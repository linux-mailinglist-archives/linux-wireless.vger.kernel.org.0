Return-Path: <linux-wireless+bounces-23748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D7ACEDFB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 12:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0483ACAB9
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD72147ED;
	Thu,  5 Jun 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GvGRPep9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1EA21421A;
	Thu,  5 Jun 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120594; cv=none; b=amfp9eyZ8YpVriFNi4FEkohHDf3HGOV6YD0aiKq7feBQxQZbroIiOIHWPIPdsTkfY1uajbgGLxIyhn1MbfIBhH9qj0UKO1LDawICMWOhi9OJQrDkNemKE6nrGyYyGzGvzxnSrH4zklv2kPWTuQgahtoPNJfVoJuR9hEpWuggAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120594; c=relaxed/simple;
	bh=Ty0Rqu5WTEruxD6Ugl5MQUQ2m+ogUAxhdpPN3wwQz+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pN4IWxjYG0ofaQwxHUrdqyXUGKpCflmH8AqWsrBsObK/UmxBoasvlzwBhTuFTpta7vY5xKNWMaeA7ypNruRRlbPHhHToclgbyDCMij152Cp7Z/dFMpdq09pp15KO7MLjreNIkdwYUEa+4S2pBzo8zyI6zeWi3xF9qdGmIv8JWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GvGRPep9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555AE7fS011697;
	Thu, 5 Jun 2025 10:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1Nu48KAOTUJB110jqb0YRD3nekgoGR2DuxLGlevIej0=; b=GvGRPep9awRZkHig
	yQ3MSVtCSS0VBY3QTPBNOjs2mvjz37OV3eEeqUajbvPKZ5qmJR2KcZ0CW6EeTe6c
	l9XNgAw3MdQy/ilPhs+YLsu3eRk1Z3WjL1ku+xt8ewrqOD4k61P+yzKpu9mmiSt9
	2e4cxBnql0JhYbDEQ58UdjndT7i1HnyWuBXbh2HnmSoPK9VTONucFPQwFF3zPGbQ
	gvuqjCkl7YVgXX5axhtvuQedDSbcGf1hkIKsjeHmJTsl6c6hVN1hidXLUwyv60SH
	JCRpuJGQI3EAjDkjkY74HBK1jLXAvnyUB5GqEnKlC/bULzum9zfFDzywxDd2i2pW
	YTAMDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47202wen8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 10:49:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 555AnhDS000699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 10:49:43 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 03:49:40 -0700
Message-ID: <ed06d62a-4b98-443a-a2ed-c92058bb521a@quicinc.com>
Date: Thu, 5 Jun 2025 18:49:37 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] wifi: ath12k: fix dest ring-buffer corruption
To: Johan Hovold <johan@kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
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
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aEFqsghEuJc3xxlU@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QWF4qvpqRSQead5CaefYpnkqDX2ylmKx
X-Proofpoint-GUID: QWF4qvpqRSQead5CaefYpnkqDX2ylmKx
X-Authority-Analysis: v=2.4 cv=Y/D4sgeN c=1 sm=1 tr=0 ts=68417648 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=5WrX-GbsLVy5X1M0D7oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA5NCBTYWx0ZWRfX2yo99HAX7Ce/
 dpCDtf1K5s4ubhPzf493z2ZSfHa9aq6AXiM2g2X9kNLCFoIzJ1kk3Y/zIAnVBX5RoqS1modMcXK
 hRtp1h8Ht1QkaNRaDMc1BOPIHwZcin5nqLxBRXrS60muGyfUN2MBbTzF/HaUAR1kEz1EFEMuh3D
 FTKpki/psNFH7uezpaxcS86kDxIgtnWzFhGjtclYl5FNRGNVUDatHBIIZDz5i7ZZ2Kq6V6zV4qp
 V92cUeIlOw71AFENCO+xYe+VaoeBD2p35J6g4gIzpT9prKtu7VNVTEWkm3XZVydXnTznVYE1OGH
 d9LNyNElr/N1RR0SfDWYBP9z9wE6LvkrCmvCcXSdNJWrYU+2N1WftVG6lMYj/9S1GIaAVplIhqU
 3yef5zZvr5YVFh2xpyYPgZyhZp6lEONTCJM2eD/SlfPiTCFn/tjlAKNQNAnYgc/bldWZi9/f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050094



On 6/5/2025 6:00 PM, Johan Hovold wrote:
> On Thu, Jun 05, 2025 at 04:41:32PM +0800, Baochen Qiang wrote:
>> On 6/4/2025 10:45 PM, Johan Hovold wrote:
>>> Add the missing memory barrier to make sure that destination ring
>>> descriptors are read after the head pointers to avoid using stale data
>>> on weakly ordered architectures like aarch64.
>>>
>>> The barrier is added to the ath12k_hal_srng_access_begin() helper for
>>> symmetry with follow-on fixes for source ring buffer corruption which
>>> will add barriers to ath12k_hal_srng_access_end().
>>>
>>> Note that this may fix the empty descriptor issue recently worked around
>>> by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
>>> monitor ring").
>>
>> why? I would expect drunk cookies are valid in case of HAL_MON_DEST_INFO0_EMPTY_DESC,
>> rather than anything caused by reordering.
> 
> Based on a quick look it seemed like this could possibly fall in the
> same category as some of the other workarounds I've spotted while
> looking into these ordering issues (e.g. f9fff67d2d7c ("wifi: ath11k:
> Fix SKB corruption in REO destination ring")).
> 
> If you say this one is clearly unrelated, I'll drop the comment.

Praneesh, could you comment here since you made that change?

> 
>>> @@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
>>>  		goto err;
>>>  	}
>>>  
>>> -	/* Make sure descriptor is read after the head pointer. */
>>> -	dma_rmb();
>>> -
>>>  	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
>>>  
>>>  	*skb = pipe->dest_ring->skb[sw_index];
>>> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
>>> index 91d5126ca149..9eea13ed5565 100644
>>> --- a/drivers/net/wireless/ath/ath12k/hal.c
>>> +++ b/drivers/net/wireless/ath/ath12k/hal.c
>>> @@ -2126,13 +2126,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
>>>  
>>>  void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
>>>  {
>>> +	u32 hp;
>>> +
>>>  	lockdep_assert_held(&srng->lock);
>>>  
>>> -	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
>>> +	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>>>  		srng->u.src_ring.cached_tp =
>>>  			*(volatile u32 *)srng->u.src_ring.tp_addr;
>>> -	else
>>> -		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>> +	} else {
>>> +		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>> +
>>> +		if (hp != srng->u.dst_ring.cached_hp) {
>>
>> This consumes additional CPU cycles in hot path, which is a concern to me.
>>
>> Based on that, I prefer the v1 implementation.
> 
> The conditional avoids a memory barrier in case the ring is empty, so
> for all callers but ath12k_ce_completed_recv_next() it's an improvement
> over v1 in that sense.
> 
> I could make the barrier unconditional, which will only add one barrier
> to ath12k_ce_completed_recv_next() in case the ring is empty compared to
> v1. Perhaps that's a good compromise if you worry about the extra
> comparison?

I guess the unconditional barrier also has impact on performance? If so I am not sure
which one is better then ...

Let's just keep it as is and see what others think.

> 
> I very much want to avoid having both explicit barriers in the caller
> and barriers in the hal end() helper. I think it should be either or.
>  
>>> +			srng->u.dst_ring.cached_hp = hp;
>>> +			/* Make sure descriptor is read after the head
>>> +			 * pointer.
>>> +			 */
>>> +			dma_rmb();
>>> +		}
>>> +	}
> 
> Johan


