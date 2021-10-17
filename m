Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA6843074A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Oct 2021 10:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245100AbhJQIqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Oct 2021 04:46:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53580 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245101AbhJQIqH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Oct 2021 04:46:07 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mc1lr-000YRM-Kd; Sun, 17 Oct 2021 11:43:56 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 17 Oct 2021 11:43:44 +0300
Message-Id: <iwlwifi.20211017113927.5e39106ec75b.I4281edc844f734bf9591396a5cc8009ad37ccda8@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211017084348.401570-1-luca@coelho.fi>
References: <20211017084348.401570-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/10] iwlwifi: mvm: Remove antenna c references
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Since antenna c is not in use and won't be relevant after the new rate &
flags, remove all it's references

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/location.h  |  2 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  5 +---
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  3 +--
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  3 +--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 -
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  7 ++---
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  4 ---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 26 ++++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 13 +++-------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  1 +
 12 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 294e733ecbc9..5f27829f8996 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -206,7 +206,7 @@ enum iwl_tof_responder_cfg_flags {
 	IWL_TOF_RESPONDER_FLAGS_SPECIFIC_CALIB_MODE = BIT(8),
 	IWL_TOF_RESPONDER_FLAGS_FAST_ALGO_SUPPORT = BIT(9),
 	IWL_TOF_RESPONDER_FLAGS_RETRY_ON_ALGO_FAIL = BIT(10),
-	IWL_TOF_RESPONDER_FLAGS_FTM_TX_ANT = RATE_MCS_ANT_ABC_MSK,
+	IWL_TOF_RESPONDER_FLAGS_FTM_TX_ANT = RATE_MCS_ANT_AB_MSK,
 	IWL_TOF_RESPONDER_FLAGS_NDP_SUPPORT = BIT(24),
 	IWL_TOF_RESPONDER_FLAGS_LMR_FEEDBACK = BIT(25),
 	IWL_TOF_RESPONDER_FLAGS_SESSION_ID = BIT(27),
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index fc2fa49e9825..810dceb649c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -372,12 +372,9 @@ enum {
 #define RATE_MCS_ANT_POS		14
 #define RATE_MCS_ANT_A_MSK		(1 << RATE_MCS_ANT_POS)
 #define RATE_MCS_ANT_B_MSK		(2 << RATE_MCS_ANT_POS)
-#define RATE_MCS_ANT_C_MSK		(4 << RATE_MCS_ANT_POS)
 #define RATE_MCS_ANT_AB_MSK		(RATE_MCS_ANT_A_MSK | \
 					 RATE_MCS_ANT_B_MSK)
-#define RATE_MCS_ANT_ABC_MSK		(RATE_MCS_ANT_AB_MSK | \
-					 RATE_MCS_ANT_C_MSK)
-#define RATE_MCS_ANT_MSK		RATE_MCS_ANT_ABC_MSK
+#define RATE_MCS_ANT_MSK		RATE_MCS_ANT_AB_MSK
 
 /* Bit 17: (0) SS, (1) SS*2 */
 #define RATE_MCS_STBC_POS		17
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
index 3f13b572915a..88d600b376dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -13,7 +13,6 @@
 #define IWL_RX_INFO_ENERGY_ANT_ABC_IDX 1
 #define IWL_RX_INFO_ENERGY_ANT_A_MSK 0x000000ff
 #define IWL_RX_INFO_ENERGY_ANT_B_MSK 0x0000ff00
-#define IWL_RX_INFO_ENERGY_ANT_C_MSK 0x00ff0000
 #define IWL_RX_INFO_ENERGY_ANT_A_POS 0
 #define IWL_RX_INFO_ENERGY_ANT_B_POS 8
 #define IWL_RX_INFO_ENERGY_ANT_C_POS 16
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 24e4a82a55da..c0caf9dca545 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_tx_h__
@@ -759,7 +759,6 @@ enum iwl_mac_beacon_flags {
 	IWL_MAC_BEACON_CCK	= BIT(8),
 	IWL_MAC_BEACON_ANT_A	= BIT(9),
 	IWL_MAC_BEACON_ANT_B	= BIT(10),
-	IWL_MAC_BEACON_ANT_C	= BIT(11),
 	IWL_MAC_BEACON_FILS	= BIT(12),
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 7eb534df5331..03b71c36f841 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -95,7 +95,6 @@ enum iwl_nvm_type {
 #define	ANT_AC		(ANT_A | ANT_C)
 #define ANT_BC		(ANT_B | ANT_C)
 #define ANT_ABC		(ANT_A | ANT_B | ANT_C)
-#define MAX_ANT_NUM 3
 
 
 static inline u8 num_of_ant(u8 mask)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 5dc39fbb74d6..8c2251178f97 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -395,10 +395,9 @@ static ssize_t iwl_dbgfs_rs_data_read(struct file *file, char __user *user_buf,
 			  "A-MPDU size limit %d\n",
 			  lq_sta->pers.dbg_agg_frame_count_lim);
 	desc += scnprintf(buff + desc, bufsz - desc,
-			  "valid_tx_ant %s%s%s\n",
+			  "valid_tx_ant %s%s\n",
 		(iwl_mvm_get_valid_tx_ant(mvm) & ANT_A) ? "ANT_A," : "",
-		(iwl_mvm_get_valid_tx_ant(mvm) & ANT_B) ? "ANT_B," : "",
-		(iwl_mvm_get_valid_tx_ant(mvm) & ANT_C) ? "ANT_C" : "");
+		(iwl_mvm_get_valid_tx_ant(mvm) & ANT_B) ? "ANT_B," : "");
 	desc += scnprintf(buff + desc, bufsz - desc,
 			  "last tx rate=0x%X ",
 			  lq_sta->last_rate_n_flags);
@@ -1060,8 +1059,6 @@ iwl_dbgfs_scan_ant_rxchain_read(struct file *file,
 		pos += scnprintf(buf + pos, bufsz - pos, "A");
 	if (mvm->scan_rx_ant & ANT_B)
 		pos += scnprintf(buf + pos, bufsz - pos, "B");
-	if (mvm->scan_rx_ant & ANT_C)
-		pos += scnprintf(buf + pos, bufsz - pos, "C");
 	pos += scnprintf(buf + pos, bufsz - pos, " (%hhx)\n", mvm->scan_rx_ant);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
index 2d58cb969918..5b224a19bb32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c
@@ -32,10 +32,6 @@ static u8 rs_fw_set_active_chains(u8 chains)
 		fw_chains |= IWL_TLC_MNG_CHAIN_A_MSK;
 	if (chains & ANT_B)
 		fw_chains |= IWL_TLC_MNG_CHAIN_B_MSK;
-	if (chains & ANT_C)
-		WARN(false,
-		     "tlc offload doesn't support antenna C. chains: 0x%x\n",
-		     chains);
 
 	return fw_chains;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index b97708cb869d..b75505061e64 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -485,13 +485,9 @@ static const char *rs_pretty_ant(u8 ant)
 		[ANT_A]    = "A",
 		[ANT_B]    = "B",
 		[ANT_AB]   = "AB",
-		[ANT_C]    = "C",
-		[ANT_AC]   = "AC",
-		[ANT_BC]   = "BC",
-		[ANT_ABC]  = "ABC",
 	};
 
-	if (ant > ANT_ABC)
+	if (ant > ANT_AB)
 		return "UNKNOWN";
 
 	return ant_name[ant];
@@ -654,8 +650,7 @@ static void rs_tl_turn_on_agg(struct iwl_mvm *mvm, struct iwl_mvm_sta *mvmsta,
 static inline int get_num_of_ant_from_rate(u32 rate_n_flags)
 {
 	return !!(rate_n_flags & RATE_MCS_ANT_A_MSK) +
-	       !!(rate_n_flags & RATE_MCS_ANT_B_MSK) +
-	       !!(rate_n_flags & RATE_MCS_ANT_C_MSK);
+	       !!(rate_n_flags & RATE_MCS_ANT_B_MSK);
 }
 
 /*
@@ -820,7 +815,7 @@ static u32 ucode_rate_from_rs_rate(struct iwl_mvm *mvm,
 	int index = rate->index;
 
 	ucode_rate |= ((rate->ant << RATE_MCS_ANT_POS) &
-			 RATE_MCS_ANT_ABC_MSK);
+			 RATE_MCS_ANT_AB_MSK);
 
 	if (is_legacy(rate)) {
 		ucode_rate |= iwl_rates[index].plcp;
@@ -885,7 +880,7 @@ static int rs_rate_from_ucode_rate(const u32 ucode_rate,
 				   enum nl80211_band band,
 				   struct rs_rate *rate)
 {
-	u32 ant_msk = ucode_rate & RATE_MCS_ANT_ABC_MSK;
+	u32 ant_msk = ucode_rate & RATE_MCS_ANT_AB_MSK;
 	u8 num_of_ant = get_num_of_ant_from_rate(ucode_rate);
 	u8 nss;
 
@@ -981,9 +976,6 @@ static int rs_toggle_antenna(u32 valid_ant, struct rs_rate *rate)
 {
 	u8 new_ant_type;
 
-	if (!rate->ant || WARN_ON_ONCE(rate->ant & ANT_C))
-		return 0;
-
 	if (!rs_is_valid_ant(valid_ant, rate->ant))
 		return 0;
 
@@ -2652,7 +2644,6 @@ void rs_update_last_rssi(struct iwl_mvm *mvm,
 	lq_sta->pers.chains = rx_status->chains;
 	lq_sta->pers.chain_signal[0] = rx_status->chain_signal[0];
 	lq_sta->pers.chain_signal[1] = rx_status->chain_signal[1];
-	lq_sta->pers.chain_signal[2] = rx_status->chain_signal[2];
 	lq_sta->pers.last_rssi = S8_MIN;
 
 	for (i = 0; i < ARRAY_SIZE(lq_sta->pers.chain_signal); i++) {
@@ -3323,7 +3314,7 @@ static void rs_build_rates_table_from_fixed(struct iwl_mvm *mvm,
 	int i;
 	int num_rates = ARRAY_SIZE(lq_cmd->rs_table);
 	__le32 ucode_rate_le32 = cpu_to_le32(ucode_rate);
-	u8 ant = (ucode_rate & RATE_MCS_ANT_ABC_MSK) >> RATE_MCS_ANT_POS;
+	u8 ant = (ucode_rate & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
 
 	for (i = 0; i < num_rates; i++)
 		lq_cmd->rs_table[i] = ucode_rate_le32;
@@ -3693,7 +3684,7 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 
 	char *type, *bw;
 	u8 mcs = 0, nss = 0;
-	u8 ant = (rate & RATE_MCS_ANT_ABC_MSK) >> RATE_MCS_ANT_POS;
+	u8 ant = (rate & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
 
 	if (!(rate & RATE_MCS_HT_MSK) &&
 	    !(rate & RATE_MCS_VHT_MSK) &&
@@ -3830,10 +3821,9 @@ static ssize_t rs_sta_dbgfs_scale_table_read(struct file *file,
 			  lq_sta->active_legacy_rate);
 	desc += scnprintf(buff + desc, bufsz - desc, "fixed rate 0x%X\n",
 			  lq_sta->pers.dbg_fixed_rate);
-	desc += scnprintf(buff + desc, bufsz - desc, "valid_tx_ant %s%s%s\n",
+	desc += scnprintf(buff + desc, bufsz - desc, "valid_tx_ant %s%s\n",
 	    (iwl_mvm_get_valid_tx_ant(mvm) & ANT_A) ? "ANT_A," : "",
-	    (iwl_mvm_get_valid_tx_ant(mvm) & ANT_B) ? "ANT_B," : "",
-	    (iwl_mvm_get_valid_tx_ant(mvm) & ANT_C) ? "ANT_C" : "");
+	    (iwl_mvm_get_valid_tx_ant(mvm) & ANT_B) ? "ANT_B," : "");
 	desc += scnprintf(buff + desc, bufsz - desc, "lq type %s\n",
 			  (is_legacy(rate)) ? "legacy" :
 			  is_vht(rate) ? "VHT" : "HT");
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 8ef5399ad9be..87b0600ed48a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -103,7 +103,7 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 					struct iwl_rx_phy_info *phy_info,
 					struct ieee80211_rx_status *rx_status)
 {
-	int energy_a, energy_b, energy_c, max_energy;
+	int energy_a, energy_b, max_energy;
 	u32 val;
 
 	val =
@@ -114,14 +114,10 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 	energy_b = (val & IWL_RX_INFO_ENERGY_ANT_B_MSK) >>
 						IWL_RX_INFO_ENERGY_ANT_B_POS;
 	energy_b = energy_b ? -energy_b : S8_MIN;
-	energy_c = (val & IWL_RX_INFO_ENERGY_ANT_C_MSK) >>
-						IWL_RX_INFO_ENERGY_ANT_C_POS;
-	energy_c = energy_c ? -energy_c : S8_MIN;
 	max_energy = max(energy_a, energy_b);
-	max_energy = max(max_energy, energy_c);
 
-	IWL_DEBUG_STATS(mvm, "energy In A %d B %d C %d , and max %d\n",
-			energy_a, energy_b, energy_c, max_energy);
+	IWL_DEBUG_STATS(mvm, "energy In A %d B %d  , and max %d\n",
+			energy_a, energy_b, max_energy);
 
 	rx_status->signal = max_energy;
 	rx_status->chains = (le16_to_cpu(phy_info->phy_flags) &
@@ -129,7 +125,6 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 					>> RX_RES_PHY_FLAGS_ANTENNA_POS;
 	rx_status->chain_signal[0] = energy_a;
 	rx_status->chain_signal[1] = energy_b;
-	rx_status->chain_signal[2] = energy_c;
 }
 
 /*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index c12f303cf652..ba65bfb2b43e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -269,7 +269,6 @@ static void iwl_mvm_get_signal_strength(struct iwl_mvm *mvm,
 		(rate_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS;
 	rx_status->chain_signal[0] = energy_a;
 	rx_status->chain_signal[1] = energy_b;
-	rx_status->chain_signal[2] = S8_MIN;
 }
 
 static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 0a13c2bda2ee..6151350fa66c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1329,7 +1329,7 @@ static void iwl_mvm_hwrate_to_tx_status(u32 rate_n_flags,
 	struct ieee80211_tx_rate *r = &info->status.rates[0];
 
 	info->status.antenna =
-		((rate_n_flags & RATE_MCS_ANT_ABC_MSK) >> RATE_MCS_ANT_POS);
+		((rate_n_flags & RATE_MCS_ANT_AB_MSK) >> RATE_MCS_ANT_POS);
 	iwl_mvm_hwrate_to_tx_rate(rate_n_flags, info->band, r);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index ec8a223f90e8..704fc71ac845 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -217,6 +217,7 @@ u8 first_antenna(u8 mask)
 	return BIT(ffs(mask) - 1);
 }
 
+#define MAX_ANT_NUM 2
 /*
  * Toggles between TX antennas to send the probe request on.
  * Receives the bitmask of valid TX antennas and the *index* used
-- 
2.33.0

