Return-Path: <linux-wireless+bounces-17786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3A1A17BA5
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 11:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 320133A3A1B
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jan 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE81922F8;
	Tue, 21 Jan 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o0KXp6rA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349641EE7AB
	for <linux-wireless@vger.kernel.org>; Tue, 21 Jan 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737455276; cv=none; b=K1fONUg5xJKJf0n8OvqZuZW7Ece8kPyWcOi9kM3pv9KIw1ENC9F/LzxIE2SwP/ME6HxtusovQY2YqhWd/y/Ord8a9y2uQlVxvSIPnwS19hCTSGhtCDKwx1+Gl1s+Vpa44D7iRNzKBvzHU3hrx9GBQ49er4HDQJpefndCPhTMLL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737455276; c=relaxed/simple;
	bh=Jc9HtUh1PPSVjy6//xtdqfkxjv3HJmE1NIRLMMeOFmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EadaBYzAmASN8oX+j8uXV/jjYvpFAcu0r+PBOBxCNoc95LXHt9DzozxRbA3M7j4aABWby+5VuLsocj7KcUIaLLlTBrMXK2W8CaW9r9BE0UISOXuK81Lj1qBmkyH9U0FD10043x2at/qR1NYCF2dtwIPF6YXMGTHRq/YfHO/EdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o0KXp6rA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L8Yl2n027213;
	Tue, 21 Jan 2025 10:27:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9/Tu5iheKIXCDUxloPMF6QaQq3tbg6UkOGG56tzgrEQ=; b=o0KXp6rAE0T/9dMX
	UyMEWQebcjqL1/iGGZ8DE8Uk15CTMAK4Pyd+LPce6h9OttZXKOMU185m4SfCJ7Hf
	GS/YJ1pb/TvImtBNAj21zz34y3KjgKVvg0aSEuCtR71EF3VYy9RIm5pohjT8aPQu
	VTxV/8vKATxUe5oSOWVekyY8BjYGeYQ1ReklPTIm+jWUxmZcpl8znYcIVAi46b+w
	Hhd8rkXf/5+Np5RUP41vFRm5N7Fv3j4vpt/5RP9eEoX4WqFrl0waHCyp4N1lu0nR
	1+x/4Sg58/UgU81GhCWQmA+nNkbaYxKbrAZVFo0uQbVO8SuQszhEoY47+5p6H6Sp
	652vpw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44a6vxrp3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 10:27:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50LARmdw026745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 10:27:48 GMT
Received: from [10.216.5.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 21 Jan
 2025 02:27:46 -0800
Message-ID: <aa86ba11-9a03-3473-cd7a-60034ec325f2@quicinc.com>
Date: Tue, 21 Jan 2025 15:57:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] wifi: ath12k: add support of station average signal
 strength
Content-Language: en-US
To: Nicolas Escande <nico.escande@gmail.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20250121093834.25132-1-nico.escande@gmail.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250121093834.25132-1-nico.escande@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UKHWRmdqvTLM6-P_1Lmo5TSoTC2GU8s0
X-Proofpoint-ORIG-GUID: UKHWRmdqvTLM6-P_1Lmo5TSoTC2GU8s0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210086



On 1/21/2025 3:08 PM, Nicolas Escande wrote:
> This adds support for reporting to the kernel the average rssi. This is
> done the same way as it was done in ath11k. A simple ewma (with the same
> parameters) is updated with each rssi update.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
> v2:
>    - removed spurious exta new line at the beggining of core.h
> 
> v1: https://lore.kernel.org/ath12k/20250117172819.3357534-1-nico.escande@gmail.com/
>    - initial version
> ---
>   drivers/net/wireless/ath/ath12k/core.h   | 4 ++++
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 2 ++
>   drivers/net/wireless/ath/ath12k/mac.c    | 5 +++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index ee595794a7aee..83af4381b79ff 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -15,6 +15,7 @@
>   #include <linux/ctype.h>
>   #include <linux/firmware.h>
>   #include <linux/panic_notifier.h>
> +#include <linux/average.h>
>   #include "qmi.h"
>   #include "htc.h"
>   #include "wmi.h"
> @@ -477,6 +478,8 @@ struct ath12k_wbm_tx_stats {
>   	u64 wbm_tx_comp_stats[HAL_WBM_REL_HTT_TX_COMP_STATUS_MAX];
>   };
>   
> +DECLARE_EWMA(avg_rssi, 10, 8)
> +
>   struct ath12k_link_sta {
>   	struct ath12k_link_vif *arvif;
>   	struct ath12k_sta *ahsta;
> @@ -496,6 +499,7 @@ struct ath12k_link_sta {
>   	u64 rx_duration;
>   	u64 tx_duration;
>   	u8 rssi_comb;
> +	struct ewma_avg_rssi avg_rssi;
>   	u8 link_id;
>   	struct ath12k_rx_peer_stats *rx_stats;
>   	struct ath12k_wbm_tx_stats *wbm_tx_stats;
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 5a21961cfd465..e53d5674b4368 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -2157,6 +2157,7 @@ static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,
>   		return;
>   
>   	arsta->rssi_comb = ppdu_info->rssi_comb;
> +	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
>   
>   	num_msdu = ppdu_info->tcp_msdu_count + ppdu_info->tcp_ack_msdu_count +
>   		   ppdu_info->udp_msdu_count + ppdu_info->other_msdu_count;
> @@ -2329,6 +2330,7 @@ ath12k_dp_mon_rx_update_user_stats(struct ath12k *ar,
>   		return;
>   
>   	arsta->rssi_comb = ppdu_info->rssi_comb;
> +	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
>   
>   	num_msdu = user_stats->tcp_msdu_count + user_stats->tcp_ack_msdu_count +
>   		   user_stats->udp_msdu_count + user_stats->other_msdu_count;
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index 2d062b5904a8e..5be8cf0e41279 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -5403,6 +5403,7 @@ static int ath12k_mac_station_add(struct ath12k *ar,
>   		}
>   	}
>   
> +	ewma_avg_rssi_init(&arsta->avg_rssi);
>   	return 0;
>   
>   free_peer:
> @@ -10054,6 +10055,10 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>   	/* TODO: Use real NF instead of default one. */
>   	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
>   	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +
> +	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi) +
> +		ATH12K_DEFAULT_NOISE_FLOOR;
> +	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
>   }
>   
>   static int ath12k_mac_op_cancel_remain_on_channel(struct ieee80211_hw *hw,


Reviewed-by: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>

