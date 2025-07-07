Return-Path: <linux-wireless+bounces-24875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEFAFAE79
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 10:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECEE17DBCE
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 08:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824A727A10D;
	Mon,  7 Jul 2025 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="UFZrBgcS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3FD264FB3;
	Mon,  7 Jul 2025 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876414; cv=pass; b=X0KNQQcqw/OwZcBKQxyWOH+8WfFrBMk6YkN75u41r+znslNiT23goYdinFLoo/7omIJv9IB04BPqXZo6vbOvSf3M+Gx47cR7kYGNIxb80e/vTRtmGxYJ73OvHgz7rhdcfoaXilK4LVjo5Joe18n49Kad5svocRAuX7SLPRtJQ8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876414; c=relaxed/simple;
	bh=3MKAEejzHE0B203hRdT6OBl+UuAzjQBEs0nPFSsun0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCnM+5dArmqY+liqDfAZ60XbE8gW175G63w/0teqXC0K3/vG2bxeYk6w5YEYo3fnHLQtk6seykuwscyjf2su2cT2lN+yj5ejpSZhKpGUq/uIVha13mbuA13926Ih6NBFrIt4tJTdNaM/ysgTyyFdoSv5/H5pzoTXugu8X/XgwgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=UFZrBgcS; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1751876344; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=igFlfYvEXhlXgoPL6DEL2GitSCJrVYbnRz8GLiJs6cvtEstaulrFDQYdvHBIw6Rep2LlLwO84rm2mHGRQvC6pWsrzGXOXKXgZwHq5np43hP3pkP9NBSm2hZaDkGIPZtLKSz2Pc02rVa0rtT6VKnVrC0cJyzGqTnCR3UairQ7vCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751876344; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jWxn6Oq+GTH3S5wXfP2bgRDrz0TNEQi+/ff2XEBKYDc=; 
	b=Oa90lN9z3w6aoXKTgqKTEioxV64OAmzoP6yAglSeZfPsOVzsl9aZqatSWm9MI7+TACZBEBKAi/EPLMy51LNjq0dmDdlTMaUmHLQ/PYL1pPuPWvS8mkKaFb7nyXvt/soxa/5OwjBYNhb2M9Pn1KBJ8amPUMLtFjiDFe5gpA3TG9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751876344;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jWxn6Oq+GTH3S5wXfP2bgRDrz0TNEQi+/ff2XEBKYDc=;
	b=UFZrBgcS5IdQVSVhBDth7UHDAhf5y2E12rIcC+TiojqDMH653ZGhlXdq9ErXl56Z
	JvSZB2XGBLtD9kGoeVvjVMJcf9KwwyVsUksNzLxkuMuPjMsQM7bNSUMumkp51EBgtgP
	iG45Tsn6MVOdJmDfydCA4u9mTgaP+3JihbMQbbjI=
Received: by mx.zohomail.com with SMTPS id 1751876341407602.7677931388906;
	Mon, 7 Jul 2025 01:19:01 -0700 (PDT)
Message-ID: <a92b3d96-0c19-49c2-ad8b-ad31dec973c3@collabora.com>
Date: Mon, 7 Jul 2025 13:19:00 +0500
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
 <29ba0afa-9a1b-40f9-a174-d03902ea5d3f@collabora.com>
 <8b9eb6f4-6f0c-458d-b1e6-a1893c35b81d@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <8b9eb6f4-6f0c-458d-b1e6-a1893c35b81d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/3/25 6:59 AM, Baochen Qiang wrote:
> 
> 
> On 7/3/2025 12:12 AM, Muhammad Usama Anjum wrote:
>> Thank you for reviewing.
>>
>> On 7/2/25 8:50 AM, Baochen Qiang wrote:
>>>
>>>
>>> On 6/30/2025 3:43 PM, Muhammad Usama Anjum wrote:
>>>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>>>> deallocated and there is high possibility that we'll not be able to get
>>>> the same memory allocated from dma when there is high memory pressure.
>>>>
>>>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>>
>>>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>>  drivers/net/wireless/ath/ath11k/core.c | 5 -----
>>>>  1 file changed, 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>  	mutex_unlock(&ab->core_lock);
>>>>  
>>>>  	ath11k_dp_free(ab);
>>>> -	ath11k_hal_srng_deinit(ab);
>>>>  
>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>  
>>>> -	ret = ath11k_hal_srng_init(ab);
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>
>>> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
>>> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
>> Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
>> in resume handler? So when device wakes up, its state is already correct.
>>
> 
> Hmm... not quite understand your question. Can you elaborate?

I'm trying to understand the possibility of cleanup of hal in suspend handler. For example:
* The driver has been loaded and has been working fine.
* The user called suspend. So all devices would be suspended.
* In suspend handler of the ath11k, we should do the necessary cleanups of the states
  like hal.
* When the device would resume after long time, the hal would have the correct state
  already. So we'll not need to deinit and init again.

> 
>> I'm not sure why it worked every time when I tested it on my device.
>>
>>> avail_blk_resource, current_blk_index and num_shadow_reg_configured etc.) inside the
>>> _init() needs to be kept as the later operation needs a clean state of them.
>> So should we just memset these 3?
> 
> more than them I think. We need to take care of all entries in hal since current code is
> memset them all.
I see. So memset the whole ath11k hal structure other than the config.

> 
>>
>>
>>>
>>>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>>>  
>>>>  	ret = ath11k_core_qmi_firmware_ready(ab);
>>>
>>> the _deinit() is still getting called in case ath11k_core_qmi_firmware_ready() fails,
>>> making it a little odd since there is no _init() anymore with this change, though this is
>>> the way of current logic (I mean the hal is currently deinit in the error path).
>>>
>>> Thinking it more, if we hit the error path, seems the only way is to remove ath11k module.
>>> In that case the _deinit() would be called again in ath11k_pci_remove(), leading to issues
>>> (at least I see a double free of hal->srng_config). But this is another topic which can be
>>> fixed in a separate patch.
>>
>> I don't think this is the problem as HAL is already initialized when before the system has
>> suspended. So by removing deinit() and init() pairs, the HAL still remains initialized. Or
>> maybe I've missed something?
> 
> Yeah, it is OK in normal path. However in error path we face issues.
For example:
* When driver was initialized the first time, the hal was init.
* Then system was suspended and hal doesn't get deinit.
* At system resume, the hal is already init. We can memset some status variables. But its
  initialized already from the first time. (considering this patch that deinit/init have
  been removed)
* So at this stage if some error occurs and we can call the deinit in the error paths.



