Return-Path: <linux-wireless+bounces-35118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD5tFfUd52mY4AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 08:49:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B155743723B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 08:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898A03009FA1
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Apr 2026 06:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DEF366061;
	Tue, 21 Apr 2026 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4HdCsEQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9D27F01E
	for <linux-wireless@vger.kernel.org>; Tue, 21 Apr 2026 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776754155; cv=none; b=WpmPNGeKZjw02Vkj0jCX1yJf7AgXahNo622RTjyMpsiiRbBC/jgJfLXI0VW3HktjN1TbDGPfY9g6unGSXsgKdO3DwWAaP1HzfenG1KbRdVlmyiJ7D19XVpaay6gpSMFSK3/G/pq3Md4WzuXDIYDjRFt7HTX8+Ntx52j+IZdPQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776754155; c=relaxed/simple;
	bh=am3smhs96M1Iz0Y0JDciE1ZjrAK1dDbEC7UccjVq/eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAYYHJcGKw/5Y5AbxKEfKWEqROoyz6rpXIlR7DPTAaRGGudrc8VLYMEMPGvcJ75kNCNqcYq0zUXG2cDwTSjE9CqbA2MF5YF5aitOhXt+n7XR5x9Ae1+/N7zmcF77qTRsMCXMO6tmm+0o0A+gvO7tNp7lbXAEIlh2hw7IQTlftJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4HdCsEQ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3591cc98871so1748860a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 23:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776754153; x=1777358953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
        b=J4HdCsEQzBF52HS7kv/2N9GJ8av6ANJwagpeEgdEx1yRdELMEGjQ4U1u/N87NO4FNi
         O6KdpnQd2wlsQteyBgo3JKT5dhLZvpI1wyEsq4drfOlNwbEJ6WcOJKua2hfbgUn7f/qO
         TzEOq5j4q1kIqn9Y+uIFyo3FhWMNPvAyfGSeTx2OrK0/Srjf3V26Ep8QZ8qfFqhXNK/n
         ZxjbuMVDQk5kg1icO+a9j//B79M0Kg9jntS58arF/1IdYz8rvP1GqYJvmDueJh+a2H6V
         AcrX5EqwWq4kixz6oUFeG2btwWnpqWtN0xGCez+9Lm3iTdeVYKxGHu2/uM273h/aIkCV
         n8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754153; x=1777358953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
        b=NUPW+7pQTE/ZE27CV0YJMNHSxW/FznCEbuub1YhdmKNtHg0rowi/WCqS8tytVrfLHV
         AApbt0UZmOBfhpDh+3LxnFOpyjWmFv+ZAyBxR/WyMyAz+Ec+H6Wc05HC5Rki08ZjH79F
         6vpgrd7PeERI50RuNW6R5Kmy/vLbdmV5UQ1dBg5LJJbOK3P+zLwLOjflveDOz5Kz9YUO
         axlnVB1S01qoZOoxeQ+SzTNdBr3t0UrkdCO5JzHyH2Q5qbZlAhpunXPsuyIidEGaFQqr
         5diZV/ghsShsVbfrVZzPESHw+tZAFbfd/vEaqNYr7Z1LJrc0fJtth6nddbyA6CvsErJA
         dSTA==
X-Forwarded-Encrypted: i=1; AFNElJ9X40UvXA12F98WZjD896UgzCy0xh/87+rLPbvWYylaRF7aAevmHd7zUX1ZJUPPGAK6YZa0r/2YZNp9TN3sgA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzl2P/v5k8wJqaRR4926r7WkrPwYPu35AzkUQ3I3qnMgdD8ld4
	ZtQBCJ7GHc8eo+A951sc5KLeIyF7E8vu8mO7KKeVgNhrXX8P+vLugLtR
X-Gm-Gg: AeBDieuOgwUqGJgLGXKCzhZNBc03ckvot5y8znPGhc8QC+JYsP3fnuo0Z4xMKcpJwQC
	DPmpxwRpxXV50UzdlG1q0ZAVqItj/g3JQGnuD7FriI7usSpqLCUkU3cu9Z4Z2xWdWyjNdutYwTZ
	9q63/+uVUTGZkZk5IDh5CFgkwWqQENBRtfFeK1zBK4ed2K50hMA2+fEHBOrI7LeJb5TqyYBukR6
	8OlVxOn9ZntzlXLSOdGI9QBp0i3w7VK6cQtWedVyD+HNqGkX7dv+2NWVPxEi7lXRYi9pj9REYm2
	EgAr4hrhEd3L47pT3ywkybbtbddEJqtcovVTjX2We8weYebecXzFgGjnTQ2lr0tIYHwvBh1PN+b
	JMEho1Oa81pr5wSgAIIqtrD4E3wF61682ND8NDAVqtG8WLFfrEkQlTG0RrrmTH8lM5IlGh8gl1R
	LezfIwHb0ro/3FuDRjjPWQRH94XeMubPfNwiiF5ywM8p/4BDaCWck0L0iNQG7PpQMJAIoBy25d4
	R/nZaKieRFGCd8x
X-Received: by 2002:a17:90a:dfd0:b0:35e:30bc:96ed with SMTP id 98e67ed59e1d1-36140402361mr16891174a91.10.1776754153374;
        Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm12278674a91.12.2026.04.20.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:18:55 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, 
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 32/38] powerpc/spufs: Use mftb() directly
Message-ID: <aecdpyvTLJOjCdFp@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.723429844@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.723429844@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35118-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ellerman.id.au,lists.ozlabs.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,linux.ibm.com,davemloft.net];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[49];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkchauras@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com:mid]
X-Rspamd-Queue-Id: B155743723B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 02:21:04PM +0200, Thomas Gleixner wrote:
> There is no reason to indirect via get_cycles(), which is about to be
> removed.
> 
> Use mftb() directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/platforms/cell/spufs/switch.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/arch/powerpc/platforms/cell/spufs/switch.c
> +++ b/arch/powerpc/platforms/cell/spufs/switch.c
> @@ -34,6 +34,7 @@
>  #include <asm/spu_priv1.h>
>  #include <asm/spu_csa.h>
>  #include <asm/mmu_context.h>
> +#include <asm/time.h>
>  
>  #include "spufs.h"
>  
> @@ -279,7 +280,7 @@ static inline void save_timebase(struct
>  	 *    Read PPE Timebase High and Timebase low registers
>  	 *    and save in CSA.  TBD.
>  	 */
> -	csa->suspend_time = get_cycles();
> +	csa->suspend_time = mftb();
>  }
>  
>  static inline void remove_other_spu_access(struct spu_state *csa,
> @@ -1261,7 +1262,7 @@ static inline void setup_decr(struct spu
>  	 *     in LSCSA.
>  	 */
>  	if (csa->priv2.mfc_control_RW & MFC_CNTL_DECREMENTER_RUNNING) {
> -		cycles_t resume_time = get_cycles();
> +		cycles_t resume_time = mftb();
>  		cycles_t delta_time = resume_time - csa->suspend_time;
>  
>  		csa->lscsa->decr_status.slot[0] = SPU_DECR_STATUS_RUNNING;
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

