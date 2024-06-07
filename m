Return-Path: <linux-wireless+bounces-8659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D1A8FFB1F
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 07:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409C2B29349
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 04:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB7838D;
	Fri,  7 Jun 2024 04:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fhvndsuc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3621CA84
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 04:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736084; cv=none; b=d/6Bhl12HcAoxOwB9UnszRQ6u6sXuRA3jorOjQMRoOSuTOAkbSXl6YvwVBRVT0WVcs1MoiraBrCSfmvyvQLLykQoFyVm894+yOoDgUdHzeXDMG0KGUq6Ypjc8FbDvb5TFf7ofBxfynLKoM7PVCWgwIvUqaO6ywh0C8d5obSGmC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736084; c=relaxed/simple;
	bh=ogbih2B8j8djwFMCMRZpSIVAB+Kt3fpCZ738P6IZRPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CjHSsvB/VgHfZPTFS0vzus8QibDba+HxEbWHdMayQolKEKReXZgxALCvwVBkbDjbkboo9wIwgWk2bGx2d9Iy8Obfjc2dQ7bbfxqgh2qzFsbvClUwv2Bg3Y0f4bL+m1LrvNTjUnPk+887BQpBGvz/e/qClTjDDgtjpmDKt2FsvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fhvndsuc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456I1dAI030512;
	Fri, 7 Jun 2024 04:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kTDhFd+78pMcDuSu6yIkaJahSKZqTdviJjzyFbzHJdI=; b=Fhvndsuc6Hlzi7N/
	Td2k1bj6y6o0DhgFgOSioNlJ8v+SMr+b4Sc5hBtb4NYcZ6+hPKBQIuSHLuOEIxaF
	qAHDvLFlM3C5bPujjslmAT3dou5UEuUXRlrjlSt27H4SO7AjbAKJO5GX/NDLWSM0
	2yKDhGataeISgZX0eWYtaMuRlsopqbXcVztCjRmChIHToRTUZD8j5shlVGR6z9nH
	+4dK86+hxFG8eEPS5jGka+KoKVqh83j0ueQJq1qQpCHJlNly39eB8eNwhEsdKNQt
	LRTuBVTqZyrYvoHtIdneNf0UdfyZ7NYoeyAEbkXC9+S8KSe2u9RLMgtB1pBfsbf4
	eY3Z3g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk8tcadr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 04:54:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4574sXcG009855
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 04:54:33 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 21:54:31 -0700
Message-ID: <cdf2d06a-4d06-df69-245b-fc9ece0c1f2b@quicinc.com>
Date: Fri, 7 Jun 2024 10:24:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v3 4/8] wifi: mac80211: add support for DFS with multiple
 radios
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC: <johannes@sipsolutions.net>, <quic_adisi@quicinc.com>,
        <ath12k@lists.infradead.org>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <7cc3d89225f365c85b363874725cfbc77c9c1db5.1717696995.git-series.nbd@nbd.name>
 <2014e488-b930-43ff-86a6-c5a4801b82f5@quicinc.com>
 <21956735-3a04-4f29-8f13-0f84ed93cda2@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <21956735-3a04-4f29-8f13-0f84ed93cda2@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lRNKnO5T5doTfq00LqmXjlUKbfLytThQ
X-Proofpoint-GUID: lRNKnO5T5doTfq00LqmXjlUKbfLytThQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070033



On 6/7/2024 10:05 AM, Felix Fietkau wrote:
> On 07.06.24 06:25, Karthikeyan Periyasamy wrote:
>>
>>
>> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>>> DFS can be supported with multi-channel combinations, as long as each 
>>> DFS
>>> capable radio only supports one channel.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>> ---
>>>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>>>   1 file changed, 24 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>> index 40fbf397ce74..e9c4cf611e94 100644
>>> --- a/net/mac80211/main.c
>>> +++ b/net/mac80211/main.c
>>
>> ...
>>
>>>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>>>   {
>>>       struct ieee80211_local *local = hw_to_local(hw);
>>> @@ -1173,17 +1188,18 @@ int ieee80211_register_hw(struct ieee80211_hw 
>>> *hw)
>>>               if (comb->num_different_channels > 1)
>>>                   return -EINVAL;
>>>           }
>>> -    } else {
>>> -        /* DFS is not supported with multi-channel combinations yet */
>>> -        for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
>>> -            const struct ieee80211_iface_combination *comb;
>>> -
>>> -            comb = &local->hw.wiphy->iface_combinations[i];
>>> +    } else if (hw->wiphy->n_radio) {
>>> +        for (i = 0; i < hw->wiphy->n_radio; i++) {
>>> +            const struct wiphy_radio *radio = &hw->wiphy->radio[i];
>>> -            if (comb->radar_detect_widths &&
>>> -                comb->num_different_channels > 1)
>>> +            if 
>>> (!ieee80211_ifcomb_check_radar(radio->iface_combinations,
>>> +                              radio->n_iface_combinations))
>>>                   return -EINVAL;
>>>           }
>>> +    } else {
>>> +        if 
>>> (!ieee80211_ifcomb_check_radar(hw->wiphy->iface_combinations,
>>> +                          hw->wiphy->n_iface_combinations))
>>> +            return -EINVAL;
>>>       }
>>>       /* Only HW csum features are currently compatible with mac80211 */
>>
>> Are we omitting the "wiphy->iface_combinations" if the radio specific
>> iface combination advertised ?
>>
>> If so, it looks like unused "wiphy->iface_combinations" for radio
>> specific combination advertised.
> 
> This patch series assumes that you have both wiphy->iface_combinations 
> and radio->iface_combinations set. wiphy->iface_combinations applies to 
> the full wiphy, whereas radio->iface_combinations only applies to vifs 
> assigned to the radio.


If radio->iface_combinations is set then always vifs assigned to the 
radio. so wiphy->iface_combinations get avoid for all the use cases.

Ultimately either of one combination only get used by this proposal.

or I am missing something here ?


> 
> - Felix

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

