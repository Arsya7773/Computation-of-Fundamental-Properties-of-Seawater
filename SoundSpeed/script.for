	program SoundSpeed

	implicit none

C==> Inisiasi variabel dan array
	dimension tekanan(11), suhu(5), salinitas(4), speed25(11,5),
	+speed30(11,5), speed35(11,5), speed40(11,5)
	
      real svel, i, j, tekanan, suhu, salinitas, speed25, speed30
	+, speed35, speed40

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
			speed25(i,j) = svel(salinitas(1), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 30
	do i=1, 11
		do j=1, 5
			speed30(i,j) = svel(salinitas(2), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 35
	do i=1, 11
		do j=1, 5
			speed35(i,j) = svel(salinitas(3), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk adiabatik pada salinitas = 40
	do i=1, 11
		do j=1, 5
			speed40(i,j) = svel(salinitas(4), suhu(j), tekanan(i))
		enddo
	enddo
	
C==> Output
	write(*,*) "Nilai Kecepatan Suara untuk salinitas = 25"
      do i=1, 11
		write(*,*) (speed25(i,j), j=1,5)
	enddo	

	write(*,*) "Nilai Kecepatan Suara untuk salinitas = 30"
      do i=1, 11
		write(*,*) (speed30(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Kecepatan Suara untuk salinitas = 35"
      do i=1, 11
		write(*,*) (speed35(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Kecepatan Suara untuk salinitas = 40"
      do i=1, 11
		write(*,*) (speed40(i,j), j=1,5)
	enddo 

	stop
	end

C==> Fungsi perhitungan     
      real function svel(S, T, P0)

C==> Inisiasi variabel lokal
	real S, T, P0, P, SR, D, B1, B0, B, A3, A2, A1, A0, A,
	+C3, C2, C1, C0, C

C==> Konversi nilai tekanan ke bars
      P=P0/10
	SR = sqrt(abs(S))

C==> Suku S^2 
	D = (1.727E-3) - (7.9836E-6*P)

C==> Suku S^3
	B1 = (7.3637E-5) + (1.7945E-7*T)
	B0 = (-1.922E-2) - (4.42E-5*T)
	B = B0 + B1*P

C==> Suku S
	A3 = (-3.389E-13*T+6.649E-12)*T+1.100E-10
      A2= ((7.988E-12*T-1.6002E-10) *T+9.1041E-9)*T-3.9064E-7
	A1 = (((-2.0122E-10*T+1.0507E-8)*T-6.4885E-8)*T-1.2580E-5)*T
     X +9.4742E-5
      A0 = (((-3.21E-8*T+2.006E-6)*T+7.164E-5)*T-1.262E-2)*T
     X +1.389
	A = ((A3*P+A2)*P+A1)*P+A0

C==> Suku S^0
	C3 = (-2.3643E-12*T+3.8504E-10)*T-9.7729E-9
	C2 = (((1.0405E-12*T-2.5335E-10)*T+2.5974E-8)*T-1.7107E-6)*T
     X +3.1260E-5
      C1 = (((-6.1185E-10*T+1.3621E-7)*T-8.1788E-6)*T+6.8982E-4)*T 
     X +0.153563
      C0 = ((((3.1464E-9*T-1.47800E-6)*T+3.3420E-4)*T-5.80852E-2)*T
     X +5.03711)*T+1402.388 
      C = ((C3*P+C2)*P+C1)*P+C0

C==> Return value of sound speed
	SVEL = C + (A+B*SR+D*S)*S 
	RETURN
	END
