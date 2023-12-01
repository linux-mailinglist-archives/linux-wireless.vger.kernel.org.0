Return-Path: <linux-wireless+bounces-288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0CD800906
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F15B20DD3
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D12219E2;
	Fri,  1 Dec 2023 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sx7I83Mw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC80C1726;
	Fri,  1 Dec 2023 02:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rDc7S3TGwDRkuN19FCwRpWlUg/012zfS/c7UoSCfhOg=;
	t=1701427798; x=1702637398; b=sx7I83MwXTI5q1y3hsEdV1kcfKxOdHCD1XKDrnSv3DIMDNU
	8COzLqD8xB+QrS+dvmNK6rDwPexvgf/y74xWxx0IvW6y5yD9AUm7rmYc8ygxGiq7BqyQ1dUTUzila
	drXGLx3zmqD4vTq7FlhkdsZbC3tdxFi5f3ldoWBUW5mbT7pWXMwpDRbDeG7ykl1ieqR8C08Y7D4dZ
	nP4zx6iHfAFlz3mdxufCo0oEAu54QzMmrYSJdjc6XNeuhdcewG8RGecH+pImX/aaIv8v499cjiv4C
	UgcqX5iEj38X/M9R3plurEx1II/VAbk1/GYCdXqZ3aKDdYNnuKFdZnJD/MdNJJ5Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r915n-0000000BBjV-3rZk;
	Fri, 01 Dec 2023 11:49:56 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: hostap@lists.infradead.org,
	netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wpa_suppplicant 2/2] driver_nl82011: wait for rtnetlink event with carrier_up_count
Date: Fri,  1 Dec 2023 11:49:09 +0100
Message-ID: <20231201114952.420b40a5f188.I75677b755f36ca63f8289d84de29b212f4c37ec0@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201104952.26254-4-johannes@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
 <20231201104952.26254-4-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's a race (see the comment in the code) between the
kernel and userspace that can lead to dropping TX packets
after the associated event was already received.

If the kernel indicates the carrier_up_count, wait for
the corresponding rtnetlink event to reach that count.
This fixes the race since the rtnetlink event is sent
after the async processing that's needed in the kernel
before a frame can be transmitted.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 src/drivers/driver_nl80211.c       |  7 ++++
 src/drivers/driver_nl80211.h       |  2 ++
 src/drivers/driver_nl80211_event.c | 52 ++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/src/drivers/driver_nl80211.c b/src/drivers/driver_nl80211.c
index 03d54222bb52..b442dee1e710 100644
--- a/src/drivers/driver_nl80211.c
+++ b/src/drivers/driver_nl80211.c
@@ -1365,6 +1365,7 @@ static void wpa_driver_nl80211_event_rtm_newlink(void *ctx,
 	char ifname[IFNAMSIZ + 1];
 	char extra[100], *pos, *end;
 	int init_failed;
+	u32 carrier_up_count = 0;
 
 	extra[0] = '\0';
 	pos = extra;
@@ -1396,6 +1397,9 @@ static void wpa_driver_nl80211_event_rtm_newlink(void *ctx,
 			pos += os_snprintf(pos, end - pos, " linkmode=%u",
 					   nla_get_u32((struct nlattr *) attr));
 			break;
+		case IFLA_CARRIER_UP_COUNT:
+			carrier_up_count = nla_get_u32((struct nlattr *) attr);
+			break;
 		}
 		attr = RTA_NEXT(attr, attrlen);
 	}
@@ -1415,6 +1419,9 @@ static void wpa_driver_nl80211_event_rtm_newlink(void *ctx,
 	if (init_failed)
 		return; /* do not update interface state */
 
+	if (carrier_up_count)
+		drv->carrier_up_count = carrier_up_count;
+
 	if (!drv->if_disabled && !(ifi->ifi_flags & IFF_UP)) {
 		namebuf[0] = '\0';
 		if (if_indextoname(ifi->ifi_index, namebuf) &&
diff --git a/src/drivers/driver_nl80211.h b/src/drivers/driver_nl80211.h
index f82f604e9017..874988715b21 100644
--- a/src/drivers/driver_nl80211.h
+++ b/src/drivers/driver_nl80211.h
@@ -201,6 +201,8 @@ struct wpa_driver_nl80211_data {
 	unsigned int puncturing:1;
 	unsigned int qca_ap_allowed_freqs:1;
 
+	u32 carrier_up_count;
+
 	u32 ignore_next_local_disconnect;
 	u32 ignore_next_local_deauth;
 
diff --git a/src/drivers/driver_nl80211_event.c b/src/drivers/driver_nl80211_event.c
index 60b4fb51fcd8..4ff25b57ceeb 100644
--- a/src/drivers/driver_nl80211_event.c
+++ b/src/drivers/driver_nl80211_event.c
@@ -19,6 +19,7 @@
 #include "common/ieee802_11_defs.h"
 #include "common/ieee802_11_common.h"
 #include "driver_nl80211.h"
+#include "netlink.h"
 
 
 static void
@@ -256,6 +257,49 @@ static void nl80211_parse_wmm_params(struct nlattr *wmm_attr,
 }
 
 
+/*
+ * Wait for an RTM newlink event with corresponding carrier up count
+ *
+ * There's a race condition with mac80211 and the network stack, which
+ * mostly hits depending on scheduling in time-simulation (tests),
+ * which is that mac80211 will both indicate carrier on to the network
+ * stack and send the associated/... event to userspace. Now, the
+ * internal kernel function netif_carrier_ok() immediately returns
+ * true after this, however, the linkwatch work still needs to run
+ * and change the TX queue qdisc away from noop (which drops all TX
+ * packets).
+ *
+ * When the race happens, userspace (and in particular tests) can see
+ * the associated/... event and immediately try to send a frame, at a
+ * time that the linkwatch work hasn't run yet, causing the frame to
+ * be dropped.
+ *
+ * Thus, if the kernel indicated the current carrier_up_count in an
+ * event, wait here for an RTM newlink event for our interface, so in
+ * in addition to seeing the associated/... event, we also know the
+ * carrier state has actually changed sufficiently to send packets,
+ * if it was meant to change.
+ *
+ * This works because the event to userspace is also sent from the
+ * asynchronous linkwatch work.
+ */
+static void
+nl80211_wait_for_carrier_up_count(struct wpa_driver_nl80211_data *drv,
+				  u32 carrier_up_count)
+{
+#define WRAPPED_U32_LESS(x, y)	((s32)(y) - (s32)(x) < 0)
+
+	if (WRAPPED_U32_LESS(drv->carrier_up_count, carrier_up_count))
+		netlink_process_one_event(drv->global->netlink, 100);
+
+	if (WRAPPED_U32_LESS(drv->carrier_up_count, carrier_up_count))
+		wpa_printf(MSG_ERROR,
+			   "nl80211: %s: carrier up count %u not seen (got %u)\n",
+			   drv->first_bss->ifname, carrier_up_count,
+			   drv->carrier_up_count);
+}
+
+
 static void mlme_event_assoc(struct wpa_driver_nl80211_data *drv,
 			     const u8 *frame, size_t len, struct nlattr *wmm,
 			     struct nlattr *req_ie)
@@ -3845,6 +3889,14 @@ static void do_process_drv_event(struct i802_bss *bss, int cmd,
 	     cmd == NL80211_CMD_SCAN_ABORTED))
 		nl80211_restore_ap_mode(bss);
 
+	/* see comment above wpa_driver_nl80211_own_ifname() */
+	if (tb[NL80211_ATTR_CARRIER_UP_COUNT]) {
+		u32 carrier_up_count =
+			nla_get_u32(tb[NL80211_ATTR_CARRIER_UP_COUNT]);
+
+		nl80211_wait_for_carrier_up_count(drv, carrier_up_count);
+	}
+
 	switch (cmd) {
 	case NL80211_CMD_TRIGGER_SCAN:
 		wpa_dbg(drv->ctx, MSG_DEBUG, "nl80211: Scan trigger");
-- 
2.43.0


