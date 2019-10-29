Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01073E8796
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2019 12:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbfJ2L4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Oct 2019 07:56:16 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:44169 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfJ2L4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Oct 2019 07:56:16 -0400
Received: from localhost.localdomain (unknown [141.24.212.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DD3D8580063;
        Tue, 29 Oct 2019 12:56:14 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] nl80211: allow more operations for mesh and ad-hoc interfaces
Date:   Tue, 29 Oct 2019 12:56:02 +0100
Message-Id: <20191029115602.78990-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This change allows mesh and ad-hoc interfaces to change beacons and
tx queue settings. The direct change of these settings should be ok
for these kind of interfaces and should maybe only forbidden for
station-like interface types.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/wireless/nl80211.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d1451e731bb8..c4ff8c2033af 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2923,7 +2923,9 @@ static int nl80211_set_wiphy(struct sk_buff *skb, struct genl_info *info)
 			return -EINVAL;
 
 		if (netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
-		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
+		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO &&
+		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT &&
+		    netdev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
 			return -EINVAL;
 
 		if (!netif_running(netdev))
@@ -4831,7 +4833,9 @@ static int nl80211_set_beacon(struct sk_buff *skb, struct genl_info *info)
 	int err;
 
 	if (dev->ieee80211_ptr->iftype != NL80211_IFTYPE_AP &&
-	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO)
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_P2P_GO &&
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_MESH_POINT &&
+	    dev->ieee80211_ptr->iftype != NL80211_IFTYPE_ADHOC)
 		return -EOPNOTSUPP;
 
 	if (!rdev->ops->change_beacon)
-- 
2.23.0

