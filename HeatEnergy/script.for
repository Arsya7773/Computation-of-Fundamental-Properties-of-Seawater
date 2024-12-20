	program HeatEnergy

	implicit none

C==> Inisiasi array dan variabel
	dimension tekanan(11), suhu(5), salinitas(4), heat25(11,5), 
	+heat30(11,5), heat35(11,5), heat40(11,5)
     	
	real i, j, tekanan, suhu, salinitas, heat25, heat30, heat35,
	+heat40, CPSW

C==> Pengulangan input nilai array
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

C==> Pemanggilan fungsi untuk energi panas pada salinitas = 25
	do i=1, 11
		do j=1, 5
			heat25(i,j) = CPSW(salinitas(1), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk energi panas pada salinitas = 30
	do i=1, 11
		do j=1, 5
			heat30(i,j) = CPSW(salinitas(2), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk energi panas pada salinitas = 35
	do i=1, 11
		do j=1, 5
			heat35(i,j) = CPSW(salinitas(3), suhu(j), tekanan(i))
		enddo
	enddo

C==> Pemanggilan fungsi untuk energi panas pada salinitas = 40
	do i=1, 11
		do j=1, 5
			heat40(i,j) = CPSW(salinitas(4), suhu(j), tekanan(i))
		enddo
	enddo

C==> Output
	write(*,*) "Nilai Energi panas untuk salinitas = 25"
      do i=1, 11
		write(*,*) (heat25(i,j), j=1,5)
	enddo	

	write(*,*) "Nilai Energi panas untuk salinitas = 30"
      do i=1, 11
		write(*,*) (heat30(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Energi panas untuk salinitas = 35"
      do i=1, 11
		write(*,*) (heat35(i,j), j=1,5)
	enddo

	write(*,*) "Nilai Energi panas untuk salinitas = 40"
      do i=1, 11
		write(*,*) (heat40(i,j), j=1,5)
	enddo

	stop
	end


C==> Fungsi perhitungan
      real function CPSW(S,T,P0)

C==> Inisiasi variabel lokal
	real S, T, P0, P, SR, A, B, C, CP0, CP1, CP2

C==> Ubah satuan ke bars	
	P=P0/10

C==> Suku fraksi
	SR = SQRT(ABS(S))

C==> Energi panas untuk P=0
	A = (-1.38385E-3*T+0.1072763)*T-7.643575
	B = (5.148E-5*T-4.07718E-3)*T+0.1770383
	C = (((2.093236E-5*T-2.654387E-3)*T+0.1412855)*T-3.720283)*T+
	+4217.4
	CP0 = (B*SR + A)*S + C

C==> Nilai Energi panas untuk S=0
	A = (((1.7168E-8*T+2.0357E-6)*T-3.13885E-4)*T+1.45747E-2)*T-
	+0.49592
      B = (((2.2956E-11*T-4.0027E-9)*T+2.87533E-7)*T-1.08645E-5)*T+
	+2.4931E-4
      C = ((6.136E-13*T-6.5637E-11)*T+2.6380E-9)*T-5.422E-8 
	CP1 = ((C*P+B)*P+A)*P

C==> Nilai Energi panas untuk S>0
	A = (((-2.9179E-10*T+2.5941E-8)*T+9.802E-7)*T-1.28315E-4)*T+
	+4.9247E-3
      B = (3.122E	-8*T-1.517E-6)*T-1.2331E-4 
	A = (A+B*SR)*S
	B = ((1.8448E-11*T-2.3905E-9)*T+1.17054E-7)*T-2.9558E-6
	B = (B+9.971E-8*SR)*S
	C = (3.513E-13*T-1.7682E-11)*T+5.540E-10 
	C = (C-1.4300E-12*T*SR)*S 
	CP2 = ((C*P+B)*P+A)*P

C==> Return nilai
	CPSW = CP0 + CP1 + CP2
	RETURN
	END