Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03778B15C
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjH1NJm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 09:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjH1NJe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 09:09:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209210C
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 06:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=AGij+/tdP1W0xDMsPVAbgLBhzGNQpIN2FNrFsUevKUc=;
        t=1693228171; x=1694437771; b=hhsjk3o56aHs27Do5NUyVchzX+yU8nCxOWwFpCjunUV1bOA
        ulTnmB5DelsNAHKiFieLmaFp4fnPl89jQ6HkCrBhxc/7MWhOM3rTCrDDRVmI5xH4zvtq7NehTvMuQ
        UCDV8vpZmoARSpv+Ag17eUqvqQyON85cEdpaxw2DSs7iwM41fXvGR9xYB+kmBWsKmnY39TyW/JIez
        rg59FJZA6krfd91Jik78e2qz/MUsYRSg2At+rEWAL2zdgspNhjW4j9JDWoc+StF8YEdC4xWNlUjiB
        iwzC9KodJtz7WM6TYFe08udAnFCiMdlEaTnCt1GUz/tEkkVZ9/GCQxG1bwVkYolw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qabzl-00Go8O-0l;
        Mon, 28 Aug 2023 15:09:29 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 4/4] wifi: mac80211: fix SMPS status handling
Date:   Mon, 28 Aug 2023 15:09:26 +0200
Message-ID: <20230828150922.86e74f4f47da.If8330b2c9441b5cb28f64d4814182207e89c5de2@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828150922.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
References: <20230828150922.c5182ba79e0f.I5efd1399be8e6dedc1e48982b7f20c531ff37616@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The current SMPS status handling isn't per link, so we only
ever change the deflink, which is obviously wrong, it's not
even used for multi-link connections, but the request API
actually includes the link ID.

Use the new status_data changes to move the handling to the
right link, this also saves parsing the frame again on the
status report, instead we can now check only if it was an
SMPS frame.

Of course, move the worker to be a wiphy work so that we're
able to cancel it safely for the link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ht.c          | 10 ++++-
 net/mac80211/ieee80211_i.h |  7 ++--
 net/mac80211/iface.c       | 11 -----
 net/mac80211/mlme.c        | 14 +++++++
 net/mac80211/status.c      | 86 ++++++++++++++++++++++----------------
 5 files changed, 78 insertions(+), 50 deletions(-)

diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 802b0e738696..05f98f0a91a8 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -543,6 +543,8 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *action_frame;
+	struct ieee80211_tx_info *info;
+	u8 status_link_id = link_id < 0 ? 0 : link_id;
 
 	/* 27 = header + category + action + smps mode */
 	skb = dev_alloc_skb(27 + local->hw.extra_tx_headroom);
@@ -562,6 +564,7 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	case IEEE80211_SMPS_AUTOMATIC:
 	case IEEE80211_SMPS_NUM_MODES:
 		WARN_ON(1);
+		smps = IEEE80211_SMPS_OFF;
 		fallthrough;
 	case IEEE80211_SMPS_OFF:
 		action_frame->u.action.u.ht_smps.smps_control =
@@ -578,7 +581,12 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* we'll do more on status of this frame */
-	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+	info = IEEE80211_SKB_CB(skb);
+	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+	/* we have 12 bits, and need 6: link_id 4, smps 2 */
+	info->status_data = IEEE80211_STATUS_TYPE_SMPS |
+			    u16_encode_bits(status_link_id << 2 | smps,
+					    IEEE80211_STATUS_SUBDATA_MASK);
 	ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
 
 	return 0;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 1df2101d8eeb..338ab9e6e6b1 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -88,6 +88,7 @@ extern const u8 ieee80211_ac_to_qos_mask[IEEE80211_NUM_ACS];
 enum ieee80211_status_data {
 	IEEE80211_STATUS_TYPE_MASK	= 0x00f,
 	IEEE80211_STATUS_TYPE_INVALID	= 0,
+	IEEE80211_STATUS_TYPE_SMPS	= 1,
 	IEEE80211_STATUS_SUBDATA_MASK	= 0xff0,
 };
 
@@ -931,6 +932,9 @@ struct ieee80211_link_data_managed {
 	struct wiphy_delayed_work chswitch_work;
 
 	struct wiphy_work request_smps_work;
+	/* used to reconfigure hardware SM PS */
+	struct wiphy_work recalc_smps;
+
 	bool beacon_crc_valid;
 	u32 beacon_crc;
 	struct ewma_beacon_signal ave_beacon_signal;
@@ -1069,9 +1073,6 @@ struct ieee80211_sub_if_data {
 	atomic_t num_tx_queued;
 	struct mac80211_qos_map __rcu *qos_map;
 
-	/* used to reconfigure hardware SM PS */
-	struct work_struct recalc_smps;
-
 	struct wiphy_work work;
 	struct sk_buff_head skb_queue;
 	struct sk_buff_head status_queue;
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index be586bc0b5b7..4beab027e0f9 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -518,8 +518,6 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	del_timer_sync(&local->dynamic_ps_timer);
 	cancel_work_sync(&local->dynamic_ps_enable_work);
 
-	cancel_work_sync(&sdata->recalc_smps);
-
 	sdata_lock(sdata);
 	WARN(ieee80211_vif_is_mld(&sdata->vif),
 	     "destroying interface with valid links 0x%04x\n",
@@ -1692,14 +1690,6 @@ static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 	}
 }
 
-static void ieee80211_recalc_smps_work(struct work_struct *work)
-{
-	struct ieee80211_sub_if_data *sdata =
-		container_of(work, struct ieee80211_sub_if_data, recalc_smps);
-
-	ieee80211_recalc_smps(sdata, &sdata->deflink);
-}
-
 static void ieee80211_activate_links_work(struct work_struct *work)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -1745,7 +1735,6 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	skb_queue_head_init(&sdata->skb_queue);
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
-	INIT_WORK(&sdata->recalc_smps, ieee80211_recalc_smps_work);
 	INIT_WORK(&sdata->activate_links_work, ieee80211_activate_links_work);
 
 	switch (type) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f93eb38ae0b8..65d3e167132c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6847,6 +6847,16 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	ifmgd->orig_teardown_skb = NULL;
 }
 
+static void ieee80211_recalc_smps_work(struct wiphy *wiphy,
+				       struct wiphy_work *work)
+{
+	struct ieee80211_link_data *link =
+		container_of(work, struct ieee80211_link_data,
+			     u.mgd.recalc_smps);
+
+	ieee80211_recalc_smps(link->sdata, link);
+}
+
 void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
@@ -6859,6 +6869,8 @@ void ieee80211_mgd_setup_link(struct ieee80211_link_data *link)
 
 	wiphy_work_init(&link->u.mgd.request_smps_work,
 			ieee80211_request_smps_mgd_work);
+	wiphy_work_init(&link->u.mgd.recalc_smps,
+			ieee80211_recalc_smps_work);
 	if (local->hw.wiphy->features & NL80211_FEATURE_DYNAMIC_SMPS)
 		link->u.mgd.req_smps = IEEE80211_SMPS_AUTOMATIC;
 	else
@@ -7824,6 +7836,8 @@ void ieee80211_mgd_stop_link(struct ieee80211_link_data *link)
 {
 	wiphy_work_cancel(link->sdata->local->hw.wiphy,
 			  &link->u.mgd.request_smps_work);
+	wiphy_work_cancel(link->sdata->local->hw.wiphy,
+			  &link->u.mgd.recalc_smps);
 	wiphy_delayed_work_cancel(link->sdata->local->hw.wiphy,
 				  &link->u.mgd.chswitch_work);
 }
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f24aceb59db0..3355e66d96d8 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -184,8 +184,6 @@ static void ieee80211_check_pending_bar(struct sta_info *sta, u8 *addr, u8 tid)
 static void ieee80211_frame_acked(struct sta_info *sta, struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (void *) skb->data;
-	struct ieee80211_local *local = sta->local;
-	struct ieee80211_sub_if_data *sdata = sta->sdata;
 
 	if (ieee80211_is_data_qos(mgmt->frame_control)) {
 		struct ieee80211_hdr *hdr = (void *) skb->data;
@@ -194,39 +192,6 @@ static void ieee80211_frame_acked(struct sta_info *sta, struct sk_buff *skb)
 
 		ieee80211_check_pending_bar(sta, hdr->addr1, tid);
 	}
-
-	if (ieee80211_is_action(mgmt->frame_control) &&
-	    !ieee80211_has_protected(mgmt->frame_control) &&
-	    mgmt->u.action.category == WLAN_CATEGORY_HT &&
-	    mgmt->u.action.u.ht_smps.action == WLAN_HT_ACTION_SMPS &&
-	    ieee80211_sdata_running(sdata)) {
-		enum ieee80211_smps_mode smps_mode;
-
-		switch (mgmt->u.action.u.ht_smps.smps_control) {
-		case WLAN_HT_SMPS_CONTROL_DYNAMIC:
-			smps_mode = IEEE80211_SMPS_DYNAMIC;
-			break;
-		case WLAN_HT_SMPS_CONTROL_STATIC:
-			smps_mode = IEEE80211_SMPS_STATIC;
-			break;
-		case WLAN_HT_SMPS_CONTROL_DISABLED:
-		default: /* shouldn't happen since we don't send that */
-			smps_mode = IEEE80211_SMPS_OFF;
-			break;
-		}
-
-		if (sdata->vif.type == NL80211_IFTYPE_STATION) {
-			/*
-			 * This update looks racy, but isn't -- if we come
-			 * here we've definitely got a station that we're
-			 * talking to, and on a managed interface that can
-			 * only be the AP. And the only other place updating
-			 * this variable in managed mode is before association.
-			 */
-			sdata->deflink.smps_mode = smps_mode;
-			ieee80211_queue_work(&local->hw, &sdata->recalc_smps);
-		}
-	}
 }
 
 static void ieee80211_set_bar_pending(struct sta_info *sta, u8 tid, u16 ssn)
@@ -695,6 +660,42 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 	}
 }
 
+static void ieee80211_handle_smps_status(struct ieee80211_sub_if_data *sdata,
+					 bool acked, u16 status_data)
+{
+	u16 sub_data = u16_get_bits(status_data, IEEE80211_STATUS_SUBDATA_MASK);
+	enum ieee80211_smps_mode smps_mode = sub_data & 3;
+	int link_id = (sub_data >> 2);
+	struct ieee80211_link_data *link;
+
+	if (!sdata || !ieee80211_sdata_running(sdata))
+		return;
+
+	if (!acked)
+		return;
+
+	if (sdata->vif.type != NL80211_IFTYPE_STATION)
+		return;
+
+	if (WARN(link_id >= ARRAY_SIZE(sdata->link),
+		 "bad SMPS status link: %d\n", link_id))
+		return;
+
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link)
+		return;
+
+	/*
+	 * This update looks racy, but isn't, the only other place
+	 * updating this variable is in managed mode before assoc,
+	 * and we have to be associated to have a status from the
+	 * action frame TX, since we cannot send it while we're not
+	 * associated yet.
+	 */
+	link->smps_mode = smps_mode;
+	wiphy_work_queue(sdata->local->hw.wiphy, &link->u.mgd.recalc_smps);
+}
+
 static void ieee80211_report_used_skb(struct ieee80211_local *local,
 				      struct sk_buff *skb, bool dropped,
 				      ktime_t ack_hwtstamp)
@@ -762,6 +763,21 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 	} else if (info->status_data_idr) {
 		ieee80211_report_ack_skb(local, skb, acked, dropped,
 					 ack_hwtstamp);
+	} else if (info->status_data) {
+		struct ieee80211_sub_if_data *sdata;
+
+		rcu_read_lock();
+
+		sdata = ieee80211_sdata_from_skb(local, skb);
+
+		switch (u16_get_bits(info->status_data,
+				     IEEE80211_STATUS_TYPE_MASK)) {
+		case IEEE80211_STATUS_TYPE_SMPS:
+			ieee80211_handle_smps_status(sdata, acked,
+						     info->status_data);
+			break;
+		}
+		rcu_read_unlock();
 	}
 
 	if (!dropped && skb->destructor) {
-- 
2.41.0

