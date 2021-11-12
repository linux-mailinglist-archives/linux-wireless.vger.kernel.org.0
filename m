Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1401E44E6CA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 13:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhKLMyn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 07:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbhKLMym (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 07:54:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF4C061766
        for <linux-wireless@vger.kernel.org>; Fri, 12 Nov 2021 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=PA5EafLckzgmIQfQWBDtXuKrdgjCSOy9kvmfdTYZTY4=; t=1636721512; x=1637931112; 
        b=XSDP4/7T6nZ8rgYUZm64DgGKXTnBL7ZFIT/HkvvhlM315hUIXYR1sJuUYgKeeNqMPvtGVNfopXs
        xr633kJ7ljPSiCogZMbHCOF6pUpJaQV4/wN9ogGEuJaEiYLXzuu92XCNmq2YkBtsqUGCKBUrotbLI
        pBo+ajkMIMtvTedCGDyNGFBY0U+nRsLeSakw4BXfj2wmgdw5IWsRiFPW3/A9IGEk7+kptlGS5k0t8
        LmEUqGt1WxWd44RDm5cTegZZmbTcVl/FZxm5A03CZEDpW87EHsekaaJIf1+ojukmZioZ8VcNP2tQd
        fXhcze9rbDn30loIlFQ0J3fUuga6mldkD02w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mlW1z-00EBaG-Ol;
        Fri, 12 Nov 2021 13:51:47 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix monitor_sdata RCU/locking assertions
Date:   Fri, 12 Nov 2021 13:51:44 +0100
Message-Id: <20211112135143.cb8e8ceffef3.Iaa210f16f6904c8a7a24954fb3396da0ef86ec08@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since commit a05829a7222e ("cfg80211: avoid holding the RTNL when
calling the driver") we've not only been protecting the pointer
to monitor_sdata with the RTNL, but also with the wiphy->mtx. This
is relevant in a number of lockdep assertions, e.g. the one we hit
in ieee80211_set_monitor_channel(). However, we're now protecting
all the assignments/dereferences, even the one in interface iter,
with the wiphy->mtx, so switch over the lockdep assertions to that
lock.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c   | 12 ++++++++----
 net/mac80211/iface.c |  4 +++-
 net/mac80211/util.c  |  7 ++++---
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e2b791c37591..bd3d3195097f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -80,7 +80,8 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* also validate MU-MIMO change */
-	monitor_sdata = rtnl_dereference(local->monitor_sdata);
+	monitor_sdata = wiphy_dereference(local->hw.wiphy,
+					  local->monitor_sdata);
 
 	if (!monitor_sdata &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
@@ -840,7 +841,8 @@ static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
 
 	mutex_lock(&local->mtx);
 	if (local->use_chanctx) {
-		sdata = rtnl_dereference(local->monitor_sdata);
+		sdata = wiphy_dereference(local->hw.wiphy,
+					  local->monitor_sdata);
 		if (sdata) {
 			ieee80211_vif_release_channel(sdata);
 			ret = ieee80211_vif_use_channel(sdata, chandef,
@@ -2707,7 +2709,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 		sdata = IEEE80211_WDEV_TO_SUB_IF(wdev);
 
 		if (sdata->vif.type == NL80211_IFTYPE_MONITOR) {
-			sdata = rtnl_dereference(local->monitor_sdata);
+			sdata = wiphy_dereference(local->hw.wiphy,
+						  local->monitor_sdata);
 			if (!sdata)
 				return -EOPNOTSUPP;
 		}
@@ -2767,7 +2770,8 @@ static int ieee80211_set_tx_power(struct wiphy *wiphy,
 	mutex_unlock(&local->iflist_mtx);
 
 	if (has_monitor) {
-		sdata = rtnl_dereference(local->monitor_sdata);
+		sdata = wiphy_dereference(local->hw.wiphy,
+					  local->monitor_sdata);
 		if (sdata) {
 			sdata->user_power_level = local->user_power_level;
 			if (txp_type != sdata->vif.bss_conf.txpower_type)
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9a2145c8192b..20aa5cc31f77 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -588,7 +588,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	 */
 	if (local->suspended) {
 		WARN_ON(local->wowlan);
-		WARN_ON(rtnl_dereference(local->monitor_sdata));
+		WARN_ON(rcu_access_pointer(local->monitor_sdata));
 		return;
 	}
 
@@ -961,6 +961,7 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 		return 0;
 
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	if (local->monitor_sdata)
 		return 0;
@@ -1028,6 +1029,7 @@ void ieee80211_del_virtual_monitor(struct ieee80211_local *local)
 		return;
 
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(local->hw.wiphy);
 
 	mutex_lock(&local->iflist_mtx);
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 39fa2a50385d..43df2f0c5db9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -796,7 +796,7 @@ static void __iterate_interfaces(struct ieee80211_local *local,
 
 	sdata = rcu_dereference_check(local->monitor_sdata,
 				      lockdep_is_held(&local->iflist_mtx) ||
-				      lockdep_rtnl_is_held());
+				      lockdep_is_held(&local->hw.wiphy->mtx));
 	if (sdata &&
 	    (iter_flags & IEEE80211_IFACE_ITER_RESUME_ALL || !active_only ||
 	     sdata->flags & IEEE80211_SDATA_IN_DRIVER))
@@ -2381,7 +2381,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				   IEEE80211_TPT_LEDTRIG_FL_RADIO, 0);
 
 	/* add interfaces */
-	sdata = rtnl_dereference(local->monitor_sdata);
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
 	if (sdata) {
 		/* in HW restart it exists already */
 		WARN_ON(local->resuming);
@@ -2426,7 +2426,8 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				WARN_ON(drv_add_chanctx(local, ctx));
 		mutex_unlock(&local->chanctx_mtx);
 
-		sdata = rtnl_dereference(local->monitor_sdata);
+		sdata = wiphy_dereference(local->hw.wiphy,
+					  local->monitor_sdata);
 		if (sdata && ieee80211_sdata_running(sdata))
 			ieee80211_assign_chanctx(local, sdata);
 	}
-- 
2.33.1

