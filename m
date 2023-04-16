Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B6A6E385A
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDPMsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDPMsX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5DA2D60
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649296; x=1713185296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aFPAxMkNiauQEhlrshJ2LXsQoWNBzCM3e7g7vdhufBk=;
  b=hAle2QZo5vbto9Bqd/gPZwhFdQmcm2C/8JB/c99DPQRPFqIDb/Qadzdc
   RJeT98Q2zC4N2ud8ymT7lX921t1wUEUoYUdntuBMm7K3l9qbFSJIxq12Y
   tlTlugzBCP/OK2ao1YyQ9Wlho/QpkuRsZy6sX64IMTcucHsnojhhyW6Su
   aX7nDvD72UXgX9xgaOoqn/MiQM+E8jppOkFVJMitZavsiALEDYBAVoG5i
   mKeAT+X9SlX5DVRXfJq/3INmZt/2MQovgJZasCal0lly0eIyIlhiDlyWJ
   yM8OL9Ny3V7u2u4noTIZa5DjoSnqQv2lUt8XCGhmuLlvuUgHeQ+yMHUv6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520571"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520571"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670445"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670445"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: iwlwifi: mvm: implement BAID link switching
Date:   Sun, 16 Apr 2023 15:47:35 +0300
Message-Id: <20230416154301.40654afce24f.I0e35151f69e7513be53ddb8f008e9ab48278c352@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230416124739.1260800-1-gregory.greenman@intel.com>
References: <20230416124739.1260800-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we switch station links, also add the code to switch
BAIDs from one station mask to the new one.

To do so, refactor the switching code a bit to have common
code for all the needed switches; will add keys next.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 80 ++++++++++++++++---
 1 file changed, 70 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 819e05a6f651..36d83e22f0af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -911,11 +911,12 @@ void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
 	rcu_read_unlock();
 }
 
-static int iwl_mvm_mld_update_sta_queue(struct iwl_mvm *mvm,
-					struct iwl_mvm_sta *mvm_sta,
-					u32 old_sta_mask,
-					u32 new_sta_mask)
+static int iwl_mvm_mld_update_sta_queues(struct iwl_mvm *mvm,
+					 struct ieee80211_sta *sta,
+					 u32 old_sta_mask,
+					 u32 new_sta_mask)
 {
+	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_scd_queue_cfg_cmd cmd = {
 		.operation = cpu_to_le32(IWL_SCD_QUEUE_MODIFY),
 		.u.modify.old_sta_mask = cpu_to_le32(old_sta_mask),
@@ -951,6 +952,63 @@ static int iwl_mvm_mld_update_sta_queue(struct iwl_mvm *mvm,
 	return 0;
 }
 
+static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
+					u32 old_sta_mask,
+					u32 new_sta_mask)
+{
+	struct iwl_rx_baid_cfg_cmd cmd = {
+		.action = cpu_to_le32(IWL_RX_BAID_ACTION_MODIFY),
+		.modify.old_sta_id_mask = cpu_to_le32(old_sta_mask),
+		.modify.new_sta_id_mask = cpu_to_le32(new_sta_mask),
+	};
+	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD);
+	int baid;
+
+	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
+
+	for (baid = 0; baid < ARRAY_SIZE(mvm->baid_map); baid++) {
+		struct iwl_mvm_baid_data *data;
+		int ret;
+
+		data = rcu_dereference_protected(mvm->baid_map[baid],
+						 lockdep_is_held(&mvm->mutex));
+		if (!data)
+			continue;
+
+		if (!(data->sta_mask & old_sta_mask))
+			continue;
+
+		WARN_ONCE(data->sta_mask != old_sta_mask,
+			  "BAID data for %d corrupted - expected 0x%x found 0x%x\n",
+			  baid, old_sta_mask, data->sta_mask);
+
+		cmd.modify.tid = cpu_to_le32(data->tid);
+
+		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, sizeof(cmd), &cmd);
+		data->sta_mask = new_sta_mask;
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int iwl_mvm_mld_update_sta_resources(struct iwl_mvm *mvm,
+					    struct ieee80211_sta *sta,
+					    u32 old_sta_mask,
+					    u32 new_sta_mask)
+{
+	int ret;
+
+	ret = iwl_mvm_mld_update_sta_queues(mvm, sta,
+					    old_sta_mask,
+					    new_sta_mask);
+	if (ret)
+		return ret;
+
+	return iwl_mvm_mld_update_sta_baids(mvm, old_sta_mask, new_sta_mask);
+}
+
 int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
@@ -987,9 +1045,10 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 	}
 
 	if (sta_mask_to_rem) {
-		ret = iwl_mvm_mld_update_sta_queue(mvm, mvm_sta,
-						   current_sta_mask,
-						   current_sta_mask & ~sta_mask_to_rem);
+		ret = iwl_mvm_mld_update_sta_resources(mvm, sta,
+						       current_sta_mask,
+						       current_sta_mask &
+							~sta_mask_to_rem);
 		if (WARN_ON(ret))
 			goto err;
 
@@ -1064,9 +1123,10 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 	}
 
 	if (sta_mask_added) {
-		ret = iwl_mvm_mld_update_sta_queue(mvm, mvm_sta,
-						   current_sta_mask,
-						   current_sta_mask | sta_mask_added);
+		ret = iwl_mvm_mld_update_sta_resources(mvm, sta,
+						       current_sta_mask,
+						       current_sta_mask |
+							sta_mask_added);
 		if (WARN_ON(ret))
 			goto err;
 	}
-- 
2.38.1

