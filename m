Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF477774B7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjHJJgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 05:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjHJJgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 05:36:14 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C710C4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 02:36:13 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-53482b44007so477572a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Aug 2023 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1691660172; x=1692264972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmxZjzZfeIjrmA5RHzp6uUJ0UlNtoAy+RIrHGVetfHc=;
        b=foB/4evDpfxdp7x6pfzPXFV+hUkwe9rufevlIECWNA1D/FuzuCbeIqi7xZKVmInIMc
         vtRDJDNFXqH+FiVe9Q5Bi2Pat6wAL2ikZQ+QOvH9d75zZ90yGjrMZjxYpnNr+T3jPEyj
         fnr1kF5WxyJgb3Urff+QsieH3Z2F27n9kQIIrevrzas+01ZknyCBDemKDbGvlCR51uL3
         zU8xH28zwDVLKFhKN12mopo2qzPusC7nhSH13nQHJwlAyRWKYyWfvSWy0875pDfgUMh1
         uBq8/LMxSemrbgXjYGvT+iLCnYYGyteNLthpk+SQyX86uJFMFYGHjWnxO5nIYV/2ajJD
         Mzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691660172; x=1692264972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmxZjzZfeIjrmA5RHzp6uUJ0UlNtoAy+RIrHGVetfHc=;
        b=R6LZeKBoq917U4xBzXOu95xaAJrcp4ae3HLfpMp8XC/E65ZFaC/28zlyev2PpwdKY2
         pRgdpDh3djAUvl4mUzoB80M+sgM+DVCrgdG0bVcQhkH3sUcidKpUBOCBBxaDyNMoHcc7
         tDpDiDOsA7v7KYhWNw/DXPvLEw55wsD5/Y36k/PkGmzzPRY6kCHdST5y5QYIPK2+F/Gv
         blM5weBGfuz850yreR9dBHB5zpc0uGgD/2uscIGLnLBSYvhIqVvS/XsQTp3jY3b4qm6M
         QlHyuOwrQx8Pi+9+8rQSjWjLJT1mK6Wde8sJ8GATwRLjctsPINsa8PhiHHPNJKMxEZwO
         Vxmw==
X-Gm-Message-State: AOJu0YyeJTmCIum4fPIlmgeMLtUlUb06LVV/zEoGqDZkLwgdZNsZN3Vs
        0ysUTgzOpQeOPrafr14XzCmNmM1bs5aBUHxnTtc=
X-Google-Smtp-Source: AGHT+IGZrjtvn6hsMJTUjLkE531wpSVBUZtGszuEtwtB21e75PMRuAIw/GScaSp9SkBEhBGqUEj5Eg==
X-Received: by 2002:a17:90b:2310:b0:268:def:a322 with SMTP id mt16-20020a17090b231000b002680defa322mr1379725pjb.9.1691660172652;
        Thu, 10 Aug 2023 02:36:12 -0700 (PDT)
Received: from bassem.hub ([2405:6e00:10e7:e100:b398:e136:4868:a1a5])
        by smtp.googlemail.com with ESMTPSA id fz12-20020a17090b024c00b00262e5449dbcsm1045906pjb.24.2023.08.10.02.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:36:12 -0700 (PDT)
From:   Bassem Dawood <bassem@morsemicro.com>
To:     linux-wireless@vger.kernel.org
Cc:     Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v7 2/2] wifi: mac80211: S1G beacon/short beacon support
Date:   Thu, 10 Aug 2023 19:35:56 +1000
Message-Id: <20230810093556.33800-2-bassem@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810093556.33800-1-bassem@morsemicro.com>
References: <20230810093556.33800-1-bassem@morsemicro.com>
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
v7:
 - no udpates
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

