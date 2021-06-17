Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77A53AB9C0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFQQdg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhFQQda (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:33:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23C1C06175F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jun 2021 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DwKVfLU/7s2hNOm4YIymF2f2b7R0tcR6Ow3bXLKCryk=; b=ZHvBSRtkGjTspRzeME61ilXqiP
        kHJSYAQ4WthgDMzZzswRZm+PB/3l8e1MqU2cnVPLpExQp62w3z9CdNwlCBv2zA6nJ+KuGcFMJE5Yl
        gak5HIQWwRzgQ09G1arZDz2j/jsBaLEFfdBRpohO1U3crS9Y5P1yrAJvXnL+ez6AZM8c=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ltuvD-0001vC-NF; Thu, 17 Jun 2021 18:31:15 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ryder Lee <ryder.lee@mediatek.com>, johannes@sipsolutions.net
Subject: [PATCH v3 1/3] mac80211: move A-MPDU session check from minstrel_ht to mac80211
Date:   Thu, 17 Jun 2021 18:31:11 +0200
Message-Id: <20210617163113.75815-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This avoids calling back into tx handlers from within the rate control module.
Preparation for deferring rate control until tx dequeue

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h             |  5 +++++
 net/mac80211/rc80211_minstrel_ht.c | 28 +---------------------------
 net/mac80211/tx.c                  | 27 +++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 27 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 445b66c6eb7e..e24ca8e7e8f9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6184,6 +6184,11 @@ enum rate_control_capabilities {
 	 * otherwise the NSS difference doesn't bother us.
 	 */
 	RATE_CTRL_CAPA_VHT_EXT_NSS_BW = BIT(0),
+	/**
+	 * @RATE_CTRL_CAPA_AMPDU_TRIGGER:
+	 * mac80211 should start A-MPDU sessions on tx
+	 */
+	RATE_CTRL_CAPA_AMPDU_TRIGGER = BIT(1),
 };
 
 struct rate_control_ops {
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 6487b05da6fa..ed4b16f4f9d2 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -1175,29 +1175,6 @@ minstrel_downgrade_rate(struct minstrel_ht_sta *mi, u16 *idx, bool primary)
 	}
 }
 
-static void
-minstrel_aggr_check(struct ieee80211_sta *pubsta, struct sk_buff *skb)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
-	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
-	u16 tid;
-
-	if (skb_get_queue_mapping(skb) == IEEE80211_AC_VO)
-		return;
-
-	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
-		return;
-
-	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
-		return;
-
-	tid = ieee80211_get_tid(hdr);
-	if (likely(sta->ampdu_mlme.tid_tx[tid]))
-		return;
-
-	ieee80211_start_tx_ba_session(pubsta, tid, 0);
-}
-
 static void
 minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
                       void *priv_sta, struct ieee80211_tx_status *st)
@@ -1498,10 +1475,6 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	struct minstrel_priv *mp = priv;
 	u16 sample_idx;
 
-	if (!(info->flags & IEEE80211_TX_CTL_AMPDU) &&
-	    !minstrel_ht_is_legacy_group(MI_RATE_GROUP(mi->max_prob_rate)))
-		minstrel_aggr_check(sta, txrc->skb);
-
 	info->flags |= mi->tx_flags;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
@@ -1907,6 +1880,7 @@ static u32 minstrel_ht_get_expected_throughput(void *priv_sta)
 
 static const struct rate_control_ops mac80211_minstrel_ht = {
 	.name = "minstrel_ht",
+	.capa = RATE_CTRL_CAPA_AMPDU_TRIGGER,
 	.tx_status_ext = minstrel_ht_tx_status,
 	.get_rate = minstrel_ht_get_rate,
 	.rate_init = minstrel_ht_rate_init,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0b719f3d2dec..e6f7953db483 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3929,6 +3929,29 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
 
+static void
+ieee80211_aggr_check(struct ieee80211_sub_if_data *sdata,
+		     struct sta_info *sta,
+		     struct sk_buff *skb)
+{
+	struct rate_control_ref *ref = sdata->local->rate_ctrl;
+	u16 tid;
+
+	if (!ref || !(ref->ops->capa & RATE_CTRL_CAPA_AMPDU_TRIGGER))
+		return;
+
+	if (!sta || !sta->sta.ht_cap.ht_supported ||
+	    !sta->sta.wme || skb_get_queue_mapping(skb) == IEEE80211_AC_VO ||
+	    skb->protocol == sdata->control_port_protocol)
+		return;
+
+	tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	if (likely(sta->ampdu_mlme.tid_tx[tid]))
+		return;
+
+	ieee80211_start_tx_ba_session(&sta->sta, tid, 0);
+}
+
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
@@ -3959,6 +3982,8 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 		skb_get_hash(skb);
 	}
 
+	ieee80211_aggr_check(sdata, sta, skb);
+
 	if (sta) {
 		struct ieee80211_fast_tx *fast_tx;
 
@@ -4222,6 +4247,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	memset(info, 0, sizeof(*info));
 
+	ieee80211_aggr_check(sdata, sta, skb);
+
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
 	tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
 	if (tid_tx) {
-- 
2.30.1

