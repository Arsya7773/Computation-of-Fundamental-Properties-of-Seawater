	program konversisalinitas

	implicit none

C==> Inisiasi variabel dan array
	dimension tekanan(11), suhu(5), konduktivitas(4), salinitas1(11,5)
	+, salinitas2(11,5), salinitas3(11,5), salinitas4(11,5), 
     +salinitas(4), konduktivitas1(11,5), konduktivitas2(11,5),
	+konduktivitas3(11,5), konduktivitas4(11,5)
	
      real SAL78, i, j, tekanan, suhu, salinitas, salinitas1, salinitas2
	+, salinitas3, salinitas4, konduktivitas1, konduktivitas2,
	+konduktivitas3, konduktivitas4, konduktivitas

C==> Pengulangan input array untuk soal 1
	open(1, file="data1.txt", status="old")      
     
	do i=1, 20
		if (i <= 11) then
			read(1,*) tekanan(i)
		else if (i <= 16) then
			read(1,*) suhu(i - 11)
		else 
			read(1,*) konduktivitas(i - 16)
		endif
	enddo

	close(1)

C==> Pengulangan input array untuk soal 2
	open(1, file="data2.txt", status="old")      
     
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

C==> Pemanggilan fungsi untuk salinitas pada konduktivitas = 0.6990
	do i=1, 11
		do j=1, 5
			salinitas1(i,j) = SAL78(konduktivitas(1), suhu(j), 
	+tekanan(i), 0)
		enddo
	enddo

C==> Pemanggilan fungsi untuk salinitas pada konduktivitas = 0.9320
	do i=1, 11
		do j=1, 5
			salinitas2(i,j) = SAL78(konduktivitas(2), suhu(j), 
	+tekanan(i), 0)
		enddo
	enddo

C==> Pemanggilan fungsi untuk salinitas pada konduktivitas = 1.1651
	do i=1, 11
		do j=1, 5
			salinitas3(i,j) = SAL78(konduktivitas(3), suhu(j), 
	+tekanan(i), 0)
		enddo
	enddo

C==> Pemanggilan fungsi untuk salinitas pada konduktivitas = 1.3981
	do i=1, 11
		do j=1, 5
			salinitas4(i,j) = SAL78(konduktivitas(4), suhu(j), 
	+tekanan(i), 0)
		enddo
	enddo

C==> Pemanggilan fungsi untuk konduktivitas pada salintas = 25
	do i=1, 11
		do j=1, 5
			konduktivitas1(i,j) = SAL78(konduktivitas(1), suhu(j), 
	+tekanan(i), 1)
		enddo
	enddo

C==> Pemanggilan fungsi untuk konduktivitas pada salintas = 30
	do i=1, 11
		do j=1, 5
			konduktivitas2(i,j) = SAL78(konduktivitas(2), suhu(j), 
	+tekanan(i), 1)
		enddo
	enddo

C==> Pemanggilan fungsi untuk konduktivitas pada salintas = 35
	do i=1, 11
		do j=1, 5
			konduktivitas3(i,j) = SAL78(konduktivitas(3), suhu(j), 
	+tekanan(i), 1)
		enddo
	enddo

C==> Pemanggilan fungsi untuk konduktivitas pada salintas = 40
	do i=1, 11
		do j=1, 5
			konduktivitas4(i,j) = SAL78(konduktivitas(4), suhu(j), 
	+tekanan(i), 1)
		enddo
	enddo
	
C==> Output
	write(*,*) "Nilai Salinitas untuk konduktivitas = 0.6990"
      do i=1, 11
		write(*,*) (salinitas1(i,j), j=1,5)
	enddo	

	write(*,*) "Nilai Salinitas untuk konduktivitas = 0.9320"
      do i=1, 11
		write(*,*) (salinitas2(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Salinitas untuk konduktivitas = 1.1651"
      do i=1, 11
		write(*,*) (salinitas3(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Salinitas untuk konduktivitas = 1.3981"
      do i=1, 11
		write(*,*) (salinitas4(i,j), j=1,5)
	enddo
	
	write(*,*) "Nilai konduktivitas pada salintas = 25"
      do i=1, 11
		write(*,*) (konduktivitas1(i,j), j=1,5)
	enddo	

	write(*,*) "Nilai konduktivitas pada salintas = 30"
      do i=1, 11
		write(*,*) (konduktivitas2(i,j), j=1,5)
	enddo

	write(*,*) "Nilai konduktivitas pada salintas = 35"
      do i=1, 11
		write(*,*) (konduktivitas3(i,j), j=1,5)
	enddo

	write(*,*) "Nilai konduktivitas pada salintas = 40"
      do i=1, 11
		write(*,*) (konduktivitas4(i,j), j=1,5)
	enddo 

	stop
	end


C==> Fungsi Konversi konduktivitas ke salinitas
	REAL FUNCTION SAL78(CND,T,P,M)

C==> Inisiasi variabel lokal
	real SAL, CND, T, P, DSAL, XR, XT, RT35, C, B, A,
	+DT, R, RT, SI, N, DELS, AT, BT, RTT, CP
      integer M  

C==>  XT=T-15.0: XR=SQRT(RT)
	 SAL(XR ,XT) =(( (2.7081*XR-7.0261)*XR+14.094*XR+25.3851)*XR
     X-0.1692)*XR+0.0080
     X +(XT/(1.0+0.0162*XT))*(((((-0.0144*XR+
     X 0.0636)*XR-0.0375)*XR-0.0066)*XR-0.006)*XR+0.0005)

C==> Fungsi turunan untuk salinitas
	DSAL(XR ,XT) =((((13.5405*XR-28.1044)*XR+42.2823) *XR+50.7702)*XR
     X-0.1692)+(XT/(1.0+0.0162*XT))*((((-0.072*XR+0.2544)*XR
     X-0.1125)*XR-0.0132)*XR-0.0056)

C==> Fungsi RT35	
	RT35(XT) = (((1.0031E-9*XT-6.9698E-7)*XT+1104259E-4)*XT
     X+2.00564E-2)*XT+0.6766097


C==> Fungsi C(XP) polinomial korespodensi	A1-A3 konstan
	C(XP) = ((3.989E-15*XP-6.370E-10 )*XP+2.070E-5)*XP
	B(XT) = (4.464E-4*XT+3.426E-2)*XT+1.0

C==> Fungsi A(XT) polinomial korespodensi	B3-B4 konstan
	A(XT) =-3.107E-3*XT+0.4215

C==> Nol salinitas
	SAL78=0.0
	IF ( (M.EQ.0) .AND. (CND .LE. 5E-4)) RETURN
	IF ((M.EQ.1) .AND.(CND.LE.0.02)) RETURN

	DT = T -15.0

C==> Salinitas (M=0), Konduktivitas (M=1)
	IF(M.EQ.1) GO TO 10

C==> Konversi konduktivitas ke salinitas
		R = CND
		RT = R/(RT35(T)*(1.0 + C(P)/(B(T) + A(T)*R)))
		RT =SQRT(ABS(RT)) 
		SAL78 = SAL(RT,DT) 
		RETURN

C==> NEWTON-RAPHSON ITERATIVE METHOD

C==> Aproksimasi awal
10    RT = SQRT(CND/35.0) 
	SI = SAL(RT,DT)
      N = 0	

C==> Iterasi loop dengan maksimum 10 putaran
15    RT = RT + (CND - SI) / DSAL(RT,DT) 
	SI = SAL (RT,DT)
      N= N+ 1
	DELS = ABS( SI - CND) 
	IF( (DELS.GT.1.0E-4) .AND. (N.LT.10) ) GO TO 15

C==> Perhitungan konduktivitas
	RTT = RT35(T)*RT*RT 
	AT = A(T) 
	BT = B(T)
	CP = C(P) 
	CP = RTT*(CP + BT)
	BT = BT - RTT*AT		

C==> Persamaa kuadratik
	R= SQRT(ABS(BT*BT + 4.0*AT*CP))-BT

C==> Return value
	SAL78 = 0.5*R/AT
	RETURN
	END
