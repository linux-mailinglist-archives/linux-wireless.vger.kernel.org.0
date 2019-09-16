Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A20B3B0A
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbfIPNKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 09:10:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44478 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfIPNKl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 09:10:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 467306156A; Mon, 16 Sep 2019 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568639440;
        bh=2pcWV4LuaUy4I49QsvNxKMfZukjy0lVa2EcX3VOVBBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfsHqwBYeEf4U2A/2/IhB7dGDeRJBp0suZqcBu25Yvm2BidYMq3oF1zJdZQRrrbjp
         LTvHhUvQMMq6/nmsTntORj4HWRF4TZzLLdBD2BKnURHGLeeOyXGNhWOzJ1xEmt3eW4
         9lwDg5+7JkOhQPwTEsV8uA8yidioUE2t8PRTPCu4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from ybzhao-HP-Z230-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yiboz@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3CDE9611FA;
        Mon, 16 Sep 2019 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568639439;
        bh=2pcWV4LuaUy4I49QsvNxKMfZukjy0lVa2EcX3VOVBBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QbpohOGBE5rewDBx1Di7W3AEwNRF6hRMbdN2eHECvsZLaLJ3bmCuMu6m++f8niiTn
         2bH3xu33xX+kLwC3DBHnUnrMlmp4TTTR6ulUnpH/ACe1jBZWjBpySWlBeoVBOvH9hI
         tIY4QPuU03R38ijLvrM9+iotGOteUGToC+8a/cQ8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3CDE9611FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yiboz@codeaurora.org
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, Yibo Zhao <yiboz@codeaurora.org>
Subject: [PATCH 4/4] mac80211: Sync airtime weight sum with per AC synced sta airtime weight together
Date:   Mon, 16 Sep 2019 21:09:48 +0800
Message-Id: <1568639388-27291-4-git-send-email-yiboz@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
References: <1568639388-27291-1-git-send-email-yiboz@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Global airtime weight sum is updated only when txq is added/removed
from rbtree. If upper layer configures sta weight during high load,
airtime weight sum will not be updated since txq is most likely on the
tree. It could a little late for upper layer to reconfigure sta weight
when txq is already in the rbtree. And thus, incorrect airtime weight sum
will lead to incorrect global virtual time calculation as well as global
airtime weight sum overflow of airtime weight sum during txq removed.

Hence, need to update airtime weight sum upon receiving event for
configuring sta weight once sta's txq is on the rbtree.

Besides, if airtime weight sum of ACs and sta weight is synced under the
same per AC lock protection, there can be a very short window causing
incorrct airtime weight sum calculation as below:

    active_txq_lock_VO                          .
    VO weight sum is syncd			.
    sta airtime weight sum is synced		.
    active_txq_unlock_VO			.
    .						.
    active_txq_lock_VI    			.
    VI weight sum is syncd			.
    sta airtime weight sum		active_txq_lock_BE
    active_txq_unlock_VI	      Remove txq and thus sum
    .				      is calculated with synced
    .				      sta airtime weight
    .					active_txq_unlock_BE

So introduce a per ac synced station airtime weight synced with per
AC synced weight sum together. And the per-AC station airtime weight
is used to calculate weight sum.

Signed-off-by: Yibo Zhao <yiboz@codeaurora.org>
---
 net/mac80211/cfg.c      | 27 +++++++++++++++++++++++++--
 net/mac80211/sta_info.c |  6 ++++--
 net/mac80211/sta_info.h |  3 +++
 net/mac80211/tx.c       |  4 ++--
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index d65aa01..4b420bb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1284,7 +1284,8 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	int ret = 0;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	u32 mask, set;
+	u32 mask, set, tid, ac;
+	struct txq_info *txqi;
 
 	sband = ieee80211_get_sband(sdata);
 	if (!sband)
@@ -1452,8 +1453,30 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		sta_apply_mesh_params(local, sta, params);
 
-	if (params->airtime_weight)
+	if (params->airtime_weight &&
+	    params->airtime_weight != sta->airtime_weight) {
+		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+			spin_lock_bh(&local->active_txq_lock[ac]);
+			for (tid = 0; tid < IEEE80211_NUM_TIDS + 1; tid++) {
+				if (!sta->sta.txq[tid] ||
+				    ac != ieee80211_ac_from_tid(tid))
+					continue;
+
+				sta->airtime_weight_synced[ac] =
+							params->airtime_weight;
+
+				txqi = to_txq_info(sta->sta.txq[tid]);
+				if (RB_EMPTY_NODE(&txqi->schedule_order))
+					continue;
+
+				local->airtime_weight_sum[ac] = local->airtime_weight_sum[ac] +
+								params->airtime_weight -
+								sta->airtime_weight;
+			}
+			spin_unlock_bh(&local->active_txq_lock[ac]);
+		}
 		sta->airtime_weight = params->airtime_weight;
+	}
 
 	/* set the STA state after all sta info from usermode has been set */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) ||
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index feac975..b00812f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -389,6 +389,7 @@ struct sta_info *sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		skb_queue_head_init(&sta->ps_tx_buf[i]);
 		skb_queue_head_init(&sta->tx_filtered[i]);
+		sta->airtime_weight_synced[i] = sta->airtime_weight;
 	}
 
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++)
@@ -1850,11 +1851,12 @@ void ieee80211_sta_register_airtime(struct ieee80211_sta *pubsta, u8 tid,
 	sta->airtime[ac].tx_airtime += tx_airtime;
 	sta->airtime[ac].rx_airtime += rx_airtime;
 
-	weight_sum = local->airtime_weight_sum[ac] ?: sta->airtime_weight;
+	weight_sum = local->airtime_weight_sum[ac] ?
+					: sta->airtime_weight_synced[ac];
 
 	/* Round the calculation of global vt */
 	local->airtime_v_t[ac] += (airtime + (weight_sum >> 1)) / weight_sum;
-	sta->airtime[ac].v_t += airtime / sta->airtime_weight;
+	sta->airtime[ac].v_t += airtime / sta->airtime_weight_synced[ac];
 	ieee80211_resort_txq(&local->hw, txq);
 
 	spin_unlock_bh(&local->active_txq_lock[ac]);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5055f94..1298902 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -476,6 +476,8 @@ struct ieee80211_sta_rx_stats {
  * @tid_seq: per-TID sequence numbers for sending to this STA
  * @airtime: per-AC struct airtime_info describing airtime statistics for this
  *	station
+ * @airtime_weight_synced: station per-AC airtime weight for sync and
+ *  calculation
  * @airtime_weight: station weight for airtime fairness calculation purposes
  * @ampdu_mlme: A-MPDU state machine state
  * @mesh: mesh STA information
@@ -602,6 +604,7 @@ struct sta_info {
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
 
 	struct airtime_info airtime[IEEE80211_NUM_ACS];
+	u16 airtime_weight_synced[IEEE80211_NUM_ACS];
 	u16 airtime_weight;
 
 	/*
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 60cf569..3592d49 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3735,7 +3735,7 @@ void ieee80211_schedule_txq(struct ieee80211_hw *hw,
 		struct sta_info *sta = container_of(txq->sta,
 						    struct sta_info, sta);
 
-		local->airtime_weight_sum[ac] += sta->airtime_weight;
+		local->airtime_weight_sum[ac] += sta->airtime_weight_synced[ac];
 		if (local->airtime_v_t[ac] > AIRTIME_GRACE)
 			sta->airtime[ac].v_t = max(local->airtime_v_t[ac] - AIRTIME_GRACE,
 						   sta->airtime[ac].v_t);
@@ -3779,7 +3779,7 @@ static void __ieee80211_unschedule_txq(struct ieee80211_hw *hw,
 		struct sta_info *sta = container_of(txq->sta,
 						    struct sta_info, sta);
 
-		local->airtime_weight_sum[ac] -= sta->airtime_weight;
+		local->airtime_weight_sum[ac] -= sta->airtime_weight_synced[ac];
 	}
 
 	rb_erase_cached(&txqi->schedule_order,
-- 
1.9.1

