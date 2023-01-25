Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242F167B084
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jan 2023 12:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjAYLBY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Jan 2023 06:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjAYLBW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Jan 2023 06:01:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F8837F2A
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jan 2023 03:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44C6CB81929
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jan 2023 11:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB52C433EF;
        Wed, 25 Jan 2023 11:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674644479;
        bh=7dGKniOWGDRYJpoK2piT/cwBv/iADkoZfJw9Vh72bAc=;
        h=From:To:Cc:Subject:Date:From;
        b=Nk7uIh0qwoDIixVcgg5VzTbGIQARhSuDwFqkfQ7bhEPldORGQ/JmyuSaRB9un9ivt
         IoYF1nV4fAOuVPbPMj8Ov1D7j2K0oNoxyYbVf9Cx6pG6hkYsyzqhcQz+nRWFKUuXtM
         z5OYf2A3JTmSZXt8k5N0Os3GMfy2y0IhF78tdX0qK1rcBDeTNM2XTi/YqQhXMfRk+l
         3F+PVTfZnCz21YuL63trtCDA0M94XwLQaF3kLZ35QZtKowJ3YFIfOPrX2hXItxVFKJ
         +v8kVknPwFuJ2D3GUJD1YlN/WN92zOVAhTpW5Kby0J7TvrvLr9rbhosAn3+E11rLvu
         A4TOnfu2ZQUeg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     nicolas.cavallari@green-communications.fr,
        linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH wireless-next] wifi: mac80211: move color collision detection report in a delayed work
Date:   Wed, 25 Jan 2023 12:01:02 +0100
Message-Id: <3f6cf60c892ad40c1cca4a55d62b1224ef1c6ce9.1674644379.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move color collision report in a dedicated delayed work and do not run
it in interrupt context in order to rate-limit the number of events
reported to userspace. Moreover grab wdev mutex in
ieee80211_color_collision_detection_work routine since it is required
by cfg80211_obss_color_collision_notify().

Tested-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/cfg.c         | 26 +++++++++++++++++++++++++-
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/link.c        |  3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f5d43f42f6d8..c3e4e48e9ce9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4652,6 +4652,20 @@ void ieee80211_color_change_finalize_work(struct work_struct *work)
 	sdata_unlock(sdata);
 }
 
+void ieee80211_color_collision_detection_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work = to_delayed_work(work);
+	struct ieee80211_link_data *link =
+		container_of(delayed_work, struct ieee80211_link_data,
+			     color_collision_detect_work);
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+
+	sdata_lock(sdata);
+	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
+					     GFP_KERNEL);
+	sdata_unlock(sdata);
+}
+
 void ieee80211_color_change_finish(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
@@ -4666,11 +4680,21 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 				       u64 color_bitmap, gfp_t gfp)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link = &sdata->deflink;
 
 	if (sdata->vif.bss_conf.color_change_active || sdata->vif.bss_conf.csa_active)
 		return;
 
-	cfg80211_obss_color_collision_notify(sdata->dev, color_bitmap, gfp);
+	if (delayed_work_pending(&link->color_collision_detect_work))
+		return;
+
+	link->color_bitmap = color_bitmap;
+	/* queue the color collision detection event every 500 ms in order to
+	 * avoid sending too much netlink messages to userspace.
+	 */
+	ieee80211_queue_delayed_work(&sdata->local->hw,
+				     &link->color_collision_detect_work,
+				     msecs_to_jiffies(500));
 }
 EXPORT_SYMBOL_GPL(ieee80211_obss_color_collision_notify);
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d16606e84e22..7ca9bde3c6d2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -974,6 +974,8 @@ struct ieee80211_link_data {
 	struct cfg80211_chan_def csa_chandef;
 
 	struct work_struct color_change_finalize_work;
+	struct delayed_work color_collision_detect_work;
+	u64 color_bitmap;
 
 	/* context reservation -- protected with chanctx_mtx */
 	struct ieee80211_chanctx *reserved_chanctx;
@@ -1929,6 +1931,7 @@ int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 /* color change handling */
 void ieee80211_color_change_finalize_work(struct work_struct *work);
+void ieee80211_color_collision_detection_work(struct work_struct *work);
 
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index d1f5a9f7c647..8c8869cc1fb4 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -39,6 +39,8 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 		  ieee80211_csa_finalize_work);
 	INIT_WORK(&link->color_change_finalize_work,
 		  ieee80211_color_change_finalize_work);
+	INIT_DELAYED_WORK(&link->color_collision_detect_work,
+			  ieee80211_color_collision_detection_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
 	INIT_LIST_HEAD(&link->reserved_chanctx_list);
 	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
@@ -66,6 +68,7 @@ void ieee80211_link_stop(struct ieee80211_link_data *link)
 	if (link->sdata->vif.type == NL80211_IFTYPE_STATION)
 		ieee80211_mgd_stop_link(link);
 
+	cancel_delayed_work_sync(&link->color_collision_detect_work);
 	ieee80211_link_release_channel(link);
 }
 
-- 
2.39.1

