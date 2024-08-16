Return-Path: <linux-wireless+bounces-11579-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5A9551B9
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 22:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717C11C21C1F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7491C3F30;
	Fri, 16 Aug 2024 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N+5+CEmj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7EE76F17;
	Fri, 16 Aug 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723838721; cv=none; b=qwUMj+LyIN9gKf5ht/k5gLh77XS5gQYJB76ldQabr57e/Hgur2YbjbmQv6l3X3Rflc5P9agva4ueF/CYaZSK16RoJ+GeD07w/LunEHdYjS6ETH0lxr6AVA0wmxKmAEHVHxdOWgZwfocykMOVITR+RCznpE6861fyqJk03wph5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723838721; c=relaxed/simple;
	bh=GlKxNSMgbl91XolYK+EIIYy+og6rT7ZOWu5Z7F0XZrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TZNN5eh7EO0Rh5iOYkyURPMfaqTZZnJch2RzIA92Aa+PH3Eehsbp0rq+XvNRWkl1iJO8Urqk0BkbBbvO1fmwHbNRZxcGbvIUmIeJevvk8M5VFa7xkM4o2yz0qgClkrAvFlvao7F8SclIwX4LJmF/PptATjbv+pyc2lRr8eRsdp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N+5+CEmj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GJLDe5014300;
	Fri, 16 Aug 2024 20:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zumYrx7GCPfW+NSzh9T5B1KAwrQlAfo5I6Ma+iDwAIA=; b=N+5+CEmjmttHttGW
	EEnOl3ic+nSKujYTChocQ8K95BKIpKkMzHa8jQYi7tPonggQuwVMPPKdJlbGnQXl
	0UEbPoL2Ba6d3W6pPO3cf7TEgrqRsN8fuU640igDpRKYitb91JrimWxo2jWI9sd8
	/w1o63eXUgqD9wir0vHGR34jBpgCz6HqmV1JM8Ur6RwFp72Rg4sA4AhgStwiqoVk
	oR/c/PudbySBS68X+MFC0JKjiJD/7Uae7/2QtGpCAl8xuZT4Hm49j+l6t+ILIaj0
	wdZNOt1CqmIKKArWLj405OfOnplClWAu3/0H4v8I9VqU2DkYRjEkPLI/abFMrNnE
	dcBrOA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411s5pjxuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 20:05:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GK4xKd017468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 20:04:59 GMT
Received: from [10.111.179.45] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 13:04:58 -0700
Message-ID: <a4167f39-b2e5-4b86-b85f-a1dad4669fec@quicinc.com>
Date: Fri, 16 Aug 2024 13:04:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Fix ieee80211_convert_to_unicast() logic
To: Felix Fietkau <nbd@nbd.name>,
        =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Michael Braun
	<michael-dev@fami-braun.de>
CC: Harsh Kumar Bijlani <hbijlani@qti.qualcomm.com>,
        Kalyan Tallapragada
	<ktallapr@qti.qualcomm.com>,
        Jyothi Chukkapalli <jchukkap@qti.qualcomm.com>,
        Anirban Sirkhell <anirban@qti.qualcomm.com>,
        Johannes Berg
	<johannes.berg@intel.com>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20240815-ieee80211_convert_to_unicast-v1-1-648f0c195474@quicinc.com>
 <877ccgd7re.fsf@toke.dk> <229bcc37-de76-40ea-a30a-14e54a73265d@quicinc.com>
 <e7435c73-1d01-40e8-82b3-4e5456fccf2f@nbd.name>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <e7435c73-1d01-40e8-82b3-4e5456fccf2f@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HEV48AR3tgDx71b6geUhiGKjZbVts4k4
X-Proofpoint-ORIG-GUID: HEV48AR3tgDx71b6geUhiGKjZbVts4k4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_16,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1011
 bulkscore=0 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160142

On 8/16/2024 10:54 AM, Felix Fietkau wrote:
> On 16.08.24 16:30, Jeff Johnson wrote:
>> On 8/16/2024 4:31 AM, Toke Høiland-Jørgensen wrote:
>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>
>>>> The current logic in ieee80211_convert_to_unicast() uses skb_clone()
>>>> to obtain an skb for each individual destination of a multicast
>>>> frame, and then updates the destination address in the cloned skb's
>>>> data buffer before placing that skb on the provided queue.
>>>>
>>>> This logic is flawed since skb_clone() shares the same data buffer
>>>> with the original and the cloned skb, and hence each time the
>>>> destination address is updated, it overwrites the previous destination
>>>> address in this shared buffer. As a result, due to the special handing
>>>> of the first valid destination, all of the skbs will eventually be
>>>> sent to that first destination.
>>>
>>> Did you actually observe this happen in practice? ieee80211_change_da()
>>> does an skb_ensure_writable() check on the Ethernet header before
>>> writing it, so AFAICT it does not, in fact, overwrite the data of the
>>> original frame.
>>
>> I'm proxying this change for our internal team, and they have observed that
>> unicast frames are not being sent to the separate STAs.
>>
>> In response to your reply I went through the code again and it seems the
>> manner in which this functionality fails isn't as it was described to me.
>>
>> Instead this functionality fails because we'd fail on the first
>> ieee80211_change_da() call and hence goto multicast and where only the
>> original skb would be queued and transmitted as a multicast frame
>>
>> So the original logic is still faulty, only the actual faulty behavior is not
>> being described correctly: instead of sending multiple unicast frames to the
>> same STA we'd send a single multicast frame.
> 
> While I agree with switching over to skb_copy (or maybe pskb_copy to 
> reduce realloc on fragmented skbs), it's still not clear to me why 
> ieee80211_change_da fails. It should detect that the packet was cloned, 
> letting pskb_expand_head reallocate the head of the skb.
> 
> Please run some more tests to figure out the exact reason for the 
> failure. There might be another hidden bug lurking there, which would 
> get papered over by this change.
> 
> - Felix

Thanks, I've thrown this back over to the development team to clarify.

/jeff

