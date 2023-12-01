Return-Path: <linux-wireless+bounces-283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DDF8008AF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FFE7B21400
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF3020B35;
	Fri,  1 Dec 2023 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ohTJK1dp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB4D40;
	Fri,  1 Dec 2023 02:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nLp68dePSfpizVBKx02HJlI+GJJe6c/8548Gc3WLetc=;
	t=1701427419; x=1702637019; b=ohTJK1dpBauqNZg9cqfX2JmHRIuDzwzTLU8xZhcyBnbrbS2
	rbfFDxAFRPv5/i6gFqMirTfnxxEe1exQ1ND0SROLSLbQviSx74tXaANhbu7R6Ljh9WjZTITwNwp37
	XIC8YO7HIJkTxXUAUGQN7EGudz/evPh8Y7+M0HJCNuvu5BvmLtHQynNRJIMNv13phyKkBg6tDHygE
	BRfnjJi0y/kuVc1o8XskU3Oetyn5zFHFP6bN7MBGVX6aDbr4l2k9GXONwoABeYNUZshuPRRgn96Q3
	MuEETOqeKiMtsOmvBLnlDVcMGw/XTvmmgM0OK5bCBNoYDh6+LM85h1YdjIKpbAFA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r90zh-0000000BBV7-0Oz0;
	Fri, 01 Dec 2023 11:43:37 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 3/3] wifi: nl80211: report carrier up count to userspace
Date: Fri,  1 Dec 2023 11:41:17 +0100
Message-ID: <20231201114329.c43ed5db7146.Idd29862133993877b9fdff962dca3649e842249a@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231201104329.25898-5-johannes@sipsolutions.net>
References: <346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
 <20231201104329.25898-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's a race in the carrier change that happens if userspace
sees the RX association event via nl80211, but the driver (or
mac80211) just prior to that set the carrier on. The carrier
on event is actually only processed by the link watch work, so
userspace can (and we've seen this at least in simulation with
ARCH=um and time-travel) attempt to send a frame before that
has run, if it was just waiting for the association to finish
(only on open connections, of course, for encryption it has to
go through the 4-way-handshake first before sending data frames.)

There's really no completely good way to address this, I've
previously analyzed this here:
https://lore.kernel.org/netdev/346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net/

This new solution requires both kernel and userspace work, it
basically builds on #3 outlined in the email linked above, but
with the addition of letting userspace _know_ that it may need
to wait for the rtnetlink event.

So to solve it, with this change userspace can see the value of
the carrier_up_count at the association event, and if it hasn't
yet seen the same value via an rtnetlink event (it is imperative
that it doesn't query, it must wait for events) then it can wait
for that event before trying to send data frames.

For now, implement this for association and IBSS joined events.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/uapi/linux/nl80211.h | 16 ++++++++++++
 net/wireless/nl80211.c       | 47 ++++++++++++++++--------------------
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 0cd1da2c2902..120936f81a28 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2830,6 +2830,20 @@ enum nl80211_commands {
  * @NL80211_ATTR_MLO_LINK_DISABLED: Flag attribute indicating that the link is
  *	disabled.
  *
+ * @NL80211_ATTR_CARRIER_UP_COUNT: This u32 attribute is included in some
+ *	events that indicate a successful connection (notably association),
+ *	indicating the value of the netdev's carrier_up_count at the time
+ *	of sending this event. Userspace can use this to fix a race: when
+ *	the carrier is turned on, the actual handling thereof is done in
+ *	an asynchronous manner in the kernel. Thus, if userspace attempts
+ *	to send a frame immediately after receiving the event indicating
+ *	successful connection over nl80211, that may not go through if the
+ *	asynchronous processing in the kernel hasn't yet happened. To fix
+ *	it then userspace should be listening to rtnetlink events, and if
+ *	it didn't see the value of the carrier_up_count yet, it can wait
+ *	for a further rtnetlink event with a value equal to or bigger than
+ *	the value reported here, and only then transmit data.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3368,6 +3382,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_MLO_LINK_DISABLED,
 
+	NL80211_ATTR_CARRIER_UP_COUNT,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 403a4a38966a..d91a99f90aaa 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -818,6 +818,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_HW_TIMESTAMP_ENABLED] = { .type = NLA_FLAG },
 	[NL80211_ATTR_EMA_RNR_ELEMS] = { .type = NLA_NESTED },
 	[NL80211_ATTR_MLO_LINK_DISABLED] = { .type = NLA_FLAG },
+	[NL80211_ATTR_CARRIER_UP_COUNT] = { .type = NLA_REJECT },
 };
 
 /* policy for the key attributes */
@@ -17738,11 +17739,13 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 
 struct nl80211_mlme_event {
 	enum nl80211_commands cmd;
+	const u8 *mac_addr;
 	const u8 *buf;
 	size_t buf_len;
 	int uapsd_queues;
 	const u8 *req_ies;
 	size_t req_ies_len;
+	u32 carrier_up_count;
 	bool reconnect;
 };
 
@@ -17766,12 +17769,17 @@ static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_FRAME, event->buf_len, event->buf) ||
+	    (event->buf &&
+	     nla_put(msg, NL80211_ATTR_FRAME, event->buf_len, event->buf)) ||
 	    (event->req_ies &&
 	     nla_put(msg, NL80211_ATTR_REQ_IE, event->req_ies_len,
 		     event->req_ies)))
 		goto nla_put_failure;
 
+	if (event->mac_addr &&
+	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, event->mac_addr))
+		goto nla_put_failure;
+
 	if (event->reconnect &&
 	    nla_put_flag(msg, NL80211_ATTR_RECONNECT_REQUESTED))
 		goto nla_put_failure;
@@ -17789,6 +17797,11 @@ static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 		nla_nest_end(msg, nla_wmm);
 	}
 
+	if (event->carrier_up_count &&
+	    nla_put_u32(msg, NL80211_ATTR_CARRIER_UP_COUNT,
+			event->carrier_up_count))
+		goto nla_put_failure;
+
 	genlmsg_end(msg, hdr);
 
 	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
@@ -17824,6 +17837,7 @@ void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 		.uapsd_queues = data->uapsd_queues,
 		.req_ies = data->req_ies,
 		.req_ies_len = data->req_ies_len,
+		.carrier_up_count = atomic_read(&netdev->carrier_up_count),
 	};
 
 	nl80211_send_mlme_event(rdev, netdev, &event, GFP_KERNEL);
@@ -18307,32 +18321,13 @@ void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 			     struct net_device *netdev, const u8 *bssid,
 			     gfp_t gfp)
 {
-	struct sk_buff *msg;
-	void *hdr;
+	struct nl80211_mlme_event event = {
+		.cmd = NL80211_CMD_JOIN_IBSS,
+		.mac_addr = bssid,
+		.carrier_up_count = atomic_read(&netdev->carrier_up_count),
+	};
 
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
-	if (!msg)
-		return;
-
-	hdr = nl80211hdr_put(msg, 0, 0, 0, NL80211_CMD_JOIN_IBSS);
-	if (!hdr) {
-		nlmsg_free(msg);
-		return;
-	}
-
-	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
-	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, bssid))
-		goto nla_put_failure;
-
-	genlmsg_end(msg, hdr);
-
-	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
-				NL80211_MCGRP_MLME, gfp);
-	return;
-
- nla_put_failure:
-	nlmsg_free(msg);
+	nl80211_send_mlme_event(rdev, netdev, &event, gfp);
 }
 
 void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
-- 
2.43.0


