Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0E2D4508
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgLIPGE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:04 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35460 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730270AbgLIPGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11p-003Dg4-6x; Wed, 09 Dec 2020 17:05:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:05 +0200
Message-Id: <iwlwifi.20201209170243.e5c5973b3aea.I8bbd41af7aa5e769273a6fc1c06fbf548dd2eb26@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/11] iwlwifi: add an extra firmware state in the transport
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Start tracking not just if the firmware is dead or alive,
but also if it's starting.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 7b244cdeb185..2c9dd3ff21eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -590,12 +590,14 @@ struct iwl_trans_ops {
 /**
  * enum iwl_trans_state - state of the transport layer
  *
- * @IWL_TRANS_NO_FW: no fw has sent an alive response
- * @IWL_TRANS_FW_ALIVE: a fw has sent an alive response
+ * @IWL_TRANS_NO_FW: firmware wasn't started yet, or crashed
+ * @IWL_TRANS_FW_STARTED: FW was started, but not alive yet
+ * @IWL_TRANS_FW_ALIVE: FW has sent an alive response
  */
 enum iwl_trans_state {
-	IWL_TRANS_NO_FW = 0,
-	IWL_TRANS_FW_ALIVE	= 1,
+	IWL_TRANS_NO_FW,
+	IWL_TRANS_FW_STARTED,
+	IWL_TRANS_FW_ALIVE,
 };
 
 /**
@@ -1025,12 +1027,18 @@ static inline int iwl_trans_start_fw(struct iwl_trans *trans,
 				     const struct fw_img *fw,
 				     bool run_in_rfkill)
 {
+	int ret;
+
 	might_sleep();
 
 	WARN_ON_ONCE(!trans->rx_mpdu_cmd);
 
 	clear_bit(STATUS_FW_ERROR, &trans->status);
-	return trans->ops->start_fw(trans, fw, run_in_rfkill);
+	ret = trans->ops->start_fw(trans, fw, run_in_rfkill);
+	if (ret == 0)
+		trans->state = IWL_TRANS_FW_STARTED;
+
+	return ret;
 }
 
 static inline void iwl_trans_stop_device(struct iwl_trans *trans)
-- 
2.29.2

