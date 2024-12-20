	program pressure2depth

	implicit none

C==> Inisiasi variabel dan array
	dimension tekanan(11), latitude(5), kedalaman(11,5)
	real i, j, tekanan, latitude, kedalaman, depth

C==> Open file data Pressure
	open(1, file="PressureData.txt", status="old")
	
C==> Pengulangan input array     
      do i=1, 11
		read(1,*) tekanan(i)
	enddo

	close(1)

C==> Open file data Latitude
	open(1, file="LatitudeData.txt", status="old")
	
C==> Pengulangan input array     
      do i=1, 5
		read(1,*) latitude(i)
	enddo

	close(1)

C==> Pemanggilan fungsi
	do i=1, 11
		do j=1, 5
			kedalaman(i,j) = DEPTH(tekanan(i), latitude(j))
		enddo
	enddo

C==> Output
	do i=1, 11
		write(*,*) (kedalaman(i,j), j=1,5)
	enddo

	stop
	end

C==> Fungsi perhitungan nilai depth
	real function DEPTH(P, lat)

C==> Inisiasi lokal
	real P, lat

C==> Perhitungan variabel X
	X = (sin(lat/57.29578)**2)

C==> Perhitungan nilai gravitasi
	GR = 9.780318*(1.0+(5.2788E-3+(2.36E-5*X))*X) + 1.092E-6*P

C==> Perhitungan variabel kedalaman	
      DEPTH = (((-1.82E-15*P+2.279E-10)*P-2.2512E-5)*P+9.72659)*P 

C==> Diperbarui nilai kedalaman
	DEPTH=DEPTH/GR

	return
	end