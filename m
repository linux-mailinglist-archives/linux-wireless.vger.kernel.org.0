Return-Path: <linux-wireless+bounces-11232-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D77694D71B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F851283453
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F615FA73;
	Fri,  9 Aug 2024 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U25OXcX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C88182B3;
	Fri,  9 Aug 2024 19:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231033; cv=none; b=HN3LIOW1jDPipxwyD8EwAiF0hNhlFgYK/4CxsWkYExDYIdjaM5R6jCAAtAmKdymfHIDc0rmJ3fJxiQ6AHkKZFlvYBJHw+G/otP8tQbi8Q4tRvJwTRvjrO9bdpUnHFfnokLHxcNCw38BA36+ONESgkGfg29GM1UjgZuh7ngWt4bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231033; c=relaxed/simple;
	bh=XmL5ncs3p6X8rgr9i2cov2GYQnkuex67uQt9cHDKhfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JA48dSeSOZAVoH5WjJToa5L8mrWqI2zPyTd97Xvo3RNraDa83zVGfHY4yQsB4QUg/Shu84meBbLWg/+VtAlhY7dfV7maGR3VReVwrl3eSNDhWu9vIv3GjMWYShB1yRrQ3G57S58nikptJX8hK4xgwd8lUrXdV+OaBawjeP3Kz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U25OXcX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952A4C32782;
	Fri,  9 Aug 2024 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723231032;
	bh=XmL5ncs3p6X8rgr9i2cov2GYQnkuex67uQt9cHDKhfs=;
	h=Date:From:To:Cc:Subject:From;
	b=U25OXcX1QIHYgFDdyQWE//lrB98SXdM6pP2FUzHGA9r/Yey7/IMmScfO75IppX2rz
	 /lcsYFavSgW+AWhLXEMmZ4tehDCIofU5PwR327R2VCFUFNszALI9UFhCaNG9oGfhvZ
	 mZcJzOFsQqoBqQ25BD2V1FVjrCqCr6GZwfXIf95bWdfkRPb7ykUi8U7BJgCz/8jTg1
	 UA9u0lzwdTQLCdKSLM2XGG7jBTecf9pK73lRYl2h/X29ghIxHBAh73l2e04GJJnAlh
	 0R97nnNCgtK1hollwazKSpHoAqWclhx/L/OmUUnXB0s9UxigzT3h9X9sKAQamj+wRP
	 1e5UIROKl6z/g==
Date: Fri, 9 Aug 2024 13:17:09 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] wifi: iwlwifi: mvm: Use __counted_by() and avoid
 -Wfamnae warnings
Message-ID: <ZrZrNfUZtUIqvbUI@cute>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, use the `DEFINE_FLEX()` helper for multiple on-stack definitions
of flexible structures where the size of their flexible-array members
are known at compile-time, and refactor the rest of the code,
accordingly.

In order to allow for the use of `DEFINE_FLEX()`, a couple of
structures were annotated with the `__counted_by()` attribute.

With these changes, fix the following warnings:
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:124:52: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2053:51: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2148:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
drivers/net/wireless/intel/iwlwifi/mvm/d3.c:2211:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 126 ++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   2 +-
 include/net/mac80211.h                        |   2 +-
 4 files changed, 61 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
index d7f8a276b683..fe6bd34fefa3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/sta.h
@@ -479,7 +479,7 @@ struct iwl_mvm_wep_key_cmd {
 	u8 decryption_type;
 	u8 flags;
 	u8 reserved;
-	struct iwl_mvm_wep_key wep_key[];
+	struct iwl_mvm_wep_key wep_key[] __counted_by(num_keys);
 } __packed; /* SEC_CURR_WEP_KEY_CMD_API_S_VER_2 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index b4d650583ac2..b19579dd8de3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -120,19 +120,15 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 	case WLAN_CIPHER_SUITE_WEP104: { /* hack it for now */
-		struct {
-			struct iwl_mvm_wep_key_cmd wep_key_cmd;
-			struct iwl_mvm_wep_key wep_key;
-		} __packed wkc = {
-			.wep_key_cmd.mac_id_n_color =
-				cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
-								mvmvif->color)),
-			.wep_key_cmd.num_keys = 1,
-			/* firmware sets STA_KEY_FLG_WEP_13BYTES */
-			.wep_key_cmd.decryption_type = STA_KEY_FLG_WEP,
-			.wep_key.key_index = key->keyidx,
-			.wep_key.key_size = key->keylen,
-		};
+		DEFINE_FLEX(struct iwl_mvm_wep_key_cmd, wkc, wep_key, num_keys, 1);
+
+		wkc->mac_id_n_color =
+			cpu_to_le32(FW_CMD_ID_AND_COLOR(mvmvif->id,
+							mvmvif->color));
+		/* firmware sets STA_KEY_FLG_WEP_13BYTES */
+		wkc->decryption_type = STA_KEY_FLG_WEP;
+		wkc->wep_key[0].key_index = key->keyidx;
+		wkc->wep_key[0].key_size = key->keylen;
 
 		/*
 		 * This will fail -- the key functions don't set support
@@ -142,18 +138,18 @@ static void iwl_mvm_wowlan_program_keys(struct ieee80211_hw *hw,
 		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
 			break;
 
-		memcpy(&wkc.wep_key.key[3], key->key, key->keylen);
+		memcpy(&wkc->wep_key[0].key[3], key->key, key->keylen);
 		if (key->keyidx == mvmvif->tx_key_idx) {
 			/* TX key must be at offset 0 */
-			wkc.wep_key.key_offset = 0;
+			wkc->wep_key[0].key_offset = 0;
 		} else {
 			/* others start at 1 */
 			data->wep_key_idx++;
-			wkc.wep_key.key_offset = data->wep_key_idx;
+			wkc->wep_key[0].key_offset = data->wep_key_idx;
 		}
 
 		mutex_lock(&mvm->mutex);
-		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, sizeof(wkc), &wkc);
+		ret = iwl_mvm_send_cmd_pdu(mvm, WEP_KEY, 0, __struct_size(wkc), wkc);
 		data->error = ret != 0;
 
 		mvm->ptk_ivlen = key->iv_len;
@@ -2049,10 +2045,8 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
 		struct iwl_wowlan_mlo_gtk *mlo_key = &status->mlo_keys[i];
 		struct ieee80211_key_conf *key, *old_key;
 		struct ieee80211_key_seq seq;
-		struct {
-			struct ieee80211_key_conf conf;
-			u8 key[32];
-		} conf = {};
+		DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
+			    WOWLAN_KEY_MAX_SIZE);
 		u16 flags = le16_to_cpu(mlo_key->flags);
 		int j, link_id, key_id, key_type;
 
@@ -2069,40 +2063,40 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
 			    key_type >= WOWLAN_MLO_GTK_KEY_NUM_TYPES))
 			continue;
 
-		conf.conf.cipher = old_keys->cipher[link_id][key_type];
+		conf->cipher = old_keys->cipher[link_id][key_type];
 		/* WARN_ON? */
-		if (!conf.conf.cipher)
+		if (!conf->cipher)
 			continue;
 
-		conf.conf.keylen = 0;
-		switch (conf.conf.cipher) {
+		conf->keylen = 0;
+		switch (conf->cipher) {
 		case WLAN_CIPHER_SUITE_CCMP:
 		case WLAN_CIPHER_SUITE_GCMP:
-			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
+			conf->keylen = WLAN_KEY_LEN_CCMP;
 			break;
 		case WLAN_CIPHER_SUITE_GCMP_256:
-			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
+			conf->keylen = WLAN_KEY_LEN_GCMP_256;
 			break;
 		case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
+			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
 			break;
 		case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-			conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
+			conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
 			break;
 		case WLAN_CIPHER_SUITE_AES_CMAC:
-			conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
+			conf->keylen = WLAN_KEY_LEN_AES_CMAC;
 			break;
 		case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-			conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
+			conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
 			break;
 		}
 
-		if (WARN_ON(!conf.conf.keylen ||
-			    conf.conf.keylen > sizeof(conf.key)))
+		if (WARN_ON(!conf->keylen ||
+			    conf->keylen > WOWLAN_KEY_MAX_SIZE))
 			continue;
 
-		memcpy(conf.conf.key, mlo_key->key, conf.conf.keylen);
-		conf.conf.keyidx = key_id;
+		memcpy(conf->key, mlo_key->key, conf->keylen);
+		conf->keyidx = key_id;
 
 		old_key = old_keys->key[link_id][key_id];
 		if (old_key) {
@@ -2114,7 +2108,7 @@ static bool iwl_mvm_mlo_gtk_rekey(struct iwl_wowlan_status_data *status,
 
 		IWL_DEBUG_WOWLAN(mvm, "Add MLO key id %d, link id %d\n",
 				 key_id, link_id);
-		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
+		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
 		if (WARN_ON(IS_ERR(key))) {
 			ret = false;
 			goto out;
@@ -2144,30 +2138,28 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 {
 	int i, j;
 	struct ieee80211_key_conf *key;
-	struct {
-		struct ieee80211_key_conf conf;
-		u8 key[32];
-	} conf = {
-		.conf.cipher = gtk_cipher,
-	};
+	DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
+		    WOWLAN_KEY_MAX_SIZE);
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 
+	conf->cipher = gtk_cipher;
+
 	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
-	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
-	BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk[0].key));
+	BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_CCMP);
+	BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_GCMP_256);
+	BUILD_BUG_ON(conf->keylen < WLAN_KEY_LEN_TKIP);
+	BUILD_BUG_ON(conf->keylen < sizeof(status->gtk[0].key));
 
 	switch (gtk_cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
-		conf.conf.keylen = WLAN_KEY_LEN_CCMP;
+		conf->keylen = WLAN_KEY_LEN_CCMP;
 		break;
 	case WLAN_CIPHER_SUITE_GCMP_256:
-		conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
+		conf->keylen = WLAN_KEY_LEN_GCMP_256;
 		break;
 	case WLAN_CIPHER_SUITE_TKIP:
-		conf.conf.keylen = WLAN_KEY_LEN_TKIP;
+		conf->keylen = WLAN_KEY_LEN_TKIP;
 		break;
 	default:
 		WARN_ON(1);
@@ -2177,14 +2169,14 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 		if (!status->gtk[i].len)
 			continue;
 
-		conf.conf.keyidx = status->gtk[i].id;
+		conf->keyidx = status->gtk[i].id;
 		IWL_DEBUG_WOWLAN(mvm,
 				 "Received from FW GTK cipher %d, key index %d\n",
-				 conf.conf.cipher, conf.conf.keyidx);
-		memcpy(conf.conf.key, status->gtk[i].key,
+				 conf->cipher, conf->keyidx);
+		memcpy(conf->key, status->gtk[i].key,
 		       sizeof(status->gtk[i].key));
 
-		key = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
+		key = ieee80211_gtk_rekey_add(vif, conf, link_id);
 		if (IS_ERR(key))
 			return false;
 
@@ -2207,41 +2199,39 @@ iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
 				struct iwl_multicast_key_data *key_data)
 {
 	struct ieee80211_key_conf *key_config;
-	struct {
-		struct ieee80211_key_conf conf;
-		u8 key[WOWLAN_KEY_MAX_SIZE];
-	} conf = {
-		.conf.cipher = cipher,
-		.conf.keyidx = key_data->id,
-	};
+	DEFINE_FLEX(struct ieee80211_key_conf, conf, key, keylen,
+		    WOWLAN_KEY_MAX_SIZE);
 	struct ieee80211_key_seq seq;
 	int link_id = vif->active_links ? __ffs(vif->active_links) : -1;
 
+	conf->cipher = cipher;
+	conf->keyidx = key_data->id;
+
 	if (!key_data->len)
 		return true;
 
-	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf.conf.cipher);
+	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf->cipher);
 
 	switch (cipher) {
 	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
+		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_128;
 		break;
 	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
+		conf->keylen = WLAN_KEY_LEN_BIP_GMAC_256;
 		break;
 	case WLAN_CIPHER_SUITE_AES_CMAC:
-		conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
+		conf->keylen = WLAN_KEY_LEN_AES_CMAC;
 		break;
 	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-		conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
+		conf->keylen = WLAN_KEY_LEN_BIP_CMAC_256;
 		break;
 	default:
 		WARN_ON(1);
 	}
-	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
-	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
+	BUILD_BUG_ON(WOWLAN_KEY_MAX_SIZE < sizeof(key_data->key));
+	memcpy(conf->key, key_data->key, conf->keylen);
 
-	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf, link_id);
+	key_config = ieee80211_gtk_rekey_add(vif, conf, link_id);
 	if (IS_ERR(key_config))
 		return false;
 	ieee80211_set_key_rx_seq(key_config, 0, &seq);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 15e64d94d6ea..7e550d880584 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4350,8 +4350,8 @@ int iwl_mvm_add_pasn_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		goto out;
 
 	keyconf->cipher = cipher;
-	memcpy(keyconf->key, key, key_len);
 	keyconf->keylen = key_len;
+	memcpy(keyconf->key, key, keyconf->key_len);
 	keyconf->flags = IEEE80211_KEY_FLAG_PAIRWISE;
 
 	if (mld) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..d3f6056daf8a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2222,7 +2222,7 @@ struct ieee80211_key_conf {
 	u16 flags;
 	s8 link_id;
 	u8 keylen;
-	u8 key[];
+	u8 key[] __counted_by(keylen);
 };
 
 #define IEEE80211_MAX_PN_LEN	16
-- 
2.34.1


