Return-Path: <linux-wireless+bounces-23208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6DABEF32
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D153A9798
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82EF238C10;
	Wed, 21 May 2025 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kdKzorIv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C702129E6E
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818563; cv=none; b=PpRxgWfVgJMehPSr+za6bJwnMngo87yWOuyJBcB/r3WDx12uM3f7lFSVnEfKx83F0VccaQTjBtP2pSoyEnhrNnxihM7RjthTSwNH76m8bNhUhkLuAsktA6wYXjrddXMSPNytWPoSzfKseYOucdSWnhMRm8PHf71YR2z3NzNNJqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818563; c=relaxed/simple;
	bh=Wd0jklAz9sn3f6mkOg5DeiNVYLZLXZEnLK81b5SblXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tu23rIjz/6ffhOKgWiOsbXtNk8bd3194ZCvr18NqsQhPTGKl2+1I8Bk+JbBHX3VRkWQLmVoVEsdNSdWQQqyRXbwMvjZOB0vanAdj4/vR5MvQv+ozkmctAeChVgB3wvYhQnkFSqt+hpw+fRkdKfz3BJRZVj4srxB2Jgurmpr+lcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kdKzorIv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L6Bx4Q018251;
	Wed, 21 May 2025 09:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bE8OyconUI1Mx/v1DBviJev4QnXuyDYn8LIZStUo4y4=; b=kdKzorIvAdCxUsxJ
	/suGxe8OyHwlmd4va1WUAgGpw2oivdSFYWqCygzkgzKqMkCXHd2q9+O1i4zYgZB2
	4mUJY+zAvM34fCHnkUaST6rBu7sGeP0+IRyACfW0a6EohgFMUM6ZXqk0BFE2590m
	sliR9X86W0QL8b2gChUphYsKFk1p0KJJSvebtX99oXnyZF6iAVLPKocgOCWzQ4fv
	sHKzbBNAaisutM3OyH8mieUYt3wPXtv64DDKBdUJosIyTG0jvxcu28lO0JmI63Wk
	lHNn0DmPU6mMObNb2FkKGFn+Ceepywhsc7xjxqs0yh39B4MacA5Eem95+nzfcQ73
	EJyh6A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9tavp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:09:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L99FjZ016020
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:09:16 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:09:14 -0700
Message-ID: <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
Date: Wed, 21 May 2025 14:39:11 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v9 3/3] wifi: mac80211: Set RTS threshold on
 per-radio basis
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20250429040048.3356960-1-quic_rdevanat@quicinc.com>
 <20250429040048.3356960-4-quic_rdevanat@quicinc.com>
 <e98a1b2791eaef6ec12ae2f9d9060cf6eca47d46.camel@sipsolutions.net>
 <3850d61a-8c6d-4cb5-b56b-d53a4a8afd32@quicinc.com>
 <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <6ae5c6bd10fd7eade50bba846a701ba5846bf811.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=V9990fni c=1 sm=1 tr=0 ts=682d983d cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=wxKnEZP9Z9EgkE9ldaEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: i6nI4EYksYXrWSs0mwUo0ajOrWGY7rva
X-Proofpoint-GUID: i6nI4EYksYXrWSs0mwUo0ajOrWGY7rva
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MCBTYWx0ZWRfX4IMa/glaXbsk
 jGAmZJs/yAjTKD+6Zu9GuYw0sMdLwht/I6ixeldH0/wV6eY+VypHTTt2v3+YJNxcp4FDgqkZzVn
 Fz3KVyNWA3I3KMU2uUgXHMxuLUaQRlWWhIJjpZyWOpBmODxnCNCaELM60/9or1hhvU5USmWHlpg
 csGNQAXB32d5XW0yT8C6Y9JGLHSe3d9uFBVFNY7EnQA4EvOhBiGLZOG4anStJxj4Ko74yh9JL5G
 50WI4EXNwdL+k2DZkw0hKME60JTdmaXjl9El8/0K9plUqSTo6iLDoxtnqvOlJmHMdwmO909dUrH
 nq/yEAtZw54Jky7dcQb4L72X6nErL6++CqIw99EZmj09cXfYEF9Xva0RkKI6fmkQnJCSLXkedph
 VJGDkq4bk8hnv8YAjF3A1Lp49V8TMQcDjc1tn7iZr5vOvO0dy2LFrUElQIiqfX1ZMldLPmxj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210090



On 5/21/2025 2:32 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 14:30 +0530, Roopni Devanathan wrote:
>>
>> On 5/21/2025 12:49 PM, Johannes Berg wrote:
>>> On Tue, 2025-04-29 at 09:30 +0530, Roopni Devanathan wrote:
>>>
>>>> +++ b/include/net/mac80211.h
>>>> @@ -4569,7 +4569,8 @@ struct ieee80211_ops {
>>>>  			    struct ieee80211_key_conf *key,
>>>>  			    struct ieee80211_key_seq *seq);
>>>>  	int (*set_frag_threshold)(struct ieee80211_hw *hw, u32 value);
>>>> -	int (*set_rts_threshold)(struct ieee80211_hw *hw, u32 value);
>>>> +	int (*set_rts_threshold)(struct ieee80211_hw *hw, u8 radio_id,
>>>> +				 u32 value);
>>>
>>> That should probably have documentation updates. And passing a negative
>>> value to a u8 seems awkward? Maybe that should just be 'int'? For a
>>> value that's likely passed in a register, u8 will probably require more
>>> (machine) code anyway.
>>>
>> The following snippet of code tests the value of radio_id in
>> nl80211_set_wiphy() in net/wireless/nl80211.c:
>> +		/* Radio idx is not expected for non-multi radio wiphy */
>> +		if (rdev->wiphy.n_radio <= 0)
>> +			return -EINVAL;
>>
>> This snippet returns an error if the radio_id is negative, so radio_id
>> passed to set_rts_threshold() will always be positive. So can we retain
>> u8 data type for radio_id?
> 
> I quote from the commit message:
> 
>> A value of NL80211_WIPHY_RADIO_ID_INVALID(-1) indicates radio index is not
>> mentioned and the configuration applies to all radio(s) of the wiphy.
> 
> So now something is at least _very_ confusing.
> 
I can rewrite the code to something like this:
 - Change the data type of radio_id to int.
 - NL80211_WIPHY_RADIO_ID_INVALID value assigned a -1.
 - Set RTS threshold for all radios when radio_id is -1.

Is this okay?

> johannes

