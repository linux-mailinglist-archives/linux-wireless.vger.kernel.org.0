Return-Path: <linux-wireless+bounces-23678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7896ACD973
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B816F036
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5348F22D4E9;
	Wed,  4 Jun 2025 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RBkmRJ7O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F01946DA;
	Wed,  4 Jun 2025 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025125; cv=none; b=fTTzM0UQAx8nCBxf+EM4OTxEsHLC0po7ygYcdznj5VBi85SV7mqpCPWu0zAOaOJlJw8VjT5+LeB67cT3/AeGQl1CBAKPj9bDsCxW5+PUltrf6xWD7Mi20eY4aedn5DywfoHDjYUKpEnhLAwGjGT0M2kYFrTGjx8IkhWUiSGqFs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025125; c=relaxed/simple;
	bh=ivhstX9IHoCz1LW/zKxbn8swTYpIdKTorWpMNnS86S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ePgHOcRmjxI6iEC5BHRi2NIhE0gQozR3CiCXcDfY0HIUOG+X7EBpmCwPxEe5uTKt5hMEbckceIl5hlOgyTOq7iE328cSuCTgvtmEWxljvXTr8jDvA0TQdmJF+p+Jyp3d2RljaGjW/y3j6IViaCx0fgWV2d9ol7U+PzEZKDAbjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RBkmRJ7O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553L0T5t007388;
	Wed, 4 Jun 2025 08:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	a+qlb57xxwaTCuFL52/E3275a9Fzz22EbNv/H6BVDLI=; b=RBkmRJ7OeMZ7gRWo
	4KhEh7RW5NB+MOVVPvpXSo+QNKJ3a6DkjCdtxzYxNIqUKtkRwzJJNT7ZO1L9zXvf
	pMGzG71O1PhjKVcs2x69CwfYSKSJdgBdzP3LWUMTRq2T33FiHOcZhmPGs4zJI7IF
	WxwNIgafx7BxYKL7Mlkk4JKZQZQGW1DFnUAyyJep81bCi/+qld/m44ME3OG6Xiz2
	q/fDPHHri5uWlClr9fYVOv+Us1h+lWMJFhGzgdBPrdxAMxrHBo1RkegbniwGLZ/T
	OeOR2y+oNB7SgKQZJTbFdZfM/RpMGtMqfFeBAOq7GJGSDMcv17IPhgiVGUYXdBbQ
	+Kbh5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8swaks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 08:18:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5548IbBs023995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 08:18:37 GMT
Received: from [10.133.33.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 01:18:35 -0700
Message-ID: <94d95c9b-2fd7-45b1-b9ae-664d651071cc@quicinc.com>
Date: Wed, 4 Jun 2025 16:18:32 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan@kernel.org>
CC: Baochen Qiang <quic_bqiang@quicinc.com>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
 <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
 <aD1axxSAJsbUfnHH@hovoldconsulting.com>
 <5268c9ba-16cf-4d3a-87df-bbe0ddd3d584@quicinc.com>
 <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
 <01634993-80b1-496e-8453-e94b2efe658c@quicinc.com>
 <7025db40-dda0-4cbb-80bd-09bd590584da@quicinc.com>
 <aD_wgACEfm1_1GNz@hovoldconsulting.com>
 <79b4bac1-6e55-408c-a334-006eded4229f@quicinc.com>
 <aD_-zt755Jr_LsWM@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <aD_-zt755Jr_LsWM@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=RMizH5i+ c=1 sm=1 tr=0 ts=6840015e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=3_NjuXynapyhKrkUQyEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2NCBTYWx0ZWRfXyisOzIPuB7Dm
 ng6rMzjM7MgNzW96wtZtp62LdWw35OorI6YgJdnmQVZe2hx+GWXHGj28A5FTN549UKbV8E7C2fc
 0GsT/SAiikWo/KPvvj38mEUmIrgQKlx+a+H3pnQtPZj1W+y7QvDo0yEn/BjUd+iejZzM/x8CxiT
 xB/ztP/5/1c++tadyIVM9+rdCMcSmErn5Fq2NuEEIETOE/NytakmdUwiAK0KEx4O7nhQnXwMxA+
 Izeq+8CI28sMqngClKDQk1wb5Vr9Yw5nHDpSU01b85lpUqquZDXMPiMXAlwqAmS3gVhk0m47aBr
 T+vLJgM2QhSZDRHBUndvK1FhFZlv+yfu/cjxHnhBGTWHc3mLqWCnQKtDMWWPzsU5bVnp9lGhh+C
 vVnAS/3NKoRYPEQdvtOZIh96/T0nJWVEwMl3Ou1UcwRieTpH3Wrv+ePPmdCNSvV9rXYJNQ6k
X-Proofpoint-GUID: W_8y7Pib7JpzMR6Zj-Qj5nLBrlt1jASV
X-Proofpoint-ORIG-GUID: W_8y7Pib7JpzMR6Zj-Qj5nLBrlt1jASV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 mlxlogscore=602 mlxscore=0
 clxscore=1015 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040064



On 6/4/2025 4:07 PM, Johan Hovold wrote:
> On Wed, Jun 04, 2025 at 03:57:57PM +0800, Miaoqing Pan wrote:
>> On 6/4/2025 3:06 PM, Johan Hovold wrote:
>>> On Wed, Jun 04, 2025 at 01:32:08PM +0800, Miaoqing Pan wrote:
>>>> On 6/4/2025 10:34 AM, Miaoqing Pan wrote:
>>>>> On 6/3/2025 7:51 PM, Johan Hovold wrote:
>>>>>> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
> 
>>>>>>> The sequence is
>>>>>>>
>>>>>>>       1# reading HP
>>>>>>>           srng->u.dst_ring.cached_hp = READ_ONCE(*srng-
>>>>>>>> u.dst_ring.hp_addr);
>>>>>>>
>>>>>>>       2# validate HP
>>>>>>>           if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
>>>>>>>               return NULL;
>>>>>>>
>>>>>>>       3# get desc
>>>>>>>           desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
>>>>>>>
>>>>>>>       4# accessing desc
>>>>>>>           ath11k_hal_desc_reo_parse_err(... desc, ...)
>>>>>>>
>>>>>>> Clearly each step depends on the results of previous steps. In this
>>>>>>> case the compiler/CPU
>>>>>>> is expected to be smart enough to not do any reordering, isn't it?
>>>>>>
>>>>>> Steps 3 and 4 can be done speculatively before the load in step 1 is
>>>>>> complete as long as the result is discarded if it turns out not to be
>>>>>> needed.
>>>
>>>>> If the condition in step 2 is true and step 3 speculatively loads
>>>>> descriptor from TP before step 1, could this cause issues?
>>>>
>>>> Sorry for typo, if the condition in step 2 is false and step 3
>>>> speculatively loads descriptor from TP before step 1, could this cause
>>>> issues?
>>>
>>> Almost correct; the descriptor can be loaded (from TP) before the head
>>> pointer is loaded and thus before the condition in step 2 has been
>>> evaluated. And if the condition in step 2 later turns out to be false,
>>> step 4 may use stale data from before the head pointer was updated.
>>
>> Actually, there's a missing step between step 3 and step 4: TP+1.
>>
>> TP+1:
>> 	srng->u.dst_ring.tp += srng->entry_size
> 
> Sure, but that is not relevant for the issue at hand.
> 
>> TP is managed by the CPU and points to the current first unprocessed
>> descriptor, while HP and the descriptor are asynchronously updated by
>> DMA. So are you saying that the descriptor obtained through speculative
>> loading has not yet been updated, or is in the process of being updated?
> 
> Exactly.
> 
> Johan

Thanks, make sense.

Reviewed-by: Miaoqing Pan <quic_miaoqing@quicinc.com>




