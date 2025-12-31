Return-Path: <linux-wireless+bounces-30201-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BF3CEAFF0
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 02:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC504300C2B4
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 01:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47F91F37D3;
	Wed, 31 Dec 2025 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U/TiBN1O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC827FBA2
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 01:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767144454; cv=none; b=rpzR0yd1rniVi53ZpcY6jrKGlTKOJIqJp29qA2XssqzOP2gDVFg3AX4IgOi+r3Qv9MnHKZQz7Dsq6Tk5MqdIxZa+BCpHBdpcNIuyiYdkGnOIXZOOUcerznhkgt4pS+IuQ1haU4VRH90O23GEYqf+xB9ws/dyhwJKPu0VenZ8RII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767144454; c=relaxed/simple;
	bh=RcopRd34S+2zZK6p6+FlKPBdVjoWshquo2wDSP/tETI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gPrTML2IPlDnq/PcGz0pTvY6GvhaeYFvlRppStBWjgRw+egw4wxO8iG8UDB3327sxOWJJeJFFk1I19R9URlZQFnohw9d0tVsIafIfDZb3CPIw506WG4ZxK1QSgtqy34GciSkt4Qmx+JmPl/vn5YPqmDh3iFCF7ZMKGD6SXhTRB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U/TiBN1O; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b804646c718so1118107566b.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 17:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1767144451; x=1767749251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/c6SVq3C/6p3QmBlE8qRyzuxT87KjBEE1uJ/bQ91nLs=;
        b=U/TiBN1OcYngp+mg+MDCqsEIYVZRYfhaWMcxo8zoWfrMMldbWIoRp+9AzwX7r1omMa
         DwZxdFkqzcAh5HgJe0D/XB/Q1cBeHCCXsEgOySvehht16iC9LqoO5VOC5DGe4oKD/Qke
         d6pUgr1ex4M4S0xpdH2rckBevnHyrMJDAXcJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767144451; x=1767749251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/c6SVq3C/6p3QmBlE8qRyzuxT87KjBEE1uJ/bQ91nLs=;
        b=fLHcJ1NbHB6FlMtk4BbW5uohDAtW4fZZt8k3aJ+FBn1Px+B/gbZCF+3LuorWdpI+fl
         CM0NFaqh/bnhqFdSjtPDxd8uzFt5fJ5PZep4BZ8Azactrdg9o2ba76J9szmIEzj0zUqN
         PQHu4pZtnFjRvxHWTBba3u/BvYkbWS/FCyyRtwgnNrB0XZS+RJzb9pIo/AKT8pshC3JY
         5YRP7cfxqmv2rt8dotXBWZOveH/ozAVJzZArUazEguhPCSBatdpnyr0qy+gPcC9rnSMa
         s24CpCkOBfhQaStxTZLOdOG0cGHheSNrXiO24JDctMVe2K7vy3oW7FwJLs1mx5dCSLDZ
         JYJg==
X-Forwarded-Encrypted: i=1; AJvYcCXwYBmJ6SKF3NOsyD40hnNRNwX2f18kvh4PFbt8GrjDmez4ZtKLfVHQbGya8C1hhOGWemTL2fMnul8eOG1qPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOY6yDHo3MdPGTrsPkCgWqMH7WTURk1dAngs2ty+u2xdhySMe
	4PJ5V94qT6hm/iTXSfPF/8mBpqxu1TrKAGhwq9+QwiHZRygYMFCXM5zvb6QvdWdnWhpI4kP9Zj9
	S/TJqCuY=
X-Gm-Gg: AY/fxX4+450P3AfRF2cn0VpAr8Y3J11v6YjUv51GB2At4/fRElllU7WtGCGNTLHXzJM
	lsAZjRPwXCovuQnXIGwOi3gjc0xlcp5fR/zdep/LkNW2FHsOALmxlCQHwdJ5Ok2oC4/1SKAWDCF
	0HaOp7rtOMXBfJ2DouwiVj/un80DgaZ429kbf1SZj8uyzzBGmhbtn8Mukt0h50chqBzdMJ1A8s/
	JfTBxri70kyvdI3R3FyddHRFlaQ5wzFLYBeoXZsUHgV7/RDjK4vtX6H95KMl7/rptEJ32YvU/7A
	DFJte0/N1yN34mhBwQQX3gUFEWJHpVrtqCB2OWEVnn8zalHgwaf5zmFlNsqW0LIgyHoFnv+kiaj
	6mBKi6ePvypYhHIK+L8+I4GLC6/pbKx3BZnKH72sKilMXc2Zy2wiGgYQl93o5aEybHN7AQbPQ54
	Z4Np9omsGQN6/1tZplL6NrwtopTslwTxZZbqlSFMk7cLUkeYpwDlQY3281IlFz
X-Google-Smtp-Source: AGHT+IHsEMECIWp5Qj+dPRYmNQfP/dOSbv8/X4g7kqx64uLiK7Vo2oWQhL5bIL0Hlq3fdmt6g9HThA==
X-Received: by 2002:a17:906:eecb:b0:b80:b7f:aa27 with SMTP id a640c23a62f3a-b803722e390mr3729610766b.63.1767144450628;
        Tue, 30 Dec 2025 17:27:30 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f51a74sm3917786366b.63.2025.12.30.17.27.29
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 17:27:29 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b832522b47cso604342966b.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 17:27:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW7cyx2bftF/DkVXlt+oLPolyqXhRwPZGUnMVoHvvlx6zwMLPLC1XBo4TSIBvJQPoTo8MNUdClYNBvU8vh8Jg==@vger.kernel.org
X-Received: by 2002:a17:906:c108:b0:b6d:6d66:e8e9 with SMTP id
 a640c23a62f3a-b80371f98e6mr3867217966b.61.1767144449430; Tue, 30 Dec 2025
 17:27:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de> <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev> <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
In-Reply-To: <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Dec 2025 17:27:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>
X-Gm-Features: AQt7F2r8OZntlpbgM6EMdT1QVs39OIAPruiONmqMbrsqySDpE_sREcU70uzNBZw
Message-ID: <CAHk-=wh6WP0Wq=rbC2Md6vsFrV-+nvDjxgfx9NpMzUmVFNkJ9A@mail.gmail.com>
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Eric Biggers <ebiggers@kernel.org>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	Mario Limonciello <superm1@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com, 
	Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	linux-wireless@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, 
	shuah <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Dec 2025 at 15:57, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> I would recommend reverting f804a5895eba instead of trying
> fix it. Then find a better way to eliminate extra newline that
> shows up in dmesg when firmware build date happens to have
> a newline.

Yeah. Let's revert it.

And the way to fix the extra newline is trivial: just remove it from
the "dev_info()" format string.

Our kernel printing logic will add a newline for the next line anyway
if it is missing (unless somebody explicitly uses PR_CONT).

Can whoever saw the problem confirm that just a revert and a "remove
\n from that dev_info()" fixes the output for them?

              Linus

