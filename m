Return-Path: <linux-wireless+bounces-20503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C66ABA67B32
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 18:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1743919C62B9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 17:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B182116E7;
	Tue, 18 Mar 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRwPBB89"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B67D211711;
	Tue, 18 Mar 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319776; cv=none; b=ukntR7sIYviKFvo81Of1/WeIJiXLh5aL4+m3u6UE1/HS+MWLuxIkqcnsRoD3HJQaj+q0geV2DLW0PEV+t/pny+ObX4Ug1Wu6NpL4RQwMJeYb7JaPpqBLO8F99hI06Wu1Cy8ZlruMnodDhgVKRQkqhUamRvfECar8Pp2FrVgP7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319776; c=relaxed/simple;
	bh=7UfjllCdR6JB488sLvQIQSOghIh0F09d0d7BjGP7AKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRGalxnFDMpVTc+ckuOvy8FPkDqgl4HbW34dkL6LN6rC7/g3K9Q5qEhKyJRsmLSMYNIhU8+kzYQ4TpbOoVxvI0n3gTndeCQUStvCg/Om9UejM5nAk6cRh8vpsq68hl8McDnOKyKIhKU3muHtaxXSvrWiZapsnOfzYeAguQyQQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRwPBB89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E991C4CEDD;
	Tue, 18 Mar 2025 17:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742319775;
	bh=7UfjllCdR6JB488sLvQIQSOghIh0F09d0d7BjGP7AKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRwPBB89NwhX/vPxAPc3guEV+NVZu52CUcBCRPPD1kC/Xy+XANGy52n8UfMerGzQo
	 4bUOuyvGmTlLlyA8yhM/odYmVCouHCCiBTr+euCcokpONBVnlEhqo+IT9SfDvaXLdY
	 xlk9JYA7a2tdcAa1OQsW28FU9k75FiIJy097yZR9j4LyZTMIHJx5f1Js2VkZ3iarpV
	 Dfw8bhM4B4qBhYEDsLdnC5pi1lF7sL2yRClmAOlzXlvdovVbGp3mwEWlhyReQ6qcq7
	 FCcsO6Y/Z0Lv5xfyYFXNHepHj3SL5NC8M9rW1hGVsDmCFVWaKj7C35QDadj7ywQfRu
	 2zu3pleJUtqTg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tuaxr-000000001Bw-3gPJ;
	Tue, 18 Mar 2025 18:42:56 +0100
Date: Tue, 18 Mar 2025 18:42:55 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9mwn3GzpPPZSiTG@hovoldconsulting.com>
References: <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
 <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
 <ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com>
 <Z9gd9Aw5Bug8IKSV@hovoldconsulting.com>
 <f30cf771-a9cd-4d8f-8d10-1640afd33c23@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30cf771-a9cd-4d8f-8d10-1640afd33c23@quicinc.com>

On Tue, Mar 18, 2025 at 03:53:39PM +0800, Miaoqing Pan wrote:
> On 3/17/2025 9:04 PM, Johan Hovold wrote:

> > Then it seems we are looking at two separate root causes for the
> > corruption as the memory barrier appears to be all that is needed to fix
> > the X13s issue.
> > 
> > A user who hit the corruption after 2 h without the fix has been running
> > over the weekend with the memory barrier without any problems. I'll ask
> > further users to test, but it certainly looks like it is working as
> > intended.
> > 
> > And the memory barrier is de-facto missing as the head pointer and
> > descriptor are accessed through (two separate) coherent mappings so
> > there are no ordering guarantees without explicit barriers.
> 
> This situation should occur when there is only one descriptor in the 
> ring. If, as you mentioned, the CPU tries to load the descriptor first, 
> but the descriptor fetch fails before the HP load because the ring 
> returns empty, it won't trigger the current issue.

It could if the CPU observes the updates out of order due to the missing
barrier. The driver could be processing an earlier interrupt when the
new descriptor is added and head pointer updated. If for example the CPU
speculatively fetches the descriptor before the head pointer is updated,
then the descriptor length may be zero when the CPU sees the updated
head pointer.

This seems to be what is happening on the X13s since adding the memory
barrier makes the zero-length descriptors go away.
 
> The Copy Engine hardware module copies the metadata to the Status 
> Descriptor after the DMA is complete, then updates the HP to trigger an 
> interrupt. I think there might be some issues in this process, such as 
> the lack of a wmb instruction after the copy is complete, causing the HP 
> to be updated first.

Yeah, possibly. At least it seems there are more issues than the missing
barrier on the machines you test.
 
> > Now obviously there are further issues in your system, which we should
> > make sure we understand before adding workarounds to the driver.
> > 
> > Do you have a pointer to the downstream kernel sources you are testing
> > with? Or even better, can you reproduce the issue with mainline after
> > adding the PCIe patches that were posted to the lists for these
> > platforms?
> > 
> https://github.com/qualcomm-linux/meta-qcom-hwe/blob/scarthgap/recipes-kernel/linux/linux-qcom-base_6.6.bb

Thanks for the pointer. That's a lot of out-of-tree patches on top of
stable so not that easy to check the state of the resulting tree.

> > Does it make any difference if you use a full rmb() barrier?
> > 
> I've also tried rmb() and mb(), but they didn't work either.

Thanks for checking.

Just to be sure, you did add the barrier in the same place as my patch
(i.e. just before the descriptor read)?

> > And after modifying ath11k_hal_ce_dst_status_get_length() so that it
> > does not clear the length, how many times you need to retry? Does it
> > always work on the second try?
> 
> Yes, the test has been running continuously for over 48 hours, always 
> work on the second try, updated in patch v4.

Good, at least the descriptor-length-sometimes-never-updated issue is
solved.

Johan

