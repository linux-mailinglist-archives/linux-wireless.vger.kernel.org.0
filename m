Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3F348C9B4
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 18:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355821AbiALRef (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 12:34:35 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:55579 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355763AbiALReK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 12:34:10 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id BEAEF2000A;
        Wed, 12 Jan 2022 17:34:04 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Harry Morris <h.morris@cascoda.com>,
        Varka Bhadram <varkabhadram@gmail.com>,
        Xue Liu <liuxuenetmail@gmail.com>, Alan Ott <alan@signal11.us>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-wireless@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [wpan-next v2 24/27] net: mac802154: Add support for processing beacon requests
Date:   Wed, 12 Jan 2022 18:33:09 +0100
Message-Id: <20220112173312.764660-25-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220112173312.764660-1-miquel.raynal@bootlin.com>
References: <20220112173312.764660-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When performing an active scan, coordinators emit beacon requests which
must be answered by other PANs receiving the request.

Answering a beacon request is considered a duty whenever the user
performs a "send beacons" command with an interval of 15. As in the
softMAC we save the interval in micro-seconds, we use a negative value
to discriminate between a passive beacons command and the task to answer
received beacon requests.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/net/ieee802154_netdev.h |  4 +++-
 net/ieee802154/header_ops.c     | 13 +++++++++++++
 net/mac802154/ieee802154_i.h    | 17 ++++++++++++++++-
 net/mac802154/rx.c              | 13 +++++++++++++
 net/mac802154/scan.c            | 17 +++++++++++++----
 5 files changed, 58 insertions(+), 6 deletions(-)

diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 1bf1a4e508a2..a2dba4442c57 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -179,9 +179,11 @@ int ieee802154_hdr_peek_addrs(const struct sk_buff *skb,
  */
 int ieee802154_hdr_peek(const struct sk_buff *skb, struct ieee802154_hdr *hdr);
 
-/* pushes a beacon_req or a beacon frame into an skb */
+/* pushes/pulls a beacon_req or a beacon frame into/from an skb */
 int ieee802154_beacon_req_push(struct sk_buff *skb,
 			       struct ieee802154_beacon_req_frame *breq);
+int ieee802154_beacon_req_pl_pull(struct sk_buff *skb,
+				  struct ieee802154_mac_cmd_pl *mac_pl);
 int ieee802154_beacon_push(struct sk_buff *skb,
 			   struct ieee802154_beacon_frame *beacon);
 
diff --git a/net/ieee802154/header_ops.c b/net/ieee802154/header_ops.c
index c31a9e429a14..771dbcf6e0b8 100644
--- a/net/ieee802154/header_ops.c
+++ b/net/ieee802154/header_ops.c
@@ -314,6 +314,19 @@ ieee802154_hdr_pull(struct sk_buff *skb, struct ieee802154_hdr *hdr)
 }
 EXPORT_SYMBOL_GPL(ieee802154_hdr_pull);
 
+int ieee802154_beacon_req_pl_pull(struct sk_buff *skb,
+				  struct ieee802154_mac_cmd_pl *mac_pl)
+{
+	if (!pskb_may_pull(skb, sizeof(*mac_pl)))
+		return -EINVAL;
+
+	memcpy(mac_pl, skb->data, sizeof(*mac_pl));
+	skb_pull(skb, sizeof(*mac_pl));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ieee802154_beacon_req_pl_pull);
+
 int
 ieee802154_hdr_peek_addrs(const struct sk_buff *skb, struct ieee802154_hdr *hdr)
 {
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 19c840500bd8..3d79c6ecbdf1 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -61,7 +61,7 @@ struct ieee802154_local {
 	/* Beacons handling */
 	bool ongoing_beacons_request;
 	struct mutex beacons_lock;
-	unsigned int beacons_interval;
+	int beacons_interval;
 	struct delayed_work beacons_work;
 	struct ieee802154_sub_if_data __rcu *beacons_sdata;
 	struct ieee802154_beacon_frame beacon;
@@ -136,6 +136,21 @@ ieee802154_sdata_running(struct ieee802154_sub_if_data *sdata)
 	return test_bit(SDATA_STATE_RUNNING, &sdata->state);
 }
 
+static inline bool ieee802154_frame_is_beacon_req(struct sk_buff *skb)
+{
+	struct ieee802154_mac_cmd_pl mac_pl;
+	int ret;
+
+	if (mac_cb(skb)->type != IEEE802154_FC_TYPE_MAC_CMD)
+		return false;
+
+	ret = ieee802154_beacon_req_pl_pull(skb, &mac_pl);
+	if (ret)
+		return false;
+
+	return mac_pl.cmd_id == IEEE802154_CMD_BEACON_REQ;
+}
+
 extern struct ieee802154_mlme_ops mac802154_mlme_wpan;
 
 void ieee802154_rx(struct ieee802154_local *local, struct sk_buff *skb);
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index f2f3eca9bc20..1aba23d007cf 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -29,6 +29,11 @@ static int ieee802154_deliver_skb(struct sk_buff *skb)
 	return netif_receive_skb(skb);
 }
 
+static bool mac802154_should_answer_beacon_req(struct ieee802154_local *local)
+{
+	return local->ongoing_beacons_request && local->beacons_interval < 0;
+}
+
 static int
 ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		       struct sk_buff *skb, const struct ieee802154_hdr *hdr)
@@ -101,6 +106,14 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		}
 		goto fail;
 	case IEEE802154_FC_TYPE_MAC_CMD:
+		if (ieee802154_frame_is_beacon_req(skb) &&
+		    mac802154_should_answer_beacon_req(sdata->local)) {
+			ieee802154_queue_delayed_work(&sdata->local->hw,
+						      &sdata->local->beacons_work,
+						      0);
+			goto success;
+		}
+		goto fail;
 	case IEEE802154_FC_TYPE_ACK:
 		goto fail;
 	case IEEE802154_FC_TYPE_DATA:
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index a3ff65d5bb7a..c9412dfaeb66 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -142,7 +142,8 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
 	local->beacon.mhr.source.pan_id = cpu_to_le16(request->wpan_dev->pan_id);
 	local->beacon.mhr.source.extended_addr = cpu_to_le64(request->wpan_dev->extended_addr);
 	local->beacon.mac_pl.beacon_order = request->interval;
-	local->beacon.mac_pl.superframe_order = request->interval;
+	if (request->interval <= IEEE802154_MAX_SCAN_DURATION)
+		local->beacon.mac_pl.superframe_order = request->interval;
 	local->beacon.mac_pl.final_cap_slot = 0xf;
 	local->beacon.mac_pl.battery_life_ext = 0;
 	local->beacon.mac_pl.pan_coordinator = 1;
@@ -150,6 +151,11 @@ int mac802154_send_beacons_locked(struct ieee802154_sub_if_data *sdata,
 
 	rcu_assign_pointer(local->beacons_sdata, sdata);
 
+	if (request->interval == IEEE802154_ACTIVE_SCAN_DURATION) {
+		local->beacons_interval = -1;
+		return 0;
+	}
+
 	/* Start the beacon work */
 	local->beacons_interval =
 		mac802154_scan_get_channel_time(request->interval,
@@ -167,7 +173,9 @@ int mac802154_stop_beacons_locked(struct ieee802154_local *local)
 		return -ESRCH;
 
 	local->ongoing_beacons_request = false;
-	cancel_delayed_work(&local->beacons_work);
+
+	if (local->beacons_interval >= 0)
+		cancel_delayed_work(&local->beacons_work);
 
 	return 0;
 }
@@ -363,8 +371,9 @@ void mac802154_beacons_work(struct work_struct *work)
 		pr_err("Error when transmitting beacon (%d)\n", ret);
 
 queue_work:
-	ieee802154_queue_delayed_work(&local->hw, &local->beacons_work,
-				      local->beacons_interval);
+	if (local->beacons_interval >= 0)
+		ieee802154_queue_delayed_work(&local->hw, &local->beacons_work,
+					      local->beacons_interval);
 
 unlock_mutex:
 	mutex_unlock(&local->beacons_lock);
-- 
2.27.0

