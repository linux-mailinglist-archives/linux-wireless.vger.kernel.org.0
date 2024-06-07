Return-Path: <linux-wireless+bounces-8662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0B58FFC64
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 08:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0DF21C23DE8
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606F011CAB;
	Fri,  7 Jun 2024 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BDQ4o+jP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C7B9443
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 06:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742743; cv=none; b=Aoj8M0/8OdnKZJhPmpjkpSGKHmNUhdoknK6pWDZt3UmkVse6Rr6+MvrpmMPtvZmGbWI9OVAOK5QuYq9va+aGpsdoNtZXg2Ywf+Ncz0nS6jyZ/dvNoYMWDQ2BRJ4yE1pceA5Jxwrkgus/jWD64Iw01r1cDHtlkV5zZZJe7ISHsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742743; c=relaxed/simple;
	bh=hJYZWZuTlRNjkRHTOKhuEzEEPqX8KWgLs4HBuOn8+e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pa9IFKLS7na00qItwNUB/qbp21eeweFxQ08AxZxz9JZMy9EltRYvyPzFrPXD1774xG4yzoj/5EEAKB7enk0yK20uN9MQm1lETBZUfdDwEM9oBcqLUFSalHRxFUtXSNJo4OpOTJFC7zmBttyJgO9z8/q0lEcVkXy0cG5mxOrsTpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BDQ4o+jP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4574iQmD009744;
	Fri, 7 Jun 2024 06:45:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q7ffYYgLvNY1C+roSNt5o8PywPtnU5+WPqjtwVn40TU=; b=BDQ4o+jPoiSs8s30
	fzWNKJay6gJgj0K3omWDinLwc4lzk7hYnb1uJVeeiiIejrPTq+qk0nKWWGt3+OwP
	drkJEqSSpD50pePVkDbrd7NeaP5zpj6R4RLNsdD87nVnDxDdawhz3cuOftLT4n/C
	QFo3g/PWWoT7ndGDczEW1QCghQE6iypoUWNAft5E7ZrRgHdCbt3NlLjilUWbjtPr
	S00SsiPd7GxsjskDricP63S5U2DqcncEbQCPay09FMP8JuWwt7BegIdQ/bCE33t/
	UbIoDk+XF9nTP3fQgpV3xb7pObjrmGKZp7VVhX/1QsH9XlEOYvQdrZY0klqeLcPy
	7bIX1A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rpqkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 06:45:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4576jVY1023278
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 06:45:31 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 23:45:27 -0700
Message-ID: <6704d2ba-8ac8-cd33-9d3b-95dae2613d9f@quicinc.com>
Date: Fri, 7 Jun 2024 12:15:24 +0530
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
 <cdf2d06a-4d06-df69-245b-fc9ece0c1f2b@quicinc.com>
 <da6038ed-87f8-40ec-a327-6065334097af@nbd.name>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <da6038ed-87f8-40ec-a327-6065334097af@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ywB99utMr4VU-DB9pksoKAaoA2vu_dZ
X-Proofpoint-ORIG-GUID: 7ywB99utMr4VU-DB9pksoKAaoA2vu_dZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=962 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070046



On 6/7/2024 10:33 AM, Felix Fietkau wrote:
> On 07.06.24 06:54, Karthikeyan Periyasamy wrote:
>>
>>
>> On 6/7/2024 10:05 AM, Felix Fietkau wrote:
>>> On 07.06.24 06:25, Karthikeyan Periyasamy wrote:
>>>>
>>>>
>>>> On 6/6/2024 11:37 PM, Felix Fietkau wrote:
>>>>> DFS can be supported with multi-channel combinations, as long as 
>>>>> each DFS
>>>>> capable radio only supports one channel.
>>>>>
>>>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>>>> ---
>>>>>   net/mac80211/main.c | 32 ++++++++++++++++++++++++--------
>>>>>   1 file changed, 24 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
>>>>> index 40fbf397ce74..e9c4cf611e94 100644
>>>>> --- a/net/mac80211/main.c
>>>>> +++ b/net/mac80211/main.c
>>>>
>>>> ...
>>>>
>>>>>   int ieee80211_register_hw(struct ieee80211_hw *hw)
>>>>>   {
>>>>>       struct ieee80211_local *local = hw_to_local(hw);
>>>>> @@ -1173,17 +1188,18 @@ int ieee80211_register_hw(struct 
>>>>> ieee80211_hw *hw)
>>>>>               if (comb->num_different_channels > 1)
>>>>>                   return -EINVAL;
>>>>>           }
>>>>> -    } else {
>>>>> -        /* DFS is not supported with multi-channel combinations 
>>>>> yet */
>>>>> -        for (i = 0; i < local->hw.wiphy->n_iface_combinations; i++) {
>>>>> -            const struct ieee80211_iface_combination *comb;
>>>>> -
>>>>> -            comb = &local->hw.wiphy->iface_combinations[i];
>>>>> +    } else if (hw->wiphy->n_radio) {
>>>>> +        for (i = 0; i < hw->wiphy->n_radio; i++) {
>>>>> +            const struct wiphy_radio *radio = &hw->wiphy->radio[i];
>>>>> -            if (comb->radar_detect_widths &&
>>>>> -                comb->num_different_channels > 1)
>>>>> +            if 
>>>>> (!ieee80211_ifcomb_check_radar(radio->iface_combinations,
>>>>> +                              radio->n_iface_combinations))
>>>>>                   return -EINVAL;
>>>>>           }
>>>>> +    } else {
>>>>> +        if 
>>>>> (!ieee80211_ifcomb_check_radar(hw->wiphy->iface_combinations,
>>>>> +                          hw->wiphy->n_iface_combinations))
>>>>> +            return -EINVAL;
>>>>>       }
>>>>>       /* Only HW csum features are currently compatible with 
>>>>> mac80211 */
>>>>
>>>> Are we omitting the "wiphy->iface_combinations" if the radio specific
>>>> iface combination advertised ?
>>>>
>>>> If so, it looks like unused "wiphy->iface_combinations" for radio
>>>> specific combination advertised.
>>>
>>> This patch series assumes that you have both 
>>> wiphy->iface_combinations and radio->iface_combinations set. 
>>> wiphy->iface_combinations applies to the full wiphy, whereas 
>>> radio->iface_combinations only applies to vifs assigned to the radio.
>>
>>
>> If radio->iface_combinations is set then always vifs assigned to the
>> radio. so wiphy->iface_combinations get avoid for all the use cases.
>>
>> Ultimately either of one combination only get used by this proposal.
>>
>> or I am missing something here ?
> 
> The functions that perform interface combination checks are called both 
> with -1 as radio_idx (meaning per-wiphy), as well as with the assigned 
> radio id. That way, both kinds of combinations/limits are checked and 
> enforced.
> 
In the radio specific iface advertisement, global iface combination 
represent the union or intersection of all radio iface combination ?

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

