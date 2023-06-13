Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6F9072E381
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbjFMM6L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241040AbjFMM6I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A8319B5
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661079; x=1718197079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5L4+AcXhbewiAnOuR6deKo7Z4wld/dxQwRXSzMDbBLs=;
  b=X0olB9n/TwlQNQN9nW/N5bJWohm6+vkjT84z+5KH7X2vbGPWS8zkze0O
   2izEucbQAsw42DzOVcBfkXqdSpsl2BZakHo1l8hkSJV0LgTxJSqTgLXv1
   DbBibE2QkG1Z01/vJakxux8BauwzSOJ3FnPqDawJ1Hdtj887zF8YuxPWa
   o2SQy16LxNs0vq6xr9wy44XGZBYRaScPAX3HmMIyEhvsBnyy5wc/fIuyA
   unmwxsAK99K8Yo2rbIDDHrX1eIZyKznHmkAGIZwnf75apMw9jn2V3M2Gw
   qa3Yih0M+v5fU59ou3FZQQdZ2lz/k6yzbqKSBPwWjUKdKGqBBDFN0uDuU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973754"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973754"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880814"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880814"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:57 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 09/14] wifi: iwlwifi: mvm: put only a single IGTK into FW
Date:   Tue, 13 Jun 2023 15:57:22 +0300
Message-Id: <20230613155501.3fde1ef09270.I2e12a3b0bba4325c07dc8fcce39b711f158bd621@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
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

The firmware only supports a single IGTK, and due to some
changes it really doesn't like to have multiple programmed
in later versions. Since only newer firmware cannot remove
a key that isn't present any more, adjust only the MLD API
code to keep track of the previous IGTK and remove it when
a new one is added.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 +
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 63 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  5 +-
 3 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index f1c7d0bef609..8267ff08e38d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1038,6 +1038,7 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 		mvmvif->link[link_id]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 		mvmvif->link[link_id]->phy_ctxt = NULL;
 		mvmvif->link[link_id]->active = 0;
+		mvmvif->link[link_id]->igtk = NULL;
 	}
 
 	probe_data = rcu_dereference_protected(mvmvif->deflink.probe_resp_data,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 995c0e01b331..b27f6a70f8d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -231,8 +231,49 @@ int iwl_mvm_sec_key_add(struct iwl_mvm *mvm,
 {
 	u32 sta_mask = iwl_mvm_get_sec_sta_mask(mvm, vif, sta, keyconf);
 	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *mvm_link = NULL;
+	int ret;
+
+	if (keyconf->keyidx == 4 || keyconf->keyidx == 5) {
+		unsigned int link_id = 0;
+
+		/* set to -1 for non-MLO right now */
+		if (keyconf->link_id >= 0)
+			link_id = keyconf->link_id;
+
+		mvm_link = mvmvif->link[link_id];
+		if (WARN_ON(!mvm_link))
+			return -EINVAL;
+
+		if (mvm_link->igtk) {
+			IWL_DEBUG_MAC80211(mvm, "remove old IGTK %d\n",
+					   mvm_link->igtk->keyidx);
+			ret = iwl_mvm_sec_key_del(mvm, vif, sta,
+						  mvm_link->igtk);
+			if (ret)
+				IWL_ERR(mvm,
+					"failed to remove old IGTK (ret=%d)\n",
+					ret);
+		}
+
+		WARN_ON(mvm_link->igtk);
+	}
+
+	ret = iwl_mvm_mld_send_key(mvm, sta_mask, key_flags, keyconf);
+	if (ret)
+		return ret;
+
+	if (mvm_link)
+		mvm_link->igtk = keyconf;
 
-	return iwl_mvm_mld_send_key(mvm, sta_mask, key_flags, keyconf);
+	/* We don't really need this, but need it to be not invalid,
+	 * and if we switch links multiple times it might go to be
+	 * invalid when removed.
+	 */
+	keyconf->hw_key_idx = 0;
+
+	return 0;
 }
 
 static int _iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
@@ -243,11 +284,31 @@ static int _iwl_mvm_sec_key_del(struct iwl_mvm *mvm,
 {
 	u32 sta_mask = iwl_mvm_get_sec_sta_mask(mvm, vif, sta, keyconf);
 	u32 key_flags = iwl_mvm_get_sec_flags(mvm, vif, sta, keyconf);
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret;
 
 	if (WARN_ON(!sta_mask))
 		return -EINVAL;
 
+	if (keyconf->keyidx == 4 || keyconf->keyidx == 5) {
+		struct iwl_mvm_vif_link_info *mvm_link;
+		unsigned int link_id = 0;
+
+		/* set to -1 for non-MLO right now */
+		if (keyconf->link_id >= 0)
+			link_id = keyconf->link_id;
+
+		mvm_link = mvmvif->link[link_id];
+		if (WARN_ON(!mvm_link))
+			return -EINVAL;
+
+		if (mvm_link->igtk == keyconf) {
+			/* no longer in HW - mark for later */
+			mvm_link->igtk->hw_key_idx = STA_KEY_IDX_INVALID;
+			mvm_link->igtk = NULL;
+		}
+	}
+
 	ret = __iwl_mvm_sec_key_del(mvm, sta_mask, key_flags, keyconf->keyidx,
 				    flags);
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index b1b46a50f764..8043f5fd26c7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -300,6 +300,7 @@ struct iwl_probe_resp_data {
  * @he_ru_2mhz_block: 26-tone RU OFDMA transmissions should be blocked
  * @queue_params: QoS params for this MAC
  * @mgmt_queue: queue number for unbufferable management frames
+ * @igtk: the current IGTK programmed into the firmware
  */
 struct iwl_mvm_vif_link_info {
 	u8 bssid[ETH_ALEN];
@@ -317,6 +318,8 @@ struct iwl_mvm_vif_link_info {
 	enum ieee80211_smps_mode smps_requests[NUM_IWL_MVM_SMPS_REQ];
 	struct iwl_probe_resp_data __rcu *probe_resp_data;
 
+	struct ieee80211_key_conf *igtk;
+
 	bool he_ru_2mhz_block;
 	bool active;
 
-- 
2.38.1

