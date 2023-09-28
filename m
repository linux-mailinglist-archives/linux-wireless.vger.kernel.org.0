Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5574E7B1FB9
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 16:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjI1OgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1OgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 10:36:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA904136
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695911762; x=1727447762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C45SE3j+1kco9QpPOK/teIoFdDoU36IAcxM9y6GMmGk=;
  b=BEpMl+iXvevSB3kGFrjem/Kcyb+5H1LG3Jp9l6dlnnYx386CUFvVtRCv
   AY+dAJQNc/S9Axf8UnG7Krtpk1xQFHWFGHcvaKoDZQBaSQYmjHmTHn0yz
   XoMfU/k8GdHAqs6SSjieT40wT5HwFOT4IBRgj147IPo223fMD7rPTEb81
   E6Roe+tilNOtWWCviKB5/qlg/gX0oa8k08U5JqXO00ckoeBTTZcEd9x5o
   6SI5BDhSvnBW+twJgOHHZ05CeulyomkN/79xq6QG3GfchnHDHWdMtdI5w
   qh+CQiUZPPcP+vzEGaIT8NL04AWxkqe907GKnX7kZvPwqtMVT0uphxiTa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="688420"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="688420"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:36:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996590406"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="996590406"
Received: from smoriles-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.92.89])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 07:35:59 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/18] wifi: mac80211: add a driver callback to add vif debugfs
Date:   Thu, 28 Sep 2023 17:35:25 +0300
Message-Id: <20230928172905.ac38913f6ab7.Iee731d746bb08fcc628fa776f337016a12dc62ac@changeid>
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

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add a callback which the driver can use to add the vif debugfs.
We used to have this back until commit d260ff12e776 ("mac80211:
remove vif debugfs driver callbacks") where we thought that it
will be easier to just add them during interface add/remove.

However, now with multi-link, we want to have proper debugfs
for drivers for multi-link where some files might be in the
netdev for non-MLO connections, and in the links for MLO ones,
so we need to do some reconstruction when switching the mode.

Moving to this new call enables that and MLO drivers will have
to use it for proper debugfs operation.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/mac80211.h    |  6 ++++++
 net/mac80211/driver-ops.c | 11 ++++++++---
 net/mac80211/driver-ops.h | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72375eceb786..a9b73e357462 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3869,6 +3869,10 @@ struct ieee80211_prep_tx_info {
  *	the station. See @sta_pre_rcu_remove if needed.
  *	This callback can sleep.
  *
+ * @vif_add_debugfs: Drivers can use this callback to add a debugfs vif
+ *	directory with its files. This callback should be within a
+ *	CONFIG_MAC80211_DEBUGFS conditional. This callback can sleep.
+ *
  * @link_add_debugfs: Drivers can use this callback to add debugfs files
  *	when a link is added to a mac80211 vif. This callback should be within
  *	a CONFIG_MAC80211_DEBUGFS conditional. This callback can sleep.
@@ -4368,6 +4372,8 @@ struct ieee80211_ops {
 	int (*sta_remove)(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta);
 #ifdef CONFIG_MAC80211_DEBUGFS
+	void (*vif_add_debugfs)(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif);
 	void (*link_add_debugfs)(struct ieee80211_hw *hw,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_bss_conf *link_conf,
diff --git a/net/mac80211/driver-ops.c b/net/mac80211/driver-ops.c
index 9112715a749a..08861ec61be9 100644
--- a/net/mac80211/driver-ops.c
+++ b/net/mac80211/driver-ops.c
@@ -72,10 +72,15 @@ int drv_add_interface(struct ieee80211_local *local,
 	ret = local->ops->add_interface(&local->hw, &sdata->vif);
 	trace_drv_return_int(local, ret);
 
-	if (ret == 0)
-		sdata->flags |= IEEE80211_SDATA_IN_DRIVER;
+	if (ret)
+		return ret;
 
-	return ret;
+	sdata->flags |= IEEE80211_SDATA_IN_DRIVER;
+
+	if (!local->in_reconfig)
+		drv_vif_add_debugfs(local, sdata);
+
+	return 0;
 }
 
 int drv_change_interface(struct ieee80211_local *local,
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index 77048b9065e6..e07e65da15ee 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -489,6 +489,23 @@ static inline void drv_sta_remove(struct ieee80211_local *local,
 }
 
 #ifdef CONFIG_MAC80211_DEBUGFS
+static inline void drv_vif_add_debugfs(struct ieee80211_local *local,
+				       struct ieee80211_sub_if_data *sdata)
+{
+	might_sleep();
+
+	if (sdata->vif.type == NL80211_IFTYPE_MONITOR ||
+	    WARN_ON(!sdata->vif.debugfs_dir))
+		return;
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	if (local->ops->vif_add_debugfs)
+		local->ops->vif_add_debugfs(&local->hw, &sdata->vif);
+}
+
 static inline void drv_link_add_debugfs(struct ieee80211_local *local,
 					struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_bss_conf *link_conf,
@@ -539,6 +556,12 @@ static inline void drv_link_sta_add_debugfs(struct ieee80211_local *local,
 		local->ops->link_sta_add_debugfs(&local->hw, &sdata->vif,
 						 link_sta, dir);
 }
+#else
+static inline void drv_vif_add_debugfs(struct ieee80211_local *local,
+				       struct ieee80211_sub_if_data *sdata)
+{
+	might_sleep();
+}
 #endif
 
 static inline void drv_sta_pre_rcu_remove(struct ieee80211_local *local,
-- 
2.38.1

