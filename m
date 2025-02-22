Return-Path: <linux-wireless+bounces-19325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A09A408E0
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 15:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C04E19C2FCD
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Feb 2025 14:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40014145348;
	Sat, 22 Feb 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kF2cwUdp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE9139566
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740233653; cv=none; b=dLNmsefWFwGbVnW7hgT41RnYVmYGAX99KhXo79tuhecqUFmcrswD+6lq5FPNYdHGB5VeOkZyrckdH0altJJdvzGAAx+Q+1CSh9t59GTCTYAFtxKK0184smX+KBTvVo7R9nmUdAXC/9LfQMUH3vg8cF0m+BTZWJaXzUU3BaRuVJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740233653; c=relaxed/simple;
	bh=tVcrP5/gr8jTB7ZyTGvHArma+IO5/SLwqBsU1PbFCU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1WKvKgizVt0Jtfe9mCwpcFiq0X95McJuGQAvfGmshc25oC90nZFA3vfEghFvphLDXhmjetkBa6DdpwL6XzZwk53EjHLKew7vT+eQOZYGKZTnpPXHifW54R/rtGmNBVtiIk+9vyvyaMxyxNqGy8rb+jTMxIbLgzquWx+ButRfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kF2cwUdp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MCxKk4028522
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 14:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11Ysi9GncpivA4iZhlsuFvjSxWJFI3QjA/kbsHHdxxM=; b=kF2cwUdpMYe7ArLe
	aM7iPtR0elv6DvqbCvmI+2SWd7cMXhRDgpCdfgsNgGJRu5OTTf32kwf33riFyu/i
	A+3cpIJXCjG6/u6607IFuQW/WGm08BoSHHKzbY4M51jTTv5yTLq+vljqSEJpC6Tg
	u9xAlz0vBsPMK6NZeTA61XBnmspo1G0QuUNHrJMO6/bzt1SbxKDmCu1B3+37dPcq
	08xIR+kglfzeH1y2DpRzJGOAx39yqFag4DuL8olFGiYtE3KvfRCKcw5QSGQx8Xke
	m32dKe6cOBa8gwkdjx6VtEAjzfAz9FR+HkwMrdO7/Wleg9RH50Hu7miw/F1EFHmq
	bGPdKw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7bf0pwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 14:14:10 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220cb5924a4so104648435ad.2
        for <linux-wireless@vger.kernel.org>; Sat, 22 Feb 2025 06:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740233649; x=1740838449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11Ysi9GncpivA4iZhlsuFvjSxWJFI3QjA/kbsHHdxxM=;
        b=CD/4miEVSscd8ZA1Ene7dliDhnEW/W14Bw58OF/WExr46PEMWGD9DfyWfFSWht/My2
         PKKDghvzFTaffpKt9zMSvXdkTUuCK5vmc2ka2OcTSGlXtWWfzLu4nOSy4ZkcyzfgEMZV
         6HtRAT3HXbWdYdtJcHFdG8/sfWR9TEmhBv7WaAdorm1sQYoZl3ulcCMc6Xj0J7YWJjZY
         GPFm04Yl+Fk/qsYqldAnO9cfwJyjqMzLHHCF2DQNegxtmM1MR6EhcAB52wW3S+2mX+rj
         QzTvlbKF82QC96I3GRkmxj1vRo6umOIlHp9t9R37xGHh6KcQWZvCE3S+Ykcku8oN9GsS
         j4CA==
X-Gm-Message-State: AOJu0Yw7sAGn6yLu7IgOcn5QJ71nkNhogFcsxeHBxu5hbhFvyNfgYHDQ
	kDaEVnzt5zdxfqcfcb8TrXmL0nlAh+rBV3i2uFtHEvSOixIEmUo4FaDwo+YDOeWSl0QyHaJVMgP
	ooCtxHMPzcd7S8Uh7jQ+47bBm7mTSACup9pX1YBicp7aS7yGqvfjLcRvzvHAIg/u8/A==
X-Gm-Gg: ASbGncutejeuDXaeOEPJQB77squEKJB5SSBRQsnm3dbshPKjTTtIUP5Fk/BB1+4H3AP
	lNytVJ0ycAeghNRPajbFAuz/BYF9X5RuLLmLNJav18WKt4oyrn9qM8RiLahJucp16R5pC+L4RYc
	qLCEI4fLiIrCsINsaUMBjK+8eU8XF4B8Puff8DVZuhgunnFbeH2iwKDtxLRhxRKcAuy//7uPtSh
	r0QsfgPIfEEt7/qyTRgylO87lI7QOR4ZkaS6QRZeTjMEk1BWYOl/6hssyFei5SoE6J0N2xgVBgX
	wvV12M/fX4taEaPn1c9HUQvyW3zw2gbMX6ScjgFBu3gkF6+Wn1Le3xBNxo8D
X-Received: by 2002:a17:902:f712:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-2219ff515dfmr133984505ad.14.1740233649319;
        Sat, 22 Feb 2025 06:14:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH8sD4+nQjwo6K4SBTdob+GiTVg6eTkZ8AQCtt9sa0XWlNmOlScXD/NaeiBJYaHF2Y5/CBJQ==
X-Received: by 2002:a17:902:f712:b0:220:ecf7:4b5c with SMTP id d9443c01a7336-2219ff515dfmr133984105ad.14.1740233648944;
        Sat, 22 Feb 2025 06:14:08 -0800 (PST)
Received: from [192.168.225.142] ([157.46.94.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7340a4b3779sm6768454b3a.109.2025.02.22.06.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 06:14:08 -0800 (PST)
Message-ID: <8385965d-1be7-12e7-b636-1a0750ee8762@oss.qualcomm.com>
Date: Sat, 22 Feb 2025 19:44:05 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 9/9] wifi: ath12k: add monitor interface support on
 QCN9274
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, P Praneesh <quic_ppranees@quicinc.com>
References: <20250222033002.3886215-1-quic_periyasa@quicinc.com>
 <20250222033002.3886215-10-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250222033002.3886215-10-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 1uDI5YAz1sIyLJ55AwhptjPSBbo2j9kq
X-Proofpoint-ORIG-GUID: 1uDI5YAz1sIyLJ55AwhptjPSBbo2j9kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502220114



On 2/22/2025 9:00 AM, Karthikeyan Periyasamy wrote:
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
>   drivers/net/wireless/ath/ath12k/core.c  |  5 +++++
>   drivers/net/wireless/ath/ath12k/dp_tx.c |  6 +++++
>   drivers/net/wireless/ath/ath12k/hw.c    |  4 ++--
>   drivers/net/wireless/ath/ath12k/mac.c   | 30 ++++++++++++++++++++++++-
>   4 files changed, 42 insertions(+), 3 deletions(-)
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
> index 54af9cbbf7cb..b90dad5cb2e0 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -1349,9 +1349,15 @@ static int ath12k_mac_monitor_start(struct ath12k *ar)
>   		return ret;
>   	}
>   
> +	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
> +	if (ret) {
> +		ath12k_warn(ar->ab, "fail to set monitor filter: %d\n", ret);
> +		return ret;
> +	}
> +
>   	ar->monitor_started = true;
>   	ar->num_started_vdevs++;
> -	ret = ath12k_dp_tx_htt_monitor_mode_ring_config(ar, false);
> +
>   	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac monitor started ret %d\n", ret);
>   
>   	return ret;
> @@ -7334,6 +7340,11 @@ static void ath12k_mac_op_tx(struct ieee80211_hw *hw,
>   	u8 link_id;
>   	int ret;
>   
> +	if (ahvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
> +		ieee80211_free_txskb(hw, skb);
> +		return;
> +	}
> +
>   	link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
>   	memset(skb_cb, 0, sizeof(*skb_cb));
>   	skb_cb->vif = vif;
> @@ -8083,6 +8094,9 @@ int ath12k_mac_vdev_create(struct ath12k *ar, struct ath12k_link_vif *arvif)
>   
>   	lockdep_assert_wiphy(hw->wiphy);
>   
> +	if (vif->type == NL80211_IFTYPE_MONITOR && ar->monitor_vdev_created)
> +		return -EINVAL;
> +

Some comment on the scenario that is being handled here might be helpful?


Vasanth

