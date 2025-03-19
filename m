Return-Path: <linux-wireless+bounces-20559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264CA68BDD
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 12:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F5D3A47A9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 11:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871A2505C7;
	Wed, 19 Mar 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YMRe9L+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17161253346;
	Wed, 19 Mar 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742384099; cv=none; b=lKdZXKdHUOzPTFfJMphVAlnegrnrd9LcbTyNI7q4q18qDLeENRC567eTIL4RQjuP0jlWa34HE+k82UWMp/XnoCzddJijNVyhqXlt5dLluKJpLRUZgr5pX98lrNwJ+bzkkKJFWxG1ERj35nPio+vaSlO1PnpQmcxiUAnh63h+wOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742384099; c=relaxed/simple;
	bh=NQIG+KzD4JNsFjAw/KBNjDnT/1GELV0VA2GH51aFwlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZynRUgyQcOPOi86atjbDsTH5Q5GJ1dZyhQ+vD7ItaJId0/REFV8WfE1bsnlqat4awFlvuL1SsMo9JYaOg40oM+GfFK9zGXNa3QdDi3Zmoy/1gCliTKiGVjIhwmMzSoWIEkgxMrRXyc74IdcP7F9+y42Q4TBgoQ5FjnCSGsFcsOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YMRe9L+1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4lmVR001856;
	Wed, 19 Mar 2025 11:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lt0wTiNTI4glUGHJkezI5v/s0a1YIU7vra3n10KWY8U=; b=YMRe9L+1gtyZdeDX
	k+IOFFMNDr0Kx52S+OmS86h5HBcgoLe9wAidc1qpx4uJqTu1Ve0xAAPCjgT8w+gu
	KeTTEltPBQt6UlNron2sdgmH7RENj7pJD4NGyGomDbBweu1vNivLwr3jzRnTzK+k
	+TzTIfyDueo7RQEnLhw9aSDedICJBCpwjMNTH4Q4QqLCe/6Vvd1atfatJL1e3YqE
	i2AbYp0WbLEukBWhzg4AeHJweS26qV4pgziFxgbLCedW0SZPv4IPwxn4OK3wkKS8
	3iPCc3RLm/bKFNoHItyYok2yVPG3q56cvDvf1FcSFMrpGjUqLxTcgbH9dRm2URyR
	Sp39NA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45etmbwr4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:32:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52JBWjVn030309
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 11:32:45 GMT
Received: from [10.152.204.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 19 Mar
 2025 04:32:42 -0700
Message-ID: <db232678-fa85-d75f-de72-d2b5e1ec611f@quicinc.com>
Date: Wed, 19 Mar 2025 17:02:39 +0530
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
To: Krzysztof Kozlowski <krzk@kernel.org>, <neil.armstrong@linaro.org>,
        "Jeff
 Johnson" <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Aditya
 Kumar Singh" <quic_adisi@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dX11e6KSh6o7vps5J56_VN1R0zm_LpfV
X-Proofpoint-GUID: dX11e6KSh6o7vps5J56_VN1R0zm_LpfV
X-Authority-Analysis: v=2.4 cv=aMLwqa9m c=1 sm=1 tr=0 ts=67daab5e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=6gNJTce8e7Hy4Yi6jooA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 spamscore=0 clxscore=1011 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=837 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190080



On 3/19/2025 3:57 PM, Krzysztof Kozlowski wrote:
> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
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
> Really, these are your answers? There is regression and first reply is
> upstream should wait for whatever you do internally. Second answer is
> the same - public posting in near future?
> 

May be I was not clear in my response. I was not telling MLO bug fixes were
in the development. Actually the MLO feature itself is not enabled
yet with WCN chip sets. Any code changes enabling it without full feature
support would result in firmware crashes with the existing firmware binaries
available in upstream.

Vasanth

