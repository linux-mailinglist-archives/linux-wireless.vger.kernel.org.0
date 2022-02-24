Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201F24C2B3C
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 12:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiBXL4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 06:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbiBXL4J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 06:56:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99B3254550
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 03:55:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7049FB82575
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 11:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB45C340E9;
        Thu, 24 Feb 2022 11:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645703736;
        bh=9dV/fwFgKTJeuXWajZjFJYR+9gH9mvMXrH+Qvsphs5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0/Qr8TqwD6RS4mGnJPCnkjbIra3yms+9eCfUzNNE7hvZ3WHbbky2sVmq0Barw07X
         56A4OeoZXr4VoZXy4ZG/TWfubYEzj1zrjVWlK0w1PVA4jGcL1BKn77OrS1YDAxX71n
         jaLSai33m+ZrbSdD+Vrat7Hb8UNhitg2jWrznttEF5R2KBEY/T3MfUpCrUxcKmkp0r
         nE6DKFdQRcZfGv+pAMicJ10zzNX2+brmDejiYkfjzd5MMaoA+SUi1dh2PeqD/4pD/M
         WZw02ij/HL+LklGwnYCNmXZULUheJdQY5tuWueKkV99nz6Pl26JMFc9bkU0LdthDdu
         Q9xQmMLskbZaA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        quic_alokad@quicinc.com, john@phrozen.org, nbd@nbd.name,
        ryder.lee@mediatek.com, money.wang@mediatek.com,
        evelyn.tsai@mediatek.com
Subject: [PATCH v14 mac80211-next 1/3] mac80211: MBSSID beacon handling in AP mode
Date:   Thu, 24 Feb 2022 12:54:58 +0100
Message-Id: <5322db3c303f431adaf191ab31c45e151dde5465.1645702516.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645702516.git.lorenzo@kernel.org>
References: <cover.1645702516.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new fields in struct beacon_data to store all MBSSID elements.
Generate a beacon template which includes all MBSSID elements.
Move CSA offset to reflect the MBSSID element length.

Co-developed-by: Aloka Dixit <alokad@codeaurora.org>
Signed-off-by: Aloka Dixit <alokad@codeaurora.org>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/mac80211.h     |  2 +
 net/mac80211/cfg.c         | 99 +++++++++++++++++++++++++++++++++-----
 net/mac80211/ieee80211_i.h | 15 ++++++
 net/mac80211/tx.c          | 24 ++++++++-
 4 files changed, 126 insertions(+), 14 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index c50221d7e82c..b73913e039c6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4931,12 +4931,14 @@ void ieee80211_report_low_ack(struct ieee80211_sta *sta, u32 num_packets);
  * @cntdwn_counter_offs: array of IEEE80211_MAX_CNTDWN_COUNTERS_NUM offsets
  *	to countdown counters.  This array can contain zero values which
  *	should be ignored.
+ * @mbssid_off: position of the multiple bssid element
  */
 struct ieee80211_mutable_offsets {
 	u16 tim_offset;
 	u16 tim_length;
 
 	u16 cntdwn_counter_offs[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
+	u16 mbssid_off;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 87a208089caf..f7324a6d4a78 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -989,11 +989,29 @@ static int ieee80211_set_ftm_responder_params(
 	return 0;
 }
 
+static int
+ieee80211_copy_mbssid_beacon(u8 *pos, struct cfg80211_mbssid_elems *dst,
+			     struct cfg80211_mbssid_elems *src)
+{
+	int i, offset = 0;
+
+	for (i = 0; i < src->cnt; i++) {
+		memcpy(pos + offset, src->elem[i].data, src->elem[i].len);
+		dst->elem[i].len = src->elem[i].len;
+		dst->elem[i].data = pos + offset;
+		offset += dst->elem[i].len;
+	}
+	dst->cnt = src->cnt;
+
+	return offset;
+}
+
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
 				   const struct ieee80211_csa_settings *csa,
 				   const struct ieee80211_color_change_settings *cca)
 {
+	struct cfg80211_mbssid_elems *mbssid = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
 	int size, err;
@@ -1019,8 +1037,19 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
+	/* new or old multiple BSSID elements? */
 	size = sizeof(*new) + new_head_len + new_tail_len;
 
+	if (params->mbssid_ies) {
+		mbssid = params->mbssid_ies;
+		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
+		size += ieee80211_get_mbssid_beacon_len(mbssid);
+	} else if (old && old->mbssid_ies) {
+		mbssid = old->mbssid_ies;
+		size += struct_size(new->mbssid_ies, elem, mbssid->cnt);
+		size += ieee80211_get_mbssid_beacon_len(mbssid);
+	}
+
 	new = kzalloc(size, GFP_KERNEL);
 	if (!new)
 		return -ENOMEM;
@@ -1029,12 +1058,20 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 
 	/*
 	 * pointers go into the block we allocated,
-	 * memory is | beacon_data | head | tail |
+	 * memory is | beacon_data | head | tail | mbssid_ies
 	 */
 	new->head = ((u8 *) new) + sizeof(*new);
 	new->tail = new->head + new_head_len;
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
+	/* copy in optional mbssid_ies */
+	if (mbssid) {
+		u8 *pos = new->tail + new->tail_len;
+
+		new->mbssid_ies = (struct cfg80211_mbssid_elems *)pos;
+		pos += struct_size(new->mbssid_ies, elem, mbssid->cnt);
+		ieee80211_copy_mbssid_beacon(pos, new->mbssid_ies, mbssid);
+	}
 
 	if (csa) {
 		new->cntdwn_current_counter = csa->count;
@@ -1332,8 +1369,11 @@ static int ieee80211_stop_ap(struct wiphy *wiphy, struct net_device *dev)
 
 	mutex_unlock(&local->mtx);
 
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	if (sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
 
 	/* turn off carrier for this interface and dependent VLANs */
 	list_for_each_entry(vlan, &sdata->u.ap.vlans, u.vlan.list)
@@ -3130,12 +3170,24 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
-	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len;
+	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
+	      ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
 		return NULL;
 
+	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt) {
+		new_beacon->mbssid_ies =
+			kzalloc(struct_size(new_beacon->mbssid_ies,
+					    elem, beacon->mbssid_ies->cnt),
+				GFP_KERNEL);
+		if (!new_beacon->mbssid_ies) {
+			kfree(new_beacon);
+			return NULL;
+		}
+	}
+
 	pos = (u8 *)(new_beacon + 1);
 	if (beacon->head_len) {
 		new_beacon->head_len = beacon->head_len;
@@ -3173,6 +3225,10 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
+	if (beacon->mbssid_ies && beacon->mbssid_ies->cnt)
+		pos += ieee80211_copy_mbssid_beacon(pos,
+						    new_beacon->mbssid_ies,
+						    beacon->mbssid_ies);
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
@@ -3222,8 +3278,11 @@ static int ieee80211_set_after_csa_beacon(struct ieee80211_sub_if_data *sdata,
 	case NL80211_IFTYPE_AP:
 		err = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		if (sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->mbssid_ies);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
+		}
 
 		if (err < 0)
 			return err;
@@ -3378,8 +3437,12 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 		if ((params->n_counter_offsets_beacon >
 		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM) ||
 		    (params->n_counter_offsets_presp >
-		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM))
+		     IEEE80211_MAX_CNTDWN_COUNTERS_NUM)) {
+			kfree(sdata->u.ap.next_beacon->mbssid_ies);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
 			return -EINVAL;
+		}
 
 		csa.counter_offsets_beacon = params->counter_offsets_beacon;
 		csa.counter_offsets_presp = params->counter_offsets_presp;
@@ -3389,7 +3452,9 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 		err = ieee80211_assign_beacon(sdata, &params->beacon_csa, &csa, NULL);
 		if (err < 0) {
+			kfree(sdata->u.ap.next_beacon->mbssid_ies);
 			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
 			return err;
 		}
 		*changed |= err;
@@ -3479,8 +3544,11 @@ static int ieee80211_set_csa_beacon(struct ieee80211_sub_if_data *sdata,
 static void ieee80211_color_change_abort(struct ieee80211_sub_if_data  *sdata)
 {
 	sdata->vif.color_change_active = false;
-	kfree(sdata->u.ap.next_beacon);
-	sdata->u.ap.next_beacon = NULL;
+	if (sdata->u.ap.next_beacon) {
+		kfree(sdata->u.ap.next_beacon->mbssid_ies);
+		kfree(sdata->u.ap.next_beacon);
+		sdata->u.ap.next_beacon = NULL;
+	}
 
 	cfg80211_color_change_aborted_notify(sdata->dev);
 }
@@ -4218,8 +4286,11 @@ ieee80211_set_after_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 
 		ret = ieee80211_assign_beacon(sdata, sdata->u.ap.next_beacon,
 					      NULL, NULL);
-		kfree(sdata->u.ap.next_beacon);
-		sdata->u.ap.next_beacon = NULL;
+		if (sdata->u.ap.next_beacon) {
+			kfree(sdata->u.ap.next_beacon->mbssid_ies);
+			kfree(sdata->u.ap.next_beacon);
+			sdata->u.ap.next_beacon = NULL;
+		}
 
 		if (ret < 0)
 			return ret;
@@ -4262,7 +4333,11 @@ ieee80211_set_color_change_beacon(struct ieee80211_sub_if_data *sdata,
 		err = ieee80211_assign_beacon(sdata, &params->beacon_color_change,
 					      NULL, &color_change);
 		if (err < 0) {
-			kfree(sdata->u.ap.next_beacon);
+			if (sdata->u.ap.next_beacon) {
+				kfree(sdata->u.ap.next_beacon->mbssid_ies);
+				kfree(sdata->u.ap.next_beacon);
+				sdata->u.ap.next_beacon = NULL;
+			}
 			return err;
 		}
 		*changed |= err;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 330ea62231fa..34484b3bc307 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -257,6 +257,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
 
@@ -1078,6 +1079,20 @@ ieee80211_vif_get_shift(struct ieee80211_vif *vif)
 	return shift;
 }
 
+static inline int
+ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems)
+{
+	int i, len = 0;
+
+	if (!elems)
+		return 0;
+
+	for (i = 0; i < elems->cnt; i++)
+		len += elems->elem[i].len;
+
+	return len;
+}
+
 enum {
 	IEEE80211_RX_MSG	= 1,
 	IEEE80211_TX_STATUS_MSG	= 2,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6d054fed062f..b6b20f38de0e 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5042,6 +5042,19 @@ ieee80211_beacon_get_finish(struct ieee80211_hw *hw,
 		       IEEE80211_TX_CTL_FIRST_FRAGMENT;
 }
 
+static void
+ieee80211_beacon_add_mbssid(struct sk_buff *skb, struct beacon_data *beacon)
+{
+	int i;
+
+	if (!beacon->mbssid_ies)
+		return;
+
+	for (i = 0; i < beacon->mbssid_ies->cnt; i++)
+		skb_put_data(skb, beacon->mbssid_ies->elem[i].data,
+			     beacon->mbssid_ies->elem[i].len);
+}
+
 static struct sk_buff *
 ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 			struct ieee80211_vif *vif,
@@ -5055,6 +5068,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	struct ieee80211_if_ap *ap = &sdata->u.ap;
 	struct sk_buff *skb = NULL;
 	u16 csa_off_base = 0;
+	int mbssid_len;
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
@@ -5064,11 +5078,12 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	}
 
 	/* headroom, head length,
-	 * tail length and maximum TIM length
+	 * tail length, maximum TIM length and multiple BSSID length
 	 */
+	mbssid_len = ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
 	skb = dev_alloc_skb(local->tx_headroom + beacon->head_len +
 			    beacon->tail_len + 256 +
-			    local->hw.extra_beacon_tailroom);
+			    local->hw.extra_beacon_tailroom + mbssid_len);
 	if (!skb)
 		return NULL;
 
@@ -5082,6 +5097,11 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		offs->tim_length = skb->len - beacon->head_len;
 		offs->cntdwn_counter_offs[0] = beacon->cntdwn_counter_offsets[0];
 
+		if (mbssid_len) {
+			ieee80211_beacon_add_mbssid(skb, beacon);
+			offs->mbssid_off = skb->len - mbssid_len;
+		}
+
 		/* for AP the csa offsets are from tail */
 		csa_off_base = skb->len;
 	}
-- 
2.35.1

