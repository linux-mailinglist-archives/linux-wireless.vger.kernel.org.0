Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8AA631A56
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Nov 2022 08:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiKUHbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Nov 2022 02:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKUHaj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Nov 2022 02:30:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4848D6455D
        for <linux-wireless@vger.kernel.org>; Sun, 20 Nov 2022 23:29:54 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AL5dSon011466;
        Mon, 21 Nov 2022 07:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O6D7HNLDZva1nxIj0XWUhUnRuQEfNr64cjKE/8lREG4=;
 b=e8F3AMf/2yXzo3K79rWo3JrT7XAVwVcft2urjNlWUfflpkmXhbSLoucwUxPu7KAu9CgI
 zdcgEXK3FbKFrfdlI9WGw5f/B22rn03fESsXxVzivSs7tO5VpCrt6eEQARYSgEKzThXs
 ogaq57dTtU72TpVjywoLyY5v1bw9PGOHqe9Hnr6eph9GPh4M13V8btnhtI/MaCqNPaN5
 RV9uPFKxNOHkuOrdo0zrtdwTK+awbT81N3FyrMiuzrOBgt7H98L1I0ySOdJAai+TM+CM
 9PDn5zDS0n1dbMPHnXEATvBIA7h/NL7czP97hLkpkEOzQ1oUZKsUrJbwFuYNKBLSgyKm 9Q== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kxrf5krgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 07:29:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2AL7TkOS018763
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 07:29:46 GMT
Received: from [10.253.79.99] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 20 Nov
 2022 23:29:44 -0800
Message-ID: <e4db49e4-6363-0c8d-10dd-a1a564da2542@quicinc.com>
Date:   Mon, 21 Nov 2022 15:29:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH] mac80211: mlme: Handle Puncturing information
 received from the AP
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        "Carl Huang (QUIC)" <quic_cjhuang@quicinc.com>
References: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
From:   Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <20220325140859.e48bf244f157.I3547481d49f958389f59dfeba3fcc75e72b0aa6e@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7to_7ewrO19y4XgsloHTUAW0jItfAIy0
X-Proofpoint-ORIG-GUID: 7to_7ewrO19y4XgsloHTUAW0jItfAIy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_05,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi:
	1.Do you have any new version about this RFC patch?
	
	2.I have some questions about this patch:

On 3/25/2022 9:09 PM, Johannes Berg wrote:
> From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> 
> Handle the Puncturing info received from the AP
> in the EHT Operation IE in beacons.
> If the info changed and is valid - update the driver.
> If the info is invalid:
>   - During association: disable EHT connection for the AP.
>   - After association: disconnect.
> 
> type=feature
> ticket=none
> 
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> RFC because I wanted you to see it now, and I didn't change all
> the drivers yet
> ---
>   drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |   4 +-
>   drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |   4 +-
>   .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
>   drivers/net/wireless/mac80211_hwsim.c         |   6 +-
>   include/net/mac80211.h                        |   6 +-
>   net/mac80211/driver-ops.h                     |   4 +-
>   net/mac80211/ieee80211_i.h                    |   2 +-
>   net/mac80211/main.c                           |   2 +-
>   net/mac80211/mlme.c                           | 199 +++++++++++++++++-
>   net/mac80211/util.c                           |   3 +
>   10 files changed, 218 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
> index abb8696ba294..2045d027bfd1 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/agn.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>   /*
> - * Copyright (C) 2005-2014, 2021 Intel Corporation
> + * Copyright (C) 2005-2014, 2021-2022 Intel Corporation
>    */
>   #ifndef __iwl_agn_h__
>   #define __iwl_agn_h__
> @@ -92,7 +92,7 @@ int iwlagn_mac_config(struct ieee80211_hw *hw, u32 changed);
>   void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
>   			     struct ieee80211_vif *vif,
>   			     struct ieee80211_bss_conf *bss_conf,
> -			     u32 changes);
> +			     u64 changes);
>   void iwlagn_config_ht40(struct ieee80211_conf *conf,
>   			struct iwl_rxon_context *ctx);
>   void iwl_set_rxon_ht(struct iwl_priv *priv, struct iwl_ht_config *ht_conf);
> diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
> index 70338bc7bb54..23295fa602b9 100644
> --- a/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
> +++ b/drivers/net/wireless/intel/iwlwifi/dvm/rxon.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /******************************************************************************
>    *
> - * Copyright(c) 2003 - 2014 Intel Corporation. All rights reserved.
> + * Copyright(c) 2003 - 2014, 2022 Intel Corporation. All rights reserved.
>    * Copyright(c) 2015 Intel Deutschland GmbH
>    *****************************************************************************/
>   
> @@ -1383,7 +1383,7 @@ static void iwlagn_chain_noise_reset(struct iwl_priv *priv)
>   void iwlagn_bss_info_changed(struct ieee80211_hw *hw,
>   			     struct ieee80211_vif *vif,
>   			     struct ieee80211_bss_conf *bss_conf,
> -			     u32 changes)
> +			     u64 changes)
>   {
>   	struct iwl_priv *priv = IWL_MAC80211_GET_DVM(hw);
>   	struct iwl_rxon_context *ctx = iwl_rxon_ctx_from_vif(vif);
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> index 784d91281c02..37d9ff01ad7c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
> @@ -2192,7 +2192,7 @@ static void iwl_mvm_protect_assoc(struct iwl_mvm *mvm,
>   static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
>   					     struct ieee80211_vif *vif,
>   					     struct ieee80211_bss_conf *bss_conf,
> -					     u32 changes)
> +					     u64 changes)
>   {
>   	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
>   	int ret;
> @@ -2632,7 +2632,7 @@ iwl_mvm_bss_info_changed_ap_ibss(struct iwl_mvm *mvm,
>   static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
>   				     struct ieee80211_vif *vif,
>   				     struct ieee80211_bss_conf *bss_conf,
> -				     u32 changes)
> +				     u64 changes)
>   {
>   	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
>   
> diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
> index 28bfa7b7b73c..a6c991453c50 100644
> --- a/drivers/net/wireless/mac80211_hwsim.c
> +++ b/drivers/net/wireless/mac80211_hwsim.c
> @@ -2097,15 +2097,15 @@ static void mac80211_hwsim_bcn_en_iter(void *data, u8 *mac,
>   static void mac80211_hwsim_bss_info_changed(struct ieee80211_hw *hw,
>   					    struct ieee80211_vif *vif,
>   					    struct ieee80211_bss_conf *info,
> -					    u32 changed)
> +					    u64 changed)
>   {
>   	struct hwsim_vif_priv *vp = (void *)vif->drv_priv;
>   	struct mac80211_hwsim_data *data = hw->priv;
>   
>   	hwsim_check_magic(vif);
>   
> -	wiphy_dbg(hw->wiphy, "%s(changed=0x%x vif->addr=%pM)\n",
> -		  __func__, changed, vif->addr);
> +	wiphy_dbg(hw->wiphy, "%s(changed=0x%llx vif->addr=%pM)\n",
> +		  __func__, (unsigned long long)changed, vif->addr);
>   
>   	if (changed & BSS_CHANGED_BSSID) {
>   		wiphy_dbg(hw->wiphy, "%s: BSSID changed: %pM\n",
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 382ebb862ea8..b2b0bcfab957 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -320,6 +320,7 @@ struct ieee80211_vif_chanctx_switch {
>    * @BSS_CHANGED_FILS_DISCOVERY: FILS discovery status changed.
>    * @BSS_CHANGED_UNSOL_BCAST_PROBE_RESP: Unsolicited broadcast probe response
>    *	status changed.
> + * @BSS_CHANGED_EHT_PUNCTURING: Puncturing bitmap changed.
>    *
>    */
>   enum ieee80211_bss_change {
> @@ -355,6 +356,7 @@ enum ieee80211_bss_change {
>   	BSS_CHANGED_HE_BSS_COLOR	= 1<<29,
>   	BSS_CHANGED_FILS_DISCOVERY      = 1<<30,
>   	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
> +	BSS_CHANGED_EHT_PUNCTURING	= 1ULL<<32,
>   
>   	/* when adding here, make sure to change ieee80211_reconfig */
>   };
> @@ -637,6 +639,7 @@ struct ieee80211_fils_discovery {
>    * @tx_pwr_env_num: number of @tx_pwr_env.
>    * @pwr_reduction: power constraint of BSS.
>    * @eht_support: does this BSS support EHT
> + * @eht_puncturing: bitmap to indicate which channels are punctured in this BSS
>    */
>   struct ieee80211_bss_conf {
>   	const u8 *bssid;
> @@ -712,6 +715,7 @@ struct ieee80211_bss_conf {
>   	u8 tx_pwr_env_num;
>   	u8 pwr_reduction;
>   	bool eht_support;
> +	u16 eht_puncturing;
>   };
>   
>   /**
> @@ -3989,7 +3993,7 @@ struct ieee80211_ops {
>   	void (*bss_info_changed)(struct ieee80211_hw *hw,
>   				 struct ieee80211_vif *vif,
>   				 struct ieee80211_bss_conf *info,
> -				 u32 changed);
> +				 u64 changed);
>   
>   	int (*start_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
>   	void (*stop_ap)(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
> diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
> index 4e2fc1a08681..46797a6cabd6 100644
> --- a/net/mac80211/driver-ops.h
> +++ b/net/mac80211/driver-ops.h
> @@ -2,7 +2,7 @@
>   /*
>   * Portions of this file
>   * Copyright(c) 2016 Intel Deutschland GmbH
> -* Copyright (C) 2018 - 2019, 2021 Intel Corporation
> +* Copyright (C) 2018 - 2019, 2021 - 2022 Intel Corporation
>   */
>   
>   #ifndef __MAC80211_DRIVER_OPS
> @@ -150,7 +150,7 @@ static inline int drv_config(struct ieee80211_local *local, u32 changed)
>   static inline void drv_bss_info_changed(struct ieee80211_local *local,
>   					struct ieee80211_sub_if_data *sdata,
>   					struct ieee80211_bss_conf *info,
> -					u32 changed)
> +					u64 changed)
>   {
>   	might_sleep();
>   
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index d4a7ba4a8202..76d31c11bf31 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -1812,7 +1812,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
>   int ieee80211_hw_config(struct ieee80211_local *local, u32 changed);
>   void ieee80211_tx_set_protected(struct ieee80211_tx_data *tx);
>   void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
> -				      u32 changed);
> +				      u64 changed);
>   void ieee80211_configure_filter(struct ieee80211_local *local);
>   u32 ieee80211_reset_erp_info(struct ieee80211_sub_if_data *sdata);
>   
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index a48a32f87897..832923005c5e 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -200,7 +200,7 @@ int ieee80211_hw_config(struct ieee80211_local *local, u32 changed)
>   }
>   
>   void ieee80211_bss_info_change_notify(struct ieee80211_sub_if_data *sdata,
> -				      u32 changed)
> +				      u64 changed)
>   {
>   	struct ieee80211_local *local = sdata->local;
>   
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index 1b30c724ca8d..51d5a1cbdd88 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -88,6 +88,117 @@ MODULE_PARM_DESC(probe_wait_ms,
>    */
>   #define IEEE80211_SIGNAL_AVE_MIN_COUNT	4
>   
> +struct ieee80211_per_bw_puncturing_values {
> +	u8 len;
> +	const u16 *valid_values;
> +};
> +
> +static const u16 puncturing_values_80mhz[] = {
> +	0x8, 0x4, 0x2, 0x1
> +};
> +
> +static const u16 puncturing_values_160mhz[] = {
> +	 0x80, 0x40, 0x20, 0x10, 0x8, 0x4, 0x2, 0x1, 0xc0, 0x30, 0xc, 0x3
> +};
> +
> +static const u16 puncturing_values_320mhz[] = {
> +	0xc000, 0x3000, 0xc00, 0x300, 0xc0, 0x30, 0xc, 0x3, 0xf000, 0xf00,
> +	0xf0, 0xf, 0xfc00, 0xf300, 0xf0c0, 0xf030, 0xf00c, 0xf003, 0xc00f,
> +	0x300f, 0xc0f, 0x30f, 0xcf, 0x3f
> +};
> +
> +#define IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(_bw) \
> +	[IEEE80211_EHT_OPER_CHAN_WIDTH_ ## _bw ## MHZ - IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ] = \
> +	{ \
> +		.len = ARRAY_SIZE(puncturing_values_ ## _bw ## mhz), \
> +		.valid_values = puncturing_values_ ## _bw ## mhz \
> +	}
> +
> +static const struct ieee80211_per_bw_puncturing_values per_bw_puncturing[] = {
> +	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(80),
> +	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(160),
> +	IEEE80211_PER_BW_VALID_PUNCTURING_VALUES(320)
> +};
> +
> +static bool ieee80211_valid_disable_subchannel_bitmap(u16 *bitmap, u8 bw)
> +{
> +	int i;
> +
> +	if (bw < IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ)
> +		*bitmap = 0;
> +
> +	if (!*bitmap)
> +		return true;
> +
> +	/* Convert the bw to an array index */
> +	bw -= IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ;
> +	for (i = 0; i < per_bw_puncturing[bw].len; i++)
> +		if (per_bw_puncturing[bw].valid_values[i] == *bitmap)
> +			return true;
> +
> +	return false;
> +}
> +
> +/*
> + * Extract from the given disabled subchannel bitmap (raw format
> + * from the EHT Operation Element) the bits for the subchannel
> + * we're using right now.
> + */
> +static u16
> +ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
> +				 struct cfg80211_chan_def *chandef, u16 bitmap)
> +{
> +	int sta_center_freq = ieee80211_channel_to_frequency(eht_oper->ccfs,
> +							     chandef->chan->band);
> +	u32 center_freq = chandef->chan->center_freq;
The shift is calculated by the difference of old and new channel center
frequency.The new channel center frequency should be 
"chandef->center_freq1" after BW negotitaion.
"chandef->chan->center_freq" is the primary channel frequency.
> +	u8 sta_bw = 20 * BIT(u8_get_bits(eht_oper->chan_width,
> +					 IEEE80211_EHT_OPER_CHAN_WIDTH));
> +	u8 bw = 20 * BIT(ieee80211_chan_width_to_rx_bw(chandef->width));
> +	int sta_start_freq = sta_center_freq - sta_bw / 2;
> +	int start_freq = center_freq - bw / 2;
> +	u16 shift = (start_freq - sta_start_freq) / 20;
> +	u16 mask = BIT(sta_bw / 20) - 1;
The mask is used to extra the valid bit according to the new BW,
but current algorithm is using the old bandwidth.
> +
> +	return (bitmap >> shift) & mask;
> +}
> +
> +/*
> + * Handle the puncturing bitmap, possibly downgrading bandwidth to get a
> + * valid bitmap.
> + */
> +static void
> +ieee80211_handle_puncturing_bitmap(struct ieee80211_sub_if_data *sdata,
> +				   const struct ieee80211_eht_operation *eht_oper,
> +				   u16 bitmap, u64 *changed)
> +{
> +	struct cfg80211_chan_def *chandef = &sdata->vif.bss_conf.chandef;
> +	u16 extracted;
> +	u64 _changed = 0;
> +
> +	if (!changed)
> +		changed = &_changed;
> +
> +	while (chandef->width > NL80211_CHAN_WIDTH_40) {
> +		extracted =
> +			ieee80211_extract_dis_subch_bmap(eht_oper, chandef,
> +							 bitmap);
> +
> +		if (ieee80211_valid_disable_subchannel_bitmap(&bitmap,
> +							      chandef->width))
Here extract the bitmap according new negotiated BW. After extracting, 
check whether it is valid.
I think you should use "&extracted"  instead of "&bitmap"

> +			break;
> +		sdata->u.mgd.flags |= ieee80211_chandef_downgrade(chandef);
> +		*changed |= BSS_CHANGED_BANDWIDTH;
> +	}
> +
> +	if (chandef->width == NL80211_CHAN_WIDTH_40)
> +		extracted = 0;
> +
> +	if (sdata->vif.bss_conf.eht_puncturing != extracted) {
> +		sdata->vif.bss_conf.eht_puncturing = extracted;
> +		*changed |= BSS_CHANGED_EHT_PUNCTURING;
> +	}
> +}
> +
>   /*
>    * We can have multiple work items (and connection probing)
>    * scheduling this timer, but we need to take care to only
> @@ -3608,6 +3719,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
>   							    sta);
>   
>   			bss_conf->eht_support = sta->sta.eht_cap.has_eht;
> +			changed |= BSS_CHANGED_EHT_PUNCTURING;
>   		} else {
>   			bss_conf->eht_support = false;
>   		}
> @@ -4100,6 +4212,41 @@ static bool ieee80211_rx_our_beacon(const u8 *tx_bssid,
>   	return ether_addr_equal(tx_bssid, bss->transmitted_bss->bssid);
>   }
>   
> +static bool ieee80211_config_puncturing(struct ieee80211_sub_if_data *sdata,
> +					const struct ieee80211_eht_operation *eht_oper,
> +					u64 *changed)
> +{
> +	u16 bitmap, extracted;
> +	u8 bw;
> +
> +	if (!u8_get_bits(eht_oper->present_bm,
> +			 IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT))
> +		bitmap = 0;
> +	else
> +		bitmap = get_unaligned_le16(eht_oper->disable_subchannel_bitmap);
> +
Should check initial bitmap here.
> +	extracted = ieee80211_extract_dis_subch_bmap(eht_oper,
> +						     &sdata->vif.bss_conf.chandef,
> +						     bitmap);
> +
> +	/* accept if there are no changes */
> +	if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
> +	    extracted == sdata->vif.bss_conf.eht_puncturing)
> +		return true;
> +
> +	bw = u8_get_bits(eht_oper->chan_width, IEEE80211_EHT_OPER_CHAN_WIDTH);
> +
> +	if (!ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw)) {
> +		sdata_info(sdata,
> +			   "Got an invalid disable subchannel bitmap from AP %pM: bitmap = 0x%x, bw = 0x%x. disconnect\n",
> +			    sdata->u.mgd.associated->bssid, bitmap, bw);
> +		return false;
> +	}
The initial bitmap received from the AP is checked here.
I think it should be carried out before the extraction above.
> +
> +	ieee80211_handle_puncturing_bitmap(sdata, eht_oper, bitmap, changed);
> +	return true;
> +}
> +
>   static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
>   				     struct ieee80211_hdr *hdr, size_t len,
>   				     struct ieee80211_rx_status *rx_status)
> @@ -4113,7 +4260,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
>   	struct ieee80211_chanctx_conf *chanctx_conf;
>   	struct ieee80211_channel *chan;
>   	struct sta_info *sta;
> -	u32 changed = 0;
> +	u64 changed = 0;
>   	bool erp_valid;
>   	u8 erp_value = 0;
>   	u32 ncrc = 0;
> @@ -4360,7 +4507,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
>   				elems->vht_cap_elem, elems->ht_operation,
>   				elems->vht_operation, elems->he_operation,
>   				elems->eht_operation,
> -				elems->s1g_oper, bssid, &changed)) {
> +				elems->s1g_oper, bssid, (u32 *)&changed)) {
>   		mutex_unlock(&local->sta_mtx);
>   		sdata_info(sdata,
>   			   "failed to follow AP %pM bandwidth change, disconnect\n",
> @@ -4386,6 +4533,21 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
>   					       elems->pwr_constr_elem,
>   					       elems->cisco_dtpc_elem);
>   
> +	if (elems->eht_operation &&
> +	    !(ifmgd->flags & IEEE80211_STA_DISABLE_EHT)) {
> +		if (!ieee80211_config_puncturing(sdata, elems->eht_operation,
> +						 &changed)) {
> +			ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
> +					       WLAN_REASON_DEAUTH_LEAVING,
> +					       true, deauth_buf);
> +			ieee80211_report_disconnect(sdata, deauth_buf,
> +						    sizeof(deauth_buf), true,
> +						    WLAN_REASON_DEAUTH_LEAVING,
> +						    false);
> +			goto free;
> +		}
> +	}
> +
>   	ieee80211_bss_info_change_notify(sdata, changed);
>   free:
>   	kfree(elems);
> @@ -6189,6 +6351,39 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
>   		assoc_data->timeout = jiffies;
>   		assoc_data->timeout_started = true;
>   	}
> +
> +	sdata->vif.bss_conf.eht_puncturing = 0;
> +	if (beacon_ies) {
> +		const struct element *elem =
> +			cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_OPERATION,
> +					       beacon_ies->data, beacon_ies->len);
> +		const struct ieee80211_eht_operation *eht_oper;
> +
> +		eht_oper = (const void *)(elem->data + 1);
> +
> +		/*
> +		 * The length should include one byte for the EID
> +		 * and 2 for the disabled subchannel bitmap
> +		 */
> +		if (elem &&
> +		    elem->datalen >= sizeof(*eht_oper) + 1 + 2 &&
> +		    eht_oper->present_bm &
> +				IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT) {
> +			u8 bw = u8_get_bits(eht_oper->chan_width,
> +					    IEEE80211_EHT_OPER_CHAN_WIDTH);
> +			u16 bitmap;
> +
> +			bitmap = get_unaligned_le16(eht_oper->disable_subchannel_bitmap);
> +
> +			if (ieee80211_valid_disable_subchannel_bitmap(&bitmap, bw))
> +				ieee80211_handle_puncturing_bitmap(sdata,
> +								   eht_oper,
> +								   bitmap,
> +								   NULL);
> +			else
> +				ifmgd->flags |= IEEE80211_STA_DISABLE_EHT;
> +		}
> +	}
>   	rcu_read_unlock();
>   
>   	run_again(sdata, assoc_data->timeout);
> diff --git a/net/mac80211/util.c b/net/mac80211/util.c
> index 682a164f795a..18786213bd16 100644
> --- a/net/mac80211/util.c
> +++ b/net/mac80211/util.c
> @@ -2540,6 +2540,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
>   			    sdata->vif.bss_conf.protected_keep_alive)
>   				changed |= BSS_CHANGED_KEEP_ALIVE;
>   
> +			if (sdata->vif.bss_conf.eht_puncturing)
> +				changed |= BSS_CHANGED_EHT_PUNCTURING;
> +
>   			sdata_lock(sdata);
>   			ieee80211_bss_info_change_notify(sdata, changed);
>   			sdata_unlock(sdata);
