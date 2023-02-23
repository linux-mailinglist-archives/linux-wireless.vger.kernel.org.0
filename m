Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E06A05C5
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Feb 2023 11:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbjBWKMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 05:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjBWKMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 05:12:17 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D14FC84
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 02:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677147134; x=1708683134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NiDJIkmFGjTheilq3ovcDExJFtjt8VzuNSCGqI6/VEs=;
  b=G4UW/cypv0fo0avk6eY5Jx+lcFSknz8PnDnDbFzqETUFiYrwXmPi3eQ6
   b/3OZkkPP5V3N3YaScP5PwZumT+AO1VdlZPBP0ujqoTTbehioC869aJVh
   +SucgWYLUTpb+sUEGdQztQjfWTIPzdUWmG05sCxEwUmLeTSwsD8t33CFR
   J9AVaCMrHV0eCHDwZgx1LNkaP1XrBxIeRcueAl4Yz50LFIkARL22TVGwx
   VWtwB/AtOec30KH3+PwRXhMijj8RY7p7CP0jg9ST88TO3YhZfr4iAO5TR
   nVPNor7XM0SE0z1eSgZ+pGWj/9B9WdhlCE2d1I92HlCTZnuEdMFTGcKI6
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="419396363"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="419396363"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="796245415"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="796245415"
Received: from bkalend-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.227.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 02:10:48 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/21] wifi: cfg80211/mac80211: report link ID on control port RX
Date:   Thu, 23 Feb 2023 12:09:32 +0200
Message-Id: <20230223114629.615663f641f1.Iddcab94789cafe336417be406072ce8a6312fc2d@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230223100942.767589-1-gregory.greenman@intel.com>
References: <20230223100942.767589-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For control port RX, report the link ID for MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h |  5 +++--
 net/mac80211/rx.c      |  2 +-
 net/wireless/nl80211.c | 15 ++++++++++-----
 net/wireless/trace.h   | 11 +++++++----
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f0da61c6ec4b..7cebba1c4135 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8126,6 +8126,7 @@ void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
  *	responsible for any cleanup.  The caller must also ensure that
  *	skb->protocol is set appropriately.
  * @unencrypted: Whether the frame was received unencrypted
+ * @link_id: the link the frame was received on, -1 if not applicable or unknown
  *
  * This function is used to inform userspace about a received control port
  * frame.  It should only be used if userspace indicated it wants to receive
@@ -8136,8 +8137,8 @@ void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
  *
  * Return: %true if the frame was passed to userspace
  */
-bool cfg80211_rx_control_port(struct net_device *dev,
-			      struct sk_buff *skb, bool unencrypted);
+bool cfg80211_rx_control_port(struct net_device *dev, struct sk_buff *skb,
+			      bool unencrypted, int link_id);
 
 /**
  * cfg80211_cqm_rssi_notify - connection quality monitoring rssi event
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index f131df282d0b..c7e44bc8ed5a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2591,7 +2591,7 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
-		cfg80211_rx_control_port(dev, skb, noencrypt);
+		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
 		dev_kfree_skb(skb);
 	} else {
 		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f687df8e20f9..22dbc30096b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18755,7 +18755,9 @@ EXPORT_SYMBOL(cfg80211_mgmt_tx_status_ext);
 
 static int __nl80211_rx_control_port(struct net_device *dev,
 				     struct sk_buff *skb,
-				     bool unencrypted, gfp_t gfp)
+				     bool unencrypted,
+				     int link_id,
+				     gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
@@ -18787,6 +18789,8 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 			      NL80211_ATTR_PAD) ||
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
 	    nla_put_u16(msg, NL80211_ATTR_CONTROL_PORT_ETHERTYPE, proto) ||
+	    (link_id >= 0 &&
+	     nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id)) ||
 	    (unencrypted && nla_put_flag(msg,
 					 NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT)))
 		goto nla_put_failure;
@@ -18805,13 +18809,14 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 	return -ENOBUFS;
 }
 
-bool cfg80211_rx_control_port(struct net_device *dev,
-			      struct sk_buff *skb, bool unencrypted)
+bool cfg80211_rx_control_port(struct net_device *dev, struct sk_buff *skb,
+			      bool unencrypted, int link_id)
 {
 	int ret;
 
-	trace_cfg80211_rx_control_port(dev, skb, unencrypted);
-	ret = __nl80211_rx_control_port(dev, skb, unencrypted, GFP_ATOMIC);
+	trace_cfg80211_rx_control_port(dev, skb, unencrypted, link_id);
+	ret = __nl80211_rx_control_port(dev, skb, unencrypted, link_id,
+					GFP_ATOMIC);
 	trace_cfg80211_return_bool(ret == 0);
 	return ret == 0;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index f3fcfc4fcce5..716a1fa70069 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -3165,14 +3165,15 @@ TRACE_EVENT(cfg80211_control_port_tx_status,
 
 TRACE_EVENT(cfg80211_rx_control_port,
 	TP_PROTO(struct net_device *netdev, struct sk_buff *skb,
-		 bool unencrypted),
-	TP_ARGS(netdev, skb, unencrypted),
+		 bool unencrypted, int link_id),
+	TP_ARGS(netdev, skb, unencrypted, link_id),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		__field(int, len)
 		MAC_ENTRY(from)
 		__field(u16, proto)
 		__field(bool, unencrypted)
+		__field(int, link_id)
 	),
 	TP_fast_assign(
 		NETDEV_ASSIGN;
@@ -3180,10 +3181,12 @@ TRACE_EVENT(cfg80211_rx_control_port,
 		MAC_ASSIGN(from, eth_hdr(skb)->h_source);
 		__entry->proto = be16_to_cpu(skb->protocol);
 		__entry->unencrypted = unencrypted;
+		__entry->link_id = link_id;
 	),
-	TP_printk(NETDEV_PR_FMT ", len=%d, %pM, proto: 0x%x, unencrypted: %s",
+	TP_printk(NETDEV_PR_FMT ", len=%d, %pM, proto: 0x%x, unencrypted: %s, link: %d",
 		  NETDEV_PR_ARG, __entry->len, __entry->from,
-		  __entry->proto, BOOL_TO_STR(__entry->unencrypted))
+		  __entry->proto, BOOL_TO_STR(__entry->unencrypted),
+		  __entry->link_id)
 );
 
 TRACE_EVENT(cfg80211_cqm_rssi_notify,
-- 
2.38.1

