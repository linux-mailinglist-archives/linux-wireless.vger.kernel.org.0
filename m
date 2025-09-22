Return-Path: <linux-wireless+bounces-27589-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A073FB93697
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 23:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563B94429C8
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D82F5461;
	Mon, 22 Sep 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkT9iD5y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D20A26A0BD
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578357; cv=none; b=lfwdSwxK67Ww1xFWqTCmngsoGlnE7jBcKN+Auu717J0dVz+uyHzDEg4UbVve9kFPrbSruuxNPxskTtteql0mx1zoxH5vSXE4FKSHXhjxrfZWCMZUwGnNkK7io8CjdiHNVP0YrSmXmdRXH7u4ecu9u5SPeveyh/1UVkfWb5kifJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578357; c=relaxed/simple;
	bh=8EAdYteEsZfi3L8LNoGQ5Mo9rWCKtDhbyQqf6B5Tt4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2X8ssUr+0FKJiLkZsfzwA1HrpaDa1qSLw/epNiYKgwlCPWWwU2Vr5fVFs87sRSAOsoUGpghypk3pnE4rVSU830WRXADag8pmeOvhy2/yAAf18LPaWkE6FOOvPrHWa1MqSqwXwnQsWloKnPUQXQEu7TU8NNy9q1zoR28VtM9sXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkT9iD5y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MH6E0U028009
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 21:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0LDmHGPzBvAlIgIdJc1sMUYY1nDOFFKwgh16pYuyb2I=; b=AkT9iD5yDkz2ePE9
	hYrle13HGQ84SwGViegVrJ6NjaVVf9fJ3FyaBJbfL1X2x4RT/lgN52Ml6+WHRQyt
	5YeTnbs3lnpqBjHSuHMcEBOCdK0mJFmXPHOs++OGR2rrJUeSAdNcPNlYQ0t/NqCs
	eu469/Us5gX6j/GKWdY2LCTXlsio0Kdeorghcz8EFiqvI48bT8Z0OprjBhROMVKu
	PzkXjw3Qqr/fyYTH4MMmuhHXAgkBXFl4A8WVyyhLa8B7CRRgrYU4UQLT00RuplP+
	rVulvB0RwxUFSr0/FpwByc2FLc17qGncFQ2AjO1R6V4lOpZja55LzhuXaKs5DbuF
	wr9qQw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bajerrjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 21:59:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24458274406so101904225ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 14:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758578354; x=1759183154;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LDmHGPzBvAlIgIdJc1sMUYY1nDOFFKwgh16pYuyb2I=;
        b=oO68FqP3BgbI5jMvruQs35S+fQ3tzCasZD3zB/mFjtRzShfFjveHhi8zfs7PgLFans
         E4GT+VP+CVQqE04apEXvsLlmwvVB+regkFGuCvUw5F0pOohKyyTmxe/4X/i5azOx4Bqz
         NP3hRqkff9cXI7F49kNgR2Usx0MZhmpx6AfXaf52u/MFiME0kA56pqKXrfsQFpazdlkx
         4MBcyxtKvcQLgfKXXcFc/g5qi8Td98egIy97V4YN6vdX9glwyU2X0Rx7GuTFpoNQG26t
         BqIgqIXKIvOPUjg43M7+CQxHddByI256gSQZ3eb/etLIVQbAUPeMwcSaweU2ve8s6BHe
         c2IA==
X-Forwarded-Encrypted: i=1; AJvYcCUc2ByUQLPCX4zHY7XUHCOmRsTwpEQK6bLnp8Bafvdbz8UGSGoJLh2ghKkoeUdH5tGarA3z2xEpAR4YoCQG+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyARBBCaZ17RpTpeCXXGV92BBO+lv59FGINddNgHKeGz1YJI1pV
	Yvm3gYuiQGQI0IGGR/OKhhB3k+EIkNXyJu/EkXF42nTrpTFhSnSnyk9Ayf7QtbDxqtlkpARDX6r
	7R0NxwlqUZYGG4b3L/PcgSRexb+DoQpDBrRW7ctQoz8SEmEA5Oj9FBu/IgnJGeo1F8RvGyg==
X-Gm-Gg: ASbGncsFeuTEUOCiXKYDFSmZrdsXvnPLaaJyoroTBM0jlIkO/CwjL9qkftctAbnvu1c
	GGgEZlcY3yFpdwG1N2rKPVepurwl7/tCr3lZ1tum9JagrkkHw1qTEbz1xPpODVgyTjewdHKSxg3
	Z2HaeiIQ/z1vxMqA3F3usF8dx+7AhuhOPaeIVp7PpyTaNZyiQuRnDaiGo2sPjjQDpeSPfcGPhh+
	ivKCk5fRtl9OcNIdA3bx71ZlJ7ge2eCRLH4TshcIb2/MIGwCQaNAVlAWAoy/lbpJqJQgyP4iznQ
	2lnv5ThsIF6sJ7ZNuw55NA4u1WIWpr6Eg3h6zCERu+QswoJdo9+LApU03iSEjZvBgNlkNvqBU9m
	lL0knh8Bjwb1cuTzDBNpGtzKNUr+T0dUMlJrI
X-Received: by 2002:a17:903:1547:b0:248:79d4:93be with SMTP id d9443c01a7336-27cc5624f64mr3800955ad.30.1758578353707;
        Mon, 22 Sep 2025 14:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGG6T7ySc8crxPcb7K8edEeVJNt96b5JVAn3AQ/h6MKUU8Y56um/AFywBRAM+AxXS7ufrcJg==
X-Received: by 2002:a17:903:1547:b0:248:79d4:93be with SMTP id d9443c01a7336-27cc5624f64mr3800745ad.30.1758578353279;
        Mon, 22 Sep 2025 14:59:13 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c08dsm141506235ad.51.2025.09.22.14.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 14:59:12 -0700 (PDT)
Message-ID: <b2885d4b-dd11-44ef-816a-9eed99f7a219@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 14:59:11 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: HAL SRNG: don't deinitialize and
 re-initialize again
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com, stable@vger.kernel.org,
        Muna Sinada <quic_msinada@quicinc.com>,
        Anilkumar Kolli <quic_akolli@quicinc.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Sven Eckelmann <sven@narfation.org>
References: <20250722053121.1145001-1-usama.anjum@collabora.com>
 <1598d25d-e254-410e-ac5c-66d5450fd686@oss.qualcomm.com>
 <ae7a08cb-af73-4a27-aad4-c852be5f77aa@collabora.com>
 <ab5af5b9-d5a7-434c-938d-3f9aac388542@oss.qualcomm.com>
 <86c465a3-f9a1-4a63-9e21-7529a5634301@collabora.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <86c465a3-f9a1-4a63-9e21-7529a5634301@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nwtnQ_kklvrpP24ZXVz9s6n4dUcCuIxi
X-Authority-Analysis: v=2.4 cv=fY2ty1QF c=1 sm=1 tr=0 ts=68d1c6b2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=QX4gbG5DAAAA:8 a=RL02kzwgQxJZJf316toA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDE2OCBTYWx0ZWRfX4GNoqLZK0thH
 f0ApXsbN/NrhVqvoXbmAKLvlW0iZ85GsUnlXH540LVDD8CK3eFPW3r+aHocn4ZKAkAeO+EfXLUO
 2oyY8AZDfB3JBkOH3MnEQEA15cVYZW8wO9KKMhiSRcmcXbdoYl8KmDxK2sE8mqV/5eOcYb5VYsF
 MqB/w/PdKeEEZakMtnDCNNcofhHxvp4V76Y4w+W8Hue1XIzfB3J8r2PDsyFnXknkXGz4skODYMA
 7uL/gfNUUV2Uf7XfS55DL0+MAYz6WMNi9X4DL7/akQN/G7SWT9CJYacNAaPvia2IScH4Qir8uh9
 WiNxEIyN8yM9gjQDPA9tB5fbR/VayHHIM0sqJVS5nEp2Cktf05dtEpXSN8S7cexxWGAllQ3yUF/
 k4FfqyrU
X-Proofpoint-ORIG-GUID: nwtnQ_kklvrpP24ZXVz9s6n4dUcCuIxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 impostorscore=0
 phishscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220168

On 7/22/2025 8:05 AM, Muhammad Usama Anjum wrote:
> On 7/22/25 7:07 PM, Jeff Johnson wrote:
>> On 7/22/2025 4:23 AM, Muhammad Usama Anjum wrote:
>>> Hi Kalle,
>>
>> Kalle is no longer a maintainer -- I am currently the only ath11k maintainer.
> Sorry, I missed it.
> 
>>
>>>
>>> On 7/22/25 2:47 PM, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 7/22/2025 1:31 PM, Muhammad Usama Anjum wrote:
>>>>> Don't deinitialize and reinitialize the HAL helpers. The dma memory is
>>>>> deallocated and there is high possibility that we'll not be able to get
>>>>> the same memory allocated from dma when there is high memory pressure.
>>>>>
>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>>>>
>>>>> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
>>>>> Cc: stable@vger.kernel.org
>>>>> Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>>>> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
>>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>>> ---
>>>>> Changes since v1:
>>>>> - Cc stable and fix tested on tag
>>>>> - Clear essential fields as they may have stale data
>>>>>
>>>>> Changes since v2:
>>>>> - Add comment and reviewed by tag
>>>>> ---
>>>>>  drivers/net/wireless/ath/ath11k/core.c |  6 +-----
>>>>>  drivers/net/wireless/ath/ath11k/hal.c  | 16 ++++++++++++++++
>>>>>  drivers/net/wireless/ath/ath11k/hal.h  |  1 +
>>>>>  3 files changed, 18 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
>>>>> index 4488e4cdc5e9e..34b27711ed00f 100644
>>>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>>>> @@ -2213,14 +2213,10 @@ static int ath11k_core_reconfigure_on_crash(struct ath11k_base *ab)
>>>>>  	mutex_unlock(&ab->core_lock);
>>>>>  
>>>>>  	ath11k_dp_free(ab);
>>>>> -	ath11k_hal_srng_deinit(ab);
>>>>> +	ath11k_hal_srng_clear(ab);
>>>>>  
>>>>>  	ab->free_vdev_map = (1LL << (ab->num_radios * TARGET_NUM_VDEVS(ab))) - 1;
>>>>>  
>>>>> -	ret = ath11k_hal_srng_init(ab);
>>>>> -	if (ret)
>>>>> -		return ret;
>>>>> -
>>>>>  	clear_bit(ATH11K_FLAG_CRASH_FLUSH, &ab->dev_flags);
>>>>>  
>>>>>  	ret = ath11k_core_qmi_firmware_ready(ab);
>>>>> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
>>>>> index b32de563d453a..e8ebf963f195c 100644
>>>>> --- a/drivers/net/wireless/ath/ath11k/hal.c
>>>>> +++ b/drivers/net/wireless/ath/ath11k/hal.c
>>>>> @@ -1359,6 +1359,22 @@ void ath11k_hal_srng_deinit(struct ath11k_base *ab)
>>>>>  }
>>>>>  EXPORT_SYMBOL(ath11k_hal_srng_deinit);
>>>>>  
>>>>> +void ath11k_hal_srng_clear(struct ath11k_base *ab)
>>>>> +{
>>>>> +	/* No need to memset rdp and wrp memory since each individual
>>>>> +	 * segment would get cleared ath11k_hal_srng_src_hw_init() and
>>>>
>>>> nit: s/cleared /cleared in/
>>> Please can you make this change while applying the patch?
>>
>> I can make this change when I pull the patch into the pending branch.
>> I'd like to see a public Reviewed-by before doing so.
>>
>> Also note that, except for anything critical, I'm not taking any patches into
>> ath-next until the upcoming v6.17 merge window closes and all changes made to
>> Linus' tree have been backmerged via net-next => wireless-next => ath-next.
> Thank you for mentioning. I didn't know the workflow.
> 
> No problem. There is no hurry.

I've modified this comment in my 'pending' branch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=9de41dd4c35fca6ebfe300b3799507dcafb9005e

I'll promote to ath-next before my pull request to wireless for the v6.18
merge window.

/jeff

