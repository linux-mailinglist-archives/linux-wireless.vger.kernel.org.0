Return-Path: <linux-wireless+bounces-24772-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBBAF5E37
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 18:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D813B1C43824
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 16:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8642F85C7;
	Wed,  2 Jul 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="UUJLIsIK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAE81E51EA;
	Wed,  2 Jul 2025 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751472782; cv=pass; b=udjS9MmcTJE9gFwwf8ClNf/5S37hyY+Z/Oi+0r+tc+WnDr3btbuPhc35P7MsHCoMufl7qVlBgmjUvqnf8CHJ9B/CTPI3W29vraSN48ZysfFTqzAlv/cF+Rux/9VV5kfVq8a9vkZXN506Ler23b3XDwqb7pOX5jWFSCcnxcX3RCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751472782; c=relaxed/simple;
	bh=SWr5egc/kBqD2BH1a3muMW35PJI1BXm67zznQoh15y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSAhAdsghBsmua/856N/+BesMlwK22i3ioLCdk1LIdl0FIGg7pSvNduatkD0b25z1g8qF7EAifpN/YkbA3pJ1Nb7WwqEvBodlgqnl4iXdti3QpnAFVnBJkBY4Ysyy4ieQ5aTviZbcauoVk+4DilzsHSEqppZB5lYTgWnD3HtP5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=UUJLIsIK; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751472731; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=NZzFzK31qLQT6oSbwobh15Vji65dWAbwwFEkkMNl8TcJmLylR4y0jFb9m3r9DB9kfdcDwjt4smQPkKVF4Zv1rQ1QnAmuo/NqTNRbMwwYpSp3p0vrBoAbI64Zl2AvR/bGm0R6iyZ4D2cHoDvn0B0Uv6WLTCC64wmhHHZoVGq9tKM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751472731; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kHonnTMMDQvh5LezYlicL8UTSbmvRPcd3Q0viWMvaiw=; 
	b=H1wfFrn1OzG3+Woz0eV9r80LdVzL43Q6AeyvONmLFitLxeHh7CELPvQ+kefMppQ+HJEq+Dss5FJWkibjiO8n7YFneZYr2Z/yLuRsto0vtdFRvYzy2VKxnxC9yBXeXO1P/Eds9mGlqP0v1QivK5vagLoejHQmKx7xRl3RTyTHdDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751472731;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=kHonnTMMDQvh5LezYlicL8UTSbmvRPcd3Q0viWMvaiw=;
	b=UUJLIsIKL6CdgL+PpjU27TlDEtHpS4PgP0a44fvCO0O8SG+1WXv+HsXtdlfoy65p
	NiRGQ4QQtwAzHywtvNoD6Xar+G5wTAJO5XgRU43vkNvqN4P1hABmGY3/22iMVafyIf9
	Fwe2NnKacPYKkonXzw5SH0EIdGlYvdWyhFNmDdaY=
Received: by mx.zohomail.com with SMTPS id 1751472728803823.4525464952651;
	Wed, 2 Jul 2025 09:12:08 -0700 (PDT)
Message-ID: <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
Date: Wed, 2 Jul 2025 21:12:00 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
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
 <5f2a900a-3c8e-4b16-bd91-500af7d0315e@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <5f2a900a-3c8e-4b16-bd91-500af7d0315e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Thank you for reviewing.

On 7/2/25 8:50 AM, Baochen Qiang wrote:
> 
> 
> On 6/30/2025 3:43 PM, Muhammad Usama Anjum wrote:
>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>> deallocated and there is high possibility that we'll not be able to get
>> the same memory allocated from dma when there is high memory pressure.
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
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
> 
> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
in resume handler? So when device wakes up, its state is already correct.

I'm not sure why it worked every time when I tested it on my device.

> avail_blk_resource, current_blk_index and num_shadow_reg_configured etc.) inside the
> _init() needs to be kept as the later operation needs a clean state of them.
So should we just memset these 3?


> 
>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>  
>>  	ret = ath11k_core_qmi_firmware_ready(ab);
> 
> the _deinit() is still getting called in case ath11k_core_qmi_firmware_ready() fails,
> making it a little odd since there is no _init() anymore with this change, though this is
> the way of current logic (I mean the hal is currently deinit in the error path).
> 
> Thinking it more, if we hit the error path, seems the only way is to remove ath11k module.
> In that case the _deinit() would be called again in ath11k_pci_remove(), leading to issues
> (at least I see a double free of hal->srng_config). But this is another topic which can be
> fixed in a separate patch.

I don't think this is the problem as HAL is already initialized when before the system has
suspended. So by removing deinit() and init() pairs, the HAL still remains initialized. Or
maybe I've missed something?

 


