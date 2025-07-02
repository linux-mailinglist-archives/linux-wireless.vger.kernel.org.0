Return-Path: <linux-wireless+bounces-24767-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9469EAF5BC5
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 16:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56BFE4A397A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1C630AAA9;
	Wed,  2 Jul 2025 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR5QI/Hf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E0E309DDE
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 14:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468020; cv=none; b=VF0eUdnfqkaNyO0782lyNWNkxheYhDcZ03Ec6gR/6ZMFlhK4XJjbN95VWvgEZB1OkvBREXpQ9XmT8YWf3aK+AWK50BPBwS1KmxC2j4awmHX5sr9j8JnfaYBKjBjMm1DnM+dMC4Pl34a6wURTep0l4bqW+Pk5HTRobCLFEPyKSj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468020; c=relaxed/simple;
	bh=beP7drDYJiC2bUAZWTxtY2Y/4PtwO1+nbUvqiOO5/vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7aqPUc3SMpEbAIi6aW88qOCs9RUVNI677edvKUgDlt9bE1W708Ya9R/RHgE1czzMK8FWCssQ2lwoX49XPuqGEsFhwRyGqCYXOqO1aPs7CgKjIFtFztdPf9+28YVROUh2P0UWzOZph1ADrBMOOum1QzVuSl3LZNt1Im0xDV36U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VR5QI/Hf; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so780443066b.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751468017; x=1752072817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPM1T2LNHQfKhij9F/iyvK/25eoDUaIBSajpXKOmcoE=;
        b=VR5QI/HfpDvDDgUWKgpZZDXDO7RKI5RHqhcvhjy6jQ3pWsB+Wm9XQvVYauMtbYYdQ2
         PWHUEd/0F/pPU4OJTNDAK0/68DCMzz0f8AcPNbLaX2VvyT+u1dhN4q9rz4ru/KV6E0+n
         ttE0JZ0mEXjW2/Dufsv/EYTVeRq4joFiGe5LfPOSf/irNmgIAUntyCKcFiUDcFNC/FcY
         8jTcYSn5otDqn1JouKl772Q6MJ/+29JWRysqG0KkG5bbyf5/vRtt6/WY1CVvAYneDAAm
         h4tnuwf18ggr+dkY0KhHvzv6llwMvupYukU17oBQMJICzKeHuTcFE1AsJTgjaeZy7nI7
         fvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751468017; x=1752072817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPM1T2LNHQfKhij9F/iyvK/25eoDUaIBSajpXKOmcoE=;
        b=EERzLgbt/OCAKaPIhmRmV52n5oI51rzYs/T7raGoISokhibt0XqpVUSsZ+xhYGMeZy
         MlYyD3vTAgF/EusEIT2/yba/+U9WMllp1A/QNabPK+zZni9GixE7FbbFsXAnnOmD1OvA
         prnIRE+5szbAPYzNHi8gjGf7sLGeaMUrK6J9uHZaT6fm5MojcWND3ZvtgO4v2Mifa7Vz
         OB6DwtEPQNJBRSpgWVOnYXGXOKQJqbk5/7mbBsJAr5CppOPaVt4KZ+FJWvUfTjapMKAK
         FWDs1EF5/uojzi5YXvxOBO9msApnr6odu+aLZaJ5vbL1Fld3MxGYpc0ZJRoyv4Z9gZIc
         Tgag==
X-Forwarded-Encrypted: i=1; AJvYcCXxCHuHEcCe1oq299wTjPY5YYU0PSieHw/A1qltVg6bbOvJABP+u7xdIE5LWRgv2uTYrUf6hJwN3Zo+7/S6YQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyXThuzamrjpN8QizR3tWNZqyu7V2MQqOpHwmeDhc7GGE8luKd7
	F6ImBvcswsavpPoaYM9wpu793AweQy8GnjnIBJaevIWAEkPceiWvtqz4Dm9p3aZMBdVf/LWDXPf
	HdBOjlUDG4uGmPU1ZVI3b+AUHfulNWqQ=
X-Gm-Gg: ASbGnctER7n6WcjAqx/TBW5c8bGeNbDmpJnaEIlkerc1AM6WVdXHvnepsNyPwui9Bwy
	p91ZGoX8spJM7cCy2BUkToDXWIqU8Jl3gAxrLvpURMA0R3/mwJtKdst/Et72AftMoUyqIx8mMWQ
	bhU/QRGveTXx5oOsQ8BNRpo8WfZ+3DbB28P6/uUoQ1W9Ruaw0+6YZKEpNJePt8NsH5tJHCwFzcj
	g==
X-Google-Smtp-Source: AGHT+IFmjVcaAlwKjAztbNsqFiGATow/TiLkiXA3EwSVpmOxrMIFRhzcapgfz5nrrTRgAUyHU/AqUz9S6WnnECsyKnc=
X-Received: by 2002:a17:907:db16:b0:ae3:cab8:d9d8 with SMTP id
 a640c23a62f3a-ae3cab8d9f0mr175432066b.41.1751468016986; Wed, 02 Jul 2025
 07:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPDiVH8gaBH6o_OY-zUWYpDbj5mhiqmofKGb71gLgHOi4vA=Vw@mail.gmail.com>
 <0ba2176e-3339-4a8b-850a-ca5643939c8b@oss.qualcomm.com> <fd3bd8b1-4108-445a-b65f-4769d73e6e63@arm.com>
 <4a13d862-1bbb-4a98-bc1d-219bf78f7c0d@amd.com> <CAPDiVH-kVCUY8DKexT9OqAZsvkZ5_CGo8d8nENYA-kD=s_x8wA@mail.gmail.com>
 <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
In-Reply-To: <e008afed-819d-43eb-8895-2c7aaf24ec13@oss.qualcomm.com>
From: Matt Mower <mowerm@gmail.com>
Date: Wed, 2 Jul 2025 07:53:25 -0700
X-Gm-Features: Ac12FXwmRNy0XV6HfwF_miAtw-Zu6Zd6a4pUwqmVNkw4VdKWa75ipABJl-DtuBk
Message-ID: <CAPDiVH-xPDmx-KQx7YJY=7+kwJNbGY-rEu-w+cz18p=kjnKFsw@mail.gmail.com>
Subject: Re: ath12k_pci errors and loss of connectivity in 6.12.y branch
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jeff Johnson <jjohnson@kernel.org>, will@kernel.org, joro@8bytes.org, 
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org, 
	1107521@bugs.debian.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

> Matt, could you help enable verbose ath12k log to verify my guess?

Here are kernel logs with ath12k debugging enabled:
1. WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
   https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x100301e1-20250702.log
2. WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
   https://cmphys.com/ath12k/dmesg-6.12.35-ath12kdebug-fw0x1108811c-20250702.log

I captured these after setting CONFIG_ATH12K_DEBUG=y and running "echo
0xffffffff > /sys/module/ath12k/parameters/debug_mask" during boot
(using @reboot in crontab).

