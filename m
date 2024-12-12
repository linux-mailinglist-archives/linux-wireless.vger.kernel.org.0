Return-Path: <linux-wireless+bounces-16288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5DB9EDEBC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 06:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209F81889B33
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 05:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287CE15C15E;
	Thu, 12 Dec 2024 05:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nxfPyYpr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED840152196
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 05:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733981111; cv=none; b=uVkAubQ3U9Y3dUW3OhyGXsB5Ny12HTyIz+K97jUjRU79dmi7oAlGxN9+PRxwLvgLDl2GciI8KK7Ea3PPrNxPGOtxjD7FxNPsd4A6ULc6YacQkHnV+iZxUxFy/2Er3P3BAYRh0NwScRHZ8zjfh/0o0I2sj8XRKabXvYPtYlCgdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733981111; c=relaxed/simple;
	bh=SgFBayqejWCx9ISB0P2ggd1prI3UXd/nQ6plu9oT9Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Mome7Dzh+nXcrBhwgQDj6wsD+n7NHHy4yBbiisgF7oYvxUbXxe0TdQZBWkahpl4s4XGrM0mwo0lYRiCM//AEIB7D+xGDMZ5KKXC674jxwo+DepEZ1gjnZvGgw5bDm3/XytS1u2317wI7mUBAhGfJwjgiXeCPeMsRH70xvYAyZfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nxfPyYpr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHjejI018816;
	Thu, 12 Dec 2024 05:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	da2ob7paYwwBsbs1CjtgSbAnN/c4QPrRkJNL3VpquTM=; b=nxfPyYprQk2QPr3U
	m3Y1tuYNnUe/2HEobbRJ1j/XebBlBlcG9ntpMlpn1BEwX322ddV8v1Bvkf2YasMO
	4fdh7rnk+KCqmqFgT6Nk1uS8P/ydWQNh23Gqgv1c82o7cAES5mIdpQFpV9uxOhAU
	eDpbFKo7yxcFTr4PTEtQ6UVQ/qmCw2j/WxfxQPkHg6q01T2p/H7za+nU1gfoTbrm
	g+1J9vnF/7MTTp+4rUzzH8j7dQ7l4/45Ing9Vti/xHcNJBu5Q/J9IEFYeB7W3fD/
	jhiLBnnH78w6/0GEeEUW/EqHPoARigWDIxm9jv5NGNMrLKVxypsQrWrcjSbf23UI
	moD04Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ffdysc71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 05:24:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC5Onfh028162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 05:24:49 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Dec
 2024 21:24:47 -0800
Message-ID: <80992ae5-e329-4a34-94c8-9345b2e8a9a0@quicinc.com>
Date: Thu, 12 Dec 2024 13:24:45 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k swiotlb buffer is full (on IMX8M with 4GiB DRAM)
To: Robin Murphy <robin.murphy@arm.com>, Tim Harvey <tharvey@gateworks.com>,
        Christoph Hellwig <hch@lst.de>
CC: <ath11k@lists.infradead.org>,
        linux-wireless
	<linux-wireless@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Marek
 Szyprowski <m.szyprowski@samsung.com>, <iommu@lists.linux.dev>
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
 <5fe372df-ae51-4a8b-9fa3-a4a0ea2d33e3@quicinc.com>
 <9b2e8ffa-ba2c-46da-a478-eb1fb44b693e@arm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <9b2e8ffa-ba2c-46da-a478-eb1fb44b693e@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MyCwuV5Xo1usK8DSR4uY-XEznIn5o22C
X-Proofpoint-GUID: MyCwuV5Xo1usK8DSR4uY-XEznIn5o22C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxlogscore=906 lowpriorityscore=0 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412120034



On 12/11/2024 9:44 PM, Robin Murphy wrote:
> On 2024-12-11 2:31 am, Baochen Qiang wrote:
>>
>>
>> On 12/11/2024 7:06 AM, Tim Harvey wrote:
>>> On Mon, Dec 9, 2024 at 8:11 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> On Mon, Dec 09, 2024 at 11:15:02AM -0800, Tim Harvey wrote:
>>>>> After a lot of back and forth and investigation this is due to the
>>>>> IMX8M SoC's not having an IOMMU thus swiotlb is being used and ath11k
>>>>> is requesting some buffers that are too large for swiotlb to provide.
>>>>> There is a specific patch which added the HAL_WBM2SW_RELEASE buffers
>>>>> to cacheable memory that could be reverted to fix this but the concern
>>>>> was that it would impact performance moving those buffers to
>>>>> non-cacheable memory (there are three ~1MiB buffers being allocated):
>>>>> commit d0e2523bfa9cb ("ath11k: allocate HAL_WBM2SW_RELEASE ring from
>>>>> cacheable memory").
>>>>
>>>> The combination of "buffers" and "swiotlb" sounds like Robin was right
>>>> below.
>>>>
>>>>> The chain of events as best I can tell are:
>>>>>
>>>>> commit 6452f0a3d565 ("ath11k: allocate dst ring descriptors from
>>>>> cacheable memory")
>>>>> - Nov 12 2021 (made it into Linux 5.17)
>>>>> - changes allocation of reo_dst rings to cacheable memory to allow
>>>>> cached descriptor access to optimize CPU usage
>>>>> - this is flawed because it uses virt_to_phys() to allocate cacheable
>>>>> memory which does not work on systems with an IOMMU enabled or using
>>>>> software IOMMU (swiotlb); this causes a kernel crash on client
>>>>> association
>>>>
>>>> And this is where it started to take a wrong turn, that everyhing
>>>> later basically made worse.  If you have long living and potentially
>>>> large DMA allocations, you need to use dma_alloc_* interfaces.
>>>>
>>>> 5.17 already had dma_alloc_pages for quite a while which was and still is
>>>> the proper interface to use.  For much older kernel you'd be stuck
>>>> with dma_alloc_noncoherent or dma_alloc_attrs with the right flag,
>>>> but even that would have been much better.
>>>
>>> Christoph,
>>>
>>> I'm not clear what you are suggesting be done here. Are you suggesting
>>> that ath11k has been using the wrong mechanism by calling
>>> dma_map_single for cached DMA buffers? I'm not all that familiar with
>>> ath11k so I can't tell what buffers are considered long living.
>>
>> those buffers are allocated when driver load and freed when driver unload, so IMO they are
>> long living.
> 
> The point is that if this driver wants a notion of "cached DMA buffers", then it should
> allocate such buffers the proper way, not try to reinvent it badly. That means using
> dma_alloc_pages(), or modern dma_alloc_noncoherent() which is essentially the same thing
> but with the dma_map_page() call automatically done for you as well.

yeah, you are right, Robin. didn't know there are convenient interfaces like these already.

Tim, can you work out a patch then?

> 
> Thanks,
> Robin.


