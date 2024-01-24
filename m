Return-Path: <linux-wireless+bounces-2426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB0839F3F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 03:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 691EF1C209DF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jan 2024 02:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DC1396;
	Wed, 24 Jan 2024 02:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZNFxpPNK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3A4402
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jan 2024 02:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706063753; cv=none; b=sBWW4Fjv/32QwD/e2S1Sg36MdPqVt6zfpHNsZ7c54uby20YJsDk39fbGJrHpMgCGl02yleM5lC6ST6mlQqGe5S/I8RnKA14Ob9jOjcmswOGRC6FcnD7m0dFIY0tVonlJ6m2BgweCqu8e0Plwgw9U9CoFwNqMLjl3O2wofQNRtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706063753; c=relaxed/simple;
	bh=V2JkuXA8837nNqsegGaG8tSgfcWnNh/97F7SHcfJtK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=A4ru0LTtouTdbDOaVaa2vE1oYyXuG3Wpq47ElnIcL5WS/A7reFLfOqLWQnuA1O7jQ/tg5cjZqNyA/hICyj8i0dJzaKUFIImxCrZtlxuQivVZ14t9Y2r+X/ZMNgWKqGO7QehTaLw1BFF98p7AV6TtDsc4PQZS34KkWCud0PZl8xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZNFxpPNK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O1MLnP027786;
	Wed, 24 Jan 2024 02:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ry6TUcO/tVaxpVzOT+I1siLRRNkF5Nd5FE83y4j4sJU=; b=ZN
	FxpPNK15YyHwLdBcYyWh8L57Ud8dQNWpKozngB2PP+5nUi4TNaLcldXe1b+RV+X+
	0ASb+I5SlszpYqxnB9rlcnUBbwXYbukwd56WwpNWKh2uv7Qk9GRKLA6ODc3/bUcu
	cOuZmrlc88KGJRDEmd+bYXjSRMPlTilRL0e8RDp1zbrWxBj/Ir7EcDwiNfER0FDE
	nB+ZX4ylNWg4jwUJGCxJQglCcx6tYh3H/zhDgD5QKq58KvM6lfIF723Y4k01JuyT
	SvZAC7WW7aHKv7/YZOARUQuVGSVRd8cCYH1wYFkqjCf+7U4bM/CMuSA3z3uRVdW/
	5WEcqErhKD/dv+z2plTw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vtmmegj6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:35:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40O2Zm3Z019378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 02:35:48 GMT
Received: from [10.110.18.75] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 18:35:47 -0800
Message-ID: <73e9ddd2-7c0c-4a96-a120-7480ebffc4f0@quicinc.com>
Date: Tue, 23 Jan 2024 18:35:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: enable 36 bit mask for stream DMA
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240123015201.28939-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240123015201.28939-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yyhLIKeTVocZkE2UvWO9haVYNpg7V10P
X-Proofpoint-ORIG-GUID: yyhLIKeTVocZkE2UvWO9haVYNpg7V10P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_15,2024-01-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401240018

On 1/22/2024 5:52 PM, Baochen Qiang wrote:
> Currently 32 bit DMA mask is used, telling kernel to get us an DMA
> address under 4GB when mapping a buffer. This results in a very high
> CPU overhead in the case where IOMMU is disabled and more than 4GB
> system memory is installed. The reason is, with more than 4GB memory
> installed, kernel is likely to allocate a buffer whose physical
> address is above 4GB. While with IOMMU disabled, kernel has to involve
> SWIOTLB to map/unmap that buffer, which consumes lots of CPU cycles.
> 
> We did hit an issue caused by the reason mentioned above: in a system
> that disables IOMMU and gets 8GB memory installed, a total of 40.5%
> CPU usage is observed in throughput test. CPU profiling shows nearly
> 60% of CPU cycles are consumed by SWIOTLB.
> 
> By enabling 36 bit DMA mask, we can bypass SWIOTLB for any buffer
> whose physical address is below 64GB. There are two types of DMA mask
> within struct device, named dma_mask and coherent_dma_mask. Here we
> only enable 36 bit for dma_mask, because firmware crashes if
> coherent_dma_mask is also enabled, due to some unknown hardware
> limitations. This is acceptable because coherent_dma_mask is used for
> mapping a consistent DMA buffer, which generally does not happen in
> a hot path.
> 
> With this change, the total CPU usage mentioned in above issue drops
> to 18.9%.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/mhi.c |  2 +-
>  drivers/net/wireless/ath/ath11k/pci.c | 16 +++++++++++++---
>  drivers/net/wireless/ath/ath11k/pci.h |  1 +
>  3 files changed, 15 insertions(+), 4 deletions(-)
My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath11k/mhi.c copyright missing 2024
drivers/net/wireless/ath/ath11k/pci.c copyright missing 2024
drivers/net/wireless/ath/ath11k/pci.h copyright missing 2024

Kalle can fix this in the pending tree, actual code LGTM
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


