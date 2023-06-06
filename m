Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC772430A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbjFFMuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjFFMuK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:10 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97E21721
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=MAe3Y+yRSHtDQjn24fzXaUuWHRK8xfPBVXRHo3tHgfw=;
        t=1686055786; x=1687265386; b=ZesoHCL3J7mNEoTbI2mtJzgXkIuJ0Bql3luHhWCz++v7sBI
        f1nT5GOqfl/stb8wwR+gIc/7XNnLHRQzGEZaKNpAuIOtyvd/xn5QnTtF/5fTAhWFArWjNFVse+lCP
        fkpYBAMkcoo5Tu/ZRqRmFvfAbFbnxpy3y8fShkGD4+12VOXX2kYBdLsk287dle3TVnQ19yLDmMrjn
        3jSoVdMtN5zVWPd6OtkMZtVssY3Bp1Tu11y6pi5D6KMFsQeybRhgx246xNAS0iwO5SnD++pdueyh6
        xpieY17LX8tW3CI1b/ylWClfoKOogH/VNepLfY2gCQiQ82G4DYWywaHPCEjE44bQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W84-00FZDP-3D;
        Tue, 06 Jun 2023 14:49:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/14] wifi: mac80211: mlme: move disconnects to wiphy work
Date:   Tue,  6 Jun 2023 14:49:31 +0200
Message-Id: <20230606144753.8af18dca8e2d.Id33ac6523806473156562bde3c91f2348e16db1f@changeid>
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

Move the beacon loss work that might cause a disconnect
and the CSA disconnect work to be wiphy work, so we hold
the wiphy lock for them.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         |  2 +-
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/main.c        |  3 ++-
 net/mac80211/mlme.c        | 49 +++++++++++++++++++++-----------------
 4 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 801aaa62b68f..027c58d23f07 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3589,7 +3589,7 @@ void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_t
 
 	sdata->deflink.csa_block_tx = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
-	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
+	wiphy_work_queue(local->hw.wiphy, &ifmgd->csa_connection_drop_work);
 }
 EXPORT_SYMBOL(ieee80211_channel_switch_disconnect);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b4b765eb09e8..6219c33bda31 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -466,8 +466,8 @@ struct ieee80211_if_managed {
 	struct timer_list conn_mon_timer;
 	struct timer_list bcn_mon_timer;
 	struct work_struct monitor_work;
-	struct work_struct beacon_connection_loss_work;
-	struct work_struct csa_connection_drop_work;
+	struct wiphy_work beacon_connection_loss_work;
+	struct wiphy_work csa_connection_drop_work;
 
 	unsigned long beacon_timeout;
 	unsigned long probe_timeout;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 3db178b1d50c..24315d7b3126 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -364,7 +364,8 @@ static void ieee80211_restart_work(struct work_struct *work)
 			 * The exception is ieee80211_chswitch_done.
 			 * Then we can have a race...
 			 */
-			cancel_work_sync(&sdata->u.mgd.csa_connection_drop_work);
+			wiphy_work_cancel(local->hw.wiphy,
+					  &sdata->u.mgd.csa_connection_drop_work);
 			if (sdata->vif.bss_conf.csa_active) {
 				sdata_lock(sdata);
 				ieee80211_sta_connection_lost(sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c00ae04df276..351fdaf2096e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1718,8 +1718,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 			sdata_info(sdata,
 				   "failed to use reserved channel context, disconnecting (err=%d)\n",
 				   ret);
-			ieee80211_queue_work(&sdata->local->hw,
-					     &ifmgd->csa_connection_drop_work);
+			wiphy_work_queue(sdata->local->hw.wiphy,
+					 &ifmgd->csa_connection_drop_work);
 			goto out;
 		}
 
@@ -1730,8 +1730,8 @@ static void ieee80211_chswitch_work(struct wiphy *wiphy,
 					&link->csa_chandef)) {
 		sdata_info(sdata,
 			   "failed to finalize channel switch, disconnecting\n");
-		ieee80211_queue_work(&sdata->local->hw,
-				     &ifmgd->csa_connection_drop_work);
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &ifmgd->csa_connection_drop_work);
 		goto out;
 	}
 
@@ -1775,8 +1775,8 @@ static void ieee80211_chswitch_post_beacon(struct ieee80211_link_data *link)
 	if (ret) {
 		sdata_info(sdata,
 			   "driver post channel switch failed, disconnecting\n");
-		ieee80211_queue_work(&local->hw,
-				     &ifmgd->csa_connection_drop_work);
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &ifmgd->csa_connection_drop_work);
 		return;
 	}
 
@@ -1795,8 +1795,8 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
 	if (!success) {
 		sdata_info(sdata,
 			   "driver channel switch failed, disconnecting\n");
-		ieee80211_queue_work(&sdata->local->hw,
-				     &ifmgd->csa_connection_drop_work);
+		wiphy_work_queue(sdata->local->hw.wiphy,
+				 &ifmgd->csa_connection_drop_work);
 	} else {
 		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
 					 &sdata->deflink.u.mgd.chswitch_work,
@@ -2012,7 +2012,8 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	link->conf->csa_active = true;
 	link->csa_block_tx = csa_ie.mode;
 
-	ieee80211_queue_work(&local->hw, &ifmgd->csa_connection_drop_work);
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &ifmgd->csa_connection_drop_work);
 	mutex_unlock(&local->chanctx_mtx);
 	mutex_unlock(&local->mtx);
 }
@@ -3409,7 +3410,8 @@ static void __ieee80211_disconnect(struct ieee80211_sub_if_data *sdata)
 	sdata_unlock(sdata);
 }
 
-static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
+static void ieee80211_beacon_connection_loss_work(struct wiphy *wiphy,
+						  struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
@@ -3434,7 +3436,8 @@ static void ieee80211_beacon_connection_loss_work(struct work_struct *work)
 	}
 }
 
-static void ieee80211_csa_connection_drop_work(struct work_struct *work)
+static void ieee80211_csa_connection_drop_work(struct wiphy *wiphy,
+					       struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
@@ -3451,7 +3454,7 @@ void ieee80211_beacon_loss(struct ieee80211_vif *vif)
 	trace_api_beacon_loss(sdata);
 
 	sdata->u.mgd.connection_loss = false;
-	ieee80211_queue_work(hw, &sdata->u.mgd.beacon_connection_loss_work);
+	wiphy_work_queue(hw->wiphy, &sdata->u.mgd.beacon_connection_loss_work);
 }
 EXPORT_SYMBOL(ieee80211_beacon_loss);
 
@@ -3463,7 +3466,7 @@ void ieee80211_connection_loss(struct ieee80211_vif *vif)
 	trace_api_connection_loss(sdata);
 
 	sdata->u.mgd.connection_loss = true;
-	ieee80211_queue_work(hw, &sdata->u.mgd.beacon_connection_loss_work);
+	wiphy_work_queue(hw->wiphy, &sdata->u.mgd.beacon_connection_loss_work);
 }
 EXPORT_SYMBOL(ieee80211_connection_loss);
 
@@ -3479,7 +3482,7 @@ void ieee80211_disconnect(struct ieee80211_vif *vif, bool reconnect)
 
 	sdata->u.mgd.driver_disconnect = true;
 	sdata->u.mgd.reconnect = reconnect;
-	ieee80211_queue_work(hw, &sdata->u.mgd.beacon_connection_loss_work);
+	wiphy_work_queue(hw->wiphy, &sdata->u.mgd.beacon_connection_loss_work);
 }
 EXPORT_SYMBOL(ieee80211_disconnect);
 
@@ -6368,8 +6371,8 @@ static void ieee80211_sta_bcn_mon_timer(struct timer_list *t)
 		return;
 
 	sdata->u.mgd.connection_loss = false;
-	ieee80211_queue_work(&sdata->local->hw,
-			     &sdata->u.mgd.beacon_connection_loss_work);
+	wiphy_work_queue(sdata->local->hw.wiphy,
+			 &sdata->u.mgd.beacon_connection_loss_work);
 }
 
 static void ieee80211_sta_conn_mon_timer(struct timer_list *t)
@@ -6544,10 +6547,10 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 
 	INIT_WORK(&ifmgd->monitor_work, ieee80211_sta_monitor_work);
-	INIT_WORK(&ifmgd->beacon_connection_loss_work,
-		  ieee80211_beacon_connection_loss_work);
-	INIT_WORK(&ifmgd->csa_connection_drop_work,
-		  ieee80211_csa_connection_drop_work);
+	wiphy_work_init(&ifmgd->beacon_connection_loss_work,
+			ieee80211_beacon_connection_loss_work);
+	wiphy_work_init(&ifmgd->csa_connection_drop_work,
+			ieee80211_csa_connection_drop_work);
 	INIT_DELAYED_WORK(&ifmgd->tdls_peer_del_work,
 			  ieee80211_tdls_peer_del_work);
 	timer_setup(&ifmgd->timer, ieee80211_sta_timer, 0);
@@ -7556,8 +7559,10 @@ void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
 	 * cancelled when disconnecting.
 	 */
 	cancel_work_sync(&ifmgd->monitor_work);
-	cancel_work_sync(&ifmgd->beacon_connection_loss_work);
-	cancel_work_sync(&ifmgd->csa_connection_drop_work);
+	wiphy_work_cancel(sdata->local->hw.wiphy,
+			  &ifmgd->beacon_connection_loss_work);
+	wiphy_work_cancel(sdata->local->hw.wiphy,
+			  &ifmgd->csa_connection_drop_work);
 	cancel_delayed_work_sync(&ifmgd->tdls_peer_del_work);
 
 	sdata_lock(sdata);
-- 
2.40.1

