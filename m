Return-Path: <linux-wireless+bounces-966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25734818388
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 09:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9501F2508B
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 08:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F01125B1;
	Tue, 19 Dec 2023 08:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR6iaUT2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F239011CA8
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702975059; x=1734511059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0DY8q798wnYllk8zyaa8jpBJe25wLvl/6d6tsmjdSI=;
  b=GR6iaUT2uUbZj7edABBD5wqGaKx5EFmNdGqM5JezFEZ8fPnsqhTFXI76
   voNjSRwz7v5Bk/BLWiB5BiZZ9DpRCyj3VEMRjKOKd5ayNCOqXfhlvLxhL
   5FX8O/oOEVSoToB42yWHE/icGjmPdUhJ0LpKw5FfoelJUWvdgVdFODHMp
   Nh8V+vAhKCNcKmd2bZ2zu13bm5GmXG2fP9z5JqrIjtc+JrVs1AV2Dr+Ee
   NmhhsvhuJG+iT8abQfjOxMNxo+Ut3dMyW+tOKy6BABX5k56EB5fk4Wxd3
   eGT3YoLL+4RWAtNJ7yBO6+7fxSVc4qZZWyd6cyJrt6pUJzYhXkcIisua+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="459969184"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="459969184"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="846266216"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="846266216"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:37:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Greenman@web.codeaurora.org, Gregory <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: cfg80211: Schedule regulatory check on BSS STA channel change
Date: Wed, 20 Dec 2023 04:37:50 +0200
Message-Id: <20231220043149.90f03921f61f.I1879d259d8d756159c8060f61f4bce172e6d323e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
References: <20231220023803.2901117-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

Due to different relaxation policies it may be needed to re-check
channels after a BSS station interface is disconnected or performed a
channel switch.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Greenman, Gregory <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 11 +++++++++++
 net/wireless/nl80211.c | 15 +++++++++++++++
 net/wireless/reg.c     |  2 +-
 net/wireless/reg.h     |  5 +++++
 net/wireless/sme.c     |  2 ++
 5 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 868c50b516b8..d8150d8b13e5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9375,6 +9375,17 @@ bool cfg80211_valid_disable_subchannel_bitmap(u16 *bitmap,
  * case disconnect instead.
  * Also note that the wdev mutex must be held.
  */
+
 void cfg80211_links_removed(struct net_device *dev, u16 link_mask);
 
+/**
+ * cfg80211_schedule_channels_check - schedule regulatory check if needed
+ * @wdev: the wireless device to check
+ *
+ * In case the device supports NO_IR or DFS relaxations, schedule regulatory
+ * channels check, as previous concurrent operation conditions may not
+ * hold anymore.
+ */
+void cfg80211_schedule_channels_check(struct wireless_dev *wdev);
+
 #endif /* __NET_CFG80211_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ff2c63d59bb5..f64005d62b19 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19457,6 +19457,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 		break;
 	}
 
+	cfg80211_schedule_channels_check(wdev);
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
@@ -20214,6 +20215,20 @@ void cfg80211_update_owe_info_event(struct net_device *netdev,
 }
 EXPORT_SYMBOL(cfg80211_update_owe_info_event);
 
+void cfg80211_schedule_channels_check(struct wireless_dev *wdev)
+{
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
index 9a61b3322fd2..44684df64734 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2480,7 +2480,7 @@ static void reg_check_chans_work(struct work_struct *work)
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
index acfe66da7109..195c8532734b 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1394,6 +1394,8 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 #endif
 
 	schedule_work(&cfg80211_disconnect_work);
+
+	cfg80211_schedule_channels_check(wdev);
 }
 
 void cfg80211_disconnected(struct net_device *dev, u16 reason,
-- 
2.34.1


