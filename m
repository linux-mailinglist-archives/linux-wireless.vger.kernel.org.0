Return-Path: <linux-wireless+bounces-282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDF18008AB
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D23228154C
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF0420B0B;
	Fri,  1 Dec 2023 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vEgzW86h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1015119F;
	Fri,  1 Dec 2023 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=D1qKTFd0xgwUo5xOwS3Rxn5IbgPSDztU8/ZuojJtijw=;
	t=1701427418; x=1702637018; b=vEgzW86h4cmM5ZxniGYHev199a8hOVm9sObg46RgMGOt8kx
	mz9Nq6TDB6af0BcvwIERRecYMMSYwJsfm2LfJw3EttygFb2HlvB2o9PMOieDqAvnrZrQkiDG6Wsxd
	hopIYkVjwrhSy/vyehk3pdul+s2w/GuaCUjrRImisMPtVeX8qxk0FxI+BiZ6/J1LVm8eXE/iU5AIz
	4qQV1sCmbnwqHP33OQ8vhZOYN+ClOXR+fusgKWTTvzo/Q0oOOPW6NsjTv9+5yJQNXIzzerl2sdyLh
	IqGEjy/e+lDJYePgUC/n2/4QsnyEuRx2bMacPn7HNXTwLbS0Lj2deUGmqukVXFpg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r90zf-0000000BBV7-2jih;
	Fri, 01 Dec 2023 11:43:35 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 1/3] wifi: nl80211: refactor nl80211_send_mlme_event() arguments
Date: Fri,  1 Dec 2023 11:41:15 +0100
Message-ID: <20231201114329.61198560b09e.I7ad73644d71cf6526b23d0e1ccd9cd34db2e4deb@changeid>
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

This function has so many arguments already, before adding
yet another one, refactor it to take a struct instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 98 +++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 31 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 12b7bd92bb86..46a79ed1c97c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17736,21 +17736,29 @@ void nl80211_common_reg_change_event(enum nl80211_commands cmd_id,
 	nlmsg_free(msg);
 }
 
+struct nl80211_mlme_event {
+	enum nl80211_commands cmd;
+	const u8 *buf;
+	size_t buf_len;
+	int uapsd_queues;
+	const u8 *req_ies;
+	size_t req_ies_len;
+	bool reconnect;
+};
+
 static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 				    struct net_device *netdev,
-				    const u8 *buf, size_t len,
-				    enum nl80211_commands cmd, gfp_t gfp,
-				    int uapsd_queues, const u8 *req_ies,
-				    size_t req_ies_len, bool reconnect)
+				    const struct nl80211_mlme_event *event,
+				    gfp_t gfp)
 {
 	struct sk_buff *msg;
 	void *hdr;
 
-	msg = nlmsg_new(100 + len + req_ies_len, gfp);
+	msg = nlmsg_new(100 + event->buf_len + event->req_ies_len, gfp);
 	if (!msg)
 		return;
 
-	hdr = nl80211hdr_put(msg, 0, 0, 0, cmd);
+	hdr = nl80211hdr_put(msg, 0, 0, 0, event->cmd);
 	if (!hdr) {
 		nlmsg_free(msg);
 		return;
@@ -17758,22 +17766,24 @@ static void nl80211_send_mlme_event(struct cfg80211_registered_device *rdev,
 
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, netdev->ifindex) ||
-	    nla_put(msg, NL80211_ATTR_FRAME, len, buf) ||
-	    (req_ies &&
-	     nla_put(msg, NL80211_ATTR_REQ_IE, req_ies_len, req_ies)))
+	    nla_put(msg, NL80211_ATTR_FRAME, event->buf_len, event->buf) ||
+	    (event->req_ies &&
+	     nla_put(msg, NL80211_ATTR_REQ_IE, event->req_ies_len,
+		     event->req_ies)))
 		goto nla_put_failure;
 
-	if (reconnect && nla_put_flag(msg, NL80211_ATTR_RECONNECT_REQUESTED))
+	if (event->reconnect &&
+	    nla_put_flag(msg, NL80211_ATTR_RECONNECT_REQUESTED))
 		goto nla_put_failure;
 
-	if (uapsd_queues >= 0) {
+	if (event->uapsd_queues >= 0) {
 		struct nlattr *nla_wmm =
 			nla_nest_start_noflag(msg, NL80211_ATTR_STA_WME);
 		if (!nla_wmm)
 			goto nla_put_failure;
 
 		if (nla_put_u8(msg, NL80211_STA_WME_UAPSD_QUEUES,
-			       uapsd_queues))
+			       event->uapsd_queues))
 			goto nla_put_failure;
 
 		nla_nest_end(msg, nla_wmm);
@@ -17793,37 +17803,60 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 			  struct net_device *netdev, const u8 *buf,
 			  size_t len, gfp_t gfp)
 {
-	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_AUTHENTICATE, gfp, -1, NULL, 0,
-				false);
+	struct nl80211_mlme_event event = {
+		.cmd = NL80211_CMD_AUTHENTICATE,
+		.buf = buf,
+		.buf_len = len,
+		.uapsd_queues = -1,
+	};
+
+	nl80211_send_mlme_event(rdev, netdev, &event, gfp);
 }
 
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
 			   struct cfg80211_rx_assoc_resp_data *data)
 {
-	nl80211_send_mlme_event(rdev, netdev, data->buf, data->len,
-				NL80211_CMD_ASSOCIATE, GFP_KERNEL,
-				data->uapsd_queues,
-				data->req_ies, data->req_ies_len, false);
+	struct nl80211_mlme_event event = {
+		.cmd = NL80211_CMD_ASSOCIATE,
+		.buf = data->buf,
+		.buf_len = data->len,
+		.uapsd_queues = data->uapsd_queues,
+		.req_ies = data->req_ies,
+		.req_ies_len = data->req_ies_len,
+	};
+
+	nl80211_send_mlme_event(rdev, netdev, &event, GFP_KERNEL);
 }
 
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev, const u8 *buf,
 			 size_t len, bool reconnect, gfp_t gfp)
 {
-	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_DEAUTHENTICATE, gfp, -1, NULL, 0,
-				reconnect);
+	struct nl80211_mlme_event event = {
+		.cmd = NL80211_CMD_DEAUTHENTICATE,
+		.buf = buf,
+		.buf_len = len,
+		.reconnect = reconnect,
+		.uapsd_queues = -1,
+	};
+
+	nl80211_send_mlme_event(rdev, netdev, &event, gfp);
 }
 
 void nl80211_send_disassoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev, const u8 *buf,
 			   size_t len, bool reconnect, gfp_t gfp)
 {
-	nl80211_send_mlme_event(rdev, netdev, buf, len,
-				NL80211_CMD_DISASSOCIATE, gfp, -1, NULL, 0,
-				reconnect);
+	struct nl80211_mlme_event event = {
+		.cmd = NL80211_CMD_DISASSOCIATE,
+		.buf = buf,
+		.buf_len = len,
+		.reconnect = reconnect,
+		.uapsd_queues = -1,
+	};
+
+	nl80211_send_mlme_event(rdev, netdev, &event, gfp);
 }
 
 void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev, const u8 *buf,
@@ -17833,28 +17866,31 @@ void cfg80211_rx_unprot_mlme_mgmt(struct net_device *dev, const u8 *buf,
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
 	const struct ieee80211_mgmt *mgmt = (void *)buf;
-	u32 cmd;
+	struct nl80211_mlme_event event = {
+		.buf = buf,
+		.buf_len = len,
+		.uapsd_queues = -1,
+	};
 
 	if (WARN_ON(len < 2))
 		return;
 
 	if (ieee80211_is_deauth(mgmt->frame_control)) {
-		cmd = NL80211_CMD_UNPROT_DEAUTHENTICATE;
+		event.cmd = NL80211_CMD_UNPROT_DEAUTHENTICATE;
 	} else if (ieee80211_is_disassoc(mgmt->frame_control)) {
-		cmd = NL80211_CMD_UNPROT_DISASSOCIATE;
+		event.cmd = NL80211_CMD_UNPROT_DISASSOCIATE;
 	} else if (ieee80211_is_beacon(mgmt->frame_control)) {
 		if (wdev->unprot_beacon_reported &&
 		    elapsed_jiffies_msecs(wdev->unprot_beacon_reported) < 10000)
 			return;
-		cmd = NL80211_CMD_UNPROT_BEACON;
+		event.cmd = NL80211_CMD_UNPROT_BEACON;
 		wdev->unprot_beacon_reported = jiffies;
 	} else {
 		return;
 	}
 
 	trace_cfg80211_rx_unprot_mlme_mgmt(dev, buf, len);
-	nl80211_send_mlme_event(rdev, dev, buf, len, cmd, GFP_ATOMIC, -1,
-				NULL, 0, false);
+	nl80211_send_mlme_event(rdev, dev, &event, GFP_ATOMIC);
 }
 EXPORT_SYMBOL(cfg80211_rx_unprot_mlme_mgmt);
 
-- 
2.43.0


