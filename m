Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7887E9911
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjKMJgF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjKMJgC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:36:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4188410DB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699868159; x=1731404159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Q5yyWsSsZUkSAU1WtN7DkgqlLanE5SqsLrQa28rJKE=;
  b=MObcR+okokCmZSEOqxuXmByvVD6cPM6V8X/JzircQmT6XeMYFP0WB9V2
   kOv4VqbMLQqtzr2VvrqKPVA1AoRkHQZPuHqp9UpWVNH9PkyfKrMr1ZY3+
   wOD6r58vEuezK1fXlW8uOXPB1avlJHH3Lqcz+DlpinVfDKESgDrkjL2e8
   WUTjTar83sndvYF/GrgUjK/5K8mNbP2U7GUD26M8zN1L5UjHFsWhsrrMa
   nU5FJfE6nco/4cGmDG7hLn7pFpqTOxnFLdiI21Td/SvcjD0HMbgA9bXoj
   nGTeafvgg1HQ3OVot2ouHuBB1G54Mxvzduj9/dCzqGD7/B5ntvBADDDUR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369735731"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369735731"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937695267"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937695267"
Received: from tdistelf-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.220.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:57 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 4/6] wifi: cfg80211: Schedule regulatory check on BSS STA channel change
Date:   Mon, 13 Nov 2023 11:35:03 +0200
Message-Id: <20231113112844.15d7a0ee3fda.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231113093505.456824-1-gregory.greenman@intel.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Due to different relaxation policies it may be needed to re-check
channels after a BSS station interface is disconnected or performed a
channel switch.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/nl80211.c | 16 ++++++++++++++++
 net/wireless/reg.c     |  2 +-
 net/wireless/reg.h     |  5 +++++
 net/wireless/sme.c     |  2 ++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c467d11283f7..8477f65f54ce 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9302,6 +9302,17 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
  * case disconnect instead.
  * Also note that the wdev mutex must be held.
  */
+
 void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 
+/**
+ * cfg80211_schedule_channels_check - schedule regulatory check if needed
+ * @netdev: the device to check
+ *
+ * In case the device supports NO_IR or DFS relaxations, schedule regulatory
+ * channels check, as previous concurrent operation conditions may not
+ * hold anymore.
+ */
+void cfg80211_schedule_channels_check(struct net_device *netdev);
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c693ebddd053..413dc2a652a7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19310,6 +19310,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 		break;
 	}
 
+	cfg80211_schedule_channels_check(dev);
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
@@ -20067,6 +20068,21 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_update_owe_info_event);
 
+void cfg80211_schedule_channels_check(struct net_device *netdev)
+{
+	struct wireless_dev *wdev = netdev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+
+	/* Schedule channels check if NO_IR or DFS relaxations are supported */
+	if (wdev->iftype == NL80211_IFTYPE_STATION &&
+	    (wiphy_ext_feature_isset(wiphy,
+				     NL80211_EXT_FEATURE_DFS_CONCURRENT) ||
+	    (IS_ENABLED(CONFIG_CFG80211_REG_RELAX_NO_IR) &&
+	     wiphy->regulatory_flags & REGULATORY_ENABLE_RELAX_NO_IR)))
+		reg_check_channels();
+}
+EXPORT_SYMBOL(cfg80211_schedule_channels_check);
+
 /* initialisation/exit functions */
 
 int __init nl80211_init(void)
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 552c05bbad47..a3210d151653 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2481,7 +2481,7 @@ static void reg_check_chans_work(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static void reg_check_channels(void)
+void reg_check_channels(void)
 {
 	/*
 	 * Give usermode a chance to do something nicer (move to another
diff --git a/net/wireless/reg.h b/net/wireless/reg.h
index a703e53c23ee..a02ef5609f52 100644
--- a/net/wireless/reg.h
+++ b/net/wireless/reg.h
@@ -181,6 +181,11 @@ bool reg_dfs_domain_same(struct wiphy *wiphy1, struct wiphy *wiphy2);
  */
 int reg_reload_regdb(void);
 
+/**
+ * reg_check_channels - schedule regulatory enforcement
+ */
+void reg_check_channels(void);
+
 extern const u8 shipped_regdb_certs[];
 extern unsigned int shipped_regdb_certs_len;
 extern const u8 extra_regdb_certs[];
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index acfe66da7109..c1a880c4af1c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1394,6 +1394,8 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 #endif
 
 	schedule_work(&cfg80211_disconnect_work);
+
+	cfg80211_schedule_channels_check(dev);
 }
 
 void cfg80211_disconnected(struct net_device *dev, u16 reason,
-- 
2.38.1

