Return-Path: <linux-wireless+bounces-23554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E56D6ACC5CA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 13:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DE43A2A6D
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jun 2025 11:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A922B8AA;
	Tue,  3 Jun 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhM3ICak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC51D7E4A;
	Tue,  3 Jun 2025 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951508; cv=none; b=TAxTbBpUCoMJRIXkEsMkLfHFM5DrO0OXqT6I1OHT8ZQBvcSGOvmR2b6Ayw8mmzsUy4OLJSZQlCWGkUwJJQLuYW+TWwtSyGFCJ+Vo4leY8ShMA0iM3Osp3sLmLmbjNwmKTtIbWFNZmlzYA6Ccx7CZEo7XQ1o/XakT5fs0YJUtt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951508; c=relaxed/simple;
	bh=+0+FjG1D5+BMAtWOeQZfZLKkO7QEDZvJWmT8YImYI40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOZWVpW2AFBhMFFO38ppAniqhgAQEaeTfE+WPTNaCelbC2RUOK+3/Wl8qe2AocTKGePEQ4anTt7zYXFZkVPVSnFlIsxFk+xpOosNuJsG8iraQDmrAqck3/3VtiXeo+naliYDZ5HDQS0b1jjQTgWJnC47R9GE75F1+tYJPzme95I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhM3ICak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146F3C4CEED;
	Tue,  3 Jun 2025 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748951508;
	bh=+0+FjG1D5+BMAtWOeQZfZLKkO7QEDZvJWmT8YImYI40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhM3ICakdOUq8YMMClJ+Aoem1yJe+icrKA7IEd+rPdVC3y6OyPe3x2Ua8ZLtD4y4F
	 NLRhmQHZPKtJXpP+Ys1fw2FEzvFYC/qnqmXa3F5Ve73EnS5kn8dHALzsJVSigeF8Tg
	 0A9mEsNgn8HKMQjFFyo975nKpA/cITqwIpEph2ZAq8FAGl9MYT33dMT7SsDQFlh+o1
	 JCxCZH2XJ5KiWQuG/u20Ir+5XWwj5bnsqDwRM+eSe2mlHq8etUwOrW2E/j6pGILH3g
	 Qqx04b+t/jqlgk8qSUcyWJ6QCYjZMN3/gZLVgJhP3HxgIP8zHg7qRW78WbPqCSP6SD
	 HsxqrHG8G51PQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uMQBE-00000000453-1hpd;
	Tue, 03 Jun 2025 13:51:45 +0200
Date: Tue, 3 Jun 2025 13:51:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>

On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
> On 6/2/2025 4:03 PM, Johan Hovold wrote:

> > No, the barrier is needed between reading the head pointer and accessing
> > descriptor fields, that's what matters.
> > 
> > You can still end up with reading stale descriptor data even when
> > ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to speculation
> > (that's what happens on the X13s).
> 
> The fact is that a dma_rmb() does not even prevent speculation, no matter where it is
> placed, right?

It prevents the speculated load from being used.

> If so the whole point of dma_rmb() is to prevent from compiler reordering
> or CPU reordering, but is it really possible?
> 
> The sequence is
> 
> 	1# reading HP
> 		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
> 
> 	2# validate HP
> 		if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
> 			return NULL;
> 
> 	3# get desc
> 		desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
> 
> 	4# accessing desc
> 		ath11k_hal_desc_reo_parse_err(... desc, ...)
> 
> Clearly each step depends on the results of previous steps. In this case the compiler/CPU
> is expected to be smart enough to not do any reordering, isn't it?

Steps 3 and 4 can be done speculatively before the load in step 1 is
complete as long as the result is discarded if it turns out not to be
needed.

Johan

