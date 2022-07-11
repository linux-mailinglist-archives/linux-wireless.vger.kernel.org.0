Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5564656D25C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGKBJE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGKBJD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240EEB1F2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o15so3576721pjh.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cXVbTmInU8G8tlN7P+BDM9qyU7c1qqtqt8NCUQ0GTLY=;
        b=ZEpTJtLfKz1lDgD+Qf4RQk3NUNywZwcaqNnbmRLKt/PTBb0fWIt73s9wpXoDVEzLy3
         vrvDLMj9TTHW6lCT9fzJuf2uxywVFO71UNyfx1fXGNJopppF4SsPvcuha0+SBAn/fQgf
         31qWv/pfx11YvejP5lq+VQbGXLO0ibCFLj2jgtS0qCQpQtE12RqEm/cbISx2Dl+nNG5F
         xzf8D3gm7cvhlk2Err3OesKWm9psFB3w7mPqr7dml4wteCXFuDy/8J2kjoGT2NtNkc57
         O5h7KqDt+PRbwzalWjz7QhxrPbyOWJUlKrRpVxdabecezoAwlVv3vDAZ6N2sA2ZIkC4F
         kqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cXVbTmInU8G8tlN7P+BDM9qyU7c1qqtqt8NCUQ0GTLY=;
        b=H6S8tXYh2e12Siw+xt/B9vxzP1sMzclPu+4fblD799BkWUXrGr/LEho41QaHyYpOru
         UmvRedMipXyWrvND8IWliGF0tW/MNG4s6hzLYakomOqyislzIM2vZbzUEx8ZIV9Re2MP
         98EVN0yR9MH1wBWxzT984F7ADIWM8y8xzYRK1dS5+p4rVqvMme2a/g/nKVciJid0FtuH
         zLeGDyqcPrzQie9kEcaH4QTzmCSltBBbx7gTTlzDoOQ+R7dWPHHkKSNFik5GsmOKqjGZ
         R8t6PCjmeLXv8TqSyxOa6xkqG9YAqCbOe+gZ+VKdSVhFOnUP8Wj6n0nCXmTd+/qqY1H6
         0tYQ==
X-Gm-Message-State: AJIora+Fq0PK3wPA6hHyydxNMeqIfQGqmNIV8IV/XHR11SE9KBY1MZZy
        EltWdfDC01XvaQ/HIwU6gtWScllf9iG77Xk9
X-Google-Smtp-Source: AGRyM1utQZi7qV3/xAtkfBdUPm27YD6Vxn1KHu5w7wWC7nO5iSp8Y/Pm8US1/sM3oPuvqm6pHyKQmg==
X-Received: by 2002:a17:902:7c06:b0:16a:755f:86dd with SMTP id x6-20020a1709027c0600b0016a755f86ddmr15831708pll.82.1657501741441;
        Sun, 10 Jul 2022 18:09:01 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:01 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 03/12] mac80211: S1G beacon/short beacon support
Date:   Mon, 11 Jul 2022 01:08:07 +0000
Message-Id: <20220711010816.45927-4-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
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

If configured, use the S1G short beacon format. The S1G short beacon
format includes a limited set of information elements.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 include/net/cfg80211.h     |  2 +-
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         |  1 +
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tx.c          | 14 +++++++++++++-
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 996782c44838..7859b8b11968 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1310,7 +1310,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 27f24ac0426d..1fd461ed746d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -656,6 +656,7 @@ struct ieee80211_bss_conf {
 	bool enable_beacon;
 	u8 dtim_period;
 	u16 beacon_int;
+	u8 short_beacon_period;
 	u16 assoc_capability;
 	u64 sync_tsf;
 	u32 sync_device_ts;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b387f5f4fef0..b4c2f4e9083e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1227,6 +1227,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2190d08f4e34..19fa3f830abc 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -257,6 +257,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	u8 long_beacon_count;
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3d83f838d728..632df040f07f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5065,6 +5065,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
@@ -5102,7 +5114,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link_id) < 0)
-- 
2.25.1

