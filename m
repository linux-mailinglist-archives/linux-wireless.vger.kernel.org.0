Return-Path: <linux-wireless+bounces-20434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED8EA6502F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 14:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4EA3A63DE
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52DE239082;
	Mon, 17 Mar 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaCJ5tGf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA70B239089;
	Mon, 17 Mar 2025 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216693; cv=none; b=mSCMNa/F69P7qw1UPVraOYHELgVZKieDoH/S0KcgfGCeSz/0UPymc4quLhONY+KoBTjHjQM6C4452gbusrq/n+gRFPhrLHVPTF7p4SksTY6daBIkCYN1rWw6x2z4A/N/UL4ld0lB6Jbu+SNMokYwH1nUSQBUzRwMLck+X/azvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216693; c=relaxed/simple;
	bh=08/mbPZq69oi0MPCJBNrNKVVKfY/AcsPcbrj1BV7nKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQgKWsm6f7R+j495xZiyAdBdad0j1dx6HuobHIYexKXh8FU/L3JlAXPL7waMCRzIJ974PDEY5S1D+Zq01G4YnwDSlsxUEcMLot28bXP0gV3QnmrxWlveEVPUKZ8hC86Ly9ErIzPXEB4rGCUIM4QQ3/PP8c4TOXWOau0HHyOqlG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaCJ5tGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE46C4CEE3;
	Mon, 17 Mar 2025 13:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742216693;
	bh=08/mbPZq69oi0MPCJBNrNKVVKfY/AcsPcbrj1BV7nKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DaCJ5tGf1S5GGUAmNH+e9/xX3imM5/QsD7zEHFUFr+XbeqW++o5U42Y+USXpRF8MB
	 GrReIXM0ntTnyn/puhLoAkze+/FH9vnLBZB/Ybd907mkXBdc5Y46lOgno71XyvicAc
	 JUQjk8pbLZQjn6y0J4qmpsSR6nxOnsUyiJb4X20uyHqVKvB+Ot8YdgqQG1JKQ00twp
	 0sL6Fi17CE9PTwyLXg5AB0FxCNUXSm9MOPjPdjDGoi56LxtrhMsMCfEAlf+NlMQbzX
	 1pusoQuySYxBczB36aNbmYXQZ4MALX/EuuKbJSv5cJUkOywzRV09d1tlEHY08+io1e
	 7LGfQPPVC7WLg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tuA9E-000000008V6-0o8n;
	Mon, 17 Mar 2025 14:04:52 +0100
Date: Mon, 17 Mar 2025 14:04:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
Message-ID: <Z9gd9Aw5Bug8IKSV@hovoldconsulting.com>
References: <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
 <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
 <ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com>

On Mon, Mar 17, 2025 at 01:52:15PM +0800, Miaoqing Pan wrote:
> On 3/14/2025 4:06 PM, Johan Hovold wrote:
> > On Fri, Mar 14, 2025 at 09:01:36AM +0800, Miaoqing Pan wrote:
 
> >> I think the hardware has already ensured synchronization between
> >> descriptor and head pointer, which isn't difficult to achieve. The issue
> >> is likely caused by something else and requires further debugging.
> > 
> > Yeah, but you still need memory barriers on the kernel side.
> > 
> > It could be that we are looking at two different causes for those
> > zero-length descriptors.
> > 
> > The error handling for that obviously needs to be fixed either way, but
> > I haven't heard anyone hitting the corruption with the memory barriers
> > in place on the X13s yet (even if we'd need some more time to test
> > this).

> After multiple and prolonged verifications, adding dma_rmb() did not 
> improve the issue at all. I think this Status Descriptor is updated by 
> hardware (Copy Engine) controlled by another system, not involving DMA 
> or out-of-order CPU access within the same system, so memory barriers do 
> not take effect.

Then it seems we are looking at two separate root causes for the
corruption as the memory barrier appears to be all that is needed to fix
the X13s issue.

A user who hit the corruption after 2 h without the fix has been running
over the weekend with the memory barrier without any problems. I'll ask
further users to test, but it certainly looks like it is working as
intended.

And the memory barrier is de-facto missing as the head pointer and
descriptor are accessed through (two separate) coherent mappings so
there are no ordering guarantees without explicit barriers.

Now obviously there are further issues in your system, which we should
make sure we understand before adding workarounds to the driver.

Do you have a pointer to the downstream kernel sources you are testing
with? Or even better, can you reproduce the issue with mainline after
adding the PCIe patches that were posted to the lists for these
platforms?

Apparently the descriptors can also be passed in non-coherent memory
for some devices (.alloc_cacheable_memory / HAL_SRNG_FLAGS_CACHED). That
implementation looks suspicious and could possibly result in similar
problems. Are you using .alloc_cacheable_memory in your setup?

Does it make any difference if you use a full rmb() barrier?

And after modifying ath11k_hal_ce_dst_status_get_length() so that it
does not clear the length, how many times you need to retry? Does it
always work on the second try?

Johan

