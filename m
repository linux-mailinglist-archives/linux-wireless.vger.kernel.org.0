Return-Path: <linux-wireless+bounces-34753-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE0eGKYz32lqQAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34753-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 08:43:50 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED73400FBD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 08:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCB5E307BBE7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C12390CA9;
	Wed, 15 Apr 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmG1V1Qh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886F39022B;
	Wed, 15 Apr 2026 06:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235411; cv=none; b=KnZkTeDuB5pVkUJcahE3xSqd5nffmgeQoMLS3v6mu35wrBZynFjROgNDr0B8znRZXKGOOITBosWm/9BPs3vMhSKz83I9oMgPLUCaOjmDDMQzwG9X2cXQA6X13t0Ni7sbXjS/dK2OAsfjZZP+8D2AJG6ox+HT8m6Dl+/WGPZS3SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235411; c=relaxed/simple;
	bh=3l4dmsvsnQyxf5GbIefFkBoRTtzYmP3a/BJez1WWJU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqawphiTbFeFgXjZv1FksI5trzJKm/0AZ1VcCiXjjAStm6GhZVfNUtSgjKJz8w5jcv0V+K+xK8wxgenf7qPeHXvxgbLHk0ZvXw43w3Wd3alc2dzcm73gmggyNjdAGVFf+zRfCGndR0LOSYoQ1R7W3TRyxzGYEsIWQuNSCMaMaEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmG1V1Qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC3EC19424;
	Wed, 15 Apr 2026 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776235411;
	bh=3l4dmsvsnQyxf5GbIefFkBoRTtzYmP3a/BJez1WWJU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NmG1V1Qh8X51h9yFFz/RGI1o84gKp7RHsiOopESELjzBD3f9G2epzFGKqLdlrBBvM
	 85BRNDv9YgePWTAd/mWHoOfcVqkZ9t54hSGyPy5okYzBxuCsVMlJue+y2wSJhbVhIb
	 lb1DnIaWF178QVSBg4jx+V4/OFjaBNwtpoh3Tr4lJfjGJizmbNJlvTEiLyH2ILDjm+
	 9pOpGMDHM1wUUHlqTgOAicNu6S/pI86hh/KXo0HpBVSU8mvpdrsn1yE6nfT23v28aD
	 LJpZNPtQ4Ce9RQkXbclJOLPdj0XzY6SczhKB/CIS9XrbEQGTKPU35O7cIRgQtYcfwt
	 Wv24vurrRB4xg==
Message-ID: <0758843e-8f75-4c82-b9c0-25fab502e62f@kernel.org>
Date: Wed, 15 Apr 2026 08:43:21 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
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
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <20260410120044.031381086@kernel.org>
 <20260410120318.045532623@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34753-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1ED73400FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Le 10/04/2026 à 14:19, Thomas Gleixner a écrit :
> Most architectures define cycles_t as unsigned long execpt:
> 
>   - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
> 
>   - parisc and mips define it as unsigned int
> 
>     parisc has no real reason to do so as there are only a few usage sites
>     which either expand it to a 64-bit value or utilize only the lower
>     32bits.
> 
>     mips has no real requirement either.
> 
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   arch/Kconfig                       |    4 ++++
>   arch/alpha/include/asm/timex.h     |    3 ---
>   arch/arm/include/asm/timex.h       |    1 -
>   arch/loongarch/include/asm/timex.h |    2 --
>   arch/m68k/include/asm/timex.h      |    2 --
>   arch/mips/include/asm/timex.h      |    2 --
>   arch/nios2/include/asm/timex.h     |    2 --
>   arch/parisc/include/asm/timex.h    |    2 --
>   arch/powerpc/include/asm/timex.h   |    4 +---
>   arch/riscv/include/asm/timex.h     |    2 --
>   arch/s390/include/asm/timex.h      |    2 --
>   arch/sparc/include/asm/timex_64.h  |    1 -
>   arch/x86/Kconfig                   |    1 +
>   arch/x86/include/asm/tsc.h         |    2 --
>   include/asm-generic/timex.h        |    1 -
>   include/linux/types.h              |    6 ++++++
>   16 files changed, 12 insertions(+), 25 deletions(-)
> 
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -11,9 +11,7 @@
>   #include <asm/cputable.h>
>   #include <asm/vdso/timebase.h>
>   
> -typedef unsigned long cycles_t;
> -
> -static inline cycles_t get_cycles(void)
> +ostatic inline cycles_t get_cycles(void)

What is 'ostatic' ?

>   {
>   	return mftb();
>   }

