Return-Path: <linux-wireless+bounces-23212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68674ABEFB3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BFB7AF2C7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A1923BCF1;
	Wed, 21 May 2025 09:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D1RN42Vy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143A323D2B1
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819511; cv=none; b=iGiodGGuinYKZKjAd1qwc5fePesgvugFgQ2UbZ2nYZ2G3TjwRuk6TU8WhB5x7Tkb77hyUK6oY1gnfaQYbON3KOOUHcp7BMQ35wNVQC3t3R6RXCP/YpqMW1nyiuQaCnq74WUxsVvnTCFDevU4niyvRlU3Bf6g279l754UQq3qoUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819511; c=relaxed/simple;
	bh=S42wfXSj6bh/JyDz+eVnWsMqhTbdacVp9MwAa9uduhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JcVRFUIn4qRfjdVsQ/ixxj4TpR+J+PNoGCh3L7mMkANrc3S1WYYfOzxn9Cuv4RXUQNrijuBuexaGOZ8Sr/lTOUw9fyAxT+/GqYOlfp7/pYPMv2bbQXYQiviD1b01ORr6HERu4ZEuoDDiumGkLHMz91YWs7GEN0KwTsdDnOHi+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D1RN42Vy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L555pd004211;
	Wed, 21 May 2025 09:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KdtHjt2xMNLXfox91ZFU2c+d04VGT9xmRYa21DYkDqg=; b=D1RN42VysWDpFgVm
	X2QTzazxAqZ+AV8/ct5i+5rx2/qJ6hz1XL0HB9FcIV+kGyGMz8ePHpMjnxdsqcOz
	KwutKct5S0nY2j84yooR99I+7gPyJwak4TqM5PIAMuCZN050krfdaylr+sy9DaCK
	nLtopeJOHI3MVB2kBvu4hnwPrax2EZAqvrzpKuJ1NJAlueKxLH/JBxYrXaQD7S76
	PlrPXEQulrBS7K3ENs32O2szFcrNYiwzg6Qx6ei1UxvkEJni8WbYh8VSB2gLZJwz
	6NbJnbp7RBlQqYE5dPouZGdf3+GzeJOzgDi0JNKVdRHSMEWhH3OeR5qs75e/WQ4Q
	NAv8gA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46s8c20v0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:25:05 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L9P5pj032606
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:25:05 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:25:03 -0700
Message-ID: <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
Date: Wed, 21 May 2025 14:55:00 +0530
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
 <694e3a16-c2d9-41b1-8f6f-033c6b1ef0f3@quicinc.com>
 <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <157dd058a06a2f111c52459610b0de7057a5d557.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5MiBTYWx0ZWRfX0Z83bx2ynFLE
 WKpkgPoRQ+BoXCAaU7J0Y2nUPWOWN8BJpsJZkJ7Xu6phpNAJWTiMMX+MOJ12cA+VLzcddBxSnh2
 vf9OtIBASbrU27AWiKmyTqE0OVluWbO2y3NrmkJkPeqlBdcbWKVb/0KLqIPV5oAiPkFIUBvtSt+
 6usQuTFrX+ocVdRhQCCWe7OrlsemR/q9bjYBe0co2mUMSdPtaDr4m10wgcexzm+l2uLApSuFC6N
 Lw3bbpyLNr1NGDh/1cRk9oW9HB50D4H3w5/S08nKqpDs0x4AzClN45cGN1sW6S71qIv13qzXwiL
 CdoM1HdPFBty7erpOOcXuBvADarcU6qa6kMiXA1gXk8YhcWQNF4lDRGAC3cOD3pDPkzseqolpJI
 c4BRh33ZwKQiDFaHB/JEBqX0Kh/cOqn03bBaXlCJgfXybCP0y/2YyrWyxGcMuZp96tOdM1Fe
X-Authority-Analysis: v=2.4 cv=RIuzH5i+ c=1 sm=1 tr=0 ts=682d9bf1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=VvPvm9HhRoyCpAQvwu8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: YnTWS5WQktL3RcQNHEHx85snjGUMf4lX
X-Proofpoint-GUID: YnTWS5WQktL3RcQNHEHx85snjGUMf4lX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=859 spamscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210092



On 5/21/2025 2:50 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 14:47 +0530, Roopni Devanathan wrote:
>>>
>> Yes those were the case. The history goes back to v6 of the patch series.
>> Quoting your comment:
>> "And why should the attribute even be signed, when you explicitly reject
>> negative values anyway? Seems like it should simply be unsigned?"
> 
> Well that was regarding the _attribute_, you had that as NLA_S8 at that
> point.
> 
>> So I came under the impression that it would be better to change the radio_id
>> datatype to u8, instead.
> 
> Oh, well, I didn't really mean to give that impression.
> 
> In the userspace API we have an attribute that can be in [0, n_radios-1]
> or unspecified if no specific radio is intended, which is how it'll work
> with existing userspace anyway.
> 
> In the internal APIs, using -1 with a properly signed value seems
> better, since we don't have the option of "not specifying" an integer.
> 
Now, I get your picture, thanks for explaining.

>> Now with this, (u8)-1 would give 255 and when driver
>> changes come in, I was planning on checking if 
>> 	radio_id >= wiphy->n_radios
>> If this condition returns true, I was planning on setting RTS threshold to all
>> radios in the wiphy.
> 
> That seems pretty odd, -1 for an invalid value is much easier to handle?
>
I think so, too. As mentioned already, I can change the datatype of radio_id to
int, retain the NL80211_WIPHY_RADIO_ID_INVALID value at -1. This would mean that
passing default value to individual drivers will set RTS threshold to all the radios
in a wiphy, or it will be the case of single wiphy architecture.

I hope this change will be sound and standing?
 
> johannes

