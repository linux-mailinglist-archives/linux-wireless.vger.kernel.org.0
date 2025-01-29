Return-Path: <linux-wireless+bounces-18107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A582BA21785
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06694166CF0
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68820188734;
	Wed, 29 Jan 2025 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gVZ8QtFl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317F5672
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129920; cv=none; b=l1xrOaNjWwJbVC36jLMX+1hjKnSKeRTaYmLx5fmto0OlIOcKMuaK0je77T/lHeT663+lpujur+6V1+6yWNRminHk2MjDf3VlViKYBAdn8koVStn3XP8LNAm2yOLuN6clRJAVkgfdXEdyxuBRJtw+09ybpRgEJTg3MoJ3jwb1xgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129920; c=relaxed/simple;
	bh=lQIB+5FMaIEPljOGLSPEoIIrhXqS5Sk0kqUS52DaUJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GUB1G85BtxqZgY03cLkCBG1gMPVRzjzp2Y2aMGydTvMwCUS/Kmk/JFS6bCkwTf/ugjyKnrCcx51RmvqFEFwouZThQrcgaXRiqpV/HZev2VJlXv0VfC0Q8X1AvS9qHD/0b7ChIBb+rZERbiNXHIm9hyUdsnrmohrWzlY7bF6Ipvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gVZ8QtFl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T4WtwO019043;
	Wed, 29 Jan 2025 05:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnS0nEO1JtELhaCJMng4BrFAefyT0zyoCBnWytvh3LM=; b=gVZ8QtFlgPPbwyt3
	ITTV4TkyayFSrbBR5rhfPfW/tzZvcGopLEtUKtDL1RmaXsq4VJnvexyM/moScdhv
	L9LdM1Cs5WhaXkAffl8FI69Uh0Ap1jgoA+l3mLn4sJ7PR//PKxYL8nRDxc9ZcJZU
	9+AxNoM8kBbIM+yVn4wdx6tQOfalUU7VPqYu/14YzqdkCCeHAjX2Fo/ZQ35T9Ci6
	7wpYkZ0WNv6cv/WeiB61qflkUf08YhG9HPTcaxKhxCi4USAK08utteNcWQJXJgE+
	txXgFRo98s//BfAhxzAWB4tx/WtTXFfVQobI4hC1XeiG9YfAtZ65WRQt/vM3HBlF
	Sop7cg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fdd8r3tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:51:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T5psw3031170
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:51:54 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 21:51:52 -0800
Message-ID: <a67ac650-3508-4887-e432-aa03aaff4d38@quicinc.com>
Date: Wed, 29 Jan 2025 11:21:49 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 8/9] wifi: ath12k: Refactor the format of peer rate
 table information
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Balamurugan Mahalingam
	<quic_bmahalin@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-9-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127104738.4174862-9-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fsy3zTvkmaSsffzpXTv9wgTWDFDri9gz
X-Proofpoint-GUID: fsy3zTvkmaSsffzpXTv9wgTWDFDri9gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290047



On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
> From: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> 
> Currently, peer rate table information involves complex computation for
> the rate index to update the rate table. To simplify this process, avoid
> the rate index calculation by defining the rate table with bandwidth, GI,
> NSS, MCS. Therefore, update the rate information based on the bandwidth,
> GI, NSS and MCS information from the TLV data of monitor status Rx path.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Balamurugan Mahalingam <quic_bmahalin@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h   |  6 +----
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 29 +++++++++++-------------
>   2 files changed, 14 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 2c9c62cb1af5..50e81d6aa280 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -52,8 +52,6 @@
>   
>   #define ATH12K_INVALID_HW_MAC_ID	0xFF
>   #define ATH12K_CONNECTION_LOSS_HZ	(3 * HZ)
> -#define	ATH12K_RX_RATE_TABLE_NUM	320
> -#define	ATH12K_RX_RATE_TABLE_11AX_NUM	576
>   
>   #define ATH12K_MON_TIMER_INTERVAL  10
>   #define ATH12K_RESET_TIMEOUT_HZ			(20 * HZ)
> @@ -360,8 +358,6 @@ struct ath12k_vif_iter {
>   #define HAL_RX_MAX_MCS_BE	15
>   #define HAL_RX_MAX_NSS		8
>   #define HAL_RX_MAX_NUM_LEGACY_RATES 12
> -#define ATH12K_RX_RATE_TABLE_11AX_NUM	576
> -#define ATH12K_RX_RATE_TABLE_NUM 320
>   
>   struct ath12k_rx_peer_rate_stats {
>   	u64 ht_mcs_count[HAL_RX_MAX_MCS_HT + 1];
> @@ -372,7 +368,7 @@ struct ath12k_rx_peer_rate_stats {
>   	u64 bw_count[HAL_RX_BW_MAX];
>   	u64 gi_count[HAL_RX_GI_MAX];
>   	u64 legacy_count[HAL_RX_MAX_NUM_LEGACY_RATES];
> -	u64 rx_rate[ATH12K_RX_RATE_TABLE_11AX_NUM];
> +	u64 rx_rate[HAL_RX_BW_MAX][HAL_RX_GI_MAX][HAL_RX_MAX_NSS][HAL_RX_MAX_MCS_HT + 1];
>   };
>   
>   struct ath12k_rx_peer_stats {
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index dae430ee3c19..7e679ce177d3 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -2946,34 +2946,31 @@ ath12k_dp_mon_rx_update_peer_rate_table_stats(struct ath12k_rx_peer_stats *rx_st
>   					      struct hal_rx_user_status *user_stats,
>   					      u32 num_msdu)
>   {
> -	u32 rate_idx = 0;
> +	struct ath12k_rx_peer_rate_stats *stats;
>   	u32 mcs_idx = (user_stats) ? user_stats->mcs : ppdu_info->mcs;
>   	u32 nss_idx = (user_stats) ? user_stats->nss - 1 : ppdu_info->nss - 1;
>   	u32 bw_idx = ppdu_info->bw;
>   	u32 gi_idx = ppdu_info->gi;
> +	u32 len;
>   
> -	if ((mcs_idx > HAL_RX_MAX_MCS_HE) || (nss_idx >= HAL_RX_MAX_NSS) ||
> -	    (bw_idx >= HAL_RX_BW_MAX) || (gi_idx >= HAL_RX_GI_MAX)) {
> +	if (mcs_idx > HAL_RX_MAX_MCS_HT || nss_idx >= HAL_RX_MAX_NSS ||
> +	    bw_idx >= HAL_RX_BW_MAX || gi_idx >= HAL_RX_GI_MAX) {
>   		return;
>   	}
>   
> -	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11N ||
> -	    ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AC) {
> -		rate_idx = mcs_idx * 8 + 8 * 10 * nss_idx;
> -		rate_idx += bw_idx * 2 + gi_idx;
> -	} else if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AX) {
> +	if (ppdu_info->preamble_type == HAL_RX_PREAMBLE_11AX ||
> +	    ppdu_info->preamble_type == HAL_RX_PREAMBLE_11BE)
>   		gi_idx = ath12k_he_gi_to_nl80211_he_gi(ppdu_info->gi);
> -		rate_idx = mcs_idx * 12 + 12 * 12 * nss_idx;
> -		rate_idx += bw_idx * 3 + gi_idx;
> -	} else {
> -		return;
> -	}
>   
> -	rx_stats->pkt_stats.rx_rate[rate_idx] += num_msdu;
> +	rx_stats->pkt_stats.rx_rate[bw_idx][gi_idx][nss_idx][mcs_idx] += num_msdu;
> +	stats = &rx_stats->byte_stats;
> +
>   	if (user_stats)
> -		rx_stats->byte_stats.rx_rate[rate_idx] += user_stats->mpdu_ok_byte_count;
> +		len = user_stats->mpdu_ok_byte_count;
>   	else
> -		rx_stats->byte_stats.rx_rate[rate_idx] += ppdu_info->mpdu_len;
> +		len = ppdu_info->mpdu_len;
> +
> +	stats->rx_rate[bw_idx][gi_idx][nss_idx][mcs_idx] += len;
>   }
>   
>   static void ath12k_dp_mon_rx_update_peer_su_stats(struct ath12k *ar,


Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

