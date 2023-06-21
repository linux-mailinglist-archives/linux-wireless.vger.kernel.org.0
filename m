Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896B7382B0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 14:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjFULuQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 07:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjFULuN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 07:50:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E1C10FF
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687348212; x=1718884212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AlrlSWHGjZ7mfT0lXvw4X7aqPdfZlAHKwao6ubq1Zqw=;
  b=ENX8ec9dK82khlTznHuU2eZR6K5T7S339h0VDestoN1vE3Kb9z5xKQlH
   bZnp5+VMoMWTJcT8lC16k7xGMnMRmstU5UWEA7ipimOOWyOzIqoUu2Za+
   dAr4zojq+GnKqu5AaqYIyzvI4ritxzm04Fra7f0M+qzq0tf9UwAqvjwx/
   BhNSVdQm3tSXydbTUKqwAkvrJn80nu/DipIEihkfebKfVbprrlK/Ri0Xp
   Qpqa27j7V555+C4FYSmksEHYdRP7w5VNcFMVTo/yaCXJexdH7C36lYI6l
   vbHqEhguahyH95aJ/UcK2HQoXH3CWt+0TaHli176cGTY0co/Y2nCrXY6N
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="360158302"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="360158302"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="717617501"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="717617501"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 04:50:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/3] wifi: iwlwifi: mvm: Refactor security key update after D3
Date:   Wed, 21 Jun 2023 14:49:50 +0300
Message-Id: <20230621144844.a2442844c224.I598ed742c7aaa5414702f03f694f2dc0874bc077@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

In the D3 resume flow, use two different iterating functions
to go over the old keys and update the new ones

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 82 +++++++++++----------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6d1007f24b4a..d3eb13f3372b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1779,18 +1779,17 @@ struct iwl_mvm_d3_gtk_iter_data {
 	struct iwl_wowlan_status_data *status;
 	void *last_gtk;
 	u32 cipher;
-	bool find_phase, unhandled_cipher;
+	bool unhandled_cipher;
 	int num_keys;
 };
 
-static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
-				   struct ieee80211_vif *vif,
-				   struct ieee80211_sta *sta,
-				   struct ieee80211_key_conf *key,
-				   void *_data)
+static void iwl_mvm_d3_find_last_keys(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta,
+				      struct ieee80211_key_conf *key,
+				      void *_data)
 {
 	struct iwl_mvm_d3_gtk_iter_data *data = _data;
-	struct iwl_wowlan_status_data *status = data->status;
 
 	if (data->unhandled_cipher)
 		return;
@@ -1805,51 +1804,56 @@ static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_TKIP:
 		/* we support these */
+		data->last_gtk = key;
+		data->cipher = key->cipher;
 		break;
 	default:
-		/* everything else (even CMAC for MFP) - disconnect from AP */
+		/* everything else - disconnect from AP */
 		data->unhandled_cipher = true;
 		return;
 	}
 
 	data->num_keys++;
+}
 
-	/*
-	 * pairwise key - update sequence counters only;
-	 * note that this assumes no TDLS sessions are active
-	 */
-	if (sta) {
-		if (data->find_phase)
-			return;
+static void iwl_mvm_d3_update_keys(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   struct ieee80211_key_conf *key,
+				   void *_data)
+{
+	struct iwl_mvm_d3_gtk_iter_data *data = _data;
+	struct iwl_wowlan_status_data *status = data->status;
 
-		switch (key->cipher) {
-		case WLAN_CIPHER_SUITE_CCMP:
-		case WLAN_CIPHER_SUITE_GCMP:
-		case WLAN_CIPHER_SUITE_GCMP_256:
+	if (data->unhandled_cipher)
+		return;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+	case WLAN_CIPHER_SUITE_WEP104:
+		/* ignore WEP completely, nothing to do */
+		return;
+	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		if (sta) {
 			atomic64_set(&key->tx_pn, status->ptk.aes.tx_pn);
 			iwl_mvm_set_aes_ptk_rx_seq(data->mvm, status, sta, key);
-			break;
-		case WLAN_CIPHER_SUITE_TKIP:
+			return;
+		}
+		fallthrough;
+	case WLAN_CIPHER_SUITE_TKIP:
+		if (sta) {
 			atomic64_set(&key->tx_pn, status->ptk.tkip.tx_pn);
 			iwl_mvm_set_key_rx_seq_tids(key, status->ptk.tkip.seq);
-			break;
+			return;
 		}
+		if (data->status->num_of_gtk_rekeys)
+			ieee80211_remove_key(key);
 
-		/* that's it for this key */
-		return;
+		if (data->last_gtk == key)
+			iwl_mvm_set_key_rx_seq(key, data->status, false);
 	}
-
-	if (data->find_phase) {
-		data->last_gtk = key;
-		data->cipher = key->cipher;
-		return;
-	}
-
-	if (data->status->num_of_gtk_rekeys)
-		ieee80211_remove_key(key);
-
-	if (data->last_gtk == key)
-		iwl_mvm_set_key_rx_seq(key, data->status, false);
 }
 
 static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
@@ -1872,9 +1876,8 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 		return false;
 
 	/* find last GTK that we used initially, if any */
-	gtkdata.find_phase = true;
 	ieee80211_iter_keys(mvm->hw, vif,
-			    iwl_mvm_d3_update_keys, &gtkdata);
+			    iwl_mvm_d3_find_last_keys, &gtkdata);
 	/* not trying to keep connections with MFP/unhandled ciphers */
 	if (gtkdata.unhandled_cipher)
 		return false;
@@ -1887,7 +1890,6 @@ static bool iwl_mvm_setup_connection_keep(struct iwl_mvm *mvm,
 	 * invalidate all other GTKs that might still exist and update
 	 * the one that we used
 	 */
-	gtkdata.find_phase = false;
 	ieee80211_iter_keys(mvm->hw, vif,
 			    iwl_mvm_d3_update_keys, &gtkdata);
 
-- 
2.38.1

