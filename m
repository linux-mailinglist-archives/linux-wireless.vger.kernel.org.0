Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9036D5301
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 23:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjDCVEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 17:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjDCVEu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 17:04:50 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5841BC3
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 14:04:48 -0700 (PDT)
X-UUID: 27ac7f50d26311edb6b9f13eb10bd0fe-20230404
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TzhTuSq9akbTJyjfNuijKETfUTZtjH0vApdpfF73mms=;
        b=j0/ANM3xh0OQBB6958aYCQHihQqwOFWx1sNbtGK2AxvMaE7lK+L5v003mZ+tYk5CYZ/CrqKpjfQoHLpxUUy7TUuj98P955u5QAgZYMqsHRF5PRuCgpjf6rb/nbzVAx8dq9tt3xR8ybWHOZI1942d2txZOUNGExTo1hVgl1tT6R0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e97f2ccf-d382-4eee-9075-593d1d9c2899,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:e97f2ccf-d382-4eee-9075-593d1d9c2899,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:e3fd4a2a-564d-42d9-9875-7c868ee415ec,B
        ulkID:2304040504433IHPKOOL,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 27ac7f50d26311edb6b9f13eb10bd0fe-20230404
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 801865238; Tue, 04 Apr 2023 05:04:42 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 05:04:41 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Tue, 4 Apr 2023 05:04:39 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Subject: [PATCH 2/2] wifi: mac80211: ageout BSS color bitmap
Date:   Mon, 3 Apr 2023 14:04:30 -0700
Message-ID: <4e6b407ec7dba2baa2cbd739088ff78ab1b02756.1680553708.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <774ab129159408a3f3e04b7e662cb559cf087c48.1680553706.git.yi-chia.hsieh@mediatek.com>
References: <774ab129159408a3f3e04b7e662cb559cf087c48.1680553706.git.yi-chia.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a periodic work runs once every second to check BSS color.
OBSS BSS Color will be aged out if not seen for 10 seconds.

Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
 include/linux/ieee80211.h  |  5 +++++
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         | 29 +++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/iface.c       |  6 ++++++
 net/mac80211/link.c        |  1 +
 net/mac80211/rx.c          |  1 +
 7 files changed, 45 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 2463bdd2a382..3e5a344fe9ce 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -307,6 +307,11 @@ static inline u16 ieee80211_sn_sub(u16 sn1, u16 sn2)
 #define IEEE80211_TRIGGER_TYPE_BQRP		0x6
 #define IEEE80211_TRIGGER_TYPE_NFRP		0x7
 
+/* max color index */
+#define IEEE80211_BSS_COLOR_MAX			63
+/* ageout time for OBSS BSS color */
+#define IEEE80211_BSS_COLOR_AGEOUT_TIME		10
+
 struct ieee80211_hdr {
 	__le16 frame_control;
 	__le16 duration_id;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f003e0dbc7c4..2471b5b9e11d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -750,6 +750,7 @@ struct ieee80211_bss_conf {
 	bool color_change_active;
 	u8 color_change_color;
 	u64 used_color_bitmap;
+	unsigned long color_last_seen[IEEE80211_BSS_COLOR_MAX + 1];
 
 	bool vht_su_beamformer;
 	bool vht_su_beamformee;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8eb342300868..f5a36b8b392d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4759,6 +4759,35 @@ ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 	return err;
 }
 
+void ieee80211_color_aging_work(struct work_struct *work)
+{
+	struct ieee80211_sub_if_data *sdata =
+		container_of(work, struct ieee80211_sub_if_data,
+			     deflink.color_aging_work.work);
+	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	int i;
+
+	sdata_lock(sdata);
+
+	if (!ieee80211_sdata_running(sdata))
+		goto unlock;
+
+	for (i = 1; i < IEEE80211_BSS_COLOR_MAX + 1; i++) {
+		/* ageout if not seen for a period */
+		if ((bss_conf->used_color_bitmap & BIT_ULL(i)) &&
+		    time_before(bss_conf->color_last_seen[i],
+				jiffies - IEEE80211_BSS_COLOR_AGEOUT_TIME * HZ)) {
+			bss_conf->used_color_bitmap &= ~BIT_ULL(i);
+		}
+	}
+
+	ieee80211_queue_delayed_work(&sdata->local->hw,
+				     &sdata->deflink.color_aging_work, HZ);
+
+unlock:
+	sdata_unlock(sdata);
+}
+
 static int
 ieee80211_set_radar_background(struct wiphy *wiphy,
 			       struct cfg80211_chan_def *chandef)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ecc232eb1ee8..5c4bd432bd60 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -974,6 +974,7 @@ struct ieee80211_link_data {
 
 	struct work_struct color_change_finalize_work;
 	struct delayed_work color_collision_detect_work;
+	struct delayed_work color_aging_work;
 	u64 color_bitmap;
 
 	/* context reservation -- protected with chanctx_mtx */
@@ -1931,6 +1932,7 @@ int ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 /* color change handling */
 void ieee80211_color_change_finalize_work(struct work_struct *work);
 void ieee80211_color_collision_detection_work(struct work_struct *work);
+void ieee80211_color_aging_work(struct work_struct *work);
 
 /* interface handling */
 #define MAC80211_SUPPORTED_FEATURES_TX	(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | \
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 23ed13f15067..d0bba2c19b0e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -541,6 +541,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	cancel_work_sync(&sdata->deflink.color_change_finalize_work);
 
 	cancel_delayed_work_sync(&sdata->deflink.dfs_cac_timer_work);
+	cancel_delayed_work_sync(&sdata->deflink.color_aging_work);
 
 	if (sdata->wdev.cac_started) {
 		chandef = sdata->vif.bss_conf.chandef;
@@ -1430,6 +1431,11 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 
 	set_bit(SDATA_STATE_RUNNING, &sdata->state);
 
+	if (sdata->vif.type == NL80211_IFTYPE_AP)
+		ieee80211_queue_delayed_work(&sdata->local->hw,
+					     &sdata->deflink.color_aging_work,
+					     HZ);
+
 	return 0;
  err_del_interface:
 	drv_remove_interface(local, sdata);
diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 8c8869cc1fb4..16c9b554c853 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -41,6 +41,7 @@ void ieee80211_link_init(struct ieee80211_sub_if_data *sdata,
 		  ieee80211_color_change_finalize_work);
 	INIT_DELAYED_WORK(&link->color_collision_detect_work,
 			  ieee80211_color_collision_detection_work);
+	INIT_DELAYED_WORK(&link->color_aging_work, ieee80211_color_aging_work);
 	INIT_LIST_HEAD(&link->assigned_chanctx_list);
 	INIT_LIST_HEAD(&link->reserved_chanctx_list);
 	INIT_DELAYED_WORK(&link->dfs_cac_timer_work,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e4a60992e4eb..da2de912b2fc 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3265,6 +3265,7 @@ ieee80211_rx_check_bss_color_collision(struct ieee80211_rx_data *rx)
 		color = le32_get_bits(he_oper->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
 		bss_conf->used_color_bitmap |= BIT_ULL(color);
+		bss_conf->color_last_seen[color] = jiffies;
 
 		if (color == bss_conf->he_bss_color.color)
 			ieee80211_obss_color_collision_notify(&rx->sdata->vif,
-- 
2.39.0

