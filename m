Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC31818F884
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 16:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCWPZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 11:25:52 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49316 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbgCWPZv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 11:25:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jGOxY-002WVN-T4; Mon, 23 Mar 2020 16:25:49 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     me@bobcopeland.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/7] wmediumd: track dynamic station addresses
Date:   Mon, 23 Mar 2020 16:25:41 +0100
Message-Id: <20200323162245.358bbb1372cb.Idd69e690298107f7d7be6c547284b6443926e5a2@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323152542.68696-1-johannes@sipsolutions.net>
References: <20200323152542.68696-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

With newer kernels, mac80211_hwsim indicates to us when it starts
and stops using a certain MAC address on a certain radio. Without
that, there's a need to configure each MAC address as a station,
which is not only incorrect (a station can have multiple addresses
and wouldn't have a different position or different frame loss
probabilities between them) but also impractical, e.g. for random
scanning.

Add the necessary code to track and use this information, and look
up sender station by the HW address and destination by any of the
used addresses.

Still keep looking up by source address as well to not break any
existing use cases.

---
 wmediumd/wmediumd.c | 97 ++++++++++++++++++++++++++++++++++++++++-----
 wmediumd/wmediumd.h | 22 ++++++++--
 2 files changed, 105 insertions(+), 14 deletions(-)

diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index a1e16defd144..14ea63b6ba69 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -238,6 +238,32 @@ static struct station *get_station_by_addr(struct wmediumd *ctx, u8 *addr)
 	return NULL;
 }
 
+static bool station_has_addr(struct station *station, const u8 *addr)
+{
+	unsigned int i;
+
+	if (memcmp(station->addr, addr, ETH_ALEN) == 0)
+		return true;
+
+	for (i = 0; i < station->n_addrs; i++) {
+		if (memcmp(station->addrs[i].addr, addr, ETH_ALEN) == 0)
+			return true;
+	}
+
+	return false;
+}
+
+static struct station *get_station_by_used_addr(struct wmediumd *ctx, u8 *addr)
+{
+	struct station *station;
+
+	list_for_each_entry(station, &ctx->stations, list) {
+		if (station_has_addr(station, addr))
+			return station;
+	}
+	return NULL;
+}
+
 static void queue_frame(struct wmediumd *ctx, struct station *station,
 			struct frame *frame)
 {
@@ -285,7 +311,7 @@ static void queue_frame(struct wmediumd *ctx, struct station *station,
 	if (is_multicast_ether_addr(dest)) {
 		deststa = NULL;
 	} else {
-		deststa = get_station_by_addr(ctx, dest);
+		deststa = get_station_by_used_addr(ctx, dest);
 		if (deststa) {
 			snr = ctx->get_link_snr(ctx, station, deststa) -
 				get_signal_offset_by_interference(ctx,
@@ -586,7 +612,7 @@ static void wmediumd_deliver_frame(struct usfstl_job *job)
 						      1, signal,
 						      frame->freq);
 
-			} else if (memcmp(dest, station->addr, ETH_ALEN) == 0) {
+			} else if (station_has_addr(station, dest)) {
 				if (set_interference_duration(ctx,
 					frame->sender->index, frame->duration,
 					frame->signal))
@@ -657,13 +683,16 @@ static void _process_messages(struct nl_msg *msg,
 	struct station *sender;
 	struct frame *frame;
 	struct ieee80211_hdr *hdr;
-	u8 *src;
+	u8 *src, *hwaddr, *addr;
+	void *new;
+	unsigned int i;
+
+	genlmsg_parse(nlh, 0, attrs, HWSIM_ATTR_MAX, NULL);
 
-	if (gnlh->cmd == HWSIM_CMD_FRAME) {
-		/* we get the attributes*/
-		genlmsg_parse(nlh, 0, attrs, HWSIM_ATTR_MAX, NULL);
+	switch (gnlh->cmd) {
+	case HWSIM_CMD_FRAME:
 		if (attrs[HWSIM_ATTR_ADDR_TRANSMITTER]) {
-			u8 *hwaddr = (u8 *)nla_data(attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
+			hwaddr = (u8 *)nla_data(attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
 
 			unsigned int data_len =
 				nla_len(attrs[HWSIM_ATTR_FRAME]);
@@ -687,12 +716,18 @@ static void _process_messages(struct nl_msg *msg,
 			if (data_len < 6 + 6 + 4)
 				return;
 
-			sender = get_station_by_addr(ctx, src);
+			sender = get_station_by_addr(ctx, hwaddr);
 			if (!sender) {
-				w_flogf(ctx, LOG_ERR, stderr, "Unable to find sender station " MAC_FMT "\n", MAC_ARGS(src));
-				return;
+				sender = get_station_by_used_addr(ctx, src);
+				if (!sender) {
+					w_flogf(ctx, LOG_ERR, stderr,
+						"Unable to find sender station by src=" MAC_FMT " nor hwaddr=" MAC_FMT "\n",
+						MAC_ARGS(src), MAC_ARGS(hwaddr));
+					return;
+				}
+				memcpy(sender->hwaddr, hwaddr, ETH_ALEN);
 			}
-			memcpy(sender->hwaddr, hwaddr, ETH_ALEN);
+
 			if (!sender->client)
 				sender->client = client;
 
@@ -712,6 +747,46 @@ static void _process_messages(struct nl_msg *msg,
 			       min(tx_rates_len, sizeof(frame->tx_rates)));
 			queue_frame(ctx, sender, frame);
 		}
+		break;
+	case HWSIM_CMD_ADD_MAC_ADDR:
+		if (!attrs[HWSIM_ATTR_ADDR_TRANSMITTER] ||
+		    !attrs[HWSIM_ATTR_ADDR_RECEIVER])
+			break;
+		hwaddr = (u8 *)nla_data(attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
+		addr = (u8 *)nla_data(attrs[HWSIM_ATTR_ADDR_RECEIVER]);
+		sender = get_station_by_addr(ctx, hwaddr);
+		if (!sender)
+			break;
+		for (i = 0; i < sender->n_addrs; i++) {
+			if (memcmp(sender->addrs[i].addr, addr, ETH_ALEN) == 0)
+				return;
+		}
+		new = realloc(sender->addrs, ETH_ALEN * (sender->n_addrs + 1));
+		if (!new)
+			break;
+		sender->addrs = new;
+		memcpy(sender->addrs[sender->n_addrs].addr, addr, ETH_ALEN);
+		sender->n_addrs += 1;
+		break;
+	case HWSIM_CMD_DEL_MAC_ADDR:
+		if (!attrs[HWSIM_ATTR_ADDR_TRANSMITTER] ||
+		    !attrs[HWSIM_ATTR_ADDR_RECEIVER])
+			break;
+		hwaddr = (u8 *)nla_data(attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
+		addr = (u8 *)nla_data(attrs[HWSIM_ATTR_ADDR_RECEIVER]);
+		sender = get_station_by_addr(ctx, hwaddr);
+		if (!sender)
+			break;
+		for (i = 0; i < sender->n_addrs; i++) {
+			if (memcmp(sender->addrs[i].addr, addr, ETH_ALEN))
+				continue;
+			sender->n_addrs -= 1;
+			memmove(sender->addrs[i].addr,
+				sender->addrs[sender->n_addrs].addr,
+				ETH_ALEN);
+			break;
+		}
+		break;
 	}
 }
 
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index 1d0392616d83..e201788b9b52 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -29,9 +29,19 @@
 #define HWSIM_TX_CTL_NO_ACK		(1 << 1)
 #define HWSIM_TX_STAT_ACK		(1 << 2)
 
-#define HWSIM_CMD_REGISTER 1
-#define HWSIM_CMD_FRAME 2
-#define HWSIM_CMD_TX_INFO_FRAME 3
+enum {
+	HWSIM_CMD_UNSPEC,
+	HWSIM_CMD_REGISTER,
+	HWSIM_CMD_FRAME,
+	HWSIM_CMD_TX_INFO_FRAME,
+	HWSIM_CMD_NEW_RADIO,
+	HWSIM_CMD_DEL_RADIO,
+	HWSIM_CMD_GET_RADIO,
+	HWSIM_CMD_ADD_MAC_ADDR,
+	HWSIM_CMD_DEL_MAC_ADDR,
+	__HWSIM_CMD_MAX,
+};
+#define HWSIM_CMD_MAX (_HWSIM_CMD_MAX - 1)
 
 /**
  * enum hwsim_attrs - hwsim netlink attributes
@@ -135,6 +145,10 @@ struct wqueue {
 	int cw_max;
 };
 
+struct addr {
+	u8 addr[ETH_ALEN];
+};
+
 struct station {
 	int index;
 	u8 addr[ETH_ALEN];		/* virtual interface mac address */
@@ -145,6 +159,8 @@ struct station {
 	struct wqueue queues[IEEE80211_NUM_ACS];
 	struct list_head list;
 	struct client *client;
+	unsigned int n_addrs;
+	struct addr *addrs;
 };
 
 enum client_type {
-- 
2.25.1

