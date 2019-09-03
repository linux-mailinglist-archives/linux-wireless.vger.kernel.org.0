Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A884A62B5
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 09:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbfICHhx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 03:37:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40322 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725888AbfICHhx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 03:37:53 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i53Nd-0004Cd-M0; Tue, 03 Sep 2019 10:37:34 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Tue,  3 Sep 2019 10:37:04 +0300
Message-Id: <20190903073714.32278-12-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903073714.32278-1-luca@coelho.fi>
References: <20190903073714.32278-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 11/21] iwlwifi: add sta_id to WOWLAN_CONFIG_CMD
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

WoWlan feature within the FW uses the station id for various of reasons.
Thus we need to add this information to the command.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h | 6 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c    | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
index 31231b223aae..4c3219e7beb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/d3.h
@@ -396,6 +396,7 @@ enum iwl_wowlan_flags {
  * @is_11n_connection: indicates HT connection
  * @offloading_tid: TID reserved for firmware use
  * @flags: extra flags, see &enum iwl_wowlan_flags
+ * @sta_id: station ID for wowlan.
  * @reserved: reserved
  */
 struct iwl_wowlan_config_cmd {
@@ -406,8 +407,9 @@ struct iwl_wowlan_config_cmd {
 	u8 is_11n_connection;
 	u8 offloading_tid;
 	u8 flags;
-	u8 reserved[2];
-} __packed; /* WOWLAN_CONFIG_API_S_VER_4 */
+	u8 sta_id;
+	u8 reserved;
+} __packed; /* WOWLAN_CONFIG_API_S_VER_5 */
 
 /*
  * WOWLAN_TSC_RSC_PARAMS
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 66d610a2f3d6..86c2c587e755 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -904,6 +904,8 @@ iwl_mvm_netdetect_config(struct iwl_mvm *mvm,
 		wowlan_config_cmd.wakeup_filter |=
 			cpu_to_le32(IWL_WOWLAN_WAKEUP_RF_KILL_DEASSERT);
 
+	wowlan_config_cmd.sta_id = mvm->aux_sta.sta_id;
+
 	ret = iwl_mvm_send_cmd_pdu(mvm, WOWLAN_CONFIGURATION, 0,
 				   sizeof(wowlan_config_cmd),
 				   &wowlan_config_cmd);
@@ -1011,6 +1013,8 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	} else {
 		struct iwl_wowlan_config_cmd wowlan_config_cmd = {};
 
+		wowlan_config_cmd.sta_id = mvmvif->ap_sta_id;
+
 		ap_sta = rcu_dereference_protected(
 			mvm->fw_id_to_mac_id[mvmvif->ap_sta_id],
 			lockdep_is_held(&mvm->mutex));
-- 
2.23.0.rc1

