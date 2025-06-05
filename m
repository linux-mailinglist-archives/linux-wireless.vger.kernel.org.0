Return-Path: <linux-wireless+bounces-23745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883DFACED37
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D5FB3AC4E4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787BD20C029;
	Thu,  5 Jun 2025 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGEXQI/E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492FC1FAC4D;
	Thu,  5 Jun 2025 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749117622; cv=none; b=G95elTSBPRkwFw+H3gCZbxqcRJIk7TCR1oW4TtbvUhzsi7Jgi2SLKrHsWK/is0uhs0zPY112W5CH9Ef3Pugandqps2SGsJI9S5Adr7EnONKzEZF4XitR6EQrdUoSZna5cIyYxpjoMG17hMidFsBOfYnQdrj2+xuP+rgbHuMp2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749117622; c=relaxed/simple;
	bh=5Eav7+G7caZZygl7Od69GSqH2G5p51M5I4/DH9iNkvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLttqdmCDpweNrGJzaWA16yDDmVQ14bVvMJYAOBoh2ReAQgzxqij5trWz1FfnJrEKK08GnFi+byYTF2B1RtiEl3IFdgpMWPpd1NPv/Y+1p1gZW5osSblQJRb4csM9fNTxAEmSpzCBwrMwwxTaFtlMhwrNmU8f6wTjcM+qB5xwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGEXQI/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCC6C4CEE7;
	Thu,  5 Jun 2025 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749117621;
	bh=5Eav7+G7caZZygl7Od69GSqH2G5p51M5I4/DH9iNkvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGEXQI/E3ikPG3TMnj3L1o7OQn1gBi8hj6JUx52U/3rlrwN+n7jsg9Iax58rAQVLP
	 ocQsfyyl0m0VJO+rk+8C4lTmfaa0wMiAs7ZAqrxtbDfhudaGxOKVbAEIH9QqA/ha+5
	 32ZOCTivQ9iI4ynr0DD6wdYByCfrovJyfu+6tgVWap84kn7sfGQvpIbRoF46CmI4QF
	 TkDhNr/9Oh/+1LVvxWuIhucjz8Jsr5zZnd+ok+RfUgZox3qBanmRWV/MoTc3Pe/OOc
	 O/EgOUs5EtI3HavqqB/5Io4BDPcNPZawPoXpJn6lP3IfJ2NHWbZ0OsoUD07k5Pmwy2
	 vV0uNT6dzLp0w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uN7OU-000000000Zb-1mJ1;
	Thu, 05 Jun 2025 12:00:19 +0200
Date: Thu, 5 Jun 2025 12:00:18 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Remi Pommarel <repk@triplefau.lt>, linux-wireless@vger.kernel.org,
	ath12k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
Message-ID: <aEFqsghEuJc3xxlU@hovoldconsulting.com>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-2-johan+linaro@kernel.org>
 <6f3eb9fa-617e-4434-8fc4-33dd92c4bdd2@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f3eb9fa-617e-4434-8fc4-33dd92c4bdd2@quicinc.com>

On Thu, Jun 05, 2025 at 04:41:32PM +0800, Baochen Qiang wrote:
> On 6/4/2025 10:45 PM, Johan Hovold wrote:
> > Add the missing memory barrier to make sure that destination ring
> > descriptors are read after the head pointers to avoid using stale data
> > on weakly ordered architectures like aarch64.
> > 
> > The barrier is added to the ath12k_hal_srng_access_begin() helper for
> > symmetry with follow-on fixes for source ring buffer corruption which
> > will add barriers to ath12k_hal_srng_access_end().
> > 
> > Note that this may fix the empty descriptor issue recently worked around
> > by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
> > monitor ring").
> 
> why? I would expect drunk cookies are valid in case of HAL_MON_DEST_INFO0_EMPTY_DESC,
> rather than anything caused by reordering.

Based on a quick look it seemed like this could possibly fall in the
same category as some of the other workarounds I've spotted while
looking into these ordering issues (e.g. f9fff67d2d7c ("wifi: ath11k:
Fix SKB corruption in REO destination ring")).

If you say this one is clearly unrelated, I'll drop the comment.

> > @@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
> >  		goto err;
> >  	}
> >  
> > -	/* Make sure descriptor is read after the head pointer. */
> > -	dma_rmb();
> > -
> >  	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
> >  
> >  	*skb = pipe->dest_ring->skb[sw_index];
> > diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> > index 91d5126ca149..9eea13ed5565 100644
> > --- a/drivers/net/wireless/ath/ath12k/hal.c
> > +++ b/drivers/net/wireless/ath/ath12k/hal.c
> > @@ -2126,13 +2126,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
> >  
> >  void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
> >  {
> > +	u32 hp;
> > +
> >  	lockdep_assert_held(&srng->lock);
> >  
> > -	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
> > +	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
> >  		srng->u.src_ring.cached_tp =
> >  			*(volatile u32 *)srng->u.src_ring.tp_addr;
> > -	else
> > -		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> > +	} else {
> > +		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> > +
> > +		if (hp != srng->u.dst_ring.cached_hp) {
> 
> This consumes additional CPU cycles in hot path, which is a concern to me.
> 
> Based on that, I prefer the v1 implementation.

The conditional avoids a memory barrier in case the ring is empty, so
for all callers but ath12k_ce_completed_recv_next() it's an improvement
over v1 in that sense.

I could make the barrier unconditional, which will only add one barrier
to ath12k_ce_completed_recv_next() in case the ring is empty compared to
v1. Perhaps that's a good compromise if you worry about the extra
comparison?

I very much want to avoid having both explicit barriers in the caller
and barriers in the hal end() helper. I think it should be either or.
 
> > +			srng->u.dst_ring.cached_hp = hp;
> > +			/* Make sure descriptor is read after the head
> > +			 * pointer.
> > +			 */
> > +			dma_rmb();
> > +		}
> > +	}

Johan

