Return-Path: <linux-wireless+bounces-23732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EEEACEB96
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 10:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4319169116
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Jun 2025 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E53204F93;
	Thu,  5 Jun 2025 08:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eb4jo6tr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270F8201113;
	Thu,  5 Jun 2025 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749111416; cv=none; b=OTaDn94VUzntwLSmgD7BQ0XlK5a02Jy2XCPFG3FhMBFy3LgY6KE2a0CqbqmEX39f8tyEKylGB6/ioZvYtB1TPCvL3zgwNvyxs97Ykvu8zK4NPL+7pdp47Tkstbm5/0+/ycHapjeVGdd9Jwp8W9+cc0u3ZncGrShvETA6dCMvJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749111416; c=relaxed/simple;
	bh=C697xSsm4UoU9t4w2FzhrIP8zlOmySiSDFcjITSsCK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MkXEEEdPIt2o+7ydpxyzDm4TUdcRnjSgJ5Z1+e5Jg2TL4+I3z+tzLGKzJaPCoGXPHgR0zE13gqSKd5+WK2hQvj+6vu9/DItqM1NwwvMAx26yy0LQKkKmFEWUunjto7EBHyKNRLQp2btBSIJ1hTL8H49WlHnAtSOR7IcQKIsa9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eb4jo6tr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5557XrXI010823;
	Thu, 5 Jun 2025 08:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ROq21nMybxo6NcuUuGMrfuOyLnzm0kJGjsT2y+rqPLQ=; b=eb4jo6trGx29KRb6
	HA/LKxRNIFwPEaerJOWq1cIor3ownXEPqUa09DkNn8GVZXSfKw4CLGTjUPk6w+xz
	ue5E+zbia4b5ND8n/3666XxoxTXn18J5KfYHpNnDcJA/pX64OjZMFjLtZzRotsTa
	Ej+w/UAWRv7rRJ4FNQ1CBdKlHxjQLQKLpaYPTQ/fz+5kpzEpgGBL2tenBUR8SCuB
	fBputsP+0qO349xnBPMJhRJsPVaNAtoJFi6xU/JZYQn4u4SFB7WYqxrPrTLd0Vo9
	7sI//2Q/xQ7HoNU5gJoLwyDUyN9RQxID1MFlRchbI5RdVqLbbKxZO+x+a/NPg4Yd
	SP8BFA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8yrm3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Jun 2025 08:16:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5558GbBw003840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 5 Jun 2025 08:16:37 GMT
Received: from [10.253.10.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 5 Jun 2025
 01:16:35 -0700
Message-ID: <0df9dde2-c713-46a2-a4fc-4b033586a524@quicinc.com>
Date: Thu, 5 Jun 2025 16:16:32 +0800
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
 <b303ba1c-b521-44b4-9afc-cf1766f549ee@quicinc.com>
 <aD_utNk4q23ewRAC@hovoldconsulting.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <aD_utNk4q23ewRAC@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3MSBTYWx0ZWRfX8lqr3Zqtto1D
 u5woHpAhNRIEt/idsDoOihzcyBqZDBRrPOqWcoR9GyAedqIo+0/m1UWIaF6royaVkdf7bZvjum+
 LkLd/WuOl+ys+Trep/OAGWNsPznt4xuukNPsvmXC0hWbIBUZSK4II7yPiPTjbCpk6Bt792sl66f
 SKFGM7p4pE5grVHr7BYqfSgeKz0l7nGEgf3k1IoUrFvC6zA80miIv8iF2F9E0YeXtePApFtBe84
 GWNBs8DOMQYW2Y9Z2+W8NyNEPO3KQaoQm2b7hRF+qhUFchZcH18ZZpFT2gqKzKr5ueUmSMcyeY/
 vui8/+M7RnDuHk8W337+cOP30yuQFoGnjUxTfhgn10L/aIeHb7ZC54S6ZOWkCkN3ET1u/hytkCj
 SwgvJEGLAzogs1wCksAPXV71w0ZqKVT8yH3kjRHpereBwOimJ8fZ7qB1z/RxozQ7ua57NJFb
X-Proofpoint-ORIG-GUID: TH4knFscO3EaqjCgLo5V9nXiJpckja4G
X-Proofpoint-GUID: TH4knFscO3EaqjCgLo5V9nXiJpckja4G
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=68415266 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=fXt-iZKTwfGWLZf-0R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=557 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506050071



On 6/4/2025 2:59 PM, Johan Hovold wrote:
> On Wed, Jun 04, 2025 at 10:16:23AM +0800, Baochen Qiang wrote:
>> On 6/3/2025 7:51 PM, Johan Hovold wrote:
>>> On Tue, Jun 03, 2025 at 06:52:37PM +0800, Baochen Qiang wrote:
>>>> On 6/2/2025 4:03 PM, Johan Hovold wrote:
>>>
>>>>> No, the barrier is needed between reading the head pointer and accessing
>>>>> descriptor fields, that's what matters.
>>>>>
>>>>> You can still end up with reading stale descriptor data even when
>>>>> ath11k_hal_srng_dst_get_next_entry() returns non-NULL due to speculation
>>>>> (that's what happens on the X13s).
>>>>
>>>> The fact is that a dma_rmb() does not even prevent speculation, no matter where it is
>>>> placed, right?
>>>
>>> It prevents the speculated load from being used.
>>
>> Sorry, still not get it. To my knowledge whether the speculated load (steps 3 and 4) would
>> get used depends on whether the condition check pass in step 2. How does a dma_rmb() make
>> any difference in this process?
> 
> It orders the two loads from the device so that the descriptor is not
> (speculatively) loaded before the head pointer.

I was thinking we need barrier_nospec() here to prevent speculatively load, instead of (or
in addition to) dma_rmb().

But, seems I was wrong. Even the kernel doc [1] talks about the ordering brought by dma_rmb()

	if (desc->status != DEVICE_OWN) {
		/* do not read data until we own descriptor */
		dma_rmb();

		/* read/modify data */
		read_data = desc->data;
		[...]
	}

     The dma_rmb() allows us to guarantee that the device has released ownership
     before we read the data from the descriptor

So a single dma_rmb() should be enough.

> 
> When the CPU sees the updated head pointer it may otherwise proceed with
> using stale descriptor data. The barrier prevents this.
> 
> Johan

[1] https://www.kernel.org/doc/Documentation/memory-barriers.txt


