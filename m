Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E88359974
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 11:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhDIJks (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 05:40:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44242 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231638AbhDIJkr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 05:40:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lUncu-000ELR-Fa; Fri, 09 Apr 2021 12:40:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri,  9 Apr 2021 12:40:17 +0300
Message-Id: <iwlwifi.20210409123755.b1e5fbab0d8c.I3eb6076cb0714ec6aec6b8f9dee613ce4a05d825@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210409094028.356611-1-luca@coelho.fi>
References: <20210409094028.356611-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.5-pre1
Subject: [PATCH 04/15] wireless: align some HE capabilities with the spec
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Some names were changed, align that with the spec as of
802.11ax-D6.1.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  6 +++---
 include/linux/ieee80211.h                     | 14 +++++++-------
 net/mac80211/debugfs_sta.c                    | 19 ++++++++++---------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index af684f80b0cc..632f20d4027d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -583,11 +583,11 @@ static const struct ieee80211_sband_iftype_data iwl_he_capa[] = {
 					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_2 |
 					IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_ABOVE_80MHZ_2,
 				.phy_cap_info[6] =
-					IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMER_FB |
-					IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMER_FB |
+					IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+					IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB |
 					IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT,
 				.phy_cap_info[7] =
-					IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR |
+					IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP |
 					IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI |
 					IEEE80211_HE_PHY_CAP7_MAX_NC_1,
 				.phy_cap_info[8] =
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 72ff75fb1971..0c15fb64e7c2 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2020,7 +2020,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_MAC_CAP4_BSRP_BQRP_A_MPDU_AGG		0x01
 #define IEEE80211_HE_MAC_CAP4_QTP				0x02
 #define IEEE80211_HE_MAC_CAP4_BQR				0x04
-#define IEEE80211_HE_MAC_CAP4_SRP_RESP				0x08
+#define IEEE80211_HE_MAC_CAP4_PSR_RESP				0x08
 #define IEEE80211_HE_MAC_CAP4_NDP_FB_REP			0x10
 #define IEEE80211_HE_MAC_CAP4_OPS				0x20
 #define IEEE80211_HE_MAC_CAP4_AMDSU_IN_AMPDU			0x40
@@ -2031,7 +2031,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 
 #define IEEE80211_HE_MAC_CAP5_MULTI_TID_AGG_TX_QOS_B40		0x01
 #define IEEE80211_HE_MAC_CAP5_MULTI_TID_AGG_TX_QOS_B41		0x02
-#define IEEE80211_HE_MAC_CAP5_SUBCHAN_SELECVITE_TRANSMISSION	0x04
+#define IEEE80211_HE_MAC_CAP5_SUBCHAN_SELECTIVE_TRANSMISSION	0x04
 #define IEEE80211_HE_MAC_CAP5_UL_2x996_TONE_RU			0x08
 #define IEEE80211_HE_MAC_CAP5_OM_CTRL_UL_MU_DATA_DIS_RX		0x10
 #define IEEE80211_HE_MAC_CAP5_HE_DYNAMIC_SM_PS			0x20
@@ -2089,7 +2089,7 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 #define IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK			0x18
 #define IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1				0x00
 #define IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_2				0x20
-#define IEEE80211_HE_PHY_CAP3_RX_HE_MU_PPDU_FROM_NON_AP_STA		0x40
+#define IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU		0x40
 #define IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER				0x80
 
 #define IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE				0x01
@@ -2136,15 +2136,15 @@ int ieee80211_get_vht_max_nss(struct ieee80211_vht_cap *cap,
 
 #define IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU			0x01
 #define IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU			0x02
-#define IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMER_FB			0x04
-#define IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMER_FB			0x08
+#define IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB			0x04
+#define IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB		0x08
 #define IEEE80211_HE_PHY_CAP6_TRIG_CQI_FB				0x10
 #define IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE			0x20
 #define IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO		0x40
 #define IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT			0x80
 
-#define IEEE80211_HE_PHY_CAP7_SRP_BASED_SR				0x01
-#define IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_AR			0x02
+#define IEEE80211_HE_PHY_CAP7_PSR_BASED_SR				0x01
+#define IEEE80211_HE_PHY_CAP7_POWER_BOOST_FACTOR_SUPP			0x02
 #define IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI		0x04
 #define IEEE80211_HE_PHY_CAP7_MAX_NC_1					0x08
 #define IEEE80211_HE_PHY_CAP7_MAX_NC_2					0x10
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 5a27c61a7b38..d350224d45e8 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -732,15 +732,15 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 	PFLAG(MAC, 4, BSRP_BQRP_A_MPDU_AGG, "BSRP-BQRP-A-MPDU-AGG");
 	PFLAG(MAC, 4, QTP, "QTP");
 	PFLAG(MAC, 4, BQR, "BQR");
-	PFLAG(MAC, 4, SRP_RESP, "SRP-RESP");
+	PFLAG(MAC, 4, PSR_RESP, "PSR-RESP");
 	PFLAG(MAC, 4, NDP_FB_REP, "NDP-FB-REP");
 	PFLAG(MAC, 4, OPS, "OPS");
 	PFLAG(MAC, 4, AMDSU_IN_AMPDU, "AMSDU-IN-AMPDU");
 
 	PRINT("MULTI-TID-AGG-TX-QOS-%d", ((cap[5] << 1) | (cap[4] >> 7)) & 0x7);
 
-	PFLAG(MAC, 5, SUBCHAN_SELECVITE_TRANSMISSION,
-	      "SUBCHAN-SELECVITE-TRANSMISSION");
+	PFLAG(MAC, 5, SUBCHAN_SELECTIVE_TRANSMISSION,
+	      "SUBCHAN-SELECTIVE-TRANSMISSION");
 	PFLAG(MAC, 5, UL_2x996_TONE_RU, "UL-2x996-TONE-RU");
 	PFLAG(MAC, 5, OM_CTRL_UL_MU_DATA_DIS_RX, "OM-CTRL-UL-MU-DATA-DIS-RX");
 	PFLAG(MAC, 5, HE_DYNAMIC_SM_PS, "HE-DYNAMIC-SM-PS");
@@ -832,8 +832,8 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 
 	PFLAG(PHY, 3, DCM_MAX_RX_NSS_1, "DCM-MAX-RX-NSS-1");
 	PFLAG(PHY, 3, DCM_MAX_RX_NSS_2, "DCM-MAX-RX-NSS-2");
-	PFLAG(PHY, 3, RX_HE_MU_PPDU_FROM_NON_AP_STA,
-	      "RX-HE-MU-PPDU-FROM-NON-AP-STA");
+	PFLAG(PHY, 3, RX_PARTIAL_BW_SU_IN_20MHZ_MU,
+	      "RX-PARTIAL-BW-SU-IN-20MHZ-MU");
 	PFLAG(PHY, 3, SU_BEAMFORMER, "SU-BEAMFORMER");
 
 	PFLAG(PHY, 4, SU_BEAMFORMEE, "SU-BEAMFORMEE");
@@ -853,16 +853,17 @@ static ssize_t sta_he_capa_read(struct file *file, char __user *userbuf,
 
 	PFLAG(PHY, 6, CODEBOOK_SIZE_42_SU, "CODEBOOK-SIZE-42-SU");
 	PFLAG(PHY, 6, CODEBOOK_SIZE_75_MU, "CODEBOOK-SIZE-75-MU");
-	PFLAG(PHY, 6, TRIG_SU_BEAMFORMER_FB, "TRIG-SU-BEAMFORMER-FB");
-	PFLAG(PHY, 6, TRIG_MU_BEAMFORMER_FB, "TRIG-MU-BEAMFORMER-FB");
+	PFLAG(PHY, 6, TRIG_SU_BEAMFORMING_FB, "TRIG-SU-BEAMFORMING-FB");
+	PFLAG(PHY, 6, TRIG_MU_BEAMFORMING_PARTIAL_BW_FB,
+	      "MU-BEAMFORMING-PARTIAL-BW-FB");
 	PFLAG(PHY, 6, TRIG_CQI_FB, "TRIG-CQI-FB");
 	PFLAG(PHY, 6, PARTIAL_BW_EXT_RANGE, "PARTIAL-BW-EXT-RANGE");
 	PFLAG(PHY, 6, PARTIAL_BANDWIDTH_DL_MUMIMO,
 	      "PARTIAL-BANDWIDTH-DL-MUMIMO");
 	PFLAG(PHY, 6, PPE_THRESHOLD_PRESENT, "PPE-THRESHOLD-PRESENT");
 
-	PFLAG(PHY, 7, SRP_BASED_SR, "SRP-BASED-SR");
-	PFLAG(PHY, 7, POWER_BOOST_FACTOR_AR, "POWER-BOOST-FACTOR-AR");
+	PFLAG(PHY, 7, PSR_BASED_SR, "PSR-BASED-SR");
+	PFLAG(PHY, 7, POWER_BOOST_FACTOR_SUPP, "POWER-BOOST-FACTOR-SUPP");
 	PFLAG(PHY, 7, HE_SU_MU_PPDU_4XLTF_AND_08_US_GI,
 	      "HE-SU-MU-PPDU-4XLTF-AND-08-US-GI");
 	PFLAG_RANGE(PHY, 7, MAX_NC, 0, 1, 1, "MAX-NC-%d");
-- 
2.31.0

