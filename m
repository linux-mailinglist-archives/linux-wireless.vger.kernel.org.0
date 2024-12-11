Return-Path: <linux-wireless+bounces-16221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB629EC172
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7975188A7BB
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA1183CDA;
	Wed, 11 Dec 2024 01:20:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A8165F09
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880025; cv=none; b=GrXl2AaXhnBfDO8V28fxuLKUoceXDjCVT98m+26Gg9phqPowGRFN1cPQQ3ZqT/xA5tBNGlDF8MaSOv5fFSi3sUbpf/fHjNQsH8+Jz5ADmTfPHAU8HD/sKLa9fr3v4mmBGbmbMNiEGoh3U64apBI73L4TcYoWM2kDuPVFyM0ky3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880025; c=relaxed/simple;
	bh=Q9NuamWIHQaMMhtnyyZGanAuEP8JOay1FCovdsjIYOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mbc3CRau9qwKxFaN+TXs9ipa4VmylRm/DnqKi96lVRCNUUbaTehZq3lJZmXZ/K5ipiFZHRF1KdeOr2C2NQUNkGCc15qOSL/SWMvueKogoDyv/swz/QiRTLITBINFGIlCeGJ8vwdE/G96YTUTc4Sa+d4/rha5o2ud37aidGFAPdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e157a79c8so236886a34.2
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880023; x=1734484823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRF9ugiz33htRxpTQb5KpK3OS4duLbF4MKOYzIA9S2Y=;
        b=aGn3TaCTx+UuqJzL1c8wy0BWPxHmhLouYOqoh33uc8gqD3pn4wskbmehZ47s4CQjW4
         modc3WUcrthi3+G9QFkMwJlXvvBMnsJ7bB+ExfbqdfD2NHh4SlU69GwX+E+6bGg1d4Mh
         qrzEEe7b0tH5RhgizYHrrePf+cqVhNF6JsFRvYY1IlSH1W2N6LIiBlyeBWaDcMLBUPXo
         yw9DptNa+DVKQh3XJ3bAHTLP12kNL5KZFfsizNPFdJyOJqii9lOsGZnb/MHGFgBfrJBB
         ib2hX3BWQRoGQmjeL4q3HuiqpuZ3dZ4IHYy/+QlvfmyWlQl14evFF20Ojejm0ZzKNNg1
         ZhkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIUsBegWs/6XZc5C/Qj1hgVPrenvhgRcMPMQmLGK3I83EpA2MQonKX3rBFRpm2X8lCYk2Ku2Bmup/34oi/1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YypaXok1ZPw7ik+2QAKsyA5SvRR1WzIP67Z0zXg99Yi8tOSr4Ky
	wUmogCxScRyWsKDqB9JpKQuDXc5ziMgTTxtcBFvXiuB68LlsPs2a
X-Gm-Gg: ASbGncv07LN0+b9RsCmUBsd6ph9aFcUv5fdaNi74FbxbVUdTzc5tC872ZNELyF9A3a4
	6eG86NwTNg5ofMqzTUjVGU0rzVlLZplkL2p3aOPi+yxO/GDwg81Zl9fYHli0faOTUB3d7lL/f1a
	+z7jRbIp1vZhYSNzN48028LV4FJQqLT2qJ57PFqI3w2vRhWWZVcpXBrVZJ/gmU/kM7IE3RFvslf
	TZeTF/LHLi8x7qlcJbVo1dve9J07V4pG3MqWGgEB8v7+PbwvyZMA+cIO6H2QPTdJnMsO8I=
X-Google-Smtp-Source: AGHT+IE1TVNPZ38uP/IvTR3MzgVFIX09y+QeA5AuUwqpjwg/ND5Ay0/c4177SuRviRkvgjmcxh8OFg==
X-Received: by 2002:a05:6870:470e:b0:29e:49b3:c50e with SMTP id 586e51a60fabf-2a012c1ffe5mr694106fac.13.1733880023388;
        Tue, 10 Dec 2024 17:20:23 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:21 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 13/17] wifi: mt76: mt7925: Update secondary link PS flow
Date: Tue, 10 Dec 2024 17:19:22 -0800
Message-Id: <20241211011926.5002-13-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211011926.5002-1-sean.wang@kernel.org>
References: <20241211011926.5002-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Update the power-saving flow for secondary links.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  7 ++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 25 ++++++-------------
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  3 +++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  7 ++++--
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 615d7a370923..f2a0159be9c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1903,6 +1903,13 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 	if (changed & (BSS_CHANGED_QOS | BSS_CHANGED_BEACON_ENABLED))
 		mt7925_mcu_set_tx(dev, info);
 
+	if (changed & BSS_CHANGED_BSSID) {
+		if (ieee80211_vif_is_mld(vif) &&
+		    hweight16(mvif->valid_links) == 2)
+			/* Indicate the secondary setup done */
+			mt7925_mcu_uni_bss_bcnft(dev, info, true);
+	}
+
 	mt792x_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index a0df9a4c4b23..9fafb7cce356 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1364,7 +1364,7 @@ int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev,
 				 &ps_req, sizeof(ps_req), true);
 }
 
-static int
+int
 mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev,
 			 struct ieee80211_bss_conf *link_conf, bool enable)
 {
@@ -1925,32 +1925,21 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 {
 #define MT7925_FIF_BIT_CLR		BIT(1)
 #define MT7925_FIF_BIT_SET		BIT(0)
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	unsigned long valid = ieee80211_vif_is_mld(vif) ?
-				      mvif->valid_links : BIT(0);
-	struct ieee80211_bss_conf *bss_conf;
 	int err = 0;
-	int i;
 
 	if (enable) {
-		for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
-			bss_conf = mt792x_vif_to_bss_conf(vif, i);
-			err = mt7925_mcu_uni_bss_bcnft(dev, bss_conf, true);
-			if (err < 0)
-				return err;
-		}
+		err = mt7925_mcu_uni_bss_bcnft(dev, &vif->bss_conf, true);
+		if (err < 0)
+			return err;
 
 		return mt7925_mcu_set_rxfilter(dev, 0,
 					       MT7925_FIF_BIT_SET,
 					       MT_WF_RFCR_DROP_OTHER_BEACON);
 	}
 
-	for_each_set_bit(i, &valid, IEEE80211_MLD_MAX_NUM_LINKS) {
-		bss_conf = mt792x_vif_to_bss_conf(vif, i);
-		err = mt7925_mcu_set_bss_pm(dev, bss_conf, false);
-		if (err)
-			return err;
-	}
+	err = mt7925_mcu_set_bss_pm(dev, &vif->bss_conf, false);
+	if (err < 0)
+		return err;
 
 	return mt7925_mcu_set_rxfilter(dev, 0,
 				       MT7925_FIF_BIT_CLR,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index ac53bdc99332..31bb8ed2ec51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -643,4 +643,7 @@ int mt7925_mcu_set_chctx(struct mt76_phy *phy, struct mt76_vif *mvif,
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt7925_mcu_update_arp_filter(struct mt76_dev *dev,
 				 struct ieee80211_bss_conf *link_conf);
+int
+mt7925_mcu_uni_bss_bcnft(struct mt792x_dev *dev,
+			 struct ieee80211_bss_conf *link_conf, bool enable);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index ab12616ec2b8..2b8b9b2977f7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -241,6 +241,7 @@ static inline struct mt792x_bss_conf *
 mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
 {
 	struct ieee80211_vif *vif;
+	struct mt792x_bss_conf *bss_conf;
 
 	vif = container_of((void *)mvif, struct ieee80211_vif, drv_priv);
 
@@ -248,8 +249,10 @@ mt792x_vif_to_link(struct mt792x_vif *mvif, u8 link_id)
 	    link_id >= IEEE80211_LINK_UNSPECIFIED)
 		return &mvif->bss_conf;
 
-	return rcu_dereference_protected(mvif->link_conf[link_id],
-		lockdep_is_held(&mvif->phy->dev->mt76.mutex));
+	bss_conf = rcu_dereference_protected(mvif->link_conf[link_id],
+					     lockdep_is_held(&mvif->phy->dev->mt76.mutex));
+
+	return bss_conf ? bss_conf : &mvif->bss_conf;
 }
 
 static inline struct mt792x_link_sta *
-- 
2.25.1


