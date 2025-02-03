Return-Path: <linux-wireless+bounces-18305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D92A25EB6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 16:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE9BC1600E9
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 15:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E9433A4;
	Mon,  3 Feb 2025 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T2b5mlNh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F133224
	for <linux-wireless@vger.kernel.org>; Mon,  3 Feb 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738596634; cv=none; b=O7JhpYdFhoO/8lyuUUJDv74JeNvW+JW5rHftVYnfQMePIeDi9e5Rjf6I6NiMbH6TPMSGg/CMcOCPcp6WU3YaEv24ZmxzY3c+E/boQauuimSahpIPH6OKZV4HoNkMY+CfstIg/BBkH/7QOwxq8JUtJJwZaCKcrnk8soUBvXg2Vz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738596634; c=relaxed/simple;
	bh=LUPDn+wYtVowOFP2QYZW/s4aAOoOQnkIqzVnroJKp/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=khC27DI1mxrbe6kI71EPt//B6ZGxm8ZVLtZd1G5I5oLRmhJbyga4GnACmhGyCT0DsGhG4tzPrMoZcVHRuYxCZQZupQWHU8xChPcSs43H0L0lPda+zrJe7/2WBfkQQqmgyBYTmsl6/JMFmxT6VKVZ2MHgTfHaC46ukQxHhMFCTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T2b5mlNh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137GBqu003896
	for <linux-wireless@vger.kernel.org>; Mon, 3 Feb 2025 15:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VciPBYUYPORNNS50qwe9VB2Y5iqKnuU2gYQRV16KHJ4=; b=T2b5mlNhjZv8XLQU
	+9aGuvS+RWVQhJ2NRjggN8/8yVXuS9KNmExnPO52x6+G7X8Q0c8FDZXJA+FuZbjA
	Q5eXxuVkcOguXrR/nP5Svso2xudvMEWZovZUwuHvTP0jhOTGtX39mHsfssohmsNl
	TFck8P636uptfgH6GpMqQD8w0hDMrVzAXuNx4J48c9+QqFpS96LHavHSfJ5OY0+0
	KtVOlJxDEAE1ZUhOIGWjd91PJmr4+cuRYP3ZKDZMx0ZAeVnQvUXNUcRPzUeGmVGp
	3EWyQvvkz/zFwKOY+jzRQRSCNeh3JM+tPtCbOAxCkv94a3MIWRSjlXJT7JoJ0b7h
	aL8jAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44js8ts89h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 15:30:30 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ef9da03117so12834583a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 03 Feb 2025 07:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738596613; x=1739201413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VciPBYUYPORNNS50qwe9VB2Y5iqKnuU2gYQRV16KHJ4=;
        b=U5+UCgTf/xLDCuXPlmQAYtrm5aUrS5Frps4pQVZmBmtcmsIT4Awgma51ieIx17CvXZ
         jP2G+PyGIMULDl1/DByz6g+RGyzb+WmVzQ6ry5scbs7YzOA+42RHaNQ7DdiFmi5YSZH1
         9RSqUKf8ilW4fuRN8HatHWxpo2L7sn9d8wYOwNPakOWYEgOuUzd9Ie2QAQAOzhMTeUh/
         9cn4k0Y21Z5vCQsgOWIsr9TUhtwX4mF6qqL/r+03mZZ79z9eDz87kX8XaiSj7AmVWN0I
         zvUKaq85xjjcKEhlgEOWhDk1HZ3EQ3rR7woIVFCkMDh1Ejc1ZU1esj7y03qWp2Abrydt
         n7nw==
X-Gm-Message-State: AOJu0YzM5h1OISA8NPIbzGd5LOjnUsmJgKwgTcG3vTIhv8SycP7ztk9h
	nCdWMHgYRZTa4REBnwDPViW1vXNbIFWb+XfLn54N9GkAtyCg7C6PHJLv9r/ro0PRJRhhkRt9Tqv
	7asq9fevPscnLkEeQH6Rvc1bKsm4JzkaOcAKPTAA1uVaz0mn4HqLtAetKo445rDjqpg==
X-Gm-Gg: ASbGncsh/EcThHx2hTjkm+PWDNYDY19Ihl0gQlcakuoj1347vslbX+bRN6WeuqlSMaH
	U8vASSXveA+hdwuJI9sVC2y75SDlbW039nJfASVr/Tv05eNUNmLVXKIEpGl1GSDAEYKsrcrYpHM
	Ie+xgG/v54lxZVjYBGvCU7Trf8w349gdu04F1hprD7shFMjB7f+GqAQ4JP1lq09XgsJhp24gbev
	q33TbSgOgarXLnypxOsgfgJXFk+Cjc6ZjH/PbsFtqwG4u2GHb2C+INXdju34ID6uMtjJ86RLTVX
	7ProxtLpSdyjLHie7ICGB+zFV5GqU6g/iRe9V8E75A==
X-Received: by 2002:a17:90b:5201:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2f83ac5c2b7mr34314944a91.24.1738596612574;
        Mon, 03 Feb 2025 07:30:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnTlPqvAsppPjuVyMMChT5l2keDSNV7HdTsd1cowZnZ3hNzamhkFrC51pzslB1jmOdD2bEYg==
X-Received: by 2002:a17:90b:5201:b0:2ea:4c8d:c7a2 with SMTP id 98e67ed59e1d1-2f83ac5c2b7mr34314897a91.24.1738596612122;
        Mon, 03 Feb 2025 07:30:12 -0800 (PST)
Received: from [192.168.29.221] ([49.37.208.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848aa7255sm9151294a91.31.2025.02.03.07.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 07:30:11 -0800 (PST)
Message-ID: <5b2198ea-014e-48e8-84aa-b7806aa82b4c@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 21:00:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] wifi: ath12k: Update HTT_TCL_METADATA version and
 bit mask definitions
To: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250203075538.3982875-1-quic_bmahalin@quicinc.com>
 <20250203075538.3982875-2-quic_bmahalin@quicinc.com>
Content-Language: en-US
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
In-Reply-To: <20250203075538.3982875-2-quic_bmahalin@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: WFhzv9-sgC76K4F2Z5a191HVln0Ij2OT
X-Proofpoint-ORIG-GUID: WFhzv9-sgC76K4F2Z5a191HVln0Ij2OT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_06,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030114

On 2/3/25 13:25, Balamurugan Mahalingam wrote:
> Update the HTT_TCL_METADATA version to the latest version (2)
> as the bit definitions have changed a little to support more
> features. This new version allows the host to submit a packet with
> more information to the firmware. Firmware uses this additional
> information to do special processing for certain frames.
> 
> All the firmware binaries available in upstream/public are compatible with
> this HTT version update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp.h    | 21 ++++++++++++++-------
>   drivers/net/wireless/ath/ath12k/dp_tx.c | 12 ++++++++++--
>   2 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
> index f68bb78d4a11..7cdc62aa35be 100644
> --- a/drivers/net/wireless/ath/ath12k/dp.h
> +++ b/drivers/net/wireless/ath/ath12k/dp.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: BSD-3-Clause-Clear */
>   /*
>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #ifndef ATH12K_DP_H
> @@ -372,17 +372,18 @@ struct ath12k_dp {
>   };
>   
>   /* HTT definitions */
> +#define HTT_TAG_TCL_METADATA_VERSION		5
>   
> -#define HTT_TCL_META_DATA_TYPE		BIT(0)
> -#define HTT_TCL_META_DATA_VALID_HTT		BIT(1)
> +#define HTT_TCL_META_DATA_TYPE		GENMASK(1, 0)
> +#define HTT_TCL_META_DATA_VALID_HTT		BIT(2)
>   
>   /* vdev meta data */
> -#define HTT_TCL_META_DATA_VDEV_ID		GENMASK(9, 2)
> -#define HTT_TCL_META_DATA_PDEV_ID		GENMASK(11, 10)
> -#define HTT_TCL_META_DATA_HOST_INSPECTED	BIT(12)
> +#define HTT_TCL_META_DATA_VDEV_ID		 GENMASK(10, 3)
> +#define HTT_TCL_META_DATA_PDEV_ID		 GENMASK(12, 11)
> +#define HTT_TCL_META_DATA_HOST_INSPECTED_MISSION BIT(13)

nit: Can we align these three new additions in same column?

>   
>   /* peer meta data */
> -#define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 2)
> +#define HTT_TCL_META_DATA_PEER_ID		GENMASK(15, 3)
>   
>   /* HTT tx completion is overlaid in wbm_release_ring */
>   #define HTT_TX_WBM_COMP_INFO0_STATUS		GENMASK(16, 13)
> @@ -413,9 +414,15 @@ enum htt_h2t_msg_type {
>   };
>   
>   #define HTT_VER_REQ_INFO_MSG_ID		GENMASK(7, 0)
> +#define HTT_OPTION_TCL_METADATA_VER_V2	2
> +#define HTT_OPTION_TAG		GENMASK(7, 0)
> +#define HTT_OPTION_LEN		GENMASK(15, 8)
> +#define HTT_OPTION_VALUE		GENMASK(31, 16)
> +#define HTT_TCL_METADATA_VER_SZ		4
>

Same here. All aligning in same column would be good.

>   struct htt_ver_req_cmd {
>   	__le32 ver_reg_info;
> +	__le32 tcl_metadata_version;
>   } __packed;
>   
>   enum htt_srng_ring_type {
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index aa8058dd2da6..5ed41783d039 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>   /*
>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include "core.h"
> @@ -1103,7 +1103,15 @@ int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab)
>   	skb_put(skb, len);
>   	cmd = (struct htt_ver_req_cmd *)skb->data;
>   	cmd->ver_reg_info = le32_encode_bits(HTT_H2T_MSG_TYPE_VERSION_REQ,
> -					     HTT_VER_REQ_INFO_MSG_ID);
> +					     HTT_OPTION_TAG);
> +
> +	cmd->tcl_metadata_version = le32_encode_bits(HTT_TAG_TCL_METADATA_VERSION,
> +						     HTT_OPTION_TAG);
> +	cmd->tcl_metadata_version |= le32_encode_bits(HTT_TCL_METADATA_VER_SZ,
> +						      HTT_OPTION_LEN);
> +	cmd->tcl_metadata_version |=
> +			le32_encode_bits(HTT_OPTION_TCL_METADATA_VER_V2,
> +					 HTT_OPTION_VALUE);
> 

Can't we write like this ?

x = a |
     b |
     c;

instead of

x = a;
x |= b;
x |= c;

>   	ret = ath12k_htc_send(&ab->htc, dp->eid, skb);
>   	if (ret) {


-- 
Aditya

