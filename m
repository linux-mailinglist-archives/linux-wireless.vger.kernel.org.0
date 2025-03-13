Return-Path: <linux-wireless+bounces-20294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52877A5EAF9
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 06:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC7D189B042
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 05:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854111DE2BD;
	Thu, 13 Mar 2025 05:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHtL4SDo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF71F91C5
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741842914; cv=none; b=emahUCgt7WuvGLHYtyclkJGxwASFuqtjkc9hirpdgioiXuc2xHzIE6fPRqcNWuoG38U3dpJEZM9Ac1A5HTnXnNk6xoJCJoTOY47PG9KbNq94NKEt8iFJHPGlvSUYOmRryTl4QCaWz5fDROOz2CfArBCn/rDrPFKDsUq/CXCcb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741842914; c=relaxed/simple;
	bh=nq5ttNCAjR1aDWUffhdw2Yu37Nbwr46tG5uhe0f2Lys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B1Cg/lRl95Mp55IAv3/n7cXNLqZEGfmi3tcuDctz0nHugmCmd06/DLlF+7RUSd5L3EcTZdZ5Jqrskc+/0DwccNJ4CDzeDHCg5kdJatJAB3rqyn8bSmp1vq11H2i0OSIhGJ1kGmfPbx5tFT/XMhfG6oDWDD1ei/OAf91YrUCt3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHtL4SDo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22548a28d0cso15413545ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741842910; x=1742447710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s5jHbP+PF4UGPijiKwjCFTAaVdv5lgxyxF2+CDyhLAU=;
        b=YHtL4SDoGgqTwj6lZ/01cDoCTYNMPWveFht3uhjQVNGDIULd+lH42V/m4n4158PVbT
         ILxJGQ7v6Wd6B7sqAGm7+mv0qyptmNOxs/kcdHzh9z2K6sYezhgL6Mepdvtl8e0BghXw
         jDeuSRxYrfKaHvxmUwzqXZ9a/ZwkSCTj/J7ozG5nY+74UUZ1VMWkFETJEx87It5JELfR
         cqfuFuUIZkmEAT270eREAISAm7z/4KtrMZrlWnrc6ELqrQLU7Y1/WCEmq8QgESILIn2T
         nqH6advYwbRlIsml9WToFthN5foeUFaohf3buvzLeAnhchTssCSMAwuNpYWdp4cbtd6n
         6XjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741842910; x=1742447710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s5jHbP+PF4UGPijiKwjCFTAaVdv5lgxyxF2+CDyhLAU=;
        b=nk4NtrYhAZeq3wBLC8Y92ctbXh/ze1jaXZKUK42alfRYrLu1QN7jJ9PL9xLdN355uZ
         0vFzqRRFRGMH8kFRi1LQRoPmd2qaMh31WAG3Vvg6CTXJ4+ZEmazsuGExj7me25cXDPON
         s0I3bMJulkd5pVzZEackZWL7Ip2duRkcqlbehDB8G7U5ZE8kMhB1oPh7IItzHzOoUbNE
         rS7w+MWVwpgcan+4Y56T0tFwt9rVCrGwqaJyPhkiCS/CQ9rE123S3d8xH3Oa7SAxnPBr
         NoezXWF0Fs5ktl4rSochivH2GFI6K10d1xEYj4vo1f89OGekOIDYMtT03MJmJLsrize6
         KVqg==
X-Gm-Message-State: AOJu0YzzQ6N0H9BY9xGlvRPgsOXJcu1sV7TWSuec9s3AAX79RLAbtGjt
	TB2LmW8EKvFkNaBEXWaPRxawh/a6D/NYrmpCwFp8LRoXyVi5zxb7
X-Gm-Gg: ASbGncuBZzW2RXtLENtDzeaNxDuK2GOLmpZb5/n1PgnSIybZ7lm+NACkWJV02ynZ7TU
	uRrjdP+MgGXt+ZrUOlNSYvXjEJoqkC7hPUpTRJ2L1vBVDoPRMmcrJ9D0pnv0RHk+Zo/OEsyldLa
	1Rivca1XMMMYOhcKSgQkyjxyn6RorlpMZQpqCzT2Bjc6NUpHdvnh2Quyxi9gXFgwvjaY32z4/ck
	/eJVAG3xWLXxfv3hoL1tD22jlJx9hcmaRrEMzwxzdqOc9pzEK9tD5V5IbJSNGktiuj4S2yB8/OX
	o0wWe5l/GVHUXO67tRH2b8qvIsCMxL0HRGvvKl9qZgj/jX2nk5jYmN4GVWw9GCwBkSw5DvffE2+
	mmb3OaFwNacR/+dMXSewPTNZBJOznHg==
X-Google-Smtp-Source: AGHT+IHMt0dPWgZYAdBiTks050FkVvcFsCmXOCAhkdgU7KRF86aVutNFKJYxdab4MSlRMVXqg9lVew==
X-Received: by 2002:a05:6a21:515:b0:1f5:86f2:ba57 with SMTP id adf61e73a8af0-1f586f2bc04mr19959605637.30.1741842909303;
        Wed, 12 Mar 2025 22:15:09 -0700 (PDT)
Received: from localhost.localdomain (118-232-8-190.dynamic.kbronet.com.tw. [118.232.8.190])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7371167def8sm453215b3a.90.2025.03.12.22.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 22:15:08 -0700 (PDT)
From: Zenm Chen <zenmchen@gmail.com>
To: linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	usbwifi2024@gmail.com,
	zenmchen@gmail.com
Subject: [PATCH] rtw88: Add firmware v33.6.0 for RTL8814AE/RTL8814AU
Date: Thu, 13 Mar 2025 13:15:01 +0800
Message-ID: <20250313051501.2519-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file contains the firmware v33.6.0 for RTL8814AE/RTL8814AU and
was extracted from the vendor driver v5.8.5.1_35583.20191029 from
https://github.com/morrownr/8814au

Signed-off-by: Zenm Chen <zenmchen@gmail.com>
---
 WHENCE                |   1 +
 rtw88/README          |   3 +++
 rtw88/rtw8814a_fw.bin | Bin 0 -> 68320 bytes
 3 files changed, 4 insertions(+)
 create mode 100644 rtw88/rtw8814a_fw.bin

diff --git a/WHENCE b/WHENCE
index 177e6d8f..0af94f18 100644
--- a/WHENCE
+++ b/WHENCE
@@ -3403,6 +3403,7 @@ File: rtw88/rtw8821c_fw.bin
 File: rtw88/rtw8703b_fw.bin
 File: rtw88/rtw8703b_wow_fw.bin
 File: rtw88/rtw8812a_fw.bin
+File: rtw88/rtw8814a_fw.bin
 
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
diff --git a/rtw88/README b/rtw88/README
index ef3a7505..a0a270de 100644
--- a/rtw88/README
+++ b/rtw88/README
@@ -22,6 +22,9 @@ Currently supported devices with corresponding firmwares:
 RTL8812AU
     rtw8812a_fw.bin
 
+RTL8814AE/RTL8814AU
+    rtw8814a_fw.bin
+
 RTL8821AU
     rtw8821a_fw.bin
 
diff --git a/rtw88/rtw8814a_fw.bin b/rtw88/rtw8814a_fw.bin
new file mode 100644
index 0000000000000000000000000000000000000000..e14924e12f88824a2ad06e4210a47e6614004392
GIT binary patch
literal 68320
zcmdqK4R}=5wKu-cd?b@(NKQh40f7ujKt6&(`0%4zhY%2w0TF^CVmToRlgyk6A%tu6
zY8}B^?F|+X1SVj|nV?oeYwvA)X>0#Z6KuIk??tq&qJ10r&@eNBArq3ew$A%o`<yc~
zLE3xY=YQYl{+~ZQYtH`OYwx}G+H0@9_D=pYj7?%`O#7FXH7e&^I%6gTD4|x*{?S@2
zV}FdPZZXdT7XklwQO`Ud0{#u~6To)?2LPYwm}f7(e-BESfz4zk!c3t=casojGj(yM
z*D-ci0rRW|xByQA+5s^@hLw441UvxP4mdg!<=@0SIRN^uR{i8Acv$^v{>vrIlQo}t
zMga-{(*Sb-|9A`P0Q?N_5#V#czhp7b&jG&zybJgU@c06h3D^#J7VvGrUclJWS|<Dp
z^V|i<0Nestq(UyfV*!%@)6}rp_!>;~FEcZfdeLCcA75ND-v;L|!p!qKz_ni?!aN$h
zh4_mqkb4y3W&qOCO&OV4<`LOBVs75Zd{$gMwKzX7Cr8ZAFj*|QIimSL|7NCZDN|j*
zQ~ft<)*Z8E7LA>V|2eZ}6^*x!%gMgxJ3{sIZ_y1oIr%)L>Y83OUU6w9W@b7nn5PEd
z25bgw1^gpmJK!iFCkNvO(7rdTe(igY>es%TR6l*67nx@tpdIiXKmhQAG0gKG;3{B@
zg?YXL*a|oR_&MMcK>Aqbak!GO74GeTp8#@X=9vIk5BRS772M48r~KhCb`-`w1#W{o
z6&`>;6}GgZ4!{n;KEQVY)1GFYdjOxPuo>TdfL8$T0(3gPj{ao<vOzzUFEP&+zyZLU
zfD3>sW9_jOfO`S0fJXq20^;%bw<V)=OoAI(MSvAB3t)Rws6F;9la750FwRhW>;}L$
zb+yM{06Yy?gFJ;i-$a&~R(tGzq`w33AmEGK+GDRGOiV|)qic^D04Bf@guMnBiSRst
z9$`8_Iv@>@1;_;a1^Ep~2mHPOF2V@bdMpo+3rGXJ0$g4O90qg%@)4E+m<E^*m;so8
z@J9i~01<fR0-ixz{t3W1@HXpFepwIvsOzui@co3xF{wAN_Shdq3a2ET-x-kRbHE<}
z1qP%uFtiI_6TTjN|AO>?#y>miTmfhU>;&uq><1hK_yDg0g6OB?fMWn=7MQ>`0xv*3
z&e-^k#|(g9x3}KMqB)F3?*a<s2qKb2*<V1|Ptrdjjb-zHxAu4l&sjmHH?s<qzZ4(<
zCjq$W@YUg~$5)SU5#nY6=299E5EBGp72Goc{{e`i9aIhenE^q@P&FruAl8PB$L>X%
zl>jS10G>L49$*Bd0n!OXv;|-Q7y&wf07wG_fQJuI2O6;9TMuZ2`y|G^7T+R_RV~8e
zaT~fi-ZK^MV(yPW$yn1d3m^+XtCbGl@#w=npvirJ@xbXM{O=niK<%-o@O=v36ZoFM
zw-w)3d}kreji~2GfPV$t0h+Vni~7)3W~@d0D)=7;)C2awKNnC8u+kUlt$-51RKQ%o
zEWoXZyA|IRz_$v(Y(07}!VUm_1^6YP2ecJMTn6xEpw(#pGk2#U+<|&F0_p&@fEvIC
zKsBHTINyvkY$~7xa4X=B+GAA+uSdT%03OCaB9^9y=Ty;j9`o=Vgv@yuU-+qAb6B??
z(_2SVd^{8QHweP<fDHJw7vk|8kYGG#JIZD3ivp%kXK}!G;JXvB8}*og$8Na)2)zCT
z_%q;hz^!OY0mg4Upal7+k{{poNPi6RZvfV#Z|scy2-6xkV6o>v0z5i+3<iuTL=aH~
zE3$$O*?^lzVM}l-(~x}~WljP-4tNYO09+XAXb0>E1Oqxx@D-g0l<V1oIt7INEAajy
zKnL26VotXL$2Z1N8#nv|W6kKd%@3RAvSSP&0CWHgKm_dgEPi(r(zgJt@Ry)n$59sg
z>2f^&AMth6cKBxlk5a%Kz%0N&Bm7?g3jvP<o&Z>pR|Eh9<QL*beDe@KYj)|Jx%1}V
za_emi$`+O{T8zfBRdp@v7gjgcHmsj>yY<1@58XMdb@GNaC06T$r77+?syj7(>EB3i
zWy@}#yrH#ZL;1>T)v=<AJ62XNt>uoTjSXcFb645JK!B%SbvF;VZ_#r4vSrm<T(hi`
zTQwY4G`2jVxmPY&zq)CCb9GC@ru7>)HLr)iwr;~#hZbMH>ET8tnz4VVmbcd3s<n#y
zX3r<@!>uJ&?wwOgUaDwG>B6$biyB*~oJEa<hIM%j|L_*E@`f#64n*38n;IMIYFezT
zTB@5{HaxO&)vBdPx5i2ZP+KTq;j;47u+(sCdGkLkZfH%7X1ovAl&qw{5|ohu>XKzG
zWe;0dH<dq36_njizbmN|3GXEh<br?JooFJyv+2v&$_2OIv$%X2isSBu3oE&k!ta|s
zGZB7YX^MMJ(!E4=QhK;&1D`djyOg_EwQOou`>bqnO-r*3%n70Un;Tl{t`o7cuI4(S
zps&W-ax3p{D>WW1pr3^;YH@5qQ<Hq3>RDc$^en8eYAsv5rDcnn8N;Y#=QOB}Bk)<&
z+^mc#+zU4)Jyh?e##LJp%yHP%xVW0T>#Cb;>ZvGg2(XynZRKT`SR1#xTbduaosTB+
zRh2EYZfazpgO)mkt+8U(!%6YzcD9t00Q&#IS+~!9h$kqa-)nx5i?P)_la*E7tvV1^
zb$3&BOMTLhsk0(ApuB3u`ntwin$s)SFQ++|q`|7@VNFodXi1XE*vjhFO;rEv=4xcX
zioCk1wq<?U{daO7W2I{N9Q8X_{mxUrE33;JDgVmaRl_=M@%<oigs)i0hm~!pTKNDa
zptM!Z==z0?+=ubm)I1yMTr_?}`yANf^4qN|%NhTcH*exN^03vIE6AzP$*L8c==pDz
z;^y?Tihh|&P;<3<shrzU=$&6(1s<Y=Hn%+DR@jymPK+J}mso2XHf~g0TbpV*YXIIn
zEisxp9tH3Ef2eL&%Gsd0h{>oyti0}?#fz0v)KSM=-c(z)<aW&FswKRl@<#4p;0gC^
z+_<H#<#y|;dLHwoBy8DAqO&_eLai*74XiAm%~m&|qBSMu8m=qLOWDfRlvD$Z(dzZ9
zsQ*{ucjc<8s@9b&u!b`R9GV|li4mu+#|Xi<YAY3oIA8&vT8x%9#n0mxUlX6=NAATd
zlF@7h2=?~L57ShkdZ>H2TV<lHB{aAteE8Ucm5Wzi!$;YQO|rbTrLGp)8Ayr}1IPy*
zLxwreQao$EpfhHXKhvbwGebr?{hHFC1u&S5dVv{6WTqRL$()&PV5Y3hG`O=eje7b;
z8dH9r*}%m7ybSyn7mm+k*5X2onSS%r=r_lJ-$|MHEt-Us)}jJ(7Zy<Xq=L~%Is0a7
zKAScBW{Zg566BpVdwM?oPR+*zn_bL*C-Pql_Uf}nMIj*J-zXBt@z1FGjjCT%{i5o>
zswCsmJEb2%KlCrE2%3s)Pvwz}PhTw@(gh?l@>3ClPM>B}HuxoR_;d!vhi#uhXGlvk
znKCl;_|41~Ek@ETDBlb*f4tR@X37*T7AxY(Up)7AV|qp=TvO-XfhY{b#GB^ZGR@|^
z(c`Vf#j~&-5KtelLHnYPbQ6>dda4#*6&EuP&&V>Hl^E{Q;>?LuW~4KTV!mbkc&pX=
zU;P$O)ly#HH8UQ+X@30XTjICQT5#L!va;Jt7v4T+;q7y8FP~TbmH17!*eJYg_U&b*
zUs*Wsj`H}Oi{f8h6kl{#d~rN}%YvH`h4kfLnYZZ9_~N_2dUrg&BpzRiZl@6#5szo*
z$4BMFM~m?>xf3T^@(L^?Ed}vW+40d6#4!^^%f#HV1@Up#_@o=+lj8AFBXh<~%(WDZ
zw2q~a!g#!hmt-&)O5*XE^MOwM=35ucx~*&>P`ypXbY@9>{!Q^)ZYE62=G?Y$-tAvm
zIJf+cuPnOrjzwR+^Ol?9x87{KZT5oO%i;^a5--0aj_}2IExLR0q9u3V4QV+ZH^<{6
z^5fZ~;yI(^;uv5WACng!VUFi#bKD8jJRmjJI@UUFECr5_kC~8bnK*K6!9?r0f=M@6
z3n$&c36Fk?r%cCh!KBGIP9<;Al&Q2Spf80dzQt3gm)yi-rc9eL^Jc6FjPamSI0`8B
z^yvnM35z|5g%xAxxP(b;C&cj&*a}w5TA2^KOPjD$=n+n+t~ENV{&j;b?F6$RbU=7Y
zpXxt_*j^rg$2IvWUn|O}7dnt{ypH^o@`unX4i9NHDrKM2DJ7jsr~f+aK?qYb%S*vk
zW>Z-yy93w~u7sn4^$C=^Q=mF(SsOzC%({m8>w!7d-)fwAO@7LE2TJ=PJB@tV0{I6}
z(pvVyH6d^4l(MNTr8T`MQ2?GsmWBOyMhdR;SvI?YO=I)fy-a40vTwqtxc%ts80wjZ
zm`9l(?sCB`>=ouC9mSOkuM3}|zpl;i2ZqDTh_fQ0d{{Zy8w)=|?rY0>Mt4e=pFe8U
z=rLn3(Z`RUFk#|E{7x*uoS#4c7VK?qyZ!dtX;){nEm%-iws0Z27hu0ruIzZCv?s*B
z#1{%_?pMFyhhV|M9{QNGZ?({OyO73JAFQc|ye%i_7ym3C{`sH!S@RQCNB<vDzhcx{
z-xC|V1Yy0bZrm|e_Z0y9DgM{}PvQ7~wch{PR@KdlTICT@X4eDWsAJJda=`$zx2dDC
z=NNN;F;uXuGqOhs8DQ?C+)eo~LG7#&u1#>=6a3g<KNmUX_<SbCZ5y<xadK2li4zeg
z^-r*~2&?;Rjd26gy4cm0c7!_-USa!)S-xjvmTv&8>CEyoeBVi9mhyC@bh4{W-uO^~
zEJm5zcH~H3Tj*%0Eo6I#S)M`K{iB6uT{W|mjKSo!d<P2>qxK<Jt5^9}d8IQajvYO=
z{Fr=<LOju)gY4=$Z_gR>S+Cl>LDg06^{K8U$V0LJc+h&)uDTzGdxh$*g`3KyG<9&V
zQQaF4dIq$-4ur2$!#5nXp&liD4cz6by9sVeA0J}{<x}4<OPOHYr>|j`HUFw>{9n7q
zKXi@Xs2iUDjzm1LZ5R<XEiL=7=EJ8xJpAD=Km6>&HI6kOKIC}t!}X4bKFo`VegA&!
z#Sh>7&=U=QIO5n74d#n8C$YLa9V}Kjo5ifN|Eqaf)av$K8NZB=MLmm}mROcp_p>_d
z?^)dhhk##pk;gS4ZYiiwZtL~*>t<zH1*bV=D6}15b+!<zOPf`^04EVNq8#%z2gcPs
zc;KgX4;}b(-HQj_JWv{$)mL_)=D<@24j=gCfzJ+jqSgcdrqXeek05t~-g*XdL2m-U
z+M62Au4W(%A<jwBbzYm-R7mcgfm(0e=?Q?|x`(IE<R!4Wztp5}NPE|Kic+(ybG;&X
zneFO`CG10C2^P&l_F?+Iv|YxX28`&JX#eV1lmfaRL%Gimws_?t!6}Dyh0JnP4Xg6%
zTuR8lj8#%qc@1iaHxXh|LtaRPh-%3966ILckll$iHZ^2hBE+MHe4lc;fKhwgDO4!+
zKT4^1m?6qkEMHHgGbO@)kO;$!Rnz^mibbo}7tKnvQBvz&lWe1!x3yiVLtjX<`iB;!
z=GJzl7A5qniO^&{|HkW~)C;0E@7clDb_MtMQo_qq!hf&gwZ^OU#i9gGT3`G*QBSfj
zrmKC?+Rpm5HeN`iV*^@PP9mL<=!;W{bh<>?4-@!F;2%l6dlTUcqN(8*DLg^b($#UG
zBW2cKj~;_V6F`s5vRZ9zxmQ;R>P(@`FY{#~I*QZgI-aL%uofeiR%F6>D!m_7!^^!I
zrDcx;PR_2ua<5gRv_u-Mcb`v$XuUhtN-aV8DU_B;CGoIi@22t6DSScH?xpk^CVP09
zO3aExi~zbxjj2k+=&p%blZeq@6SFQ6V;B}w4cgK$FkTZ=o`^}iCT2+@COr|;HCXTc
z$0FeFtVXM}7I}$6oYbP~D7C1bx0PCy8bd8oVyH#Q7@{C8hFX-2AsW(Rs70wUgtt-}
z&A9C;7*PKtV<skIJQ(TJn1)1*Z;1LQna4yi7|(ij{t|!FsnjBSOF2JKsOlu2FI|JO
zN)7r#YIQPHp$B~-wKye|&o_M`wKf^5%s71^wUmc~HdlBB(56z?|D)E`G_0;<Xlh+4
zp(%AGLsRQYhAMnXsm*GnKG38dAv!uSW0Px0+}Rc~u4VPb5~W=-w<pRfcbt>jS(yCR
z0jYhYsJLp|vsG7pdxq+g+YPF#sa-k(iK$-hwM3cA9L||Rx%`7-<+=X-0iClF@{?Zv
zr$}4qT>qNxEh4xoQr$&#$WwWu9|oRq$K{iKx~&D(p6I%O;O<18wCPA6Sk`y0|5*1V
z(G&e?Ktx#-BR0>drm_uA=H9_erEwdTV-?T!e}LS-=6QGymn+;EZVOwt=p|<P3Jfr|
zIhbYah%Cb02^=d>j$emVZQ*nMtzEiV6K9Pf9#N0DC8*!0Yw$&X;hPzX%kTwP+nJkL
z?ihWpzsk4l;<^60!Qmz86D18_hYhEwJ~jY}&VOeSb4gu_pVnKdP3ltWYw_uvaal$i
zvkLWStsPjk1c8}PrgjDk(8BdT@(aLxeJ~ekl$dk<PxyRMo3AD`Lh?ml@PQwt3(e{1
zrxxENHC0v6xX-YYq&<=i45#AtZN1F$ph-V{Cwk?tW-V5e1^+TdXclBaBKj|%nkwf3
zXSr<1gx(MundQg1)EeqdPqfv~$2#2If6NbG7xgWTKsS1qxw`uw=`!Q@(JrO5xYOPj
z-)fJX45d}03{DT5&+|T2-GP3&qcimVKDqB`D9~>|ZtX>$NW7&pWaK#(Us>C&$X2Mo
zGSL4Tq^EC3IwL!fx&kq*Zm1@AgZOUFDO-o>wCVW*r#)<XudJiGW5nr&9Zz*+yl>iL
zTIY$HrFi{Qvx^He_7oPIL*}sG(e2pf$U1F)k6FH{&v<^so&^giysbCj*ycFp$UL3F
zW3u*|U)bdkHZjXAW9FWWy{8;H?#_9@MDxlyb&k|;u4p)G^Rf_gmW!tb$`=$2G4KWB
zbc**4+Prf)HTuBeZWcXXieKU_R^#p70x>wS<eK~|y!mQ;l{ZIh`cnKFFQ2KXX`OfJ
zC(>(}t5{bbcdY6zE3G0qlaJh@PtdzBt?mx=FMH`e{H}ZHe*8Z4(wgo=j!DiH$J3qn
zoV>dn5~P3SahwfXN=N4I6L;n8%;0;6Ki6b!$b2{Bl+a=A$gu8o`~dW{M^E2XppT^!
z9(P!sE4ua0d)}e?*g(1WkOL(pY7g`~{ek{U|CZxbYUx?~GIwR{OjBvq-?5;>)8U)9
z`T}8Z?_-wVC+LyOAg4MUC|TYxWVENF#-DMD+%UArZ(KW4;cunBepBVLbGCMjgPbl3
zvQgB@dQmS6BJu2|(a6tfE)ZK1D3AqrMQK~e7u_4UJJJar9*8~LZ4d>_q(E#b;mtWj
zAXbkVD~GInw#tZG5(Foj__$-qJM~8bv2VS~@eMy0HWoeZc;<*b!Yp$qQXkN43B;ZO
z@7WPXDP7<fTxwV5p3<81#<HO?cC9s(!xydhgV(v^l{GQB%NM=dPbK~?Lz|nQ*JNxk
zy_?RtO>ofQ&3r#|ugw>4;C<sL3DcYv8jYY_rH6u$2>zJdaX5p6b}w<K%so1ntwRo#
zpa-&OZz7|1yWxGz=nmR5l!QFde5{s1aKp+p!ye;qYdys+>oxG$lHM_VM-!wqkng1>
ze@R&CqSVxSU#!WilWl>L&<>Pk>&_JoyOng{6MkAVux^5L$RWe?-B>l4Wj)VVHuQ|&
z<cz!8LL&-w&SkWxLRmY#f?Mt-e2*fZ?Kp)}N>NQ|_)k*S`>nv*Sm;5$%ZR`5a?6J5
z{Wfq5{fuN-5Ob7q-u?8IrGEW%T6fB)D)mun19-P_I<tUt%EEMoZ|)auLBpQz{s%e?
z&A#Z!YLa-$r+%N$SsGKrX-{;GpCkq9Ra4=1htjJk)#Zzcl~TKL4|aKh9le6A^_O9f
z!CBHvJx;kSf3L6AGE#fn2<j*OMzUAy(W~fd-lwVU7kMc4pB5T~Y;MD9%@T6}*!wy|
z>4n|>Ykj)rNwiwHM~gP_VXispR>E_kHEGS{J=1K&Du2iaJH1A|$m9;kTi_PcvJ6<;
z?)M>ekoq$?SmiAQCElR+-r5d>tZUXwCge6_b~4QJX<5{lb$X@$clZ;bmKJ@+KGUxB
zoyK8n9j$V|&Z6I70gc?GOv<?p<D8CmW`}ebxwj@$ydg8W7HWH(xbsGb{o<wt_OQXB
zd(hr%@3UXhS5xYL9xtw0&AGj44vXch+#a0XHk{K-2~J<DaQbWF>l2(_Ryh4N@l6R%
z-=c8(YvNlIoc=K{wT!6C-Ls%4(BI|*NB8Z36w{{Y7MzQ(+(tY{)fN0b{i6svq|$m~
z8I>$re}??fqf`WAV=Jq<FNl~8+~q@9jq1v%tmQ5b!s@uIr(dYtct+DbX&5q>Cn}$@
zU3nPXp^4;H+Kb4GuZ*wQc*SfdZq(EzRBUiO7yi=><324{pueFDs|LUYsP9sASQNYX
zimAd;23%zi@;O7FSC<WlP8tb&7<=F?f@I_ps&C*iRfY{h)^(pXR4{qN0BiPqbg?=W
zM+QBd-gQE@dCN*ymVz%er|}hqT`^ZSob~vb<^42`|0+7QcG4&UZcb;GSEgZ>O<<N~
zMa;4Q;4?GJ0YHnMS)Q88EX@VXvZg@GueFZ3Y=e(>*#`fyi~7ZOrL~L8IL;nO3j%tC
z@T0UngHL(mE~|Su@9P<S#%oFm)AB;IiJ6m}nbuz8y03A%eP*t&e|*KWTuMQ?SO-_M
z9}VI6Bl7h?Gvni~;GooAN}P+Ylnan%ftsRKP0=&>So@?ziZY}q<0;sXq^4j)we4ae
z#X_W5sHUh-q>$S+jTvaTvK(p3)ih0sG%Y+0t23^vQQHvg7l*ZBXZ!adNo%bj+!dW$
z4|vPG1O`v?R9ZV8OQc!jElQ->#?xpmsa4Z3>^yT5X}0q;T3e_EG(v1>3G}>43H2$S
zN^1?ZK}ofOr_vV-EqPKh^>Va)xzh3hZ4B5@YfAs!gB17h6v4q{-%u-vMyR}zDdj!K
zYgbD|Icn_#RVnTGHcz9J$%eH4pp~53!Rby84tfqUt}~$Cr7>FYQQ1ceKPvyo_A%Nc
z_Y599sJPhBQwdjF!nG&i+JA8QNB5|?*bwEi^VV2FFG?GT+K2*4_Tu=$r(*6Rs#3z(
zP`&0tPbp#4BZ|ukno}vtX&ri%xT7l=6C3@5r#=#f1mcw77u156K6*;+O{qP|T}077
z?jp)n%40*x@vZWDw0_|n7qa~s8dEE%LsCW_dphF9o9x+9!S&pkO+20rtwByo$%aUC
zukjr42AoFh1Oxy<z)utWC7Grn7v~ST8sAX%b4snUH|UJld$9i6x-+rLy~br>>kw%p
zjQebUbLeZOjUhP%&3DRPka|SZ7X)GgY2)fAi`!zRrd--*aoseyr)+EAp^O6BR|UT4
z3QJw1M3QoaCHCHYUf-NGCZ5NN7D|d_ftB^cG@<!-YB=qCDd+H7bzDoKV5P{x%D&ll
zHQ&qJsJ)R^+aKo|oVFluD{23hWQT_MPRe%mAX2dbk_>)~o=GhSdw)9JaeX7U4zlDY
z;LZ2)(;h2&{x0xSW;u<p-vaI$$1K_DTE9{))zHxQT)BbpeVhDGLLZldJmhAOhCWy2
zXLW8M-VUB@^V`GDIeN&CI;WvXzeVp9B*CeTA8%JZBYIgP$T~<fw&;oz%yKrz7CrT<
zAnV;-^U0^RLX$ywomWlX_#pb*Ez#~mjyFK&JwY)&gH2u=_yMO;;L+smi4`of9nsFP
zD2;W<?hVS4zYV>gN*%}v9Zgaqr?gK-LEC(sY`!4mQ(LpCI+^Fm=wsdt(bH^B3419j
z(cD5#I-^RaeJNU-5<Xn+kbY|IwE^rnh4swc5&D*TqC$P8gnc{GmJ$j{G=e%@&&{J*
zd-UA){?<UcyRFaBC&+DK?8T5z>#w-87&4o^@20uwE&+Oml5hc0Am6*?o)?_uVdU;$
zZg*&V|C-~wKwW#M_@ejumR}q{joRUh*>O6vqLf`ND?Qi0_5|nle3svv$bC-;yN{Io
zDXrsYY=kc)Q<SVw70p!&1Fa^)$ZuTN8LH%x#WQnl(ebJ-&d6nZ+Aqzdm4@$}tfCg$
z;w@A|TfCzZp{?FAYG|uBGZFfj*Q|y<=Jf=IoSC9o**C-_uPqRlO>RwMSLB5t!iQ35
zo43Q&8EOm(Yu7l8>z0&q4TtNQxl&YAu_Yd@tX{rYTRZS|2V)(Fq=TK|iBvcCBEv(K
z6t5pr^o!Sz{o$dbVd-P(s#FFU4kJu5oLGI+-zo3dp-;z5ETZ~?F}Z!h-%0t#b;=f`
zbS@tTWA*K%w^7<dB`H4M570l2l=Q{AmQj+0mrt~KuK#^#AMJg#e?5ua5442cioW#a
zD|bVCKp2$`Eu)<iq-m@U*rCdy;zHdzeYLJ-Ov*Zau76KJaJHd@eSs%j>q^_g?ob>v
zkV@!@VHHwzUfAWj{Yq&#*VSZ1(5&Q-qvUuqb7m>rJ4TvE+U2CXl<`yaXad@ymvk)|
zO5L2Yb*^*$kAbIWaIQ-0mM>c4r!b=!uOJLwzGCNXpg4phZV%w`E*o?i&^H1PqH)4Y
z$$gM^w~_SXn%D|IutGaVPB*|H=|PjwoXzo5O4{Q$xZ1+T8J_4v(A%tW2qJSTb4Hub
zD3i}!U-U7b;EXre!x=?2vCYtqmV_ovM?T-g>98N<C6BE>2R*4CZO-R0xzkBEkv*OI
zJZn1XMQPVxf_;B?zuiYPP4y*bFX3M{bU!pS_ORfz5KUmzs=PLTF7KJ17|!whS*jZ=
zIPdetrL>a=58}K&UL%}BJ}xbv>mL=cZi+k2m+hDB5!yXA-h8e<KOk(Pkc=Dkv8urN
zGJS<UcDY+0Ti$IFjho1ATyDVkQn&pQVL&~lkM;TWu}1&7a7ML0wh4Xzzq&S`|JU>S
z*y~*xqCWO*|HBu4^694Y6t0gobtUs{LcX2;%*t(HoiseA38lQ~FXA!h`oEr%r^z3e
z^|6g_Q#%-TO8VI1*L;DtzU6(o$@YjRg%bAq7hts@P5Ra@gJ^S(0R67+hIv&D@nj7P
zgR3T1+oi{ET~{rBH@+?4x4z4W--c^w2U=~vFY58vL<)iLHosuUFWThy*TkOn2O?vt
z_3mR~eXI@bI_fuUqWHEhYRMP&ys#TRvKgr<_Fe4L-ZZ7G>#kp3F;>Q%uPkf}O<9J$
zVz*Ga-SNH1pG&Bn=;ca%>`9EnHb7gqAU_Aa&P?>fZunPmy|N;6#p}(SllOD^g7Phl
zJ=4B0R{qiU&}>j3afFk7=DzI7`q=vcj8NeDv)Rjk_GwM5Bd~4mx8{ET(`V0Ri8Zme
zc-%joedp5mKP@ZGtgI+qdd?i0xi*Kd2vlyvS$%9T?}5E&(}I8iI#`hCePD||+4x#b
z<WXsx=<7IoF7ECO*Id#`U5+$SsOSvMY!>XXYHm%#si-FQ>1#EyCB#46OkV#P`eRwG
z!*=-I^Kq<3+b*Y73zhcp%q_yQtJREa02JCgjoP;Wn*Es%8mkA<Pi|=TjnL%iV>=*I
zY(lTgDfH9q*T<d*b^Xx4<-FkP4C^stYyCR3xz4}&JdN0{l+>I3;)8lgbkWFZ6azQP
zP{vq?`e;nw_3NQ$f78SuaZb+QTvleFpc8(y!@kh*^)Z_4l$4DLe>(FZenpaNTbSWg
z=R2U6{ap*_gbI|q7nrtm<?`5_4x(gc`Bj0UGos($V6UE(n_)R&W$w2e(1$_GZFZAZ
zX|BnP-)T2$w5HKX8_rseT8&5_mr3Kbbb>)mPx@y{pDZ^n-`v>2(=f}^R%RKnn$)zW
zVP$K4k*E;7ymvft(+0G2sV}<prHn!@FBkZt-+hT(+pHO)(gyndl(*^+&_A5aP)-oa
zh92-6)I9o>ltG^IS4jEej3j?d<?+x)`{R(o(ux$#G?i%*Nn6ciEkx5&Yd8Z_&dZA(
zzUVi7f(z%7VSCtq(Od-FeY&-#YLdqWGl0F1T-&T)s@sj0F7riyb(nIWq}-7-%6(X|
z(i$A57e{?qeLDjNr0wKsGoX{7h;s?Sxx4$Gca&3&jD4gt)b!|Fb6#H(K|M<h?<ddI
zZpO^s>dU}7FNbzHHn~e0!Res+Upm1P-R(2%6Wk{3Lbl`x&Et@AwNK~rMGyMi#1DhC
zu9rYxiq#Myf2x#2a0LZ98}i^>Q#K#pr1nxhi$mz+po5|D%yMo#QQ70xRQjTs0vW@v
zD>OByLDTv@tgK|GwgP%g?YxiD&<voNi2jo0zJke~=rO<C*Vbp8+1<YmJC?Ta$RaJB
zCrT%yawM&U;*@pUP{=G}ZdA%%lTx<fRB{$*R88ePeI?sZwAM4l=2{kxyLUR|K4y7u
z%5aL;_Ifup#^p`ug{2d8Dzy(U<4xqJv!C~-kY+tOW0LYd(qoMx>yBav3v6@v9Wxst
z|6}GYg%0j%Yufa<{5rzOpDh}uF-X14@)`Dh16K4Z+;cfcnRa86)~=;j8hI0B50V{9
zB1W76n0dYhB1!q1vIW_|{m{-sMzM!WAklR9KgMO0lET#9g=N*S-km_Pd`@)tf0fgG
z&lHdQNZ+zPaO6Ik1Mf}g?w{yWderKsaIHs_9!>I=>*CKj!@2$+y_B2-rWyKSSWgtG
z7dB;UybSem-qADViA3)w!~T#6Q+VF>>L)%yD~eKXl1{XK)96_1=XgU&r1RpeVy!Qd
zvu+BXbw)nxW`I_5+}f<$<-i^qSkvrdn0r^yS2X)Z@En3uklmp)HT7H**~+AjaFTu|
z(<vh7Drw;Tzd5W=@D-w>o~V8X&L|E)7Yarv7LHgKjNYJX9z9V*QuD}XVs^7~Ht>2T
zjX2Fs<+Lc6q50F)6g`O)hUScF<D^}V*MWUzmcoHqmX_Xx(<43R^p7)qw3GNRmYEG3
z0B{TNgKP0IH$SGvwDMDonVBt#a{qR&FJo=KriPg*?Wsf!yHNMtyoLjr3;&yIxVBFX
z&3UNt*~}bXkHYO9_M5kGI|zQtN7g_mQ&zF$*rQMR+@oCsP7WK0TdxU{y+zwa-P#cn
zq-kGVUTy#IEKxGqfIQ(l*Z(zNzNmM#BCQhp#d7A(3qA0ul48A24+-PzzWt#uD)T~1
z&*@|La?KUd1KCv?r*C%%?sqZX)3TB?menQKpAyn_)EnNX7045P#P<Z>v&=6{&Wcut
z@x7a781|g&f5S(sq+t)?*Pl*&YGG{22Ue%D?mXmhl#Qsg1&A-5>wgIA&~V<A!Fkiu
zS27_f|7D7?P}iiFP?qJ@tmJB>;idJJf)VG1k&=+%eOn4%w^v^e6HoL})V?~H!`mS=
zq!pg)p9el!I(zv=`$eK_8Z}ybXwR6s_GGL0IdML`JnRa&L&2eirS^-2t)Wmq=~`S>
z`Gm{zSmy%A9fAxQqmOo8wBEfD=#1F0E2TQihIXLU58P;kozWpk>@*%<=1XlCv$$4>
z4ZMm|ZN6@(>j#y=2HK$aOUJp3);qF#9*rH-tM;&x2D|>Q<k;nbKc(8|&<QBfg*k;T
z(r_+HdsQ06s$h~zhV#pclHs^n(v-E$!q3gg@`%guuryNeAPp?hlypYJMud*`sFhY3
zmPNFadJ0b?W)$h%RiRZXLz!KB{6=-p*P@mzCoBqZ&fKEsQrs+a5^s%$hRaqs8O!iQ
z4}iW6d+m{u2(#R0_Cz1>J%QdR31t*|qHBFQvM2g8pAx&#l%z^UegIC~{)4&60)#Zc
z%9)_nPZa<16@#6*n|M6=RSOF@-1U@)dPL{+L?6WLIM=@}Nb|(##Q2@S?%XFfoa_H;
z(13l{il9C=8}gnmgU+u>YS5`tfVQep>CFA|m3%u^BC9XD0sRU4EYQ6#x&Woip{Xu+
z$QLaOrXyq_%B%80?~78E@@ZG2luZ(avUbwRI<0cBJmg=j`TUEzKz-Ej%<T!h<!FQE
zU)hl`Cv+Rvp&8_W7N;Xc7Ea@G9~)T1?LTNWeQmr_E-b(s;HtNtq2BRDyTAn>urv2B
zp`lhR;nMdhws48lWUlw*I&MDue9<=o20r^}#@Ty|N<7h@1fGyPv1ge8TL4)0VfRIG
z*~O<EkR(t$&h``gB$9W|nN4IL5HL<RfC^7>j;ZaKk~}=#&_+C@ewTxArCc<l%*|sY
zDpjG~qy$1#P7;HFxur-AiafC;CrPbIUR+GF0k?yJ1l?iNb`cjdim+?!5M6E9Q|OCm
z{`{eUa3Bn5=8}DocwK8gtS`QF(D%COYxsJ_1|H*gPe@}gRA3a}`OmHWzLH|?*Xl65
zH-84Rm@$(c#TrJtlQ_yxpH6uEp@J+0tAdlEA+o`K5Wk>0n@_(s`x-7pD@6uY3Z6ow
z7L6T&7V#O+Tv+$I^gMK;Idu+d^Xyu?QeV{a-(pufk~DB?{~zo4qOvn=glyay)-CG{
zW6eHJmYoyL_pA1$R-$K>_iMCPjCLLi2=dVgcKqF*s5c;T-W8XV7NU8og{Y#D#u!$T
zr77{kwvaJl#rl84PE_NIL_2Yk)R(kf)OfSd%&y#knWC)!G^XszNbtl*eYB1W%?;JY
z2i9^~bn2X7RI@jvF|*=qSMrk!C03A@miomy(As_%r#b5YX)dpgw?WT$Gmp2yR_}W8
z_3Z^}JZYQ1oWH4Ek-==&t>1?Fr2y%aQ*!!sGf10EAunHXcM;vq&w$Tm8+e1x5)}G_
zJoTL}=_pRV8c&9W%9CN~*OW#dd)ZIgNgrv%um@~v=bA~laB>Xo9@+USI-gvw=^+UN
zRMT~>lwl~Ode7?=3V)R7J~5MR=<DT>SN8fuSKM9hkVBoJ8!)#Xf<*I%?|UKJ^c~?{
zq%*?Gu#K;zKQ5rsKIOlED4>*ajKM>}8IUuyv6~F4e8^`wZFn9lj;}E^fn)G>t6}f=
zLSs;yqNk=Y7vbCLQ*3^z9@04chL`;-{u?B|lUSFnsy1E=OYG;1ll%G1=~^u5#IzjA
zSsll|trOaEq;g3EJ{pBaY2f&a(xH=KvnVw4(}k3n6NveBSo-~(l5}3OG$47Oz!}mF
zNUNM9Q%GF4xsz5XkVuyWm(kgiNz`EnL>N)3Hxp-1dZiv7Iy|qYSC$4kadS#&{Ly*o
zus!^1aAN7L;Nj0*ppLf`++S}`YkcQYYP=Hu!}fw<xs=dj?b+9cx}||P4lx%m&+QrT
z9a2j6K-(aI4=Hr#8K`g9r}*Ud&F6hsD_p>+Gc3V+nbm1$0v^z4+<Dg~_XQTfs(8tK
zxu;tsX;k(M3>*~e|9Zjmiajy{tD@&uo`7dl7^epO1dqpGmj8Nzy<+BZwoUd(AJQSO
z(=%ZAdb&LW!TGB%*bXhb6#TuWf2TA0POJxhM_H-dr<^5uFc015HQXNqwl<Dq3NLaY
zU%d}A%iL%9jTBH$R3~xnN}3kv_uNuoek1lWr!_4L(FJRSRkZt4Q2)NEhP~SyW=M2r
zvyFS1d<)mUWQo^LL2Y2*Ih))&Wt;!jM$-3??q+j-k}8vHGL07D7IzvPQed*f-fIsx
z&#^;`SbPnJ(}1BN1w-ZBscdLFtOlX0gD!dBRKH`V<6U5UJlg;~r>j~b!su_MyB04^
zC#v9O^V0g^iT<yEk8DxplUPIA`pnb+8J5KvIFs5HU~Ws}1>Q$gQc_pPWv9kk$2Yh>
z!Z*-y$Tx7}MU-0Kb2RupjEKAQGOZ9N`+oMBC;HDm%+pKXyM%T}rrksmPj<6dT?}rz
z73W_h1u#|jL9(QxtrEqw=8@HTkX<xMUr3}eI8jD0DSsv9EX~fF+DCNJ*1KV-EuiRb
z(fgO|m#OcKzcu_Wi}$~8KyGJF8|TSB&^vcIeFJp%37q*@O}l2KreLJfQbsDL+W5jw
z(2_Dnh8J|O%lGq9BDrvXb{fX&Mm|=Cy}J-%&lxFduD_p?`aEf8PUGyuY87|Erf<+Q
zmkn;8%c_bcpPwXEPnXAUbIXyV5t+M@TJDKGb?`2?hxU7LKXXuV`3CmG<?$!ez6sfo
zPG^&JOLH-MC)p<GUG~c*VVu+c#*ALGoxllX(PUAvoUpwrRM<}7)Z1AS!l`#NEEhRf
z^<m96@YOeno?QA#*7G*p<}yFuNOxIZH9TJv`a`wyUE@g3nz++9&mQs3I~iKmXQWdu
zXAtvDD`yGWXSjj`{CpnYCbA>>SlP7(X$}7vypOjb?gaL(wh-j6LS9Nt!-npHNpqw*
z%lKY52u{Rg<rZ=f`wFFe*k<`X-EpjDD(^;Jk753v#D2c#N`b4B^2)&DAeH0>4oV$W
zUUE|&q;m4IVlC~RAzP`f)E!dF)@-t<HnPA;)Zy$wKiOVW>>4yT%~iuG!;n}nibgq(
z-NI|RS=^Sp2lsGsOG&kLVorX##LJLgy9+Wv?{op@(wcpdCie>Uh6wDX8bnxE$CvWb
zxVGTh(v%xRgoSn&!yNh)C0=jOk-gjC$k|1*0cHz$+fE13$%x+>-Xp!ot&k$p3)9v>
z`^aTK)2yCoenkei;?(tv&TLVK`=VK5A%0Ex6`e-03~n8MMc#)a_Vi%IYU6$0gFfF8
zPMbvi-!riDpgUqD8iRY!K{;Z0A#IA*>pQ|c#?^z>qb*EU8TJV1vjy}?bS3)+-Z;qV
z3ghTINFiA-^b8z4_@lEYBc9(sMRpwS&S5#&RiB!JUG3mG%qcm(Sti)8m*<&8p0<O}
zo|Vo(&x;fMB*kmz3V4!)x0c}*faSd+D8C->0HB|68~WLFj8u+tyZ>1_!{zdmC)x)6
zNLx6)NRb)ILYY}cjJ{qvvRTL|QnVmSy8H5(B^N+12BemG!2bkK>xn)N+4FvXqk1=R
zqM7O~ge{s5I+*IrFXwE-y;s6UIhRyw8NBU!>EbS-vMp>Xio0}`bi%2m{VASQxfUC=
z5I6BCtqxX+$+UBD&i73E#xcxU>(~g}rp~ZohEQQ`{$sV3+caqOPB;_)ne144o_W6k
z&U;BL=}il*a3m>NlOq-^GCIt^9jWk(0joEsck+4Lfp0iyMZP4OpRWxqbQqqOdq;$9
zAEv9E&FVGpo_*f-aq4(3Sftu4q2BL@Pxjq=-gc0*Y{VHfeC|CT<a|O~s}z1kTEAk4
zd|BKnUo`$E4ZIe%CI5$fR<ZCfK9BV&h1dR`^IBycsR^xd(48gyrnbwqj>Qhcjaj1a
zqrX%bDh+EtmtYNeNiX`2$CnHCzud&on{h~FdeN2=qR5AOm(d~jmOIWv0?3<c4~sLN
z#wmXF1-Ae3vwyL(KcKvIf0W*y`^;Ru>(E*G(yj~4h4}N#xAn95a`u)``KOySxsSOP
zI?UqZ=Nm5cykheUm6e~dL0c&sTv)1`9$y~2iFj&SNv(_eZ`<HwXOtCT+u*@7O2|6z
z)aIGew6*C{e)CvqY;%E>**pUFLMxg}rF+-vrPAgp@YOcYkxn$<1{c54h*>0^=^2_>
zc^kCjR1Wz+iA|`SEoLPA=VN0kr-{ad|7`4r%1L5w!rvRqsT?b2Cj94zMpx#Fg$aKy
z=r==LnDA3QwyQF?H1rSF!lG7dfx6ZJi*j$gW=$k7gr|OX$1CXf^XaMfDYm~EPwNG<
zNC~|n`N5STpWcly=G4wvajz26sQnTok=zxI<T?RdxIQA-5saRLMnP~_hB_}rLchjo
z(!y>}$J28=BTvoKV|QwYlo5<>hm{HT3h%O0)C#GC_U|>ZAK?C1TX=lkpk1ER8F7=$
z@3Mlg)xe74i$-6-v?&rfiQP!tJ)iF-tb^kZni^(Y^!PfVRW&xugr3bqXArWDY`8me
zWOKw&pB=H3)W9;R?Q-YkaW`*|eaC;a#ZVoH+5GdG^Z43=I)>dIFye;Ken%(nZ($AY
z1`P-7mxA5GF2=2WY#quxwZT3%E?ZJ|d&-zh=~wK6P1C7ul<Kp@ZjVB!tv>YA+c<$1
zWbmfGli{P`VAR>w78Z&ue8g=SOOi+=lD~M4AWpN>WjSI3H|q@VKzh12p~>W0neSdx
z=4O-`cb0J})He7``vvUZqz*eu=x`qmOC*2bHiq2pA&csd6ns~B%lbzFGwE$+nL{fk
z+R)<Fr&veZ23x&fTpe$>wI_2u=6&)CO9_z%xwWh;4Z=pAr_*%Sifkgd4UQvy3kEDW
zYdA8F@IV_XYhr5%3%AE74ZeDa=nFImdG%<dCbs7zMdz*1YDaNuc{=xT$E_%-wJ^EQ
z5D+#sC5(8xt>bY=x_d?Uf(}F4z1?LUE4vqVtm-cBm?c+rGw15=`(Q!cTA031dt*e8
zGICSOpt`Bt8?F;J<~m_TDPdH9b;r*gwvMK^HguTQZhot#qxr4cjxBH1b+o*-u_G>T
zeXE@4(Y2)1)^Aqtb555{;xt%M-zv_Q=ZU5A9C41E=AJE*MaM0Lv&2J=rUZ@D#GdHd
z+_60-bv5I+x@!x5H*~e&w+463e(qRtSnKEK4{wJRUe#gGT-poRN_T{I9o`Yz4gZeN
zcG!2}HmKVG>wK**w6zZTxyERF>>-~{zOlJdnz}Yk8r5u;ig25{TzW;E+gu^t*36~0
z=DVcth?s9ao3kyXoN!6FgL#+x`(c}RM|g2*Cr%AXTF&IFBE?DGyPO-b$8AH5ZEdTA
zZb=f((%|cgerE9f7d?k;gSI*4r6(ghpp8*t+uENX%7!hj8|!5)tR%||t8v;daBHNA
zg%1Lc^**7YBvb_3lzV;j%FDge4>@KX|AAw!thAKuE`B$u29_%(Sdc*OhQ-y_gCb5c
z5Jp_ZNqoYFnKCn!hr6|u8h7rHqe-=vNlo`xb<R(OrO-iW;p5m<SPFwtkI#VKkVARE
zW2eu<b+545gbzJhi2GO7ak&8}5Jv3!?iigaAJD$4jrRs{!MuW&5jRoX7qC7y20t=X
zek=TW^=H_<DEpco>`+8m*{w)}YrIP@D7zI8Zdt`$(4QQZ!QbSN?JZhAlsSoV`RID0
z_WcG|hr=C$>jT^1+E+7%SaZ6Bds{x+;Df$+<??Xm4C)b*|5?Abn;0psD9t@<yE4u$
z0(*NdrCs3?D)0@GyAih#$(>v`Qsph;VO;}H_&Xei8D|G<{+#A4nhhMIu7UNwvjY+|
zjEy)y)N008_Hh2P1KjI7V$oshBg0br#jb&Mua2MIEAJ2YHs*zM&)EjY+X*9->q8xY
zJ5DSQH$(PANRUEB*bY0Vlg}Y;I6Qa8vQN&fnk{t=eBDQ-<b_9|j28n_OKgMR3B()!
zQW3Yq)!jAl*sHzJeZ(u_Izg#RE>UWC&(d=%2EScKcaggWzUJ%2DSBQAQu*K$e)lK%
z?IH{peWK{0spV*$UzCMPe7nf~Tv&%*P);<Jp7}bDM;*xfbskUdWDmXQ>veWHu>MDK
z&ui_ac2aLCCA{bd9+9qrgRkX<aa(+7JI)DYuR-3yCF!JOn?euZ%9VlmrXJX#EqH6;
zVgH~jps$F8GQ_^Jc)j`ZUoX`D>eE;B_gp+{4qaY+HZ;IBoJa*(48Me(lc?|B^VAc6
zYusgju|wBb4av?ws90A@gZsTk$F5JbyWAe!`ulgE-=>5lF;(c6)#r;nxXqKvYbToY
zB=)!1u`VI1$dv7{lv3^sk#)1=r*q2lDZ5>b7GYgw=^4pfianDDTq#E;tpMY)R}b_6
z_THCl{?amNx)ciB3BDtpgxlr8T`pU9PxPBFG0P1jziG>}{{W@^cqH`$)k^mp1($+9
zb_I~8Q~G)sr7sW9DI%(&QuSBOu&}uI9J9nmrbD+zvs0OylSG;sBIX#rL2}a^BRAEk
zjQV%{3O%J4rH-}%IbQ@NJ@&RXD%ZAuKHt$$`_cNw_@-q0=|oexNB)w{gS&Hej+5&B
zArEdJO8!6B`AZ|%pOry-5eYrvuyud)yE^;HNNS(_`~N|o*ap3v?>rZp%yHT|S0Bx+
z*mV~2N&fgk@F$%3;TJqc;ZKdBG@KtLdr9jH#QRssG_&BsD;<iKgVr`m;ek|xuN;iw
z24A}s_m+sOuz><OO=lPqH_?7>Vy<FC`9+QXT^*NQJ$QK{hu?_GBq@vcxhIPKCtmu)
z_Y8&U@s<HQ9j_2h|4wAP(>VXqN0<21n=^>R@jSLG7Qe9PTfNHdGNNJJXN5fVGg=#Q
zGPt87;CLnS4d@CxBfe;6v3cH)&f?r`8NaEByMBEy$7Sdd8rm+m+|zr@U(c3Y#t!&l
zlSDDeu$-Hf(q=;1fUB|XV$0I0v(GvvpY;uV{9=~qADsCzg$D<MFDBzY{3Q6YdG<+?
z$5E5G{KHTF^eMZt@0W@{S@UDpsaXrlR%`ClYQC(*P`#O`w=Y?*8uQ_2!Iy;!L-Waq
z=PhAbo61>^Vvlg#alG$8`uu~x_IJYW@+rDI(C8Wb_{GkM=a=XyKhECmov>@&ftP2F
z;>{MtjZ|t+@At#v*lxSBAGeS9`@a`4mylc2gw@jP4g4mcPP}U<eTIIQZl?}b{@VOt
z9qCS#<w~1p?^^>b#7bdPq&Khckqg1-n=enO(?Jrs)lt$nq7VLG`Z`{oZ@;wW(og3_
z`i|YQ0C9Pj9{DsFEqK}7*T+-zbbQK7`r?+q+@h3H@bVLGE!NlZWXH=qJ}=a8wkPW8
zqIUSeg?ey5&gN|kogG-hCHEj!cAu9yH#pK8Kj54RxY_eA?LuvT=)lhEl4;6QA$J7w
z^c*%=GbfI{mQZ18?yZ)fXJmt<k!12R?D;-3CONFapOiN{%7&PoY=4Q9CuMOZj;u{G
zu*NEHZ<GzS`CpieTi|$ihf@BjX2b^byIH49?=R>mcBGw_I>>S$?fLZgbcJOd>8I0n
zjuK7J3$VDvUJDo;N+<pIo^%6$z30tz#a{4uI(RvBh3UKXq27dSK<CJ5yPv~pCFQW-
z_o&qanTzTtYo8XMk)IRLX#m*>Tx<Iyy+kX)NIolxW75kd6W!mM(;2Rx_c+%b9p$f>
zkRB=dA`+!CsPCI7)<*%{@Id}0|9$VKjM!)1m9;Y+{YUE@S{|t{KT&B9TXBnkS^l-;
zw_<e*>?WlR>u!<?S{#yfU7nQR5{za_qt>NKLd$Y#X>nG|J<?Cb2`yF9#C2<>@hx`g
zU&P{;hos5t(xpkroi9yVx3apZ#VFp`a-TGHok5z6&<x2Zmb9#tB;;!s8(Q#ohvZzB
zE!Dxlah*}BX=##b*HuUjqN8PtRKISkB#WDnz6qteTNX==>y}7zOSAO2xEb|tUbnRR
zn=PB9w^}w!Eh1^tZX4CgzZIhtzi4RU{z|K?gj?(R*Qc-L-#_8n1m&}hTF1W+8rJZy
z-B8897Q+hueJIb)zsvHL@NZXcIsg7gu8n{HntKQTn)7buUu)i6{<Y-I;@_w9O8EE5
zys7;ASY9#zKAdOeUsv9E{@s{o;opDC%je(fJduCbTh09YdA^D7X^4*tDmO`;Gs+!V
zq88hg`+ax=!M8j-t;kV!L!~@t#5sHEHv_AC*cHn%yev10Qeb_%a(@u-B_Qn@tnteF
zrc<SWBxifrZ&KDb{^G>faq6b5aU=l|&uR+=v2TD2x7-gNJQ=nP`sVFO(Q+RRC-vM1
z6MAkB*Fe)gfy!wMDOz!8VWAiA{2Mv2I=g+OUqDU!557O&2L94^$xXc46~wJ`_a&5q
zy$Z_s8?RP0oDD+D#p-gdGFR&*rDm->!aENVhSrj!(1<8l5l(-<4akGr#B}#H$<xWU
ziq+%(TIi;bIGs+~g52uh`zaO(UhaOrAcx-``2)W<^6&gtxoz?)cfV91EHO5nsZMfG
zoG0Oq9g}JO78+0X>1XOH;_l9nU^lc}#cLdKm)s{u^fPzk{S9kx)Y%z&VeZ}7k&};b
zwc)P4&CgW5CR@pOMSSOlcWzYLqTAQJU7$BHDnLF{bS|Wa{bNnehU|AoaB0OhR8BHZ
z!{HcPiZY#Pr*#g~>Gad-yA4L6d5t6ew1^s89Y^|&c<BWx`Mr7DM`?SQWh-7x(@D(v
zfoPukbH~oZ@s<LKs3E6Ws3(5(>}Z|iamR{)X;0c-+b;w=jTmkRFJl9&#q@sKZ-k`=
z32)znf1enGFehFt+l@4kU6nmPW<#a>?Ad|m0&(nyc6L)7-W*+fMPe?Uoc><g`^ApT
z_cC`Ao|y?e(}&?neLy^X=_e?`pK)5jFS|Np@7aM}hY3faj4;U9P4Q<3e&A1suHf0x
z8PDq+%#E-BY`RBJS(_`R?M7K{^wY9?FPw7ByFe>j+Vj*VcaJ@s_TDJ**0m$6(<v26
zQtrc88+q#U^N^lWr{i3U(x$&>+B3O__r}Gd$akclI~<F0D}8~qJsP%W2VU>mHs|M#
zvjdyE9E(OF4!6Coyv|p88{XIucn!~m+0`E&5>elg{tWx(^B&TDxNSq7hw$aLWA~o_
z!Fim{cBSnVDo`Izt^$!yss(4xzU*BicABt`BxIO|g?R4^`CQ8{(#a7@bsoWczSD4S
zgiwA~%;*%mHwSZKW+A;LtSh|aEEIKcjViR_x5<%>wf4KCn;eGeRwr)2;LMxy+VC0!
zlRaI3#j2Vm8hFmnaUNlEnZqj_x}qV3P|ZGi%L4kg{iA<6Jvm#HyOh?Ur-)9uPSAJI
zj<e8Zct?ZlJKyEJ6Ek=&rNGxxfz!qVaLYa(!Z2SL-U5RL*gLL{(!ez&B9-tyr6S9P
z=s|Y6oa`toe&OBjl`nT*5}x;aFPxDh=00dNc0P0FmuJl3SI#t?N!HQxp~Vs8ew2>V
zd>?qoC!=iCC4Fq%MZ8v-hiu?|j!SUxb^fKAq!*v__8gKUo4mWuM8eHyJpW7jJ@L0x
zKp#fZ-N#7M=4}@m^CFwiLyqh?**9TwPt@0O7H68l=yy7{UZ6BKybSWjyh+QpUg$ae
z;vDbXlabar2j|)^?+EvW88|M<d3M+drPlHH+|*hd-oCK;6&KwCR$O?=nY$#;jVMe4
zFVVu5BwXODJYA4p7w}VEl$P30Hd+FBVP;Wx;$2EQ5oil{!&Xh{xBt#`f3KZd9LZI{
zkN34F`oWQ$A;FFF`aayX<5u)^r_&y`r0ndDk?npT#cKD)(hIehznEqAjXLlXdTmmX
zk2SsNaC`8i<>RP?-D6282NrOxs%5%zJ43Oc)lVnu|Kawi|4F&fWle*g02b%y?~-tl
zYK79&j-5?6jRzZQg(g#bagAhTJ!E8i7%td_YcFzYHoRZPAhqAl^<NF>8gbj$fqp~J
zO`IGboCqBeZ1}o!N>H0y8hZVZ?{McO{S*`Kb?L<n?1JolxU0o+DI03=KLK7rw^x+Y
zVxoc|ZbsXH{rIAq*z10s9B-_1w1rQG^ZBWDCvh5HF0`**C_ADrHpuRX9@Y;36p?XS
zuv2}7GsP~Y0eR|6urC~b-*IBf7+9b;@Is%0QyKJ|b&FA=yG8W6sv`L(aK&qFG%909
zBsH{(E{f`)8WLlSvA6+a@e_<iT<#2yN{)p)bu8L&(%Xj9CVG)odx=$(-jqEUN>=F<
zcE0FurMKy}$76w$pi;%k{pl+eejRMWky@Q~$6f<fgO2%4J+AdqUS#KYDrrTxygfpr
z*K5ZW_e$K~bl@Zx=XN+_F2>s|+Q{C78f0l`C+vaR`t*|x@-nse?Gad!@{y&JFxp!g
z3;C;duzS~wPh)MIn3x}_^?7iQg>JEQM#jO4^FYARGFrlGssY`WJW0prp}vS&+<HC|
zuziJPob0v-VP{6?k#~%~UK{?uUS@J1pxmgGq2a=7iarD08dTmEoFLIoISxq(uOFlJ
zc#jCTGLEAc$#T%9r&MOps0nuf459%q2-3}pw-8Uad^9_r;k5bxx4Iy~jn_FyMnNCp
z1_gMqdUM5wu$)4g3ldf}2~xDOCbCtKDXTr0=SdB_b_<{G-_tv{^rAv)|4}K6`3s&j
z7Ia7I^u$z}OO7S86im_jcmzgm@r`_xWD{l^-SMDX8ebkCW{D3w(}cEnf>ypJw*d$B
zgodo;>2BIYa4gbwlt8=sz47#(M+t0cl40k}BVb8&5SkA~5AwoX+&RJwt%7~^#FU#$
z2_B<z4aJ^^mjpTRg}HW=KWiAD(B4>XzL9h_u`Grj8UE_z@?PCkdUZ0{k16foZ&St_
z(w%J=W$e0ikR@kL*4l@XZq#lBOu@Ri+BXSfWe?jh7of)p(tN<ZlUSP%Z({)7^%?ny
zk&b79s_j|Lb>J^wsr6GXJ-0mPw^w)zp{?=X6waLiZH>P`c0!kb_eJQ)LMFTunwW2V
zjA`5zxkSc^nsQb`JH%0$NvW0Q7qdK)7%#<NBx>WQ`0=(;ir$P_Xn(HA37XwB$#aka
zFS*Z~@XFaoJv!V8Prr1^VZUs^%6js0PH$W9`M$nhdoLUI_6Y3~Xus4(=Q?=r2)aJk
zN9Wr5+CsICyZaoMWUMVD^9U^?q%^$jBTD)f<{V$Gyp8bcJPEIvDJvYg*Lk@OoYMnY
z?^V1@Y&)b#XC6p=nm;MmJvks^x6*P3=YW+pS6a^q{QDU9Z@(h(Jv{ZHhj8SUi(lhA
zU4*$jL!H##NDsgBAhevkY~n8uWx>|wiNOL_B%CdJu8`&}686Yxsyi-6!h(GVq=D^@
z4Rf$E@qLE}`wq`rnjI&s_FC+HCqv__g{_&gLDFpnXQ<AQg=Pan46gL*39!gdhg;_|
zRF4sLTLqT^A-UDMt$J5>bvEwznW}Zof=kb30G*4;c-O~;JFWQLiIWZLPtakc0B=KJ
zR^h&v-kB+h#fBE6l!o5TtG-;J6VpMBN6wZ*zpB_JS$j>+;eP02xjpXP<?AX?Ug+Vq
z*q2MJs@AEO?k<0*g7g5|yoqCkX(##Q;wi9CNh{gTt%Xa*=^UA2(oNL)WqUQP4C?nF
zt)5($({Pq~7c83WFcyB}y17#1C)h+&O7m~qdX*axWFfbpC-}h_SPSfgH3wO8?7GJ8
ztt52wMfsvu=gd%bkL`n`%%tH&G|(BUDoI=06P-x13v3{I`VFcLgiwzVXI8IgXs&my
znDpJ@J;1eW6fV?f^}Y@Z_m>7l%-Wxf<L*JlO}RZo7QPen4OzWzky6Fo4?~yzlW|Jy
z`*>&hC8VcTC}9$A!oD<sSN{^JUK-4oJwwO5v&FQvID<*xIsO_veM80G8#!j=QZS<$
z-$f4-W>k;j)-Y4*d7Z~oEpRoqswGVQFSkt^n94Dxwo^??N$)yVsU?;Czb=VN6|R8O
z$Mkp|Uu&bX$Mp@pkJ^(x?i)IBojx_G7?O@e>-%F~!c+-K^3=p02X<)oh~YO=X)oan
z#w=bTYHHvw3Gk7b6czEl2%Sp+x5i1)e7rD7Zo22dET=$`uRBs}tLL|NNY+l$p&}o}
z>&=mzb)CH#kclhCiCDQS#^H9FoK;OPdR2_0_b@Ormiup@T^{@i`5=L7eX+xQv9nij
z6CTQp5H=f57fbp{y3L!VAF3m9Or^z-y)Q-SbqS>>g0VNezlcIUNKjmGNYQCjBh)t(
z^zI&(KR9%p@}n=VU&1cO9c~kDva0la^_X{36!um__~U(AjcWOx!Q)=4LksW0ood*u
zh7?P;pz^AyGdOh8yC4cl6S;*ZW3}i8uZM-r-6DNOoS2qfgWsty;rB6b;maK3|9<@5
zPvAFvY>9HF;2n!+=I%PnsR-*GzR+&coq^!c$L*fZqp%0YzVs5cPFt6?ab4_)*Mna+
z2o+?Z-qzcBkxr(5;P{mzPyB&nCt6c7&b&vl_#J^89Y1g!51Dt{FWnP1?6!y9DD&bC
zBr(2*^JDGp?j-NSjo9W~34e>Fd4e=u6b4v5gI(b%M-=7$5&0B1?wL`{0BcZUucX9Y
zffX#)H^iTJQ0inp2D#{uHza3O3P0zxYR20uhToioZNxp8F{g0<gjqHcPjvO*{aLz=
zLOQx_H&A%a_$2lz<&Z^aZ@uk&r9C|2LFGid8k*^zp$@NSAiwcuvEKGu#N}KQXB!yV
zI0<nbh|B#_Twdcy@gLSGH|Dg`*g#&Rdai=9DYW`ZCZ8*;f$GO95}xp&PSRCmtL09k
zld_oLOoQ$Gjx~nU*vntVneu6(fu5mfytGal_U%HSohO|n!cKZeTo!P{;g2^MHvgtN
zS*lT5aK$1Qfa{5B*)t#1!gP&k;@&lB)k+FI$0*rT3Y{rB)|;SLhfRS?sq1yREqK^>
zxGmHfSsoFKYq#+B;_ksy?KZb`@F*-at-V4et<?7L1^i{Z)Uq1;>F=*8CDGo7cG`cO
zK0HMpQjnZNp*?sL8M|xnJw=-9!5q+TlA!1Q)4x^nSV!`2m8`=}I*oo)Ym7Hs!tH~$
zi)ds01pdOVGJ<ptCaPx@<NwZ!x&oIEv#1pqi*>M<p_j=?Uc4#v!LYVn>Ys?VrP8&+
z!;zEkkf?;l{S0lCaJ%8)c=EHW_1?>>T^_9sZ}Qisem9BsMo-|@3+*kcf~k8xMb}Ky
zKiwgv{i5;;q&`;r8kH#Ey<FT9tS4L9-%Zl$KuZH=Sl5}+*EH+jRB8t<jO=R9P`aKW
zvL)0~DQ^oW*ONqB`1y;7^vehMU%2CvkPs!!YaZ_<AxgSe#U@U`>%2C<VqYTQ?_Jsa
zMSSnOVW^4kfzk_!lJGY2T9YKmxqKYVA-sLRHfcF!RYwUjD6CD1V+l*%8k2e_2(&Wn
zZ`3@f&=c291^SP`K2rM|HI;}-dB3233f9I|o6XR%XGm#$HOF7L@gK!00khmWfqI2{
z8n52_@%L@~u)rh^jeD5Xj}*K3%B?By`fKUC`+wyB1bd(E{-(DLkkZLMy1Re(+ui+p
zx^(XD{ukah%16VBo_VXHXXdze<Nd<B=yeR|&n^iwFZ2p{5qRl&vG3J+zOL^6D!f66
zU$lU)0jDUP5N(C*AgJ$8D<SIJn7z}j@VlPA@(sK@(T1IBA@r2=6}Dtax-GfVxET~5
zyt=1d=OznmeuJF*)3~4C4B`H4?mvpW(s8PT`lK6g_bIn<y76istv5NP58<>euS>_@
zcuT(UX5xPrLR+^eKiP_4-0_yO?KM`vfo@&$Tc~Ye!+UtinPhYPrAEnn33tzYM><3F
z*E5dvac$%~{QXxIgQnNe%Uev<!*N-U8(|8Sa4yA9Aw978lU~C~EI5+BFgPSOeOzsL
z9=UNZKsoDs`ikcW(z`5;tIp%~RIE|^rs_CmlR(=`dz9NKRnTiuTiu*C==N{iwaLAp
z$L0ghe3k<jpFR8!{4MG~RkY!rT{muy@03gW#)1nk<@qLIhFD>D*WG{LtLQzPrNec?
zfOjz{ZIVwbd-Ruio~N&Ly_Pm5E<XfIT&`Q>a?K>nuV6y2Oz9VNNF8)XkLYiCIEU+Y
zF<zD3{VU$t){*I?+Zf&bEAbarV-xt_1>k*&)N*%!^V{A1JKt7%U-`>4iqt_Ni~Aq&
z$7_shOVmAvEtaqDF(}rDvlZ$+n|GWdZ^5rvFHOR%AEDxk`LDk2tk_pi0)5-OgehKC
z5Nn-}J8bU&_&5kPw98E1-=;PMVy^~hOxyThIO~kS;-xzf3mpLlu8sJ6L(HAu_(30h
z{OpnJi~_Oz4xDiJj<p72dphFvPvbnw9LX#89C<JzOux{Z7kToXZAbQB&Wo&7{oCGo
z@`$eF7w>F)M_87*HNWz=WaXuBl32w%_!~n<0x|m$VW*NG7zFY{f!OkQ);I#O74PVr
z_)A!^CEbZTE^5wK1F+?W9@$K{L_pi%yEu=e6OK+Ly_4F?ocZ#8&SR*xLPcgXowWsG
zKkU$f&v%9cv6kbPa6V6EEbd=}b02#cIujaW=SKWB2Ilg4pX<w+iCzdJjK8dwcj+hS
zg@KpJ1}xHtvVJL4W^T!^2;mf#>eS{X_3Puf?`Xedh1MInU77D2eyjBQ324FDU=Qr=
z*kI9Yx!5vU*xFE?xyMm#*jv$8D?PD!gM|F|uE!mg%p*7S2~*Lt&<KG?pSEBYjTSTa
z+>5kGvvnC#SMt<LklLJ*8aKpF3sZ&qOq^moGLgB^7u1Tz@pZsrIh}%?gVrf8@-BL0
zPY3D$i%VJ^t(T4aF2WY|-_D+&k9PVac#k0Sg`?r_Sny2NzTZ2#W9QF&wm9RS;P(Tu
zgKr07;{YE3=63~RdjTz7iyXLHfIj(E_5W_}-Q%LX?)>q2<_-+-fH$J10^Sj$f|zVK
zZ3aQZW$+f0cx|5%%>#1*MNQM)q>dr6X}^=M+|;6`bJJ*o{pz;aU%PGE;iAblq#G4Y
z(<Utf8XN{3<ks!Bulc?|=b2#!HEnnQ`Xw*M=Q+>0e$MBd^Esbuv^68q5<y^^nw?kA
zA*z_n@+`w+_H3SP{R#C>!nFRHo9>|w4`*$HMjQ3+5Uh(7b8K&M2HUSBcz+I=jTEU0
zrP!LY1zvQyht9&^@AKI|>`Pe$i3}_joBHg1$>5g$yDO1B>)<u>%-h{}Pq+X*$oY=-
zC;KR#SiuL|#j>}k2dnQkHqq=E5clfYsJK__dGv8yZkyb1r9Q&jR?|Q%`nb>i9Q4V8
z)+R(;65is9g<o-o*nN|WZiciPN$afK72Nv>W@$IR;}=ld{T6WjtqR}l3>wA%77|qU
z1@XDNl81lHE+nxQvX30s`<C>O!?=n3WzXG>Es&K@Hf>^@8^TM{J_M|p1b5NwgJ*;@
zrT+QG;Mj|{gL%r1*i2bq^)XrCyT|mtkcXYOr-8mW?jSvo<6e4txlb!l4Ya!Kw7OcL
zdof;0X3Bk^D~#PUxuDG$*^?QK`4RO9eSl`&Yw)EiGub7HrnIuLv(w79`>+#$r!CET
z0qttge}MO@FOfc;d#L@496SEX!I_W`NI4&$%IuO^WU_I3E7VSb1Gei}?Q<3p^k@gc
zznJ?JgU}+gcHnIJw<OMlz3Kg(_$^|;Yu=}nG6##I=6#8Ap*d)1QEPcowsJx63=?Tr
z&5$&HG)2<hOMRd<KwJh`Xye=|9*>O?{SEPazwnz>?(2W0+&$mGyM*12IHe@NpZpGd
zu9D6m)*iko7b`4852*MVC5R}{udqbtl4J%!(1Ws+*JnZQV)6Lysbl<`;{I><w4D;_
z^<Qs0oa@1Dhrdej3inHDJNykZ3IA59h<j`I8M3ThHrjtJsiXBLYPuYV#3zt`oH-RS
zR?E8t7ioz}_os<vzPOaND_nyGk(X?4f$i_9(7VHz(6d1P_Msi|`_jA}D=+7M#Njk3
z_HArUG(FR*H9gyk9-xQ$jX`*!&@C<O)Hf<Qweo_ftRNnPq+^>pTF`hw)F?p@9Sf(c
zU=_A*Qr^*(HMxh=qx5~KJ{r|QP*(>7WyfW%RCqfv^crqw^fDTQwWiC4)s+kQ>Dz)E
z7grT4z*8cua1^kKm9*Zz^LQN7e&bU$?BD)bl4kCop!G)e#oqpe?P%0aY80(bFbvx)
zJ3T8sO3~)glq<|{tw^ji+_Cg$4j?+o%!ANE@QB}CkvU-S|67hMW%10HMBcRIgLSQX
zhf=u#e2A<`5uX+kU9J?n95zI`Ac@)&GZC>9+>#GaTjO+_BZxIj(FwcYH&yyh^{s0~
zyvGkBHDb46G&8{nF;rY6@o$HInvz#QR<L+PhLtSm3*cKo-%jHQ;e*Kux-xu!CfGUw
z*YN$C@Q>XcL-)5d6My&rFZZ{odppKp#~9@B>quN`3v>`Hp%{Y)K}mAZrI7T^op^)n
z#2S9v*!WLT-;ROHH@RHzk;<PJ^(@-R+tYL5m58{n5>Jib>kK^JcwRgh#S6bI9t?5m
ziECXAUM}(9E~8ZS-7qH~d@ZEDJzY`WA}$^{FG}ykN#{nTFQIhyM(GNiZd5`_m)=-9
z_>@vQJS7h(*xOI1N4N-K*bp?xr!uv49+>s^bS3PJTg1$Pa0)n}XifUY(nD`QoldPq
z(!*~^M{7~(p|_t-CukrYX9}JHi|{kSBK+(Oq!h|32qIL&PZ>{}dZn)@VGyP?3BIt*
z4RbhHqzD#!7BOqqu~<M-9!q1`Ix#Zxh&<05c*_O-5_5aMr5|@QlF6Ey!RLs<Nt@d1
z4Xk&y154u4*XCP%@mu5;DPo*$NXsI|g>&1GSGG&LPx6elW2_P!h@b^_kBpXK7R4dU
zX~~xw@hIR&$cl&-=`oBqKzaTg8jD1Qvr^!#G=(g)CHrTJ1C|cHDYZ=04QUR+Yme35
zH-C{MaDr(OHTA_?=Hl%Di%QZ2jTDNP(d3(+0m&bGnv@~QLa84%c6JBNk`$Esu0<X>
z&Sfd4Y7B5FJ1xv3rgo+AS$wuYLWXwRPP(<35Ibf_8}XdX?k4Dun`*cFf)=~)*>v>C
zor=2czNgZqG13UA*W{t&$=TFn`c8XtzLaCUo^OrUvk~<mvb1>(i+#0>L1N`t1$@bp
zKFPds$dD!#yt`SN`u-90@3+`@yDtaYoYVt8L+U}eq%QQnW6Z+FPZ2Z`)6&F2bCmei
za_E{!vt1VQw9^c_Qc8jKI^@36^X>_05j=yAmP_*aQ9AU7s}y=%lHL`pZW-<n{@_gU
z8|aP+4BSZEK=^T&nN~8YteL2?eYTcxFSa$NvXM3;rj?_G%G>}~qx`0lx1HwJPz;Qs
zzCRgPK~jouW_*KxFPzV<(3J&r)mw&*vAlqsOe4hH9Dr}VqBVV^p|&P^2++5#62s@f
z4V-ln_f@h^yAdd3)S}b_`w6d`=Jchmn$Nw&&#~MHymA6OUF&!I{6+!y<tE&rn!xKJ
zs+?@TBn<<J?=%H;!MfI3c=1;%*Mf_XH7Vl5pI{SbCK>l<;_gctbLFpVFHK`NUTV)h
zB)Ilosvi25Yu_dJkkPdtzdKyd<F^#|pnTUiE^WG`;a?Je)Vi^?q4h}X(bi+F(NO}V
zyJ{?JUrpyFY~^!dE5FjS5jOKr!)E@O)>R&*@>zB&OTCiH#F*cO#+bps`y%@EVeQ37
zXf>PX-L<(>8Aoj9Y(4u|iD>l{sd;K>K6W1$+){L+8-TswhEKC}&U8|Is!avk^`|b%
z`R(G~78%NHY$Z$mXInS5E*Qt{>Y)R!lj6JL-ZuA;%~gNVjhG<~_<h-R1i#g;qxgNr
zb?jp4&_}Q!v-s0+3#rd(hv$V{+|`dQZvtnRaPWQ@P|RWG^`dw7?s?G1&<S%ksf486
zGlUtt6NInw3wCD-OLs32{voO_hhZBe`Ff$bs0OC<uobFC{gKs3saz;kI9)xozs1OY
zcd*~&3AO3Xozn=Pq}pmi<)kPgtM3YLIqt?{4a?0_A(gs}6XG{%oSA1kE$#g9frHap
zXtehUzZDvl0m3nO6f)1=9UjX+Vk{2{doUJw+T5KBYaY(DMzZl{ckb$;^PWEyHTksG
zWL|JmPgdXE(XyH4nno*RJl6nnrCQJVs)yFK@qskUg`tPRLyN88DwT-LZ2!^|<K;_R
z{(+TWF`@ilP+o5R131oW`r;;h`31h%Fjtoe61a<LVOvX9@;^(O!s>~S%6-8j)kFPQ
z-}bX<;XdzdiQFxTMvK7oFxzoeA)iPzQ_<hFz*v5E47<68ztN5)t$WfsBaZ{oB?#A5
zvkA-WY~G{4*;r~2+<@fS2aqpRqqOH(tA~E$65KM2rJplb^g~N4s@|G=ddV<g9QItr
zYG{SPPdAkSgj5Du$~R!q#G9IY@RS=$RUq}n<TPmJN2kh>dMFvOjVGjPk!ntkgZG5>
z9y;|Ie+D(f({##n$&tGvjqV2G;058SLhqhZA!)NxFZ8Xe@5&e#l|0Fiw$nIm43E}`
zfeVk;$X7<5W`NxVaVAG#yH|_fuX&|fH#Ir}KL7<!JmJ&|i?4`9q1u$4%g#S)!|I!d
zHXMPk<Np6-QYri~u-gvOsrHx0I72BsIM6pQ{KIS6>5ll`flWxGb6k@6usb9429tqP
zg%1-~J95U;H~6}qO+BJDSUU83oLJv-B|_7xD#wLb$>a$lmUoM|PnX#H$wJx!Pd7N(
z#`(oz{z|Y+H=w+pa0DER@}}FmJ39XbQ8%Fan0zx*{Q|sQ+fW{U0^DKwkj;I^WDiL}
zgkg#=KJlx9eSJy%b{^GWgO9ivgWxH=aZ*Hxq<krDTVs5&&0ToI)<W+$a7wPap?B(h
z@*<s2-yB&NVOve)!admmO(6rM;_7Rf>w<fZsG*pHy$c8uOg1C=$mB3DTHH*fNF*F0
z6;K;1$6kR4%A2AV5Iwp;eMEB<W46{{4@FFsl>akZ3k?l9gSNEW{jL1u(=cKaIZmtZ
z>kK@^wA!``%6<C5hlOV;DrksK`nfxm=@c)^<Y5PFfNn9UAm%3-^hayy5Io}Vn+;uC
zyIVa6*x}YxC@q!&6)!#O@XT3x#B)07R_sfJrnuy9+2D_f$}O|f4QF8-jhV2c^{&Mw
z8=O2FK0RDYL}jV8Dl7OT(mbPQRYh!)0zQvp*jrqMg2gbUazyvhzM)y<4M;wOf}l*E
z9$)`h2RKLUEXveOmj=Ch$;Ite8%u{~y3|XtZd_VkxmQ+}z*4Y+keVl19`&YfQW)<*
zgG<HBmTH$W4kn||s9mC%X@^sR6WZXS8%952;sglV`;+E+0}d8fKqrm8Qoh1+2e~bT
zABH=!ly?|bpvGeIiY~$37MK!(JkKC62WB^6T^w$WK>J?!(KyLc<b_29!7$v^6&28L
zu3%8pRg}^B$hdVBFE5qp!cHN28opL);JrB0_jCsHsS<*^reZCxs#?oR$5#|$Poz9w
zf=3ouSyWKWcFdtQlg*=43w_U;P=~f+G3r>%>PV=V54~E+XLTmL%KY_u5+>9WQxSuD
zr1?)ooOt-NXZ(r6hokRfwC8a9VvHP<QIe;mxBKVaeZNuCfS7l;4cb*wD&791y*0ch
zlq5@I`|J7887TlR7T<FWmq>mjxWd><&@LT%5!5$y3oYb{&**RjUTWEa-*2@{=Z%hx
ztx7=wO$vpX<1@_kZKWf_oB=7aVhg;v(ONg}7+ce-WHif;u?pH@*xZyNej#Z<!b@v8
z{O)*_meQdtZ|P7rcHV<&q;K>G+;LunPaM)U;!M>;2Da;SgZjqmp~YVME%*)fR0dr`
z6>gwvGri5bYlTN6^1*X3jeZ68`-iCgxyGeor!3(%deM>_dK0K`p*@_=d~=_Lu(1U`
z#$0w#fO}f#&P8{$uof_#1V`s+@mr7<JwIVshsPR@+i3CS0UHE1rcB>g7;R9HMihd;
zeh;!=8utO_|A+8Q(kDO4sCT-7(#?%$bEStz4dT@c@R-Cj2k_(_It*`?k{$uAU+Ozi
zk{AaYE724<1*7<H>};#B50J$KagW2+68Dc`8}pKsl1^)93b1xJeC>xJAxrtE+3@*?
zwIWN&m`i??N{7DUExBEa$PN+6FucWR|1g^%SCB@(0{cCfMzE*5ax{DiG80Fh6gBb)
z<%+TxJ2&{s38G^ov-pxrzBk=S^Q>pLel7Oh6E4~f4=sPH=P!mN?348V65gN7-rG|;
zv=>m?;4181>!av4@T}6)<fjou>LfagC^y0f+GXW?<%k$a)<xt!1Sz3YoyJP|mob;T
zM@8^Y>Wv-NJ~THHCX$~Ws*fW1?S(Yj;-V8`x68`#F9C3sc6VBXa`@a-Nc($nq&11>
zjk6PNJqV*71YHSxr7!;jyb7(}?G6R@DM#Rq(2Q?~^c<MM*62jc+XIM1=%_FxaSi}8
z8OH%*{m4aQe+fHHJ7Al&$OgaPAKp<`G!57XN{0e1Gv-wfz3!?W`XQoUGK~~V^^gZM
zZad-lv>K5ZS>#`H^$;S|3<}3NgX4F|-=YI`YH`J|v!{CKHTKPhFYPVR`+@BN(VX|<
zIcCM7um;Ny!3SBeNWO(LZ4fXkj-T`;_s2dh7nEBcViZhxjM5BBJLMj>Q{Fp6oM{>6
z>m!HK+TNepKVz-}_@lD6_r2ZU)Q4I2j@N)Svj<+q?6A`qufxI7EPLUrs91p=axZqr
z44k%fGAS*Qb16E4>qL8v2%H}UoQccR1PGJ8)ZW>TfR=$A1FIM^C+M{L=1P1DX>2dK
z)LS3M*iXL9nRoi<;AR|~nT%g$W(<BcnTgQNvCV~cValqxF&N?DkQNl}FA?}+zM;!+
z0sq_X6OKb;AE&&%52^4|cK8HWWjg^4{3;tX+Hu;MxFX3fnGNx}rIpMLN<NweM70N<
zOImGaZqRakor!7w;CVM}g(ZF;`Je;^DRTP{kxz6#>f9e|hHgJQ89HIJkXYGtXLojg
zA7phYE9Vg|lI_8qO#-tsR581sNX%gyY%cVzVeAe2IH10BgY_qZ<`&U1AaQQE!QY%v
zRIbdjo%Z|wYpuoa_mh>r{t~so4Zb+8S1bdcOyVj@<9HF=4B5Elk;1sMDga*7PMn`q
zG7V>)-lf0DGz6d}fYJFizz;+J_m;05<_#<6!m|NnWjF=)b3)o;yaCF1t3otqcE^WL
z;>LG+Y^Nj(4tk?{Njv|Yp7pQ@Ckq33Ab`*B{Jz(HE9jKA!h7*auA;5)0(|((;7vg`
z>dyJF|I2)ITXX*xZBaWmv_q|}1;zzI!IF=;d)xfafpDwsumyEMpOD5)F`Hw?EkIDl
z?1h|;>9&~D26rB36b7DX#u$IlOm-Ksf)X|@GSeg@iy>h0LUJb2B58x9DM#{Ef=C*$
zOnO7F9#AfA&@f(Z-Gp+`oEfiW<yZmsG~z>Q7`;KIBz>i?WrcZyw6@6JnYg%;w|MX9
zE60Cnc6ge=>61ZM?VF6pNxh2BtC-D2e`6H5EwBmq6~M-%hF#=lw;UFw6w#U5k^x_$
z>maIG9kQ=}9a?Z9yK1JJ0{iAua@^?J`wV@sj#<=tw~^U}-@7+P;-1N?rU;Q}JDKp|
zNYSU`GHkd-6E&F$KDx}RV?Guq#(1N1abmwL{wZ^8@L`HpUH=a0qAp#&FF}A#gvmf&
znju?~;U>5+PR`5skxl9{#Eg|}qoVr9;4w!8WT9CRG|_#|0KXk7)STj;zO;$#q7X5S
zLxh0D1=N0ct~ir+wu^L|SsRis?Fhv(aWBQ_z#;S?nx}4V>)oHY&iP@l-V(M7BP(UA
zBHTAdSK&@K7xhZoX3?{G|I91d>`JAnY$OgrG_(k7!k7@1H|1aE%TiS1aFN>fi0R?B
zL)bzQeIWht#WN}jc-N?}(0iKTi?_+AZ&R3nL)h&k*xuKNzpD=J{yI|5Kd^6U;lAC2
z<%)aZkiw(<rF+I!X`S`J@_z?hS$)?h)JJhpCqmicmt#eJGm4gzaHb6OchCaAq#+3I
zY}7}2`6c_?*{olGtHzLy0`jN+5Aw@c-?a-S%n^KAP3${iNHi3sw#fGt@fha(ui-{9
zpTjYn?{87souY9vd%?XpiBb>PZ{V39`_kr9-}RLXs%;{jeCF4d+lIpNvy_m!%Tk)>
zZ-EUSJw37DX~^H{sd4@~MA%t_C)NC7Z~!Rn{QT9SeAx?fL;3z?{^R^V!itoi|5zy3
z(EMzar2N_ikA!mh<}c(IAlKvtb3?g)Fh4bv>(cxgp;{kWFqNNzT$ks=(<`gNHa|X;
z>-v0(<wLd3UZCLR$aQl9o?&E`LxaTGOu;Pt+c<XzcKYx|M|2VGDtK$5I|k8dv`<TC
zf)49~JQLFDB%4s|j*PcLGZE6`#mOZjO<d@4Bel#itUR_JI<&U;Ph?TcX@kd3P<q<n
z%wsiOwkEDicFf{e%?)Yw`Yrz71Z3D>!g*`DB+r$(pr}b(g-#G~!QnB$+^6ePgC3Bc
zIv?$4WpZ)<vLONwB(+T2EjO?ezMN1SPURPmzdm5?@-pg8ik%XQxoplIeC@c6v;n#V
zoPd(Ni^}AJ#*<lWt<nikxek~~3x`fg`feMpKRz~|B6)ou=c7VHuc=RUmGU{@6@_R|
z+uNkyDl4=1N#2Xn0<Rq3mQ~ZG>`392wW*Do1)Q}Sb{vo*fXf9L{)9JWo#ZQ2S#0Q4
zURBlR_1=uqMMFDm7gL$5hlSt9m`jIW9Jg(CjQqS&VWOVsFH%15h>g);!tnbNEjE(h
z=p89LF0b@{3g7V;xzNAJTj?F~|Df|zStX^@*ANY1*26Ck(M0vj_w)$Rt)TRqr8zs6
zU(Wsr<*Zs|Cp?601dbU9$E*)49fQiKciZ6P5~VVceV17?Oq)oKYF<66Eml@8gEoV#
zf-9l8t%c?pyM&fZbB(LCCC0q7C7#`Ul?+pBT~l4nEwA4puAR>RCD)M_!eE_07y1!@
z+@<qRc74`zttGSf2{H4|-If8@f3$qk65OT5z3vIoe><(>k(LhzvR&=|H(EY&9TUIZ
z@?X1bC{MXx9~f%+sD-aw2CV42<L_<n<0~e&eAuTii-#m`PYYqbZNG=z!n`A!8WrY0
zf|rdEn9O5$K-ZsIEKA`Q(z|zL8^PG}uu9faIHWTWM3{z@MXNeHB#U}498nsSDuT$*
zl5&nNugN|<BkFEQbTwp8psVMJ4~|Cj^iA1GvV*$cwl<8Dt3|GeqCw0TXQoH$dvI-}
z)fKiG)78!KRr<){uH-hA16TeFW8&m?rbb!NO8dULL#>SYSaVH#on*vO`?G|TBfF1p
zT+S8k0j>W>tQny#2&&vxHHbazzp;PMTqsLPc|3gHU@VulAH{a$i!bwY_bLV96nxee
z{WEWTb;sV9#8l&sS6|qx5H{g?y7A>#h0`xo4$w|eS+z8GkY9VFQ|92d9TV%9zux;5
zQP!MTX6gM)r|_n{<n=ydvn(K29DMZ~`{tqK3!w8h?MpM-eyF~x>7e&Nirm*z#K}uj
zcIhmdqlsmxwfu9x?hfiL{L1H@Z>kSJCN947XG5o#E9l8rf7HK3Su8J^%O4EYm1;cr
zYU&&6t1s+3CUV>UC=NfWxjbvv%<;NzMb}l6BF0l)&0Hbsy4=4+Tg;W5gm!YLhck3y
z#HIc}8I^0e65-VYV>1@T)^l@&me`{)HQK{{U8>TsU5Mbx^}Otn1(MaWz?U>KtK$;4
z=CnA_|EI-VMUU8i=i&JWx6Uvg-13ldyLg4+FHwkRMlFpe#m^wE-T~Y19of%ciZ|C^
z+I{Ke<tlT-rOIEQ8EyKlgO^u$;8Q1m?q9@%Td%yAB6JKn@(9!OhxlUDV%VAO$!WM*
z(_Pl|{<;0{?a03R-t+IZtdN<@KJ0j}tX;`Z#Y%oy-0MZ_C~I4ZvSySmLfPW{tXHtF
zSi1_|KGXD>xcSn`tpD%QmP@W2nW>=tCzlF7Kxyzm{~|v7UcBjHah*5Dw1Iyr^WfHW
z_%Exvxbd!+dcw~6wiQ3Ub?b)@i$mV7M~A%~cRTZX9)0KYTj%y=k052#i+q*(k>MZo
zcMI-AzdrQgH@tFqt*>f3xMjAm@vhV>>JjzlU2)UJ)9BAn(UX6_)N$9b(vxGodHU^*
zSwBO{&*`RZ)x!(gS!hpgza%rQZeRU@od1is={+UurOveWeI>LSl+g0~zaNBU`I3HL
z*bkn}#CLG8gK>Bg<_4`?F+3O+#qDkKDU4h}Q?JbYXccD|G(O5!4)yEw=qv8TZJdEK
z$}D(pB`6k->~qIim*{tA!y{ciR?}_pO*%Nsq@JI^|8`B6#UIlFO&LR6hxW?jytY2h
z9NX}M|D>3VyH}zq6MA;qh7E0N^*@AEmahfoD6L(xz$AGh&)3H^(37?2LYI<vxVd5n
zaPhmoKN;g{H51--(2bCp*S7C&Q#B~-nRE?yi_V4G2JD@;xf1O)Ek#!9Q}q4P81Von
z?H7_=8;wMdy%nQ5PJ0Kq^n<dhn2*&RI@)*3)D7k_zTmK^K_q~879PgVXU>T5N$Bnn
ziBEAh@M4S8qu6^k@NUa2;||Z+z&Be;@%v9LJ3UIv*}y-y;Jkze!qV9|JsVY9GmU4V
zfqypeTm1dE3$4MHlcdV$GG_7ey$_GqKxO}_g=mmS9SNa2V#n*C@&{Qw;&T~zhAkgv
zu81?A4IBVvbry0A>An+|ZOS|uj9c_VFV4dvmq!a8<S%l54xf_Nu0i(!lOHp*zO~Dv
zM=Uy9NwCBKU%eMvZ+K?mOMYv*M`==27W@3Sn-B|NeXI5nm#67YJaiL!AC+=CJy+Z+
z(=T$0eP>`_e9lL@Gw2svFG9tk;r~9>?t5m15-W^iq#PRFdeP;%>|Tm9?*~Pce?4It
z$;A=#1r}x_-ZykPg*O$3Yd5{voxH$^w}27&&Sd|kh)Knv?5w%f!?qKuZ8MCQ-LJS$
zi^>j##on*F_NyFwzxrC0`?rst7ftX7r@4A1TcQA+gDHmJuQ1%vLN`N#9KnrdinG}J
zk^pB&UADxtQ<!?9TS{%_b~=vT7$lGS=Q1Ml*wNBSJCZLa5p4o4gWabev>(?G>WU%1
z>o|D4%&qD;DZap{I{lyxUu4A^maav5YG7wus!>+9U5xMA=8oIK8DmX!M#+m_61RSk
zU`h?Z$_Kwitufu}TyYJ$BdLMn*4X;^qg(;ue9Z1H;~rjH^{6p5pi*jNN-m*8?+Djp
z=sPK{%-h<|>S@zbJ#Bg?YG{)oj@U`@=^n2$49l9X%RPsNPk6YZ)PVhB5PX+X{{XCS
zs7-2(V{0s-wy5_%jgRp$RV%1P1+|!X^^01J`I{}?8b16tT1;duPCA-glXN&1R7=FJ
zGGE-~l3NdgW+r}b-lDI-b4j{O>B@6y7>01rl%bWo3<hZ0eI>mtI;4fWOVPW{Y_-sw
zuexz)cxLk~K4zcvJ?*~lw}$!VL_T((gbl(-52Lzrp$qa~)&)b*yaqNz^Hhi?!v5pW
zK+FL^w*o6|4Ky#USYx+76aVk86Rqbj)n0n)QfeUIjfgAt8}YQt{WN}8yPvtFYEU0x
zGka8p(T4Z#$+c7JrXG&H5;RTU1#P4&o5XhCw3_L=V#$*z)@qZlsjmsv`Dl-=wbJ2F
zPsU!c53HDnm2pyKTH{|v+GrO2$gvZrM?EJG6unqPw%7AAPl`|GLqpp&+}8EzhPF-6
zI(srd4euju&$PwXznpbae6~%F_4-2F^tQ*_*0t@(mM=|TrZauBZARNy+Say*_h9OC
zWVa3Lyz4!?%h7I``pQ9ybyT40P}RPXt+{Hy{gQ|^>ic$H67)5)mMO2C6k~2wk6Bv8
z{1|9!RF8d+Xa<Y%F3(n*rZz3TdaMfExBS~yU-j4qZ|U&1V?0($d^*<ZG1ZnBBcj<I
zmCDS7h7`?;s!j*33rqi7(5b($Y&IXRVJ*1Vf4z=_XjiHOHL}~!sv8`jP(5a7j%eb`
zc7^v<y(gnwDL#f6mz1CO)>L!y?YUhmJ-={nZLapDp{&JE`nz9ib|WUdz5g!;iU{=v
z-sIT9{=3MI-H*QM@y%ukj(<IX9ffvi`daOPwn@h;j?}=nn_qQkIu1EvIu@jpkJ?8c
zzwA_))b+nw@iV7k06WNlET!ek;l79WwdBygmS7yD+zq}*f9EvZA(#ctPOKISbQ$j7
z4f#+ho$+_hZnXWRQ{6yino)wRGR|da>$T|Rtn`>#MHx7@<D6OP<cklLk1?tnG)Ji9
z4QMR|*bJ%bH4U-~dRF8_cGU1$t?=Y~ydK$7{0}cer#!bj@jebzC+aZA`)tdBQN^$O
zfC;}lJ$kV<b{=tyHFHjno^Cxo`gyB-t}Nxp|2Xm7rjq%v!4O7-<91M3ZkMAq-^CT{
zq0QO-<;eYk$y)qg%z|#4O3Wax4fL92gM3J@nS2KMGrq)pUa!oY&i*}@IhFnUgGI^g
z-(O}Vuz!zb#<G94nM6qh7b@6W5I(acxnU5Tht#d$6A8fXK1m+XX|VfJ;SY(W`K7e5
z5A;ZC7*4@5onMx6H8T<1dBlbDg=@a|JLwru%t5q_<j;)yc9r%BvoP}7aq#*5v8=xz
zhte#^VbcvRJ=Glq4?Mz0y}$h72bACUKPdkK^2RTs9(~Nlq+!pWW_AwE!U*r}#l$gu
zoOxr62Oe-{ssEpb`v2nJ-M$UDVL)^~seOWoZDc1>!oAQ1QXbHY2(0bB5m?&5`!Mt+
zPpFF^850_jRQqnE+&ij!>yzfe20Qx5+(=`yjS#%<FFzh<4*j1=wq2E2FKZD?2xrrb
zU5|+e%$a?sN6X(695!$@4B&d59yPs(lsAd@R^fjtQ@;IfKv)%H{N5_aO}6D5wc87Y
z)1yUiKEdwzpi;i@u3pmZZO!IqWzd~IoG&c1JJDFvt@ngwb|)l05$LU&?h^9hhCQ7t
zvVdbhiASHAG%skOFYp$FT~gnwAz59h)?XWcJuMucE-E$&D7K*4R$+5>5`}GYj5r!U
z7_j*Dr(}r!bRH*y?3x=lOn<-Q?zFk>K8r6V-7&1K1W(bLIwD(R8=i^Ss<z>jO89X>
zTyVa^HmoxpD9<R%^r!e~&WM|o+#BC5JDl0e?Y0f32%1#+Zf{_^pxE6x_>f>vMjy)z
zy(*H%fLA&57?aDDd52}k{?W~KrFyxQ$Wflz3mER^gcvE`$ed$yyJVM_xgXlaw4KTv
zBMVqck~;-6rYOtomDR|a<rB(=+8EJ=+Hj2U$CjauuP#gVDjt|~@_5daV=-MxZbf<W
zQq<f+aBYVjCWG08c*HVy;VoH9?rIv<Jv<t4_#~O5W2B&wWBFD-FrRKbAK$pa&6RVv
zin20&dT-tXb8j5ay{U2Yt$ers67>#r)B}3=^iAq9(dl-w<ZIM_MtS`Y%)9+_$}5cM
z8|};2Bhsk;5C4{g+}JUg^$p_O{`o|WTT%9xuJ0~q784flaOZf6&QE)-?Y)Bp*Gm6{
zc(;y`S3;2k93!ut=yun1b+*0yz<l=ce1}imWcjKen6G|3-?0<l={n@L{goNod~5Sx
zg;8qYWq09CTTAXL8m)ce+MO_msew}D6k1kNPOQcWt9&FZDRzvkqm^scLwA&N=RGiY
z^el#EDX<wb|35Q%yP=<7j5@4{g>#brB@RdZqn~uW^Lgi~pw-{+xWsIvD)b{AZ`40Z
zIVd&`N$`W^nFH^1c`rH%ZWZkz9RZb8+lc2R!$_-R<P6n|@*llXzx*BCaJ-1Z(~h`0
zY+kHQ_sn1Py!-_7;%H;@a$mmac`0*$r%Pz5r}5xaP%T1x;L5)klGuBpMO@zH9MR@e
zI?*fIrSaXR$A#Y_{}-&a$+$OczJ>gZ?o0+p|4s65^Lr}sVEm^N5_Hi*kyHY5{Cifx
zi=h>TKCwNQ@)q`-xodD)Ki9YBK1n0EceZzquR><q!+L}=LsFTQ4=fXnA<}B2me%(y
z7&3VD?}eiZN%o{~`FEO@2}|Zw_b)aA&$h#Bz7clb+Z86Q5jNf1<t8PxcfVAW*S|^h
z_+IhJ%$(_TPIZ5haBx^w@m}A5baDG}1FC5E{isK2lp~4@w@)p|GvUz^94_77+r}+f
z@LS35)FemHd%)FgBfSjhyO=E`88CTrc8mZLH}!8>{Ox_4{HV{8?6dn+vp3{ClWo0O
z*bQ0?`NQ(~(vt^Ik{+?&XY6V2>^j+YGWBFnPIKowo!`9m^v%Ls`B~tXn_}mh`-0u`
zKd-xSp{Kfkr%4W;bMlhtdt%UJ@TYDgKbxJPGr_&g-hY#Hk!&ZS=R)UssMkSItQMbT
zz|#M+sF?TK%3gy7<>Kg$3tCM$-jvg6*ncx<cEHEJ<V{CE@*-0A--M<M>TBxb7Quo5
zdM0)s?xa2{$IdUvK<eNN!s4%Msf7+`6*M#GTaaeC*x+ySl@9&Voi%q7_|<XyByHDu
zclWp_^T|kw9Z#up$MH!>i5XAX>y|?|O>lo}xi<6Rt-Mgu{qR%q0#S{ry?_chEO~u^
z2l{00BG}HvQ<&a40LyQppYCRI=42KHNxoQaj%QEFixp-qdz!ttxUZzoJGLXcESo6O
zJW--YgQY=OVWkeon{e8H_{#Fs;Y3sJhc!2CO|*K#yI$=08L}P{rUdkBb(Z8ShIEHW
zb0`6MpCnsw@Vg~CDp;oTLzYCRKfB+x_X?+o<4Nyc?1i14W{=)A9jA0E_?&Yyf_pjB
zY~et8o|x&&ypwlFC6FA@GSELD=UaW8;JvsS)&la~ys^^5)9sLH4DnS@nmJ*W*>=i?
zH1g}CzX*P6C;~5V7B~~)E3i3y2z46z(U0ybk7Ym!{X#?EmA0p5f8?=&)~C0U*#jO;
z#R0Q_z%ZbAzNv4f@kwaTU-sy*`)I2!n(~GB_REEW{gJdMO<xu+?#~uh?_VYq<h2$B
zvAR@SCh_v;HO6=MFBHDIf4=a3-mlhZdG7fy8Gp1tU0A+96)7ES3<L77O%Z;PqnOJT
zqo;i~>zX|Bs1&pYi<^A^>e<!y5PH?rr?sBzt74i@slBT(_g}$ZHp79C?Dy{&<1<lX
zTsJ$xqp3V#*4;7Ou~jI(0ba<!WaBD$l^eu3{TQdx_@wEpk6bi8&a)9!`r!*KN06D`
z-;Z&9Lu>5K`(Ul%j{NJ3koJrHF+BH;c}Tm)($bLjV`!jprYY&Fc{Xb<8<T>k8G<$)
zankP_o0iYbqZyF2?KmE~e=LS_2$z6eD$-OhCr&?BTcIaMU6*r{cAk0X>;v{Y_P(n<
z>3)UrA8uXx5IS{`9Ul4+`K=^3K>m_fmS5;OP5xLa{`(eL;k^6#t#;%CC-!tZ@-glx
zWGN>q2iybax^as{Um$z=l)h~o5~vPHQ8Y(h?|zLuhFCwoS>0cA3;EE}Yag^hR)U=D
zyvoli?<#wXdN!%26g@I_YJY{6P+!@vqVN)XDZG0uF3A6L5qK0^9yS)_53{GKc=EHS
z1im2uQ#{3PNkG~a_N2kn`|Jt)2zVPMOIt}xiP|@hS=|cgI4i1hphcNv)YAEGN(Xmk
zeNS-A;E{B|R<id$j1}RXt4cRADge1;@P;VmpIMXy&4o$uXFMrXhaAyUsE&=HI?~w*
z^#}HzPa0;x#;|OY>Tr#kTnn})8fAcqi8xbi%|}Nknk|rjANu+wYPD?j=oEO8A*t!q
zg@VKHK$=B)H8^&_aY1YmZ`_?};0jfY`wXqgJ;AZBd-dLog3qJm?&0>?nlDT7Gfs_J
zcRlW!>SNl!Q%@!La^1pd<<$%D+M+zt1h3Ere+%?Nb+tmvdFWLq%vrM85kTA|$UY5y
zj(`*?0dqgj>5lMbz{g{}8Ez=WFo<3g_l$$QQ-u@vNgn>?O!>U3p4$g~@FL)IQ4q8O
z#$+y7t`8`Stv%kigYZB59AZ@{ueN~8UgMCJ_lQk*cHGe#<0~!weRs~}*zcUXGw9`r
zBWOV>LqS$y&yBaxdrMbVlYgauh4H2r9B=O`N3d$CQ0sVz?SWd$>%I-%1*BPOvHMDW
zMZ}G<6y#71H8&kiq_txocw|8JhztCFW&QX1-zJUrP>u^d&hZ?-e?)nN^8C90lf~bk
zCM%0c+b({4WsD)N)&@TiwibdLN-`=Z%rlEXi0Vumnrt}FpaZI+Y@Haf9+Q;?;BB{a
znskl@O}pUz!QeL_Ub*%WZ$O=C&olV7+h#CMk~9M+V8_ygn3gGXBx!>qFp17|)5?IX
zsHB@(%Y{@wIQDb*DPFmC`h6vBff=Eaw!qX-N$q&a6obS49l}Jm7r4j%!?V=d4vkZO
z|5uD>@;)uOi2lWXEkOYH>;#9o+)sSe6RItHs3wbXNNF(fXY#Jxm(Li=w>^}PH#~!U
z??X})yZtGtHfxh_O(<6p%XKEtI5gAnen~FBa`BnGKeN32c;3fCd6$Rs9vspdJ}p^<
zTJPSIb9N}_tnr+a4R=eXB4;mhDz{IP>I9ZZQMcy}t%DSYMHaQ3$#X&{qPK)$Hq$dA
zzL7**fkJ|}Ld9(P-b6vN%Ek;KCKqR6KIPaxXzfy1)CAAao5oT-c9_XTDR1fUiQ_zG
zGXXPVJFeOmYqWM%kA37OSUNF_<UI&0inU90WUvCe%y7K<q*&J8?gN!#E^p7zw)T|0
z4LZfr1YQNG;V+2iR@3e93|gA}Z8@*^LzkHOP!FPQl(bqV-h_sK9=Zw9o#|Y+?Y{oT
zp})d$)mBMj(u`S`dMZVNkMi5bxcK(l7;6FX>Cd|)f9L<XEX;>bpt%7bKGvvYvB8=#
z<A8um;-W{blU-q%2Ej6jeH5HQzqUi>=1DSHZt0!0)X<A|3UfNaZ9k>H_A;Wg(JuP3
z7=wQsmZ<Auub|cMSC3V=0dt@FDo<^HU$sSNtRCCw)HG<1#4t&~4XoA>hq^X79ksKS
zT|M?A=(+9`clMs^s~+3ig8CY`;vd3mhU7sIZ5LIK)j`*JXK!Vno#lB5vV(mtvDc0`
zJhU_Lpkd=eeC?35X*j$y5cT?}Wf2dO56+)9EDP-<$Pde;|6CT4p2)^wL^L}=MSW%7
z=*&V{nck_ctMJ(Z4>JmudaAhsNe24*WUmG3NlY3rb>R*tL5rlD4NEi<ypEH!giqJh
z0anLVTjGq`T6Kd2r?g?6;Unh19=!b8*gCFghc8VC_bUQ7@`4tI$v!66COAABg2Pj6
zRpySvp_rY%5;Ucf@B}axDK`;*#&LK=+S`kHBA8Dahk0zME#}?DVnn}bT}cq1#D^h$
zZ?2SZE(T|=K)#zR{QB5KQQ84voWxl>kWrSx^!n(G#SVT4ktnWfKc=(xfZ5`owOEH(
zpEM^spq=w7q(YA(g6lADaN0$R^2gZypzE%zDA~V|r+ZyE?d7{lq|M@W+nDtOO3y6h
z%&*>1Urph)4Xpg)@w`KnH)cZlbof+B_P^Q%|FlfTL~y<TjB+@eon21!&T?>A(kci;
zGn`i!f}j@C7%5+hfjl=uhFR}*DgmML#hUtNrz-T+;#9LIb)9Yzhx7QP7<*Y(zOHS3
z+lIE7%WA~7jpJ=>%|S<g3C?U#hPX?5f56Aq%3PVdl}2q{W*N6gS4Qjdut;*`txJMc
zLFkTXjH`Di2{H9GH%M<p!>f<HD_*|It+5QOYg1p3tyS!ScgicjGpcLj4lB$-(24)*
zFf1pkfFx-fyfO7blX{y;SPmIl)-ucOZ$UnmnO>R8nM!>N2pid6O?xw>8QAFv?<LHE
zzkY@j6wi_Fnn@X-i8ZI`Nft;_YBIKqwJv&to_`=&sZ_~Q9$E4&hu&oIJ(RAkQ_Uu*
z?ike-Nu19eqspQnW^;C5tnpp3=9Ip1Cr*Cy^HJ<Od~yB7&%`~agNUiM;dBs@aGvuf
zKvQSEJ6NR<s@%c78sVh4-V?+fWdnY3`}4jlt~(Xk4Z?hfU^(<xZ|6aq|J!{;Il%u9
zqlma-<=zn^SCvU4Hg$s64IS7r$sYzZJ@>E?n+}WKVNaumm+xWw74mr+v2H4^Bq<{~
zhJMmGI!(LB3ma{!>#*24a;C9=n!L&pko+0lTYK)H%o4C(#*PO+PkUyvQq&IB9QMs5
zwM26ApH8RzvLWnu<8SaQWj)BN_Dp$TSuc77oEgteWf$`?Uyz%6dv9(7uMYJqJmPS_
z?yZ}866u#3-v4s=*icLNmc6$nDm#tW?MWSE8bpZJK>dz}!Ni_X?UA-p@WxfdGwXP%
zd<f2nmH~*BQI8LcVK_^(+=TiixNG)EGw&UqLo<&k3Uua5ezB<ElqNxtN>a}#h5Qdt
zt&!OP<S+^;=V6h0xR{UI^Z59@NOebQmRjQ`w07q2s+-0uwJ(k3`~+AL*8RBA#>el;
z4Yhs$xWc1|jEiREi^fG`36JZG+otFRk@~0?p2n4Y!k#?Vi_Ve%O)nxiB|-Fydhz24
z5Rg_-IPV2ff>ku{FiPhLdckX4fTP7ZoC4}Co=N26Ycn!r*aIjs_^fnrjF?OwCt6Xk
zocP0gLYByx@P0+PrY?+GaKLIHeyF7xCr4&~_*`A}xa8r`w);26Q+#}FknO{YEx3IM
z(*3qxV+$lw8>D^0cw^Lp?n<}~?DW0^8SoOzzB@-=%cZl6B2pCIAntSZ3AHSdooN<-
z;n>WggpSD-hsEUnce+SlIpIhm;uM@mAHT9hR~KJ@uzRPuxH~nF=bgDw>MeG1oKWX7
zVnEMmjwr8akH$(ADBz)D&`1rq9hCRRu%x?HgW6U-9$%}d$~NliNDn79u*+TQQyX>l
zva-~`bDmOP9B$FjaB@K_$CcNcB66EjL~tj%rc<kojx6jv8~DCUhZeSGQ|%nItf`;p
zGIXqcZiF|Gt{<gvg`g~M+x8q7Qyb&!6kBHq@e~D@SsSZ*kjqImq>aefsf2o+R4ZpX
z3*Rnh17CA+Mfmk5^YMojrZv3@BrQa4=?ud&>(AN1td_HZFSSJLN`>`s&^n`Q_`3Pz
z#{|B`3}n?H%~mhhwaxJeqT70Mwu`U#Uu}85C9CDfEt?%LiRvTIw(6i$N}jNk^{NKV
zQPT5y-1{IMm>@h<;m&&}HSqIRqL}7DyX^$sfS_v$3HNPv$MWUY9>HBBCaNsH_ZT(*
zvn8DYZ3ZZ=2=1Uan%XaCR5^ZGbQyf_4PNM8!^_*Z^QIW`yf)91c~gqM@723199z6R
zJln4EYU(M+pWVt1Df*pnc^D#LnrDBA=GkN1j+~#mwCr|}Hj)z3@sXL;SM$U&UR{5{
zq&M4rwT{<8!JI_i7d_u|lzJs^ZK%~!;RWs*XiP5;YKv>StX-=|UhxQSPyUX6PWYGZ
z7rgYXWk^?C-gVrecjbW_v&o?>+9ZvlTDF1SRd}y}KOXWXDD~)%3_o*6boXc-g-0+g
zG=fP+8tbR-O%7=cxg(_OB;9d1i@HMvS%>-x@#oZ6^`@A5jag>3_i5|xOS$fnUfHN@
zX%Kd*3f!=yc4;M)FRnqf%a1}&vXo6()W*-<nj<yh@@4QIw2a_+Qq+%ZY$S*j-jKK?
zdT_l9Z^#(Oq!Ze-t8P4*p9IY@eRD*UCyK82W0pfc?Pwp;LTfno8mQ_nsy$52+WYRI
z-A71Uk2H*Ek0PINhuz>5b~qgBngbTiwLK2|?Wz@|+i4isF21=ksl;(=PfN`8Gv0rN
z9}1!qtv=#a?(#kd&Qclv%DsCX7Qe)s6^jYKWF{$MULDQtI87b7ok(=D5s;>yNL1ib
z^axa8AW6-^hyN!_y#Zy$1;=ON`qK*YtD?pKvTu&S6~$ZDU;00Oi?0COtrB)KSbB-t
zsPTs9HKJ*H;WXf2Ify-kT2b+P;1l*;;Q#uInj@{Z*9qIj^DYL3r38iZ?jSh!-_A7{
zu(JK?4(1_X9Eu!nWiN&><^?*vP_G2XJ-oCN(G3}MkA3sUS)ewV?aqTofBuwIUK;&p
z;yTc<YY_iC@3!2y?ouJv%y(~JGp^z_4L`g+e_<8#{_$M8`Ur8y+nG$`>*IIT@Tenq
z5E>QL?+lGwQ%B{jxMi$sn*r~4@2#4$#!HZ4WBcgh`{R&{Xr)O#bYkrg<di(_ujS+&
zsEY9q*$kJT6!&-(rW)K23bNzT0!dcZd$sj)Mun9xu5=`tJ_EFQv(>lOi(Z}9)(^Ta
zV@)V>B9ypn*H~%N4*qiDM+9{VpAB?ZWcw&#wB}m;^}mJF&iiospaYQ|+;JW7&0s!Y
ztzGe5MAfqlyd>7N>aJgLD1pE2unpqCn}5}N2sr#2{=Va_b2Qza?Sr-;(qHcr4Rq_0
znSbQn@0H_5v5qv3CtySb>YrhJ1obdZYwBp%=nUv)e<o_{&*L8SdvFbcRWVm%rJ6hk
zOm3VT!4izSKjzxsuK8eSwZzmq0<+SkH8X2`%}|ulPnJ3Yl26oVyo+ckz9gQPxMveq
z#7SBaZE?^UjJ@u@{XABMxN>f>;8tJX-SRrGJ)#3v!=f5kt-0@(92vi+A%^j~ouOW8
z8q}AA`yVmBpZnuAbW&=rt80Tr>MMwQZ=#s@YzHurlz2|IXL(6?VUO^({;g79qVTGy
zI|6TB>_)2<A{Ym&gzIWvU8|`x`96W)Bu$5=A&%N)wRp1I#%syz(_$1KwM5FQpqc$<
z{uJzF=i6eB;D%enL9!N$`*2KMsqb}0jYh*PF|^X-jNy3=uLW4nUy-x3ARe51CHj|w
zGe?87mG026da!Qrs;|+Su5rk%1>QZU6((85y=#O{2wEQ&UutM|3}Pob?;<^AMNZOD
zz9#W-40M(6md@BQ{qjTbaQ4%sGSieR{1v`7qnxjQj5t_qh2URyBTu|ay0LsM^dgEN
z1L#&D9@W%^30G`R9@O6Cj`dEhvM6iPl}QZ>;M?t6L?uoltg|Lxfp7i+P>CgzE0TSX
zvr86lOd2CFkFh!F)LJU^dt?<3+FNkb-PS1SfkBJ3(FSjNpnkyDq2BZL$w##+I{QFf
z))V!Xyd<#>+(l^FS$z7D<n+XP@D0Eh*N?E9nWZ_j&*(>#uvsDcT0b%^T|Y7<b&r$w
zF354MO(+?kk$8lIt>m^h=#)ntZ>Y9tj6CDHG>3M8TBjZyP}rR=s&U$i?U2#1DA^NM
zt!yN`)5%7d%pX0NY2X{?@iChg80(xGGg<5tH$QEjwjx*p8FRmV;2iBrmaEOc69co7
zsPy-D4#$P;Bsz!H#?vT8d2Wno4F*Q-dxvN63AG9J2P$o5zt7@Nx-zw6uT%0G_*8T3
zk(h?KI^EH;x5~S;^}$`YyC4&+^!sYMX6{m6xzODPS<cSv@~#77S<cxm!1ag<TI%qD
z4LGk^np8KrzSN&COl?T$(9E?#YTYA#cn33aC*fn7qiB4dC~>(Fg4N{OB;fMox+JoD
z{et|o{-rU^3{m21^_nfo!t+k@+K`a3#`#RP;whz&TC}EF7*_J6O)8j5`YM{0e1&rs
z@~mmDaHdMLXtDboRZkiDdT_#US1w<ytBtEmZYb$K*BzTx>YGeFzzO~641{Ty&H&Sv
zuyCU~!|(azBa`Rdo7Wqd99p&BKq5P#xzWjn_jzrt!Y3P^cHbHg*DP_b(nh6w0$)#i
z-FI_>lai0}_0f2oh+9eWl4(~eobWAOY4Q1igNgNrvNktQYdD>?r8$X>aZPgqzuB31
zBp+IH|It-UUyuHivnR{?d0}@ka#63npz;J4alYoK$JNKw>KbB?Oy5=5bGEB3+uHS=
zoB3Hk5eX9tyU*Q9J_5P=m6)y%y8J%XmBiYbZf%|V%4R3ukZ{D>Lo<^$N?PW`&p(&(
zeP>d`RO}(kmQ1QsEz)Og%UX&5HT<M{`97sFKMS>D4X*l+dtn#Z$A9Ylt&?ia1(s8d
z(K+Ryfxb9ra)Wkzl&2$b^oeGg2xVgwl*x<!S638Iif(~QM5x4fSx<}@AN3@O?e&D!
zg|`lkq_`4~D(*}X`Z^P?B;ZU*v>5sluI_en)(XU5&d)jrdc<b<qrs460iAfbIf+jM
zXLC}I!Jp8v+nH#Qav^HN@^7+vd)>E=%}w;GiJYA4Frx`a*JLG<JjG)18G%{nLwAIP
z2IclNBcGi}UN}vO-G;so@mC4@d7YE9tU+(I=}EMP7-koK{#>?}PokSDdw(vwu!k!?
zH1a}A676Fwt>h-&;io0>>MpVSE?>MeyQEv^CQ2_F{)uega{{8Y*PhErsQXO(eD$)m
ziCgt=a>fKx5GyfUV`2B9(T%P+?3U}C3f8A7=?X~i!{1BjyF0fNyGL*ACPXQ=%F49-
zXaOPtSvg*2oxX`PK2#RY9i}-WGlee}=jhB(Pm=1wIi=ngcE@c}|4ME`q_$1CX$Xo<
zn?&+DqXO3<u`c<exUE{_XtC(Cb|zm<CJRV^atG2ISlUhWsc*sd$yepZ1r^EH74Vll
z?P$<+>rum<DSu_3OKzBQWHQ^innRd8wRTc^q-TZQw}#ibWR`>u`4-+7ECLphtz&<}
zwHQ7c(<oQMmFW39G`!6fEK9s1?SRwMzYXYbUaU$_s3q^G$cxzpFN9L+RK+@Ar53oC
z(4a7=OLTr+e_}@hox8X*A|{8~20v1SA%tJ@HLA6i0n44l>j@tx!#XLi@5{nul$?SS
zyt2o7^W(0wpR=A+1W5wD#@_dK&L^L*9`Rg)uh_mPw?doSxEdZecHu4I>JHKFTL|m7
z1%$KkK|+`f|AfGzL{QZeF)4x3ZZ}4yn^I~(<9q^`0K1ffvJKM&^t~UkFDnwRtM~-K
ze%9x7#w222MXEXRDnGuq5<6n~nAC&@tOe7Qn-ARrRWOin4dbc*izq(1ta$4-y_+*`
zF<~v5U9efU^nbqE-j}m><<_KYgtfWwHp4h(QKvw{HH;>-v&X_h?oDUH5e5az4PczK
zGoYu=grm5vUsqOqEz2WnKE8$3sRG^f+eQBhj1QWA2pxseRq%$lwS=&KT#CU}B(7@r
z8+s>7ZPUhNp%WaX%}F<Y2)#9ul^9k?l9CU7D$j;y=v6?v5F<>wQsabm1@@7$Y<3H}
zZzqZDnv>Y7O@p^$Y1Q)ela8KeJW@r@MJC;goDRzL3eXBxADyHzq0?oHbJ~`_d6tby
z(m8mWt-mNP8J8J`*KMRX2@MR_EooyCBsV*gfORZtcGL{qyNl<NuVw5w?5xB&{?!#S
zQ(?2g$rTxzOZkNQYG1xkh`o<1Dx3g`d+SLH;oH;B+fI4W$~&u!G+yXBrSlD+u)RNb
z?EX{e0jCOPOX?5ZzP}5*^TOs5^robF=6z$o=R6vd&KABNQaVPFR62<&U)xMxA;P;@
z7;g8L4MTxApFDOC4jL1-{rt5j?&^#)j!v(6=x_pPc+!cGYAT0SlxwuS1%EF2R(O2@
z7M8>RgzC{Ke+fI7kNEP;ux2FFNrd&SH5t04S6qXxGFN;5nH5d9$wt`U|6#w)b)n^e
z)za_wbHYxsz-1%LlV0lt&eXjliC_S}Sd73IikLz$RDxn3WKtGIPDI0Coab3?zfGLQ
zpb0tx>^4Yzry7y&=XBqYqT%X6-z?9r5er!aAZTzyW?rw^fOuO$3q=F6!!}%<uC6Uj
z{}*@!CC<TGZ={DO8ZCZWjbtsXF)G=5IT)I!8WECHHcuNJWO-%rZS<<@Q!14W_B*nQ
z8gbxJx`Bl6VjH|`L%DFK_;}0rd|bN1wAb-8_*0v`Tf7Hwvh4L%frC-u*uXfSTAZ0{
zywLBOUCDYD)*zK=&x2#oeISgoILF}q<H!XDu?Ak^J5n1{(#OkL>^@$KYJuG0a?MfY
zq?@B5W4w>7#1qDijzo(q<onwK3r5JhH*WMM7-_6ZMmHQV+xyZHHIU$&pA}p5bcpk*
zOW%h(<u#0l`WUn}qh0A95`pf$*4XbjDDMsQi)LTNZ$u1Cg=wEx;@?G6Ly<egMph=#
z3ahYC{S}T7_3Nz>HK7@*0d%-8??p7+FqAg{*12pS+Y5M0w;(z0zfVozeMjr)%@s4O
zKOrt(XcZW4-x43&j97yG?{wQv?KtH;r4+TooXw>@N@2=ol_)nlyWww#Zk@mqMb5qB
zj*LMmop{*yF0k0xkadhl(~j7nlCB8w9h5iKM7U0v{)!`UTLGOSrq{CdgDFLbztt%7
z%`h$JzhbIzJQ+2ze*kVwGKEtpg4-I*RrZ7wxfT5OYx9vaE|Ok>wCfKe?aA>p1uLz&
zn#|9RY9*YiVOU6aWrZ1Kuc{ceO!hnNIrim}B|}#rrKqOsrugtKc;?7H*X=za9AD;W
z?^9G{4#>+N8PGfutS}64c#=Qz%QfwN1uJge5<YoB{N^p;4X#LzsH93m_oDR<RfEF3
zA**RQ!!s+*4r#{=BaV~sG|?j*?>wPc(kjZz<@|eMYWXbq<Ma62`(x(L?Fm}!x8u@v
zn`4Zrh4$NOK4=J9n-Bqbz$hzEt&q>|rg?+qEZx5!-bLm7{c&@TiI?G(O4)&u+fWj^
z`bu!+IYa6`pHXI2UL%fGsyC)s@6N?;K>LuY{s2}o>FP{fsIA{2sxMdHPBs$n^Px5R
z(^}|dq9^_B{_1`uxN&dh$CT(#(b(13Yr$<Ldd!AXK$WhpE9naYf7SQhkRu!-f`^)6
zlcG`{z>2`_{9Fc7>(vd4N?8THD{>_MlkHT|=9j%{<6eh!>nJck!Rt3i-u323`4v&`
zkC~V7nNjac&GY#=QSS@Pv-p`&@2Tc#{N$+j6muf4i+bnH8eX|sGv2-yIHlyny?F}0
zVx?2BaLDXZ00JrLT-9S%^0&I!$_Z1fG%5w)6m1E8X!tlHl#qtXq2YgSiO4C!XGVAp
zo*td=$|yTMy4uAgQ*1@ctFWHBmy+*qXcB9LH{l^|x1g-DLBrO`>mdDF`@u;u!Mq!q
zF<ZgOMeLTgJjcei^^PL&a~m$c47tFOi?2G4UOePDcJXV=H{f*n{>3d9>8vTj^VW--
z9NRAL;9nBq&E<mxNZsO18(Q-nnaiF+9Jr0GxsIn>seiOi3UBCL&#*TcqT$h-6gy8g
zYG7}hLf=S2qjzm)ZvuE?^tL7R4N;%*wl(wyZzy=%7J8FnBy4Y80$wC~0}m4GFsjXt
zr`l2jD;>|`H_x$&MLV0i@Lh2;lOM2?bQ#4~*mAMJvHfBaMxqFfBoQNFeTR=pJyv!u
zV%F?!+t@}jMe^W6QpISQBI2?}MLu<oyq^bM{S}||U@z@~HPmNs2G-$kBmOqwZ`)@L
z-QW>k%=<lTj4qzRAN1<;$VbrX4>v}h;6;ei3O?)@e+t<t?0w(3Njx)ZK-77%v9S9{
zFQ4`boGHbg9GPYR%|lcZyz;Q8A;(J6k@w`}XYIdf?RxFQ*FKQ!YtU<Uo}rvUW|n$u
zK@WH1Zy)|%z~76XHIPLZIG^ibePy{=idKWBaBFtN8<m+C3|U&v;E(zf*8ia#u;Uqp
zb+X^S%zDG-MoJk^eJrrUOU(0L%0clR>Dv>ynVt>QP#R)9zILMKhRs7MwV@O{OQCXm
zL*;g(oZvni*d2P`cl>PNu!GVpzGt$|1~y{FO<hQP73npd4LnQv(4S3>X9N4;2c2eK
zU2_)EMN}-dXxKLb!SiL2B=K7xrxJ8dpAGP?jB@JlW8{gZ82y4joFBQg9cSS^R&!0+
z0S<BZ*}xu``YLL7#o+gOS0d8`B+kx6>NXvk;IxlLb6_2i$ic52_Cs4>)}olYLU=Ie
zwjLAZ=DKcW$Ma4LWP>s3hjH#tU0CJR<1R-jlXz9FAzK<3))i<L@;o3L&C8N)Pz#h#
zqOz(o)OEB=CY7kR>Q8Y-rAcKu)*H>m&^9Fdtv%p(6_<feR(%{+V81KrJcD=}ng+~%
zfp%%lO}w>g>tee0+$?Rh_LTlMqA^+62@C)QPIw?$CK1#MJAo5OCCrd+ABl|HEqz-s
z)Z{ud)J{BaOFH&;f=C8>MNmeL;_^=Fk$Y^nd%=+1MYbH!__1nutQVIOk_8>b9LJqx
c{+9_V8y{CfwkO}#EW9%<vQH*2k+J{&AA0NMNB{r;

literal 0
HcmV?d00001

-- 
2.48.1


