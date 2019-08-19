Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9C94AD7
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfHSQuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:18 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:36994 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727032AbfHSQuR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:17 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrH-0007zi-IH; Mon, 19 Aug 2019 19:50:16 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:49:49 +0300
Message-Id: <20190819165007.10181-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 04/22] iwlwifi: mvm: Block 26-tone RU OFDMA transmissions
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

In case that there are OBSS that do not know how to properly
interpret 26-tone RU OFDMA transmissions, instruct the FW not
to use such transmissions.

The check is currently only performed upon association.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |  4 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 54 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 3 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
index 85c5e367cbf1..73fb0030c496 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac.h
@@ -500,6 +500,9 @@ struct iwl_he_pkt_ext {
  *	enabled AGG, i.e. both BACK and non-BACK frames in a single AGG
  * @STA_CTXT_HE_MU_EDCA_CW: indicates that there is an element of MU EDCA
  *	parameter set, i.e. the backoff counters for trig-based ACs
+ * @STA_CTXT_HE_RU_2MHZ_BLOCK: indicates that 26-tone RU OFDMA transmission are
+ *      not allowed (as there are OBSS that might classify such transmissions as
+ *      radar pulses).
  */
 enum iwl_he_sta_ctxt_flags {
 	STA_CTXT_HE_REF_BSSID_VALID		= BIT(4),
@@ -511,6 +514,7 @@ enum iwl_he_sta_ctxt_flags {
 	STA_CTXT_HE_CONST_TRIG_RND_ALLOC	= BIT(10),
 	STA_CTXT_HE_ACK_ENABLED			= BIT(11),
 	STA_CTXT_HE_MU_EDCA_CW			= BIT(12),
+	STA_CTXT_HE_RU_2MHZ_BLOCK		= BIT(14),
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index b74bd58f3f45..438a8b5b90c2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -2254,6 +2254,10 @@ static void iwl_mvm_cfg_he_sta(struct iwl_mvm *mvm,
 
 	flags = 0;
 
+	/* Block 26-tone RU OFDMA transmissions */
+	if (mvmvif->he_ru_2mhz_block)
+		flags |= STA_CTXT_HE_RU_2MHZ_BLOCK;
+
 	/* HTC flags */
 	if (sta->he_cap.he_cap_elem.mac_cap_info[0] &
 	    IEEE80211_HE_MAC_CAP0_HTC_HE)
@@ -3205,6 +3209,51 @@ iwl_mvm_tdls_check_trigger(struct iwl_mvm *mvm,
 				peer_addr, action);
 }
 
+struct iwl_mvm_he_obss_narrow_bw_ru_data {
+	bool tolerated;
+};
+
+static void iwl_mvm_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
+						    struct cfg80211_bss *bss,
+						    void *_data)
+{
+	struct iwl_mvm_he_obss_narrow_bw_ru_data *data = _data;
+	const struct element *elem;
+
+	elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY, bss->ies->data,
+				  bss->ies->len);
+
+	if (!elem || elem->datalen < 10 ||
+	    !(elem->data[10] &
+	      WLAN_EXT_CAPA10_OBSS_NARROW_BW_RU_TOLERANCE_SUPPORT)) {
+		data->tolerated = false;
+	}
+}
+
+static void iwl_mvm_check_he_obss_narrow_bw_ru(struct ieee80211_hw *hw,
+					       struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_he_obss_narrow_bw_ru_data iter_data = {
+		.tolerated = true,
+	};
+
+	if (!(vif->bss_conf.chandef.chan->flags & IEEE80211_CHAN_RADAR)) {
+		mvmvif->he_ru_2mhz_block = false;
+		return;
+	}
+
+	cfg80211_bss_iter(hw->wiphy, &vif->bss_conf.chandef,
+			  iwl_mvm_check_he_obss_narrow_bw_ru_iter,
+			  &iter_data);
+
+	/*
+	 * If there is at least one AP on radar channel that cannot
+	 * tolerate 26-tone RU UL OFDMA transmissions using HE TB PPDU.
+	 */
+	mvmvif->he_ru_2mhz_block = !iter_data.tolerated;
+}
+
 static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
@@ -3306,6 +3355,11 @@ static int iwl_mvm_mac_sta_state(struct ieee80211_hw *hw,
 				iwl_mvm_cfg_he_sta(mvm, vif, mvm_sta->sta_id);
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
 			vif->bss_conf.he_support = sta->he_cap.has_he;
+
+			mvmvif->he_ru_2mhz_block = false;
+			if (sta->he_cap.has_he)
+				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif);
+
 			iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 		}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index a263cc629d75..a14701c8933b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -504,6 +504,9 @@ struct iwl_mvm_vif {
 
 	/* we can only have 2 GTK + 2 IGTK active at a time */
 	struct ieee80211_key_conf *ap_early_keys[4];
+
+	/* 26-tone RU OFDMA transmissions should be blocked */
+	bool he_ru_2mhz_block;
 };
 
 static inline struct iwl_mvm_vif *
-- 
2.23.0.rc1

