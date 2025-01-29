Return-Path: <linux-wireless+bounces-18105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2033A21781
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089D61884CAF
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 05:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870A188734;
	Wed, 29 Jan 2025 05:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X3DDKpp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D037A5672
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738129742; cv=none; b=syiF724Jlzp54tB7XASbHzh/Ze2C1vEkdPRzu/9hUA1+KztFIBXHEtu88v/2eX9JviLaXa0PG3vbvNw3hAtktv8gAlc0xv2hw0goucuJQLIXBhfouObieQHRTaN4NA4G/8U5/94+elAusNW9r8scUj4N08r96/ZKoarrx8KOGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738129742; c=relaxed/simple;
	bh=zL6RJO/O3v/VKxfYVGoJiyEBSkf5XY+ZbDs7EbNWOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JClkJRHdhQZSbZXmBGZE/lFuK4W/uLxVG+ZSKCWhaARhFzgDTFQauocFsjqZFvU4JIqeCDta+GVROLB98o3hxtrCtawaezwqoL8SClG4GWsexk1fyHTwLv7j7OzGgJOE9qZkz1Bv2ZSYB7n7d0X5AvvsdZGe++UR9x7u8DRb7S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X3DDKpp6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2hL55026851;
	Wed, 29 Jan 2025 05:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3n6GVERab+GMaqE1bu9ml9kFGSRYDHwYLDsZ5quGwUo=; b=X3DDKpp6sVRHt3GW
	TqEnhYUq2osPHcL2CC7aGQKz7DVmaFW3YIbld4OgAZswGolMXQgO1pAox9qrxCHK
	drqSs8StudFDXkiGdX4BQ1yoj0I0DxVHHNNF5RX4JNjdCI2rhZdMmvA9hLnTSpuu
	wCEVFl8RvL0kwoswK+qym7dgeJh4SPaX//dwN6Pu6vE/yYtQ2pwnWAIW4KY8z0nb
	LctsiJMAWz/EjLIGiXn8mX1qUq4nbp+SLcW8hkmki/OZm9vjT65UaB0hjNOFEG6y
	64oryP1ORli042EGHhg1dLzR5hoprQcE5eHjEqPm4NzkxC7jJEbTNwNLPzoUWQYC
	Ct0I4w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44f54dh065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:48:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T5muWK022244
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 05:48:56 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 21:48:54 -0800
Message-ID: <1f79a5fe-a8c8-5f60-e9cb-9d4a516cb364@quicinc.com>
Date: Wed, 29 Jan 2025 11:18:51 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 6/9] wifi: ath12k: fix the ampdu id fetch in the
 HAL_RX_MPDU_START TLV
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, P Praneesh <quic_ppranees@quicinc.com>
References: <20250127104738.4174862-1-quic_periyasa@quicinc.com>
 <20250127104738.4174862-7-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127104738.4174862-7-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vv6kHNI4qvKMu_wWnPNrxgjged4ZaV18
X-Proofpoint-ORIG-GUID: vv6kHNI4qvKMu_wWnPNrxgjged4ZaV18
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290046



On 1/27/2025 4:17 PM, Karthikeyan Periyasamy wrote:
> From: P Praneesh <quic_ppranees@quicinc.com>
> 
> Currently, ampdu id is update with peer id mask which is incorrect.
> Therefore, update the ampdu id with PPDU id mask value. Also move
> the ampdu_id field inside the user stats since it is a user id based
> statistics.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c | 16 ++++++++++------
>   drivers/net/wireless/ath/ath12k/hal_rx.h |  3 ++-
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index 8c283e7c7dde..6ba2f0fa39c1 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: BSD-3-Clause-Clear
>   /*
>    * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
> - * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>    */
>   
>   #include "dp_mon.h"
> @@ -1558,6 +1558,11 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   		if (userid < HAL_MAX_UL_MU_USERS) {
>   			struct hal_rx_user_status *rxuser_stats =
>   				&ppdu_info->userstats[userid];
> +
> +			if (ppdu_info->num_mpdu_fcs_ok > 1 ||
> +			    ppdu_info->num_mpdu_fcs_err > 1)
> +				ppdu_info->userstats[userid].ampdu_present = true;
> +
>   			ppdu_info->num_users += 1;
>   
>   			ath12k_dp_mon_rx_handle_ofdma_info(eu_stats, rxuser_stats);
> @@ -1669,8 +1674,8 @@ ath12k_dp_mon_rx_parse_status_tlv(struct ath12k *ar,
>   		if (userid < HAL_MAX_UL_MU_USERS) {
>   			info[0] = __le32_to_cpu(mpdu_start->info0);
>   			ppdu_info->userid = userid;
> -			ppdu_info->ampdu_id[userid] =
> -				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO1_PEERID);
> +			ppdu_info->userstats[userid].ampdu_id =
> +				u32_get_bits(info[0], HAL_RX_MPDU_START_INFO0_PPDU_ID);
>   		}
>   
>   		break;
> @@ -1888,15 +1893,14 @@ static void ath12k_dp_mon_update_radiotap(struct ath12k *ar,
>   {
>   	struct ieee80211_supported_band *sband;
>   	u8 *ptr = NULL;
> -	u16 ampdu_id = ppduinfo->ampdu_id[ppduinfo->userid];
>   
>   	rxs->flag |= RX_FLAG_MACTIME_START;
>   	rxs->signal = ppduinfo->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
>   	rxs->nss = ppduinfo->nss + 1;
>   
> -	if (ampdu_id) {
> +	if (ppduinfo->userstats[ppduinfo->userid].ampdu_present) {
>   		rxs->flag |= RX_FLAG_AMPDU_DETAILS;
> -		rxs->ampdu_reference = ampdu_id;
> +		rxs->ampdu_reference = ppduinfo->userstats[ppduinfo->userid].ampdu_id;
>   	}
>   
>   	if (ppduinfo->is_eht || ppduinfo->eht_usig) {
> diff --git a/drivers/net/wireless/ath/ath12k/hal_rx.h b/drivers/net/wireless/ath/ath12k/hal_rx.h
> index 445d1c33b41f..163f9235fcf0 100644
> --- a/drivers/net/wireless/ath/ath12k/hal_rx.h
> +++ b/drivers/net/wireless/ath/ath12k/hal_rx.h
> @@ -148,6 +148,8 @@ struct hal_rx_user_status {
>   	u32 mpdu_fcs_ok_bitmap[HAL_RX_NUM_WORDS_PER_PPDU_BITMAP];
>   	u32 mpdu_ok_byte_count;
>   	u32 mpdu_err_byte_count;
> +	bool ampdu_present;
> +	u16 ampdu_id;
>   };
>   
>   #define HAL_MAX_UL_MU_USERS	37
> @@ -263,7 +265,6 @@ struct hal_rx_mon_ppdu_info {
>   	u8 addr4[ETH_ALEN];
>   	struct hal_rx_user_status userstats[HAL_MAX_UL_MU_USERS];
>   	u8 userid;
> -	u16 ampdu_id[HAL_MAX_UL_MU_USERS];
>   	bool first_msdu_in_mpdu;
>   	bool is_ampdu;
>   	u8 medium_prot_type;

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

