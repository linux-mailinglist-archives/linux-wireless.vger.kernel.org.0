Return-Path: <linux-wireless+bounces-15277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3A9C7A05
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 18:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB3DB279F8
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461FC158D93;
	Wed, 13 Nov 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k9WJD7cf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE7B13B5AE;
	Wed, 13 Nov 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514857; cv=none; b=YuObzCjlUZ1lY3ylPW7Xegt4dYEbvk7w4uI/psW9VSD/ZQ5FlioGWWZGrXdPm7Jj/7sQ+FoPJJ5zk2FBg8BWh9Zbe+nNqJ/amw7QvXOgKvPPTJ7wKfFlOrg/5++dwyB4z9UhZCh74mf5mlyWgoOntTLZSxS3U8BXhQjbqSHvZos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514857; c=relaxed/simple;
	bh=lRGhAJ/9VWeaVLsscQ7KSa1mJkIIRLqg+5970adWr8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BGIB+sMpwETigv6B2bwdb9Dvrh8yUCVA20TB1tF1mdZ6p89y7EqC+LtxD58ehEklKIKEmTnPv4VZui4JkIytmalHVNne05tvO4OciX7ixppsKsv3JAB1voeKoRGXgsEPAKIQkTLGkqkbwijgf1JcEJODI8bh39ld7UbwnlWvDh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k9WJD7cf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD9sjn5014823;
	Wed, 13 Nov 2024 16:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jhWCMul96BfcVa7FrwzASwBJCYOs19YcscRz15aAOTs=; b=k9WJD7cfdksNOSry
	XDKbRb1OF39xOi/gDP9Q/8NUoXtOmAK4+IkB/dAzlmMdyFXLCnSO+UVgTwAAhsHw
	zNdf5YDJ+QlVtW0H4KxdoGnixD6WVnUGql1datOA9QRNKxfNAbOSYloVAsWu++Es
	uRe3Bn0WvsfcRO7E40G4f/mo2Fy2KRQxRTRl3KRGexTG7SbrOMS6+n61hknwcExo
	eCT4lym+FIABBuad0rcIo3Zgc70qQaQsEnbkBOm8N0eaf1XReDlJMPWTIpRda6Sd
	q+WN2E23xSlyChHLZw768QfgJTsoxD9ppA9nfRAZmG/wnWy5chyPZkXaFTaB8KvR
	8Ijp+Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42v47y4kkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 16:20:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ADGKoMc027314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 16:20:50 GMT
Received: from [10.216.38.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 13 Nov
 2024 08:20:48 -0800
Message-ID: <f383c25d-fb76-4e3e-b900-7156f608bef0@quicinc.com>
Date: Wed, 13 Nov 2024 21:50:43 +0530
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
 <383a616d-50c7-4538-9e94-fc8526405c94@quicinc.com>
 <6b59e7a5f90b85dfc9146fa2cbdfe56c0a307a3e.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <6b59e7a5f90b85dfc9146fa2cbdfe56c0a307a3e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aV1_pOQ84zU9uMKCZAQn2AGxwE74mRkn
X-Proofpoint-GUID: aV1_pOQ84zU9uMKCZAQn2AGxwE74mRkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=857 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411130136

On 11/13/24 21:18, Johannes Berg wrote:
> On Wed, 2024-11-13 at 20:13 +0530, Aditya Kumar Singh wrote:
>> On 11/13/24 14:59, Johannes Berg wrote:
>>>>
>>>> diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
>>>> index a5eb92d93074e6ce1e08fcc2790b80cf04ff08f8..2a932a036225a3e0587cf5c18a4e80e91552313b 100644
>>>> --- a/net/wireless/mlme.c
>>>> +++ b/net/wireless/mlme.c
>>>> @@ -1112,10 +1112,6 @@ void cfg80211_cac_event(struct net_device *netdev,
>>>>    	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
>>>>    	unsigned long timeout;
>>>>    
>>>> -	if (WARN_ON(wdev->valid_links &&
>>>> -		    !(wdev->valid_links & BIT(link_id))))
>>>> -		return;
>>>> -
>>>>    	trace_cfg80211_cac_event(netdev, event, link_id);
>>>>    
>>>>    	if (WARN_ON(!wdev->links[link_id].cac_started &&
>>>>
>>>
>>> This really doesn't seem right.
>>>
>>> Perhaps the order in teardown should be changed?
>>
>> I thought about it but couldn't really come down to a convincing approach.
>>
>> The thing is when CAC in ongoing and hostapd process is killed, there is
>> no specific event apart from link delete which hostapd sends.
>>
> 
> so we do have link removal, why doesn't that work?

Because link ID is cleared from the bitmap well before link stop is 
called. As mentioned in commit message, this is the flow -

nl80211_remove_link
   > cfg80211_remove_link                -> link ID gets updated here
     > ieee80211_del_intf_link
       > ieee80211_vif_set_links
         > ieee80211_vif_update_links
           > ieee80211_link_stop         -> this ultimately tries to stop
					   CAC if it is ongoing.

> 
>> Will it be
>> okay to add a new NL command to stop radar detection? Something opposite
>> of what start_radar_detection command does?
>>
> 
> No, obviously not.
> 
> johannes


-- 
Aditya

