Return-Path: <linux-wireless+bounces-5994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C4D89D511
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 11:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D71C21996
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 09:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B175339A;
	Tue,  9 Apr 2024 09:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aclFlPQX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6997EEE0
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 09:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653602; cv=none; b=rsyGz06mnsAfLaSI1eVyFnJI7dPdON/8/kp7gmfgqOJbyuk9SQRH8HLR/PLCnjSDv64DTnlATAxtLsVRhQEWqmkVcUT2L1JhJSxvlFnfwnABLafJO9umR6kC20Mf8sxrxgcTPLYr4mJdyJf71mBb0PjbRifnm/q+otZ+d0YMgGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653602; c=relaxed/simple;
	bh=Z73v6FIGfwiByAT6/QKXk7kmTbNiT9EzdtVwkJiCO1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=clhhbWdnVpV4gRx564s8fSj70kdrS9YSWeeQpEaQzH87jtimyke8lcS15c+CW3SDA10DJ4VRAfn68gbvQLWRUam2WCPGzJLewn7TlsfEgT/Fds/jeaT+/m7DKovitZaEr14b9qcSalm8a+sCA56BYLfOs180AHlG8H/rFsUXYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aclFlPQX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4397o2pm020737;
	Tue, 9 Apr 2024 09:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lNMlg02CJFuGUeYXDToHklfhiyKGIqVJY3BcUszPHp0=; b=ac
	lFlPQXxvRy8eF5uMnXWixDnPMzzybcZwd2NAOa/UNqkB3jx9Xfq3Yo5hr7SeHbbt
	tKQlbmQYD1tw/mKjJAR5agb97R5lL8TyrzlkBOtrhErIekO47Ynqrts5372E3DXx
	ow2YrgopI/ohLSy6HU1sCSQb1msKI5wPYImJ9YQIT5E2cFzH47YLbB5KS7fbZvh9
	2Oxkq2bQE900z8FV+mTsIIkv2XbwJMzOgzCfQqGAnl2sRiDi6tAACqjVINYYACVD
	S6/NAMQVNhLKYsAj4/CoqsmRzPWI1KSxB14rFFeGkq5/8bpbcz6uzmY62sN8Ak1P
	xF2e1CwzXDfEmA4NkJgw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd0hjr99h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 09:06:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43996aLd026126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 09:06:36 GMT
Received: from [10.216.45.2] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 9 Apr 2024
 02:06:34 -0700
Message-ID: <f3032ce0-fe04-42e4-822b-a920ea6e0e3f@quicinc.com>
Date: Tue, 9 Apr 2024 14:36:31 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: handle sdata->u.ap.active flag with MLO
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240326151141.3824454-1-quic_adisi@quicinc.com>
 <bae1e71edcc13e73e8ef7f24d30140a4a6aefb98.camel@sipsolutions.net>
 <15bc7705-5da9-4c56-aa45-81972bad5e01@quicinc.com>
 <98081f4e417cf20beea41288ca7b75235b8fe0e0.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <98081f4e417cf20beea41288ca7b75235b8fe0e0.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3lqfVH-S8V6cb0pjZVnXY1Gb4ZrADW9Z
X-Proofpoint-GUID: 3lqfVH-S8V6cb0pjZVnXY1Gb4ZrADW9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_06,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090057

On 4/9/24 12:57, Johannes Berg wrote:
> On Tue, 2024-04-09 at 09:27 +0530, Aditya Kumar Singh wrote:
>> On 4/8/24 23:55, Johannes Berg wrote:
>>> On Tue, 2024-03-26 at 20:41 +0530, Aditya Kumar Singh wrote:
>>>
>>>> @@ -1232,7 +1256,9 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
>>>>    	}
>>>>    
>>>>    	rcu_assign_pointer(link->u.ap.beacon, new);
>>>> -	sdata->u.ap.active = true;
>>>> +
>>>> +	if (ieee80211_num_beaconing_links(sdata) <= 1)
>>>> +		sdata->u.ap.active = true;
>>>
>>> I don't understand this change. Neither the <= 1 really, nor the fact
>>> that you actually _make_ this change.
>>>
>>
>> The place above where we are checking number of beaconing links, at that
>> point at least 1 should be active. Since before checking, we have done
>> rcu_assign_pointer() so at least 1 should be there. That is why that
>> condition.
>>
>> If it is more than 1, then this is not the first link which is going to
>> come up and hence there is no need to set the flag again.
> 
> Hmm, OK, I guess that makes some sense. However, it's also completely
> pointless, since setting it =true when it's already =true doesn't really
> do anything. Adding the code seems to imply it should avoid setting it
> in some cases, which isn't actually the case.
> 
> Besides, doing the counting is almost certainly far more expensive than
> simply setting it to true when it's already true. Certainly the state
> should be =true after this function is called.
> 
> If you really think the extra write might be a problem (it isn't though)
> then you'd still want to write it as "if (!active) active=true" since
> that's actually checking the right thing. But ... that really wouldn't
> matter in all but the highest-performance code meant to deal with high
> (CPU/core) parallelism.
> 
> So this is just a long-winded way of saying: don't do that, just keep it
> unconditionally setting active.
> 

Well, that's true. Just to have symmetry in beaconing up and tear down I 
did like that but it seems costly as you said. I will instead go with 
!active thing as you suggested. Thanks for your inputs. Will send v2 
soon for review.

>>>> @@ -1486,7 +1488,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
>>>>    		if (old)
>>>>    			kfree_rcu(old, rcu_head);
>>>>    		RCU_INIT_POINTER(link->u.ap.beacon, NULL);
>>>> -		sdata->u.ap.active = false;
>>>> +
>>>> +		if (!ieee80211_num_beaconing_links(sdata))
>>>> +			sdata->u.ap.active = false;
>>>
>>> == 0 maybe?
>>>
>>
>> Yeah can do. I prefer "!expr" over "expr == 0". Do you have any preference?
> 
> I think for something that actually _counts_, like here, I'd (slightly)
> prefer ==0. It's obviously equivalent, but it seems more natural to
> write "is number of beaconing links equal to zero" rather than "is not
> number of beaconing links".
> 
> I may be influenced too much by Dan's thoughts on the matter ;-)
> 
> https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/

Yeah in this case it seems reasonable to use "== 0" instead. Will do 
like this.

> 
>>> Or maybe we should just save/restore the value instead?
>>>
>>>>    	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
>>>>    		netif_carrier_off(vlan->dev);
>>>>    
>>>> -	if (ieee80211_num_beaconing_links(sdata) <= 1)
>>>
>>> Unrelated, but it looks like the VLAN netif_carrier_off() handling above
>>> is also wrong and should really go into this if block as well.
>>>
>>
>> Yeah MLO VLAN changes would do that? The previous change was focusing on
>> the AP mode alone and I did not want to break anything in VLAN so did
>> not touch it there.
> 
> Sure sure, just drive-by observation.

:)



