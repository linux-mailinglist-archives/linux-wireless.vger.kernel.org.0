Return-Path: <linux-wireless+bounces-20571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B2FA69651
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 18:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D49147AA335
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFBE1E131A;
	Wed, 19 Mar 2025 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UN2Apf22"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49DA1DE3A3;
	Wed, 19 Mar 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405052; cv=none; b=u4+OBG0KfweajR3w4w88yitcvsOBMSFtG90VDIt597J/NfvVc31UzvjM/feBRjZZfyDZX2wSE+CnA9dRWIWNXYO5bBFefDoJOsisHxCdv8pWQAVCMSnwG7lHtkvgoEgjIsZ0do/LwdSdqVD+JlPuC36ALWfS7M4AfGfqzrIPomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405052; c=relaxed/simple;
	bh=ELadN9suy3cNwA0vlVcbLNaRM/0CFBqCRG2jr6J/Tew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EoYwQjO9AsAlst43LKuE1EPYpSg4+BOQOAf2kE3a4Pyg42mY1F6OuoAzuLDiIk9CTqxlVuWMwbu22O3TgBpEdqpLzXFg1iKXfNj2ZBayU+NvLyWxAexQGH8CfrtRMShi1Mid0o8G5s2a7qplIVdZLjWGcYDwqGApBwtdbpIqGAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UN2Apf22; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JDOMK7020536;
	Wed, 19 Mar 2025 17:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IXWlm4JCY0DtIXW2D7Gz2sscoUFyjUlCOxapsFxmIPU=; b=UN2Apf22vL+mtkDt
	yH9Jzj66XPBgn4esPyHI4dFcZFWukGRfWysDdYiCB0cOurjAIY9Omb+ZpAmyLlYG
	nq+kbR0g7q/aDgK6XPX83KJ0cpk6QCzQU7mdiIh0dmMryeo27D03npcQRGTsM49I
	blYVU7aWy3yFqk0nkcF83m4zAS3dG0Rw3UE2XZCCb8DS+Kr37+0MjX9h7GyDLT9b
	k9PtRyDN5kkUViPld8WsNs13gF6TaUhLtMEbXigmGVAcsQ41ZJxcQa/iYuQT7x6F
	a7XKZLVQaW/n3UKL3xddqw6J1CToTj8dLIb4tB1l6hcofdmCR1i2ROnUldPwflAX
	eKcqAQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45fdmwug7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:23:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52JHNsMc022551
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 17:23:54 GMT
Received: from [10.216.38.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 10:23:48 -0700
Message-ID: <83c71791-dc34-54a5-7d67-9765aa2886e5@quicinc.com>
Date: Wed, 19 Mar 2025 22:53:43 +0530
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
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        "Vasanthakumar
 Thiagarajan" <vasanthakumar.thiagarajan@oss.qualcomm.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <neil.armstrong@linaro.org>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
 <db232678-fa85-d75f-de72-d2b5e1ec611f@quicinc.com>
 <2a5hvicenftfiktviiofvknanyz756cbryu35gkfczdvbcdd5j@fktlzfieotgl>
 <c6e3b0c1-18fe-a9fa-0e72-d955809144e3@oss.qualcomm.com>
 <hmfvyajygmjoeaaashmddu4rg6ttzn7es4sjls5qvnemykkx2l@zuzixrzkmkgx>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <hmfvyajygmjoeaaashmddu4rg6ttzn7es4sjls5qvnemykkx2l@zuzixrzkmkgx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p9o9autkuEDX5tRUsSZyR6g-iawFRZJ-
X-Authority-Analysis: v=2.4 cv=ReKQC0tv c=1 sm=1 tr=0 ts=67dafdab cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=fppTZj3WDclMhW0upbEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p9o9autkuEDX5tRUsSZyR6g-iawFRZJ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_06,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190117



On 3/19/2025 7:03 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 06:24:57PM +0530, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 3/19/2025 5:21 PM, Dmitry Baryshkov wrote:
>>> On Wed, Mar 19, 2025 at 05:02:39PM +0530, Vasanthakumar Thiagarajan wrote:
>>>>
>>>>
>>>> On 3/19/2025 3:57 PM, Krzysztof Kozlowski wrote:
>>>>> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>>>>>>>> ---
>>>>>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>>>>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>
>>>>>>>> NAK since this will break QCN
>>>>>>>> There is a series under internal review to address MLO issues for WCN chipsets
>>>>>>>
>>>>>>> ???
>>>>>>>
>>>>>>> The original commit is wrong, this fixes the conversion, nothing else.
>>>>>>
>>>>>> Nope. Driver changes to enable MLO with WCN chipset are not there yet.
>>>>>> Setting the mlo capability flag without having required driver changes
>>>>>> for WCN chipset will likely result in firmware crash. So the recommendation
>>>>>> is to enable MLO (in WCN) only when all the necessary driver changes
>>>>>> (in development, public posting in near future) are in place.
>>>>> Really, these are your answers? There is regression and first reply is
>>>>> upstream should wait for whatever you do internally. Second answer is
>>>>> the same - public posting in near future?
>>>>>
>>>>
>>>> May be I was not clear in my response. I was not telling MLO bug fixes were
>>>> in the development. Actually the MLO feature itself is not enabled
>>>> yet with WCN chip sets. Any code changes enabling it without full feature
>>>> support would result in firmware crashes with the existing firmware binaries
>>>> available in upstream.
>>>
>>> Is there an undocumented change of the behaviour in the commit
>>> 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
>>> single_chip_mlo_supp")?
>>>
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>
>> -       if (resp.single_chip_mlo_support_valid) {
>> -               if (resp.single_chip_mlo_support)
>> -                       ab->mlo_capable_flags |= ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> -               else
>> -                       ab->mlo_capable_flags &= ~ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> -       }
>>
>> The above logic seems to keep the initialized intra MLO support even when
>> single_chip_mlo_support_valid is not set. The above code removal is correct as
>> MLO support can not be enabled in host when firmware does not advertise it.
> 
> Ack
> 
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>>
> 
> You skipped an important chunk:
> 
> -	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> +       ab->single_chip_mlo_supp = false;
> 
> Is this an _undocumented_ change? I think it is. If the developer has
> described that the commit disables MLO, there would be no such
> questions.
> 

Right. Since MLO was WCN was not supported, this default configuration was
changed to avoid potential issues due to partial MLO configurations with
official upstream firmware binaries.

>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>
>> +       if (resp.single_chip_mlo_support_valid &&
>> +           resp.single_chip_mlo_support)
>> +               ab->single_chip_mlo_supp = true;
>>
>> The above code does it in right way. Overriding firmware MLO capability as done
>> in the submitted patch under review is obviously wrong. The firmware used to report
>> the issue seems to have an odd behavior: 1. it does not seem to advertise MLO
>> capability in single_chip_mlo_support bit and 2. expects configurations to enable
>> MLO from host. None of the WCN firmware available in upstream either advertises
>> MLO capability or expects configurations to enable MLO from host.
> 
> Additionally, from the commit message:
> 
>      For the WCN7850 family of chipsets, since the event is not supported,
>      assumption is made that single chip MLO is supported.
> 
> However the code doesn't contain that change. Instead single chip MLO is
> unconditionally disabled.
>

This text in commit message seems to be a miss. This should have been
removed as the merged patch version completely disables MLO for WCN
chip.

Vasanth

