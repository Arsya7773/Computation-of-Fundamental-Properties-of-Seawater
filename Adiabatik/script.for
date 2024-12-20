	program Adiabatik

	implicit none

C==> Inisiasi variabel dan array
	dimension tekanan(11), suhu(5), salinitas(4), adiabatik25(11,5),
	+adiabatik30(11,5), adiabatik35(11,5), adiabatik40(11,5)
	
      real ATG, i, j, tekanan, suhu, salinitas, adiabatik25, adiabatik30
	+, adiabatik35, adiabatik40

C==> Pengulangan input array
	open(1, file="data.txt", status="old")      
     
	do i=1, 20
		if (i <= 11) then
			read(1,*) tekanan(i)
		else if (i <= 16) then
			read(1,*) suhu(i - 11)
		else 
			read(1,*) salinitas(i - 16)
		endif
	enddo

	close(1)

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 25
	do i=1, 11
		do j=1, 5
			adiabatik25(i,j) = ATG(salinitas(1), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 30
	do i=1, 11
		do j=1, 5
			write(*,*)
			adiabatik30(i,j) = ATG(salinitas(2), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 35
	do i=1, 11
		do j=1, 5
			adiabatik35(i,j) = ATG(salinitas(3), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 40
	do i=1, 11
		do j=1, 5
			adiabatik40(i,j) = ATG(salinitas(4), suhu(j), tekanan(i))
		enddo
	enddo
	
C==> Output
	write(*,*) "Nilai Adiabatik untuk salinitas = 25"
      do i=1, 11
		write(*,*) (adiabatik25(i,j), j=1,5)
	enddo	

	write(*,*) "Nilai Adiabatik untuk salinitas = 30"
      do i=1, 11
		write(*,*) (adiabatik30(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Adiabatik untuk salinitas = 35"
      do i=1, 11
		write(*,*) (adiabatik35(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Adiabatik untuk salinitas = 40"
      do i=1, 11
		write(*,*) (adiabatik40(i,j), j=1,5)
	enddo 

	stop
	end

C==> Fungsi perhitungan
      real function ATG(S,T,P)

C==> Inisiasi variabel lokal
	real S, T, P, DS

C==> Perhitungan nilai
	DS = S - 35.0
	ATG = (((-2.1687E-16*T+1.8676E-14)*T-4.6206E-13)*P 
     X+((2.7759E-12*T-1.1351E-10)*DS+((-5.4481E-14*T
     X+8.733E-12)*T-6.7795E-10)*T+1.8741E-8) )*P
     X+(-4.2393E-8*T+1.8932E-6)*DS 
     X+((6.6228E-10*T-6.836E-8)*T+8.5258E-6)*T+3.5803E-5
      return
	end