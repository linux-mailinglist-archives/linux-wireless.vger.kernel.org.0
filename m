Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C944A14EB9A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgAaLS2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:18:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgAaLS2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:18:28 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEd-0002GC-Vo; Fri, 31 Jan 2020 13:13:16 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:49 +0200
Message-Id: <20200131111300.891737-13-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 12/23] cfg80211: Limit the registration for authentication frames
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

Commit 87e1e12c3b94 ("mac80211: Allow user space to register for
station Rx authentication") enabled registration for authentication
frames to allow PASN flows. However, since some versions of the user
space daemons wrongly register to all types of authentication frames
(which might result in unexpected behavior) allow such registration
if the request is for a specific authentication algorithm number.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/wireless/core.h    |  2 +-
 net/wireless/mlme.c    | 33 +++++++++++++++++++++++++++++----
 net/wireless/nl80211.c |  5 +++--
 3 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index ed487e324571..bb897a803ffe 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -385,7 +385,7 @@ void cfg80211_mlme_down(struct cfg80211_registered_device *rdev,
 			struct net_device *dev);
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_pid,
 				u16 frame_type, const u8 *match_data,
-				int match_len);
+				int match_len, struct netlink_ext_ack *extack);
 void cfg80211_mlme_unreg_wk(struct work_struct *wk);
 void cfg80211_mlme_unregister_socket(struct wireless_dev *wdev, u32 nlpid);
 void cfg80211_mlme_purge_registrations(struct wireless_dev *wdev);
diff --git a/net/wireless/mlme.c b/net/wireless/mlme.c
index f9462010575f..e4805a3bd310 100644
--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2009, Jouni Malinen <j@w1.fi>
  * Copyright (c) 2015		Intel Deutschland GmbH
+ * Copyright (C) 2019 Intel Corporation
  */
 
 #include <linux/kernel.h>
@@ -470,7 +471,7 @@ void cfg80211_mlme_unreg_wk(struct work_struct *wk)
 
 int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 				u16 frame_type, const u8 *match_data,
-				int match_len)
+				int match_len, struct netlink_ext_ack *extack)
 {
 	struct wiphy *wiphy = wdev->wiphy;
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
@@ -481,15 +482,38 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 	if (!wdev->wiphy->mgmt_stypes)
 		return -EOPNOTSUPP;
 
-	if ((frame_type & IEEE80211_FCTL_FTYPE) != IEEE80211_FTYPE_MGMT)
+	if ((frame_type & IEEE80211_FCTL_FTYPE) != IEEE80211_FTYPE_MGMT) {
+		NL_SET_ERR_MSG(extack, "frame type not management");
 		return -EINVAL;
+	}
 
-	if (frame_type & ~(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE))
+	if (frame_type & ~(IEEE80211_FCTL_FTYPE | IEEE80211_FCTL_STYPE)) {
+		NL_SET_ERR_MSG(extack, "Invalid frame type");
 		return -EINVAL;
+	}
 
 	mgmt_type = (frame_type & IEEE80211_FCTL_STYPE) >> 4;
-	if (!(wdev->wiphy->mgmt_stypes[wdev->iftype].rx & BIT(mgmt_type)))
+	if (!(wdev->wiphy->mgmt_stypes[wdev->iftype].rx & BIT(mgmt_type))) {
+		NL_SET_ERR_MSG(extack,
+			       "Registration to specific type not supported");
+		return -EINVAL;
+	}
+
+	/*
+	 * To support Pre Association Security Negotiation (PASN), registration
+	 * for authentication frames should be supported. However, as some
+	 * versions of the user space daemons wrongly register to all types of
+	 * authentication frames (which might result in unexpected behavior)
+	 * allow such registration if the request is for a specific
+	 * authentication algorithm number.
+	 */
+	if (wdev->iftype == NL80211_IFTYPE_STATION &&
+	    (frame_type & IEEE80211_FCTL_STYPE) == IEEE80211_STYPE_AUTH &&
+	    !(match_data && match_len >= 2)) {
+		NL_SET_ERR_MSG(extack,
+			       "Authentication algorithm number required");
 		return -EINVAL;
+	}
 
 	nreg = kzalloc(sizeof(*reg) + match_len, GFP_KERNEL);
 	if (!nreg)
@@ -504,6 +528,7 @@ int cfg80211_mlme_register_mgmt(struct wireless_dev *wdev, u32 snd_portid,
 			continue;
 
 		if (memcmp(reg->match, match_data, mlen) == 0) {
+			NL_SET_ERR_MSG(extack, "Match already configured");
 			err = -EALREADY;
 			break;
 		}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4ac21cf5ffc1..25e9c936289b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10589,8 +10589,9 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	return cfg80211_mlme_register_mgmt(wdev, info->snd_portid, frame_type,
-			nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
-			nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]));
+					   nla_data(info->attrs[NL80211_ATTR_FRAME_MATCH]),
+					   nla_len(info->attrs[NL80211_ATTR_FRAME_MATCH]),
+					   info->extack);
 }
 
 static int nl80211_tx_mgmt(struct sk_buff *skb, struct genl_info *info)
-- 
2.24.1

