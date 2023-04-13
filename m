Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B386E0804
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDMHpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDMHpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E8383FA
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371920; x=1712907920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CC0tkvqP3FfANwa5F2bM61FP7ShQZgujKBfcFZPLW2w=;
  b=UApsCllzQYGm5hlPK7hUOWq0P9+cOnc4A9N0ySObaI+pQi7GwJq8W8qA
   jgEdfyE4+igQk9cbfEqRnBrYmQf1Zl6p1AmG6gS/Ac0Exu2xaeo6jcxpw
   8XtOTkZaSxHU1Sn8mxQVXlMZgqGTmMn9/vnwB/SETsjM/24rf2ZTXNV9A
   rP4UKnl2QTgRq/X9TbGNVqY8imB7wlKr0Yl0j1MBFrsOAAGv7CWENcaO8
   ZEtTppWnENJ5RrzTMJahUbrO77kgYZI6FuqXII76lS4Kj7fhBo1ZlXpc/
   i/T1r7JBsR8VRXjsORyJpP6/UkJND4pgYtlD6t5nZ2kNKn8Ie78BBAiaU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735955"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735955"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034725"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034725"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: convert TID to FW value on queue remove
Date:   Thu, 13 Apr 2023 10:44:05 +0300
Message-Id: <20230413102635.6651077eaec3.Ia6868c8fc1a92063609bb057b6a618726712d0bb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

On queue remove, we should convert the TID value to the
firmware value (8 -> 15) just like we do on queue add.
Otherwise, the firmware will not be able to find the
correct queue to remove.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c     | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 78d4f186cd99..ad71233a2299 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -268,6 +268,9 @@ static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm, int sta_id,
 	int queue = *queueptr;
 	int ret = 0;
 
+	if (tid == IWL_MAX_TID_COUNT)
+		tid = IWL_MGMT_TID;
+
 	if (mvm->sta_remove_requires_queue_remove) {
 		u32 cmd_id = WIDE_ID(DATA_PATH_GROUP,
 				     SCD_QUEUE_CONFIG_CMD);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 50e224883af0..6b2690534f59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -356,10 +356,14 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 					     SCD_QUEUE_CONFIG_CMD);
 			struct iwl_scd_queue_cfg_cmd remove_cmd = {
 				.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
-				.u.remove.tid = cpu_to_le32(tid),
 				.u.remove.sta_mask = cpu_to_le32(BIT(sta_id)),
 			};
 
+			if (tid == IWL_MAX_TID_COUNT)
+				tid = IWL_MGMT_TID;
+
+			remove_cmd.u.remove.tid = cpu_to_le32(tid);
+
 			ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0,
 						   sizeof(remove_cmd),
 						   &remove_cmd);
-- 
2.38.1

