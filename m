Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D017A62010B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 22:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiKGVZB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 16:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKGVYk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 16:24:40 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A422F66F
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 13:24:08 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s196so11608517pgs.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 13:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RM0lG+fj9X9NdzLvFBZpi+eiE8A7unHNU+MJkajS6is=;
        b=LTE6w12NwcenpNfXEb/h4ANwTdEzlgHhDcqQTle1FA5aKFsVaKvkOUcl2lsq0hEkRT
         3UaVTXLtzeLeD0SQEpucI069xNGhO1/QkpXdaLSe9t3czGbdqXvM9GbceaD3XBe+Bzjt
         P6DBNN1pTIkBeXQwigXiPfN+PhsM2pg9v4zH1FWbokxHrpWms8ufCOe01xypKaWctBKr
         MftSiP7jR+cS5b8igKc0p5lIh6uC5cDtIlDhQLSl7BRDfifLvULfrKePMY/49ALik7/8
         TL9eL/EyeD+Bcc4w8MDrHp7m3WYf+C18OHsHbdDDpeg7hzTCHkzjA0UXixVHnJ6ollOv
         i6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RM0lG+fj9X9NdzLvFBZpi+eiE8A7unHNU+MJkajS6is=;
        b=hyJPHhv1eYYEUG12diiBHbTaCXSNv+3ofQnDV0L5dRl4QQzDTxzC9eXxSZiJq6GFPw
         InODZfMT37a9uAMyh3Q8Cn/PGkyprgYYOmk4VKKv4eUipfOkXG/QMA8r0nMBYlYKSwUW
         pI44Ahxv0QxqfrL9V0WOnU6KHYo/Qs1aGRYT1VOi65FecmJOJeo6aa+ptCqNWL7p+GQS
         HaZCUqnV0IDZutXbwEemPIicKhBP3+P0CyhYjbNSoB0Tgibc4EZ4AQVNnxQdBmRFae6m
         rbf/98b/ZrlDqjwmZDFYPVp5PguLlgA4ujCqEd0dCPNmvnFNbXzDvGIMxpasoSVEQq7A
         NrJA==
X-Gm-Message-State: ACrzQf0VNmL4RlbLrGtB4H6cTBgq+0HylBpDxZG4YqZgaDv6SVoTjGZN
        RP7hsbsAaubb8R31RS47nIkM6g==
X-Google-Smtp-Source: AMsMyM4TUpJldZzymfR8O2K2LJG/LzDQiXK8C7orgciqZzgmt2OqXGiYe7EHbNPCVWhYdD7Vod+Hiw==
X-Received: by 2002:a05:6a00:2193:b0:56c:ea4c:6947 with SMTP id h19-20020a056a00219300b0056cea4c6947mr52646696pfi.27.1667856248206;
        Mon, 07 Nov 2022 13:24:08 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79f8a000000b00560bb4a57f7sm5102356pfr.179.2022.11.07.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:24:07 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH 2/4] wifi: mac80211: S1G beacon/short beacon support
Date:   Tue,  8 Nov 2022 10:23:56 +1300
Message-Id: <20221107212358.272070-2-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107212358.272070-1-gilad.itzkovitch@morsemicro.com>
References: <20221107212358.272070-1-gilad.itzkovitch@morsemicro.com>
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
index 383e0242e95f..ff5ea7ab271b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5121,6 +5121,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
@@ -5158,7 +5170,7 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.34.1

