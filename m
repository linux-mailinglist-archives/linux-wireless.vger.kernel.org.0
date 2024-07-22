Return-Path: <linux-wireless+bounces-10436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 422B6939441
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 21:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65D7D1C21575
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 19:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772D416F903;
	Mon, 22 Jul 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b4Xqa2l/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32A016EBE9
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676673; cv=none; b=JtQJSEpX+L0MaKEDA7vEKYXAgR3dRc+v7Bn7iDQE3LF4H71/Eq+38qIgTBBkcyb54W1oxdE1YNLUmimcXV31RhZvMTv6ol/LGyfBIV4T1XsC7fEN8JcBuGCdwUQPWNYiXXGBS5AmpeJTxkzGETx8956BC4t/OfRFyG82L95HjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676673; c=relaxed/simple;
	bh=tby+TYChdhxGDBt5vyblcT/EnT/A3j+wJAQr2LjJ2LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUm1s/CEDhOLnL6SznR7OgTvGFGmcU1AYBdMvfosUoi6qX+rO9BGqlNN2Tuaf4/OawpFrosbeytDAy0qGy0bRWfbzNbHdse1AOGP9o+RknmLNGGuOldMmKu1zIQJJJKqjSWG8HDwqP81WH4yAL7MIheK8BZ6MGWgvlJq/ZhN6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=b4Xqa2l/; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso450002066b.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721676670; x=1722281470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tby+TYChdhxGDBt5vyblcT/EnT/A3j+wJAQr2LjJ2LY=;
        b=b4Xqa2l/zPH3cedO2+D3tY3R/vRW6UpRiv+8EfQyGXclFNbxtKNMFKhkGOPIbRLiwD
         mqdnMT5GaoVXfhCMybyh29FZkyfejdxtn9WLKQroJjq2z6JVO+Rfaqd0bE6B8wbhADyG
         XA7Tzs0o/lRidJqGvBQKF/XQnVO9NdmakaQfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676670; x=1722281470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tby+TYChdhxGDBt5vyblcT/EnT/A3j+wJAQr2LjJ2LY=;
        b=N2jr0y1RH3QlU3A+HftijxSeyXf5UuFX2mbXGXBAzoXiYaWBBTvEE3tzAbgaPvZvvp
         UXtRK6dwyN5fUF3kAQIiXZ4jn6oQm+SxuIv3mdTetoz9PFy73I9tQOxgPBWAOQf0UGn6
         iRIKTORHlBCkxpD2VRXQPlmMhuqopTWTfXQS3h4rbXzMnbLMOO+6sGjUvirFid4RTx9j
         zJaq3aSeTlOqIYjCOerZ7wybt2xaWgHkhYTkUDmo4bL1d7StHJoHlGG50p6Wm1RTDS9r
         G+Ax7GvvSTyP1d2AI+rUQ/UgqX57ecyTX1vF4d+HX37a8hM79UlVOiirxOCR7JusArk4
         /zmg==
X-Forwarded-Encrypted: i=1; AJvYcCWJrYim3I9n3THG5p6rCVvsG8ERfZoOtYBXkYAF/u82eGDZwzS4L2m23t4vXPgNW6n0CuCXaxG5dc9UgKUwXZDtZgORIRB+202D4PSs3Y8=
X-Gm-Message-State: AOJu0YyvcfRPNfp5TEM1CMdAAEAMfrCLgm3nKLovW0CqaBOPU6dSEK9E
	sFgRz2+PXppRtvcQfizgOwj1Uhm8tGaoCabZXb9PcV+Shr8lt9X9afMdYGxBJBcfinE4UlapY3g
	=
X-Google-Smtp-Source: AGHT+IGp6vpOdwZ0Z8047/AbqeXtqwzB5M1nzH4MNkslo+p2xKOs9KwH/5DESwKE/itmYEj96y923A==
X-Received: by 2002:a17:907:d86:b0:a77:d1ea:ab3b with SMTP id a640c23a62f3a-a7a4c010093mr515245966b.25.1721676669585;
        Mon, 22 Jul 2024 12:31:09 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7b6e92sm455042466b.57.2024.07.22.12.31.08
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 12:31:08 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso449998066b.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 12:31:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6sWunVKYhEzdLkUmROyqZJxi7T/kw6ZgBAGhc0bbSaa2VNqH5Mvi8Colw6Z1CqBmIAB+ykpjm2rtSVGs2tAOXxlflxPHwPiSGU13/mdw=
X-Received: by 2002:a17:907:968e:b0:a75:360a:6cb0 with SMTP id
 a640c23a62f3a-a7a4c010857mr549203766b.29.1721676668187; Mon, 22 Jul 2024
 12:31:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
 <20240717-mwifiex-wpa-psk-sha256-v2-2-eb53d5082b62@pengutronix.de>
 <ZpmdVq2CkxRcLxvO@google.com> <ZpoCC042qMcOQ83N@pengutronix.de>
 <Zpq43ZxnICn5vEIu@google.com> <Zp4O68Y6oss_pwMm@pengutronix.de> <PA4PR04MB963817EE5EA2F6BAEDF22CC2D1A82@PA4PR04MB9638.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB963817EE5EA2F6BAEDF22CC2D1A82@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Brian Norris <briannorris@chromium.org>
Date: Mon, 22 Jul 2024 12:30:53 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPGwT7ST3k0SHzpHJ0i2XbtMD-9f06M2PhQjMu-TmMqZw@mail.gmail.com>
Message-ID: <CA+ASDXPGwT7ST3k0SHzpHJ0i2XbtMD-9f06M2PhQjMu-TmMqZw@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 2/2] wifi: mwifiex: add support for WPA-PSK-SHA256
To: David Lin <yu-hao.lin@nxp.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Francesco Dolcini <francesco@dolcini.it>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David and Sascha,

On Mon, Jul 22, 2024 at 1:46=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wrot=
e:
> > From: Sascha Hauer <s.hauer@pengutronix.de>

> > Thinking about this again we really do need to use '|=3D' and not '=3D'
> > to make the result independent of the ordering of the AKM suites array =
entries.
> >
>
> Yes, for our private driver. It uses '|=3D" and can work for firmware of =
IW416 and IW61x.
> For nxpwifi, it will follow mwifiex first and will be updated to use "|=
=3D" later.

Thanks for the reply, David. Treating this as a bitfield sounds good
to me, then.

> > > That would make sense to me, but I think that's in conflict with what
> > > David Lin said here:
...
> > > "Firmware can only support one of WLAN_AKM_SUITE_8021X,
> > > WLAN_AKM_SUITE_PSK, or WLAN_AKM_SUITE_SAE."
> >
> > I don't really know how this sentence was meant. It clearly works when =
both
> > WLAN_AKM_SUITE_PSK and WLAN_AKM_SUITE_SAE are advertised. Of course
> > in the only one of both is selected by the station.

Yeah, I was a little confused too. I don't have many AP systems to
test though -- all my use cases are STA.

> Mwifiex supports a lot of legacy devices, I don't know if modifications o=
f the coding
> for the data of TLV_TYPE_UAP_AKMP will affect existed devices or not. May=
be you
> can follow the patch for host mlme to add a flag like ''host_mlme_enabled=
'' to enable
> this kind of change for specific device.

I don't love adding new flags for small changes just out of extreme
caution. If we find a good reason to, that's an option, but in this
case, it feels like the behavior is poorly defined and possibly
inconsistent or broken with the current code. Specifically, if anyone
was specifying PSK+EAP from user space, we didn't really guarantee
behavior. If users were really using that previously and are broken by
such a change ... well, we can figure out a way forward by introducing
such a flag.

Brian

