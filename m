Return-Path: <linux-wireless+bounces-34698-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FA9MYzp3GmUYAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34698-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:03:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 298863EC522
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C74D7300D9C5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 13:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE353CAE7C;
	Mon, 13 Apr 2026 13:03:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517933CA4A6;
	Mon, 13 Apr 2026 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776085383; cv=none; b=bwTHW/tkxY99tCwHUoJHgwpZjOo9A4zphWbzXQFy0xtA7LtE2/PHO1efJ1LD+FjrcqUYN4wmN8mwVemBWTxUOwUARtUUPAfmUc2U5/3KXlt4tN8Ag06OSFV/i1ujLw2Ka7S8QY8lALOq/meKjp99DeWScs8GUZysYV9QMRgJy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776085383; c=relaxed/simple;
	bh=EaqCVYb3mYfVBkGOFXvjwb/3rY9FtA9tCj0m3HXl1VM=;
	h=Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=E2FS0Mr44aeB66UkFZZ48HBwLHb5fdRBLmTQBxQVz5NXFeYCHKayBV+YvqzRMyLWWMZotdcE8UVuOqgnJWdgvSquHcamJwPcAlejOKjwDI3H3z1zYaykGK886Psv5TPOdGgdFb8ePR7Cxzxv0mzvy+YwqZTUZXgT6Hqx4CVxngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4fvSJ26Vzyz8Xs70;
	Mon, 13 Apr 2026 21:02:58 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 63DD2n3P010875;
	Mon, 13 Apr 2026 21:02:49 +0800 (+08)
	(envelope-from hu.shengming@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 13 Apr 2026 21:02:52 +0800 (CST)
X-Zmail-TransId: 2af969dce97c49e-2c715
X-Mailer: Zmail v1.0
Message-ID: <20260413210252672ZfdcegJLJtyvlYdFAUBlr@zte.com.cn>
In-Reply-To: <adyyNeVTkXQlnh_2@hyeyoo>
References: 20260410120044.031381086@kernel.org,20260410120318.525653921@kernel.org,adyyNeVTkXQlnh_2@hyeyoo
Date: Mon, 13 Apr 2026 21:02:52 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <hu.shengming@zte.com.cn>
To: <harry@kernel.org>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <vbabka@kernel.org>,
        <linux-mm@kvack.org>, <arnd@arndb.de>, <x86@kernel.org>,
        <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
        <m.grzeschik@pengutronix.de>, <netdev@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>, <dwmw2@infradead.org>,
        <bernie@plugable.com>, <linux-fbdev@vger.kernel.org>, <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>, <akpm@linux-foundation.org>,
        <urezki@gmail.com>, <elver@google.com>, <dvyukov@google.com>,
        <kasan-dev@googlegroups.com>, <ryabinin.a.a@gmail.com>,
        <t.sailer@alumni.ethz.ch>, <linux-hams@vger.kernel.org>,
        <Jason@zx2c4.com>, <richard.henderson@linaro.org>,
        <linux-alpha@vger.kernel.org>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <chenhuacai@kernel.org>, <loongarch@lists.linux.dev>,
        <geert@linux-m68k.org>, <linux-m68k@lists.linux-m68k.org>,
        <dinguyen@kernel.org>, <jonas@southpole.se>,
        <linux-openrisc@vger.kernel.org>, <deller@gmx.de>,
        <linux-parisc@vger.kernel.org>, <mpe@ellerman.id.au>,
        <linuxppc-dev@lists.ozlabs.org>, <pjw@kernel.org>,
        <linux-riscv@lists.infradead.org>, <hca@linux.ibm.com>,
        <linux-s390@vger.kernel.org>, <davem@davemloft.net>,
        <sparclinux@vger.kernel.org>, <hao.li@linux.dev>, <cl@gentwo.org>,
        <rientjes@google.com>, <roman.gushchin@linux.dev>
Subject: =?UTF-8?B?UmU6IFtwYXRjaCAxNC8zOF0gc2x1YjogVXNlIHByYW5kb20gaW5zdGVhZCBvZiBnZXRfY3ljbGVzKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 63DD2n3P010875
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: hu.shengming@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 13 Apr 2026 21:02:58 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 69DCE982.001/4fvSJ26Vzyz8Xs70
X-Spamd-Result: default: False [2.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	SUBJ_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[zte.com.cn : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,kvack.org,arndb.de,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net,linux.dev,gentwo.org];
	FROM_NEQ_ENVFROM(0.00)[hu.shengming@zte.com.cn,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34698-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_GT_50(0.00)[54];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kvack.org:email]
X-Rspamd-Queue-Id: 298863EC522
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Harry wrote:
> [Resending after fixing broken email headers]
> 
> On Fri, Apr 10, 2026 at 02:19:37PM +0200, Thomas Gleixner wrote:
> > The decision whether to scan remote nodes is based on a 'random' number
> > retrieved via get_cycles(). get_cycles() is about to be removed.
> > 
> > There is already prandom state in the code, so use that instead.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> > Cc: Vlastimil Babka <vbabka@kernel.org>
> > Cc: linux-mm@kvack.org
> > ---
> 
> Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
> 
> Is this for this merge window?
> 
> This may conflict with upcoming changes on freelist shuffling [1]
> (not queued for slab/for-next yet though), but it should be easy to
> resolve.
> 

Hi Harry,

Would you like me to wait for this patch to land linux-next and then
rebase and send v6 on top?

Thanks,

--
With Best Regards,
Shengming

> [Cc'ing Shengming and SLAB ALLOCATOR folks]
> [1] https://lore.kernel.org/linux-mm/20260409204352095kKWVYKtZImN59ybO6iRNj@zte.com.cn
> 
> -- 
> Cheers,
> Harry / Hyeonggon
> 
> >  mm/slub.c |   37 +++++++++++++++++++++++--------------
> >  1 file changed, 23 insertions(+), 14 deletions(-)
> > 
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3302,6 +3302,25 @@ static inline struct slab *alloc_slab_pa
> >      return slab;
> >  }
> >  
> > +#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
> > +static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
> > +
> > +static unsigned int slab_get_prandom_state(unsigned int limit)
> > +{
> > +    struct rnd_state *state;
> > +    unsigned int res;
> > +
> > +    /*
> > +     * An interrupt or NMI handler might interrupt and change
> > +     * the state in the middle, but that's safe.
> > +     */
> > +    state = &get_cpu_var(slab_rnd_state);
> > +    res = prandom_u32_state(state) % limit;
> > +    put_cpu_var(slab_rnd_state);
> > +    return res;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_SLAB_FREELIST_RANDOM
> >  /* Pre-initialize the random sequence cache */
> >  static int init_cache_random_seq(struct kmem_cache *s)
> > @@ -3365,8 +3384,6 @@ static void *next_freelist_entry(struct
> >      return (char *)start + idx;
> >  }
> >  
> > -static DEFINE_PER_CPU(struct rnd_state, slab_rnd_state);
> > -
> >  /* Shuffle the single linked freelist based on a random pre-computed sequence */
> >  static bool shuffle_freelist(struct kmem_cache *s, struct slab *slab,
> >                   bool allow_spin)
> > @@ -3383,15 +3400,7 @@ static bool shuffle_freelist(struct kmem
> >      if (allow_spin) {
> >          pos = get_random_u32_below(freelist_count);
> >      } else {
> > -        struct rnd_state *state;
> > -
> > -        /*
> > -         * An interrupt or NMI handler might interrupt and change
> > -         * the state in the middle, but that's safe.
> > -         */
> > -        state = &get_cpu_var(slab_rnd_state);
> > -        pos = prandom_u32_state(state) % freelist_count;
> > -        put_cpu_var(slab_rnd_state);
> > +        pos = slab_get_prandom_state(freelist_count);
> >      }
> >  
> >      page_limit = slab->objects * s->size;
> > @@ -3882,7 +3891,7 @@ static void *get_from_any_partial(struct
> >       * with available objects.
> >       */
> >      if (!s->remote_node_defrag_ratio ||
> > -            get_cycles() % 1024 > s->remote_node_defrag_ratio)
> > +        slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
> >          return NULL;
> >  
> >      do {
> > @@ -7102,7 +7111,7 @@ static unsigned int
> >  
> >      /* see get_from_any_partial() for the defrag ratio description */
> >      if (!s->remote_node_defrag_ratio ||
> > -            get_cycles() % 1024 > s->remote_node_defrag_ratio)
> > +        slab_get_prandom_state(1024) > s->remote_node_defrag_ratio)
> >          return 0;
> >  
> >      do {
> > @@ -8421,7 +8430,7 @@ void __init kmem_cache_init_late(void)
> >      flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM | WQ_PERCPU,
> >                    0);
> >      WARN_ON(!flushwq);
> > -#ifdef CONFIG_SLAB_FREELIST_RANDOM
> > +#if defined(CONFIG_SLAB_FREELIST_RANDOM) || defined(CONFIG_NUMA)
> >      prandom_init_once(&slab_rnd_state);
> >  #endif
> >  }
> > 
> >

