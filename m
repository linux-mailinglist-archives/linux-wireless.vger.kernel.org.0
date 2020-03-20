Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D443D18CBCF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2020 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCTKim (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Mar 2020 06:38:42 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43416 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCTKim (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Mar 2020 06:38:42 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jFF31-00AZic-8T; Fri, 20 Mar 2020 11:38:39 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] nl80211: clarify code in nl80211_del_station()
Date:   Fri, 20 Mar 2020 11:38:35 +0100
Message-Id: <20200320113834.2c51b9e8e341.I3fa5dc3f7d3cb1dbbd77191d764586f7da993f3f@changeid>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The long if chain of interface types is hard to read,
especially now with the additional condition after it.
Use a switch statement to clarify this code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/nl80211.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bc7d81231547..c071ea48481e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6285,16 +6285,22 @@ static int nl80211_del_station(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_MAC])
 		params.mac = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP_VLAN &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
+	switch (dev->ieee80211_ptr->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_P2P_GO:
+		/* always accept these */
+		break;
+	case NL80211_IFTYPE_ADHOC;
+		/* conditionally accept */
+		if (wiphy_ext_feature_isset(&rdev->wiphy,
+					    NL80211_EXT_FEATURE_DEL_IBSS_STA))
+			break;
 		return -EINVAL;
-	if (dev->ieee80211_ptr->iftype == NL80211_IFTYPE_ADHOC &&
-	    !wiphy_ext_feature_isset(&rdev->wiphy,
-				     NL80211_EXT_FEATURE_DEL_IBSS_STA))
+	default:
 		return -EINVAL;
+	}
 
 	if (!rdev->ops->del_station)
 		return -EOPNOTSUPP;
-- 
2.25.1

