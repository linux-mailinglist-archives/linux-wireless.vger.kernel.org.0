Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BF1242BCC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHLPBi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLPBH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:07 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE48C061388
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:01 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFN-0002OP-M2; Wed, 12 Aug 2020 17:00:57 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 3/9] mac80211: add multiple bssid support to beacon handling
Date:   Wed, 12 Aug 2020 17:00:44 +0200
Message-Id: <20200812150050.2683396-4-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812150050.2683396-1-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With beacon_data now holding the additional information about the multiple
bssid elements, we need to honour these in the various beacon handling
code paths.

Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  2 ++
 net/mac80211/cfg.c         | 59 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  1 +
 3 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b409a5f1026c..a2145092697f 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -607,6 +607,7 @@ struct ieee80211_ftm_responder_params {
  * @he_oper: HE operation information of the AP we are connected to
  * @he_obss_pd: OBSS Packet Detection parameters.
  * @he_bss_color: BSS coloring settings, if BSS supports HE
+ * @multiple_bssid: the multiple bssid settings of the AP.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -674,6 +675,7 @@ struct ieee80211_bss_conf {
 	} he_oper;
 	struct ieee80211_he_obss_pd he_obss_pd;
 	struct cfg80211_he_bss_color he_bss_color;
+	struct ieee80211_multiple_bssid multiple_bssid;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 50a219d8a2cc..32c5c6d726b8 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -936,13 +936,39 @@ static int ieee80211_set_ftm_responder_params(
 	return 0;
 }
 
+static int ieee80211_get_multiple_bssid_beacon_len(struct cfg80211_multiple_bssid_data *data)
+{
+	int i, len = 0;
+
+	for (i = 0; i < data->cnt; i++)
+		len += data->len[i];
+
+	return len;
+}
+
+static u8 *ieee80211_copy_multiple_bssid_beacon(u8 *offset,
+						struct cfg80211_multiple_bssid_data *new,
+						struct cfg80211_multiple_bssid_data *old)
+{
+	int i;
+
+	*new = *old;
+	for (i = 0; i < new->cnt; i++) {
+		new->ies[i] = offset;
+		memcpy(new->ies[i], old->ies[i], new->len[i]);
+		offset += new->len[i];
+	}
+	return offset;
+}
+
 static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 				   struct cfg80211_beacon_data *params,
 				   const struct ieee80211_csa_settings *csa,
 				   const struct ieee80211_cca_settings *cca)
 {
 	struct beacon_data *new, *old;
-	int new_head_len, new_tail_len;
+	int new_head_len, new_tail_len, new_multiple_bssid_len;
+	u8 *new_multiple_bssid_offset;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
 
@@ -966,7 +992,15 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	/* new or old multiple_bssid? */
+	if (params->multiple_bssid.cnt || !old)
+		new_multiple_bssid_len =
+			ieee80211_get_multiple_bssid_beacon_len(&params->multiple_bssid);
+	else
+		new_multiple_bssid_len =
+			ieee80211_get_multiple_bssid_beacon_len(&old->multiple_bssid);
+
+	size = sizeof(*new) + new_head_len + new_tail_len + new_multiple_bssid_len;
 
 	new = kzalloc(size, GFP_KERNEL);
 	if (!new)
@@ -983,6 +1017,18 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
 
+	new_multiple_bssid_offset = new->tail + new_tail_len;
+
+	/* copy in optional multiple_bssid_ies */
+	if (params->multiple_bssid.cnt)
+		ieee80211_copy_multiple_bssid_beacon(new_multiple_bssid_offset,
+						     &new->multiple_bssid,
+						     &params->multiple_bssid);
+	else if (old && old->multiple_bssid.cnt)
+		ieee80211_copy_multiple_bssid_beacon(new_multiple_bssid_offset,
+						     &new->multiple_bssid,
+						     &old->multiple_bssid);
+
 	if (csa) {
 		new->cntdwn_current_counter = csa->count;
 		memcpy(new->cntdwn_counter_offsets, csa->counter_offsets_beacon,
@@ -1134,6 +1180,8 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	       sizeof(struct ieee80211_he_obss_pd));
 	memcpy(&sdata->vif.bss_conf.he_bss_color, &params->he_bss_color,
 	       sizeof(struct ieee80211_he_bss_color));
+	sdata->vif.bss_conf.multiple_bssid.count = params->multiple_bssid.count;
+	sdata->vif.bss_conf.multiple_bssid.index = params->multiple_bssid.index;
 
 	sdata->vif.bss_conf.ssid_len = params->ssid_len;
 	if (params->ssid_len)
@@ -3015,7 +3063,8 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 
 	len = beacon->head_len + beacon->tail_len + beacon->beacon_ies_len +
 	      beacon->proberesp_ies_len + beacon->assocresp_ies_len +
-	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len;
+	      beacon->probe_resp_len + beacon->lci_len + beacon->civicloc_len +
+	      ieee80211_get_multiple_bssid_beacon_len(&beacon->multiple_bssid);
 
 	new_beacon = kzalloc(sizeof(*new_beacon) + len, GFP_KERNEL);
 	if (!new_beacon)
@@ -3058,6 +3107,10 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
+	if (beacon->multiple_bssid.cnt)
+		pos = ieee80211_copy_multiple_bssid_beacon(pos,
+							   &new_beacon->multiple_bssid,
+							   &beacon->multiple_bssid);
 
 	/* might copy -1, meaning no changes requested */
 	new_beacon->ftm_responder = beacon->ftm_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c8a25f62e458..016bed63e74e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -268,6 +268,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	struct cfg80211_multiple_bssid_data multiple_bssid;
 	struct rcu_head rcu_head;
 };
 
-- 
2.25.1

