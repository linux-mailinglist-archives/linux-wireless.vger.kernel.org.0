Return-Path: <linux-wireless+bounces-15269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01ED9C74AA
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 15:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92A421F25D48
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948F1DF272;
	Wed, 13 Nov 2024 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WLrzEhew"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C6B16DEB4;
	Wed, 13 Nov 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509037; cv=none; b=S7IN861qschiEhp9GIr+jf7UKnR8h8O/9WhlQi12POJh2IEnd0FbkwQnpISiExqV26Bb5c7io6GRKJMFVqDcyZEcgvUnsVxcAkJEQ5r1gsEt7JVFRk3F5co+pu+mREL3bceDz3YbQ/6nt281Emjm6aHJZEfjp7XO0evassijsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509037; c=relaxed/simple;
	bh=t2WtO/QeHXnzOTRE/EZTZ7m1BFBDqSnzm+HgnlQJWiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YQluptUHi+8hZKLxd3CBVvE5yvtsjz842DomaCI5ZOiD+Aswd4ihc9PT+TI5veLNTXLM5Tx0ALRGgcK4zDCdNjIwW5QZvtE7zKptJZyZuEOXonKS11ZHdOzp648lKpI7Ty4/nr7Rf6WcFM4aqyH818AtXaILfjSBEnsogHncDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WLrzEhew; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADCpfib031445;
	Wed, 13 Nov 2024 14:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3LNP0iBpCQcW3CvFDOGm8egHJQ7xu6hdWq4qFuEe7MM=; b=WLrzEhewUKX+Kr5L
	loFvNu+LVAvzuCEYm5AnMDvUzaDRvS8PKvQ7MqxNwBDeBCm1kRUwYPxWlkIKNBXa
	Gbhy7UqHpht+3D/WLDas0XWTlNZtVt/EQw1ajdLHl5gX5/ZFDFiF6/jgZkwfHVyn
	2HLYegecMNZO1DO98O9EUnHXl1qJvbPJmeJdSsij7QNLMylOF3l2UeXbG0BDNfpT
	3eJDt7Box/pXIf97jOerzKwG49M9zQGyHkBovOz15ix6A7p1auDfmu+dL6a9Thiw
	yTAcskCaThTGJeqZP7/UEh9IdV4fArlvx9i/Cw8UyUVAgpdHca4vo7Jbt3uL+1+8
	X3hkLA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42vkvr9ntk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:43:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADEhYgu027524
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 14:43:34 GMT
Received: from [10.216.38.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 06:43:33 -0800
Message-ID: <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
Date: Wed, 13 Nov 2024 20:13:29 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: fix WARN_ON during CAC cancelling
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241113-mlo_dfs_fix-v1-1-e4326736347b@quicinc.com>
 <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <d0eb18d4a302e4be5251106fbfa8f5e10dd36477.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: S4yQlfYUu2V_OLttenX8jIm7eyzghHMj
X-Proofpoint-GUID: S4yQlfYUu2V_OLttenX8jIm7eyzghHMj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=818 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130124

On 11/13/24 14:59, Johannes Berg wrote:
>>
>> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
>> index a5eb92d93074e6ce1e08fcc2790b80cf04ff08f8..2a932a036225a3e0587cf5c18a4e80e91552313b 100644
>> --- a/net/wireless/mlme.c
>> +++ b/net/wireless/mlme.c
>> @@ -1112,10 +1112,6 @@ void cfg80211_cac_event(struct net_device *netdev,
>>   	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
>>   	unsigned long timeout;
>>   
>> -	if (WARN_ON(wdev->valid_links &&
>> -		    !(wdev->valid_links & BIT(link_id))))
>> -		return;
>> -
>>   	trace_cfg80211_cac_event(netdev, event, link_id);
>>   
>>   	if (WARN_ON(!wdev->links[link_id].cac_started &&
>>
> 
> This really doesn't seem right.
> 
> Perhaps the order in teardown should be changed?

I thought about it but couldn't really come down to a convincing approach.

The thing is when CAC in ongoing and hostapd process is killed, there is 
no specific event apart from link delete which hostapd sends. Will it be 
okay to add a new NL command to stop radar detection? Something opposite 
of what start_radar_detection command does?

-- 
Aditya

