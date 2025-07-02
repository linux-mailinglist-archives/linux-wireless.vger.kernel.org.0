Return-Path: <linux-wireless+bounces-24770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 944DDAF5D3D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 17:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328D57B6FE0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100902D77F1;
	Wed,  2 Jul 2025 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="CuThlUxt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438662D77EC;
	Wed,  2 Jul 2025 15:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470154; cv=pass; b=SsexE3E5nw852JHDdHHy/YsYuqm1BdTy+swXS4DqFNN7J4yYg74Fk6EhEJWN7OxIzAGgwMg304jT87bw1H8XACdvXmU9YQHArxo1AMNLDSOGKUvcM5QLXc0wEcJGUeT4KjEmqSBL5SEWQ3X4ErpiY64sE/tLiROXIseOu/Kt5yE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470154; c=relaxed/simple;
	bh=4XEKQT76LvS3Y6e6rmkm0GkWsEW6Zw0OCCcFcS67QPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q2zxSk3GSZgr39mb4lZURim5wBr4W5OOaRkGcetB8bouCm/+o8QWHNY8eAgFPwPeCR5EckDlmAZkBtU5ROO7rasVDiqxvS0BHhX4k/sg0teP0RnSwkvb0kmj7AjFJJrSRaVw4+VDvCQEyA6fQNIS94mb4CUAv6geADol3kHARXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=CuThlUxt; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751470104; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SRAugPz6P+3S6Ww1NMrFW+rBm8a+V/pHxmp0f5e9ImTqsgawHg7mJ3Xv9atJN5EKT1ZGw8mwJRFq1hX7WPxk1CMyR2dPjoyHcLt+xkq8x6mI7GysxsLtbA4Ds0cxxe6uJUN7IYYTTKw4cx3BI+QILpcUI9pyfjn1h07LFLqZsEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751470104; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vToI/q0SLNdevcT5MHyyQG4DzTsgKvzxpzAhoFP37GM=; 
	b=nT+2wCpivFckHAfh8BQVmjtTtjGhJuqX+kjQ778zgcWJ3Jmqpis2mWAbdbLKFmMss1DyOVPrCQ9qJ18+ftHPw+yzClb5wrtrPRTQwTby6V4zvD7qN9orRHbZAK++NesCIC3GZJxIOQjXXAd5gEKAmT3AKsyunyBVt22WEQi+O3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751470104;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vToI/q0SLNdevcT5MHyyQG4DzTsgKvzxpzAhoFP37GM=;
	b=CuThlUxt/Ev8mupL8U0sZk7gy1qW3SfjKatxNKRlQuqNCOSgV3j+CfBgEql6mOSR
	i6SLjaLJfhb/hEp1z4LZ7ipJk62qa1BFHIH2LjXjOVK7PuNYDJnYP4IeWWmkSAPcewL
	h1YyybETUyOAT4RKpRGgY+YaSBtbtQZTzLJRUSms=
Received: by mx.zohomail.com with SMTPS id 1751470102160518.2344574890795;
	Wed, 2 Jul 2025 08:28:22 -0700 (PDT)
Message-ID: <defad9df-e248-48d2-a3b6-3f057c6f0b76@collabora.com>
Date: Wed, 2 Jul 2025 20:28:13 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-3-usama.anjum@collabora.com>
 <855ae20a-3675-4cce-b87d-6f25fb69e0a8@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <855ae20a-3675-4cce-b87d-6f25fb69e0a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thank you for reviewing!

On 7/1/25 7:49 PM, Jeff Johnson wrote:
> On 6/30/2025 12:43 AM, Muhammad Usama Anjum wrote:
> 
> Subject has incorrect prefix, should be "wifi: ath11k: "
> 
> And ideally it should mention HAL SRNG since it is specific to that allocation
I'll fix the subject.

> 
>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>> deallocated and there is high possibility that we'll not be able to get
>> the same memory allocated from dma when there is high memory pressure.
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
> 
> not quite the right format since it is missing hw version and bus
I've been using the same tag from last accepted patches. How to construct the
correct patch?

> 
>>
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>  	mutex_unlock(&ab->core_lock);
>>  
>>  	ath11k_dp_free(ab);
>> -	ath11k_hal_srng_deinit(ab);
>>  
>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>  
>> -	ret = ath11k_hal_srng_init(ab);
>> -	if (ret)
>> -		return ret;
>> -
>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>  
>>  	ret = ath11k_core_qmi_firmware_ready(ab);
> 
> does this patch have any dependency upon the 1/3 patch?
No

> if not, then it should be sent separately since it should go through the ath
> tree instead of through the mhi tree.
Ohh... I see. I'll send it separately.

> 
> /jeff


