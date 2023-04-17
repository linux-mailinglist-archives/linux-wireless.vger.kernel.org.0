Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5189E6E42C4
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 10:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjDQImJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 04:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjDQImH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 04:42:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC74222
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681720926; x=1713256926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8ovJ6YTZpMSUOKRFrWPffY+1oyUCSEZzBzmfp9vNOs=;
  b=N1RXRnPcIdlY3LU/hHYIPMBA3j2AcdJPYwMfpsbAWTUu1eKPAyRGcC3g
   HbhQLuaFTZ3VPRP4OtZdcCkh74k204qKVLADJh9rQ9UUaY3iluFb3qTmN
   sFyblCCO7YB5aQhDcMz7SgXtUzPUVMeVmU7CHTJYqkaX2mA7NLQi2+Crr
   Vks0gdnPtBhI5zmNnuY02VEPRz1oVgUDAtJwxvUesQyWhBWgW1kw9f3wR
   xqFHXVQYUaoy2sXl3XAhLdGS2SKwM5qJazW9ykxu7n8wUQ/fyc5O4IDBk
   34bnndN7vWmDgoHJgpqik+tzer49n9Gvv5aZumL4VZmovs5CFG5jndLOh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333634306"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="333634306"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="693173797"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="693173797"
Received: from odotan1x-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.202.32])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 01:41:53 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: mvm: adopt the latest firmware API
Date:   Mon, 17 Apr 2023 11:41:20 +0300
Message-Id: <20230417113648.92aed4180a06.I277efa343c88081cb3fc890dcbeae3161cdffe16@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230417084134.1338976-1-gregory.greenman@intel.com>
References: <20230417084134.1338976-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The firmware no longer wants the beacon template inside the MAC command.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 10 ----------
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c    |  7 -------
 2 files changed, 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index 0bafa3e21cb5..74f2efbad34e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -223,15 +223,6 @@ struct iwl_mac_client_data {
 	__le32 ctwin;
 } __packed; /* MAC_CONTEXT_CONFIG_CLIENT_DATA_API_S_VER_1 */
 
-/**
- * struct iwl_mac_go_ibss_data - configuration data for GO and IBSS MAC context
- *
- * @beacon_template: beacon template ID
- */
-struct iwl_mac_go_ibss_data {
-	__le32 beacon_template;
-} __packed; /* MAC_CONTEXT_CONFIG_GO_IBSS_DATA_API_S_VER_1 */
-
 /**
  * struct iwl_mac_p2p_dev_data  - configuration data for P2P device MAC context
  *
@@ -304,7 +295,6 @@ struct iwl_mac_config_cmd {
 	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_1 */
 	union {
 		struct iwl_mac_client_data client;
-		struct iwl_mac_go_ibss_data go_ibss;
 		struct iwl_mac_p2p_dev_data p2p_dev;
 	};
 } __packed; /* MAC_CONTEXT_CONFIG_CMD_API_S_VER_1 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index d73ab1712e0e..1717fb52dc12 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -167,7 +167,6 @@ static int iwl_mvm_mld_mac_ctxt_cmd_ibss(struct iwl_mvm *mvm,
 					 struct ieee80211_vif *vif,
 					 u32 action)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mac_config_cmd cmd = {};
 
 	WARN_ON(vif->type != NL80211_IFTYPE_ADHOC);
@@ -178,9 +177,6 @@ static int iwl_mvm_mld_mac_ctxt_cmd_ibss(struct iwl_mvm *mvm,
 				       MAC_CFG_FILTER_ACCEPT_PROBE_REQ |
 				       MAC_CFG_FILTER_ACCEPT_GRP);
 
-	/* TODO: Assumes that the beacon id == mac context id */
-	cmd.go_ibss.beacon_template = cpu_to_le32(mvmvif->id);
-
 	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
 }
 
@@ -220,9 +216,6 @@ static int iwl_mvm_mld_mac_ctxt_cmd_ap_go(struct iwl_mvm *mvm,
 						 MAC_CFG_FILTER_ACCEPT_PROBE_REQ,
 						 MAC_CFG_FILTER_ACCEPT_BEACON);
 
-	/* TODO: Assume that the beacon id == mac context id */
-	cmd.go_ibss.beacon_template = cpu_to_le32(mvmvif->id);
-
 	return iwl_mvm_mld_mac_ctxt_send_cmd(mvm, &cmd);
 }
 
-- 
2.38.1

