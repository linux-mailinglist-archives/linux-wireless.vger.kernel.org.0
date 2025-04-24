Return-Path: <linux-wireless+bounces-22010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B73EA9B464
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2917C3CB
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9B288CAB;
	Thu, 24 Apr 2025 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e87m8C+o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADFE284685
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513072; cv=none; b=NUBi7IaNMSp+bytl6W1FUR2ppj2lTakHmHhvqgQnPa2FL17L/X8MEN4rk7K4afJnwoi0nYRfL/m7P3u509B4CnH9Lh3ZJX4+deTLU3uB9MQFZnVOO/Ej7sgQlpdr4y6KsHqjrzcdHsuf2D5nlyhwn7QIxtXXryN1BvaLe1P4uis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513072; c=relaxed/simple;
	bh=QCs6y4B/+JbdPfb7CU6X0gPQn92l/DsDXMii/d/HMq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qf2KyxpLu4y5YN2apJVVch65t98jhT8/8ebpPNJUEorujmETx8eFsLhf8j7wCVz6P77DFEdriWxLAqkITVvmnWDnTCTApXiKvfxpsK+sMiKnvpA5HqR35vm47PTdPjnKo1Lsj6kzH50mUeHJhGImVNihpt+wsPyWjTp16BfgZ4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e87m8C+o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OC3B7I016183;
	Thu, 24 Apr 2025 16:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hhWis3oRd8IFVvw6Is3B/8N0JOu4NlmzMBsmJkU4zkE=; b=e87m8C+oNh+X9G0A
	XytbxcQQ7/yXVi9ik4F3WtbIXoE64d1UUKxfzFfqe5RFYrbF62lU17bSOPR6mH78
	SZaUcWzA0vCN6/I8KVvXQMXdRAE2Ei+oNcejDQ3k17/OAGrMcawA2CPhZ2V3mFHW
	Xo76JKH5VEEYjlLFe+sU5XOBhaFeG1bfW2O7qjvF0neZAu1pbBGFDL2fTrxZ7r3u
	vd6AqpzQCcBaCdybdQHYeZ8Kvq0jP352JQegix2d80NZqf8G4bDtbz9e63y1FC70
	cnWt0Wn2Rrx6LE+Vre2GT/qz3SFTAbyPD2o+4XdQgy4wZU07kLNjvtPlAYM5BnHa
	A19F+g==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh0edsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:44:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OGiP89003298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 16:44:25 GMT
Received: from [10.50.10.125] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 09:44:23 -0700
Message-ID: <c3a6b07e-007e-4168-bf8a-7b0d9ebbc913@quicinc.com>
Date: Thu, 24 Apr 2025 22:14:20 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 04/11] wifi: cfg80211: reorg sinfo
 structure elements for MLO
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250415042030.1246187-1-quic_sarishar@quicinc.com>
 <20250415042030.1246187-5-quic_sarishar@quicinc.com>
 <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <fa49a2d4927868be689ed8464aa27c3aad2f03b6.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 31JhL2E10MkOEBibx5PIPn-be1UKb20z
X-Proofpoint-ORIG-GUID: 31JhL2E10MkOEBibx5PIPn-be1UKb20z
X-Authority-Analysis: v=2.4 cv=Fv0F/3rq c=1 sm=1 tr=0 ts=680a6a69 cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=9BaG5z2gojUmMlJgXmQA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDExNSBTYWx0ZWRfX+Gt9PaQYBrz8 YqABSBAFrWdOokmCWrXPNiTD6dLbVVLlh9zpI0C9dJvg1k3JrxElgsEOIeyeMTkTrmkkvvXEo6X G46TROdkbEwFpXidZgrxOGf39+UxIyzcxK6A9Som2PbACNYtX/AkSlOEQnrZ3pyJ9+DPkdwWp6g
 /UaZwJ85x+ScvrvhKxoSgSNUEaF/Knj79QOZ36BIxP2DsIUpdDWo8yBg6oHNQaCG9Yg5CFzNpI8 ns+hAxdAHQeE5MRHbeIGKabGX6sxU2gnyhmIR2DfulHFIb6SuNj4iPaguUN6y3b7KiTIpFbz/jz DKvUhhHexgncfiabz0pthG+jikrUAodZWukkui2ME1I9cs6gfIzKowC1tsV7dibim6V8s7452Jd
 tePWngya5T7UT4U/pEVNjGB5zN9jUTmNxyaYpT+q16QNPt9FRprMghN85zuFLZ6dv1bduucI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_07,2025-04-24_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=918 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240115

On 4/23/2025 10:22 PM, Johannes Berg wrote:
> On Tue, 2025-04-15 at 09:50 +0530, Sarika Sharma wrote:
>> Current implementation of NL80211_GET_STATION does not work for
>> multi-link operation(MLO) since in case of MLO only deflink (or one
>> of the links) is considered and not all links.
>>
>> Therefore to support for MLO, start reorganizing sinfo structure
>> related data elements and add link_sinfo structure for link-level
>> statistics and keep station related data at sinfo structure.
>> Currently, changes are done at the deflink(or one of the links) level.
>> Actual link-level changes will be added in subsequent changes.
>>
>> Also currently, mac80211 ops .sta_statistics() is mapped to fill sinfo
>> structure. But to add support for station statistics at link level,
>> change the ops to .link_sta_statistics() to fill link_sinfo structure.
>>
>> Additionally, move connected_time before assoc_at in station_info
>> structure to get minimal holes.
>> pahole summary before this change:
>>   - size: 232, cachelines: 4, members: 23
>>   - sum members: 223, holes: 3, sum holes: 9
>>   - forced alignments: 1
>>   - last cacheline: 40 bytes
>>
>> pahole summary after this change:
>>   - size: 224, cachelines: 4, members: 23
>>   - sum members: 223, holes: 1, sum holes: 1
>>   - forced alignments: 1
>>   - last cacheline: 32 bytes
>>
>> Signed-off-by: Sarika Sharma <quic_sarishar@quicinc.com>
>> ---
>> NOTE:
>>   - Included driver changes for fixing compilation issue.
> 
> Does this really need to do all the changes in mac80211 and the drivers?
> 
> OTOH maybe if not then it would cause much more back and forth?

Yes, true this patch includes only the minimum necessary changes to 
resolve the compilation issues in mac80211 and the drivers.

Without these changes, compilation issues will persist.

> 
>> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
>> @@ -1810,47 +1810,51 @@ static int ath6kl_get_station(struct wiphy *wiphy, struct net_device *dev,
>>   	else if (left < 0)
>>   		return left;
>>   
>> +	sinfo->links[0] = kzalloc(sizeof(*sinfo->links[0]), GFP_KERNEL);
>> +	if (!sinfo->links[0])
>> +		return -ENOMEM;
>>
> 
> This seems rather error-prone to me.
> 
> We already have sinfo->pertid today, allocated and freed by cfg80211,
> and here you've added something that's allocated by the driver and freed
> by mac80211. That seems odd in comparison?
> 
> I'm not sure what the choices are, but I can't say I like this one ;-)
> Maybe it's still the least bad option.

Options what I can think of here, other then above approach, may be can 
allocate memory during get_station() call only, in cfg80211(but this may 
not be memory efficient as have to allocate for all possible links).

or, may be can introduce an API in cfg80211 to allocate the memory for 
sinfo->links, and call the API from drivers/mac80211 while filling the 
sinfo->links[] data.

> 
>>   	if (vif->target_stats.rx_byte) {
>> -		sinfo->rx_bytes = vif->target_stats.rx_byte;
>> -		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
>> -		sinfo->rx_packets = vif->target_stats.rx_pkt;
>> -		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
>> +		sinfo->links[0]->rx_bytes = vif->target_stats.rx_byte;
>> +		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
>> +		sinfo->links[0]->rx_packets = vif->target_stats.rx_pkt;
>> +		sinfo->links[0]->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
>>   	}
> 
> You later (patch 7) add support for accumulated statistics. These are in
> the struct station_info.
> 

Yes, possibly here it is true, all fields are present.
But there might be some drivers which have fields that is not in sinfo 
structure.

So, the structure filling and meaning for structure fields should be 
consistent across the drivers, therefore I guess sinfo->links[0] is 
better and efficient way to be followed for non-ML drivers.
(Pseudo code for suggested approach mentioned below)

> Why do we need to make these changes to non-MLO drivers at all? It
> stands to reason that for non-MLO drivers we could mostly use the
> accumulated statistics? That'd at least be 9 of the values changed here,
> they just come back as is in patch 7.
> 
> I don't think it really matters for non-MLO whether or not link[0] is
> used or the overall STA/accumulated fields?

True, it doesn't matters for non-ML station, values could be taken from 
sinfo or sinfo->links[0].

But I believe taking sinfo->links[0], will be better way as code will be 
even, while filling the sinfo and link_sinfo structure for ML/non-ML 
drivers.
(Pseudo code for suggested approach mentioned below)

> 
> A similar argument can be made for what's later called 'mld_addr' and
> some other fields, I'd say?
> 
> Perhaps it'd be better to structure this patchset the other way around:
> start with the existing non-MLO and move out things that are clearly not
> applicable at all to the MLD level (such as RSSI, rates, etc.). It seems
> plausible that'd really be less than you have now, since the
> accumulation (patch 7) adds back a bunch and should possibly add back
> more than it does (e.g. tx/rx duration, MPDU count, etc.)
> 

We can do with above way- however may be few points why I started with 
this approach not the other one:

Pseudo code for above suggested approach:
- Remove fields from station_info structure, not applicable for MLD 
level and add sinfo_links and add links applicable fields.

- cfg80211/mac80211:
     structure sinfo {
         filled
         packets
         bytes...
         // Fields applicable at MLD level
         // Remove fields not applicable at MLD level (RSSI, etc.)
         link_station_info *links[IEEE80211_MLD_MAX_NUM_LINKS]
     }

     structure link_station_info {
         filled
         packets
         bytes...
         // All link-level applicable fields (RSSI, etc.)
     }

- Call get_station from cfg80211, which will call sta_set_sinfo in mac80211.

- sta_set_sinfo() -> refactor code and split for non-ML stats and MLO 
stats in different ways:
     non-ML -> fill all station_info data and other link-level data in 
sinfo->links[0] (RSSI, etc. // fields not applicable at MLD level)
     MLO -> fill station-specific data only (avoid filling accumulated 
stats( data will be accumulated in cfg80211) and refactor code
         to fill all link-specific data applicable (rx_byte, etc.)

- Call driver to fill sinfo data + sinfo->links[0] data (for some 
fields) for non-ML and fill link_sinfo data for MLO.

Reasons for not considering this approach:

- Some fields in the sinfo structure have different meanings for MLO and 
non-ML stations. For example:
     signal - for non-ML, it is the station signal, but for MLO, it is 
the best signal of all links.
     etc.
   So, the structure parameters' meanings will be inconsistent.

- Code flow will be uneven and clumsy (in mac80211 - split the code to 
fill station info fields for non-ML and a few fields to fill for 
sinfo->links[0], for MLO, fill some fields only at station_info and most 
fields at the link level).

But if this approach looks more reliable, could send a new version with 
these changes?

> 
> I probably need to spend more time with this ...
> 
> johannes


