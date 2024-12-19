Return-Path: <linux-wireless+bounces-16604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A79F7AD9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2595163937
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB062236EB;
	Thu, 19 Dec 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T6BNdP6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951BE222D50
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734609586; cv=none; b=Vbk2X1hWR38e84uLRNTP7o41AHoKtzOrvR/bwDMs9IBm7ILR7O71C4atNuT7Nlkr0wMKHDd5j59ZipYKPnNL1R+NyEjLeNZRaNuLQg+GGF3Aqv531w3BFvtPsxezBhXjHKivd/NGWGI/sw4f1qkn01lyn0ETNlRvOj1+MfV3SGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734609586; c=relaxed/simple;
	bh=epSuMI+Sm0Ljnwg04M9Y2UQ+qgvv1+ZcexjMCm5M8Q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Um6zEQJdZ9Z5SiVrtgyrf45faqRaBr5PfW8uHzmQ5wmLDOHUpGYLYaQMnEdVzNyd5wRumSj81NKZjbsYs3aI8TF8+IR+eWEu7XXSPDWsgM8V0HlnalXCP3bYcuBWkzsv8pcgVv+4lzMT4eR90DB2lOk+da8lVj5FU7kS6GuFFHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T6BNdP6M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJ9geqB008376;
	Thu, 19 Dec 2024 11:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V0vgtMs0niTamg0G1VYVksVC/vgjHmv9V+T6uAJZAO4=; b=T6BNdP6MsvhLiel2
	YSjQl+ufpCaYa3ZtNIATOWjTEx9TLVrBZkYnC3RYo1vq/3kM5632wjhYZcdWuiz/
	TueIVX3FEK9nYKlI6EMlTI5J3Mn7OZal5wFGyQQUXLIZrceJPtup6v8LABEMlAoO
	h74rPVK+GQScqUL89G7PYKWLR8JboWKOlgeDVVx7yRdXwTtTZhGGDTOW5tDNQIXU
	/gsnrUplf0Y+l/n6+Pq+txQ3pTd4agqspL1NU68cj52+72gy8ou4HljpVM21Ywl0
	Jvn30m5lhswXtGsJw/eDOQYe/RzVS8EZE5mmBxTVKtWXF3TwrxkvK0LDZcNpSu7H
	INO/WA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mh3hgasb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 11:59:40 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJBxd6X004867
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 11:59:39 GMT
Received: from [10.206.111.90] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 19 Dec
 2024 03:59:37 -0800
Message-ID: <19e73db4-921a-4ccb-8f31-0c9a960933af@quicinc.com>
Date: Thu, 19 Dec 2024 17:29:34 +0530
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
 <b4c7a1b1-86cf-4c06-b7ee-21f2f6333dec@quicinc.com>
 <81f864e1fcc1c226763273dec915e43f1fe14f5f.camel@sipsolutions.net>
 <bfe298e3-c096-4426-a948-c4a67a5b8db0@quicinc.com>
 <91fc1c1717646a8562ac2a74c4e2d9928a145171.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <quic_kkavita@quicinc.com>
In-Reply-To: <91fc1c1717646a8562ac2a74c4e2d9928a145171.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: arzGt7wufngKyVUXdXaOKxQlanR8MuOn
X-Proofpoint-GUID: arzGt7wufngKyVUXdXaOKxQlanR8MuOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=859 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190095



On 12/19/2024 4:29 PM, Johannes Berg wrote:
> On Thu, 2024-12-19 at 16:27 +0530, Kavita Kavita wrote:
>>
>> On 12/19/2024 2:31 PM, Johannes Berg wrote:
>>> On Thu, 2024-12-19 at 11:35 +0530, Kavita Kavita wrote:
>>>>
>>>> The for_each_subchan() macro will not work for this. When sub channel is
>>>> null, it will terminate the loop, but in this case, we should continue
>>>> checking other sub channels.
>>>
>>> Wait, I'm confused by what you're saying here. The for_each_subchan()
>>> macro should iterate over all enabled (not punctured) subchannels, so
>>> why would it not be applicable here?
>>>
>>
>> So, In the following regulatory checks: cfg80211_get_chans_dfs_required,
>> cfg80211_get_chans_dfs_usable, cfg80211_get_chans_dfs_available, and so on.
>>
>> When iterating over primary or secondary bandwidth, if we encounter any
>> null subchannel,
> 
> What do you mean by "null subchannel"?

For example,

Please refer below Implementation of cfg80211_get_chans_dfs_required:

for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
	c = ieee80211_get_channel_khz(wiphy, freq);
	if (!c)
		return -EINVAL;

I handled this above "if" case within the macro itself, so when this 
case occurs, the loop terminates and does not check further subchannels.

Now, please refer below Implementation of cfg80211_set_chans_dfs_state:

for (freq = center_freq - bandwidth/2 + 10;
	freq <= center_freq + bandwidth/2 - 10;
	freq += 20) {
	c = ieee80211_get_channel(wiphy, freq);
	if (!c || !(c->flags & IEEE80211_CHAN_RADAR))
		continue;

However, for cfg80211_set_chans_dfs_state, we should iterate over all 
subchannels, even if any subchannel is null or radar detected.

That is why I haven't used the for_each_subchan macro for 
cfg80211_set_chans_dfs_state.

I will fix this in the updated patch to make the for_each_subchan macro 
applicable for all.

> 
> In all of these cases, if you have e.g. the following 320 MHz channel,
> where "x" indicates removed by puncturing:
> 
> | | | | | | | | | | | | |x|x| | |
> 
> then of course it should iterate over all the non-removed 14
> subchannels, not just the first 12?
> 

Yes, You are correct. The for_each_subchan macro will check all the 14 
non-punctured subchannels.

>> the loop will terminate, and we will not check the
>> remaining subchannels.
> 
> As you write it here, that seems wrong for all cases?
> 
> johannes


