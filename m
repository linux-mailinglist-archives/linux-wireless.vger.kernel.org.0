Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046AB69B20D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Feb 2023 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjBQRuU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Feb 2023 12:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBQRuT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Feb 2023 12:50:19 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47263BFB
        for <linux-wireless@vger.kernel.org>; Fri, 17 Feb 2023 09:50:14 -0800 (PST)
X-UUID: 8502876caeeb11ed945fc101203acc17-20230218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=yiO7+GfNtc3Ebf3kPnUIZB9WtVAk3tp78yo3RlgMNrg=;
        b=meJNoi7KXctbdHulsuh5XmVDxhy++m9SsdOe2O9M1K+u2XRuiQHSjRJpQK657q8BIwm90BuZOUbuU+bPjpBdFgjJ52pAx759O4l85DX5oW2xTVDde8Dc4W2DO8OhkgiUqMtIjwNe/E5M4qDqDPFcw/XzLOMbo6tyBnunr5h92bg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.19,REQID:a98ebcec-27e5-4952-8f65-8137d4e7fd04,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:885ddb2,CLOUDID:3e39cbb0-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 8502876caeeb11ed945fc101203acc17-20230218
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1068955065; Sat, 18 Feb 2023 01:50:09 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 18 Feb 2023 01:50:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sat, 18 Feb 2023 01:50:07 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mac80211: introduce ieee80211_refresh_tx_agg_session_timer()
Date:   Sat, 18 Feb 2023 01:50:05 +0800
Message-ID: <7c3f72eac1c34921cd84a462e60d71e125862152.1676616450.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows low level drivers to refresh the tx agg session timer, based on
querying stats from the firmware usually. Especially for some mt76 devices
support .net_fill_forward_path would bypass mac80211, which leads to tx BA
session timeout for certain clients.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 include/net/mac80211.h | 12 ++++++++++++
 net/mac80211/agg-tx.c  | 17 +++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 76a12bec71d5..920ea31620cd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -5993,6 +5993,18 @@ void ieee80211_queue_delayed_work(struct ieee80211_hw *hw,
 				  struct delayed_work *dwork,
 				  unsigned long delay);
 
+/**
+ * ieee80211_refresh_tx_agg_session_timer - Refresh a tx agg session timer.
+ * @sta: the station for which to start a BA session
+ * @tid: the TID to BA on.
+ *
+ * This function allows low level driver to refresh tx agg session timer
+ * to maintain BA session, the session level will still be managed by the
+ * mac80211.
+ */
+void ieee80211_refresh_tx_agg_session_timer(struct ieee80211_sta *sta,
+					    u16 tid);
+
 /**
  * ieee80211_start_tx_ba_session - Start a tx Block Ack session.
  * @sta: the station for which to start a BA session
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index f9514bacbd4a..3b651e7f5a73 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -554,6 +554,23 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	ieee80211_send_addba_with_timeout(sta, tid_tx);
 }
 
+void ieee80211_refresh_tx_agg_session_timer(struct ieee80211_sta *pubsta,
+					    u16 tid)
+{
+	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
+	struct tid_ampdu_tx *tid_tx;
+
+	if (WARN_ON_ONCE(tid >= IEEE80211_NUM_TIDS))
+		return;
+
+	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+	if (!tid_tx)
+		return;
+
+	tid_tx->last_tx = jiffies;
+}
+EXPORT_SYMBOL(ieee80211_refresh_tx_agg_session_timer);
+
 /*
  * After accepting the AddBA Response we activated a timer,
  * resetting it after each frame that we send.
-- 
2.18.0

