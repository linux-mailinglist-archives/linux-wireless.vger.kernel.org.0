Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24E56CD29E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC2HIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjC2HIl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:41 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4FD2D51
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073705; x=1711609705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=buOh4Kbjin8LZRLGGediHaWqyohXOeVSyyt2lIGlxxE=;
  b=AjqkEZjCpsy9b8H8tY+AOLQd/9OmFnIZvZ8NiDGEIsJNp2ERpGEOTT5s
   54/3OQ8KHllzp8AJuOClglzJITG7pIotmctY/2Tw0gmrA1V1FZvGpWECQ
   FlFHK6S/s5syD15shhmKCF9+F13XhoS40MTHfJ8gnLk+JhbsG51pW8Eie
   AaLUPMXA1EGRuTDQ7GJoDkNtfmSJX394qckf75v492jmn2mBMo4kFFpld
   i3iXt8HeLqJhXSGEnqTJojYg2iAVvKuwS5jy+dsWf1rBaUkM3h/IZtKWM
   ZgYpCeiLpXCdivyHEPRZTFlEJxmNuibAoWdrvcoiGuen5aHwx9jYmuzVz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450988"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450988"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111459"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111459"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 28/34] wifi: iwlwifi: mvm: rework active links counting
Date:   Wed, 29 Mar 2023 10:05:34 +0300
Message-Id: <20230329100040.1ecfb27b6b84.I3a5e0bc32b3728e4caae8a231bc3f04ea1d89cad@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

Remove fw_active_links_num counter since we now have a bitmap of
active links in vif. Also, update link activation status only when
LINK_CONTEXT_MODIFY_ACTIVE bit set in changes parameter.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 33 ++++++++++---------
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 --
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 0cd40672fade..eb828de40a3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -104,11 +104,6 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			 link_info->fw_link_id == IWL_MVM_FW_LINK_ID_INVALID))
 		return -EINVAL;
 
-	/* cannot activate third link */
-	if (!link_info->active && active &&
-	    mvmvif->fw_active_links_num >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM)
-		return -EINVAL;
-
 	if (changes & LINK_CONTEXT_MODIFY_ACTIVE) {
 		/* When activating a link, phy context should be valid;
 		 * when deactivating a link, it also should be valid since
@@ -119,6 +114,22 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		if (!link_info->phy_ctxt)
 			return 0;
 
+		/* check there aren't too many active links */
+		if (!link_info->active && active) {
+			int i, count = 0;
+
+			/* link with phy_ctxt is active in FW */
+			for_each_mvm_vif_valid_link(mvmvif, i)
+				if (mvmvif->link[i]->phy_ctxt)
+					count++;
+
+			/* FIXME: IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM should be
+			 * defined per HW
+			 */
+			if (count >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM)
+				return -EINVAL;
+		}
+
 		/* Catch early if driver tries to activate or deactivate a link
 		 * twice.
 		 */
@@ -230,18 +241,8 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	cmd.flags_mask = cpu_to_le32(flags_mask);
 
 	ret = iwl_mvm_link_cmd_send(mvm, &cmd, FW_CTXT_ACTION_MODIFY);
-	if (!ret) {
-		/* the FW is updated, so now it's possible to update the
-		 * activation status. If activating a link, it was already
-		 * checked above that we didn't reach the FW limit.
-		 */
-		if (link_info->active && !active)
-			mvmvif->fw_active_links_num--;
-		else if (!link_info->active && active)
-			mvmvif->fw_active_links_num++;
-
+	if (!ret && (changes & LINK_CONTEXT_MODIFY_ACTIVE))
 		link_info->active = active;
-	}
 
 	return ret;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7fb00220e6cc..ff03c8d52277 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1027,7 +1027,6 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 
 	memset(&mvmvif->bf_data, 0, sizeof(mvmvif->bf_data));
 
-	mvmvif->fw_active_links_num = 0;
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
 		mvmvif->link[link_id]->ap_sta_id = IWL_MVM_INVALID_STA;
 		mvmvif->link[link_id]->fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 23d797247915..022f7bd64a5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -355,7 +355,6 @@ struct iwl_mvm_vif_link_info {
  * @csa_failed: CSA failed to schedule time event, report an error later
  * @csa_bcn_pending: indicates that we are waiting for a beacon on a new channel
  * @features: hw features active for this vif
- * @fw_active_links_num: the number of activated links
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -439,8 +438,6 @@ struct iwl_mvm_vif {
 		struct ieee80211_key_conf __rcu *keys[2];
 	} bcn_prot;
 
-	u32 fw_active_links_num;
-
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
-- 
2.38.1

