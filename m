Return-Path: <linux-wireless+bounces-21214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313DFA7EEFA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 22:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4FD2188872C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52772222D2;
	Mon,  7 Apr 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mE/zQBRl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0102188A0E;
	Mon,  7 Apr 2025 20:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744056913; cv=none; b=d8XpsRw1NJgoOHz1jRoUulqlFV9j4chcyl3SIxX7Yl2VxE/MY79WlYI9kjmKwf66uAsgQxFTGDCPGWlb/N4jdxcSK8dhkTzYARxwESo8c2NVQ2g7OoEGlMTAv47Cj90YydHVWTKLH10z/TEmQaOeyADkb0fPSsW6tvl8smLPVh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744056913; c=relaxed/simple;
	bh=djtTgi5s+tmZT4o6LD+IJ6pJNRyecHdv2wWEjt/w0VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB4Dj54OZkOoHs30aW+5VuKdsU6KoaOAOkUAwqjcJUX0+qE6E5JBxPJA2mlrsfk7OaRdxpEx7GyiKaONVyH6wK8d4vPmzmo7yWuk1dAD2Kek42labjRRryR1WmBNQYsVtpn9VX2EgVYYbeFyEZw2ZwkMeJF1m0is8i7o+Tw/bgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mE/zQBRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14040C4CEDD;
	Mon,  7 Apr 2025 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744056913;
	bh=djtTgi5s+tmZT4o6LD+IJ6pJNRyecHdv2wWEjt/w0VM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mE/zQBRlDe2033IjNnnYX8ikScEF9qNmludnavuNTVTaxKw6fH7X2GHoj9q9MWnqv
	 xWgu1DvkbSfotzst9N6iOTY0WgY3rMViROJx6HqCoGJCXXwVQKzY19GbTXEbGYaMbZ
	 gj4H4UnkF064a0/QyEd/4iXKYj7/aQxNqzikxVy5OInHNEbx1oa+LC1ySVvhMlw2jj
	 YZWrJhIvI8BR4hdlZ1YlffWqy0KzI5i96LW3+3S29+k20wXKl7VzaNyy/HGl0gx7xL
	 6m7UJ2KfqrluR+h0GzfOMjXqfZUleC00fkrk/hRNMpYVpnMau5Mjp55pvcsqsH0oQ3
	 xjlgOt6DCSMHQ==
Date: Mon, 7 Apr 2025 13:15:10 -0700
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] wifi: iwlwifi: mvm: d3: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <202504071310.17CBF96EEA@keescook>
References: <Z_FxXjiMvG5u73fi@kspp>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_FxXjiMvG5u73fi@kspp>

On Sat, Apr 05, 2025 at 12:07:26PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warnings:
> 
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:124:52: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2067:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2162:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2225:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 129 +++++++++-----------
>  1 file changed, 61 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 3e8b7168af01..3e95799208fc 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -120,19 +120,17 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
>  	switch (key->cipher) {
>  	case WLAN_CIPHER_SUITE_WEP40:
>  	case WLAN_CIPHER_SUITE_WEP104: { /* hack it for now */
> -		struct {
> -			struct iwl_mvm_wep_key_cmd wep_key_cmd;
> -			struct iwl_mvm_wep_key wep_key;
> -		} __packed wkc = {
> -			.wep_key_cmd.mac_id_n_color =
> -				cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
> -								mvmvif->color)),
> -			.wep_key_cmd.num_keys = 1,
> -			/* firmware sets STA_KEY_FLG_WEP_13BYTES */
> -			.wep_key_cmd.decryption_type = STA_KEY_FLG_WEP,
> -			.wep_key.key_index = key->keyidx,
> -			.wep_key.key_size = key->keylen,
> -		};
> +		DEFINE_RAW_FLEX(struct iwl_mvm_wep_key_cmd, wkc, wep_key, 1);
> +		struct iwl_mvm_wep_key *wep_key = wkc->wep_key;
> +
> +		wkc->mac_id_n_color =
> +			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
> +							mvmvif->color));
> +		wkc->num_keys = 1;

Looks like struct iwl_mvm_wep_key_cmd::num_keys is the counted_by for
struct iwl_mvm_wep_key_cmd::wep_key?

> +		/* firmware sets STA_KEY_FLG_WEP_13BYTES */
> +		wkc->decryption_type = STA_KEY_FLG_WEP;
> +		wep_key->key_index = key->keyidx;
> +		wep_key->key_size = key->keylen;
>  
>  		/*
>  		 * This will fail -- the key functions don't set support
> @@ -142,18 +140,19 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
>  		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
>  			break;
>  
> -		memcpy(&wkc.wep_key.key[3], key->key, key->keylen);
> +		memcpy(&wep_key->key[3], key->key, key->keylen);
>  		if (key->keyidx == mvmvif->tx_key_idx) {
>  			/* TX key must be at offset 0 */
> -			wkc.wep_key.key_offset = 0;
> +			wep_key->key_offset = 0;
>  		} else {
>  			/* others start at 1 */
>  			data->wep_key_idx++;
> -			wkc.wep_key.key_offset = data->wep_key_idx;
> +			wep_key->key_offset = data->wep_key_idx;
>  		}
>  
>  		mutex_lock(&mvm->mutex);
> -		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, sizeof(wkc), &wkc);
> +		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0,
> +					   __struct_size(wkc), wkc);
>  		data->error = ret != 0;
>  
>  		mvm->ptk_ivlen = key->iv_len;
> @@ -2063,10 +2062,8 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>  		struct iwl_wowlan_mlo_gtk *mlo_key = &status->mlo_keys[i];
>  		struct ieee80211_key_conf *key, *old_key;
>  		struct ieee80211_key_seq seq;
> -		struct {
> -			struct ieee80211_key_conf conf;
> -			u8 key[32];
> -		} conf = {};
> +		DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
> +				WOWLAN_KEY_MAX_SIZE);

Okay, yes, WOWLAN_KEY_MAX_SIZE == 32.

>  		u16 flags = le16_to_cpu(mlo_key->flags);
>  		int j, link_id, key_id, key_type;
>  
> @@ -2083,40 +2080,40 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>  			    key_type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES))
>  			continue;
>  
> -		conf.conf.cipher = old_keys->cipher[link_id][key_type];
> +		conf->cipher = old_keys->cipher[link_id][key_type];
>  		/* WARN_ON? */
> -		if (!conf.conf.cipher)
> +		if (!conf->cipher)
>  			continue;
>  
> -		conf.conf.keylen = 0;
> -		switch (conf.conf.cipher) {
> +		conf->keylen = 0;
> +		switch (conf->cipher) {
>  		case WLAN_CIPHER_SUITE_CCMP:
>  		case WLAN_CIPHER_SUITE_GCMP:
> -			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
> +			conf->keylen = WLAN_KEY_LEN_CCMP;
>  			break;
>  		case WLAN_CIPHER_SUITE_GCMP_256:
> -			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
> +			conf->keylen = WLAN_KEY_LEN_GCMP_256;
>  			break;
>  		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> -			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
> +			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
>  			break;
>  		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> -			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
> +			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
>  			break;
>  		case WLAN_CIPHER_SUITE_AES_CMAC:
> -			conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
> +			conf->keylen = WLAN_KEY_LEN_AES_CMAC;
>  			break;
>  		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> -			conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
> +			conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
>  			break;
>  		}
>  
> -		if (WARN_ON(!conf.conf.keylen ||
> -			    conf.conf.keylen > sizeof(conf.key)))
> +		if (WARN_ON(!conf->keylen ||
> +			    conf->keylen > WOWLAN_KEY_MAX_SIZE))
>  			continue;
>  
> -		memcpy(conf.conf.key, mlo_key->key, conf.conf.keylen);
> -		conf.conf.keyidx = key_id;
> +		memcpy(conf->key, mlo_key->key, conf->keylen);
> +		conf->keyidx = key_id;
>  
>  		old_key = old_keys->key[link_id][key_id];
>  		if (old_key) {
> @@ -2128,7 +2125,7 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>  
>  		IWL_DEBUG_WOWLAN(mvm, "Add MLO key id %d, link id %d\n",
>  				 key_id, link_id);
> -		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
>  		if (WARN_ON(IS_ERR(key))) {
>  			ret = false;
>  			goto out;
> @@ -2158,30 +2155,28 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
>  {
>  	int i, j;
>  	struct ieee80211_key_conf *key;
> -	struct {
> -		struct ieee80211_key_conf conf;
> -		u8 key[32];
> -	} conf = {
> -		.conf.cipher = gtk_cipher,
> -	};
> +	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
> +			WOWLAN_KEY_MAX_SIZE);
>  	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
>  
> +	conf->cipher = gtk_cipher;
> +
>  	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
> -	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
> -	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
> -	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
> -	BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk[0].key));
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_CCMP);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_GCMP_256);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_TKIP);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(status->gtk[0].key));
>  
>  	switch (gtk_cipher) {
>  	case WLAN_CIPHER_SUITE_CCMP:
>  	case WLAN_CIPHER_SUITE_GCMP:
> -		conf.conf.keylen = WLAN_KEY_LEN_CCMP;
> +		conf->keylen = WLAN_KEY_LEN_CCMP;
>  		break;
>  	case WLAN_CIPHER_SUITE_GCMP_256:
> -		conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
> +		conf->keylen = WLAN_KEY_LEN_GCMP_256;
>  		break;
>  	case WLAN_CIPHER_SUITE_TKIP:
> -		conf.conf.keylen = WLAN_KEY_LEN_TKIP;
> +		conf->keylen = WLAN_KEY_LEN_TKIP;
>  		break;
>  	default:
>  		WARN_ON(1);
> @@ -2191,14 +2186,14 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
>  		if (!status->gtk[i].len)
>  			continue;
>  
> -		conf.conf.keyidx = status->gtk[i].id;
> +		conf->keyidx = status->gtk[i].id;
>  		IWL_DEBUG_WOWLAN(mvm,
>  				 "Received from FW GTK cipher %d, key index %d\n",
> -				 conf.conf.cipher, conf.conf.keyidx);
> -		memcpy(conf.conf.key, status->gtk[i].key,
> +				 conf->cipher, conf->keyidx);
> +		memcpy(conf->key, status->gtk[i].key,
>  		       sizeof(status->gtk[i].key));
>  
> -		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
>  		if (IS_ERR(key))
>  			return false;
>  
> @@ -2220,42 +2215,40 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
>  				struct ieee80211_vif *vif, u32 cipher,
>  				struct iwl_multicast_key_data *key_data)
>  {
> +	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
> +			WOWLAN_KEY_MAX_SIZE);
>  	struct ieee80211_key_conf *key_config;
> -	struct {
> -		struct ieee80211_key_conf conf;
> -		u8 key[WOWLAN_KEY_MAX_SIZE];
> -	} conf = {
> -		.conf.cipher = cipher,
> -		.conf.keyidx = key_data->id,
> -	};
>  	struct ieee80211_key_seq seq;
>  	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
>  
> +	conf->cipher = cipher;
> +	conf->keyidx = key_data->id;
> +
>  	if (!key_data->len)
>  		return true;
>  
> -	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf.conf.cipher);
> +	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf->cipher);
>  
>  	switch (cipher) {
>  	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> -		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
> +		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
>  		break;
>  	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> -		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
> +		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
>  		break;
>  	case WLAN_CIPHER_SUITE_AES_CMAC:
> -		conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
> +		conf->keylen = WLAN_KEY_LEN_AES_CMAC;
>  		break;
>  	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> -		conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
> +		conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
>  		break;
>  	default:
>  		WARN_ON(1);
>  	}
> -	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
> -	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(key_data->key));
> +	memcpy(conf->key, key_data->key, conf->keylen);
>  
> -	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +	key_config = ieee80211_gtk_rekey_add(vif, conf, link_id);
>  	if (IS_ERR(key_config))
>  		return false;
>  	ieee80211_set_key_rx_seq(key_config, 0, &seq);

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

