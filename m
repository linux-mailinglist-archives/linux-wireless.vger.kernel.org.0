Return-Path: <linux-wireless+bounces-16229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9009EC241
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 03:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A305282B2E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A841FCCF2;
	Wed, 11 Dec 2024 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KtkgDgVx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30E01FCCFD
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 02:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733884307; cv=none; b=jx1+aZAhM7/Lr9ximNHpvXNmKgVw3nqelmxANPFl8vVB4/9QH7b6aEywijWVG1OVw9aec2ud6qEBAMxJLlR4JYxNRVeP48D24ag3Yb2QqJSEoLYcyvSh4Vhe14/T1xH/xGyl/dzTgZf+hU8d0mmVsLhNY4duWq55skT6FpVW9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733884307; c=relaxed/simple;
	bh=nt+HTDgYxOVTdeJgLR7i8ybNsexGO3q814SnR/l06OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fYkKqh3Qk5P82q2ZNyvNmfr5K7buI8SOXBsHyp6OLZa8pRBxTm/Q6XVop2ptz9ZIhaFNbrFFd3iQA3OOnbiEy29uqjbmMwAWXC7D5Jy6D6yglo/g7X0LGwqOm/sG4uWbZkH5aCzlSwiq4CM9vETz4hnm8r1ZHNPuS7l9NkgjjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KtkgDgVx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAF82LQ030874;
	Wed, 11 Dec 2024 02:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJ4/4F4JNJmG41KLFAewschP079+tEh24O/wOSrqZhQ=; b=KtkgDgVx1Aqm0o+u
	6iRX897PFHFo7WmhdgCB2T/mgCSK8OWntie9gk1cuv+LBNdOWkDYnwq2cgVGZEZR
	HASJkS+Sx/S9fHC0GCAiqDSem0Q+DXuMT96PfZlwMdkR7bgyxU66DYZqZ0A0HENq
	zVx6dW3S96OQUKr4kOIiMoGbeGbR+N5TgSndqfxDEW/Bjr0311JKKIEqFexdoWE+
	h/eGHX1vzpCqcoNs8eQNRvF0p5wQr1/C+hHIm/+jQBU+0GjyebYSDzxTJZhxcFGX
	QTwIwwPHJtHOOTCw0/oiwS046Td0pVb6Hws6vjHRsJzopK7mysAFiea6KIpXfvNz
	dE85DQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eg9ek5p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 02:31:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BB2VT8i004462
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 02:31:29 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 10 Dec
 2024 18:31:27 -0800
Message-ID: <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com>
Date: Wed, 11 Dec 2024 10:31:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Tim Harvey <tharvey@gateworks.com>, Christoph Hellwig <hch@lst.de>
CC: Robin Murphy <robin.murphy@arm.com>, <ath11k@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Fabio Estevam
	<festevam@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>, <iommu@lists.linux.dev>
References: <CAJ+vNU0EL3T+GyNAbVbGqYYQ5NM3h7cgAwqxxBMuZjh+-YQ3bA@mail.gmail.com>
 <1b2ea8b2-6fbe-4118-b6c6-742c8f0be476@quicinc.com>
 <CAJ+vNU1-OZ3y4p2L+zf64AiVtUv70yZNqkT20jTxyE0_gJb6Jg@mail.gmail.com>
 <0282be95-9094-4d49-b79e-4f7c976dad00@quicinc.com>
 <CAJ+vNU32EMHjtchJRb1sODBrUKG2vZW4ZEu1_F0+dCCEjCn7Dg@mail.gmail.com>
 <20241209081714.GA25363@lst.de>
 <593c0d63-d8fd-4439-a57a-97340212c197@arm.com>
 <CAJ+vNU2ypE_Mn_6iKCmf5LYk9Sth=ryWXyewc5MhOKK8VoAKCA@mail.gmail.com>
 <20241210041133.GA17116@lst.de>
 <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <CAJ+vNU03Cqsc+O5anwmvJW8Wfd-06LbDMVHjxVFdixf01ZLczQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s3MXoqu9gS9pQ18AhbXzfYgemfaB70Sa
X-Proofpoint-ORIG-GUID: s3MXoqu9gS9pQ18AhbXzfYgemfaB70Sa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=807 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412110019



On 12/11/2024 7:06 AM, Tim Harvey wrote:
> On Mon, Dec 9, 2024 at 8:11 PM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
>>> After a lot of back and forth and investigation this is due to the
>>> IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
>>> is requesting some buffers that are too large for swiotlb to provide.
>>> There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
>>> to cacheable memory that could be reverted to fix this but the concern
>>> was that it would impact performance moving those buffers to
>>> non-cacheable memory (there are three ~1MiB buffers being allocated):
>>> commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
>>> cacheable memory").
>>
>> The combination of "buffers" and "swiotlb" sounds like Robin was right
>> below.
>>
>>> The chain of events as best I can tell are:
>>>
>>> commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
>>> cacheable memory")
>>> - Nov 12 2021 (made it into Linux 5.17)
>>> - changes allocation of reo_dst rings to cacheable memory to allow
>>> cached descriptor access to optimize CPU usage
>>> - this is flawed because it uses virt_to_phys() to allocate cacheable
>>> memory which does not work on systems with an IOMMU enabled or using
>>> software IOMMU (swiotlb); this causes a kernel crash on client
>>> association
>>
>> And this is where it started to take a wrong turn, that everyhing
>> later basically made worse.  If you have long living and potentially
>> large DMA allocations, you need to use dma_alloc_* interfaces.
>>
>> 5.17 already had dma_alloc_pages for quite a while which was and still is
>> the proper interface to use.  For much older kernel you'd be stuck
>> with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
>> but even that would have been much better.
> 
> Christoph,
> 
> I'm not clear what you are suggesting be done here. Are you suggesting
> that ath11k has been using the wrong mechanism by calling
> dma_map_single for cached DMA buffers? I'm not all that familiar with
> ath11k so I can't tell what buffers are considered long living.

those buffers are allocated when driver load and freed when driver unload, so IMO they are
long living.

> 
> Best Regards,
> 
> Tim


