Return-Path: <linux-wireless+bounces-16118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A879EA158
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 22:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CB62829F6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 21:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4686619D07E;
	Mon,  9 Dec 2024 21:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAED2J+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C822F19ABB6;
	Mon,  9 Dec 2024 21:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733780595; cv=none; b=iTf/BYhLSOQXtQc7+k1VlCrUauyDIHW6AI1fV430gcOMpgyZaNMWu5XrEdOkfksKS2qGQvhrAz6YFMDbuUbi4NVU4OoE7mMfIAcoYrmme73sxYpK+ye3qOEq9IluJQY/2x4z2RaeWY4nHOr1wHje0ullhOW1paXD6vc1qeA6PNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733780595; c=relaxed/simple;
	bh=7C3TIQDc5r9whWF7hD8ixXiUW5KVhkJSPaWd2XPJqUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE/NqCRrwt5XdkK8tjs50c3kiDXnERCOmeb1NpaY06lqdzA03cQpxpnBeRiXgAjlvMSSdT7SUSRqmAjpNQgq5r1sC9CE2dk4Uq6Fg0J/AKlnkwdceh5AjnOQDvcAAtHsIZtiBCDDqlGMVqt/Nw+HFmhoqk8DmmA1ac046mcAk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAED2J+8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so3881453a91.0;
        Mon, 09 Dec 2024 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733780593; x=1734385393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C3TIQDc5r9whWF7hD8ixXiUW5KVhkJSPaWd2XPJqUQ=;
        b=nAED2J+8Rykj1u8I7Qy5txY4u3cCHKtHXsgnXL5QFoCS2hcPGqXb0H1iAvogMJ1E0G
         chwRqcQhqRJwHZEp2VW9b57O4O2e+U/Tekp3LeKR0jATAcxdDGjlFbLkfoBZ8zDMbmi1
         Xs33nTGQwJLHbz7MjAh81dzJWRvXoM8E5NgmYhZthfrKu9aj8BsRfQCgZc1ZqPepM7Vm
         zxmdCB3RWBI6ZmSjMGPd/x1/ViU2tYuK6ksOFhxp271FefPxlDjlmHW2tGbQh7qhlRbf
         RTMYvib/eJuMkf+MIUAP0VfHXx2YfqPKuIIdBxlyKds1gu5LsUes/ur06n5W3hYqYIwn
         7f4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733780593; x=1734385393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7C3TIQDc5r9whWF7hD8ixXiUW5KVhkJSPaWd2XPJqUQ=;
        b=u5P/FME/J0VvkfwCe8DMim3v6uI90DbvuULxtuKSiTp/aEKc/omk+AaN2RQLTzbRgX
         EBi59S2OqpbSlq2Mq6S4FmzxmfdurS0f1PFzlPtvEM8zNVJQwJNDxcZr7lwcjupOWQ7W
         yo9wNy3Eoj7DZrmm7FlFdsv5XYlLWACFL2uqTm9bJaCJtd+JAp3AOPON3d0G4Tm3zcPw
         iMgCHPVrF6P5sofHXQn+xd3VgLJbHZroHQMF5LLGTLyxWg7Ng8U8X0WqCq088oD4vTt1
         78dXmmPeZaGN1Yz+kzr6ZMStFIOg+gGVrf/RS7hLJegQEgDfCslK0FdVfW0bpoIz3BF4
         pmGA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdv/dYwN7P5k0Wa80lvEses7EFyZKkE6soPcezJU8l9xrwwpNl4WvpFMShbwiFiIndXScQ6oxhPXeNh0ESmQ=@vger.kernel.org, AJvYcCXrsb04rfeuLIiHcuwwqCvjRCi1pnhSlEFXwyOlFv4DOj/5QkAFVLGYYxMOC4X78aoUHJhuzTOdDe4grsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaU00JHejBzNurrAFhQAWci+UE6NES02GNRRJ8HCpGhOsOWqt
	oJYLXJu+U0Ins+lIdEIbYWnGQJA/683GVYh19Ob4xUZOzaw4dDdWoVI35SXFicSF87hlg2p5GMK
	7sAxAPBHtkM4vvUkfEOXMMZku5EA=
X-Gm-Gg: ASbGncsRybbmBWcHTpZ2le/f8Qg/YVmAdGjepuetMjJ4fgW3/8qcdtGRbtC+D6wIolX
	c0ynbU0L0d/lhqRQoE/IDeATZxynSqnLjmx11Tw==
X-Google-Smtp-Source: AGHT+IFHl9JvnbZ+WzyQTTMG8AYlwn35BnR5qXXNW5glTv8INdg01gjaC0AsvGoTptYUEGv3VkWRbRqYbYwgJy28coc=
X-Received: by 2002:a17:90b:394f:b0:2ee:aed2:c15c with SMTP id
 98e67ed59e1d1-2efcf25d4b4mr2723757a91.28.1733780592965; Mon, 09 Dec 2024
 13:43:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122210346.2848578-1-alexthreed@gmail.com>
 <980c5cee-2dc3-4d26-b749-6ba00b9c2091@broadcom.com> <CAF4oh-Np5HZzdCxjycrvr_-RS0ZdC4Y3AyCi89=Lo1gQnSSowg@mail.gmail.com>
In-Reply-To: <CAF4oh-Np5HZzdCxjycrvr_-RS0ZdC4Y3AyCi89=Lo1gQnSSowg@mail.gmail.com>
From: KeithG <ys3al35l@gmail.com>
Date: Mon, 9 Dec 2024 15:43:01 -0600
Message-ID: <CAG17S_MYhPCuDryf2Meh64iZPAc-NnHyPwEv4oQdww9QNr0j6g@mail.gmail.com>
Subject: Re: [PATCH] brcmfmac: fix RSSI report in AP mode
To: Alex Shumsky <alexthreed@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	Alexey Berezhok <a@bayrepo.ru>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Kalle Valo <kvalo@kernel.org>, 
	Kees Cook <kees@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, brcm80211-dev-list.pdl@broadcom.com, 
	brcm80211@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From my updated aarch64 RPiOS Bookworm as of today, it is:
Firmware: BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26
CY) FWID 01-b677b91b

On Mon, Dec 9, 2024 at 3:08=E2=80=AFPM Alex Shumsky <alexthreed@gmail.com> =
wrote:
>
> On Tue, Nov 26, 2024 at 2:13=E2=80=AFPM Arend van Spriel
> <arend.vanspriel@broadcom.com> wrote:
> >
> > On 11/22/2024 10:03 PM, Alex Shumsky wrote:
> > > After commit 9a1590934d9a ("brcmfmac: correctly report average RSSI i=
n
> > > station info") it is required from firmware to provide rx_lastpkt_rss=
i.
> > > If this field is not provided brcmfmac doesn't report any RSSI at all=
.
> > > Unfortunately some firmwares doesn't provide it. One example is firmw=
are
> > > for BCM43455 found in Raspbberry Pi.
> > > See https://github.com/raspberrypi/linux/issues/4574
> > >
> > > Fix it by falling back to rssi field if rx_lastpkt_rssi is not provid=
ed
> > > (like it was before 9a1590934d9a).
> >
> > Sounds like a reasonable approach. However, I would like to learn more
> > about the issue. Maybe it is a per-vendor issue so I am interested what
> > the sta_info version is that we get from firmware. It is printed in
> > brcmf_cfg80211_get_station() with brcmf_dbg(). You can make it a
> > bphy_err() call instead or enable TRACE level debug messages in the dri=
ver.
> >
> > Also would be good to know the firmware version and kernel version of
> > the BCM43455.
> >
> > Regards,
> > Arend
>
> I've just checked sta version in trace logs:
> brcmf_cfg80211_get_station version 4
>
> Firmware I currently use:
> BCM4345/6 wl0: Aug 29 2023 01:47:08 version 7.45.265 (28bca26 CY) FWID
> 01-b677b91b
> https://github.com/murata-wireless/cyw-fmac-fw/blob/e024d0c0a3ab241f547cb=
44303de7e1b49f0ca78/cyfmac43455-sdio.bin
>
> I'm not sure what firmware version is used in the raspberry pi distro.
> From raspberry forums it looks, like:
> Firmware: BCM4345/6 wl0: Nov 1 2021 00:37:25 version 7.45.241 (1a2f2fa
> CY) FWID 01-703fd60
>

