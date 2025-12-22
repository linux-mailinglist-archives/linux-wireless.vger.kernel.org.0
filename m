Return-Path: <linux-wireless+bounces-30041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328C3CD49EC
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 04:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B4493005FDF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 03:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62E025C6F9;
	Mon, 22 Dec 2025 03:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ta7BolsG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MAKOi0Zs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFBA19992C
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373863; cv=none; b=mN5dfZLBKr9ecLSIIXXHqInpBYCX+MCnoqsMgm9qRpCHImH9nCUp7EMfK1hAjLSUPVzrQIiSuY3+7vyyFdHSuJMi76oZpzLHGXGJ93TwS9e3rVK1194qCcuhwCNBTD2iW1ETQJ3AsEdSqMemWN5u0HWbsYIPzdQLWCUZWtMRFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373863; c=relaxed/simple;
	bh=wEBNv2zQPQ6qnFCp2ZwOhivffZkHUTl/rHX4h55rhvU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fDSs5ftRcVdy7+kFs2OGxsAC2fqzvusJcuSV7mx2TmFsky0VqbehJkzOdBaSYObzysJ+6N3/uchu2uzTDCduMSfR0mIc+y0rdVGuOSEBQmk1Cr7vvZLiH0tGk3Qu2b4DPz34uuJj4ninnrmqhCYMOpuQPn2qVHC5gSUFZY3Zmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ta7BolsG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MAKOi0Zs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLNoMDf3865657
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KokLN2f6s0lWOZzuwSebE5Ps7kCCbczKjZeZ8YRvtjM=; b=Ta7BolsGdqwdDtqZ
	vESRwvVaDlu59zgWAdUGPIeOsu7VNwZ09K52eCBOx9jWkmVKYmFRdMA/nsxEBpx9
	1lo+MHe82Ef4UvaJr3vPrSMEB8HJUnL5x6iGBkIrAWHwsfcXvyGyujnci1b34vS8
	74yg9V3tFqbaRbIXBblTpR5O/7McXNn/b9/7k1nH1C30cdmtT5+uIaETWBYuP07t
	nBq2XNUzP8t3f3YEMWQQOqgXCeWFVsfS7upLpNe4WsZHOv6GmOZxtpD5gQkyeV58
	rFnmUzysDDiDrZA3+x+Xan0x5tj4Qy7lo7pxVfGRFR+pAW+VV+XU+FSXB7jyXUnf
	n+veYw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5mrtbf9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:24:20 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so6615626b3a.3
        for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 19:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766373860; x=1766978660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KokLN2f6s0lWOZzuwSebE5Ps7kCCbczKjZeZ8YRvtjM=;
        b=MAKOi0Zsk4wn3PLXLjeJ5zfezGcrB3Hru5TbzJxb1suAcIzEuVgmlwPXPXSH1hhY64
         uAbmX9JxoGhQlzIpQ3tUZzPhD7DpdQPLFFzlnIjBvpRJdIv7W0+ml8/TPB/ub/9bDO5g
         sbyZX0v9cXPtkN7ZjxjFTMkL1ny7C8PvH0PPz+0XXaNyrzONqgl8DHVdUOvAEkUzPJSV
         szqmPifBHzfnmIwq/G+ptkaHkNKM+GdIG7bEFEMua6lqNWSYOqLe3a/8phPGjo/L3MN7
         09EiRV3u9nncXh1o1BwqQKJGdbj0XuQ2CfNI+EQCYSCJdKfyFqd1ijkKWoFDQRyhJ2kU
         coow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766373860; x=1766978660;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KokLN2f6s0lWOZzuwSebE5Ps7kCCbczKjZeZ8YRvtjM=;
        b=Z7kXRfep84haptO+/r8d9I2q5nDjyX4RGrYpNDB0DxUFAfk7a5AMXjrgKkEW521Jp1
         U5cj6V3v2jWbP+YuRwqo20Ghm2DqZDAdOq2008tP0HdCFtX40TXipIrjYnf1y0dExEaj
         OxpptTJ+BGN3nr0TmcBuQ5Qo7Ult4l+tiKUEMXnIehRQ2xg0+kD8Ag2IB2v0dDj5Vlkx
         ALokVxSxkAihJwpPuOOTuWiLQpiTcADwMcQQngc7eedAy7j7TGBcxrVW+mZ1XyGlnDIZ
         l90Ugf0dv9nDQoDRp2Eb9aRvssN0LGTKft3gRmeakebPro+eTBEu5XSB2mIFDvcDcOD9
         lGRA==
X-Gm-Message-State: AOJu0YzWkUq80O4BccwcqIoJls6CfSjXmvw4BEE9LAu2mReEbLOqmnbO
	TzdeZnt3n2f3WSLs9XdTgB0nFEa/d5Z9B7xuIILEWPjbJAqKrxSIecKetE53Dc08EZ0ctxevBSH
	N71QtceWxJDrdCfXybGShRGpu2rbsh87xIM+A1r61F1leoW+b1/sRt12Jr+wXkkfBz5+lSkRNYI
	kmLTdF
X-Gm-Gg: AY/fxX7XgANgd9qEjNR0QVqOWhRQA/Qz/cC9cDuB/A60ClP1BpiTgxiQId21Mc4vKca
	qJBFGqqgZZqrfGDkHTC57sd5mIOq9/oqMaj6WUzbNVkE6konlrRXk8b2VF9mffXRqqOzbNlComV
	Ue8rOiQejcmFVgk/fLHmJg/0qRcvUBwDxsVpALZoPBUzmBXYa9hDaV0nTd6qTXxauRdpSq+Ll4P
	KhT5ytZsIPExObt/Ytu1141Pefabt/+PMZOu4VTcMkZxzleHyKC4a7V7RZREz38Fqj8yieV/PGq
	PemLLI+ZP1xZxy5uhMZsufCHlzuYPh+VvV6xjEPJf0vBYatrlQv0Q375acaJY52XUH0w52ogSRZ
	zx64kHUVveMQSVI+rspauy6Kp/jomevdWYJInLiPRz/rjG0FNphU2EYqVnHd/sYIR1fWELIcy6e
	b6yCkOQzs=
X-Received: by 2002:a05:6a00:429b:b0:7f7:2680:7325 with SMTP id d2e1a72fcca58-7ff657a2dd6mr8831353b3a.13.1766373859680;
        Sun, 21 Dec 2025 19:24:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSplvpnRSU1fYBZhg5agrJDk1CG55zGaDvlplGyqY55mYt1JVqPWERt5OdoXcDFWq1eQaeDg==
X-Received: by 2002:a05:6a00:429b:b0:7f7:2680:7325 with SMTP id d2e1a72fcca58-7ff657a2dd6mr8831341b3a.13.1766373859198;
        Sun, 21 Dec 2025 19:24:19 -0800 (PST)
Received: from [10.133.33.213] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48f30bsm8615236b3a.48.2025.12.21.19.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 19:24:18 -0800 (PST)
Message-ID: <67b88f07-b4db-4193-930c-88c3547a083e@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 11:24:16 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead of
 #ifdef CONFIG_PM_SLEEP
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
 <dcd0c9e1-66ae-473b-ad37-5d028dc1bc16@oss.qualcomm.com>
 <72d6e9fa-fa28-4079-851e-00905a7b0dda@oss.qualcomm.com>
 <acb54008-3242-40e6-b6ed-2a5506364496@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <acb54008-3242-40e6-b6ed-2a5506364496@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ruJDmPX_5fh3xtp74y48bUhmlZOcmLZt
X-Proofpoint-GUID: ruJDmPX_5fh3xtp74y48bUhmlZOcmLZt
X-Authority-Analysis: v=2.4 cv=CeEFJbrl c=1 sm=1 tr=0 ts=6948b9e4 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=YGRzt7nt-F64klo2Xg8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAyOCBTYWx0ZWRfXzszYbPfA8Dak
 odXt8ewyJp43bOONtZtzXeVWUgUVHSVCs9EU0/1pJTBZR3Dz210za+sjparVjPmE8PBwClb+kqR
 rurGBBCGiWUYPXh/w3EXVwrjE5aJcZrodssbuCUpSswxx4H1QYa8cQXawPkA+Qt2lCKoEKa0kGA
 9AjEsyMbqC3S3bn/OQ5OUtYWs+X7hWudnbVd+4oKTyEPMpRVdRCNAiww4QiCqq5xgZAHWujsq68
 YNnproRsZf35EH9OxH0ifNUkfGCW6ff6WYUW+iu/oCnCO56zxouhtf4Y0feG6/vl03hcb9QBlZD
 TSpOByg7rd9jq5SSpbfbuk3AD5ZzE+EN6BhJgxq48KC7XoNtfPxefbMBvuKxKRb/AWSheL5k4T9
 w/rm5BXRmw4X8BLRj998qv8buBqEqRIJ5eCZay4SJN1QiTCdBajHJibLRAn5SjVoeh6deIyrdIu
 7GlkAjHPH/e15Hgs9AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512220028



On 12/22/2025 11:19 AM, Baochen Qiang wrote:
> 
> 
> On 12/19/2025 11:12 PM, Jeff Johnson wrote:
>> On 12/19/2025 2:32 AM, Baochen Qiang wrote:
>>>
>>>
>>> On 12/17/2025 7:19 PM, Uwe Kleine-König wrote:
>>>> This increases build coverage and removes an ugly #ifdef block.
>>>>
>>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>>>> ---
>>>> Hello,
>>>>
>>>> I found the patch opportunity while looking in this driver for a different
>>>> reason.
>>>>
>>>> Best regards
>>>> Uwe
>>>>
>>>>  drivers/net/wireless/ath/ath10k/sdio.c | 12 +-----------
>>>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
>>>> index c06d50db40b8..3efe744c0c96 100644
>>>> --- a/drivers/net/wireless/ath/ath10k/sdio.c
>>>> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
>>>> @@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
>>>>  #endif
>>>>  };
>>>>  
>>>> -#ifdef CONFIG_PM_SLEEP
>>>> -
>>>>  /* Empty handlers so that mmc subsystem doesn't remove us entirely during
>>>>   * suspend. We instead follow cfg80211 suspend/resume handlers.
>>>>   */
>>>> @@ -2175,14 +2173,6 @@ static int ath10k_sdio_pm_resume(struct device *device)
>>>>  static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
>>>>  			 ath10k_sdio_pm_resume);
>>>>  
>>>> -#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
>>>> -
>>>> -#else
>>>> -
>>>> -#define ATH10K_SDIO_PM_OPS NULL
>>>> -
>>>> -#endif /* CONFIG_PM_SLEEP */
>>>> -
>>>>  static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
>>>>  {
>>>>  	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
>>>> @@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver = {
>>>>  	.probe = ath10k_sdio_probe,
>>>>  	.remove = ath10k_sdio_remove,
>>>>  	.drv = {
>>>> -		.pm = ATH10K_SDIO_PM_OPS,
>>>> +		.pm = pm_sleep_ptr(&ath10k_sdio_pm_ops),
>>>>  	},
>>>>  };
>>>>  module_sdio_driver(ath10k_sdio_driver);
>>>>
>>>
>>> won't this cause defined-but-not-used warnings if CONFIG_PM_SLEEP not enabled?
>>
>> no because SIMPLE_DEV_PM_OPS() adds __maybe_unused to the dev_pm_ops
> 
> Yeah ...
> 
> But the key here is ath10k_sdio_pm_suspend()/ath10k_sdio_pm_resume()

I mean with CONFIG_PM_SLEEP disabled, SIMPLE_DEV_PM_OPS expands to

	const struct dev_pm_ops __maybe_unused name = {
	/* nothing here*/
	}

hence compiler warns on ath10k_sdio_pm_suspend()/ath10k_sdio_pm_resume()

> 
>>
>>
> 


