Return-Path: <linux-wireless+bounces-34687-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLWAIE+k3GkEUgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34687-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:07:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE5A3E8D2E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 10:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6658303A6F8
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8C3A0B3D;
	Mon, 13 Apr 2026 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aInXVTZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60217396B73;
	Mon, 13 Apr 2026 07:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067142; cv=none; b=mwl5JWeertl0/gsLkuJhUFiD/4pFkMbuu1YAx66BnaaHh0xM3vW7B5nuvKYeeYycgQhrlECdYiSPDDUvTjCjz8WGBdJ5FQqMHmDPfWm68Dc/tEiKj9zaFJVmHJMdTkXt2Y46jn+qRWPpKQ36tlP8aPz+KqPZMazxYVK287sR45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067142; c=relaxed/simple;
	bh=XHj3Sl5zLIaiozQdeiIMCMFRZIyOS3dN0hw7WTARA40=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o5Yy4LGd4QYVJp16vTLLNEu6pFIPQOqsaBE/s5GlxjBieSH7nqN5V9DzN1lBKj+ARWJKEd8uIs8XnYd/tS3ePR3atwpKF9Z0HERwePpnYoHD+JiCxf9IsiRsr8b002FusBcBkCZgtcc6Kvv8W9mqLm7JvCKukmzXI7KK/zz/3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aInXVTZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E82C2BCB1;
	Mon, 13 Apr 2026 07:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776067142;
	bh=XHj3Sl5zLIaiozQdeiIMCMFRZIyOS3dN0hw7WTARA40=;
	h=Date:From:To:Cc:From;
	b=aInXVTZDoMoSfHiM/ZTxpP0dqJp8rPTOhRsc0Vuegjf9eP1zvaDTJ+apxlgIuhj5m
	 uymEbEu/UHOJWJ6lw7U0YrRJbLNQJR/o8436sUmQyyIJnGd5I57C1MKi19QSG24eX9
	 h2iGOBKURBUQkPE+zITLtqcSezi5jonPS8m9wlnnrbrXoKcavVutGZS3YzVK/HoBVS
	 ZTBks8Urt9YUD0fN0O3n/+VePDQcDLPvpr8M3UALf3YN6/WXTllw86HLQ5q1c3ADYE
	 YbRf8iuI5QEq4lS/pfjIFvTCKsJMm3+e/VB0lwWLoC4lQj8qW8Sg2xkFLYg/qNqpkL
	 OEuPIqPS+wyIg==
Date: Mon, 13 Apr 2026 16:58:59 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
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
	Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shengming Hu <hu.shengming@zte.com.cn>
Message-ID: <adyiQy_DP_vldg1r@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [1.84 / 15.00];
	MISSING_SUBJECT(2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-34687-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,kvack.org,arndb.de,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net,linux.dev,gentwo.org,zte.com.cn];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kvack.org:email]
X-Rspamd-Queue-Id: 1AE5A3E8D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Bcc: 
Subject: Re: [patch 14/38] slub: Use prandom instead of get_cycles()
Reply-To: 
In-Reply-To: <20260410120318.525653921@kernel.org>

On Fri, Apr 10, 2026 at 02:19:37PM +0200, Thomas Gleixner wrote:
> The decision whether to scan remote nodes is based on a 'random' number
> retrieved via get_cycles(). get_cycles() is about to be removed.
> 
> There is already prandom state in the code, so use that instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: linux-mm@kvack.org
> ---

Acked-by: Harry Yoo (Oracle) <harry@kernel.org>

Is this for this merge window?

This may conflict with upcoming changes on freelist shuffling [1]
(not queued for slab/for-next yet though), but it should be easy to
resolve.

[Cc'ing Shengming and SLAB ALLOCATOR folks]

[1] https://lore.kernel.org/linux-mm/20260409204352095kKWVYKtZImN59ybO6iRNj@zte.com.cn

-- 
Cheers,
Harry / Hyeonggon

>  mm/slub.c |   37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3302,6 +3302,25 @@ static inline struct slab *alloc_slab_pa
>  	return slab;
>  }
>  
> +#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
> +static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
> +
> +static unsigned int slab_get_prandom_state(unsigned int limit)
> +{
> +	struct rnd_state *state;
> +	unsigned int res;
> +
> +	/*
> +	 * An interrupt or NMI handler might interrupt and change
> +	 * the state in the middle, but that's safe.
> +	 */
> +	state = &get_cpu_var(slab_rnd_state);
> +	res = prandom_u32_state(state) % limit;
> +	put_cpu_var(slab_rnd_state);
> +	return res;
> +}
> +#endif
> +
>  #ifdef CONFIG_SLAB_FREELIST_RANDOM
>  /* Pre-initialize the random sequence cache */
>  static int init_cache_random_seq(struct kmem_cache *s)
> @@ -3365,8 +3384,6 @@ static void *next_freelist_entry(struct
>  	return (char *)start + idx;
>  }
>  
> -static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
> -
>  /* Shuffle the single linked freelist based on a random pre-computed sequence */
>  static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab,
>  			     bool allow_spin)
> @@ -3383,15 +3400,7 @@ static bool shuffle_freelist(struct kmem
>  	if (allow_spin) {
>  		pos = get_random_u32_below(freelist_count);
>  	} else {
> -		struct rnd_state *state;
> -
> -		/*
> -		 * An interrupt or NMI handler might interrupt and change
> -		 * the state in the middle, but that's safe.
> -		 */
> -		state = &get_cpu_var(slab_rnd_state);
> -		pos = prandom_u32_state(state) % freelist_count;
> -		put_cpu_var(slab_rnd_state);
> +		pos = slab_get_prandom_state(freelist_count);
>  	}
>  
>  	page_limit = slab->objects * s->size;
> @@ -3882,7 +3891,7 @@ static void *get_from_any_partial(struct
>  	 * with available objects.
>  	 */
>  	if (!s->remote_node_defrag_ratio ||
> -			get_cycles() % 1024 > s->remote_node_defrag_ratio)
> +	    slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
>  		return NULL;
>  
>  	do {
> @@ -7102,7 +7111,7 @@ static unsigned int
>  
>  	/* see get_from_any_partial() for the defrag ratio description */
>  	if (!s->remote_node_defrag_ratio ||
> -			get_cycles() % 1024 > s->remote_node_defrag_ratio)
> +	    slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
>  		return 0;
>  
>  	do {
> @@ -8421,7 +8430,7 @@ void __init kmem_cache_init_late(void)
>  	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
>  				  0);
>  	WARN_ON(!flushwq);
> -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> +#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
>  	prandom_init_once(&slab_rnd_state);
>  #endif
>  }
> 
> 

