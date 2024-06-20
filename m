Return-Path: <linux-wireless+bounces-9295-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8A910281
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 13:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F42283D2C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF691AB916;
	Thu, 20 Jun 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="mr9QkvKP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC15D1AB900
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718882716; cv=none; b=BADFwngqNKc6buEBD4ZLcOPFEx9TMCUA0j5/jKudHocRfyUcernMah/7SPvewJ3O/P/vNzznfKgI5rfn9wn+lWeTWR4MthgqnPKKkiZgYu1jEvpjMWEz902cGEKHuy2rBSDkfUn1y7h91/pY5y8DT+53XPr5w9Hly+4iTiQ3nnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718882716; c=relaxed/simple;
	bh=khs6sI6vGHhttbCx7S1NAQ3eqV42Luwwh4uqPQwN1IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPq/q8LsP8c9omcFDj9Z6jA7fZBNiBVfUvXWaS1Ak0BaWuWaUzKnvMjEb3pJHQ51nQT9m75ETx7DPiRXXEpUoWwIbuBvZDSHaLddGicuQtGcCgwscJfjUoIv4opTrGmfgzogeS39LTIsvtkcSh9gMTBtIKN0VIDWSHIG+egTafo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=mr9QkvKP; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mssQG0ePFtkfU1+YGOVKXuRtNO6XYOyVvFzpGYrXr5o=; b=mr9QkvKPkO/pabpzvcif9WoPqp
	IeKnZcnobvddyvW4nEH2Ms7Bz9vjXcQsEidZZA3+Dv3njAsLnG/kTxsU31Ns+Ys0+V48Us9eDLtIA
	ZF8zBq0BPsAo2SjfBBpfLrhVU3Yy3EqTmO83ch/fZxxcryLKqPfciTDFMd5UmCAHI3Kg=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sKFhM-00Ei9k-1T;
	Thu, 20 Jun 2024 13:11:24 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [PATCH 03/10] wifi: cfg80211: extend interface combination check for multi-radio
Date: Thu, 20 Jun 2024 13:11:15 +0200
Message-ID: <47e02b920cce18ed56e3fa7c93537124ce10024a.1718881762.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
References: <cover.a7730420cfba0f204a60e4c30e6b0e07b441ff6b.1718881762.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a field in struct iface_combination_params to check per-radio
interface combinations instead of per-wiphy ones.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h  |  4 ++++
 net/mac80211/util.c     |  5 ++++-
 net/wireless/rdev-ops.h | 17 +++++++++++++++++
 net/wireless/trace.h    |  5 +++++
 net/wireless/util.c     | 33 ++++++++++++++++++++++++++-------
 5 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8a9ef59413d8..307b77e166c1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1595,6 +1595,7 @@ struct cfg80211_color_change_settings {
  *
  * Used to pass interface combination parameters
  *
+ * @radio_idx: wiphy radio index or -1 for global
  * @num_different_channels: the number of different channels we want
  *	to use for verification
  * @radar_detect: a bitmap where each bit corresponds to a channel
@@ -1608,6 +1609,7 @@ struct cfg80211_color_change_settings {
  *	the verification
  */
 struct iface_combination_params {
+	int radio_idx;
 	int num_different_channels;
 	u8 radar_detect;
 	int iftype_num[NUM_NL80211_IFTYPES];
@@ -4577,6 +4579,7 @@ struct mgmt_frame_regs {
  *
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames.
  * @set_ttlm: set the TID to link mapping.
+ * @get_radio_mask: get bitmask of radios in use
  */
 struct cfg80211_ops {
 	int	(*suspend)(struct wiphy *wiphy, struct cfg80211_wowlan *wow);
@@ -4938,6 +4941,7 @@ struct cfg80211_ops {
 				    struct cfg80211_set_hw_timestamp *hwts);
 	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ttlm_params *params);
+	u32	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev);
 };
 
 /*
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 927f752a0209..0d2927e53114 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3940,6 +3940,7 @@ int ieee80211_check_combinations(struct ieee80211_sub_if_data *sdata,
 	int total = 1;
 	struct iface_combination_params params = {
 		.radar_detect = radar_detect,
+		.radio_idx = -1,
 	};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -4030,7 +4031,9 @@ int ieee80211_max_num_channels(struct ieee80211_local *local)
 	struct ieee80211_chanctx *ctx;
 	u32 max_num_different_channels = 1;
 	int err;
-	struct iface_combination_params params = {0};
+	struct iface_combination_params params = {
+		.radio_idx = -1,
+	};
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 43897a5269b6..56ac6410f4b0 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1542,4 +1542,21 @@ rdev_set_ttlm(struct cfg80211_registered_device *rdev,
 
 	return ret;
 }
+
+static inline u32
+rdev_get_radio_mask(struct cfg80211_registered_device *rdev,
+		    struct net_device *dev)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	u32 ret;
+
+	if (!rdev->ops->get_radio_mask)
+		return 0;
+
+	trace_rdev_get_radio_mask(wiphy, dev);
+	ret = rdev->ops->get_radio_mask(wiphy, dev);
+	trace_rdev_return_int(wiphy, ret);
+
+	return ret;
+}
 #endif /* __CFG80211_RDEV_OPS */
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 14cfa0aba93a..12081e81f9c5 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -4081,6 +4081,11 @@ TRACE_EVENT(cfg80211_links_removed,
 		  __entry->link_mask)
 );
 
+DEFINE_EVENT(wiphy_netdev_evt, rdev_get_radio_mask,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev),
+	TP_ARGS(wiphy, netdev)
+);
+
 #endif /* !__RDEV_OPS_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2bde8a354631..3da04ceb6054 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2305,13 +2305,16 @@ static int cfg80211_wdev_bi(struct wireless_dev *wdev)
 
 static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
 				       u32 *beacon_int_gcd,
-				       bool *beacon_int_different)
+				       bool *beacon_int_different,
+				       int radio_idx)
 {
+	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
 
 	*beacon_int_gcd = 0;
 	*beacon_int_different = false;
 
+	rdev = wiphy_to_rdev(wiphy);
 	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
 		int wdev_bi;
 
@@ -2319,6 +2322,11 @@ static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
 		if (wdev->valid_links)
 			continue;
 
+		/* skip wdevs not active on the given wiphy radio */
+		if (radio_idx >= 0 &&
+		    !(rdev_get_radio_mask(rdev, wdev->netdev) & BIT(radio_idx)))
+			continue;
+
 		wdev_bi = cfg80211_wdev_bi(wdev);
 
 		if (!wdev_bi)
@@ -2366,14 +2374,19 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 					    void *data),
 			       void *data)
 {
+	const struct wiphy_radio *radio = NULL;
+	const struct ieee80211_iface_combination *c, *cs;
 	const struct ieee80211_regdomain *regdom;
 	enum nl80211_dfs_regions region = 0;
-	int i, j, iftype;
+	int i, j, n, iftype;
 	int num_interfaces = 0;
 	u32 used_iftypes = 0;
 	u32 beacon_int_gcd;
 	bool beacon_int_different;
 
+	if (params->radio_idx >= 0)
+		radio = &wiphy->radio[params->radio_idx];
+
 	/*
 	 * This is a bit strange, since the iteration used to rely only on
 	 * the data given by the driver, but here it now relies on context,
@@ -2385,7 +2398,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 	 * interfaces (while being brought up) and channel/radar data.
 	 */
 	cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
-				   &beacon_int_gcd, &beacon_int_different);
+				   &beacon_int_gcd, &beacon_int_different,
+				   params->radio_idx);
 
 	if (params->radar_detect) {
 		rcu_read_lock();
@@ -2402,13 +2416,18 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 			used_iftypes |= BIT(iftype);
 	}
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++) {
-		const struct ieee80211_iface_combination *c;
+	if (radio) {
+		cs = radio->iface_combinations;
+		n = radio->n_iface_combinations;
+	} else {
+		cs = wiphy->iface_combinations;
+		n = wiphy->n_iface_combinations;
+	}
+	for (i = 0; i < n; i++) {
 		struct ieee80211_iface_limit *limits;
 		u32 all_iftypes = 0;
 
-		c = &wiphy->iface_combinations[i];
-
+		c = &cs[i];
 		if (num_interfaces > c->max_interfaces)
 			continue;
 		if (params->num_different_channels > c->num_different_channels)
-- 
git-series 0.9.1

