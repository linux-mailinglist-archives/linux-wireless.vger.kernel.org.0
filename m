Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 002674236DF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 06:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhJFELm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 00:11:42 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:56195 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhJFELm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 00:11:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633493391; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: To: From: Sender;
 bh=qOJs6C8FRmD1g6DWyS0ZFMfZOSufXk8Dh2RInssUWuk=; b=qvhlMXAn74WD0O+/DjO1ysuBQ7bVDjJzXKPvMHCpzWqoG2Ly75LGPmWFFYiOmF29N4soVA5m
 swAA6dGkiBGjR1JOYgAgvMT28FJhaqOwt2gcEgX+c0yO1Xpnv+FXFFAXgrUqVShabwk6FbDt
 10MQKkeqHWuLo6B10OKRfbJ+HbE=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 615d218a03355859c81b6877 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 04:09:46
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7298FC4338F; Wed,  6 Oct 2021 04:09:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from alokad-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CF23C43460;
        Wed,  6 Oct 2021 04:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9CF23C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: [v13 1/3] mac80211: split beacon retrieval functions
Date:   Tue,  5 Oct 2021 21:09:36 -0700
Message-Id: <20211006040938.9531-2-alokad@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006040938.9531-1-alokad@codeaurora.org>
References: <20211006040938.9531-1-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Split __ieee80211_beacon_get() into a separate function for AP mode
ieee80211_beacon_get_ap().
Also, move the code common to all modes (AP, adhoc and mesh) to
a separate function ieee80211_beacon_get_finish().

Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
---
v13:New addition to the patch series compared to v12.
This change is added in a separate patch for better readability.

 net/mac80211/tx.c | 203 +++++++++++++++++++++++++++-------------------
 1 file changed, 118 insertions(+), 85 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2d1193ed3eb5..ac9ab007dc6f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4979,6 +4979,115 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 	return 0;
 }
 
+static void
+ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_mutable_offsets *offs,
+			    struct beacon_data *beacon,
+			    struct sk_buff *skb,
+			    struct ieee80211_chanctx_conf *chanctx_conf,
+			    u16 csa_off_base)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_tx_info *info;
+	enum nl80211_band band;
+	struct ieee80211_tx_rate_control txrc;
+
+	/* CSA offsets */
+	if (offs && beacon) {
+		u16 i;
+
+		for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; i++) {
+			u16 csa_off = beacon->cntdwn_counter_offsets[i];
+
+			if (!csa_off)
+				continue;
+
+			offs->cntdwn_counter_offs[i] = csa_off_base + csa_off;
+		}
+	}
+
+	band = chanctx_conf->def.chan->band;
+	info = IEEE80211_SKB_CB(skb);
+	info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+	info->flags |= IEEE80211_TX_CTL_NO_ACK;
+	info->band = band;
+
+	memset(&txrc, 0, sizeof(txrc));
+	txrc.hw = hw;
+	txrc.sband = local->hw.wiphy->bands[band];
+	txrc.bss_conf = &sdata->vif.bss_conf;
+	txrc.skb = skb;
+	txrc.reported_rate.idx = -1;
+	if (sdata->beacon_rate_set && sdata->beacon_rateidx_mask[band])
+		txrc.rate_idx_mask = sdata->beacon_rateidx_mask[band];
+	else
+		txrc.rate_idx_mask = sdata->rc_rateidx_mask[band];
+	txrc.bss = true;
+	rate_control_get_rate(sdata, NULL, &txrc);
+
+	info->control.vif = vif;
+	info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT |
+		       IEEE80211_TX_CTL_ASSIGN_SEQ |
+		       IEEE80211_TX_CTL_FIRST_FRAGMENT;
+}
+
+static struct sk_buff *
+ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
+			struct ieee80211_vif *vif,
+			struct ieee80211_mutable_offsets *offs,
+			bool is_template,
+			struct beacon_data *beacon,
+			struct ieee80211_chanctx_conf *chanctx_conf)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_if_ap *ap = &sdata->u.ap;
+	struct sk_buff *skb = NULL;
+	u16 csa_off_base = 0;
+
+	if (beacon->cntdwn_counter_offsets[0]) {
+		if (!is_template)
+			ieee80211_beacon_update_cntdwn(vif);
+
+		ieee80211_set_beacon_cntdwn(sdata, beacon);
+	}
+
+	/* headroom, head length,
+	 * tail length and maximum TIM length
+	 */
+	skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
+			    beacon->tail_len + 256 +
+			    local->hw.extra_beacon_tailroom);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, local->tx_headroom);
+	skb_put_data(skb, beacon->head, beacon->head_len);
+
+	ieee80211_beacon_add_tim(sdata, &ap->ps, skb, is_template);
+
+	if (offs) {
+		offs->tim_offset = beacon->head_len;
+		offs->tim_length = skb->len - beacon->head_len;
+		offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
+
+		/* for AP the csa offsets are from tail */
+		csa_off_base = skb->len;
+	}
+
+	if (beacon->tail)
+		skb_put_data(skb, beacon->tail, beacon->tail_len);
+
+	if (ieee80211_beacon_protect(skb, local, sdata) < 0)
+		return NULL;
+
+	ieee80211_beacon_get_finish(hw, vif, offs, beacon, skb, chanctx_conf,
+				    csa_off_base);
+	return skb;
+}
+
 static struct sk_buff *
 __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		       struct ieee80211_vif *vif,
@@ -4988,12 +5097,8 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct beacon_data *beacon = NULL;
 	struct sk_buff *skb = NULL;
-	struct ieee80211_tx_info *info;
 	struct ieee80211_sub_if_data *sdata = NULL;
-	enum nl80211_band band;
-	struct ieee80211_tx_rate_control txrc;
 	struct ieee80211_chanctx_conf *chanctx_conf;
-	int csa_off_base = 0;
 
 	rcu_read_lock();
 
@@ -5010,48 +5115,11 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		struct ieee80211_if_ap *ap = &sdata->u.ap;
 
 		beacon = rcu_dereference(ap->beacon);
-		if (beacon) {
-			if (beacon->cntdwn_counter_offsets[0]) {
-				if (!is_template)
-					ieee80211_beacon_update_cntdwn(vif);
-
-				ieee80211_set_beacon_cntdwn(sdata, beacon);
-			}
-
-			/*
-			 * headroom, head length,
-			 * tail length and maximum TIM length
-			 */
-			skb = dev_alloc_skb(local->tx_headroom +
-					    beacon->head_len +
-					    beacon->tail_len + 256 +
-					    local->hw.extra_beacon_tailroom);
-			if (!skb)
-				goto out;
-
-			skb_reserve(skb, local->tx_headroom);
-			skb_put_data(skb, beacon->head, beacon->head_len);
-
-			ieee80211_beacon_add_tim(sdata, &ap->ps, skb,
-						 is_template);
-
-			if (offs) {
-				offs->tim_offset = beacon->head_len;
-				offs->tim_length = skb->len - beacon->head_len;
-				offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
-
-				/* for AP the csa offsets are from tail */
-				csa_off_base = skb->len;
-			}
-
-			if (beacon->tail)
-				skb_put_data(skb, beacon->tail,
-					     beacon->tail_len);
-
-			if (ieee80211_beacon_protect(skb, local, sdata) < 0)
-				goto out;
-		} else
+		if (!beacon)
 			goto out;
+
+		skb = ieee80211_beacon_get_ap(hw, vif, offs, is_template,
+					      beacon, chanctx_conf);
 	} else if (sdata->vif.type == NL80211_IFTYPE_ADHOC) {
 		struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 		struct ieee80211_hdr *hdr;
@@ -5077,6 +5145,9 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		hdr = (struct ieee80211_hdr *) skb->data;
 		hdr->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						 IEEE80211_STYPE_BEACON);
+
+		ieee80211_beacon_get_finish(hw, vif, offs, beacon, skb,
+					    chanctx_conf, 0);
 	} else if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 
@@ -5116,51 +5187,13 @@ __ieee80211_beacon_get(struct ieee80211_hw *hw,
 		}
 
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
+		ieee80211_beacon_get_finish(hw, vif, offs, beacon, skb,
+					    chanctx_conf, 0);
 	} else {
 		WARN_ON(1);
 		goto out;
 	}
 
-	/* CSA offsets */
-	if (offs && beacon) {
-		int i;
-
-		for (i = 0; i < IEEE80211_MAX_CNTDWN_COUNTERS_NUM; i++) {
-			u16 csa_off = beacon->cntdwn_counter_offsets[i];
-
-			if (!csa_off)
-				continue;
-
-			offs->cntdwn_counter_offs[i] = csa_off_base + csa_off;
-		}
-	}
-
-	band = chanctx_conf->def.chan->band;
-
-	info = IEEE80211_SKB_CB(skb);
-
-	info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
-	info->flags |= IEEE80211_TX_CTL_NO_ACK;
-	info->band = band;
-
-	memset(&txrc, 0, sizeof(txrc));
-	txrc.hw = hw;
-	txrc.sband = local->hw.wiphy->bands[band];
-	txrc.bss_conf = &sdata->vif.bss_conf;
-	txrc.skb = skb;
-	txrc.reported_rate.idx = -1;
-	if (sdata->beacon_rate_set && sdata->beacon_rateidx_mask[band])
-		txrc.rate_idx_mask = sdata->beacon_rateidx_mask[band];
-	else
-		txrc.rate_idx_mask = sdata->rc_rateidx_mask[band];
-	txrc.bss = true;
-	rate_control_get_rate(sdata, NULL, &txrc);
-
-	info->control.vif = vif;
-
-	info->flags |= IEEE80211_TX_CTL_CLEAR_PS_FILT |
-			IEEE80211_TX_CTL_ASSIGN_SEQ |
-			IEEE80211_TX_CTL_FIRST_FRAGMENT;
  out:
 	rcu_read_unlock();
 	return skb;
-- 
2.31.1

