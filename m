Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35484620110
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Nov 2022 22:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiKGVZI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Nov 2022 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKGVYt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Nov 2022 16:24:49 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF4CE02
        for <linux-wireless@vger.kernel.org>; Mon,  7 Nov 2022 13:24:15 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so11914960pfb.0
        for <linux-wireless@vger.kernel.org>; Mon, 07 Nov 2022 13:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lk4Pp0Fz5Mba6FhFVSZeNtxpH20vTyuYMMbZGtqe5s=;
        b=LZ47W8Xh5mrhsYA+EDxxkMHYsz4bLd49jvOzhCMIF7UvlwUenHc6zATa9riZVqSA8d
         R9r81wZd6fKSUvn1RevZeDU0mJKqjggfCQf8EojXQsuWLlggnNJI7IDxHuvnM+Q54yqu
         ORMFwraSPnhFgHhxvEEE46DtEXOWDNWHdz0IulG2/RqEY1eAL+5onjVoOY4WRKgkX5HU
         gwREDWpKYUrl7jkrKhkeU8gpBec8CHdEEF7mGAnJ+LOUECclKmQp3hQZni91+4H34uJL
         BBCeeNCCu0AL+iGyPTcJ8qt0AqVQr0mllttf0+mvcI2VYgKLf4jLak7echDHBVR6XjHE
         p62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lk4Pp0Fz5Mba6FhFVSZeNtxpH20vTyuYMMbZGtqe5s=;
        b=2DVXPPmgeUPPcErZ9uAbmY1lMr/oCf+UGUrytP7P1PnoOFJ9PMduCzJJ7cPSM9MOHZ
         bY49/EV7pzDUSczos9MV/rUROKwbRL4hV3FBxT9+POxKuw7rBdYij4qEivE7NiA6bSbj
         DDWoTkDF0Nt6J9rbLxybJLrlEnlpvibmP7feK5W4HrgmYqA3ou1Rqt2EN37Y7iNJ6liw
         Huaye/xB0qrlxMPvSIoPK619K3TdBge5rz3T+ZQ1Knw5nMZS7u+dtwXzjRw/JLREVZJk
         iK10MoeLC9jK6POgyMwnxr4zau+NaqkGaOLIfagjv9OFves3Xo8kPPZXDNdIt7OJ5vtl
         t+WQ==
X-Gm-Message-State: ACrzQf23pUXOY1XULq/hkVC2SRhmLA0/kqH7MMLHUdkQIeCGYFDAsZMb
        ah3WSHtgy+lQxTNdK9xSa0Th6g==
X-Google-Smtp-Source: AMsMyM61c4S4Skew9WKrKK69PLG7+A5Kqo3KEt+WJpepDrxOSAaCwPja6HiXPhRGAaGL4SuqZpaYhA==
X-Received: by 2002:a63:cf48:0:b0:439:7d1c:fedc with SMTP id b8-20020a63cf48000000b004397d1cfedcmr44923490pgj.281.1667856254683;
        Mon, 07 Nov 2022 13:24:14 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id z10-20020aa79f8a000000b00560bb4a57f7sm5102356pfr.179.2022.11.07.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 13:24:14 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH 4/4] wifi: mac80211: support setting S1G short beacon period and tail
Date:   Tue,  8 Nov 2022 10:23:58 +1300
Message-Id: <20221107212358.272070-4-gilad.itzkovitch@morsemicro.com>
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

With the kernel able to send both short and long S1G beacons, include
the ability for setting the short beacon period.
It also adds the support for distinguish short beacon tail.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/cfg.c         | 24 ++++++++++++++++++++----
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/tx.c          |  4 +++-
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a42abaa25273..acc8c881bd7b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1091,8 +1091,8 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 {
 	struct cfg80211_mbssid_elems *mbssid = NULL;
 	struct beacon_data *new, *old;
-	int new_head_len, new_tail_len;
-	int size, err;
+	int new_head_len, new_tail_len, new_short_tail_len;
+	int size, size_short, err;
 	u32 changed = BSS_CHANGED_BEACON;
 	struct ieee80211_bss_conf *link_conf = link->conf;
 
@@ -1115,7 +1115,13 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	else
 		new_tail_len = old->tail_len;
 
-	size = sizeof(*new) + new_head_len + new_tail_len;
+	if (params->short_tail || !old)
+	       /* params->tail_len will be zero for !params->tail */
+		new_short_tail_len = params->short_tail_len;
+	else
+		new_short_tail_len = old->short_tail_len;
+
+	size = sizeof(*new) + new_head_len + new_tail_len + new_short_tail_len;
 
 	/* new or old multiple BSSID elements? */
 	if (params->mbssid_ies) {
@@ -1142,9 +1148,12 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	new->tail = new->head + new_head_len;
 	new->head_len = new_head_len;
 	new->tail_len = new_tail_len;
+	new->short_tail = new->tail + new->tail_len;
+	new->short_tail_len = new_short_tail_len;
+
 	/* copy in optional mbssid_ies */
 	if (mbssid) {
-		u8 *pos = new->tail + new->tail_len;
+		u8 *pos = new->short_tail + new->short_tail_len;
 
 		new->mbssid_ies = (void *)pos;
 		pos += struct_size(new->mbssid_ies, elem, mbssid->cnt);
@@ -1177,6 +1186,13 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
index 2e1d829c548a..ef58e6f74b52 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -263,8 +263,8 @@ struct ieee80211_color_change_settings {
 };
 
 struct beacon_data {
-	u8 *head, *tail;
-	int head_len, tail_len;
+	u8 *head, *tail, *short_tail;
+	int head_len, tail_len, short_tail_len;
 	struct ieee80211_meshconf_ie *meshconf;
 	u16 cntdwn_counter_offsets[IEEE80211_MAX_CNTDWN_COUNTERS_NUM];
 	u8 cntdwn_current_counter;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ff5ea7ab271b..f33e62d24151 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5170,7 +5170,9 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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

