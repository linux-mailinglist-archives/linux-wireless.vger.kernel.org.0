Return-Path: <linux-wireless+bounces-8188-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8BC8D18CC
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E26E1C20ACD
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC6D16B73D;
	Tue, 28 May 2024 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyZBHwnY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3616B737
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716892979; cv=none; b=kkPOp95m3JiZOMs2efGn4J2iMVEIARcv0kLLzsu8IcAKiC1QME5JBxpww3OdZ9/EXs78vw14uOYpfkZGOjpkTTdUGGOMBJ/HYhQmxM9SAqiunMDhlhfU2qwkxzmZkZe7GWuWGh6QhCX1PVTWiaK8//LaIKHB7CbUzpNpp57OWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716892979; c=relaxed/simple;
	bh=27HmSlmRGporPir+dDnf9Ud+Xttc0RCvYhKtVB5HKcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2ZDW75Zfm3gL3bZ7o98KXSOvQQ5Qg3FpNpP4IH6l2CRzVQbKNHh56MZsmDaKD98q+d72X7cksqS+CL2n/XoosrdijQMPzi2JJ/bfbuEkF+ytMuxDUfvkSRRVTbWbXfX7ByL/QsccJg108abwqDHCzt+huHryr/DiZlX40C+u3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyZBHwnY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-6818811cb8aso446514a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 03:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716892977; x=1717497777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yovco7T4VLhbhQNa4tVtlJzCn3hw/Ld0XbvBwiOk9zs=;
        b=fyZBHwnYLflZlHxMCwQ6rkgxb1gA2s/OC1nuafDxWokzV6oEWsU9Pl8IRiHHfA1J3r
         q2AeXN0mY2/1ckufmjAAUoExzJbbiJZ+VFq9EdG+3Z2mkxlHNadfxgxRmikWTzrc3nPe
         dpRcl6MTGtvuFfZynYvlzKq3+Z4jNBZGIc1uiIxLAfbhGSkVCXUh2e4K5FUJH3HtnubO
         +oRBPhdyOJTZrQJ/XdnVaFEImPDlwxMpE1iWZq/2oBLK5Ahv4VKmCBuLWIFN47LMl8VS
         36sKqgzT8H24GRmlEgpgYTUo7qNl3xLkOw37NzT3tuvvg2hrrfYh9gwl/PA5M7SDm0HP
         /lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716892977; x=1717497777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yovco7T4VLhbhQNa4tVtlJzCn3hw/Ld0XbvBwiOk9zs=;
        b=vQNm2abrCdZvpKRiTHV1sKoFTdVflbvJVy84rRGMCAkseyVDhdT/z+MQgZcExz2sWZ
         4mf2lK5UIqE5JYMiga7gBGK818hAoq7cNgSwecjCFLqKdkKII/BML4wowqrIb872ZCaO
         tIGmT6z1biLOhW7sQ8ifcTM1JCfsvaYNIaNPpVHPvf3C4rkRQaAFoD1KESJr5iBp2hyN
         /a8bU0eUymkbpJrgo123cV9mUW4fgtcNdM1WT+KyuyvbHcNDZKwv4FFF5ZqzNQNEk94B
         GNduea6AR2oNlJJAmGQgyvIGOE9P7Z9s+ud8seeNu0PTc+LMyI0CGGuOtGyd+cDWmj6L
         Y84Q==
X-Gm-Message-State: AOJu0YxryJ+xIcbFuBG0DCU1eDwqspioW2HFkDjXkSyXZXAsHr0UG1Nr
	M42Wj1hrKtsAW2JeJ0oWT0K0BnzhVU/CetUdbGb2cTjw5SX6T2N+AF6geMVkN5iYDtmRJT5FucY
	StnQNqHBGe1VKscnp4Fa6l+x1nqi3SVnsBRE=
X-Google-Smtp-Source: AGHT+IHZeu/XTsLSEMwAom1Cj5J3HnAn8B5t6PQ++0MdThHo73iEBpW4URjUA8X8TxQeBGSzoc/4CPMLuLrWjh2V0X0=
X-Received: by 2002:a17:90a:ff15:b0:2a2:981b:2c9e with SMTP id
 98e67ed59e1d1-2bf5ee17c5bmr11510344a91.36.1716892976802; Tue, 28 May 2024
 03:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com> <0f1aef25-2b91-408d-aca9-9943dc9367b3@gmail.com>
In-Reply-To: <0f1aef25-2b91-408d-aca9-9943dc9367b3@gmail.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Tue, 28 May 2024 12:42:46 +0200
Message-ID: <CA+GA0_vz7S++ttaug2kGZWyzyc-PMZoVSsiSH-sXn4uctX5V2A@mail.gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 27 maj 2024 o 20:43 Bitterblue Smith <rtl8821cerfe2@gmail.com> napisa=
=C5=82(a):
>
> On 27/05/2024 20:34, Marcin =C5=9Alusarz wrote:
> > From: Marcin =C5=9Alusarz <mslusarz@renau.com>
> >
> > If I don't connect to any Wifi network, after around 10 minutes, the de=
vice
> > hangs with endless spamming of:
> > rtw_8821cu 1-1:1.2: rtw_usb_reg_sec: reg 0x4e0, usb write 1 fail, statu=
s: -71
> > killing both Wifi and Bluetooth part of the device.
> >
> > On arm, just leaving the wifi device unconnected kills it in up to 20 m=
inutes.
> > If I keep restarting wpa_supplicant I can trigger it within a minute.
> > Looping "ifconfig wlan0 down; ifconfig wlan0 up" also triggers it withi=
n a minute.
> >
> > On x86_64 system the only way I could trigger this was via ifconfig loo=
p,
> > but it took 3 hours and 20 minutes to do it.
> >
> > The only thing that can "fix" the device is replugging it.
> >
> > I found out that the reason for those hangs is a power-off+on sequence =
that's
> > triggered by the above steps.
> >
> > Disabling power-off for that chip "fixes" the issue. The patches below
> > implement that, but I'm not seriously proposing them for merging.
> >
> > Marcin =C5=9Alusarz (2):
> >   wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/leave
> >     IPS
> >   wifi: rtw88: disable power offs for 8821C
> >
> >  drivers/net/wireless/realtek/rtw88/main.c | 14 ++++++++------
> >  drivers/net/wireless/realtek/rtw88/ps.c   |  4 ++--
> >  2 files changed, 10 insertions(+), 8 deletions(-)
> >
>
> The first patch alone doesn't fix it?

The first patch exists only to make the second patch work.
Without the first one, rtw_enter_ips will perform all actions except actual=
ly
doing the power off, which clears the POWERON flag.
After that, rtw_leave_ips will happily return early success without actuall=
y
undoing the stuff that rtw_enter_ips did (like canceling all work_structs).

