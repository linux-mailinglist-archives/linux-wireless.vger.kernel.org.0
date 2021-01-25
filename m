Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F305F3047CC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 20:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbhAZF41 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbhAYTSf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 14:18:35 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B195C061797
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 11:17:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 11so8981229pfu.4
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 11:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rEHECdyQhXR56O9wH/xOk7o/1QE9qgszq9A9MWvgcjc=;
        b=R1pavMFZ2+QaAEArZBQdAqlv6Llopzqhi75FC0Bb1KCuArvJiT0JEgljRg+MKtwP83
         z7wOWPJBaw22tp4fmPhbMj7DdYJjgsqaBIVIEOmgh9s95F6BN+j+ityJJUYGTBeT3Ie7
         E7AjQh+NkJevPsWSUZ+6m3DLi1+qGI8+kuleq/RAq+gb2ctQOrbsgT+gL+CJ8XT54H/p
         t34Q5XkC0jbV1NKM3FBGSOEwED7IynLKkqNrbBEf/x4ctDNyOexbOI7pZkoOj8hT1Ro7
         mGjoF0SsIAd78WAwTMx+v13pCrEd/q3MywNPOXohic/UahQIg/6mOO9hKJcOS0OYBDEk
         rxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rEHECdyQhXR56O9wH/xOk7o/1QE9qgszq9A9MWvgcjc=;
        b=Hmtw/kr9ggfOamR8HP3SvyfWx4TGr1t8uDLE5yYB5QiqHqD11juydm/CJ2JCQ5IQYn
         10hIHlUmp7MPjAqUPFuSJmcKCbTX0X+DCs5AnDpnDHHKsF4gTXhLvcr6HtlDnbF1HH4u
         ms6bgbNWTUj3Hev4csOD01rq/LgkhDy/cj3OC2mW+iELM62YM7CNnEW79rwCLMW7bHHg
         pa/fRGKYEFLAYpQscIZZ0XLy0jRtKNZ1iSYvrHdlevx5xjndG+hm75gG47bPqjStofIw
         QY5jdwb/xZQmSmLtPsOq7N9YjQLCUc8jYrwAnbItiL0pOPJdn6CXL3+oDsiMP5kI8RIZ
         OuiQ==
X-Gm-Message-State: AOAM5335ySafgXdrxv7Yo8uIFQ5BYaweVPLrW9S1XZhn05fEynYSfIyi
        IVUQLSOS26Eb/6rr9Ukawbc=
X-Google-Smtp-Source: ABdhPJyAf5sg12wkqDZT035guNXiPpFDpKQ71JfH+8eG1FtjoqRLLwAsDr63IzgKfxCLKknIXaE/OQ==
X-Received: by 2002:a63:7885:: with SMTP id t127mr2020212pgc.15.1611602260106;
        Mon, 25 Jan 2021 11:17:40 -0800 (PST)
Received: from localhost.localdomain ([183.83.147.80])
        by smtp.gmail.com with ESMTPSA id x19sm17777969pfp.207.2021.01.25.11.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:17:39 -0800 (PST)
From:   chaitanya.mgit@gmail.com
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Chaitanya Tata <chaitanya.mgit@gmail.com>,
        Chaitanya Tata <chaitanya.tata@bluwireless.com>
Subject: [PATCH] cfg80211: Skip key deletion for open associations
Date:   Tue, 26 Jan 2021 00:47:27 +0530
Message-Id: <20210125191727.518-1-chaitanya.mgit@gmail.com>
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
 net/wireless/sme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 38df713f2e2e..3850af772131 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1099,7 +1099,6 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	wdev->ssid_len = 0;
 	wdev->conn_owner_nlportid = 0;
 	kfree_sensitive(wdev->connect_keys);
-	wdev->connect_keys = NULL;
 
 	nl80211_send_disconnected(rdev, dev, reason, ie, ie_len, from_ap);
 
@@ -1113,7 +1112,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 	 * Delete all the keys ... pairwise keys can't really
 	 * exist any more anyway, but default keys might.
 	 */
-	if (rdev->ops->del_key) {
+	if (wdev->connect_keys && rdev->ops->del_key) {
 		int max_key_idx = 5;
 
 		if (wiphy_ext_feature_isset(
@@ -1127,6 +1126,8 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 			rdev_del_key(rdev, dev, i, false, NULL);
 	}
 
+	wdev->connect_keys = NULL;
+
 	rdev_set_qos_map(rdev, dev, NULL);
 
 #ifdef CONFIG_CFG80211_WEXT
-- 
2.17.1

