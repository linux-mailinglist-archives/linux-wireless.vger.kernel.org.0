Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9BCD510A
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 18:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbfJLQax (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 12:30:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48834 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbfJLQaw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 12:30:52 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJKGy-00062r-Hu; Sat, 12 Oct 2019 19:29:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 19:29:24 +0300
Message-Id: <20191012192536.4b61ed866f94.I38188bc18da1615342d4e12a4a485b7c4e18b268@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012162924.19848-1-luca@coelho.fi>
References: <20191012162924.19848-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 13/13] iwlwifi: rx: use new api to get band from rx mpdu
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

The FW introduce new API to get the band from the rx mpdu,
use this new API.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  5 ++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 23 +++++++++++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index a93449db7bb2..88bc7733065f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -260,6 +260,11 @@ enum iwl_rx_mpdu_amsdu_info {
 	IWL_RX_MPDU_AMSDU_LAST_SUBFRAME		= 0x80,
 };
 
+#define RX_MPDU_BAND_POS 6
+#define RX_MPDU_BAND_MASK 0xC0
+#define BAND_IN_RX_STATUS(_val) \
+	(((_val) & RX_MPDU_BAND_MASK) >> RX_MPDU_BAND_POS)
+
 enum iwl_rx_l3_proto_values {
 	IWL_RX_L3_TYPE_NONE,
 	IWL_RX_L3_TYPE_IPV4,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 07628566cb4a..6de20e76b63c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -322,6 +322,8 @@ enum iwl_ucode_tlv_api {
 	IWL_UCODE_TLV_API_SAR_TABLE_VER         = (__force iwl_ucode_tlv_api_t)55,
 	IWL_UCODE_TLV_API_ADWELL_HB_DEF_N_AP	= (__force iwl_ucode_tlv_api_t)57,
 	IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER	= (__force iwl_ucode_tlv_api_t)58,
+	IWL_UCODE_TLV_API_BAND_IN_RX_DATA	= (__force iwl_ucode_tlv_api_t)59,
+
 
 	NUM_IWL_UCODE_TLV_API
 #ifdef __CHECKER__
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d9c437682a5a..a25712cce4ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1409,6 +1409,12 @@ static inline bool iwl_mvm_is_scan_ext_chan_supported(struct iwl_mvm *mvm)
 			  IWL_UCODE_TLV_API_SCAN_EXT_CHAN_VER);
 }
 
+static inline bool iwl_mvm_is_band_in_rx_supported(struct iwl_mvm *mvm)
+{
+	return fw_has_api(&mvm->fw->ucode_capa,
+			   IWL_UCODE_TLV_API_BAND_IN_RX_DATA);
+}
+
 static inline bool iwl_mvm_has_new_rx_stats_api(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 77b03b757193..b488cd702058 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1542,6 +1542,19 @@ static void iwl_mvm_decode_lsig(struct sk_buff *skb,
 	}
 }
 
+static inline u8 iwl_mvm_nl80211_band_from_rx_msdu(u8 phy_band)
+{
+	switch (phy_band) {
+	case PHY_BAND_24:
+		return NL80211_BAND_2GHZ;
+	case PHY_BAND_5:
+		return NL80211_BAND_5GHZ;
+	default:
+		WARN_ONCE(1, "Unsupported phy band (%u)\n", phy_band);
+		return NL80211_BAND_5GHZ;
+	}
+}
+
 void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 			struct iwl_rx_cmd_buffer *rxb, int queue)
 {
@@ -1678,8 +1691,14 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 	}
 
 	rx_status->device_timestamp = gp2_on_air_rise;
-	rx_status->band = channel > 14 ? NL80211_BAND_5GHZ :
-		NL80211_BAND_2GHZ;
+	if (iwl_mvm_is_band_in_rx_supported(mvm)) {
+		u8 band = BAND_IN_RX_STATUS(desc->mac_phy_idx);
+
+		rx_status->band = iwl_mvm_nl80211_band_from_rx_msdu(band);
+	} else {
+		rx_status->band = channel > 14 ? NL80211_BAND_5GHZ :
+			NL80211_BAND_2GHZ;
+	}
 	rx_status->freq = ieee80211_channel_to_frequency(channel,
 							 rx_status->band);
 	iwl_mvm_get_signal_strength(mvm, rx_status, rate_n_flags, energy_a,
-- 
2.23.0

