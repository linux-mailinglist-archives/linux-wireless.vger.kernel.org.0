Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 356A35A5941
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiH3CUt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiH3CUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:20:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1010D7D1FB
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso7261042pjd.2
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HxKKlWsAhxPCYRgnWNyY3cpTuJyPhAfkq7gTXShT8Fc=;
        b=IkbxtS1eZN7FNYuF9zrg3v4mezDdURdg8lcGOCUgMLGHvpWyqAbKUlm8A/7LfPY4UZ
         ShYQetsI1O6tx1Ia7YdjV0+ESk8U2IPmhXtVGOHBCDu5o6BukQB3L9rGnPzov1JqTadO
         emmVZ8ER8/XNYPsoUoP2a8gNahD1+VwEhvzSzWu4s/fVTNb9/OITMZaAPxQlEgnLx0jm
         Ugbv8iMS4xlwo7eDtk4dd+N/GdoVeovLrnHGX5Wwv3jF8sZYbCKva33zGJjOYQ7JFGZz
         TU3DtxjTuDzYeAUaukQxSZN9P480y2VWPYh1xDOrmO9e49kuc3FqFHp5L9Yq9PM030qB
         f0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HxKKlWsAhxPCYRgnWNyY3cpTuJyPhAfkq7gTXShT8Fc=;
        b=3tP2FRPTmmbnF19c8HHpx8iDu6IG7lz/bxNNzDMf5fQ50O1YCJIgti0YHa3EctgKCB
         6UUAdSr/IVYL7/l8aoE9+ppN059AiXUspF+ki5+H0GlBnpxsijnbuzLWUwZokIhlDy00
         t3tA8jQm3cHL2U1VdnicYRzwJiW6qEdV/hBES/LPYnZI4XHQ1i99bTI1mLQFbKhLDTIJ
         VvlLZgg+d3NqiazqjORlgvqN44oJoQra0iAWJdkplxBlwSOTDcQTvv0tmWe+9duDBaqu
         IA8txScUzCMaES84XqLK0ayJPuwOpQidw1rj0DutDbbPcVIY4N0W6aYFJsL0m4oF0zTK
         A5nw==
X-Gm-Message-State: ACgBeo3jIszWXK6hZTr3rALfPaikRe0hegQyUZxGtQpGVLoZfsXa3tFd
        ghF0U3WBkqJ56pgfJxzWFAkbRg==
X-Google-Smtp-Source: AA6agR571wBp27ZIydxuLKyzFZ0+23F4dna4c5Fmxj2QzDjyrl221gON+4chOQ8bOTXSjD4GIYjtyw==
X-Received: by 2002:a17:902:ef46:b0:168:bac3:2fd4 with SMTP id e6-20020a170902ef4600b00168bac32fd4mr18886182plx.132.1661826046581;
        Mon, 29 Aug 2022 19:20:46 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:20:46 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 03/12] mac80211: S1G beacon/short beacon support
Date:   Tue, 30 Aug 2022 02:20:08 +0000
Message-Id: <20220830022017.51017-4-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
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
---
 include/net/cfg80211.h     |  2 +-
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         |  1 +
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tx.c          | 14 +++++++++++++-
 5 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908d58393484..f462dcdd023a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1328,7 +1328,7 @@ struct cfg80211_ap_settings {
 
 	struct cfg80211_beacon_data beacon;
 
-	int beacon_interval, dtim_period;
+	int beacon_interval, dtim_period, short_beacon_period;
 	const u8 *ssid;
 	size_t ssid_len;
 	enum nl80211_hidden_ssid hidden_ssid;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f198af600b5e..359edfa9ec1c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -672,6 +672,7 @@ struct ieee80211_bss_conf {
 	bool enable_beacon;
 	u8 dtim_period;
 	u16 beacon_int;
+	u8 short_beacon_period;
 	u16 assoc_capability;
 	u64 sync_tsf;
 	u32 sync_device_ts;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a4f6971b7a19..03ed90ce9a84 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1236,6 +1236,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e192e1ec0261..cd8879998739 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -267,6 +267,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	u8 long_beacon_count;
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bf85a01fcf9d..48c737aeb3f7 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5099,6 +5099,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
@@ -5136,7 +5148,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.25.1

