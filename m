Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0653166BF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBJMcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:32:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45066 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231894AbhBJMa0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:26 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9ocb-0049Yg-WF; Wed, 10 Feb 2021 14:29:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:17 +0200
Message-Id: <iwlwifi.20210210142629.941d963ceb88.I72a89c0161d7beab99bc3a90707796c2a63e4197@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210122927.315774-1-luca@coelho.fi>
References: <20210210122927.315774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 02/12] iwlwifi: api: clean up some documentation/bits
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Clean up some documentation references and some bits in the enums
to make the documentation more useful.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h | 7 ++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h       | 4 +++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
index b916b38b3092..8142dcfd8b40 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/commands.h
@@ -284,7 +284,7 @@ enum iwl_legacy_cmds {
 
 	/* Phy */
 	/**
-	 * @PHY_CONFIGURATION_CMD: &struct iwl_phy_cfg_cmd
+	 * @PHY_CONFIGURATION_CMD: &struct iwl_phy_cfg_cmd_v1 or &struct iwl_phy_cfg_cmd_v3
 	 */
 	PHY_CONFIGURATION_CMD = 0x6a,
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
index 28aa28138908..ceeef8749765 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/location.h
@@ -12,7 +12,12 @@
 enum iwl_location_subcmd_ids {
 	/**
 	 * @TOF_RANGE_REQ_CMD: TOF ranging request,
-	 *	uses &struct iwl_tof_range_req_cmd
+	 *	uses one of &struct iwl_tof_range_req_cmd_v5,
+	 *	&struct iwl_tof_range_req_cmd_v7,
+	 *	&struct iwl_tof_range_req_cmd_v8,
+	 *	&struct iwl_tof_range_req_cmd_v9,
+	 *	&struct iwl_tof_range_req_cmd_v11,
+	 *	&struct iwl_tof_range_req_cmd_v7
 	 */
 	TOF_RANGE_REQ_CMD = 0x0,
 	/**
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 95038b1a8c6f..24e4a82a55da 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -20,6 +20,7 @@
  * @TX_CMD_FLG_VHT_NDPA: mark frame is NDPA for VHT beamformer sequence
  * @TX_CMD_FLG_HT_NDPA: mark frame is NDPA for HT beamformer sequence
  * @TX_CMD_FLG_CSI_FDBK2HOST: mark to send feedback to host (only if good CRC)
+ * @TX_CMD_FLG_BT_PRIO_MASK: BT priority value
  * @TX_CMD_FLG_BT_PRIO_POS: the position of the BT priority (bit 11 is ignored
  *	on old firmwares).
  * @TX_CMD_FLG_BT_DIS: disable BT priority for this frame
@@ -51,6 +52,7 @@ enum iwl_tx_flags {
 	TX_CMD_FLG_HT_NDPA		= BIT(9),
 	TX_CMD_FLG_CSI_FDBK2HOST	= BIT(10),
 	TX_CMD_FLG_BT_PRIO_POS		= 11,
+	TX_CMD_FLG_BT_PRIO_MASK		= BIT(11) | BIT(12),
 	TX_CMD_FLG_BT_DIS		= BIT(12),
 	TX_CMD_FLG_SEQ_CTL		= BIT(13),
 	TX_CMD_FLG_MORE_FRAG		= BIT(14),
@@ -177,7 +179,7 @@ enum iwl_tx_offload_assist_flags_pos {
  * ( TX_CMD = 0x1c )
  * @len: in bytes of the payload, see below for details
  * @offload_assist: TX offload configuration
- * @tx_flags: combination of TX_CMD_FLG_*
+ * @tx_flags: combination of TX_CMD_FLG_*, see &enum iwl_tx_flags
  * @scratch: scratch buffer used by the device
  * @rate_n_flags: rate for *all* Tx attempts, if TX_CMD_FLG_STA_RATE_MSK is
  *	cleared. Combination of RATE_MCS_*
-- 
2.30.0

