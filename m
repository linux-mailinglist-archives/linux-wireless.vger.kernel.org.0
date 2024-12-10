Return-Path: <linux-wireless+bounces-16127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090569EA71C
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 05:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F4188AEF3
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 04:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC1D2248B5;
	Tue, 10 Dec 2024 04:11:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5F19D897
	for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803901; cv=none; b=gDgy10WPDbQYu2KSB13W1wuVfDQ92gP0xmlauSMTuBALgBHI3IJmcVO130SLBuRboBRDUWT7xCa6v7QQSgk+zRMS+/TYhOuvzBzh+DpqRNKNPQWxFGNcYiO0gqP3vRQUyTqy0CqXR8d/s0KQRwRbaVBUfM/PYkqRznb4ZitzgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803901; c=relaxed/simple;
	bh=zFsZv0jSpwyuQI19qncvelyx3Bf3OhU92E/nbMXeYFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXer6u1qAxrqyLKLvxH0D/oyRlejx9lfU8PUa5uoEbqdkZTr0QsfIrO3NRsBwBbvspnVapQJh8mYSXbEC7Q0j0v28xttMzJtWDXojMHHyHNlMbN6Kdk2go37kfanLx6Dd5hJSELme1Nf+Cku1g5lNqPfaIncTUt1gcjSLjHFWy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 845B168C4E; Tue, 10 Dec 2024 05:11:33 +0100 (CET)
Date: Tue, 10 Dec 2024 05:11:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Baochen Qiang <quic_bqiang@quicinc.com>, ath11k@lists.infradead.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	P Praneesh <ppranees@codeaurora.org>
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
Message-ID: <20241210041133.GA17116@lst.de>
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com> <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com> <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com> <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com> <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com> <20241209081714.GA25363@lst.de> <593c0d63-d8fd-4439-a57a-97340212c197@arm.com> <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
> After a lot of back and forth and investigation this is due to the
> IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
> is requesting some buffers that are too large for swiotlb to provide.
> There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
> to cacheable memory that could be reverted to fix this but the concern
> was that it would impact performance moving those buffers to
> non-cacheable memory (there are three ~1MiB buffers being allocated):
> commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
> cacheable memory").

The combination of "buffers" and "swiotlb" sounds like Robin was right
below. 

> The chain of events as best I can tell are:
> 
> commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
> cacheable memory")
> - Nov 12 2021 (made it into Linux 5.17)
> - changes allocation of reo_dst rings to cacheable memory to allow
> cached descriptor access to optimize CPU usage
> - this is flawed because it uses virt_to_phys() to allocate cacheable
> memory which does not work on systems with an IOMMU enabled or using
> software IOMMU (swiotlb); this causes a kernel crash on client
> association

And this is where it started to take a wrong turn, that everyhing
later basically made worse.  If you have long living and potentially
large DMA allocations, you need to use dma_alloc_* interfaces.

5.17 already had dma_alloc_pages for quite a while which was and still is
the proper interface to use.  For much older kernel you'd be stuck
with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
but even that would have been much better.

