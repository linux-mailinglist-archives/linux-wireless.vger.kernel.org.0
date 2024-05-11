Return-Path: <linux-wireless+bounces-7500-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C58C8C2F3B
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 05:12:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37374B22D6D
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 03:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954712376A;
	Sat, 11 May 2024 03:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YYTDL263"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775F12B95;
	Sat, 11 May 2024 03:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397160; cv=none; b=g/TxWJCKkWz111jAuXzH5esQ2r4a6GwPFmRJCxsR+aYleu5oRQupS/M4a8fEBblqc2UEzGucZzUvOSkzuDdBq/InRO34o7cx2TaB8bRVgMdq9vOD7HT1AA51F1RjKGu1W4DPZedzIw6IKecL2mXRt/9v67UxHEVosB1++pgmqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397160; c=relaxed/simple;
	bh=+TT7KyEefz4oXXELIawQi7Y1J1t7XFWHVVyzGOsACCE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=svxIqX8GFx04i5WlVQeWztuGCfaATH26ZpxB2K+N3VNJijQGwIj+FU4qC3pzDfgNCcYTVwzrwXNi3X3PJ21t+PLhEV/1PH20KeafbrNQZLJc5NMVlLE03k9F1INtEP0qqmG7+XAbTz051ncoJaRHVczlRlpLcgetRErEWJJqGNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YYTDL263; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44B2qv49029832;
	Sat, 11 May 2024 03:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:cc:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SQbJvDTDrl02dIQQnb7RNH6pl73AWqV5I1YMx8caNSA=; b=YY
	TDL263pXNpDRLoK4C/+t2mnuJ+xVi4gOCzDh882QjlaXXT9vK8zZsrOxp7N+nCkf
	bbYmVcWPkM4k99GJzYmnm3awYEU8um++WbmU0p4mHoLhErEb2uHUaCOp24iWv4ob
	O+edczKfZPSubs+Crm7PB0Xbn3w7iNHo61DIepkYWUGB/5v6C921wJQho/Q2gijN
	z+4MUSa7cwVYL4XyeGlmwdzvaYnh+j1Z/80q4K2KTWK53eDHQooBAES+9pP6T74H
	vHAGa/OBKUaT5Kg+2Iy1mDVufIpNs3IQ9GutyR3AnIYVAT9/ustomAiOgfCvyjQ8
	avVo/wvewfagc1PTq2hA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y208vr0q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 03:12:32 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B3CUE9001504
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 03:12:30 GMT
Received: from [10.253.8.22] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 10 May
 2024 20:12:28 -0700
Message-ID: <4e21e556-527f-4d1e-aa29-cacec14155af@quicinc.com>
Date: Sat, 11 May 2024 11:12:26 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <quic_cjhuang@quicinc.com>, Luca Weiss <luca.weiss@fairphone.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Kalle Valo <kvalo@kernel.org>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
 <871q69lqh5.fsf@kernel.org>
Content-Language: en-US
From: Carl Huang <quic_cjhuang@quicinc.com>
In-Reply-To: <871q69lqh5.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0RwQJzx9_jyYlKQP-grVuROwfwo3bdnS
X-Proofpoint-GUID: 0RwQJzx9_jyYlKQP-grVuROwfwo3bdnS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_18,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110022



On 2024/5/10 21:57, Kalle Valo wrote:
> Carl Huang <quic_cjhuang@quicinc.com> writes:
> 
>> On 2024/5/10 18:18, Kalle Valo wrote:
>>> "Luca Weiss" <luca.weiss@fairphone.com> writes:
>>>
>>>> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>>>>> Add hardware parameter support_dual_stations to indicate
>>>>> whether 2 station interfaces are supported. For chips which
>>>>> support this feature, limit total number of AP interface and
>>>>> mesh point to 1. The max interfaces are 3 for such chips.
>>>>>
>>>>> The chips affected are:
>>>>>    QCA6390 hw2.0
>>>>>    WCN6855 hw2.0
>>>>>    WCN6855 hw2.1
>>>>> Other chips are not affected.
>>>>>
>>>>> For affected chips, remove radar_detect_widths because now
>>>>> num_different_channels is set to 2. radar_detect_widths can
>>>>> be set only when num_different_channels is 1. See mac80211
>>>>> function wiphy_verify_combinations for details.
>>>>>
>>>>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3
>>>>
>>>> Hi Carl,
>>>>
>>>> Unfortunately this commit breaks wifi on a QCM6490 smartphone
>>>> (qcm6490-fairphone-fp5) and makes the board crash.
>>>>
>>>> Reverting this commit (plus for conflict resolution 5dc9d1a55e95 ("wifi:
>>>> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
>>>> provide address list if chip supports 2 stations")) makes wifi work
>>>> again.
>>> Thanks for the report. So the broken commit is:
>>> f019f4dff2e4 wifi: ath11k: support 2 station interfaces
>>> This went into v6.9-rc1 so I'm guessing that WCN6750 support will be
>>> fully broken in v6.9? Not good. And most likely Linus will release v6.9
>>> on Sunday so it's too late to get a fix included in the final release.
>>> Carl, can you fix this ASAP? Or should we just revert the broken
>>> commits?
>>> Adding this to our regression tracking:
>>> #regzbot introduced: f019f4dff2e4 ^
>>> #regzbot title: ath11k: WCN6750 firmware crashes during initialisation
>>
>> Kalle, looks we're not able to fix it before Sunday as I don't have
>> WCN6750 setup to verify the fix.
> 
> We are so late in the cycle that we would have to send the fix directly
> to Linus and ask him to apply the fix before he tags the release. I
> prefer that we are on the safe side here and send the fix to v6.10-rc1
> via the usual route (the wireless tree). We get more testing time that
> way.
> 
No problem, Kalle.

I think more tags are needed like Tested-on WCN6750 and Tested-by Luca.

I'll send out the formal patch next week.

>> The fix could be to define a dedicated function
>> ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the patch out
>> so others like Luca can have a try.
> 
> Thanks for the quick patches!
> 

