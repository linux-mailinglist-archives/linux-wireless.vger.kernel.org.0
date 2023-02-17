Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92EC669AA7C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 12:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBQLe6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 06:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBQLe6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 06:34:58 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4603D0BB
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 03:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=L5g2wcDDN2s5YT4ykIYdX3Voog1NBJkmYu4FwHQv3b0=; t=1676633696; x=1677843296; 
        b=qyKNLbzjFtrX6UH0e4unMp5XmqfiwmlEirrOJ/cYaQ4NnLm3R59mK5PhmbJbaG+plKJI966Xo+U
        rJJeCpF88HbI043JZIc3Kr/hoeXgHrdDR64WGN3p1u3S3EcyUdJCsld3QBevLNPwHrADIfNo5r32g
        G9+vdu76UZjhO768c6Yoew8A37eMgkwiChbDA2666AK8bzqrgZ/iOKGgGjuw6PxRH6ApnR+340zKM
        MmxoAKDRQW8/0NV3BSjGoGQx80DubYcIsyZpvmr6EfNP5zQLPatwJarS2NP3O6T4BayXaVCBN/bSW
        aD6Rhs/abUfwQ3g0tXg9pvBAmburIaEEh6UQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pSz0u-00F0Kq-1O;
        Fri, 17 Feb 2023 12:34:52 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211/mac80211: report link ID on control port RX
Date:   Fri, 17 Feb 2023 12:34:50 +0100
Message-Id: <20230217123449.e2b9b1433808.Iddcab94789cafe336417be406072ce8a6312fc2d@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

For control port RX, report the link ID for MLO.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h |  5 +++--
 net/mac80211/rx.c      |  2 +-
 net/wireless/nl80211.c | 15 ++++++++++-----
 net/wireless/trace.h   | 11 +++++++----
 4 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f115b2550309..2808caac5887 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -8101,6 +8101,7 @@ void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
  *	responsible for any cleanup.  The caller must also ensure that
  *	skb->protocol is set appropriately.
  * @unencrypted: Whether the frame was received unencrypted
+ * @link_id: the link the frame was received on, -1 if not applicable or unknown
  *
  * This function is used to inform userspace about a received control port
  * frame.  It should only be used if userspace indicated it wants to receive
@@ -8111,8 +8112,8 @@ void cfg80211_control_port_tx_status(struct wireless_dev *wdev, u64 cookie,
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
index f7fdfe710951..fd7fc6a037f1 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2582,7 +2582,7 @@ static void ieee80211_deliver_skb_to_local_stack(struct sk_buff *skb,
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 		bool noencrypt = !(status->flag & RX_FLAG_DECRYPTED);
 
-		cfg80211_rx_control_port(dev, skb, noencrypt);
+		cfg80211_rx_control_port(dev, skb, noencrypt, rx->link_id);
 		dev_kfree_skb(skb);
 	} else {
 		struct ethhdr *ehdr = (void *)skb_mac_header(skb);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 112b4bb009c8..5a949a84567d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -18717,7 +18717,9 @@ EXPORT_SYMBOL(cfg80211_mgmt_tx_status_ext);
 
 static int __nl80211_rx_control_port(struct net_device *dev,
 				     struct sk_buff *skb,
-				     bool unencrypted, gfp_t gfp)
+				     bool unencrypted,
+				     int link_id,
+				     gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
@@ -18749,6 +18751,8 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 			      NL80211_ATTR_PAD) ||
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
 	    nla_put_u16(msg, NL80211_ATTR_CONTROL_PORT_ETHERTYPE, proto) ||
+	    (link_id >= 0 &&
+	     nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id)) ||
 	    (unencrypted && nla_put_flag(msg,
 					 NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT)))
 		goto nla_put_failure;
@@ -18767,13 +18771,14 @@ static int __nl80211_rx_control_port(struct net_device *dev,
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
index ca7474eec723..c6e63140d9a2 100644
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
2.39.2

