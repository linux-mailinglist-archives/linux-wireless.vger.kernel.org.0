Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491742A5E14
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 07:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKDGTk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 01:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKDGTk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 01:19:40 -0500
Received: from rhcavuit02.kulnet.kuleuven.be (rhcavuit02.kulnet.kuleuven.be [IPv6:2a02:2c40:0:c0::25:130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E4C061A4D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 22:19:40 -0800 (PST)
X-KULeuven-Envelope-From: mathy.vanhoef@kuleuven.be
X-Spam-Status: not spam, SpamAssassin (not cached, score=-50.999, required 5,
        autolearn=disabled, ALL_TRUSTED -1.00, LOCAL_SMTPS -50.00,
        URIBL_BLOCKED 0.00)
X-KULeuven-Scanned: Found to be clean
X-KULeuven-ID: 007D512032F.AA427
X-KULeuven-Information: Katholieke Universiteit Leuven
Received: from icts-p-smtps-2.cc.kuleuven.be (icts-p-smtps-2e.kulnet.kuleuven.be [134.58.240.34])
        by rhcavuit02.kulnet.kuleuven.be (Postfix) with ESMTP id 007D512032F
        for <linux-wireless@vger.kernel.org>; Wed,  4 Nov 2020 07:19:26 +0100 (CET)
Received: from mathy-work.localhost (unknown [92.96.39.204])
        (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by icts-p-smtps-2.cc.kuleuven.be (Postfix) with ESMTPSA id 3D2ED200A1;
        Wed,  4 Nov 2020 07:19:24 +0100 (CET)
X-Kuleuven: This mail passed the K.U.Leuven mailcluster
From:   Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
Subject: [PATCH 2/5] mac80211: adhere to Tx control flag that prevents frame reordering
Date:   Wed,  4 Nov 2020 10:18:20 +0400
Message-Id: <20201104061823.197407-3-Mathy.Vanhoef@kuleuven.be>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
References: <20201104061823.197407-1-Mathy.Vanhoef@kuleuven.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the Tx control flag is set to prevent frame reordering, send
all frames that have this flag set on the same queue. This assures
that frames that have this flag set are not reordered relative to
other frames that have this flag set.

Signed-off-by: Mathy Vanhoef <Mathy.Vanhoef@kuleuven.be>
---
 net/mac80211/wme.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/wme.c b/net/mac80211/wme.c
index 2fb993251..3d7dea387 100644
--- a/net/mac80211/wme.c
+++ b/net/mac80211/wme.c
@@ -118,9 +118,11 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_hdr *hdr)
 {
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	u8 *p;
 
-	if (local->hw.queues < IEEE80211_NUM_ACS)
+	if ((info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER) ||
+	    local->hw.queues < IEEE80211_NUM_ACS)
 		return 0;
 
 	if (!ieee80211_is_data(hdr->frame_control)) {
@@ -141,6 +143,7 @@ u16 ieee80211_select_queue_80211(struct ieee80211_sub_if_data *sdata,
 u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 			     struct sta_info *sta, struct sk_buff *skb)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mac80211_qos_map *qos_map;
 	bool qos;
 
@@ -153,7 +156,7 @@ u16 __ieee80211_select_queue(struct ieee80211_sub_if_data *sdata,
 	else
 		qos = false;
 
-	if (!qos) {
+	if (!qos || (info->control.flags & IEEE80211_TX_CTRL_DONT_REORDER)) {
 		skb->priority = 0; /* required for correct WPA/11i MIC */
 		return IEEE80211_AC_BE;
 	}
-- 
2.28.0

