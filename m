Return-Path: <linux-wireless+bounces-23218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F8ABF08D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A93BADD1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8120423815C;
	Wed, 21 May 2025 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bfcsi1nL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD9D2356A0
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747821466; cv=none; b=pHs82SWFVnPJz0BeoC8nG/4AbhnCXRNfsioms5BWdhPuRrsT6RCNqYsX5CMurAoNTLm7SoqFt+lpB5Msk+rGieDF0n8TkTGw0a2Uwb0fdfirc1tkgb4xXswp1Ye620jDoV5/3R2NfZaT6YwUBoZ9MZbi7O4TPie6IHdOzEgwzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747821466; c=relaxed/simple;
	bh=yRQ2A3fHY6tifpI8jLtGb3v9ZsRl18zjx3W6yO7hDGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=od7+oeEtXEnkHX1YmrsAW9GUTHU9nM/6JXCTwIOmqmG2mfEm1/eYnob+EIKsx/qa5AfObUX4+ulbP+rb2LYKpVYm0TnbM0GN6/+/GpTKCODhWEpyr8rO3LMeDzPDN2IE1KdM6zfq4fQXyXECEfEJj5XDk/pj5Xwiq/FAIr5HO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bfcsi1nL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XKVR027606;
	Wed, 21 May 2025 09:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IvnT2ton/HqmZjZY/fxY5Ea70pUMorSfIJW9RhuNS88=; b=Bfcsi1nLiFIovc+v
	LJCnlfgFH4Y3dWiBDmIqfCK9jiV702HJXenAl6aot0qCk15lJU0Hw0c9brhYLlhg
	55fqaBSOm5q+Q9s0PSrIXrWL6c5Q8jH4KObCS+ljoZ4il7lqPqaK9CId9CQWz9Jt
	tMQ4A3Qw7B80RYZgri/CtyQWjafG2s+Oa9ZVqugYbrpBBPHZpcoS7mLZYAObUpgW
	ZoLS0p2jPlHZZXKcZtkIcyE/ymc92mM0jmalbEPtGqt46cPND2drRqBDToTFi41G
	iL+Mg9Cw0W0DZNw8XfbwpX9F1xb0uTIpfP+ylPV200QERY/QjF+Rt/O05BShjMBK
	TR1t3g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9af1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:57:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L9vd1i032600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:57:39 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:57:38 -0700
Message-ID: <aab47e6a-7b45-43db-a4ba-f2372e27a946@quicinc.com>
Date: Wed, 21 May 2025 15:27:35 +0530
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
 <c2c54fbf-c9d5-4a4c-982c-dfcd5b6d9624@quicinc.com>
 <4c9a74c436bd14b49fc9a15e7f9c68cb446baa84.camel@sipsolutions.net>
 <5ea169b9-8f63-46b7-8f48-40d8caf97ac4@quicinc.com>
 <6341cc8198b7054f9242821d8a7db2d2f12b92eb.camel@sipsolutions.net>
 <beae7cfb-03cf-496d-94b8-45425b1aa44c@quicinc.com>
 <4825b1cf6d59570d9bb3f03b500023bc2574c19d.camel@sipsolutions.net>
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <4825b1cf6d59570d9bb3f03b500023bc2574c19d.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qilzB5qLgQQa2361oFrfvRZBgNq9lj43
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5OCBTYWx0ZWRfXwP/HBUkbhaAm
 xpaYaIVpiL5F7Y2C5lAZUZ/vxbWZFAY/Lk1/0eMwncmZBeOdoSAkbjdo7/1hoObTJKtvgcJHAo1
 4lCU5xXmTGDOgfAwAIIAcv5AQ/cwTqE3c66u1uipooOXT252VUDAP3Xhqc4K9FAVg+V5mRMeYxP
 9wechEVyIRmKKxDyt5TKDFz2P2gKQzSbDbAvQb7+zaVxYns2kSrkFmBfBZCbNpcrfiF4BGLvrY4
 oM6dWEnpFs7kRpQ0BdLNJGjhFm8rZu/TL6mvrMDFDUTXrQp8hLNGIoSo9ZFANgiWEcoUmQAOWLO
 M/WjgCZ+7pgTQMmqsUS2qtyxx3b5Xv/f7anXY4vIbK2aD+ALNLX6MuxoFQG4VxmzDLHhIpBhDNM
 6R/7TqOaroncAJtSoNCbBGeLRifrL2u9uXIJ+QBuRERs35JrDaKv+33k7HCPFl1lGTDglxd2
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682da394 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=Cwe70lL3fS-SdrdfAkQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: qilzB5qLgQQa2361oFrfvRZBgNq9lj43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=834 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210098



On 5/21/2025 3:22 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 15:03 +0530, Roopni Devanathan wrote:
>>>
>>> The internal "all radios" (and otherwise invalid) value is _never_ part
>>> of the API. Quoting myself:
>>>
>>>> In the userspace API we have an attribute that can be in [0, n_radios-1]
>>>> or unspecified if no specific radio is intended, which is how it'll work
>>>> with existing userspace anyway.
>>>
>>> So no, regardless of the value (and I still think -1 is better), this
>>> define simply doesn't belong to the nl80211 API.
>>>
>> I am not sure where to define NL80211_WIPHY_RADIO_ID_DEFAULT other than in nl80211.
>> Can you point out to your expectation?
> 
> There are different APIs involved, right? Externally, nl80211, which
> doesn't know about this. Internally, cfg80211 and mac80211, though it
> stands to reason that since they're necessarily layered, mac80211 API
> can (and does) use cfg80211 definitions a lot - but of course not the
> other way around.
> 
> I'm not even sure we really _need_ such a define, we probably have a lot
> of places that just hardcode -1 (e.g. invalid link), but if you want
> one, given the above, it would live in cfg80211, right?
> 
Okay, understood. If I can directly assign -1 as default value to radio_id,
then I can cut down this definition entirely. I can re-write radio_id
declaration in nl80211_set_wiphy() as:
	s8 radio_id = -1;
instead of 
	u8 radio_id = NL80211_WIPHY_RADIO_ID_DEFAULT;

This will solve the whole problem. Is that alright?

> johannes

