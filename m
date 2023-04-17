Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F56E3D31
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 03:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjDQBWF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Apr 2023 21:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDQBWD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Apr 2023 21:22:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAA31BDB
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 18:22:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b70f0b320so884310b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 16 Apr 2023 18:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1681694522; x=1684286522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gvoxS0itX1uZN6V8Ml76IVlyfp9aUx67t6z7brDWtIw=;
        b=rDTEcOMa/q5wVCTGnIf0m28P1lJcFwbF4X/06gosK18jFaO8Y2ZWucga5S2yOtWcvM
         HjpW5d5lmvvXs4fV7LT400cuQESVtQ055TKRbz2nnbUl+hgMwAgJCESL0t/64gZyvKnm
         IYV0YfwXEn4c5Jw+IgqRKwq11X9WiJgWGFMKPsyab+jDXW/duKTCQpPpE1ubTrPvqQjg
         pxQa5HYLO/eVFWOBBRs7EtN3C6o55PWiJI8AJQHDKWM9q0FH0xiaquaotO6fLHrQbcfJ
         5QbCEqXB0+2BFQnZRjTqe7u9IziKPZWiZ2T+dZgxTr3H3yAs95pPyVxcBoOYZZKtow7b
         unaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681694522; x=1684286522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvoxS0itX1uZN6V8Ml76IVlyfp9aUx67t6z7brDWtIw=;
        b=Hq/7Yju5ACjec5+zPUvuZYZU/D74d5RdtWhEh0ixWWSLtUpKqPpCU5q56EI9ovhcjK
         2VRIW45uj9u7/3pDbxsYB//nQ39KQKfdnQdCW7IJYFK7cDvoc0UWz41fcDggry39r5kL
         zVf5m08vw4+5ptRXcEyP5GdEa/hxAWBRRQjfXkQSdOz+XThPyP7mkezjK2A9n1/drSns
         I0lZU6lNGK8k80VzfGCGPoIRnpoc4pxNIt4q5aMP0yISZNnMAZKLmXJCmOVtO2wp+Vxf
         ftokHDODkOwPlHaboo5hxot36XWTUiO5hLCbrSjXDET8XOK1bqWYJG+G1rBt+FUyknb+
         X5sQ==
X-Gm-Message-State: AAQBX9et44cSrBBAOU292aryjr1yvHdehrU35yJkOgJeP7Nl+Bfztv32
        ln+HQzWZ2NY4CPbZbm7V88wCSA==
X-Google-Smtp-Source: AKy350ZMAqY+nJPn2IlN+uWY0/t7HQoMNHAmpIF+zQcZdSZco1YSqWg5gJ6Z/jT9qrapyY4JwX86Yw==
X-Received: by 2002:a05:6a00:814:b0:627:e1c3:49d5 with SMTP id m20-20020a056a00081400b00627e1c349d5mr20092413pfk.23.1681694521830;
        Sun, 16 Apr 2023 18:22:01 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id h17-20020aa786d1000000b0063d238c2e95sm386654pfo.91.2023.04.16.18.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 18:22:01 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v5 2/2] wifi: mac80211: S1G beacon/short beacon support
Date:   Mon, 17 Apr 2023 13:21:51 +1200
Message-Id: <20230417012151.2512303-2-gilad.itzkovitch@virscient.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
References: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

With the kernel able to send both short and long S1G beacons, include
the ability for setting the short beacon period. If configured, use
the S1G short beacon format. The S1G short beacon format includes a
limited set of information elements. It also adds the support for
distinguish short beacon head and tail.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>

v4:
 - squash mac80211 commits together
 - address hitting short head/tail code path in nl80211.c
 - update code style
---
 include/net/mac80211.h     |  2 ++
 net/mac80211/cfg.c         | 36 ++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/tx.c          | 22 ++++++++++++++++++++--
 4 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 679421d37a42..fe24decbfd3c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -573,6 +573,7 @@ struct ieee80211_fils_discovery {
  *	Note also that this is not used with MLD associations, mac80211 doesn't
  *	know how to track beacons for all of the links for this.
  * @beacon_int: beacon interval
+ * @short_beacon_period: S1G short beacon period
  * @assoc_capability: capabilities taken from assoc resp
  * @basic_rates: bitmap of basic rates, each bit stands for an
  *	index into the rate table configured by the driver in
@@ -706,6 +707,7 @@ struct ieee80211_bss_conf {
 	bool enable_beacon;
 	u8 dtim_period;
 	u16 beacon_int;
+	u16 short_beacon_period;
 	u16 assoc_capability;
 	u64 sync_tsf;
 	u32 sync_device_ts;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ebbd13d0c29a..7fa92b5b0421 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1111,6 +1111,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_rnr_elems *rnr = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
+	int new_short_head_len, new_short_tail_len;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
 	struct ieee80211_bss_conf *link_conf = link->conf;
@@ -1127,6 +1128,13 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_head_len = old->head_len;
 
+	/* Short head is not a mandatory field */
+	new_short_head_len = 0;
+	if (params->short_head)
+		new_short_head_len = params->short_head_len;
+	else if (old && old->short_head)
+		new_short_head_len = old->short_head_len;
+
 	/* new or old tail? */
 	if (params->tail || !old)
 		/* params->tail_len will be zero for !params->tail */
@@ -1134,7 +1142,14 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	if (params->short_tail || !old)
+		/* params->short_tail_len will be zero for !params->short_tail */
+		new_short_tail_len = params->short_tail_len;
+	else
+		new_short_tail_len = old->short_tail_len;
+
+	size = sizeof(*new) + new_head_len + new_tail_len +
+		new_short_head_len + new_short_tail_len;
 
 	/* new or old multiple BSSID elements? */
 	if (params->mbssid_ies) {
@@ -1169,11 +1184,16 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	 */
 	new->head = ((u8 *) new) + sizeof(*new);
 	new->tail = new->head + new_head_len;
+	new->short_head = new->tail + new_tail_len;
+	new->short_tail = new->short_head + new_short_head_len;
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
+	new->short_head_len = new_short_head_len;
+	new->short_tail_len = new_short_tail_len;
+
 	/* copy in optional mbssid_ies */
 	if (mbssid) {
-		u8 *pos = new->tail + new->tail_len;
+		u8 *pos = new->short_tail + new->short_tail_len;
 
 		new->mbssid_ies = (void *)pos;
 		pos += struct_size(new->mbssid_ies, elem, mbssid->cnt);
@@ -1205,6 +1225,11 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(new->head, old->head, new_head_len);
 
+	if (params->short_head)
+		memcpy(new->short_head, params->short_head, new_short_head_len);
+	else if (old && old->short_head)
+		memcpy(new->short_head, old->short_head, new_short_head_len);
+
 	/* copy in optional tail */
 	if (params->tail)
 		memcpy(new->tail, params->tail, new_tail_len);
@@ -1212,6 +1237,12 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		if (old)
 			memcpy(new->tail, old->tail, new_tail_len);
 
+	/* copy in optional short tail */
+	if (params->short_tail)
+		memcpy(new->short_tail, params->short_tail, new_short_tail_len);
+	else if (old)
+		memcpy(new->short_tail, old->short_tail, new_short_tail_len);
+
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
 				       params->probe_resp_len, csa, cca, link);
 	if (err < 0) {
@@ -1405,6 +1436,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cdc80285efd4..867004f87a2c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -265,10 +265,13 @@ struct ieee80211_color_change_settings {
 
 struct beacon_data {
 	u8 *head, *tail;
+	u8 *short_head, *short_tail;
 	int head_len, tail_len;
+	int short_head_len, short_tail_len;
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	u8 long_beacon_count;
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct cfg80211_rnr_elems *rnr_ies;
 	struct rcu_head rcu_head;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index dfe6b9c9b29e..2ea79f12fe21 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5256,6 +5256,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 	struct sk_buff *skb = NULL;
 	u16 csa_off_base = 0;
 	int mbssid_len;
+	bool is_short = false;
+
+	if (vif->cfg.s1g) {
+		if (beacon->long_beacon_count == 0) {
+			is_short = false;
+			beacon->long_beacon_count =
+				vif->bss_conf.short_beacon_period - 1;
+		} else {
+			is_short = true;
+			beacon->long_beacon_count--;
+		}
+	}
 
 	if (beacon->cntdwn_counter_offsets[0]) {
 		if (!is_template)
@@ -5278,7 +5290,11 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		return NULL;
 
 	skb_reserve(skb, local->tx_headroom);
-	skb_put_data(skb, beacon->head, beacon->head_len);
+
+	if (is_short)
+		skb_put_data(skb, beacon->short_head, beacon->short_head_len);
+	else
+		skb_put_data(skb, beacon->head, beacon->head_len);
 
 	ieee80211_beacon_add_tim(sdata, link, &ap->ps, skb, is_template);
 
@@ -5296,7 +5312,9 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->short_tail && is_short)
+		skb_put_data(skb, beacon->short_tail, beacon->short_tail_len);
+	else if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.34.1

