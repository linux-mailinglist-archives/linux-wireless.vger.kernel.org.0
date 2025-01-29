Return-Path: <linux-wireless+bounces-18112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58517A21795
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 07:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57201640F6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 06:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB071EEE6;
	Wed, 29 Jan 2025 06:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ORWu63AB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F0D14F6C
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130712; cv=none; b=KpxeJsrw9saCAb/xOYw25J+EnJud126NPWTTodiyY3eCZresYiE6Gh7ZHdF+wOkUB0lFBh55vyjl4UB2d6zAHl6GWps6CttWkWXqMBrqO7rLc8Q5rt7Ms7xFWvAUAa6GoYgyq4zPAp5TtdV2fuW5GwBwvp3xm0bweTaqSbZCCQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130712; c=relaxed/simple;
	bh=1qMnCUDybQBmlqYNdXESC19PrZk8PaCwrtsNyxvxnbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TqfYG9iU57+bcR5JkkZGmC70SRF8K8PmS0wYOOVGhtJWSE5QpKmETtzM0LHkx5leIQmUWBSk4uDbT38VBUCr1UYPDSP3aILO5GEC/fPlZdEpcu8gcgqkLd8bXzmRk44NRT96GLZlZsqSrVnZpUlNGiWKScT+mLs+BuI9DRQaVH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ORWu63AB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T4XHfj020175;
	Wed, 29 Jan 2025 06:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/dr9zyUXXiq35X2kGogX5kQYXSjnnXVYaKixitQHbnk=; b=ORWu63ABOkbHC0jA
	H9R947h7KR5fRdVx1r/qKD1DRQ4B+/RYH4vYB4ftM6DIXJ2+4p9s74FwanU4NGi6
	XcP+2uniABkRTRkN3cQO+rm4cT1XKyP1/byrIcn0K+NqFfyGydTBs5ZYhGpVxgy9
	E6mfJxS4bBp2Y1E+aUMsKp7Rs74ZV/Band9mX/HcRxs9lmAl/oz+MWiX921HTysV
	TqmRDx/HuNESH9A+5U33ThBeuOIsdJlk9JdS0LI4Uwr2TL/5o061rJo09j1RseBN
	WTh6/6+XcBK41hLzcPMffhmYmGd8P22pbK/eP2DKqW1yoYTiXMEZDIHjaMFrOLX+
	fEa6lQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fdd8r4hh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 06:05:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50T655SV017451
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 06:05:06 GMT
Received: from [10.216.32.57] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 28 Jan
 2025 22:05:03 -0800
Message-ID: <5f72cc3e-62b2-2297-1569-35fe28f2d2c1@quicinc.com>
Date: Wed, 29 Jan 2025 11:34:43 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/7] wifi: ath12k: Replace band define G with GHZ where
 appropriate
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Nicolas Escande <nico.escande@gmail.com>
References: <20250127114030.43479-1-quic_periyasa@quicinc.com>
 <20250127114030.43479-5-quic_periyasa@quicinc.com>
From: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>
In-Reply-To: <20250127114030.43479-5-quic_periyasa@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hk81ddFzNC1GTtJJMkmypZ48dNYVVJva
X-Proofpoint-GUID: hk81ddFzNC1GTtJJMkmypZ48dNYVVJva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 clxscore=1015 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290048



On 1/27/2025 5:10 PM, Karthikeyan Periyasamy wrote:
> Currently, band define and enum are with the word 'G'. Replace it with
> more appropriate 'GHZ' for clarity and correctness.
> 
> No functional changes. Only compile tested.
> 
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> Tested-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>   drivers/net/wireless/ath/ath12k/core.h  |  8 ++--
>   drivers/net/wireless/ath/ath12k/dp_rx.c |  4 +-
>   drivers/net/wireless/ath/ath12k/mac.c   | 52 ++++++++++++-------------
>   drivers/net/wireless/ath/ath12k/wmi.c   | 36 ++++++++---------
>   drivers/net/wireless/ath/ath12k/wmi.h   | 16 ++++----
>   5 files changed, 58 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
> index 2c0bee476604..3f908fd8161c 100644
> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -525,11 +525,11 @@ struct ath12k_sta {
>   	enum ieee80211_sta_state state;
>   };
>   
> -#define ATH12K_MIN_5G_FREQ 4150
> -#define ATH12K_MIN_6G_FREQ 5925
> -#define ATH12K_MAX_6G_FREQ 7115
> +#define ATH12K_MIN_5GHZ_FREQ 4150
> +#define ATH12K_MIN_6GHZ_FREQ 5925
> +#define ATH12K_MAX_6GHZ_FREQ 7115
>   #define ATH12K_NUM_CHANS 101
> -#define ATH12K_MAX_5G_CHAN 173
> +#define ATH12K_MAX_5GHZ_CHAN 173
>   
>   enum ath12k_hw_state {
>   	ATH12K_HW_STATE_OFF,
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 44e47ec5b3ee..fedca17eba66 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2433,8 +2433,8 @@ void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
>   	channel_num = meta_data;
>   	center_freq = meta_data >> 16;
>   
> -	if (center_freq >= ATH12K_MIN_6G_FREQ &&
> -	    center_freq <= ATH12K_MAX_6G_FREQ) {
> +	if (center_freq >= ATH12K_MIN_6GHZ_FREQ &&
> +	    center_freq <= ATH12K_MAX_6GHZ_FREQ) {
>   		rx_status->band = NL80211_BAND_6GHZ;
>   		rx_status->freq = center_freq;
>   	} else if (channel_num >= 1 && channel_num <= 14) {
> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
> index c15e0e329776..a00dc02adb5d 100644
> --- a/drivers/net/wireless/ath/ath12k/mac.c
> +++ b/drivers/net/wireless/ath/ath12k/mac.c
> @@ -861,12 +861,12 @@ static bool ath12k_mac_band_match(enum nl80211_band band1, enum WMI_HOST_WLAN_BA
>   {
>   	switch (band1) {
>   	case NL80211_BAND_2GHZ:
> -		if (band2 & WMI_HOST_WLAN_2G_CAP)
> +		if (band2 & WMI_HOST_WLAN_2GHZ_CAP)
>   			return true;
>   		break;
>   	case NL80211_BAND_5GHZ:
>   	case NL80211_BAND_6GHZ:
> -		if (band2 & WMI_HOST_WLAN_5G_CAP)
> +		if (band2 & WMI_HOST_WLAN_5GHZ_CAP)
>   			return true;
>   		break;
>   	default:
> @@ -967,7 +967,7 @@ static int ath12k_mac_txpower_recalc(struct ath12k *ar)
>   	ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "txpower to set in hw %d\n",
>   		   txpower / 2);
>   
> -	if ((pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) &&
> +	if ((pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP) &&
>   	    ar->txpower_limit_2g != txpower) {
>   		param = WMI_PDEV_PARAM_TXPOWER_LIMIT2G;
>   		ret = ath12k_wmi_pdev_set_param(ar, param,
> @@ -977,7 +977,7 @@ static int ath12k_mac_txpower_recalc(struct ath12k *ar)
>   		ar->txpower_limit_2g = txpower;
>   	}
>   
> -	if ((pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP) &&
> +	if ((pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP) &&
>   	    ar->txpower_limit_5g != txpower) {
>   		param = WMI_PDEV_PARAM_TXPOWER_LIMIT5G;
>   		ret = ath12k_wmi_pdev_set_param(ar, param,
> @@ -1259,12 +1259,12 @@ static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
>   	arg.pdev_id = pdev->pdev_id;
>   	arg.if_stats_id = ATH12K_INVAL_VDEV_STATS_ID;
>   
> -	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
>   		arg.chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
>   		arg.chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
>   	}
>   
> -	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP) {
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
>   		arg.chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
>   		arg.chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
>   	}
> @@ -3790,7 +3790,7 @@ static void ath12k_mac_bss_info_changed(struct ath12k *ar,
>   		else
>   			rateidx = ffs(info->basic_rates) - 1;
>   
> -		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP)
> +		if (ar->pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP)
>   			rateidx += ATH12K_MAC_FIRST_OFDM_RATE_IDX;
>   
>   		bitrate = ath12k_legacy_rates[rateidx].bitrate;
> @@ -4067,9 +4067,9 @@ ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
>   	 * split the hw request and perform multiple scans
>   	 */
>   
> -	if (center_freq < ATH12K_MIN_5G_FREQ)
> +	if (center_freq < ATH12K_MIN_5GHZ_FREQ)
>   		band = NL80211_BAND_2GHZ;
> -	else if (center_freq < ATH12K_MIN_6G_FREQ)
> +	else if (center_freq < ATH12K_MIN_6GHZ_FREQ)
>   		band = NL80211_BAND_5GHZ;
>   	else
>   		band = NL80211_BAND_6GHZ;
> @@ -6425,7 +6425,7 @@ static void ath12k_mac_setup_ht_vht_cap(struct ath12k *ar,
>   	rate_cap_tx_chainmask = ar->cfg_tx_chainmask >> cap->tx_chain_mask_shift;
>   	rate_cap_rx_chainmask = ar->cfg_rx_chainmask >> cap->rx_chain_mask_shift;
>   
> -	if (cap->supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +	if (cap->supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
>   		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
>   		ht_cap = cap->band[NL80211_BAND_2GHZ].ht_cap_info;
>   		if (ht_cap_info)
> @@ -6434,7 +6434,7 @@ static void ath12k_mac_setup_ht_vht_cap(struct ath12k *ar,
>   						    rate_cap_rx_chainmask);
>   	}
>   
> -	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
> +	if (cap->supported_bands & WMI_HOST_WLAN_5GHZ_CAP &&
>   	    (ar->ab->hw_params->single_pdev_only ||
>   	     !ar->supports_6ghz)) {
>   		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
> @@ -6842,7 +6842,7 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
>   	enum nl80211_band band;
>   	int count;
>   
> -	if (cap->supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +	if (cap->supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
>   		band = NL80211_BAND_2GHZ;
>   		count = ath12k_mac_copy_sband_iftype_data(ar, cap,
>   							  ar->mac.iftype[band],
> @@ -6852,7 +6852,7 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
>   						 count);
>   	}
>   
> -	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
> +	if (cap->supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
>   		band = NL80211_BAND_5GHZ;
>   		count = ath12k_mac_copy_sband_iftype_data(ar, cap,
>   							  ar->mac.iftype[band],
> @@ -6862,7 +6862,7 @@ static void ath12k_mac_setup_sband_iftype_data(struct ath12k *ar,
>   						 count);
>   	}
>   
> -	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP &&
> +	if (cap->supported_bands & WMI_HOST_WLAN_5GHZ_CAP &&
>   	    ar->supports_6ghz) {
>   		band = NL80211_BAND_6GHZ;
>   		count = ath12k_mac_copy_sband_iftype_data(ar, cap,
> @@ -7744,15 +7744,15 @@ static int ath12k_mac_setup_vdev_create_arg(struct ath12k_link_vif *arvif,
>   			return ret;
>   	}
>   
> -	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
>   		arg->chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
>   		arg->chains[NL80211_BAND_2GHZ].rx = ar->num_rx_chains;
>   	}
> -	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP) {
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
>   		arg->chains[NL80211_BAND_5GHZ].tx = ar->num_tx_chains;
>   		arg->chains[NL80211_BAND_5GHZ].rx = ar->num_rx_chains;
>   	}
> -	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5G_CAP &&
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_5GHZ_CAP &&
>   	    ar->supports_6ghz) {
>   		arg->chains[NL80211_BAND_6GHZ].tx = ar->num_tx_chains;
>   		arg->chains[NL80211_BAND_6GHZ].rx = ar->num_rx_chains;
> @@ -7781,7 +7781,7 @@ ath12k_mac_prepare_he_mode(struct ath12k_pdev *pdev, u32 viftype)
>   	u32 *hecap_phy_ptr = NULL;
>   	u32 hemode;
>   
> -	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP)
> +	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2GHZ_CAP)
>   		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
>   	else
>   		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
> @@ -10481,10 +10481,10 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
>   	struct ath12k_pdev *pdev = ar->pdev;
>   	struct ath12k_pdev_cap *pdev_cap = &pdev->cap;
>   
> -	if (band == WMI_HOST_WLAN_2G_CAP)
> +	if (band == WMI_HOST_WLAN_2GHZ_CAP)
>   		return pdev_cap->band[NL80211_BAND_2GHZ].phy_id;
>   
> -	if (band == WMI_HOST_WLAN_5G_CAP)
> +	if (band == WMI_HOST_WLAN_5GHZ_CAP)
>   		return pdev_cap->band[NL80211_BAND_5GHZ].phy_id;
>   
>   	ath12k_warn(ar->ab, "unsupported phy cap:%d\n", band);
> @@ -10509,7 +10509,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   
>   	reg_cap = &ar->ab->hal_reg_cap[ar->pdev_idx];
>   
> -	if (supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
>   		channels = kmemdup(ath12k_2ghz_channels,
>   				   sizeof(ath12k_2ghz_channels),
>   				   GFP_KERNEL);
> @@ -10525,7 +10525,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   		bands[NL80211_BAND_2GHZ] = band;
>   
>   		if (ar->ab->hw_params->single_pdev_only) {
> -			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2G_CAP);
> +			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2GHZ_CAP);
>   			reg_cap = &ar->ab->hal_reg_cap[phy_id];
>   		}
>   		ath12k_mac_update_ch_list(ar, band,
> @@ -10533,8 +10533,8 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   					  reg_cap->high_2ghz_chan);
>   	}
>   
> -	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
> -		if (reg_cap->high_5ghz_chan >= ATH12K_MIN_6G_FREQ) {
> +	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
> +		if (reg_cap->high_5ghz_chan >= ATH12K_MIN_6GHZ_FREQ) {
>   			channels = kmemdup(ath12k_6ghz_channels,
>   					   sizeof(ath12k_6ghz_channels), GFP_KERNEL);
>   			if (!channels) {
> @@ -10556,7 +10556,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   			ah->use_6ghz_regd = true;
>   		}
>   
> -		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6G_FREQ) {
> +		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6GHZ_FREQ) {
>   			channels = kmemdup(ath12k_5ghz_channels,
>   					   sizeof(ath12k_5ghz_channels),
>   					   GFP_KERNEL);
> @@ -10575,7 +10575,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
>   			bands[NL80211_BAND_5GHZ] = band;
>   
>   			if (ar->ab->hw_params->single_pdev_only) {
> -				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5G_CAP);
> +				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
>   				reg_cap = &ar->ab->hal_reg_cap[phy_id];
>   			}
>   
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
> index 61aa5f509338..174851995675 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.c
> +++ b/drivers/net/wireless/ath/ath12k/wmi.c
> @@ -520,10 +520,10 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
>   	 * band to band for a single radio, need to see how this should be
>   	 * handled.
>   	 */
> -	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2G_CAP) {
> +	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2GHZ_CAP) {
>   		pdev_cap->tx_chain_mask = le32_to_cpu(mac_caps->tx_chain_mask_2g);
>   		pdev_cap->rx_chain_mask = le32_to_cpu(mac_caps->rx_chain_mask_2g);
> -	} else if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5G_CAP) {
> +	} else if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5GHZ_CAP) {
>   		pdev_cap->vht_cap = le32_to_cpu(mac_caps->vht_cap_info_5g);
>   		pdev_cap->vht_mcs = le32_to_cpu(mac_caps->vht_supp_mcs_5g);
>   		pdev_cap->he_mcs = le32_to_cpu(mac_caps->he_supp_mcs_5g);
> @@ -546,7 +546,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
>   	pdev_cap->rx_chain_mask_shift =
>   			find_first_bit((unsigned long *)&pdev_cap->rx_chain_mask, 32);
>   
> -	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2G_CAP) {
> +	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_2GHZ_CAP) {
>   		cap_band = &pdev_cap->band[NL80211_BAND_2GHZ];
>   		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
>   		cap_band->max_bw_supported = le32_to_cpu(mac_caps->max_bw_supported_2g);
> @@ -566,7 +566,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
>   				le32_to_cpu(mac_caps->he_ppet2g.ppet16_ppet8_ru3_ru0[i]);
>   	}
>   
> -	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5G_CAP) {
> +	if (le32_to_cpu(mac_caps->supported_bands) & WMI_HOST_WLAN_5GHZ_CAP) {
>   		cap_band = &pdev_cap->band[NL80211_BAND_5GHZ];
>   		cap_band->phy_id = le32_to_cpu(mac_caps->phy_id);
>   		cap_band->max_bw_supported =
> @@ -3625,15 +3625,15 @@ ath12k_fill_band_to_mac_param(struct ath12k_base  *soc,
>   		arg[i].pdev_id = pdev->pdev_id;
>   
>   		switch (pdev->cap.supported_bands) {
> -		case WMI_HOST_WLAN_2G_5G_CAP:
> +		case WMI_HOST_WLAN_2GHZ_5GHZ_CAP:
>   			arg[i].start_freq = hal_reg_cap->low_2ghz_chan;
>   			arg[i].end_freq = hal_reg_cap->high_5ghz_chan;
>   			break;
> -		case WMI_HOST_WLAN_2G_CAP:
> +		case WMI_HOST_WLAN_2GHZ_CAP:
>   			arg[i].start_freq = hal_reg_cap->low_2ghz_chan;
>   			arg[i].end_freq = hal_reg_cap->high_2ghz_chan;
>   			break;
> -		case WMI_HOST_WLAN_5G_CAP:
> +		case WMI_HOST_WLAN_5GHZ_CAP:
>   			arg[i].start_freq = hal_reg_cap->low_5ghz_chan;
>   			arg[i].end_freq = hal_reg_cap->high_5ghz_chan;
>   			break;
> @@ -4678,7 +4678,7 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
>   		bands = pdev->cap.supported_bands;
>   	}
>   
> -	if (bands & WMI_HOST_WLAN_2G_CAP) {
> +	if (bands & WMI_HOST_WLAN_2GHZ_CAP) {
>   		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_2GHZ,
>   					  caps->eht_cap_mac_info_2ghz,
>   					  caps->eht_cap_phy_info_2ghz,
> @@ -4687,7 +4687,7 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
>   					  caps->eht_cap_info_internal);
>   	}
>   
> -	if (bands & WMI_HOST_WLAN_5G_CAP) {
> +	if (bands & WMI_HOST_WLAN_5GHZ_CAP) {
>   		ath12k_wmi_eht_caps_parse(pdev, NL80211_BAND_5GHZ,
>   					  caps->eht_cap_mac_info_5ghz,
>   					  caps->eht_cap_phy_info_5ghz,
> @@ -4901,7 +4901,7 @@ static u8 ath12k_wmi_ignore_num_extra_rules(struct ath12k_wmi_reg_rule_ext_param
>   	for (count = 0; count < num_reg_rules; count++) {
>   		start_freq = le32_get_bits(rule[count].freq_info, REG_RULE_START_FREQ);
>   
> -		if (start_freq >= ATH12K_MIN_6G_FREQ)
> +		if (start_freq >= ATH12K_MIN_6GHZ_FREQ)
>   			num_invalid_5ghz_rules++;
>   	}
>   
> @@ -4971,9 +4971,9 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
>   		num_6g_reg_rules_ap[i] = reg_info->num_6g_reg_rules_ap[i];
>   
> -		if (num_6g_reg_rules_ap[i] > MAX_6G_REG_RULES) {
> +		if (num_6g_reg_rules_ap[i] > MAX_6GHZ_REG_RULES) {
>   			ath12k_warn(ab, "Num 6G reg rules for AP mode(%d) exceeds max limit (num_6g_reg_rules_ap: %d, max_rules: %d)\n",
> -				    i, num_6g_reg_rules_ap[i], MAX_6G_REG_RULES);
> +				    i, num_6g_reg_rules_ap[i], MAX_6GHZ_REG_RULES);
>   			kfree(tb);
>   			return -EINVAL;
>   		}
> @@ -4994,9 +4994,9 @@ static int ath12k_pull_reg_chan_list_ext_update_ev(struct ath12k_base *ab,
>   				reg_info->num_6g_reg_rules_cl[WMI_REG_VLP_AP][i];
>   		total_reg_rules += num_6g_reg_rules_cl[WMI_REG_VLP_AP][i];
>   
> -		if (num_6g_reg_rules_cl[WMI_REG_INDOOR_AP][i] > MAX_6G_REG_RULES ||
> -		    num_6g_reg_rules_cl[WMI_REG_STD_POWER_AP][i] > MAX_6G_REG_RULES ||
> -		    num_6g_reg_rules_cl[WMI_REG_VLP_AP][i] >  MAX_6G_REG_RULES) {
> +		if (num_6g_reg_rules_cl[WMI_REG_INDOOR_AP][i] > MAX_6GHZ_REG_RULES ||
> +		    num_6g_reg_rules_cl[WMI_REG_STD_POWER_AP][i] > MAX_6GHZ_REG_RULES ||
> +		    num_6g_reg_rules_cl[WMI_REG_VLP_AP][i] >  MAX_6GHZ_REG_RULES) {
>   			ath12k_warn(ab, "Num 6g client reg rules exceeds max limit, for client(type: %d)\n",
>   				    i);
>   			kfree(tb);
> @@ -6296,13 +6296,13 @@ static void ath12k_mgmt_rx_event(struct ath12k_base *ab, struct sk_buff *skb)
>   	if (rx_ev.status & WMI_RX_STATUS_ERR_MIC)
>   		status->flag |= RX_FLAG_MMIC_ERROR;
>   
> -	if (rx_ev.chan_freq >= ATH12K_MIN_6G_FREQ &&
> -	    rx_ev.chan_freq <= ATH12K_MAX_6G_FREQ) {
> +	if (rx_ev.chan_freq >= ATH12K_MIN_6GHZ_FREQ &&
> +	    rx_ev.chan_freq <= ATH12K_MAX_6GHZ_FREQ) {
>   		status->band = NL80211_BAND_6GHZ;
>   		status->freq = rx_ev.chan_freq;
>   	} else if (rx_ev.channel >= 1 && rx_ev.channel <= 14) {
>   		status->band = NL80211_BAND_2GHZ;
> -	} else if (rx_ev.channel >= 36 && rx_ev.channel <= ATH12K_MAX_5G_CHAN) {
> +	} else if (rx_ev.channel >= 36 && rx_ev.channel <= ATH12K_MAX_5GHZ_CHAN) {
>   		status->band = NL80211_BAND_5GHZ;
>   	} else {
>   		/* Shouldn't happen unless list of advertised channels to
> diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
> index 2934d9589007..b491eff33513 100644
> --- a/drivers/net/wireless/ath/ath12k/wmi.h
> +++ b/drivers/net/wireless/ath/ath12k/wmi.h
> @@ -216,9 +216,9 @@ enum wmi_host_hw_mode_priority {
>   };
>   
>   enum WMI_HOST_WLAN_BAND {
> -	WMI_HOST_WLAN_2G_CAP	= 1,
> -	WMI_HOST_WLAN_5G_CAP	= 2,
> -	WMI_HOST_WLAN_2G_5G_CAP	= 3,
> +	WMI_HOST_WLAN_2GHZ_CAP		= 1,
> +	WMI_HOST_WLAN_5GHZ_CAP		= 2,
> +	WMI_HOST_WLAN_2GHZ_5GHZ_CAP	= 3,
>   };
>   
>   enum wmi_cmd_group {
> @@ -2675,8 +2675,8 @@ enum wmi_channel_width {
>    * 2 - index for 160 MHz, first 3 bytes valid
>    * 3 - index for 320 MHz, first 3 bytes valid
>    */
> -#define WMI_MAX_EHT_SUPP_MCS_2G_SIZE  2
> -#define WMI_MAX_EHT_SUPP_MCS_5G_SIZE  4
> +#define WMI_MAX_EHT_SUPP_MCS_2GHZ_SIZE  2
> +#define WMI_MAX_EHT_SUPP_MCS_5GHZ_SIZE  4
>   
>   #define WMI_EHTCAP_TXRX_MCS_NSS_IDX_80    0
>   #define WMI_EHTCAP_TXRX_MCS_NSS_IDX_160   1
> @@ -2715,8 +2715,8 @@ struct ath12k_wmi_caps_ext_params {
>   	struct ath12k_wmi_ppe_threshold_params eht_ppet_2ghz;
>   	struct ath12k_wmi_ppe_threshold_params eht_ppet_5ghz;
>   	__le32 eht_cap_info_internal;
> -	__le32 eht_supp_mcs_ext_2ghz[WMI_MAX_EHT_SUPP_MCS_2G_SIZE];
> -	__le32 eht_supp_mcs_ext_5ghz[WMI_MAX_EHT_SUPP_MCS_5G_SIZE];
> +	__le32 eht_supp_mcs_ext_2ghz[WMI_MAX_EHT_SUPP_MCS_2GHZ_SIZE];
> +	__le32 eht_supp_mcs_ext_5ghz[WMI_MAX_EHT_SUPP_MCS_5GHZ_SIZE];
>   	__le32 eml_capability;
>   	__le32 mld_capability;
>   } __packed;
> @@ -4093,7 +4093,7 @@ struct ath12k_wmi_eht_rate_set_params {
>   
>   #define MAX_REG_RULES 10
>   #define REG_ALPHA2_LEN 2
> -#define MAX_6G_REG_RULES 5
> +#define MAX_6GHZ_REG_RULES 5
>   
>   enum wmi_start_event_param {
>   	WMI_VDEV_START_RESP_EVENT = 0,

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

