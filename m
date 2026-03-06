Return-Path: <linux-wireless+bounces-32667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO7KA4Fiq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:25:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 619CD228A72
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 987D53112131
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804EB35BDC4;
	Fri,  6 Mar 2026 23:23:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500E2ECE91
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839399; cv=none; b=gxd0sm0QUVcs/Kqhfqj7HYVXU/9InZheTAPbyG13rRsPcdsG51KsgAvhziDtq1D0Kb7V1gVWU0TCJB91XBmBPooVottAVsH9KiwODYhu55hJSoShogjtUR+DNQriHCCQSgFFqrWjYxtSXbUZ9HYvaxxwIIB7eqDJkeUggndSg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839399; c=relaxed/simple;
	bh=ABzd+GW/ifmPqK2FFnPCMcZ6oewtcx02XrKPVbVyHOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWS0h0fLxhoglwDKTRbUmx3DweiZfFU9N1XSgPJJDj5ea0AqQbLlte+qv7pBIDXv8MzGBzBM81nXVA5QweOqhbQa8qisu6qA0iCqq8iPBNbEcvB6mHXQjivTiJ80+35E23VubbEL/oim2DPS3N55AZnviW7y90vROAc/sBHxcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-463d81452abso6236801b6e.0
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839397; x=1773444197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+eTGWet6XyoMFJ4Chh4Z8OqxtwPFIFWbrK9UEPtAnUo=;
        b=dylIvgLg+JaZS/JQ0HYVmMHyI5NFhBPlCpR4Vt1O+tbSVxv/iaofmQ7Nd9d6tqo8H7
         /xtGoiNRO/R6a5hnVdXcI+aaPsJAiL+4Wma9oigSqnUnjDXHuB8Akg9KAf0sil64RQIK
         Webu3/oGl3E8QDNCgx1ZQlbT4Gddk6BnWravxRNgTnycIr/UZK75Twku/6ke6DFhqP+h
         wf/X/wfAo+z+2nwnFwhuYxuYjdLGWN32zD9QAVDNjGN07NgXTWG4IVFvGI1zpgtvgHJI
         WQB3pCoEhSR85Cntau4+rL7JpK8/BKI1TDnJvgGQmQVm3H0j4UCyaGpA5pXQbDbMjQYx
         5orA==
X-Gm-Message-State: AOJu0YyQP2IOL3CPLgYzPbDmL1TTj6Vi5enj97ZsltGKc0aPFyWlvGDH
	ZLfxenfAy3BRBHvV2aExKmu1uEDom2ZersIdani/5L47lBVH2nmf5awS
X-Gm-Gg: ATEYQzwAj92xYVEoFjM0nj7r+iBipjQru/CQ0tdXjTPliKr93KKBwN1TJb91hYD/7mk
	M83T/oLaXOX7xLUqebxLrh0Yg4I+961gQOyj9NAFUaWCWefD/YVZDMn6PHxwMIbPZH1Owk3cXSb
	4PBcxn4d0HdmSNZllQ2gCx9pVH6+KU5QeYDUjHERuV66p7y1cxySFfFWUshncOrLso2c4XlMFWZ
	P2UoxKIf6myAWWFABFeJ3Lj1lfCdIq0KkWp21q5YrDmnrkzueIF69U4l+uDeNZdJma9m8NcQrwb
	6Tp8dr9Q8H2yhKmbPOpvZ8ZO+HLo4U+I+S1dzZKLugcV+rcI7hP7o9WHYY2MMuc03yLa+OEZOjD
	QQHIc4ZyEngCNQYpDDEBj1qVKjCtuZWXzSXtwQf57Q6BzPERNzEPCxB90bscs4MRYl52bnLnPnc
	OYjNNpY2XjNknJoUa416xI0Kv462vfxJ3uZUugxXqGMKEZYJ8=
X-Received: by 2002:a05:6808:344b:b0:463:4f2e:c50b with SMTP id 5614622812f47-466dcb193demr1996398b6e.41.1772839396937;
        Fri, 06 Mar 2026 15:23:16 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:16 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 02/19] wifi: mt76: mt7925: pass WCID indices to bss_basic_tlv()
Date: Fri,  6 Mar 2026 17:22:21 -0600
Message-ID: <20260306232238.2039675-3-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306232238.2039675-1-sean.wang@kernel.org>
References: <20260306232238.2039675-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 619CD228A72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32667-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.376];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_mcu_bss_basic_tlv() and
pass the resolved WCID indices from the caller instead. The link
context is already known, so the lookup is redundant.

This makes link ownership explicit and keeps the helper lookup-free.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 34 +++++++---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 68 ++++++++++++-------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  7 ++
 3 files changed, 73 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index afcc0fa4aa35..353461f0e169 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -850,20 +850,22 @@ mt7925_get_rates_table(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 				   struct ieee80211_vif *vif,
-				   struct ieee80211_link_sta *link_sta)
+				   struct ieee80211_link_sta *link_sta,
+				   struct mt792x_link_sta *mlink)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
 	struct mt792x_bss_conf *mconf;
 	u8 link_id = link_sta->link_id;
-	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 	struct mt76_wcid *wcid;
 	int ret, idx;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-	mlink = mt792x_sta_to_link(msta, link_id);
+
+	if (WARN_ON_ONCE(!mlink))
+		return -EINVAL;
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
@@ -898,12 +900,21 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 
 	/* should update bss info before STA add */
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
-		if (ieee80211_vif_is_mld(vif))
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, link_sta != mlink->pri_link);
-		else
-			mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
-						link_conf, link_sta, false);
+		struct mt792x_link_sta *mlink_bc;
+
+		mlink_bc = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
+
+		if (ieee80211_vif_is_mld(vif)) {
+			mt7925_mcu_add_bss_info_sta(&dev->phy, mconf->mt76.ctx,
+						    link_conf, link_sta,
+						    mlink_bc->wcid.idx, mlink->wcid.idx,
+						    link_sta != mlink->pri_link);
+		} else {
+			mt7925_mcu_add_bss_info_sta(&dev->phy, mconf->mt76.ctx,
+						    link_conf, link_sta,
+						    mlink_bc->wcid.idx, mlink->wcid.idx,
+						    false);
+		}
 	}
 
 	if (ieee80211_vif_is_mld(vif) &&
@@ -965,7 +976,7 @@ mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		mlink->wcid.def_wcid = &msta->deflink.wcid;
 
 		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
-		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta);
+		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta, mlink);
 	}
 
 	return err;
@@ -989,7 +1000,8 @@ int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 		err = mt7925_mac_sta_add_links(dev, vif, sta, sta->valid_links);
 	} else {
-		err = mt7925_mac_link_sta_add(mdev, vif, &sta->deflink);
+		err = mt7925_mac_link_sta_add(mdev, vif, &sta->deflink,
+					      &msta->deflink);
 	}
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index fa5f79004a6e..0d5519e5dc4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2476,7 +2476,9 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 			 struct ieee80211_bss_conf *link_conf,
 			 struct ieee80211_link_sta *link_sta,
 			 struct ieee80211_chanctx_conf *ctx,
-			 struct mt76_phy *phy, u16 wlan_idx,
+			 struct mt76_phy *phy,
+			 u16 bmc_tx_wlan_idx,
+			 u16 sta_wlan_idx,
 			 bool enable)
 {
 	struct ieee80211_vif *vif = link_conf->vif;
@@ -2485,7 +2487,6 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 						  &link_conf->chanreq.oper;
 	enum nl80211_band band = chandef->chan->band;
 	struct mt76_connac_bss_basic_tlv *basic_req;
-	struct mt792x_link_sta *mlink;
 	struct tlv *tlv;
 	int conn_type;
 	u8 idx;
@@ -2509,20 +2510,9 @@ mt7925_mcu_bss_basic_tlv(struct sk_buff *skb,
 	basic_req->phymode = mt76_connac_get_phy_mode(phy, vif, band, link_sta);
 	basic_req->bcn_interval = cpu_to_le16(link_conf->beacon_int);
 	basic_req->dtim_period = link_conf->dtim_period;
-	basic_req->bmc_tx_wlan_idx = cpu_to_le16(wlan_idx);
+	basic_req->bmc_tx_wlan_idx = cpu_to_le16(bmc_tx_wlan_idx);
 	basic_req->link_idx = mconf->mt76.idx;
-
-	if (link_sta) {
-		struct mt792x_sta *msta;
-
-		msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
-
-	} else {
-		mlink = &mconf->vif->sta.deflink;
-	}
-
-	basic_req->sta_idx = cpu_to_le16(mlink->wcid.idx);
+	basic_req->sta_idx = cpu_to_le16(sta_wlan_idx);
 	basic_req->omac_idx = mconf->mt76.omac_idx;
 	basic_req->band_idx = mconf->mt76.band_idx;
 	basic_req->wmm_idx = mconf->mt76.wmm_idx;
@@ -2829,16 +2819,16 @@ void mt7925_mcu_del_dev(struct mt76_dev *mdev,
 			  &dev_req, sizeof(dev_req), true);
 }
 
-int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
-			    struct ieee80211_chanctx_conf *ctx,
-			    struct ieee80211_bss_conf *link_conf,
-			    struct ieee80211_link_sta *link_sta,
-			    int enable)
+int mt7925_mcu_add_bss_info_sta(struct mt792x_phy *phy,
+				struct ieee80211_chanctx_conf *ctx,
+				struct ieee80211_bss_conf *link_conf,
+				struct ieee80211_link_sta *link_sta,
+				u16 bmc_tx_wlan_idx,
+				u16 sta_wlan_idx,
+				int enable)
 {
-	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
 	struct mt792x_dev *dev = phy->dev;
-	struct mt792x_link_sta *mlink_bc;
 	struct sk_buff *skb;
 
 	skb = __mt7925_mcu_alloc_bss_req(&dev->mt76, &mconf->mt76,
@@ -2846,11 +2836,9 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	mlink_bc = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
-
 	/* bss_basic must be first */
 	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta, ctx, phy->mt76,
-				 mlink_bc->wcid.idx, enable);
+				 bmc_tx_wlan_idx, sta_wlan_idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
@@ -2871,6 +2859,36 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 				     MCU_UNI_CMD(BSS_INFO_UPDATE), true);
 }
 
+int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
+			    struct ieee80211_chanctx_conf *ctx,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_link_sta *link_sta,
+			    int enable)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
+	struct mt792x_link_sta *mlink_bc;
+	struct mt792x_link_sta *mlink;
+	u16 sta_wlan_idx;
+
+	sta_wlan_idx = mvif->sta.deflink.wcid.idx;
+
+	mlink_bc = mt792x_sta_to_link(&mvif->sta, mconf->link_id);
+
+	if (link_sta) {
+		struct mt792x_sta *msta = (void *)link_sta->sta->drv_priv;
+
+		mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+		if (WARN_ON(!mlink))
+			return -1;
+	} else {
+		mlink = &mconf->vif->sta.deflink;
+	}
+
+	return mt7925_mcu_add_bss_info_sta(phy, ctx, link_conf, link_sta,
+					   mlink_bc->wcid.idx, mlink->wcid.idx, enable);
+}
+
 int mt7925_mcu_set_dbdc(struct mt76_phy *phy, bool enable)
 {
 	struct mt76_dev *mdev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index e09e0600534a..56e2772f3ffe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -693,6 +693,13 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 			    struct ieee80211_bss_conf *link_conf,
 			    struct ieee80211_link_sta *link_sta,
 			    int enable);
+int mt7925_mcu_add_bss_info_sta(struct mt792x_phy *phy,
+				struct ieee80211_chanctx_conf *ctx,
+				struct ieee80211_bss_conf *link_conf,
+				struct ieee80211_link_sta *link_sta,
+				u16 bmc_tx_wlan_idx,
+				u16 sta_wlan_idx,
+				int enable);
 int mt7925_mcu_set_timing(struct mt792x_phy *phy,
 			  struct ieee80211_bss_conf *link_conf);
 int mt7925_mcu_set_deep_sleep(struct mt792x_dev *dev, bool enable);
-- 
2.43.0


