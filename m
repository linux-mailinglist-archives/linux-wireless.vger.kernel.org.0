Return-Path: <linux-wireless+bounces-23675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F655ACD83D
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 09:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 692801895181
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 07:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0C22F754;
	Wed,  4 Jun 2025 07:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TteEiU4z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94B1F4CB3;
	Wed,  4 Jun 2025 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749020941; cv=none; b=KqRzx5BQZrOqNmCvweGvLic86RTOSaA2T4xhsut3ZR7bJp9x9oAVDxJUH/4hc1P4p/tLrurZiCXtobx5NfUilK7Y8rbXDZlNCFDa+NVWbwOtw3homwwV8KmApw4SROoDpGqw7fe4jmC6sP2wbt0THHCh/+rBZx7t4SJxwpfK9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749020941; c=relaxed/simple;
	bh=iD+RZcjbKVDtFg3DEp6r0Fsk0DPdKsjlbg4GlDqQuaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDtslKfiOMerFDfXQPw9cBNJ8neJV99Tq8KTaEUyHNcA5uP+2mra3Dcudp0MtnOm4Ss+aeOLryDyBRk2T8zQfb0VuAU3y1wWxUWyp9Tmu/MG88csmZ1TQy6NLM4nKNhxkWOJzMq/FIiwFxOCiemApW92A7WIH2JsQKd0kKBSL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TteEiU4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42222C4CEE7;
	Wed,  4 Jun 2025 07:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749020940;
	bh=iD+RZcjbKVDtFg3DEp6r0Fsk0DPdKsjlbg4GlDqQuaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TteEiU4zeIjPp6LGl1PUi2UAQNWfbXR3tbndvdF73evDvvVAig3ccB4cbaYN717KC
	 tDEEsSq2SfsXG6xwJiWTyq8TXj8b1WLQoHZjd1tz+aAPKUzd9NgiHFTr6Uo15q5NfZ
	 gAn+qvOPE7KFeEfG6VxxCicJyVCIlnkkzbTKU33Ue/C/4hCTOdaxYWSeOvnQG1NYT+
	 uXtnGU+P/SDZT3qwmcBGUCgxPiyW5q9GIpw9KLvngmBg7awa56DnotkAwAs1oaX5WB
	 vs/ZrXBBJxd8ZOW1hhz1nlbqWBvTpJ0kv07DscoVlpx1/cvK93UiaaaScD7asGmBza
	 1nwroc3D2VNkw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uMiCu-000000004XS-40bA;
	Wed, 04 Jun 2025 09:06:41 +0200
Date: Wed, 4 Jun 2025 09:06:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
Message-ID: <aD_wgACEfm1_1GNz@hovoldconsulting.com>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <7025db40-dda0-4cbb-80bd-09bd590584da@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7025db40-dda0-4cbb-80bd-09bd590584da@quicinc.com>

On Wed, Jun 04, 2025 at 01:32:08PM +0800, Miaoqing Pan wrote:
> On 6/4/2025 10:34 AM, Miaoqing Pan wrote:
> > On 6/3/2025 7:51 PM, Johan Hovold wrote:
> >> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
> >>> On 6/2/2025 4:03 PM, Johan Hovold wrote:
> >>
> >>>> No, the barrier is needed between reading the head pointer and 
> >>>> accessing
> >>>> descriptor fields, that's what matters.
> >>>>
> >>>> You can still end up with reading stale descriptor data even when
> >>>> ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to 
> >>>> speculation
> >>>> (that's what happens on the X13s).
> >>>
> >>> The fact is that a dma_rmb() does not even prevent speculation, no 
> >>> matter where it is
> >>> placed, right?
> >>
> >> It prevents the speculated load from being used.
> >>
> >>> If so the whole point of dma_rmb() is to prevent from compiler 
> >>> reordering
> >>> or CPU reordering, but is it really possible?
> >>>
> >>> The sequence is
> >>>
> >>>     1# reading HP
> >>>         srng->u.dst_ring.cached_hp = READ_ONCE(*srng- 
> >>> >u.dst_ring.hp_addr);
> >>>
> >>>     2# validate HP
> >>>         if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
> >>>             return NULL;
> >>>
> >>>     3# get desc
> >>>         desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
> >>>
> >>>     4# accessing desc
> >>>         ath11k_hal_desc_reo_parse_err(... desc, ...)
> >>>
> >>> Clearly each step depends on the results of previous steps. In this 
> >>> case the compiler/CPU
> >>> is expected to be smart enough to not do any reordering, isn't it?
> >>
> >> Steps 3 and 4 can be done speculatively before the load in step 1 is
> >> complete as long as the result is discarded if it turns out not to be
> >> needed.

> > If the condition in step 2 is true and step 3 speculatively loads 
> > descriptor from TP before step 1, could this cause issues?
> 
> Sorry for typo, if the condition in step 2 is false and step 3 
> speculatively loads descriptor from TP before step 1, could this cause 
> issues?

Almost correct; the descriptor can be loaded (from TP) before the head
pointer is loaded and thus before the condition in step 2 has been
evaluated. And if the condition in step 2 later turns out to be false,
step 4 may use stale data from before the head pointer was updated.

Johan

