Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431F6CB8E7
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Mar 2023 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjC1IAS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Mar 2023 04:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjC1IAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Mar 2023 04:00:16 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16EA44B6
        for <linux-wireless@vger.kernel.org>; Tue, 28 Mar 2023 01:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990413; x=1711526413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mByYTZhGUzFoQ5jzxpu3fW40cxtEYZkJhGWAL40OMqY=;
  b=QU02akhVss0jWgRL6FnDvqiE7hgEt07mgWcWG+FNFtpeWIjCPCF8HRbz
   XZsSjoTOGiK+GV3TwMQGrj9B/he0sTef8PXQ7k8GzAiCAwjv9ZdkD8zsc
   CHq21n5DQOvZhGG6rRLW5MRm0f81gX5tGESp8CaDhGo0qvCAZ/D0PMh21
   E/kp+qrUI8K3VXcwCh30/3WiOeHbiCFup4sX2Qz1dA6QLiF/VPgoqqbKx
   JKXZ/v9nloHhAFP4UWF2EixkcOWO+rMhwRITMb/xUM2t9LqOzkix2Plbb
   8CrZVe+KQsCY+uT6A0ftQT7DFaraM9bxACExROb6d47LEN7ymnF0L0vIX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="328958136"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="328958136"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="773045148"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="773045148"
Received: from gershonr-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.194.136])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 00:59:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/31] wifi: iwlwifi: mvm: fix crash on queue removal for MLD API too
Date:   Tue, 28 Mar 2023 10:58:52 +0300
Message-Id: <20230328104948.527dace26147.Ia215df5833634f95688a979f39fae70c1ac4e027@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230328075911.2370108-1-gregory.greenman@intel.com>
References: <20230328075911.2370108-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The patch linked below fixes the crash on queue removal bug only
for the non-MLD API. Do the same for the MLD API.

Fixes: c5a976cf6a75 ("wifi: iwlwifi: modify new queue allocation command")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c   | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index a6eb18830cd9..fc380e59c740 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -258,27 +258,19 @@ int iwl_mvm_mld_add_aux_sta(struct iwl_mvm *mvm, u32 lmac_id)
 				       IWL_MAX_TID_COUNT, NULL);
 }
 
-static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm,
-				   struct ieee80211_sta *sta,
+static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm, int sta_id,
 				   u16 *queueptr, u8 tid)
 {
-	struct iwl_mvm_sta *mvmsta;
 	int queue = *queueptr;
 	int ret = 0;
 
-	if (!sta)
-		return -EINVAL;
-
-	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
 	if (mvm->sta_remove_requires_queue_remove) {
 		u32 cmd_id = WIDE_ID(DATA_PATH_GROUP,
 				     SCD_QUEUE_CONFIG_CMD);
 		struct iwl_scd_queue_cfg_cmd remove_cmd = {
 			.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
 			.u.remove.tid = cpu_to_le32(tid),
-			.u.remove.sta_mask =
-				cpu_to_le32(BIT(mvmsta->deflink.sta_id)),
+			.u.remove.sta_mask = cpu_to_le32(BIT(sta_id)),
 		};
 
 		ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0,
@@ -308,7 +300,7 @@ static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
 	if (flush)
 		iwl_mvm_flush_sta(mvm, int_sta, true);
 
-	iwl_mvm_mld_disable_txq(mvm, NULL, queuptr, tid);
+	iwl_mvm_mld_disable_txq(mvm, int_sta->sta_id, queuptr, tid);
 
 	ret = iwl_mvm_mld_rm_sta_from_fw(mvm, int_sta->sta_id);
 	if (ret)
@@ -536,8 +528,8 @@ static void iwl_mvm_mld_disable_sta_queues(struct iwl_mvm *mvm,
 		if (mvm_sta->tid_data[i].txq_id == IWL_MVM_INVALID_QUEUE)
 			continue;
 
-		iwl_mvm_mld_disable_txq(mvm, sta, &mvm_sta->tid_data[i].txq_id,
-					i);
+		iwl_mvm_mld_disable_txq(mvm, mvm_sta->deflink.sta_id,
+					&mvm_sta->tid_data[i].txq_id, i);
 		mvm_sta->tid_data[i].txq_id = IWL_MVM_INVALID_QUEUE;
 	}
 
-- 
2.38.1

