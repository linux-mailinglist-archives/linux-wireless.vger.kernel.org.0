Return-Path: <linux-wireless+bounces-6976-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C778B53E0
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 11:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF301F21F72
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F3C2C8;
	Mon, 29 Apr 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vls3wlYG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0072612E7F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381901; cv=none; b=aTQUtbllaK8+qxQdDgvb24oo/F1NcY/RxJ6SQFkoqs8fjQFTZVtQL30rRxlhSjgnQZsJdBOmWbH09PELkEgy2Y3u/2V+eHHvNf80QBM4OzHp5jqBT4jGmaqN2ZKqBfl3UP0uqxNWPiIjhzyDkxvxxldC8rU3US0MBT9dYqHsK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381901; c=relaxed/simple;
	bh=wQ0P9rNLrvbURaTcfxEDZO6wt+nM2S1bsINTqWgzmh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oo4qSlqXrLBD5PTA1Vgon9F8zh9lkSZwtXsj7a21FO36fuvUSC+utml1a9ehqicw86gWUwmnUH0+fVVVadzlkU0qi/oYiyB2zghB5w0lub6DdIUEB4UKIMgnnV+g+j7FB9bs6t+S93TQZFTkbM9eZBQmT3RXfZADJVt3MWVXaPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vls3wlYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5r0B6032240;
	Mon, 29 Apr 2024 09:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4xyHY7wd/bX2Xwf0zhA52uK17c59w6dliOUhtUTbVoQ=; b=Vl
	s3wlYGSmrliGjJL3upWHC2O1Je3ujUmCIWRdMURKlIckkgZivcJfyGJ9QGT24tf5
	WbKAkObzOWfaOYHePwqURYsh2s39wrFFc4qast9rZHTwCBabU7zqS0z+KZg5ULYR
	UjNXVBLrqwUum1RbvNJmwYsdDiPMEFUtoffQl2Etq6J0qINVgymPP4K+/z0RCGLp
	nEGpojudmj8TsvJhaP8gYcbLbI+eJRsdSAMZfBF4Ryz+mb3qesR37gMwm9ycPyKn
	EuK/lJbFYR5cr/4PfLiVrPOMEw1UCurNfNAd23iYxf3OM/Vov0dh9btgSAzAVm+s
	L/u6sK2ljO9MNBlnDj/w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt2sersk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:11:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T9BUDV008214
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:11:30 GMT
Received: from [10.152.205.142] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 02:11:28 -0700
Message-ID: <f974973d-5797-39c2-fddf-c928755c76a9@quicinc.com>
Date: Mon, 29 Apr 2024 14:41:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
 <20240419032122.7009-2-quic_lingbok@quicinc.com>
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
In-Reply-To: <20240419032122.7009-2-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NSvqusHxBTy7DVJbBzFuVAwH-idUB-ZE
X-Proofpoint-ORIG-GUID: NSvqusHxBTy7DVJbBzFuVAwH-idUB-ZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290057



On 4/19/2024 8:51 AM, Lingbo Kong wrote:
> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
> 
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
> 
> This patch affects the station mode of WCN7850 and QCN9274.
> 
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>          inactive time:  872 ms
>          rx bytes:       219111
>          rx packets:     1133
>          tx bytes:       53767
>          tx packets:     462
>          tx retries:     51
>          tx failed:      0
>          beacon loss:    0
>          beacon rx:      403
>          rx drop misc:   74
>          signal:         -95 dBm
>          beacon signal avg:      -18 dBm
>          tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
> ---
> v4:
> 1.change ATH12K_EHT_MCS_MAX from 13 to 15
> 
> v3:
> no change
> 
> v2:
> 1.change copyright
> 
>   drivers/net/wireless/ath/ath12k/core.h   |   2 +
>   drivers/net/wireless/ath/ath12k/dp_rx.h  |   3 +
>   drivers/net/wireless/ath/ath12k/dp_tx.c  | 147 ++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath12k/hal_tx.h |   9 +-
>   drivers/net/wireless/ath/ath12k/mac.c    | 124 +++++++++++++++++++
>   drivers/net/wireless/ath/ath12k/mac.h    |   4 +-
>   6 files changed, 282 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 5d3c1fb632b0..b2ddd1e6fb14 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -74,6 +74,7 @@ enum wme_ac {
>   #define ATH12K_HT_MCS_MAX	7
>   #define ATH12K_VHT_MCS_MAX	9
>   #define ATH12K_HE_MCS_MAX	11
> +#define ATH12K_EHT_MCS_MAX	15
>   
>   enum ath12k_crypt_mode {
>   	/* Only use hardware crypto engine */
> @@ -448,6 +449,7 @@ struct ath12k_sta {
>   	struct ath12k_rx_peer_stats *rx_stats;
>   	struct ath12k_wbm_tx_stats *wbm_tx_stats;
>   	u32 bw_prev;
> +	u32 peer_nss;
>   };
>   
>   #define ATH12K_MIN_5G_FREQ 4150
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
> index 2ff421160181..1543788c0da7 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
> @@ -79,6 +79,9 @@ static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
>   	case RX_MSDU_START_SGI_3_2_US:
>   		ret = NL80211_RATE_INFO_HE_GI_3_2;
>   		break;
> +	default:
> +		ret = NL80211_RATE_INFO_HE_GI_0_8;
> +		break;
>   	}
>   
>   	return ret;
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index 9b6d7d72f57c..74ef4c7a72c1 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -8,6 +8,8 @@
>   #include "dp_tx.h"
>   #include "debug.h"
>   #include "hw.h"
> +#include "peer.h"
> +#include "mac.h"
>   
>   static enum hal_tcl_encap_type
>   ath12k_dp_tx_get_encap_type(struct ath12k_vif *arvif, struct sk_buff *skb)
> @@ -443,6 +445,125 @@ ath12k_dp_tx_process_htt_tx_complete(struct ath12k_base *ab,
>   	}
>   }
>   
> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_peer *peer;
> +	struct ath12k_sta *arsta;
> +	struct ieee80211_sta *sta;
> +	u16 rate;
> +	u8 rate_idx = 0;
> +	int ret;
> +
> +	spin_lock_bh(&ab->base_lock);
> +
> +	peer = ath12k_peer_find_by_id(ab, ts->peer_id);
> +	if (!peer || !peer->sta) {
> +		ath12k_dbg(ab, ATH12K_DBG_DP_TX,
> +			   "failed to find the peer by id %u\n", ts->peer_id);
> +		goto err_out;
> +	}
> +
> +	sta = peer->sta;
> +	arsta = ath12k_sta_to_arsta(sta);
> +
> +	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
> +
> +	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
> +	 * if it is invalid, then choose the NSS value while assoc.
> +	 */
> +	if (arsta->last_txrate.nss)
> +		arsta->txrate.nss = arsta->last_txrate.nss;
> +	else
> +		arsta->txrate.nss = arsta->peer_nss;
> +
> +	if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
> +	    ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
> +		ret = ath12k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
> +							    ts->pkt_type,
> +							    &rate_idx,
> +							    &rate);
> +		if (ret < 0) {
> +			ath12k_warn(ab, "Invalid tx legacy rate %d\n", ret);
> +			goto err_out;
> +		}
> +
> +		arsta->txrate.legacy = rate;
> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
> +		if (ts->mcs > ATH12K_HT_MCS_MAX) {
> +			ath12k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
> +			goto err_out;
> +		}
> +
> +		if (arsta->txrate.nss != 0)
> +			arsta->txrate.mcs = ts->mcs + 8 * (arsta->txrate.nss - 1);
> +
> +		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
> +
> +		if (ts->sgi)
> +			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
> +		if (ts->mcs > ATH12K_VHT_MCS_MAX) {
> +			ath12k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
> +			goto err_out;
> +		}
> +
> +		arsta->txrate.mcs = ts->mcs;
> +		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
> +
> +		if (ts->sgi)
> +			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
> +		if (ts->mcs > ATH12K_HE_MCS_MAX) {
> +			ath12k_warn(ab, "Invalid HE mcs index %d\n", ts->mcs);
> +			goto err_out;
> +		}
> +
> +		arsta->txrate.mcs = ts->mcs;
> +		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
> +		arsta->txrate.he_gi = ath12k_he_gi_to_nl80211_he_gi(ts->sgi);
> +	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
> +		if (ts->mcs > ATH12K_EHT_MCS_MAX) {
> +			ath12k_warn(ab, "Invalid EHT mcs index %d\n", ts->mcs);
> +			goto err_out;
> +		}
> +
> +		arsta->txrate.mcs = ts->mcs;
> +		arsta->txrate.flags = RATE_INFO_FLAGS_EHT_MCS;
> +		arsta->txrate.eht_gi = ath12k_mac_eht_gi_to_nl80211_eht_gi(ts->sgi);
> +	}
> +
> +	arsta->txrate.bw = ath12k_mac_bw_to_mac80211_bw(ts->bw);
> +
> +	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
> +		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
> +		arsta->txrate.he_ru_alloc =
> +			ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ts->ru_tones);
> +	}
> +
> +	if (ts->ofdma && ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11BE) {
> +		arsta->txrate.bw = RATE_INFO_BW_EHT_RU;
> +		arsta->txrate.eht_ru_alloc =
> +			ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(ts->ru_tones);
> +	}
> +
> +err_out:
> +	spin_unlock_bh(&ab->base_lock);
> +}
> +
> +static void ath12k_dp_tx_update(struct ath12k *ar, struct hal_tx_status *ts)
> +{
> +	if (ar->last_ppdu_id != 0) {
> +		if (ar->last_ppdu_id == ts->ppdu_id ||
> +		    ar->cached_ppdu_id == ar->last_ppdu_id)
> +			ar->cached_ppdu_id = ar->last_ppdu_id;
> +
> +		ath12k_dp_tx_update_txcompl(ar, ts);
> +	}
> +
> +	ar->last_ppdu_id = ts->ppdu_id;
> +}
> +
>   static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
>   				       struct sk_buff *msdu,
>   				       struct hal_tx_status *ts)
> @@ -498,6 +619,8 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
>   	 * Might end up reporting it out-of-band from HTT stats.
>   	 */
>   
> +	ath12k_dp_tx_update(ar, ts);
> +
>   	ieee80211_tx_status_skb(ath12k_ar_to_hw(ar), msdu);
>   
>   exit:
> @@ -522,10 +645,26 @@ static void ath12k_dp_tx_status_parse(struct ath12k_base *ab,
>   
>   	ts->ppdu_id = le32_get_bits(desc->info1,
>   				    HAL_WBM_COMPL_TX_INFO1_TQM_STATUS_NUMBER);
> -	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID)
> -		ts->rate_stats = le32_to_cpu(desc->rate_stats.info0);
> -	else
> -		ts->rate_stats = 0;
> +
> +	if (le32_to_cpu(desc->info2) & HAL_WBM_COMPL_TX_INFO2_FIRST_MSDU)
> +		ts->flags |= HAL_TX_STATUS_FLAGS_FIRST_MSDU;
> +
> +	ts->peer_id = le32_get_bits(desc->info3, HAL_WBM_COMPL_TX_INFO3_PEER_ID);
> +
> +	if (le32_to_cpu(desc->rate_stats.info0) & HAL_TX_RATE_STATS_INFO0_VALID) {
> +		ts->pkt_type = le32_get_bits(desc->rate_stats.info0,
> +					     HAL_TX_RATE_STATS_INFO0_PKT_TYPE);
> +		ts->mcs = le32_get_bits(desc->rate_stats.info0,
> +					HAL_TX_RATE_STATS_INFO0_MCS);
> +		ts->sgi = le32_get_bits(desc->rate_stats.info0,
> +					HAL_TX_RATE_STATS_INFO0_SGI);
> +		ts->bw = le32_get_bits(desc->rate_stats.info0,
> +				       HAL_TX_RATE_STATS_INFO0_BW);
> +		ts->ru_tones = le32_get_bits(desc->rate_stats.info0,
> +					     HAL_TX_RATE_STATS_INFO0_TONES_IN_RU);
> +		ts->ofdma = le32_get_bits(desc->rate_stats.info0,
> +					  HAL_TX_RATE_STATS_INFO0_OFDMA_TX);
> +	}


Why multiple read from dma mapped area say desc->rate_stats.info0 lead 
to increase in CPU cycles. Instead you do one read from dma mapped area 
desc->rate_stats.info0 and classify into your own data structure ?

And the info0 classification used within the 
ath12k_dp_tx_update_txcompl(), so you can do the classification within 
this API.

-- 
Karthikeyan Periyasamy
--
கார்த்திகேயன் பெரியசாமி

