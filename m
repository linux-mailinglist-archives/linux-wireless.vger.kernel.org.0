Return-Path: <linux-wireless+bounces-11559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD73A954C60
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 16:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF181F22963
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6F31B29BF;
	Fri, 16 Aug 2024 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oAgzcDBk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47BF2BB0D;
	Fri, 16 Aug 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723818650; cv=none; b=JatDIXWg05mvkhjmTJjH8MOR+cosc1gwZnivEhBFNTl4G8OVzB/1sCBb+yBVSvwIIcqF0x2ZuSqF6OfQOgTENrJxM15uCspPURNYPfbJL4AW+Zsyh10iuiilj104zKe85PflC3znyG2EdqfOF88DCdUiJ0/uWOkmPArcOsxRl4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723818650; c=relaxed/simple;
	bh=okqa08d3NtplnUtcUNsK/7qdSLfF0QhpEZkh/WIk5OQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AkOtw0KZ17cuhQxufq3Z0xhJsHvI3djFtzEfXA4+9R0Js/KS9AABSjcpE631LxvoQ1FBMqpmmJFKzVwZJuHbEHqZepRcvxNF0jZFpXApZqVA38W8I9O2bTFyrFw9Vuv81/DY7kngui2QENgpl6SgVZa3fYOJ6A11bSrvn8bBxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oAgzcDBk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GA37iQ018931;
	Fri, 16 Aug 2024 14:30:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ySmGx9Vjqb+jCe6jKNHQOd/iD3jo8brjdUCvlYIe8t4=; b=oAgzcDBkGYLECNsP
	nZJzgPMJ9llY3CeB6RZaBPofHTXhlpD2en4QmwOh1xfDcJmvHlE37sKWm7Cgmt1Y
	ory+T6Kb9cSf8cFM3+iM+aQD9mGvoe6iu3zbdISWmSu/T0qW5unpM59/PmQ6mIQ6
	Yr7vsVRDISG3f/4/jKi2a8whzA5KiFxEKCAz9irXsdEUihjflMjdBukoJRHpUJ3U
	moWdG5RgyffzEUyBYKu7ZJW2QMTv3qQAu9K5EcdhKX5OLEr9eYA2gS5LsgDcXO+6
	5KAjFvalMh5QFtfYxZ02hkdcvd5wk+ZTubYUKEhjsijtTVHQg8pp0hRjXuFoE1cN
	VGVmfQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411rvra4y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:30:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47GEUPkE025479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 14:30:25 GMT
Received: from [10.111.179.45] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 16 Aug
 2024 07:30:24 -0700
Message-ID: <229bcc37-de76-40ea-a30a-14e54a73265d@quicinc.com>
Date: Fri, 16 Aug 2024 07:30:23 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Fix ieee80211_convert_to_unicast() logic
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        "Johannes
 Berg" <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Michael Braun <michael-dev@fami-braun.de>
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
 <877ccgd7re.fsf@toke.dk>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <877ccgd7re.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oX_0gPwsd6f-dAdRGHMLir2hI64zJ9fy
X-Proofpoint-ORIG-GUID: oX_0gPwsd6f-dAdRGHMLir2hI64zJ9fy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_08,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1011 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160105

On 8/16/2024 4:31 AM, Toke Høiland-Jørgensen wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> The current logic in ieee80211_convert_to_unicast() uses skb_clone()
>> to obtain an skb for each individual destination of a multicast
>> frame, and then updates the destination address in the cloned skb's
>> data buffer before placing that skb on the provided queue.
>>
>> This logic is flawed since skb_clone() shares the same data buffer
>> with the original and the cloned skb, and hence each time the
>> destination address is updated, it overwrites the previous destination
>> address in this shared buffer. As a result, due to the special handing
>> of the first valid destination, all of the skbs will eventually be
>> sent to that first destination.
> 
> Did you actually observe this happen in practice? ieee80211_change_da()
> does an skb_ensure_writable() check on the Ethernet header before
> writing it, so AFAICT it does not, in fact, overwrite the data of the
> original frame.

I'm proxying this change for our internal team, and they have observed that
unicast frames are not being sent to the separate STAs.

In response to your reply I went through the code again and it seems the
manner in which this functionality fails isn't as it was described to me.

Instead this functionality fails because we'd fail on the first
ieee80211_change_da() call and hence goto multicast and where only the
original skb would be queued and transmitted as a multicast frame

So the original logic is still faulty, only the actual faulty behavior is not
being described correctly: instead of sending multiple unicast frames to the
same STA we'd send a single multicast frame.

>> Fix this issue by using skb_copy() instead of skb_clone(). This will
>> result in a duplicate data buffer being allocated for each
>> destination, and hence each skb will be transmitted to the proper
>> destination.
> 
> Cf the above, it seems this change will just lead to more needless
> copying.

What other way is there to implement this multicast to unicast functionality?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebceec860fc370b2f4c23e95c51daa932e047913

All of this logic exists to support that feature.

Also note MLO multicast uses the skb_copy() methodology as well.

/jeff

