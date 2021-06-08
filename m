Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C847239F278
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jun 2021 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhFHJeb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Jun 2021 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhFHJe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Jun 2021 05:34:29 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C107C061574
        for <linux-wireless@vger.kernel.org>; Tue,  8 Jun 2021 02:32:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lqY66-003gsH-36; Tue, 08 Jun 2021 11:32:34 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/4] cfg80211: fix phy80211 symlink creation
Date:   Tue,  8 Jun 2021 11:32:28 +0200
Message-Id: <20210608113226.a5dc4c1e488c.Ia42fe663cefe47b0883af78c98f284c5555bbe5d@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608113226.14020430e449.I78e19db0a55a8295a376e15ac4cf77dbb4c6fb51@changeid>
References: <20210608113226.14020430e449.I78e19db0a55a8295a376e15ac4cf77dbb4c6fb51@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When I moved around the code here, I neglected that we could still
call register_netdev() or similar without the wiphy mutex held,
which then calls cfg80211_register_wdev() - that's also done from
cfg80211_register_netdevice(), but the phy80211 symlink creation
was only there. Now, the symlink isn't needed for a *pure* wdev,
but a netdev not registered via cfg80211_register_wdev() should
still have the symlink, so move the creation to the right place.

Fixes: 2fe8ef106238 ("cfg80211: change netdev registration/unregistration semantics")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 6fbf7537faf5..8d0883e81093 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1340,6 +1340,11 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 	rdev->devlist_generation++;
 	wdev->registered = true;
 
+	if (wdev->netdev &&
+	    sysfs_create_link(&wdev->netdev->dev.kobj, &rdev->wiphy.dev.kobj,
+			      "phy80211"))
+		pr_err("failed to add phy80211 symlink to netdev!\n");
+
 	nl80211_notify_iface(rdev, wdev, NL80211_CMD_NEW_INTERFACE);
 }
 
@@ -1365,14 +1370,6 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	if (ret)
 		goto out;
 
-	if (sysfs_create_link(&dev->dev.kobj, &rdev->wiphy.dev.kobj,
-			      "phy80211")) {
-		pr_err("failed to add phy80211 symlink to netdev!\n");
-		unregister_netdevice(dev);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	cfg80211_register_wdev(rdev, wdev);
 	ret = 0;
 out:
-- 
2.31.1

