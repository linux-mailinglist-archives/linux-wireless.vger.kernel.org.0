Return-Path: <linux-wireless+bounces-9569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77E9176BE
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 05:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5CE1C20F43
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9F661FC5;
	Wed, 26 Jun 2024 03:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pcv2090C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710E53E23
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 03:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719372220; cv=none; b=fjy/j3gr9Ra7WqmsKDnbf3H1t5XkyzkLIB2XYifv/pTmDacm3EGHRHNp8+7XMLLu1qMFL08RzOdNJorUpChhLlovbps2/mseuYFhMpVeLFH/4lDvHWyfIQof5dhjtvH8Cq4Q58q3UbPqfcJdIT8Srlg6ThVzxBC+CzkA3DNWGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719372220; c=relaxed/simple;
	bh=QJoYoMttqvmw/RFCZHDZicXH9shqBVzpOEz/GIer3UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YufjhTq4xbrkWyWEbInVlCw+1t7vLbpebaUwkAD3c+nCWX5eYE59Bm30IgQoHhNtDwLhyZU1zmOrZpS6E6q86XcSxXfzsPdfm3Zqn/j4+4V+FSDc5EFb1XO8t827cyjRXinYyXY27FaNalQB8Kw/S/fg6lynceIdjkHwVU/xttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pcv2090C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PHQ0ik018116;
	Wed, 26 Jun 2024 03:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	quzlalAbrbw0664pHB/fOMErzqm6fQ67195Ns5dBBTw=; b=pcv2090CBJcgDDJd
	BQuU/scZUtDoW0iev6Nx5AwYAm0k0k8Tg/e4Zfy/8XkEqRxT3yqkGSYwmPfIdT9D
	KaSLtk8b8Pxv3fVnpXCm4xk4Q1VyMkdhVWPhU7pXdhauDxDWk1qBuILbb2vkpNTm
	sjum0vsw50KoaV+44CVOIA22znFGwM5/VQKCiWvLs4QnrupP8MZwuB2gEWkXLate
	l2qYOS1iOzeLvoFAbtZx6A44gHCTiXjPWeYk/MFSEDguVRTPr/48rzOv1gYYI4Sh
	eBW5LVIHMG5WSWozsUdTTC95BzaIiuwmFlj70ubEtGEsFw5EzNJVjVIbyzYog+kt
	rhyeOA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywkyn8cma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 03:23:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45Q3NXV2010494
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 03:23:33 GMT
Received: from [10.152.202.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 20:23:32 -0700
Message-ID: <4b91df42-3473-4069-8846-9c03f62bb1f0@quicinc.com>
Date: Wed, 26 Jun 2024 08:53:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] wifi: mac80211: fix label name in
 ieee80211_start_radar_detection()
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240619040959.1457547-1-quic_adisi@quicinc.com>
 <20240619040959.1457547-7-quic_adisi@quicinc.com>
 <b419cf92eb34ad9f19260baf2a3e728dea52d4f0.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <b419cf92eb34ad9f19260baf2a3e728dea52d4f0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: osVLlFwEHdMd1gaNrIZbPKfB-ypIczuP
X-Proofpoint-GUID: osVLlFwEHdMd1gaNrIZbPKfB-ypIczuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_01,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260025

On 6/25/24 17:30, Johannes Berg wrote:
> On Wed, 2024-06-19 at 09:39 +0530, Aditya Kumar Singh wrote:
>> After locks rework [1], ieee80211_start_radar_detection() function is no
>> longer acquiring any lock as such explicitly. Hence, it is not unlocking
>> anything as well. However, label "out_unlock" is still used which creates
>> confusion.
>>
>> Rename the label to "return_err".
> 
> Probably better to get rid of it entirely?

Yup, good point. Will do in next version. Thanks for the input.

>>
>> [1]: https://lore.kernel.org/all/20230828135928.b1c6efffe9ad.I4aec875e25abc9ef0b5ad1e70b5747fd483fbd3c@changeid/
> 
> I _think_ people were suggesting to drop the ":" from that?
> 
>> @@ -3477,7 +3477,7 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
>>   
>>   	if (!list_empty(&local->roc_list) || local->scanning) {
>>   		err = -EBUSY;
>> -		goto out_unlock;
>> +		goto return_err;
> 
> can drop braces, "return -EBUSY;"

That's correct.

> 
>> @@ -3487,12 +3487,12 @@ static int ieee80211_start_radar_detection(struct wiphy *wiphy,
>>   	err = ieee80211_link_use_channel(&sdata->deflink, &chanreq,
>>   					 IEEE80211_CHANCTX_SHARED);
>>   	if (err)
>> -		goto out_unlock;
>> +		goto return_err;
> 
> return err;

Yep.

>   
>>   	wiphy_delayed_work_queue(wiphy, &sdata->deflink.dfs_cac_timer_work,
>>   				 msecs_to_jiffies(cac_time_ms));
>>   
>> - out_unlock:
>> + return_err:
>>   	return err;
>>
> 
> and that can then become "return 0" which is much nicer anyway
> 
> Cf. also
> https://staticthinking.wordpress.com/2024/02/28/return-0-is-better-than-return-ret/
> 
Indeed! Will do. Thanks.

