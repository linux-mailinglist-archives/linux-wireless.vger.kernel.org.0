Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB56E0256
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDLXMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Apr 2023 19:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLXMx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Apr 2023 19:12:53 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D992326BE
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 16:12:51 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id jx2-20020a17090b46c200b002469a9ff94aso11492472pjb.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Apr 2023 16:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1681341171; x=1683933171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMN62qJwdoMSmvkp+Eg4iesbNTxNKeE2B1TTV88zrfM=;
        b=to5R8SWZxnkmUw33AVNrwsUL1RKVP/bXS3j62mhoEwTIj8zK0f+E0jUz6nkSl5IGSb
         1HyHzn1e0/RVIOynDimemrhDRgRbyPoGXgb6fbQ/2seaG07UHFwq9IpS+lRoXdpEP9P2
         v78oamUuVSmxegS+pj8g8mPCA/PAtsYYQsxSHc+NVvwOhKDNhT5IWbs0HGkvhAb+vD0S
         K2te+O5UzKXcf8XpXVm7JZfV/prFXOrLuKhCwPHNvWGer42OhEA6Zcro3AjI7/QiXYKv
         DjFHXa2lstiSiokMEy5rXd45+eZqkE6R9dENsQw+2P+8zzQtN2nc98yQyVtcEajS95Io
         z8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681341171; x=1683933171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMN62qJwdoMSmvkp+Eg4iesbNTxNKeE2B1TTV88zrfM=;
        b=Pd1DvfClbOXA992rhrvjtnOolprZp4On7bHT3/WkGRDKFRu/LgUEDPdFReTNcZdCrg
         JzczDrMLLKTvVECmcHA+l7HN041Oxz7SlqbvvxSD5hySzSOvNv6ydossi4FK+ncI150k
         jbSJNQHozlmvYVPumYKo+LPD4R2cY81t5N9SBTFqK0t7jXTpdJazbJ1YCWsBl9A1wNQF
         GlcUG34kpwALex/SUsU5g1gJCXzwetd+SZx2nEcZJispHcH6rnGpIX1GltoNlsWJjIaD
         /6smslZuN3TUWfkuh1U0qrFsfCy/42iaeUyw6aYgjSt6aklJpEVm/QuUBXpS/wiMJRwL
         PBQQ==
X-Gm-Message-State: AAQBX9clxZVMFWdRkuNbh4doakc7dLk0CYSsNEHplkPmi6Zwf/MQmpWF
        JvLZl94dpAZcDmfOf6ExS6cje5NBMmkl/YOR2fI=
X-Google-Smtp-Source: AKy350a4jFjwpZoHKWKUlah+MnaZuvOd3ruHz0iKamgaBlpxdTh9IOCpN6CnDv/LEsq9WT3hsiUncg==
X-Received: by 2002:a17:903:454:b0:1a6:4fbd:d5bf with SMTP id iw20-20020a170903045400b001a64fbdd5bfmr32964plb.8.1681341171321;
        Wed, 12 Apr 2023 16:12:51 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id s20-20020a170902a51400b001a1c2ee06e0sm128198plq.15.2023.04.12.16.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 16:12:51 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH v4 2/2] wifi: mac80211: S1G beacon/short beacon support
Date:   Thu, 13 Apr 2023 11:12:41 +1200
Message-Id: <20230412231241.1587517-2-gilad.itzkovitch@virscient.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412231241.1587517-1-gilad.itzkovitch@virscient.com>
References: <20230412231241.1587517-1-gilad.itzkovitch@virscient.com>
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
the ability for setting the short beacon period. If configured, use
the S1G short beacon format. The S1G short beacon format includes a
limited set of information elements. It also adds the support for
distinguish short beacon head and tail.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Co-developed-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---

Notes:
    v4:
     - squash mac80211 commits together
     - address hitting short head/tail code path in nl80211.c
     - update code style

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

