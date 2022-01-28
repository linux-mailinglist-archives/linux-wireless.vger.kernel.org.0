Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A1D49FAD4
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 14:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348961AbiA1New (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 08:34:52 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37866 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348945AbiA1Nev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 08:34:51 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDROr-0002DK-EF;
        Fri, 28 Jan 2022 15:34:50 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 15:34:33 +0200
Message-Id: <iwlwifi.20220128153014.7120a90ed7d2.I9d6d907a2c1b965d1e42ff9f0886b1df627e4761@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128133433.591765-1-luca@coelho.fi>
References: <20220128133433.591765-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 13/13] iwlwifi: mvm: starting from 22000 we have 32 Rx AMPDU sessions
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Those devices have more BAIDs, which is the hardware module
that tracks the BA session.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h         | 1 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c         | 6 +++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index b0b8f067d544..5539d402daa9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -264,6 +264,9 @@ struct iwl_rlc_config_cmd {
 	u8 reserved[3];
 } __packed; /* RLC_CONFIG_CMD_API_S_VER_2 */
 
+#define IWL_MAX_BAID_OLD	16 /* MAX_IMMEDIATE_BA_API_D_VER_2 */
+#define IWL_MAX_BAID		32 /* MAX_IMMEDIATE_BA_API_D_VER_3 */
+
 /**
  * enum iwl_rx_baid_action - BAID allocation/config action
  * @IWL_RX_BAID_ACTION_ADD: add a new BAID session
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 250effb8ed87..3208a7670505 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1097,7 +1097,6 @@ struct iwl_mvm {
 	} cmd_ver;
 
 	struct ieee80211_vif *nan_vif;
-#define IWL_MAX_BAID	32
 	struct iwl_mvm_baid_data __rcu *baid_map[IWL_MAX_BAID];
 
 	/*
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ef4d52672674..c8ffe31ca124 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2464,8 +2464,6 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	return ret;
 }
 
-#define IWL_MAX_RX_BA_SESSIONS 16
-
 static void iwl_mvm_sync_rxq_del_ba(struct iwl_mvm *mvm, u8 baid)
 {
 	struct iwl_mvm_delba_data notif = {
@@ -2657,10 +2655,12 @@ int iwl_mvm_sta_rx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_baid_data *baid_data = NULL;
 	int ret, baid;
+	u32 max_ba_id_sessions = iwl_mvm_has_new_tx_api(mvm) ? IWL_MAX_BAID :
+							       IWL_MAX_BAID_OLD;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (start && mvm->rx_ba_sessions >= IWL_MAX_RX_BA_SESSIONS) {
+	if (start && mvm->rx_ba_sessions >= max_ba_id_sessions) {
 		IWL_WARN(mvm, "Not enough RX BA SESSIONS\n");
 		return -ENOSPC;
 	}
-- 
2.34.1

