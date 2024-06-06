Return-Path: <linux-wireless+bounces-8636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF12C8FF448
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 20:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FAF128C3A9
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950651993AB;
	Thu,  6 Jun 2024 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="QOHIQoCH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBD198E74
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717697240; cv=none; b=KeODmWZ8MXoqHBpL/Cn5PUi4c6qTNCsKBMo3DiUEmw/rtj1KTu3aU1naNlE6caasKca7AqmatpE+JbcPWO9+tzlMMBqxdUs+aZc8oCUrs6JFLLNDmyX5TH8MdQBVjhMLvAalEKBCzhTAISAUz19zwk7DPERMBhcDUt5QGcRXuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717697240; c=relaxed/simple;
	bh=QaQmLgy+3Eigey3N+sivQTze1lolrmlzeM2zMrBVkf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWivrchPaxoTSL3VvSkrrufxvvOf2MTiHmccH3gNZb+rTCbGbDEW+z2hE3keM0pR9he32zA1a2ewRUcaslT6emAbIdsca4GuU6UemhvnBrLpn+zMT2o3T+eiIGBYVmi0uH0f6I/Lvzrf+r+PplEQenwQs/818bj7iEV+3Y8lK2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=QOHIQoCH; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vOCst2QAjVjlhHAvyW0f7/33PkTY6/tNWmZ2vHouG+8=; b=QOHIQoCHbVhtg1dva6hZXi07M1
	gsjMaHzVtlO69hcvCIwnzYlBZDxRpFwxbHo3VR56fEGzXbeQ2URDY+n6OmyrCLi7eaEao76QNpwbZ
	9WzZ3j5qW/9RX6TwsTVcFTR2wdzKqWi+wAIYifp6KDXWgHLBH71bQOvsBBkqDSJ+pyvA=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFHW6-008aic-2j;
	Thu, 06 Jun 2024 20:07:14 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	quic_adisi@quicinc.com,
	quic_periyasa@quicinc.com,
	ath12k@lists.infradead.org
Subject: [RFC v3 3/8] wifi: cfg80211: extend interface combination check for multi-radio
Date: Thu,  6 Jun 2024 20:07:08 +0200
Message-ID: <754815488294f5b7f599b2adba085f1889b53b1a.1717696995.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
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
 include/net/cfg80211.h  |  5 +++++
 net/wireless/rdev-ops.h | 17 +++++++++++++++++
 net/wireless/trace.h    |  5 +++++
 net/wireless/util.c     | 36 +++++++++++++++++++++++++++++-------
 4 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 27355e08ae52..35d4d18e0500 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1595,6 +1595,7 @@ struct cfg80211_color_change_settings {
  *
  * Used to pass interface combination parameters
  *
+ * @radio: when set, check radio specific interface combinations.
  * @num_different_channels: the number of different channels we want
  *	to use for verification
  * @radar_detect: a bitmap where each bit corresponds to a channel
@@ -1608,6 +1609,7 @@ struct cfg80211_color_change_settings {
  *	the verification
  */
 struct iface_combination_params {
+	const struct wiphy_radio *radio;
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
@@ -4938,6 +4941,8 @@ struct cfg80211_ops {
 				    struct cfg80211_set_hw_timestamp *hwts);
 	int	(*set_ttlm)(struct wiphy *wiphy, struct net_device *dev,
 			    struct cfg80211_ttlm_params *params);
+	int	(*get_radio_mask)(struct wiphy *wiphy, struct net_device *dev,
+				  u32 *mask);
 };
 
 /*
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 43897a5269b6..43d72d09ef34 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -1542,4 +1542,21 @@ rdev_set_ttlm(struct cfg80211_registered_device *rdev,
 
 	return ret;
 }
+
+static inline int
+rdev_get_radio_mask(struct cfg80211_registered_device *rdev,
+		    struct net_device *dev, u32 *mask)
+{
+	struct wiphy *wiphy = &rdev->wiphy;
+	int ret;
+
+	if (!rdev->ops->get_radio_mask)
+		return -EOPNOTSUPP;
+
+	trace_rdev_get_radio_mask(wiphy, dev);
+	ret = rdev->ops->get_radio_mask(wiphy, dev, mask);
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
index 2bde8a354631..cab40e4c3491 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2305,20 +2305,35 @@ static int cfg80211_wdev_bi(struct wireless_dev *wdev)
 
 static void cfg80211_calculate_bi_data(struct wiphy *wiphy, u32 new_beacon_int,
 				       u32 *beacon_int_gcd,
-				       bool *beacon_int_different)
+				       bool *beacon_int_different,
+				       const struct wiphy_radio *radio)
 {
+	struct cfg80211_registered_device *rdev;
 	struct wireless_dev *wdev;
+	int radio_idx = -1;
 
 	*beacon_int_gcd = 0;
 	*beacon_int_different = false;
+	if (radio)
+		radio_idx = radio - wiphy->radio;
 
+	rdev = wiphy_to_rdev(wiphy);
 	list_for_each_entry(wdev, &wiphy->wdev_list, list) {
 		int wdev_bi;
+		u32 mask;
 
 		/* this feature isn't supported with MLO */
 		if (wdev->valid_links)
 			continue;
 
+		if (radio_idx >= 0) {
+			if (rdev_get_radio_mask(rdev, wdev->netdev, &mask))
+				continue;
+
+			if (!(mask & BIT(radio_idx)))
+				continue;
+		}
+
 		wdev_bi = cfg80211_wdev_bi(wdev);
 
 		if (!wdev_bi)
@@ -2366,9 +2381,11 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 					    void *data),
 			       void *data)
 {
+	const struct wiphy_radio *radio = params->radio;
+	const struct ieee80211_iface_combination *c;
 	const struct ieee80211_regdomain *regdom;
 	enum nl80211_dfs_regions region = 0;
-	int i, j, iftype;
+	int i, j, n, iftype;
 	int num_interfaces = 0;
 	u32 used_iftypes = 0;
 	u32 beacon_int_gcd;
@@ -2385,7 +2402,8 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 	 * interfaces (while being brought up) and channel/radar data.
 	 */
 	cfg80211_calculate_bi_data(wiphy, params->new_beacon_int,
-				   &beacon_int_gcd, &beacon_int_different);
+				   &beacon_int_gcd, &beacon_int_different,
+				   radio);
 
 	if (params->radar_detect) {
 		rcu_read_lock();
@@ -2402,13 +2420,17 @@ int cfg80211_iter_combinations(struct wiphy *wiphy,
 			used_iftypes |= BIT(iftype);
 	}
 
-	for (i = 0; i < wiphy->n_iface_combinations; i++) {
-		const struct ieee80211_iface_combination *c;
+	if (radio) {
+		c = radio->iface_combinations;
+		n = radio->n_iface_combinations;
+	} else {
+		c = wiphy->iface_combinations;
+		n = wiphy->n_iface_combinations;
+	}
+	for (i = 0; i < n; i++, c++) {
 		struct ieee80211_iface_limit *limits;
 		u32 all_iftypes = 0;
 
-		c = &wiphy->iface_combinations[i];
-
 		if (num_interfaces > c->max_interfaces)
 			continue;
 		if (params->num_different_channels > c->num_different_channels)
-- 
git-series 0.9.1

