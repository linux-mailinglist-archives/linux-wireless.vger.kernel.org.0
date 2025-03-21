Return-Path: <linux-wireless+bounces-20646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD80EA6B79E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 10:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7264611D3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A824C1F1921;
	Fri, 21 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrGZ0FQH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEB221E0A2;
	Fri, 21 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549706; cv=none; b=pOqV06m3KFozqBFiYwD+7KWPzXDVw3kk4aSPsE/aTMxTOA6HhZQcVLL0udGsdTyQ//U9yLNV8fV1wvuOkQZjiuTwtVVjOfIxGPimtn7UxiiCQbHrP2TqY0fR7hZWU+pU5symYO7tL8pU46eXwIhXcc0VmDNHOXk7nHYEKoghgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549706; c=relaxed/simple;
	bh=5Rf2fkdPmUr9DP2uzn0oLDH5fnH7e7xxgEWlMFSo2vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDg0jAZGZ6fIQw9wSIMuNo2QlFDpPWZQGgEPJ6650gdJrQ21Ay2M5nfzoPzIo6mdCR9Ahq53svzTkqWfx1r8zvHvkczlkf6ETJk8Wv6I6MZiVW3//5It6q9MhAEFyf0bPDODzj6efv61y6ytiv3NoUfjYx6p/5+WzdiCyZ0kIng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrGZ0FQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFCC4CEE8;
	Fri, 21 Mar 2025 09:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742549705;
	bh=5Rf2fkdPmUr9DP2uzn0oLDH5fnH7e7xxgEWlMFSo2vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DrGZ0FQHGOI8f8hAaAKApzJWrfm4mdzxNRkBtqujwzmcFrirGzZWMizi8Ko4kxs+e
	 eD+gutlK9mmaQUorBm1hPftOfrAVfJyjF5hSJSzQqwpaLCgqRXrLJjmDyGVJjw/caM
	 soRD1FZ4y60qd0oss7k/IHxk7qeSLm2J6q5ykLS7yVA8SW4SI62bY3hChnCeyPh0VL
	 WbAZQQMIRce1/68LEgJP39zp01eZ13UMNfnEUK6625FBglY0T9QQBrScsOSeFKIyUS
	 T3r8Wi42Utooa61Dgf5o0oPxUy3Kz+8L/OewZdAcLOcBIfbjCTpAQJG+948DRdCN4E
	 ghwzrAcySpgXg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tvYmQ-000000003Fm-3GzD;
	Fri, 21 Mar 2025 10:35:07 +0100
Date: Fri, 21 Mar 2025 10:35:06 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z90yyrZcORhJJgNU@hovoldconsulting.com>
References: <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
 <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
 <ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com>
 <Z9gd9Aw5Bug8IKSV@hovoldconsulting.com>
 <f30cf771-a9cd-4d8f-8d10-1640afd33c23@quicinc.com>
 <Z9mwn3GzpPPZSiTG@hovoldconsulting.com>
 <a8fc9f07-013c-4e31-9d9e-46e042d81dbf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8fc9f07-013c-4e31-9d9e-46e042d81dbf@quicinc.com>

On Wed, Mar 19, 2025 at 02:47:12PM +0800, Miaoqing Pan wrote:
> On 3/19/2025 1:42 AM, Johan Hovold wrote:

> > It could if the CPU observes the updates out of order due to the missing
> > barrier. The driver could be processing an earlier interrupt when the
> > new descriptor is added and head pointer updated. If for example the CPU
> > speculatively fetches the descriptor before the head pointer is updated,
> > then the descriptor length may be zero when the CPU sees the updated
> > head pointer.
> 
> Sorry, I still think this situation won't happen. Please see the 
> following code.
> 
> ath11k_hal_srng_access_begin(ab, srng);
>    => srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
>    => if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp) return NULL;
> //dma_rmb();
> *nbytes = ath11k_hal_ce_dst_status_get_length(desc);
> 
> If the condition 'srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp' is 
> true, the descriptor retrieval fails.

The CPU can still speculate that this condition will be false and load
the descriptor.

If the speculation later turns out to be correct, then the descriptor
may have stale values from before the head pointer was updated.

> > This seems to be what is happening on the X13s since adding the memory
> > barrier makes the zero-length descriptors go away.
> 
> Hmm, it is indeed a bit strange. Could it be that dma_rmb() introduces 
> some delay ?

It's only expected since you must use memory barriers on weakly ordered
architectures like aarch64 to guarantee the ordering.
 
> >> The Copy Engine hardware module copies the metadata to the Status
> >> Descriptor after the DMA is complete, then updates the HP to trigger an
> >> interrupt. I think there might be some issues in this process, such as
> >> the lack of a wmb instruction after the copy is complete, causing the HP
> >> to be updated first.
> > 
> > Yeah, possibly. At least it seems there are more issues than the missing
> > barrier on the machines you test.
> >   
> >>> Now obviously there are further issues in your system, which we should
> >>> make sure we understand before adding workarounds to the driver.
> >>>
> >>> Do you have a pointer to the downstream kernel sources you are testing
> >>> with? Or even better, can you reproduce the issue with mainline after
> >>> adding the PCIe patches that were posted to the lists for these
> >>> platforms?
> >>>
> >> https://github.com/qualcomm-linux/meta-qcom-hwe/blob/scarthgap/recipes-kernel/linux/linux-qcom-base_6.6.bb
> > 
> > Thanks for the pointer. That's a lot of out-of-tree patches on top of
> > stable so not that easy to check the state of the resulting tree.
> 
> Yes, but there are only a few patches for ath11k.

Sure, but there are other components that come into play here such as
the PCIe controller driver.

A colleague of yours recently submitted an updated patch that overrides
the no_snoop bit for qcs8300:

	https://lore.kernel.org/lkml/20250318053836.tievnd5ohzl7bmox@thinkpad/

but that flag appears not to be set in your downstream tree:

	https://github.com/qualcomm-linux/meta-qcom-hwe/blob/scarthgap/recipes-kernel/linux/linux-qcom-base-6.6/drivers/qcs8300/0004-PCI-qcom-Add-QCS8300-PCIe-support.patch

Something like that may prevent a cached descriptor from being
invalidated when the controller updates it.

Similarly, the PCIe controllers are marked as dma-coherent in your
devicetrees. A misconfiguration there could also cause problems.

I suggest we merge my fix that adds the missing memory barrier, and
which users have now been testing for a week without hitting the
corruption (which they used to see several times a day).

Then we can continue to track down why you are having coherency issues
on qcs615 and qcs8300. You really want to make sure that that is fixed
properly as it may lead to subtle bugs elsewhere too.

Johan

