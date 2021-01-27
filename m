Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89DA306592
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhA0VAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jan 2021 16:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbhA0VAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jan 2021 16:00:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B63C061756
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jan 2021 12:59:53 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l4rum-00CZWs-QR; Wed, 27 Jan 2021 21:59:48 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] virt_wifi: fix deadlock on RTNL
Date:   Wed, 27 Jan 2021 21:59:42 +0100
Message-Id: <20210127215941.2d6a97b09784.I4f1fac32f67045171be50931f44d77e150911bee@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Fix a regression where everything in virt_wifi would just hang. This
happened due to overlapping changes between commit a05829a7222e
("cfg80211: avoid holding the RTNL when calling the driver") which
had originally needed to change the locking, but then I introduced
commit 2fe8ef106238 ("cfg80211: change netdev registration/unregistration
semantics") instead. virt_wifi somehow fell through the cracks when
I undid all the previous locking changes. Fix it now.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/virt_wifi.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 4b455a4ae15b..c878097f0dda 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -537,9 +537,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	dev->ieee80211_ptr->iftype = NL80211_IFTYPE_STATION;
 	dev->ieee80211_ptr->wiphy = common_wiphy;
 
-	wiphy_lock(common_wiphy);
 	err = register_netdevice(dev);
-	wiphy_unlock(common_wiphy);
 	if (err) {
 		dev_err(&priv->lowerdev->dev, "can't register_netdevice: %d\n",
 			err);
@@ -562,9 +560,7 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 
 	return 0;
 unregister_netdev:
-	wiphy_lock(common_wiphy);
 	unregister_netdevice(dev);
-	wiphy_unlock(common_wiphy);
 free_wireless_dev:
 	kfree(dev->ieee80211_ptr);
 	dev->ieee80211_ptr = NULL;
@@ -590,9 +586,7 @@ static void virt_wifi_dellink(struct net_device *dev,
 	netdev_rx_handler_unregister(priv->lowerdev);
 	netdev_upper_dev_unlink(priv->lowerdev, dev);
 
-	wiphy_lock(common_wiphy);
 	unregister_netdevice_queue(dev, head);
-	wiphy_unlock(common_wiphy);
 	module_put(THIS_MODULE);
 
 	/* Deleting the wiphy is handled in the module destructor. */
@@ -631,9 +625,7 @@ static int virt_wifi_event(struct notifier_block *this, unsigned long event,
 		upper_dev = priv->upperdev;
 
 		upper_dev->rtnl_link_ops->dellink(upper_dev, &list_kill);
-		wiphy_lock(common_wiphy);
 		unregister_netdevice_many(&list_kill);
-		wiphy_unlock(common_wiphy);
 		break;
 	}
 
-- 
2.26.2

