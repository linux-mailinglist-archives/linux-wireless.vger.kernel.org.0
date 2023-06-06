Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF11D724307
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjFFMuR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 08:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbjFFMuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 08:50:08 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FFD171B
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=srJ0fwk1NhFET7SxMQVHX4TPYDpl0t9Gx8UNI65CGvk=;
        t=1686055785; x=1687265385; b=PCwzYlBaqYZRgfQ8TotsoWM44DAl0BlL03qxtiiH0VSJyxK
        Pnte3f0Dk2JF9EHPHluni2r4BL55VdgWa99hTirwz2r0jsirCZ6TRgVtG70RHSBNYufk8/ZjUhs3B
        A65TQvI4hDGUftxBimCy/IvSgaJHLqusfqBhIEsqipNeQ3wW5GH8LRniAGfpgzqM3U1XNfExZxjZW
        u9vDv5JBEZLBwQREp4KsbGvojDQih0wJBjOJ0JefrCrc+T4ULudP6k4llZcYcwlmY3eksmJILA8KJ
        9Gl46WoHSEMjYMrUvYNGFNW2+yDPHXSe7lexMVDx8qmAkv4sIGvA8oplT6L3mlBA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6W84-00FZDP-03;
        Tue, 06 Jun 2023 14:49:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/14] wifi: mac80211: use wiphy work for channel switch
Date:   Tue,  6 Jun 2023 14:49:29 +0200
Message-Id: <20230606144753.88636e992199.I67d3707e2c36450f52cf081c92de09f0c1a32932@changeid>
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

Channel switch obviously must be handled per link, and we
have a (potential) deadlock when canceling that work. Use
the new delayed wiphy work to handle this instead and get
rid of the explicit timer that way too.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        |  4 ++--
 net/mac80211/ieee80211_i.h |  3 +--
 net/mac80211/mlme.c        | 40 ++++++++++++++++----------------------
 3 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 88b24a69b891..2c349aae59a3 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -1186,8 +1186,8 @@ ieee80211_link_chanctx_reservation_complete(struct ieee80211_link_data *link)
 				     &link->csa_finalize_work);
 		break;
 	case NL80211_IFTYPE_STATION:
-		ieee80211_queue_work(&sdata->local->hw,
-				     &link->u.mgd.chswitch_work);
+		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+					 &link->u.mgd.chswitch_work, 0);
 		break;
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NL80211_IFTYPE_AP_VLAN:
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4a51ec8b6cee..e1273636488e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -918,8 +918,7 @@ struct ieee80211_link_data_managed {
 
 	bool csa_waiting_bcn;
 	bool csa_ignored_same_chan;
-	struct timer_list chswitch_timer;
-	struct work_struct chswitch_work;
+	struct wiphy_delayed_work chswitch_work;
 
 	struct wiphy_work request_smps_work;
 	bool beacon_crc_valid;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a24f6f417248..c00ae04df276 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1673,10 +1673,12 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 }
 
 /* spectrum management related things */
-static void ieee80211_chswitch_work(struct work_struct *work)
+static void ieee80211_chswitch_work(struct wiphy *wiphy,
+				    struct wiphy_work *work)
 {
 	struct ieee80211_link_data *link =
-		container_of(work, struct ieee80211_link_data, u.mgd.chswitch_work);
+		container_of(work, struct ieee80211_link_data,
+			     u.mgd.chswitch_work.work);
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
@@ -1796,21 +1798,13 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success)
 		ieee80211_queue_work(&sdata->local->hw,
 				     &ifmgd->csa_connection_drop_work);
 	} else {
-		ieee80211_queue_work(&sdata->local->hw,
-				     &sdata->deflink.u.mgd.chswitch_work);
+		wiphy_delayed_work_queue(sdata->local->hw.wiphy,
+					 &sdata->deflink.u.mgd.chswitch_work,
+					 0);
 	}
 }
 EXPORT_SYMBOL(ieee80211_chswitch_done);
 
-static void ieee80211_chswitch_timer(struct timer_list *t)
-{
-	struct ieee80211_link_data *link =
-		from_timer(link, t, u.mgd.chswitch_timer);
-
-	ieee80211_queue_work(&link->sdata->local->hw,
-			     &link->u.mgd.chswitch_work);
-}
-
 static void
 ieee80211_sta_abort_chanswitch(struct ieee80211_link_data *link)
 {
@@ -1854,6 +1848,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	struct ieee80211_csa_ie csa_ie;
 	struct ieee80211_channel_switch ch_switch;
 	struct ieee80211_bss *bss;
+	unsigned long timeout;
 	int res;
 
 	sdata_assert_lock(sdata);
@@ -1997,12 +1992,11 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	/* channel switch handled in software */
-	if (csa_ie.count <= 1)
-		ieee80211_queue_work(&local->hw, &link->u.mgd.chswitch_work);
-	else
-		mod_timer(&link->u.mgd.chswitch_timer,
-			  TU_TO_EXP_TIME((csa_ie.count - 1) *
-					 cbss->beacon_interval));
+	timeout = TU_TO_JIFFIES((max_t(int, csa_ie.count, 1) - 1) *
+				cbss->beacon_interval);
+	wiphy_delayed_work_queue(local->hw.wiphy,
+				 &link->u.mgd.chswitch_work,
+				 timeout);
 	return;
  lock_and_drop_connection:
 	mutex_lock(&local->mtx);
@@ -3024,7 +3018,6 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	del_timer_sync(&sdata->u.mgd.conn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.bcn_mon_timer);
 	del_timer_sync(&sdata->u.mgd.timer);
-	del_timer_sync(&sdata->deflink.u.mgd.chswitch_timer);
 
 	sdata->vif.bss_conf.dtim_period = 0;
 	sdata->vif.bss_conf.beacon_rate = NULL;
@@ -6590,8 +6583,8 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 	else
 		link->u.mgd.req_smps = IEEE80211_SMPS_OFF;
 
-	INIT_WORK(&link->u.mgd.chswitch_work, ieee80211_chswitch_work);
-	timer_setup(&link->u.mgd.chswitch_timer, ieee80211_chswitch_timer, 0);
+	wiphy_delayed_work_init(&link->u.mgd.chswitch_work,
+				ieee80211_chswitch_work);
 
 	if (sdata->u.mgd.assoc_data)
 		ether_addr_copy(link->conf->addr,
@@ -7549,7 +7542,8 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 {
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.request_smps_work);
-	cancel_work_sync(&link->u.mgd.chswitch_work);
+	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
+				  &link->u.mgd.chswitch_work);
 }
 
 void ieee80211_mgd_stop(struct ieee80211_sub_if_data *sdata)
-- 
2.40.1

