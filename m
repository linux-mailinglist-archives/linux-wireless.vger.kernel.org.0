Return-Path: <linux-wireless+bounces-35425-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Mt9Darc72lAHAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35425-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 00:01:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C9A47B0F3
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 00:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 010A230616D1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905837F8A4;
	Mon, 27 Apr 2026 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nxkw0L4W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018D536D517
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327108; cv=none; b=I5AA6IxYQxn9u+OqjIFOFEWz1tI4cCahvFEeNY/lfxiwav4h27Wt9Zm46kJQ8Ga7AQFVR1WXtdRs3efBnYgV7knvBggPKZvtVOFvRhVYvKSRKzd4hV09UAeQw02yCHnpQxFipkWNKq8HZU0av7GdVOmTVzG1XJ6c3oz4rylDnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327108; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m8fuWENL0kMx7TA9gCc01tzt7N2hQmf3y7yx1WsVZZqx4BiqBXuVOJJmZA3R/nd7nVHQ3IYYobar5pLWKk2NiRR05zho54sSYExUMPmCS3dKYNbsYEKMzYx1X/p7u6RguTRoJRarZWTcMk2wjymg9NWaYwN4FR4+J4bRlWyy1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nxkw0L4W; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1770712266b.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327105; x=1777931905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=Nxkw0L4WFXgr4y6d+KHgeIPp3bJtsD9q2umC2Uf1o+ju/BEE0KrbH1M605Ik4QAAhn
         SePdOK7IAp4DvPE/PFJcxkMpNP3CurpoHRAB2ikHNx3Tdg+kiE25B4ygvIa10Klm1Za6
         VCv1NyN12NqPGS6K7PMSAGwmQ+LIyQuaRO3mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327105; x=1777931905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=CZJ/Vw3+9yuGsKs+mW5RGXlCdIxM1tvPNf5gBs7CpP2tmcIRUUXHuEcRSOWyOnJp2H
         CffVCSZazOU4kcBYEVxCrrrHZMGnx+5MBE8hCqOOIvaKHqXuu+3kuIfupSMmYDHCg2sD
         tfu+wz1CgU8GH1G29uCmjVc3oBx79DWgATwNeIUiBystQwsJsM+6HnzdZSs8ctAikR0Q
         9Q2m1iCI30aK/FJmH3qqJuS3J0RJzakwsGSujNKosT7/5MdDcBIuptuUuifHYp71o6H0
         bf7/nWetnusUmVqrIJsoq0az+Hr+r6D2S5BJf1xtFxvPnPSVEhtke95BCLEOcEJmRluX
         213Q==
X-Forwarded-Encrypted: i=1; AFNElJ/NY4Gz/52SWtRPq9tSavf5HXzwxE/1NzJT4CynyumPlijdbM3U6VM6mgOcwDDU/XR+TTEE3Q2bBP9Ok7ZKww==@vger.kernel.org
X-Gm-Message-State: AOJu0YygCflQxp0zSvzH95sssYc8c5EO4PdEtjiaUjQmy3iqP4DAvQBt
	n5jrEcahT4W8ogdnZhi4Btjdwa6+e1oj0t9TIOgjIQgVjxMzgUBp1+durth6Oiuzj4yvNaltg4i
	0FOGzTJKgGQ==
X-Gm-Gg: AeBDievOIYeE0sFLXOUSw2uSqw2IITZq38IdZdzpYdOPlic3sqfM/NPhFN+KXFDQ+P/
	GVLgBcnxio+BdHA6YWJk0Tlzi/nLq3K2dQlByxrYyD1fe8FAo46PwAnDs7EQ+vGvI0IeuhU9hvl
	DzXd9ikHL28qbURXLmwGsCGJWRiC7OrEQISxmSnSWuQH9uzBU8PWdWKm+5nenpTe9QsUg+18g5R
	pKkTOMLHDnwJjyaPTIhXxsPsxdy7wLEYgMlJyqzLgNWOExtkG+E4AKDat18iHW8JmDlIN225x60
	uhBhQ7RqEfFbMcxwMjA1eQ6G0ihKXs2cEYrHo5ZNQ2HvTt9RQk4UJQh204dYP40yNcBZomxE2Ci
	8PDPilKSp1429eqcv7rqbIAYm+4UcrDrlpVVVMeySATgKQFzUmIkme59Nw/Bp11rqj7nJbXcZUc
	IRMHybkVmu/vWvHpTXB1+qvB6hcH586BhgQs34BWhlM85mhQOpyjtN1M2/5fc+rgYs/KeIrWYuK
	mWk/1O+IDE=
X-Received: by 2002:a17:907:e146:b0:bac:6d85:255c with SMTP id a640c23a62f3a-bb801bce7d6mr17679866b.21.1777327105302;
        Mon, 27 Apr 2026 14:58:25 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80c0828d0sm9876966b.56.2026.04.27.14.58.25
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:58:25 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso10759644a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:58:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/E9bYSVSwfYMV0uwuh4qy1IVoOpbJxhK3H7QljxKBBOa13yZgJ+QrCKxWnlreZlLZxnQDDB/+Gr3nYGPcWqg==@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 24C9A47B0F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35425-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

