Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 810CB1C1EE
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 07:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENFjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 01:39:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54224 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725562AbfENFjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 01:39:24 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hQQ9l-0007fb-NA; Tue, 14 May 2019 08:39:17 +0300
Message-ID: <d02c4f44024be655cc939490e32442e5a23e5cb0.camel@coelho.fi>
Subject: Re: [PATCH] iwlwifi: remove some unnecessary NULL checks
From:   Luca Coelho <luca@coelho.fi>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Naftali Goldstein <naftali.goldstein@intel.com>,
        Sara Sharon <sara.sharon@intel.com>,
        Shaul Triebitz <shaul.triebitz@intel.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Liad Kaufman <liad.kaufman@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Tue, 14 May 2019 08:39:16 +0300
In-Reply-To: <20190506125409.GC13799@mwanda>
References: <20190506125409.GC13799@mwanda>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-05-06 at 15:54 +0300, Dan Carpenter wrote:
> These pointers are an offset into the "sta" struct.  They're assigned
> like this:
> 
> 	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
> 
> They're not the first member of the struct (->supp_rates[] is first) so
> they can't be NULL.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    | 23 +++++++++----------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
> index 659e21b2d4e7..b6fb670d249c 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
> @@ -101,7 +101,7 @@ static u8 rs_fw_sgi_cw_support(struct ieee80211_sta *sta)
>  	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
>  	u8 supp = 0;
>  
> -	if (he_cap && he_cap->has_he)
> +	if (he_cap->has_he)
>  		return 0;
>  
>  	if (ht_cap->cap & IEEE80211_HT_CAP_SGI_20)
> @@ -123,12 +123,12 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
>  	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
>  	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
>  	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
> -	bool vht_ena = vht_cap && vht_cap->vht_supported;
> +	bool vht_ena = vht_cap->vht_supported;
>  	u16 flags = 0;
>  
>  	if (mvm->cfg->ht_params->stbc &&
>  	    (num_of_ant(iwl_mvm_get_valid_tx_ant(mvm)) > 1)) {
> -		if (he_cap && he_cap->has_he) {
> +		if (he_cap->has_he) {
>  			if (he_cap->he_cap_elem.phy_cap_info[2] &
>  			    IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ)
>  				flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
> @@ -136,15 +136,14 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
>  			if (he_cap->he_cap_elem.phy_cap_info[7] &
>  			    IEEE80211_HE_PHY_CAP7_STBC_RX_ABOVE_80MHZ)
>  				flags |= IWL_TLC_MNG_CFG_FLAGS_HE_STBC_160MHZ_MSK;
> -		} else if ((ht_cap &&
> -			    (ht_cap->cap & IEEE80211_HT_CAP_RX_STBC)) ||
> +		} else if ((ht_cap->cap & IEEE80211_HT_CAP_RX_STBC) ||
>  			   (vht_ena &&
>  			    (vht_cap->cap & IEEE80211_VHT_CAP_RXSTBC_MASK)))
>  			flags |= IWL_TLC_MNG_CFG_FLAGS_STBC_MSK;
>  	}
>  
>  	if (mvm->cfg->ht_params->ldpc &&
> -	    ((ht_cap && (ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING)) ||
> +	    ((ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING) ||
>  	     (vht_ena && (vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC))))
>  		flags |= IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
>  
> @@ -154,7 +153,7 @@ static u16 rs_fw_get_config_flags(struct iwl_mvm *mvm,
>  	     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD))
>  		flags &= ~IWL_TLC_MNG_CFG_FLAGS_LDPC_MSK;
>  
> -	if (he_cap && he_cap->has_he &&
> +	if (he_cap->has_he &&
>  	    (he_cap->he_cap_elem.phy_cap_info[3] &
>  	     IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK))
>  		flags |= IWL_TLC_MNG_CFG_FLAGS_HE_DCM_NSS_1_MSK;
> @@ -293,13 +292,13 @@ static void rs_fw_set_supp_rates(struct ieee80211_sta *sta,
>  	cmd->mode = IWL_TLC_MNG_MODE_NON_HT;
>  
>  	/* HT/VHT rates */
> -	if (he_cap && he_cap->has_he) {
> +	if (he_cap->has_he) {
>  		cmd->mode = IWL_TLC_MNG_MODE_HE;
>  		rs_fw_he_set_enabled_rates(sta, sband, cmd);
> -	} else if (vht_cap && vht_cap->vht_supported) {
> +	} else if (vht_cap->vht_supported) {
>  		cmd->mode = IWL_TLC_MNG_MODE_VHT;
>  		rs_fw_vht_set_enabled_rates(sta, vht_cap, cmd);
> -	} else if (ht_cap && ht_cap->ht_supported) {
> +	} else if (ht_cap->ht_supported) {
>  		cmd->mode = IWL_TLC_MNG_MODE_HT;
>  		cmd->ht_rates[0][0] = cpu_to_le16(ht_cap->mcs.rx_mask[0]);
>  		cmd->ht_rates[1][0] = cpu_to_le16(ht_cap->mcs.rx_mask[1]);
> @@ -381,7 +380,7 @@ static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
>  	const struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
>  	const struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
>  
> -	if (vht_cap && vht_cap->vht_supported) {
> +	if (vht_cap->vht_supported) {
>  		switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
>  		case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
>  			return IEEE80211_MAX_MPDU_LEN_VHT_11454;
> @@ -391,7 +390,7 @@ static u16 rs_fw_get_max_amsdu_len(struct ieee80211_sta *sta)
>  			return IEEE80211_MAX_MPDU_LEN_VHT_3895;
>  	}
>  
> -	} else if (ht_cap && ht_cap->ht_supported) {
> +	} else if (ht_cap->ht_supported) {
>  		if (ht_cap->cap & IEEE80211_HT_CAP_MAX_AMSDU)
>  			/*
>  			 * agg is offloaded so we need to assume that agg

Thanks! Applied to our internal tree and it will reach the mainline
following our normal upstreaming process.

--
Cheers,
Luca.

