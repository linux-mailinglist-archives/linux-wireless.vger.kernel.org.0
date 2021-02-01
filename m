Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3030AF19
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 19:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbhBASYR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 13:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhBASVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 13:21:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F99C061573
        for <linux-wireless@vger.kernel.org>; Mon,  1 Feb 2021 10:20:59 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l6dom-00EWp2-B9; Mon, 01 Feb 2021 19:20:56 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+2ae0ca9d7737ad1a62b7@syzkaller.appspotmail.com
Subject: [PATCH v2] cfg80211: fix netdev registration deadlock
Date:   Mon,  1 Feb 2021 19:20:50 +0100
Message-Id: <20210201192048.ed8bad436737.I7cae042c44b15f80919a285799a15df467e9d42d@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If register_netdevice() fails after having called cfg80211's
netdev notifier (cfg80211_netdev_notifier_call) it will call
the notifier again with UNREGISTER. This would then lock the
wiphy mutex because we're marked as registered, which causes
a deadlock.

Fix this by separately keeping track of whether or not we're
in the middle of registering to also skip the notifier call
on this unregister.

Reported-by: syzbot+2ae0ca9d7737ad1a62b7@syzkaller.appspotmail.com
Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h | 4 +++-
 net/wireless/core.c    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4741d71ead21..4cdd75449d73 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5299,6 +5299,8 @@ static inline void wiphy_unlock(struct wiphy *wiphy)
  * @wiphy: pointer to hardware description
  * @iftype: interface type
  * @registered: is this wdev already registered with cfg80211
+ * @registering: indicates we're doing registration under wiphy lock
+ *	for the notifier
  * @list: (private) Used to collect the interfaces
  * @netdev: (private) Used to reference back to the netdev, may be %NULL
  * @identifier: (private) Identifier used in nl80211 to identify this
@@ -5382,7 +5384,7 @@ struct wireless_dev {
 
 	struct mutex mtx;
 
-	bool use_4addr, is_running, registered;
+	bool use_4addr, is_running, registered, registering;
 
 	u8 address[ETH_ALEN] __aligned(sizeof(u16));
 
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 18f9a5c214b5..a2785379df6e 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1346,6 +1346,7 @@ int cfg80211_register_netdevice(struct net_device *dev)
 
 	/* we'll take care of this */
 	wdev->registered = true;
+	wdev->registering = true;
 	ret = register_netdevice(dev);
 	if (ret)
 		goto out;
@@ -1361,6 +1362,7 @@ int cfg80211_register_netdevice(struct net_device *dev)
 	cfg80211_register_wdev(rdev, wdev);
 	ret = 0;
 out:
+	wdev->registering = false;
 	if (ret)
 		wdev->registered = false;
 	return ret;
@@ -1403,7 +1405,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		 * It is possible to get NETDEV_UNREGISTER multiple times,
 		 * so check wdev->registered.
 		 */
-		if (wdev->registered) {
+		if (wdev->registered && !wdev->registering) {
 			wiphy_lock(&rdev->wiphy);
 			_cfg80211_unregister_wdev(wdev, false);
 			wiphy_unlock(&rdev->wiphy);
-- 
2.26.2

