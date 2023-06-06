Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F95C7242FB
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237731AbjFFMuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbjFFMuD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CCD170E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=BIiq9Xg09rc+YIC+XBny3R6l1bIPO5RBAr7rfMrfw08=;
        t=1686055781; x=1687265381; b=jlqMJXLHMt5543FfLvaeZ3w73Hedhi+VlFk2/m6V9ze/Etf
        v/p2fQ3AaGOjoqzKg1KfTX/bGH4vt76oKJI1x/9MNH3mC3Jl5Ue3CvIC70Qy2Xj+81ATOu+6+hMvm
        MFjhbP7i8dUboalGd5jRoh/7vJ2bf6gUIYMjwK3iFMlkblxCCTAOat9dGxBfeMmGHbfR0GV+detGC
        hHrWRPlRfddbAWXYXAdlAqe/wpAmKwTfXyy/RkNoi6Gpdn/g5hSL6qLxBXi8RMAxyAaRjpmrq7eYp
        L8SL15SJnKfzj1Jdnxqqtpc5k7AG1NkC1yWiZnYmslQ5c/ZS203qZRBIRRbGrtmQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W81-00FZDP-2l;
        Tue, 06 Jun 2023 14:49:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 01/14] wifi: cfg80211: hold wiphy lock in auto-disconnect
Date:   Tue,  6 Jun 2023 14:49:20 +0200
Message-Id: <20230606144753.82c61c57d9cc.I3fd658cf56b9ac76d780799aa1f7c5ed2bc45ad5@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606124933.181107-1-johannes@sipsolutions.net>
References: <20230606124933.181107-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Most code paths in cfg80211 already hold the wiphy lock,
mostly by virtue of being called from nl80211, so make
the auto-disconnect worker also hold it, aligning the
locking promises between different parts of cfg80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 6 ++----
 net/wireless/sme.c  | 4 +++-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5b0c4d5b80cf..5ac280092a0f 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1178,10 +1178,6 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	kfree_sensitive(wdev->wext.keys);
 	wdev->wext.keys = NULL;
 #endif
-	/* only initialized if we have a netdev */
-	if (wdev->netdev)
-		flush_work(&wdev->disconnect_wk);
-
 	cfg80211_cqm_config_free(wdev);
 
 	/*
@@ -1455,6 +1451,8 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		cfg80211_leave(rdev, wdev);
 		cfg80211_remove_links(wdev);
 		wiphy_unlock(&rdev->wiphy);
+		/* since we just did cfg80211_leave() nothing to do there */
+		cancel_work_sync(&wdev->disconnect_wk);
 		break;
 	case NETDEV_DOWN:
 		wiphy_lock(&rdev->wiphy);
diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 7bdeb8eea92d..247369004aaa 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -5,7 +5,7 @@
  * (for nl80211's connect() and wext)
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009, 2020, 2022 Intel Corporation. All rights reserved.
+ * Copyright (C) 2009, 2020, 2022-2023 Intel Corporation. All rights reserved.
  * Copyright 2017	Intel Deutschland GmbH
  */
 
@@ -1569,6 +1569,7 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 		container_of(work, struct wireless_dev, disconnect_wk);
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wdev->wiphy);
 
+	wiphy_lock(wdev->wiphy);
 	wdev_lock(wdev);
 
 	if (wdev->conn_owner_nlportid) {
@@ -1607,4 +1608,5 @@ void cfg80211_autodisconnect_wk(struct work_struct *work)
 	}
 
 	wdev_unlock(wdev);
+	wiphy_unlock(wdev->wiphy);
 }
-- 
2.40.1

