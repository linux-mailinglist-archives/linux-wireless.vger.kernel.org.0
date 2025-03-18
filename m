Return-Path: <linux-wireless+bounces-20485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB22A66CD7
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 08:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505873B91D3
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9589B1AA791;
	Tue, 18 Mar 2025 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SGXCR2Tw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C768A1A7045;
	Tue, 18 Mar 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742284436; cv=none; b=pp+UYB2oDqt2/lS91X9Rdy+0+3JSmDEJXqLFMeNUJRpy/lRJ67+Me6JhYrvyYDhzSnrODyRUsFsLj4km15F5b7PeBmlSITTgGLSHiClR/fPfHyMqmc+ti6DCFYr4IZJ8fKb6fLH0/Rvkj2MS5oV9fL5pT/CXOjsF8Bu2jeNl7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742284436; c=relaxed/simple;
	bh=iNUOvA3sag629Y3TB7XcMbbNr4GLpvbf9SCKMm/uukE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=atGQ5XXy4s1LM7183RTMp74nc4902fkjSJDix1Jyj2PstEzjy9wif5Ar5DhUdQSwz8IU3Vz79lfg7oNQ8+exIcsl1aRrvvtV+U0QEBlX41z91SDUd7ZxRn6M5IAgsAzAqmkt9YNr+iROBps23eFKT/MunxghSeZPP486T1LSAnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SGXCR2Tw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HLe2LG024976;
	Tue, 18 Mar 2025 07:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zOVwMdkFvGuOZ9cWNHAiMuAvOwL6TqB2abgcw+wNOh8=; b=SGXCR2Twy+xbgD8T
	PGF4PpwfnTpxXsm9h+/KHOdp6mKVwvID0JvXhorEWK4HTmEEwpN2h4mEuI4Xf9fq
	8bJnli0Unawz7diC+UzEkiAF7LSefLS8U3ieNeSopP+nfXEGLIsypBrO5NYY+byh
	KKL0Zix/QzJOrPQTxRZqN8AVvUJUEm2ilSPqiRmz2ckmbGu4mOOe8WQh0k9LC0s8
	tkeJk/ENF+DvIaEVlSaJvyyuUXIWKkOCjMeHGYElR0HZrh8uMH3JtwchOAfo21Xl
	LgN42WS7ZsjI7zTjt3RYMinJeFrUbfTFCW/cmWkbrgPx/myU8qevFOEjVwBY8iI/
	6y7nMw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1utyavr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52I7rkB1022369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 07:53:46 GMT
Received: from [10.239.29.24] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Mar
 2025 00:53:44 -0700
Message-ID: <f30cf771-a9cd-4d8f-8d10-1640afd33c23@quicinc.com>
Date: Tue, 18 Mar 2025 15:53:39 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 ath-next 2/2] wifi: ath11k: fix HTC rx insufficient
 length
To: Johan Hovold <johan@kernel.org>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <johan+linaro@kernel.org>
References: <Z866cCj8SWyZjCoP@hovoldconsulting.com>
 <7b1c5e40-b11d-421b-8c8b-117a2a53298b@quicinc.com>
 <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
 <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
 <ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com>
 <Z9gd9Aw5Bug8IKSV@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z9gd9Aw5Bug8IKSV@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=67d9268b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=2M5b3jNWWK1cOhy4hzQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JN3mFfdcbY7wxtnhoottWP2pIq8HRbxq
X-Proofpoint-ORIG-GUID: JN3mFfdcbY7wxtnhoottWP2pIq8HRbxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_03,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503180055



On 3/17/2025 9:04 PM, Johan Hovold wrote:
> On Mon, Mar 17, 2025 at 01:52:15PM +0800, Miaoqing Pan wrote:
>> On 3/14/2025 4:06 PM, Johan Hovold wrote:
>>> On Fri, Mar 14, 2025 at 09:01:36AM +0800, Miaoqing Pan wrote:
>   
>>>> I think the hardware has already ensured synchronization between
>>>> descriptor and head pointer, which isn't difficult to achieve. The issue
>>>> is likely caused by something else and requires further debugging.
>>>
>>> Yeah, but you still need memory barriers on the kernel side.
>>>
>>> It could be that we are looking at two different causes for those
>>> zero-length descriptors.
>>>
>>> The error handling for that obviously needs to be fixed either way, but
>>> I haven't heard anyone hitting the corruption with the memory barriers
>>> in place on the X13s yet (even if we'd need some more time to test
>>> this).
> 
>> After multiple and prolonged verifications, adding dma_rmb() did not
>> improve the issue at all. I think this Status Descriptor is updated by
>> hardware (Copy Engine) controlled by another system, not involving DMA
>> or out-of-order CPU access within the same system, so memory barriers do
>> not take effect.
> 
> Then it seems we are looking at two separate root causes for the
> corruption as the memory barrier appears to be all that is needed to fix
> the X13s issue.
> 
> A user who hit the corruption after 2 h without the fix has been running
> over the weekend with the memory barrier without any problems. I'll ask
> further users to test, but it certainly looks like it is working as
> intended.
> 
> And the memory barrier is de-facto missing as the head pointer and
> descriptor are accessed through (two separate) coherent mappings so
> there are no ordering guarantees without explicit barriers.
> 
This situation should occur when there is only one descriptor in the 
ring. If, as you mentioned, the CPU tries to load the descriptor first, 
but the descriptor fetch fails before the HP load because the ring 
returns empty, it won't trigger the current issue.

The Copy Engine hardware module copies the metadata to the Status 
Descriptor after the DMA is complete, then updates the HP to trigger an 
interrupt. I think there might be some issues in this process, such as 
the lack of a wmb instruction after the copy is complete, causing the HP 
to be updated first.


> Now obviously there are further issues in your system, which we should
> make sure we understand before adding workarounds to the driver.
> 
> Do you have a pointer to the downstream kernel sources you are testing
> with? Or even better, can you reproduce the issue with mainline after
> adding the PCIe patches that were posted to the lists for these
> platforms?
> 
https://github.com/qualcomm-linux/meta-qcom-hwe/blob/scarthgap/recipes-kernel/linux/linux-qcom-base_6.6.bb

> Apparently the descriptors can also be passed in non-coherent memory
> for some devices (.alloc_cacheable_memory / HAL_SRNG_FLAGS_CACHED). That
> implementation looks suspicious and could possibly result in similar
> problems. Are you using .alloc_cacheable_memory in your setup?
> 
No.

> Does it make any difference if you use a full rmb() barrier?
> 
I've also tried rmb() and mb(), but they didn't work either.

> And after modifying ath11k_hal_ce_dst_status_get_length() so that it
> does not clear the length, how many times you need to retry? Does it> always work on the second try?
>

Yes, the test has been running continuously for over 48 hours, always 
work on the second try, updated in patch v4.



