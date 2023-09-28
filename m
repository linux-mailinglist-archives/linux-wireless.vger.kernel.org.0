Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA17B1FBB
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjI1OgL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbjI1OgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C7F1BF
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911768; x=1727447768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SX/H/gwT0B7aSEcO25/GuEMOH7pgWIzEnll4yM/wFQ8=;
  b=h8UNWyicnU34GM8eXy/jpPbVEmrsgDFfDn0W8UnZjojIp9n0IrK1EfkE
   2xNF/FmobyEpuXX798uaHHSh0LNQ4Jf9EvUdOgt1i5esi8OSOMpTqWwPF
   82LS3hAyjZC0dTaXH095GujzMqNF+BN+GQbN+7PaszNDFY9bGBWj5Dm/L
   +QzJeqxdz0sC/kiAUR3Dx1ruxfeo+qv1z5ueuF3dEtQ9SK30MyUGbznwt
   fpIURyoQRN/wqGYpYY1oIm29ACDh0IkCxmXkwu7tQ6e+SeVsv3GrOrGtB
   M8AEK7y6LpZOL6JOfMapvM2I5nweYjTiBQbYsTFgfqnYJaBL64wMJTzGQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688438"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688438"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590420"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590420"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:05 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/18] wifi: mac80211: Rename and update IEEE80211_VIF_DISABLE_SMPS_OVERRIDE
Date:   Thu, 28 Sep 2023 17:35:27 +0300
Message-Id: <20230928172905.fb2c2f9a0645.If6df5357568abd623a081f0f33b07e63fb8bba99@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230928143539.1037500-1-gregory.greenman@intel.com>
References: <20230928143539.1037500-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

EMLSR operation and SMPS operation cannot coexist. Thus, when EMLSR is
enabled, all SMPS signaling towards the AP should be stopped (it is
expected that the AP will consider SMPS to be off).

Rename IEEE80211_VIF_DISABLE_SMPS_OVERRIDE to IEEE80211_VIF_EML_ACTIVE
and use the flag as an indication from the driver that EMLSR is enabled.
When EMLSR is enabled SMPS flows towards the AP MLD should be stopped.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 6 +++---
 include/net/mac80211.h                                | 6 +++---
 net/mac80211/cfg.c                                    | 6 ++++++
 net/mac80211/debugfs_netdev.c                         | 5 ++++-
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 5449deb3c2d6..726a3276f715 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -240,8 +240,8 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 
 	mvmvif->esr_active = true;
 
-	/* Disable SMPS overrideing by user */
-	vif->driver_flags |= IEEE80211_VIF_DISABLE_SMPS_OVERRIDE;
+	/* Indicate to mac80211 that EML is enabled */
+	vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
 
 	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_FW,
 					    IEEE80211_SMPS_OFF);
@@ -399,7 +399,7 @@ static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
 
 	mvmvif->esr_active = false;
 
-	vif->driver_flags &= ~IEEE80211_VIF_DISABLE_SMPS_OVERRIDE;
+	vif->driver_flags &= ~IEEE80211_VIF_EML_ACTIVE;
 
 	iwl_mvm_update_smps_on_active_links(mvm, vif, IWL_MVM_SMPS_REQ_FW,
 					    IEEE80211_SMPS_AUTOMATIC);
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a9b73e357462..7dae9aac089c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1767,15 +1767,15 @@ struct ieee80211_channel_switch {
  * @IEEE80211_VIF_GET_NOA_UPDATE: request to handle NOA attributes
  *	and send P2P_PS notification to the driver if NOA changed, even
  *	this is not pure P2P vif.
- * @IEEE80211_VIF_DISABLE_SMPS_OVERRIDE: disable user configuration of
- *	SMPS mode via debugfs.
+ * @IEEE80211_VIF_EML_ACTIVE: The driver indicates that EML operation is
+ *      enabled for the interface.
  */
 enum ieee80211_vif_flags {
 	IEEE80211_VIF_BEACON_FILTER		= BIT(0),
 	IEEE80211_VIF_SUPPORTS_CQM_RSSI		= BIT(1),
 	IEEE80211_VIF_SUPPORTS_UAPSD		= BIT(2),
 	IEEE80211_VIF_GET_NOA_UPDATE		= BIT(3),
-	IEEE80211_VIF_DISABLE_SMPS_OVERRIDE	= BIT(4),
+	IEEE80211_VIF_EML_ACTIVE	        = BIT(4),
 };
 
 
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8f1d128b5eeb..3c167db6ce4e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3152,6 +3152,12 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	old_req = link->u.mgd.req_smps;
 	link->u.mgd.req_smps = smps_mode;
 
+	/* The driver indicated that EML is enabled for the interface, which
+	 * implies that SMPS flows towards the AP should be stopped.
+	 */
+	if (sdata->vif.driver_flags & IEEE80211_VIF_EML_ACTIVE)
+		return 0;
+
 	if (old_req == smps_mode &&
 	    smps_mode != IEEE80211_SMPS_AUTOMATIC)
 		return 0;
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index b383dad18841..ec91e131b29e 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -323,7 +323,10 @@ static int ieee80211_set_smps(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 
-	if (sdata->vif.driver_flags & IEEE80211_VIF_DISABLE_SMPS_OVERRIDE)
+	/* The driver indicated that EML is enabled for the interface, thus do
+	 * not allow to override the SMPS state.
+	 */
+	if (sdata->vif.driver_flags & IEEE80211_VIF_EML_ACTIVE)
 		return -EOPNOTSUPP;
 
 	if (!(local->hw.wiphy->features & NL80211_FEATURE_STATIC_SMPS) &&
-- 
2.38.1

