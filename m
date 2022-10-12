Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CBE5FC452
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 13:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJLLab (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Oct 2022 07:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLLaa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Oct 2022 07:30:30 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D85754C
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 04:30:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fy4so891778ejc.5
        for <linux-wireless@vger.kernel.org>; Wed, 12 Oct 2022 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DgdPf8v8v11GRgEJnoCw+Nwic2jm+0IIwDzSIgqxGFo=;
        b=BqibvM8iLJXUr9PIBLz7vl0Nye0Nksa8P8KeTCZEIzBDz6P+ddCvrEqzAfJpFDw3M3
         T3dAdsgXd8jKZKMP4JTxuBrchwYXyDB1Lxbvp3PfT5zIVfoKeneo2lrS5UAkdjPrb1+D
         CnY19/wgG7lS95RcwK7RtcFVt/Hzl0kHEjPZwDPEfO+khNZ9t2wMJA5jK9LjRro6nVce
         9dCZcA1KhwVH0XC78RIIdRIv6KVVin0Tj5AJTb5pUL9UBsqoUBBi1o4WjZ9JdsO4mlfp
         HCPvZ50trydF3Yl1PsCcUSERzDK0npZLfpCtWZ+0Hq7kUaMtZY1A3zjbHo23Ef65w+wC
         7a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DgdPf8v8v11GRgEJnoCw+Nwic2jm+0IIwDzSIgqxGFo=;
        b=tOyT1NuMgkrW2UTWqoSRZLqo67qA7nh+tNMLlXgsWIp91Xx1jMcJYnJXyi/GbPdqPp
         cQVwNIJRv+08T50CYX0J88XnsLAus+xw8BRpl9qg5hae6URqnMc3VSgjHI+lI1kbXpeB
         Or/cnI2JKHQzozd3+IZjPznRbxPD6Qsmr/SmhjU/9lRGPZrX2u9h81TfeA048OdDuAo/
         3KCEp3XL7QUY7I5Zhqhe2hliStRuqHwdxmGg9KhgdvsbWPAEAUNLpuspkAPvt07d12Bs
         pPdGScbH3jrPkCTH0jQKRymP1mdDnMRo38VpZHuuKHxEVmiISKYbpI3K+TLAcZ2hT27j
         46Jw==
X-Gm-Message-State: ACrzQf24GswX5F+InlcHVF/Tl7ORT/GIIfwmhO1xfEK4F9PARef8XiJP
        LAPQQ/lEqHDL4j84ya0bos8=
X-Google-Smtp-Source: AMsMyM4KAk5Zm2Ncu1ehqvYsRWrFvjVPBtAFGK+zFyG8cLaD/3akl9SRG1eSdCJNsxJf9eRTuDUrsw==
X-Received: by 2002:a17:907:7fa0:b0:782:9713:1e with SMTP id qk32-20020a1709077fa000b007829713001emr22620867ejc.394.1665574226119;
        Wed, 12 Oct 2022 04:30:26 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.23])
        by smtp.gmail.com with ESMTPSA id w5-20020a056402128500b004589da5e5cesm11048061edv.41.2022.10.12.04.30.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 04:30:25 -0700 (PDT)
Message-ID: <363eab5c-d25d-3fc1-36b6-211c913e0def@gmail.com>
Date:   Wed, 12 Oct 2022 14:30:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     linux-firmware@kernel.org
Cc:     linux-wireless@vger.kernel.org
From:   Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2] rtlwifi: Add firmware v4.0 for RTL8188FU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rtl8xxxu supports this device now.

The firmware comes from the Realtek driver v4.3.23.6_20964.20170110
found at https://github.com/kelebek333/rtl8188fu

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
  - send v4.0 instead of v15.0
---
 WHENCE                  |   6 ++++++
 rtlwifi/rtl8188fufw.bin | Bin 0 -> 21020 bytes
 2 files changed, 6 insertions(+)
 create mode 100644 rtlwifi/rtl8188fufw.bin

diff --git a/WHENCE b/WHENCE
index d67b12d..cca9ce1 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3228,6 +3228,12 @@ File: rtlwifi/rtl8192eu_nic.bin
 File: rtlwifi/rtl8192eu_wowlan.bin
 File: rtlwifi/rtl8192eu_ap_wowlan.bin
 
+Info: rtl8188fu taken from Realtek driver v4.3.23.6_20964.20170110
+      from https://github.com/kelebek333/rtl8188fu
+      Firmware was embedded in the driver as data statements. This info
+      has been extracted into a binary file.
+File: rtlwifi/rtl8188fufw.bin
+
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
 --------------------------------------------------------------------------
diff --git a/rtlwifi/rtl8188fufw.bin b/rtlwifi/rtl8188fufw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..0d7fbab5ce8aae0c562131b31065130e202d0d81
GIT binary patch
literal 21020
zcmc(Hdwf$x+JDX@Y0^@987dSNC?PDaE7FSBU6rEM^$Lwf#Z^m?qJj!3q#~A*Q%XUo
z+S4{w)?G!nt_ZGlyIZ{Msx1@+6tDqzy{wl5Bt?WaCu$IElk@vNbD9df@4oN5pWh!Z
znlm%c+@G0w=DAIyk7k)HCX>nT7;$00i<#cM7>Sequ~n69$1NuTOeVH@!l~&U>rYAl
zbAs)-Re;#mu|~M##eXjH@6+tjT(;&DCa+}jYPR8a)|}2>y_?BROkT_6-!S=ECO^;Q
z7nr=B$s3vc3X}iHp1X|6uQK@!_UAL$>$}<OH?h}Fu-3cTpO-Ru50isT{*cKZp-(1%
z&SaIz2btW><ikup%H#->zhQEW$;X-8$K(X7l3106RoPfo8mk)0s<K$sFjh63RgL_2
zqh{^3Z0AJwWG`ELkX0437w%`fqpa#$R&@ibn$D_jVpX@Wsu`^64)*KgtZEjkDrN7!
z#y<Fpb&dLWZT?@uPt){F^nIE}Uz62HS&dYdk;*bsF;T)~Buqn%0jJr`W|Jk=Mqhi1
znc-_SOD4<EG@I3APfxR1O!gsZDTohAvzqCPGWHyvZZT!$@Kk)Ajx)I_&*{ibr*BRQ
zeKRfij!naN+*p*%8#jjHjxhuuJ7zda7EH>^G36Ib%FV*}9MsJ(I6H^FXXTjib&Bt3
z`Z8v=SnR2(=^0s^r4Gp$nwiCMA}}sfmT8=6qN&(aZ|amLNCi@f=`qs|(`QnNbf5IJ
zv`hM$F^fH&=Q{JR@jQ@o)_KJbKewY>k|c)znHkM8ONz~Ax7!UEzJSvgfe{+ztP;jx
zO|b!2X4IqakN-xdSePl-z~=wKcWaBBIFGNe)N~Cg@3L=Hw>}nL<GeSvCj8j>OJa}h
zee9@n)$#5(8T09#O;v4$rouf-%n!@MyY1c~TU)yG_nV7ykL_)-f70`HZI>gQu8(t8
z9nZAe+szig>EWvG{LnY1aC+yu;yi1*Z{_&(<K6KWtL)vI(%+^gcOU=iL62(h?oj1p
z;q-m$3MYiqslS2jcy9OZ<Ke0YJt<x4v0OQZ%#}Niot7@|3#U^*ehUpjHD?`2_nY$f
z+wu=u{C4+u?xpYUZE?$2*c=b9e6h;MJSn>UA^pofzd7`<e9V5#{^bu3S3Q)kJUY}T
zHFl^W{H|Orm9O!XKelA=V|!a1EV3`a3eA4q;j5Z7>3DZu_&an|l#hvSO7F#F#%B0d
zo_oCeguOdg%p=}2*OQuhXynN6Q&Z({hYy!O?Zsp))+%ciMI2Px-hHBXb2{5lm79{%
zEh>y0c_=mY`;qduqvcN`&XvczEyp91EErbfF?(cE<1xR<F*uM2&9^&W48;8y1`<x+
zY)kX4#OPvGY{iYm=lWJ5-cDEr+D=eTUw8lE2R!zdtcQ+`8YzGGlKDmJ7^-#<4U5w8
z+?7%$m3&dMue4AW`$JU^stiqi$=dzB{2hV5SY7om10l4Bt@$e38`^sS$OiTgNSSQK
z4Ru;bPtfAX$G2|C|9+_7-t8GO@t7yS_*~hRA5G~w<{7_?+4Hq5G?8^^Tt@zZbX2#<
zT%?D&k50qfFdx6&9x18@+HVzWIbC-|ex~>SJkfJW{OHB~j?Tz$^xmfvJ-?10UEA;Y
zs!n@hSFQHKIsJ#9pzj*32j8y|-~EyX_{3cokJsXdQR<xC7ij%QkdfG+9YOkoceHbN
zUy=x2+W++n6Zc%8#SwEv?$CRGmFT%Wesl&B*XzC4C3>!nAHAmEq4qbc@n$vAtm+Q+
zc(Zz<S^c3|?Q^JoB67lUL~H(9Yd)+wx~jXD9}hKpIkuR0XmfMpaYSOvAFU28^0CJI
zJdx(+X8B9D>aT3Y=b^@C6m2dvACskT>|cH-|CAtZn=^e!=j3hf%%Z#<)rFStZk460
zk9`@Ehe)7GS$T!B@~A1aOltJJ*{r*#<cCw;V-l$7kupATcZ^p(FBQIy<PX#qemmY-
zzT>@js^8NFV_zQr;*k9I)TV6H)FzG}uDieHb=<Q<;w4#ri_$bAqWKwLIYC*mMb(j1
z6On0%YYwHcFQU1Y`M+Cc;-we0OLir2x~c@uBv|ZJ*eHS>I~6vXVBen#8$+<;r^508
z<LwU&wm%kWSB>{3qc?}<ws}O)Zq<8vh4e^Z$r=71T&uk2QGUPM=H*Jjp(d2T8LHbB
z@4XQz?I_9$ur9!2MgXJlIBNcqY9`#fl)yNx*PX5pG~eMpH$t_>0ShSLHuK<nRD=?`
zyThABS&4`{f4n+g)qAH?bK0p>aS|+gDr`K#zBv{46M}tvDr^G5`cH+Or74a5zL6M0
zn$M2!nX1y5KsXAaj&L-V!-Q}QLJ46WLWXcGLNh`KLJPui2(1W*_)f=nq>tiGz=k3m
zk1zw_PY`AzoPaP3;aLc?(SM)XCJhJP8<+HB!-xeKB6g0HTYiRAer99&sQ&WNX~>Y4
zJjdsa6~I9GsG;Sftpd1_%^NGKo$m1WiTOoJB?o`*BF>KK(M1WjIo>;LnA_IZVUEs-
ze#^V&b(#5w+Yw(>_O{aat`DPW{Lp99qBBrKY22ZqwZ<jy4h%wR?BJ`WDUIzBjjy_`
zcCxAVBB}P$l-e7!YH!M}y^Yu2nNz#rwAxw2Yv<(F&Kp^~;LO@Zd9@EaYb(dsE}u}l
zs<8I4D{43VvbO%(+9x|}r@mV|b$jj99VS!l(`6g?pD5eN)~4d~#uW6R>dk!BRqTyV
z0a&NwQ=f^?AJ4<5H65kjL*yk1pO&7ojZ+mwlqvYU@G3s7XV7OHKF?i-&$OT7^WJ_`
z+N?+&Y7tfs?JLq&I(8jw)m7!%880|5jx7(J-w><DZZ+!yN%4JIEmCJkm(p}vj}~gy
zA~_yb)uN=BRd=5TpxU=>vKyzta)s(%H!Y!s;(WJNX&N5U6iYQ$bsx8U5AH)!0v`>;
zT9^L|$ZuMf+PcyJXQ9#7-$&4Y=wXRl-g(#(Ek%CXKz_REr2I6IHB@A!qZjm>ta>`K
za$8r3Hc=<pyQwu-32YgJz9V85lY9rwsED@izYN&)uLCxnG~gc_Pya6)Pd8QOE;WU8
zzF}`yS3`@#zhap^iPJ!^S8K*L^3GBM|KOG*)cdN5+_E0YXi0~q!`hM3VKbnZLbRmI
z+{L=2E)!psrv$zfHNHd*rT!if4~iRvm*pBgnU>jG&qQs9Vx6Vxq5gQ{VLP{c{E}sZ
zbz{oQHpS{Opbn)WP0dr;{%e(nS5=F~0~r>Oqy?JNFht#Kvxba#o2q+8AR1k&cCJ(E
z7x0$)zPP`5nZ##J1z6RiFS>1sQsy!Ddb1<ZO4Zq~hm`vHm?D2SkNSxI&TZ3kJefHj
zTaG8yY4#4`yGmp;f2x-UMkoz`1|h@%z}R3Yt&d@ngD9}x-TM27voQFRFp$h_Mpo{r
zSxUf52(iv-{XO3#E7nqkC%1Obf7qH&pcgYoJ1s9#>#Hu|D>o>CheZaG6Di)Zt~fh-
z1ApV9&}DStD*>tpK+9{<>v&5CeRf8#Q>>5Tbf7qvx@GT=(SQ6H4Gl(vV;mIsu~ieD
zI1-Z+N@FKZEBa@vhGEj!7R++w<vTXsx#2Fw1bHA+2`p2^VZLPGFgv1k&;LPbNLBOI
zA-rWxNNGsd_&ZTYCupE3`19nccMyeC8s5~}rBuI^JsCyc)EvBJlhSah7G0z?To(OC
zX}C?}^{Gn342?f^NNHHepNc6Bi!{e{O))`w$y8XX8oL86jlV-#@vg?}7Exq7ult6=
z9a=#ug*&zAAqwA%#wd7S%f5udT_8uM6tprxuHAm6<{d4<o26!IDel(5x9Cbur|Q<G
zqp5zkgu79x*`m7R({T-B-!|+7X_~I}xHGr8HJ!iq8Lx{fHQUfZzFJIk);j|hrRL*e
zOGJ|=_{?Z`#$jg)U*D_y%+7csf*#@#^wM*#J2QbcrgQV9D3g5&buH@dF1GqCn#^!?
z>t;j`#lg<pwj5Dj_CDYGp@t#z;C%ktKNRV0nh#{NOdye}w`ZP4E8$LPSP8!NBY<4n
z*_)Gi-Ge+BjrPZ?BR~|0pX)VuKL+kTQ}4wnT(7$iQVMJUqGP55c{(tRfrk2Ao1(`C
z5*3nbQ$gzF$&=m3(OSG*%Xq;#d|+`Sz}7aJeUAW-7zFpyxN;u!j>Tz@080km=(xHw
zr)%ygs6Z<23mzQjs4IDV<|eamOlMO`VVdj3P~7#b^Fz77H)Q}&ndkbg^HDj^H!}$+
z1fWaK^!W*p=X$Zy1Hg)S=zL3mcqR`Hi&d9v=3Z_+>!{Y;qk;W?Cg$l3*o)5$#b%YQ
z>!|Knt~72}yOwuRITQ<fH2Lx{iewe1md}#H9_Mj+1f_E+&5+h)Tlp+AB46qMRRa;N
zWtO9*#B~AAQH1Wk?Y-K|GaUsV8b`=sU?*enMAVf8yTc{XIPS#$aEa@6-u0^%3%CUl
zuYEgQ!Z#j_w>Gpcf2G7P$)-Wdej-8>!iA{>`c&*1b0M4cv=aD1O(bU>;lT>9JpCwf
zLhWy3py>T-ytnK*F>BPKS@S<t$gFen$Ne|Tc}Lr%JRW@J-xT<6Cbflp(f-M85axmv
zL`C{Q+-KRv<#0sog6x5LI(XOm%{EIfRvVN-P>5hJ?|Pdyr22#FwSMqSM+MIW=-d_t
z1k`5$8MSZMXXv7(+$6?ueQZ1cjD-5)^=WaxH1(KYZ(T*(iO!w_cZnZ6DoxdK;XGf(
z>u@C~fu)+qrsC#c&yNRnQoZN$;2$fdRW7Jci+-Z&%S;uPN~yJ>T^btwm0(>O(tQ#Z
zFHot*E2dY)sZObc+QTs%UiTtSZ6<`s=W`;_yH!131v~FY1$jiIb6B35ZKSA+;>rbL
zbOFEWDODQ&N*B;y)CHa^fhcufKq^E{nT|T$fwESgVGIXxwa*w)1`pn*VXpoe%Opnk
zAPvbC(w|=iEdC|hBc>WHA#O=#(Oxl9t9N$rqKLOdz6~>1^-{CP3J%pfZ6Nb%f+Bqm
zuUmpajG-n9)1rS@^-9yyr84hCw2$&CO(Yrgx0w0b-ueupLK|<QhOPb-zVUkpjY?On
zjvnA!I-)rS_vSa?I(VyDv5ZnZ6HoxV@VHiy6a0!sVdY(AGIT8RX@Fubr-iV5xTCwu
z_`2hMNo*eDGPzkS)%c3xl?#Gj*Jt1$5K0hvN1{anV#Kv?ER|Rx?`X<3;UYQ>n}kXy
zvF8@pE8FA<_C~x+chqMn4UcL+?#lX%*kZ9Q!;8h0^^4?o%U35vr>V}`WLoDN_eP>O
zsuujPm}?+FZBDU7r-iUB_p1G9RplE$R3GqUh8Od$8;rBOnAiRh$vW^ay2sqkGQx|K
z`!0m7{K{g#1k@@Gt7#9L^>$_jKezFFzvQSGQK{1o3Moxi4TqhO*<{lyf9cox+JlPq
zxavKvS@mY)Hx$2A9y|;<D(+L7Qq;g#sHTE8WC@-;4>%LqCWrq#2rf(4A)CLY%dcs^
zP2(3Q&ua242}E3;gbpxiX+ZAn;+DhKPvomN;t2HOx<SCVy^)X2kKL4rmPCks4=li`
zP%NsNzkgJ;m(CW`Xxn0=8@q|vI!{{F2xPhATI+I0l4U4NcB_~yxZSYB(jnwIzyes2
zG;W@uqKu>Vjx~3#zDsF%OZ7rgdJI%#O1_$+G;~tm4ehEoGy5ZPHCh4O1|aT2JvI|X
z6P?5IRU5DSHs+C8ou_7INw{QRlc)Hs?2p`1yrqQCpNY@nOCl{LUQ6~moG%qEs2)p8
zN%lHxi5v{i^bXglfH#x3*YYK^_`AP%w`*>{=BSjC$ARtvkm|}J{{mN)(zp$xZfBd6
zs=D4Jfk3uV1jx!(#nv~j3C50v;&iq^RU0H+T*<})RcK7yW#V+5X`HT=TIGc<f4jsA
zK2!oLagHy_J}6TH+r_;=ue><>VDz|Xez2WHkJfwyD-@4Fr0VAtXD>Cq0zw&A70Y;l
z6ROAR`a_YdwOD<5lL*m7sofo#>ks%SO(s>}WcB5qJCFml$`i=X+dslBfwR{^HpZ)c
zks@}zP8qlqt-kDJGd^AO{WO_S-QR1QEG<^!+y|;~sG3Z^bdbDCso+8-utG>MN?^HA
zVX?&@56+-LpjBDX30f+Uae;x1C$-9-xco$FM!23rEBxnMc~^g)3YIdJq!8EhO5jQ0
zXhQZu*GhS`Yb8oipJ^KP_)kTn$CVZB&8pK+6I~vw#`e+0Q2l!LK^Rh$K!d8YJDYvn
zK!pPwD5el-RB?L*gt)|tKk|(ooUTKShaUpd=d@CbRk3Qv;}1phyH78>#`QW>G)nyt
zOugkHKH;*mUj*;+N%FP9Qi~QWEoI)(z769aicVGI-+7p9DZ56EyZ*w1zbLx~<(ND+
zSh^1<eJJWa7!Y;M@=$7Zu!#2ZL)cX8rcU3R;~%2ll~{F1Ge%=djz+Q6sImK%z)Qet
zC^lQE!JQSJ-3gItOHp`s*>!3RjN~eH&V!!e%9^t9gT#WoJUg!Qn>qnUTCqGwm&*;!
z>YUl$tDDtWX*1~mRhp<gr_{@~6jC%?3JC4|eqie=%zQe!alMKCj#f*xW^9s|XJfc%
zcS~W*Y;nj?wOr%j+5GuBFzmR1si|Q&@ME0i{Lk4-P00F_B3nBr@0q;k;}d%Cor%a@
z(>y2^{TnUCG_NiCo@$H$4ZYwjI^kP=f%Zd%qy!2{=VD^qlB;ub&m^4(_v815VuD1Q
zJ1O=6T8Q0;*~~=?81a=M608k`l)7a-T<Z46<`|>fJR%XEv+vnL+Y@ubbEd~ieM`sB
z9zeI+8L$GAmxbpj%l9|N=0!Xf>pbhc@SM&-df`~#TBBe9M@e`46OsHwDdBnN>X=b@
z-m`k$yzsnzfzw;&6*B+nNR%qow>Rqhlt7WX4kJ<nrb707yfZvEkQTmABwi0*g&w6s
zE5aO{YE1GfV@8-lkvfScqF$hZWqhMo1pDI%`@{Ej4oigR4%7GbtULN_;n48xfVCKH
zK$dwvZnOd%&3VAf!kYJN><(n7p^JUgscZ{B0Cu$4UYXJ|JGx*?VJO}*J6IOIf6HY&
zxOdBC!K*?T$#p)ay*%%g*)4N7-N)Zw@WefJ_wwMiAlZ#g_l6pq?kP?Wx<WXRR8@BI
z;3u8od)I~U37Cq9CNp^34Edty{XrLYD)3qTV55#WcB+F)pb8p9dz17~<M}2`C^8H?
zEIQNBhy?dqXV1FF;d^5c;||{+jCdW+q>5drH9Jl^D5|4w{^JWGH~?|1w717C$I7tW
z5x#juY>|jOU$@O|j`^aOVe3Y(72Sl(Zq)f^NIl{CwAIbAg}xic&*z)RgcoXI@0>;6
z3AAJ8^WXK7<OK0KT;{cfy+v|dE*@y2($+G6|AMf$vuRQB1uxHkWl@WlFZ}uyl%g$j
zcCvoLXyEkl0?%+X!bKy|%OHW;Fo5tPEe^_pUSD3&GM`Pj43uO(ZAt7jN7y@Fb;c+K
z`W9+T0B3r5K429DBWz#{vwQMY2TfC1T@-y=S$#EquA$F$^tl0|6HbKIlfOTWN<}|4
zQU~lJ^#QGiM|HOs$=GY2Uda4LdCH|`!?TsuS1{{Y1JOc6LviW($}#>0+2C>}pem%^
zc5uoL#WKd1r#Z4OQY=pB0l+9hbOs(EijJfKL%Z0kWuMKT`lMIOjI^1taLdc9P28M0
z{*FWh0vXgB)3PrjX&M5qKMtus;U1$jZg<6@n}u);)ntFKJ0C2A(zsKk3%7yBn4ze3
zfgaU;+vm0mqN6mvul;buZ6S^Wic7b&jU;2aV2#^99oo+ws(`pV0BE1CeeGdmSEC!%
zJ;rs|t&%dqjGTTEq3aTfZ>iq9qMlntsV^xFb%Plf2C_ex9(96Mh&oC70u^f9r9!1o
zVjQ@HPSsO@NgZ~YqrL7iP$?*l?-2*o2zmvjLU9fR|C{QTKT#dxW@wk+!>N%EC=F0-
z*z|U58iYTvNAIFW2$`Z9^aG*-P^b4qW3lS+@^hjWf<lYRYMbTL7Aqg|gaZN^?@?Ay
z!J4W`MkSb&*UhH>Q87IRe$}q|ALkV=r70DaO-}%l1{NX}`a4gi)9hhWH=vBF2hT7f
z&d<cga~;!N2hemu9bvz3XegO1lTJ$D%nhb+7W+c+Oi@c&eHq5%`VtMe=yaiuUlKVk
zpvR>~W3FSOr2Pe_BsRb6^KuOdc5=dea>8OH2CIo1eEC4Nl#@%^L;_U2Z>Vc?Fb6kP
z)KJbwycVA(50A7-7T<SrMx>2de8=S!Y}0gK|3s?AV$~3(2C5QTlIXo$pqDa2aR<yi
zGBzcq1xC|vN%BNZXFwK%t_suuC_}eZ_w<(0MOk%^QnN!%Ebt-*`Da$pnLsqdneg1`
z>_-e=sNHAwwq=;PuaU|^$dmXInWAkeX1?eN5wm0}O=mz&Yvm8#0GVycEP|HWsV;xy
zjjEadzGjBK{{D6;*?MU@RjI!pT$-rseb%Vkc51PcdQKmx?|oKuY4Miu-BDulZsm&;
zvP+Eae_8qDsaZzwCEv<iR8JqmJExKGVCIjk0R%cW?PR8zKk`!=ueCf=lAVNRK?U+v
z0GK>Xso9PT&{Bw$UAFS}MRJBBy@6{^kzNmHYJStnO%2E_AZ)Rc+B4Rixq4LjXbD!J
znk8?-;sm{&PKpHf{QXMJn-I7j2+l1p85>-JzIgCw^3ae{^A@OWWueZOP7Qk9V=(3`
zOE_s3MJ$J^88-spa`ZqR<rfBrf`%F^yR#&?JYTiIfITGmIJgk#mKfywoh9<JU>cPw
zwSaH3>VRyq8iRN+IQPnug26%9Dhok-PwJixc5ev|rPkA;4|wuJ5cK5H{JpJ8O^4dX
za`_{_3qB6@FQH4Xlw>n_ys~uJPAh;SkZ=oq4o&_Eje;tq(EgT(h=iRI>1FBBPf$C$
zi|?)%I4v)ca7BbmG>5+qWG0fNK}yrGh=$YGeX$@vv{}won!pD&<*0FFs{A+Cg_lo^
zUWg;5yEYRTS{bPR3O_&j%vPHHj8()52|8BXK@l9UDI%halLiCGl`4D*4lzjHp;$Q-
zw5n$T-*&He9^c+kUM?9J%r>TEMhPI@%VOo>a?dq1^SlGB3@F&C7Qr@Hvj-w3i7&#q
zLCGj5a|mo4h|Adm937biidfATngeR;-RdL^YY+7E<`<j^hvwTQhzeceARpo7KLv@o
zpc<)7Hd=)Y+8L=WKx<h#Mh<t0<hl{288H2Thea2m$qs1G5WGW5v@GbnJwxa;c&%|-
z4<keJj--rqtT<qNt;+6SOLOyLYNCYKW}qR<2*e01^2X?64%!K`sN&<S;&Rb21C)vx
z=pFmiiO|n~fKV(bw2)PnJEEI(cV?`Fc3o+v_ZOsha3^#vT;jHkC$n~R8W|Ai6hQHo
zr&@g}nrz1X7G2X)QebYEtk`+3oBV97DO@5{9T%POH3(^-gLO#ZyPVRA&;@ta+;K)s
z98U}EVho298d>OZzSnR_(R0q667OQdOLB4+zf~?Z@}Te5xN=FqP<SWA_%f&A+V`Ly
zR7a~-_X*tZG;HX=tuu&JG_*p)uo;XXY4F`!pe})a0J<*s7UXRfToB3w;5WOzcht=k
z5^rOt#-Hq_?R`Obrt3rKk!K3cQ^D<sK=Cy5N5#_+B%b=jrNwzu!z(j!A>M>#2TKG!
z+_gB(O{=g41}_sSqV>?3InpNCRNRXhIHgUJ>P*Bkk~U70-jY$!>AKD^ts)^q%WRlG
zO%UWI{`l_;whv}gZM~q=FBKTKAz2KS0Bod3$b>oAaiHB$a0K3lgb%+JPHOC(!VtEF
zY+7W#1Y>rR{gS}cP~E8p%-y06#P@iIRSE2-LXSTqU~j8>mz6*Kxu72*y<jg!{bT>j
zaf_0o1v0nO&?!`F71vcR;7@+tF4+{zhdy1tMhR2{YgZSz<SS5^MBW14R85Ks@Ix?l
zUrM(*nYzD21uY_Amz@Or8<rM1#3v7EJqJ{e7Y!70pw3B5EvczPeaS&WS7V(Gv$*wc
z^%0ZPq<?+65>QAaB~vWG9#sGnJ#F?h>@Br_5{dxXRlX6JTOG~<#!rgdG&N4zJZu~2
zTBw0uGASq|E-QgmloGBERs7Lm0$EgpRO?%Aqz#!stm?01S%r=qmeps9DT)4+z+JGa
z)ir~;B!g|lI}S`3c#=HzbgEZW7_CPU@URVkQYSefoDg~AkN=ZR7Tf3F8f7W(U#zk&
zT3zcL<ORtpi||yl?0?u`@DUncU+9Mu$1z%JZRLhg-y;^ja$E3TVV}J{SfT`OkFG1W
z1dD?Y28*Mw1*b(j@Y@-j20Lu<*63dR{()a8cq<Q%f%fxNam)u%h?^er2b2;wM%-KU
z-W)hXjfZqVn&2_Gf^Vb^SX3CVnBgzP`BbdMq%l*ha|h;l-#^cB-hVhpCEyZs5SV*#
zpw$Qdxz+jqVXMJMg7<cqIwX)%Gf_3n#xFbsqAw0w*vY<43l^Laytk8E+LAb=Wqn7n
z-W!}oi;vhnh(Qg5*c`%YDQ@*y1BGUbxKZqG5jP6XqBxEL9f)GJ2);(73T=;9+%C}Q
zx4XU<1a(W%SsKVG=~)A}zy?m??Fa>xa3O*rvQ?KvoRS{8JdrfJ-vX2PDXtFUuF6-l
znn~g!Mu9ZTEVzlk`0J1!+&OFU08!;H;@16<**cjeB)f8g_=<dWj1oBL8;y}fskuNn
zVw}N)!a<0?dbg;?-&qrV#4iPRDh(E}h&j<JrNIWRZH~qsS;Jdrg!Jh6B(<Qs;q>T2
zPipjjUJ;L0$##mg^VcSU)0Iac$0l-QtAIxziLM1ZFS-HyIt30(alaW}94T<<nc}Df
zr^uFW5J@Wx^OboaomI3$aD*=g$s?2t2ZDXf(uTuw;y7Em&0u(OgAc4*tz%$q*Ej~2
zcC}+5YgIC9WiqQq-1QQ!&{p1Bj7z@PElnqLJx(VCbdVom2qpiHwo)r_CZ|Q(o`g92
zXK1X5I9ce_4LBc|;e24rz6uA?tT}|^Ri{5P;H8#ASD~PIjY~THy@S4MfGUme7;ajf
z{+?6e?<V0#Plaz!!jGH^-vI%78$7SbArtPGkm3OV^V_%^;T|8y_cL;6YwRk3&S4ia
z_93ww;fF?xd&EA#`vai>Z-%%?nhfaO8=!JXOczOIWtlNyH=)f^Q0!*F8eA9z)~o_+
zDO$k{+B~SrTE?R)+^e7<X|Sp}*h<i}NV{O7R~p|!_iw3jFPjSaZj`EfQ<~M%R8LwY
z2OQ^UIPe%7+7$8F6=@4`Ck~}4TXi-3sELi-h1yp@v+y?BdRsj~3W*C{vtG~-$CsKW
z=|`b_^mV!BDl2yL_4yH(=Y@#|Oe0v3V4@yW79BJeuol^_D#LIMyEKgu9qK;mC7a!V
zV(bD2hTe@mP&3-Kx-AXdIk@hz4?uhxt&M#^*u=nep=yz=nAW&Fiqu6?wjy<ssR{6M
z&EkOS-X~p-i(JeW94Hi4<SL*-Q}$Ad-9bVF*e2X`K53Z=BQPWY(wmpV<$6v_IVrC_
zw};Dxya*_~n0)1v%CcKhT#YB=$a6usoJ<2k9|6;Vns*3-r2!La34-Z)hf)Qa^I$c8
zrJO&#(^@Vo4tWi+4Pf-uIEc~ae_Ewi|8<p^=IDT2@+#(-`GRxI317_x+DlS@rPPI4
z_%k`{s@&yI@QTY(CW$-`%+xhFNl6wFs}H1%I;nB^q9UCDmS`=3q<F93+4r3Atq{C5
zR7PtczKuGi$x&M6eWEX3_y&3Hg6|c?Clp&0$%!rO(ZdU4%O^LfvFgt7@^wD>_?+ss
zg*S&6K5YKop<y5Q>BveP;p>Hp3d<F)rsax}+AqA&b+SR=mg+?0mgUnt!)g}#tc#Su
z_3E5Op0u!U-!p}l(-z84w)h+yZ5ym#Lo!rj^GVSQ{n6KkE(tu%FEvWGj?lm6PYZo6
z6thb8sK)r$eBDfNay=p+<_S0mn3cfQkiX7u%?x`r-wkKCjtMV-(ihHWmO5|U{MBV4
zJ<{1!Ry;X8KmSl_jd%XY!(OL69-Y8K<i&t8UuGEKVXehm7OI;M5g0kK`La1v-rmAU
zo4Wv(qF01AcbB2fg+0fitiF`c?x5X3=?=9+BXwa%S9zByc_Sx1+Z1V=Z-VCA4Bw|R
zC458ve%AUWf)ESdg&=I^yLKY%HuD`Hho_NVWYZG}_p@Lbf&*s0{aJ(uS@bdlAv53d
zIKnWCQf@bky28`*_nZ0pO$b9QdJsXFm1X)SSkSNNwaeC((q-+kBw2#4E>dQ8X<h1h
zA=oBdIQ5ogL@JfQEDh=_&pk@uCZg#958Q`)Es&!^39!jf+X<miCLQIueEo%L+~*bs
zIViY$w2a<1`zL~py$PffZK+gKYtLk4ikJnHCtOAXF4b@GGC7q$n(M$m^s~C5gKp$k
z4FyfZy-tSZnzzLz50Q`UKV7N$4Cnv<n{ln_H_V*mTb3Z+FJB$Xw^wpkrEoWkgMw{M
zs+(~7f1wgWCn-(2hQ>lJ9HK~TMOBgwrQqELQ}AO^acM(aW8BVDNi~rnv=nx}O^zM`
z^X-8AxA>BFDN}$`qjTLhFP5|d^A>|j=0jHo<wkn+Gve#n;#qvjR6+1kHmI?3c$M2x
zGp?~M72)#y?p!Ji=7UH7hT>MfcoystOQyn-J~s?4$<F*k_UKpWoW1)DIRJ>hFazO#
zmx&(P#J3Ee0dN+|%K0kf1V^a9=NzXg`?`>pezYz3Tc2rS_H__j+*3e*g|?%Q49-55
zjH_-<^O*-zuxa~-{FusuvK2=Kbsz_SiyM{ffK6OYz^H7JdZ8=#nI@e;0ayt;%%mAm
z8oz@XEvdC5cUjhDhGGEKAtj$ul)S4C6YS@;LW_W^+1p~HjVkaW7v{JOI5Z>)YUB6l
z-v8t>#_y3Mo@t7N#|w%yTwO{s-qFhw1s5reKVY)D5+_&oA0T$IfDro{zt7(0WaPlf
zfAxFHapuB6fab2^w|=LvC$VP*Ngd#1iDe+&>)0-(@c>#nKt_VB;t7$0AY9S+i{}ws
zY1~hT&v}qA)JRyRg1Ce~NIJ?NEFWzbJk&b^0i8Z4iUe^slLd~%MvMFpMgCqNd<z;?
z<Qt3^PNRtIg>>m~enF$JNP5!K=%&t(I4|+=9M4E6^FnrN+zG=l)HpeaA#4VtN3nE3
zEt;!Jb1f)5lT0jP67Pyh*vO#rop*|Bu_miVk;zm9d<Qx_Iyuqfl;TGx_oE%Pue0Yj
z@uL9~3?DNdU;bD%3?Fe<J=NTa&9Q^*n+Uf91I=m<VmrZ;ZO4S(L%757#2s~aK7JPl
z`95~eMPMo7{)=#ZR?hW*fFOKl++RT99dPhbOy|MyJw5I}50F>x^5-K^Op`^O$pdj*
z3T5_UE1?@68lnwq78WbfY?<9}DkgO!`h(806pn8zwg4mapVB}qm`N7x$!L#n|BCM_
z=M}%Lzp^X~di@$WiQ1uW(v2AUsK2j%6nG|ICdQ6>g>gUCE6;<5cef%vr?$n(CF#-0
z^}7{Q75rA>{wiv><7Z`0;FQ)p3zlI>r3s7Ku;eYC@<sjdDBizdE&AZ;FTpnl=Mzjg
zjCg>!?MlPjTK#aorp9}|0NA`aVjuMTe@KW`1J~IvgZo8cXz#Wd)r3Y{Y3M*ze|&(a
z&JbnNNp4aawhl1#eU8=>yduIcHS_llLrdH`y8dzu@XrGSOl2uwv>wGrF_~aai$hYX
zpczSod1<Xr#&&vCYsP(!sDm%X<DqvVTK#Vosgx+cWgPGdG>yO#Qne9O&2+Iq+Qo>o
z`wsB(S9$r2Xqb1Thhl}Xsj(}{uasXY^cN%hm8pIg1y}fQqTovZ&Cq#b*YsiG_^#(5
zs(F6ViRr6>M`><>VTGB3-GgFS+U|>M@+g2?_26y$M4|IUAyeTtMS54wKlm0EN@xyD
z_YY#aHA}W&Jz9_A11Dvyxl;3f4($^7yC^k5nj~xejPF@Zz81GFuS^%d#t0;&FmZ@f
zcqdiU<@;QdGb4z!nXSGLNt0Tr`OhJBJFe1pD~j}?aq?rVf#cW82a#yTZfb^f0TH{|
zXKVcoSs$Tiv^;n6fW9*Y(g*I|6zD*YlZcM{m;@J$tWR}Xl$y`QIB7PPfyJ{pFi<vs
zW~f|~m@Q3df^{7(DA@FHsTxqh0|+0>^E;KMp@hYzbiyKJ6Ff@+xkuVSALX7Wa!rL>
z1p3s!IQ%)wOl;{ozI&nHE@l^rQ{-}p@hO!T_$MGrcd<J%$OQ)*f+d2q5?tu-yVSV9
zQ51Yv^>9U+q~;&8LWq`A5cesX(Q;9i(K4><l*;o(%YG$V?N?B9U=*Z2hr?i-eQ0zP
zo|6TaD^eJT71!hzup%RcrXgR=BzD2hcmKIvN|Bjt3WgxWS-?c(sTU}0mFi(o+)5_3
zbP8-&cT2JZ*8vm-<#%VvBNVn0UR!Y5ph*5f04-=@I9aZsGlAvmZdk4y{u4k-=|xC~
zuzU`hnk1<RU6CRwo)icC45Mc_OW0(R30@FN%4@z<eA|30jmsxm%intmXUGw48!+l)
zPqZW1B}Zugtvx6VMeS6CzxO-&)ADP0D0Xf6b++>B&x;i+QhxXvtvP%xe%Il5J^IND
z7i*64n^MYemdf4c@>}j!q>IBhA@gSZ-1yxBbV(uH4>-`^f{5k4K=XAFm4wZ?2NGIt
z51bw7k!lEB)a#fx_Nd7*RQ>`}h1cUx>9l}9{3#e2RC-tS=90DD%bQj3Pyjpc5&SHg
z<V)`%8|NM41&;&<i+sUg=vv@m1r=LcvM-?AxBK_DWN+u|kMb2a$}c5vezM<>_q&&+
z;;~M_f=CgR97X0t4+zZBf(6F=8<AUv&fiv{m$vP~78pegY(5NTO5k#$O@Z^k9fOnx
zmgM6~rNQdnG%;FBv+6lbF^wT^NRi(0;kBm^+ztpz#Di_Q&1b{hFa{B)dBV?8#0Nw%
zC2)?=iJe0_F>u0|7Oau*eOrGyTfeLRUhipQ&YATfjo6*_o4`I|(%7ot7PFL;2Kazl
z`Tc8UOYrvv73A6523!P2&|c;*)?hbB-0iOS!C;dDK~5!R*7YHlO|-E^)rH5`=!n~o
zLi<q&#KulMqw7O(YSamOGh9ur^`G#ky#KT0Ggk9$#hR6$6~2`$^tA}~GuIag4zPmt
z2p|B})rN0FCWN>dBpqFW0AkRNFhWR4zYX7xS@|u{$sq;_sKtaZ%nEiO=w<~+d}9q+
z2mSmvvJUPP6$ssmjrs<yqV&3fHs(6Yn?7TK5oOb$42D%GlC<mBF9F)>;clB65tzP6
zo?PEiI0?%z5jHsZSbP5=JMmF!J^;M{<H8D4%dW;@`v8<13^-zYG>1SfXjvaol&xgl
zbkyGqd;Il;Pk04fPc{anVGk(t-3UKG2w|zA3!w*LP!o#{>ENhV?{&tD8BE?nNV334
zZRW2%R__JxpRc66jM+gS0}%nQubWjkwBZ(_qwzkrAhsxOkN4GtE}KvcZ(jC1FUA*q
zWnkWS8S~Clo%J&pc&A4^HwaQ&sI?yEE%!pB$zQvWFtQ6yZgM^e53sPI=kfJ3Av2Cq
ztc&oj1&&c=!n&V{jV7w$yOy^+Qhyr_TG-p`Zxe_p5+oJ_Y*r1a2bVH3I#nI*4yZq;
zD$;E@eA1;p*hQt=RL`09)wJ_zQOprJ6U&h{AW^Zhs~zMGO>z`u9Ky4(9`C`@2q5_C
zl@Ag+_TX(AXg9s28q-WVb6cy4oUD1IRf3Z>f2s#h=g4!q;TXAvz&dmqvF5NcIrwg<
zsux5w9Lh>5Bs1eWC;#gF?rh@<vV;b1AX$r6GKiL#ww|v}A?xlkQyXK;pbu(?*MFOZ
zRZ2b6yyNkl0kdJ7Hr3Y(({*|ZI8i&8Zq#VAAc0evPBd}>CW0e)GdAG#*27w~10d{V
zEF+d(Y>DBb4jkL5Fx24igb~%q0sKtE1a9Wd12%BH{3Ba7q`hDs5dXf4B?MlKCmzPc
zlkbaQ=@p1bK0~5P8WhpJ;?acR_D>rR^1TMvy$+m>*XGK<>dEh(N<)T;?<}HM!ruZ;
z39!I}`kaYFg#ClAk+u-Wa`zK*4u5S>h_#atiyc0f)CMS(f5^sP`zn|xr-&s+MJTZb
zE^3%-kPbqLVV$8l{s4Y<r+NZ3Wj~xd=o$xR3})w3pb9awQuB!>!&T!`!L5CgqYZ)k
z!zbzwcvGhCd%75BY&Sf&Yd%#wpE*a)?(BK`XMg~Jmn_&c>xgTjT-})#4?(c0`8>L4
zZJ{ONB!=&EfX5l&-2>op26!0`pYdFj>~{;iQpm%CuN-#AW%J=8hCyTJ?tA8FseIfA
z4x;8G>I_a1U*N9@(8_>1DGhC4EBrQk8#1uBtbF|g9(bdGoLD082%&|BB7l|M3YQ6@
zEqe!O3sl^Kw%~D_pe=vH4J6hA4%N>KUh-*NRzJ~{73&3m4&8mI?+4=9S58v`QzDuN
zSy)Cd-E-lsE$A$h0JueP3ManBe{);*^|&{10J-NbL=U9kNb-3P?ro9rhZ?rFh}w?x
z{zrA$t(tEKE{zA?^xbNZcBK9r(oPKyYTv9Kw#xOmYkSa!4rfWx08Fl^5C8WrQhllC
z8OOycc-kZy|2IdJufJ6sF*}{nbQycOL-nS_aXI0LCe2Sz_JVj2&z>MELTsGLH-(sV
zXqc=wt3`PRpEfmVuOfP&G@Y)&act`Sc$$56j%Q&G;=}1P)oFo<en0X-4B+v!Yaq@L
ze`_FaMqD-GLZH8&x3`~ErR$_BZOJMY*YAudweG4*7Pq)$xm<K6SzKOuo`{+)1$W9b
zDeAo)-u$;1gR!{&Bwv>-x>lYdqRis@NIqW_J=gW5e6|3ZEw1<EF-B1<Ul)QO7flCc
zKLFEA%`(>-!QEHpi6=J&;C|Y%Asw!*mE+{2t~$BfRmawW(h08BRaZIIue)9b8|H8c
zR@dNbk?p8-h!$L1sVwq|1uiNCQ#zil>&E+$N~aMHWJ5!v1fGIOYkI`A#H6e~1FE44
z{gLGqAB{L-Q<T-vAyI6<vU-9Miz%zmrdaioQOfFxMyx<tJ=uueuB^V$h*c@8FF_3S
z_$Ba-Pmzc%#BAt+ti@TrHzx6Cuf+ui5fmDTZoFo=TBs<Y<Hpmzloxc-^;L%_o%kAh
zeI+mrZ7G3kR4BrUGC*_v0qLc%jYZy7N&xSrgi4;YDoagN7Rq$E6GL5HuCa))sDK%O
zZ#Z6#ykv$G-JZ^2dxm{{qW;$2I*mitLla<T+N`e_P4cIXiH5GDN>`J|0-1k)tfkT)
zJ=sSd?Dn2@`q5_-vIT-9dcNLJwnF<)e-LG0)B@&!^S>7b9Q>(Y;jM_B?!PpK=i^8U
zdM*X%f`E_>VM39f#*3JuA(}r8+6X+RA{A_h-_!>GeDDj>S_s!5TG=Fd_|p=i#IIF%
zzFwN;u|(SP%qRsxLy<l(ZYSKuHcEhIMe@VrMD$Dabw2!^L$Q})UqP*a$G)Vp@SAaX
z<wWvahZ1qPlny=8#>_+I6!`0~O4gDB&nWFi<FyJ_8UE~=zZ!=hugmcVQYf|w4}QF=
zzBxs5bSi;`YM>Ow=o!IKAuAVR>5z@3FQZ3dTS-b-sQGrI9muGzNS^w=Z=pd10V5$@
z8c;dBDYOl+ki-qyoY0U?w;=oqfg2B_X*XqH%kVNc-3~hUbO{b(qyS$9D<#wl@U@Qf
zd9NFa@Z?+vy)d&Rxr{Do-HrE+<ylOgO`=vJ)cI^Nk`~z=$v=RIUA~@5<%bZ@0x1xR
zboUfEgq3II$&;XOAXzv|hD&G4-6W)xXJyN|BCe*>^OSZOAbyfdC%85U##u?1PNmTd
zF-7Q9NSjiMA3fD0w#Y>r05{oQay@F;1DiPcITT(?7eAnI7~owyjO!n7F&fQs3Z)w@
zYN9jpEKD6(fSX7$JF$4U@9&d%R}uEVQu7Zw1@Qsf+&@&j0BKCY3y?;<^fTcv8yw=n
zMjl*WJeqffvAJ&sPg#hw13o3-hRj4UoaoO7N}Wrkpl?D87y&f_FCnTEdNx_>mLF^F
zMjPOFR1EAEg!_4LYap#KE#f=|=0pq0X`q821L#Ww8}bpxswR1oFOVQ^$4b+LX3v6y
z2j*cCP3Q|KFw=_7LL>DBbm*F~;<&iyPImBZy9*~NHDA)y8zHe%bl<vS@Qfb;#Mh7H
z>tT}kLhDQNBruvdLJ8mB&&@6hk?CjRcNo-Xgg5-Y)NoL2&Ay4WF@@%zm}lXfb@JaP
z8TbP(#MsbVU!{q7xxhC>E$~tdA~yUZ`LFRj?O3nY4>E^WF)`SmvxHrN9@zsy-$6K@
zGfVhO(d!d;RENO|u8Gr0<Pj|sgYUqm5L;s+U-|08Y2@VsCN0tFOM7+_{*2e(Va_z%
z$iz}k0uF2{h7uU;7w^xw(G8{ni6B!{z~!<cq8XkUaUvmw_!Ci3=5DyM1Qu%;C-Kg#
zLTY&kZ$ZLyPI~`=T}yvZ!)JC7^>CW0F?ys1oA_UVzU>JAO0J|tTVqg>(-WE5RES(m
zvEy&X#9f4|e#{ZC(Ghcr9gG2?kw7K#OeyrFN+&HJwnwLf9zWnuG{JMEWj33$mEQ7<
cY6RIaS*RQcg$@3p*MKzR#U|u0)7-QFANUTBa{vGU

literal 0
HcmV?d00001

-- 
2.37.2
