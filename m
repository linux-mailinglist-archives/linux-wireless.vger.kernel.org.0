Return-Path: <linux-wireless+bounces-30040-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C830CD49E3
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 04:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62F413004D06
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 03:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A40E239E7E;
	Mon, 22 Dec 2025 03:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FHbr7xw6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bcf629mo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81D62C3252
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373591; cv=none; b=E9pJSsCIkJHy2LgDFzyfwvkzWWOAmgG9If/1+S1/M4lKuVPUgB0m6uNo1X9qMvvbjv9TMNCJHKFcn6pmqeisq1gkcMO2YQ0oY6Ongn0cG+rr33s0ZgTGWVmOq52FO+m5z0lw20nGykNHmH7f8wxs0X/79d4vrP2ngyUcB0AndTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373591; c=relaxed/simple;
	bh=vdLuLlSn+grvQ2B2H4AE5tQBJPtxOb23uF0sfu6JqnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJankuzkKsg8xB8DoPB3A4pW0Kr7eDGTre9dN/akUJVybNiNfot1RncUbtPMfcookwQHl785ZihPQwoL7RysDUuCcpvQTpTaXP+RSe1DwM6MjIZEadXMvFHFwxglJzoWcZwNgKkAM7NGoHz2TGD1sDbYzceZIKPLNyDWnFELHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FHbr7xw6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bcf629mo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BLMjTP93127495
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L20Ppf5+Rf5pT5ngSQAQpO1ayxSe1/VgOVW+oG7K294=; b=FHbr7xw6aKvSjP3d
	vGqMbimRQwhg0IrizCHZ1WKUF99IJteFzZ/JrJvgGqgsj/kYXqS4YSVPaU5FjRSv
	Zh6hsk9ZzCXT4ZGBn3/nci/5INtCvlGFf5jIUyG/Mw8PpP+ALj5LGbqOzpGMd24Z
	R1pcBccESODitwEst2+GID9pVQKcfZZa8SdFoPBSk/VRpoyppLpT/HEdj8I0tvpp
	aX9p4STfVC8gbK/QPBcXcwM/n3bU2Nc1KP7fjk0aFeW6nA7fGZMJr59luwTAraZN
	4chSHugPteLXKrzNVGmkrxpX7zDBPsXoqfu8YyWNTRxG4IRKGZFL2vJflrknljmr
	bSKeCA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b5n36kfu2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Dec 2025 03:19:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29efd658fadso114998905ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 21 Dec 2025 19:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766373588; x=1766978388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L20Ppf5+Rf5pT5ngSQAQpO1ayxSe1/VgOVW+oG7K294=;
        b=Bcf629mo07q1xFYjoW5CDxhSUJ9r4I006iQCkpy19VtAe3c9Qf1wq12yrZJOLF3Qmu
         3qEYzAOYOPueweYDoiNuZlqtuNHTfnZaUfeehsICIwMkGdxCbkhTlJWB6h5DAKCIhu9x
         x4fysqs8+9IT+brPxR/ALVD/4oyMRjbqHL4tofpr9VnjHfmXt5cfOmyZeL7fYZNAL4Ek
         H23VReycN8sfYHjsF1ca1wWhYb0uYjoyAyZ5CX8yHRnSyC28yazymniNd4kGYYoA+hyu
         zNMjAQ2Fk+9ATlHSNmD91T6qE+sBvBqr35JtjrJjThpwS50r2dSJAZ/2S27Z7V3X3sXN
         twTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766373588; x=1766978388;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L20Ppf5+Rf5pT5ngSQAQpO1ayxSe1/VgOVW+oG7K294=;
        b=f6YKGv2kVEZtvF6GtC5vjHNludTfvUkm6aiHfojekZoq+rFMAYrctHFBM0phRteWpp
         2oAt4GkVvwVEfPoM7ZR/+jDWwf6/DSBF8kEgFFB2lgIOiLEHDGEwjEEaWSg9o9RPClEi
         crHIyFxpVvbLRIIzuj2+iA/8f+5upwEjbuUmHuzRnmzSl8Phl0qpkQxWiRdYP4+VxMiC
         PD/WI0MzDmuVQzYNVuiSKQ3ANBQVkujq0h7GxhWYCBOAQK8J9TISpqJPe78Z8rRJ8aJN
         scZ3ueIwLcNr0R0HD0MZovaniGTuSEKwxkukrPjshhZxe2KR5skcSVdmBHqwYjSr0FM1
         oV0A==
X-Gm-Message-State: AOJu0YwdBSA2hB01CmMp5Ojo6shw+IVlOD9RHaZmVxqYn5xyyWuJ9OxZ
	g9/M4UJpLfLPfaU3/mHsDZZfepP9jaIhAzmdyGzx/vcJ7HBX2mHohYexducazV5YPjemh6xbBMw
	/1dnbb6XQdnTJk15ATS4XLCe1adbRn2ZhC7iOkHXeq1gFZM6emZteyIAGjN/1yveuTk2G6g==
X-Gm-Gg: AY/fxX5WEp46ie1yYP7Zro5IbO3PPajVeX/p4DfGltQ+dCK8NfmOKjt8IssygJ5PUPY
	t+jGeM6rzl+EaVm+6ZYz2jAJFROXuxUesesw3R70UlrQzUqrQNq7UpX1T2uVwVqjxEKaEtQYnOc
	1czk6IUW1eYek8nR2yuquBHMrStXEEn3GzdbNQTHeYewBchZrxZ2GEwiZE8R5BkR6+EtIeI7MFy
	XrE9XeGaDmev3jnSY8YgY+PZ54kjs2X7guRu1PXjCF4agoR3fPnpgDBWY3W3i0DWKJjxcInG4yZ
	jV/X4CElC8P39VRDu1h6e/CWZKW/kp7wMBRc4gIBCTvp66Yn+vbr4nr5Ygv4tP0/F+1UgG4p+Bh
	vNda6+jPzs8pAY4mJMypEK5Mevlfz03lin3GBzBvKUgbF71Kr9w7edzx5AGGpG3B1NJg34wJk+w
	MytBjcwiY=
X-Received: by 2002:a17:903:234a:b0:298:3aa6:c03d with SMTP id d9443c01a7336-2a2f2a3fc97mr100625375ad.57.1766373588337;
        Sun, 21 Dec 2025 19:19:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNnrZY1M64JzL879GOK7P9KN7XkosH6cNOUVQNuGYN0asXUPx8Z8fbmC66Kwt8//8XsJ/ZbA==
X-Received: by 2002:a17:903:234a:b0:298:3aa6:c03d with SMTP id d9443c01a7336-2a2f2a3fc97mr100625165ad.57.1766373587635;
        Sun, 21 Dec 2025 19:19:47 -0800 (PST)
Received: from [10.133.33.213] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d407sm80724535ad.72.2025.12.21.19.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Dec 2025 19:19:47 -0800 (PST)
Message-ID: <acb54008-3242-40e6-b6ed-2a5506364496@oss.qualcomm.com>
Date: Mon, 22 Dec 2025 11:19:41 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wifi-next] wifi: ath10k: sdio: Use pm_sleep_ptr instead of
 #ifdef CONFIG_PM_SLEEP
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <20251217111951.3309170-4-u.kleine-koenig@baylibre.com>
 <dcd0c9e1-66ae-473b-ad37-5d028dc1bc16@oss.qualcomm.com>
 <72d6e9fa-fa28-4079-851e-00905a7b0dda@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <72d6e9fa-fa28-4079-851e-00905a7b0dda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDAyNyBTYWx0ZWRfX3Oa/Jl+HfbU4
 N0MxA0b1J+3STUal1FtphBeojPvniBo2q7FQBmR3Qzv1xq57xKUzrCm6TxANnW7vU2hLtDzmAYU
 WkydUHWDRJmfcp+nJUtjXxE9GSkGJSVeWkcn82SMPdqnTD8b+lyRlwRLOFAWwGtM2w1RP95F7B7
 Igsw933slXHxXOH8kfUcwTweLNDG0yDG16g2aH7SIs4zGGFyYfh41nLU6l4v82p61dPlJ11Nrkz
 Bk+KlXJEniIAvACJtkqeRljJEkgA6ZSdvCt+zLJSj0NUA/ZltYxYYXGKn4gkVHe00leB15JgEGN
 1ls/BixL+tb9rEezo7Y9ycgT1ajpCzh4T5SMt9AzZ/+lP1YinBPNIfslV25c1XEnTxgdu7UWDj3
 +HOKo/w0FQ6GA8oS58mb2cQyEYH/L4Fa2AhA6KoT598ewjzfzmr5nXeeJoiSUNxpnmqhLpab3df
 S8zBoaHgHfrfiaqDAfA==
X-Proofpoint-GUID: FBgLgWRp-hr7gB93MFb7ZbgrppPtMrK4
X-Proofpoint-ORIG-GUID: FBgLgWRp-hr7gB93MFb7ZbgrppPtMrK4
X-Authority-Analysis: v=2.4 cv=VJ/QXtPX c=1 sm=1 tr=0 ts=6948b8d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=IpJZQVW2AAAA:8 a=gyhuY85s6JstAfznKHkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220027



On 12/19/2025 11:12 PM, Jeff Johnson wrote:
> On 12/19/2025 2:32 AM, Baochen Qiang wrote:
>>
>>
>> On 12/17/2025 7:19 PM, Uwe Kleine-König wrote:
>>> This increases build coverage and removes an ugly #ifdef block.
>>>
>>> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
>>> ---
>>> Hello,
>>>
>>> I found the patch opportunity while looking in this driver for a different
>>> reason.
>>>
>>> Best regards
>>> Uwe
>>>
>>>  drivers/net/wireless/ath/ath10k/sdio.c | 12 +-----------
>>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
>>> index c06d50db40b8..3efe744c0c96 100644
>>> --- a/drivers/net/wireless/ath/ath10k/sdio.c
>>> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
>>> @@ -2136,8 +2136,6 @@ static const struct ath10k_hif_ops ath10k_sdio_hif_ops = {
>>>  #endif
>>>  };
>>>  
>>> -#ifdef CONFIG_PM_SLEEP
>>> -
>>>  /* Empty handlers so that mmc subsystem doesn't remove us entirely during
>>>   * suspend. We instead follow cfg80211 suspend/resume handlers.
>>>   */
>>> @@ -2175,14 +2173,6 @@ static int ath10k_sdio_pm_resume(struct device *device)
>>>  static SIMPLE_DEV_PM_OPS(ath10k_sdio_pm_ops, ath10k_sdio_pm_suspend,
>>>  			 ath10k_sdio_pm_resume);
>>>  
>>> -#define ATH10K_SDIO_PM_OPS (&ath10k_sdio_pm_ops)
>>> -
>>> -#else
>>> -
>>> -#define ATH10K_SDIO_PM_OPS NULL
>>> -
>>> -#endif /* CONFIG_PM_SLEEP */
>>> -
>>>  static int ath10k_sdio_napi_poll(struct napi_struct *ctx, int budget)
>>>  {
>>>  	struct ath10k *ar = container_of(ctx, struct ath10k, napi);
>>> @@ -2668,7 +2658,7 @@ static struct sdio_driver ath10k_sdio_driver = {
>>>  	.probe = ath10k_sdio_probe,
>>>  	.remove = ath10k_sdio_remove,
>>>  	.drv = {
>>> -		.pm = ATH10K_SDIO_PM_OPS,
>>> +		.pm = pm_sleep_ptr(&ath10k_sdio_pm_ops),
>>>  	},
>>>  };
>>>  module_sdio_driver(ath10k_sdio_driver);
>>>
>>
>> won't this cause defined-but-not-used warnings if CONFIG_PM_SLEEP not enabled?
> 
> no because SIMPLE_DEV_PM_OPS() adds __maybe_unused to the dev_pm_ops

Yeah ...

But the key here is ath10k_sdio_pm_suspend()/ath10k_sdio_pm_resume()

> 
> 


