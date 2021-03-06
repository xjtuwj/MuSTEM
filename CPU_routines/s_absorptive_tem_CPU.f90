!--------------------------------------------------------------------------------
!
!  Copyright (C) 2017  L. J. Allen, H. G. Brown, A. J. D’Alfonso, S.D. Findlay, B. D. Forbes
!
!  This program is free software: you can redistribute it and/or modify
!  it under the terms of the GNU General Public License as published by
!  the Free Software Foundation, either version 3 of the License, or
!  (at your option) any later version.
!  
!  This program is distributed in the hope that it will be useful,
!  but WITHOUT ANY WARRANTY; without even the implied warranty of
!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!  GNU General Public License for more details.
!   
!  You should have received a copy of the GNU General Public License
!  along with this program.  If not, see <http://www.gnu.org/licenses/>.
!                       
!--------------------------------------------------------------------------------

subroutine absorptive_tem
    
    use global_variables
    use m_lens
    use m_user_input
    use m_absorption
    use m_precision
    use output
	use cufft_wrapper
    use m_slicing
    use m_probe_scan, only: place_probe, probe_initial_position
    use m_tilt, only: tilt_wave_function
    use m_multislice, only: make_absorptive_grates, setup_propagators
    use m_potential, only: precalculate_scattering_factors
    use m_string
    implicit none
    
    !dummy variables
    integer(4) :: i_cell,i_slice,z_indx(1),length,lengthdf,i
    
    !random variables
    integer(4) :: count
       
    !probe variables
    complex(fp_kind),dimension(nopiy,nopix)  :: psi,psi_initial,psi_out
    complex(fp_kind) :: lens_ctf(nopiy,nopix,imaging_ndf)
    
    !output
    real(fp_kind),dimension(nopiy,nopix) :: cbed,image,tem_image,temp_image
    
    !diagnostic variables
    real(fp_kind) :: intensity, t1, delta
    
    !output variables
    character(120) :: filename,fnam_df
    
    !device variables
	integer :: plan
        
    real(fp_kind) :: absorptive_tem_GPU_memory
    
    write(*,*) '|----------------------------------|'
	write(*,*) '|      Pre-calculation setup       |'
	write(*,*) '|----------------------------------|'
    write(*,*) 

    if (imaging) then	
		do i=1,imaging_ndf
          call make_lens_ctf(lens_ctf(:,:,i),imaging_df(i))
		enddo
    endif
	   
    call calculate_absorption_mu        

    ! Precalculate the scattering factors on a grid
    call precalculate_scattering_factors()
    !Generally not practical for CPU calculations
    on_the_fly = .false.            
    if (on_the_fly) then
    else
        call make_absorptive_grates
    endif
    
	call setup_propagators
    


    write(*,*) '|--------------------------------|'
	write(*,*) '|      Calculation running       |'
	write(*,*) '|--------------------------------|'
    write(*,*)
    
    

	t1 = secnds(0.0)
	
	if (pw_illum) then
        psi_initial = 1.0_fp_kind/sqrt(float(nopiy*nopix))
	else
	    call make_stem_wfn(psi_initial,probe_df(1),probe_initial_position)
    endif
    
    call tilt_wave_function(psi_initial)
    
   lengthdf = ceiling(log10(maxval(abs(imaging_df))))
   if(any(imaging_df<0)) lengthdf = lengthdf+1

	length = ceiling(log10(maxval(zarray)))
    psi = psi_initial
    do i_cell = 1, maxval(ncells)
        do i_slice = 1, n_slices
            
            ! Transmit through slice potential
			psi = psi*transf_absorptive(:,:,i_slice)
          
            
			! Propagate to next slice
			call fft2(nopiy,nopix,psi,nopiy,psi,nopiy)
			psi = psi*prop(:,:,i_slice)
			call ifft2(nopiy,nopix,psi,nopiy,psi,nopiy)
        enddo ! End loop over slices
        
		!If this thickness corresponds to any of the output values then output images
		if (any(i_cell==ncells)) then
			call fft2(nopiy, nopix, psi, nopiy, psi_out, nopiy)
			cbed = abs(psi_out)**2
			z_indx = minloc(abs(ncells-i_cell))
			filename = trim(adjustl(output_prefix))
			if (nz>1) filename = trim(adjustl(filename))//'_z='//zero_padded_int(int(zarray(z_indx(1))),length)//'_A'
			call binary_out_unwrap(nopiy, nopix, cbed, trim(adjustl(filename))//'_DiffractionPattern',write_to_screen=.false.)
			
			if (imaging) then
				
				do i=1,imaging_ndf
					call fft2(nopiy, nopix, psi, nopiy, psi_out, nopiy)
					psi_out = psi_out*lens_ctf(:,:,i)
					call ifft2(nopiy, nopix, psi_out, nopiy, psi_out, nopiy)
					tem_image = abs(psi_out)**2
					fnam_df = trim(adjustl(filename))// '_Image'
					if(imaging_ndf>1) fnam_df = trim(adjustl(fnam_df))//'_Defocus_'//zero_padded_int(int(imaging_df(i)),lengthdf)//'_Ang'
					call binary_out(nopiy, nopix, tem_image, fnam_df,write_to_screen=.false.)
				enddo
			endif
			
		endif
        intensity = sum(abs(psi)**2)
#ifdef GPU        
	    write(6,900,advance='no') achar(13), i_cell, intensity
900     format(a1, 1x, 'Cell: ', i5, ' Intensity: ', f12.6)	
#else
        write(6,900) i_cell, intensity
900     format(1h+, 1x, 'Cell: ', i5, ' Intensity: ', f12.6)	
#endif
        
	enddo ! End loop over cells

    
    
	delta = secnds(t1)
    
    write(*,*) 
    write(*,*) 
    write(*,*) 'Calculation is finished.'
    write(*,*) 
    write(*,*) 'Time elapsed: ', delta, ' seconds.'
    write(*,*)  
    
	if(timing) then
		open(unit=9834, file=trim(adjustl(output_prefix))//'_timing.txt', access='append')
		write(9834, '(a, g, a, /)') 'The multislice calculation took ', delta, 'seconds.'
		close(9834)
	endif


end subroutine absorptive_tem
