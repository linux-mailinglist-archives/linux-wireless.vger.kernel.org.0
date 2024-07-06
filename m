Return-Path: <linux-wireless+bounces-10046-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42A9291EB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4096D1C21565
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC621CAB3;
	Sat,  6 Jul 2024 08:29:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F944C3D0
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254550; cv=none; b=i1prwWetxPfE6RNBK5tw/8QRo4ZzSC1JehW8MZGjUASayVqBHa3TVrLrKF+yPvqve4c4SQ7d9IFnn2iTMWJE24RMZKMyAd85V5WnBbHP053bgot7NevV6MjgCivVSB92RAu9GuPMHA7/HoZ0sVbcxyUSfuh8871lWFPcP7I25Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254550; c=relaxed/simple;
	bh=aije1VGNsaJTFW/oAOiH7oKtz7rydn3N/BjlbK37BXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ytpsim2K1QZMGnnA73YuSbeOJuSLtEn2POevH2xByYbQWcPKBSTOLhwea8F87RAoT2VCW5DeB7vLQC2vNM7JrktEvy1rgV6KTUdsR3MG0BAEJKlSbhR7MP42y6PTkyqxIfkB5JK8rIx0Ga3Sc0qxkX8bXqffCQH1aB37OmCsZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5c66c4c30bfso4138eaf.2
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254548; x=1720859348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SdoXLXIu+HvSjVwv2ngUt5gbyZnRN7Gqj36N7mgsJo=;
        b=FQ+j6fza54Nfer52wGWTLZv5Elr1MEHarC88sAuyiQBRKm2NDih3MO/I6u/5tL8UGn
         fmNmfsZIj5VYVrJvGg6fjwduvC8SXSmZSZdjL6d5cieSIc1H8ERguxBmTVYkyzu6W/ef
         33v67/wkCFW5ciDMScg1c2OQ6Rs3GsfBDAzIuM6d00QO1hnnIQHG5WOvsfV2JKGYj6w6
         YEw0h+X2BS8sJeKXANIYSDnp+pHTuyQayOZF2PEh3qMk2r7WBk2DrXLHQc5b+QJ1XT01
         QA2x0K4bMseCUMNyMFaVSj+AaxD666Cohg+7VYmeTr2J+8j5f4YcQ0SGwm1lOeFcdZ+2
         wwJw==
X-Forwarded-Encrypted: i=1; AJvYcCWWNeqLe6AD/yK7vFpD3563moqwA89+YxrGFjugBbEW0kn2TO3gyH2Ij1FTt782Gjdc1cXAf1Ybt32bnH250QCWSw1X5N9Ahwo4XxoZLTM=
X-Gm-Message-State: AOJu0YzfAWRb8FPZqIClVsleoT+7Onxoxi7K624J/J3YZJQpplXOsohx
	9gSZ7MRjhrgwpXUaSyvTx7vAdM58EAYdX6/9B/BAWk+msBPVpJvCzwdWyoly
X-Google-Smtp-Source: AGHT+IFSM1KejwThfKI59psSqbCJd8hsVG0T4rGP3gosGe/XsVKfdWxA91fA4LN2yCedSML9ivzIVA==
X-Received: by 2002:a4a:ead8:0:b0:5c6:6aae:b5f5 with SMTP id 006d021491bc7-5c66aaeb9e2mr305319eaf.0.1720254548387;
        Sat, 06 Jul 2024 01:29:08 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:29:06 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 27/37] wifi: mt76: mt7925: update mt7925_mcu_bss_mld_tlv for MLO
Date: Sat,  6 Jul 2024 01:28:07 -0700
Message-Id: <2d89b93bcfd92e7c6987aaa0a3c4637e605ac154.1720248331.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720248331.git.sean.wang@kernel.org>
References: <cover.1720248331.git.sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

update mt7925_mcu_bss_mld_tlv for the MLO-enabled firmware,
the change remains compatible with the non-MLO mode and the
older firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 22 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  5 ++++-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 38e2ac5efb6b..53228bbed2c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2393,24 +2393,29 @@ mt7925_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt792x_phy *phy,
 
 static void
 mt7925_mcu_bss_mld_tlv(struct sk_buff *skb,
-		       struct ieee80211_bss_conf *link_conf,
-		       struct ieee80211_link_sta *link_sta)
+		       struct ieee80211_bss_conf *link_conf)
 {
 	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(link_conf);
-	bool is_mld = ieee80211_vif_is_mld(link_conf->vif);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)link_conf->vif->drv_priv;
 	struct bss_mld_tlv *mld;
 	struct tlv *tlv;
+	bool is_mld;
+
+	is_mld = ieee80211_vif_is_mld(link_conf->vif) ||
+		 (hweight16(mvif->valid_links) > 1);
 
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_BSS_INFO_MLD, sizeof(*mld));
 	mld = (struct bss_mld_tlv *)tlv;
 
-	mld->link_id = link_sta ? (is_mld ? link_conf->link_id : 0) : 0xff;
-	mld->group_mld_id = is_mld ? mconf->mt76.idx : 0xff;
+	mld->link_id = is_mld ? link_conf->link_id : 0xff;
+	/* apply the index of the primary link */
+	mld->group_mld_id = is_mld ? mvif->bss_conf.mt76.idx : 0xff;
 	mld->own_mld_id = mconf->mt76.idx + 32;
 	mld->remap_idx = 0xff;
+	mld->eml_enable = !!(link_conf->vif->cfg.eml_cap &
+			     IEEE80211_EML_CAP_EMLSR_SUPP);
 
-	if (link_sta)
-		memcpy(mld->mac_addr, link_sta->addr, ETH_ALEN);
+	memcpy(mld->mac_addr, link_conf->addr, ETH_ALEN);
 }
 
 static void
@@ -2520,10 +2525,9 @@ int mt7925_mcu_add_bss_info(struct mt792x_phy *phy,
 	mt7925_mcu_bss_basic_tlv(skb, link_conf, link_sta, ctx, phy->mt76,
 				 mvif->sta.deflink.wcid.idx, enable);
 	mt7925_mcu_bss_sec_tlv(skb, link_conf);
-
 	mt7925_mcu_bss_bmc_tlv(skb, phy, ctx, link_conf);
 	mt7925_mcu_bss_qos_tlv(skb, link_conf);
-	mt7925_mcu_bss_mld_tlv(skb, link_conf, link_sta);
+	mt7925_mcu_bss_mld_tlv(skb, link_conf);
 	mt7925_mcu_bss_ifs_tlv(skb, link_conf);
 
 	if (link_conf->he_support) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 6ae5286385d9..7b0c6937f918 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -366,7 +366,10 @@ struct bss_mld_tlv {
 	u8 mac_addr[ETH_ALEN];
 	u8 remap_idx;
 	u8 link_id;
-	u8 __rsv[2];
+	u8 eml_enable;
+	u8 max_link_num;
+	u8 hybrid_mode;
+	u8 __rsv[3];
 } __packed;
 
 struct sta_rec_ba_uni {
-- 
2.25.1


