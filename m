Return-Path: <linux-wireless+bounces-24501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B1DAE8C06
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 20:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F847B22A5
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 18:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1C2D321A;
	Wed, 25 Jun 2025 18:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b="VsQoaO3O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA15729CB42
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 18:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750874862; cv=none; b=thVl4o8UR8aXY18qwAxJUA9akR5J8BcW8UV/TnHuzsajeFFp2xkORyVE0kakZbtsvy3YCH1PYo1qOptW+4yhwbinEYgiaZHeM66wllJ9Hkpeepvu/vJrbZ33Q9yuKi01oyXEw0ULCehALLTwSz9exNubjvqhUAgWblrlS4yA8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750874862; c=relaxed/simple;
	bh=5yoArg8Q8vP2AxVXLfBDB9Qj8/5lFrbXUbgZAk2+/ww=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gWBwHHb6vpv4i1OSEqajYdQYahxloOA3HvdADjjCHbnKXY3hT/1rzewslTPSclEj7ythSDcK3ZFnunpVkJA8e2ssdzGC1/SkNx4+LfB1YlRJjfqyT0KlIiKOw75Qoe2GDHK/BJNfui+wFfY4VEB1SWw8KAbDM302rCFoW7Tuf+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch; spf=none smtp.mailfrom=easyb.ch; dkim=pass (2048-bit key) header.d=easyb-ch.20230601.gappssmtp.com header.i=@easyb-ch.20230601.gappssmtp.com header.b=VsQoaO3O; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=easyb.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easyb.ch
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450cfb790f7so966115e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=easyb-ch.20230601.gappssmtp.com; s=20230601; t=1750874856; x=1751479656; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZO4Xv7s5EGkfjWrejC3c1JPjAZceEOiE6U+qYSQBuw=;
        b=VsQoaO3OTNLgjzS71TPcLRfBk8E1aCjiu+f+DCRjPyA3x6+8oIZVfo3jxeexoS/lph
         oijiJw8HSEjP/ym0Q8XlwG9aNWwFQ6i2sownrJrtEYY4e6RXGjSfCG81/myDFVa8xyCM
         fSjnQbVxKohkjxosQetUJqShHft4uu3wy/ZzNhF0xCoPhJHX4EdFUH8cwflSjPLwYXfN
         Jva3V1ONVvNYv1XkJ22StR1/rnm+7YV9hh2D3a3rXoh+nttnEO2ndyl24VON4ZwNtycM
         H1zxugj/jEHWhO1hjzzMnnRxDTgwstfFlhmiJZ83ELO5LU3gk7z83boivrBadmDIM6r9
         5KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750874856; x=1751479656;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZO4Xv7s5EGkfjWrejC3c1JPjAZceEOiE6U+qYSQBuw=;
        b=BqXZCDdtmeaRWK7D/rM6+xdQvo9wdZAfSXVizkd/CrDMYHf6HlXMozBEpVa+1tB9wk
         ZlD9JrEoVSsDbTr0sy7sp2y8y9nCJ36qLxWOBhPRqx+KLFkSive7VWV7oruwjpAMMMVW
         kOBY6ClmxDo829k6++CyCpSYIMQcx3CdIw+KHCBDnYOer3wlIV2X9NUgXSL55ZBAJTIQ
         dE4EVhVT9CLWT+FV8p05aBqU8WY+KEefo9hoUqshQ6SNkbaCIZ8RVJP1osttO6gmx4mJ
         1OQq3w0mS74irGHmOMqbxuKZXW8IPXNVAfNB3rYplG5vhExviHOgLINEGVr9gLhKeVEY
         rVEA==
X-Gm-Message-State: AOJu0YyhRs2l9EddtQb65zB2Th9oV1ESPdjf9DhQY4uFV/1ISCifIqeZ
	T03df1i/AbxCK9ne9/4q+Y9KowB8tmKVOznCcdGgJlcPXq2OJfdJTMxIOADskZ0U2DHWcd14qvI
	tUBTE
X-Gm-Gg: ASbGncsI28k8tkkD9tTsCzHOLFo/O8jPvnbIcqFL3Nv0MtpEk2DBt5sr2BRfRJEc/es
	TnD0AvsGbERx/bIt/XyJCi7uW1+XOGJ+awwhkLppv0XXy1k2XWTIR0wejGOwca/vuPsAZ97+tIL
	jNOWNQcxsBBb6ioPBB7JyzK4yEh3NHON+RyQvVDSHiHv59V2JrgWjqfPmWgVDE5hZpnq/Ksuo9m
	UofcVGy5BbnvDqMU7EeFxdvxgENYlyeUO7WdvzkoRQIHf6HKn4nV/D2okPHwmPCHsFixQ0FPT1T
	+Zix1Hjebt0ullj2ErbvUxFVAGNszfJ+kjcvWqIKwnNoZ3LWOeCJ/yl5nQNYOqAvSpLbLWRLZb2
	9+FHpng==
X-Google-Smtp-Source: AGHT+IHuGHw2UHQ9YWHbdUAD8H9Y3cr5G0StefN1qB2MCXP18MaxG1Wx/uzHOYkVuGRQmadJh7YLEw==
X-Received: by 2002:a05:600c:c166:b0:453:2433:1c5b with SMTP id 5b1f17b1804b1-45381aeaf59mr43696665e9.5.1750874856150;
        Wed, 25 Jun 2025 11:07:36 -0700 (PDT)
Received: from smtpclient.apple ([2a02:16a:7402:0:7c8d:a722:7ae3:ed0a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c42e1sm26377315e9.37.2025.06.25.11.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jun 2025 11:07:35 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v1 0/3] wifi: rtl8xxxu: AP mode fixes (for gen1 devices)
From: Ezra Buehler <ezra@easyb.ch>
In-Reply-To: <20250219175228.850583-1-ezra@easyb.ch>
Date: Wed, 25 Jun 2025 20:07:24 +0200
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
 Kalle Valo <kvalo@kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>,
 Martin Kaistra <martin.kaistra@linutronix.de>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Reto Schneider <reto.schneider@husqvarnagroup.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8132EC31-A53A-4C49-93D6-70D45600C4B4@easyb.ch>
References: <20250219175228.850583-1-ezra@easyb.ch>
To: linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)

> On 19 Feb 2025, at 18:52, Ezra Buehler <ezra@easyb.ch> wrote:
>=20
> From: Ezra Buehler <ezra.buehler@husqvarnagroup.com>
>=20
> As mentioned in the previous patch [1], especially the transmit rate =
is
> rather low in AP mode with gen1 devices like the RTL8192CU. The
> following changes seem to fix the issue.
>=20
> When looking at the patches introducing the initial AP support [2], I
> noticed that rtl8xxxu_gen2_report_connect() was altered too. So, now I
> am wondering if we need to use `macid` and `role` in
> rtl8xxxu_gen1_report_connect() as well...
>=20
> [1]: https://lore.kernel.org/all/20250122071512.10165-1-ezra@easyb.ch/
> [2]: =
https://lore.kernel.org/all/20230428150833.218605-1-martin.kaistra@linutro=
nix.de/
>=20
>=20
> Ezra Buehler (3):
>  wifi: rtl8xxxu: Use macid in rtl8xxxu_update_rate_mask()
>  wifi: rtl8xxxu: Use macid in rtl8xxxu_fill_txdesc_v1()
>  wifi: rtl8xxxu: Make sure TX rate is reported in AP mode
>=20
> drivers/net/wireless/realtek/rtl8xxxu/core.c  | 28 ++++++++++++++++++-
> .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  1 +
> 2 files changed, 28 insertions(+), 1 deletion(-)
>=20
> =E2=80=94
> 2.43.0

I apologize for the radio silence. It turned out that these changes do
not improve things. I must have made a mistake when measuring throughput
back then.

When testing the TX rate (with iperf3), I see the throughput constantely
dropping to 0 bits/sec. This makes AP mode unusable even for our
non-data-heavy use case.

Do you have any suggestions where to dig deeper to get to the bottom of
this?

Cheers,
Ezra.=

