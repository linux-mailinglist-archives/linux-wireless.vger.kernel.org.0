Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B56220E7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKIAiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKIAiT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:38:19 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20B463159
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:38:18 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so15696145pli.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8fLhB7N3J1r4mUp3lzjhF1u0CrSA6Q2JXjotTecwRE=;
        b=OufF/yojHVARO+dLFRtys9JkIz3ukmHqpUlhGZhxgCLrmEbpIU3vmgFABuWxtt8aVO
         NuMmSPOKuHeZq+8x+rwtCW0edCc7dF8Laca1PsN3LlosEfHIOsgLjl19nh0lmxVOR7j1
         f7Ua4BWsEVtY0hm7CXtGvtWdSVawVmM140Jgnb/LNGagrrBKD95XLB0iKWrAkfrFp4NZ
         kzbBhggsS7mzNev0tEYNTibOLW9MWbTpKnly8F/byjcjOGcDKZTfSjJYcmWf0fhs/JHN
         AogdCsMhlKIg0xfrZStJNwGEA1OP3olXHGwGlmNgTxyPjeO8gn65v6xicKDLdVch94Ml
         rgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8fLhB7N3J1r4mUp3lzjhF1u0CrSA6Q2JXjotTecwRE=;
        b=lV87XaRhknjbNBwxH4dOhYuAJshmfehEtRilKEbi0abWgul+I47IvtYwUt/pJuelIR
         /NCACTVEGV40lM4O5K6E2xDhdPy9wydyCtG0JYWmo5QKi90hsAjT1+oC0CSTqrvpBnZU
         il89Ozne1E2AoI9u8qbXr6tYLOh2GXPP3pTOtsutdxxd7DgTxXdcg0Ib/clCIeOk1QtL
         a3g90GOocsk3St2OSZ6RI763nbBeJuaeDrDoVS8LVSd8HDiPM0UwFZJCqrnJ3eJrdv6j
         J8kLu5C5h4nv6ARPdH3Ku/Y8VSlGI4HOKozDsuEbjlr1J/hIYSrNTbSw6a/9qxy6anxk
         pzGw==
X-Gm-Message-State: ACrzQf1SEBCidDxJUOJHUlQstO2rXw5VTW6ZdTmmMVmt5hcU67qDspLm
        oW+FVdE1n8gjUQZ1fLu30zaC1A==
X-Google-Smtp-Source: AMsMyM7gUoGlEGJV6d4fz0GlUNWVfsSADE3EKI5j6b0+b963qI5UvsFUK89A5hBmcB61ikxZeFUdnw==
X-Received: by 2002:a17:902:c94b:b0:187:3da6:37ab with SMTP id i11-20020a170902c94b00b001873da637abmr39722840pla.50.1667954298245;
        Tue, 08 Nov 2022 16:38:18 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001714c36a6e7sm7502726plf.284.2022.11.08.16.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:38:17 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v2 2/4] wifi: mac80211: S1G beacon/short beacon support
Date:   Wed,  9 Nov 2022 13:37:25 +1300
Message-Id: <20221109003727.614882-2-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109003727.614882-1-gilad.itzkovitch@morsemicro.com>
References: <20221109003727.614882-1-gilad.itzkovitch@morsemicro.com>
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

If configured, use the S1G short beacon format. The S1G short beacon
format includes a limited set of information elements.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/net/mac80211.h     |  1 +
 net/mac80211/cfg.c         |  1 +
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/tx.c          | 14 +++++++++++++-
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 721c450a9ccd..39faafde109a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -674,6 +674,7 @@ struct ieee80211_bss_conf {
 	bool enable_beacon;
 	u8 dtim_period;
 	u16 beacon_int;
+	u8 short_beacon_period;
 	u16 assoc_capability;
 	u64 sync_tsf;
 	u32 sync_device_ts;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index c848fe04dd44..a42abaa25273 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1308,6 +1308,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 63ff0d2524b6..2e1d829c548a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -268,6 +268,7 @@ struct beacon_data {
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
+	u8 long_beacon_count;
 	struct cfg80211_mbssid_elems *mbssid_ies;
 	struct rcu_head rcu_head;
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index bb2e54610101..a12b32544a3a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5116,6 +5116,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
@@ -5153,7 +5165,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.34.1

