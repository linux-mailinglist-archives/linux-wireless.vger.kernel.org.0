Return-Path: <linux-wireless+bounces-17059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E15A00E4D
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 20:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1851B3A1A2B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA14B1F9F58;
	Fri,  3 Jan 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md2jLHM/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAED1B21B9;
	Fri,  3 Jan 2025 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931441; cv=none; b=EBXjIY3+bYdgbz+0Qh0M3lHAQpsq1odzryb9k/+G3M48PpuG6fiLgf0vW5rnSByjJ0N9p2mOyc3WyNC7ijvOJjbRenQL7GNnmWBTm244J/uLyPdnsQiND66baB16Ie8eCAlcswbKyGrs1UgCvE6Masp40gzJmsEZ6+kRwUwXXKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931441; c=relaxed/simple;
	bh=LfWdzo9EE6EIL2ZIglc052EjtptEHsXTURrle1b2I7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TYb40+Lwhyohw5V2L4n9KtviGhhlfq+tFo/hHbw0mEViE9QZ7/TA1UpjTZuFivxK11AApDVw6dTAHTK8nYXPvxlrLVK2nljLqkm9jMS2AE/bR8Ux5C1pbE08bqosr4jEDcNgd0CCDZSgHSheQozAflWxgTKiwvTWtNzvXQ9Z+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md2jLHM/; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-29ff5c75c21so6807326fac.0;
        Fri, 03 Jan 2025 11:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735931439; x=1736536239; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O38d7jAf6dEwF11VcZ7H/P9bv/zLZA/v1y+Yx0LQ16Q=;
        b=md2jLHM/nr/BZbe8l41SxW69YMx7MI0rXWUvnXRX/GMxRMj19LEtscoJ5SiZHdZ8mc
         DiguCq5mlMZmWd2dQKCqYZgyL9M7In+ZZJ/sC5W2uZCYiN8wPl8jkAUdTUsXrsTMu5Ms
         FXLZE69UG2YvY44eo/0xRA3W4+N4bpp6Ook582TEYb2JlwmpGSTduofxuaPm6na9rgmC
         7pcnMTKaunWaFG2fO400PM/5B5SUww+j8K+5RScwggm7eNUv4yJ10z/6mUXEIsV88psx
         IlWW9N+F8qotguWLk/z9u2vjbAYo/vD7yFsJtjdb+xstvWTmJ22pHwPtEBnhfZLx3p9g
         CJyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735931439; x=1736536239;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O38d7jAf6dEwF11VcZ7H/P9bv/zLZA/v1y+Yx0LQ16Q=;
        b=izcrm8MiuftyMpZFoQD/qJdTvqn6aIxSoJPNlMYPzrinS00RNQn8thxkYmnU1027P7
         csVlQFEcbPOG0fOxrnVYxQFBfiUSB7lo49iOh6eOYg5py1hthqtSPFxwMh9eirYBXMno
         4wfAZLkgc5Hy/MXivZw8xDQ76pN9kD3ajQXy9v/JAgaHab4aenu/NJ1okkaEDRxrUENn
         U9yxAOrB6ZF3HAhqRzCF264mYUzaQAmTj4UqyVXZjYqWmth0qTiSLurTteg7JERWapP5
         XGXe7bXI4boo38gFw42l0bxV6AvvPE1NB9Gs2iXCcdlwZ5MJr3VhhqsIBjmFSZ4g8n80
         KnOA==
X-Forwarded-Encrypted: i=1; AJvYcCUTc2NEVIVQr0EUFDy4uuaxPelkm4+ztS9r+ZPG/Uysa+16eqGm6F38EtIGNpnWvsdxEtn9d3cpp5ar5cw/uVg=@vger.kernel.org, AJvYcCUnT2Qb1f4TsqEsMn6vvXNAKW2UfO0XiLThxh3ZBlb99Gd67JNikJQyErLv/x1eC6kVn90FML5/ITkrw0Y=@vger.kernel.org, AJvYcCWprdYCC3Bu0Gh8KnTM1MVx358xtqFrV735v4s3P7vffHc+OejCt6Ap/pSHSfhLTBWnE6IP0U6M@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3FJ7//iRMXKju7RDyJR384KHWdlkZkqM4QzVJTXFIIoy/Mbuf
	u+xDI9rCAPRDy3LCehYiLIa2CZGrUE7eOlKW5J1VArR7KxwD2wDxF5LT2+RjvlxZK/cSmW8RthE
	/QkM8dn1B2H7iF8KhRpRGR/mTPpA=
X-Gm-Gg: ASbGncuICPPV+nrMwH9xzrc5IxdmqA0Z2PdClhwPHg76XXmYKocDnJpNxK7hqiQ1Cit
	pUuiVIEf3dwaYFEUSDbNgsoorn66hS7iNpMPZDeydNZ36vhsRVM/TQFShILzbG4Ig4CtVwjwl
X-Google-Smtp-Source: AGHT+IGu1tzVTWb4B3RMjZ249lg25e9skJHb6zvlh+Ag74TNeeMsrdms/5xQwJmF6ynn0wy+84VnrEvF7ajA+g2oJYM=
X-Received: by 2002:a05:6871:d308:b0:29e:37af:a943 with SMTP id
 586e51a60fabf-2a7fcd3b648mr27596656fac.18.1735931439051; Fri, 03 Jan 2025
 11:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103075107.1337533-1-anarsoul@gmail.com> <Z3g0MLOJlLsPnF1m@skv.local>
In-Reply-To: <Z3g0MLOJlLsPnF1m@skv.local>
From: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 3 Jan 2025 11:10:13 -0800
Message-ID: <CA+E=qVcmHzLkH9eijPqw0_o-pOZEhXpWoPGmRmzLRFGaZiNnwA@mail.gmail.com>
Subject: Re: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>, Vasily Khoruzhick <anarsoul@gmail.com>, 
	Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>, Fiona Klute <fiona.klute@gmx.de>, 
	Bitterblue Smith <rtl8821cerfe2@gmail.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 11:02=E2=80=AFAM Andrey Skvortsov
<andrej.skvortzov@gmail.com> wrote:
>
> On 25-01-02 23:50, Vasily Khoruzhick wrote:
> > Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
> > fatal and do not seem to have any impact, just fix them to match vendor
> > driver.
> >
> > However the last one in rtw8703b_set_channel_bb() clears too many bits
> > in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
> > above MCS0-MCS1). Vendor driver clears only 2 most significant bits.
> >
> > With the last typo fixed, the driver is able to reach MCS7 on Pinebook
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>
> Thank you, Vasily, for fixing that. Performance is much better with
> the fix. Here are iperf results made on PinePhone:

Thanks for testing!

> 1. without the patch using rtw88 driver
>   1.98 Mbits/sec
>
> 2. with the patch using rtw88 driver
>   14.0 Mbits/sec
>
> 3. using old vendor 8723cs driver
>   23.6 Mbits/sec

Interesting, I get 30-50 Mbit/s on both rtw88 and vendor driver on
Pinebook for either TX or RX, however I am pretty close (a few meters)
to the AP and it isn't a noisy env (Pinebook can pick up just 4 other
2.4G APs besides mine, none on the same channel). Could you try
disabling bluetooth (run bluetoothctl, and do "power off") and re-run
the test? I noticed that btcoex is implemented differently in rtw88
and in the vendor driver, so it might not be working correctly.

>
> --
> Best regards,
> Andrey Skvortsov

