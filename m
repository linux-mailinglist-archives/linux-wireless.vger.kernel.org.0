Return-Path: <linux-wireless+bounces-16579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5849F7487
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 07:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D142B1886E76
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 06:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB57216E07;
	Thu, 19 Dec 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lbJ2paOs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0821F867C
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 06:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734588329; cv=none; b=LfOHjRBhKERftQtad33m2ggNDTJ7XpqlqAEPJAJDMZzWxeJ+HB61zNlOdioMj+PLSAoxps6nAsbfbNw240B0WjqlyYSE/sMNAQPwosdDR8xR+dLu+fk5JeAp1eIkkO7XcbdOXFSZTUyqP5J+RGqufE6jddBKqB6pT3KxqsRHsrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734588329; c=relaxed/simple;
	bh=11CZRreUc+UzyGm+GvPKeyGeGrZS17pAtoea4Zma4Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VrWmU5GcLF/1zDbqaDPd6VSGZyZR1d6r5gjPCoZ+FURr1JP7JTvzGBWjIGEqeGUoiCfZkyBHayMU9apPIRZXjFcE8qNLckeytrDwtGqsu+V8k2s3cRtQOWEs4405HONbCc2C0iIfCvBUhmq1HdUw1XahcCY5TZB8LPPbDNTz+pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lbJ2paOs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIMhbd2028689;
	Thu, 19 Dec 2024 06:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+orIIDWddqXnCsraqpLffAtHMT9yQG3M5oBOXrx53vU=; b=lbJ2paOsxQtH8+Pa
	Ytk9RvLOweiUlOJXhhVZAUs41De9KSaWEpnlhU+ra1Vr4QLddO16nE66MShuZd9A
	JcCyeCdeiW41iD9bmYjDEnV7VLZkKBb7HOjtUzkC7PozB0qVgX+A9JfXAvq7l6y2
	sWTh2cjMKdiPzxNYdWPfsvbceQZTDWE0Hu172MlJjvLrjUcS7+gNfX/HGLCORmxl
	Gt3jN39zeI22uyYJkS03UOBHV6ESPCVsCdp9aqfgma4GPm5iqhenFUivDeZ6HnBy
	jrHZiZB8M1bepGe4mLkknpxFM06gGWJy0aQpL+wRDZUy+YOiyKVtQJgwor9bHl+b
	l8RDkA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43m7eb0u61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:05:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ65DOV001666
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 06:05:13 GMT
Received: from [10.204.117.236] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 18 Dec
 2024 22:05:12 -0800
Message-ID: <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
Date: Thu, 19 Dec 2024 11:35:00 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: cfg80211: skip regulatory checks when the
 channel is punctured
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_mpaluri@quicinc.com>
References: <20241125051624.29085-1-quic_kkavita@quicinc.com>
 <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <quic_kkavita@quicinc.com>
In-Reply-To: <cc95ac5eb124ff46484a44beb0e2ec300d1d6392.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QAYnJ68PAWHCLw8C4OBsesyVIvdDIb9v
X-Proofpoint-ORIG-GUID: QAYnJ68PAWHCLw8C4OBsesyVIvdDIb9v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190046



On 12/4/2024 9:05 PM, Johannes Berg wrote:
> The subject is a bit misleading IMHO - you don't skip all checks when
> there's puncturing ...
> 
> maybe just say "wifi: cfg80211: skip regulatory for punctured
> subchannels"
> 
>> However, these checks are also performed on frequencies that
>> have been punctured, which should not be examined as they are
>> not in use.
> 
> I'd argue subchannels are punctured (or really disabled, the whole
> channel is punctured ... but we mix that up already), not frequencies
>

Thanks for the feedback, will make the necessary changes.


>>   static void cfg80211_set_chans_dfs_state(struct wiphy *wiphy, u32 center_freq,
>> -					 u32 bandwidth,
>> +					 u32 bandwidth, u16 punctured,
>>   					 enum nl80211_dfs_state dfs_state)
>>   {
>>   	struct ieee80211_channel *c;
>>   	u32 freq;
>> +	int subchan = 0;
>>   
>>   	for (freq = center_freq - bandwidth/2 + 10;
>>   	     freq <= center_freq + bandwidth/2 - 10;
>>   	     freq += 20) {
>> +		if (punctured & BIT(subchan))
>> +			continue;
>> +		subchan++;
>>
> 
> You never tested this code properly, it's clearly broken.
> 
> but anyway - for_each_subchan()?

Thank you for pointing that out. You are correct. I apologize for the 
mistake.
The for_each_subchan() macro will not work for this. When sub channel is 
null, it will terminate the loop, but in this case, we should continue 
checking other sub channels.

> 
>> +#define for_each_subchan(wiphy, center_freq, bandwidth, punctured,	\
>> +			       subchan)						\
> 
> I feel like we really should make this work on a chandef, not all these
> arguments ... and cover both center_freq1 and center_freq2, because we
> have all these duplicate calls like cfg80211_chandef_dfs_cac_time().
> 
>> +	for (subchan = ieee80211_next_subchan(wiphy, center_freq, bandwidth,	\
>> +					      punctured, NULL);			\
> 
> It should be especially easy if you're pulling it out into iterator
> functions? Worst case, keep some extra state in the loop, like
> 
> for (u32 punctured = chandef->punctured,
>       freq = cfg80211_get_start_freq(chandef, 1),
>       _cf = 1;
>       freq = _cf == 1 ? 20, punctured >>= 1;
>       ...)
>    if (!(punctured & 1))
> 
> 
> I don't really mind a bit more complexity here, if it means we can get
> rid of all the functions like cfg80211_get_chans_dfs_required() that get
> called twice ...

Thank you for the suggestion. I am working on this and will share the 
updated patch with you soon.

> 
> johannes


