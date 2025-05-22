Return-Path: <linux-wireless+bounces-23295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D30AC0880
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85F03A7928
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44048254873;
	Thu, 22 May 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ggWkIadT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FDC2EF;
	Thu, 22 May 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905686; cv=none; b=MQ+lCQhbzPEIEFodDXahr1AkILS+lxI6oueJ/aA26MKGUez94jNFW2oCGrae+OaZIeKDQHC1NVYSp5gpT9Dc5cvgulHwmfbh1WDl0hBPxZpgB2Hr+D+rP7A26BVqsbmfvDhSdLQ5tgkI05S8dFxxBWJ+No9DFfuP0w/31btMjoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905686; c=relaxed/simple;
	bh=mE1PBBdiCUAfuYLq9s75R8eefvL04S4/DPTR9c0GKEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C6UruEdvxdcLsmJ1maK68mxXMA/vRAKPp1T2g8wCAblfNz6+YwEUebq3HDXfGM9/JJPfqTMk/5fGCAzPBiiSP17kcTRXAIjpbHFI5bKjsr++5dQgrV89qj6M1/y4yul+J8pftFVvcR1s5zR2tDrZ02aoO1m/C9LzonGszxF48cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ggWkIadT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7ZfpG032698;
	Thu, 22 May 2025 09:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OfFQcp7R1/HPn9Y1r0ELmaSelxLSB6NhumbBR3lzbYY=; b=ggWkIadTSiuPeh1c
	rqiU4CDsbHYxG8t5vqvPKmcymbIAJoqJex7BY2LD35Biee1w7/cHT0TcG45Q0/8B
	quZjFtyHdMiCuNFsKdpBIsnhC78HMj3SGVB9BmLgkAgJLoKbz1h72cu39zDxsEIk
	LSSXrFCMgz4Q4Ypol+1D4+qaaOUF1FU29z1VDgbsw4uRMe/opFNPbwx7yoTW3KRw
	eJ1vUN1ydFbMBpVEvTSAes1GjzWIlLkSzQ2gx24i6GseuRny9Z+J7OY+S9EzzCtf
	AtBXWgYBn0Gb3/De/Y+GaQwKkl1oihAaQEhHe07Jk8RwzyQRUjCP7JAKrTiWgJXi
	5VG+dA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c24bq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:21:20 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54M9LJEr011097
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 09:21:19 GMT
Received: from [10.152.207.135] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 22 May
 2025 02:21:17 -0700
Message-ID: <d2aa2b49-f907-41e4-8208-3b92da607a34@quicinc.com>
Date: Thu, 22 May 2025 14:51:14 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211: Allow DFS/CSA on a
 radio if scan is ongoing on another radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Aditya
 Kumar Singh" <aditya.kumar.singh@oss.qualcomm.com>
References: <20250514-mlo-dfs-acs-v1-0-74e42a5583c6@quicinc.com>
 <20250514-mlo-dfs-acs-v1-3-74e42a5583c6@quicinc.com>
 <fb6cb470c66e215c0fde3652c1986d604731ac94.camel@sipsolutions.net>
Content-Language: en-US
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <fb6cb470c66e215c0fde3652c1986d604731ac94.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA5MyBTYWx0ZWRfX2+znLhnjoevS
 2Mj9N7SkwryDPKRQVqVm752tyEOXwu41kxJnPIK9xW2IJKOwrfXOLQRq+tsaXGV/aPoSMyqfCpt
 AerbQKugxN5eG/+nkx1cPpJbGvctHabutzJKrwzflGEZdQKlbB+p4t/7VKQQiVbDQoq0J5F0pZR
 vohAmF9KmtrZyCV2gPUlKwxwJC1S7eebDZ5ARVnt2AC+lM5mc45UIxvqU2/loNBWMb7SzJm3KOx
 yqn4T3LCPv6l1640g746gKIOUxGL4Pox6WhUQT3wEIFbb6CkjiXAxdBGAbD6KGLAiTyNtv3bhuL
 lGjUgrqxr9tFRG+SWcJCO87Z7IQF82WP9WBGIQI2YQLpHOBPkjyaax3xp2hi4pZWVutJXfH4/88
 FxKwPoAn5zcPIqilo4kiUtojFyM05GXZSBHgdsgrnx+DIgYT3fd4HgvhcEGa58Uv/3Ck2Otu
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682eec90 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=baXPdB0C5tyLT9uP71EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: OmCdwnk8PiL0ZG9UXGIHKQ8CmdHsRD6j
X-Proofpoint-GUID: OmCdwnk8PiL0ZG9UXGIHKQ8CmdHsRD6j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220093

On 5/16/2025 1:35 PM, Johannes Berg wrote:
> On Wed, 2025-05-14 at 16:58 +0530, Raj Kumar Bhagat wrote:
>>
>> +static bool
>> +__ieee80211_is_scan_ongoing(struct wiphy *wiphy,
>> +			    struct ieee80211_local *local,
>> +			    struct cfg80211_chan_def *chandef)
> 
> Any particular reason or the __ name? We usually have that for internal
> locking-related things, but here doesn't matter, and there's no non-__
> version either?
> 

Next version will rename this function to "ieee80211_is_scan_ongoing()".

>> +{
>> +	struct cfg80211_scan_request *scan_req;
>> +	int chan_radio_idx, req_radio_idx;
>> +	struct ieee80211_roc_work *roc;
>> +	bool ret = false;
>> +
>> +	if (!list_empty(&local->roc_list) || local->scanning)
>> +		ret = true;
>> +
>> +	if (wiphy->n_radio < 2)
>> +		return ret;
>> +
>> +	/*
>> +	 * Multiple HWs are grouped under same wiphy. If not scanning then
>> +	 * return now itself
>> +	 */
>> +	if (!ret)
>> +		return ret;
> 
> I don't fully understand this logic, and certainly not the comment. You
> can certainly "return false" here anyway or something. And initialize
> ret = list_empty || scanning or something, the whole thing is hard to
> follow?
> 

Thanks for suggestion, will simplify the above logic in next version.

> 
>> +	if (!list_empty(&local->roc_list)) {
>> +		list_for_each_entry(roc, &local->roc_list, list) {
> 
> There's no point in checking first before iterating, it's perfectly fine
> to iterate an empty list and do nothing while doing so ...
> 

Sure, will do in next version.

> 
> Also patch-order wise, it seems this one really should go before the
> 2nd?
> 

Sure will update the patch order as suggested.

