Return-Path: <linux-wireless+bounces-594-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920580B94A
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 07:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EF41C20853
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Dec 2023 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C871FB9;
	Sun, 10 Dec 2023 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQbksrCV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E42102
	for <linux-wireless@vger.kernel.org>; Sat,  9 Dec 2023 22:24:26 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so382290566b.1
        for <linux-wireless@vger.kernel.org>; Sat, 09 Dec 2023 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702189465; x=1702794265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHugCs1b68jUZ50CFVJ/GyQ3cahkmq/nwNLV/Wb5LUk=;
        b=eQbksrCVW1a3HSkgQzLWH/wvGIHyRWSKcfRcZgrD5wnRkohDulADXANjaWerC1B5pY
         1ToP3uItH/bQ7lZtzHIfiXjzb8Ha6hXaxQqruQVQJNwvE7GzRkC5pbdJhOk8fLax5Ql5
         kyjuzp51yhyvOkxy1kOj7FtyGmNUcYSHf2JzSc9jTqxbH7Vjhw+j6cEJaEM3yvbeL86c
         FvMkabTUHlNFHNzgxyodXzJoOtS35yTyohNEoafYYsAIr3p2gYoKUEEuFUtpWltO1AiM
         81bUxNjlm8tsnYEMbcJE8VYc8pTepKiuosUI+Z5/t9GY6BPYkU69mOlh7o40UqdPLgqz
         RwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702189465; x=1702794265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHugCs1b68jUZ50CFVJ/GyQ3cahkmq/nwNLV/Wb5LUk=;
        b=PRQT24e+ExYYY0XIrtaA7cdlkDzm4TbggxRIiB8AKfVVAqOHtH0c1KWDTMfEgL02Xz
         BD1e/o0B38klb5eirjYFZPpYzr8Yz1fFzNDHJUOB3zOCPZ3/G5MrWIroZzvVKY24JHps
         t0947Grr3B3Vfs54uXxE0qqrOrjBghZhBf156r9gMogkoNG0YQw8jPmNHwe/N5eckSyk
         6P8fIDl95Dwo4scpNvaeD+QhMTfA3SFVeA/W6TvYpX8b6OZAfQqpcKOxVHG8nJH/nf2o
         by8FqQ6iwT5iXkaW2pHPODpayzACt07Y/nSpg5LQpUbtJLpQFKCo+MKC4xlJoUzY5C1O
         j3IA==
X-Gm-Message-State: AOJu0YzrG4lFE+AfRS72KKkDtvPO41ShNsz6aNjcrVbafag0vzW0ppsg
	gxac12Yy+DVf7aY2KXLu67HqwmXUmZwWQACu6y64CjsXZ+8D9g==
X-Google-Smtp-Source: AGHT+IG6gmerRXyMkInEZLMB0Q3VwGknyju+sERN7QZpV00QVG0hTs8S131ylhwHpaB6CMd8KgRDvQTZ4G5I5oB71Dk=
X-Received: by 2002:a17:907:3da9:b0:a18:4e1d:a360 with SMTP id
 he41-20020a1709073da900b00a184e1da360mr1149172ejc.42.1702189464698; Sat, 09
 Dec 2023 22:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com> <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com>
 <b4cfd676c0b24d98b82302aefac7f379@realtek.com> <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
 <1ad457d646ba4d9d99dc2f5cb8a1b590@realtek.com> <CAOE0c97cFjF=LGD8-nb95ihQhE0YRRqM=4PKud4nccQa06MVxw@mail.gmail.com>
 <f5e03fd6c26544b48cb493ec428338fb@realtek.com>
In-Reply-To: <f5e03fd6c26544b48cb493ec428338fb@realtek.com>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Sun, 10 Dec 2023 08:24:12 +0200
Message-ID: <CAOE0c94UMKymy8mV2unbNo9CRe9n0pUmg6dGQ-xnRRKZvMxNJA@mail.gmail.com>
Subject: Re: Lenovo LOQ rtw_8852be
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> I did trace PCI code and found pci_dev->cfg_size limit the access, so ple=
ase try
> below hack patch in driver and see pci_dev->cfg_size in your platform.
>
> @@ -2111,6 +2111,11 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_=
dev *rtwdev, bool autook_en)
>         u8 val8, bdr_ori;
>         bool l1_flag =3D false;
>         int ret =3D 0;
> +       struct rtw89_pci *rtwpci =3D (struct rtw89_pci *)rtwdev->priv;
> +       struct pci_dev *pdev =3D rtwpci->pdev;
> +
> +       printk("pdev->cfg_size=3D%d\n", pdev->cfg_size);  // in my comput=
er, this is 4096 already
> +       pdev->cfg_size =3D PCI_CFG_SPACE_EXP_SIZE; // 4096
>
>         if (chip_id !=3D RTL8852B && chip_id !=3D RTL8851B)
>                 return 0;
>

It ended up showing 4096.

ali@loq:~$ sudo dmesg | grep rtw
[    3.153827] rtw89_8852be 0000:09:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[    3.154264] rtw89_8852be 0000:09:00.0: enabling device (0000 -> 0003)
[    3.155976] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 5
[    3.155980] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 3
[    3.160040] rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
[    3.160044] rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
[    3.160046] rtw89_8852be 0000:09:00.0: failed to setup chip information
[    3.161040] rtw89_8852be: probe of 0000:09:00.0 failed with error -22
[  760.432807] rtw89_8852be 0000:09:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[  760.434865] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 5
[  760.434868] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 3
[  760.434874] rtw89_8852be 0000:09:00.0: MAC has already powered on
[  760.440601] rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
[  760.440602] rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
[  760.440603] rtw89_8852be 0000:09:00.0: failed to setup chip information
[  760.441448] rtw89_8852be: probe of 0000:09:00.0 failed with error -22
[ 1765.595921] rtw89_8852be 0000:09:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[ 1765.599918] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 5
[ 1765.599929] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 3
[ 1765.599940] rtw89_8852be 0000:09:00.0: MAC has already powered on
[ 1765.605861] rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
[ 1765.605869] rtw89_8852be 0000:09:00.0: [ERR] pcie autok fail -22
[ 1765.605874] rtw89_8852be 0000:09:00.0: failed to setup chip information
[ 1765.609552] rtw89_8852be: probe of 0000:09:00.0 failed with error -22

ali@loq:~$ sudo dmesg | grep pdev
[    2.508247] ppdev: user-space parallel port driver
[  760.440595] pdev->cfg_size=3D256
[ 1765.605839] pdev->cfg_size=3D4096


On Wed, Dec 6, 2023 at 4:41=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
>
>
> > -----Original Message-----
> > From: Ali Ghandour <gandour.ali@gmail.com>
> > Sent: Tuesday, December 5, 2023 2:13 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: linux-wireless@vger.kernel.org
> > Subject: Re: Lenovo LOQ rtw_8852be
> >
> >
> > > > > > > $ lspci -tv
> > > > > > > -[0000:00]-+-00.0  Intel Corporation Device a715
> > > > >> Can I know the type of your platoform Lenovo LOQ? Is it a regula=
r notebook computer?
> > > >
> > > > LOQ 15IRH8 - Type 82XV
> > > > I am using a dual boot with Windows and Ubuntu 22.04
> > >
> > > I still can't find information about the device a715 that I also can'=
t find
> > > this ID in kernel source code. I will dig kernel further when I have =
free time.
> >
> >
> > According to the specs:
> > 1x 13th Generation Intel Core i7-13620H Processor(Core i7-13620H)
> >
>
> I have found the ID in kernel:
>   arch/x86/events/intel/uncore_snb.c:101:#define PCI_DEVICE_ID_INTEL_RPL_=
15_IMC           0xA715
>
> But honestly I'm not familiar with PCI. I'll continue to dig to see if I =
can
> find something...
>
> >
> >
> > >
> > > >
> > > > >> The PCI EXT capabilities locate from 100h. Not sure if host cont=
roller driver limits to display them?
> > > > I did not get your question. Can you say it again please?
> > >
> > > I meant offset 100h of PCI configuration space is a standard area [1]=
.
> > >
> > > "PCI Express extends the Configuration Space to 4096 bytes per Functi=
on as compared to 256 bytes
> > > allowed by PCI Local Bus Specification. PCI Express Configuration Spa=
ce is divided into a PCI 3.0
> > > compatible region, which consists of the first 256 bytes of a Functio=
n=E2=80=99s Configuration Space, and a
> > > PCI Express Extended Configuration Space which consists of the remain=
ing Configuration Space
> > > 5 (see Figure 7-3)."
> > >
> > > I don't know why the PCI controller in your platform doesn't recogniz=
e the region,
> > > and then _possibly_ cause driver failed to access 719h.
> > >
> > >
> > > [1] https://blog.csdn.net/huangkangying/article/details/50570612
> >
> > According to the specs:
> > 2 x M.2 (PCI Express 4.0 x4) (1 free)
> > 512 GB SSD M.2 2242 PCIe 4.0 x4 - NVM Express (NVMe)
> > and I have actually inserted a second SSD myself
> >
> > Is the driver compatible with PCI 4.0?
>
> I think PCI should be backward compatible to older devices.
>
>
> I did trace PCI code and found pci_dev->cfg_size limit the access, so ple=
ase try
> below hack patch in driver and see pci_dev->cfg_size in your platform.
>
> @@ -2111,6 +2111,11 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_=
dev *rtwdev, bool autook_en)
>         u8 val8, bdr_ori;
>         bool l1_flag =3D false;
>         int ret =3D 0;
> +       struct rtw89_pci *rtwpci =3D (struct rtw89_pci *)rtwdev->priv;
> +       struct pci_dev *pdev =3D rtwpci->pdev;
> +
> +       printk("pdev->cfg_size=3D%d\n", pdev->cfg_size);  // in my comput=
er, this is 4096 already
> +       pdev->cfg_size =3D PCI_CFG_SPACE_EXP_SIZE; // 4096
>
>         if (chip_id !=3D RTL8852B && chip_id !=3D RTL8851B)
>                 return 0;
>
> Ping-Ke
>

