Return-Path: <linux-wireless+bounces-22086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D628A9D415
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFDDE9E47F7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EFD224B0F;
	Fri, 25 Apr 2025 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="oxub/gKq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B62236F4
	for <linux-wireless@vger.kernel.org>; Fri, 25 Apr 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745616009; cv=none; b=uKiR2Tg5O57nKTIk8rHq0vCuQsoM+AaZL69oORke9LTRXZ0UpDI8TO3roTWEB2sGte75TneIgf4QO3NVOpPvYGmWefZNR38hd8qN53/Fn5h+bQN7XuAHVisOqvwwBSkTTxyNfJELQNxwbzIfGZfjWA8WNGRn5YH8wUd9hpjw5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745616009; c=relaxed/simple;
	bh=5PGQf5CYKhZIeygAkVsRvmYn/oKBPV/lzLk/AA67Ql8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJDd7Ov/YidNi5NX+dMpvBpQOudefY1ON8aV1n5AkmJ1O85eo/B4ouA007QuiQThgfKoKOTovnzGqVwDJeiFiHv5KGPkFT0Pa9zadsU8wxlhw7MT1uyLs4ps8REr/9CVAirlTAMjtVkTOru3ioDrkqzgQ+ZQ4c3vNJX+HQBPzgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=oxub/gKq; arc=none smtp.client-ip=44.202.169.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id 8OnIuSUhnXshw8QSluckmO; Fri, 25 Apr 2025 21:19:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 8QSjuSbjakmGT8QSkuAvQW; Fri, 25 Apr 2025 21:19:58 +0000
X-Authority-Analysis: v=2.4 cv=eYM7faEH c=1 sm=1 tr=0 ts=680bfc7e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=efVMuJ2jJG67FGuSm7J3ww==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=Q5GphUb1KYWObyZPT8MA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FWBkTosPAfafQbTlH5RFqaJwuvOFaIPLrV8UbOnE3VY=; b=oxub/gKq6JOKxxZh0/pWp1L8ie
	1IN006+2qC74Q/MdHmPz6/9tjVJIGvzVNiD+A6x8ux4Bj9bgWhVrN9MlLiZiv5Y88oh8NiCrCpo9y
	STXuTWu6LOsZNJ8qFeTrZizaLrcSYWV5wjdEEuuTl0qUY8+nKaFumfeQaetRiAja+VnuUDU7IHizH
	LiMkQ4DRTfZRh8aqNkYTawDvvQg8YOPFJ+8AdqKR+xoodY3VSJqBBZDM6FJgc/NJS1k2NtqjALtFS
	Wd08HlMvMgI+/wG+LnB/mxqYVUjV7iXu5nPR/tNoxPE/nxe6IuzjR5P4dpPFJALESSkEWuXCdqLy5
	N9NxJumA==;
Received: from [177.238.17.151] (port=9122 helo=[192.168.0.102])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1u8QSi-00000003XlN-0Cmt;
	Fri, 25 Apr 2025 16:19:57 -0500
Message-ID: <ce8dc422-4567-42c8-80a4-515085d40a66@embeddedor.com>
Date: Fri, 25 Apr 2025 15:19:45 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: iwlwifi: mvm: d3: Avoid
 -Wflex-array-member-not-at-end warnings
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z_FxXjiMvG5u73fi@kspp>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z_FxXjiMvG5u73fi@kspp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 177.238.17.151
X-Source-L: No
X-Exim-ID: 1u8QSi-00000003XlN-0Cmt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.102]) [177.238.17.151]:9122
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLtDk/5KPVcteS1in4Twv+T9zP7fWCOWidTzPxRb0zSDm/7UQ5XIMz0dfjZJwSx3CQmtkVErk4bAW4vjbqsntMg+jwdvQcVcmUKdz1TWuxk9Zw1pKixX
 j5qXu9PD5x7BJoboJf+2b76Wb0qlRJI9hIrLrhRe2fEWZWmx1t9uG+EkfrbTicGUqlCpE9WbvneDOWB/j8XiOst4VSCio/e71CQE1vUWrYdO6czq4w/a7ls1

Hi all,

Friendly ping: who can take this, please? :)

Thanks!
-Gustavo

On 05/04/25 12:07, Gustavo A. R. Silva wrote:
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
>   drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 129 +++++++++-----------
>   1 file changed, 61 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> index 3e8b7168af01..3e95799208fc 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
> @@ -120,19 +120,17 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
>   	switch (key->cipher) {
>   	case WLAN_CIPHER_SUITE_WEP40:
>   	case WLAN_CIPHER_SUITE_WEP104: { /* hack it for now */
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
> +		/* firmware sets STA_KEY_FLG_WEP_13BYTES */
> +		wkc->decryption_type = STA_KEY_FLG_WEP;
> +		wep_key->key_index = key->keyidx;
> +		wep_key->key_size = key->keylen;
>   
>   		/*
>   		 * This will fail -- the key functions don't set support
> @@ -142,18 +140,19 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
>   		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
>   			break;
>   
> -		memcpy(&wkc.wep_key.key[3], key->key, key->keylen);
> +		memcpy(&wep_key->key[3], key->key, key->keylen);
>   		if (key->keyidx == mvmvif->tx_key_idx) {
>   			/* TX key must be at offset 0 */
> -			wkc.wep_key.key_offset = 0;
> +			wep_key->key_offset = 0;
>   		} else {
>   			/* others start at 1 */
>   			data->wep_key_idx++;
> -			wkc.wep_key.key_offset = data->wep_key_idx;
> +			wep_key->key_offset = data->wep_key_idx;
>   		}
>   
>   		mutex_lock(&mvm->mutex);
> -		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, sizeof(wkc), &wkc);
> +		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0,
> +					   __struct_size(wkc), wkc);
>   		data->error = ret != 0;
>   
>   		mvm->ptk_ivlen = key->iv_len;
> @@ -2063,10 +2062,8 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>   		struct iwl_wowlan_mlo_gtk *mlo_key = &status->mlo_keys[i];
>   		struct ieee80211_key_conf *key, *old_key;
>   		struct ieee80211_key_seq seq;
> -		struct {
> -			struct ieee80211_key_conf conf;
> -			u8 key[32];
> -		} conf = {};
> +		DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
> +				WOWLAN_KEY_MAX_SIZE);
>   		u16 flags = le16_to_cpu(mlo_key->flags);
>   		int j, link_id, key_id, key_type;
>   
> @@ -2083,40 +2080,40 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>   			    key_type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES))
>   			continue;
>   
> -		conf.conf.cipher = old_keys->cipher[link_id][key_type];
> +		conf->cipher = old_keys->cipher[link_id][key_type];
>   		/* WARN_ON? */
> -		if (!conf.conf.cipher)
> +		if (!conf->cipher)
>   			continue;
>   
> -		conf.conf.keylen = 0;
> -		switch (conf.conf.cipher) {
> +		conf->keylen = 0;
> +		switch (conf->cipher) {
>   		case WLAN_CIPHER_SUITE_CCMP:
>   		case WLAN_CIPHER_SUITE_GCMP:
> -			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
> +			conf->keylen = WLAN_KEY_LEN_CCMP;
>   			break;
>   		case WLAN_CIPHER_SUITE_GCMP_256:
> -			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
> +			conf->keylen = WLAN_KEY_LEN_GCMP_256;
>   			break;
>   		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> -			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
> +			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
>   			break;
>   		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> -			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
> +			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
>   			break;
>   		case WLAN_CIPHER_SUITE_AES_CMAC:
> -			conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
> +			conf->keylen = WLAN_KEY_LEN_AES_CMAC;
>   			break;
>   		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> -			conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
> +			conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
>   			break;
>   		}
>   
> -		if (WARN_ON(!conf.conf.keylen ||
> -			    conf.conf.keylen > sizeof(conf.key)))
> +		if (WARN_ON(!conf->keylen ||
> +			    conf->keylen > WOWLAN_KEY_MAX_SIZE))
>   			continue;
>   
> -		memcpy(conf.conf.key, mlo_key->key, conf.conf.keylen);
> -		conf.conf.keyidx = key_id;
> +		memcpy(conf->key, mlo_key->key, conf->keylen);
> +		conf->keyidx = key_id;
>   
>   		old_key = old_keys->key[link_id][key_id];
>   		if (old_key) {
> @@ -2128,7 +2125,7 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
>   
>   		IWL_DEBUG_WOWLAN(mvm, "Add MLO key id %d, link id %d\n",
>   				 key_id, link_id);
> -		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
>   		if (WARN_ON(IS_ERR(key))) {
>   			ret = false;
>   			goto out;
> @@ -2158,30 +2155,28 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
>   {
>   	int i, j;
>   	struct ieee80211_key_conf *key;
> -	struct {
> -		struct ieee80211_key_conf conf;
> -		u8 key[32];
> -	} conf = {
> -		.conf.cipher = gtk_cipher,
> -	};
> +	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
> +			WOWLAN_KEY_MAX_SIZE);
>   	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
>   
> +	conf->cipher = gtk_cipher;
> +
>   	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
> -	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
> -	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
> -	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
> -	BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk[0].key));
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_CCMP);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_GCMP_256);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < WLAN_KEY_LEN_TKIP);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(status->gtk[0].key));
>   
>   	switch (gtk_cipher) {
>   	case WLAN_CIPHER_SUITE_CCMP:
>   	case WLAN_CIPHER_SUITE_GCMP:
> -		conf.conf.keylen = WLAN_KEY_LEN_CCMP;
> +		conf->keylen = WLAN_KEY_LEN_CCMP;
>   		break;
>   	case WLAN_CIPHER_SUITE_GCMP_256:
> -		conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
> +		conf->keylen = WLAN_KEY_LEN_GCMP_256;
>   		break;
>   	case WLAN_CIPHER_SUITE_TKIP:
> -		conf.conf.keylen = WLAN_KEY_LEN_TKIP;
> +		conf->keylen = WLAN_KEY_LEN_TKIP;
>   		break;
>   	default:
>   		WARN_ON(1);
> @@ -2191,14 +2186,14 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
>   		if (!status->gtk[i].len)
>   			continue;
>   
> -		conf.conf.keyidx = status->gtk[i].id;
> +		conf->keyidx = status->gtk[i].id;
>   		IWL_DEBUG_WOWLAN(mvm,
>   				 "Received from FW GTK cipher %d, key index %d\n",
> -				 conf.conf.cipher, conf.conf.keyidx);
> -		memcpy(conf.conf.key, status->gtk[i].key,
> +				 conf->cipher, conf->keyidx);
> +		memcpy(conf->key, status->gtk[i].key,
>   		       sizeof(status->gtk[i].key));
>   
> -		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
>   		if (IS_ERR(key))
>   			return false;
>   
> @@ -2220,42 +2215,40 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
>   				struct ieee80211_vif *vif, u32 cipher,
>   				struct iwl_multicast_key_data *key_data)
>   {
> +	DEFINE_RAW_FLEX(struct ieee80211_key_conf, conf, key,
> +			WOWLAN_KEY_MAX_SIZE);
>   	struct ieee80211_key_conf *key_config;
> -	struct {
> -		struct ieee80211_key_conf conf;
> -		u8 key[WOWLAN_KEY_MAX_SIZE];
> -	} conf = {
> -		.conf.cipher = cipher,
> -		.conf.keyidx = key_data->id,
> -	};
>   	struct ieee80211_key_seq seq;
>   	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
>   
> +	conf->cipher = cipher;
> +	conf->keyidx = key_data->id;
> +
>   	if (!key_data->len)
>   		return true;
>   
> -	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf.conf.cipher);
> +	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf->cipher);
>   
>   	switch (cipher) {
>   	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
> -		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
> +		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
>   		break;
>   	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
> -		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
> +		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
>   		break;
>   	case WLAN_CIPHER_SUITE_AES_CMAC:
> -		conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
> +		conf->keylen = WLAN_KEY_LEN_AES_CMAC;
>   		break;
>   	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
> -		conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
> +		conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
>   		break;
>   	default:
>   		WARN_ON(1);
>   	}
> -	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
> -	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
> +	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(key_data->key));
> +	memcpy(conf->key, key_data->key, conf->keylen);
>   
> -	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
> +	key_config = ieee80211_gtk_rekey_add(vif, conf, link_id);
>   	if (IS_ERR(key_config))
>   		return false;
>   	ieee80211_set_key_rx_seq(key_config, 0, &seq);


