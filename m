Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37400724308
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbjFFMuS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237746AbjFFMuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4910F4
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=8bYROfnBZXYqxYveKtr5DmRn8FG7fY3KIdVDuhj6e9k=;
        t=1686055786; x=1687265386; b=XM4Dh7GHU82h/5cEhULb+fSh4h5m4AzGJtqodr9p91lnwAz
        fqwXiNhQBwiFGgH5ltiwYTPy7WUAb1FKZ6Ah/5zZHhb8ZuUZMxz0CM1LF5EZRt0cUVpC239WEeMmi
        L9keK60Zrt36BvYlniCTp7e5k1e/ZIqJflycv0Ofugz/hHpvbJrjvlXj3wUWJuyYCmYqfnjcqPpRi
        U94psLHT/J9It860DjMdT9l5CuqetN+rtJjV90FeONnmnK1Qrks6G8C3lfEXrCZ+Z9lr23Ndm6UBX
        DnNusKniRcJUDEUuUpArio6ffy1sbcjec4yHrUZ84nN5QmvJi1FQT1/mKsXfrWPw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W84-00FZDP-2L;
        Tue, 06 Jun 2023 14:49:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/14] wifi: mac80211: ibss: move disconnect to wiphy work
Date:   Tue,  6 Jun 2023 14:49:30 +0200
Message-Id: <20230606144753.5495a4238d83.I2d0bf4c3f8cb871386179393607140025f93278c@changeid>
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

Move the IBSS disconnect work to be a wiphy work.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ibss.c        | 14 ++++++++------
 net/mac80211/ieee80211_i.h |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 19017810024b..e1900077bc4b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -561,7 +561,8 @@ void ieee80211_ibss_stop(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 
-	cancel_work_sync(&ifibss->csa_connection_drop_work);
+	wiphy_work_cancel(sdata->local->hw.wiphy,
+			  &ifibss->csa_connection_drop_work);
 }
 
 static struct sta_info *ieee80211_ibss_finish_sta(struct sta_info *sta)
@@ -730,7 +731,8 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->mtx);
 }
 
-static void ieee80211_csa_connection_drop_work(struct work_struct *work)
+static void ieee80211_csa_connection_drop_work(struct wiphy *wiphy,
+					       struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
@@ -896,8 +898,8 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	return true;
 disconnect:
 	ibss_dbg(sdata, "Can't handle channel switch, disconnect\n");
-	ieee80211_queue_work(&sdata->local->hw,
-			     &ifibss->csa_connection_drop_work);
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &ifibss->csa_connection_drop_work);
 
 	ieee80211_ibss_csa_mark_radar(sdata);
 
@@ -1733,8 +1735,8 @@ void ieee80211_ibss_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	timer_setup(&ifibss->timer, ieee80211_ibss_timer, 0);
 	INIT_LIST_HEAD(&ifibss->incomplete_stations);
 	spin_lock_init(&ifibss->incomplete_lock);
-	INIT_WORK(&ifibss->csa_connection_drop_work,
-		  ieee80211_csa_connection_drop_work);
+	wiphy_work_init(&ifibss->csa_connection_drop_work,
+			ieee80211_csa_connection_drop_work);
 }
 
 /* scan finished notification */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e1273636488e..b4b765eb09e8 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -553,7 +553,7 @@ struct ieee80211_if_managed {
 
 struct ieee80211_if_ibss {
 	struct timer_list timer;
-	struct work_struct csa_connection_drop_work;
+	struct wiphy_work csa_connection_drop_work;
 
 	unsigned long last_scan_completed;
 
-- 
2.40.1

