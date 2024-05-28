Return-Path: <linux-wireless+bounces-8199-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CDB8D1B6D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0851C21620
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E116D4E6;
	Tue, 28 May 2024 12:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcJXiugU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8982516D4EB
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899892; cv=none; b=QhzmDDiUJNwhRbQNlyVnB6vQOwGmU4Xisc+w9sUDEvZpKdokhcumYq/gH29I5mUlzn7VAKq5Z8+ld7qdYJ67R+4IY9aG3zUqAkRrVjpcXUctLxVfqt5MbE8dqHpyco0XykFLKa4lYuwtzgA+kg5y0jslxf3DLlmSokS2sUfR5cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899892; c=relaxed/simple;
	bh=PGm32k8sjtzrt2vdQQlEmCKgzb/ZFoCoY4QynQiU6zE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq6kPylGQt3lQBGLUFnlcgfqWidzzOhtTPG2q5mtEXv/nGX5l1YLlk+RVXe3TXFZNSUrwpSU7W+SAgukYmCgaPcPr8xOERcTMetOa8mHOqmsP8zk4ywA/Tc2iZC3VBjwioMYnJCzPagtvmxJQ02ec9+8HsjZUMJBbls9EiSfNLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcJXiugU; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2bf59b781d6so635336a91.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 05:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899891; x=1717504691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YIcXX1EIYEIH8ddoKVPC9z/U4HsRTrXm8gri/zlxCw=;
        b=ZcJXiugUkDjVcWLGeBdhTskDFsOz7xTjalNmv/cj+YF/D0rjfIuENLP4yiAZr6PXLr
         C82ODM61rI/2tC2gWQAat3Jm5MqIbcVV3dQpqWx1LaDy541YbdL/eb+xK5xod5qxBOgL
         I7skDAOSf2flu4rzLEGLklrqfTHv65XNnscLD1BzjMRnfftSEGrJHY55FIhdZWuhsErw
         LG715xGEGklehq3u26r52HG6EXOStMRUq/gr4gHKCn2mo6qPv7cuYJC3MTE3U2J/mMg+
         JwHhdd90K9y6W+1GcpwCT/kivDle3qxOhqIGSlYfxgG0nF6Mfcr673IdTfOeS79qg1nM
         gucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899891; x=1717504691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1YIcXX1EIYEIH8ddoKVPC9z/U4HsRTrXm8gri/zlxCw=;
        b=lo9eOuxwoX3AsRcCTzl3+i8HLGqBzJhRPKTEwMoIKG/w7uBG7bP1esXz0Rq8R2lPiG
         N4/AiMIL5wP5n5Yi3Z/BliPRxtQxupv71B5gqbOdk0O47Zc/SC7wA3p/ieKlypBPQnj2
         JuCZpu1YpGqnKBf6fxs/KOnIbo6/RoE2k1ZHD2CGpfVwgVhtQWfOpAfjxaL0+46aNL8z
         7sSP6lYBPOy7uy8e0R6ryBy+CY6pPZoYnB+c7ywhPZn1E7T2a9S4ln6aEDzD9IvipPsR
         ZOojFVoj6Ie+HCGRpBxB2m2dDvP8v31Ox4ygmsKtnPnPzF+h6f6uZoWbsMNdhmsnYMKO
         f2TQ==
X-Gm-Message-State: AOJu0YypXyrh1cF/Ygj4NEUhDr8mHVuPak8gznGQiC40+stt9jY0N+vt
	GvZCci6t6fFIL55tBTcKJ9uCwE9E+8zWAiGaLnNhPKK8yYsO1jQuWWOIj7WkyWemUbmy+Bwsh7K
	EwtgX8GGBiv8G6GyIAb1qa2TMAPc=
X-Google-Smtp-Source: AGHT+IGOGZwP2JYnGMOO3qn+HK4RfUdxGfHCVpfI7fq5U/gE0PCmWB+l43RGkUSA2U1SlCTzHm+I8Q4bLTtVTYdzos4=
X-Received: by 2002:a17:90b:3552:b0:2bd:e917:232c with SMTP id
 98e67ed59e1d1-2bf5f10a12amr11405117a91.48.1716899890734; Tue, 28 May 2024
 05:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <0f1aef25-2b91-408d-aca9-9943dc9367b3@gmail.com> <CA+GA0_vz7S++ttaug2kGZWyzyc-PMZoVSsiSH-sXn4uctX5V2A@mail.gmail.com>
 <fdb30dac-4ab3-4182-80b2-8dc197420778@gmail.com>
In-Reply-To: <fdb30dac-4ab3-4182-80b2-8dc197420778@gmail.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Tue, 28 May 2024 14:38:00 +0200
Message-ID: <CA+GA0_tJxv_4vuoRssbXnYtDD2Z-AizyoiSjvT=EW7DnyJRQwQ@mail.gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 28 maj 2024 o 14:25 Bitterblue Smith <rtl8821cerfe2@gmail.com> napisa=
=C5=82(a):
>
> On 28/05/2024 13:42, Marcin =C5=9Alusarz wrote:
> > pon., 27 maj 2024 o 20:43 Bitterblue Smith <rtl8821cerfe2@gmail.com> na=
pisa=C5=82(a):
> >>
> >> On 27/05/2024 20:34, Marcin =C5=9Alusarz wrote:
> >>> From: Marcin =C5=9Alusarz <mslusarz@renau.com>
> >>>
> >>> If I don't connect to any Wifi network, after around 10 minutes, the =
device
> >>> hangs with endless spamming of:
> >>> rtw_8821cu 1-1:1.2: rtw_usb_reg_sec: reg 0x4e0, usb write 1 fail, sta=
tus: -71
> >>> killing both Wifi and Bluetooth part of the device.
> >>>
> >>> On arm, just leaving the wifi device unconnected kills it in up to 20=
 minutes.
> >>> If I keep restarting wpa_supplicant I can trigger it within a minute.
> >>> Looping "ifconfig wlan0 down; ifconfig wlan0 up" also triggers it wit=
hin a minute.
> >>>
> >>> On x86_64 system the only way I could trigger this was via ifconfig l=
oop,
> >>> but it took 3 hours and 20 minutes to do it.
> >>>
> >>> The only thing that can "fix" the device is replugging it.
> >>>
> >>> I found out that the reason for those hangs is a power-off+on sequenc=
e that's
> >>> triggered by the above steps.
> >>>
> >>> Disabling power-off for that chip "fixes" the issue. The patches belo=
w
> >>> implement that, but I'm not seriously proposing them for merging.
> >>>
> >>> Marcin =C5=9Alusarz (2):
> >>>   wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/lea=
ve
> >>>     IPS
> >>>   wifi: rtw88: disable power offs for 8821C
> >>>
> >>>  drivers/net/wireless/realtek/rtw88/main.c | 14 ++++++++------
> >>>  drivers/net/wireless/realtek/rtw88/ps.c   |  4 ++--
> >>>  2 files changed, 10 insertions(+), 8 deletions(-)
> >>>
> >>
> >> The first patch alone doesn't fix it?
> >
> > The first patch exists only to make the second patch work.
> > Without the first one, rtw_enter_ips will perform all actions except ac=
tually
> > doing the power off, which clears the POWERON flag.
> > After that, rtw_leave_ips will happily return early success without act=
ually
> > undoing the stuff that rtw_enter_ips did (like canceling all work_struc=
ts).
>
> I see.
>
> I wonder if it's really the chip that has a problem, or rtw88?
> Can you try your ifconfig loop with the other driver?
> https://github.com/morrownr/8821cu-20210916/

Actually, the issue was found on this driver. I started looking at the issu=
e
more closely (and discovered the exact reproduction steps) after I switched
to rtw88 and discovered it has exactly the same problem.

So yeah, it's either a chip issue or the same bug in both drivers.

