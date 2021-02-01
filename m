Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA530A950
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Feb 2021 15:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhBAOFa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Feb 2021 09:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhBAOF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Feb 2021 09:05:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95182C061756
        for <linux-wireless@vger.kernel.org>; Mon,  1 Feb 2021 06:04:47 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l6Zoq-00ERo9-Tt; Mon, 01 Feb 2021 15:04:45 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+2ae0ca9d7737ad1a62b7@syzkaller.appspotmail.com
Subject: [PATCH] cfg80211: fix netdev registration deadlock
Date:   Mon,  1 Feb 2021 15:04:38 +0100
Message-Id: <20210201150437.275519ea8047.I7cae042c44b15f80919a285799a15df467e9d42d@changeid>
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
 include/net/cfg80211.h | 3 +++
 net/wireless/core.c    | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4741d71ead21..ceeeb1d7cfe5 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4788,6 +4788,8 @@ struct wiphy_iftype_akm_suites {
  *	the same number of arbitrary MAC addresses.
  * @registered: protects ->resume and ->suspend sysfs callbacks against
  *	unregister hardware
+ * @registering: indicates we're doing registration under wiphy lock
+ *	for the notifier
  * @debugfsdir: debugfs directory used for this wiphy (ieee80211/<wiphyname>).
  *	It will be renamed automatically on wiphy renames
  * @dev: (virtual) struct device for this wiphy. The item in
@@ -5033,6 +5035,7 @@ struct wiphy {
 	struct device dev;
 
 	bool registered;
+	bool registering;
 
 	struct dentry *debugfsdir;
 
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

