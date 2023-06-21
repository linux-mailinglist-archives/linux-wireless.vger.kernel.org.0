Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E777382A3
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjFULuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFULuQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:50:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C037810DB
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687348214; x=1718884214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O/bRbwk6iRZCJDPmivd6SaCAhim6u/DC5LGAqON2c90=;
  b=UpCBDYoowhd1kkkS1KDRAms9ltjbWQ8GuuOOMdbvJPbZYtR9/QChqAbi
   y8Y6RxTLFi25324x1nrgqfmCq9KHbNzx1zHfCSC63kOJucw9gSb9FIS7C
   ay8DVE/BM08TyV6GksAmZW/K4scqnbiTCrqp/S6wbPUUlvm+rnPn/BbgN
   qfHsR6ICJQhHrQI3lShaLdivAoBHXwgorjyE427s2ZdMo0I+vhCGKSfIt
   ABHsuN/JcysxY9xZVymoA9xTWr2kZFoI8vDk2F8a9/5ZpwaOtXBLKxDkY
   2dVom5VMYGDg7MSWbHS9mzyqNfhjMS8Gp+GG8PBYJ+YiYH7sNhb7L0T8P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360158315"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360158315"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:50:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="717617564"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="717617564"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:50:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 2/3] wifi: iwlwifi: mvm: update two most recent GTK's on D3 resume flow
Date:   Wed, 21 Jun 2023 14:49:51 +0300
Message-Id: <20230621144844.3ea3a9f52ec2.I7cedfa2bb0eafb83e7c77363673560acf05bff74@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621144844.a2442844c224.I598ed742c7aaa5414702f03f694f2dc0874bc077@changeid>
References: <20230621144844.a2442844c224.I598ed742c7aaa5414702f03f694f2dc0874bc077@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

When resuming from D3 the two most recent GTK's are passed from
the FW with wowlan_info_notif. Both keys should be updated as
they both might be needed upon FW restart and they both should
be removed upon station removal.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 196 ++++++++++++--------
 1 file changed, 115 insertions(+), 81 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index d3eb13f3372b..1d900342224f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1398,7 +1398,8 @@ struct iwl_wowlan_status_data {
 		u8 key[WOWLAN_KEY_MAX_SIZE];
 		u8 len;
 		u8 flags;
-	} gtk;
+		u8 id;
+	} gtk[WOWLAN_GTK_KEYS_NUM];
 
 	struct {
 		/*
@@ -1758,7 +1759,7 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 			s8 new_key_id = -1;
 
 			if (status->num_of_gtk_rekeys)
-				new_key_id = status->gtk.flags &
+				new_key_id = status->gtk[0].flags &
 						IWL_WOWLAN_GTK_IDX_MASK;
 
 			/* Don't install a new key's value to an old key */
@@ -1777,8 +1778,7 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_mvm *mvm;
 	struct iwl_wowlan_status_data *status;
-	void *last_gtk;
-	u32 cipher;
+	u32 gtk_cipher;
 	bool unhandled_cipher;
 	int num_keys;
 };
@@ -1804,8 +1804,7 @@ static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_TKIP:
 		/* we support these */
-		data->last_gtk = key;
-		data->cipher = key->cipher;
+		data->gtk_cipher = key->cipher;
 		break;
 	default:
 		/* everything else - disconnect from AP */
@@ -1824,6 +1823,7 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm_d3_gtk_iter_data *data = _data;
 	struct iwl_wowlan_status_data *status = data->status;
+	s8 keyidx;
 
 	if (data->unhandled_cipher)
 		return;
@@ -1848,14 +1848,76 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 			iwl_mvm_set_key_rx_seq_tids(key, status->ptk.tkip.seq);
 			return;
 		}
-		if (data->status->num_of_gtk_rekeys)
+		keyidx = key->keyidx;
+		/* The current key is always sent by the FW, even if it wasn't
+		 * rekeyed during D3.
+		 * We remove an existing key if it has the same index as
+		 * a new key
+		 */
+		if (status->num_of_gtk_rekeys &&
+		    ((status->gtk[0].len && keyidx == status->gtk[0].id) ||
+		     (status->gtk[1].len && keyidx == status->gtk[1].id))) {
 			ieee80211_remove_key(key);
-
-		if (data->last_gtk == key)
+		} else {
 			iwl_mvm_set_key_rx_seq(key, data->status, false);
+		}
 	}
 }
 
+static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
+			      struct ieee80211_vif *vif,
+			      struct iwl_mvm *mvm, u32 gtk_cipher)
+{
+	int i;
+	struct ieee80211_key_conf *key;
+	struct {
+		struct ieee80211_key_conf conf;
+		u8 key[32];
+	} conf = {
+		.conf.cipher = gtk_cipher,
+	};
+
+	BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
+	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
+	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
+	BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
+	BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk[0].key));
+
+	switch (gtk_cipher) {
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+		conf.conf.keylen = WLAN_KEY_LEN_CCMP;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		conf.conf.keylen = WLAN_KEY_LEN_TKIP;
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(status->gtk); i++) {
+		if (!status->gtk[i].len)
+			continue;
+
+		conf.conf.keyidx = status->gtk[i].id;
+		IWL_DEBUG_WOWLAN(mvm,
+				 "Received from FW GTK cipher %d, key index %d\n",
+				 conf.conf.cipher, conf.conf.keyidx);
+		memcpy(conf.conf.key, status->gtk[i].key,
+		       sizeof(status->gtk[i].key));
+
+		key = ieee80211_gtk_rekey_add(vif, &conf.conf);
+		if (IS_ERR(key))
+			return false;
+		iwl_mvm_set_key_rx_seq_idx(key, status, i);
+	}
+
+	return true;
+}
+
 static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  struct iwl_wowlan_status_data *status)
@@ -1883,8 +1945,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		return false;
 	if (!gtkdata.num_keys)
 		goto out;
-	if (!gtkdata.last_gtk)
-		return false;
 
 	/*
 	 * invalidate all other GTKs that might still exist and update
@@ -1893,52 +1953,14 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	ieee80211_iter_keys(mvm->hw, vif,
 			    iwl_mvm_d3_update_keys, &gtkdata);
 
-	IWL_DEBUG_WOWLAN(mvm, "num of GTK rekeying %d\n",
-			 status->num_of_gtk_rekeys);
 	if (status->num_of_gtk_rekeys) {
-		struct ieee80211_key_conf *key;
-		struct {
-			struct ieee80211_key_conf conf;
-			u8 key[32];
-		} conf = {
-			.conf.cipher = gtkdata.cipher,
-			.conf.keyidx =
-				status->gtk.flags & IWL_WOWLAN_GTK_IDX_MASK,
-		};
-		__be64 replay_ctr;
-
-		IWL_DEBUG_WOWLAN(mvm,
-				 "Received from FW GTK cipher %d, key index %d\n",
-				 conf.conf.cipher, conf.conf.keyidx);
+		__be64 replay_ctr = cpu_to_be64(status->replay_ctr);
 
-		BUILD_BUG_ON(WLAN_KEY_LEN_CCMP != WLAN_KEY_LEN_GCMP);
-		BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_CCMP);
-		BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_GCMP_256);
-		BUILD_BUG_ON(sizeof(conf.key) < WLAN_KEY_LEN_TKIP);
-		BUILD_BUG_ON(sizeof(conf.key) < sizeof(status->gtk.key));
+		IWL_DEBUG_WOWLAN(mvm, "num of GTK rekeying %d\n",
+				 status->num_of_gtk_rekeys);
 
-		memcpy(conf.conf.key, status->gtk.key, sizeof(status->gtk.key));
-
-		switch (gtkdata.cipher) {
-		case WLAN_CIPHER_SUITE_CCMP:
-		case WLAN_CIPHER_SUITE_GCMP:
-			conf.conf.keylen = WLAN_KEY_LEN_CCMP;
-			break;
-		case WLAN_CIPHER_SUITE_GCMP_256:
-			conf.conf.keylen = WLAN_KEY_LEN_GCMP_256;
-			break;
-		case WLAN_CIPHER_SUITE_TKIP:
-			conf.conf.keylen = WLAN_KEY_LEN_TKIP;
-			break;
-		}
-
-		key = ieee80211_gtk_rekey_add(vif, &conf.conf);
-		if (IS_ERR(key))
+		if (!iwl_mvm_gtk_rekey(status, vif, mvm, gtkdata.gtk_cipher))
 			return false;
-		iwl_mvm_set_key_rx_seq(key, status, true);
-
-		replay_ctr = cpu_to_be64(status->replay_ctr);
-
 		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
 					   (void *)&replay_ctr, GFP_KERNEL);
 	}
@@ -1957,40 +1979,52 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 static void iwl_mvm_convert_gtk_v2(struct iwl_wowlan_status_data *status,
 				   struct iwl_wowlan_gtk_status_v2 *data)
 {
-	BUILD_BUG_ON(sizeof(status->gtk.key) < sizeof(data->key));
+	BUILD_BUG_ON(sizeof(status->gtk[0].key) < sizeof(data->key));
 	BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
 		     sizeof(data->tkip_mic_key) >
-		     sizeof(status->gtk.key));
+		     sizeof(status->gtk[0].key));
 
-	status->gtk.len = data->key_len;
-	status->gtk.flags = data->key_flags;
+	status->gtk[0].len = data->key_len;
+	status->gtk[0].flags = data->key_flags;
 
-	memcpy(status->gtk.key, data->key, sizeof(data->key));
+	memcpy(status->gtk[0].key, data->key, sizeof(data->key));
 
 	/* if it's as long as the TKIP encryption key, copy MIC key */
-	if (status->gtk.len == NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
-		memcpy(status->gtk.key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+	if (status->gtk[0].len == NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
+		memcpy(status->gtk[0].key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
 		       data->tkip_mic_key, sizeof(data->tkip_mic_key));
 }
 
 static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 				   struct iwl_wowlan_gtk_status_v3 *data)
 {
-	/* The parts we need are identical in v2 and v3 */
-#define CHECK(_f) do {							\
-	BUILD_BUG_ON(offsetof(struct iwl_wowlan_gtk_status_v2, _f) !=	\
-		     offsetof(struct iwl_wowlan_gtk_status_v3, _f));	\
-	BUILD_BUG_ON(offsetofend(struct iwl_wowlan_gtk_status_v2, _f) !=\
-		     offsetofend(struct iwl_wowlan_gtk_status_v3, _f));	\
-} while (0)
+	int data_idx, status_idx = 0;
 
-	CHECK(key);
-	CHECK(key_len);
-	CHECK(key_flags);
-	CHECK(tkip_mic_key);
-#undef CHECK
+	BUILD_BUG_ON(sizeof(status->gtk[0].key) < sizeof(data[0].key));
+	BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
+		     sizeof(data[0].tkip_mic_key) >
+		     sizeof(status->gtk[0].key));
+	BUILD_BUG_ON(ARRAY_SIZE(status->gtk) < WOWLAN_GTK_KEYS_NUM);
+	for (data_idx = 0; data_idx < ARRAY_SIZE(status->gtk); data_idx++) {
+		if (!(data[data_idx].key_len))
+			continue;
+		status->gtk[status_idx].len = data[data_idx].key_len;
+		status->gtk[status_idx].flags = data[data_idx].key_flags;
+		status->gtk[status_idx].id = status->gtk[status_idx].flags &
+				    IWL_WOWLAN_GTK_IDX_MASK;
+
+		memcpy(status->gtk[status_idx].key, data[data_idx].key,
+		       sizeof(data[data_idx].key));
 
-	iwl_mvm_convert_gtk_v2(status, (void *)data);
+		/* if it's as long as the TKIP encryption key, copy MIC key */
+		if (status->gtk[status_idx].len ==
+		    NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY)
+			memcpy(status->gtk[status_idx].key +
+			       NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+			       data[data_idx].tkip_mic_key,
+			       sizeof(data[data_idx].tkip_mic_key));
+		status_idx++;
+	}
 }
 
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
@@ -2033,7 +2067,7 @@ static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
 	}
 
 	iwl_mvm_convert_key_counters_v5(status, &data->gtk[0].sc);
-	iwl_mvm_convert_gtk_v3(status, &data->gtk[0]);
+	iwl_mvm_convert_gtk_v3(status, data->gtk);
 	iwl_mvm_convert_igtk(status, &data->igtk[0]);
 
 	status->replay_ctr = le64_to_cpu(data->replay_ctr);
@@ -2156,29 +2190,29 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 			goto out_free_resp;
 
 		BUILD_BUG_ON(sizeof(v6->gtk.decrypt_key) >
-			     sizeof(status->gtk.key));
+			     sizeof(status->gtk[0].key));
 		BUILD_BUG_ON(NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY +
 			     sizeof(v6->gtk.tkip_mic_key) >
-			     sizeof(status->gtk.key));
+			     sizeof(status->gtk[0].key));
 
 		/* copy GTK info to the right place */
-		memcpy(status->gtk.key, v6->gtk.decrypt_key,
+		memcpy(status->gtk[0].key, v6->gtk.decrypt_key,
 		       sizeof(v6->gtk.decrypt_key));
-		memcpy(status->gtk.key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+		memcpy(status->gtk[0].key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
 		       v6->gtk.tkip_mic_key,
 		       sizeof(v6->gtk.tkip_mic_key));
 
 		iwl_mvm_convert_key_counters(status, &v6->gtk.rsc.all_tsc_rsc);
 
 		/* hardcode the key length to 16 since v6 only supports 16 */
-		status->gtk.len = 16;
+		status->gtk[0].len = 16;
 
 		/*
 		 * The key index only uses 2 bits (values 0 to 3) and
 		 * we always set bit 7 which means this is the
 		 * currently used key.
 		 */
-		status->gtk.flags = v6->gtk.key_index | BIT(7);
+		status->gtk[0].flags = v6->gtk.key_index | BIT(7);
 	} else if (notif_ver == 7) {
 		struct iwl_wowlan_status_v7 *v7 = (void *)cmd.resp_pkt->data;
 
@@ -2212,7 +2246,7 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 			goto out_free_resp;
 
 		iwl_mvm_convert_key_counters_v5(status, &v12->gtk[0].sc);
-		iwl_mvm_convert_gtk_v3(status, &v12->gtk[0]);
+		iwl_mvm_convert_gtk_v3(status, v12->gtk);
 		iwl_mvm_convert_igtk(status, &v12->igtk[0]);
 
 		status->tid_tear_down = v12->tid_tear_down;
-- 
2.38.1

