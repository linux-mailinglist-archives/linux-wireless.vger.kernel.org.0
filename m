Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D159529D7C
	for <lists+linux-wireless@lfdr.de>; Tue, 17 May 2022 11:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbiEQJIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 May 2022 05:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244345AbiEQJHn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 May 2022 05:07:43 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C699520BD7
        for <linux-wireless@vger.kernel.org>; Tue, 17 May 2022 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652778405; x=1684314405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DGSOyS/l9Mp9ua7U5b2t4HvZ60aLMXEX8U7XTxT8758=;
  b=LYJJDGLLrBb37WdX5em7pgcE6+JHSiPI8Q8CFXH7wzm3MxNqzs1/c/5z
   qLvoakJIYc51d7U+Lwq6jyVYHn+kwbHEcVXsDl6XtWI0k94XkNP2bYVoo
   YrxxmuavbS2GDTYbJmbp2j+tYbhKNcCrHihVqPyi1L0FBYAycva0BWwpG
   UJXa3UT7GSo7I4iuROyrRseBs19GQ1U8SwVSQtPHA6ukNc7DgwXkxsF0+
   9ih99FNCFeUXag5ty8qz0Xq1lRH82mc7xjvSPxCw6yZ1EjO8S1QFFvurk
   HM3SOAcMI7YsPO80K3T9knByXeAPXrSYjHbflRSZyJILHkLpohLBq8Blz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="271064812"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="271064812"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:30 -0700
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="741679751"
Received: from sgens-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.212.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 02:06:29 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org
Cc:     johannes@sipsolutions.net, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 07/10] iwlwifi: mvm: always tell the firmware to accept MCAST frames in BSS
Date:   Tue, 17 May 2022 12:05:11 +0300
Message-Id: <20220517120045.479956a46317.I21fac7ede9eca85a662671d694872898df884f0b@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517090514.211796-1-gregory.greenman@intel.com>
References: <20220517090514.211796-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Make the firmware's life easier and always accept MCAST frames. If
needed, drop them in the driver. We need to filter out MCAST frames
in order not to have false positives in the decryption check. If we
accept MCAST frames before we have the GKT installed, we'll end up
complaining that we can't decrypt the frame.
Implement the same filtering, but in the driver.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 13 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 44 ++++++++++++++-----
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index e7f18f549ca9..56fa20596f16 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -552,6 +552,12 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 	/* Fill the common data for all mac context types */
 	iwl_mvm_mac_ctxt_cmd_common(mvm, vif, &cmd, bssid_override, action);
 
+	/*
+	 * We always want to hear MCAST frames, if we're not authorized yet,
+	 * we'll drop them.
+	 */
+	cmd.filter_flags |= cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
+
 	if (vif->p2p) {
 		struct ieee80211_p2p_noa_attr *noa =
 			&vif->bss_conf.p2p_noa_attr;
@@ -608,13 +614,6 @@ static int iwl_mvm_mac_ctxt_cmd_sta(struct iwl_mvm *mvm,
 				IWL_UCODE_TLV_CAPA_COEX_HIGH_PRIO))
 			ctxt_sta->data_policy |=
 				cpu_to_le32(COEX_HIGH_PRIORITY_ENABLE);
-
-		/*
-		 * allow multicast data frames only as long as the station is
-		 * authorized, i.e., GTK keys are already installed (if needed)
-		 */
-		if (mvmvif->authorized)
-			cmd.filter_flags |= cpu_to_le32(MAC_FILTER_ACCEPT_GRP);
 	} else {
 		ctxt_sta->is_assoc = cpu_to_le32(0);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 78198da7e55b..49ca1e168fc5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -326,17 +326,6 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	rx_status = IEEE80211_SKB_RXCB(skb);
 
-	/*
-	 * drop the packet if it has failed being decrypted by HW
-	 */
-	if (iwl_mvm_set_mac80211_rx_flag(mvm, hdr, rx_status, rx_pkt_status,
-					 &crypt_len)) {
-		IWL_DEBUG_DROP(mvm, "Bad decryption results 0x%08x\n",
-			       rx_pkt_status);
-		kfree_skb(skb);
-		return;
-	}
-
 	/*
 	 * Keep packets with CRC errors (and with overrun) for monitor mode
 	 * (otherwise the firmware discards them) but mark them as bad.
@@ -386,6 +375,37 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		sta = ieee80211_find_sta_by_ifaddr(mvm->hw, hdr->addr2, NULL);
 	}
 
+	if (sta) {
+		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+		struct ieee80211_vif *vif = mvmsta->vif;
+		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+		/*
+		 * Don't even try to decrypt a MCAST frame that was received
+		 * before the managed vif is authorized, we'd fail anyway.
+		 */
+		if (vif->type == NL80211_IFTYPE_STATION &&
+		    !mvmvif->authorized &&
+		    is_multicast_ether_addr(hdr->addr1)) {
+			IWL_DEBUG_DROP(mvm, "MCAST before the vif is authorized\n");
+			kfree_skb(skb);
+			rcu_read_unlock();
+			return;
+		}
+	}
+
+	/*
+	 * drop the packet if it has failed being decrypted by HW
+	 */
+	if (iwl_mvm_set_mac80211_rx_flag(mvm, hdr, rx_status, rx_pkt_status,
+					 &crypt_len)) {
+		IWL_DEBUG_DROP(mvm, "Bad decryption results 0x%08x\n",
+			       rx_pkt_status);
+		kfree_skb(skb);
+		rcu_read_unlock();
+		return;
+	}
+
 	if (sta) {
 		struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 		struct ieee80211_vif *tx_blocked_vif =
-- 
2.35.1

