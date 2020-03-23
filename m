Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1028218F596
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgCWNTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:19:44 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43434 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728497AbgCWNTn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:19:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzU-00023f-SC; Mon, 23 Mar 2020 15:19:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:20 +0200
Message-Id: <iwlwifi.20200323151304.2b0ce6957740.Ib71b07ea9e322eb74571dc5e8aa58f17eece5c9c@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/14] iwlwifi: move integrated, extra_phy and soc_latency to trans_cfg
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

These values are selected based on the PCI device ID, so the decision
to use them can be made early.  By moving them to the trans_cfg, we
avoid duplicating the large cfg structs for small pieces of
data (sometimes a single boolean).  This will also allow us to make
more decisions based on, for instance, the SoC type in used.

The trans_cfg concept changes a bit, because previously it was used
only to boot the device before reading further characteristics and now
it also contains more data that is associated with the device ID.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 24 +++++------
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 31 +++++++++-----
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 21 ++++++----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  7 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 42 ++++---------------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +-
 7 files changed, 58 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 53568bbcf214..bfabe0ed4ee8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -464,8 +464,8 @@ const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.integrated = true,
-	.soc_latency = 5000,
+	.trans.integrated = true,
+	.trans.xtal_latency = 5000,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
@@ -479,8 +479,8 @@ const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.integrated = true,
-	.soc_latency = 5000,
+	.trans.integrated = true,
+	.trans.xtal_latency = 5000,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
@@ -494,8 +494,8 @@ const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.integrated = true,
-	.soc_latency = 5000,
+	.trans.integrated = true,
+	.trans.xtal_latency = 5000,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
@@ -509,8 +509,8 @@ const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.integrated = true,
-	.soc_latency = 5000,
+	.trans.integrated = true,
+	.trans.xtal_latency = 5000,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
@@ -524,8 +524,8 @@ const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.integrated = true,
-	.soc_latency = 5000,
+	.trans.integrated = true,
+	.trans.xtal_latency = 5000,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
@@ -539,8 +539,8 @@ const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.integrated = true,
-	.soc_latency = 5000,
+	.trans.integrated = true,
+	.trans.xtal_latency = 5000,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index cb2604b01a99..f84b8e5d3f0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -174,9 +174,23 @@ const struct iwl_cfg_trans_params iwl9000_trans_cfg = {
 	.rf_id = true,
 };
 
-const struct iwl_cfg iwl9260_2ac_cfg = {
-	.fw_name_pre = IWL9260_FW_PRE,
-	IWL_DEVICE_9000,
+const struct iwl_cfg_trans_params iwl9560_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_9000,
+	.base_params = &iwl9000_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.integrated = true,
+	.xtal_latency = 5000,
+};
+
+const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_9000,
+	.base_params = &iwl9000_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+	.integrated = true,
+	.xtal_latency = 5000,
+	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
 };
 
 const char iwl9162_name[] = "Intel(R) Wireless-AC 9162";
@@ -200,19 +214,14 @@ const char iwl9560_killer_1550i_name[] =
 const char iwl9560_killer_1550s_name[] =
 	"Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)";
 
-const struct iwl_cfg iwl9560_2ac_cfg_soc = {
-	.fw_name_pre = IWL9000_FW_PRE,
+const struct iwl_cfg iwl9260_2ac_cfg = {
+	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
 };
 
-const struct iwl_cfg iwl9560_2ac_cfg_shared_clk = {
+const struct iwl_cfg iwl9560_2ac_cfg_soc = {
 	.fw_name_pre = IWL9000_FW_PRE,
 	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
-	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
 };
 
 MODULE_FIRMWARE(IWL9000_MODULE_FIRMWARE(IWL9000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index dc32ccf95be5..2e9a85a9ee67 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -287,27 +287,34 @@ struct iwl_pwr_tx_backoff {
 /**
  * struct iwl_cfg_trans - information needed to start the trans
  *
- * These values cannot be changed when multiple configs are used for a
- * single PCI ID, because they are needed before the HW REV or RFID
- * can be read.
+ * These values are specific to the device ID and do not change when
+ * multiple configs are used for a single device ID.  They values are
+ * used, among other things, to boot the NIC so that the HW REV or
+ * RFID can be read before deciding the remaining parameters to use.
  *
  * @base_params: pointer to basic parameters
  * @csr: csr flags and addresses that are different across devices
  * @device_family: the device family
  * @umac_prph_offset: offset to add to UMAC periphery address
+ * @xtal_latency: power up latency to get the xtal stabilized
+ * @extra_phy_cfg_flags: extra configuration flags to pass to the PHY
  * @rf_id: need to read rf_id to determine the firmware image
  * @use_tfh: use TFH
  * @gen2: 22000 and on transport operation
  * @mq_rx_supported: multi-queue rx support
+ * @integrated: discrete or integrated
  */
 struct iwl_cfg_trans_params {
 	const struct iwl_base_params *base_params;
 	enum iwl_device_family device_family;
 	u32 umac_prph_offset;
+	u32 xtal_latency;
+	u32 extra_phy_cfg_flags;
 	u32 rf_id:1,
 	    use_tfh:1,
 	    gen2:1,
 	    mq_rx_supported:1,
+	    integrated:1,
 	    bisr_workaround:1;
 };
 
@@ -374,7 +381,6 @@ struct iwl_fw_mon_regs {
  * @smem_offset: offset from which the SMEM begins
  * @smem_len: the length of SMEM
  * @vht_mu_mimo_supported: VHT MU-MIMO support
- * @integrated: discrete or integrated
  * @cdb: CDB support
  * @nvm_type: see &enum iwl_nvm_type
  * @d3_debug_data_base_addr: base address where D3 debug data is stored
@@ -413,7 +419,6 @@ struct iwl_cfg {
 	u32 dccm2_len;
 	u32 smem_offset;
 	u32 smem_len;
-	u32 soc_latency;
 	u16 nvm_ver;
 	u16 nvm_calib_ver;
 	u32 rx_with_siso_diversity:1,
@@ -427,7 +432,6 @@ struct iwl_cfg {
 	    disable_dummy_notification:1,
 	    apmg_not_supported:1,
 	    vht_mu_mimo_supported:1,
-	    integrated:1,
 	    cdb:1,
 	    dbgc_supported:1,
 	    uhb_supported:1;
@@ -442,7 +446,6 @@ struct iwl_cfg {
 	u8 ucode_api_min;
 	u16 num_rbds;
 	u32 min_umac_error_event_table;
-	u32 extra_phy_cfg_flags;
 	u32 d3_debug_data_base_addr;
 	u32 d3_debug_data_length;
 	u32 min_txq_size;
@@ -496,6 +499,8 @@ struct iwl_dev_info {
  * This list declares the config structures for all devices.
  */
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
@@ -586,7 +591,6 @@ extern const struct iwl_cfg iwl9260_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_160_cfg;
 extern const struct iwl_cfg iwl9260_killer_2ac_cfg;
 extern const struct iwl_cfg iwl9270_2ac_cfg;
-extern const struct iwl_cfg iwl9560_2ac_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
@@ -596,7 +600,6 @@ extern const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9461_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9462_2ac_cfg_shared_clk;
-extern const struct iwl_cfg iwl9560_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_killer_2ac_cfg_shared_clk;
 extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_shared_clk;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 1b3a2f52e13f..98978a475d93 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -93,10 +93,10 @@ static int iwl_set_soc_latency(struct iwl_mvm *mvm)
 	struct iwl_soc_configuration_cmd cmd;
 	int ret;
 
-	cmd.device_type = (mvm->trans->cfg->integrated) ?
+	cmd.device_type = (mvm->trans->trans_cfg->integrated) ?
 		cpu_to_le32(SOC_CONFIG_CMD_INTEGRATED) :
 		cpu_to_le32(SOC_CONFIG_CMD_DISCRETE);
-	cmd.soc_latency = cpu_to_le32(mvm->trans->cfg->soc_latency);
+	cmd.soc_latency = cpu_to_le32(mvm->trans->trans_cfg->xtal_latency);
 
 	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SOC_CONFIGURATION_CMD,
 						   SYSTEM_GROUP, 0), 0,
@@ -561,7 +561,8 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	phy_cfg_cmd.phy_cfg = cpu_to_le32(iwl_mvm_get_phy_config(mvm));
 
 	/* set flags extra PHY configuration flags from the device's cfg */
-	phy_cfg_cmd.phy_cfg |= cpu_to_le32(mvm->cfg->extra_phy_cfg_flags);
+	phy_cfg_cmd.phy_cfg |=
+		cpu_to_le32(mvm->trans->trans_cfg->extra_phy_cfg_flags);
 
 	phy_cfg_cmd.calib_control.event_trigger =
 		mvm->fw->default_calib[ucode_type].event_trigger;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5f10dba12c8c..76c8df244dba 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -567,12 +567,12 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
 
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9000_trans_cfg)},
-	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9560_shared_clk_trans_cfg)},
+	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9560_trans_cfg)},
+	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9560_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
@@ -825,37 +825,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 	IWL_DEV_INFO(0x30DC, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0x30DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
-	IWL_DEV_INFO(0x31DC, 0x1551, iwl9560_2ac_cfg_shared_clk, iwl9560_killer_1550s_name),
-	IWL_DEV_INFO(0x31DC, 0x1552, iwl9560_2ac_cfg_shared_clk, iwl9560_killer_1550i_name),
+	IWL_DEV_INFO(0x31DC, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
+	IWL_DEV_INFO(0x31DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 
-	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg_shared_clk, iwl9461_160_name),
-	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg_shared_clk, iwl9461_name),
-	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg_shared_clk, iwl9462_160_name),
-	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg_shared_clk, iwl9462_name),
-
-	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg_shared_clk, iwl9560_160_name),
-	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
-		      iwl9560_2ac_cfg_shared_clk, iwl9560_name),
-
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 427fcea5cb2d..8c29071cb415 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1043,7 +1043,7 @@ static void iwl_pcie_rx_mq_hw_init(struct iwl_trans *trans)
 			       RFH_GEN_CFG_VAL(DEFAULT_RXQ_NUM, 0) |
 			       RFH_GEN_CFG_SERVICE_DMA_SNOOP |
 			       RFH_GEN_CFG_VAL(RB_CHUNK_SIZE,
-					       trans->cfg->integrated ?
+					       trans->trans_cfg->integrated ?
 					       RFH_GEN_CFG_RB_CHUNK_SIZE_64 :
 					       RFH_GEN_CFG_RB_CHUNK_SIZE_128));
 	/* Enable the relevant rx queues */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 46832bbfcae7..e4cbd8daa7c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1817,7 +1817,7 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 	iwl_trans_pcie_sw_reset(trans);
 
 	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
-	    trans->cfg->integrated) {
+	    trans->trans_cfg->integrated) {
 		err = iwl_pcie_gen2_force_power_gating(trans);
 		if (err)
 			return err;
-- 
2.25.1

