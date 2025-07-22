Return-Path: <linux-wireless+bounces-25868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E25B0E000
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 17:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC87562064
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 15:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6651EDA0F;
	Tue, 22 Jul 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="acPssfsk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D341DDA0E;
	Tue, 22 Jul 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753196760; cv=pass; b=J6J0l1pRptIONmM6cBQZpyBSkCFsYEHKW76k1qXV7iM4ihUXPKd9kxjmk3zTwdKZ6IA1+PK2/AEwRF9zc5HXJWJHiG1srojxZ3AvPRV+2FfFVh0WCaP7jKO+pt0sNR7St3EpYiZcgJRufL1OjoDgmLFsS2KapIv+pi435x3BEFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753196760; c=relaxed/simple;
	bh=S9NzapF48kcQ0t4yyxgo8oZIiRW3qF4ZSzJJumpQekk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QEZmMhgc7X2tJ9zWT96QqsWYp3DwiYhaxb2M+icgbWbnuPZ1Nl0w97oR+5r4NY7aSzAvkjn3MSJ1afITt54CusTzL9LgXVajuZkI+dGTVEpq6o6vopjClVKAQpIJl5q1O8E6du1QV5iWCSLvWsvvxdv3h7k+JfapW7ApPp48jWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=acPssfsk; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753196713; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZfS92ml7oakJK2191UnaySAdgMEQgM2gWjzxlfcSiIKuhjdrGJo1jyKFC5fMh32h4KedpJ2cWBFLq0ikPectQ0Ho8doXaUETDRDJAPOI6Ni+3aKQOMZNh91Z7YDdWPdKCBQrxgvmQOveFtuTDVk9bj6zpvUPCCBpgGrFnFxCYr4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753196713; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=B6h9KYWTByAokR/crJv4d6XMusmoK5pSX1xCNc0XzKc=; 
	b=XWy0zr8fDeSinpfTGEu6uJ190C9sO5amsAuz8BWD3c/5awedWBhoq7LR/2tqxlnq4iafMApiwKdFvZVMj7ixf0KWn7Eky17JiXIvKldTNkC15kfEddTT9deLDbJDHjo6AQ6x7j8ERNY+s5zY7IobEj1+U1PdU36XValA1iqcOgw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753196713;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=B6h9KYWTByAokR/crJv4d6XMusmoK5pSX1xCNc0XzKc=;
	b=acPssfskuhVxZGjeP5/h0MnKPl7yzuFa3ElacUGYiujjk/rtWsrrSqH7RSVI++Jb
	sF4wKJAqm1u5+v+lmxs6B2YMgoxXczc9C7f01kzj2TUAKYsoRmaa+qCBWabawjYqrjH
	ivq8pjpTDst9Q5hG1VNCNoYZQE5A76a6vx9UWEfo=
Received: by mx.zohomail.com with SMTPS id 175319671119016.921485936466638;
	Tue, 22 Jul 2025 08:05:11 -0700 (PDT)
Message-ID: <86c465a3-f9a1-4a63-9e21-7529a5634301@collabora.com>
Date: Tue, 22 Jul 2025 20:05:01 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com, stable@vger.kernel.org,
 Muna Sinada <quic_msinada@quicinc.com>,
 Anilkumar Kolli <quic_akolli@quicinc.com>, Miles Hu <milehu@codeaurora.org>,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
 Jeff Johnson <jjohnson@kernel.org>, kbuild test robot <lkp@intel.com>,
 Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
 Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Kalle Valo <kvalo@kernel.org>
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
 <1598d25d-e254-410e-ac5c-66d5450fd686@oss.qualcomm.com>
 <ae7a08cb-af73-4a27-aad4-c852be5f77aa@collabora.com>
 <ab5af5b9-d5a7-434c-938d-3f9aac388542@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <ab5af5b9-d5a7-434c-938d-3f9aac388542@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/22/25 7:07 PM, Jeff Johnson wrote:
> On 7/22/2025 4:23 AM, Muhammad Usama Anjum wrote:
>> Hi Kalle,
> 
> Kalle is no longer a maintainer -- I am currently the only ath11k maintainer.
Sorry, I missed it.

> 
>>
>> On 7/22/25 2:47 PM, Baochen Qiang wrote:
>>>
>>>
>>> On 7/22/2025 1:31 PM, Muhammad Usama Anjum wrote:
>>>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>>>> deallocated and there is high possibility that we'll not be able to get
>>>> the same memory allocated from dma when there is high memory pressure.
>>>>
>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>>
>>>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>>>> Cc: stable@vger.kernel.org
>>>> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> Changes since v1:
>>>> - Cc stable and fix tested on tag
>>>> - Clear essential fields as they may have stale data
>>>>
>>>> Changes since v2:
>>>> - Add comment and reviewed by tag
>>>> ---
>>>>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>>>>  drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
>>>>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>>>>  3 files changed, 18 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>> index 4488e4cdc5e9e..34b27711ed00f 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>  	mutex_unlock(&ab->core_lock);
>>>>  
>>>>  	ath11k_dp_free(ab);
>>>> -	ath11k_hal_srng_deinit(ab);
>>>> +	ath11k_hal_srng_clear(ab);
>>>>  
>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>  
>>>> -	ret = ath11k_hal_srng_init(ab);
>>>> -	if (ret)
>>>> -		return ret;
>>>> -
>>>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>>>  
>>>>  	ret = ath11k_core_qmi_firmware_ready(ab);
>>>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>>>> index b32de563d453a..e8ebf963f195c 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>>>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>>>> @@ -1359,6 +1359,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>>>  }
>>>>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>>>>  
>>>> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
>>>> +{
>>>> +	/* No need to memset rdp and wrp memory since each individual
>>>> +	 * segment would get cleared ath11k_hal_srng_src_hw_init() and
>>>
>>> nit: s/cleared /cleared in/
>> Please can you make this change while applying the patch?
> 
> I can make this change when I pull the patch into the pending branch.
> I'd like to see a public Reviewed-by before doing so.
> 
> Also note that, except for anything critical, I'm not taking any patches into
> ath-next until the upcoming v6.17 merge window closes and all changes made to
> Linus' tree have been backmerged via net-next => wireless-next => ath-next.
Thank you for mentioning. I didn't know the workflow.

No problem. There is no hurry.

> 
> /jeff


