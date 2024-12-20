	program FreezingPoint

	implicit none

C==> Inisiasi variabel dan array
	dimension tekanan(6), salinitas(8), titikBeku(6, 8)
	real i, j, TF, tekanan, salinitas, titikBeku
 
C==> Pengulangan input nilai array     
	open(1, file="data.txt", status="old")

	do i=1, 14
		if (i <= 6)	then
			read(1,*) tekanan(i)
		else
			read(1,*) salinitas(i-6)
		endif
	enddo
			 
	close(1)

C==> Pemanggilan fungsi
	do i=1, 6
		do j=1, 8
			titikBeku(i,j) = TF(tekanan(i), salinitas(j))
		enddo
	enddo

C==> Output
	do i=1, 6
		write(*,*) (titikBeku(i,j), j=1,8)
	enddo	

	stop
	end

      real function TF(P,S)

C==> Inisiasi variabel lokal
	real P, S

C==> Perhitungan titik beku air laut
	TF = (-0.0575+1.710523E-3*sqrt(abs(S))-2.154996E-4*S)*S-7.53E-4*P

	return
	end