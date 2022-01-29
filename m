Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C044A2E22
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237285AbiA2LQj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:39 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37892 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237578AbiA2LQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:37 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDlid-0002ji-RC;
        Sat, 29 Jan 2022 13:16:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:22 +0200
Message-Id: <iwlwifi.20220129105618.b79be7a134e9.I7f5c67d79dd97bf5170492aab356ec983622d3b2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: mvm: add support for CT-KILL notification version 2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

A new version was added to the CT-KILL notification API.
Add support for it.

In addition, print the two fields that was added in this version.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h | 16 +++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c     |  5 +++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index c04f2521fcb3..b1b9c29859c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -166,14 +166,24 @@ struct iwl_dts_measurement_resp {
 
 /**
  * struct ct_kill_notif - CT-kill entry notification
+ * This structure represent both versions of this notification.
  *
  * @temperature: the current temperature in celsius
- * @reserved: reserved
+ * @dts: only in v2: DTS that trigger the CT Kill bitmap:
+ *			bit 0: ToP master
+ *			bit 1: PA chain A master
+ *			bit 2: PA chain B master
+ *			bit 3: ToP slave
+ *			bit 4: PA chain A slave
+ *			bit 5: PA chain B slave)
+ *			bits 6,7: reserved (set to 0)
+ * @scheme: only for v2: scheme that trigger the CT Kill (0-SW, 1-HW)
  */
 struct ct_kill_notif {
 	__le16 temperature;
-	__le16 reserved;
-} __packed; /* GRP_PHY_CT_KILL_NTF */
+	u8 dts;
+	u8 scheme;
+} __packed; /* CT_KILL_NOTIFICATION_API_S_VER_1, CT_KILL_NOTIFICATION_API_S_VER_2 */
 
 /**
 * enum ctdp_cmd_operation - CTDP command operations
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 9409ef7aee83..69cf3a372759 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -160,6 +160,11 @@ void iwl_mvm_ct_kill_notif(struct iwl_mvm *mvm, struct iwl_rx_cmd_buffer *rxb)
 	notif = (struct ct_kill_notif *)pkt->data;
 	IWL_DEBUG_TEMP(mvm, "CT Kill notification temperature = %d\n",
 		       notif->temperature);
+	if (iwl_fw_lookup_notif_ver(mvm->fw, PHY_OPS_GROUP,
+				    CT_KILL_NOTIFICATION, 0) > 1)
+		IWL_DEBUG_TEMP(mvm,
+			       "CT kill notification DTS bitmap = 0x%x, Scheme = %d\n",
+			       notif->dts, notif->scheme);
 
 	iwl_mvm_enter_ctkill(mvm);
 }
-- 
2.34.1

