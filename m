Return-Path: <linux-wireless+bounces-12159-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5CB962650
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 13:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C961F242D7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 11:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB616D4EE;
	Wed, 28 Aug 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PSmvIWjc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470816C861
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724845694; cv=none; b=ZXKA14PFzmuTKd8tuuXSqz3Hcwr9kIHe6zBDMVhExjQWR5gvoAmyOmzbPBTHqXdqvE6SV/0qMg57puxKLPtBPe1V/g4E+SISCMY6MnRkS30wWBl4LYjWlmjnf7dQ9XWz86A99sTPTksJmodRhFLvwKdUQIcyNcLiISOh+XXCtu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724845694; c=relaxed/simple;
	bh=Im+NmlpVzHlmW2/4dE4eFpp2qzEgoZJYVfMBbtOPnLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GLNBrDq2mFM2x5cGBXujPyIFT5nm1rEZ0CornWUJMaZTuWz6egJJWsdUqXlswo8OgRTCReGBLM9AQhWYwKFIWy1Agk0DHPZi1AkPA7idtc5n5rScrRJc3azhLkwVi9e8KGT3fFBJoLLxiDQ+W9o57rNhaDZgSVt9fIOtdl5KdrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PSmvIWjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SB2PKN021973;
	Wed, 28 Aug 2024 11:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1tnmxQYLK4AGUkva94kFtwT9mX+zjvybHyxstLZxTOw=; b=PSmvIWjcJkQktjU5
	C/Hx47/O4xpDtnyg5a+3iQBXWKUzrwpM8yv/MiS+L72Seuu1ropyyi7PT+cZfjsI
	TZKyJYAsv/5Kn/qB6kn5ZLF4dlQFmL1GfmoBQStjVKGnM31LUtJ39FhFewpYe42Y
	YlQJxS2qLxyHPHg+3ZID9oVZUCKe9hOdh6juddaG10IVoCsGqn16AL7/r427jE2o
	hZ2Sl/CW5dmC6tOlKVz987brdjw0Lv9P6rQOX+2MT9JaHwADtX0vLWyVuDlbYbw+
	rOPFucWn+9MblLwCdVrKJfHIRzvKg9H8+HfNj5m//msHtlP/2T6gQ912Qo0I6uW8
	RBSahA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419q2xsmk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 11:48:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SBm0wB026983
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 11:48:00 GMT
Received: from [10.216.37.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 04:47:58 -0700
Message-ID: <22a210cc-8e9f-47f7-8b4b-aff8f9a0781c@quicinc.com>
Date: Wed, 28 Aug 2024 17:17:55 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] wifi: mac80211: handle ieee80211_radar_detected()
 for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240711035147.1896538-1-quic_adisi@quicinc.com>
 <20240711035147.1896538-9-quic_adisi@quicinc.com>
 <5c099cda2015594d23f29635d77adf9db5744a15.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <5c099cda2015594d23f29635d77adf9db5744a15.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IGSseqemUEb9EisQzb1jvij-MmqSjP9S
X-Proofpoint-GUID: IGSseqemUEb9EisQzb1jvij-MmqSjP9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_04,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408280085

On 8/28/24 16:03, Johannes Berg wrote:
> On Thu, 2024-07-11 at 09:21 +0530, Aditya Kumar Singh wrote:
>>
>>    * In the worker, go over all the contexts again and for all such context
>>      which is marked with radar detected, add it to a local linked list.
> 
> Why is the local list needed first?

As per the current design and hwsim test cases, 
NL80211_RADAR_CAC_ABORTED event is expected first and then 
NL80211_RADAR_DETECTED event. Now, in the worker, while iterating over 
the contexts and upon finding radar marked contexts, 
cfg80211_radar_event() can not be called immediately. First 
ieee80211_dfs_cac_cancel() needs to be called which in turn will send 
CAC_ABORTED event. Now calling this will delete the channel context, 
hence a local copy is taken and since we could have multiple contexts 
marked with radar, a linked list is used.

> 
>> +++ b/include/net/mac80211.h
>> @@ -257,6 +257,7 @@ struct ieee80211_chan_req {
>>    *	after RTS/CTS handshake to receive SMPS MIMO transmissions;
>>    *	this will always be >= @rx_chains_static.
>>    * @radar_enabled: whether radar detection is enabled on this channel.
>> + * @radar_detected: whether radar got detected on this channel.
>>    * @drv_priv: data area for driver use, will always be aligned to
>>    *	sizeof(void *), size is determined in hw information.
>>    */
>> @@ -269,6 +270,7 @@ struct ieee80211_chanctx_conf {
>>   	u8 rx_chains_static, rx_chains_dynamic;
>>   
>>   	bool radar_enabled;
>> +	bool radar_detected;
> 
> I'm not sure why you're adding this to the driver visible part of the
> chanctx, I don't think that really makes sense since setting it must be
> done by mac80211 through the API function to trigger all the work?

So you want to add this member in struct ieee80211_chanctx? Yeah we can 
move to there as well.

> 
>> +++ b/net/mac80211/ieee80211_i.h
>> @@ -1329,6 +1329,11 @@ enum mac80211_scan_state {
>>   
>>   DECLARE_STATIC_KEY_FALSE(aql_disable);
>>   
>> +struct radar_info {
>> +	struct list_head list;
>> +	struct cfg80211_chan_def chandef;
>> +};
> 
> If it _really_ is needed this can be local to the C file.

Okay sure.

> 
>> +	INIT_LIST_HEAD(&radar_info_list);
> 
> but really, why?

I've answered this above. Please let me know if it is still not clear.

> 
>>   	list_for_each_entry(ctx, &local->chanctx_list, list) {
>>   		if (ctx->replace_state == IEEE80211_CHANCTX_REPLACES_OTHER)
>>   			continue;
>>   
>> -		num_chanctx++;
>> -		chandef = ctx->conf.def;
>> +		if (ctx->conf.radar_detected) {
>> +			ctx->conf.radar_detected = false;
>> +			num_chanctx++;
>> +
>> +			radar_info = kzalloc(sizeof(*radar_info), GFP_KERNEL);
>> +			if (WARN_ON(!radar_info))
>> +				continue;
> 
> that clearly shouldn't be a WARN_ON,

If node can not be added, NL event will not be sent to user sapce and 
apt action can not be taken. Will that be fine missing out it without 
any warning?

> 
>> +
>> +			INIT_LIST_HEAD(&radar_info->list);
>> +			radar_info->chandef = ctx->conf.def;
>> +			list_add_tail(&radar_info->list, &radar_info_list);
> 
> but I also don't really see why you couldn't just call
> cfg80211_radar_event() here.

I've answered this as well above. Please let me know if it is still not 
clear.

> 
>> +	if (num_chanctx > 1) {
>> +		/* XXX: multi-channel is not supported yet in case of non-MLO */
>> +		if (WARN_ON(!(wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)))
>> +			trigger_event = false;
>> +	}
> 
> I don't see how that'd happen in the first place?

This part is keeping the same old code with the new handling with MLO. 
Prior to MLO, if num_chanctx is more than 1, it would throw a warn_on so 
that's why it will throw now as well if MLO is not supported and 
simultaneously two channel contexts are marked as radar detected.

> 
> johannes

-- 
Aditya


