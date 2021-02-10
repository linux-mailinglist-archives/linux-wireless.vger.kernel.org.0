Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABEF3169E1
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBJPQN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 10:16:13 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45262 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230245AbhBJPQH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:07 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9rD5-0049kS-R4; Wed, 10 Feb 2021 17:15:20 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 17:15:08 +0200
Message-Id: <iwlwifi.20210210171218.9b8da8408692.I7fe99d73cd67ffc817c2ef6af4c9932ce9fc50b2@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210151514.416221-1-luca@coelho.fi>
References: <20210210151514.416221-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: mvm: Support SCAN_CFG_CMD version 5
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Since the firmware support for internal station for auxiliary
activities, there is no need to configure an auxiliary station
as part of SCAN_CFG_CMD. Thus, this configuration was removed
from the corresponding structure.

Align the code accordingly.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h |  5 +++--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c    | 14 ++++++++------
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
index 931c0f48de99..6b8ca35cec1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/scan.h
@@ -542,7 +542,8 @@ struct iwl_scan_config_v2 {
  * struct iwl_scan_config
  * @enable_cam_mode: whether to enable CAM mode.
  * @enable_promiscouos_mode: whether to enable promiscouos mode
- * @bcast_sta_id: the index of the station in the fw
+ * @bcast_sta_id: the index of the station in the fw. Deprecated starting with
+ *     API version 5.
  * @reserved: reserved
  * @tx_chains: valid_tx antenna - ANT_* definitions
  * @rx_chains: valid_rx antenna - ANT_* definitions
@@ -554,7 +555,7 @@ struct iwl_scan_config {
 	u8 reserved;
 	__le32 tx_chains;
 	__le32 rx_chains;
-} __packed; /* SCAN_CONFIG_DB_CMD_API_S_3 */
+} __packed; /* SCAN_CONFIG_DB_CMD_API_S_5 */
 
 /**
  * enum iwl_umac_scan_flags - UMAC scan flags
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 42e790ed8caa..caf87f320094 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1253,14 +1253,16 @@ int iwl_mvm_config_scan(struct iwl_mvm *mvm)
 	memset(&cfg, 0, sizeof(cfg));
 
 	if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
-				  ADD_STA, 0) < 12)
+				  ADD_STA, 0) < 12) {
 		cfg.bcast_sta_id = mvm->aux_sta.sta_id;
-	/*
-	 * Fw doesn't use this sta anymore, pending deprecation via HOST API
-	 * change.
-	 */
-	else
+	} else if (iwl_fw_lookup_cmd_ver(mvm->fw, LONG_GROUP,
+					 SCAN_CFG_CMD, 0) < 5) {
+		/*
+		 * Fw doesn't use this sta anymore. Deprecated on SCAN_CFG_CMD
+		 * version 5.
+		 */
 		cfg.bcast_sta_id = 0xff;
+	}
 
 	cfg.tx_chains = cpu_to_le32(iwl_mvm_get_valid_tx_ant(mvm));
 	cfg.rx_chains = cpu_to_le32(iwl_mvm_scan_rx_ant(mvm));
-- 
2.30.0

