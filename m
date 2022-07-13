Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA5557336F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234041AbiGMJqk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiGMJpg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A58EEAB6
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Kmk/LW5lYWNCmipN+RRXp/n/gworMvqmnXQuejXydHA=;
        t=1657705527; x=1658915127; b=Yx/dgCYM/UOwj+UV+O+ytAptaZKpEmmcyp5NBgCJYMdIYvK
        /m0/08M0RwwGXSARoN7B4eIhI19WKRZlQCVFtrffaAWLK8KeRDrdBQuXAJ1AuXEhCwn6EPwjdtFK+
        /igI1lXIAl4qf3Z629bhTBkzSrme6F7TEb6kMPXK0k2wQE+RWk74Yy9Lmffxz0sa/FP1IapcQTo4U
        h7WFwzTRNnuzrkdMFk5wWn95mzMESP/MBV+jAPdZfHIJwKpJ3OsAWK5yoYJeoP7uVOauWUrmWqkVR
        SKEFyKOr+IMoPPP5x/M+VqQcm9Ft49II+ITtIpMyH6vsKrsguZifx0LGchhvFJ2g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvs-00EgvB-SI;
        Wed, 13 Jul 2022 11:45:25 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 57/76] wifi: cfg80211: clean up links appropriately
Date:   Wed, 13 Jul 2022 11:44:43 +0200
Message-Id: <20220713114425.f9bea0264306.Iac8f8265454b023660801822fee547803dab3796@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This was missing earlier, we need to remove links when
interfaces are being destroyed, and we also need to
stop (AP) operations when a link is being destroyed.
Address these issues to remove many warnings that will
otherwise appear in mac80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c    |  3 ++-
 net/wireless/core.h    |  5 +++++
 net/wireless/nl80211.c | 11 ++---------
 net/wireless/util.c    | 43 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 6b5321bb1176..eefd6d8ff465 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -342,7 +342,7 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 
 			wiphy_lock(&rdev->wiphy);
 			cfg80211_leave(rdev, wdev);
-			rdev_del_virtual_intf(rdev, wdev);
+			cfg80211_remove_virtual_intf(rdev, wdev);
 			wiphy_unlock(&rdev->wiphy);
 		}
 	}
@@ -1437,6 +1437,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 	case NETDEV_GOING_DOWN:
 		wiphy_lock(&rdev->wiphy);
 		cfg80211_leave(rdev, wdev);
+		cfg80211_remove_links(wdev);
 		wiphy_unlock(&rdev->wiphy);
 		break;
 	case NETDEV_DOWN:
diff --git a/net/wireless/core.h b/net/wireless/core.h
index e72ca6eefafb..775e16cb99ed 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -562,4 +562,9 @@ void cfg80211_release_pmsr(struct wireless_dev *wdev, u32 portid);
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev);
 void cfg80211_pmsr_free_wk(struct work_struct *work);
 
+void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id);
+void cfg80211_remove_links(struct wireless_dev *wdev);
+int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
+				 struct wireless_dev *wdev);
+
 #endif /* __NET_WIRELESS_CORE_H */
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 11cad2d46d0e..d774e9a95492 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -4279,7 +4279,7 @@ static int nl80211_del_interface(struct sk_buff *skb, struct genl_info *info)
 
 	mutex_lock(&rdev->wiphy.mtx);
 
-	return rdev_del_virtual_intf(rdev, wdev);
+	return cfg80211_remove_virtual_intf(rdev, wdev);
 }
 
 static int nl80211_set_noack_map(struct sk_buff *skb, struct genl_info *info)
@@ -15707,7 +15707,6 @@ static int nl80211_add_link(struct sk_buff *skb, struct genl_info *info)
 
 static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 {
-	struct cfg80211_registered_device *rdev = info->user_ptr[0];
 	unsigned int link_id = nl80211_link_id(info->attrs);
 	struct net_device *dev = info->user_ptr[1];
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
@@ -15723,14 +15722,8 @@ static int nl80211_remove_link(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 	}
 
-	/* FIXME: stop the link operations first */
-
 	wdev_lock(wdev);
-	wdev->valid_links &= ~BIT(link_id);
-
-	rdev_del_intf_link(rdev, wdev, link_id);
-
-	eth_zero_addr(wdev->links[link_id].addr);
+	cfg80211_remove_link(wdev, link_id);
 	wdev_unlock(wdev);
 
 	return 0;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index b7257862e0fe..fe7956c8c6da 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -2447,3 +2447,46 @@ bool cfg80211_iftype_allowed(struct wiphy *wiphy, enum nl80211_iftype iftype,
 	return false;
 }
 EXPORT_SYMBOL(cfg80211_iftype_allowed);
+
+void cfg80211_remove_link(struct wireless_dev *wdev, unsigned int link_id)
+{
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
+
+	ASSERT_WDEV_LOCK(wdev);
+
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		__cfg80211_stop_ap(rdev, wdev->netdev, link_id, true);
+		break;
+	default:
+		/* per-link not relevant */
+		break;
+	}
+
+	wdev->valid_links &= ~BIT(link_id);
+
+	rdev_del_intf_link(rdev, wdev, link_id);
+
+	eth_zero_addr(wdev->links[link_id].addr);
+}
+
+void cfg80211_remove_links(struct wireless_dev *wdev)
+{
+	unsigned int link_id;
+
+	wdev_lock(wdev);
+	if (wdev->valid_links) {
+		for_each_valid_link(wdev, link_id)
+			cfg80211_remove_link(wdev, link_id);
+	}
+	wdev_unlock(wdev);
+}
+
+int cfg80211_remove_virtual_intf(struct cfg80211_registered_device *rdev,
+				 struct wireless_dev *wdev)
+{
+	cfg80211_remove_links(wdev);
+
+	return rdev_del_virtual_intf(rdev, wdev);
+}
-- 
2.36.1

