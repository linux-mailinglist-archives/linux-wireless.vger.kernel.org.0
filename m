Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29E97E5673
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 13:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjKHMle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 07:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344373AbjKHMld (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 07:41:33 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752F31BF0
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 04:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=7/0k8R5MwGL0iLHlcjQghBsX84YHRqaFQL2eml41fc8=; t=1699447291; x=1700656891; 
        b=XVRReEDbDGzAxOOpU/c2j6XtXPd9GOnB09qoDyRDy82t72XcVTDfeJIs+xUavIcvmqp7oGorayB
        Tjo3a7OlpJ9dBX8pWu/flZ3WV0EdOFkI4ZytIgQ2cWN8YIVxkl3NX0ryqpcwxBVKDDOFB9vr5RUKe
        tOG53bzz2/69+xhQkubHVwSmOus8Bc8/hlxz6d8oqiK50l/tVTrSro285IubNpBDdn90++s+4su9D
        E0EY+FCqW2O+/wCqOLmgXPwdAT7yUqzWJSW5DO1DlPdYb/1chULYmMH3fE+GmkNB6cVGQ5Cpp/bSk
        hVFIcPJmtrEyEsvU1Tti/3+zNQKxGT9ww0ZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r0hs8-00000000VB3-0cC9;
        Wed, 08 Nov 2023 13:41:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com
Subject: [PATCH] wifi: cfg80211: lock wiphy mutex for rfkill poll
Date:   Wed,  8 Nov 2023 13:41:25 +0100
Message-ID: <20231108134124.de02800a7b66.I8caff5f6d6a5212bca99afad1a191cf2321cdf28@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We want to guarantee the mutex is held for pretty much
all operations, so ensure that here as well.

Reported-by: syzbot+7e59a5bfc7a897247e18@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 758c9a2a12c0..3f756ce46602 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -221,7 +221,9 @@ static void cfg80211_rfkill_poll(struct rfkill *rfkill, void *data)
 {
 	struct cfg80211_registered_device *rdev = data;
 
+	wiphy_lock(&rdev->wiphy);
 	rdev_rfkill_poll(rdev);
+	wiphy_unlock(&rdev->wiphy);
 }
 
 void cfg80211_stop_p2p_device(struct cfg80211_registered_device *rdev,
-- 
2.41.0

