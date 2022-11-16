Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAB362B109
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 03:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiKPCIx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Nov 2022 21:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiKPCIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Nov 2022 21:08:53 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426DB5FDC
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:52 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id l2so15087318pld.13
        for <linux-wireless@vger.kernel.org>; Tue, 15 Nov 2022 18:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuWAMaxUQ7+ei6oSXMS/B1imdQq/CqIh4ycZhMCtLOk=;
        b=E1msHNH/i5lnybpzc3O5/K6ifgafD+kDsEIb/95KNb4DGQ6VxmbuuLyv1FNyzENQMm
         nefaai+shT04se93370UoYteP2NzIjMS0offlq+vZNflaTF6PzdZNw0ghWNZFM4SaMsX
         BezMMnRDWXWhRqrBrRVhVfeg8tkJcF3ef/YA9GRHz/z1dW9R1PFOyP2Ew0SVqXUgBqII
         TNdkUIemKPLmE/Q1PUp43vEQMD+UTp+e85+J3iuFjyM9kchQMydgE7Zj7t8+Cp2idE+5
         7cZXW7pIkk2CvNc5U+VUqdVZOIqtKvue5rKngzu7YXgEc/3Zuo02BflCBNyzIT7XnPEm
         O4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuWAMaxUQ7+ei6oSXMS/B1imdQq/CqIh4ycZhMCtLOk=;
        b=6bUAv8+dpu0iaqochmoZzEdI75pwg1NbUe/r1vh3GWS7BmKNaKfaUcSeDZ51SHSA7S
         WLOW+0P1CEl66gwXj+lVZ/gbEXKUBbQl09yxaDshVXx7XCU2kYgDgmVL0LxI/XJPnbKk
         +gzSBaDBK5pwTMc9RW99M8bnb6DHpc4NX7SO8nJYpFRSN1jmXMpqujwVJT93nyWdLbju
         +JWGpqeBodqq8d2GYRQM8pB+seXjOVADdwP48aD753+LZsm+ccXKkRnlnhEpu5HAZx9O
         TzHnwXhr1rUepZeJzhHfx2qecxpPABjToWHMCYmrYNNQZAFTV+Ifwa2yl0V9FK+ABKkN
         bqjg==
X-Gm-Message-State: ANoB5pkDBWVbuNQHFvsa5YIQWdvVd/j3cObAeP5rLfHEPBYbp8B0At8h
        IiTY8Df2DeDXGzoZDeZ+7tTUfA==
X-Google-Smtp-Source: AA0mqf4awMD+9Fqzn/3OCLOckfYMA6lnh3N8+nMCGK3M2KOb3UJaYMmQmkWUO1l9tdMqKNk7dtp5hA==
X-Received: by 2002:a17:902:d345:b0:188:7675:763a with SMTP id l5-20020a170902d34500b001887675763amr6662568plk.133.1668564531774;
        Tue, 15 Nov 2022 18:08:51 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id y2-20020a62ce02000000b0056bbd286cf4sm9379231pfg.167.2022.11.15.18.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 18:08:51 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v3 4/4] wifi: mac80211: support setting S1G short beacon period, head and tail
Date:   Wed, 16 Nov 2022 15:07:00 +1300
Message-Id: <20221116020700.3907453-4-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
References: <20221116020700.3907453-1-gilad.itzkovitch@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kieran Frewen <kieran.frewen@morsemicro.com>

With the kernel able to send both short and long S1G beacons, include
the ability for setting the short beacon period.
It also adds the support for distinguish short beacon head and tail.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/cfg.c         | 38 ++++++++++++++++++++++++++++++++++++--
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/tx.c          | 10 ++++++++--
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a42abaa25273..9c4db453a9f1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1092,6 +1092,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_mbssid_elems *mbssid = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
+	int new_short_head_len, new_short_tail_len;
 	int size, err;
 	u32 changed = BSS_CHANGED_BEACON;
 	struct ieee80211_bss_conf *link_conf = link->conf;
@@ -1108,6 +1109,14 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_head_len = old->head_len;
 
+	/* Short head is not a mandatory field */
+	new_short_head_len = 0;
+	if (params->short_head)
+		new_short_head_len = params->short_head_len;
+	else
+		if (old && old->short_head)
+			new_short_head_len = old->short_head_len;
+
 	/* new or old tail? */
 	if (params->tail || !old)
 		/* params->tail_len will be zero for !params->tail */
@@ -1115,7 +1124,14 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	if (params->short_tail || !old)
+	       /* params->tail_len will be zero for !params->tail */
+		new_short_tail_len = params->short_tail_len;
+	else
+		new_short_tail_len = old->short_tail_len;
+
+	size = sizeof(*new) + new_head_len + new_tail_len +
+		new_short_head_len + new_short_tail_len;
 
 	/* new or old multiple BSSID elements? */
 	if (params->mbssid_ies) {
@@ -1140,11 +1156,16 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1170,6 +1191,12 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(new->head, old->head, new_head_len);
 
+	if (params->short_head)
+		memcpy(new->short_head, params->short_head, new_short_head_len);
+	else
+		if (old && old->short_head)
+			memcpy(new->short_head, old->short_head, new_short_head_len);
+
 	/* copy in optional tail */
 	if (params->tail)
 		memcpy(new->tail, params->tail, new_tail_len);
@@ -1177,6 +1204,13 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 		if (old)
 			memcpy(new->tail, old->tail, new_tail_len);
 
+	/* copy in optional short tail */
+	if (params->short_tail)
+		memcpy(new->short_tail, params->short_tail, new_short_tail_len);
+	else
+		if (old)
+			memcpy(new->short_tail, old->short_tail, new_short_tail_len);
+
 	err = ieee80211_set_probe_resp(sdata, params->probe_resp,
 				       params->probe_resp_len, csa, cca, link);
 	if (err < 0) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2e1d829c548a..212457672d7f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -264,7 +264,9 @@ struct ieee80211_color_change_settings {
 
 struct beacon_data {
 	u8 *head, *tail;
+	u8 *short_head, *short_tail;
 	int head_len, tail_len;
+	int short_head_len, short_tail_len;
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a12b32544a3a..963596772de4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5147,7 +5147,11 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		return NULL;
 
 	skb_reserve(skb, local->tx_headroom);
-	skb_put_data(skb, beacon->head, beacon->head_len);
+
+	if (is_short)
+		skb_put_data(skb, beacon->short_head, beacon->short_head_len);
+	else
+		skb_put_data(skb, beacon->head, beacon->head_len);
 
 	ieee80211_beacon_add_tim(sdata, link, &ap->ps, skb, is_template);
 
@@ -5165,7 +5169,9 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail && !is_short)
+	if (beacon->short_tail && is_short)
+		skb_put_data(skb, beacon->short_tail, beacon->short_tail_len);
+	else if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.34.1

