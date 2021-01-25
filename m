Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315C3047C9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 20:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbhAZF4j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbhAYTVS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:18 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FFCC061756
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 11:20:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id i7so9594291pgc.8
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 11:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=d95KpvZ+W0+h9y/jVWQdnBr41kpwBbzV5ZXklJY1vXc=;
        b=ncUepx6gDa2igdquISRH3E3xv8/Hw65bsWW7oQJy4Bt9MWgAAoW/8E/35X+MhrlbAX
         ll/Gnb9kxiw8ToVO4v24CUuyUV03vWTLeV0zhKEZ1AGKi4h0PdiYT56er7DBsPrjH+Ki
         t9vUhXh8xlWn5KqDZS+KXItkEBVTLaMrkuexlQxvOcTfdJiQtWzLzQYI5g210nNJkvGo
         q182oVs3Ukl7LGxxhk2omXc5qb6sBRWOjanm5lxAovwKRQtTlEAIsA3g1JHJgmzphzlH
         OCynRw+98dlvrAWuoCpVAdNOjlJnrpCiFz62TeSfyCDtSC0m37YjD9hFc51BR6Rq6Uis
         CZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d95KpvZ+W0+h9y/jVWQdnBr41kpwBbzV5ZXklJY1vXc=;
        b=f120j7Nfklyd9RGzjpSIkSWd7COSgZJmK9YTPiTnJKW+ZknFPReLklBTJ97m4o8H+W
         ELiNfw4aJv0nKMo1RgBpnQGZLMZ54mCR5U5OG2x5DWH6PjDXbH2jl6+m22czd/aS0OV8
         GAYXaUBKu1MH6dhS3HcjC1wOmL6QvI7x9iYAgYGGlanQ/UX4bT+X8OhvIa7XIYAT/Gq0
         RkARAraSOepsvwmwSwPJKi0BqGN0IYY/hSNWJCXZxc+stpzwyWsOP8Kcr25YxaQiai7J
         tzMH1d8+d/6Enjxe2waNMkaYekEJJ0IeIbXckg8l7FE1motjYVh0PztnsJpGP7HyCMKb
         J8tg==
X-Gm-Message-State: AOAM531UcojdPJpKJOlkB0Lge700boh2LNwdNPV0JLnh/PB9Kt5UUqVJ
        qsrIXieUrS/a8Gp4LJpfIQg=
X-Google-Smtp-Source: ABdhPJyQjBxW/3O9EB54zdRJPJ0lAzqPZpyPlY9dmBDnDthSQIBlT2W8Fji7kuk8FudUJq4W0mU93w==
X-Received: by 2002:a63:4b5c:: with SMTP id k28mr1997489pgl.294.1611602456093;
        Mon, 25 Jan 2021 11:20:56 -0800 (PST)
Received: from localhost.localdomain ([183.83.147.80])
        by smtp.gmail.com with ESMTPSA id br21sm157002pjb.9.2021.01.25.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:20:55 -0800 (PST)
From:   chaitanya.mgit@gmail.com
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Chaitanya Tata <chaitanya.mgit@gmail.com>,
        Chaitanya Tata <chaitanya.tata@bluwireless.com>
Subject: [PATCHv2] cfg80211: Skip key deletion for open associations
Date:   Tue, 26 Jan 2021 00:50:46 +0530
Message-Id: <20210125192046.975-1-chaitanya.mgit@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chaitanya Tata <chaitanya.mgit@gmail.com>

From: Chaitanya Tata <chaitanya.mgit@gmail.com>

If the association is open (no authentication and encryption) no need
to delete the keys, though this is handled by all drivers, this is
unnecessary.

Signed-off-by: Chaitanya Tata <chaitanya.tata@bluwireless.com>
---
v2: Move kfree after check.
---
 net/wireless/sme.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 38df713f2e2e..016655595b48 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1098,8 +1098,6 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	wdev->current_bss = NULL;
 	wdev->ssid_len = 0;
 	wdev->conn_owner_nlportid = 0;
-	kfree_sensitive(wdev->connect_keys);
-	wdev->connect_keys = NULL;
 
 	nl80211_send_disconnected(rdev, dev, reason, ie, ie_len, from_ap);
 
@@ -1113,7 +1111,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	 * Delete all the keys ... pairwise keys can't really
 	 * exist any more anyway, but default keys might.
 	 */
-	if (rdev->ops->del_key) {
+	if (wdev->connect_keys && rdev->ops->del_key) {
 		int max_key_idx = 5;
 
 		if (wiphy_ext_feature_isset(
@@ -1127,6 +1125,9 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			rdev_del_key(rdev, dev, i, false, NULL);
 	}
 
+	kfree_sensitive(wdev->connect_keys);
+	wdev->connect_keys = NULL;
+
 	rdev_set_qos_map(rdev, dev, NULL);
 
 #ifdef CONFIG_CFG80211_WEXT
-- 
2.17.1

