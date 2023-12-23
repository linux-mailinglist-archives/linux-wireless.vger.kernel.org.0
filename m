Return-Path: <linux-wireless+bounces-1263-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3204D81D391
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C09A1C213A8
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Dec 2023 10:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438559456;
	Sat, 23 Dec 2023 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hTdqZmzZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D210BA4F
	for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bb8f3d9f98so1068501b6e.3
        for <linux-wireless@vger.kernel.org>; Sat, 23 Dec 2023 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703328013; x=1703932813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK91vC5T5UGJhHy+n6e9eMfG+PGKVbXTcqsUI/TPXlU=;
        b=hTdqZmzZ/XGYEyfCYz5/tOHa3aiqOg+i5E5CXXurtusajkn9x/UJejt1Oyda7Ut2cu
         uyEHDNB+azPhqBabrYWbyC8MeHPgPnJDD14LZ5pb+WshUFzXZRb4CurVHUrPt1fZL5v7
         Dai2MZyqgdSwDMFzd2ikcFnVj+jKO5xj0tpmmiezBuHyms0AlzCFXlw4yAO+jDn/CwEQ
         TxH158Q0CuOe4BfRF1Dn7olblKSDB3K/lc9CM7RTlDDqU6pb8oOkICtJATTeF7cn1gO8
         paUK6aexIJzg0TiCigScBz0AjwILO6LenV6qtT8x6qS5k4W5iNvCggwLm2GZXZQo1Dy9
         Gffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703328013; x=1703932813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZK91vC5T5UGJhHy+n6e9eMfG+PGKVbXTcqsUI/TPXlU=;
        b=lIx9FgZ5kbsS33UjL+bOP8ic6k76LsAcUmAMmt4ywWxZ95tWqsLt+sJDLD6lkSydTS
         I+uZRpM/SeQ1j5PxaOAB6oRwQdIR9nfPHMiyOtb5FwjBMa9BCMdyNC/GtpCH3MQ4+Ufu
         UBTZhbrwx96MptQrrfF0Jys45vRl92YzCAKLPYe93nebHmgfDW8bf10HhyD45u8xSabm
         noYNZGO0siF3SB/KGPlA00FiymPTf1+NlgAxpf3E50Gzp16eBQnZIbELahVBk3CiLEt4
         BKgiq6MNyPtjA0Yf1ShBX35jKHesfPLGPxj6rB/V/bycJbwmdr/bYVnfLJP7uQ/noUBB
         iF2g==
X-Gm-Message-State: AOJu0Yza13/3gZq59bi+Ra+ilvAZOqJpdkg2WgtmqnnwMij/SIae8dtg
	+oej+GnfXFXV9CnmfTbuKt7hyuB2zaPTXIN9ACDQF3oq
X-Google-Smtp-Source: AGHT+IEXMp08rWnr/nJBAXwa/zmYsikjaCYOTg0RpVPt6RYMa4posQjh52TlRVACJgUvZUoO9NPK1Ymz+ZFjZgof7aw=
X-Received: by 2002:a05:6808:1246:b0:3b8:b063:addf with SMTP id
 o6-20020a056808124600b003b8b063addfmr3845613oiv.60.1703328012831; Sat, 23 Dec
 2023 02:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3505110-b76b-4152-8375-37fa3184d3c1@lwfinger.net>
 <748b045e7aaa43eb9a7fb83ad924614f@realtek.com> <CAFBinCD=iLbyfWWTqQjLQ5CiqOn08r4UaVqyKHve8AoW_xeFEw@mail.gmail.com>
 <84dc9e8b-0850-4724-a55b-582c994d042f@lwfinger.net>
In-Reply-To: <84dc9e8b-0850-4724-a55b-582c994d042f@lwfinger.net>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 23 Dec 2023 11:40:01 +0100
Message-ID: <CAFBinCDD9kY-HLQXy=Ksi1QnLcOVpS0Vrnn6ksCZmTbf0MukSA@mail.gmail.com>
Subject: Re: EFUSE in RTW8723DS
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>, linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Larry,

apologies for my late reply.

On Tue, Nov 21, 2023 at 11:47=E2=80=AFPM Larry Finger <Larry.Finger@lwfinge=
r.net> wrote:
>
> On 11/20/23 13:55, Martin Blumenstingl wrote:
> > Ping-Ke is right: the eFuse is split into two sections:
> > 1. common (RF calibration, EEPROM version, antenna information,
> > country code, ...) which is independent of the HCI (host controller
> > interface)
> > 2. HCI specific bits (PCI vendor/device IDs, USB vendor/device IDs,
> > SDIO specifics)
> >
> > #1 has already existed for a long time and I didn't have to touch it
> > since it's the same for the PCIe, USB and SDIO variant of a wireless
> > chip.
> >
> > For #2 there are no (known to me) SDIO specific bits other than the
> > MAC address. That's why I only added the MAC address for SDIO. If
> > there's more it can still be added.
> > Note that the MAC address has different offsets depending on whether
> > the HCI is PCIe, USB or SDIO.
>
> Martin,
>
> As shown in
> https://github.com/lwfinger/rtw88/issues/157#issuecomment-1820421821, dri=
ver
> rtw88 shows a lot worse performance than the vendor driver for a chip wit=
h a
> properly encoded EFUSE. Is this not a case of incorrect setting of the
> calibration data?
My current assumption is that the worse performance (=3D throughput) is
related to the implementation in rtw88's SDIO code, not the
programming of the RF parameters.
I'm planning to look into this next week.
I'd appreciate any hints from Ping-Ke on what to check / how to check
(as long as I can do it with very basic equipment - in other words: I
don't have an RF analyzer) :-)


Best regards,
Martin

