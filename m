Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DFF13C205
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAOMza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 07:55:30 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51183 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgAOMza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 07:55:30 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0CD91580063;
        Wed, 15 Jan 2020 13:55:26 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v2] nl80211: use src and dst addr attribute for control port tx/rx
Date:   Wed, 15 Jan 2020 13:55:22 +0100
Message-Id: <20200115125522.3755-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When using control port over nl80211 in AP mode with
pre-authentication, APs need to forward frames to other
APs defined by their MAC address. Before this patch,
pre-auth frames reaching user space over nl80211 control
port  have no longer any information about the dest attached,
which can be used for forwarding to a controller or injecting
the frame back to a ethernet interface over a AF_PACKET
socket.
Analog problems exist, when forwarding pre-auth frames from
AP -> STA.

This patch therefore uses the NL80211_ATTR_DST_MAC and
NL80211_ATTR_SRC_MAC attributes to provide more context
information when forwarding.
The respective arguments are optional on tx and included on rx.
Therefore unaware existing software is not affected.

Software which wants to detect this feature, can do so
by checking against:
  NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/net/cfg80211.h       |  3 ++-
 include/uapi/linux/nl80211.h | 16 +++++++++++++++-
 net/mac80211/ieee80211_i.h   |  3 ++-
 net/mac80211/main.c          |  2 ++
 net/mac80211/tx.c            |  5 +++--
 net/wireless/nl80211.c       | 18 +++++++++++++++---
 net/wireless/rdev-ops.h      |  8 ++++----
 net/wireless/trace.h         | 27 +++++++++++++++++----------
 8 files changed, 60 insertions(+), 22 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fa027d0d031b..5fbd6e613982 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3967,7 +3967,8 @@ struct cfg80211_ops {
 	int	(*tx_control_port)(struct wiphy *wiphy,
 				   struct net_device *dev,
 				   const u8 *buf, size_t len,
-				   const u8 *dest, const __be16 proto,
+				   const u8 *dest, const u8 *src,
+				   const __be16 proto,
 				   const bool noencrypt);
 
 	int	(*get_ftm_responder_stats)(struct wiphy *wiphy,
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 809ef9165684..14ca94303a8c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1039,11 +1039,14 @@
  *	a control port frame and as a notification that a control port frame
  *	has been received. %NL80211_ATTR_FRAME is used to specify the
  *	frame contents.  The frame is the raw EAPoL data, without ethernet or
- *	802.11 headers.
+ *	802.11 headers. An optional %NL80211_ATTR_SRC_MAC can be used to send
+ *	pre-auth frames to STAs on behalf of other APs.
  *	When used as an event indication %NL80211_ATTR_CONTROL_PORT_ETHERTYPE,
  *	%NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT and %NL80211_ATTR_MAC are added
  *	indicating the protocol type of the received frame; whether the frame
  *	was received unencrypted and the MAC address of the peer respectively.
+ *	%NL80211_ATTR_DST_MAC can be used to forward pre-auth frames in
+ *	userspace while using AP mode.
  *
  * @NL80211_CMD_RELOAD_REGDB: Request that the regdb firmware file is reloaded.
  *
@@ -2402,6 +2405,9 @@ enum nl80211_commands {
  *
  * @NL80211_ATTR_HE_BSS_COLOR: nested attribute for BSS Color Settings.
  *
+ * @NL80211_ATTR_SRC_MAC: MAC address used in control port over nl80211 transmit
+ * @NL80211_ATTR_DST_MAC: MAC address used in control port over nl80211 receive
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2868,6 +2874,9 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_BSS_COLOR,
 
+	NL80211_ATTR_SRC_MAC,
+	NL80211_ATTR_DST_MAC,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5525,6 +5534,10 @@ enum nl80211_feature_flags {
  *	feature, which prevents bufferbloat by using the expected transmission
  *	time to limit the amount of data buffered in the hardware.
  *
+ * @NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS: The driver
+ *	can use src and dst MAC addresses with control port over nl80211 rx
+ *	and tx operations.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5572,6 +5585,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
 	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 	NL80211_EXT_FEATURE_AQL,
+	NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e3cf24cb4615..e485a7528678 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1786,7 +1786,8 @@ void ieee80211_check_fast_xmit_iface(struct ieee80211_sub_if_data *sdata);
 void ieee80211_clear_fast_xmit(struct sta_info *sta);
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
-			      const u8 *dest, __be16 proto, bool unencrypted);
+			      const u8 *dest, const u8 *src, __be16 proto,
+			      bool unencrypted);
 int ieee80211_probe_mesh_link(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len);
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2b5ba3ac09..6b90d1206504 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -574,6 +574,8 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_FILS_STA);
 	wiphy_ext_feature_set(wiphy,
 			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211);
+	wiphy_ext_feature_set(wiphy,
+			      NL80211_EXT_FEATURE_CONTROL_PORT_OVER_NL80211_MAC_ADDRS);
 
 	if (!ops->hw_scan) {
 		wiphy->features |= NL80211_FEATURE_LOW_PRIORITY_SCAN |
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 4296d9d71311..a447d258fea3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5285,7 +5285,8 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 
 int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 			      const u8 *buf, size_t len,
-			      const u8 *dest, __be16 proto, bool unencrypted)
+			      const u8 *dest, const u8 *src, __be16 proto,
+			      bool unencrypted)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_local *local = sdata->local;
@@ -5316,7 +5317,7 @@ int ieee80211_tx_control_port(struct wiphy *wiphy, struct net_device *dev,
 
 	ehdr = skb_push(skb, sizeof(struct ethhdr));
 	memcpy(ehdr->h_dest, dest, ETH_ALEN);
-	memcpy(ehdr->h_source, sdata->vif.addr, ETH_ALEN);
+	memcpy(ehdr->h_source, src, ETH_ALEN);
 	ehdr->h_proto = proto;
 
 	skb->dev = dev;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 00f24d4c623e..c7255803475d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -633,6 +633,8 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
 	[NL80211_ATTR_VLAN_ID] = NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
 	[NL80211_ATTR_HE_BSS_COLOR] = NLA_POLICY_NESTED(he_bss_color_policy),
+	[NL80211_ATTR_SRC_MAC] = NLA_POLICY_ETH_ADDR,
+	[NL80211_ATTR_DST_MAC] = NLA_POLICY_ETH_ADDR,
 };
 
 /* policy for the key attributes */
@@ -13647,6 +13649,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 	const u8 *buf;
 	size_t len;
 	u8 *dest;
+	u8 src[ETH_ALEN];
 	u16 proto;
 	bool noencrypt;
 	int err;
@@ -13684,6 +13687,13 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 		goto out;
 	}
 
+	/* copy src address under wdev_lock, as we may copy wdev_address */
+	if (info->attrs[NL80211_ATTR_SRC_MAC])
+		ether_addr_copy(src,
+				nla_data(info->attrs[NL80211_ATTR_SRC_MAC]));
+	else
+		ether_addr_copy(src, wdev_address(wdev));
+
 	wdev_unlock(wdev);
 
 	buf = nla_data(info->attrs[NL80211_ATTR_FRAME]);
@@ -13694,7 +13704,7 @@ static int nl80211_tx_control_port(struct sk_buff *skb, struct genl_info *info)
 		nla_get_flag(info->attrs[NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT]);
 
 	return rdev_tx_control_port(rdev, dev, buf, len,
-				    dest, cpu_to_be16(proto), noencrypt);
+				    dest, src, cpu_to_be16(proto), noencrypt);
 
  out:
 	wdev_unlock(wdev);
@@ -15949,7 +15959,8 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 	struct ethhdr *ehdr = eth_hdr(skb);
-	const u8 *addr = ehdr->h_source;
+	const u8 *daddr = ehdr->h_dest;
+	const u8 *saddr = ehdr->h_source;
 	u16 proto = be16_to_cpu(skb->protocol);
 	struct sk_buff *msg;
 	void *hdr;
@@ -15974,7 +15985,8 @@ static int __nl80211_rx_control_port(struct net_device *dev,
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, addr) ||
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, saddr) ||
+	    nla_put(msg, NL80211_ATTR_DST_MAC, ETH_ALEN, daddr) ||
 	    nla_put_u16(msg, NL80211_ATTR_CONTROL_PORT_ETHERTYPE, proto) ||
 	    (unencrypted && nla_put_flag(msg,
 					 NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT)))
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index e853a4fe6f97..39e6c1db3092 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -730,14 +730,14 @@ static inline int rdev_mgmt_tx(struct cfg80211_registered_device *rdev,
 static inline int rdev_tx_control_port(struct cfg80211_registered_device *rdev,
 				       struct net_device *dev,
 				       const void *buf, size_t len,
-				       const u8 *dest, __be16 proto,
-				       const bool noencrypt)
+				       const u8 *dest, const u8 *src,
+				       __be16 proto, const bool noencrypt)
 {
 	int ret;
 	trace_rdev_tx_control_port(&rdev->wiphy, dev, buf, len,
-				   dest, proto, noencrypt);
+				   dest, src, proto, noencrypt);
 	ret = rdev->ops->tx_control_port(&rdev->wiphy, dev, buf, len,
-					 dest, proto, noencrypt);
+					 dest, src, proto, noencrypt);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index d98ad2b3143b..fefa255fd062 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1923,27 +1923,31 @@ TRACE_EVENT(rdev_mgmt_tx,
 
 TRACE_EVENT(rdev_tx_control_port,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
-		 const u8 *buf, size_t len, const u8 *dest, __be16 proto,
+		 const u8 *buf, size_t len,
+		 const u8 *dest, const u8 *src, __be16 proto,
 		 bool unencrypted),
-	TP_ARGS(wiphy, netdev, buf, len, dest, proto, unencrypted),
+	TP_ARGS(wiphy, netdev, buf, len, dest, src, proto, unencrypted),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
 		MAC_ENTRY(dest)
-		__field(__be16, proto)
+		MAC_ENTRY(src)
+		__field(u16, proto)
 		__field(bool, unencrypted)
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
 		NETDEV_ASSIGN;
 		MAC_ASSIGN(dest, dest);
-		__entry->proto = proto;
+		MAC_ASSIGN(src, src);
+		__entry->proto = be16_to_cpu(proto);
 		__entry->unencrypted = unencrypted;
 	),
-	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " MAC_PR_FMT ","
-		  " proto: 0x%x, unencrypted: %s",
-		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(dest),
-		  be16_to_cpu(__entry->proto),
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", dest: " MAC_PR_FMT
+		  ", src: " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
+		  WIPHY_PR_ARG, NETDEV_PR_ARG,
+		  MAC_PR_ARG(dest), MAC_PR_ARG(src),
+		  __entry->proto,
 		  BOOL_TO_STR(__entry->unencrypted))
 );
 
@@ -2835,6 +2839,7 @@ TRACE_EVENT(cfg80211_rx_control_port,
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
 		__field(int, len)
+		MAC_ENTRY(to)
 		MAC_ENTRY(from)
 		__field(u16, proto)
 		__field(bool, unencrypted)
@@ -2842,12 +2847,14 @@ TRACE_EVENT(cfg80211_rx_control_port,
 	TP_fast_assign(
 		NETDEV_ASSIGN;
 		__entry->len = skb->len;
+		MAC_ASSIGN(to, eth_hdr(skb)->h_dest);
 		MAC_ASSIGN(from, eth_hdr(skb)->h_source);
 		__entry->proto = be16_to_cpu(skb->protocol);
 		__entry->unencrypted = unencrypted;
 	),
-	TP_printk(NETDEV_PR_FMT ", len=%d, " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
-		  NETDEV_PR_ARG, __entry->len, MAC_PR_ARG(from),
+	TP_printk(NETDEV_PR_FMT ", len=%d, dest: " MAC_PR_FMT
+		  ", src: " MAC_PR_FMT ", proto: 0x%x, unencrypted: %s",
+		  NETDEV_PR_ARG, __entry->len, MAC_PR_ARG(to), MAC_PR_ARG(from),
 		  __entry->proto, BOOL_TO_STR(__entry->unencrypted))
 );
 
-- 
2.25.0

