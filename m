Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDE8307CB4
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jan 2021 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhA1RhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jan 2021 12:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbhA1RgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jan 2021 12:36:20 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08E3C061794
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jan 2021 09:35:38 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l5BCi-00CwTh-PC; Thu, 28 Jan 2021 18:35:36 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+4305e814f9b267131776@syzkaller.appspotmail.com
Subject: [PATCH 4/4] cfg80211: call cfg80211_destroy_ifaces() with wiphy lock held
Date:   Thu, 28 Jan 2021 18:35:28 +0100
Message-Id: <20210128183454.d31df9cbd7ce.I1beb07c9492f0ade900e864a098c57041e7a7ebf@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210128173528.76393-1-johannes@sipsolutions.net>
References: <20210128173528.76393-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is needed since it calls into the driver, which must have the
same context as if we got to destroy an interface through nl80211.
Fix this, and add a direct lockdep assertion so we don't see it
pop up only when the driver calls back to cfg80211.

Fixes: a05829a7222e ("cfg80211: avoid holding the RTNL when calling the driver")
Reported-by: syzbot+4305e814f9b267131776@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 200cd9f5fd5f..18f9a5c214b5 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -334,6 +334,7 @@ void cfg80211_destroy_ifaces(struct cfg80211_registered_device *rdev)
 	struct wireless_dev *wdev, *tmp;
 
 	ASSERT_RTNL();
+	lockdep_assert_wiphy(&rdev->wiphy);
 
 	list_for_each_entry_safe(wdev, tmp, &rdev->wiphy.wdev_list, list) {
 		if (wdev->nl_owner_dead)
@@ -349,7 +350,9 @@ static void cfg80211_destroy_iface_wk(struct work_struct *work)
 			    destroy_work);
 
 	rtnl_lock();
+	wiphy_lock(&rdev->wiphy);
 	cfg80211_destroy_ifaces(rdev);
+	wiphy_unlock(&rdev->wiphy);
 	rtnl_unlock();
 }
 
-- 
2.26.2

