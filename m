Return-Path: <linux-wireless+bounces-685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0456480E3D9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 06:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0FA1F21E8F
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 05:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2CE13FF4;
	Tue, 12 Dec 2023 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbbA5a8p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F79BD
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 21:36:39 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54c7744a93fso7356544a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 21:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702359397; x=1702964197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T9VWkQpJuim68FUG/YUh+CRjeuekaCZfHF4MdQ/p6A=;
        b=mbbA5a8pHGusCc79qEYHsVFAPvUWHQUG1sEy/GX7vblf75gtDUyt/c2ZkuRCPtn2gL
         LavmipaZlpMg4607kx37K4AxHW7rCqK6PaKurbPur0SZ29mlK6PqoZJbu7NhYBh9RNut
         8fQ8eEKrkNyjrFM89nBS/AfaaHYmwJxjbM9PkFOZObkZm28BW6qJZ4z1AjtGHalJJ9TA
         s5Rmr9Qk5PtYcEQ2y/j+8n3lJQ+pq1S4+EiWzb0cHaH2YkjwOEptwGwDcIPFXrgLokqN
         C0AdC4y7SZFZKjMonoJBg5crdI3SFehnfWpQhEhcN2b45QtQltev3+ilytPF5se2jXtm
         d98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359397; x=1702964197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7T9VWkQpJuim68FUG/YUh+CRjeuekaCZfHF4MdQ/p6A=;
        b=SgR5A3tDCAHgZtusMpB4bAeoUVc4JvBoAXmiqxKphhRBUAVk85AEuQMeDNSf3dQa9F
         fbVY2N9XmeNE02xSRaZrDC07/FzAP7Wjraxur2NJdeyPQ5LOQ8SLdyaHuNxJA3tVKBn0
         nxwLE0I1tC7lQX3G9cI3/D2Tr8+tOkYEXeJUypl4QUAA0BaTDAc8W/6R10nEDdOo0oAx
         ZewS2Yxjq2l/41wOC2l/O7N637MsGSe+r74GKXPkOgA2IyD2QEugEXK2il76ine9j18c
         2FF/oOde9qZUjAuuoyGxzaRlE8Nxp2x06v65uIWGf8fmhUasE/CrMiflG5IP82xei5OF
         wikg==
X-Gm-Message-State: AOJu0YxooEOk/vTpWzhMqA5FON2cuxKLZ+6ji5XUykd6n5d2dF0rNTLw
	VfqLNihrdka/8QFVRD0y1/CkcfS7XoAC6lZHNxw=
X-Google-Smtp-Source: AGHT+IFuah62m6boeAxNqOeRLU+hdbVtSwn8mQ13Ku44W/Mz0RfwBVi3JOlGKTHe4ehFZSaaG7UPZnuobUcnTgb3srk=
X-Received: by 2002:a17:907:2d0f:b0:a1c:d788:e0a5 with SMTP id
 gs15-20020a1709072d0f00b00a1cd788e0a5mr3250606ejc.65.1702359397114; Mon, 11
 Dec 2023 21:36:37 -0800 (PST)
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
 <f5e03fd6c26544b48cb493ec428338fb@realtek.com> <CAOE0c94UMKymy8mV2unbNo9CRe9n0pUmg6dGQ-xnRRKZvMxNJA@mail.gmail.com>
 <973fe7f5ec2c474c8a88f8933c7dde83@realtek.com>
In-Reply-To: <973fe7f5ec2c474c8a88f8933c7dde83@realtek.com>
From: Ali Ghandour <gandour.ali@gmail.com>
Date: Tue, 12 Dec 2023 07:36:25 +0200
Message-ID: <CAOE0c94tf8y2hv0QHKEiuo5a7Ly=oJAw+g4Uh6BktHOMdbWY1Q@mail.gmail.com>
Subject: Re: Lenovo LOQ rtw_8852be
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Please try below workaround patch to ignore the setting. I have tried tha=
t, and
> in my side it still works without obvious problem. I will check internall=
y to
> check how much this can affect. If not, I would ignore this if certain pl=
atform
> like yours can't access PCI space over 0x100.

I was able to connect. Thanks a lot Ping-Ke!

[  609.484727] rtw89_8852be 0000:09:00.0: loaded firmware
rtw89/rtw8852b_fw-1.bin
[  609.484998] rtw89_8852be 0000:09:00.0: enabling device (0000 -> 0003)
[  609.486812] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 5
[  609.486815] rtw89_8852be 0000:09:00.0: Firmware version 0.29.29.5
(da87cccd), cmd version 0, type 3
[  609.767891] rtw89_8852be 0000:09:00.0: chip rfe_type is 1
[  609.796171] rtw89_8852be 0000:09:00.0: failed to set CLKREQ Delay
[  609.796175] rtw89_8852be 0000:09:00.0: failed to set CLKREQ_L1, ret=3D-2=
2
[  609.796177] rtw89_8852be 0000:09:00.0: failed to read ASPM Delay
[  609.796177] rtw89_8852be 0000:09:00.0: failed to read ASPM Delay
[  609.796178] rtw89_8852be 0000:09:00.0: failed to set ASPM L1, ret=3D-22
[  609.803786] rtw89_8852be 0000:09:00.0 wlp9s0: renamed from wlan0


On Mon, Dec 11, 2023 at 3:53=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
>
>
> > -----Original Message-----
> > From: Ali Ghandour <gandour.ali@gmail.com>
> > Sent: Sunday, December 10, 2023 2:24 PM
> > To: Ping-Ke Shih <pkshih@realtek.com>
> > Cc: linux-wireless@vger.kernel.org
> > Subject: Re: Lenovo LOQ rtw_8852be
> >
> > It ended up showing 4096.
>
> But still not work. PCI code is hard to me.
>
> Please try below workaround patch to ignore the setting. I have tried tha=
t, and
> in my side it still works without obvious problem. I will check internall=
y to
> check how much this can affect. If not, I would ignore this if certain pl=
atform
> like yours can't access PCI space over 0x100.
>
>
> @@ -2061,6 +2061,9 @@ static int rtw89_pci_auto_refclk_cal(struct rtw89_d=
ev *rtwdev, bool autook_en)
>         if (chip_id !=3D RTL8852B && chip_id !=3D RTL8851B)
>                 return 0;
>
> +       printk("no auto_refclk_cal\n");
> +       return 0;
> +
>         ret =3D rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_PHY_RATE, &=
val8);
>         if (ret) {
>                 rtw89_err(rtwdev, "[ERR]pci config read %X\n",
>
>
> Ping-Ke
>

