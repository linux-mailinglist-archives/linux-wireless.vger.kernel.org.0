Return-Path: <linux-wireless+bounces-32666-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6COCIXliq2mmcgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32666-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:25:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F2B228A64
	for <lists+linux-wireless@lfdr.de>; Sat, 07 Mar 2026 00:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C64023105F19
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 23:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C5D372672;
	Fri,  6 Mar 2026 23:23:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF435BDC4
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772839398; cv=none; b=gnmfZU5Ckd/WedyjPLZWySIFaRdn5fsutCdp8lrgQ0DTlv1CyvN5U8Y1sJzh3YBTHxKzQtrxvM8td8Lhh60SbzPFbRsK91dI9tmpiq+4Nq7P0Gt/exPL3+OPrCIQs4cwUxV10Gf8Gn3r6g+xgRvQq3m40BLr3ZjV6ikkRuhoeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772839398; c=relaxed/simple;
	bh=P0IL4mfnA1ue9xgJ1gjzS8DGWRAQ3Io/xidr5lMLljg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzu5Gp39zdnuSYlw4tVpAwOMfDzBlpK5hSnB6Gr7DHz2OOLs7ELCHs7/Fe1hr/ztAsoK/vI0JJAFEO068xTeHR6fprzrQQgXyJh1+i4QhW3fc8nJdpuB86iubyeroPBPAZqYxEXZpV/qyL2chVEshpOSdZO2npA3sBaVSs67VS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40efc77933fso3178464fac.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 15:23:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772839394; x=1773444194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FI6lFbqNcjlnv2/DDmdSeyH5dGNHoKeIYxDgvbGzpSI=;
        b=vJO9oY6cb30CgAx2P1Oq2mnPUNsIN9odwLXoDuzSV4aBs9Oj5JBOhtllNj3dEInHvz
         4iNr+toEZDvdlrY2ZOJFktoY68KFyLMOao9kTL2GmmLoFi0gY+EK016g0zuzLTO12RIy
         +YxMppk6qNkcZVvmSlrxvSUA5vU5etkNmtt1ZkA4lkbN2wC2Idf3B5WaUpTE5TgZqQxP
         puQx5IPaOC6wfbKtdbb5MwpoCk/5AlnnFYxgAKItIXNe6fw3Swmf5mGfAxjxHOX/QByP
         Fiwczy9SEP7xGSpI9KaL8orSMWtLSvwt/O2keUTN+NM6kD0bQ9nvi4DsTgScQC34WV+D
         zLpA==
X-Gm-Message-State: AOJu0Yw8RldNLeopG6ONy5TMZ8Ic2SvEpozTueiZAyVs6z1QBGsxxbJO
	5ky/RJ0A1oS59ewjUg5YT8+WlIHoy5d+V6iba6MUoCP4vqrQ8DSreR/Z
X-Gm-Gg: ATEYQzynXKvNC2rtXVlpLlEnpRIoqDA2N2Jp+uR/XK59JMQvT1+Qep8Ny9FC0x8l1TH
	gXiuWzhRL+xJjRDCcdxuqKr3iasllAEg/jt/p0w6HUurdyX7uLaj5anB8G+2iMsWefX6Yr2FfKs
	CacsaZKupFZ438OaKLO8CY20ZOfqz6umaMBRa8+QdjReh7LGqQYdTln/SKhi+YUAYj3dpUuW91K
	a2H80/OCFi3T7IRpcxvPkrVl7vUD2nBSuiSZhIE35vh3yCVa6NNjLxO1sgdtcKOLXgYe+Q+CEnF
	ajToPYQc3pkAwPjRIzXQ8/do+deaGDkG5WCJ8lCsj9CUmP3dM4nKKIGHAOBf014j89/Kta/7JeC
	ni8BtggAnYgeWpoLIHm8yjC3kBKupoXzUlo3n4kWLFdTH9eHoc9OR3zgeZq9qCu9ykl4UIsLng0
	2wid8+NspjcqbiBluAcdkNoBPoTVTNLdMj1dqYXRgSikSMY1Q=
X-Received: by 2002:a05:6870:a919:b0:3ff:4ab4:774c with SMTP id 586e51a60fabf-416e4448983mr2367273fac.43.1772839394133;
        Fri, 06 Mar 2026 15:23:14 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e65b1c82sm2572344fac.5.2026.03.06.15.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 15:23:13 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 01/19] wifi: mt76: mt7925: pass mlink to sta_amsdu_tlv()
Date: Fri,  6 Mar 2026 17:22:20 -0600
Message-ID: <20260306232238.2039675-2-sean.wang@kernel.org>
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
X-Rspamd-Queue-Id: F3F2B228A64
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32666-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.356];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mediatek.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Sean Wang <sean.wang@mediatek.com>

Drop the mt792x_sta_to_link() lookup in mt7925_mcu_sta_amsdu_tlv() and
pass mlink from the caller instead. The link context is already known
so the lookup is redundant.

This makes link ownership explicit and keeps the helper lookup-free.

No functional change intended.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index abcdd0e0b3b5..fa5f79004a6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1726,10 +1726,9 @@ mt7925_mcu_sta_vht_tlv(struct sk_buff *skb, struct ieee80211_link_sta *link_sta)
 static void
 mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 			 struct ieee80211_vif *vif,
-			 struct ieee80211_link_sta *link_sta)
+			 struct ieee80211_link_sta *link_sta,
+			 struct mt792x_link_sta *mlink)
 {
-	struct mt792x_sta *msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-	struct mt792x_link_sta *mlink;
 	struct sta_rec_amsdu *amsdu;
 	struct tlv *tlv;
 
@@ -1745,7 +1744,6 @@ mt7925_mcu_sta_amsdu_tlv(struct sk_buff *skb,
 	amsdu->max_amsdu_num = 8;
 	amsdu->amsdu_en = true;
 
-	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
 	mlink->wcid.amsdu = true;
 
 	switch (link_sta->agg.max_amsdu_len) {
@@ -1966,6 +1964,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct mt792x_bss_conf *mconf;
+	struct mt792x_link_sta *mlink;
 	struct sk_buff *skb;
 	int conn_state;
 
@@ -1980,6 +1979,8 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 				    CONN_STATE_DISCONNECT;
 
 	if (info->enable && info->link_sta) {
+		mlink = container_of(info->wcid, struct mt792x_link_sta, wcid);
+
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      conn_state, info->newly);
@@ -1987,7 +1988,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_vht_tlv(skb, info->link_sta);
 		mt76_connac_mcu_sta_uapsd(skb, info->vif, info->link_sta->sta);
-		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta);
+		mt7925_mcu_sta_amsdu_tlv(skb, info->vif, info->link_sta, mlink);
 		mt7925_mcu_sta_he_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_he_6g_tlv(skb, info->link_sta);
 		mt7925_mcu_sta_eht_tlv(skb, info->link_sta);
-- 
2.43.0


