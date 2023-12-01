Return-Path: <linux-wireless+bounces-284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A138008B1
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 11:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D56B213AA
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FCB210E3;
	Fri,  1 Dec 2023 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aJ4RBZ3I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB9D1B4;
	Fri,  1 Dec 2023 02:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EfQkefueeRpWO4moSC5v+lFCZI+GNqDBoK2i8hrHNH0=;
	t=1701427418; x=1702637018; b=aJ4RBZ3IdiPNEtedGV/5OP0Slwl7boso7zHr0xo+/E5aD/A
	WkhkjoeMbCQGkvnjNt+yuAIWDBwd25yyqMcLXxbmB0MErY2eqsvxSw+oj7kjC0f6DK6Pt1od4Ns1w
	OcdILY5McjyYJkfdJ5a/fN8J5kAIA0i/gVKYM5P6I0zmj9pX8/k/WwdSg0yzssfUqdN2sQhuYoac/
	WQqzmV9dcUb2fLo6qijBA6m9XS5jRlmQJtY4JnhAMd+fzKWDH9rRuakk0aOXUcjG/S5QJSF0RHr/T
	DcQQe3zJeOaAV6oYV1BJQYzjWzXGK1gJTf59sre+u7wKjMDHaiWdBNNfT7EdxGjA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r90zg-0000000BBV7-1cQ0;
	Fri, 01 Dec 2023 11:43:36 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/3] wifi: cfg80211: make RX assoc data const
Date: Fri,  1 Dec 2023 11:41:16 +0100
Message-ID: <20231201114329.21b500f4f89b.I2eb7218e5b3cbfff1e72ec5b5e1efb5ec2d24045@changeid>
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

This is just a collection of data and we only read it,
so make it const.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/mlme.c    | 2 +-
 net/wireless/nl80211.c | 2 +-
 net/wireless/nl80211.h | 2 +-
 net/wireless/trace.h   | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d36ad4cedf3b..d59669d86718 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -7312,7 +7312,7 @@ struct cfg80211_rx_assoc_resp_data {
  * This function may sleep. The caller must hold the corresponding wdev's mutex.
  */
 void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_rx_assoc_resp_data *data);
+			    const struct cfg80211_rx_assoc_resp_data *data);
 
 /**
  * struct cfg80211_assoc_failure - association failure data
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index bad9e4fd842f..f635a8b6ca2e 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -22,7 +22,7 @@
 
 
 void cfg80211_rx_assoc_resp(struct net_device *dev,
-			    struct cfg80211_rx_assoc_resp_data *data)
+			    const struct cfg80211_rx_assoc_resp_data *data)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 46a79ed1c97c..403a4a38966a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -17815,7 +17815,7 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
-			   struct cfg80211_rx_assoc_resp_data *data)
+			   const struct cfg80211_rx_assoc_resp_data *data)
 {
 	struct nl80211_mlme_event event = {
 		.cmd = NL80211_CMD_ASSOCIATE,
diff --git a/net/wireless/nl80211.h b/net/wireless/nl80211.h
index aad40240d9cb..6376f3a87f8a 100644
--- a/net/wireless/nl80211.h
+++ b/net/wireless/nl80211.h
@@ -60,7 +60,7 @@ void nl80211_send_rx_auth(struct cfg80211_registered_device *rdev,
 			  const u8 *buf, size_t len, gfp_t gfp);
 void nl80211_send_rx_assoc(struct cfg80211_registered_device *rdev,
 			   struct net_device *netdev,
-			   struct cfg80211_rx_assoc_resp_data *data);
+			   const struct cfg80211_rx_assoc_resp_data *data);
 void nl80211_send_deauth(struct cfg80211_registered_device *rdev,
 			 struct net_device *netdev,
 			 const u8 *buf, size_t len,
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 30cd1bd58aac..4de710efa47e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2928,7 +2928,7 @@ DEFINE_EVENT(netdev_evt_only, cfg80211_send_rx_auth,
 
 TRACE_EVENT(cfg80211_send_rx_assoc,
 	TP_PROTO(struct net_device *netdev,
-		 struct cfg80211_rx_assoc_resp_data *data),
+		 const struct cfg80211_rx_assoc_resp_data *data),
 	TP_ARGS(netdev, data),
 	TP_STRUCT__entry(
 		NETDEV_ENTRY
-- 
2.43.0


