Return-Path: <linux-wireless+bounces-6268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF408A355A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 20:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D2081C224F2
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 18:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F7214E2EF;
	Fri, 12 Apr 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Om/aul0L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50397148313
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712945131; cv=none; b=R7sqHHEr/Oy7CnQeQL6WJdnYLemjXPnLXK1m7StpfClxHjBwKJ+jl8lWn+B3NcflYO7D1rqvL8j0dB+hJVi4RU65LErDs5HqR9Z5sM7T7LjF5lBiLHOdxPQAo6t3VPpimh9pMLgQDvs+2clmw+clk3ctXAhHDakBLmdIHMFddNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712945131; c=relaxed/simple;
	bh=CMmZzDobQyRNlGAo/O8rAN8HIJMG0SC0XcT4YF/7MRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ilrT1xzBvagOBYrLo2YwVbQr3wXP9sZtwdazbxHy4OpyTtBFgTaBL7kQZ9iRBAgD6zSVgjvcQCNxfS+aKg0Xr8kXpyKmhDa4hItjveuD0zTOfMTouRm8q7WNwa65OTenuQsdzVV9zkg4eZksOlnGnegWtFvg9iCSFgLvsWpNCtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Om/aul0L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CEtv30000767;
	Fri, 12 Apr 2024 18:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=JMRuDMCMN+0Lx3D+OcNdIJJXhCZRAJFIDfDyf6HMhYY=; b=Om
	/aul0LN7qiosg7BSaV4XxVuo0Oeh5JcCaonckwQ0qUw0fF5fpQvtjH+VdNOwOhHD
	m9uqVqk00d6+NQxJ/IVVatVA3bk7SWryXq6ENULYHz2VdU2hhy+taV/5YyLQSNbp
	djfnBa8r08FhcTocaPrhByWZrdUxDCyyd1OhgLRufuCBOc45YyutPXLevXscJAgU
	RzWrVo7pW3um6gEgmSdbiYq3kF0pLYAAc4N1WHSD4qgyKM29b0RTHrXQUYmBEXIf
	vdF9Ztq4BWM4BqB1krTQ/kQf+quQfYV9thb36Ts8x+hx3M3LiG0QbhAO5hZC60yc
	4nUpP5KOZOkRbtcSVIFw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xf06phcem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 18:05:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43CI51VC031991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 18:05:01 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 12 Apr
 2024 11:05:01 -0700
Message-ID: <aea9f68d-4862-439c-a52f-d6463e6edca9@quicinc.com>
Date: Fri, 12 Apr 2024 11:05:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] wifi: ath12k: support suspend/resume
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: KZeWdr7L3bQiJ0ZCM1ODAk1vOJQzig1y
X-Proofpoint-GUID: KZeWdr7L3bQiJ0ZCM1ODAk1vOJQzig1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_14,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404120133

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> Now that the MHI&QRTR patches [1] are merged, we can add
> suspend/resume support for ath12k.
> 
> The whole design is quite similar to that in ath11k: firmware
> is powered down when going to suspend and powered up when
> resume, this makes hibernation work as well in addition to
> suspend.
> 
> To summary, this series first does some preparations in the
> first 8 patches. Then in patch [9/10] suspend/resume callbacks
> are implemented. And at last in [10/10] we enable suspend/resume
> functionality for WCN7850 because it's the only chip supporting
> it for now.
> 
> [1] https://lore.kernel.org/linux-wireless/20240305021320.3367-1-quic_bqiang@quicinc.com/
> 
> Baochen Qiang (10):
>   wifi: ath12k: rearrange IRQ enable/disable in reset path
>   wifi: ath12k: remove MHI LOOPBACK channels
>   wifi: ath12k: do not dump SRNG statistics during resume
>   wifi: ath12k: fix warning on DMA ring capabilities event
>   wifi: ath12k: decrease MHI channel buffer length to 8KB
>   wifi: ath12k: flush all packets before suspend
>   wifi: ath12k: no need to handle pktlog during suspend/resume
>   wifi: ath12k: avoid stopping mac80211 queues in ath12k_core_restart()
>   wifi: ath12k: support suspend/resume
>   wifi: ath12k: change supports_suspend to true for WCN7850
> 
>  drivers/net/wireless/ath/ath12k/core.c  | 108 ++++++++++++++----------
>  drivers/net/wireless/ath/ath12k/core.h  |   4 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c |  48 -----------
>  drivers/net/wireless/ath/ath12k/dp_rx.h |   2 -

My Qualcomm Innovation Center copyright checker reports:
drivers/net/wireless/ath/ath12k/dp_rx.h copyright missing 2024

>  drivers/net/wireless/ath/ath12k/hif.h   |  14 ++-
>  drivers/net/wireless/ath/ath12k/hw.c    |   2 +-
>  drivers/net/wireless/ath/ath12k/mac.c   |  28 ++++--
>  drivers/net/wireless/ath/ath12k/mac.h   |   1 +
>  drivers/net/wireless/ath/ath12k/mhi.c   |  91 +++++++-------------
>  drivers/net/wireless/ath/ath12k/mhi.h   |   5 +-
>  drivers/net/wireless/ath/ath12k/pci.c   |  41 +++++++--
>  drivers/net/wireless/ath/ath12k/pci.h   |   2 +-
>  drivers/net/wireless/ath/ath12k/qmi.c   |   3 +-
>  drivers/net/wireless/ath/ath12k/wmi.c   |   1 +
>  14 files changed, 175 insertions(+), 175 deletions(-)
> 
> 
> base-commit: 363e7193eaf258fe7f04e8db560bd8a282a12cd9

patch 6 of this series conflicts with:
wifi: ath12k: add support to handle beacon miss for WCN7850

So I was not able to take this series into my local verification tree

patch 7 of this series conflicts with:
wifi: ath12k: fix mac id extraction when MSDU spillover in rx error path

So this conflicts with a patch already in the pending branch

So FYI at some point you'll need to rebase.

