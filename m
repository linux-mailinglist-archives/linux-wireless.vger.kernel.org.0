Return-Path: <linux-wireless+bounces-29622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 649E7CAF84F
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56766300D499
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD9B2FCC04;
	Tue,  9 Dec 2025 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fKTmBWiX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6102FD1B3
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765274206; cv=none; b=cPJn4DD00n/2XcMn0KASrpTQheo74vhdT9yz8+GJoFXfGtwY8KLLZ+es3/NA85E6SniLj3IlqMD+yo3f/3T3y/NCHfeWC2kCBnn3y51VS6BLRR9aPzheCegS6IQ6vrlCqBI4Bp/zRyxksvYc8brcfkmk79HZfLs8iRwdGmp0ToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765274206; c=relaxed/simple;
	bh=jm3XX331lc84J55flGtiwfJlZ6w8mFxpIaHelyD1weU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JowbdTJHB1ISzsRP8Ybn4ztw7+LdYLaZY51Au8/rBE4//bwckyyqx2HdG6xdz2E+Fiu1dVneewItm58XRxJSeqIWsup4zvQHeFMlfG0cldXEjUIDV07XJ+4lM8UjsEDJH+bGV4mwbpxcI49zqzYGdyz4HBoKVr0BxXV+m2Zkg3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fKTmBWiX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-594330147efso5920758e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 01:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765274202; x=1765879002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c1mWainHbP6PtxYP8tSRq2dOg37f/54kFiM5MeSFCo=;
        b=fKTmBWiXrCTl0+aruvdbkFo2P7Sj3iQdsQzxJnkptKTyFMjyEcdSIBXY3i5vSPSvil
         ilrotJ+g5klj8RrKrac/9crwXmBpm1k0tyfjW8DtW3sUWsUKrQMNKU0isPn5OTRa9OEH
         0W3mmZ+WKznxbV8Ia4PG78QpmVRDl+yiRjaFHRejx2t0sfrwOO4wGiqzXi301pYV1CHb
         5sDNW+ELOGh2Y0bkz1UK+172k8gb2650F8rSqvxMQjmA/nbECc3hyCO8MpGE9EWPF+l0
         VsaFVWrRhVht4uw/f02Lx/YZ/GQ3ViQnYAFkQoSGcfQNNrQkv6u3KDyxSZoiA51LyEVO
         rXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765274202; x=1765879002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5c1mWainHbP6PtxYP8tSRq2dOg37f/54kFiM5MeSFCo=;
        b=a06KBm083ZiWLdpRKfp8vUc5OkFKV5Pu1hagAIRR2AvbbIg0933xJWcMZwFV79Zr2w
         sx88AnJfyCxEfLhkAghwObt2Nmf5WOnAunijtRquH4P7cszywuGGZ8bKf6ob35BpK2+x
         ahsxZ05dGlU0xyx/sObdBT1aDw8jARInQMbZuIBv+Wb0olpziUbQoQUE+9w98UGQYPkJ
         TFqVPNmxhRkEqh6p9xmCMV0jzvHSc7aFr+16xrBlzIcdEfeEP9whPST3CrYukIT7uJVd
         4Awgo4CCi4KS+iRdkp3ctWvbGHCQTx80z02bQ+LVeAfsQWktEBZbcIY8iFPxR7B29jPw
         tMVw==
X-Forwarded-Encrypted: i=1; AJvYcCXs9zSA0Wb2bHOAOdfzXFBUzI9BtwL018KC7QQn3lf84MZtPEnxFWgEj7+uR5jDf4GZTBL4fxw0GnN+PnvTVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXbPDGXbSOYywzfvnxKpKbf3LCwOPabREMhX1b8KTOQwv0YHkB
	gLLzV/ZEt5mSxWiyFd/o6ImlUlAKE79QhYVZRuMkWotgLduFNqRohEj82wnChW0YkAbMHD+Efeh
	qN/SeXQLZLxDyoucSAXQecWzW7BkwRVgNAXuknSwYLA==
X-Gm-Gg: ASbGnct92EB6UHaSyPYBFShwhn5HxWdGqli+QsCBZi50FMqU0t1pjyJCnOu3gnl88kF
	pwaip1eTw1lZ8qE8I/MHpHnFvpOOPsxPnaAIj1RKqj3xfRln4UlBOXgk1/fiTU0lv/LhixvtWZn
	BpGCr13zMpnUXAYnwUBasR4DZ3SDsltMHcJwRJtISSm9w5pqqJ8AG22fugw/frW0KffRDrN0whj
	NMXhvP4EhvFevD6+pUlmOaD40M1RtL8ridNrVtJkeqDVLAPGIJrzO+JPDlwWQQgKk4Dm7x+W1Fk
	RUqlZHEYna6kOkS/XBz/GRheoOOi
X-Google-Smtp-Source: AGHT+IHQA8LMhz3PMS7bVzth73MQ2qUI2QeYp7fDXja9n7h3kytkXkhUQyqYQaFxN1YcPluw29UsDBFs2c4nIo12vdk=
X-Received: by 2002:a05:6512:234d:b0:594:3503:d864 with SMTP id
 2adb3069b0e04-598853bdd42mr3139270e87.45.1765274202412; Tue, 09 Dec 2025
 01:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d57efe48-b8ff-4bf1-942c-7e808535eda6@gmail.com> <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
In-Reply-To: <dcf31afec1614ce0b5e6c6d7f8cd2cb9@realtek.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Dec 2025 10:56:31 +0100
X-Gm-Features: AQt7F2puKmP4sCXo7rVpivPFMBJpIjoyLYFsBRaNTcdFSJbjZBIa-EUA36wkcs0
Message-ID: <CAAofZF4Z=O=q96RaTUKFpXiLGEYU84JB+oqfWtTc2njHGgC2Ww@mail.gmail.com>
Subject: Re: [PATCH rtw-next] Revert "wifi: rtw88: add WQ_UNBOUND to
 alloc_workqueue users"
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

rtw89On Mon, Dec 8, 2025 at 1:40=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.co=
m> wrote:
> Hi Marco,
>
> Will you send a patch to point out WQ_PERCPU explicitly?
>
> > +       rtwusb->rxwq =3D alloc_workqueue("rtw88_usb: rx wq", WQ_BH, 0);
> >         if (!rtwusb->rxwq) {
> >                 rtw_err(rtwdev, "failed to create RX work queue\n");
> >                 return -ENOMEM;

Hi,

The v1 is indeed correct, sorry for that: WQ_BH should be per-cpu
because it is executed in softirq context.

Should I send a patch prefixed with [BUG] in order to fix it or the v1
could be used and we're ok?

I noticed also in 6.18 "rtw89_usb_init_rx" is allocating a workqueue
and is missing WQ_PERCPU.

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

