Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFE86C136E
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 14:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCTNbT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjCTNbP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 09:31:15 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DD358E
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uxsTcGcvNUyMW6GMNAktgjc2sxKO4rP/en99v/qfdKY=; b=lRa1MH6HFDxVsccqq3ZY6uXXJf
        +AojMXsJ4PGDIpn5pq2yKLGtzvu+uwWiZEnmrW+2/spGpRGMaumXjndW8BGDV0TYZtHsi2souD22t
        MM03K7wj5YCYhfALiQx6B575494J3XweeFCJFqropW5KF7N5epzJ23tDhopA11ZgoyI8=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1peFbO-0052pB-Bq; Mon, 20 Mar 2023 14:31:06 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] wifi: mac80211: add support for letting drivers register tc offload support
Date:   Mon, 20 Mar 2023 14:31:03 +0100
Message-Id: <20230320133103.40724-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On newer MediaTek SoCs (e.g. MT7986), WLAN->WLAN or WLAN->Ethernet flows can
be offloaded by the SoC. In order to support that, the .ndo_setup_tc op is
needed.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h     |  9 +++++++++
 net/mac80211/driver-ops.h  | 17 +++++++++++++++++
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       | 17 +++++++++++++++++
 net/mac80211/trace.h       | 25 +++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f12edca660ba..fcfe3e9aff3d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4227,6 +4227,10 @@ struct ieee80211_prep_tx_info {
  * @set_hw_timestamp: Enable/disable HW timestamping of TM/FTM frames. This is
  *	not restored at HW reset by mac80211 so drivers need to take care of
  *	that.
+ * @net_setup_tc: Called from .ndo_setup_tc in order to prepare hardware
+ *	flow offloading for flows originating from the vif.
+ *	Note that the driver must not assume that the vif driver_data is valid
+ *	at this point, since the callback can be called during netdev teardown.
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4593,6 +4597,11 @@ struct ieee80211_ops {
 	int (*set_hw_timestamp)(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif,
 				struct cfg80211_set_hw_timestamp *hwts);
+	int (*net_setup_tc)(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct net_device *dev,
+			    enum tc_setup_type type,
+			    void *type_data);
 };
 
 /**
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index a68d606e6987..0bf208f5bbc5 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1502,6 +1502,23 @@ static inline int drv_net_fill_forward_path(struct ieee80211_local *local,
 	return ret;
 }
 
+static inline int drv_net_setup_tc(struct ieee80211_local *local,
+				   struct ieee80211_sub_if_data *sdata,
+				   struct net_device *dev,
+				   enum tc_setup_type type, void *type_data)
+{
+	int ret = -EOPNOTSUPP;
+
+	sdata = get_bss_sdata(sdata);
+	trace_drv_net_setup_tc(local, sdata, type);
+	if (local->ops->net_setup_tc)
+		ret = local->ops->net_setup_tc(&local->hw, &sdata->vif, dev,
+					       type, type_data);
+	trace_drv_return_int(local, ret);
+
+	return ret;
+}
+
 int drv_change_vif_links(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata,
 			 u16 old_links, u16 new_links,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3d4edc25a69e..b2535614483e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1939,7 +1939,8 @@ void ieee80211_color_collision_detection_work(struct work_struct *work);
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
 					 NETIF_F_HW_CSUM | NETIF_F_SG | \
-					 NETIF_F_HIGHDMA | NETIF_F_GSO_SOFTWARE)
+					 NETIF_F_HIGHDMA | NETIF_F_GSO_SOFTWARE | \
+					 NETIF_F_HW_TC)
 #define MAC80211_SUPPORTED_FEATURES_RX	(NETIF_F_RXCSUM)
 #define MAC80211_SUPPORTED_FEATURES	(MAC80211_SUPPORTED_FEATURES_TX | \
 					 MAC80211_SUPPORTED_FEATURES_RX)
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 23ed13f15067..19d81cc03375 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -813,6 +813,21 @@ ieee80211_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	dev_fetch_sw_netstats(stats, dev->tstats);
 }
 
+static int ieee80211_netdev_setup_tc(struct net_device *dev,
+				     enum tc_setup_type type, void *type_data)
+{
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_local *local;
+
+	sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	local = sdata->local;
+
+	if (!local->ops->net_setup_tc)
+		return -EOPNOTSUPP;
+
+	return drv_net_setup_tc(local, sdata, dev, type, type_data);
+}
+
 static const struct net_device_ops ieee80211_dataif_ops = {
 	.ndo_open		= ieee80211_open,
 	.ndo_stop		= ieee80211_stop,
@@ -821,6 +836,7 @@ static const struct net_device_ops ieee80211_dataif_ops = {
 	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
 	.ndo_set_mac_address 	= ieee80211_change_mac,
 	.ndo_get_stats64	= ieee80211_get_stats64,
+	.ndo_setup_tc		= ieee80211_netdev_setup_tc,
 };
 
 static u16 ieee80211_monitor_select_queue(struct net_device *dev,
@@ -929,6 +945,7 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_set_mac_address	= ieee80211_change_mac,
 	.ndo_get_stats64	= ieee80211_get_stats64,
 	.ndo_fill_forward_path	= ieee80211_netdev_fill_forward_path,
+	.ndo_setup_tc		= ieee80211_netdev_setup_tc,
 };
 
 static bool ieee80211_iftype_supports_hdr_offload(enum nl80211_iftype iftype)
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 9f4377566c42..915ec1fbcaee 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2478,6 +2478,31 @@ DEFINE_EVENT(sta_event, drv_net_fill_forward_path,
 	TP_ARGS(local, sdata, sta)
 );
 
+TRACE_EVENT(drv_net_setup_tc,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 u8 type),
+
+	TP_ARGS(local, sdata, type),
+
+	TP_STRUCT__entry(
+		LOCAL_ENTRY
+		VIF_ENTRY
+		__field(u8, type)
+	),
+
+	TP_fast_assign(
+		LOCAL_ASSIGN;
+		VIF_ASSIGN;
+		__entry->type = type;
+	),
+
+	TP_printk(
+		LOCAL_PR_FMT VIF_PR_FMT " type:%d\n",
+		LOCAL_PR_ARG, VIF_PR_ARG, __entry->type, __entry->new_links
+	)
+);
+
 TRACE_EVENT(drv_change_vif_links,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
-- 
2.39.0

