Return-Path: <linux-wireless+bounces-29025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E01C6371B
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 11:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5753D3663AC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EA285C84;
	Mon, 17 Nov 2025 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CvxC1klt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C25313264
	for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763373782; cv=none; b=f3P9u+FKTgaZ5sAJeCe3cnsP7YWSPfZf9y7Ivqvb5wqweMwIRyM5GAEuSKORcEgsYBHOpE/kJJ8l9lRAd1pkzzyI9VcZdp4w+QcTl58O0QzNpLHe6Ww2lJfhFFSyjyq2v95ZOsB0QsRQVkLnIvTSrkqXE2FDjw9t8GoB3Jndghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763373782; c=relaxed/simple;
	bh=kru59UOgOj15mjtL3WWCJL5AP6Lm0N42mIehluARFdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdFR7R8HNgfzvScXBA/U9AacPYwBBF1RkbtaSDAXKqsI0AthcjYQvhq+NIcIaqbweNEcjlCjJCzdYpBTY/XllMP/5m9Kk8kY7J1t6U/jNQRyAo+HMkgQBzikGYxiGqDVnYbRuY/khVek/bBCP4Uu/3nYAbN9HOR13KKrSrLeKIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CvxC1klt; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-59577c4c7c1so4777033e87.1
        for <linux-wireless@vger.kernel.org>; Mon, 17 Nov 2025 02:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763373778; x=1763978578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kru59UOgOj15mjtL3WWCJL5AP6Lm0N42mIehluARFdU=;
        b=CvxC1kltgJkg1YLYInuyTAvvXyi1wjk769kNnEZTAS7SW4AMBm9q6Wk9KyVb2cs3B5
         LukfG41loL0kBca1V0QP9X1Cv/h2QIWrpSgHpY5SxOzhFTVTpb2BKoPYRS+kTesAtAqo
         +se+0tLyyWjJWQNYDej/yZYl5Juyq55t65M2/2VPe1HrLB4gDZmz3zuO9/7XH+JOrZHb
         IPqDJO3lUHaeVVNLV2JcibdnoN0h56hYfgkmHZ1zMxxLNM3ZpXhXo8LDYrHYt6MtEjsV
         ZG3dQZN+FcSLtvk4b7GECSCdW/pWSY/UOZ9225edLAktVDjGrabR2OfLyZE+lvdiGZ2V
         9bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763373778; x=1763978578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kru59UOgOj15mjtL3WWCJL5AP6Lm0N42mIehluARFdU=;
        b=QiDAiShOgptXZ9sq5LOI64uFn9sBGT1Og8tyF8dkUBsBiIhh2uRE9sXkCL/BZ3omPJ
         7c0O2o8BcbrEsmNEaGzpighGZEhVAKejdn5ECNvJBH9dUN2OFgQZgwhqRasNZccKJfp4
         RJCZZmkVXRqPlhUvcVNNSrShSfcrtVdFkmpzvcroenqKUdPH54fRti3Rr+Ww5iHjECTD
         6QSpg4twBMoUtuAHl1NMC93CvITyiHiM16IlWworhvGhWYlp7zwLic9NUJLjRdJCgqeL
         yifRLdeshRjRpqT2wSQPdxvi9xQoHdS8O9NTT/JtxgFGPWRY2IUxLWVb2FcZOMhmoizL
         rB7w==
X-Forwarded-Encrypted: i=1; AJvYcCWzFEzrwjhLd2aHSnsr+BfbQpFNfpE8Mpj1vMSV113HTwSZtxphvDuWWELeOhoruEsoi1totljY5JaoU8B5ag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi4lpEsgXi7NSKm2J9kz7D982rmAwAS1BeYuJSNHNKIbhcvg85
	nqUhmC6TTwoH+ucvLedaH6Z/elScuCk7rvLgCf0LWy1uDoF7OSVILYkUG+gflSMtJl4j8qAsquW
	vu2mufk9jF8H895jZafw/Wo5Pmfm43yQEwe6dPf7lZQ==
X-Gm-Gg: ASbGncsMRaVQ39FZRSlQrrRvxwIYP/L9g42plqYQjhwLsuWlaHUjW+Ofc4QhvQrGNAk
	oU6DJDhGeIuVpe/iHXfOz7bGPMCY5OIWKr9e/mGQVMY4Z0cbs2wsZPqErcEztZ656UsoY81HP3t
	K9fFiOHglf+jTHGLqlE1mLiTT3orCJmGnNcXO+0jXUh+M4RQ+jITFe1j2vc7h9wwNhi01wTFVFU
	JogVRLVMUkyfEV0pEJ9epDLQCj9/nAOZq/DwEVkTKKhX/AOVX+d5upNFxcr4r0HgUXrODwEFAQU
	NsdFF5uUo7hGj9ooSOQ4TVlF0tmi
X-Google-Smtp-Source: AGHT+IHhYbYREgFfDc1RL2L1STvgiP7jb2aoLbUIARHySU4EG+BvwMGM4Jw4X/3PaZTW/Kpa+FhTTnpPEBZHRpZm4qA=
X-Received: by 2002:a05:6512:104f:b0:594:2876:c901 with SMTP id
 2adb3069b0e04-5957ececcc7mr4606968e87.25.1763373778306; Mon, 17 Nov 2025
 02:02:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113160605.381777-1-marco.crivellari@suse.com>
 <20251113160605.381777-2-marco.crivellari@suse.com> <e3b57536924b4573ac61de3f24af8a9f@realtek.com>
In-Reply-To: <e3b57536924b4573ac61de3f24af8a9f@realtek.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 17 Nov 2025 11:02:47 +0100
X-Gm-Features: AWmQ_bnXuqyNK0geAX05CaIBjhaJMgOWKetUM2GTtA9OxxGhJb-wTrrS_Ni8zns
Message-ID: <CAAofZF4RK7Dt=eJAXjn0Nbmw4rR_RJ4Nc4P3LkmRDCE_dvK6dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 17, 2025 at 1:53=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
> [...]
>
> I think this driver should use WQ_UNBOUND as well as another patch in thi=
s
> patchset.
>
>
> I feel most user scenarios should be WQ_UNBOUND. Could you share which ca=
se
> uses WQ_PERCPU?

I think a typical scenario is when per-cpu variables are used.
But this is not the case here, for both the patches.

So yes, unless there is the need to have the item scheduled on the same CPU=
,
this can be converted to WQ_UNBOUND.

I did the same for other series in other subsystems. If you want, I
can send the v2
with the change.

Thanks!
--

Marco Crivellari

L3 Support Engineer, Technology & Product

