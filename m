Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026E69795B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 14:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfHUMar (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 08:30:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37724 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728230AbfHUMar (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 08:30:47 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0PlE-0000kL-Kn; Wed, 21 Aug 2019 15:30:46 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 15:30:40 +0300
Message-Id: <20190821123040.13982-1-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v5.3] iwlwifi: pcie: handle switching killer Qu B0 NICs to C0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We need to use a different firmware for C0 versions of killer Qu NICs.
Add structures for them and handle them in the if block that detects
C0 revisions.

Additionally, instead of having an inclusive check for QnJ devices,
make the selection exclusive, so that switching to QnJ is the
exception, not the default.  This prevents us from having to add all
the non-QnJ cards to an exclusion list.  To do so, only go into the
QnJ block if the device has an RF ID type HR and HW revision QnJ.

Cc: stable@vger.kernel.org # 5.2
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 24 ++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 28 +++++++++++--------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  7 +----
 4 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1f500cddb3a7..55b713255b8e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -556,6 +556,30 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
 };
 
+const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0 = {
+	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
+	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+};
+
+const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
+	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
+	.fw_name_pre = IWL_QU_C_HR_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+};
+
 const struct iwl_cfg iwl22000_2ax_cfg_jf = {
 	.name = "Intel(R) Dual Band Wireless AX 22000",
 	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 1c1bf1b281cd..6c04f8223aff 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -577,6 +577,8 @@ extern const struct iwl_cfg iwl_ax1650i_cfg_quz_hr;
 extern const struct iwl_cfg iwl_ax1650s_cfg_quz_hr;
 extern const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0;
+extern const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0;
+extern const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
 extern const struct iwl_cfg iwl9461_2ac_cfg_qu_b0_jf_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7c5aaeaf7fe5..65d2f6b996dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1050,18 +1050,22 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * thing to do to support Qu C-step.
 	 */
 	if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_QU_C0) {
-		if (iwl_trans->cfg == &iwl_ax101_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax101_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &iwl_ax201_cfg_qu_hr)
-			iwl_trans->cfg = &iwl_ax201_cfg_qu_c0_hr_b0;
-		else if (iwl_trans->cfg == &iwl9461_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9461_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9462_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9462_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9560_2ac_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_cfg_qu_c0_jf_b0;
-		else if (iwl_trans->cfg == &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-			iwl_trans->cfg = &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
+		if (iwl_trans->cfg= &iwl_ax101_cfg_qu_hr)
+			iwl_trans->cfg &iwl_ax101_cfg_qu_c0_hr_b0;
+		else if (iwl_trans->cfg= &iwl_ax201_cfg_qu_hr)
+			iwl_trans->cfg &iwl_ax201_cfg_qu_c0_hr_b0;
+		else if (iwl_trans->cfg= &iwl9461_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg &iwl9461_2ac_cfg_qu_c0_jf_b0;
+		else if (iwl_trans->cfg= &iwl9462_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg &iwl9462_2ac_cfg_qu_c0_jf_b0;
+		else if (iwl_trans->cfg= &iwl9560_2ac_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg &iwl9560_2ac_cfg_qu_c0_jf_b0;
+		else if (iwl_trans->cfg= &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
+			iwl_trans->cfg &iwl9560_2ac_160_cfg_qu_c0_jf_b0;
+		else if (iwl_trans->cfg= &killer1650s_2ax_cfg_qu_b0_hr_b0)
+			iwl_trans->cfg &killer1650s_2ax_cfg_qu_c0_hr_b0;
+		else if (iwl_trans->cfg= &killer1650i_2ax_cfg_qu_b0_hr_b0)
+			iwl_trans->cfg &killer1650i_2ax_cfg_qu_c0_hr_b0;
 	}
 
 	/* same thing for QuZ... */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 935e35dafce5..db62c8314603 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3602,12 +3602,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		}
 	} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(trans->hw_rf_id) ==
 		   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		   ((trans->cfg != &iwl_ax200_cfg_cc &&
-		     trans->cfg != &iwl_ax201_cfg_qu_hr &&
-		     trans->cfg != &killer1650x_2ax_cfg &&
-		     trans->cfg != &killer1650w_2ax_cfg &&
-		     trans->cfg != &iwl_ax201_cfg_quz_hr) ||
-		    trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0)) {
+		   trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) {
 		u32 hw_status;
 
 		hw_status = iwl_read_prph(trans, UMAG_GEN_HW_STATUS);
-- 
2.23.0.rc1

