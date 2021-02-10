Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6412E3169E5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhBJPQS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:18 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45280 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231708AbhBJPQL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD7-0049kS-MR; Wed, 10 Feb 2021 17:15:22 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:11 +0200
Message-Id: <iwlwifi.20210210171218.ed18d7c8e7b8.Ic3fdf7c8636f332e3d5ee5841b03bf85e3bc4855@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/12] iwlwifi: remove max_vht_ampdu_exponent config parameter
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is not (or no longer) used, so remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    | 3 ---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 4 +---
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 605628a67c6a..e8b7b7618a3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -327,8 +327,6 @@ struct iwl_fw_mon_regs {
  * @max_tx_agg_size: max TX aggregation size of the ADDBA request/response
  * @max_ht_ampdu_factor: the exponent of the max length of A-MPDU that the
  *	station can receive in HT
- * @max_vht_ampdu_exponent: the exponent of the max length of A-MPDU that the
- *	station can receive in VHT
  * @dccm_offset: offset from which DCCM begins
  * @dccm_len: length of DCCM (including runtime stack CCM)
  * @dccm2_offset: offset from which the second DCCM begins
@@ -396,7 +394,6 @@ struct iwl_cfg {
 	u8 nvm_hw_section_num;
 	u8 max_tx_agg_size;
 	u8 max_ht_ampdu_exponent;
-	u8 max_vht_ampdu_exponent;
 	u8 ucode_api_max;
 	u8 ucode_api_min;
 	u16 num_rbds;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index fd3aeb5c0c58..af684f80b0cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -453,8 +453,6 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 	const struct iwl_cfg *cfg = trans->cfg;
 	int num_rx_ants = num_of_ant(rx_chains);
 	int num_tx_ants = num_of_ant(tx_chains);
-	unsigned int max_ampdu_exponent = (cfg->max_vht_ampdu_exponent ?:
-					   IEEE80211_VHT_MAX_AMPDU_1024K);
 
 	vht_cap->vht_supported = true;
 
@@ -462,7 +460,7 @@ static void iwl_init_vht_hw_capab(struct iwl_trans *trans,
 		       IEEE80211_VHT_CAP_RXSTBC_1 |
 		       IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
 		       3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT |
-		       max_ampdu_exponent <<
+		       IEEE80211_VHT_MAX_AMPDU_1024K <<
 		       IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
 
 	if (data->vht160_supported)
-- 
2.30.0

