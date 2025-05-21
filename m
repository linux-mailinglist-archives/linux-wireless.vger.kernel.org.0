Return-Path: <linux-wireless+bounces-23210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0C2ABEF5D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C71116875C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7123BCF1;
	Wed, 21 May 2025 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A+Beyv2c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002923A9AB
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819042; cv=none; b=cecLREla5WlG54pAJ+yQFOJDwt5ku90v2ifKEyc+n0W4ltTieSMyG3FOcoysc9etClXsuOTghxVhaWryzMDvMU+Ka5GHALNuOHRR+cMiUtWpVVF67N0YRuTGY/2RAt1wyifVyaYe7AUqtljVbAOZWpDd4KdSgsBA0AdXznS1OPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819042; c=relaxed/simple;
	bh=HzwE6NbvlvS6pKLXBzw072QM9/kfrDQrzePT3jWL14k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KwYsiy800NF6OMUP7XWidx/z4ikqb55EnGxqu+tF1anKZz5/ViHY9PJu+EzeY5R4+JjOoVKa9TYUx/ZDH5vHeZ066IhSseNZdvIfBqv6RG9rhcPyH/fwfKvmCGeYk4wMeJabs/xWZYCVUPfq+NytVGRebykWCLoMek1mHvG8zeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A+Beyv2c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L6QjDS000710;
	Wed, 21 May 2025 09:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f4Bc1/gGYWUn99TNJYCBE3+L/XjXshO5uiq4pGqqJM0=; b=A+Beyv2csfxLC8js
	yozeeU/WO7IlKWkYeX39+APkDGXu4bH/5AvdV06+/1Sf6lw/WZbCdvuEAjM2d8Sg
	0JrsKiDwkStjTiI8UHiEAAT+j5bWkKu8FveYs2XLLkqr0XMqbzKAA1nlOTkKGDyD
	Z7jgq3kuaL9TJphjPi7wrq1FnV9bHhzaAlIiO1SJ0ZFzm50k65Uxo/MLwLtynzFu
	/1hm6MJmAGhT6YIhH5rK1S5OlbsRFRAT7aL0s8zjW0/tHvM75AmOy5dqIPDF3+Iw
	KZdsOXoMfUmv+XCdsWq7PHcpRJWwnA3+8nBPHOM8rsgx1dD0toTd1JqoD4f6KLSn
	sDjKKw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf4tadm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:17:16 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L9HFYg018015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:17:15 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:17:14 -0700
Message-ID: <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
Date: Wed, 21 May 2025 14:47:11 +0530
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
 <6c4fd852-c70a-4d7e-ac34-3a7f375b98ab@quicinc.com>
 <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <78e46648e8bbaec139df2a3d11a2408fe5973afb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JTRPbBG7AxVPQo55lz2W3sTOuYgtsZX2
X-Proofpoint-ORIG-GUID: JTRPbBG7AxVPQo55lz2W3sTOuYgtsZX2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MSBTYWx0ZWRfX5KFxRbqpDSRw
 EiCVgvwJrZAzQMTEiU/A0UDrMa5Ej3OuRugpvBqMdAzwqxRkeoPm0e5yOfq/0jOuKynHah29LVS
 lJzCqClLBVvanKTonxehbb/O838IC+127MkrGd/Zo+0mpZ0r8dSzO5mDhKAOaR180GRrAmXDMoE
 Wn/Eh4MHeSCf1apIM5uEPL//2wS9FTpWNW/WUvo+lR2r3VrL7BXG4y1iArJl2jZPVpwc7nsVA9W
 ozexliJs4AL+NriTK5PsHl1B7zUiKOYZxVH6BepCGjn/AeqQmggPZJknke5GhSNx8b3tnAlO+xS
 zaCsQD79VPe3iOJ9MJm+Hiz9BppbYt6WvabwxLWku+gOd0m5113dmC+AgQUl5raoYYp8TqNabkK
 GSbnyxgPAXaod7LmfMPgtL7HQXHn/WTAdLBcqtI/vh+30SYy+Nfjbblh+8m37CJQW87mwwJy
X-Authority-Analysis: v=2.4 cv=R7UDGcRX c=1 sm=1 tr=0 ts=682d9a1c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=qsG7e4QrYeFphVZwBk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210091



On 5/21/2025 2:40 PM, Johannes Berg wrote:
>>>>>
>>>> The following snippet of code tests the value of radio_id in
>>>> nl80211_set_wiphy() in net/wireless/nl80211.c:
>>>> +		/* Radio idx is not expected for non-multi radio wiphy */
>>>> +		if (rdev->wiphy.n_radio <= 0)
>>>> +			return -EINVAL;
>>>>
>>>> This snippet returns an error if the radio_id is negative, so radio_id
>>>> passed to set_rts_threshold() will always be positive. So can we retain
>>>> u8 data type for radio_id?
>>>
>>> I quote from the commit message:
>>>
>>>> A value of NL80211_WIPHY_RADIO_ID_INVALID(-1) indicates radio index is not
>>>> mentioned and the configuration applies to all radio(s) of the wiphy.
>>>
>>> So now something is at least _very_ confusing.
>>>
>> I can rewrite the code to something like this:
>>  - Change the data type of radio_id to int.
>>  - NL80211_WIPHY_RADIO_ID_INVALID value assigned a -1.
>>  - Set RTS threshold for all radios when radio_id is -1.
>>
>> Is this okay?
> 
> I honestly thought the last two items were already the case?
> 
Yes those were the case. The history goes back to v6 of the patch series.
Quoting your comment:
"And why should the attribute even be signed, when you explicitly reject
negative values anyway? Seems like it should simply be unsigned?"

So I came under the impression that it would be better to change the radio_id
datatype to u8, instead. Now with this, (u8)-1 would give 255 and when driver
changes come in, I was planning on checking if 
	radio_id >= wiphy->n_radios
If this condition returns true, I was planning on setting RTS threshold to all
radios in the wiphy.

> johannes

