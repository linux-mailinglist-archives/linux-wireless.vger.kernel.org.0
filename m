Return-Path: <linux-wireless+bounces-24145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAD7ADADE2
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 12:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 088897A4EF4
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 10:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDBE27F178;
	Mon, 16 Jun 2025 10:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vtik706T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E9B1465A5;
	Mon, 16 Jun 2025 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071586; cv=none; b=kIoxOgTPVH8xmEaAlnL1kJxFTbKTEl45RfltRE4sXNDObo3+3xr78rQjT9/CS0GnCr/zACSZdJQucyHc3Xoy3Y0foW7e4LiVBDMKi40wBaA2625Mac5VJSUuH8vh0DcM3YqzH4suVJZ2M6hQJkW/VbmoLJ+Rg4NvO0pPv5QEvJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071586; c=relaxed/simple;
	bh=vh0ChoyvFOfuB08SmeEbn8gLSfHzaq+vHJE9lbd9YcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=J4eaD6sMxxu75RCvJbzkcFlyV4li2eZ5DB9AW3G2kDmJhxVxEc1sac+9mF06U5J1d8mInsPJuWDoCIXHWd82Muufq1cIdhduuvN9MUrJUZ3jyZVWCs0IbhHjSkQjYKzGziR9yNqgz0/ZrYx53PFaEj/65ZUGYLscYfkigYKHyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vtik706T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8eVSh010256;
	Mon, 16 Jun 2025 10:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CBwca7iYJlCgH/85QR5/GTDEW6kvwbktN5KO9BTcuxs=; b=Vtik706TdElAa/pz
	CZTMn8edh5aW6vjVz74wDz/nz+bOKTC8yKJ28Ur/BhE4spoF8yjdKDYDS4I4LFdi
	h12BeGHuphMRf2ra69sxDFNlM+yypY194kweS4zn/vFwxvEQe542MUFlCCaE5WLt
	W9k0jrN4Hc4WURur/iM6WYf2QaXGcJ4NueNoiI+ZH50ANUBWRuxKgUoQmyjjfVHR
	E0F3m7/pDCGi4dNDmOaggiYdFSwhsXxZUExvvVAio6w2E5PMJWqVVglEPjXS5sx5
	YBMgegHD3vRdbCeYmf3g2fkep0eyHuZc5c1yVrPv/c4B9vtMywZMsN6ytOOGWBQm
	S+AjDA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4791f7475r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:59:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55GAxbl0012424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 10:59:37 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 16 Jun
 2025 03:59:34 -0700
Message-ID: <28744dbe-1759-4abe-8f1b-505a2a71c5fb@quicinc.com>
Date: Mon, 16 Jun 2025 18:59:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
To: Praneesh P <praneesh.p@oss.qualcomm.com>, Johan Hovold <johan@kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Jeff Johnson
	<jjohnson@kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>,
        "Remi
 Pommarel" <repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250604144509.28374-1-johan+linaro@kernel.org>
 <20250604144509.28374-2-johan+linaro@kernel.org>
 <6f3eb9fa-617e-4434-8fc4-33dd92c4bdd2@quicinc.com>
 <aEFqsghEuJc3xxlU@hovoldconsulting.com>
 <ed06d62a-4b98-443a-a2ed-c92058bb521a@quicinc.com>
 <63c2c889-0a09-4b25-a1d2-2aaa92d75d9f@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <63c2c889-0a09-4b25-a1d2-2aaa92d75d9f@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDA2NyBTYWx0ZWRfX1Hcwpd5M6DH5
 bYkEsWskogVGS+pM0AxPyEqIz5ag2uXDsgAYnLDPRt2iVGhOir4jNlMCsC4InxjQe57byDceAhf
 tiR4YRzJzVY5Girita3/igbxzAqDGyiHNSpdIo1KXNdd1I4nVcScs8hSDZBMmjhkJp08/PG0XRy
 w8fuch0D5VE3I39CHligx+PbquCgwdVipsCPtpFtiaWMGMG9ZPDJ4pU8p22NjRAVlJv2E8l9JHS
 wAxPRWSnn7GCyVwJ08HuzJIP1cVmzgrpMn+YQjNkwykTvNWGwEJOQ4F6tm56QuNU8tessR0kmBd
 99UsQUkonyWCpqjFise1yH2yZixcETulDlyVE5KCNdAzQVKZSF5bJ5x+srNsSR0G2kLoeF6FZsU
 kFET/TepEtPpohfy6YuWg3m4yCHasJLaUDJS5ho5P/hsUtQ60VBIt3BewI2s2OM7Y41ow1an
X-Proofpoint-GUID: 236sAS0ZcdOMniQ1vXu9DWFADIqWe0TX
X-Proofpoint-ORIG-GUID: 236sAS0ZcdOMniQ1vXu9DWFADIqWe0TX
X-Authority-Analysis: v=2.4 cv=FrIF/3rq c=1 sm=1 tr=0 ts=684ff91a cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=jdvWKOla6C7U-uX_HBcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506160067



On 6/16/2025 5:29 PM, Praneesh P wrote:
> 
> On 6/5/2025 4:19 PM, Baochen Qiang wrote:
>>
>> On 6/5/2025 6:00 PM, Johan Hovold wrote:
>>> On Thu, Jun 05, 2025 at 04:41:32PM +0800, Baochen Qiang wrote:
>>>> On 6/4/2025 10:45 PM, Johan Hovold wrote:
>>>>> Add the missing memory barrier to make sure that destination ring
>>>>> descriptors are read after the head pointers to avoid using stale data
>>>>> on weakly ordered architectures like aarch64.
>>>>>
>>>>> The barrier is added to the ath12k_hal_srng_access_begin() helper for
>>>>> symmetry with follow-on fixes for source ring buffer corruption which
>>>>> will add barriers to ath12k_hal_srng_access_end().
>>>>>
>>>>> Note that this may fix the empty descriptor issue recently worked around
>>>>> by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
>>>>> monitor ring").
>>>> why? I would expect drunk cookies are valid in case of HAL_MON_DEST_INFO0_EMPTY_DESC,
>>>> rather than anything caused by reordering.
>>> Based on a quick look it seemed like this could possibly fall in the
>>> same category as some of the other workarounds I've spotted while
>>> looking into these ordering issues (e.g. f9fff67d2d7c ("wifi: ath11k:
>>> Fix SKB corruption in REO destination ring")).
>>>
>>> If you say this one is clearly unrelated, I'll drop the comment.
>> Praneesh, could you comment here since you made that change?
> Empty/Drop descriptor is intentionally issued by the hardware during backpressure scenario
> and is unrelated to the issue discussed in this patch series.

Thanks Praneesh.

Johan, according to that, please drop the comment.

>>>>> @@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe
>>>>> *pipe,
>>>>>           goto err;
>>>>>       }
>>>>>   -    /* Make sure descriptor is read after the head pointer. */
>>>>> -    dma_rmb();
>>>>> -
>>>>>       *nbytes = ath12k_hal_ce_dst_status_get_length(desc);
>>>>>         *skb = pipe->dest_ring->skb[sw_index];
>>>>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/
>>>>> hal.c
>>>>> index 91d5126ca149..9eea13ed5565 100644
>>>>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>>>>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>>>>> @@ -2126,13 +2126,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base
>>>>> *ab,
>>>>>     void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>>>>>   {
>>>>> +    u32 hp;
>>>>> +
>>>>>       lockdep_assert_held(&srng->lock);
>>>>>   -    if (srng->ring_dir == HAL_SRNG_DIR_SRC)
>>>>> +    if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>>>>>           srng->u.src_ring.cached_tp =
>>>>>               *(volatile u32 *)srng->u.src_ring.tp_addr;
>>>>> -    else
>>>>> -        srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>>>> +    } else {
>>>>> +        hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>>>> +
>>>>> +        if (hp != srng->u.dst_ring.cached_hp) {
>>>> This consumes additional CPU cycles in hot path, which is a concern to me.
>>>>
>>>> Based on that, I prefer the v1 implementation.
>>> The conditional avoids a memory barrier in case the ring is empty, so
>>> for all callers but ath12k_ce_completed_recv_next() it's an improvement
>>> over v1 in that sense.
>>>
>>> I could make the barrier unconditional, which will only add one barrier
>>> to ath12k_ce_completed_recv_next() in case the ring is empty compared to
>>> v1. Perhaps that's a good compromise if you worry about the extra
>>> comparison?
>> I guess the unconditional barrier also has impact on performance? If so I am not sure
>> which one is better then ...
>>
>> Let's just keep it as is and see what others think.
>>
>>> I very much want to avoid having both explicit barriers in the caller
>>> and barriers in the hal end() helper. I think it should be either or.
>>>  
>>>>> +            srng->u.dst_ring.cached_hp = hp;
>>>>> +            /* Make sure descriptor is read after the head
>>>>> +             * pointer.
>>>>> +             */
>>>>> +            dma_rmb();
>>>>> +        }
>>>>> +    }
>>> Johan
>>


