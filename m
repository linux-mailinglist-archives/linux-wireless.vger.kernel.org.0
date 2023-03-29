Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8F6CD2A5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjC2HIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjC2HIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366C626BA
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073722; x=1711609722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=43GwylzguhU8bQtxUExyD+qSftXtahsm6WT/w1TMdeQ=;
  b=kKEVbOi1VjJjjHx9Xiw1L8C2pvXSAI59R5NaJ6w/KxiIVMe8dXhnBeVi
   Ig3CO+wVeDer+EP8UTgfvQTo6YNDT13nD9oSKhF9Ob/OyL7r/JmI0E/mF
   cUQ8kj44Y6eOtRSUjM15+J+4IrBCO4H5r4/UhFaBiRrCAsyhtVTX46LZW
   +lyfOEtVPEEslCQjeFix5UKIxKwkHZkScqxo8s/xiSJ2ZeXkhDZg3UUU3
   GbCIo0JJUhPvXMFjpRUZXoEIv0aOguesS6gQu6gRNaUr3PwhRMtVCLijH
   i5iN15ZYpjZF67NrpCCq4PiMpDCf2ignafuB0KtY0f189NadnZVmcWfis
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320451035"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320451035"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111531"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111531"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:58 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 33/34] wifi: iwlwifi: separate AP link management queues
Date:   Wed, 29 Mar 2023 10:05:39 +0300
Message-Id: <20230329100040.0671fa976832.Id5aa9856fd5984e447f247e6d0c3979d9794a21a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The link management queues associated with the broadcast stations
were forgotten and so the same queue was used with both broadcast
stations. This leads to lost frames and warnings on cleanup and
HW restart.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c     | 16 ++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c      |  4 ++--
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 26686cc7ff4c..ca788a427fa6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -181,7 +181,7 @@ int iwl_mvm_mld_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
-		queue = &mvm->probe_queue;
+		queue = &mvm_link->mgmt_queue;
 	} else if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 		queue = &mvm->p2p_dev_queue;
 	} else {
@@ -327,7 +327,7 @@ int iwl_mvm_mld_rm_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_ADHOC:
-		queueptr = &mvm->probe_queue;
+		queueptr = &link->mgmt_queue;
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		queueptr = &mvm->p2p_dev_queue;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 022f7bd64a5d..707c930a278f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -299,6 +299,7 @@ struct iwl_probe_resp_data {
  *	data to be inserted into probe response.
  * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked
  * @queue_params: QoS params for this MAC
+ * @mgmt_queue: queue number for unbufferable management frames
  */
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
@@ -329,6 +330,8 @@ struct iwl_mvm_vif_link_info {
 	 * to have the data for the MAC context
 	 */
 	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+
+	u16 mgmt_queue;
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index db6a3419bd31..a57de37f6e02 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2348,10 +2348,18 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 		}
 
 		if (vif->type == NL80211_IFTYPE_AP ||
-		    vif->type == NL80211_IFTYPE_ADHOC)
+		    vif->type == NL80211_IFTYPE_ADHOC) {
+			/* for queue management */
 			mvm->probe_queue = queue;
-		else if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+			/* for use in TX */
+			mvmvif->deflink.mgmt_queue = queue;
+		} else if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 			mvm->p2p_dev_queue = queue;
+		}
+	} else if (vif->type == NL80211_IFTYPE_AP ||
+		   vif->type == NL80211_IFTYPE_ADHOC) {
+		/* set it for use in TX */
+		mvmvif->deflink.mgmt_queue = mvm->probe_queue;
 	}
 
 	return 0;
@@ -2384,6 +2392,10 @@ void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 	queue = *queueptr;
 	iwl_mvm_disable_txq(mvm, NULL, mvmvif->deflink.bcast_sta.sta_id,
 			    queueptr, IWL_MAX_TID_COUNT);
+
+	if (vif->type == NL80211_IFTYPE_AP || vif->type == NL80211_IFTYPE_ADHOC)
+		mvmvif->deflink.mgmt_queue = mvm->probe_queue;
+
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index f5b92d99f39d..2c842938656d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -626,7 +626,7 @@ static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
 		if (ieee80211_is_mgmt(fc) &&
 		    (!ieee80211_is_bufferable_mmpdu(fc) ||
 		     ieee80211_is_deauth(fc) || ieee80211_is_disassoc(fc)))
-			return mvm->probe_queue;
+			return link->mgmt_queue;
 
 		if (!ieee80211_has_order(fc) && !ieee80211_is_probe_req(fc) &&
 		    is_multicast_ether_addr(hdr->addr1))
@@ -634,7 +634,7 @@ static int iwl_mvm_get_ctrl_vif_queue(struct iwl_mvm *mvm,
 
 		WARN_ONCE(info->control.vif->type != NL80211_IFTYPE_ADHOC,
 			  "fc=0x%02x", le16_to_cpu(fc));
-		return mvm->probe_queue;
+		return link->mgmt_queue;
 	case NL80211_IFTYPE_P2P_DEVICE:
 		if (ieee80211_is_mgmt(fc))
 			return mvm->p2p_dev_queue;
-- 
2.38.1

