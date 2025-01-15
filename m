Return-Path: <linux-wireless+bounces-17530-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B37A118CA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 06:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66F29188A4B7
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABC4156F3B;
	Wed, 15 Jan 2025 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M0MbDxR+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262544360
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736917936; cv=none; b=IlZlHRrs0vbRdpauRawAVGhAKDBuveE+L1IG0MqGpkhe8qpJaEbFsFygUF9LO+NPPCeyzlUpyA/0WJcQVpo9Std0yH5pzIRucu+nG9yGaW/5d+2kwBWdDwOLRHesllQyx8T2kRS3kQWcuITs+PgibOMviLjJmMvhWB7jbe6PPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736917936; c=relaxed/simple;
	bh=RpQHx83CnYkkunG8Qj/B29WVDfbUDRANQ+fTtQVgUxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h64RbEmQCWf/PCNJN4OGIYS5Gw7WVcMvH1ks2wwwAoiIR2eI2L+m3+ts2dmNuysrq0rV28DWyeAzxiYlqgbLW1vwGH+GsvCgq35/K6riO9Qqn4o0Tf6KnlRnlrMsFME5AKQuzFojSlKN0cMODHjt5TtMUCdLvCFFhMQcKwgdnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M0MbDxR+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELNGBc005149;
	Wed, 15 Jan 2025 05:12:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S4UR8Y1MxebqwerxxWjpyCF+TgghoKvCnauU8GfI1N4=; b=M0MbDxR+4B5cwewL
	07vq79zdDOXzvj7Mm+U9zQ4hGTSaZcebhT5YjvfaoM/qqvIqPZ+nQ4RGuzfMefnX
	k6nMJWGLAXtGgGcuk2ctBLryy2vaBwTT0J8kIncBLvCDokXc1fRf1EfEJ90tTByh
	uKHv/wNt7XnxuP5IgNdQsuViNe0HF5HLvoPk6gnjb3bj8oItgJRhJlRtUWAABWnS
	StkdGnUO1YcIr7iy4jbUIarZ5gfllS8crQua/Q2m6oYUOZanMVkecvbWYNFwkYfZ
	wRtbNaEu6gisZob874WUE0a/R6EYd5eIU+9gc5Hj+P8pnGffn5K/IXrmVjNPcGkG
	b4Hs3g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445ysr8uqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:12:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50F5C6YI022612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 05:12:06 GMT
Received: from [10.152.201.120] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 14 Jan
 2025 21:12:05 -0800
Message-ID: <5d5b4723-95a2-41c1-be26-534bb5ff1abe@quicinc.com>
Date: Wed, 15 Jan 2025 10:41:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/7] wifi: cfg80211/mac80211: add support to handle
 per link statistics of multi-link station
To: Ben Greear <greearb@candelatech.com>, <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250110042449.1158789-1-quic_sarishar@quicinc.com>
 <38a7b894-9528-123a-28b8-fd9613fe4a13@candelatech.com>
Content-Language: en-US
From: Sarika Sharma <quic_sarishar@quicinc.com>
In-Reply-To: <38a7b894-9528-123a-28b8-fd9613fe4a13@candelatech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5ZQioUMxjN_2nqBIk0FxwNPg9E-zE0Lv
X-Proofpoint-ORIG-GUID: 5ZQioUMxjN_2nqBIk0FxwNPg9E-zE0Lv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_01,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1011
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150035

On 1/10/2025 10:23 PM, Ben Greear wrote:
> On 1/9/25 20:24, Sarika Sharma wrote:
>> Current implementation of NL80211_CMD_GET_STATION does not work
>> for multi-link operation(MLO) since in case of MLO only deflink
>> (or one of the links) is considered and not all links.
>>
>> Hence, add the link_sinfo structure to provide infrastructure
>> for link-level station statistics for multi-link operation(MLO).
>>
>> Additionally, accumulated stats for MLO are included in a concise
>> manner to provide a comprehensive overview of the ML stations.
>>
>> NOTE:
>>     1. Current code changes are done to get an early feedback on design.
>>     2. Once RFC patches are approved will add the required driver 
>> changes.
>>     3. Ath12k changes are included in this series for reference to other
>>        driver changes.
> 
>> Alternate approach:
>>     - Keep sinfo structure as it is and use this for non-ML or
>>       accumulated statistics for ML station.
>>     - Add link sinfo for links with only certain link specific 
>> statistics.
>>     - Keep mac_op_sta_statistics at MLD level and let driver fill the
>>       MLO and link level data, if driver not filling let mac80211 fill
>>       the data.
>>     - Corresponding changes done to embed statistics into the NL message
>>       based on the sinfo/link_sinfo.
> 
> My suggestions for general approach to this:
> 
> 1)  current sinfo stats should report totals for all links,
> but it should not sum them up at query time because links come
> and go.  So driver/firmware/mac80211 or whatever is keeping count
> of the stats needs to count the total tx/rx/ packets/bytes/whatever
> as it happens.

Alternate approach is not considered here, because some fields at 
station level could not be much meaningful like rx_beacon, pertid ,etc.
I believe the total count is better to do from links data in 
cfg80211/mac80211, as if link's data is provided it is easy to aggregate 
them, during query time.

Also removed link_data is maintained in implemented approach, so that 
could be helpful if any link go down.

> 
> 2)  Per-link stats can be over duration of the link object.
> 
> 3)  For sinfo logic that currently reports tx/rx mcs rate and such that 
> cannot
> be summed, use 'best' link's for those values.  Effectively, this 
> probably means highest
> frequency is 'best' link.

Every fields have it's own way of best, so based on field need to check 
what is best for this field value? but some parameters not have much 
meaning at MLO level like rx_beacon, pertid, etc. So keeping best of it, 
will be useful here?

or you mean need to check for best frequency link and take this link 
data as MLO data? if yes? will it be useful here?

> 
> 4) Add per-link stats data that looks very much like 'sinfo' data struct 
> and user-space
> that can support that could then get detailed per-link stats at same 
> time it is getting
> per netdev 'sinfo' stats.

Again, some fields that are in sinfo structure could not be very useful 
at link level like generation, sta_info, etc. So keeping same structure 
for station level and link level is not very useful, instead better to 
split the structure, fields for station level and some fields at link level.

> 
> 5) Assuming there will never be more than 3 links for any radios 
> supported by Linux in the near future,
> embed the 3 link's 'sinfo-like' stats data structure in the per-netdev 
> sinfo stats struct
> so that we can get all 3 link's data at same time that we are getting 
> the other stats.
> That should save calls into the driver and ensure that per-links stats 
> can be gathered
> at exactly the same time.

Yes, I agree currently it's 3 only, but everywhere we are using max-15, 
so explicitly keeping it 3 here isn't questionable? In future also it 
will not be useful.

> 
> Thanks,
> Ben
> 

Currently, addressing the comments on current implemented approach.


