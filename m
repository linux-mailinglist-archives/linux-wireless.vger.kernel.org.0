Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0A1E10933B
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 19:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfKYSDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 13:03:43 -0500
Received: from nbd.name ([46.4.11.11]:40252 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbfKYSDn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 13:03:43 -0500
Received: from p5dcfb8d8.dip0.t-ipconnect.de ([93.207.184.216] helo=[192.168.45.104])
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iZIi4-0007qS-B1; Mon, 25 Nov 2019 19:03:40 +0100
Subject: Re: [PATCH 6/8] ath11k: add HE support
To:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
 <0101016ea36be2a7-e7459aa6-c762-4f95-bb93-0158f7bb5bfb-000000@us-west-2.amazonses.com>
From:   John Crispin <john@phrozen.org>
Message-ID: <3bba1a22-48e2-31c2-9671-ade9312b10c9@phrozen.org>
Date:   Mon, 25 Nov 2019 19:03:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0101016ea36be2a7-e7459aa6-c762-4f95-bb93-0158f7bb5bfb-000000@us-west-2.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 25/11/2019 17:36, Kalle Valo wrote:
> From: John Crispin <john@phrozen.org>
> 
> Add basic HE support to the driver. The sband_iftype data is generated from
> the capabilities read from the FW.
> 
> Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

yippie !!

> ---
>   drivers/net/wireless/ath/ath11k/core.h |   2 +
>   drivers/net/wireless/ath/ath11k/mac.c  | 265 ++++++++++++++++++++++++++++++++-
>   drivers/net/wireless/ath/ath11k/reg.c  |   1 +
>   drivers/net/wireless/ath/ath11k/wmi.c  |   6 +-
>   drivers/net/wireless/ath/ath11k/wmi.h  |   6 +-
>   5 files changed, 270 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
> index 95447d1be104..065cb9dc880b 100644
> --- a/drivers/net/wireless/ath/ath11k/core.h
> +++ b/drivers/net/wireless/ath/ath11k/core.h
> @@ -431,6 +431,8 @@ struct ath11k {
>   
>   	struct {
>   		struct ieee80211_supported_band sbands[NUM_NL80211_BANDS];
> +		struct ieee80211_sband_iftype_data
> +			iftype[NUM_NL80211_BANDS][NUM_NL80211_IFTYPES];
>   	} mac;
>   	unsigned long dev_flags;
>   	unsigned int filter_flags;
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 939f5880bce6..79c22d86e0fe 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -1140,7 +1140,86 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
>   				   struct ieee80211_sta *sta,
>   				   struct peer_assoc_params *arg)
>   {
> -	/* TODO: Implementation */
> +	const struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
> +	u16 v;
> +
> +	if (!he_cap->has_he)
> +		return;
> +
> +	arg->he_flag = true;
> +
> +	memcpy(&arg->peer_he_cap_macinfo, he_cap->he_cap_elem.mac_cap_info,
> +	       sizeof(arg->peer_he_cap_macinfo));
> +	memcpy(&arg->peer_he_cap_phyinfo, he_cap->he_cap_elem.phy_cap_info,
> +	       sizeof(arg->peer_he_cap_phyinfo));
> +	memcpy(&arg->peer_he_ops, &vif->bss_conf.he_operation,
> +	       sizeof(arg->peer_he_ops));
> +
> +	/* the top most byte is used to indicate BSS color info */
> +	arg->peer_he_ops &= 0xffffff;
> +
> +	if (he_cap->he_cap_elem.phy_cap_info[6] &
> +	    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT) {
> +		int bit = 7;
> +		int nss, ru;
> +
> +		arg->peer_ppet.numss_m1 = he_cap->ppe_thres[0] &
> +					  IEEE80211_PPE_THRES_NSS_MASK;
> +		arg->peer_ppet.ru_bit_mask =
> +			(he_cap->ppe_thres[0] &
> +			 IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK) >>
> +			IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS;
> +
> +		for (nss = 0; nss <= arg->peer_ppet.numss_m1; nss++) {
> +			for (ru = 0; ru < 4; ru++) {
> +				u32 val = 0;
> +				int i;
> +
> +				if ((arg->peer_ppet.ru_bit_mask & BIT(ru)) == 0)
> +					continue;
> +				for (i = 0; i < 6; i++) {
> +					val >>= 1;
> +					val |= ((he_cap->ppe_thres[bit / 8] >>
> +						 (bit % 8)) & 0x1) << 5;
> +					bit++;
> +				}
> +				arg->peer_ppet.ppet16_ppet8_ru3_ru0[nss] |=
> +								val << (ru * 6);
> +			}
> +		}
> +	}
> +
> +	switch (sta->bandwidth) {
> +	case IEEE80211_STA_RX_BW_160:
> +		if (he_cap->he_cap_elem.phy_cap_info[0] &
> +		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G) {
> +			v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80p80);
> +			arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
> +
> +			v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80p80);
> +			arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80_80] = v;
> +
> +			arg->peer_he_mcs_count++;
> +		}
> +		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
> +		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
> +
> +		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_160);
> +		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_160] = v;
> +
> +		arg->peer_he_mcs_count++;
> +		/* fall through */
> +
> +	default:
> +		v = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
> +		arg->peer_he_rx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
> +
> +		v = le16_to_cpu(he_cap->he_mcs_nss_supp.tx_mcs_80);
> +		arg->peer_he_tx_mcs_set[WMI_HECAP_TXRX_MCS_NSS_IDX_80] = v;
> +
> +		arg->peer_he_mcs_count++;
> +		break;
> +	}
>   }
>   
>   static void ath11k_peer_assoc_h_smps(struct ieee80211_sta *sta,
> @@ -1307,6 +1386,32 @@ static enum wmi_phy_mode ath11k_mac_get_phymode_vht(struct ath11k *ar,
>   	return MODE_UNKNOWN;
>   }
>   
> +static enum wmi_phy_mode ath11k_mac_get_phymode_he(struct ath11k *ar,
> +						   struct ieee80211_sta *sta)
> +{
> +	if (sta->bandwidth == IEEE80211_STA_RX_BW_160) {
> +		if (sta->he_cap.he_cap_elem.phy_cap_info[0] &
> +		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G)
> +			return MODE_11AX_HE160;
> +		else if (sta->he_cap.he_cap_elem.phy_cap_info[0] &
> +		     IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
> +			return MODE_11AX_HE80_80;
> +		/* not sure if this is a valid case? */
> +		return MODE_11AX_HE160;
> +	}
> +
> +	if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
> +		return MODE_11AX_HE80;
> +
> +	if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
> +		return MODE_11AX_HE40;
> +
> +	if (sta->bandwidth == IEEE80211_STA_RX_BW_20)
> +		return MODE_11AX_HE20;
> +
> +	return MODE_UNKNOWN;
> +}
> +
>   static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
>   					struct ieee80211_vif *vif,
>   					struct ieee80211_sta *sta,
> @@ -1328,7 +1433,14 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
>   
>   	switch (band) {
>   	case NL80211_BAND_2GHZ:
> -		if (sta->vht_cap.vht_supported &&
> +		if (sta->he_cap.has_he) {
> +			if (sta->bandwidth == IEEE80211_STA_RX_BW_80)
> +				phymode = MODE_11AX_HE80_2G;
> +			else if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
> +				phymode = MODE_11AX_HE40_2G;
> +			else
> +				phymode = MODE_11AX_HE20_2G;
> +		} else if (sta->vht_cap.vht_supported &&
>   		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
>   			if (sta->bandwidth == IEEE80211_STA_RX_BW_40)
>   				phymode = MODE_11AC_VHT40;
> @@ -1345,12 +1457,12 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
>   		} else {
>   			phymode = MODE_11B;
>   		}
> -		/* TODO: HE */
> -
>   		break;
>   	case NL80211_BAND_5GHZ:
> -		/* Check VHT first */
> -		if (sta->vht_cap.vht_supported &&
> +		/* Check HE first */
> +		if (sta->he_cap.has_he) {
> +			phymode = ath11k_mac_get_phymode_he(ar, sta);
> +		} else if (sta->vht_cap.vht_supported &&
>   		    !ath11k_peer_assoc_h_vht_masked(vht_mcs_mask)) {
>   			phymode = ath11k_mac_get_phymode_vht(ar, sta);
>   		} else if (sta->ht_cap.ht_supported &&
> @@ -1362,7 +1474,6 @@ static void ath11k_peer_assoc_h_phymode(struct ath11k *ar,
>   		} else {
>   			phymode = MODE_11A;
>   		}
> -		/* TODO: HE Phymode */
>   		break;
>   	default:
>   		break;
> @@ -3126,6 +3237,142 @@ static int ath11k_check_chain_mask(struct ath11k *ar, u32 ant, bool is_tx_ant)
>   	return 0;
>   }
>   
> +static void ath11k_gen_ppe_thresh(struct ath11k_ppe_threshold *fw_ppet,
> +				  u8 *he_ppet)
> +{
> +	int nss, ru;
> +	u8 bit = 7;
> +
> +	he_ppet[0] = fw_ppet->numss_m1 & IEEE80211_PPE_THRES_NSS_MASK;
> +	he_ppet[0] |= (fw_ppet->ru_bit_mask <<
> +		       IEEE80211_PPE_THRES_RU_INDEX_BITMASK_POS) &
> +		      IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK;
> +	for (nss = 0; nss <= fw_ppet->numss_m1; nss++) {
> +		for (ru = 0; ru < 4; ru++) {
> +			u8 val;
> +			int i;
> +
> +			if ((fw_ppet->ru_bit_mask & BIT(ru)) == 0)
> +				continue;
> +			val = (fw_ppet->ppet16_ppet8_ru3_ru0[nss] >> (ru * 6)) &
> +			       0x3f;
> +			val = ((val >> 3) & 0x7) | ((val & 0x7) << 3);
> +			for (i = 5; i >= 0; i--) {
> +				he_ppet[bit / 8] |=
> +					((val >> i) & 0x1) << ((bit % 8));
> +				bit++;
> +			}
> +		}
> +	}
> +}
> +
> +static int ath11k_mac_copy_he_cap(struct ath11k *ar,
> +				  struct ath11k_pdev_cap *cap,
> +				  struct ieee80211_sband_iftype_data *data,
> +				  int band)
> +{
> +	int i, idx = 0;
> +
> +	for (i = 0; i < NUM_NL80211_IFTYPES; i++) {
> +		struct ieee80211_sta_he_cap *he_cap = &data[idx].he_cap;
> +		struct ath11k_band_cap *band_cap = &cap->band[band];
> +		struct ieee80211_he_cap_elem *he_cap_elem =
> +				&he_cap->he_cap_elem;
> +
> +		switch (i) {
> +		case NL80211_IFTYPE_STATION:
> +		case NL80211_IFTYPE_AP:
> +			break;
> +
> +		default:
> +			continue;
> +		}
> +
> +		data[idx].types_mask = BIT(i);
> +		he_cap->has_he = true;
> +		memcpy(he_cap_elem->mac_cap_info, band_cap->he_cap_info,
> +		       sizeof(he_cap_elem->mac_cap_info));
> +		memcpy(he_cap_elem->phy_cap_info, band_cap->he_cap_phy_info,
> +		       sizeof(he_cap_elem->phy_cap_info));
> +
> +		he_cap_elem->mac_cap_info[1] |=
> +			IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK;
> +		he_cap_elem->phy_cap_info[4] &=
> +			~IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK;
> +		he_cap_elem->phy_cap_info[4] &=
> +			~IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK;
> +		he_cap_elem->phy_cap_info[4] |= (ar->num_tx_chains - 1) << 2;
> +
> +		he_cap_elem->phy_cap_info[5] &=
> +			~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK;
> +		he_cap_elem->phy_cap_info[5] &=
> +			~IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_MASK;
> +		he_cap_elem->phy_cap_info[5] |= ar->num_tx_chains - 1;
> +
> +		switch (i) {
> +		case NL80211_IFTYPE_AP:
> +			he_cap_elem->phy_cap_info[9] |=
> +				IEEE80211_HE_PHY_CAP9_RX_1024_QAM_LESS_THAN_242_TONE_RU;
> +			break;
> +		case NL80211_IFTYPE_STATION:
> +			he_cap_elem->mac_cap_info[0] &=
> +				~IEEE80211_HE_MAC_CAP0_TWT_RES;
> +			he_cap_elem->mac_cap_info[0] |=
> +				IEEE80211_HE_MAC_CAP0_TWT_REQ;
> +			he_cap_elem->phy_cap_info[9] |=
> +				IEEE80211_HE_PHY_CAP9_TX_1024_QAM_LESS_THAN_242_TONE_RU;
> +			break;
> +		}
> +
> +		he_cap->he_mcs_nss_supp.rx_mcs_80 =
> +			cpu_to_le16(band_cap->he_mcs & 0xffff);
> +		he_cap->he_mcs_nss_supp.tx_mcs_80 =
> +			cpu_to_le16(band_cap->he_mcs & 0xffff);
> +		he_cap->he_mcs_nss_supp.rx_mcs_160 =
> +			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> +		he_cap->he_mcs_nss_supp.tx_mcs_160 =
> +			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> +		he_cap->he_mcs_nss_supp.rx_mcs_80p80 =
> +			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> +		he_cap->he_mcs_nss_supp.tx_mcs_80p80 =
> +			cpu_to_le16((band_cap->he_mcs >> 16) & 0xffff);
> +
> +		memset(he_cap->ppe_thres, 0, sizeof(he_cap->ppe_thres));
> +		if (he_cap_elem->phy_cap_info[6] &
> +		    IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT)
> +			ath11k_gen_ppe_thresh(&band_cap->he_ppet,
> +					      he_cap->ppe_thres);
> +		idx++;
> +	}
> +
> +	return idx;
> +}
> +
> +static void ath11k_mac_setup_he_cap(struct ath11k *ar,
> +				    struct ath11k_pdev_cap *cap)
> +{
> +	struct ieee80211_supported_band *band = NULL;
> +	int count = 0;
> +
> +	if (cap->supported_bands & WMI_HOST_WLAN_2G_CAP) {
> +		count = ath11k_mac_copy_he_cap(ar, cap,
> +					       ar->mac.iftype[NL80211_BAND_2GHZ],
> +					       NL80211_BAND_2GHZ);
> +		band = &ar->mac.sbands[NL80211_BAND_2GHZ];
> +		band->iftype_data = ar->mac.iftype[NL80211_BAND_2GHZ];
> +	}
> +
> +	if (cap->supported_bands & WMI_HOST_WLAN_5G_CAP) {
> +		count = ath11k_mac_copy_he_cap(ar, cap,
> +					       ar->mac.iftype[NL80211_BAND_5GHZ],
> +					       NL80211_BAND_5GHZ);
> +		band = &ar->mac.sbands[NL80211_BAND_5GHZ];
> +		band->iftype_data = ar->mac.iftype[NL80211_BAND_5GHZ];
> +	}
> +
> +	band->n_iftype_data = count;
> +}
> +
>   static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
>   {
>   	int ret;
> @@ -3161,8 +3408,9 @@ static int __ath11k_set_antenna(struct ath11k *ar, u32 tx_ant, u32 rx_ant)
>   		return ret;
>   	}
>   
> -	/* Reload HT/VHT capability */
> +	/* Reload HT/VHT/HE capability */
>   	ath11k_mac_setup_ht_vht_cap(ar, &ar->pdev->cap, NULL);
> +	ath11k_mac_setup_he_cap(ar, &ar->pdev->cap);
>   
>   	return 0;
>   }
> @@ -5207,6 +5455,7 @@ static int ath11k_mac_register(struct ath11k *ar)
>   		goto err_free;
>   
>   	ath11k_mac_setup_ht_vht_cap(ar, cap, &ht_cap);
> +	ath11k_mac_setup_he_cap(ar, cap);
>   
>   	ar->hw->wiphy->available_antennas_rx = cap->rx_chain_mask;
>   	ar->hw->wiphy->available_antennas_tx = cap->tx_chain_mask;
> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
> index 810050b033c4..453aa9c06969 100644
> --- a/drivers/net/wireless/ath/ath11k/reg.c
> +++ b/drivers/net/wireless/ath/ath11k/reg.c
> @@ -141,6 +141,7 @@ int ath11k_reg_update_chan_list(struct ath11k *ar)
>   			/* TODO: Set to true/false based on some condition? */
>   			ch->allow_ht = true;
>   			ch->allow_vht = true;
> +			ch->allow_he = true;
>   
>   			ch->dfs_set =
>   				!!(channel->flags & IEEE80211_CHAN_RADAR);
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 3ec5dd47cdc8..d077ea30f3c1 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -753,6 +753,8 @@ static void ath11k_wmi_put_wmi_channel(struct wmi_channel *chan,
>   		chan->info |= WMI_CHAN_INFO_ALLOW_HT;
>   	if (arg->channel.allow_vht)
>   		chan->info |= WMI_CHAN_INFO_ALLOW_VHT;
> +	if (arg->channel.allow_he)
> +		chan->info |= WMI_CHAN_INFO_ALLOW_HE;
>   	if (arg->channel.ht40plus)
>   		chan->info |= WMI_CHAN_INFO_HT40_PLUS;
>   	if (arg->channel.chan_radar)
> @@ -2150,7 +2152,9 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
>   
>   		if (tchan_info->is_chan_passive)
>   			chan_info->info |= WMI_CHAN_INFO_PASSIVE;
> -		if (tchan_info->allow_vht)
> +		if (tchan_info->allow_he)
> +			chan_info->info |= WMI_CHAN_INFO_ALLOW_HE;
> +		else if (tchan_info->allow_vht)
>   			chan_info->info |= WMI_CHAN_INFO_ALLOW_VHT;
>   		else if (tchan_info->allow_ht)
>   			chan_info->info |= WMI_CHAN_INFO_ALLOW_HT;
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
> index 1110da29cfcd..fd1ffa593a41 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.h
> +++ b/drivers/net/wireless/ath/ath11k/wmi.h
> @@ -2445,6 +2445,7 @@ struct channel_param {
>   	    is_chan_passive:1,
>   	    allow_ht:1,
>   	    allow_vht:1,
> +	    allow_he:1,
>   	    set_agile:1;
>   	u32 phy_mode;
>   	u32 cfreq1;
> @@ -3334,7 +3335,10 @@ struct wmi_vdev_install_key_arg {
>   
>   #define WMI_MAX_SUPPORTED_RATES			128
>   #define WMI_HOST_MAX_HECAP_PHY_SIZE		3
> -#define WMI_HOST_MAX_HE_RATE_SET		1
> +#define WMI_HOST_MAX_HE_RATE_SET		3
> +#define WMI_HECAP_TXRX_MCS_NSS_IDX_80		0
> +#define WMI_HECAP_TXRX_MCS_NSS_IDX_160		1
> +#define WMI_HECAP_TXRX_MCS_NSS_IDX_80_80	2
>   
>   struct wmi_rate_set_arg {
>   	u32 num_rates;
> 

