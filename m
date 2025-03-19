Return-Path: <linux-wireless+bounces-20539-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA4A68772
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 10:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 970617A434B
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 09:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98372512D9;
	Wed, 19 Mar 2025 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T//yqjem"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9486430100;
	Wed, 19 Mar 2025 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375202; cv=none; b=bQ8kfaaHEh1G9vMjbblEh4nbL0yGmxNiqhDijddTRl91HE/yG9/kX/v+Q1wzLkbISA3VahW6O9LLGFB5aklE9hZR2sX3yckmkeg0D8pDUAmHq0zFSOEsr5JxZvGjpiOj15USbukUqBwPLHksfPfIOjkBM6ARJUO4+oOHOTmhnLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375202; c=relaxed/simple;
	bh=xmiZQlmsf/r/3b1a3nfLYxnr6lpkMpoPdZerrCWSamA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=edRNwRAakgCU+mmair03Aeqf4pchxVFZRCJlR7bqwZbefDDPecQgh1Pl33uHNqIOFle6r2yRmZCtPYKOgxBGqvuDUz+YiK+OTbIZ3hwjjvwKkctIlYFDoYkBhjLbruYnB9BjLj3qt2B4TgB4BSQikQrp/p628AUsBD1/gLS/YaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T//yqjem; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4mDKP013654;
	Wed, 19 Mar 2025 09:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zOSe9GaBXahZnB+SUeIQwp6YUMWRjQANUYGvWAVRwNQ=; b=T//yqjemdpQiK4Yo
	v+palrr4rfL3+ObkTHwf0wFGn+gNFSuTKMe6Pr4H6/kY4YOO5Cy6ATHY8bvl9RaF
	AycbkJX2m6RXBCCkpA+0eMCsUQGkXwPTkE6LgAwoQPI68oqXccdYtuweu1tFQnA4
	iA+JDeaOpa38/+GeEBKp/pWdiO04kxAm6bPV3RictSmj3jjtU9TkjwQV77iRs0K/
	xgvajExLiWIEwrYnBpGuokhyGJDbcx2WUSH7nToBTl8+dVKuX1v8/2lXbu+0RDGI
	nbwTi4WLrCyWa0tyIrWUNwkhs/K10DdL66agKwjvrpbRo+0rr6tnCssC2c2+IVfj
	GtlRXA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtmtv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:06:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52J96Tot025228
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:06:29 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 02:06:26 -0700
Message-ID: <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
Date: Wed, 19 Mar 2025 14:36:23 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Content-Language: en-US
To: <neil.armstrong@linaro.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Zz6FlvoCgsDsdske-79VFVe2GFnI3KIL
X-Proofpoint-ORIG-GUID: Zz6FlvoCgsDsdske-79VFVe2GFnI3KIL
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67da8916 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=punbUWOz3g3VwUVV8CwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190062



On 3/19/2025 1:34 PM, Neil Armstrong wrote:
> On 18/03/2025 17:35, Jeff Johnson wrote:
>> On 3/3/2025 7:00 AM, Neil Armstrong wrote:
>>> In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
>>> the line:
>>>     ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>>> was incorrectly updated to:
>>>     ab->single_chip_mlo_supp = false;
>>> leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
>>>
>>> The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
>>> crashes on driver initialization with:
>>>   ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
>>>   ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35 
>>> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1
>>>   ath12k_pci 0000:01:00.0: ignore reset dev flags 0x200
>>>   ath12k_pci 0000:01:00.0: failed to receive wmi unified ready event: -110
>>>   ath12k_pci 0000:01:00.0: failed to start core: -110
>>>   failed to send QMI message
>>>   ath12k_pci 0000:01:00.0: qmi failed to send mode request, mode: 4, err = -5
>>>   ath12k_pci 0000:01:00.0: qmi failed to send wlan mode off
>>>
>>> With ab->single_chip_mlo_supp set to True, firmware loads nominally.
>>>
>>> Fixes: 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>> ---
>>> Bisect log for reference:
>>> The bisect leaded to:
>>> git bisect start 'v6.14-rc4' 'v6.12'
>>> git bisect good 5757b31666277e2b177b406e48878dc48d587a46
>>> git bisect bad d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c
>>> git bisect bad cf33d96f50903214226b379b3f10d1f262dae018
>>> git bisect good 12e070eb6964b341b41677fd260af5a305316a1f
>>> git bisect bad 6917d207b469ee81e6dc7f8ccca29c234a16916d
>>> git bisect good 4fefbc66dfb356145633e571475be2459d73ce16
>>> git bisect bad a6ac667467b642c94928c24ac2eb40d20110983c
>>> git bisect bad b05d30c2b6df7e2172b18bf1baee9b202f9c6b53
>>> git bisect good 56dcbf0b520796e26b2bbe5686bdd305ad924954
>>> git bisect bad d302ac65ac938516487f57ae20f11e9cf6327606
>>> git bisect good 8c2143702d0719a0357600bca0236900781ffc78
>>> git bisect good a5686ae820fa7ab03226a3b0ff529720b7bac599
>>> git bisect bad 6f245ea0ec6c29b90c8fa4fdf6e178c646125d7e
>>> git bisect bad 46d16f7e1d1413ad7ff99c1334d8874623717745
>>> ---
>>>   drivers/net/wireless/ath/ath12k/core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/core.c 
>>> b/drivers/net/wireless/ath/ath12k/core.c
>>> index 
>>> 0606116d6b9c491b6ede401b2e1aedfb619339a8..33aba5fceec946fad5a47a11a4d86b7be96e682e 100644
>>> --- a/drivers/net/wireless/ath/ath12k/core.c
>>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>>> @@ -1927,7 +1927,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t 
>>> priv_size,
>>>       ab->dev = dev;
>>>       ab->hif.bus = bus;
>>>       ab->qmi.num_radios = U8_MAX;
>>> -    ab->single_chip_mlo_supp = false;
>>> +    ab->single_chip_mlo_supp = true;
>>>       /* Device index used to identify the devices in a group.
>>>        *
>>>
>>> ---
>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>
>>> Best regards,
>>
>> NAK since this will break QCN
>> There is a series under internal review to address MLO issues for WCN chipsets
> 
> ???
> 
> The original commit is wrong, this fixes the conversion, nothing else.

Nope. Driver changes to enable MLO with WCN chipset are not there yet.
Setting the mlo capability flag without having required driver changes
for WCN chipset will likely result in firmware crash. So the recommendation
is to enable MLO (in WCN) only when all the necessary driver changes
(in development, public posting in near future) are in place.

Vasanth

