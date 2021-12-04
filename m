Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDEE4682F7
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbhLDGje (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50296 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229784AbhLDGjc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:32 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeT-0017AH-Of; Sat, 04 Dec 2021 08:36:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:48 +0200
Message-Id: <iwlwifi.20211204083238.f309942ddd15.Iaa95c602f3a681dd464e10ce2de047aa86fac19c@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: mvm: d3: move GTK rekeys condition
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Move the GTK rekeying condition into iwl_mvm_set_key_rx_seq()
so we can modify it in the next patch. In the next firmware
API revision we'll properly get data for both active GTKs and
will have to install it accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index a19f646a324f..f9b485fcfcdb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1651,8 +1651,12 @@ static void iwl_mvm_convert_key_counters(struct iwl_wowlan_status_data *status,
 
 static void iwl_mvm_set_key_rx_seq(struct iwl_mvm *mvm,
 				   struct ieee80211_key_conf *key,
-				   struct iwl_wowlan_status_data *status)
+				   struct iwl_wowlan_status_data *status,
+				   bool installed)
 {
+	if (status->num_of_gtk_rekeys && !installed)
+		return;
+
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
 	case WLAN_CIPHER_SUITE_GCMP:
@@ -1740,8 +1744,9 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 
 	if (data->status->num_of_gtk_rekeys)
 		ieee80211_remove_key(key);
-	else if (data->last_gtk == key)
-		iwl_mvm_set_key_rx_seq(data->mvm, key, data->status);
+
+	if (data->last_gtk == key)
+		iwl_mvm_set_key_rx_seq(data->mvm, key, data->status, false);
 }
 
 static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
@@ -1825,7 +1830,7 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		key = ieee80211_gtk_rekey_add(vif, &conf.conf);
 		if (IS_ERR(key))
 			return false;
-		iwl_mvm_set_key_rx_seq(mvm, key, status);
+		iwl_mvm_set_key_rx_seq(mvm, key, status, true);
 
 		replay_ctr = cpu_to_be64(status->replay_ctr);
 
-- 
2.33.1

