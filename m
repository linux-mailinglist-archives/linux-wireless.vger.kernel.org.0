Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0DF4192DE
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 13:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhI0LMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhI0LMu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 07:12:50 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006AC061575
        for <linux-wireless@vger.kernel.org>; Mon, 27 Sep 2021 04:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=GMdyq65OtrwtF+ma/haUVohQUFjqUsaeMS5pg5KuFek=; t=1632741073; x=1633950673; 
        b=gCtUE/jMNtfVf9ocn97x247nQyUf9aoEG1B6YmMI7LdSq/holAN/K/32ilK1gYEx4rCKr+2jfQh
        YTVnImQbOxFZR4E+ZYx9oQhHXNqxFhFvW2AT5YOlvaFM6YWmfZHEFo9KrZTfvgCTZlM3p0vl7GKJY
        37K8+y4K2wVRACghkPwcbl7KtWp1xnb3IzkQl+1+7i2SnSrsA2E8pqawKJNdmvItvawNVZXdORBHR
        11uQnhUeg3NgnlBaTuRhHzEwXhesXskfNQPopGf6ahfXOXavZai3u0adcWda6YODnZemrQZzpS+D1
        Pm4BKt6Iq6LRyaTIaT+ok9QMZgEZSjMzIqLw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mUoXN-00COH8-Ai;
        Mon, 27 Sep 2021 13:11:09 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+1638e7c770eef6b6c0d0@syzkaller.appspotmail.com
Subject: [PATCH] cfg80211: always free wiphy specific regdomain
Date:   Mon, 27 Sep 2021 13:11:06 +0200
Message-Id: <20210927131105.68b70cef4674.I4b9f0aa08c2af28555963b9fe3d34395bb72e0cc@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In the (somewhat unlikely) event that we allocate a wiphy, then
add a regdomain to it, and then fail registration, we leak the
regdomain. Fix this by just always freeing it at the end, in the
normal cases we'll free (and NULL) it during wiphy_unregister().
This happened when the wiphy settings were bad, and since they
can be controlled by userspace with hwsim, syzbot was able to
find this issue.

Reported-by: syzbot+1638e7c770eef6b6c0d0@syzkaller.appspotmail.com
Fixes: 3e0c3ff36c4c ("cfg80211: allow multiple driver regulatory_hints()")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 03323121ca50..45be124a98f1 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1080,6 +1080,16 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 	list_for_each_entry_safe(scan, tmp, &rdev->bss_list, list)
 		cfg80211_put_bss(&rdev->wiphy, &scan->pub);
 	mutex_destroy(&rdev->wiphy.mtx);
+
+	/*
+	 * The 'regd' can only be non-NULL if we never finished
+	 * initializing the wiphy and thus never went through the
+	 * unregister path - e.g. in failure scenarios. Thus, it
+	 * cannot have been visible to anyone if non-NULL, so we
+	 * can just free it here.
+	 */
+	kfree(rcu_dereference_raw(rdev->wiphy.regd));
+
 	kfree(rdev);
 }
 
-- 
2.31.1

