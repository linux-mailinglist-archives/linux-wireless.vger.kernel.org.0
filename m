Return-Path: <linux-wireless+bounces-24924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56659AFC885
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 12:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915491768B3
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36DD2D838B;
	Tue,  8 Jul 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gbgvtn8U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCB02D660D
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751971146; cv=none; b=Tg18B2KV+6j+uPUH/5fTZF57E65vxI3dcwHPIR43UyIFT+ig+ztp3nRk2zfRPtVNfAb108FJZ5s/3TzshXln9kKxgXg+5gMcuZwulfMiz7L/jc2DWLDzdY93qjimFK+zQmf0VzP7vveOJWRnA5BM1qUpGZsTyCnSVUJ0Nwjws6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751971146; c=relaxed/simple;
	bh=1+K2vStuMbWEvbxNn4v5jMkIEs47um7WuK/tPjoaTZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ngOXPac8lSb2EIgH5RaeSLTqs2PKe3hmg+eVqJfxUK7B9ubOrP5IlY3/Z/9vhKsAd3pCXWu6PsrkhbnUmD9UPzJg4MPphUiUpNUMiQmHvYemoa7C3INeBbDa7BaVeVjmlycHNDAyGf2ylsC3t8cnFbwObo5/8h/eCGw4pIetedo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gbgvtn8U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568AAaLN032658
	for <linux-wireless@vger.kernel.org>; Tue, 8 Jul 2025 10:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MBWTgG1nt7QgnG2L1PdtfNApAGuuPN/fOFc0QPePaMA=; b=Gbgvtn8UMww41wns
	B5/R2pshzbfIbdd3D4bOEe4XGEu0os7l3mMaoJjdWOzdBFsGtF/CMQZAqlv5OqSW
	m6gyEdjx3Z5t8UblYJImazagnYYGrZY9hWnwpyvHQ6aNDXZa4gmcn1cPIZa2faxX
	wDckYvzBUiFW0iEBI8L7+EWtY36HgsRe8LF10RAG38CqqwmlpTCCqPwUZcivdaYI
	NQ7a2LgV4d1uFbITP+rWDruwf/jFM8fEbiMFcLWApIOmX2stZNz5B5vWIZwxf9wY
	NnovWdEcBGEAzkLi2yKZNWwXzj/wdoTusg5QRyeTqY7jI5uH3N9Om7FLUmOVlQj9
	KfuVVw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq2xtsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 10:39:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-234b133b428so32316275ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Jul 2025 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751971142; x=1752575942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBWTgG1nt7QgnG2L1PdtfNApAGuuPN/fOFc0QPePaMA=;
        b=PsaWNPIVGRtGyr1Dv6iivEi5hWYItBw3xyAydovoMfDLKulj4pCdrj4UK5Pv5GNWsW
         2t2kVijFzZJPhj9cx+hU3128pG9pnudRHuZoYunIg0fwjABSpxhe5iHdm9ahJY93mIDV
         DebRL/TmFTokYFdTYc7ALGmfjHjZhB30SztlM0m41dSW2bbz+yfIRM93Ur6bBbEFs1ik
         tWMPai/aEijTP/Tu97QGBSHHnxPJtEebS8wvKOWFCroSEwKW4M2oxUid+vlJoXNBMZbH
         e4BiS8thftqLjxRWeFbxkDmJqmVucT8yP+LXP3ycdbN+uqB58gOlEBTEjiP5EiPAjRRs
         O8Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWzJkKtFSjWtcof+aEgLZTbMAXaDVEdN/MpWXf5VJV5sAU67+I6UZhcU1O6pmf8p5YoZd8XaBzn9m8XGbEPMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyITuJNGq6GH99jQHGdR5h9IClN0LQmg/gH5VutUFKy6ZZUZFsL
	Avvkfx7oaa8ASq409f+oi9MUmSFS5u8Mhbp0b6Owi8mVpdMqL0qEoCXrXIfUXQOJe3DnFaP+HJN
	28YZV0kragz5UP5JNBfiK2pRLT2WNJNn7NbuEWqvEF93HiQf5O7SvG4p5cYZiA2vjG/aPmA==
X-Gm-Gg: ASbGnctTaU1CoiWh7rADR6QzD+I2Pqma8DwGohhY/I2XqgyPmzsm/900e/DfDkczlI0
	u4Sj+Hn4po89KZWNYjiRf16AmfnSqBAl93lCTKCE3e0DmvR+8XCv/LblsjqnLHfNCINiXKQSNhR
	aVyI4Mif1AnFJKpQqMippYmBKSJZKvL35emvmnSBxvQFBRXlFX0bh/kszqxcqkx9gpCpZjpfijU
	/8ERCBkVE8MhyYm8GdyXWeS1bweM0dVQcCZm0I3LzsOEOaL/w29fh3KmXPYxTur6IsqNh6YCWBo
	ZZXkukxBkVAPYAOa0xS0+W4FaveAHbC1nFX8smyA4HNwQXRPJtEZZs+reZkTQZeWfpysS5Z/s67
	wPMt6p5YNVcB6nMw=
X-Received: by 2002:a17:902:e788:b0:234:1163:ff99 with SMTP id d9443c01a7336-23dd1d7ef95mr32972075ad.43.1751971142359;
        Tue, 08 Jul 2025 03:39:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC/n1Wv16I6oi8TfKFbGm9RVJSuG7cMjQtpyIJkVs3+lkD6ynLF8cQTccR4h0hqlT00wE5zA==
X-Received: by 2002:a17:902:e788:b0:234:1163:ff99 with SMTP id d9443c01a7336-23dd1d7ef95mr32971795ad.43.1751971141853;
        Tue, 08 Jul 2025 03:39:01 -0700 (PDT)
Received: from [10.133.33.177] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8435022dsm114182915ad.86.2025.07.08.03.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:39:01 -0700 (PDT)
Message-ID: <7aa0ac35-068f-4738-abbd-f1073294365b@oss.qualcomm.com>
Date: Tue, 8 Jul 2025 18:38:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bus: mhi: don't deinitialize and re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
        Youssef Samir <quic_yabdulra@quicinc.com>,
        Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
        Alexander Wilhelm <alexander.wilhelm@westermo.com>,
        Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Julia Lawall <julia.lawall@lip6.fr>, John Crispin <john@phrozen.org>,
        Muna Sinada <quic_msinada@quicinc.com>,
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
 <a92b3d96-0c19-49c2-ad8b-ad31dec973c3@collabora.com>
 <7b8ea9ba-02ef-4676-a4d3-d088920283c3@oss.qualcomm.com>
 <9eba0149-290d-4010-8791-d4d8d8be3786@collabora.com>
 <fdb9f1e7-bf8f-4018-b0ac-ac8a70d9b8ec@oss.qualcomm.com>
 <5c9843b5-d756-4a99-b93f-d32ed8f16e32@collabora.com>
Content-Language: en-US
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
In-Reply-To: <5c9843b5-d756-4a99-b93f-d32ed8f16e32@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA4NyBTYWx0ZWRfX0+dk3tje1uvS
 b2z0UP2iBdyYPTtaYclNiPr86xRPCtQh3UwP5V4s/DG8E4Tgd6CUXrca7Mcuq2yqiSYAsOPm3XQ
 uaZbVpsT6iynCKWSK/FHidme7ePz1NFC2uP3NF2KaBlcW9mwTEIk5prnXvExO8iy8hU/GAmNYEY
 6jDa3H7SvioQeyfFrVdMUE80tYq110L+ok+QuFDjBtUJIomrG3vxEUIZER3Y1Y4GyDjuUS39RSu
 DNV90onD38b9LenRI/+4rnzWNDZVbLMjVKhwoXYd5kDprOGJFH1GCHngS16tKHdg6lnnGBYD4xd
 6l3oFnk9JaR3OD48c+vh/bIKZNDnb2dAG0SbNzlJe4hBb8Rqh2+aiyPT4tuaT+cnWJc9dTyUPuR
 fHnMIzzpIy1WZ0K9MMtz9ylm3/DEcKUBK0wnGGCumwbmf7OVzuSVKSTHqaMtb7xE2NOX+67H
X-Proofpoint-ORIG-GUID: NPZIrO_vdamGoKDgbKP-egPvcrZFcWhN
X-Proofpoint-GUID: NPZIrO_vdamGoKDgbKP-egPvcrZFcWhN
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686cf547 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=n4c7CGo1Dgpf3paWKKAA:9
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080087



On 7/8/2025 5:12 PM, Muhammad Usama Anjum wrote:
> On 7/8/25 6:43 AM, Baochen Qiang wrote:
>>
>>
>> On 7/7/2025 9:11 PM, Muhammad Usama Anjum wrote:
>>>>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>>>> index 4488e4cdc5e9e..bc4930fe6a367 100644
>>>>>>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>>>>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>>>>>>> @@ -2213,14 +2213,9 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>>>>>>  	mutex_unlock(&ab->core_lock);
>>>>>>>>>  
>>>>>>>>>  	ath11k_dp_free(ab);
>>>>>>>>> -	ath11k_hal_srng_deinit(ab);
>>>>>>>>>  
>>>>>>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>>>>>>  
>>>>>>>>> -	ret = ath11k_hal_srng_init(ab);
>>>>>>>>> -	if (ret)
>>>>>>>>> -		return ret;
>>>>>>>>> -
>>>>>>>> while I agree there is no need of a dealloc/realloc, we can not simply remove calling the
>>>>>>>> _deinit()/_init() pair. At least the memset() cleanup to hal parameters (e.g.
>>>>>>> Why do is it being done in the resume handler? Shouldn't those parameters be cleaned up
>>>>>>> in resume handler? So when device wakes up, its state is already correct.
>>>>>>>
>>>>>> Hmm... not quite understand your question. Can you elaborate?
>>>>> I'm trying to understand the possibility of cleanup of hal in suspend handler. For example:
>>>>> * The driver has been loaded and has been working fine.
>>>>> * The user called suspend. So all devices would be suspended.
>>>>> * In suspend handler of the ath11k, we should do the necessary cleanups of the states
>>>>>   like hal.
>>>>> * When the device would resume after long time, the hal would have the correct state
>>>>>   already. So we'll not need to deinit and init again.
>>>> The hal cleanup is not only needed by suspend/resume, but also a step of reset/recover
>>>> process. So If we are moving the cleanup to suspend handler, similar stuff needs to be
>>>> done for reset/recover as well.
>>> It makes sense.
>>>
>>> So clearing the hal structure completely other than ab->hal.srn_config doesn't seem
>>> right. I've also tested it and it crashes the whole system.
>>>
>>> On contrary, with only the current patch applied, there is no abnormality.
>>>
>>> num_shadow_reg_configured and avail_blk_resource are non-zero. If I make them 0,
>>> driver still keeps on working.
>>>
>>> 	ab->hal.num_shadow_reg_configured = 0;
>>> 	ab->hal.avail_blk_resource = 0;
>>> 	ab->hal.current_blk_index = 0;
>>>
>>> As you have suggested setting these 3 to zero, is there any other variable in hal
>>> structure which should be set to zero?
>>
>> IMO srng_config, rdp, wrp and srng_key may keep unchanged through suspend/reset, all other
>> fields should be cleared/reinitialized.
> 
> memseting srng_list and shadow_reg_addr causes crashes. Please can you confirm why do you
> think those should be memset. Here is WIP patch:

We need to make sure they have a clean state while resume/recover.

> 
> 
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>  	mutex_unlock(&ab->core_lock);
>  
>  	ath11k_dp_free(ab);
> -	ath11k_hal_srng_deinit(ab);
> +	ath11k_hal_srng_clear(ab);
>  
>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>  
> -	ret = ath11k_hal_srng_init(ab);
> -	if (ret)
> -		return ret;
> -
>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>  
>  	ret = ath11k_core_qmi_firmware_ready(ab);
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index b32de563d453a..d4be040acf2c8 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -1359,6 +1359,19 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>  }
>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>  
> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
> +{
> +// --> both of these memset causes crashes
> +//	memset(ab->hal.srng_list, 0,
> +//	       sizeof(ab->hal.srng_list) * HAL_SRNG_RING_ID_MAX);

You are memset too much, just sizeof(ab->hal.srng_list) is OK.

> +//	memset(ab->hal.shadow_reg_addr, 0,
> +//	       sizeof(ab->hal.shadow_reg_addr) * HAL_SHADOW_NUM_REGS);

same here

> +	ab->hal.avail_blk_resource = 0;
> +	ab->hal.current_blk_index = 0;
> +	ab->hal.num_shadow_reg_configured = 0;
> +}
> +EXPORT_SYMBOL(ath11k_hal_srng_clear);
> +
>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab)
>  {
>  	struct hal_srng *srng;
> diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
> index 601542410c752..839095af9267e 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.h
> +++ b/drivers/net/wireless/ath/ath11k/hal.h
> @@ -965,6 +965,7 @@ int ath11k_hal_srng_setup(struct ath11k_base *ab, enum hal_ring_type type,
>  			  struct hal_srng_params *params);
>  int ath11k_hal_srng_init(struct ath11k_base *ath11k);
>  void ath11k_hal_srng_deinit(struct ath11k_base *ath11k);
> +void ath11k_hal_srng_clear(struct ath11k_base *ab);
>  void ath11k_hal_dump_srng_stats(struct ath11k_base *ab);
>  void ath11k_hal_srng_get_shadow_config(struct ath11k_base *ab,
>  				       u32 **cfg, u32 *len);
> 
> 


