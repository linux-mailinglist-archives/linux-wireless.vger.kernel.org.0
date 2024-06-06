Return-Path: <linux-wireless+bounces-8602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD2F8FE397
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 11:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8EDB2F6A6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 09:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96109154420;
	Thu,  6 Jun 2024 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SvKCUrtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175571514E7
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717667595; cv=none; b=iwmNp36yopujz56PCxfZN0P7X7vo3cGB3K+bv2T/uqlmVawyt/+nelj2J2PeoKckgW3Q8d0a85MMqUqYspk+qcVeNrnjYIqKcuavmxNSIAx/ljyagbWdlYVs53CSHyV72E+gVOOs8P9727rRe/ohaXm8KZ/fLLurfx4xkZT/d9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717667595; c=relaxed/simple;
	bh=qMouWOxjy1ZN913zxTSsk/VtsIJbCu4FsqV2XA9Zlbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SuZTgvDuGWRxt+khijc6m4tcccer0MAn7rccwZPXbXfXBG7maYlTNc09HdHd5xLNOcPc99pvTpYJEEGKl2MGvjUFqhv5YCgaLb6KkixHpbTTxLP1A4ed6WQc7aP8MFXJGinUT9HufG+0xgco4sXw/J58RxTYsFrVRSUf+cxyNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SvKCUrtj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4568mvqV032234;
	Thu, 6 Jun 2024 09:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vkON2huWfqzkVhlpPnFi+GiqvsCmwPiSKh8/TA2iakc=; b=SvKCUrtjpgAAym9/
	V5mOxDFTyCpHN3TQ822zYUXIfD9UwZsG71ap/CnI+ZBzIFFZ25fUqJkYXcC7/w6+
	1EEHMXs0UHOcmE/0305N68bz3hc8DSYpSm5rK7S1sizdQ0U+LM8jPElubLarBQW2
	Z5NFGzhVbRCsNMcTIuLGGoiR8wE4ygGGxprzlamM1QBhtbMhZ1BKTCSPfRiuqCOG
	oJ7NqPseK78AoT0VQjhgOI8Kk1kx+yoH+y7sPA3hPHTQK2WPgDwp+5pFA2dgdr2R
	vCOb7SnhnSzxSrshoGIvn63DyviuT+fto41qKAQfCP7oA5he/2Lf8irraTBNaFM6
	SZoenA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjk89baf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 09:53:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4569r1k4003248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 09:53:01 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 02:52:58 -0700
Message-ID: <4369fb49-bab7-7ed7-f841-4be537a26f20@quicinc.com>
Date: Thu, 6 Jun 2024 15:22:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 3/7] wifi: cfg80211: extend interface combination check
 for multi-radio
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
 <8fc2f117346fcb4ed11bb20cdf9cb1f88bcf64b4.1717611760.git-series.nbd@nbd.name>
 <8add7134-9929-0288-0770-7778013cc37c@quicinc.com>
 <23a6d1eb-3ce9-400c-aa3d-a7d29c953079@nbd.name>
 <555d6af3-5b47-6d8a-9222-d3949c156cc4@quicinc.com>
 <21208cf1-eaa7-4077-873d-5863019111e7@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <21208cf1-eaa7-4077-873d-5863019111e7@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3DqVcrr3Y454lFWMbraB9MCQlO1j95be
X-Proofpoint-ORIG-GUID: 3DqVcrr3Y454lFWMbraB9MCQlO1j95be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406060072



On 6/6/2024 2:28 PM, Felix Fietkau wrote:
> On 06.06.24 10:56, Karthikeyan Periyasamy wrote:
>>
>>
>> On 6/6/2024 1:25 PM, Felix Fietkau wrote:
>>> On 06.06.24 09:20, Karthikeyan Periyasamy wrote:
>>>>
>>>>
>>>> On 6/6/2024 12:01 AM, Felix Fietkau wrote:
>>>>>       /*
>>>>>        * This is a bit strange, since the iteration used to rely 
>>>>> only on
>>>>> @@ -2384,8 +2383,10 @@ int cfg80211_iter_combinations(struct wiphy 
>>>>> *wiphy,
>>>>>        * cfg80211 already - the only thing not would appear to be 
>>>>> any new
>>>>>        * interfaces (while being brought up) and channel/radar data.
>>>>>        */
>>>>> -    cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
>>>>> -                   &beacon_int_gcd, &beacon_int_different);
>>>>> +    if (!radio)
>>>>> +            cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
>>>>> +                           &beacon_int_gcd,
>>>>> +                           &beacon_int_different);
>>>>
>>>> Why its avoid for radio specific iface combination ?
>>>
>>> Because it iterates over all wdevs within cfg80211. I didn't think 
>>> this was necessary, given that it already excludes MLO wdevs.
>>>
>>
>> Dont tie the radio specific iface advertisement with MLO.
>>
>> Usually the existing code consider "params->new_beacon_int" the MLO
>> scenario also.
> 
> For your hardware, do beacon intervals need to be matched/aligned per 
> radio or globally?
> 

Our hardware supports radio aligned beacon interval.

Currently, ath12k use use same beacon interval configuration all radio 
iface combination.

Even in radio specific iface combination, we should check the beacon 
interval for the non MLO VAPs.

so dont avoid the beacon interval check.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

