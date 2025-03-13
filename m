Return-Path: <linux-wireless+bounces-20326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2394BA5F5FB
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 14:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7CF18868C0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5BC41760;
	Thu, 13 Mar 2025 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O7dwPxh8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C258101E6;
	Thu, 13 Mar 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872730; cv=none; b=gFlj8NXFNQisA99VyHB2PyLH9KKOxN9rhs9kfmuDznrWiEMCkTSJjdAbLD57Hv4sB3/v//s8hHwBTUOBg+v3+Y24xC2cty1BU+nVzxJ/EpRFmEJsTiLwMm/fv3z/rv6jbnnjxcpqVWeb5H+mL0gOLUl42aaxrpw8eWnoS/r9EQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872730; c=relaxed/simple;
	bh=lv9WD/LyfzkEiwc6v8Z5TUZKz9TC2fvHQxlDBZKxZIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JgPl/a+zYmKiTMrKZLj5F7LbnEFMzgTQsQI9usfV984FPFKSjbklURUmLMY334xZjM6NuwQTFlPaiQU+RhOuiG5nifux/1jinmRPFZX3frcnv6GelItCb2lBTWiOx0z4KVHtMwZTaBouo/7e/XbesKHTrhGxhvEFWEfuuWSjwn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O7dwPxh8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D9SZ84028501;
	Thu, 13 Mar 2025 13:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C7BMESZ1albT009zS/aJeY7GPt60TCH4RI2gYZnDsn4=; b=O7dwPxh8+xa+D257
	SoABzQ62NyFOR2Ex/VVRqQEjKQF+iu1BhK4FjpbXRFVRJciGjIMUb4Xsf9oFUU5e
	d8Xl+4jT5+VwHsHXRStlK14doLUZDK7fXgifplk5CEllRiP2XeisWGfqyjBMg+/m
	3QDbtSyvnQ1pxCl9+Bt9UGC6GNV5q6Fy4CqYxaWvJH3svH4hPmJWhVAbxEdrpfuY
	DeoA/lc174hgHHqtWgHw2LUl7+9CjMrgd+dEM9mVbPhBMvxpjwX8ZRSyLkgrQQ0l
	DwiG129nMxQ33wbabPCaCzyuFHyNuCLG8HLvKB8YbhU790o38bKFxzMw9H2eK1Cl
	XEUEBg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2px03c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:32:03 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52DDW2Aa026700
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 13:32:02 GMT
Received: from [10.253.32.44] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Mar
 2025 06:32:00 -0700
Message-ID: <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
Date: Thu, 13 Mar 2025 21:31:56 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Johan Hovold <johan@kernel.org>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>
References: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
 <20250310010217.3845141-3-quic_miaoqing@quicinc.com>
 <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=P506hjAu c=1 sm=1 tr=0 ts=67d2de53 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=POYSu9ou3bP9OeXHj2YA:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zzDgsTmd8_OvdzKPbx0FA4Ze8PppLFIs
X-Proofpoint-ORIG-GUID: zzDgsTmd8_OvdzKPbx0FA4Ze8PppLFIs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130106



On 3/13/2025 12:43 AM, Johan Hovold wrote:
> On Wed, Mar 12, 2025 at 09:11:45AM +0800, Miaoqing Pan wrote:
>> On 3/11/2025 11:20 PM, Jeff Johnson wrote:
>>> On 3/11/2025 1:29 AM, Miaoqing Pan wrote:
>>>> On 3/10/2025 6:09 PM, Johan Hovold wrote:
>>>>> I'm still waiting for feedback from one user that can reproduce the
>>>>> ring-buffer corruption very easily, but another user mentioned seeing
>>>>> multiple zero-length descriptor warnings over the weekend when running
>>>>> with this patch:
>>>>>
>>>>> 	ath11k_pci 0006:01:00.0: rxed invalid length (nbytes 0, max 2048)
>>>>>
>>>>> Are there ever any valid reasons for seeing a zero-length descriptor
>>>>> (i.e. unrelated to the race at hand)? IIUC the warning would only be
>>>>> printed when processing such descriptors a second time (i.e. when
>>>>> is_desc_len0 is set).
>>>>
>>>> That's exactly the logic, only can see the warning in a second time. For
>>>> the first time, ath12k_ce_completed_recv_next() returns '-EIO'.
>>>
>>> That didn't answer Johan's first question:
>>> Are there ever any valid reasons for seeing a zero-length descriptor?
>>
>> The events currently observed are all firmware logs. The discarded
>> packets will not affect normal operation. I will adjust the logging to
>> debug level.
> 
> That still does not answer the question whether there are ever any valid
> reasons for seeing zero-length descriptors. I assume there are none?
> 
>>> We have an issue that there is a race condition where hardware updates the
>>> pointer before it has filled all the data. The current solution is just to
>>> read the data a second time. But if that second read also occurs before
>>> hardware has updated the data, then the issue isn't fixed.
>>   
>> Thanks for the addition.
>>
>>> So should there be some forced delay before we read a second time?
>>> Or should we attempt to read more times?
>>
>> The initial fix was to keep waiting for the data to be ready. The
>> observed phenomenon is that when the second read fails, subsequent reads
>> will continue to fail until the firmware's CE2 ring is full and triggers
>> an assert after timeout. However, this situation is relatively rare, and
>> in most cases, the second read will succeed. Therefore, adding a delay
>> or multiple read attempts is not useful.
> 
> The proposed fix is broken since ath11k_hal_ce_dst_status_get_length()
> not just reads the length but also sets it to zero so that the updated
> length may indeed never be seen.
> 
> I've taken a closer look at the driver and it seems like we're missing a
> read barrier to make sure that the updated descriptor is not read until
> after the head pointer.
> 
> Miaoqing, could you try the below patch with your reproducer and see if
> it is enough to fix the corruption?
> 
> If so I can resend with the warning removed and include a corresponding
> fix for ath12k (it looks like there are further places where barriers
> are missing too).
> 
> Johan
> 
> 
>  From 656dbd0894741445aeb16ee8357e6fef51b6084c Mon Sep 17 00:00:00 2001
> From: Johan Hovold <johan+linaro@kernel.org>
> Date: Wed, 12 Mar 2025 16:49:20 +0100
> Subject: [PATCH] wifi: ath11k: fix ring-buffer corruption
> 
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
> 
> 	ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
> 	ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
> 
> Miaoqing Pan tracked it down to the host seeing the updated destination
> ring head pointer before the updated descriptor, and the error handling
> for that in turn leaves the ring buffer in an inconsistent state.
> 
> Add the missing the read barrier to make sure that the descriptor is
> read after the head pointer to address the root cause of the corruption.
> 
> The error handling can be fixed separately in case there can ever be
> actual zero-length descriptors.
> 
> FIXME: remove WARN_ON_ONCE() added for verification purposes
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quicinc.com
> Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Cc: stable@vger.kernel.org	# 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/net/wireless/ath/ath11k/ce.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
> index e66e86bdec20..423b970e288c 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -393,8 +393,12 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
>   		goto err;
>   	}
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
>   	if (*nbytes == 0) {
> +		WARN_ON_ONCE(1);	// FIXME: remove
>   		ret = -EIO;
>   		goto err;
>   	}

This issue can still be reproduced.

[ 3283.687469] WARNING: CPU: 0 PID: 0 at 
/drivers/net/wireless/ath/ath11k/ce.c:405 
ath11k_ce_per_engine_service+0x228/0x3e4 [ath11k]

[ 3283.688685] Call trace:
[ 3283.688692]  ath11k_ce_per_engine_service+0x228/0x3e4 [ath11k]
[ 3283.688807]  ath11k_pcic_ce_tasklet+0x34/0x54 [ath11k]
[ 3283.688920]  tasklet_action_common.isra.0+0xec/0x338
[ 3283.688958]  tasklet_action+0x28/0x34
[ 3283.688972]  handle_softirqs+0x120/0x36c


