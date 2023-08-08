Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D80774AAD
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Aug 2023 22:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjHHUdR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Aug 2023 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjHHUct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Aug 2023 16:32:49 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1AE4BBDE
        for <linux-wireless@vger.kernel.org>; Tue,  8 Aug 2023 09:52:06 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63cf6b21035so37691416d6.1
        for <linux-wireless@vger.kernel.org>; Tue, 08 Aug 2023 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1691513525; x=1692118325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2K9R0Ynh/NjLSFVRUap1atZMHDIXekAscDzKyxohbk=;
        b=J5wbealKCpirJjXQvCWAwlboOBOb8AA6+hnVsKlQVUGz8M8PDo9Gu+OgZAPW+c+MqU
         jQlgX9mbOy6UVwZGNCpof7hkmax9Qjr6orqqyv59H/kVNSVGyELNRj56emynD0XWDSsO
         KIzyTRHgSvqIHIRN+wvgSV2djoVeYfUCxOZloqf468CIhFky6pr0LDM+OedKMDFVBaCP
         FETAMBv81fVphDLLdCJNDwQaIyaTYkc6D6iG4nJ7xjJwx7LgBqVANLxQgUG4I+3HCHk8
         2b5XwSLehuNMvyQ/1ASdeDkvAOrfoq9MiLBLzfH1hDVHMWZdZrOZXpDViPwqJ1zvXkIZ
         31tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513525; x=1692118325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2K9R0Ynh/NjLSFVRUap1atZMHDIXekAscDzKyxohbk=;
        b=Oja+eZvq3IfJWJZhnRSt0rH9cc+C//qCRLx6AMgYchE1b79P7K9ilAnKoftlO0Uowq
         QdMZEtHwO882lrmIwYV07xViceusNlm9KhHJN4qRhGO1o1t+YWyuufJFyqxDWlV1jjpH
         6Ax4wDPSWajhtvshfWKmx1g/Jtghj0zHvjCG/BNVNxCRIJUtvLy5FaQC73NQLdrC+hmL
         uOt4CfrC+5yP/HGhy1/605k5Z38oJ9gi6tHO5qCvYbKNJZtXKusgWbldQd7QkiYTt9s8
         XMVaE1b8HYS6BEANIvBKmwumP+0+YS5lOzw7VLL7U0z7Q0eUj5yj579unmz1ZM9UNChM
         w1JA==
X-Gm-Message-State: AOJu0YwPvFtXbb7Z4HvSRAoS88acaT85YizeEuv6yU/3s6TuRZrmHxVo
        orfSEE8RleF6t7smr1VNTKscoZYWL7aw4uBOnVw=
X-Google-Smtp-Source: AGHT+IFYfABVVZy9YxP3YpvjdpZ9K6L5MPFKDudOJU1LYXHnLsCnVbbLquF5Rmm2VcfwdvIoMau6LA==
X-Received: by 2002:a17:902:a40b:b0:1bc:2d43:c741 with SMTP id p11-20020a170902a40b00b001bc2d43c741mr10243619plq.66.1691490473648;
        Tue, 08 Aug 2023 03:27:53 -0700 (PDT)
Received: from bassem.sydney.mm.lcl (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.googlemail.com with ESMTPSA id q17-20020a170902dad100b001bb9aadfb04sm8642087plx.220.2023.08.08.03.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 03:27:53 -0700 (PDT)
From:   Bassem Dawood <bassem@morsemicro.com>
To:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Cc:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v6 2/2] wifi: mac80211: S1G beacon/short beacon support
Date:   Tue,  8 Aug 2023 20:27:32 +1000
Message-Id: <20230808102732.37270-2-bassem@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808102732.37270-1-bassem@morsemicro.com>
References: <20230417012151.2512303-1-gilad.itzkovitch@virscient.com>
 <20230808102732.37270-1-bassem@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
v6:
 - update to latest wireless-next
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
index 3a8a2d2c58c3..912abcc2dec0 100644
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
index e7ac24603892..4925c476b46e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1119,6 +1119,7 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_rnr_elems *rnr = NULL;
 	struct beacon_data *new, *old;
 	int new_head_len, new_tail_len;
+	int new_short_head_len, new_short_tail_len;
 	int size, err;
 	u64 _changed = BSS_CHANGED_BEACON;
 	struct ieee80211_bss_conf *link_conf = link->conf;
@@ -1135,6 +1136,13 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1142,7 +1150,14 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1177,11 +1192,16 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1213,6 +1233,11 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1220,6 +1245,12 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
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
@@ -1418,6 +1449,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	link_conf->dtim_period = params->dtim_period;
+	link_conf->short_beacon_period = params->short_beacon_period;
 	link_conf->enable_beacon = true;
 	link_conf->allow_p2p_go_ps = sdata->vif.p2p;
 	link_conf->twt_responder = params->twt_responder;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 91633a0b723e..bc60384740e0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -259,10 +259,13 @@ struct ieee80211_color_change_settings {
 
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
index 7fe7280e8437..f3015941ae80 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5260,6 +5260,18 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
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
@@ -5282,7 +5294,11 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		return NULL;
 
 	skb_reserve(skb, local->tx_headroom);
-	skb_put_data(skb, beacon->head, beacon->head_len);
+
+	if (is_short)
+		skb_put_data(skb, beacon->short_head, beacon->short_head_len);
+	else
+		skb_put_data(skb, beacon->head, beacon->head_len);
 
 	ieee80211_beacon_add_tim(sdata, link, &ap->ps, skb, is_template);
 
@@ -5300,7 +5316,9 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
 		csa_off_base = skb->len;
 	}
 
-	if (beacon->tail)
+	if (beacon->short_tail && is_short)
+		skb_put_data(skb, beacon->short_tail, beacon->short_tail_len);
+	else if (beacon->tail && !is_short)
 		skb_put_data(skb, beacon->tail, beacon->tail_len);
 
 	if (ieee80211_beacon_protect(skb, local, sdata, link) < 0)
-- 
2.25.1

