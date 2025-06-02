Return-Path: <linux-wireless+bounces-23527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E449BACAA57
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 634F23BA30B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jun 2025 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DAE1C8638;
	Mon,  2 Jun 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLeoGhj+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFAC1C861B;
	Mon,  2 Jun 2025 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748851404; cv=none; b=F3au+1invn3DKsHyjFToKk0HZXRX2ZRT08QVO2NTsOXxATQU6cViKdxzZhuYDp9QtJn45YbYrLjFV6twy7KjuSdMNDapJvi85+i79364FSgUrubhbJBwfVuVIZuJsqumrFZymolaoTqcQEp7RwU0DobV4V99K+uSlOmEbhVn3RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748851404; c=relaxed/simple;
	bh=pRRYoIgu54ppeU32xD5VW+LrdjfzHD2C8cuKElm78PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6ET3xcqTgK7eMrzsSfd9JmxafpPjvyRv8ZijilDJv6OW/im8LQZcuReaHwzgL/2HpL0UV5rfnRe1VhTOHK/SwJJGV+joiqb0q7TX+dX3t21jwiDBwE3+RH2HPSubctRbOJWu8BOAElRGZbs7A+5tU8wTRqOJqTatl7BQhKYjHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLeoGhj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634DCC4CEF1;
	Mon,  2 Jun 2025 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748851403;
	bh=pRRYoIgu54ppeU32xD5VW+LrdjfzHD2C8cuKElm78PU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FLeoGhj+y2PlPKFs2kkIYEOqtUe1ScNoqI+pQheGIWfb31whJcZC61LbdbWAQ+Q3F
	 LR9kNpKaZWpmctJ+lUh4oEzP9ruEiTTcOsan8hE2sXem2mHFAxojOw6wN1KaJpd9RU
	 rPo4v0SIVQ5xW9F4ZJlz1BbsGHBh0QLcrNJkXESubMjzCX3mhPnQXjxAC4xs8s/V8Y
	 NE1h5ESc7AvYeGYthyzjgOmHDIDUsvn9W44eV7qkCLwKKd7PTswWFYECJ2pMn6KLRO
	 aTAWzdQsExJiEsfwTcpOsBI3Gy1U0K/QqoEwnnP8XEteiXYXxWw6FLm9xsmx7tnWvV
	 S8dLTeoXMdo4A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uM08d-0000000028E-22Ru;
	Mon, 02 Jun 2025 10:03:19 +0200
Date: Mon, 2 Jun 2025 10:03:19 +0200
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aD1axxSAJsbUfnHH@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>

On Thu, May 29, 2025 at 03:03:38PM +0800, Miaoqing Pan wrote:
> On 5/26/2025 7:48 PM, Johan Hovold wrote:
> > Add the missing memory barriers to make sure that destination ring
> > descriptors are read after the head pointers to avoid using stale data
> > on weakly ordered architectures like aarch64.

> > @@ -3851,6 +3851,9 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
> >   
> >   	ath11k_hal_srng_access_begin(ab, srng);
> >   
> > +	/* Make sure descriptor is read after the head pointer. */
> > +	dma_rmb();
> > +
> 
> Thanks Johan, for continuing to follow up on this issue. I have some 
> different opinions.
> 
> This change somewhat deviates from the fix approach described in 
> https://lore.kernel.org/all/20250321095219.19369-1-johan+linaro@kernel.org/. 
> In this case, the descriptor might be accessed before it is updated or 
> while it is still being updated. Therefore, a dma_rmb() should be added 
> after the call to ath11k_hal_srng_dst_get_next_entry() and before 
> accessing ath11k_hal_ce_dst_status_get_length(), to ensure that the DMA 
> has completed before reading the descriptor.
> 
> However, in this patch, the memory barrier is used to protect the head 
> pointer (HP). I don't think a memory barrier is necessary for HP, 
> because even if an outdated HP is fetched, 
> ath11k_hal_srng_dst_get_next_entry() will return NULL and exit safely. 

No, the barrier is needed between reading the head pointer and accessing
descriptor fields, that's what matters.

You can still end up with reading stale descriptor data even when
ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to speculation
(that's what happens on the X13s).

Whether to place it before or after (or inside)
ath11k_hal_srng_dst_get_next_entry() is a trade off between readability, 
maintainability and whether we want to avoid unnecessary barriers in
cases like the above where we strictly only need one barrier before the
loop (or if we want to avoid the barrier in case the ring is ever
empty).

> So, placing the memory barrier inside 
> ath11k_hal_srng_dst_get_next_entry() would be more appropriate.
> 
> @@ -678,6 +678,8 @@ u32 *ath11k_hal_srng_dst_get_next_entry(struct 
> ath11k_base *ab,
>          if (srng->flags & HAL_SRNG_FLAGS_CACHED)
>                  ath11k_hal_srng_prefetch_desc(ab, srng);
> 
> +       dma_rmb();
> +
>          return desc;
>   }

So this will add a barrier in each iteration of the loop, but we only
need a single one after reading the head pointer.

[ Also note that ath11k_hal_srng_dst_peek() would similarly need a
barrier if we were to move them into those helpers. ]

Johan

