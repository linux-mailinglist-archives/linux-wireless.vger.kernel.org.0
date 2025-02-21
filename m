Return-Path: <linux-wireless+bounces-19296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01823A3FD81
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171CE188D4BB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2025 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371712500AA;
	Fri, 21 Feb 2025 17:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K9biuXYX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2432F3B
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159087; cv=none; b=UTFL5eWjxczsqcPVvYlLn7fhOZdfOIO2v8exU5kXjn6SxmCaTKkBa4Q2Y95TU3jVMcEDTLqinI/a/55N+yhtNDAQr2sakGOFwQOPsVOMBF/5sGc1PdeKs1gywTtR+5wHYpI7JzUuDTmFoVDc72u25kk1bAiRX1sqWeuHsj56o+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159087; c=relaxed/simple;
	bh=DF7tPAfklRvJ4tbKaf/GnbEnqKvMHRuBuiW4XWUsRH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1t/LQYsdF4lKLtQQ5/S+COYoTMzWay5YpZIXTBGsKDVBHpG9xb2pTYKasQfeMLF2rMQS1q7HJ4Po5Ru7TC2MG4LcLLuol9Jpe9TrKO7W1DavEHGf3ODET7v/A1A7WhpE9OG99IfoyMyVwaF1XkKvkgCPWoFxYx0F6evO7/oqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K9biuXYX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LCtv7j016231
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fx0UqVGkhKWBkaa1mMaE/JMLUCKUZ+tXgvAun+l0YII=; b=K9biuXYXYv9zXywN
	WOUnmmwyUYcxbAezF3gyylHaxO1VhTSVlcY0zc03lw7irQtvGCWAq3Fg2SirZr7h
	JEORy1rRVMWNYCHDmlo6rgtFPiF+ThJ/ljVv58e+EPNAE3tw6+mDMFGqMzHOIbAE
	E0x3CD7bhMSBrGBRWj39eAU0Nc+NJXy1vjR2MIGeR9y2ctQEkeLGK0CV/6zesO0O
	0QT/jSZj8T/Qo2sB3lb4aiExzs6UmKArJeOQzBCDEfxB/SIUNpfICMzV+HNfmVDV
	m5bto4OIVzHX5BnuEQdbksUuAk2D2F4+5Kwg6Vczw2d20dNuhnnACGNS/bsNrEth
	mdh5ug==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy4jtau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 17:31:23 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-220bf94cb40so34522115ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 21 Feb 2025 09:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740159082; x=1740763882;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fx0UqVGkhKWBkaa1mMaE/JMLUCKUZ+tXgvAun+l0YII=;
        b=KrCY8yTMdJGF47ecDb774gYZjGu54iOBZNHM/s0LRHRsMYEQGduCzOlWpp0OkiD9s6
         //ta08BtqEHMZYpMNJ/t1rrPPw8buvUE1WW/k2mQ2iOuwXOrcdBZkacW+/205tlUCztN
         TbqvONKZ+7aE4K9gdV7p7cJyhYVk070iktOUsSejjmpQdjnVXRLqPWYJDoPJ+Uu9ryOU
         sBPRWQ1QIfPXlgPk6XvUVPkswUAlSnPD5hl0YCfqrp2krEEj97mTiMgjMVXVfO1n4Lum
         NV2NuKC87ekhmEhOidk+xOqSJsfd7hNRoZy96R7S7pcAM+W4WQJ6V5FCKeQrZPUtiuSV
         btJg==
X-Gm-Message-State: AOJu0Yw7qQXsGxouXIycfy4Yb6eXe/lBITbptaxH8B29mompj5Oq41Xq
	9ao42imVqrJSO3ZOZ6EOUSzt8RhPTmesceVAx9OVbHr1JRvCLiSIVSxjz71fGLoKVgFpA9TyxW+
	RRomASU4HV9u7IEXJztBxr46H5NkdC8dp5cwldJqZ/2OhO7puOiZpaSqWmogpTC1zqQ==
X-Gm-Gg: ASbGncuYWgDDhvY0iCQNyIV1zRt4eZtHZwduT3eNr4SVHVNGhRZoGgZfSmEGq6hj6+L
	kocppx5j7epwd4xWpBKrdNnpenXCm5E1zGgquIAvROa3K4U0AtkKwc/H1NKwuQ8Za6mpy/+oyqw
	WFhehI725iqQVCRmfLfRDrs/XKqmrE+x7mMceNNms1a4fO64Mz+VBtubkl+IPUCecLd8YL8LA+L
	xmG5hr6xkV/Hwv7XcsCsQ3rcTH9nSipoNpMctSW4SyeMYjWiHDOXqs1qY+fsTRsj91iLSOzennD
	GntffsMkQ0Wuv4pkp7eDhvWhTyA7AzK1fFQmxdcy3SYYOu9anoC/nkXR7jjB
X-Received: by 2002:a17:902:e74b:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2219ffb37fbmr67335965ad.42.1740159082330;
        Fri, 21 Feb 2025 09:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8zNaLjhEOj/4DPWXsp279Wbgk/TSxyoepH6AEAKBqWke58jY+4KeodCTob3iAc4+0GT9row==
X-Received: by 2002:a17:902:e74b:b0:220:d79f:60f1 with SMTP id d9443c01a7336-2219ffb37fbmr67335405ad.42.1740159081865;
        Fri, 21 Feb 2025 09:31:21 -0800 (PST)
Received: from [192.168.225.142] ([157.46.94.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556d608sm140143445ad.171.2025.02.21.09.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 09:31:21 -0800 (PST)
Message-ID: <413d7f5b-c959-5af0-b001-d3b9d487268b@oss.qualcomm.com>
Date: Fri, 21 Feb 2025 23:01:17 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 8/8] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250221164110.3277222-1-quic_periyasa@quicinc.com>
 <20250221164110.3277222-9-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250221164110.3277222-9-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -XL8z-vKBiAAvPb91uNfBFu8zYTCyMEm
X-Proofpoint-ORIG-GUID: -XL8z-vKBiAAvPb91uNfBFu8zYTCyMEm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210122



On 2/21/2025 10:11 PM, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, the monitor interface is not supported. To support the monitor
> interface, configure the monitor vdev state identifier, configure the HTT
> filter setup, subscribe the mac80211 NO_VIRTUAL_MONITOR feature and
> prevent monitor interface to transmit packet. Therefore, add these
> procedures to add monitor interface support and enable the monitor
> interface support on the QCN9274 platform through the hardware parameter.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.c  |  5 +++
>   drivers/net/wireless/ath/ath12k/dp_tx.c |  6 +++
>   drivers/net/wireless/ath/ath12k/hw.c    |  4 +-
>   drivers/net/wireless/ath/ath12k/mac.c   | 53 +++++++++++++++++--------
>   4 files changed, 50 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
> index 0b2dec081c6e..ed7365ce7f95 100644
> --- a/drivers/net/wireless/ath/ath12k/core.c
> +++ b/drivers/net/wireless/ath/ath12k/core.c
> @@ -1306,6 +1306,11 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
>   				     ath12k_mac_tx_mgmt_pending_free, ar);
>   			idr_destroy(&ar->txmgmt_idr);
>   			wake_up(&ar->txmgmt_empty_waitq);
> +
> +			ar->monitor_vdev_id = -1;
> +			ar->monitor_conf_enabled = false;
> +			ar->monitor_vdev_created = false;
> +			ar->monitor_started = false;
>   		}
>   	}
>   
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 46a55554c19c..a74afa8b2236 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -7,6 +7,7 @@
>   #include "core.h"
>   #include "dp_tx.h"
>   #include "debug.h"
> +#include "debugfs.h"
>   #include "hw.h"
>   #include "peer.h"
>   #include "mac.h"
> @@ -1431,6 +1432,11 @@ int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset)
>   					HTT_RX_MON_MO_CTRL_FILTER_FLASG3 |
>   					HTT_RX_MON_FP_DATA_FILTER_FLASG3 |
>   					HTT_RX_MON_MO_DATA_FILTER_FLASG3;
> +	} else {
> +		tlv_filter = ath12k_mac_mon_status_filter_default;
> +
> +		if (ath12k_debugfs_is_extd_rx_stats_enabled(ar))
> +			tlv_filter.rx_filter = ath12k_debugfs_rx_filter(ar);
>   	}
>   
>   	if (ab->hw_params->rxdma1_enable) {
> diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
> index a106ebed7870..021a4b565e8b 100644
> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>   /*
>    * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include <linux/types.h>
> @@ -1049,7 +1049,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>   					BIT(NL80211_IFTYPE_AP) |
>   					BIT(NL80211_IFTYPE_MESH_POINT) |
>   					BIT(NL80211_IFTYPE_AP_VLAN),
> -		.supports_monitor = false,
> +		.supports_monitor = true,
>   
>   		.idle_ps = false,
>   		.download_calib = true,
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index c0e50cc5c024..b90dad5cb2e0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1323,19 +1323,9 @@ static int ath12k_mac_monitor_vdev_delete(struct ath12k *ar)
>   	return ret;
>   }
>   
> -static void
> -ath12k_mac_get_any_chandef_iter(struct ieee80211_hw *hw,
> -				struct ieee80211_chanctx_conf *conf,
> -				void *data)
> -{
> -	struct cfg80211_chan_def **def = data;
> -
> -	*def = &conf->def;
> -}
> -
>   static int ath12k_mac_monitor_start(struct ath12k *ar)
>   {
> -	struct cfg80211_chan_def *chandef = NULL;
> +	struct ath12k_mac_get_any_chanctx_conf_arg arg;
>   	int ret;
>   
>   	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> @@ -1343,22 +1333,31 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
>   	if (ar->monitor_started)
>   		return 0;
>   
> +	arg.ar = ar;
> +	arg.chanctx_conf = NULL;
>   	ieee80211_iter_chan_contexts_atomic(ath12k_ar_to_hw(ar),
> -					    ath12k_mac_get_any_chandef_iter,
> -					    &chandef);
> -	if (!chandef)
> +					    ath12k_mac_get_any_chanctx_conf_iter,
> +					    &arg);
> +	if (!arg.chanctx_conf)
>   		return 0;

Can this particular change be in a separate patch?

Vasanth

