Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB6C78AF9A
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjH1MGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjH1MFq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17617123
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dJSNVRa3c+jqlrTbjXpVRQzQ8AOEG8UEdL7OmwYtbrA=;
        t=1693224344; x=1694433944; b=NpLMlTtrsr0gJLmrRjR2AWrl9Ohn5TKF9M6y4o8g9pFpQDX
        pRFWbCZvoBlOWRfGPYBx2uI/WHjaXJwUHaLaO74MzWsFwz8BFhU6AE+73GWHwUTVr7sGkhZ5OogLl
        ze/ofMWTXi6uMN2ehaN1NTL5YQ+HbqNlPXxcf+/aLE2bA+jxNUAToR+xH248eY3khBfaqC9Kl4/ze
        wZrdnpGtrQCcGn+6JNYADDw5nyXVBO9RexI1RvyU00K70Goey90U+msGnRwixe21SMEByPFJ0jtrC
        I3p+9VxmDwcpTFeohkEtttzWCWWa3MBMuwX0WkdvoGETLdb5OmzXwXUkllu8AlKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab02-00Gjgt-06;
        Mon, 28 Aug 2023 14:05:42 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 28/40] wifi: cfg80211: check wiphy mutex is held for wdev mutex
Date:   Mon, 28 Aug 2023 13:59:56 +0200
Message-ID: <20230828135928.cb773b6c358c.I31b42971dffe8e77248cef445c6563b97f9138b0@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This might seem pretty pointless rather than changing the locking
immediately, but it seems safer to run for a while with checks and
the old locking scheme, and then remove the wdev lock later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index b9876b444e1b..5dc76ea3b84e 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -238,6 +238,7 @@ void cfg80211_register_wdev(struct cfg80211_registered_device *rdev,
 static inline void wdev_lock(struct wireless_dev *wdev)
 	__acquires(wdev)
 {
+	lockdep_assert_held(&wdev->wiphy->mtx);
 	mutex_lock(&wdev->mtx);
 	__acquire(wdev->mtx);
 }
@@ -245,11 +246,16 @@ static inline void wdev_lock(struct wireless_dev *wdev)
 static inline void wdev_unlock(struct wireless_dev *wdev)
 	__releases(wdev)
 {
+	lockdep_assert_held(&wdev->wiphy->mtx);
 	__release(wdev->mtx);
 	mutex_unlock(&wdev->mtx);
 }
 
-#define ASSERT_WDEV_LOCK(wdev) lockdep_assert_held(&(wdev)->mtx)
+static inline void ASSERT_WDEV_LOCK(struct wireless_dev *wdev)
+{
+	lockdep_assert_held(&wdev->wiphy->mtx);
+	lockdep_assert_held(&wdev->mtx);
+}
 
 static inline bool cfg80211_has_monitors_only(struct cfg80211_registered_device *rdev)
 {
-- 
2.41.0

