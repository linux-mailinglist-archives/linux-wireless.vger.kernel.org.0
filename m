Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BED4A5D42
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Feb 2022 14:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbiBANKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Feb 2022 08:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238679AbiBANJ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Feb 2022 08:09:58 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E427C061401
        for <linux-wireless@vger.kernel.org>; Tue,  1 Feb 2022 05:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=+SlkoWw0BmhIg3WbmN3O6/YE3W/CkOj7xS82vKGNooI=; t=1643720998; x=1644930598; 
        b=ivjnUEdqXz0TgiOi0AvPdpXFHwcF9r9OXPi3JcsHE3fJ3uPTDMd5VHTvjtsIFJe7J9mhpiRlGdY
        pJX1aEFdGdnkb2P/f8GzY2hJuKJK1mH2E6sHPpirIv2il3opzyUOmv0SzTbr2y4sqVJNBvw8V84Ba
        Nh6/G2puo09oImtRPickERVYgtrVfGt9WMByyqRZNmzKu/JHuCJ305NYAojUudKAkTY1VOXjw0cgw
        0Ih+duX8lt5lEON5X1rhcNRjRZTbDJQMEj3QW6l8r8zMoGsjYdgVI41wy2mmxtBONA/1O9KpYigzF
        2As1sDvyIcT+uifZ274uMitSuK2qPiAiHq6Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nEsux-00D7QT-DT;
        Tue, 01 Feb 2022 14:09:55 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH] cfg80211: fix race in netlink owner interface destruction
Date:   Tue,  1 Feb 2022 14:09:51 +0100
Message-Id: <20220201130951.22093-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

My previous fix here to fix the deadlock left a race where
the exact same deadlock (see the original commit referenced
below) can still happen if cfg80211_destroy_ifaces() already
runs while nl80211_netlink_notify() is still marking some
interfaces as nl_owner_dead.

The race happens because we have two loops here - first we
dev_close() all the netdevs, and then we destroy them. If we
also have two netdevs (first one need only be a wdev though)
then we can find one during the first iteration, close it,
and go to the second iteration -- but then find two, and try
to destroy also the one we didn't close yet.

Fix this by only iterating once.

Change-Id: Ie56cd0ef3f0d2108bb8a25c8bb5efced15e6a909
Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Fixes: ea6b2098dd02 ("cfg80211: fix locking in netlink owner interface destruction")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index ff74549b1022..d151a433388c 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2010		Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright 2015-2017	Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -332,29 +332,20 @@ static void cfg80211_event_work(struct work_struct *work)
 void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 {
 	struct wireless_dev *wdev, *tmp;
-	bool found = false;
 
 	ASSERT_RTNL();
 
-	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+	list_for_each_entry_safe(wdev, tmp, &rdev->wiphy.wdev_list, list) {
 		if (wdev->nl_owner_dead) {
 			if (wdev->netdev)
 				dev_close(wdev->netdev);
-			found = true;
-		}
-	}
-
-	if (!found)
-		return;
 
-	wiphy_lock(&rdev->wiphy);
-	list_for_each_entry_safe(wdev, tmp, &rdev->wiphy.wdev_list, list) {
-		if (wdev->nl_owner_dead) {
+			wiphy_lock(&rdev->wiphy);
 			cfg80211_leave(rdev, wdev);
 			rdev_del_virtual_intf(rdev, wdev);
+			wiphy_unlock(&rdev->wiphy);
 		}
 	}
-	wiphy_unlock(&rdev->wiphy);
 }
 
 static void cfg80211_destroy_iface_wk(struct work_struct *work)
-- 
2.34.1

