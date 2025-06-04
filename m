Return-Path: <linux-wireless+bounces-23663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBCBACD53C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 04:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CFF17881B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 02:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F76B4C97;
	Wed,  4 Jun 2025 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LRbWIQll"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660FB7262F;
	Wed,  4 Jun 2025 02:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003399; cv=none; b=oWjgEaY1H5TP+e4QxXOeYNpUu5beTl9qqwDVV12FTncjDqYvtT0W4EW9VElMPIgdclaAan2mTvLilTIbuwb08/l7a18sF4bDnp+ZQqknuN/4xcKYM3K2hRPA1Tet2bx2+IGVvnI28Az2vdGcG+WX10ubU3DKztBGws9qKfrv0OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003399; c=relaxed/simple;
	bh=6dOQE+uqi7oQtocTnWyfs/s0aKKZDl8OuQcypQQPmRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WxN4PIRQmi6tWnwxvdVoNjgSzTzV14l7JBQDPFrI1Po18fM3IJy3xUlZAdEmH75aw/6+ITN1I42OCmxywQx2+8vnxcitq9OHPGYq7Nq+TdmEMYtld/3BKHDnrItEJfOHE/XUW7GzJubIxTT+oop3aMHjwU/pPGRyhH9UnKHTfdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LRbWIQll; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553KKPkT032469;
	Wed, 4 Jun 2025 02:16:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lzoIt0DVnfgEsq/1b1999xRbKEXgU2sfXlH81SPn5G0=; b=LRbWIQllBIxQc/EQ
	zSj5vTo7pDmdcina4QWyT45qVy5Yt/yuNSMVvBcldLbchY9DRYlyCserLF2PGS1r
	TaSF/b+kzqacpa0z8CXKqcWYMFCDCwFNpKbkOmJ2u5RBRUJaNkHWadAOqUh91mXc
	2PlMLZTZmN5rFrFb5XL2Qd9Wnwyv2u3HAKIU5efu2hfPHftNGp6a2JxjjlGhASj6
	KNBfOmWIveUKCmAJetRUM2nuOkOwDj3cq/+38olVPhfVO/Ns4NxqfkopD47ZLzx1
	s7WhmBd6W4AowAPlZfVhjdFloAQceziYBcxNYas//CUt77MTYdk+sEXrGuy8ZMb8
	sEpB/Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471sfuuamb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 02:16:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5542GUde025483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 02:16:30 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Jun 2025
 19:16:27 -0700
Message-ID: <b303ba1c-b521-44b4-9afc-cf1766f549ee@quicinc.com>
Date: Wed, 4 Jun 2025 10:16:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
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
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aD7h0OOoGjVm8pDK@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=CY8I5Krl c=1 sm=1 tr=0 ts=683fac7f cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10
 a=0bE2M0OxO6QlerH5VgoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Y7T0tH0nta4IxMcvbUEnbxM73AbOsrzT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDAxNiBTYWx0ZWRfXwo23OH1zfJDh
 za4r137CNmzFPiOrJk/H5//UK1hkazYl99oSCqe8/moDfhOekY4ui8hzZpEw1Ss+JI220TJU2St
 KYe6/VoVdzgsT4CPU3hHo//G3bYcEcFGwwcmb9ROnolsg5iWDlrQhQHMZwJqyMt/FefY0+dLBOa
 VYv6UEnJ7zckhCioUwyBGGfMXJcb8ZniCZesZcKxmyF61gajyC0Ge5EJb0NbKjo2yjFSmb9h0y4
 AgroTbViLvcJayOVkt15SIDnu7J3aQuGpSQihdG95N7VEQC0p9UtrzRI9JIsR2IPMV6cJk++6bl
 BQaKJkNFv3GlIIhcU8MtEzjIL8TslzaqZ8PqUBsJOVXM5tGpidrsAr2mRZDNlc9PDJY0i4HMUWV
 5WqgOtjw/thFNOpa8y2+AI9oEC9Ult7uh1kJvHOE48DkHGFYsylivABeq/MfL/p+XM1BjJZg
X-Proofpoint-GUID: Y7T0tH0nta4IxMcvbUEnbxM73AbOsrzT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_01,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxlogscore=492 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506040016



On 6/3/2025 7:51 PM, Johan Hovold wrote:
> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
>> On 6/2/2025 4:03 PM, Johan Hovold wrote:
> 
>>> No, the barrier is needed between reading the head pointer and accessing
>>> descriptor fields, that's what matters.
>>>
>>> You can still end up with reading stale descriptor data even when
>>> ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to speculation
>>> (that's what happens on the X13s).
>>
>> The fact is that a dma_rmb() does not even prevent speculation, no matter where it is
>> placed, right?
> 
> It prevents the speculated load from being used.

Sorry, still not get it. To my knowledge whether the speculated load (steps 3 and 4) would
get used depends on whether the condition check pass in step 2. How does a dma_rmb() make
any difference in this process?

Could you help give an detailed explanation on how dma_rmb() work here? I mean what issue
is there if without the barrier, and then how does the barrier prevent the issue? It would
be better if you can follow below pattern in the explanation, i.e, steps and code lines ...

> 
>> If so the whole point of dma_rmb() is to prevent from compiler reordering
>> or CPU reordering, but is it really possible?
>>
>> The sequence is
>>
>> 	1# reading HP
>> 		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
>>
>> 	2# validate HP
>> 		if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp)
>> 			return NULL;
>>
>> 	3# get desc
>> 		desc = srng->ring_base_vaddr + srng->u.dst_ring.tp;
>>
>> 	4# accessing desc
>> 		ath11k_hal_desc_reo_parse_err(... desc, ...)
>>
>> Clearly each step depends on the results of previous steps. In this case the compiler/CPU
>> is expected to be smart enough to not do any reordering, isn't it?
> 
> Steps 3 and 4 can be done speculatively before the load in step 1 is
> complete as long as the result is discarded if it turns out not to be
> needed.
> 
> Johan


