Return-Path: <linux-wireless+bounces-322-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7393801BA4
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 10:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B601F210AE
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129A1118C;
	Sat,  2 Dec 2023 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/g/I9MK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C700E9E
	for <linux-wireless@vger.kernel.org>; Sat,  2 Dec 2023 01:24:08 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9e1021dbd28so419341466b.3
        for <linux-wireless@vger.kernel.org>; Sat, 02 Dec 2023 01:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701509047; x=1702113847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cyRhIR0A6aTSPQR5JFcskpSPit5SlzMxXdXuH/hceE=;
        b=G/g/I9MKLSapR2AeUJ+ddEmW+QtfLnzk55PA6ZSPkt9tz6BlTmk/k2/J9hgw1GxKOO
         fy7UMDwQ0zVJNaX+O0YcZUrFbD8W2bIprTzTrMyYvGrFqqfuNmWC+lULZ9Of/VTEnu67
         yCpG3zfAOw3V38znD1xDbbLHiC2FCK/jxr2HQsd70tAH5N6u0k1zDMU5hOUYCPOP/gxr
         WFGwnjsjPQCtgz6GdEKchlZ7c/C5JhIYkUaERZhs/4rp2ZnDFiUesWBj95TwgMlvoCqU
         v0lbUxfA1OLWOx4Z6kJz1ailDQ3VWVB8xhS1gsX7SogKECuSOgBXexltMasgVMQKAhRR
         ++Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701509047; x=1702113847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cyRhIR0A6aTSPQR5JFcskpSPit5SlzMxXdXuH/hceE=;
        b=dEj0/H7az5LN6LgN+hSCSxYh0gOw0qbGFmSrhPIvbF+0RRvecGAkjMyFDMpv4lfNLH
         LVQw+pcz/Z17Hd7RVyIqojMPNxsUNUvlsTfcJ5khhxOOUXnUyZ+JfYzCy0ZVOdInpYTp
         +7p1twNkKml/nXq5OnX0fjNq6UP1yeyddWY6j7krk/G9O9VQ+Tylpnz1fZ5up1NahGhn
         Ozeae4syxv9EBnGd/wf7IVDoeX4KRWzcNUdOqo/CSXNw0Ffu8o2ab8q/XLND0faXiiku
         k+4YmgFBZDhDhuSsVWVc/UGbVONxX1PMPWIX6vuHCLOpA4iwFGCbnKqwV7TWcQTx8F9d
         +nBw==
X-Gm-Message-State: AOJu0YzRxocVM4Zgh73CYLy38ZI0kL4Dqy6X5GkSqsUcLqaDZ5EAymtD
	rn7hbH3UAygaRpXIJCnRCEpjWXk5dH5Dnsh67J/hQb0o/ZMd3g==
X-Google-Smtp-Source: AGHT+IFQfQiUQR2iMs1/xKDSvr3J3tfTKOHyVW01kw8JtaBhcX+qdEyhaiKv9DPs/D14LqMVwzI1zu/XaDa/q+4BR0A=
X-Received: by 2002:a17:906:81d9:b0:a19:a19b:c716 with SMTP id
 e25-20020a17090681d900b00a19a19bc716mr1481452ejx.102.1701509046995; Sat, 02
 Dec 2023 01:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1700948088-16140-mlmmj-666d2532@vger.kernel.org>
 <CAOE0c97T1cVvqFkqfrP_h53X08yQ7kLinZP09L35nVHc_V89+g@mail.gmail.com>
 <5abfc98859504795b50f7f343784c886@realtek.com> <CAOE0c96uJ9x8gbJZdHiMEiOM5gTd_ZqM_rUV7Cs1NyA_t0Ncfg@mail.gmail.com>
 <CAOE0c97fDaLTfsMJVmEh4HxOAPY19kD60qsV5AKJbWW5nnqWzw@mail.gmail.com> <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
In-Reply-To: <b4cfd676c0b24d98b82302aefac7f379@realtek.com>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Sat, 2 Dec 2023 11:23:54 +0200
Message-ID: <CAOE0c97NvXFhttfNNm3+NsXw9SKV7sC-nJriwF43pujvJugvSg@mail.gmail.com>
Subject: Re: Lenovo LOQ rtw_8852be
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> Can I know the type of your platoform Lenovo LOQ? Is it a regular notebo=
ok computer?

LOQ 15IRH8 - Type 82XV
I am using a dual boot with Windows and Ubuntu 22.04

>> The PCI EXT capabilities locate from 100h. Not sure if host controller d=
river limits to display them?
I did not get your question. Can you say it again please?


Ali

On Tue, Nov 28, 2023 at 3:21=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
>
>
> > -----Original Message-----
> > From: Ali Ghandour <gandour.ali@gmail.com>
> > Sent: Monday, November 27, 2023 2:19 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: linux-wireless@vger.kernel.org
> > Subject: Re: Lenovo LOQ rtw_8852be
> >
> > seems like the same error persists after downgrading:
> >
> > $ uname -r
> > 5.17.0-1035-oem
> >
> > $ sudo dmesg | grep rtw
> > [    4.859848] rtw89_8852be 0000:09:00.0: loaded firmware
> > rtw89/rtw8852b_fw-1.bin
> > [    4.860214] rtw89_8852be 0000:09:00.0: enabling device (0000 -> 0003=
)
> > [    4.861546] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
> > (da87cccd), cmd version 0, type 5
> > [    4.861550] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
> > (da87cccd), cmd version 0, type 3
> > [    4.861556] rtw89_8852be 0000:09:00.0: MAC has already powered on
> > [    4.867246] rtw89_8852be 0000:09:00.0: [ERR]pci config read 719
>
> We did changes after 5.18, but your 5.17 print out error with
> "pci config read" instead of "dbi_r8_pcie".
>
> -       ret =3D rtw89_dbi_read8(rtwdev, RTW89_PCIE_L1_CTRL, &bdr_ori);
> +       ret =3D rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_L1_CTRL, &b=
dr_ori);
>         if (ret) {
> -               rtw89_err(rtwdev, "[ERR]dbi_r8_pcie %X\n", RTW89_PCIE_L1_=
CTRL);  // 5.17
> +               rtw89_err(rtwdev, "[ERR]pci config read %X\n", RTW89_PCIE=
_L1_CTRL); // 5.18
>                 return ret;
>         }
>
> Uh. I know the reason why you see the new one, because 8852be is supporte=
d
> by kernel 6.2, and distro backport the driver to old kernel.
>
>
> If you can build driver yourself, please revert below patch and try again=
.
> Fixes: db38d9cd26c9 ("rtw89: use pci_read/write_config instead of dbi rea=
d/write")
>
> > >
> > > $ lspci -tv
> > > -[0000:00]-+-00.0  Intel Corporation Device a715
>
> I will try to Google to see if I can find some information about this PCI=
 host controller.
>
> Can I know the type of your platoform Lenovo LOQ? Is it a regular noteboo=
k computer?
>
> > >
> > > $ sudo lspci -s 09:00.0 -xxxx
> > > 09:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b8=
52
>
> [...]
>
> > > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
> In my side, lspci with '-xxxx', it can display PCI configuration space 0 =
~ ff0.
> In your side, lspci has the same behavior as driver that can't read 0x719=
.
>
> The PCI EXT capabilities locate from 100h. Not sure if host controller dr=
iver
> limits to display them?
>
> Ping-Ke
>

