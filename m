Return-Path: <linux-wireless+bounces-2593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FB883EB21
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 05:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9133C1F237B9
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jan 2024 04:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FBB12E41;
	Sat, 27 Jan 2024 04:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JcbNNZMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31A8BED
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jan 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331529; cv=none; b=p6NaAjWDNxi0cGYu651ETOf29u6jDWJYmciZcsLMKX4g5YQfaCzE7CUaSbXeKHdkl/nxSL6/Zk82qP1EcxohnmVv47qYfMF/GvUSrylSpNZsl4qs+9noLHWbW5pWQz1LvuOWkJi/Yt151DLzpGD6JcnYha2is1/UUyCrgkMtBM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331529; c=relaxed/simple;
	bh=WoLD7pt6zFs6zqnc82HkXVEe+IxBh5nLcgwOKG3lb6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H8FdCAbJGuF6c5r0LLFBNic0/kCZZqLJKKkQ3aW3NcK6IU7fVLhuBVX/7nPIhfmut3qmcJbG5x4bY8gTJ9fecuPZibPc1Nbfmoj81lAVWZYD2+lYMMoIR0igWbqCETZgxKDLg0O7t/DGk6JmAJk8SkSKw8KxRDWdfIyqI3/ck7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JcbNNZMG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40R4w4dH029824;
	Sat, 27 Jan 2024 04:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eEC2hF5jXKY9/Pp9mblMcGNtN4pmwz0Y8PQMcbXvxqU=; b=Jc
	bNNZMGKSN8ABgmr1ebw7ISsdtD80Gg9rbfbT/b27gZ8Hnlta4EI32GarS92IDmqh
	984OhYtfQjz4ng9LvYAjbYhEEt9KAOzkUOrbHWfTIXKnGwqDXTBYyTKoIAH/LYWL
	sIZ9AbAFBG4U5qPaDeJR+ccQ4aYKAA0tEti1AGWK+4buLd7Gq8bswB+Lp4cP4zZB
	qfz4pRDEWFaLyHMZEj4ppXX9wcNl0mTkwS+dPrfIKHxPeJnTPtcI1t7NHRD/prRS
	5OlwscHOdoIiqyvVxYP8ozbtrbaL3dWm9HKcTGUZ/yCzW8o2qOriQbA2blRvJt6i
	69Cv548ceHjRhT1j5XRw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvrsug5ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 04:58:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40R4wgAI007774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Jan 2024 04:58:42 GMT
Received: from [10.216.58.0] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 26 Jan
 2024 20:58:40 -0800
Message-ID: <033151e5-7857-4c44-9b12-d8d8317a4139@quicinc.com>
Date: Sat, 27 Jan 2024 10:28:37 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] wifi: mac80211: add support for AP channel switch
 with MLO
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240125130410.827701-1-quic_adisi@quicinc.com>
 <20240125130410.827701-3-quic_adisi@quicinc.com>
 <d4e77541479560147d453b7b5c06de3f940bad35.camel@sipsolutions.net>
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <d4e77541479560147d453b7b5c06de3f940bad35.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _rUauwBPVW3hFejtYpi9MNRKRh99pcaH
X-Proofpoint-GUID: _rUauwBPVW3hFejtYpi9MNRKRh99pcaH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401270035

On 1/26/24 15:01, Johannes Berg wrote:
> On Thu, 2024-01-25 at 18:34 +0530, Aditya Kumar Singh wrote:
>> Currently, during channel switch, deflink (or link_id 0)
> 
> The parenthetical is wrong: deflink isn't even a valid/used link *at
> all* in MLD data structures. Speaking about "link_id 0" would be a valid
> thing to do even for MLD, but speaking about "deflink" isn't.
> 

Okay got it. Will address in next version.

> 
>> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
>> @@ -2285,7 +2285,7 @@ static void mac80211_hwsim_beacon_tx(void *arg, u8 *mac,
>>   	}
>>   
>>   	if (link_conf->csa_active && ieee80211_beacon_cntdwn_is_complete(vif))
>> -		ieee80211_csa_finish(vif);
>> +		ieee80211_csa_finish(vif, link_id);
> 
> Might make sense to keep the actual logic changes out of this patch?
> It's pretty big, and this is pretty hidden...
> 

Sure so I will move this ieee80211_csa_finish() changes to a different 
patch.

>> +++ b/net/mac80211/cfg.c
>> @@ -1588,6 +1588,8 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev,
>>   		link->csa_block_tx = false;
>>   	}
>>   
>> +	wiphy_work_cancel(wiphy, &link->csa_finalize_work);
> 
> You don't _really_ need that here (if it runs, it'll just find
> csa_active==false), and I'd feel better about it if we actually had this
> in ieee80211_link_stop() in some way, that's called from
> ieee80211_tear_down_links() and then it's really obvious to see that
> this is removed before freeing the link.
> 

Yeah makes sense. Let me see what I can do here. Thanks for the inputs! :)

>> -	if (sdata->vif.bss_conf.eht_puncturing != sdata->vif.bss_conf.csa_punct_bitmap) {
>> -		sdata->vif.bss_conf.eht_puncturing =
>> -					sdata->vif.bss_conf.csa_punct_bitmap;
>> +	if (link_conf->eht_puncturing != link_conf->csa_punct_bitmap) {
>> +		link_conf->eht_puncturing = link_conf->csa_punct_bitmap;
>>   		changed |= BSS_CHANGED_EHT_PUNCTURING;
>>   	}
> 
> Hm. I'm going to send some patches soon that remove the puncturing stuff
> and move it into the chandef (as we discussed elsewhere), but just
> noting that - doesn't need to concern you here, I think.
> 

Oh okay! Let's see if at all it conflicts, will send a re-based once 
those gets merged.

>> @@ -3875,16 +3894,23 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
>>   	if (sdata->wdev.cac_started)
>>   		return -EBUSY;
>>   
>> -	if (cfg80211_chandef_identical(&params->chandef,
>> -				       &sdata->vif.bss_conf.chandef))
>> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>> +		return -EINVAL;
>> +
>> +	link_data = wiphy_dereference(wiphy, sdata->link[link_id]);
>> +	if (!link_data)
>> +		return -ENOLINK;
>> +
>> +	link_conf = link_data->conf;
>> +
>> +	if (cfg80211_chandef_identical(&params->chandef, &link_conf->chandef))
>>   		return -EINVAL;
> 
> Also another thing unrelated to your patch - I'm thinking about removing
> that identical() check entirely - you might want to switch to the same
> channel with quiet=1. At least for testing that'd be really useful, and
> I don't think it really serves any purpose to forbid it.
> 
Yeah, we can do. But is there any actual use case? Also, what if some 
notorious user space application simply sends NL command without even 
quiet=1? There should be some check I guess?

