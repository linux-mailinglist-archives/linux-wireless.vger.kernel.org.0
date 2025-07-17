Return-Path: <linux-wireless+bounces-25595-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6815B08941
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 11:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E638E56430F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2C289E0F;
	Thu, 17 Jul 2025 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="FhzF4R/3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87E289803;
	Thu, 17 Jul 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752744403; cv=pass; b=PnIX75gNzwdP2o9PYyHLyQtyRsJh1nz/4uLMus1qQAo2XxWKNbfIajSOO051Gnz6vbTsxAnn0c2Bp1btLAnGaeWdgWn1UuB2Gh/vkWl2j1uCzSsErZQRJhdCFCvJgBW8Jq9cTbM+BAmhgoIPb9BSAr9vIk55abG+3lisRkY1OKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752744403; c=relaxed/simple;
	bh=f+IM8ifVXCwWGyNHB1bGGaUoGRb4E5qB+YSUinFExkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVIGxn8jDYCEfKYTByc+PKpu6kYTwctgULosQNONPieb1+Z93vxergLFWlBqSDf0myfizt+u2M8iDYz9NnNrxKtzKDJn2EJ5AZJXJAc2I2ByJlaOM+ghRb0ryhunFFaXCr7+djXyN6I4JClsntWheoDqr2s1O60L9MpfUVU5Xc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=FhzF4R/3; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752744333; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=G+rPizvRlW5rcmE6CDCyf4ffA3Z0FKCeRnehUu3cx05zpHGjTR546+Hz1rS6hvGTPIKhqUkwALrBAkBMaKf5ASpZW//wDhgiLANieTtYgnJwTmm0yjLkZFs9I3tL5xu2S1O03ZPc9Simy3HfLBasSZR/hhekIX9mqFUTj9TVQsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752744333; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=myrD4Oc5GjJnUJKj0O/5nUQsBQ9XKBlijpMkJOywH2Q=; 
	b=BFSJrfuHL1RVypiJX4ghnXVEuc2VSeLLYdpjJlyW2uACH/Fn7h3qk7FgRrIVggfHPwadqqi3fnO461VgRKRN7zsi/6lN4NL4zj9vQGbsN9fZ4Xx3Q8QLSVf3rZllNoJrclX6T75rGN8HaHVHEZZ6FvBAWn2F/DkknDLuE0XWvlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752744333;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=myrD4Oc5GjJnUJKj0O/5nUQsBQ9XKBlijpMkJOywH2Q=;
	b=FhzF4R/3dKXmWFVrbFUw/WOBC09YOhBrtYs3UWiU7XcZwUeHA9LM9HMcgJZbEbGI
	ziyCPElmJg04dGAKvZv9FzAQD+Hp7Wdatv8jcXsOGQ8nvLL035/Euisp+JewsUOfrpy
	CkmWfhcp5+6A+3KRSBsSk402iU39IRYTCTqSdMjw=
Received: by mx.zohomail.com with SMTPS id 1752744331135757.2706251805113;
	Thu, 17 Jul 2025 02:25:31 -0700 (PDT)
Message-ID: <656979d8-9ce8-4225-91dc-2236d9e1291f@collabora.com>
Date: Thu, 17 Jul 2025 14:25:34 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>, kbuild test robot <lkp@intel.com>,
 Ganesh Sesetti <gseset@codeaurora.org>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
 Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
 Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
 Sriram R <quic_srirrama@quicinc.com>,
 Rajkumar Manoharan <rmanohar@codeaurora.org>,
 Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
 Bhagavathi Perumal S <bperumal@codeaurora.org>,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250715132351.2641289-1-usama.anjum@collabora.com>
 <7ecc1cfc-5033-4d74-9303-9ac58527113c@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <7ecc1cfc-5033-4d74-9303-9ac58527113c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 7/16/25 8:10 AM, Baochen Qiang wrote:
> 
> 
> On 7/15/2025 9:23 PM, Muhammad Usama Anjum wrote:
>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>> deallocated and there is high possibility that we'll not be able to get
>> the same memory allocated from dma when there is high memory pressure.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>> Cc: stable@vger.kernel.org
>> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Cc stable and fix tested on tag
>> - Clear essential fields as they may have stale data
>> ---
>>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>>  drivers/net/wireless/ath/ath11k/hal.c  | 12 ++++++++++++
>>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>>  3 files changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>> index 4488e4cdc5e9e..34b27711ed00f 100644
>> --- a/drivers/net/wireless/ath/ath11k/core.c
>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>  	mutex_unlock(&ab->core_lock);
>>  
>>  	ath11k_dp_free(ab);
>> -	ath11k_hal_srng_deinit(ab);
>> +	ath11k_hal_srng_clear(ab);
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
>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>> index b32de563d453a..dafa9bdbb3d32 100644
>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>> @@ -1359,6 +1359,18 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>  }
>>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>>  
>> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
>> +{
>> +	memset(ab->hal.srng_list, 0,
>> +	       sizeof(ab->hal.srng_list));
>> +	memset(ab->hal.shadow_reg_addr, 0,
>> +	       sizeof(ab->hal.shadow_reg_addr));
> 
> nit: I would add comment here that no need to memset rdp and wrp memory since each
> individual segment would get cleared when
> 
> ath11k_hal_srng_src_hw_init()
> 	*srng->u.src_ring.tp_addr = 0;
> 
> and
> ath11k_hal_srng_dst_hw_init()
> 	*srng->u.dst_ring.hp_addr = 0;
I'll add:
	/* No need to memset rdp and wrp memory since each individual
	 * segment would get cleared ath11k_hal_srng_src_hw_init() and
	 * ath11k_hal_srng_dst_hw_init().
	 */

> 
>> +	ab->hal.avail_blk_resource = 0;
>> +	ab->hal.current_blk_index = 0;
>> +	ab->hal.num_shadow_reg_configured = 0;
>> +}
>> +EXPORT_SYMBOL(ath11k_hal_srng_clear);
>> +
>>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
>>  {
>>  	struct hal_srng *srng;
>> diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
>> index 601542410c752..839095af9267e 100644
>> --- a/drivers/net/wireless/ath/ath11k/hal.h
>> +++ b/drivers/net/wireless/ath/ath11k/hal.h
>> @@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
>>  			  struct hal_srng_params *params);
>>  int ath11k_hal_srng_init(struct ath11k_base *ath11k);
>>  void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
>> +void ath11k_hal_srng_clear(struct ath11k_base *ab);
>>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
>>  void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
>>  				       u32 **cfg, u32 *len);
> 
> other than the nit:
> 
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Thanks,
Usama


