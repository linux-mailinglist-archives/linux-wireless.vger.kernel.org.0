Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D77724301
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjFFMuP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237736AbjFFMuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA94171A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=HCpWjaCnz4RSVggrxU4gFB6+eKUhkQpViEiwpIJjP9I=;
        t=1686055785; x=1687265385; b=YbdIbcEJkbv1KfSc4HzSdwXmYBUwx7HPgTDHmqnLbnUnfyt
        bZlTserCj5UeeRfNvSdK2X5oy5N51T3l4fxoh/1nPvF6QcOq8dJGuyCefqWjLqECbAoGCRskh4Uce
        v5f58c3LzOZ0HHUuNrBYNhpjQo9msmKiN/9JWjYReWLaZ0EuB6waIo82tba8iC8aMckIcygaSVr78
        degg3tH0YDFrcz3iH/yw8moDBEkXjKtU/19FHgQmEB8QwOIvhDvJg9Yr8teiBPaDMi7xI/lDUutv5
        zZJ2X6m+FZrHgULJDtgr6O9TuFGMGcenzNIxux2v5DbjTgqD/TnOES3nKMH/+zrQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W83-00FZDP-2V;
        Tue, 06 Jun 2023 14:49:39 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/14] wifi: mac80211: use wiphy work for SMPS
Date:   Tue,  6 Jun 2023 14:49:28 +0200
Message-Id: <20230606144753.a5c9bd2f7f56.I9c81a0493229804096a1b0dce03e61c56e8104a3@changeid>
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

SMPS requests are per link, and currently there's a potential
deadlock with canceling. Use the new wiphy work to handle SMPS
instead, so that the cancel cannot deadlock.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c          |  5 +++--
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mlme.c        | 10 ++++++----
 net/mac80211/tdls.c        |  4 ++--
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 5315ab750280..33729870ad8a 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright(c) 2020-2022 Intel Corporation
+ * Copyright(c) 2020-2023 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -602,7 +602,8 @@ void ieee80211_request_smps(struct ieee80211_vif *vif, unsigned int link_id,
 		goto out;
 
 	link->u.mgd.driver_smps_mode = smps_mode;
-	ieee80211_queue_work(&sdata->local->hw, &link->u.mgd.request_smps_work);
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &link->u.mgd.request_smps_work);
 out:
 	rcu_read_unlock();
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 91bc4982d6b9..4a51ec8b6cee 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -921,7 +921,7 @@ struct ieee80211_link_data_managed {
 	struct timer_list chswitch_timer;
 	struct work_struct chswitch_work;
 
-	struct work_struct request_smps_work;
+	struct wiphy_work request_smps_work;
 	bool beacon_crc_valid;
 	u32 beacon_crc;
 	struct ewma_beacon_signal ave_beacon_signal;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6c659609abee..a24f6f417248 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6532,7 +6532,8 @@ void ieee80211_sta_restart(struct ieee80211_sub_if_data *sdata)
 	sdata_unlock(sdata);
 }
 
-static void ieee80211_request_smps_mgd_work(struct work_struct *work)
+static void ieee80211_request_smps_mgd_work(struct wiphy *wiphy,
+					    struct wiphy_work *work)
 {
 	struct ieee80211_link_data *link =
 		container_of(work, struct ieee80211_link_data,
@@ -6582,8 +6583,8 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	link->u.mgd.conn_flags = 0;
 	link->conf->bssid = link->u.mgd.bssid;
 
-	INIT_WORK(&link->u.mgd.request_smps_work,
-		  ieee80211_request_smps_mgd_work);
+	wiphy_work_init(&link->u.mgd.request_smps_work,
+			ieee80211_request_smps_mgd_work);
 	if (local->hw.wiphy->features & NL80211_FEATURE_DYNAMIC_SMPS)
 		link->u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
 	else
@@ -7546,7 +7547,8 @@ int ieee80211_mgd_disassoc(struct ieee80211_sub_if_data *sdata,
 
 void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 {
-	cancel_work_sync(&link->u.mgd.request_smps_work);
+	wiphy_work_cancel(link->sdata->local->hw.wiphy,
+			  &link->u.mgd.request_smps_work);
 	cancel_work_sync(&link->u.mgd.chswitch_work);
 }
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index b255f3b5bf01..52c47674a554 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -1431,8 +1431,8 @@ int ieee80211_tdls_oper(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (ret == 0)
-		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->deflink.u.mgd.request_smps_work);
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &sdata->deflink.u.mgd.request_smps_work);
 
 	mutex_unlock(&local->mtx);
 	sdata_unlock(sdata);
-- 
2.40.1

