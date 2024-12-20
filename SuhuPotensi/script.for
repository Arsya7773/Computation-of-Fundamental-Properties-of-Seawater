	program SuhuPotensi

	implicit none

C==> Inisiasi array dan variabel
	dimension salinitas(4), suhu(5), tekanan(11), potensi25(11,5),
	+potensi30(11,5), potensi35(11,5), potensi40(11,5)
	
      real theta, i, j, tekanan, suhu, salinitas, potensi25, potensi30
	+, potensi35, potensi40, PR

	PR = 0

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

C==> Pemanggilan fungsi untuk Suhu Potensi pada salinitas = 25
	do i=1, 11
		do j=1, 5
			potensi25(i,j) = theta(salinitas(1), suhu(j), tekanan(i),
	+		PR)
		enddo
	enddo

C==> Pemanggilan fungsi untuk Suhu Potensi pada salinitas = 30
	do i=1, 11
		do j=1, 5
			potensi30(i,j) = theta(salinitas(2), suhu(j), tekanan(i),
	+		PR)
		enddo
	enddo

C==> Pemanggilan fungsi untuk Suhu Potensi pada salinitas = 35
	do i=1, 11
		do j=1, 5
			potensi35(i,j) = theta(salinitas(3), suhu(j), tekanan(i),
	+		PR)
		enddo
	enddo

C==> Pemanggilan fungsi untuk Suhu Potensi pada salinitas = 40
	do i=1, 11
		do j=1, 5
			potensi40(i,j) = theta(salinitas(4), suhu(j), tekanan(i),
	+		PR)
		enddo
	enddo
	
C==> Output
	write(*,*) "Nilai Suhu Potensi untuk salinitas = 25"
      do i=1, 11
		write(*,*) (potensi25(i,j), j=1,5)
	enddo	

	write(*,*) "Nilai Suhu Potensi untuk salinitas = 30"
      do i=1, 11
		write(*,*) (potensi30(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Suhu Potensi untuk salinitas = 35"
      do i=1, 11
		write(*,*) (potensi35(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Suhu Potensi untuk salinitas = 40"
      do i=1, 11
		write(*,*) (potensi40(i,j), j=1,5)
	enddo 

	stop
	end

C==> Fungsi perhitungan Suhu Potensial
	real function theta(S, T0, P0, PR)

C==> Inisiasi variabel lokal
	real S, T0, P0, P, T, XK, Q, H, ATG, PR
	
C==> Perhitungan nilai
	P=P0
	T=T0
	H= PR - P
	XK = H*ATG(S,T,P) 
	T = T + 0.5*XK
	Q = XK
	P = P + 0.5*H
	XK = H*ATG(S,T,P)
	T = T + 0.29289322*(XK-Q) 
	Q = 0.58578644*XK + 0.121320344*Q
	XK = H*ATG(S,T,P)
	T = T + 1.707106781*(XK-Q) 
	Q = 3.414213562*XK - 4.121320344*Q 
	P = P + 0.5*H
	XK = H*ATG(S,T,P) 
	THETA = T + (XK-2.0*Q)/6.0 
	return
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
