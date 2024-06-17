Return-Path: <linux-wireless+bounces-9136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E664390BD08
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 23:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA84283DBD
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 21:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A11190693;
	Mon, 17 Jun 2024 21:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QZurCP5p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0EB8480
	for <linux-wireless@vger.kernel.org>; Mon, 17 Jun 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718660366; cv=none; b=AmqVGOhNlr1v/DcBqB0s0mFSSA77RKjieC037mx7NVC/Q5ZDtYOO+MEY4/hU4zQi10MlIB9n+ll1vIuljLmWJqgjNCLW/1SU8BQpP+XVQ6RHTcNBrKP17qIBpoqfStMor7onE28eKfzS78IMWfstBm8PI+PmzlvxSaQxmfeuMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718660366; c=relaxed/simple;
	bh=aovGyNUWeGVUX5HC/wkuf6v1hvzmp+u0ZofBjzZG3RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CY77Sx2PZS4O5m+yATV3zHiMreaJ4naLKaRim7Ng6BYe1/vQqmEm1NASe3fEg1LrSu0GLbVTDetq+tZQH2yreOsrJxhyz1d4wmdbPS8d/61CE9s0mRptnAzhUR3Fn3pNxFBnquR5uZ2c2QUXinN6+DF+xlkrfURgI71iSdoLDNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QZurCP5p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HAjaR8002135;
	Mon, 17 Jun 2024 21:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9NbeHXEErNBY2VLi/FKG3KB3c3jw5WRugKv6LT1HXJw=; b=QZurCP5pOGyAKs1C
	2xvypFrO2uD5OPwn11FvFJA9hQFhFQXNSS13kiyozGtaG1hOh1jcNLCnZSZnxmhh
	cC5hidIrIQQz2i3eBhbopZvnz9iKS0ZtVTOHZ4r2rxJTLuWKe++VomGsIp/vi/iW
	Vmq/4MSYQbayDkVeWbUomh/DPFYpuxIzkXuqAk/F0FRNUlNajAP1/6PxSwNjHaP6
	DINr64/VvyAsLwz3yhDsSST20E4uRAR4SoFw3zbAiVY5V+gSV6F+TL6zTCwJCFBm
	6NNTxtIFsaTlRZOe/hGRwrEXYZRdg8gSXk/sffvm4tH7shBmboTkd966dKs55DCx
	HBjkyg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys31u4vxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 21:39:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45HLdHoX011931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 21:39:17 GMT
Received: from [10.48.243.231] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 17 Jun
 2024 14:39:17 -0700
Message-ID: <255df1aa-8d06-4d6e-82f0-577aff3ebe5f@quicinc.com>
Date: Mon, 17 Jun 2024 14:39:16 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] wifi: ath: create common testmode_i.h file for ath
 drivers
Content-Language: en-US
To: Aaradhana Sahu <quic_aarasahu@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240617052903.2720292-1-quic_aarasahu@quicinc.com>
 <20240617052903.2720292-2-quic_aarasahu@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240617052903.2720292-2-quic_aarasahu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lFHwbMqy6TMt06kkGXRH9CPfroouXNhi
X-Proofpoint-ORIG-GUID: lFHwbMqy6TMt06kkGXRH9CPfroouXNhi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=625 bulkscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406170167

On 6/16/2024 10:29 PM, Aaradhana Sahu wrote:
> User space application requires that the testmode interface
> is exactly same between ath drivers. Move testmode_i.h file
> in ath directory to ensure that all ath driver uses same testmode
> interface instead of duplicating testmode_i.h for each ath drivers.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00210-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath11k/testmode.c    | 78 +++++++++----------
>  .../wireless/ath/{ath11k => }/testmode_i.h    | 54 ++++++-------
>  2 files changed, 66 insertions(+), 66 deletions(-)
>  rename drivers/net/wireless/ath/{ath11k => }/testmode_i.h (50%)
> 
...
> diff --git a/drivers/net/wireless/ath/ath11k/testmode_i.h b/drivers/net/wireless/ath/testmode_i.h
> similarity index 50%
> rename from drivers/net/wireless/ath/ath11k/testmode_i.h
> rename to drivers/net/wireless/ath/testmode_i.h
> index 91b83873d660..ac852642bde1 100644
> --- a/drivers/net/wireless/ath/ath11k/testmode_i.h
> +++ b/drivers/net/wireless/ath/testmode_i.h
> @@ -1,59 +1,59 @@
>  /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>  /*
>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.

this should be
 * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.

>   */


