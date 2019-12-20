Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF95127B4B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 13:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLTMvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 07:51:40 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54072 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727341AbfLTMvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 07:51:40 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiHkm-0007lx-7b; Fri, 20 Dec 2019 14:51:37 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 14:51:19 +0200
Message-Id: <20191220125124.1315679-7-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220125124.1315679-1-luca@coelho.fi>
References: <20191220125124.1315679-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 06/11] iwlwifi: allocate more receive buffers for HE devices
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For HE-capable devices, we need to allocate more receive buffers as
there could be 256 frames aggregated into a single A-MPDU, and then
they might contain A-MSDUs as well. Until 22000 family, the devices
are able to put multiple frames into a single RB and the default RB
size is 4k, but starting from AX210 family this is no longer true.
On the other hand, those newer devices only use 2k receive buffers
(by default).

Modify the code and configuration to allocate an appropriate number
of RBs depending on the device capabilities:

 * 4096 for AX210 HE devices, which use 2k buffers by default,
 * 2048 for 22000 family devices which use 4k buffers by default,
 * 512 for existing 9000 family devices, which doesn't really
   change anything since that's the default before this patch,
 * 512 also for AX210/22000 family devices that don't do HE.

Theoretically, for devices lower than AX210, we wouldn't have to
allocate that many RBs if the RB size was manually increased, but
to support that the code got more complex, and it didn't really
seem necessary as that's a use case for monitor mode only, where
hopefully the wasted memory isn't really much of a concern.

Note that AX210 devices actually support bigger than 12-bit VID,
which is required here as we want to allocate 4096 buffers plus
some for quick recycling, so adjust the code for that as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 55 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 +
 .../wireless/intel/iwlwifi/iwl-context-info.h | 20 +++----
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |  5 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   | 11 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 13 +++++
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 34 ++++++++----
 10 files changed, 116 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 56dc335a788c..bd687e745dc9 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -236,10 +236,22 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 		},							\
 	}
 
+/*
+ * If the device doesn't support HE, no need to have that many buffers.
+ * 22000 devices can split multiple frames into a single RB, so fewer are
+ * needed; AX210 cannot (but use smaller RBs by default) - these sizes
+ * were picked according to 8 MSDUs inside 256 A-MSDUs in an A-MPDU, with
+ * additional overhead to account for processing time.
+ */
+#define IWL_NUM_RBDS_NON_HE		512
+#define IWL_NUM_RBDS_22000_HE		2048
+#define IWL_NUM_RBDS_AX210_HE		4096
+
 const struct iwl_cfg iwl22000_2ac_cfg_hr = {
 	.name = "Intel(R) Dual Band Wireless AC 22000",
 	.fw_name_pre = IWL_22000_HR_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb = {
@@ -247,12 +259,14 @@ const struct iwl_cfg iwl22000_2ac_cfg_hr_cdb = {
 	.fw_name_pre = IWL_22000_HR_CDB_FW_PRE,
 	IWL_DEVICE_22500,
 	.cdb = true,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl22000_2ac_cfg_jf = {
 	.name = "Intel(R) Dual Band Wireless AC 22000",
 	.fw_name_pre = IWL_22000_JF_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
@@ -266,6 +280,7 @@ const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.tx_with_siso_diversity = true,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
@@ -278,6 +293,7 @@ const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0 = {
@@ -290,6 +306,7 @@ const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax201_cfg_qu_c0_hr_b0 = {
@@ -302,6 +319,7 @@ const struct iwl_cfg iwl_ax201_cfg_qu_c0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
@@ -314,6 +332,7 @@ const struct iwl_cfg iwl_ax101_cfg_quz_hr = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
@@ -326,6 +345,7 @@ const struct iwl_cfg iwl_ax201_cfg_quz_hr = {
          * HT size; mac80211 would otherwise pick the HE max (256) by default.
          */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
@@ -338,6 +358,7 @@ const struct iwl_cfg iwl_ax1650s_cfg_quz_hr = {
          * HT size; mac80211 would otherwise pick the HE max (256) by default.
          */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
@@ -350,6 +371,7 @@ const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
          * HT size; mac80211 would otherwise pick the HE max (256) by default.
          */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl_ax200_cfg_cc = {
@@ -363,6 +385,7 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.trans.bisr_workaround = 1,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg killer1650x_2ax_cfg = {
@@ -376,6 +399,7 @@ const struct iwl_cfg killer1650x_2ax_cfg = {
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.trans.bisr_workaround = 1,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg killer1650w_2ax_cfg = {
@@ -389,6 +413,7 @@ const struct iwl_cfg killer1650w_2ax_cfg = {
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.trans.bisr_workaround = 1,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 /*
@@ -400,48 +425,56 @@ const struct iwl_cfg iwl9461_2ac_cfg_qu_b0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9461",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9462_2ac_cfg_qu_b0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9462",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_cfg_qu_b0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9560",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_160_cfg_qu_b0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9560 160MHz",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9461_2ac_cfg_qu_c0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9461",
 	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9462_2ac_cfg_qu_c0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9462",
 	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_cfg_qu_c0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9560",
 	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_160_cfg_qu_c0_jf_b0 = {
 	.name = "Intel(R) Wireless-AC 9560 160MHz",
 	.fw_name_pre = IWL_QU_C_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_cfg_qnj_jf_b0 = {
@@ -454,6 +487,7 @@ const struct iwl_cfg iwl9560_2ac_cfg_qnj_jf_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc = {
@@ -468,6 +502,7 @@ const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.integrated = true,
 	.soc_latency = 5000,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc = {
@@ -482,6 +517,7 @@ const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.integrated = true,
 	.soc_latency = 5000,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc = {
@@ -496,6 +532,7 @@ const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.integrated = true,
 	.soc_latency = 5000,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc = {
@@ -510,6 +547,7 @@ const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.integrated = true,
 	.soc_latency = 5000,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc = {
@@ -524,6 +562,7 @@ const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.integrated = true,
 	.soc_latency = 5000,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc = {
@@ -538,18 +577,21 @@ const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 	.integrated = true,
 	.soc_latency = 5000,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg killer1550i_2ac_cfg_qu_b0_jf_b0 = {
 	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg killer1550s_2ac_cfg_qu_b0_jf_b0 = {
 	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
 	IWL_DEVICE_22500,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
@@ -562,6 +604,7 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
@@ -574,6 +617,7 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
@@ -586,6 +630,7 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
@@ -598,6 +643,7 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl22000_2ax_cfg_jf = {
@@ -610,6 +656,7 @@ const struct iwl_cfg iwl22000_2ax_cfg_jf = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0 = {
@@ -622,6 +669,7 @@ const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0 = {
@@ -634,6 +682,7 @@ const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0 = {
@@ -646,18 +695,21 @@ const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0 = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0 = {
 	.name = "Intel(R) Wireless-AC 9560 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_JF_B_FW_PRE,
 	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0 = {
 	.name = "Intel(R) Wi-Fi 7 AX210 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
@@ -665,6 +717,7 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.fw_name_pre = IWL_22000_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
@@ -672,12 +725,14 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 	.fw_name_pre = IWL_22000_TY_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 	.name = "Intel(R) Wi-Fi 7 AX411 160MHz",
 	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
 	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 MODULE_FIRMWARE(IWL_22000_HR_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index e9155b9b5ee4..ac05c1a6ec6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -138,6 +138,7 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 	.thermal_params = &iwl9000_tt_params,				\
 	.apmg_not_supported = true,					\
 	.trans.mq_rx_supported = true,					\
+	.num_rbds = 512,						\
 	.vht_mu_mimo_supported = true,					\
 	.mac_addr_from_csr = true,					\
 	.trans.rf_id = true,						\
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 317eac066082..f8a93324d7c0 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -431,6 +431,8 @@ struct iwl_fw_mon_regs {
  * @uhb_supported: ultra high band channels supported
  * @min_256_ba_txq_size: minimum number of slots required in a TX queue which
  *	supports 256 BA aggregation
+ * @num_rbds: number of receive buffer descriptors to use
+ *	(only used for multi-queue capable devices)
  *
  * We enable the driver to be backward compatible wrt. hardware features.
  * API differences in uCode shouldn't be handled here but through TLVs
@@ -485,6 +487,7 @@ struct iwl_cfg {
 	u8 max_vht_ampdu_exponent;
 	u8 ucode_api_max;
 	u8 ucode_api_min;
+	u16 num_rbds;
 	u32 min_umac_error_event_table;
 	u32 extra_phy_cfg_flags;
 	u32 d3_debug_data_base_addr;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 5ed07e37e3ee..eeaa8cbdddce 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -20,7 +20,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -64,12 +64,12 @@
  *	the init done for driver command that configures several system modes
  * @IWL_CTXT_INFO_EARLY_DEBUG: enable early debug
  * @IWL_CTXT_INFO_ENABLE_CDMP: enable core dump
- * @IWL_CTXT_INFO_RB_CB_SIZE_POS: position of the RBD Cyclic Buffer Size
+ * @IWL_CTXT_INFO_RB_CB_SIZE: mask of the RBD Cyclic Buffer Size
  *	exponent, the actual size is 2**value, valid sizes are 8-2048.
  *	The value is four bits long. Maximum valid exponent is 12
  * @IWL_CTXT_INFO_TFD_FORMAT_LONG: use long TFD Format (the
  *	default is short format - not supported by the driver)
- * @IWL_CTXT_INFO_RB_SIZE_POS: RB size position
+ * @IWL_CTXT_INFO_RB_SIZE: RB size mask
  *	(values are IWL_CTXT_INFO_RB_SIZE_*K)
  * @IWL_CTXT_INFO_RB_SIZE_1K: Value for 1K RB size
  * @IWL_CTXT_INFO_RB_SIZE_2K: Value for 2K RB size
@@ -83,12 +83,12 @@
  * @IWL_CTXT_INFO_RB_SIZE_32K: Value for 32K RB size
  */
 enum iwl_context_info_flags {
-	IWL_CTXT_INFO_AUTO_FUNC_INIT	= BIT(0),
-	IWL_CTXT_INFO_EARLY_DEBUG	= BIT(1),
-	IWL_CTXT_INFO_ENABLE_CDMP	= BIT(2),
-	IWL_CTXT_INFO_RB_CB_SIZE_POS	= 4,
-	IWL_CTXT_INFO_TFD_FORMAT_LONG	= BIT(8),
-	IWL_CTXT_INFO_RB_SIZE_POS	= 9,
+	IWL_CTXT_INFO_AUTO_FUNC_INIT	= 0x0001,
+	IWL_CTXT_INFO_EARLY_DEBUG	= 0x0002,
+	IWL_CTXT_INFO_ENABLE_CDMP	= 0x0004,
+	IWL_CTXT_INFO_RB_CB_SIZE	= 0x00f0,
+	IWL_CTXT_INFO_TFD_FORMAT_LONG	= 0x0100,
+	IWL_CTXT_INFO_RB_SIZE		= 0x1e00,
 	IWL_CTXT_INFO_RB_SIZE_1K	= 0x1,
 	IWL_CTXT_INFO_RB_SIZE_2K	= 0x2,
 	IWL_CTXT_INFO_RB_SIZE_4K	= 0x4,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
index 8836f85afe85..bf673ce5f183 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-fh.h
@@ -611,10 +611,7 @@ static inline unsigned int FH_MEM_CBBC_QUEUE(struct iwl_trans *trans,
  */
 #define FH_TX_CHICKEN_BITS_SCD_AUTO_RETRY_EN	(0x00000002)
 
-#define MQ_RX_TABLE_SIZE	512
-#define MQ_RX_TABLE_MASK	(MQ_RX_TABLE_SIZE - 1)
-#define MQ_RX_NUM_RBDS		(MQ_RX_TABLE_SIZE - 1)
-#define RX_POOL_SIZE		(MQ_RX_NUM_RBDS +	\
+#define RX_POOL_SIZE(rbds)	((rbds) - 1 +	\
 				 IWL_MAX_RX_HW_QUEUES *	\
 				 (RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC))
 /* cb size is the exponent */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index a4e09a5b1816..01f248ba8fec 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -206,7 +206,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 	ctxt_info_gen3->mtr_size =
 		cpu_to_le16(TFD_QUEUE_CB_SIZE(cmdq_size));
 	ctxt_info_gen3->mcr_size =
-		cpu_to_le16(RX_QUEUE_CB_SIZE(MQ_RX_TABLE_SIZE));
+		cpu_to_le16(RX_QUEUE_CB_SIZE(trans->cfg->num_rbds));
 
 	trans_pcie->ctxt_info_gen3 = ctxt_info_gen3;
 	trans_pcie->prph_info = prph_info;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index d38cefbb779e..c34451e7e7ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -193,11 +193,12 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 		rb_size = IWL_CTXT_INFO_RB_SIZE_4K;
 	}
 
-	BUILD_BUG_ON(RX_QUEUE_CB_SIZE(MQ_RX_TABLE_SIZE) > 0xF);
-	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG |
-			(RX_QUEUE_CB_SIZE(MQ_RX_TABLE_SIZE) <<
-			 IWL_CTXT_INFO_RB_CB_SIZE_POS) |
-			(rb_size << IWL_CTXT_INFO_RB_SIZE_POS);
+	WARN_ON(RX_QUEUE_CB_SIZE(trans->cfg->num_rbds) > 12);
+	control_flags = IWL_CTXT_INFO_TFD_FORMAT_LONG;
+	control_flags |=
+		u32_encode_bits(RX_QUEUE_CB_SIZE(trans->cfg->num_rbds),
+				IWL_CTXT_INFO_RB_CB_SIZE);
+	control_flags |= u32_encode_bits(rb_size, IWL_CTXT_INFO_RB_SIZE);
 	ctxt_info->control.control_flags = cpu_to_le32(control_flags);
 
 	/* initialize RX default queue */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 040cec17d3ad..cdf112d6c0f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -995,6 +995,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct iwl_cfg *cfg = (struct iwl_cfg *)(ent->driver_data);
 	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
 	struct iwl_trans *iwl_trans;
+	struct iwl_trans_pcie *trans_pcie;
 	unsigned long flags;
 	int ret;
 
@@ -1002,6 +1003,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
 
+	trans_pcie = IWL_TRANS_GET_PCIE_TRANS(iwl_trans);
+
 	/* the trans_cfg should never change, so set it now */
 	iwl_trans->trans_cfg = &cfg->trans;
 
@@ -1129,6 +1132,16 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* now set the real cfg we decided to use */
 	iwl_trans->cfg = cfg;
 
+	if (cfg->trans.mq_rx_supported) {
+		if (WARN_ON(!cfg->num_rbds)) {
+			ret = -EINVAL;
+			goto out_free_trans;
+		}
+		trans_pcie->num_rx_bufs = cfg->num_rbds;
+	} else {
+		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
+	}
+
 	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000 &&
 	    iwl_trans_grab_nic_access(iwl_trans, &flags)) {
 		u32 hw_step;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index a091690f6c79..c45df9a48559 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -513,8 +513,8 @@ struct cont_rec {
  */
 struct iwl_trans_pcie {
 	struct iwl_rxq *rxq;
-	struct iwl_rx_mem_buffer rx_pool[RX_POOL_SIZE];
-	struct iwl_rx_mem_buffer *global_table[RX_POOL_SIZE];
+	struct iwl_rx_mem_buffer *rx_pool;
+	struct iwl_rx_mem_buffer **global_table;
 	struct iwl_rb_allocator rba;
 	union {
 		struct iwl_context_info *ctxt_info;
@@ -573,6 +573,7 @@ struct iwl_trans_pcie {
 	u8 no_reclaim_cmds[MAX_NO_RECLAIM_CMDS];
 	u8 max_tbs;
 	u16 tfd_size;
+	u16 num_rx_bufs;
 
 	enum iwl_amsdu_size rx_buf_size;
 	bool bc_table_dword;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 452da44a21e0..f03d3cfb50da 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -510,7 +510,7 @@ void iwl_pcie_free_rbs_pool(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int i;
 
-	for (i = 0; i < RX_POOL_SIZE; i++) {
+	for (i = 0; i < RX_POOL_SIZE(trans_pcie->num_rx_bufs); i++) {
 		if (!trans_pcie->rx_pool[i].page)
 			continue;
 		dma_unmap_page(trans->dev, trans_pcie->rx_pool[i].page_dma,
@@ -738,7 +738,7 @@ static int iwl_pcie_alloc_rxq_dma(struct iwl_trans *trans,
 
 	spin_lock_init(&rxq->lock);
 	if (trans->trans_cfg->mq_rx_supported)
-		rxq->queue_size = MQ_RX_TABLE_SIZE;
+		rxq->queue_size = trans->cfg->num_rbds;
 	else
 		rxq->queue_size = RX_QUEUE_SIZE;
 
@@ -807,8 +807,18 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 
 	trans_pcie->rxq = kcalloc(trans->num_rx_queues, sizeof(struct iwl_rxq),
 				  GFP_KERNEL);
-	if (!trans_pcie->rxq)
-		return -ENOMEM;
+	trans_pcie->rx_pool = kcalloc(RX_POOL_SIZE(trans_pcie->num_rx_bufs),
+				      sizeof(trans_pcie->rx_pool[0]),
+				      GFP_KERNEL);
+	trans_pcie->global_table =
+		kcalloc(RX_POOL_SIZE(trans_pcie->num_rx_bufs),
+			sizeof(trans_pcie->global_table[0]),
+			GFP_KERNEL);
+	if (!trans_pcie->rxq || !trans_pcie->rx_pool ||
+	    !trans_pcie->global_table) {
+		ret = -ENOMEM;
+		goto err;
+	}
 
 	spin_lock_init(&rba->lock);
 
@@ -845,6 +855,8 @@ static int iwl_pcie_rx_alloc(struct iwl_trans *trans)
 		trans_pcie->base_rb_stts = NULL;
 		trans_pcie->base_rb_stts_dma = 0;
 	}
+	kfree(trans_pcie->rx_pool);
+	kfree(trans_pcie->global_table);
 	kfree(trans_pcie->rxq);
 
 	return ret;
@@ -1081,12 +1093,11 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 
 	/* move the pool to the default queue and allocator ownerships */
 	queue_size = trans->trans_cfg->mq_rx_supported ?
-		     MQ_RX_NUM_RBDS : RX_QUEUE_SIZE;
+			trans_pcie->num_rx_bufs - 1 : RX_QUEUE_SIZE;
 	allocator_pool_size = trans->num_rx_queues *
 		(RX_CLAIM_REQ_ALLOC - RX_POST_REQ_ALLOC);
 	num_alloc = queue_size + allocator_pool_size;
-	BUILD_BUG_ON(ARRAY_SIZE(trans_pcie->global_table) !=
-		     ARRAY_SIZE(trans_pcie->rx_pool));
+
 	for (i = 0; i < num_alloc; i++) {
 		struct iwl_rx_mem_buffer *rxb = &trans_pcie->rx_pool[i];
 
@@ -1177,6 +1188,8 @@ void iwl_pcie_rx_free(struct iwl_trans *trans)
 		if (rxq->napi.poll)
 			netif_napi_del(&rxq->napi);
 	}
+	kfree(trans_pcie->rx_pool);
+	kfree(trans_pcie->global_table);
 	kfree(trans_pcie->rxq);
 }
 
@@ -1390,13 +1403,12 @@ static struct iwl_rx_mem_buffer *iwl_pcie_get_rxb(struct iwl_trans *trans,
 		return rxb;
 	}
 
-	/* used_bd is a 32/16 bit but only 12 are used to retrieve the vid */
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		vid = le16_to_cpu(rxq->cd[i].rbid) & 0x0FFF;
+		vid = le16_to_cpu(rxq->cd[i].rbid);
 	else
-		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF;
+		vid = le32_to_cpu(rxq->bd_32[i]) & 0x0FFF; /* 12-bit VID */
 
-	if (!vid || vid > ARRAY_SIZE(trans_pcie->global_table))
+	if (!vid || vid > RX_POOL_SIZE(trans_pcie->num_rx_bufs))
 		goto out_err;
 
 	rxb = trans_pcie->global_table[vid - 1];
-- 
2.24.0

