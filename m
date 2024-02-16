Return-Path: <linux-wireless+bounces-3655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48BE8573ED
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 04:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EE89281462
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 03:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACC9FBE5;
	Fri, 16 Feb 2024 03:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="C46bLP2x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ECDFC01
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708052678; cv=none; b=EndquaknaTEhto56UuGtv0mVKk9I6bGXxxwl6PMbLF/Ag19YF5hKdRBwzq9QHlnWecr7RuAiBObQPcmla14HCx5w/DUqV6+YjDbl10w70Sh0Uh1SpZG/7wkI0ENkseMaZT+HPIqtwFgHjzxRKr+xEPN0nYzYayMzBEJ+BqZ9EHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708052678; c=relaxed/simple;
	bh=F/Ee6jRo2dLUWkGZkhlgQKLwMQJnRuuGecucpEJP6AU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J8ipTxxlg7FUX6mwhAgUIA6o4RmwlQJ2KmsY+1fhA5t3U265lj08QSiixGSfNrOUv0wSG+sMa3BnB5vZD/3X7Qprjpf1mEHGi0ot0VK/a0ysbrwKq0qL6AfVNq62eqVYClFuEcXdTsdxcCV9+MH+ziqruj0mcmxgQOh8+4dsmJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=C46bLP2x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G2t9x4031968;
	Fri, 16 Feb 2024 03:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=orDKn41MCHwi22+Nae0AUWl/RV3uw6MSXmTw5idtb5s=; b=C4
	6bLP2xmHDJvlXsLTlX99XgSeP41N7wbrXZHDOEAwaa4Fef39vbdHE0syBP1G6A2Q
	e8mfaZWYyJ3ya4ZP2FhBcHfHG8yat6jmo6j1OmhmpAFsKcpvVVtLSKKOy9FIH6aA
	mff575fLH0W1TO0cU7f/POGlmQHpFhUpRaCKY9q4Ku60gyCSdPvV/fa2ZmiNgEP7
	Wgc13Qxd/n5tPXMux6B2AIQftYPhJiGuxpmyHs7zOGGe62W7aKCSdE3exUk3IGzH
	XnTFkU1ZRqNNCdjpOhBW8Tb4cVXECgln3kzavaTAK+yr6LjNteCcqZc6Y+BayyR6
	DMaX4h7ZkkPKhDxyeRRw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xdx8391-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:04:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G34VG5017503
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:04:31 GMT
Received: from [10.201.207.136] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 15 Feb
 2024 19:04:30 -0800
Message-ID: <b9e13882-38b6-4f97-9831-26205fb2ddc9@quicinc.com>
Date: Fri, 16 Feb 2024 08:34:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: check beacon countdown is complete on
 per link basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240215162811.506065-1-quic_adisi@quicinc.com>
 <20240215162811.506065-2-quic_adisi@quicinc.com>
 <189c5d80de6b640686030eef00a1c82f191e5cac.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <189c5d80de6b640686030eef00a1c82f191e5cac.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: h0qtgGnZ7kqB31O7ZDkCal-DoRYiXIXi
X-Proofpoint-GUID: h0qtgGnZ7kqB31O7ZDkCal-DoRYiXIXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=679 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160021

On 2/16/24 01:18, Johannes Berg wrote:
> 
>> -bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
>> +bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif,
>> +					 unsigned int link_id)
>>   {
>>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>> +	struct ieee80211_link_data *link;
>>   	struct beacon_data *beacon = NULL;
>>   	u8 *beacon_data;
>>   	size_t beacon_data_len;
>> @@ -5106,9 +5108,17 @@ bool ieee80211_beacon_cntdwn_is_complete(struct ieee80211_vif *vif)
>>   	if (!ieee80211_sdata_running(sdata))
>>   		return false;
>>   
>> +	if (WARN_ON(link_id >= IEEE80211_MLD_MAX_NUM_LINKS))
>> +		return 0;
>> +
>>   	rcu_read_lock();
>> +
>> +	link = rcu_dereference(sdata->link[link_id]);
>> +	if (!link)
>> +		goto out;
>>
> 
> Maybe that should be a warning too? Not sure I see any case where the
> driver can/should call it with a link that's not even there?
> 

Yes even I don't see any case like that.

> Oh ... and maybe it should check if the link is active? We had the
> sdata_running() check before, but that doesn't mean much for MLO?
> 

Correct. But at least in this function I don't see much use of checking 
if link is active.

> Though then again we have the check below anyway:
> 
>>   	if (vif->type == NL80211_IFTYPE_AP) {
>> -		beacon = rcu_dereference(sdata->deflink.u.ap.beacon);
>> +		beacon = rcu_dereference(link->u.ap.beacon);
>>   		if (WARN_ON(!beacon || !beacon->tail))
>>   			goto out;
>>
> 
> So that will just be NULL if it's not active... so I guess that's fine.
> 
Yep. That's the intention here. Ultimately beacon would be NULL if link 
is not active so eventually a WARN_ON() will trigger.

