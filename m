Return-Path: <linux-wireless+bounces-92-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5D37F9902
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 07:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCFC1C2085A
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Nov 2023 06:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0F76AAB;
	Mon, 27 Nov 2023 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxZ2S+sr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D6E1
	for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 22:01:32 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so5091593a12.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Nov 2023 22:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701064891; x=1701669691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rf5Ib6Ar6FTQr3DYg2s73uc6qo51FpsHtIaCq4ypng0=;
        b=jxZ2S+sra3GTIkJ5DkWaND0laWUArMPJlGCXqfvyu7hxiLAm4mtBfNQMI+g1VlfYwg
         IlRILEdYnlV0HqcjrPuSB4gX0Ty8bDvySpd+yZ2KR7i6QpQXvN62Nh93SxKO3roQg5C7
         UpsBhz3xuXZWDu7g32UMUIAtZpkBeg7qsy1lkT+BqU3jahA6pnFeDEbAnRhWJaqYp8o4
         TuhEjlc/M7fYyP0PFPrH+i6Uf8Y6F5+et2cmXLcfqdCTDoJf3ljyeQtJWZCENkAeXUFT
         XW4A+26UYy8t7326S4v7GoOMaR/SnSY/Aku8HJZiQN88dLzF+ttx6yrH4x7z7Gmxai0v
         5ogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701064891; x=1701669691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rf5Ib6Ar6FTQr3DYg2s73uc6qo51FpsHtIaCq4ypng0=;
        b=BA3gnDOxKBsA6mir01Nn7NNVNtLc/B/0Rxbj3BlM8BbjnaGIcXwWhzwIusgrrzrpPy
         hrO7/Z7cPSOxWfC9pUCPd7oJ7mAMTlzZ9lf1lyn2t0+yl/Bl7+T8R0JFkdMta5JiK9zK
         bKqSWZ2MLwuCJHsOeBpFsvKAHEiTPe/2vsIq9jUM/qp+LJLRc2n0btfFz2jizq7GQ9Ad
         bUN1JDtUnIvLaVsOuHJXlcWTYGOXZrThIAD1Y0F5zFjyRBPyG+UkVsfGiAD0PzyLdbpk
         AdSiatMYP08kkER2AScZoqJ/nlOGhaTc71YIPq9UgXzLUI8qf509pQRpg6GONT0Aek/a
         k65Q==
X-Gm-Message-State: AOJu0Yz1hiUCDb83UtPH/PGSb6wKHG0JMi5Ihb4vMr3WOl5JOtuMgk0N
	N06L2rYWi7zKSqGTGsnHpgzvfGoRsdJIYP1R7Xtc+Ey+
X-Google-Smtp-Source: AGHT+IGwgAKF5pYh3k/6beoY05z0QNRrkdV3ZnE9VSO0BDX/KdgZAPI5+5F0ukG1tXNP4qqfyYSrd6Ch5cTOj2KRq1I=
X-Received: by 2002:a17:906:cc2:b0:a0f:cc19:e579 with SMTP id
 l2-20020a1709060cc200b00a0fcc19e579mr863084ejh.1.1701064890762; Sun, 26 Nov
 2023 22:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com> <5abfc98859504795b50f7f343784c886@realtek.com>
In-Reply-To: <5abfc98859504795b50f7f343784c886@realtek.com>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Mon, 27 Nov 2023 08:01:18 +0200
Message-ID: <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
Subject: Re: Lenovo LOQ rtw_8852be
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

$ lspci -tv
-[0000:00]-+-00.0  Intel Corporation Device a715
           +-01.0-[01-05]--+-00.0  NVIDIA Corporation Device 28e0
           |               \-00.1  NVIDIA Corporation Device 22be
           +-02.0  Intel Corporation Device a7a8
           +-04.0  Intel Corporation Device a71d
           +-06.0-[06]----00.0  Micron Technology Inc Device 5411
           +-06.2-[07]----00.0  MAXIO Technology (Hangzhou) Ltd. NVMe
SSD Controller MAP1202
           +-0a.0  Intel Corporation Device a77d
           +-14.0  Intel Corporation Alder Lake PCH USB 3.2 xHCI Host Contr=
oller
           +-14.2  Intel Corporation Alder Lake PCH Shared SRAM
           +-15.0  Intel Corporation Alder Lake PCH Serial IO I2C Controlle=
r #0
           +-16.0  Intel Corporation Alder Lake PCH HECI Controller
           +-19.0  Intel Corporation Alder Lake-P Serial IO I2C Controller =
#0
           +-1c.0-[08]----00.0  Realtek Semiconductor Co., Ltd.
RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
           +-1c.5-[09]----00.0  Realtek Semiconductor Co., Ltd. Device b852
           +-1f.0  Intel Corporation Device 519d
           +-1f.3  Intel Corporation Device 51ca
           +-1f.4  Intel Corporation Alder Lake PCH-P SMBus Host Controller
           \-1f.5  Intel Corporation Alder Lake-P PCH SPI Controller


$ sudo lspci -s 09:00.0 -xxxx
09:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
00: ec 10 52 b8 03 00 10 00 00 00 80 02 10 00 00 00
10: 01 30 00 00 00 00 00 00 04 00 10 52 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 53 48
30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
40: 01 50 c3 c9 08 00 00 00 00 00 00 00 00 00 00 00
50: 05 70 80 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 10 00 02 00 81 8d 90 15 30 20 10 00 11 6c 47 00
80: 43 01 11 10 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 10 08 0c 00 00 04 00 00 02 00 00 00
a0: 02 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Dr. Ali J. Ghandour
Associate Researcher, GEOspatial Artificial Intelligence (GEOAI) group
National Remote Sensing Center =E2=80=93 CNRS
Beirut, Lebanon



Phone: +961 (4)409845
Email: aghandour@cnrs.edu.lb - LinkedIn - GoogleScholar


On Mon, Nov 27, 2023 at 3:43=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
>
>
> > -----Original Message-----
> > From: Ali Ghandour <gandour.ali@gmail.com>
> > Sent: Sunday, November 26, 2023 5:36 AM
> > To: linux-wireless@vger.kernel.org
> > Subject: Lenovo LOQ rtw_8852be
> >
> > Hi,
> >
> > Following below thread, rtw_8852be driver fails for Lenovo LOQ:
> > https://github.com/lwfinger/rtw89/issues/235
> >
> > rtw89_8852be 0000:09:00.0: loaded firmware rtw89/rtw8852b_fw-1.bin
> > rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5 (da87cccd), cmd
> > version 0, type 5
> > rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5 (da87cccd), cmd
> > version 0, type 3
> > rtw89_8852be 0000:09:00.0: MAC has already powered on
> > rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
> > rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
> > rtw89_8852be 0000:09:00.0: failed to setup chip information
> > tw89_8852be: probe of 0000:09:00.0 failed with error -22
> >
> > I am running Ubuntu 22.04.3 and kernel 6.2.0-37-generic.
> >
>
> Not very sure why your host can't read PCI configuration space 0x719.
> Please provide your PCI host controller by 'lspci -tv'.
>
> And, I wonder if user space tool 'lspci' can dump whole PCI configuration
> space on your platform, so please provide full dump by
> 'sudo lspci -s xx:yy.zz -xxxx'
>
>   (you can get the device number followed '-s' by 'lspci', and copy the n=
umber, like)
>   03:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
>
>
> After kernel 5.18, we change to use standard pci API to read/write config=
uration
> space, so if possible please downgrade to 5.17 to see if that version wor=
ks to you.
>
> Ping-Ke
>

