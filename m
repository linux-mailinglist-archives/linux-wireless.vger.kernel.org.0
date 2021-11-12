Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1744E588
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 12:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhKLLZS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 06:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234144AbhKLLZR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 06:25:17 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A75C061767
        for <linux-wireless@vger.kernel.org>; Fri, 12 Nov 2021 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yLaX+vcXHxGC7ayxtVdg2j2J1DiFHDQj4fyZd/hcieQ=; b=JZXlhA0jm17uFC//Zm+BCrYByF
        mQESOuWl35Ek9+n1aZfT3eMCQaP1RDr61ryoolhqZeF2Ti6lyP56vKqGXl1fqlHeoI8dsPv7c5BTR
        t2uv4iTshd3ucVSnTgqy5rquBHY72cSTpztNa5ptzs2Wa3/T0yvXtLzL/x+hdeEu9k78=;
Received: from p54ae9f3f.dip0.t-ipconnect.de ([84.174.159.63] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mlUdV-0002cs-MD; Fri, 12 Nov 2021 12:22:25 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: add support for .ndo_fill_forward_path
Date:   Fri, 12 Nov 2021 12:22:23 +0100
Message-Id: <20211112112223.1209-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows drivers to provide a destination device + info for flow offload
Only supported in combination with 802.3 encap offload

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h     |  7 +++++
 net/mac80211/driver-ops.h  | 22 ++++++++++++++
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/iface.c       | 61 ++++++++++++++++++++++++++++++++++++++
 net/mac80211/trace.h       |  7 +++++
 5 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 775dbb982654..10e6fe215f0f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3952,6 +3952,8 @@ struct ieee80211_prep_tx_info {
  *	radar channel.
  *	The caller is expected to set chandef pointer to NULL in order to
  *	disable offchannel CAC/radar detection.
+ * @net_fill_forward_path: Called from .ndo_fill_forward_path in order to
+ *	resolve a path for hardware flow offloading
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4282,6 +4284,11 @@ struct ieee80211_ops {
 				     struct ieee80211_sta *sta, u8 flowid);
 	int (*set_radar_offchan)(struct ieee80211_hw *hw,
 				 struct cfg80211_chan_def *chandef);
+	int (*net_fill_forward_path)(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     struct net_device_path_ctx *ctx,
+				     struct net_device_path *path);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index cd3731cbf6c6..50a0cdadceec 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1483,4 +1483,26 @@ static inline void drv_twt_teardown_request(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline int drv_net_fill_forward_path(struct ieee80211_local *local,
+					    struct ieee80211_sub_if_data *sdata,
+					    struct ieee80211_sta *sta,
+					    struct net_device_path_ctx *ctx,
+					    struct net_device_path *path)
+{
+	int ret = -EOPNOTSUPP;
+
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return -EIO;
+
+	trace_drv_net_fill_forward_path(local, sdata, sta);
+	if (local->ops->net_fill_forward_path)
+		ret = local->ops->net_fill_forward_path(&local->hw,
+							&sdata->vif, sta,
+							ctx, path);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5666bbb8860b..08c0542c93a3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1463,7 +1463,7 @@ struct ieee80211_local {
 };
 
 static inline struct ieee80211_sub_if_data *
-IEEE80211_DEV_TO_SUB_IF(struct net_device *dev)
+IEEE80211_DEV_TO_SUB_IF(const struct net_device *dev)
 {
 	return netdev_priv(dev);
 }
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9a2145c8192b..6012442cd0d6 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -789,6 +789,66 @@ static const struct net_device_ops ieee80211_monitorif_ops = {
 	.ndo_get_stats64	= ieee80211_get_stats64,
 };
 
+
+static int ieee80211_netdev_fill_forward_path(struct net_device_path_ctx *ctx,
+					      struct net_device_path *path)
+{
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_local *local;
+	struct sta_info *sta;
+	int ret = -ENOENT;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(ctx->dev);
+	local = sdata->local;
+
+	if (!local->ops->net_fill_forward_path)
+		return -EOPNOTSUPP;
+
+	rcu_read_lock();
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP_VLAN:
+		sta = rcu_dereference(sdata->u.vlan.sta);
+		if (sta)
+			break;
+		if (sdata->wdev.use_4addr)
+			goto out;
+		if (is_multicast_ether_addr(ctx->daddr))
+			goto out;
+		sta = sta_info_get_bss(sdata, ctx->daddr);
+		break;
+	case NL80211_IFTYPE_AP:
+		if (is_multicast_ether_addr(ctx->daddr))
+			goto out;
+		sta = sta_info_get(sdata, ctx->daddr);
+		break;
+	case NL80211_IFTYPE_STATION:
+		if (sdata->wdev.wiphy->flags & WIPHY_FLAG_SUPPORTS_TDLS) {
+			sta = sta_info_get(sdata, ctx->daddr);
+			if (sta && test_sta_flag(sta, WLAN_STA_TDLS_PEER)) {
+				if (!test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
+					goto out;
+
+				break;
+			}
+		}
+
+		sta = sta_info_get(sdata, sdata->u.mgd.bssid);
+		break;
+	default:
+		goto out;
+	}
+
+	if (!sta)
+		goto out;
+
+	ret = drv_net_fill_forward_path(local, sdata, &sta->sta, ctx, path);
+out:
+	rcu_read_unlock();
+
+	return ret;
+}
+
+
 static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_open		= ieee80211_open,
 	.ndo_stop		= ieee80211_stop,
@@ -798,6 +858,7 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_set_mac_address	= ieee80211_change_mac,
 	.ndo_select_queue	= ieee80211_netdev_select_queue,
 	.ndo_get_stats64	= ieee80211_get_stats64,
+	.ndo_fill_forward_path	= ieee80211_netdev_fill_forward_path,
 };
 
 static bool ieee80211_iftype_supports_hdr_offload(enum nl80211_iftype iftype)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9e8381bef7ed..d91498f77796 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2892,6 +2892,13 @@ TRACE_EVENT(drv_twt_teardown_request,
 	)
 );
 
+DEFINE_EVENT(sta_event, drv_net_fill_forward_path,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta),
+	TP_ARGS(local, sdata, sta)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.30.1

