Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8406372430B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjFFMuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbjFFMuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F1C1722
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bfK86/j1iNV1soMJ+NliKkc5xKpr5nQapFiv+TKHUu0=;
        t=1686055786; x=1687265386; b=j/iDci6z095OgF2fjxgcaDH9j0G+UaU54IgGnf9YhUrMa40
        SQZXHxHcI89hRKVFdHxaYeQcs0aFwR56bFf6F2PKNmR6pYug6lzhDpLdtDkCWdQGU2k/CSTExPQKU
        lpWKQ3n9jyN+CrbrpUKbNR6ubFZAvFbap5NP7alwHYUwq+wEf2nXgPXpqgI1W5QZ0t0QpCJF8vmeB
        B6kdtVVtk1Xotda0cBk79W2xmHNVBzSjf67RbAWRSc+uCyr/pJ9WVS1ES64kylhCFRDg0/lHzaBwt
        /3V2MI3fD01KG9fkjh0CDmPrwaQmunn1tOgEmMKa3iieBXjPgVYbKMLwd7nPWYTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W85-00FZDP-12;
        Tue, 06 Jun 2023 14:49:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/14] wifi: cfg80211: move sched scan stop to wiphy work
Date:   Tue,  6 Jun 2023 14:49:32 +0200
Message-Id: <20230606144753.a7da451559cf.I25ad10960aeffdfab348f9e6590048bed6d64933@changeid>
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

This work can now trivially be converted, it behaves
identical either way.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c    | 6 +++---
 net/wireless/core.h    | 2 +-
 net/wireless/nl80211.c | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 3b37bbc4e8d2..56b7d4404eed 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -365,7 +365,8 @@ static void cfg80211_destroy_iface_wk(struct work_struct *work)
 	rtnl_unlock();
 }
 
-static void cfg80211_sched_scan_stop_wk(struct work_struct *work)
+static void cfg80211_sched_scan_stop_wk(struct wiphy *wiphy,
+					struct wiphy_work *work)
 {
 	struct cfg80211_registered_device *rdev;
 	struct cfg80211_sched_scan_request *req, *tmp;
@@ -541,7 +542,7 @@ struct wiphy *wiphy_new_nm(const struct cfg80211_ops *ops, int sizeof_priv,
 	device_enable_async_suspend(&rdev->wiphy.dev);
 
 	INIT_WORK(&rdev->destroy_work, cfg80211_destroy_iface_wk);
-	INIT_WORK(&rdev->sched_scan_stop_wk, cfg80211_sched_scan_stop_wk);
+	wiphy_work_init(&rdev->sched_scan_stop_wk, cfg80211_sched_scan_stop_wk);
 	INIT_WORK(&rdev->sched_scan_res_wk, cfg80211_sched_scan_results_wk);
 	INIT_WORK(&rdev->propagate_radar_detect_wk,
 		  cfg80211_propagate_radar_detect_wk);
@@ -1148,7 +1149,6 @@ void wiphy_unregister(struct wiphy *wiphy)
 	cancel_delayed_work_sync(&rdev->dfs_update_channels_wk);
 	cancel_delayed_work_sync(&rdev->background_cac_done_wk);
 	flush_work(&rdev->destroy_work);
-	flush_work(&rdev->sched_scan_stop_wk);
 	flush_work(&rdev->propagate_radar_detect_wk);
 	flush_work(&rdev->propagate_cac_done_wk);
 	flush_work(&rdev->mgmt_registrations_update_wk);
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 435060dad81e..468957a0be24 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -95,7 +95,7 @@ struct cfg80211_registered_device {
 	struct cfg80211_coalesce *coalesce;
 
 	struct work_struct destroy_work;
-	struct work_struct sched_scan_stop_wk;
+	struct wiphy_work sched_scan_stop_wk;
 	struct work_struct sched_scan_res_wk;
 
 	struct cfg80211_chan_def radar_chandef;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b74092efa6f0..87a3551a2381 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -19775,7 +19775,8 @@ static int nl80211_netlink_notify(struct notifier_block * nb,
 					list) {
 			if (sched_scan_req->owner_nlportid == notify->portid) {
 				sched_scan_req->nl_owner_dead = true;
-				schedule_work(&rdev->sched_scan_stop_wk);
+				wiphy_work_queue(&rdev->wiphy,
+						 &rdev->sched_scan_stop_wk);
 			}
 		}
 
-- 
2.40.1

