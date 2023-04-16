Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CD36E3854
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjDPMsH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjDPMsF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:05 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72D132
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649283; x=1713185283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T121+5K7VBBgMb8L0woVExjvds9AY6S36Mt4/puKmWs=;
  b=HH8ypenHUt47LQAJ5+/TAz4Xj4xOEIMkD12BwS9d6ayLsTn1WvQEgzpQ
   IOKUiq27KlVStntJwm59fIC5wzK0dy+7Fsx5TnTTFZIeLuUqagoJFeJXt
   pQ0X6UQphvJweU2T5OKia/ZSaeBkTuVHDvK1XXLf0aQwH5ubs1wR0Vx+T
   GkPIkgregNMh7N8EO66r5rcu9DdCq1v2dzDVHm/syRz+cdTv9yH89FF41
   3kYy1//uSLhz7YdhnuB8B65+70rZ9ZFzO9S0ZygKCFGvSXx+wzgoDa/Nh
   P0QL0LYYVHPgoBABZW8X5T+Rn4v/MZVUwpQW4NroZQ5mimubGB00eNPpj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520554"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520554"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670424"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670424"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:01 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: properly implement HE AP support
Date:   Sun, 16 Apr 2023 15:47:29 +0300
Message-Id: <20230416154301.34dbfefe2a49.I0e39cd35dbe03ff9209b26733746479eae1c8966@changeid>
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

The firmware split the HE support field into HE and "pseudo HE",
the latter is really for AP and doesn't implement trigger frame
handling for example.

Use the new field for AP mode.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c   | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index e236d1b0aae2..0bafa3e21cb5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -278,6 +278,7 @@ enum iwl_mac_config_filter_flags {
  * @reserved_for_local_mld_addr: reserved
  * @filter_flags: combination of &enum iwl_mac_config_filter_flags
  * @he_support: does this MAC support HE
+ * @he_ap_support: HE AP enabled, "pseudo HE", no trigger frame handling
  * @eht_support: does this MAC support EHT. Requires he_support
  * @nic_not_ack_enabled: mark that the NIC doesn't support receiving
  *	ACK-enabled AGG, (i.e. both BACK and non-BACK frames in single AGG).
@@ -296,7 +297,8 @@ struct iwl_mac_config_cmd {
 	u8 local_mld_addr[6];
 	__le16 reserved_for_local_mld_addr;
 	__le32 filter_flags;
-	__le32 he_support;
+	__le16 he_support;
+	__le16 he_ap_support;
 	__le32 eht_support;
 	__le32 nic_not_ack_enabled;
 	/* MAC_CONTEXT_CONFIG_SPECIFIC_DATA_API_U_VER_1 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
index ab0ba85936b4..d73ab1712e0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac.c
@@ -4,6 +4,16 @@
  */
 #include "mvm.h"
 
+static void iwl_mvm_mld_set_he_support(struct iwl_mvm *mvm,
+				       struct ieee80211_vif *vif,
+				       struct iwl_mac_config_cmd *cmd)
+{
+	if (vif->type == NL80211_IFTYPE_AP)
+		cmd->he_ap_support = cpu_to_le16(1);
+	else
+		cmd->he_support = cpu_to_le16(1);
+}
+
 static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 					    struct ieee80211_vif *vif,
 					    struct iwl_mac_config_cmd *cmd,
@@ -41,7 +51,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	 * and enable both when we have MLO.
 	 */
 	if (vif->valid_links) {
-		cmd->he_support = cpu_to_le32(1);
+		iwl_mvm_mld_set_he_support(mvm, vif, cmd);
 		cmd->eht_support = cpu_to_le32(1);
 		return;
 	}
@@ -53,7 +63,7 @@ static void iwl_mvm_mld_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 			continue;
 
 		if (link_conf->he_support)
-			cmd->he_support = cpu_to_le32(1);
+			iwl_mvm_mld_set_he_support(mvm, vif, cmd);
 
 		/* it's not reasonable to have EHT without HE and FW API doesn't
 		 * support it. Ignore EHT in this case.
-- 
2.38.1

