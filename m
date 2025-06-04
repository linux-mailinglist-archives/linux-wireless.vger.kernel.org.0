Return-Path: <linux-wireless+bounces-23677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14746ACD952
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DF23A4AEB
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BBD239E95;
	Wed,  4 Jun 2025 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3YIPlYL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88C927C175;
	Wed,  4 Jun 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749024466; cv=none; b=H12m6MxxzYQ8ciwU1v3tvU8WL0bVnriT7y/Guy/LRJ7gEHQW/5MdJsrqBZzh/prscTvOf7apEVOaPKRHg0vmIQO5AmnHpa0i0E06glgj7fYpou2ntIHyt8LrtDCHNpOD2byqZJtvTow3R0I+1GL+I1L46cyDChcEpW+pNcLBkdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749024466; c=relaxed/simple;
	bh=udKDE2z3Dh+zqzXfzXV5t59Ts2YA2zBXT9lPczBGBS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxt6EIdQgqglw60zvLx2tzPYvxKs8LOUb3k+KdkioNnbbq9JWwq/GEuwyKHYKpUy0kWvbp4e4c15W7BjHauNvx9WzVgtDNA5XEzEwSgsmOsgkRuc6ug38viXAdgnXmx5HuM3Lzorymi7B26IOlAs86OkzlkShP9owdzdNuePSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3YIPlYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DBFC4CEE7;
	Wed,  4 Jun 2025 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749024466;
	bh=udKDE2z3Dh+zqzXfzXV5t59Ts2YA2zBXT9lPczBGBS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h3YIPlYLvNMuU/TEmJORHLVoAKjDkiS4dNNtm9kp1I8H+iv70L6zFAhK/z0GMrfMV
	 fooH7ILEVwS/0hX6w5gBlkSNwwvIntzKx2XWZJEadN3B7HIb1Caw/VrL5zyNLaPHD3
	 CWaWQkFUTbnHf/DbH+vZn3YKbpgmnTgxAf/OrvrsvA5lxd2dfotlkMgFgemItEg9pD
	 QrXgvoge4tcVUcIH33FC0HqNG9BI6VdL/uVjV5HDTsyUAYSj+XgBBSAY25LPAd0Eyo
	 1sKVXm3+0PYAyOokrAEVLCHMRWlAlVAKt3gdSUnRM/9Y/s4RJRAp1/Dpoe3PAOEMxo
	 E6aq92l0R2ONA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uMj9y-000000003m2-1ilT;
	Wed, 04 Jun 2025 10:07:43 +0200
Date: Wed, 4 Jun 2025 10:07:42 +0200
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aD_-zt755Jr_LsWM@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <7025db40-dda0-4cbb-80bd-09bd590584da@quicinc.com>
 <aD_wgACEfm1_1GNz@hovoldconsulting.com>
 <79b4bac1-6e55-408c-a334-006eded4229f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79b4bac1-6e55-408c-a334-006eded4229f@quicinc.com>

On Wed, Jun 04, 2025 at 03:57:57PM +0800, Miaoqing Pan wrote:
> On 6/4/2025 3:06 PM, Johan Hovold wrote:
> > On Wed, Jun 04, 2025 at 01:32:08PM +0800, Miaoqing Pan wrote:
> >> On 6/4/2025 10:34 AM, Miaoqing Pan wrote:
> >>> On 6/3/2025 7:51 PM, Johan Hovold wrote:
> >>>> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:

> >>>>> The sequence is
> >>>>>
> >>>>>      1# reading HP
> >>>>>          srng->u.dst_ring.cached_hp = READ_ONCE(*srng-
> >>>>>> u.dst_ring.hp_addr);
> >>>>>
> >>>>>      2# validate HP
> >>>>>          if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
> >>>>>              return NULL;
> >>>>>
> >>>>>      3# get desc
> >>>>>          desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
> >>>>>
> >>>>>      4# accessing desc
> >>>>>          ath11k_hal_desc_reo_parse_err(... desc, ...)
> >>>>>
> >>>>> Clearly each step depends on the results of previous steps. In this
> >>>>> case the compiler/CPU
> >>>>> is expected to be smart enough to not do any reordering, isn't it?
> >>>>
> >>>> Steps 3 and 4 can be done speculatively before the load in step 1 is
> >>>> complete as long as the result is discarded if it turns out not to be
> >>>> needed.
> > 
> >>> If the condition in step 2 is true and step 3 speculatively loads
> >>> descriptor from TP before step 1, could this cause issues?
> >>
> >> Sorry for typo, if the condition in step 2 is false and step 3
> >> speculatively loads descriptor from TP before step 1, could this cause
> >> issues?
> > 
> > Almost correct; the descriptor can be loaded (from TP) before the head
> > pointer is loaded and thus before the condition in step 2 has been
> > evaluated. And if the condition in step 2 later turns out to be false,
> > step 4 may use stale data from before the head pointer was updated.
> 
> Actually, there's a missing step between step 3 and step 4: TP+1.
> 
> TP+1:
> 	srng->u.dst_ring.tp += srng->entry_size

Sure, but that is not relevant for the issue at hand.

> TP is managed by the CPU and points to the current first unprocessed 
> descriptor, while HP and the descriptor are asynchronously updated by 
> DMA. So are you saying that the descriptor obtained through speculative 
> loading has not yet been updated, or is in the process of being updated?

Exactly.

Johan

