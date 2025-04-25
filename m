Return-Path: <linux-wireless+bounces-22039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE17CA9BFF2
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 09:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070294A8221
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 07:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7203322FDEA;
	Fri, 25 Apr 2025 07:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Np4Ar/u5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4A522F75E;
	Fri, 25 Apr 2025 07:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567005; cv=pass; b=msjXiQquaoNoskrBLVu6L3WrVNoLpqgt644xWZqsZWLAg23cl8x4WUqi0ohIM1NcUGCon5nuL2LzhK9OAkAp6q6P4eSbhK/oIC2U9uNeLOVaM9/GZ60sQJOLKuFrB59AEE+Ol8OnJf+WdDQ7YP89sHFV5sc7JBawaejshWTe22k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567005; c=relaxed/simple;
	bh=RQtI3gn+efvWLyMRJzYXV2oCjgTZh+NpE8aFcXT3ejw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQMIJK5Irqg34pORn5Z6Ye+5yOS6vt+O9Js36wh6zcKGD5HjX5y/IHmlUYSmBDR9nAPCXv5o/4zQd2pt5KcIlRxaHYivIS+UQ7c0zCD0K8aIfN9ZK1cTJ948UKOXCsglYAOVemldrURjtE6LknoOjADtrCyjPVTfPJwb6IJXZkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Np4Ar/u5; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1745566970; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JnQDKjYH3rYWCAwKmiyLBZ2hmlwp0/jemeMxGKdoBD3v02+NNczdU/EHbnloUIZvsYGwW+d1QSDGiD9/WzZk+LG9i1aMX3WwqqpnIXLvmr3sefkhoT48Lan5gNeh/RHVfQLWhRAhKkILOGLHQ41EPAqii3Uu5f2+TpqUeaOt4X8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745566970; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T8tWFVeEPdpMtiUtY+e6f8fdZdq5OaJQE3ekwAwYymg=; 
	b=nngvDYq6pk51V1sVhc3mTV2rbaOhDVdkJB4gt8OfGAmDBm2TFuwzQvM4CQX1hUt2hvbjOhAZFX0miga2pu1P4Pq0+wLLy0ACClwizXLCg0OYa07+MdOA8jEmAjC/USNXK+nmEF89uEd3oZJRtIubkEWTYVT26eI9nVh5NtbvYYg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745566970;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=T8tWFVeEPdpMtiUtY+e6f8fdZdq5OaJQE3ekwAwYymg=;
	b=Np4Ar/u5k/y7WTdImrJp1bJPZ3yjxCjUIudP8B4CtZ9Esy3hZKSvpNu5ql/TZwOJ
	khDO3sai5xoFSmT6JH1qrVZUuEyqzLP+yJSqtnyZGSUFAwADWYS1L+VcJ9opqhTVq/d
	uxq6Jdwp+bq5GjMllXqRx6J/q4y6iVAbIRRN8qLU=
Received: by mx.zohomail.com with SMTPS id 1745566967087809.0756023391033;
	Fri, 25 Apr 2025 00:42:47 -0700 (PDT)
Message-ID: <4d87ef88-3533-4255-adc6-6c268818fe25@collabora.com>
Date: Fri, 25 Apr 2025 12:42:38 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jeff Johnson <jjohnson@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Youssef Samir <quic_yabdulra@quicinc.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunwu Chan <chentao@kylinos.cn>, kernel@collabora.com, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <h2wv7drxntokziiwbzjw5xjzbctbomp6cfcba7ppfbih6o7so7@p6dazv32xfx4>
 <1136c7cb-1c7b-410b-93d2-c74aec939196@collabora.com>
 <cfb3sntvqhupyhm2m5tevpsl77r6mzl2aqzr3wtxvr22bezmp3@qjh7ftr2kdjy>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cfb3sntvqhupyhm2m5tevpsl77r6mzl2aqzr3wtxvr22bezmp3@qjh7ftr2kdjy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/25/25 12:32 PM, Manivannan Sadhasivam wrote:
> On Fri, Apr 25, 2025 at 12:14:39PM +0500, Muhammad Usama Anjum wrote:
>> On 4/25/25 12:04 PM, Manivannan Sadhasivam wrote:
>>> On Thu, Apr 10, 2025 at 07:56:54PM +0500, Muhammad Usama Anjum wrote:
>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>> allocation. There is a crash report where at resume time, the memory
>>>> from the dma doesn't get allocated and MHI fails to re-initialize.
>>>> There may be fragmentation of some kind which fails the allocation
>>>> call.
>>>>
>>>
>>> If dma_direct_alloc() fails, then it is a platform limitation/issue. We cannot
>>> workaround that in the device drivers. What is the guarantee that other drivers
>>> will also continue to work? Will you go ahead and patch all of them which
>>> release memory during suspend?
>>>
>>> Please investigate why the allocation fails. Even this is not a device issue, so
>>> we cannot add quirks :/
>> This isn't a platform specific quirk. We are only hitting it because
>> there is high memory pressure during suspend/resume. This dma allocation
>> failure can happen with memory pressure on any device.
>>
> 
> Yes.
Thanks for understanding.

> 
>> The purpose of this patch is just to make driver more robust to memory
>> pressure during resume.
>>
>> I'm not sure about MHI. But other drivers already have such patches as
>> dma_direct_alloc() is susceptible to failures when memory pressure is
>> high. This patch was motivated from ath12k [1] and ath11k [2].
>>
> 
> Even if we patch the MHI driver, the issue is going to trip some other driver.
> How does the DMA memory goes low during resume? So some other driver is
> consuming more than it did during probe()?
Think it like this. The first probe happens just after boot. Most of the
RAM was empty. Then let's say user launches applications which not only
consume entire RAM but also the Swap. The DMA memory area is the first
~4GB on x86_64 (if I'm not mistaken). Now at resume time when we want to
allocate memory from dma, it may not be available entirely or because of
fragmentation we cannot allocate that much contiguous memory.

In our testing and real world cases, right now only wifi driver is
misbehaving. Wifi is also very important. So we are hoping to make wifi
driver robust.

> 
>> [1]
>> https://lore.kernel.org/all/20240419034034.2842-1-quic_bqiang@quicinc.com/
>> [2]
>> https://lore.kernel.org/all/20220506141448.10340-1-quic_akolli@quicinc.com/
>>
>> What do you think can be the way forward for this patch?
>>
> 
> Let's try first to analyze why the memory pressure happens during suspend. As I
> can see, even if we fix the MHI driver, you are likely to hit this issue
> somewhere else.>
> - Mani
> 
>>>
> 
> [...]
> 
>>> Did you intend to leak this information? If not, please remove it from
>>> stacktrace.
>> The device isn't private. Its fine.
>>
> 
> Okay.
> 
> - Mani
> 


-- 
Regards,
Usama

