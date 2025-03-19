Return-Path: <linux-wireless+bounces-20543-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F5A688C7
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 10:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3B2161BFB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 09:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA7253B45;
	Wed, 19 Mar 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZV1tF50Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC9F25179D;
	Wed, 19 Mar 2025 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742377640; cv=none; b=CULcr16SD8gLocxxxKMTUTVhxvQ2wMcbdbTxEfUDjHQVJQMu8gpxOdDT2wPfaS4jC00dzNI+RIFDF0sEANcyU7K8lLTlMvbOjkutm/a5T0oT28UcWVS7LLZ26l/0ZnOjHZPjD1e5Voust4z8UzFViYj3ycA7w5AIw0oDCPbr7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742377640; c=relaxed/simple;
	bh=O6w5UQiPQDAncHL0JGYpqSqNNeXRkspuAfX3mQuz4qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NejFucBgGlfvq2CyvUFGDD+ASjnPRI888EIhcaScl9A9DUkYJxh0ou4pPMZR9ZnCHfvuwOrm9tcqqe+hSVDfJ+5MygXDw4HyPJbvosf+FAcKwVuGlzA8SBsrfcAeskAsl/W7jD6j5/a9xoN5qxYQcRr09AZxqvWTv4Deq09ihBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZV1tF50Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lhgO013238;
	Wed, 19 Mar 2025 09:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rHfbdl1JsaGugNsEPHcVkxixLUiPvsM33VrChlLfuhk=; b=ZV1tF50ZEi/FJrs1
	iFfEv4cEDVywCl0BL7cIbN9cDq1KzS5gQ20092PoJMXFEJHnRdIQJa5IDB4QMySt
	Jo17OBoyvxFVMTtRaHlSfUTaB6tx+QZZbGptfARXg2n+dW3J5qjxvTSG9/2XbSQm
	sjwBUXFiBVrRR18sQiQlufRN98BTywDrLI9dgI9+WhVcWKBm2sabLs7zgCdo2zOo
	PE7tWsUADDoVtJ0d3OfnZWsx05flJ1xj3wcMtmI5UhiybOzCZI3OXnrLcCUd6xPo
	zNoWXBsAOTmSFLpcgYQAIccgaxOnzepge695Sf7/RFXZ5MS9cDXWQGhauBrYxLlm
	Iph7dQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exwtmy2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:47:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52J9l4ZO004824
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 09:47:04 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 02:47:01 -0700
Message-ID: <38cd738c-1a2a-4382-80f8-d57feb7c829d@quicinc.com>
Date: Wed, 19 Mar 2025 17:46:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
To: <neil.armstrong@linaro.org>,
        Vasanthakumar Thiagarajan
	<quic_vthiagar@quicinc.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <a5ebfdfb-107f-407f-b557-522b074c904f@linaro.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <a5ebfdfb-107f-407f-b557-522b074c904f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9piXMHhr3cMNyFLuoDeLddUzUi6lZcfN
X-Proofpoint-ORIG-GUID: 9piXMHhr3cMNyFLuoDeLddUzUi6lZcfN
X-Authority-Analysis: v=2.4 cv=UoJjN/wB c=1 sm=1 tr=0 ts=67da9298 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=X1ODuQJvNpbElp41e2UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 adultscore=0 clxscore=1011 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190066



On 3/19/2025 5:12 PM, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 3/19/2025 1:34 PM, Neil Armstrong wrote:
>>> On 18/03/2025 17:35, Jeff Johnson wrote:
>>>> On 3/3/2025 7:00 AM, Neil Armstrong wrote:
>>>>> In commit 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
>>>>> single_chip_mlo_supp")
>>>>> the line:
>>>>>     ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>>>>> was incorrectly updated to:
>>>>>     ab->single_chip_mlo_supp = false;
>>>>> leading to always disabling INTRA_DEVICE_MLO even if the device supports it.
>>>>>
>>>>> The firmware "WLAN.HMT.1.1.c5-00156-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1"
>>>>> crashes on driver initialization with:
>>>>>   ath12k_pci 0000:01:00.0: chip_id 0x2 chip_family 0x4 board_id 0x3d soc_id 0x40170200
>>>>>   ath12k_pci 0000:01:00.0: fw_version 0x110f009c fw_build_timestamp 2024-05-30 11:35
>>>>> fw_build_id QC_IMAGE_VERSION_STRING=WLAN.HMT.1.1.c5-00156-
>>>>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

this FW version is not upstream yet, why are you testing with it?

Generally we only support upstrmea driver + upstream FW.


>>>>>   ath12k_pci 0000:01:00.0: ignore reset dev flags 0x200
>>>>>   ath12k_pci 0000:01:00.0: failed to receive wmi unified ready event: -110
>>>>>   ath12k_pci 0000:01:00.0: failed to start core: -110
>>>>>   failed to send QMI message
>>>>>   ath12k_pci 0000:01:00.0: qmi failed to send mode request, mode: 4, err = -5
>>>>>   ath12k_pci 0000:01:00.0: qmi failed to send wlan mode off
>>>>>
>>>>> With ab->single_chip_mlo_supp set to True, firmware loads nominally.
>>>>>
>>>>> Fixes: 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp")
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>> Bisect log for reference:
>>>>> The bisect leaded to:
>>>>> git bisect start 'v6.14-rc4' 'v6.12'
>>>>> git bisect good 5757b31666277e2b177b406e48878dc48d587a46
>>>>> git bisect bad d78794d4f4dbeac0a39e15d2fbc8e917741b5b7c
>>>>> git bisect bad cf33d96f50903214226b379b3f10d1f262dae018
>>>>> git bisect good 12e070eb6964b341b41677fd260af5a305316a1f
>>>>> git bisect bad 6917d207b469ee81e6dc7f8ccca29c234a16916d
>>>>> git bisect good 4fefbc66dfb356145633e571475be2459d73ce16
>>>>> git bisect bad a6ac667467b642c94928c24ac2eb40d20110983c
>>>>> git bisect bad b05d30c2b6df7e2172b18bf1baee9b202f9c6b53
>>>>> git bisect good 56dcbf0b520796e26b2bbe5686bdd305ad924954
>>>>> git bisect bad d302ac65ac938516487f57ae20f11e9cf6327606
>>>>> git bisect good 8c2143702d0719a0357600bca0236900781ffc78
>>>>> git bisect good a5686ae820fa7ab03226a3b0ff529720b7bac599
>>>>> git bisect bad 6f245ea0ec6c29b90c8fa4fdf6e178c646125d7e
>>>>> git bisect bad 46d16f7e1d1413ad7ff99c1334d8874623717745
>>>>> ---
>>>>>   drivers/net/wireless/ath/ath12k/core.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/
>>>>> ath12k/core.c
>>>>> index
>>>>> 0606116d6b9c491b6ede401b2e1aedfb619339a8..33aba5fceec946fad5a47a11a4d86b7be96e682e
>>>>> 100644
>>>>> --- a/drivers/net/wireless/ath/ath12k/core.c
>>>>> +++ b/drivers/net/wireless/ath/ath12k/core.c
>>>>> @@ -1927,7 +1927,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev,
>>>>> size_t priv_size,
>>>>>       ab->dev = dev;
>>>>>       ab->hif.bus = bus;
>>>>>       ab->qmi.num_radios = U8_MAX;
>>>>> -    ab->single_chip_mlo_supp = false;
>>>>> +    ab->single_chip_mlo_supp = true;
>>>>>       /* Device index used to identify the devices in a group.
>>>>>        *
>>>>>
>>>>> ---
>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>>>
>>>>> Best regards,
>>>>
>>>> NAK since this will break QCN
>>>> There is a series under internal review to address MLO issues for WCN chipsets
>>>
>>> ???
>>>
>>> The original commit is wrong, this fixes the conversion, nothing else.
>>
>> Nope. Driver changes to enable MLO with WCN chipset are not there yet.
>> Setting the mlo capability flag without having required driver changes
>> for WCN chipset will likely result in firmware crash. So the recommendation
>> is to enable MLO (in WCN) only when all the necessary driver changes
>> (in development, public posting in near future) are in place.
> 
> Right, I understand clearly, _but_ before 46d16f7e1d14 the firmware
> was _not_ crashing, and 46d16f7e1d14 causes a regression because
> single_chip_mlo_supp was set to false instead of true.
> 
> So if you read the commit message, it clearly explains the regression,
> and the reason of the patch.
> 
> This has nothing to do with enabling MLO, it fixes a regression
> on mainline for current users.
> 
> #regzbot introduced: 46d16f7e1d14
> 
> Neil
> 
>>
>> Vasanth
> 
> 


