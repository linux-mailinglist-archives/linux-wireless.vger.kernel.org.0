Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C933352DF4A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 23:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbiESV1e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 17:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiESV1b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 17:27:31 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB00A6E8D6
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 14:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=My4RAXA1cDZVnqQQkN9zKTPCq5pwPiJo03vhTpWR0yY=;
        t=1652995647; x=1654205247; b=uLmQBT3WBNZfQb9QXp7BvWEvH/SGhzRfmSI1ibLcoMyfa5N
        IE2sOzTBX++0gRB4fCNKafYQNQWKJGuFsj2elhpFkkHalzQ4KVXQg4oZmel+MvwSs+jSZtdOCtzgd
        O5yOl4OUiOsSnLZkmvLWG/x8DTLDQ0sZ+k9+uaEL5P3dnblSkANDU7xPpogdSWG7tKW/TgI2qVKA0
        BvFa3vymrCBDMxqWirlE9wmngAqXzDezIPuT+n/RdY25s6TXCagPplf+Rral9wOVPJvUV47mqT43d
        /V4EcOGMjGT+3FE/lcAJY5o6Ik4HpUNfp+51mLVDnoOxHxgHWQIy/PvxddGWB1gg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nrng5-00GZd0-1c;
        Thu, 19 May 2022 23:27:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 2/3] mac80211: remove cipher scheme support
Date:   Thu, 19 May 2022 23:27:21 +0200
Message-Id: <20220519232721.e46f24800e6e.I2a66a9e9e350746ec891e563788d31898041ebc5@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid>
References: <20220519232721.af7f735316fb.I77ae111a28f7c0e9fd1ebcee7f39dbec5c606770@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The only driver using this was iwlwifi, where we just removed
the support because it was never really used. Remove the code
from mac80211 as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h     |  35 ----------
 net/mac80211/cfg.c         |  26 +-------
 net/mac80211/ieee80211_i.h |  11 +--
 net/mac80211/iface.c       |   7 +-
 net/mac80211/key.c         |  22 +-----
 net/mac80211/key.h         |   7 +-
 net/mac80211/main.c        |  69 ++-----------------
 net/mac80211/mesh_hwmp.c   |   6 +-
 net/mac80211/mlme.c        |   6 +-
 net/mac80211/rx.c          |  49 ++++----------
 net/mac80211/sta_info.h    |   4 +-
 net/mac80211/tx.c          |  21 ++----
 net/mac80211/util.c        |  70 +------------------
 net/mac80211/wpa.c         | 133 +------------------------------------
 net/mac80211/wpa.h         |   5 +-
 15 files changed, 39 insertions(+), 432 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ebadb2103968..5c9e97eca739 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1958,36 +1958,6 @@ struct ieee80211_key_seq {
 	};
 };
 
-/**
- * struct ieee80211_cipher_scheme - cipher scheme
- *
- * This structure contains a cipher scheme information defining
- * the secure packet crypto handling.
- *
- * @cipher: a cipher suite selector
- * @iftype: a cipher iftype bit mask indicating an allowed cipher usage
- * @hdr_len: a length of a security header used the cipher
- * @pn_len: a length of a packet number in the security header
- * @pn_off: an offset of pn from the beginning of the security header
- * @key_idx_off: an offset of key index byte in the security header
- * @key_idx_mask: a bit mask of key_idx bits
- * @key_idx_shift: a bit shift needed to get key_idx
- *     key_idx value calculation:
- *      (sec_header_base[key_idx_off] & key_idx_mask) >> key_idx_shift
- * @mic_len: a mic length in bytes
- */
-struct ieee80211_cipher_scheme {
-	u32 cipher;
-	u16 iftype;
-	u8 hdr_len;
-	u8 pn_len;
-	u8 pn_off;
-	u8 key_idx_off;
-	u8 key_idx_mask;
-	u8 key_idx_shift;
-	u8 mic_len;
-};
-
 /**
  * enum set_key_cmd - key command
  *
@@ -2664,9 +2634,6 @@ enum ieee80211_hw_flags {
  *	deliver to a WMM STA during any Service Period triggered by the WMM STA.
  *	Use IEEE80211_WMM_IE_STA_QOSINFO_SP_* for correct values.
  *
- * @n_cipher_schemes: a size of an array of cipher schemes definitions.
- * @cipher_schemes: a pointer to an array of cipher scheme definitions
- *	supported by HW.
  * @max_nan_de_entries: maximum number of NAN DE functions supported by the
  *	device.
  *
@@ -2716,8 +2683,6 @@ struct ieee80211_hw {
 	netdev_features_t netdev_features;
 	u8 uapsd_queues;
 	u8 uapsd_max_sp_len;
-	u8 n_cipher_schemes;
-	const struct ieee80211_cipher_scheme *cipher_schemes;
 	u8 max_nan_de_entries;
 	u8 tx_sk_pacing_shift;
 	u8 weight_multiplier;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f7896f257e1b..f3b10cee9299 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -438,7 +438,6 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta = NULL;
-	const struct ieee80211_cipher_scheme *cs = NULL;
 	struct ieee80211_key *key;
 	int err;
 
@@ -456,23 +455,12 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		if (WARN_ON_ONCE(fips_enabled))
 			return -EINVAL;
 		break;
-	case WLAN_CIPHER_SUITE_CCMP:
-	case WLAN_CIPHER_SUITE_CCMP_256:
-	case WLAN_CIPHER_SUITE_AES_CMAC:
-	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
-	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
-	case WLAN_CIPHER_SUITE_GCMP:
-	case WLAN_CIPHER_SUITE_GCMP_256:
-		break;
 	default:
-		cs = ieee80211_cs_get(local, params->cipher, sdata->vif.type);
 		break;
 	}
 
 	key = ieee80211_key_alloc(params->cipher, key_idx, params->key_len,
-				  params->key, params->seq_len, params->seq,
-				  cs);
+				  params->key, params->seq_len, params->seq);
 	if (IS_ERR(key))
 		return PTR_ERR(key);
 
@@ -537,9 +525,6 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct net_device *dev,
 		break;
 	}
 
-	if (sta)
-		sta->cipher_scheme = cs;
-
 	err = ieee80211_key_link(key, sdata, sta);
 
  out_unlock:
@@ -1207,9 +1192,6 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 				params->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth =
 				params->crypto.control_port_no_preauth;
-	sdata->encrypt_headroom = ieee80211_cs_headroom(sdata->local,
-							&params->crypto,
-							sdata->vif.type);
 
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list) {
 		vlan->control_port_protocol =
@@ -1220,10 +1202,6 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 			params->crypto.control_port_over_nl80211;
 		vlan->control_port_no_preauth =
 			params->crypto.control_port_no_preauth;
-		vlan->encrypt_headroom =
-			ieee80211_cs_headroom(sdata->local,
-					      &params->crypto,
-					      vlan->vif.type);
 	}
 
 	sdata->vif.bss_conf.dtim_period = params->dtim_period;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 86ef0a46a68c..1cf331572de1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #ifndef IEEE80211_I_H
@@ -944,7 +944,6 @@ struct ieee80211_sub_if_data {
 	bool control_port_no_encrypt;
 	bool control_port_no_preauth;
 	bool control_port_over_nl80211;
-	int encrypt_headroom;
 
 	atomic_t num_tx_queued;
 	struct ieee80211_tx_queue_params tx_conf[IEEE80211_NUM_ACS];
@@ -2483,14 +2482,6 @@ void ieee80211_dfs_radar_detected_work(struct work_struct *work);
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings);
 
-bool ieee80211_cs_valid(const struct ieee80211_cipher_scheme *cs);
-bool ieee80211_cs_list_valid(const struct ieee80211_cipher_scheme *cs, int n);
-const struct ieee80211_cipher_scheme *
-ieee80211_cs_get(struct ieee80211_local *local, u32 cipher,
-		 enum nl80211_iftype iftype);
-int ieee80211_cs_headroom(struct ieee80211_local *local,
-			  struct cfg80211_crypto_settings *crypto,
-			  enum nl80211_iftype iftype);
 void ieee80211_recalc_dtim(struct ieee80211_local *local,
 			   struct ieee80211_sub_if_data *sdata);
 int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 41531478437c..fb8d102fca48 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -8,7 +8,7 @@
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (c) 2016        Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include <linux/slab.h>
 #include <linux/kernel.h>
@@ -1036,8 +1036,6 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		 wiphy_name(local->hw.wiphy));
 	sdata->wdev.iftype = NL80211_IFTYPE_MONITOR;
 
-	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
-
 	ieee80211_set_default_queues(sdata);
 
 	ret = drv_add_interface(local, sdata);
@@ -1644,7 +1642,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	sdata->control_port_no_encrypt = false;
 	sdata->control_port_over_nl80211 = false;
 	sdata->control_port_no_preauth = false;
-	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
 	sdata->vif.bss_conf.idle = true;
 	sdata->vif.bss_conf.txpower = INT_MIN; /* unset */
 
@@ -2116,8 +2113,6 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 	sdata->ap_power_level = IEEE80211_UNSET_POWER_LEVEL;
 	sdata->user_power_level = local->user_power_level;
 
-	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
-
 	/* setup type-dependent data */
 	ieee80211_setup_sdata(sdata, type);
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 0fcf8aebedc4..c3476de4b14d 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2008	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright 2018-2020  Intel Corporation
+ * Copyright 2018-2020, 2022  Intel Corporation
  */
 
 #include <linux/if_ether.h>
@@ -531,8 +531,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 struct ieee80211_key *
 ieee80211_key_alloc(u32 cipher, int idx, size_t key_len,
 		    const u8 *key_data,
-		    size_t seq_len, const u8 *seq,
-		    const struct ieee80211_cipher_scheme *cs)
+		    size_t seq_len, const u8 *seq)
 {
 	struct ieee80211_key *key;
 	int i, j, err;
@@ -675,21 +674,6 @@ ieee80211_key_alloc(u32 cipher, int idx, size_t key_len,
 			return ERR_PTR(err);
 		}
 		break;
-	default:
-		if (cs) {
-			if (seq_len && seq_len != cs->pn_len) {
-				kfree(key);
-				return ERR_PTR(-EINVAL);
-			}
-
-			key->conf.iv_len = cs->hdr_len;
-			key->conf.icv_len = cs->mic_len;
-			for (i = 0; i < IEEE80211_NUM_TIDS + 1; i++)
-				for (j = 0; j < seq_len; j++)
-					key->u.gen.rx_pn[i][j] =
-							seq[seq_len - j - 1];
-			key->flags |= KEY_FLAG_CIPHER_SCHEME;
-		}
 	}
 	memcpy(key->conf.key, key_data, key_len);
 	INIT_LIST_HEAD(&key->list);
@@ -1294,7 +1278,7 @@ ieee80211_gtk_rekey_add(struct ieee80211_vif *vif,
 
 	key = ieee80211_key_alloc(keyconf->cipher, keyconf->keyidx,
 				  keyconf->keylen, keyconf->key,
-				  0, NULL, NULL);
+				  0, NULL);
 	if (IS_ERR(key))
 		return ERR_CAST(key);
 
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index 1e326c89d721..b3fb41c0c77f 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -2,7 +2,7 @@
 /*
  * Copyright 2002-2004, Instant802 Networks, Inc.
  * Copyright 2005, Devicescape Software, Inc.
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2022 Intel Corporation
  */
 
 #ifndef IEEE80211_KEY_H
@@ -30,12 +30,10 @@ struct sta_info;
  * @KEY_FLAG_UPLOADED_TO_HARDWARE: Indicates that this key is present
  *	in the hardware for TX crypto hardware acceleration.
  * @KEY_FLAG_TAINTED: Key is tainted and packets should be dropped.
- * @KEY_FLAG_CIPHER_SCHEME: This key is for a hardware cipher scheme
  */
 enum ieee80211_internal_key_flags {
 	KEY_FLAG_UPLOADED_TO_HARDWARE	= BIT(0),
 	KEY_FLAG_TAINTED		= BIT(1),
-	KEY_FLAG_CIPHER_SCHEME		= BIT(2),
 };
 
 enum ieee80211_internal_tkip_state {
@@ -140,8 +138,7 @@ struct ieee80211_key {
 struct ieee80211_key *
 ieee80211_key_alloc(u32 cipher, int idx, size_t key_len,
 		    const u8 *key_data,
-		    size_t seq_len, const u8 *seq,
-		    const struct ieee80211_cipher_scheme *cs);
+		    size_t seq_len, const u8 *seq);
 /*
  * Insert a key into data structures (sdata, sta if necessary)
  * to make it used, free old key. On failure, also free the new key.
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5a385d4146b9..4f3e93c0819b 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2017     Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -778,7 +778,7 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 {
 	bool have_wep = !fips_enabled; /* FIPS does not permit the use of RC4 */
 	bool have_mfp = ieee80211_hw_check(&local->hw, MFP_CAPABLE);
-	int n_suites = 0, r = 0, w = 0;
+	int r = 0, w = 0;
 	u32 *suites;
 	static const u32 cipher_suites[] = {
 		/* keep WEP first, it may be removed below */
@@ -824,10 +824,9 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 				continue;
 			suites[w++] = suite;
 		}
-	} else if (!local->hw.cipher_schemes) {
-		/* If the driver doesn't have cipher schemes, there's nothing
-		 * else to do other than assign the (software supported and
-		 * perhaps offloaded) cipher suites.
+	} else {
+		/* assign the (software supported and perhaps offloaded)
+		 * cipher suites
 		 */
 		local->hw.wiphy->cipher_suites = cipher_suites;
 		local->hw.wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
@@ -842,58 +841,6 @@ static int ieee80211_init_cipher_suites(struct ieee80211_local *local)
 
 		/* not dynamically allocated, so just return */
 		return 0;
-	} else {
-		const struct ieee80211_cipher_scheme *cs;
-
-		cs = local->hw.cipher_schemes;
-
-		/* Driver specifies cipher schemes only (but not cipher suites
-		 * including the schemes)
-		 *
-		 * We start counting ciphers defined by schemes, TKIP, CCMP,
-		 * CCMP-256, GCMP, and GCMP-256
-		 */
-		n_suites = local->hw.n_cipher_schemes + 5;
-
-		/* check if we have WEP40 and WEP104 */
-		if (have_wep)
-			n_suites += 2;
-
-		/* check if we have AES_CMAC, BIP-CMAC-256, BIP-GMAC-128,
-		 * BIP-GMAC-256
-		 */
-		if (have_mfp)
-			n_suites += 4;
-
-		suites = kmalloc_array(n_suites, sizeof(u32), GFP_KERNEL);
-		if (!suites)
-			return -ENOMEM;
-
-		suites[w++] = WLAN_CIPHER_SUITE_CCMP;
-		suites[w++] = WLAN_CIPHER_SUITE_CCMP_256;
-		suites[w++] = WLAN_CIPHER_SUITE_TKIP;
-		suites[w++] = WLAN_CIPHER_SUITE_GCMP;
-		suites[w++] = WLAN_CIPHER_SUITE_GCMP_256;
-
-		if (have_wep) {
-			suites[w++] = WLAN_CIPHER_SUITE_WEP40;
-			suites[w++] = WLAN_CIPHER_SUITE_WEP104;
-		}
-
-		if (have_mfp) {
-			suites[w++] = WLAN_CIPHER_SUITE_AES_CMAC;
-			suites[w++] = WLAN_CIPHER_SUITE_BIP_CMAC_256;
-			suites[w++] = WLAN_CIPHER_SUITE_BIP_GMAC_128;
-			suites[w++] = WLAN_CIPHER_SUITE_BIP_GMAC_256;
-		}
-
-		for (r = 0; r < local->hw.n_cipher_schemes; r++) {
-			suites[w++] = cs[r].cipher;
-			if (WARN_ON(cs[r].pn_len > IEEE80211_MAX_PN_LEN)) {
-				kfree(suites);
-				return -EINVAL;
-			}
-		}
 	}
 
 	local->hw.wiphy->cipher_suites = suites;
@@ -1168,12 +1115,6 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	if (local->hw.wiphy->max_scan_ie_len)
 		local->hw.wiphy->max_scan_ie_len -= local->scan_ies_len;
 
-	if (WARN_ON(!ieee80211_cs_list_valid(local->hw.cipher_schemes,
-					     local->hw.n_cipher_schemes))) {
-		result = -EINVAL;
-		goto fail_workqueue;
-	}
-
 	result = ieee80211_init_cipher_suites(local);
 	if (result < 0)
 		goto fail_workqueue;
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 58ebdcd69d05..45e7c1b307bc 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2008, 2009 open80211s Ltd.
- * Copyright (C) 2019, 2021 Intel Corporation
+ * Copyright (C) 2019, 2021-2022 Intel Corporation
  * Author:     Luis Carlos Cobo <luisca@cozybit.com>
  */
 
@@ -247,13 +247,13 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
 		return -EAGAIN;
 
 	skb = dev_alloc_skb(local->tx_headroom +
-			    sdata->encrypt_headroom +
+			    IEEE80211_ENCRYPT_HEADROOM +
 			    IEEE80211_ENCRYPT_TAILROOM +
 			    hdr_len +
 			    2 + 15 /* PERR IE */);
 	if (!skb)
 		return -1;
-	skb_reserve(skb, local->tx_headroom + sdata->encrypt_headroom);
+	skb_reserve(skb, local->tx_headroom + IEEE80211_ENCRYPT_HEADROOM);
 	mgmt = skb_put_zero(skb, hdr_len);
 	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 					  IEEE80211_STYPE_ACTION);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ae5a1e34e7d2..c4aab217ac8e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -8,7 +8,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2022 Intel Corporation
  */
 
 #include <linux/delay.h>
@@ -2496,8 +2496,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
 	cancel_delayed_work_sync(&ifmgd->tx_tspec_wk);
 
-	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
-
 	bss_conf->pwr_reduction = 0;
 	bss_conf->tx_pwr_env_num = 0;
 	memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
@@ -6065,8 +6063,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	sdata->control_port_over_nl80211 =
 					req->crypto.control_port_over_nl80211;
 	sdata->control_port_no_preauth = req->crypto.control_port_no_preauth;
-	sdata->encrypt_headroom = ieee80211_cs_headroom(local, &req->crypto,
-							sdata->vif.type);
 
 	/* kick off associate process */
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 959a36fd658b..6147816418cb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -6,7 +6,7 @@
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #include <linux/jiffies.h>
@@ -1009,43 +1009,20 @@ static int ieee80211_get_mmie_keyidx(struct sk_buff *skb)
 	return -1;
 }
 
-static int ieee80211_get_keyid(struct sk_buff *skb,
-			       const struct ieee80211_cipher_scheme *cs)
+static int ieee80211_get_keyid(struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	__le16 fc;
-	int hdrlen;
-	int minlen;
-	u8 key_idx_off;
-	u8 key_idx_shift;
+	__le16 fc = hdr->frame_control;
+	int hdrlen = ieee80211_hdrlen(fc);
 	u8 keyid;
 
-	fc = hdr->frame_control;
-	hdrlen = ieee80211_hdrlen(fc);
-
-	if (cs) {
-		minlen = hdrlen + cs->hdr_len;
-		key_idx_off = hdrlen + cs->key_idx_off;
-		key_idx_shift = cs->key_idx_shift;
-	} else {
-		/* WEP, TKIP, CCMP and GCMP */
-		minlen = hdrlen + IEEE80211_WEP_IV_LEN;
-		key_idx_off = hdrlen + 3;
-		key_idx_shift = 6;
-	}
-
-	if (unlikely(skb->len < minlen))
+	/* WEP, TKIP, CCMP and GCMP */
+	if (unlikely(skb->len < hdrlen + IEEE80211_WEP_IV_LEN))
 		return -EINVAL;
 
-	skb_copy_bits(skb, key_idx_off, &keyid, 1);
+	skb_copy_bits(skb, hdrlen + 3, &keyid, 1);
 
-	if (cs)
-		keyid &= cs->key_idx_mask;
-	keyid >>= key_idx_shift;
-
-	/* cs could use more than the usual two bits for the keyid */
-	if (unlikely(keyid >= NUM_DEFAULT_KEYS))
-		return -EINVAL;
+	keyid >>= 6;
 
 	return keyid;
 }
@@ -1917,7 +1894,6 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 	struct ieee80211_key *ptk_idx = NULL;
 	int mmie_keyidx = -1;
 	__le16 fc;
-	const struct ieee80211_cipher_scheme *cs = NULL;
 
 	if (ieee80211_is_ext(hdr->frame_control))
 		return RX_CONTINUE;
@@ -1960,8 +1936,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 
 		if (ieee80211_has_protected(fc) &&
 		    !(status->flag & RX_FLAG_IV_STRIPPED)) {
-			cs = rx->sta->cipher_scheme;
-			keyid = ieee80211_get_keyid(rx->skb, cs);
+			keyid = ieee80211_get_keyid(rx->skb);
 
 			if (unlikely(keyid < 0))
 				return RX_DROP_UNUSABLE;
@@ -2066,7 +2041,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		    (status->flag & RX_FLAG_IV_STRIPPED))
 			return RX_CONTINUE;
 
-		keyidx = ieee80211_get_keyid(rx->skb, cs);
+		keyidx = ieee80211_get_keyid(rx->skb);
 
 		if (unlikely(keyidx < 0))
 			return RX_DROP_UNUSABLE;
@@ -2132,7 +2107,7 @@ ieee80211_rx_h_decrypt(struct ieee80211_rx_data *rx)
 		result = ieee80211_crypto_gcmp_decrypt(rx);
 		break;
 	default:
-		result = ieee80211_crypto_hw_decrypt(rx);
+		result = RX_DROP_UNUSABLE;
 	}
 
 	/* the hdr variable is invalid after the decrypt handlers */
@@ -2946,7 +2921,7 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 		tailroom = IEEE80211_ENCRYPT_TAILROOM;
 
 	fwd_skb = skb_copy_expand(skb, local->tx_headroom +
-				       sdata->encrypt_headroom,
+				       IEEE80211_ENCRYPT_HEADROOM,
 				  tailroom, GFP_ATOMIC);
 	if (!fwd_skb)
 		goto out;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 35c390bedfba..aa6950aa49a9 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,7 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright(c) 2020-2021 Intel Corporation
+ * Copyright(c) 2020-2022 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -616,7 +616,6 @@ struct link_sta_info {
  *	taken from HT/VHT capabilities or VHT operating mode notification
  * @known_smps_mode: the smps_mode the client thinks we are in. Relevant for
  *	AP only.
- * @cipher_scheme: optional cipher scheme for this station
  * @cparams: CoDel parameters for this station.
  * @reserved_tid: reserved TID (if any, otherwise IEEE80211_TID_UNRESERVED)
  * @fast_tx: TX fastpath information
@@ -700,7 +699,6 @@ struct sta_info {
 #endif
 
 	enum ieee80211_smps_mode known_smps_mode;
-	const struct ieee80211_cipher_scheme *cipher_scheme;
 
 	struct codel_params cparams;
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0e4efc08c762..37fe72bb5ab0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -882,7 +882,7 @@ static int ieee80211_fragment(struct ieee80211_tx_data *tx,
 		rem -= fraglen;
 		tmp = dev_alloc_skb(local->tx_headroom +
 				    frag_threshold +
-				    tx->sdata->encrypt_headroom +
+				    IEEE80211_ENCRYPT_HEADROOM +
 				    IEEE80211_ENCRYPT_TAILROOM);
 		if (!tmp)
 			return -ENOMEM;
@@ -890,7 +890,7 @@ static int ieee80211_fragment(struct ieee80211_tx_data *tx,
 		__skb_queue_tail(&tx->skbs, tmp);
 
 		skb_reserve(tmp,
-			    local->tx_headroom + tx->sdata->encrypt_headroom);
+			    local->tx_headroom + IEEE80211_ENCRYPT_HEADROOM);
 
 		/* copy control information */
 		memcpy(tmp->cb, skb->cb, sizeof(tmp->cb));
@@ -1040,8 +1040,6 @@ ieee80211_tx_h_encrypt(struct ieee80211_tx_data *tx)
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		return ieee80211_crypto_gcmp_encrypt(tx);
-	default:
-		return ieee80211_crypto_hw_encrypt(tx);
 	}
 
 	return TX_DROP;
@@ -2013,7 +2011,7 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 
 	headroom = local->tx_headroom;
 	if (encrypt != ENCRYPT_NO)
-		headroom += sdata->encrypt_headroom;
+		headroom += IEEE80211_ENCRYPT_HEADROOM;
 	headroom -= skb_headroom(skb);
 	headroom = max_t(int, 0, headroom);
 
@@ -2867,7 +2865,7 @@ static struct sk_buff *ieee80211_build_hdr(struct ieee80211_sub_if_data *sdata,
 	 */
 
 	if (head_need > 0 || skb_cloned(skb)) {
-		head_need += sdata->encrypt_headroom;
+		head_need += IEEE80211_ENCRYPT_HEADROOM;
 		head_need += local->tx_headroom;
 		head_need = max_t(int, 0, head_need);
 		if (ieee80211_skb_resize(sdata, skb, head_need, ENCRYPT_DATA)) {
@@ -3128,15 +3126,6 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 			/* we don't know how to generate IVs for this at all */
 			if (WARN_ON(gen_iv))
 				goto out;
-			/* pure hardware keys are OK, of course */
-			if (!(build.key->flags & KEY_FLAG_CIPHER_SCHEME))
-				break;
-			/* cipher scheme might require space allocation */
-			if (iv_spc &&
-			    build.key->conf.iv_len > IEEE80211_FAST_XMIT_MAX_IV)
-				goto out;
-			if (iv_spc)
-				build.hdr_len += build.key->conf.iv_len;
 		}
 
 		fc |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1e26b5235add..9e6c4dcef280 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -6,7 +6,7 @@
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  *
  * utilities for mac80211
  */
@@ -4212,74 +4212,6 @@ int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-bool ieee80211_cs_valid(const struct ieee80211_cipher_scheme *cs)
-{
-	return !(cs == NULL || cs->cipher == 0 ||
-		 cs->hdr_len < cs->pn_len + cs->pn_off ||
-		 cs->hdr_len <= cs->key_idx_off ||
-		 cs->key_idx_shift > 7 ||
-		 cs->key_idx_mask == 0);
-}
-
-bool ieee80211_cs_list_valid(const struct ieee80211_cipher_scheme *cs, int n)
-{
-	int i;
-
-	/* Ensure we have enough iftype bitmap space for all iftype values */
-	WARN_ON((NUM_NL80211_IFTYPES / 8 + 1) > sizeof(cs[0].iftype));
-
-	for (i = 0; i < n; i++)
-		if (!ieee80211_cs_valid(&cs[i]))
-			return false;
-
-	return true;
-}
-
-const struct ieee80211_cipher_scheme *
-ieee80211_cs_get(struct ieee80211_local *local, u32 cipher,
-		 enum nl80211_iftype iftype)
-{
-	const struct ieee80211_cipher_scheme *l = local->hw.cipher_schemes;
-	int n = local->hw.n_cipher_schemes;
-	int i;
-	const struct ieee80211_cipher_scheme *cs = NULL;
-
-	for (i = 0; i < n; i++) {
-		if (l[i].cipher == cipher) {
-			cs = &l[i];
-			break;
-		}
-	}
-
-	if (!cs || !(cs->iftype & BIT(iftype)))
-		return NULL;
-
-	return cs;
-}
-
-int ieee80211_cs_headroom(struct ieee80211_local *local,
-			  struct cfg80211_crypto_settings *crypto,
-			  enum nl80211_iftype iftype)
-{
-	const struct ieee80211_cipher_scheme *cs;
-	int headroom = IEEE80211_ENCRYPT_HEADROOM;
-	int i;
-
-	for (i = 0; i < crypto->n_ciphers_pairwise; i++) {
-		cs = ieee80211_cs_get(local, crypto->ciphers_pairwise[i],
-				      iftype);
-
-		if (cs && headroom < cs->hdr_len)
-			headroom = cs->hdr_len;
-	}
-
-	cs = ieee80211_cs_get(local, crypto->cipher_group, iftype);
-	if (cs && headroom < cs->hdr_len)
-		headroom = cs->hdr_len;
-
-	return headroom;
-}
-
 static bool
 ieee80211_extend_noa_desc(struct ieee80211_noa_data *data, u32 tsf, int i)
 {
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 5fd8a3e8b5b4..93ec2f349748 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -3,7 +3,7 @@
  * Copyright 2002-2004, Instant802 Networks, Inc.
  * Copyright 2008, Jouni Malinen <j@w1.fi>
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2020-2021 Intel Corporation
+ * Copyright (C) 2020-2022 Intel Corporation
  */
 
 #include <linux/netdevice.h>
@@ -778,102 +778,6 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
-static ieee80211_tx_result
-ieee80211_crypto_cs_encrypt(struct ieee80211_tx_data *tx,
-			    struct sk_buff *skb)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	struct ieee80211_key *key = tx->key;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	int hdrlen;
-	u8 *pos, iv_len = key->conf.iv_len;
-
-	if (info->control.hw_key &&
-	    !(info->control.hw_key->flags & IEEE80211_KEY_FLAG_PUT_IV_SPACE)) {
-		/* hwaccel has no need for preallocated head room */
-		return TX_CONTINUE;
-	}
-
-	if (unlikely(skb_headroom(skb) < iv_len &&
-		     pskb_expand_head(skb, iv_len, 0, GFP_ATOMIC)))
-		return TX_DROP;
-
-	hdrlen = ieee80211_hdrlen(hdr->frame_control);
-
-	pos = skb_push(skb, iv_len);
-	memmove(pos, pos + iv_len, hdrlen);
-
-	return TX_CONTINUE;
-}
-
-static inline int ieee80211_crypto_cs_pn_compare(u8 *pn1, u8 *pn2, int len)
-{
-	int i;
-
-	/* pn is little endian */
-	for (i = len - 1; i >= 0; i--) {
-		if (pn1[i] < pn2[i])
-			return -1;
-		else if (pn1[i] > pn2[i])
-			return 1;
-	}
-
-	return 0;
-}
-
-static ieee80211_rx_result
-ieee80211_crypto_cs_decrypt(struct ieee80211_rx_data *rx)
-{
-	struct ieee80211_key *key = rx->key;
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)rx->skb->data;
-	const struct ieee80211_cipher_scheme *cs = NULL;
-	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
-	int data_len;
-	u8 *rx_pn;
-	u8 *skb_pn;
-	u8 qos_tid;
-
-	if (!rx->sta || !rx->sta->cipher_scheme ||
-	    !(status->flag & RX_FLAG_DECRYPTED))
-		return RX_DROP_UNUSABLE;
-
-	if (!ieee80211_is_data(hdr->frame_control))
-		return RX_CONTINUE;
-
-	cs = rx->sta->cipher_scheme;
-
-	data_len = rx->skb->len - hdrlen - cs->hdr_len;
-
-	if (data_len < 0)
-		return RX_DROP_UNUSABLE;
-
-	if (ieee80211_is_data_qos(hdr->frame_control))
-		qos_tid = ieee80211_get_tid(hdr);
-	else
-		qos_tid = 0;
-
-	if (skb_linearize(rx->skb))
-		return RX_DROP_UNUSABLE;
-
-	rx_pn = key->u.gen.rx_pn[qos_tid];
-	skb_pn = rx->skb->data + hdrlen + cs->pn_off;
-
-	if (ieee80211_crypto_cs_pn_compare(skb_pn, rx_pn, cs->pn_len) <= 0)
-		return RX_DROP_UNUSABLE;
-
-	memcpy(rx_pn, skb_pn, cs->pn_len);
-
-	/* remove security header and MIC */
-	if (pskb_trim(rx->skb, rx->skb->len - cs->mic_len))
-		return RX_DROP_UNUSABLE;
-
-	memmove(rx->skb->data + cs->hdr_len, rx->skb->data, hdrlen);
-	skb_pull(rx->skb, cs->hdr_len);
-
-	return RX_CONTINUE;
-}
-
 static void bip_aad(struct sk_buff *skb, u8 *aad)
 {
 	__le16 mask_fc;
@@ -1212,38 +1116,3 @@ ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx)
 
 	return RX_CONTINUE;
 }
-
-ieee80211_tx_result
-ieee80211_crypto_hw_encrypt(struct ieee80211_tx_data *tx)
-{
-	struct sk_buff *skb;
-	struct ieee80211_tx_info *info = NULL;
-	ieee80211_tx_result res;
-
-	skb_queue_walk(&tx->skbs, skb) {
-		info  = IEEE80211_SKB_CB(skb);
-
-		/* handle hw-only algorithm */
-		if (!info->control.hw_key)
-			return TX_DROP;
-
-		if (tx->key->flags & KEY_FLAG_CIPHER_SCHEME) {
-			res = ieee80211_crypto_cs_encrypt(tx, skb);
-			if (res != TX_CONTINUE)
-				return res;
-		}
-	}
-
-	ieee80211_tx_set_protected(tx);
-
-	return TX_CONTINUE;
-}
-
-ieee80211_rx_result
-ieee80211_crypto_hw_decrypt(struct ieee80211_rx_data *rx)
-{
-	if (rx->sta && rx->sta->cipher_scheme)
-		return ieee80211_crypto_cs_decrypt(rx);
-
-	return RX_DROP_UNUSABLE;
-}
diff --git a/net/mac80211/wpa.h b/net/mac80211/wpa.h
index af3272284e85..a9a81abb5479 100644
--- a/net/mac80211/wpa.h
+++ b/net/mac80211/wpa.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright 2002-2004, Instant802 Networks, Inc.
+ * Copyright (C) 2022 Intel Corporation
  */
 
 #ifndef WPA_H
@@ -39,10 +40,6 @@ ieee80211_tx_result
 ieee80211_crypto_aes_gmac_encrypt(struct ieee80211_tx_data *tx);
 ieee80211_rx_result
 ieee80211_crypto_aes_gmac_decrypt(struct ieee80211_rx_data *rx);
-ieee80211_tx_result
-ieee80211_crypto_hw_encrypt(struct ieee80211_tx_data *tx);
-ieee80211_rx_result
-ieee80211_crypto_hw_decrypt(struct ieee80211_rx_data *rx);
 
 ieee80211_tx_result
 ieee80211_crypto_gcmp_encrypt(struct ieee80211_tx_data *tx);
-- 
2.36.1

