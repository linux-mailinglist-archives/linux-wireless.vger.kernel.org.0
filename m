Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85714738344
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjFULuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFULuV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:50:21 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9F10DB
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687348220; x=1718884220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JNw+kJa6adeYxk4YRLXmsfKf7771QlrDzXGrO3XoSvk=;
  b=VdBk11YfwqOv2ABkGfsML7lJewmSyCeJ3hDhDMYp64oiz/ijBgvT8+qX
   SMtmgpB/ohKOxawFnpOCMSz6qwJ5g9/7+qBrwkslHD2golLfx8HqEpuJG
   JdUuTACNeBlX5TrtaR9mPk66fHMn5hcCNKSFzNbzbiHBTl5TxXSx4oQi3
   7gFQlHbQCE3nRss4KuTSPCGSMtXJvYVpzJYYc6i6k8yMGPp+tkJpOg02+
   uw/+6Q2LS7BKgZphkykMa8RXWH0Z+B75FCULCCs6K+N9lOGoFbyWgSRYY
   TE2hW4VmhobBPe/ZXizWFyWbmtBHdaQwpZu9v8Py1q4EPM8ic6XJjdrBF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360158346"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360158346"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="717617591"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="717617591"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:50:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/3] wifi: iwlwifi: mvm: Add support for IGTK in D3 resume flow
Date:   Wed, 21 Jun 2023 14:49:52 +0300
Message-Id: <20230621144844.b53c301c07e6.I375277a10a1f756b93d4a343f6664351a80189c5@changeid>
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

As part of the new security API in the FW, all security keys are to
be removed before station removal. Until now IGTK rekey
wasn't supported in the D3 resume flow, and thus the driver might
not know the right key to remove.
If an IGTK was rekeyed during D3 the old IGTK is removed and the
new key is updated. If not, the old key's IPN is updated.
As opposed to GTK, which both the FW and the driver hold it's two
most recent keys, only one IGTK is held.

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 168 +++++++++++++++---
 2 files changed, 147 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 380eeb2363c7..72d461c47323 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -396,6 +396,7 @@ struct iwl_wowlan_config_cmd {
 #define WOWLAN_KEY_MAX_SIZE	32
 #define WOWLAN_GTK_KEYS_NUM     2
 #define WOWLAN_IGTK_KEYS_NUM	2
+#define WOWLAN_IGTK_MIN_INDEX	4
 
 /*
  * WOWLAN_TSC_RSC_PARAMS
@@ -612,6 +613,7 @@ struct iwl_wowlan_gtk_status_v3 {
 } __packed; /* WOWLAN_GTK_MATERIAL_VER_3 */
 
 #define IWL_WOWLAN_GTK_IDX_MASK		(BIT(0) | BIT(1))
+#define IWL_WOWLAN_IGTK_BIGTK_IDX_MASK	(BIT(0))
 
 /**
  * struct iwl_wowlan_igtk_status - IGTK status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 1d900342224f..f6488b4bbe68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1380,6 +1380,14 @@ int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	return __iwl_mvm_suspend(hw, wowlan, false);
 }
 
+struct iwl_multicast_key_data {
+	u8 key[WOWLAN_KEY_MAX_SIZE];
+	u8 len;
+	u8 flags;
+	u8 id;
+	u8 ipn[6];
+};
+
 /* converted data from the different status responses */
 struct iwl_wowlan_status_data {
 	u64 replay_ctr;
@@ -1429,12 +1437,7 @@ struct iwl_wowlan_status_data {
 		} tkip, aes;
 	} ptk;
 
-	struct {
-		u64 ipn;
-		u8 key[WOWLAN_KEY_MAX_SIZE];
-		u8 len;
-		u8 flags;
-	} igtk;
+	struct iwl_multicast_key_data igtk;
 
 	u8 *wake_packet;
 };
@@ -1778,8 +1781,8 @@ static void iwl_mvm_set_key_rx_seq(struct ieee80211_key_conf *key,
 struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_mvm *mvm;
 	struct iwl_wowlan_status_data *status;
-	u32 gtk_cipher;
-	bool unhandled_cipher;
+	u32 gtk_cipher, igtk_cipher;
+	bool unhandled_cipher, igtk_support;
 	int num_keys;
 };
 
@@ -1806,6 +1809,19 @@ static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
 		/* we support these */
 		data->gtk_cipher = key->cipher;
 		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		/* we support these */
+		if (data->igtk_support &&
+		    (key->keyidx == 4 || key->keyidx == 5)) {
+			data->igtk_cipher = key->cipher;
+		} else {
+			data->unhandled_cipher = true;
+			return;
+		}
+		break;
 	default:
 		/* everything else - disconnect from AP */
 		data->unhandled_cipher = true;
@@ -1815,6 +1831,23 @@ static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
 	data->num_keys++;
 }
 
+static void
+iwl_mvm_d3_set_igtk_bigtk_ipn(const struct iwl_multicast_key_data *key,
+			      struct ieee80211_key_seq *seq, u32 cipher)
+{
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		BUILD_BUG_ON(sizeof(seq->aes_gmac.pn) != sizeof(key->ipn));
+		memcpy(seq->aes_gmac.pn, key->ipn, sizeof(seq->aes_gmac.pn));
+		break;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		BUILD_BUG_ON(sizeof(seq->aes_cmac.pn) != sizeof(key->ipn));
+		memcpy(seq->aes_cmac.pn, key->ipn, sizeof(seq->aes_cmac.pn));
+		break;
+	}
+}
+
 static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta,
@@ -1861,6 +1894,24 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 		} else {
 			iwl_mvm_set_key_rx_seq(key, data->status, false);
 		}
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		if (key->keyidx == 4 || key->keyidx == 5) {
+			/* remove rekeyed key */
+			if (status->num_of_gtk_rekeys) {
+				ieee80211_remove_key(key);
+			} else {
+				struct ieee80211_key_seq seq;
+
+				iwl_mvm_d3_set_igtk_bigtk_ipn(&status->igtk,
+							      &seq,
+							      key->cipher);
+				ieee80211_set_key_rx_seq(key, 0, &seq);
+			}
+		}
 	}
 }
 
@@ -1918,6 +1969,70 @@ static bool iwl_mvm_gtk_rekey(struct iwl_wowlan_status_data *status,
 	return true;
 }
 
+static bool
+iwl_mvm_d3_igtk_bigtk_rekey_add(struct iwl_wowlan_status_data *status,
+				struct ieee80211_vif *vif, u32 cipher,
+				struct iwl_multicast_key_data *key_data)
+{
+	struct ieee80211_key_conf *key_config;
+	struct {
+		struct ieee80211_key_conf conf;
+		u8 key[WOWLAN_KEY_MAX_SIZE];
+	} conf = {
+		.conf.cipher = cipher,
+		.conf.keyidx = key_data->id,
+	};
+	struct ieee80211_key_seq seq;
+
+	if (!key_data->len)
+		return true;
+
+	iwl_mvm_d3_set_igtk_bigtk_ipn(key_data, &seq, conf.conf.cipher);
+
+	switch (cipher) {
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_128;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		conf.conf.keylen = WLAN_KEY_LEN_BIP_GMAC_256;
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		conf.conf.keylen = WLAN_KEY_LEN_AES_CMAC;
+		break;
+	case WLAN_CIPHER_SUITE_BIP_CMAC_256:
+		conf.conf.keylen = WLAN_KEY_LEN_BIP_CMAC_256;
+		break;
+	default:
+		WARN_ON(1);
+	}
+	BUILD_BUG_ON(sizeof(conf.key) < sizeof(key_data->key));
+	memcpy(conf.conf.key, key_data->key, conf.conf.keylen);
+
+	key_config = ieee80211_gtk_rekey_add(vif, &conf.conf);
+	if (IS_ERR(key_config))
+		return false;
+	ieee80211_set_key_rx_seq(key_config, 0, &seq);
+	return true;
+}
+
+static int iwl_mvm_lookup_wowlan_status_ver(struct iwl_mvm *mvm)
+{
+	u8 notif_ver;
+
+	if (!fw_has_api(&mvm->fw->ucode_capa,
+			IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL))
+		return 6;
+
+	/* default to 7 (when we have IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL) */
+	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
+					    WOWLAN_GET_STATUSES, 0);
+	if (!notif_ver)
+		notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
+						    WOWLAN_GET_STATUSES, 7);
+
+	return notif_ver;
+}
+
 static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 					  struct ieee80211_vif *vif,
 					  struct iwl_wowlan_status_data *status)
@@ -1937,6 +2052,12 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	if (status->wakeup_reasons & disconnection_reasons)
 		return false;
 
+	if (iwl_mvm_lookup_wowlan_status_ver(mvm) > 6 ||
+	    iwl_fw_lookup_notif_ver(mvm->fw, PROT_OFFLOAD_GROUP,
+				    WOWLAN_INFO_NOTIFICATION,
+				    0))
+		gtkdata.igtk_support = true;
+
 	/* find last GTK that we used initially, if any */
 	ieee80211_iter_keys(mvm->hw, vif,
 			    iwl_mvm_d3_find_last_keys, &gtkdata);
@@ -1961,6 +2082,12 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 
 		if (!iwl_mvm_gtk_rekey(status, vif, mvm, gtkdata.gtk_cipher))
 			return false;
+
+		if (!iwl_mvm_d3_igtk_bigtk_rekey_add(status, vif,
+						     gtkdata.igtk_cipher,
+						     &status->igtk))
+			return false;
+
 		ieee80211_gtk_rekey_notify(vif, vif->bss_conf.bssid,
 					   (void *)&replay_ctr, GFP_KERNEL);
 	}
@@ -2030,21 +2157,19 @@ static void iwl_mvm_convert_gtk_v3(struct iwl_wowlan_status_data *status,
 static void iwl_mvm_convert_igtk(struct iwl_wowlan_status_data *status,
 				 struct iwl_wowlan_igtk_status *data)
 {
-	const u8 *ipn = data->ipn;
-
 	BUILD_BUG_ON(sizeof(status->igtk.key) < sizeof(data->key));
 
+	if (!data->key_len)
+		return;
+
 	status->igtk.len = data->key_len;
 	status->igtk.flags = data->key_flags;
+	status->igtk.id = u32_get_bits(data->key_flags,
+				       IWL_WOWLAN_IGTK_BIGTK_IDX_MASK)
+		+ WOWLAN_IGTK_MIN_INDEX;
 
 	memcpy(status->igtk.key, data->key, sizeof(data->key));
-
-	status->igtk.ipn = ((u64)ipn[5] <<  0) |
-			   ((u64)ipn[4] <<  8) |
-			   ((u64)ipn[3] << 16) |
-			   ((u64)ipn[2] << 24) |
-			   ((u64)ipn[1] << 32) |
-			   ((u64)ipn[0] << 40);
+	memcpy(status->igtk.ipn, data->ipn, sizeof(data->ipn));
 }
 
 static void iwl_mvm_parse_wowlan_info_notif(struct iwl_mvm *mvm,
@@ -2175,14 +2300,9 @@ iwl_mvm_send_wowlan_get_status(struct iwl_mvm *mvm, u8 sta_id)
 	len = iwl_rx_packet_payload_len(cmd.resp_pkt);
 
 	/* default to 7 (when we have IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL) */
-	notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LONG_GROUP,
-					    WOWLAN_GET_STATUSES, 0);
-	if (!notif_ver)
-		notif_ver = iwl_fw_lookup_notif_ver(mvm->fw, LEGACY_GROUP,
-						    WOWLAN_GET_STATUSES, 7);
+	notif_ver = iwl_mvm_lookup_wowlan_status_ver(mvm);
 
-	if (!fw_has_api(&mvm->fw->ucode_capa,
-			IWL_UCODE_TLV_API_WOWLAN_KEY_MATERIAL)) {
+	if (notif_ver < 7) {
 		struct iwl_wowlan_status_v6 *v6 = (void *)cmd.resp_pkt->data;
 
 		status = iwl_mvm_parse_wowlan_status_common_v6(mvm, v6, len);
-- 
2.38.1

