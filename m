Return-Path: <linux-wireless+bounces-22067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6AFA9C7E9
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 13:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3867616E2C3
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE11E2459EA;
	Fri, 25 Apr 2025 11:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="KjRgrNMd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79F32459D7;
	Fri, 25 Apr 2025 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581351; cv=pass; b=HpjT9BaXRSjXSORFtWsk2eIaJ3rH5e+MZwWm1B9MKDU2gBpnhwZTGLivXe0j9ojxdoancXWC2JwnPPVMZdzA/qYsudvJuUVSpBrDr0FbcNuq0sQmGLzT1fRIQPfwtdn9OKin5mSjfvP1/TEWf08lzWw88Uid5IVHKpj763exa9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581351; c=relaxed/simple;
	bh=1G6AweYjxm0kJiNi3tcdfVXSJehj5SwP9EIh79+Tjd0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tg5jpU52xhm0D21P03BUqC3lQaHWmVYcHpwf9ZJF5o4vISzs+9PnbqeKjS/aOmMqbmO8eWnTeA9xiMxQ8VGFZbCvOI3P6zwZs4t0gkev1xg4ZTK2K256un8iXVLdQPROnpHAr4WW0kvSJz5Xbu9tiVzDneruFgYcqDISOEhMup0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=KjRgrNMd; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745581316; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ATO62M49i6OKXGbXEsqzcVCpnUqkaDPw41NH+jE9uXMYRr4A4p2GnT2e0ExLoNzJYGZ6GttFkpGgICVCqQngHe8+x4QlmH61vOP07dPzlGvfOOsVfd4vVgth8vpIrq2T4mVivjRtmjIBRsjcOEFelzTs66eAlHm37O6yz5T376Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745581316; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l4DUDdg/nGvqN1UdcxVddkB5BkoJ1f3+rZUXbIsl6cU=; 
	b=Wl8eOBZW8/wRHV/gJMpTqYzRfliBCChHOlLNx29kS1HVg2S5FQGYP+5/Ca7vK9csP/rUT4XZjctRmffH3h9BJpETshlcRklQKmL1kCbsgjs5JiEXyNkz2fIqzdgp9m5jfYUVt/3it37EOCG/8eD2oafhiLBQ+gfqBw8CX0Dlwm4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745581316;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l4DUDdg/nGvqN1UdcxVddkB5BkoJ1f3+rZUXbIsl6cU=;
	b=KjRgrNMd+H1um2Hg8ung+jJ23G975Y9PLhHqT5paYiZ0mF18EGWqr9wlZRxNU1P8
	YjGYi2bAbmEGxGhCj6Lo/aQSfqsRexvLRKagUlK+LBmKKEi2ZWwmai+dA4QflPJA1b2
	rlHBTSYt1sYqeLLFRGJRxGE7hjRatpYkBqjjdGdg=
Received: by mx.zohomail.com with SMTPS id 1745581313535618.4441025554677;
	Fri, 25 Apr 2025 04:41:53 -0700 (PDT)
Message-ID: <a403eb91-c90d-444c-b508-c428a8ef1447@collabora.com>
Date: Fri, 25 Apr 2025 16:41:43 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jjohnson@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Youssef Samir <quic_yabdulra@quicinc.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunwu Chan <chentao@kylinos.cn>, kernel@collabora.com, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <h2wv7drxntokziiwbzjw5xjzbctbomp6cfcba7ppfbih6o7so7@p6dazv32xfx4>
 <1136c7cb-1c7b-410b-93d2-c74aec939196@collabora.com>
 <cfb3sntvqhupyhm2m5tevpsl77r6mzl2aqzr3wtxvr22bezmp3@qjh7ftr2kdjy>
 <4d87ef88-3533-4255-adc6-6c268818fe25@collabora.com>
 <y5odcxzms6mwpz5bdxhbjxo7p6whsdgwm772usmmzqobhf6nam@p4ul7vn7d3an>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <y5odcxzms6mwpz5bdxhbjxo7p6whsdgwm772usmmzqobhf6nam@p4ul7vn7d3an>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/25/25 1:59 PM, Manivannan Sadhasivam wrote:
> On Fri, Apr 25, 2025 at 12:42:38PM +0500, Muhammad Usama Anjum wrote:
>> On 4/25/25 12:32 PM, Manivannan Sadhasivam wrote:
>>> On Fri, Apr 25, 2025 at 12:14:39PM +0500, Muhammad Usama Anjum wrote:
>>>> On 4/25/25 12:04 PM, Manivannan Sadhasivam wrote:
>>>>> On Thu, Apr 10, 2025 at 07:56:54PM +0500, Muhammad Usama Anjum wrote:
>>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>>>> allocation. There is a crash report where at resume time, the memory
>>>>>> from the dma doesn't get allocated and MHI fails to re-initialize.
>>>>>> There may be fragmentation of some kind which fails the allocation
>>>>>> call.
>>>>>>
>>>>>
>>>>> If dma_direct_alloc() fails, then it is a platform limitation/issue. We cannot
>>>>> workaround that in the device drivers. What is the guarantee that other drivers
>>>>> will also continue to work? Will you go ahead and patch all of them which
>>>>> release memory during suspend?
>>>>>
>>>>> Please investigate why the allocation fails. Even this is not a device issue, so
>>>>> we cannot add quirks :/
>>>> This isn't a platform specific quirk. We are only hitting it because
>>>> there is high memory pressure during suspend/resume. This dma allocation
>>>> failure can happen with memory pressure on any device.
>>>>
>>>
>>> Yes.
>> Thanks for understanding.
>>
>>>
>>>> The purpose of this patch is just to make driver more robust to memory
>>>> pressure during resume.
>>>>
>>>> I'm not sure about MHI. But other drivers already have such patches as
>>>> dma_direct_alloc() is susceptible to failures when memory pressure is
>>>> high. This patch was motivated from ath12k [1] and ath11k [2].
>>>>
>>>
>>> Even if we patch the MHI driver, the issue is going to trip some other driver.
>>> How does the DMA memory goes low during resume? So some other driver is
>>> consuming more than it did during probe()?
>> Think it like this. The first probe happens just after boot. Most of the
>> RAM was empty. Then let's say user launches applications which not only
>> consume entire RAM but also the Swap. The DMA memory area is the first
>> ~4GB on x86_64 (if I'm not mistaken). Now at resume time when we want to
>> allocate memory from dma, it may not be available entirely or because of
>> fragmentation we cannot allocate that much contiguous memory.
>>
> 
> Looks like you have a workload that consumes the limited DMA coherent memory.
> Most likely the GPU applications I think.
> 
>> In our testing and real world cases, right now only wifi driver is
>> misbehaving. Wifi is also very important. So we are hoping to make wifi
>> driver robust.
>>
> 
> Sounds fair. If you want to move forward, please modify the exisiting
> mhi_power_down_keep_dev() to include this partial unprepare as well:
> 
> mhi_power_down_unprepare_keep_dev()
> 
> Since both APIs are anyway going to be used together, I don't see a need to
> introduce yet another API.
I've looked at usages of mhi_power_down_keep_dev(). Its getting used by
ath12k and ath11k both. We would have to look at ath12k as well before
we can change mhi_power_down_keep_dev(). Unfortunately, I don't have
device using ath12k at hand.

Should we keep this new API or what should we do?

> 
> - Mani
> 
>>>
>>>> [1]
>>>> https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
>>>> [2]
>>>> https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
>>>>
>>>> What do you think can be the way forward for this patch?
>>>>
>>>
>>> Let's try first to analyze why the memory pressure happens during suspend. As I
>>> can see, even if we fix the MHI driver, you are likely to hit this issue
>>> somewhere else.>
>>> - Mani
>>>
>>>>>
>>>
>>> [...]
>>>
>>>>> Did you intend to leak this information? If not, please remove it from
>>>>> stacktrace.
>>>> The device isn't private. Its fine.
>>>>
>>>
>>> Okay.
>>>
>>> - Mani
>>>
>>
>>
>> -- 
>> Regards,
>> Usama
> 


-- 
Regards,
Usama

