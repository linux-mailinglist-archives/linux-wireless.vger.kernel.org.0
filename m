Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1610C16A1CB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Feb 2020 10:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBXJT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Feb 2020 04:19:27 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:57566 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgBXJT1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Feb 2020 04:19:27 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j69ta-006AMd-E5; Mon, 24 Feb 2020 10:19:22 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Markus Theil <markus.theil@tu-ilmenau.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] Revert "nl80211: add src and dst addr attributes for control port tx/rx"
Date:   Mon, 24 Feb 2020 10:19:12 +0100
Message-Id: <20200224101910.b746e263287a.I9eb15d6895515179d50964dec3550c9dc784bb93@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
References: <20200224101910.b87da63a3cd6.Ic94bc51a370c4aa7d19fbca9b96d90ab703257dc@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit 8c3ed7aa2b9ef666195b789e9b02e28383243fa8.

As Jouni points out, there's really no need for this, since the
RSN pre-authentication frames are normal data frames, not port
control frames (locally).

We can still revert this now since it hasn't actually gone beyond
-next.

Fixes: 8c3ed7aa2b9e ("nl80211: add src and dst addr attributes for control port tx/rx")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h       |  3 +--
 include/uapi/linux/nl80211.h | 16 +---------------
 net/mac80211/ieee80211_i.h   |  3 +--
 net/mac80211/tx.c            |  3 +--
 net/wireless/nl80211.c       | 18 +++---------------
 net/wireless/rdev-ops.h      |  8 ++++----
 net/wireless/trace.h         | 27 ++++++++++-----------------
 7 files changed, 21 insertions(+), 57 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 7ea23caa7301..089ffdd6dba5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3974,8 +3974,7 @@ struct cfg80211_ops {
 	int	(*tx_control_port)(struct wiphy *wiphy,
 				   struct net_device *dev,
 				   const u8 *buf, size_t len,
-				   const u8 *dest, const u8 *src,
-				   const __be16 proto,
+				   const u8 *dest, const __be16 proto,
 				   const bool noencrypt);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 158bccb4a47b..350ab86fe20e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1039,14 +1039,11 @@
  *	a control port frame and as a notification that a control port frame
  *	has been received. %NL80211_ATTR_FRAME is used to specify the
  *	frame contents.  The frame is the raw EAPoL data, without ethernet or
- *	802.11 headers. An optional %NL80211_ATTR_SRC_MAC can be used to send
- *	pre-auth frames to STAs on behalf of other APs.
+ *	802.11 headers.
  *	When used as an event indication %NL80211_ATTR_CONTROL_PORT_ETHERTYPE,
  *	%NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT and %NL80211_ATTR_MAC are added
  *	indicating the protocol type of the received frame; whether the frame
  *	was received unencrypted and the MAC address of the peer respectively.
- *	%NL80211_ATTR_DST_MAC can be used to forward pre-auth frames in
- *	userspace while using AP mode.
  *
  * @NL80211_CMD_RELOAD_REGDB: Request that the regdb firmware file is reloaded.
  *
@@ -2412,9 +2409,6 @@ enum nl80211_commands {
  *	%NL80211_ATTR_AKM_SUITES are default capabilities if AKM suites not
  *	advertised for a specific interface type.
  *
- * @NL80211_ATTR_SRC_MAC: MAC address used in control port over nl80211 transmit
- * @NL80211_ATTR_DST_MAC: MAC address used in control port over nl80211 receive
- *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2883,9 +2877,6 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_IFTYPE_AKM_SUITES,
 
-	NL80211_ATTR_SRC_MAC,
-	NL80211_ATTR_DST_MAC,
-
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5548,10 +5539,6 @@ enum nl80211_feature_flags {
  *	feature, which prevents bufferbloat by using the expected transmission
  *	time to limit the amount of data buffered in the hardware.
  *
- * @NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS: The driver
- *	can use src and dst MAC addresses with control port over nl80211 rx
- *	and tx operations.
- *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5599,7 +5586,6 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
-	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index da9eaa9ee37e..8a49d78ad7c9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1792,8 +1792,7 @@ void ieee80211_check_fast_xmit_iface(struct ieee80211_sub_if_data *sdata);
 void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
-			      const u8 *dest, const u8 *src, __be16 proto,
-			      bool unencrypted);
+			      const u8 *dest, __be16 proto, bool unencrypted);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2645a39cce88..cddaacaa31a3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5283,8 +5283,7 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
-			      const u8 *dest, const u8 *src, __be16 proto,
-			      bool unencrypted)
+			      const u8 *dest, __be16 proto, bool unencrypted)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f0112dabe21e..d795552f97b2 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -634,8 +634,6 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
 	[NL80211_ATTR_VLAN_ID] = NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
 	[NL80211_ATTR_HE_BSS_COLOR] = NLA_POLICY_NESTED(he_bss_color_policy),
-	[NL80211_ATTR_SRC_MAC] = NLA_POLICY_ETH_ADDR,
-	[NL80211_ATTR_DST_MAC] = NLA_POLICY_ETH_ADDR,
 };
 
 /* policy for the key attributes */
@@ -13698,7 +13696,6 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	const u8 *buf;
 	size_t len;
 	u8 *dest;
-	u8 src[ETH_ALEN];
 	u16 proto;
 	bool noencrypt;
 	int err;
@@ -13736,13 +13733,6 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
-	/* copy src address under wdev_lock, as we may copy wdev_address */
-	if (info->attrs[NL80211_ATTR_SRC_MAC])
-		ether_addr_copy(src,
-				nla_data(info->attrs[NL80211_ATTR_SRC_MAC]));
-	else
-		ether_addr_copy(src, wdev_address(wdev));
-
 	wdev_unlock(wdev);
 
 	buf = nla_data(info->attrs[NL80211_ATTR_FRAME]);
@@ -13753,7 +13743,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 		nla_get_flag(info->attrs[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT]);
 
 	return rdev_tx_control_port(rdev, dev, buf, len,
-				    dest, src, cpu_to_be16(proto), noencrypt);
+				    dest, cpu_to_be16(proto), noencrypt);
 
  out:
 	wdev_unlock(wdev);
@@ -16010,8 +16000,7 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct ethhdr *ehdr = eth_hdr(skb);
-	const u8 *daddr = ehdr->h_dest;
-	const u8 *saddr = ehdr->h_source;
+	const u8 *addr = ehdr->h_source;
 	u16 proto = be16_to_cpu(skb->protocol);
 	struct sk_buff *msg;
 	void *hdr;
@@ -16036,8 +16025,7 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, saddr) ||
-	    nla_put(msg, NL80211_ATTR_DST_MAC, ETH_ALEN, daddr) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
 	    nla_put_u16(msg, NL80211_ATTR_CONTROL_PORT_ETHERTYPE, proto) ||
 	    (unencrypted && nla_put_flag(msg,
 					 NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT)))
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index 5ea34c1b60fe..e0d34f796d0b 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -734,14 +734,14 @@ static inline int rdev_mgmt_tx(struct cfg80211_registered_device *rdev,
 static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				       struct net_device *dev,
 				       const void *buf, size_t len,
-				       const u8 *dest, const u8 *src,
-				       __be16 proto, const bool noencrypt)
+				       const u8 *dest, __be16 proto,
+				       const bool noencrypt)
 {
 	int ret;
 	trace_rdev_tx_control_port(&rdev->wiphy, dev, buf, len,
-				   dest, src, proto, noencrypt);
+				   dest, proto, noencrypt);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
-					 dest, src, proto, noencrypt);
+					 dest, proto, noencrypt);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index b6b60e3aea41..3ef1679b0e66 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1928,31 +1928,27 @@ TRACE_EVENT(rdev_mgmt_tx,
 
 TRACE_EVENT(rdev_tx_control_port,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 const u8 *buf, size_t len,
-		 const u8 *dest, const u8 *src, __be16 proto,
+		 const u8 *buf, size_t len, const u8 *dest, __be16 proto,
 		 bool unencrypted),
-	TP_ARGS(wiphy, netdev, buf, len, dest, src, proto, unencrypted),
+	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MAC_ENTRY(dest)
-		MAC_ENTRY(src)
-		__field(u16, proto)
+		__field(__be16, proto)
 		__field(bool, unencrypted)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(dest, dest);
-		MAC_ASSIGN(src, src);
-		__entry->proto = be16_to_cpu(proto);
+		__entry->proto = proto;
 		__entry->unencrypted = unencrypted;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", dest: " MAC_PR_FMT
-		  ", src: " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG,
-		  MAC_PR_ARG(dest), MAC_PR_ARG(src),
-		  __entry->proto,
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ","
+		  " proto: 0x%x, unencrypted: %s",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest),
+		  be16_to_cpu(__entry->proto),
 		  BOOL_TO_STR(__entry->unencrypted))
 );
 
@@ -2844,7 +2840,6 @@ TRACE_EVENT(cfg80211_rx_control_port,
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		__field(int, len)
-		MAC_ENTRY(to)
 		MAC_ENTRY(from)
 		__field(u16, proto)
 		__field(bool, unencrypted)
@@ -2852,14 +2847,12 @@ TRACE_EVENT(cfg80211_rx_control_port,
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		__entry->len = skb->len;
-		MAC_ASSIGN(to, eth_hdr(skb)->h_dest);
 		MAC_ASSIGN(from, eth_hdr(skb)->h_source);
 		__entry->proto = be16_to_cpu(skb->protocol);
 		__entry->unencrypted = unencrypted;
 	),
-	TP_printk(NETDEV_PR_FMT ", len=%d, dest: " MAC_PR_FMT
-		  ", src: " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
-		  NETDEV_PR_ARG, __entry->len, MAC_PR_ARG(to), MAC_PR_ARG(from),
+	TP_printk(NETDEV_PR_FMT ", len=%d, " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
+		  NETDEV_PR_ARG, __entry->len, MAC_PR_ARG(from),
 		  __entry->proto, BOOL_TO_STR(__entry->unencrypted))
 );
 
-- 
2.24.1

