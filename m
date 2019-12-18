Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03A212490E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfLROGF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:05 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:54572 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727125AbfLROGE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:04 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 09:06:00 EST
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:54 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 7/8] wil6210: support set_multicast_to_unicast cfg80211 operation
Date:   Wed, 18 Dec 2019 15:59:46 +0200
Message-Id: <20191218135947.5903-8-merez@codeaurora.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218135947.5903-1-merez@codeaurora.org>
References: <20191218135947.5903-1-merez@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ahmad Masri <amasri@codeaurora.org>

Wil6210 AP has a separate ring for transmitting multicast packets,
multicast packets are transmitted without an ack from the receiver side.
Therefore, 802.11 spec defines some low MCS rates for multicat packets.
However, there is no guarantee that these packets were really received
and handled on the client side.

Some applications that rely on multicast packets, may prefer to
transmit these packets as a unicast to ensure reliability, and also
to ensure better performance with high MCS rates.
multicast to unicast is done by duplicating multicast packets to all
clients and changing the DA (multicast) to the MAC address of the
client.
see NL80211_CMD_SET_MULTICAST_TO_UNICAST for more info.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 16 +++++++++++
 drivers/net/wireless/ath/wil6210/txrx.c     | 32 ++++++++++++++++++++-
 drivers/net/wireless/ath/wil6210/wil6210.h  |  1 +
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 7d6f14420855..5a3aff131472 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2579,6 +2579,21 @@ wil_cfg80211_update_ft_ies(struct wiphy *wiphy, struct net_device *dev,
 	return rc;
 }
 
+static int wil_cfg80211_set_multicast_to_unicast(struct wiphy *wiphy,
+						 struct net_device *dev,
+						 const bool enabled)
+{
+	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+
+	if (wil->multicast_to_unicast == enabled)
+		return 0;
+
+	wil_info(wil, "set multicast to unicast, enabled=%d\n", enabled);
+	wil->multicast_to_unicast = enabled;
+
+	return 0;
+}
+
 static const struct cfg80211_ops wil_cfg80211_ops = {
 	.add_virtual_intf = wil_cfg80211_add_iface,
 	.del_virtual_intf = wil_cfg80211_del_iface,
@@ -2615,6 +2630,7 @@ static const struct cfg80211_ops wil_cfg80211_ops = {
 	.sched_scan_start = wil_cfg80211_sched_scan_start,
 	.sched_scan_stop = wil_cfg80211_sched_scan_stop,
 	.update_ft_ies = wil_cfg80211_update_ft_ies,
+	.set_multicast_to_unicast = wil_cfg80211_set_multicast_to_unicast,
 };
 
 static void wil_wiphy_init(struct wiphy *wiphy)
diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 8ebc6d59aa74..17118d643d7e 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -10,6 +10,7 @@
 #include <linux/moduleparam.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/if_vlan.h>
 #include <net/ipv6.h>
 #include <linux/prefetch.h>
 
@@ -1529,6 +1530,35 @@ static struct wil_ring *wil_find_tx_bcast_1(struct wil6210_priv *wil,
 	return v;
 }
 
+/* apply multicast to unicast only for ARP and IP packets
+ * (see NL80211_CMD_SET_MULTICAST_TO_UNICAST for more info)
+ */
+static bool wil_check_multicast_to_unicast(struct wil6210_priv *wil,
+					   struct sk_buff *skb)
+{
+	const struct ethhdr *eth = (void *)skb->data;
+	const struct vlan_ethhdr *ethvlan = (void *)skb->data;
+	__be16 ethertype;
+
+	if (!wil->multicast_to_unicast)
+		return false;
+
+	/* multicast to unicast conversion only for some payload */
+	ethertype = eth->h_proto;
+	if (ethertype == htons(ETH_P_8021Q) && skb->len >= VLAN_ETH_HLEN)
+		ethertype = ethvlan->h_vlan_encapsulated_proto;
+	switch (ethertype) {
+	case htons(ETH_P_ARP):
+	case htons(ETH_P_IP):
+	case htons(ETH_P_IPV6):
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static void wil_set_da_for_vring(struct wil6210_priv *wil,
 				 struct sk_buff *skb, int vring_index)
 {
@@ -2336,7 +2366,7 @@ netdev_tx_t wil_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		/* in STA mode (ESS), all to same VRING (to AP) */
 		ring = wil_find_tx_ring_sta(wil, vif, skb);
 	} else if (bcast) {
-		if (vif->pbss)
+		if (vif->pbss || wil_check_multicast_to_unicast(wil, skb))
 			/* in pbss, no bcast VRING - duplicate skb in
 			 * all stations VRINGs
 			 */
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index bf00f0693a3d..21399ced2a5d 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1059,6 +1059,7 @@ struct wil6210_priv {
 
 	u32 max_agg_wsize;
 	u32 max_ampdu_size;
+	u8 multicast_to_unicast;
 };
 
 #define wil_to_wiphy(i) (i->wiphy)
-- 
2.23.0

