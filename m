Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE00359B0D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 12:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhDIKHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 06:07:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44308 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234541AbhDIKGv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 06:06:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncz-000ELR-Pc; Fri, 09 Apr 2021 12:40:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:24 +0300
Message-Id: <iwlwifi.20210409123755.9e6ff1af1181.If6868bc6902ccd9a95c74c78f716c4b41473ef14@changeid>
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
Subject: [PATCH 11/15] wireless: fix spelling of A-MSDU in HE capabilities
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In the HE capabilities, spell A-MSDU correctly, not "A-MDSU".

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 +-
 drivers/net/wireless/mac80211_hwsim.c              | 8 ++++----
 include/linux/ieee80211.h                          | 2 +-
 net/mac80211/debugfs_sta.c                         | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d2058cdcb0d8..c7ea5b35f9f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -552,7 +552,7 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_2,
 				.mac_cap_info[4] =
-					IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU |
+					IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU |
 					IEEE80211_HE_MAC_CAP4_MULTI_TID_AGG_TX_QOS_B39,
 				.mac_cap_info[5] =
 					IEEE80211_HE_MAC_CAP5_MULTI_TID_AGG_TX_QOS_B40 |
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 3039baa43f4c..f85a879d738b 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -2796,7 +2796,7 @@ static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
-				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -2840,7 +2840,7 @@ static const struct ieee80211_sband_iftype_data he_capa_2ghz[] = {
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
-				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
 				.phy_cap_info[1] =
 					IEEE80211_HE_PHY_CAP1_PREAMBLE_PUNC_RX_MASK |
 					IEEE80211_HE_PHY_CAP1_DEVICE_CLASS_A |
@@ -2886,7 +2886,7 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
-				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
 				.phy_cap_info[0] =
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
@@ -2934,7 +2934,7 @@ static const struct ieee80211_sband_iftype_data he_capa_5ghz[] = {
 				.mac_cap_info[3] =
 					IEEE80211_HE_MAC_CAP3_OMI_CONTROL |
 					IEEE80211_HE_MAC_CAP3_MAX_AMPDU_LEN_EXP_EXT_3,
-				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU,
+				.mac_cap_info[4] = IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU,
 				.phy_cap_info[0] =
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G |
 					IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G |
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 9aa6a6c02100..63252fba3f90 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2021,7 +2021,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_MAC_CAP4_PSR_RESP				0x08
 #define IEEE80211_HE_MAC_CAP4_NDP_FB_REP			0x10
 #define IEEE80211_HE_MAC_CAP4_OPS				0x20
-#define IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU			0x40
+#define IEEE80211_HE_MAC_CAP4_AMSDU_IN_AMPDU			0x40
 /* Multi TID agg TX is split between byte #4 and #5
  * The value is a combination of B39,B40,B41
  */
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 25b3d4822aed..936c9dfa86c8 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -735,7 +735,7 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	PFLAG(MAC, 4, PSR_RESP, "PSR-RESP");
 	PFLAG(MAC, 4, NDP_FB_REP, "NDP-FB-REP");
 	PFLAG(MAC, 4, OPS, "OPS");
-	PFLAG(MAC, 4, AMDSU_IN_AMPDU, "AMSDU-IN-AMPDU");
+	PFLAG(MAC, 4, AMSDU_IN_AMPDU, "AMSDU-IN-AMPDU");
 
 	PRINT("MULTI-TID-AGG-TX-QOS-%d", ((cap[5] << 1) | (cap[4] >> 7)) & 0x7);
 
-- 
2.31.0

