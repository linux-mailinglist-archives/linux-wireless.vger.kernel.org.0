Return-Path: <linux-wireless+bounces-21968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDABDA9AB95
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AB7170D8F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3762222489A;
	Thu, 24 Apr 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Cn+j7Qlr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF0922258B
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745493650; cv=none; b=rrI/605iE8ZuomC2H2STyxLhTAEnKn4vjwxMMYYVFjaWaiU4qIPhBLSnHH/rwGh57NmaicpMVMfP+ekOiRvtYPfZGCBaGrCwtgnzLRVaFjWhKcD3g5g7ZmTsZZybICzmrQahkpVe1ud09cne2dmIgb7HMzWjBGgTZwfWH+O4LvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745493650; c=relaxed/simple;
	bh=28rAhRGZj3YTTw8mUV2pZZ53EZiJ1l1Rgk0hra06+ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qqP/4onnUKMYmqZBeUmy8dE9lG6E/a7yakKDV1AkZw+c0XOlL6WehYrhX+RtseVrwiqn8P90SSPRt60WqbCbH1Bv51w65xNv4i30420CTqNhjD2LEfSfd/Gtq2wVTqMWm+WZJHFMfpDOA3F8wkRVZiclKE12he0HRHxWf4CYecM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Cn+j7Qlr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OAWYV3005969;
	Thu, 24 Apr 2025 11:20:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c1x2O9tpR+xE1WzBgPNjh7tAXxb+CCWqh5jDk2qvaCk=; b=Cn+j7QlrBYp1lLXB
	DgrcP6bGk8t9CAE/QwTI8ykaiBC1tfsus35Lle/KDdwzQ78eGbQZZ2MGclRCa3AG
	5bUZZqTxDeDG/n3hHCOnyGM+CdqUV7EeYN3mF0YvKwfV/0FczmbW/ku1sIvIUQz/
	e183sTD1AUg1d9EbUymMbq3e7UbBbJV1GS1uSbIEVs6SJGEtJoFZhEchdc/dAXD3
	q00epYKW+zXSTpU9qHgQVulfHsqJjLkG8ro2+Rgq2mhcSDJud0o1JCbwmV6A26WI
	oyY3bVkaSgQ1Tfml+nhYFw+9ctw/dnGwePZF9spoYmr5v3pkUl295M0E1LE/nTo+
	Rgxzkw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 466jh05by7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:20:44 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53OBKYuW014396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 11:20:34 GMT
Received: from [10.152.206.29] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 24 Apr
 2025 04:20:33 -0700
Message-ID: <28d1f106-d498-4e47-bf8a-bde9189918da@quicinc.com>
Date: Thu, 24 Apr 2025 16:50:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v6 1/5] wifi: cfg80211: Add Support to Set
 RTS Threshold for each Radio
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250328122519.1946729-1-quic_rdevanat@quicinc.com>
 <20250328122519.1946729-2-quic_rdevanat@quicinc.com>
 <bef48349364854ba2ec42262e91b747028310a1c.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <bef48349364854ba2ec42262e91b747028310a1c.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDA3NiBTYWx0ZWRfX8UXnAG+61rVr FGmeXraaE49CRfKgw/2Dq/EkSBDWTfBFPOlSSA0cKvJBhJjNZhAy0QpiGWyOvL/8xu+TJ8sUh65 IyyaMzhlr4jZozX5Eu67+xipmS0O6mJZAtLA+vPkwMosvuJRyrKpiEEYyHjOcYJ00J6EMLUx+RF
 RDciDNkzTs+yLlPldGY6LVqMrm1KkvlL3X4rlLhFGwDaDd3bdzs3XlBfte/FM3uK7qOHe5HrcCe ZQVoXefnah0nJcI7PVs1Ihh5tvEfhVEiFNLk6PaPlVZb0oV0rRrSICZsjvXG4SfNvYo/cco49mM m1SeOduH0U2gucSXjmjl3Kp/vtZLUVt0CXZvMOwavfY+H3pK9HXaVDIywsTTpZDnrku7ItZOSEj
 nyj9paZTVsXO6j470wjB1Odi62/4eBtEYtEpvh6+ywFh8IWmBTLkDjB8vj3xCYdQ0VVcqtBT
X-Proofpoint-GUID: DXr7k8z5phKEF5ZdlyM7wKhG70FIzxD1
X-Authority-Analysis: v=2.4 cv=ZuTtK87G c=1 sm=1 tr=0 ts=680a1e8c cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=rNVh4dst47hFR5lpOHoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: DXr7k8z5phKEF5ZdlyM7wKhG70FIzxD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_05,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=715 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504240076



On 4/23/2025 9:06 PM, Johannes Berg wrote:
> On Fri, 2025-03-28 at 17:55 +0530, Roopni Devanathan wrote:
>>
>> -static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
>> +static int ath6kl_cfg80211_set_wiphy_params(struct wiphy *wiphy, s8 radio_id, u32 changed)
> 
> nit: all those lines could be shorter. I'm surprised you even did that
> by hand rather than spatch ;-)
> 
Will address this in next version.

>>  #define NL80211_WIPHY_NAME_MAXLEN		64
>> +#define NL80211_WIPHY_RADIO_ID_DEFAULT		-1
> 
> It seems to me that should't be in nl80211.h, since it cannot be used by
> userspace, and is internal anyway?
> 
> And why should the attribute even be signed, when you explicitly reject
> negative values anyway? Seems like it should simply be unsigned?
>
Sure, will change this in next version.
 
>> +	/* Allocate radio configuration space for multi-radio wiphy
>> +	 */
> 
> what happened there
> 
>> +	if (wiphy->n_radio > 0) {
>> +		int idx;
>> +
>> +		wiphy->radio_cfg = kcalloc(wiphy->n_radio, sizeof(*wiphy->radio_cfg),
>> +					   GFP_KERNEL);
>> +		if (!wiphy->radio_cfg)
>> +			return -ENOMEM;
>> +		/*
>> +		 * Initialize wiphy radio parameters to IEEE 802.11 MIB default values.
>> +		 * RTS threshold is disabled by default with the special -1 value.
> 
> unnecessarily long lines
> 
Will resolve this in next version.

>> @@ -1185,6 +1202,7 @@ void wiphy_unregister(struct wiphy *wiphy)
>>  	cfg80211_rdev_free_wowlan(rdev);
>>  	cfg80211_free_coalesce(rdev->coalesce);
>>  	rdev->coalesce = NULL;
>> +	kfree(wiphy->radio_cfg);
>>  }
> 
> Hm. Would be safer in wiphy_free()?
> 
Sure, will port it to wiphy_free().

>> @@ -3875,50 +3887,79 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
>>  
>>  	if (changed) {
>>  		u8 old_retry_short, old_retry_long;
>> -		u32 old_frag_threshold, old_rts_threshold;
>> -		u8 old_coverage_class;
>> +		u32 old_frag_threshold, old_rts_threshold, *old_radio_rts_threshold;
>> +		u8 old_coverage_class, i;
> 
> also long lines
> 
>> +		old_radio_rts_threshold = kcalloc(rdev->wiphy.n_radio, sizeof(u32),
>> +						  GFP_KERNEL);
> 
> long line
> 
> allocations can fail
> 
> you leak it
> 
Will resolve this in next version.

> 
>> +
>> +		if (radio_id < rdev->wiphy.n_radio && radio_id >= 0) {
>> +			old_rts_threshold =
>> +				rdev->wiphy.radio_cfg[radio_id].rts_threshold;
>> +
>> +			if (changed & WIPHY_PARAM_RTS_THRESHOLD)
>> +				rdev->wiphy.radio_cfg[radio_id].rts_threshold =
>> +					rts_threshold;
>> +
>> +			result = rdev_set_wiphy_params(rdev, radio_id, changed);
>> +			if (result)
>> +				rdev->wiphy.radio_cfg[radio_id].rts_threshold =
>> +					old_rts_threshold;
> 
> this is also getting really deep - probably better to refactor this into
> new functions for the two cases (with and without radio idx)
> 
Sure, will split the code.

>>  static inline int
>> -rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, u32 changed)
>> +rdev_set_wiphy_params(struct cfg80211_registered_device *rdev, s8 radio_id, u32 changed)
>>  {
> 
> also unnecessarily long
> 
Will resolve this in next version.

> johannes

