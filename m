Return-Path: <linux-wireless+bounces-35423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJnkNRfa72mvGwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:50:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2AB47AEE5
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 23:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A6D3044BBF
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2026 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AB023505E;
	Mon, 27 Apr 2026 21:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AD0zdoIb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A9373BE9
	for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 21:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326345; cv=none; b=tiT1K9/6Ci9dSlAcc1dMhMupBYBHp0rBuR2pogzi1JqqUdiAzXEFYsFTxAsaBOlasxPDwKUE4l6MTkMkndT0UHN9igZ808E1nWKRiCZH4ZuFyxUfb0WcWD8kV/LeUf/ETjovrGhW2gJOx1bpVaKZc16iRhBmaDfOxunBnSjZ2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326345; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4aRVc6aNZXNBW/IcisG5WVlXfTBemGuL7p5Pzk9zQbLV8wU9uJebS2iopzijfXMR7iZxIY85mDqMkSs4Ix76hviOYacDVe8ntMjOG6DBkj5gsVaJvf6tEVlBx1QfsHZr2s7mCd7OzwfwJglW0i5YIal/D18OrmN14wY2UU9GVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AD0zdoIb; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b8f97c626aaso849420366b.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326342; x=1777931142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=AD0zdoIb4eC/JVHSjbM9DFD+WJbcHev1pXojDEytaAob6DnClJONAk6NjbB+wn8wwk
         FqeL4lrtTmmNwepBeXZXI0NyWyGxUKWdo7KWc39P9+jwBfsFR2KDeuQnyYJRIRF07f62
         QoxsI/kWj1s6MpzS3VJQ0VxHhahWn8Up6+O0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326342; x=1777931142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=Vn26FP80ZEPwBVwXc0qiOjZPQVNtRqflOg0HFyi4xEuwUBq+SLZ2NpsngHC5PE9OId
         nNCk5qVHvLW3o4YZgIM62YaoKV4WikXvQ9Q4HOOa4k3Gc9BYhH14Aer3vEjZbmo66lke
         8SZbHRYwxw2B/yZXpDDq3nttDwiOzmgttwxZB+Q63d+3oc/XDq+S7M8RdNV965XcxNwG
         xOicQzrm15vVuDXz2uUX+Vn6sfK2ALmmVf/xAj1cBvFn6HTbYQ2J4b2nYa6d2cJyBJyC
         mzK1mkMcZ9IwAxeYwP0vEa809HGfwHdIM+nRuPHPIMYgreKLXCRDd4uOTnf84H7152qi
         fT2w==
X-Forwarded-Encrypted: i=1; AFNElJ8R4LBTgKFvAZYsbhd3pIska83KhIb6G0he1FHzJTgeIkSSajzEiIZ5GaBzlI/8En8xvi21gch0vsTu/empvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGpNdHfglga2Fm0U3AXvRnVj2BbRL1gRMY4bzdkyts68+t7DV
	nfb8Qk9jDhRSO6t9R82mqJ89RGynFWULxA2owl+sfWYU9v2fL/NqEce4q7B9UuYojgcQHdkKZTD
	zDNrPhrJ+Mg==
X-Gm-Gg: AeBDieuwGZdavDRk0wB/sO0MUSUNFEPkWYX9gFcnViLD1Ea4WqwehD+m/hlpaS+r/ed
	LN7n4C6kdBphJNpTZAUF4A7S3BY7kktmgTKZ3N47wWkk+BNVzgZDHR4f5NGimHlBtlOyt5JLkmA
	yYnCM4l3rulHsmFTGLMQlbQcuDehoD9R8Td4PUPgSE7eU86rsDgDfgezdnfLiaB36Jp4Kwsp1SV
	0DbFevHHuyB7okfsGh3zoOH7mZXl6hi3zp8/xbsedJu1zCEtnoebITmxkf3Pxe+z27vTAmXVs6I
	auTiUERSEOIFIzMKxrwOzaRSAmhukCo3UhWZ8w7c30aWwtuNgqChS6cihqwLNq7ZbEbv2RtkwvN
	lDZkbH6qalqpZ5B+KjpRxG5iwJ1YP+18qE/YyhbLrGliIdT7Bsi2uONuURy8Milxh5RIj8rwkNC
	HGrBCMG54yVx8t+sFkM2ZDsLs6xhpDYJdVn0kPrfCZ4s/W2L77kfx0Ry9WLvw9B/a6Qld/EKQ1E
	dr71Y0ooRuRooyZR2+ZMA==
X-Received: by 2002:a17:907:3e0c:b0:bb5:8503:fb03 with SMTP id a640c23a62f3a-bb8047283a6mr29919766b.28.1777326341260;
        Mon, 27 Apr 2026 14:45:41 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb809023ecesm10079666b.26.2026.04.27.14.45.41
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:45:41 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so18827472a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 14:45:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85Wge/NJrnUANVD49dPO36uJVFwIQ+KZ4cDDAQWZ9zWhYk9w01KkjqfViBf2oqugV9HP2uzHqKfFS+NDnXvg==@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3E2AB47AEE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-35423-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim]

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus

