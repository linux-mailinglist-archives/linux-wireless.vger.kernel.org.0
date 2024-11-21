Return-Path: <linux-wireless+bounces-15580-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B300A9D553C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 23:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DA7281985
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2024 22:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BC91DC05D;
	Thu, 21 Nov 2024 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GR3b2tn/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B011DC054
	for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2024 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227103; cv=none; b=r+60C/02Hn631sgFHmrUnhzfEfJDm7koUW4FAWjzPT04pgSX1WJuL4uONKfxkLvNVNXu3tKgxvAyJHct9ON6BaDjkvH9z1ou9i8BRXOzz5r1cIuCMF4baoqxghWwlcCi+iL6L9qfRSMfjabnl1uD7GB2UCMCdbum0+hKxeqli3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227103; c=relaxed/simple;
	bh=UgqnE8Tt9bqJgiHBjRfHu5rsd2QzU/1jROB7EZ/Ur5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnY+rScj8hye3YMtNx0ImFqgOgLJBMBFVmcwc7mv0vMaKt6IcqgBjHRH20uGMm/nYxeJvvgyqJQ6VxD5QYAmpzJZscwMXDImy4Wxy9tSdLxAPR8NJlEle/tdDdllkbcb75Y6E6xCHmL6uOGyDjPJJ5Ya+1Qfar1E481rKRF7aAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GR3b2tn/; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c4qbX75d8kq6ZWG9Syeo/cYFkGLoWKk5kjh89J7h+sk=;
	t=1732227102; x=1733436702; b=GR3b2tn/z3q0MT/yUU8X0mm74k8Cw/6xwXhTnyr99D6onDf
	whkEoIbRsgdkDPclYaSOqW+6TGdr4+jFitTLAVsunOOwVXM6XT+K3iZtioVVfuVUFhvLniKnQ2faz
	IOCXArErJWxtnx4vfXLLst9awRwzNwJvDOIsMsak/7h2xrptKYolWihjGeZ0ErOt09Y4YK1ZSXQiT
	PVqrPcb5ge2B6QbPpq4aLrI5w537bpCZA1486XkBk5oDVWlnH3/H6i5Oq3lQPfvSIyoRq0JbbXKHl
	lF6vFa81geN3Q5HMBFN6WBQQ+y90YCDicwETOetRMHPnDtCEXLWRbKDBQTsbItxw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tEFOl-0000000AroR-2eyd;
	Thu, 21 Nov 2024 23:11:39 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: use wiphy guard
Date: Thu, 21 Nov 2024 23:11:38 +0100
Message-ID: <20241121231136.9e02d2b88f8e.I5b06810b7a71860fe3c2efa92ac09f2a13e30d7b@changeid>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
References: <20241121231136.4fede74dcb60.I610c9b14f36902e75e1d13f0db29f8bef2298804@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The wiphy guard simplifies some code here, so use it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs.c | 18 +++++++++---------
 net/mac80211/ethtool.c | 18 ++++++------------
 net/mac80211/iface.c   | 25 +++++++++----------------
 3 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index be2e486907f9..8b42e445a713 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -284,7 +284,8 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	q_limit_low_old = local->aql_txq_limit_low[ac];
 	q_limit_high_old = local->aql_txq_limit_high[ac];
 
-	wiphy_lock(local->hw.wiphy);
+	guard(wiphy)(local->hw.wiphy);
+
 	local->aql_txq_limit_low[ac] = q_limit_low;
 	local->aql_txq_limit_high[ac] = q_limit_high;
 
@@ -296,7 +297,6 @@ static ssize_t aql_txq_limit_write(struct file *file,
 			sta->airtime[ac].aql_limit_high = q_limit_high;
 		}
 	}
-	wiphy_unlock(local->hw.wiphy);
 
 	return count;
 }
@@ -414,10 +414,10 @@ static ssize_t reset_write(struct file *file, const char __user *user_buf,
 	int ret;
 
 	rtnl_lock();
-	wiphy_lock(local->hw.wiphy);
-	__ieee80211_suspend(&local->hw, NULL);
-	ret = __ieee80211_resume(&local->hw);
-	wiphy_unlock(local->hw.wiphy);
+	scoped_guard(wiphy, local->hw.wiphy) {
+		__ieee80211_suspend(&local->hw, NULL);
+		ret = __ieee80211_resume(&local->hw);
+	}
 
 	if (ret)
 		cfg80211_shutdown_all_interfaces(local->hw.wiphy);
@@ -590,9 +590,9 @@ static ssize_t format_devstat_counter(struct ieee80211_local *local,
 	char buf[20];
 	int res;
 
-	wiphy_lock(local->hw.wiphy);
-	res = drv_get_stats(local, &stats);
-	wiphy_unlock(local->hw.wiphy);
+	scoped_guard(wiphy, local->hw.wiphy) {
+		res = drv_get_stats(local, &stats);
+	}
 	if (res)
 		return res;
 	res = printvalue(&stats, buf, sizeof(buf));
diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 99f6174a9d69..069aa05139cd 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -19,16 +19,13 @@ static int ieee80211_set_ringparam(struct net_device *dev,
 				   struct netlink_ext_ack *extack)
 {
 	struct ieee80211_local *local = wiphy_priv(dev->ieee80211_ptr->wiphy);
-	int ret;
 
 	if (rp->rx_mini_pending != 0 || rp->rx_jumbo_pending != 0)
 		return -EINVAL;
 
-	wiphy_lock(local->hw.wiphy);
-	ret = drv_set_ringparam(local, rp->tx_pending, rp->rx_pending);
-	wiphy_unlock(local->hw.wiphy);
+	guard(wiphy)(local->hw.wiphy);
 
-	return ret;
+	return drv_set_ringparam(local, rp->tx_pending, rp->rx_pending);
 }
 
 static void ieee80211_get_ringparam(struct net_device *dev,
@@ -40,10 +37,10 @@ static void ieee80211_get_ringparam(struct net_device *dev,
 
 	memset(rp, 0, sizeof(*rp));
 
-	wiphy_lock(local->hw.wiphy);
+	guard(wiphy)(local->hw.wiphy);
+
 	drv_get_ringparam(local, &rp->tx_pending, &rp->tx_max_pending,
 			  &rp->rx_pending, &rp->rx_max_pending);
-	wiphy_unlock(local->hw.wiphy);
 }
 
 static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
@@ -109,7 +106,7 @@ static void ieee80211_get_stats(struct net_device *dev,
 	 * network device.
 	 */
 
-	wiphy_lock(local->hw.wiphy);
+	guard(wiphy)(local->hw.wiphy);
 
 	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
 		sta = sta_info_get_bss(sdata, sdata->deflink.u.mgd.bssid);
@@ -205,13 +202,10 @@ static void ieee80211_get_stats(struct net_device *dev,
 	else
 		data[i++] = -1LL;
 
-	if (WARN_ON(i != STA_STATS_LEN)) {
-		wiphy_unlock(local->hw.wiphy);
+	if (WARN_ON(i != STA_STATS_LEN))
 		return;
-	}
 
 	drv_get_et_stats(sdata, stats, &(data[STA_STATS_LEN]));
-	wiphy_unlock(local->hw.wiphy);
 }
 
 static void ieee80211_get_strings(struct net_device *dev, u32 sset, u8 *data)
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index a8fbedd530f4..32aaf3856ccf 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -300,7 +300,6 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
-	int ret;
 
 	/*
 	 * This happens during unregistration if there's a bond device
@@ -310,11 +309,9 @@ static int ieee80211_change_mac(struct net_device *dev, void *addr)
 	if (!dev->ieee80211_ptr->registered)
 		return 0;
 
-	wiphy_lock(local->hw.wiphy);
-	ret = _ieee80211_change_mac(sdata, addr);
-	wiphy_unlock(local->hw.wiphy);
+	guard(wiphy)(local->hw.wiphy);
 
-	return ret;
+	return _ieee80211_change_mac(sdata, addr);
 }
 
 static inline int identical_mac_addr_allowed(int type1, int type2)
@@ -450,16 +447,13 @@ static int ieee80211_open(struct net_device *dev)
 	if (!is_valid_ether_addr(dev->dev_addr))
 		return -EADDRNOTAVAIL;
 
-	wiphy_lock(sdata->local->hw.wiphy);
+	guard(wiphy)(sdata->local->hw.wiphy);
+
 	err = ieee80211_check_concurrent_iface(sdata, sdata->vif.type);
 	if (err)
-		goto out;
+		return err;
 
-	err = ieee80211_do_open(&sdata->wdev, true);
-out:
-	wiphy_unlock(sdata->local->hw.wiphy);
-
-	return err;
+	return ieee80211_do_open(&sdata->wdev, true);
 }
 
 static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_down)
@@ -780,11 +774,11 @@ static int ieee80211_stop(struct net_device *dev)
 		ieee80211_stop_mbssid(sdata);
 	}
 
-	wiphy_lock(sdata->local->hw.wiphy);
+	guard(wiphy)(sdata->local->hw.wiphy);
+
 	wiphy_work_cancel(sdata->local->hw.wiphy, &sdata->activate_links_work);
 
 	ieee80211_do_stop(sdata, true);
-	wiphy_unlock(sdata->local->hw.wiphy);
 
 	return 0;
 }
@@ -2282,7 +2276,7 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	 */
 	cfg80211_shutdown_all_interfaces(local->hw.wiphy);
 
-	wiphy_lock(local->hw.wiphy);
+	guard(wiphy)(local->hw.wiphy);
 
 	WARN(local->open_count, "%s: open count remains %d\n",
 	     wiphy_name(local->hw.wiphy), local->open_count);
@@ -2312,7 +2306,6 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 		if (!netdev)
 			kfree(sdata);
 	}
-	wiphy_unlock(local->hw.wiphy);
 }
 
 static int netdev_notify(struct notifier_block *nb,
-- 
2.47.0


