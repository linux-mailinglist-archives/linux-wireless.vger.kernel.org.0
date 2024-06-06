Return-Path: <linux-wireless+bounces-8598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E858FE1F6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 11:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3231F27B61
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 09:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B919D8B5;
	Thu,  6 Jun 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VY6P0SiS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA662EAE6
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664213; cv=none; b=ANJKoIExDUy0B4UeDwnQqorfYPD2yMTVaTCDvZAqeoDJvrCGSo0krq5+SFTeQ/jIeKJTNwZOXQdGZWLHCj1uvpLPC2Tw0OS/5N7e2B3WxG/JWVHj9A5deBMNn6HbKWcVWBLhJnRFirgWHTyZRXsKXcGp6lE7lF4JFSX/35cYwDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664213; c=relaxed/simple;
	bh=OvkR9kOkS+xl1M5ILVKol3o6PcXO6FqY9rw1G/Jy0uY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N1u5zNbNtpJ1ssJqV9pSHSMFIGm8mX1euv4+t6lXbAhXTXpSCv9ftKVJX9Si7KGWxEfhrPB8iOD34nXIp8m0f2zufLVkpIb5LHBV8mOr6e9q3eSOmWE8cYpg846BVEZ2/kNUYLvBy52svkMbjVdBdrzFoBPurQTcjq7x4qmiJ/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VY6P0SiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455LW7uZ019470;
	Thu, 6 Jun 2024 08:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xfXaprwRq6ysYn9iy2pliOmDnA23C80GYCp1X78vGSk=; b=VY6P0SiSI+Ku1eZo
	R89Z6F162JbhtCJiFWNFI1wDGjgryTXgJ0wEfMdzCVQ2/uu76HGSe01TtXWwuEvS
	4I+tYRxYkIgka7DdW/QCkE1uxX//KB6t7Sdn3Aakw/kATeLgqUcdEFVfyLNz2/bb
	UaXUXF30k/ahOsj2dxDYx3TX/Y8ytzoBgYjcuVo3aDAYX3CtaLV+gSE3T3OAZ5BK
	8h1dWYJeFiWwbGsAxJDdYODNmwWuiyN7KzshcS9/MTTUX8RTVJyVJ3qPIhNTY5iN
	eAuxCnhBlh8C3VXBK6eRws9qLycIUquyF+NkcNYpel79n4aCLZZKJn2jdYfjrt9z
	vxU59w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjan2m2np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Jun 2024 08:56:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4568uf1n016784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 08:56:41 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 01:56:39 -0700
Message-ID: <555d6af3-5b47-6d8a-9222-d3949c156cc4@quicinc.com>
Date: Thu, 6 Jun 2024 14:26:36 +0530
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
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <23a6d1eb-3ce9-400c-aa3d-a7d29c953079@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x0yOlPl6SHzxuu3CMT0GX2ZZMlQExiqG
X-Proofpoint-ORIG-GUID: x0yOlPl6SHzxuu3CMT0GX2ZZMlQExiqG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=980 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406060065



On 6/6/2024 1:25 PM, Felix Fietkau wrote:
> On 06.06.24 09:20, Karthikeyan Periyasamy wrote:
>>
>>
>> On 6/6/2024 12:01 AM, Felix Fietkau wrote:
>>>       /*
>>>        * This is a bit strange, since the iteration used to rely only on
>>> @@ -2384,8 +2383,10 @@ int cfg80211_iter_combinations(struct wiphy 
>>> *wiphy,
>>>        * cfg80211 already - the only thing not would appear to be any 
>>> new
>>>        * interfaces (while being brought up) and channel/radar data.
>>>        */
>>> -    cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
>>> -                   &beacon_int_gcd, &beacon_int_different);
>>> +    if (!radio)
>>> +            cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
>>> +                           &beacon_int_gcd,
>>> +                           &beacon_int_different);
>>
>> Why its avoid for radio specific iface combination ?
> 
> Because it iterates over all wdevs within cfg80211. I didn't think this 
> was necessary, given that it already excludes MLO wdevs.
> 

Dont tie the radio specific iface advertisement with MLO.

Usually the existing code consider "params->new_beacon_int" the MLO 
scenario also.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

