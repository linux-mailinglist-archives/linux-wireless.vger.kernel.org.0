Return-Path: <linux-wireless+bounces-23216-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7377ABEFFC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 11:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96757A3789
	for <lists+linux-wireless@lfdr.de>; Wed, 21 May 2025 09:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9984248F42;
	Wed, 21 May 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J0CYbGx8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E024886A
	for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820050; cv=none; b=HWWmBcPfgnHAFU0V3TM9AQivtl5R5pGak9HI4y/73bhSTleDMslU7+W98gKlTYE53TFuf1zwIHjSdv/tgNfmJ1NF+yqZmNI2HjeEx0mnRf7igttiIG2xYFfRtQ0e8QJy0Y+tixGWBm78UuaVEnswBbVXPkR9TPMCA+ovmcrYDNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820050; c=relaxed/simple;
	bh=Is1C6HvUe0HAzOfmMx8VRU/rIV/9dxevyeDuhp6Zm80=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wox7tSnWdsPO3+sDZB56VO4K/g7r4e146Htz0gjDhuQlEFJkd0+DmvNgpL4tiEG8gdQ7i3RTz+i5HGUAj4kg4bIODXCpWG4adbzwYzvlaIhxATBRPXBax3fMCBwVqb4JjPSwgVkGRuumT97rrEaHNhvwK0Ug6ZtMB9McwnOLhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J0CYbGx8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9XWkO027677;
	Wed, 21 May 2025 09:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2+2A8gregE/qkq9dc6XbdUcO3n6Bic7JweyCnxFCWmI=; b=J0CYbGx8jUJajnrG
	UKV1UE5DQyqBTC07vifmh6jxcTG3jrgNQFqFn6KrKjurogkMR+hVtdtRENJpklHh
	gtJ27p7qFxb7+Plf/6zPuS1s1orXanggoXFiiEkTzYvlK7YLThwjAAkQWkGsDcLH
	+y7tiUSXEEoMA/LTC+iHV68mY6nLMq617C7ZjY8UHqwTDCljSsTxX+DMbQjjXPS3
	1GZ04mH6IvaF39mDPHrxvjHSFv8U3zZSAfvoHtZEWJMe9+GTvaEhsbORx3px2/mT
	sO6HFxF5J/0Cr+CFlKlLt5b3yZP55m+ctHUEltnKkbw+6mJwp1QZ79ncT4k25UjP
	4RE4YA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf9ad0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:34:04 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54L9Y3hu004450
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 09:34:03 GMT
Received: from [10.50.1.145] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 21 May
 2025 02:34:01 -0700
Message-ID: <beae7cfb-03cf-496d-94b8-45425b1aa44c@quicinc.com>
Date: Wed, 21 May 2025 15:03:58 +0530
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
Content-Language: en-US
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
In-Reply-To: <6341cc8198b7054f9242821d8a7db2d2f12b92eb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nTNTweAojlZfz1fff4IryYjFYlk709He
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA5NCBTYWx0ZWRfXwXWwd1PLHubz
 +5VEYLijjqeCTJAlOUvtzM14+sG7RtBAoBsEeuy1+FUsWoW9kl690w3JwAuhb4jm4UAt9eohWes
 jY1IdgZ8Em9wTgIrrI9K2TUJgk61rPG9stJPkUOXMZiBJsiA9varfQJDuILVmbZiBTHLT3AJEn3
 9k+P43SGALy2AiQuPkmLtjCNzrz0nUL24ZoOej9jseF8Wj90tnhnyytTdZfwW+e+gplD7dYHPN3
 8iRz6aKuR/F1gp2sovQv/fkrJ+sKuHIHrE4D2V88lcMoXtNWnYkIy/BIrD+ZlF9YcC5uVRah/Fl
 FJJaByM+TKU8pK9JIMRy6a2jrqxSnZISZBXHB8taf7BXJEYTKlXGrQ7hQWxwDMsxfLjofGABQFZ
 XAv/f1TyEJ4dTcd7s7uZswlOueJYWInfo0MscVqrhHG8OmczQmhcAvEGIOuVoEpz+2rpNZrS
X-Authority-Analysis: v=2.4 cv=GawXnRXL c=1 sm=1 tr=0 ts=682d9e0c cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=MAicmmMvh9-ox_7n7JUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nTNTweAojlZfz1fff4IryYjFYlk709He
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=861 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505210094



On 5/21/2025 3:00 PM, Johannes Berg wrote:
> On Wed, 2025-05-21 at 14:58 +0530, Roopni Devanathan wrote:
>>
>> On 5/21/2025 2:56 PM, Johannes Berg wrote:
>>> On Wed, 2025-05-21 at 14:55 +0530, Roopni Devanathan wrote:
>>>>
>>>> I think so, too. As mentioned already, I can change the datatype of radio_id to
>>>> int, retain the NL80211_WIPHY_RADIO_ID_INVALID value at -1. This would mean that
>>>> passing default value to individual drivers will set RTS threshold to all the radios
>>>> in a wiphy, or it will be the case of single wiphy architecture.
>>>>
>>>> I hope this change will be sound and standing?
>>>
>>> Right, that sounds good. Except it still shouldn't be
>>> NL80211_WIPHY_RADIO_ID_INVALID since negative values are not part of the
>>> nl80211 API :)
>>>
>> So, why not, we give a value of 255 to NL80211_WIPHY_RADIO_ID_DEFAULT? Then, we can
>> retain u8 datatype of radio_id.
> 
> The internal "all radios" (and otherwise invalid) value is _never_ part
> of the API. Quoting myself:
> 
>> In the userspace API we have an attribute that can be in [0, n_radios-1]
>> or unspecified if no specific radio is intended, which is how it'll work
>> with existing userspace anyway.
> 
> So no, regardless of the value (and I still think -1 is better), this
> define simply doesn't belong to the nl80211 API.
> 
I am not sure where to define NL80211_WIPHY_RADIO_ID_DEFAULT other than in nl80211.
Can you point out to your expectation?

> johannes

