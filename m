Return-Path: <linux-wireless+bounces-19687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9801DA4B9BD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 09:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900581890F01
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Mar 2025 08:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8A4B667;
	Mon,  3 Mar 2025 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="STNQX5Kk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38FA22611
	for <linux-wireless@vger.kernel.org>; Mon,  3 Mar 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991616; cv=none; b=lazpnqwSTSCwCyvy+EtyqQQm4t1OSCV7nZk4FhG9G4MsbyL+6uC3g//qwpfdJ+YslD9pU043yLCRCJ7+r1HHlJFcBckYX5SsXVUpQHzhLfTtKNs9HYM3qtkXh6oH7Qm0tgSbgey5fbSPzWs8OlnabumC4xU+n7MtyFQWXIe/oNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991616; c=relaxed/simple;
	bh=fOxpqGGb2y6WEQPQJB/JbqbqQ8YKVfIjjzkY9TzG5nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=olf7Hzrfdeff6Y3zy5Rf8WWu9eT/hIWVuptVc93ki5UN18a7DsJnZu/B7RS8HO2ZwJfyydaxD4/dOAozzT41EwoUhoGsKGeuY9OR8ujQzt+g8V+/kyEjpV+nqwwRD4uUOWS9Hb+Azft0Jw8gvt5+Yhn5t3EUYT/xIeh+u1yBcnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=STNQX5Kk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522NTtcA009143;
	Mon, 3 Mar 2025 08:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2hUdwLPmioySthKILoBhoRlwKbOykAoYEZSYsDqbR18=; b=STNQX5Kk+fFrlYa5
	cjqdKHhsr5gBOSZv68ruhvN2KpwsIlM7UXXoKynke5iuiLqcKTBRFRgzZ0nDBn7S
	4wpVGz5bROd+MzPsSczKlcBLmsfJl57OG1JKZ0lQwl1x27PIcimootmn/HlCwbQ3
	mFszWKT1hP7kxexWz6MOUrUXXSXBA1tYDN7GetmhC4BTziHAcDir/brHV/vDGOhQ
	W8e5QD5E2U1UNvOivg5lWeH8yIUGwXaCa2L7Aj4S1b0N1bIa3cLXDKFzzdiwPcgw
	poZYIrdhRr89l4cOEH6UvUeXI//aKjS/fSKjBAUmnQswE+Ady2HohzPDR8S9tZ7o
	rOFpNw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t9945ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:46:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5238koi5019732
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 08:46:50 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Mar 2025
 00:46:48 -0800
Message-ID: <c3c5fc43-9140-4793-9e61-279b7176150d@quicinc.com>
Date: Mon, 3 Mar 2025 14:16:46 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] wifi: mac80211: add support towards MLO handling
 of station statistics
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250213171632.1646538-1-quic_sarishar@quicinc.com>
 <20250213171632.1646538-4-quic_sarishar@quicinc.com>
 <38d1d5f8be439e8553cddd2df03bf3553bafb82f.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <38d1d5f8be439e8553cddd2df03bf3553bafb82f.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: C9Vd9Wx70HxVkSVE0Ncw-OxNrmZ4hlLe
X-Proofpoint-GUID: C9Vd9Wx70HxVkSVE0Ncw-OxNrmZ4hlLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_03,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=941
 mlxscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503030066

On 2/28/2025 6:46 PM, Johannes Berg wrote:
> On Thu, 2025-02-13 at 22:46 +0530, Sarika Sharma wrote:
>>
>> -	if (!sta->deflink.pcpu_rx_stats)
>> +	if (link_id < 0)
>> +		link_sta_info = &sta->deflink;
>> +	else
>> +		link_sta_info =
>> +			rcu_dereference_protected(sta->link[link_id],
>> +						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
> 
> We have all kinds of helper macros for that? Even this very specific
> case: link_sta_dereference_protected()

Sure, will check this and use link_sta_dereference_protected() instead.

> 
>> +	stats = &link_sta_info->rx_stats;
> 
> Should you check that link_sta_info even exists, just in case some link
> IDs get mixed up? Not sure.

No, here it is not required, as already lock is acquired and checked 
existence of link_sta_info in it's caller.

> 
>> -unsigned long ieee80211_sta_last_active(struct sta_info *sta)
>> +unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id)
>>   {
>> -	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta);
>> +	struct ieee80211_sta_rx_stats *stats = sta_get_last_rx_stats(sta, link_id);
>> +	struct link_sta_info *link_sta_info;
>> +
>> +	if (link_id < 0)
>> +		link_sta_info = &sta->deflink;
>> +	else
>> +		link_sta_info =
>> +			rcu_dereference_protected(sta->link[link_id],
>> +						  lockdep_is_held(&sta->local->hw.wiphy->mtx));
>>   
>> -	if (!sta->deflink.status_stats.last_ack ||
>> -	    time_after(stats->last_rx, sta->deflink.status_stats.last_ack))
>> +	if (!link_sta_info->status_stats.last_ack ||
>> +	    time_after(stats->last_rx, link_sta_info->status_stats.last_ack))
>>   		return stats->last_rx;
>> -	return sta->deflink.status_stats.last_ack;
>> +
>> +	return link_sta_info->status_stats.last_ack;
>>   }
> 
> This seems wrong, if you ask for -1 you get deflink but that's no longer
> updated at all, so you break the current/updated sta_set_sinfo() usage
> with this since you just use -1 statically there now (with this patch.)

Yes, I updated the usage, passing -1 as of now with this patch.
But deflink is still filled whenever we use -1.

Example:
Here, in sta_set_tidstats() we check
if (link_id < 0)
+		link_sta_info = &sta->deflink;

> 
>>   static void sta_update_codel_params(struct sta_info *sta, u32 thr)
>> diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
>> index 07b7ec39a52f..7e600c82a6e1 100644
>> --- a/net/mac80211/sta_info.h
>> +++ b/net/mac80211/sta_info.h
>> @@ -947,7 +947,7 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_info *sta);
>>   void ieee80211_sta_ps_deliver_poll_response(struct sta_info *sta);
>>   void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
>>   
>> -unsigned long ieee80211_sta_last_active(struct sta_info *sta);
>> +unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id);
>>   
>>   void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
>>   					   const u8 *ext_capab,
>> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
>> index f6b631faf4f7..1e2cb33030da 100644
>> --- a/net/mac80211/util.c
>> +++ b/net/mac80211/util.c
>> @@ -3276,14 +3276,28 @@ int ieee80211_put_srates_elem(struct sk_buff *skb,
>>   	return 0;
>>   }
>>   
>> -int ieee80211_ave_rssi(struct ieee80211_vif *vif)
>> +int ieee80211_ave_rssi(struct ieee80211_vif *vif, int link_id)
>>   {
>>   	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>> +	struct ieee80211_link_data *link_data;
>> +	int rssi;
>>   
>>   	if (WARN_ON_ONCE(sdata->vif.type != NL80211_IFTYPE_STATION))
>>   		return 0;
>>   
>> -	return -ewma_beacon_signal_read(&sdata->deflink.u.mgd.ave_beacon_signal);
>> +	if (link_id < 0)
>> +		link_data = &sdata->deflink;
>> +	else
>> +		link_data =
>> +			rcu_dereference_protected(sdata->link[link_id],
>> +						  lockdep_is_held(&sdata->local->hw.wiphy->mtx));
>> +
>> +	if (WARN_ON(!link_data))
>> +		return -99;
>> +
>> +	rssi = -ewma_beacon_signal_read(&link_data->u.mgd.ave_beacon_signal);
>> +
>> +	return rssi;
> 
> what's the point in the trivial intermediate 'rssi' variable? It's not
> even for line length since "rssi = " is the same length as "return "?

Oops! sure, will use return directly.

> 
> johannes
> 


