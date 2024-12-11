Return-Path: <linux-wireless+bounces-16245-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F19ECD93
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 14:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C30F281AE2
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 13:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7722368F0;
	Wed, 11 Dec 2024 13:45:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F11233690
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733924700; cv=none; b=AjOuICcS2FwmcESGLawP17Srvv6EDlAvWQ6wjHf9u60QZWf6S9BS+60fuBKKqhP8d1RMF1fJsx95/awXeIfAWCBwZVhN47MDkAGBEQEWIdCOoYcZNCtLf4gu8IK9o8MdSnn6YXKn7mFE8vIKx9kSQHBPgUB6S5sKpWgSZY+XIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733924700; c=relaxed/simple;
	bh=7a3F+AzibRiEDsZ1gon0QCWqFX3YIFz0poJNZD9mdFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd7ToIBOsvV2IxvXFJ46u+0wmdBPhc5Ic5bfRHRWxDD6qwgMLcFUEoYpjb5H0rUfDCOYeioE7/bMXYOjRil+YePNSIFafEDHCLutf8uoHUrNewMkTYvPCALy8FoKfeQz/Pt0tMv9CDrTWMrcquzTbge3vsQLzBx7r2713PUudxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40B6D1063;
	Wed, 11 Dec 2024 05:45:25 -0800 (PST)
Received: from [10.1.30.25] (010265703453.arm.com [10.1.30.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9152F3F720;
	Wed, 11 Dec 2024 05:44:55 -0800 (PST)
Message-ID: <9b2e8ffa-ba2c-46da-a478-eb1fb44b693e@arm.com>
Date: Wed, 11 Dec 2024 13:44:53 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Tim Harvey <tharvey@gateworks.com>, Christoph Hellwig <hch@lst.de>
Cc: ath11k@lists.infradead.org,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com>
 <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com>
 <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de>
 <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
 <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
 <20241210041133.GA17116@lst.de>
 <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
 <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-11 2:31 am, Baochen Qiang wrote:
> 
> 
> On 12/11/2024 7:06 AM, Tim Harvey wrote:
>> On Mon, Dec 9, 2024 at 8:11 PM Christoph Hellwig <hch@lst.de> wrote:
>>>
>>> On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
>>>> After a lot of back and forth and investigation this is due to the
>>>> IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
>>>> is requesting some buffers that are too large for swiotlb to provide.
>>>> There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
>>>> to cacheable memory that could be reverted to fix this but the concern
>>>> was that it would impact performance moving those buffers to
>>>> non-cacheable memory (there are three ~1MiB buffers being allocated):
>>>> commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
>>>> cacheable memory").
>>>
>>> The combination of "buffers" and "swiotlb" sounds like Robin was right
>>> below.
>>>
>>>> The chain of events as best I can tell are:
>>>>
>>>> commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
>>>> cacheable memory")
>>>> - Nov 12 2021 (made it into Linux 5.17)
>>>> - changes allocation of reo_dst rings to cacheable memory to allow
>>>> cached descriptor access to optimize CPU usage
>>>> - this is flawed because it uses virt_to_phys() to allocate cacheable
>>>> memory which does not work on systems with an IOMMU enabled or using
>>>> software IOMMU (swiotlb); this causes a kernel crash on client
>>>> association
>>>
>>> And this is where it started to take a wrong turn, that everyhing
>>> later basically made worse.  If you have long living and potentially
>>> large DMA allocations, you need to use dma_alloc_* interfaces.
>>>
>>> 5.17 already had dma_alloc_pages for quite a while which was and still is
>>> the proper interface to use.  For much older kernel you'd be stuck
>>> with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
>>> but even that would have been much better.
>>
>> Christoph,
>>
>> I'm not clear what you are suggesting be done here. Are you suggesting
>> that ath11k has been using the wrong mechanism by calling
>> dma_map_single for cached DMA buffers? I'm not all that familiar with
>> ath11k so I can't tell what buffers are considered long living.
> 
> those buffers are allocated when driver load and freed when driver unload, so IMO they are
> long living.

The point is that if this driver wants a notion of "cached DMA buffers", 
then it should allocate such buffers the proper way, not try to reinvent 
it badly. That means using dma_alloc_pages(), or modern 
dma_alloc_noncoherent() which is essentially the same thing but with the 
dma_map_page() call automatically done for you as well.

Thanks,
Robin.

