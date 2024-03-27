Return-Path: <linux-wireless+bounces-5319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088B888DAF6
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 11:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB291C2390C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 10:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A033EA86;
	Wed, 27 Mar 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cPNelnD8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA28381BE
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711534187; cv=none; b=RbQh5t/yuwq1b1aaFNOTSAXzTh6hU4HK8ulR7WNflI/gfjYMFgxQt6LDx7oSVsn80rg5JnXSfA3Wc2BZSkZCU9BmUSh6/EHHbyvtmTA+l2gimHwFXXR3xdQAKdzXbZFvE/ZzHc9k+VG2SRWXnPcCrXc3PMp5JGoMn3IEHMo20ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711534187; c=relaxed/simple;
	bh=+p7C2uFZZ/ouX0fbmRshSoUsgbkM9JpjNuWXtOEraOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nNpLnMdhzGBqMamx86YJQpHmsPnMu7Ib2cM2/i/a4Raz/9CPY/nu1JU5elDKjPi3OQuGH4HLCnI9TaFJDqtvNJggajPo7XUpw7x5uH+e1yUcQPpb1pScwdgyFzaDhcxrvniqbj+/9SLww0mUHy1jNWaZQG4oR8fI9zJJEGv6M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cPNelnD8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R8NGCP020977;
	Wed, 27 Mar 2024 10:09:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Go75WFpQ11JIbQ6GcC+LxZIYbIddhsA7jBFd1k3Sj98=; b=cP
	NelnD8pY0gBjmCArU8Uhd2EcTaCH6kbV/M1lowtszrW1uPyBnZTls2SbcHC5lj38
	B5aew8bOE5roaBTMawMQ1AHr+/pEQ+tBLtCYZDEv9GdqBMFrWDw+96AiQsY03x1A
	WbgpcD4PZNxzFOFBlinel59lvvHiKH1v8ozmNHTOWw1sTlszpgg+agObQS+ffa+4
	JxHD85VOzoY8w6FTEH1xB94OCk4uDPBMmBhjR1dN73j5TG9vP4d4y2+NdfzHKxqi
	vUrvH15nrQNUHUMgfc6/FUjkakg1CIKhFhBLwdF9rsDxIG0xFCzSUHpRMWAj8Gnp
	F3WJI6Hq1B8Rvsiow/9g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x47839bxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 10:09:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42RA9YII005676
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 10:09:34 GMT
Received: from [10.216.7.159] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 03:09:32 -0700
Message-ID: <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
Date: Wed, 27 Mar 2024 15:39:28 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
To: Johannes Berg <johannes@sipsolutions.net>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
 <20240319134522.4021062-2-quic_haric@quicinc.com>
 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
Content-Language: en-US
From: Hari Chandrakanthan <quic_haric@quicinc.com>
In-Reply-To: <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Hj9cwXoew0W_bsJq_vZz1QfFVDOD03oK
X-Proofpoint-ORIG-GUID: Hj9cwXoew0W_bsJq_vZz1QfFVDOD03oK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=647 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270068


On 3/25/2024 9:13 PM, Johannes Berg wrote:
> On Tue, 2024-03-19 at 19:15 +0530, Hari Chandrakanthan wrote:
>> Add support to count station level rx retries.
> Should the subject say "for ... stats"?
>
>> +++ b/net/mac80211/sta_info.c
>> @@ -2653,6 +2653,11 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
>>   		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
>>   	}
>>   
>> +	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_RX_RETRIES))) {
>> +		sinfo->rx_retries = sta->deflink.rx_stats.rx_retries;
>> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_RETRIES);
>> +	}
> The use of deflink here seems ... questionable?
>
> I know we've not really done any stats properly here for link STA
> (patches welcome), but I guess this could be a first one that at least
> sums up all the links like all of these should, and then find a way to
> expose per-link as well?
>
> Although possibly we should just expose per-link to cfg80211, and then
> have cfg80211 sum up for the MLD representation...
>
>
> Either way, seems odd to add something now that absolutely cannot work
> for MLO?
>
ok.

Fields such packet count, retries etc can be summed up for the MLD 
representation and the existing NL
attribute can be used for exposing the summed up value.

But there are fields such as signal avg, bitrate etc which cannot be 
summed up.
Should we expose such fields of each link STA through NL?

Sample station dump log for reference:
         inactive time:  271110 ms
         rx bytes:       1129
         rx packets:     13
         tx bytes:       219
         tx packets:     3
         tx retries:     38
         tx failed:      0
         rx drop misc:   0
         signal:         -16 dBm
         signal avg:     -20 dBm
         tx bitrate:     6.0 MBit/s
         tx duration:    452 us
         rx bitrate:     260.0 MBit/s VHT-MCS 6 short GI VHT-NSS 4
         rx duration:    792 us
         last ack signal:0 dBm
         avg ack signal: 0 dBm
         authorized:     yes
         authenticated:  yes
         associated:     yes
         preamble:       long
         WMM/WME:        yes
         MFP:            no
         TDLS peer:      no
         DTIM period:    2
         beacon interval:100
         short slot time:yes
         connected time: 869 seconds
         associated at [boottime]:       1040062.600s
         associated at:  1695979678173 ms
         current time:   1695980547138 ms

> johannes

