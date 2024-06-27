Return-Path: <linux-wireless+bounces-9663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5486F91ABBE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 17:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0958C280EF6
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE28196D9E;
	Thu, 27 Jun 2024 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ktGRnu04"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F392722EF2
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 15:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503234; cv=none; b=I6UvklmrLIM1pdE5FqeCcCCWF4AO8GACZzuQjWHmUqWoBXK+L7bit8Bca5BQTw4OZT0WxgTu8KXrgMM+KmCZ6Wk+UZjPyIcIUJlDo6zAfKZanyBpmatM704imALTwUyFHYq9474ySNGwJpiiPjvYZmrH0hYi2LGwQ6tfEQJtALQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503234; c=relaxed/simple;
	bh=LUIcEJ2xkG5/kMPmWvdxpZJaV1orkS761/E+wTZY7TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UmglNaq8sHu874IF2rZ1j7Ax3S4D1VynOvShvE7kN5huCamuMqlMonoK0XIHL6X7Y6WWqXdcqii1sDXHjMSfjYWSdD+lS722CvNNgoEaQLw2mtRYtN4t6oJpfZBT3vYz8GndVeHGX/odFHGoDDF2LkBQX6W2zQ46hQfbHoZxaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ktGRnu04; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RCIjFE018101;
	Thu, 27 Jun 2024 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mVOVBfdqQprsKsyswS3jcsOHHYDMlcUGrezJBVaWUcc=; b=ktGRnu049WE5saie
	rzSIurgzc/cMcZeqVKqggw81BrXnJ3QoOiEvH4VG6WHeaJarhuLxL4fvakwSH/83
	tWxKW408lUotCnWV1opq+3f9/LIFSF6AcoFMPh91hZpEapELD22eUQ1UVadxpUd4
	xI9fzWKQfn3C5BxS9dYWeHNHl8/CdGdCvIF6RGwTLBe/gnqJl9kMe6dnTVT6aF7D
	WWedktK83nNOuo+MRaddrxMUnTFIlFN30VHVRLUJ0yz7kxnc/PHAeFmP3J7DgQLT
	/qLf0ehzcaHmC6NVURrapKb6fiP+bX0EqHHpzjdy8LmP2ul20h4NXNlPEM7WON+/
	SCRBeQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywppvce8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:47:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45RFl6qm031416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jun 2024 15:47:06 GMT
Received: from [10.110.11.227] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 27 Jun
 2024 08:47:06 -0700
Message-ID: <1624b548-334e-4391-a8e9-ff2aa5d81f80@quicinc.com>
Date: Thu, 27 Jun 2024 08:46:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3]wifi: ath12k: Add firmware coredump collection support
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>
References: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
Content-Language: en-US
From: Sidhanta Sahu <quic_sidhanta@quicinc.com>
In-Reply-To: <20240325183414.4016663-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MJpB4J0aNsjN90Sbrwjgc08ROZ716MmF
X-Proofpoint-ORIG-GUID: MJpB4J0aNsjN90Sbrwjgc08ROZ716MmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_12,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406270119



On 3/25/2024 11:34 AM, Sowmiya Sree Elavalagan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55 MB
> approximately.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
> ---
> v2:
>    - Fixed errors shown by ath12k-check
> v3:
>    - Fixed SPDX comment style for coredump.c file
>      Changed Kconfig description.
> ---
>   drivers/net/wireless/ath/ath12k/Kconfig    |  10 ++
>   drivers/net/wireless/ath/ath12k/Makefile   |   1 +
>   drivers/net/wireless/ath/ath12k/core.c     |   2 +
>   drivers/net/wireless/ath/ath12k/core.h     |   5 +
>   drivers/net/wireless/ath/ath12k/coredump.c |  51 ++++++
>   drivers/net/wireless/ath/ath12k/coredump.h |  80 +++++++++
>   drivers/net/wireless/ath/ath12k/hif.h      |   9 +-
>   drivers/net/wireless/ath/ath12k/hw.c       |   4 +-
>   drivers/net/wireless/ath/ath12k/mhi.c      |   5 +
>   drivers/net/wireless/ath/ath12k/mhi.h      |   4 +-
>   drivers/net/wireless/ath/ath12k/pci.c      | 185 +++++++++++++++++++++
>   11 files changed, 351 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/net/wireless/ath/ath12k/coredump.c
>   create mode 100644 drivers/net/wireless/ath/ath12k/coredump.h
> 


> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 391b6fb2bd42..f0cc4959faf5 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1121,6 +1121,7 @@ static void ath12k_core_reset(struct work_struct *work)
>   	reinit_completion(&ab->recovery_start);
>   	atomic_set(&ab->recovery_count, 0);
>   
> +	ath12k_coredump_collect(ab);

1. Can we confirm if the operation guarantees that the coredump has been 
successfully uploaded upon its completion? It would be helpful to 
understand the expected behavior of the system in the event of a 
successful or unsuccessful upload.

2. Is it safe to proceed with memory cleanup operations immediately 
after this call? Understanding the dependencies and potential risks 
associated with memory cleanup post-upload would be beneficial for 
maintaining system stability and avoiding potential issues.

>   	ath12k_core_pre_reconfigure_recovery(ab);
>   
>   	reinit_completion(&ab->reconfigure_complete);
> @@ -1220,6 +1221,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
>   	INIT_WORK(&ab->restart_work, ath12k_core_restart);
>   	INIT_WORK(&ab->reset_work, ath12k_core_reset);
>   	INIT_WORK(&ab->rfkill_work, ath12k_rfkill_work);
> +	INIT_WORK(&ab->dump_work, ath12k_coredump_upload);
>   
>   	timer_setup(&ab->rx_replenish_retry, ath12k_ce_rx_replenish_retry, 0);
>   	init_completion(&ab->htc_suspend);

