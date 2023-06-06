Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A917242FD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237753AbjFFMuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237716AbjFFMuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BCE1711
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=j0S9DR/pIHUEBdCXwEt1NuLG9uNwSX/u6I1+shq9228=;
        t=1686055782; x=1687265382; b=AqYIaQmh69u1Hl/Orc+mKtLLgI1XPp9DZ89hfHl1I3iGzaF
        viVBjD7qD9GIf8RQWVO/1rBn004nXsKflajI/g6dAfwY1M/v67Fet30NgEl9kbGBJ+ngrY8c5m3dx
        VsUdo4sTKRu7xc9oPgsyVt0jNfDBveL5J1TQcxic7oadEHtFQC63tDYgIsWrIiaW6mjP/f4Vqh3NR
        DOegu6Npr4hfUAtSdFx363uo0wkfKrORGNBoKMoXwkPdsATJtqPxsv1iPV2k8IbyhlZpITtep8OWk
        vobmqywh6S6RYpMC6C1s5W6ef738O2ukRObZXgU7nL2E9mqk96ji1u4mIIlTyz6g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W82-00FZDP-0Q;
        Tue, 06 Jun 2023 14:49:38 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 02/14] wifi: cfg80211: hold wiphy lock in pmsr work
Date:   Tue,  6 Jun 2023 14:49:21 +0200
Message-Id: <20230606144753.95133e9367e3.I8ca0b968e8b94636addd3e390d247326ef903246@changeid>
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
the pmsr cleanup worker also hold it, aligning the
locking promises between different parts of cfg80211.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 3 +--
 net/wireless/pmsr.c | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 5ac280092a0f..8215b2060136 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1145,8 +1145,6 @@ static void _cfg80211_unregister_wdev(struct wireless_dev *wdev,
 	ASSERT_RTNL();
 	lockdep_assert_held(&rdev->wiphy.mtx);
 
-	flush_work(&wdev->pmsr_free_wk);
-
 	nl80211_notify_iface(rdev, wdev, NL80211_CMD_DEL_INTERFACE);
 
 	wdev->registered = false;
@@ -1453,6 +1451,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		wiphy_unlock(&rdev->wiphy);
 		/* since we just did cfg80211_leave() nothing to do there */
 		cancel_work_sync(&wdev->disconnect_wk);
+		cancel_work_sync(&wdev->pmsr_free_wk);
 		break;
 	case NETDEV_DOWN:
 		wiphy_lock(&rdev->wiphy);
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 2bc647720cda..77000a264855 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 - 2021 Intel Corporation
+ * Copyright (C) 2018 - 2021, 2023 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include "core.h"
@@ -623,9 +623,11 @@ void cfg80211_pmsr_free_wk(struct work_struct *work)
 	struct wireless_dev *wdev = container_of(work, struct wireless_dev,
 						 pmsr_free_wk);
 
+	wiphy_lock(wdev->wiphy);
 	wdev_lock(wdev);
 	cfg80211_pmsr_process_abort(wdev);
 	wdev_unlock(wdev);
+	wiphy_unlock(wdev->wiphy);
 }
 
 void cfg80211_pmsr_wdev_down(struct wireless_dev *wdev)
-- 
2.40.1

