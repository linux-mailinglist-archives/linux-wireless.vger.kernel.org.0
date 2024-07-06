Return-Path: <linux-wireless+bounces-10027-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7D09291D8
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 10:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9783DB21CC3
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Jul 2024 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FBB48CE0;
	Sat,  6 Jul 2024 08:28:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BC1C69D
	for <linux-wireless@vger.kernel.org>; Sat,  6 Jul 2024 08:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720254518; cv=none; b=k4uIS0xmQJzSbLyoYMrW8cxAQD76MOILeVA9WGsWB4ZRY+fr0tI+wRPYJ+Svb3FTSPBGO3TEMLK795eR2R12OGSuYEiU1io0RNa3NmBmViPW7SIA4ffqLdlZ1As35+pqkXJn1Bum1Oh7CI/ZR0JunPQPpJxh2FjsHBJX0/htNvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720254518; c=relaxed/simple;
	bh=mPnMvD6AF7jRji3xDhpAIpUZWr5N0Os2jLLyOoWL+Xg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TG+GTPE4Z1s0pUnfyfZip4H1aRPNV23zv+53egguFaOTcdsSYU8gdLHK6jEo83Pja8iN4uRApPg3EsU/mtSXWoC4IQz+2jOmyLmNJUUSpMyHrJTNVV1iq0D4MgpuhrNwTusL9w2K8gPgG1Iv/aDtvL4e9Z50C7rmxdr1/WMN0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3d561131a3cso316286b6e.3
        for <linux-wireless@vger.kernel.org>; Sat, 06 Jul 2024 01:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720254516; x=1720859316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5dbXS4wTlPSU2CAE2pE+Qjua78xQ9zEerZ5yBNPnYA=;
        b=wzPJ9JNTch0OzA3v8UjeYQv8a0ZcEURHQdKgrQJI+Fnqbp8mXctvnVzmGe++1+WdtL
         28wggbgd73qRXPJ+A7dUVsOA8lz9R+1hWjBFKUPTBEMkeAJ4vkZ1NLcQG3zVaMv2JRBS
         GP3EgHGk4mLW5UH+pvuwyj/O8Lb9s1eGPQZ3Cw496h/1uqH5CRwWQMnWtM6nXjv2YOSS
         TUHXrVtz3AiIuTgDy+qaq6XI/oXMOGX3WBDCPsx1tWVSwCjCAKPbJoPU/ogp4JcVA1zg
         DEOQK0EEr6GIL6hpYC7dLfOMbxR2yhYPDWAf60jxLy7YzlTyb0FgAvZ18zlWnPFPXEV2
         hksQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd5Cw51sxToQTnTTQ3eYpG5elq7wdsCcPrCWssa+/9MNt682Ab6LgShcKPgLi/kwYjUM6ovV58FX2zHYk66F7BTgAUDfOqslFWArLRmtU=
X-Gm-Message-State: AOJu0Yy+rr6hFvFavktSMBMttceOu8t//yGMmdc0viHT14ciP0wE2tX2
	+Pb5cFpK6kqTLdl7rSthnHakKGmdnJfvs8jQ+N/wkkdWazHv49Rc
X-Google-Smtp-Source: AGHT+IGHxWVmEstv1MmXEbD4rINzqvMgcEmLY/LkqNO+kP/ZyG/UuExe/x6Ahvz/MsUpchRnf0C0Cw==
X-Received: by 2002:a05:6870:7251:b0:25e:14d9:da27 with SMTP id 586e51a60fabf-25e2b59dcf7mr6914926fac.0.1720254515685;
        Sat, 06 Jul 2024 01:28:35 -0700 (PDT)
Received: from sean-ThinkPad-T450s.attlocal.net ([2600:1702:5083:7610:1e13:57ab:ecc5:1fd4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25e71070ba1sm10744fac.34.2024.07.06.01.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 01:28:34 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 08/37] wifi: mt76: mt7925: add mt7925_change_sta_links
Date: Sat,  6 Jul 2024 01:27:48 -0700
Message-Id: <eeedec88f0576315791a8b1b453464173a4addbe.1720248331.git.sean.wang@kernel.org>
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

add mt7925_change_sta_links to change the valid links of a station,
supporting the MLO-enabled firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 142 +++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |   7 +
 2 files changed, 145 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index fcf7bd1a06bc..afb58a9206b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -809,16 +809,79 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
 					link_conf, link_sta, false);
 
-	ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
-				    MT76_STA_INFO_STATE_NONE);
-	if (ret)
-		return ret;
+	if (ieee80211_vif_is_mld(vif) &&
+	    link_sta == mlink->pri_link) {
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+					    MT76_STA_INFO_STATE_NONE);
+		if (ret)
+			return ret;
+	} else if (ieee80211_vif_is_mld(vif) &&
+		   link_sta != mlink->pri_link) {
+		ret = mt7925_mcu_sta_update(dev, mlink->pri_link, vif,
+					    true, MT76_STA_INFO_STATE_ASSOC);
+		if (ret)
+			return ret;
+
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+					    MT76_STA_INFO_STATE_ASSOC);
+		if (ret)
+			return ret;
+	} else {
+		ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
+					    MT76_STA_INFO_STATE_NONE);
+		if (ret)
+			return ret;
+	}
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 
 	return 0;
 }
 
+static int
+mt7925_mac_sta_add_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, unsigned long new_links)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt76_wcid *wcid;
+	unsigned int link_id;
+	int err = 0;
+
+	for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct mt792x_link_sta *mlink;
+
+		if (msta->deflink_id == IEEE80211_LINK_UNSPECIFIED) {
+			mlink = &msta->deflink;
+			msta->deflink_id = link_id;
+		} else {
+			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink), GFP_KERNEL);
+			if (!mlink) {
+				err = -ENOMEM;
+				break;
+			}
+
+			wcid = &mlink->wcid;
+			ewma_signal_init(&wcid->rssi);
+			rcu_assign_pointer(dev->mt76.wcid[wcid->idx], wcid);
+			mt76_wcid_init(wcid);
+			ewma_avg_signal_init(&mlink->avg_ack_signal);
+			memset(mlink->airtime_ac, 0,
+			       sizeof(msta->deflink.airtime_ac));
+		}
+
+		msta->valid_links |= BIT(link_id);
+		rcu_assign_pointer(msta->link[link_id], mlink);
+		mlink->sta = msta;
+		mlink->pri_link = &sta->deflink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		mt7925_mac_link_sta_add(&dev->mt76, vif, link_sta);
+	}
+
+	return err;
+}
+
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
@@ -915,6 +978,48 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 
+static int
+mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, unsigned long old_links)
+{
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_wcid *wcid;
+	unsigned int link_id;
+
+	for_each_set_bit(link_id, &old_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_link_sta *link_sta;
+		struct mt792x_link_sta *mlink;
+
+		link_sta = mt792x_sta_to_link_sta(vif, sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mlink = mt792x_sta_to_link(msta, link_id);
+		if (!mlink)
+			continue;
+
+		mt7925_mac_link_sta_remove(&dev->mt76, vif, link_sta);
+
+		wcid = &mlink->wcid;
+		rcu_assign_pointer(msta->link[link_id], NULL);
+		msta->valid_links &= ~BIT(link_id);
+		mlink->sta = NULL;
+		mlink->pri_link = NULL;
+
+		if (link_sta != mlink->pri_link) {
+			mt76_wcid_cleanup(mdev, wcid);
+			mt76_wcid_mask_clear(mdev->wcid_mask, wcid->idx);
+			mt76_wcid_mask_clear(mdev->wcid_phy_mask, wcid->idx);
+		}
+
+		if (msta->deflink_id == link_id)
+			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+	}
+
+	return 0;
+}
+
 void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
@@ -1650,6 +1755,34 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return err;
 }
 
+static int
+mt7925_change_sta_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta, u16 old_links, u16 new_links)
+{
+	unsigned long add = new_links & ~old_links;
+	unsigned long rem = old_links & ~new_links;
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	if (old_links == new_links)
+		return 0;
+
+	mt792x_mutex_acquire(dev);
+
+	err = mt7925_mac_sta_remove_links(dev, vif, sta, rem);
+	if (err < 0)
+		goto out;
+
+	err = mt7925_mac_sta_add_links(dev, vif, sta, add);
+	if (err < 0)
+		goto out;
+
+out:
+	mt792x_mutex_release(dev);
+
+	return err;
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -1709,6 +1842,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.vif_cfg_changed = mt7925_vif_cfg_changed,
 	.link_info_changed = mt7925_link_info_changed,
 	.change_vif_links = mt7925_change_vif_links,
+	.change_sta_links = mt7925_change_sta_links,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 9a7443a8a951..af9a103dc7f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -92,6 +92,10 @@ struct mt792x_link_sta {
 	unsigned long last_txs;
 
 	struct mt76_connac_sta_key_conf bip;
+
+	struct mt792x_sta *sta;
+
+	struct ieee80211_link_sta *pri_link;
 };
 
 struct mt792x_sta {
@@ -99,6 +103,9 @@ struct mt792x_sta {
 	struct mt792x_link_sta __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
 	struct mt792x_vif *vif;
+
+	u16 valid_links;
+	u8 deflink_id;
 };
 
 DECLARE_EWMA(rssi, 10, 8);
-- 
2.25.1


