Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B62D6EF07
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfGTK0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:26:03 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59438 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727830AbfGTK0C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:26:02 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homYy-0000Hj-3r; Sat, 20 Jul 2019 13:26:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:31 +0300
Message-Id: <20190720102545.5952-3-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 02/16] iwlwifi: mvm: prepare the ground for more RSS notifications
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We will need a new type of synchronization message going
through all the RSS queues. Prepare the ground for this.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index ac9bc65c4d15..23fd3108adb9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2427,7 +2427,7 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 static void iwl_mvm_sync_rxq_del_ba(struct iwl_mvm *mvm, u8 baid)
 {
-	struct iwl_mvm_delba_notif notif = {
+	struct iwl_mvm_rss_sync_notif notif = {
 		.metadata.type = IWL_MVM_RXQ_NOTIF_DEL_BA,
 		.metadata.sync = 1,
 		.delba.baid = baid,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 84139fc38c34..79d655b3fce0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -343,9 +343,11 @@ struct iwl_mvm_delba_data {
 	u32 baid;
 } __packed;
 
-struct iwl_mvm_delba_notif {
+struct iwl_mvm_rss_sync_notif {
 	struct iwl_mvm_internal_rxq_notif metadata;
-	struct iwl_mvm_delba_data delba;
+	union {
+		struct iwl_mvm_delba_data delba;
+	};
 } __packed;
 
 /**
-- 
2.20.1

