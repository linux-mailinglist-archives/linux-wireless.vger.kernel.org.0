Return-Path: <linux-wireless+bounces-34653-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIzWBmxe22kLBAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34653-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 10:57:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FE3E32F4
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 10:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D5CE3021E4E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 08:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F9308F39;
	Sun, 12 Apr 2026 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmk25eS0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AD31354C
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775984199; cv=none; b=avXV2RzHUAOlzyCwFm51m15wA0hdRZNSQQeGBFn20TznSWmeZJmRYf5BruBm0E27XQ86pTuIY5N22f4JASqFx+dnswzneNEsERtambEtsFEuTpw+Hrc5IMldRUW0QDW5lX0HrcudV7K09wPdGOOTOubsL77h6SnGycDNP7wkbHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775984199; c=relaxed/simple;
	bh=XZtsBYJ+xUzK/w66hhh7L4ep5/Nv3d9zyXSTiNiHtzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBob1VLEdl1atvMzGDs0etxC244oFJtMYX1AdWgnFihD+AU7zegupmZAjnW6yk8Pa0oXr+P+fvoPGSzBxbhbyptXAd3G69clAMaue5FC9LCNVY9Hh9qoIEcAOZoNYKmifZkdt++NpAeeKNnTcQmQ5owvfkSjLT7qbYWa0X7k/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rmk25eS0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d70c30767so265751f8f.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 01:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775984196; x=1776588996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbDgrbrkQIZIzHMqS4zyFwb8jbE/7QCDRz8zhtNheE4=;
        b=rmk25eS0pD3r1W6fBjCHCIGG+xosVecWiNg/3nfNyAKaxOqHC0aIxIp+bwKvPu9+1j
         fAU2vugkDHatrG3Fzq7V9jewKzPcvw41odvofwZkis7b1Y4DeW1IWegwg5QbXQj7kCio
         L+ztGdtDUlhH+iJPC48SIdv4mbiVxmA7Be8JQhGglK1VOqWIq1YR4dry10OotSVrXztE
         o4/62vmfM6KQrUkxwd24yP/lrxDf8HyZquUshVzt2ycEVPZUv3y2nMTj7GvueTw7R7E/
         WKG3HtUgcwPCHxCI4T+H5u0NML0HalT4/vA4x/F5vuumDuC+b3YDtjggzfClJhOrbI7r
         R2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775984196; x=1776588996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbDgrbrkQIZIzHMqS4zyFwb8jbE/7QCDRz8zhtNheE4=;
        b=iqo8pJCD05GogXIH9k5St7N/prYzkEGJeEQ6liZwuSOWuwC87eZEVvLP8VBZoCQNEp
         CV3Ri/K1sPVPeTx2hU36RALV5H2ZZEn6c/EM3T7wRUaxOXYkZZOv1Ky4imzeFtshFPyF
         ODTak06IcLTVyRaJ5sRbkkn4xlh51j2s2YoW8qTKCZ/dHhxqZUIuyeYxfPHu+vSeNCXA
         Ndo/UwXtl1ljrKKBohJKSIKgqZabAxEqkyllWniHj2nxU8WV+hgVML0b4nyGWOLTLB5y
         yAdYMLprc//4/hIQnWxViMqDZdI6lQk3IMuwEU8fLhwRZmgJFJvIL0HvMV1UX8FWBHH2
         8jfg==
X-Forwarded-Encrypted: i=1; AJvYcCWj+K4VW/8g5ULh+GK8Q3atCsdheRPl6nVY2K4a1kyH0m/vAPJJHgkJjM62jkOsEJfqlozQqwAwZVWMeo7u3g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6mKn8vjbpprxr3rP87n2Dz4cumJtEhRfyH7zq/W13B+hApka
	azSxJotAIpGEP3qgqYxmsuk3NdapbOcn9e0/HvhaeTizZvZ81i7Wd6q7
X-Gm-Gg: AeBDieuf7rMS2GhedWcl24DBoRKsh4q79jbztE/9tAaKoYvrpMGu6kfIfLdBdcxfXmz
	plLPKRXqEYhIoaQZqSBCqokKK0zIGCFFsNQhQVsGheFY4+Hf7bDm3Pj2QxmgepLH02FMFoYr4BE
	Bj5PSDONpr+4PpLzzLfV9NpOHJfC96pgL6YPMHxtRAMuHjP95BuqaiODXHqX4S8PwBVqLW+lsoe
	iBsG2tt/FMfv45MIznozlGrvwoMpvBhreh+H/7qZ0JITA6xnd4sPrisPPoSeywg4CFV34EWCO7g
	aAFBYTD8s7JYvREeg5+dxm6sqxmPqIXExzZkups1zC6lxgeXIcj65y22Gga8Yf5kFV/4k8F0F/9
	4uFzwBOXbdd+iExptHHGhf05Mzi7hTA9wT7upHYNm2eAKSnU2ge1wb6AmgOWF5S3Sjy4j5/oMHx
	0+MiXEUiMVUZfa0Tbgu29WaidhUQQ5N23vO9TZBrAX4bplLhezyNJyy0daGkdVu0cL+lHSHRDqX
	5wHPA==
X-Received: by 2002:a05:600c:698d:b0:487:22ad:403e with SMTP id 5b1f17b1804b1-488d6ac9ce5mr126951995e9.14.1775984195334;
        Sun, 12 Apr 2026 01:56:35 -0700 (PDT)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d532ed4dsm197923925e9.4.2026.04.12.01.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 01:56:34 -0700 (PDT)
Date: Sun, 12 Apr 2026 09:56:33 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>,
	linux-openrisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
	iommu@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
	linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: Re: [patch 30/38] openrisc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <adteQSw8c65MtX5l@antec>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.593798781@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.593798781@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34653-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[vger.kernel.org,southpole.se,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shorne@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,southpole.se:email]
X-Rspamd-Queue-Id: 7E9FE3E32F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:20:55PM +0200, Thomas Gleixner wrote:
> The only remaining non-architecture usage of get_cycles() is to provide
> random_get_entropy().
> 
> Switch openrisc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Add 'asm/timex.h' includes to the relevant files, so the global include can
> be removed once all architectures are converted over.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: linux-openrisc@vger.kernel.org

This looks good to me.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  arch/openrisc/Kconfig              |    1 +
>  arch/openrisc/include/asm/random.h |   12 ++++++++++++
>  arch/openrisc/include/asm/timex.h  |    5 -----
>  arch/openrisc/lib/delay.c          |    1 +
>  4 files changed, 14 insertions(+), 5 deletions(-)
> 
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -10,6 +10,7 @@ config OPENRISC
>  	select ARCH_HAS_DELAY_TIMER
>  	select ARCH_HAS_DMA_SET_UNCACHED
>  	select ARCH_HAS_DMA_CLEAR_UNCACHED
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>  	select GENERIC_BUILTIN_DTB
>  	select COMMON_CLK
> --- /dev/null
> +++ b/arch/openrisc/include/asm/random.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef __ASM_OPENRISC_RANDOM_H
> +#define __ASM_OPENRISC_RANDOM_H
> +
> +#include <asm/timex.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return get_cycles();
> +}
> +
> +#endif
> --- a/arch/openrisc/include/asm/timex.h
> +++ b/arch/openrisc/include/asm/timex.h
> @@ -9,13 +9,9 @@
>   * OpenRISC implementation:
>   * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
>   */
> -
>  #ifndef __ASM_OPENRISC_TIMEX_H
>  #define __ASM_OPENRISC_TIMEX_H
>  
> -#define get_cycles get_cycles
> -
> -#include <asm-generic/timex.h>
>  #include <asm/spr.h>
>  #include <asm/spr_defs.h>
>  
> @@ -23,6 +19,5 @@ static inline cycles_t get_cycles(void)
>  {
>  	return mfspr(SPR_TTCR);
>  }
> -#define get_cycles get_cycles
>  
>  #endif
> --- a/arch/openrisc/lib/delay.c
> +++ b/arch/openrisc/lib/delay.c
> @@ -18,6 +18,7 @@
>  #include <linux/init.h>
>  
>  #include <asm/param.h>
> +#include <asm/timex.h>
>  #include <asm/processor.h>
>  
>  bool delay_read_timer(unsigned long *timer_value)
> 
> 

