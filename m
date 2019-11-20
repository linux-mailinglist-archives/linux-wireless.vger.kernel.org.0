Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E328103773
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfKTK1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:27:01 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58532 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728361AbfKTK1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:27:00 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCM-0001kS-JH; Wed, 20 Nov 2019 12:26:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:42 +0200
Message-Id: <20191120102650.514376-5-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120102650.514376-1-luca@coelho.fi>
References: <20191120102650.514376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 04/12] iwlwifi: config: remove max_rx_agg_size
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This field isn't set by any configuration, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c    | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 59bb960b460a..317eac066082 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -409,7 +409,6 @@ struct iwl_fw_mon_regs {
  * @mac_addr_from_csr: read HW address from CSR registers
  * @features: hw features, any combination of feature_whitelist
  * @pwr_tx_backoffs: translation table between power limits and backoffs
- * @max_rx_agg_size: max RX aggregation size of the ADDBA request/response
  * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
  * @max_ht_ampdu_factor: the exponent of the max length of A-MPDU that the
  *	station can receive in HT
@@ -481,7 +480,6 @@ struct iwl_cfg {
 	u8 valid_rx_ant;
 	u8 non_shared_ant;
 	u8 nvm_hw_section_num;
-	u8 max_rx_agg_size;
 	u8 max_tx_agg_size;
 	u8 max_ht_ampdu_exponent;
 	u8 max_vht_ampdu_exponent;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 3b0637311e3c..1b07a8e8f069 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -664,10 +664,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (!hw)
 		return NULL;
 
-	if (cfg->max_rx_agg_size)
-		hw->max_rx_aggregation_subframes = cfg->max_rx_agg_size;
-	else
-		hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
 
 	if (cfg->max_tx_agg_size)
 		hw->max_tx_aggregation_subframes = cfg->max_tx_agg_size;
-- 
2.24.0

