Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A797E5D8A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjKHS62 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjKHS61 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:58:27 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21222210A
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=Mf5Q59WPA/esaZTjJZGEhgoj/oE5RprmhDBhlWnnqKQ=; t=1699469905; x=1700679505; 
        b=nr+8lTSTvgGu4PwxxqJRZ00bcHsl+IhggkWWH2mDmcmHhmoosWO+zrJ80u2thzRk7MiiYPhzbLI
        T9s8kEjpVS4UWHjx4jy5j4L7gOVVHnp8NUD7KnhH6s+YB9NMVf+oF09qAU2QX2eOKDF5Vrn6uVV9o
        YuuM5N92sn88g+y41oPTGc/6BFv+/uE32MgW7w/lOz1WaiImCT6sToCCgWdwX8pTS8m9Z/18fiIFv
        Bk4FwHPhRFNj3uN8TjR9TzSkvIhduuvruTewM9TPAg/Qx5gU2fcmOmNLKgeJGfqR6CKq/b/UBk/vC
        6RTzJPyCB8+JaSnfkSyjWoeiA5t8d1kzEuag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0nks-00000000i6i-3QNr;
        Wed, 08 Nov 2023 19:58:23 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211: make debugfs locking interruptible
Date:   Wed,  8 Nov 2023 19:58:21 +0100
Message-ID: <20231108195820.f3f4bb4214d3.I33acae0718c86722ae6d416b89a59f3527a77b33@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Due to the locking changes, debugfs accesses can deadlock
because we may delete a debugfs file under wiphy_lock(),
but also acquire it inside the read/write handlers, and
debugfs file removal waits for those to finish.

While we're debating ways to fix this, at least make the
locking interruptible so you can recover from this rather
than having a hard deadlock.

Reported-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/debugfs_netdev.c | 26 +++++++++++++++++---------
 net/mac80211/debugfs_sta.c    |  6 ++++--
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index ec91e131b29e..db7516487225 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -29,11 +29,13 @@ static ssize_t ieee80211_if_read_sdata(
 	ssize_t (*format)(const struct ieee80211_sub_if_data *sdata, char *, int))
 {
 	char buf[200];
-	ssize_t ret = -EINVAL;
+	ssize_t ret;
 
-	wiphy_lock(sdata->local->hw.wiphy);
+	ret = mutex_lock_interruptible(&sdata->local->hw.wiphy->mtx);
+	if (ret)
+		return ret;
 	ret = (*format)(sdata, buf, sizeof(buf));
-	wiphy_unlock(sdata->local->hw.wiphy);
+	mutex_unlock(&sdata->local->hw.wiphy->mtx);
 
 	if (ret >= 0)
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
@@ -57,9 +59,11 @@ static ssize_t ieee80211_if_write_sdata(
 		return -EFAULT;
 	buf[count] = '\0';
 
-	wiphy_lock(sdata->local->hw.wiphy);
+	ret = mutex_lock_interruptible(&sdata->local->hw.wiphy->mtx);
+	if (ret)
+		return ret;
 	ret = (*write)(sdata, buf, count);
-	wiphy_unlock(sdata->local->hw.wiphy);
+	mutex_unlock(&sdata->local->hw.wiphy->mtx);
 
 	return ret;
 }
@@ -73,9 +77,11 @@ static ssize_t ieee80211_if_read_link(
 	char buf[200];
 	ssize_t ret = -EINVAL;
 
-	wiphy_lock(link->sdata->local->hw.wiphy);
+	ret = mutex_lock_interruptible(&link->sdata->local->hw.wiphy->mtx);
+	if (ret)
+		return ret;
 	ret = (*format)(link, buf, sizeof(buf));
-	wiphy_unlock(link->sdata->local->hw.wiphy);
+	mutex_unlock(&link->sdata->local->hw.wiphy->mtx);
 
 	if (ret >= 0)
 		ret = simple_read_from_buffer(userbuf, count, ppos, buf, ret);
@@ -99,9 +105,11 @@ static ssize_t ieee80211_if_write_link(
 		return -EFAULT;
 	buf[count] = '\0';
 
-	wiphy_lock(link->sdata->local->hw.wiphy);
+	ret = mutex_lock_interruptible(&link->sdata->local->hw.wiphy->mtx);
+	if (ret)
+		return ret;
 	ret = (*write)(link, buf, count);
-	wiphy_unlock(link->sdata->local->hw.wiphy);
+	mutex_unlock(&link->sdata->local->hw.wiphy->mtx);
 
 	return ret;
 }
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index 06e3613bf46b..a0b9b5980910 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -420,7 +420,9 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 	if (ret || tid >= IEEE80211_NUM_TIDS)
 		return -EINVAL;
 
-	wiphy_lock(sta->local->hw.wiphy);
+	ret = mutex_lock_interruptible(&sta->local->hw.wiphy->mtx);
+	if (ret)
+		return ret;
 	if (tx) {
 		if (start)
 			ret = ieee80211_start_tx_ba_session(&sta->sta, tid,
@@ -432,7 +434,7 @@ static ssize_t sta_agg_status_write(struct file *file, const char __user *userbu
 					       3, true);
 		ret = 0;
 	}
-	wiphy_unlock(sta->local->hw.wiphy);
+	mutex_unlock(&sta->local->hw.wiphy->mtx);
 
 	return ret ?: count;
 }
-- 
2.41.0

