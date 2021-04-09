Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35F46359977
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhDIJkv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44260 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231638AbhDIJku (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncw-000ELR-Jj; Fri, 09 Apr 2021 12:40:36 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:20 +0300
Message-Id: <iwlwifi.20210409123755.c2a257d3e2df.I3455245d388c52c61dace7e7958dbed7e807cfb6@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 07/15] wireless: align HE capabilities A-MPDU Length Exponent Extension
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The A-MPDU length exponent extension is defined differently in
802.11ax D6.1, align with that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c   |  4 ++--
 drivers/net/wireless/mac80211_hwsim.c            |  8 ++++----
 include/linux/ieee80211.h                        | 10 ++++------
 net/mac80211/debugfs_sta.c                       | 16 ++++++++--------
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 632f20d4027d..d2058cdcb0d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -550,7 +550,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_MAC_CAP2_32BIT_BA_BITMAP,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
 				.mac_cap_info[4] =
 					IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU |
 					IEEE80211_HE_MAC_CAP4_MULTI_TID_AGG_TX_QOS_B39,
@@ -636,7 +636,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_MAC_CAP2_BSR,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
 				.mac_cap_info[4] =
 					IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
 				.mac_cap_info[5] =
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index fa7d4c20dc13..3039baa43f4c 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2795,7 +2795,7 @@ static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP2_ACK_EN,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
@@ -2839,7 +2839,7 @@ static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
 					IEEE80211_HE_MAC_CAP2_ACK_EN,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
@@ -2885,7 +2885,7 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 					IEEE80211_HE_MAC_CAP2_ACK_EN,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
 				.phy_cap_info[0] =
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
@@ -2933,7 +2933,7 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 					IEEE80211_HE_MAC_CAP2_ACK_EN,
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
-					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2,
+					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
 				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
 				.phy_cap_info[0] =
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 0c15fb64e7c2..9aa6a6c02100 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2006,17 +2006,15 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
  * A-MDPU Length Exponent field in the HT capabilities, VHT capabilities and the
  * same field in the HE capabilities.
  */
-#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_USE_VHT	0x00
-#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_1		0x08
-#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2		0x10
-#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_RESERVED	0x18
+#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_0		0x00
+#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_1		0x08
+#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2		0x10
+#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3		0x18
 #define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK		0x18
 #define IEEE80211_HE_MAC_CAP3_AMSDU_FRAG			0x20
 #define IEEE80211_HE_MAC_CAP3_FLEX_TWT_SCHED			0x40
 #define IEEE80211_HE_MAC_CAP3_RX_CTRL_FRAME_TO_MULTIBSS		0x80
 
-#define IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_SHIFT		3
-
 #define IEEE80211_HE_MAC_CAP4_BSRP_BQRP_A_MPDU_AGG		0x01
 #define IEEE80211_HE_MAC_CAP4_QTP				0x02
 #define IEEE80211_HE_MAC_CAP4_BQR				0x04
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index d350224d45e8..25b3d4822aed 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -711,17 +711,17 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	PFLAG(MAC, 3, OFDMA_RA, "OFDMA-RA");
 
 	switch (cap[3] & IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_MASK) {
-	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_USE_VHT:
-		PRINT("MAX-AMPDU-LEN-EXP-USE-VHT");
+	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_0:
+		PRINT("MAX-AMPDU-LEN-EXP-USE-EXT-0");
 		break;
-	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_1:
-		PRINT("MAX-AMPDU-LEN-EXP-VHT-1");
+	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_1:
+		PRINT("MAX-AMPDU-LEN-EXP-VHT-EXT-1");
 		break;
-	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_VHT_2:
-		PRINT("MAX-AMPDU-LEN-EXP-VHT-2");
+	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2:
+		PRINT("MAX-AMPDU-LEN-EXP-VHT-EXT-2");
 		break;
-	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_RESERVED:
-		PRINT("MAX-AMPDU-LEN-EXP-RESERVED");
+	case IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3:
+		PRINT("MAX-AMPDU-LEN-EXP-VHT-EXT-3");
 		break;
 	}
 
-- 
2.31.0

