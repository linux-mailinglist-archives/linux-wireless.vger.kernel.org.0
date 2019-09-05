Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2412BAA443
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbfIENWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41108 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388305AbfIENWk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:40 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rif-00062D-Dc; Thu, 05 Sep 2019 16:22:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:07 +0300
Message-Id: <20190905132220.23970-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 08/21] iwlwifi: always access the trans configuration via trans
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Stop accessing the trans configuration via the iwl_cfg structure and
always access it via the iwl_trans structure.  This completes the
requirements to disassociate the trans-specific configuration from the
rest of the configuration.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/devices.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c    |  4 ++--
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c   | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/dvm/power.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c     |  4 ++--
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.c   | 17 ++++++++++-------
 .../wireless/intel/iwlwifi/iwl-eeprom-parse.h   |  4 ++--
 .../wireless/intel/iwlwifi/iwl-eeprom-read.c    |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-nvm-parse.c  | 17 ++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c     |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c    |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c    |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c  |  6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 11 +++++++----
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c    |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c |  6 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c    | 11 +++++------
 21 files changed, 59 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index 73b3a947ab7a..dc3f197f94d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -484,7 +484,7 @@ static void iwl6000_set_ct_threshold(struct iwl_priv *priv)
 /* NIC configuration for 6000 series */
 static void iwl6000_nic_config(struct iwl_priv *priv)
 {
-	switch (priv->cfg->trans.device_family) {
+	switch (priv->trans->trans_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_6005:
 	case IWL_DEVICE_FAMILY_6030:
 	case IWL_DEVICE_FAMILY_6000:
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/led.c b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
index 1e1664ecf30b..dd387aba3317 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/led.c
@@ -121,9 +121,9 @@ static int iwl_led_cmd(struct iwl_priv *priv,
 	}
 
 	led_cmd.on = iwl_blink_compensation(priv, on,
-				priv->cfg->trans.base_params->led_compensation);
+				priv->trans->trans_cfg->base_params->led_compensation);
 	led_cmd.off = iwl_blink_compensation(priv, off,
-				priv->cfg->trans.base_params->led_compensation);
+				priv->trans->trans_cfg->base_params->led_compensation);
 
 	ret = iwl_send_led_cmd(priv, &led_cmd);
 	if (!ret) {
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index c223f26f046e..6512d25e3563 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -1099,7 +1099,7 @@ static void iwlagn_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto done;
 	}
 
-	scd_queues = BIT(priv->cfg->trans.base_params->num_of_queues) - 1;
+	scd_queues = BIT(priv->trans->trans_cfg->base_params->num_of_queues) - 1;
 	scd_queues &= ~(BIT(IWL_IPAN_CMD_QUEUE_NUM) |
 			BIT(IWL_DEFAULT_CMD_QUEUE_NUM));
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 8e47a075089f..4f2789bb3b5b 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1267,7 +1267,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	priv->cfg = cfg;
 	priv->fw = fw;
 
-	switch (priv->cfg->trans.device_family) {
+	switch (priv->trans->trans_cfg->device_family) {
 	case IWL_DEVICE_FAMILY_1000:
 	case IWL_DEVICE_FAMILY_100:
 		priv->lib = &iwl_dvm_1000_cfg;
@@ -1342,7 +1342,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 					  driver_data[2]);
 
 	WARN_ON(sizeof(priv->transport_queue_stop) * BITS_PER_BYTE <
-		priv->cfg->trans.base_params->num_of_queues);
+		priv->trans->trans_cfg->base_params->num_of_queues);
 
 	ucode_flags = fw->ucode_capa.flags;
 
@@ -1405,9 +1405,9 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	/* Reset chip to save power until we load uCode during "up". */
 	iwl_trans_stop_device(priv->trans);
 
-	priv->nvm_data = iwl_parse_eeprom_data(priv->trans->dev, priv->cfg,
-						  priv->eeprom_blob,
-						  priv->eeprom_blob_size);
+	priv->nvm_data = iwl_parse_eeprom_data(priv->trans, priv->cfg,
+					       priv->eeprom_blob,
+					       priv->eeprom_blob_size);
 	if (!priv->nvm_data)
 		goto out_free_eeprom_blob;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index e4e02fcbcd9f..93ef023905c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -200,7 +200,7 @@ static void iwl_static_sleep_cmd(struct iwl_priv *priv,
 	else
 		cmd->flags &= ~IWL_POWER_SLEEP_OVER_DTIM_MSK;
 
-	if (priv->cfg->trans.base_params->shadow_reg_enable)
+	if (priv->trans->trans_cfg->base_params->shadow_reg_enable)
 		cmd->flags |= IWL_POWER_SHADOW_REG_ENA;
 	else
 		cmd->flags &= ~IWL_POWER_SHADOW_REG_ENA;
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 75dc911b8f00..3029e3f6de63 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -468,7 +468,7 @@ static int iwlagn_alloc_agg_txq(struct iwl_priv *priv, int mq)
 	int q;
 
 	for (q = IWLAGN_FIRST_AMPDU_QUEUE;
-	     q < priv->cfg->trans.base_params->num_of_queues; q++) {
+	     q < priv->trans->trans_cfg->base_params->num_of_queues; q++) {
 		if (!test_and_set_bit(q, priv->agg_q_alloc)) {
 			priv->queue_to_mac80211[q] = mq;
 			return q;
@@ -1282,7 +1282,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * (in Tx queue's circular buffer) of first TFD/frame in window */
 	u16 ba_resp_scd_ssn = le16_to_cpu(ba_resp->scd_ssn);
 
-	if (scd_flow >= priv->cfg->trans.base_params->num_of_queues) {
+	if (scd_flow >= priv->trans->trans_cfg->base_params->num_of_queues) {
 		IWL_ERR(priv,
 			"BUG_ON scd_flow is bigger than number of queues\n");
 		return;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
index 75e7053f6807..cf7e2a9232e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c
@@ -728,12 +728,13 @@ int iwl_init_sband_channels(struct iwl_nvm_data *data,
 #define MAX_BIT_RATE_40_MHZ	150 /* Mbps */
 #define MAX_BIT_RATE_20_MHZ	72 /* Mbps */
 
-void iwl_init_ht_hw_capab(const struct iwl_cfg *cfg,
+void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 			  struct iwl_nvm_data *data,
 			  struct ieee80211_sta_ht_cap *ht_info,
 			  enum nl80211_band band,
 			  u8 tx_chains, u8 rx_chains)
 {
+	const struct iwl_cfg *cfg = trans->cfg;
 	int max_bit_rate = 0;
 
 	tx_chains = hweight8(tx_chains);
@@ -765,7 +766,7 @@ void iwl_init_ht_hw_capab(const struct iwl_cfg *cfg,
 	if (cfg->ht_params->ldpc)
 		ht_info->cap |= IEEE80211_HT_CAP_LDPC_CODING;
 
-	if ((cfg->trans.mq_rx_supported &&
+	if ((trans->trans_cfg->mq_rx_supported &&
 	     iwlwifi_mod_params.amsdu_size == IWL_AMSDU_DEF) ||
 	     iwlwifi_mod_params.amsdu_size >= IWL_AMSDU_8K)
 		ht_info->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
@@ -805,10 +806,11 @@ void iwl_init_ht_hw_capab(const struct iwl_cfg *cfg,
 	}
 }
 
-static void iwl_init_sbands(struct device *dev, const struct iwl_cfg *cfg,
+static void iwl_init_sbands(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 			    struct iwl_nvm_data *data,
 			    const u8 *eeprom, size_t eeprom_size)
 {
+	struct device *dev = trans->dev;
 	int n_channels = iwl_init_channel_map(dev, cfg, data,
 					      eeprom, eeprom_size);
 	int n_used = 0;
@@ -820,7 +822,7 @@ static void iwl_init_sbands(struct device *dev, const struct iwl_cfg *cfg,
 	sband->n_bitrates = N_RATES_24;
 	n_used += iwl_init_sband_channels(data, sband, n_channels,
 					  NL80211_BAND_2GHZ);
-	iwl_init_ht_hw_capab(cfg, data, &sband->ht_cap, NL80211_BAND_2GHZ,
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
 			     data->valid_tx_ant, data->valid_rx_ant);
 
 	sband = &data->bands[NL80211_BAND_5GHZ];
@@ -829,7 +831,7 @@ static void iwl_init_sbands(struct device *dev, const struct iwl_cfg *cfg,
 	sband->n_bitrates = N_RATES_52;
 	n_used += iwl_init_sband_channels(data, sband, n_channels,
 					  NL80211_BAND_5GHZ);
-	iwl_init_ht_hw_capab(cfg, data, &sband->ht_cap, NL80211_BAND_5GHZ,
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_5GHZ,
 			     data->valid_tx_ant, data->valid_rx_ant);
 
 	if (n_channels != n_used)
@@ -840,10 +842,11 @@ static void iwl_init_sbands(struct device *dev, const struct iwl_cfg *cfg,
 /* EEPROM data functions */
 
 struct iwl_nvm_data *
-iwl_parse_eeprom_data(struct device *dev, const struct iwl_cfg *cfg,
+iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const u8 *eeprom, size_t eeprom_size)
 {
 	struct iwl_nvm_data *data;
+	struct device *dev = trans->dev;
 	const void *tmp;
 	u16 radio_cfg, sku;
 
@@ -918,7 +921,7 @@ iwl_parse_eeprom_data(struct device *dev, const struct iwl_cfg *cfg,
 		goto err_free;
 	}
 
-	iwl_init_sbands(dev, cfg, data, eeprom, eeprom_size);
+	iwl_init_sbands(trans, cfg, data, eeprom, eeprom_size);
 
 	return data;
  err_free:
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
index 2375d300a7cd..03a748cc98fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h
@@ -116,14 +116,14 @@ struct iwl_nvm_data {
  * later with iwl_free_nvm_data().
  */
 struct iwl_nvm_data *
-iwl_parse_eeprom_data(struct device *dev, const struct iwl_cfg *cfg,
+iwl_parse_eeprom_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const u8 *eeprom, size_t eeprom_size);
 
 int iwl_init_sband_channels(struct iwl_nvm_data *data,
 			    struct ieee80211_supported_band *sband,
 			    int n_channels, enum nl80211_band band);
 
-void iwl_init_ht_hw_capab(const struct iwl_cfg *cfg,
+void iwl_init_ht_hw_capab(struct iwl_trans *trans,
 			  struct iwl_nvm_data *data,
 			  struct ieee80211_sta_ht_cap *ht_info,
 			  enum nl80211_band band,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
index 80bc2e44c7b1..ad6dc4497437 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c
@@ -193,7 +193,7 @@ static int iwl_init_otp_access(struct iwl_trans *trans)
 {
 	int ret;
 
-	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
+	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 83d4311e83d7..c8972f6e38ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -435,14 +435,14 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 
 	switch (iwlwifi_mod_params.amsdu_size) {
 	case IWL_AMSDU_DEF:
-		if (cfg->trans.mq_rx_supported)
+		if (trans->trans_cfg->mq_rx_supported)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
 			vht_cap->cap |= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895;
 		break;
 	case IWL_AMSDU_2K:
-		if (cfg->trans.mq_rx_supported)
+		if (trans->trans_cfg->mq_rx_supported)
 			vht_cap->cap |=
 				IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454;
 		else
@@ -689,7 +689,7 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 	sband->n_bitrates = N_RATES_24;
 	n_used += iwl_init_sband_channels(data, sband, n_channels,
 					  NL80211_BAND_2GHZ);
-	iwl_init_ht_hw_capab(cfg, data, &sband->ht_cap, NL80211_BAND_2GHZ,
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_2GHZ,
 			     tx_chains, rx_chains);
 
 	if (data->sku_cap_11ax_enable && !iwlwifi_mod_params.disable_11ax)
@@ -701,7 +701,7 @@ static void iwl_init_sbands(struct iwl_trans *trans,
 	sband->n_bitrates = N_RATES_52;
 	n_used += iwl_init_sband_channels(data, sband, n_channels,
 					  NL80211_BAND_5GHZ);
-	iwl_init_ht_hw_capab(cfg, data, &sband->ht_cap, NL80211_BAND_5GHZ,
+	iwl_init_ht_hw_capab(trans, data, &sband->ht_cap, NL80211_BAND_5GHZ,
 			     tx_chains, rx_chains);
 	if (data->sku_cap_11ac_enable && !iwlwifi_mod_params.disable_11ac)
 		iwl_init_vht_hw_capab(trans, data, &sband->vht_cap,
@@ -899,7 +899,7 @@ static int iwl_set_hw_address(struct iwl_trans *trans,
 }
 
 static bool
-iwl_nvm_no_wide_in_5ghz(struct device *dev, const struct iwl_cfg *cfg,
+iwl_nvm_no_wide_in_5ghz(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 			const __be16 *nvm_hw)
 {
 	/*
@@ -911,7 +911,7 @@ iwl_nvm_no_wide_in_5ghz(struct device *dev, const struct iwl_cfg *cfg,
 	 * in 5GHz otherwise the FW will throw a sysassert when we try
 	 * to use them.
 	 */
-	if (cfg->trans.device_family == IWL_DEVICE_FAMILY_7000) {
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_7000) {
 		/*
 		 * Unlike the other sections in the NVM, the hw
 		 * section uses big-endian.
@@ -920,7 +920,7 @@ iwl_nvm_no_wide_in_5ghz(struct device *dev, const struct iwl_cfg *cfg,
 		u8 sku = (subsystem_id & 0x1e) >> 1;
 
 		if (sku == 5 || sku == 9) {
-			IWL_DEBUG_EEPROM(dev,
+			IWL_DEBUG_EEPROM(trans->dev,
 					 "disabling wide channels in 5GHz (0x%0x %d)\n",
 					 subsystem_id, sku);
 			return true;
@@ -937,7 +937,6 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		   const __le16 *mac_override, const __le16 *phy_sku,
 		   u8 tx_chains, u8 rx_chains, bool lar_fw_supported)
 {
-	struct device *dev = trans->dev;
 	struct iwl_nvm_data *data;
 	bool lar_enabled;
 	u32 sku, radio_cfg;
@@ -1019,7 +1018,7 @@ iwl_parse_nvm_data(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (lar_fw_supported && lar_enabled)
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_LAR;
 
-	if (iwl_nvm_no_wide_in_5ghz(dev, cfg, nvm_hw))
+	if (iwl_nvm_no_wide_in_5ghz(trans, cfg, nvm_hw))
 		sbands_flags |= IWL_NVM_SBANDS_FLAGS_NO_WIDE_IN_5GHZ;
 
 	iwl_init_sbands(trans, data, ch_section, tx_chains, rx_chains,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index fcb51cb3010e..f93d50ceca68 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -558,7 +558,7 @@ int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 		goto remove_notif;
 	}
 
-	if (mvm->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000) {
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000) {
 		ret = iwl_mvm_send_bt_init_conf(mvm);
 		if (ret)
 			goto remove_notif;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/led.c b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
index 64298aec893a..d104da9170ca 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/led.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/led.c
@@ -156,7 +156,7 @@ void iwl_mvm_leds_sync(struct iwl_mvm *mvm)
 	 * if we control through the register, we're doing it
 	 * even when the firmware isn't up, so no need to sync
 	 */
-	if (mvm->cfg->trans.device_family < IWL_DEVICE_FAMILY_8000)
+	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		return;
 
 	iwl_mvm_led_set(mvm, mvm->led.brightness > 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 02a93adc3dfa..003a02bf79e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -400,7 +400,7 @@ int iwl_mvm_mac_setup_register(struct iwl_mvm *mvm)
 	 * for older devices. We also don't see this issue on any newer
 	 * devices.
 	 */
-	if (mvm->cfg->trans.device_family >= IWL_DEVICE_FAMILY_9000)
+	if (mvm->trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000)
 		ieee80211_hw_set(hw, TX_AMSDU);
 	ieee80211_hw_set(hw, TX_FRAG_LIST);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 9e76d494c45c..2540d7ffbbc1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1922,7 +1922,7 @@ void iwl_mvm_vif_set_low_latency(struct iwl_mvm_vif *mvmvif, bool set,
  */
 static inline u32 iwl_mvm_flushable_queues(struct iwl_mvm *mvm)
 {
-	return ((BIT(mvm->cfg->trans.base_params->num_of_queues) - 1) &
+	return ((BIT(mvm->trans->trans_cfg->base_params->num_of_queues) - 1) &
 		~BIT(IWL_MVM_DQA_CMD_QUEUE));
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index e2855efc2afd..945c1ea5cda8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -249,7 +249,7 @@ static int iwl_nvm_read_section(struct iwl_mvm *mvm, u16 section,
 	while (ret == length) {
 		/* Check no memory assumptions fail and cause an overflow */
 		if ((size_read + offset + length) >
-		    mvm->cfg->trans.base_params->eeprom_size) {
+		    mvm->trans->trans_cfg->base_params->eeprom_size) {
 			IWL_ERR(mvm, "EEPROM size is too small for NVM\n");
 			return -ENOBUFS;
 		}
@@ -372,7 +372,7 @@ int iwl_nvm_init(struct iwl_mvm *mvm)
 	/* Read From FW NVM */
 	IWL_DEBUG_EEPROM(mvm->trans->dev, "Read from NVM\n");
 
-	nvm_buffer = kmalloc(mvm->cfg->trans.base_params->eeprom_size,
+	nvm_buffer = kmalloc(mvm->trans->trans_cfg->base_params->eeprom_size,
 			     GFP_KERNEL);
 	if (!nvm_buffer)
 		return -ENOMEM;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index eaa8b1c9938a..0bedba4c61f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1954,7 +1954,7 @@ static void iwl_mvm_enable_aux_snif_queue(struct iwl_mvm *mvm, u16 *queue,
 					  u8 sta_id, u8 fifo)
 {
 	unsigned int wdg_timeout = iwlmvm_mod_params.tfd_q_hang_detect ?
-		mvm->cfg->trans.base_params->wd_timeout :
+		mvm->trans->trans_cfg->base_params->wd_timeout :
 		IWL_WATCHDOG_DISABLED;
 
 	if (iwl_mvm_has_new_tx_api(mvm)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index ba1524727a1f..8686107da116 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -531,7 +531,7 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
 		/* reset the device */
 		iwl_trans_sw_reset(trans);
 
-		err = iwl_finish_nic_init(trans, &trans->cfg->trans);
+		err = iwl_finish_nic_init(trans, trans->trans_cfg);
 		if (err)
 			return;
 	}
@@ -941,7 +941,7 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 	struct iwl_fw_dbg_trigger_txq_timer *txq_timer;
 	unsigned int default_timeout = cmd_q ?
 		IWL_DEF_WD_TIMEOUT :
-		mvm->cfg->trans.base_params->wd_timeout;
+		mvm->trans->trans_cfg->base_params->wd_timeout;
 
 	if (!iwl_fw_dbg_trigger_enabled(mvm->fw, FW_DBG_TRIGGER_TXQ_TIMERS)) {
 		/*
@@ -985,7 +985,7 @@ unsigned int iwl_mvm_get_wd_timeout(struct iwl_mvm *mvm,
 		return default_timeout;
 	default:
 		WARN_ON(1);
-		return mvm->cfg->trans.base_params->wd_timeout;
+		return mvm->trans->trans_cfg->base_params->wd_timeout;
 	}
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 16d65dfd3124..f02113b514be 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -997,9 +997,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	unsigned long flags;
 	int ret;
 
-	if (WARN_ONCE(!cfg->trans.csr, "CSR addresses aren't configured\n"))
-		return -EINVAL;
-
 	iwl_trans = iwl_trans_pcie_alloc(pdev, ent, &cfg->trans);
 	if (IS_ERR(iwl_trans))
 		return PTR_ERR(iwl_trans);
@@ -1007,6 +1004,12 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* the trans_cfg should never change, so set it now */
 	iwl_trans->trans_cfg = &cfg->trans;
 
+	if (WARN_ONCE(!iwl_trans->trans_cfg->csr,
+		      "CSR addresses aren't configured\n")) {
+		ret = -EINVAL;
+		goto out_free_trans;
+	}
+
 #if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
@@ -1116,7 +1119,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* now set the real cfg we decided to use */
 	iwl_trans->cfg = cfg;
 
-	if (cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000 &&
+	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000 &&
 	    iwl_trans_grab_nic_access(iwl_trans, &flags)) {
 		u32 hw_step;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index b6db3c42c467..df8455f14e4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -92,7 +92,7 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
-	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
+	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d2fe8ff45bbb..ae4f84016c3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -368,7 +368,7 @@ static int iwl_pcie_apm_init(struct iwl_trans *trans)
 	if (trans->trans_cfg->base_params->pll_cfg)
 		iwl_set_bit(trans, CSR_ANA_PLL_CFG, CSR50_ANA_PLL_CFG_VAL);
 
-	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
+	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
 		return ret;
 
@@ -440,7 +440,7 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 
 	iwl_trans_pcie_sw_reset(trans);
 
-	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
+	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
 		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
@@ -1534,7 +1534,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	iwl_set_bit(trans, CSR_GP_CNTRL,
 		    BIT(trans->trans_cfg->csr->flag_mac_access_req));
 
-	ret = iwl_finish_nic_init(trans, &trans->cfg->trans);
+	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 5787cdefacd6..4806a04cec8c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1238,7 +1238,6 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 				      const struct iwl_host_cmd *cmd)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	const struct iwl_cfg *cfg = trans->cfg;
 	int ret;
 
 	lockdep_assert_held(&trans_pcie->reg_lock);
@@ -1253,19 +1252,19 @@ static int iwl_pcie_set_cmd_in_flight(struct iwl_trans *trans,
 	 * returned. This needs to be done only on NICs that have
 	 * apmg_wake_up_wa set.
 	 */
-	if (cfg->trans.base_params->apmg_wake_up_wa &&
+	if (trans->trans_cfg->base_params->apmg_wake_up_wa &&
 	    !trans_pcie->cmd_hold_nic_awake) {
 		__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-					 BIT(cfg->trans.csr->flag_mac_access_req));
+					 BIT(trans->trans_cfg->csr->flag_mac_access_req));
 
 		ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-				   BIT(cfg->trans.csr->flag_val_mac_access_en),
-				   (BIT(cfg->trans.csr->flag_mac_clock_ready) |
+				   BIT(trans->trans_cfg->csr->flag_val_mac_access_en),
+				   (BIT(trans->trans_cfg->csr->flag_mac_clock_ready) |
 				    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP),
 				   15000);
 		if (ret < 0) {
 			__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
-					BIT(cfg->trans.csr->flag_mac_access_req));
+					BIT(trans->trans_cfg->csr->flag_mac_access_req));
 			IWL_ERR(trans, "Failed to wake NIC for hcmd\n");
 			return -EIO;
 		}
-- 
2.23.0.rc1

