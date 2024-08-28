Return-Path: <linux-wireless+bounces-12162-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A59626DE
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE101F23897
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D77816A95E;
	Wed, 28 Aug 2024 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JC4d7QKr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9129416BE1D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847786; cv=none; b=Q9KbOakl5eMmg2j7m3xCqFDLfwmJoR3sogmbjHWtIuQkUyI4JbvJmGbqcUzrdHYvybYeUSoT8Y79sFhn/3UVhAxNwJM4jnzuJjFfdTFM6ZUBKyRLY9bfIk/oTZnLC5rs1e1CnEYexshJsqC6oV+fVvVfG/5KG46dxKlqLp2w/T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847786; c=relaxed/simple;
	bh=99h6B84IoHbu4qTt75e0EY98smJnLT3MrIWOe0wkb9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tXWkHYS6JOg1+ZIJkfINLdxudw5Pl8lafap/rTklyBPsAF1tNIaRKcehSRFwKeQyuN8t0hofuUf0kET9xUy5ThGmgeVBw7cqSEMDOu5o7xMeQ/ThKrqJfajPk+LgZZB0rl4jCthY8XDsJ435XRxWsUD+TTXULPGseMCFDPpBsdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JC4d7QKr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SAVxZ5007314;
	Wed, 28 Aug 2024 12:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QdMO2yD1ps72yVxNjrtuJ4MYtUijzWns+A9g/VTkZB8=; b=JC4d7QKrBVPrbkhJ
	FhX5i7wHqGoMcgKnrrHUDmuuhYn77wpUbrmlWuhtCLDoLoUyyr4fOdZEMSVY6ZMU
	zKAqdvsyu0bUgLBJDJt0IXkjU+ZLzkrrE7ajjBmHZpmJ7UMnAiiOtOL/DU7VJNN5
	kHUw/MPrElhVBj9zmxHaJYZGM4fOxS3z6RSz624WUzsYdkTipK/5eWPFlks4oKQj
	ZIb8P29vPI+2TA/nPB+MHtACpGdZnZmj/yU/MCjOiL7ZSqy+lolc/sT7J+0wCLBZ
	en3Wy8pw9G1PB/N1LzCnWmN26J7LFKAwBNh97A94+xEbcpv31qZhdW6rS8qgRC0O
	cy8xzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puw1qrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 12:23:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47SCMw6L031715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Aug 2024 12:22:59 GMT
Received: from [10.216.37.253] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 28 Aug
 2024 05:22:57 -0700
Message-ID: <97e2b90e-3f2b-488a-8744-8f60f3697859@quicinc.com>
Date: Wed, 28 Aug 2024 17:52:54 +0530
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
 <22a210cc-8e9f-47f7-8b4b-aff8f9a0781c@quicinc.com>
 <f7a99b42dae9a2c5c035515a0c4e70dff6344465.camel@sipsolutions.net>
Content-Language: en-US
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
In-Reply-To: <f7a99b42dae9a2c5c035515a0c4e70dff6344465.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mA71c5kt7rNLbESzHg7-xgavRmCcx9dp
X-Proofpoint-GUID: mA71c5kt7rNLbESzHg7-xgavRmCcx9dp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_05,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 spamscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408280089

On 8/28/24 17:34, Johannes Berg wrote:
> On Wed, 2024-08-28 at 17:17 +0530, Aditya Kumar Singh wrote:
>> On 8/28/24 16:03, Johannes Berg wrote:
>>> On Thu, 2024-07-11 at 09:21 +0530, Aditya Kumar Singh wrote:
>>>>
>>>>     * In the worker, go over all the contexts again and for all such context
>>>>       which is marked with radar detected, add it to a local linked list.
>>>
>>> Why is the local list needed first?
>>
>> As per the current design and hwsim test cases,
>> NL80211_RADAR_CAC_ABORTED event is expected first and then
>> NL80211_RADAR_DETECTED event.
> 
> Ouch, OK.
> 
>> Now, in the worker, while iterating over
>> the contexts and upon finding radar marked contexts,
>> cfg80211_radar_event() can not be called immediately. First
>> ieee80211_dfs_cac_cancel() needs to be called which in turn will send
>> CAC_ABORTED event. Now calling this will delete the channel context,
>> hence a local copy is taken and since we could have multiple contexts
>> marked with radar, a linked list is used.
> 
> Why not do both in ieee80211_dfs_cac_cancel() then? You're effectively
> iterating all the chanctx's there anyway, so you could just add
> 
>   if (ctx->radar_reported) {
>      ctx->radar_reported = false;
>      tmp_chandef = ctx->conf.chandef;
>      report = true;
>   }
> 
>   ...
>   cac_event()
>   if (report)
>     cfg80211_radar_event(...)
> 
> or so in the loop there?

Okay sure. Let me see what I can do here.

> 
>>>> +			radar_info = kzalloc(sizeof(*radar_info), GFP_KERNEL);
>>>> +			if (WARN_ON(!radar_info))
>>>> +				continue;
>>>
>>> that clearly shouldn't be a WARN_ON,
>>
>> If node can not be added, NL event will not be sent to user sapce and
>> apt action can not be taken. Will that be fine missing out it without
>> any warning?
> 
> Have you actually _seen_ what happens if the kernel runs out of memory?
> Not that it'll actually happen here.

:) Okay will remove WARN_ON().

> 
>>>> +	if (num_chanctx > 1) {
>>>> +		/* XXX: multi-channel is not supported yet in case of non-MLO */
>>>> +		if (WARN_ON(!(wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)))
>>>> +			trigger_event = false;
>>>> +	}
>>>
>>> I don't see how that'd happen in the first place?
>>
>> This part is keeping the same old code with the new handling with MLO.
>> Prior to MLO, if num_chanctx is more than 1, it would throw a warn_on so
>> that's why it will throw now as well if MLO is not supported and
>> simultaneously two channel contexts are marked as radar detected.
> 
> I don't think it can actually happen, and if keeping the warning around
> makes the code this complex I'm not sure I'd want to?

Sure will remove that condition check. Thanks for the suggestions.

> 
> johannes

-- 
Aditya


