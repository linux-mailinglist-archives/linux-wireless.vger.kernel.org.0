Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529926220E9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 01:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiKIAi3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 19:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKIAi1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 19:38:27 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217FC21A5
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 16:38:25 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s196so14837855pgs.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Nov 2022 16:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWr7+FtXB0DpYZhfjg0/57m9qZMBht3duwcWNgFxQfs=;
        b=6AguqwjG/j8PPqApZaF4IPjsuuLTj4V+AqmNgWx3X9u4bA36tKcNr5Fy0xt79S48sH
         z/HPfPwA22RW+tFhZmZe+jaO8C3kVUR8QN25jWN9msA++ep4STg6pmtOVWLxAwv4aTW2
         93ZEe7kBtRLruQ+1siD1c2Q1GxJg3A+6l3Rks85LVOTucUjb5Dm0nIc3ZstNASHRmu1d
         e51RbYVH4YOkbg/YUlI/AXcEgkcXblLvzrbs4JMWSM11ylsL6yQQxyZMG09JwVYbAj83
         5XzOzjSie4ANE455uSyIX+VFZkHMsygfA2Epa3bTiYrDVmORhehiMpqSIlZOGI/nmSOH
         zT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWr7+FtXB0DpYZhfjg0/57m9qZMBht3duwcWNgFxQfs=;
        b=E9yXSV9U2Na/M2hqVq4M0bdha4aQsroroYhL7/EI3ud+w2TsH9yegGl1oavPBgMw7L
         pcUUr/N/VmVCdKC/axT9ucYEkn5ENtFU2Q5O++XMeHxypg0S+SdA/jv6gLx70EjfSv7f
         kNnWGtbZieQQzr3yV430vIYa3wmg5xWo/4dgOXoVrOpjUXhTfKbbT6FK1mUQnOOSPK7c
         WL5lVI0NmGf4aUrm+77SzZA0na4xj77gVjoxMSBWTS3UsKLjpYLk3w6orD9EI1j9y3MR
         3Z5l69kOE1QFqdiTaymVuujcgx7u/NiBqBKSw3PDP7z8pk3IGfQfzefr9lt3QNAE/6a+
         MU4g==
X-Gm-Message-State: ACrzQf0C9jy82uEo72pjm62hTwQb29JK58dG519K7m2ck2fXE0r1xxN4
        hyeFNEZ84Anh0Oo+frpcu4dL7g==
X-Google-Smtp-Source: AMsMyM5LlgceTu1In9hrmgEaIWgvoggkWneZPXQAHoDlfmURC6/0RMdzWcEFxukcSStuOZz+AUKoJw==
X-Received: by 2002:a63:106:0:b0:460:64ce:51c4 with SMTP id 6-20020a630106000000b0046064ce51c4mr49533704pgb.17.1667954304669;
        Tue, 08 Nov 2022 16:38:24 -0800 (PST)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001714c36a6e7sm7502726plf.284.2022.11.08.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 16:38:24 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v2 4/4] wifi: mac80211: support setting S1G short beacon period and tail
Date:   Wed,  9 Nov 2022 13:37:27 +1300
Message-Id: <20221109003727.614882-4-gilad.itzkovitch@morsemicro.com>
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

With the kernel able to send both short and long S1G beacons, include
the ability for setting the short beacon period.
It also adds the support for distinguish short beacon tail.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 net/mac80211/cfg.c         | 22 +++++++++++++++++++---
 net/mac80211/ieee80211_i.h |  4 ++--
 net/mac80211/tx.c          |  4 +++-
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a42abaa25273..09905f827b29 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1091,7 +1091,7 @@ static int ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 {
 	struct cfg80211_mbssid_elems *mbssid = NULL;
 	struct beacon_data *new, *old;
-	int new_head_len, new_tail_len;
+	int new_head_len, new_tail_len, new_short_tail_len;
 	int size, err;
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
index a12b32544a3a..b75817915def 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5165,7 +5165,9 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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

