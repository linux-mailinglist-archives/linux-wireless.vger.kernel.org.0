Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493E86E3855
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Apr 2023 14:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbjDPMsK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjDPMsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 08:48:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7C026B5
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 05:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681649286; x=1713185286;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HKZX1IlKMQ+HXoDbTXIyiK9FBTddpb+c5rBvJKbO7aw=;
  b=ljuMyhQOv9AcFhS8OIgitzjqxqeWZY4TWRmF+VmlYymey/lRlY14NOSS
   NYG0llTudqRSGJ9r0qql0LJhIu6d3KMz2GqYQK3tCiUsuTezV6+oH/P4n
   xk+qtw8V5g5DuXwf3Bg2d+NYa9Axl1GqfnKVHINnnkoqKCciam9lskuma
   Au4wJ1gyfOmtxSQWLvBMC5QNaOvt1YBnwHzKZchqx3F8v047uyT9pMZrl
   a8imxE78aZqD7u0Butv25Ce74cSoD3AU1wwXIh1iREMC50rIQR8KU8HDB
   I0EuM1/y/TOFk5bobF0rDv4PXVOPWlROBTBoHSBOO5kr2oWkqjUeDMANA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="333520557"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="333520557"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="640670427"
X-IronPort-AV: E=Sophos;i="5.99,202,1677571200"; 
   d="scan'208";a="640670427"
Received: from lavnon-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.99])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 05:48:03 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: factor out iwl_mvm_sta_fw_id_mask()
Date:   Sun, 16 Apr 2023 15:47:30 +0300
Message-Id: <20230416154301.eff92b93025d.I2c50290a0537d5db3d3460f4d57c78a4712ffb75@changeid>
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

We are going to need this in more places than just the
key code, so factor out the functionality of getting
the FW station ID mask (filtered to a specific link if
needed) to a separate function that can now be called
both under RCU and mvm->mutex protection.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 33 ++---------------
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  | 37 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  2 +
 3 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 7c417b39aca4..a8ab35473924 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -15,10 +15,6 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_vif_link_info *link_info = &mvmvif->deflink;
-	struct iwl_mvm_link_sta *link_sta;
-	struct iwl_mvm_sta *mvmsta;
-	u32 result = 0;
-	int link_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -49,33 +45,10 @@ static u32 iwl_mvm_get_sec_sta_mask(struct iwl_mvm *mvm,
 	if (!sta && (keyconf->link_id >= 0 || !vif->valid_links))
 		return BIT(link_info->ap_sta_id);
 
-	/* this shouldn't happen now */
-	if (!sta)
-		return 0;
+	/* STA should be non-NULL now, but iwl_mvm_sta_fw_id_mask() checks */
 
-	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-	/* it's easy when the STA is not an MLD */
-	if (!sta->valid_links)
-		return BIT(mvmsta->deflink.sta_id);
-
-	/* but if it is an MLD, get the mask of all the FW STAs it has ... */
-	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
-		/* unless we have a specific link in mind (GTK on client) */
-		if (keyconf->link_id >= 0 &&
-		    keyconf->link_id != link_id)
-			continue;
-
-		link_sta =
-			rcu_dereference_protected(mvmsta->link[link_id],
-						  lockdep_is_held(&mvm->mutex));
-		if (!link_sta)
-			continue;
-
-		result |= BIT(link_sta->sta_id);
-	}
-
-	return result;
+	/* pass link_id to filter by it if not -1 (GTK on client) */
+	return iwl_mvm_sta_fw_id_mask(mvm, sta, keyconf->link_id);
 }
 
 static u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index ad71233a2299..c5d25772159b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -4,6 +4,43 @@
  */
 #include "mvm.h"
 #include "time-sync.h"
+#include "sta.h"
+
+u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			   int filter_link_id)
+{
+	struct iwl_mvm_sta *mvmsta;
+	unsigned int link_id;
+	u32 result = 0;
+
+	if (!sta)
+		return 0;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
+	/* it's easy when the STA is not an MLD */
+	if (!sta->valid_links)
+		return BIT(mvmsta->deflink.sta_id);
+
+	/* but if it is an MLD, get the mask of all the FW STAs it has ... */
+	for (link_id = 0; link_id < ARRAY_SIZE(mvmsta->link); link_id++) {
+		struct iwl_mvm_link_sta *link_sta;
+
+		/* unless we have a specific link in mind */
+		if (filter_link_id >= 0 && link_id != filter_link_id)
+			continue;
+
+		link_sta =
+			rcu_dereference_check(mvmsta->link[link_id],
+					      lockdep_is_held(&mvm->mutex));
+		if (!link_sta)
+			continue;
+
+		result |= BIT(link_sta->sta_id);
+	}
+
+	return result;
+}
 
 static int iwl_mvm_mld_send_sta_cmd(struct iwl_mvm *mvm,
 				    struct iwl_mvm_sta_cfg_cmd *cmd)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 7b9e91935aa0..698b9c014cd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -642,6 +642,8 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta,
 				 u16 old_links, u16 new_links);
+u32 iwl_mvm_sta_fw_id_mask(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
+			   int filter_link_id);
 
 /* Queues */
 void iwl_mvm_mld_modify_all_sta_disable_tx(struct iwl_mvm *mvm,
-- 
2.38.1

