Return-Path: <linux-wireless+bounces-20527-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D01FEA68543
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E498419C2033
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 06:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEDF18FDAF;
	Wed, 19 Mar 2025 06:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V2K32Hkh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC2E552;
	Wed, 19 Mar 2025 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742366844; cv=none; b=CT0+9Ud1ycrzS3izUYjPrsvLvHQQNgBkqVF/mcdpcQ+hLOKFzyax0vJMXAexAYWl3R4JjvU1uITSind8F6890GvIB4CXCYFIzYBinAxSDw6JFw9dAmHB1+BLTn1cyf/+eolv+qgfDn9Dmn0ncjAI37FCZ5XT4Jw0LZ2YRmtuXeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742366844; c=relaxed/simple;
	bh=SZ74C1A2GIjdkIZezaCs1k2RDgFtfbh9/7XU6gBsARk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ptRls+VKZrID/eIhxnnNXmkxuziEEJ4LNwaAdpKceMtv5+i9GjGub7CvcIJKeCb5V9yJ34bXEO4407WgiemstU+fV2v9TUaMU5HNS9yNIpHemr9kHCsNR8gbFAxs4IynsoTpY6auXKwWPIc+Y3kJb+DLQ73DemTpbaDw+sYXN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V2K32Hkh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J4liQf020761;
	Wed, 19 Mar 2025 06:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	t0y/TCrIUgcCHFmCeC0dVj9Yieamk69pvvMnIjszNh4=; b=V2K32HkhTDlWmN5r
	liWAvg2chu7i/9BJU7+kmzGMh9t24QYSC+NWen9oRhV+5Y/E1rWC5eeKxIWzk9YR
	rrljp6Ibn4WLMbWqzUg6DfoBPMLMwwvJ8u7+OHg9OQnQ/BiwvMXuj7yWvZlnQjLK
	2425CxVDr1mmCgJ9kXlt6T3Q1JgPGTLMXUkPV2AmiVc92MLdXBRI6NBJ/3dOJpI0
	Z9vRzrlC42NY4AHbdD/HRn5rcP0HS2pXaPd/MJU9QgCe+FcLvdaek529Mrw4j+iB
	zNOb9MPXm9m603MpJD4RNRCQC4A3NZUX1duL+YQFDWR/Y2qKLTqm+yhTM9Zo6Pk+
	QZNIJg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45exx34c6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 06:47:17 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52J6lHrs008568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 06:47:17 GMT
Received: from [10.239.29.24] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 18 Mar
 2025 23:47:15 -0700
Message-ID: <a8fc9f07-013c-4e31-9d9e-46e042d81dbf@quicinc.com>
Date: Wed, 19 Mar 2025 14:47:12 +0800
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
References: <c0cdcaf2-655b-4d22-a949-1519c552e6a4@oss.qualcomm.com>
 <72d95d77-674e-4ae7-83b0-ab58748b8251@quicinc.com>
 <Z9G5zEOcTdGKm7Ei@hovoldconsulting.com>
 <8ea7fe7c-7b4d-4a6f-ae03-b9ca127c23f8@quicinc.com>
 <Z9METTzUJe9yqVEI@hovoldconsulting.com>
 <b1c79589-4fcd-4630-9551-a620087e0c23@quicinc.com>
 <Z9PjjDFBuSJ7exVj@hovoldconsulting.com>
 <ecfe850c-b263-4bee-b888-c34178e690fc@quicinc.com>
 <Z9gd9Aw5Bug8IKSV@hovoldconsulting.com>
 <f30cf771-a9cd-4d8f-8d10-1640afd33c23@quicinc.com>
 <Z9mwn3GzpPPZSiTG@hovoldconsulting.com>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <Z9mwn3GzpPPZSiTG@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=b+uy4sGx c=1 sm=1 tr=0 ts=67da6875 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=NEAV23lmAAAA:8 a=SdDGcHOF2Uqb6CuH5E0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: xdbP3m1r4BOFb-k3aPoIXCkFAIrdq0b9
X-Proofpoint-GUID: xdbP3m1r4BOFb-k3aPoIXCkFAIrdq0b9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_02,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190045



On 3/19/2025 1:42 AM, Johan Hovold wrote:
> On Tue, Mar 18, 2025 at 03:53:39PM +0800, Miaoqing Pan wrote:
>> On 3/17/2025 9:04 PM, Johan Hovold wrote:
> 
>>> Then it seems we are looking at two separate root causes for the
>>> corruption as the memory barrier appears to be all that is needed to fix
>>> the X13s issue.
>>>
>>> A user who hit the corruption after 2 h without the fix has been running
>>> over the weekend with the memory barrier without any problems. I'll ask
>>> further users to test, but it certainly looks like it is working as
>>> intended.
>>>
>>> And the memory barrier is de-facto missing as the head pointer and
>>> descriptor are accessed through (two separate) coherent mappings so
>>> there are no ordering guarantees without explicit barriers.
>>
>> This situation should occur when there is only one descriptor in the
>> ring. If, as you mentioned, the CPU tries to load the descriptor first,
>> but the descriptor fetch fails before the HP load because the ring
>> returns empty, it won't trigger the current issue.
> 
> It could if the CPU observes the updates out of order due to the missing
> barrier. The driver could be processing an earlier interrupt when the
> new descriptor is added and head pointer updated. If for example the CPU
> speculatively fetches the descriptor before the head pointer is updated,
> then the descriptor length may be zero when the CPU sees the updated
> head pointer.
> 

Sorry, I still think this situation won't happen. Please see the 
following code.

ath11k_hal_srng_access_begin(ab, srng);
   => srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
   => if (srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp) return NULL;
//dma_rmb();
*nbytes = ath11k_hal_ce_dst_status_get_length(desc);

If the condition 'srng->u.dst_ring.tp == srng->u.dst_ring.cached_hp' is 
true, the descriptor retrieval fails.

> This seems to be what is happening on the X13s since adding the memory
> barrier makes the zero-length descriptors go away.
> 

Hmm, it is indeed a bit strange. Could it be that dma_rmb() introduces 
some delay ?

>> The Copy Engine hardware module copies the metadata to the Status
>> Descriptor after the DMA is complete, then updates the HP to trigger an
>> interrupt. I think there might be some issues in this process, such as
>> the lack of a wmb instruction after the copy is complete, causing the HP
>> to be updated first.
> 
> Yeah, possibly. At least it seems there are more issues than the missing
> barrier on the machines you test.
>   
>>> Now obviously there are further issues in your system, which we should
>>> make sure we understand before adding workarounds to the driver.
>>>
>>> Do you have a pointer to the downstream kernel sources you are testing
>>> with? Or even better, can you reproduce the issue with mainline after
>>> adding the PCIe patches that were posted to the lists for these
>>> platforms?
>>>
>> https://github.com/qualcomm-linux/meta-qcom-hwe/blob/scarthgap/recipes-kernel/linux/linux-qcom-base_6.6.bb
> 
> Thanks for the pointer. That's a lot of out-of-tree patches on top of
> stable so not that easy to check the state of the resulting tree.
> 

Yes, but there are only a few patches for ath11k.

>>> Does it make any difference if you use a full rmb() barrier?
>>>
>> I've also tried rmb() and mb(), but they didn't work either.
> 
> Thanks for checking.
> 
> Just to be sure, you did add the barrier in the same place as my patch
> (i.e. just before the descriptor read)?
> 

Yes.

>>> And after modifying ath11k_hal_ce_dst_status_get_length() so that it
>>> does not clear the length, how many times you need to retry? Does it
>>> always work on the second try?
>>
>> Yes, the test has been running continuously for over 48 hours, always
>> work on the second try, updated in patch v4.
> 
> Good, at least the descriptor-length-sometimes-never-updated issue is
> solved.
> 
> Johan

Yeah, thanks for pointing out the issue.

