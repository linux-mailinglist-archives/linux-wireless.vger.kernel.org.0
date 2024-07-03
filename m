Return-Path: <linux-wireless+bounces-9948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61528926A92
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848291C215BF
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F503184116;
	Wed,  3 Jul 2024 21:43:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823411946B0
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042990; cv=none; b=Ue0SSanN9ZeOewAX2xhlB18Kz9YWz+ZuHr0BtGqqzqf1NWpZTXd1Uj+zta2tP8bvuJ+LAYkQyLyNLmekmesxODpH+xwSrr9cJ7YB7VA3FRb/gBaHMDJ1VsfaNG8i52OHea+g0i5Mo5PL5cH6zBKSvniwGhZ3jwybvgtH212X+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042990; c=relaxed/simple;
	bh=THKNZI4jrpFWwBZoTQY9CQERKD/jg4vCX/LEXCm33jI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SbVy+0oW/FCfUmvi0MTAR8PDJLp7k8Cn8MafNgGT94yzT5Ywx9L9l9SQ12p5W1ytgKJQejWG/DQWCnavbVTppNJM1ugbt1BrpyquzV3u6Wq4x3pafJlIzCTO9krQb6ELpjgN8FdWCus/f3+9juECPyVSjeqqfhrWy1eV+227sa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-700d29f33a0so89045a34.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042987; x=1720647787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9TOWM2avYXo/xP6pN6yETRbPs1gdrDHvtIHr+R1SQlw=;
        b=sUaAUIbaopWpSzGz4pRfuvmvLdl6d4NFWUz2O9v5ZBVfgZGU/N95gi5CROsCgTPDlG
         JYsZrVmsdKR/1NRoCUMQ7PRJsJEgzuUfNQEI0g50b3iM3ykPuPWdTCzbtzZ8tjI9qgEX
         fsZaXOeKFvEEGtnovha5r3Ii6R2yW6swkQfopJ2ljUOdtO9flUpCWKnp+LhiSHuMJmif
         zygqr+YCN0YxakmBDlGtFkGcERBowP1lIrgVr/uIwQG1olMuuFrkhvFzF99CYmqSoNc8
         lOJO5adPvWCRa/p4PXB9+mdEiDJf0Dir4paU/2AEFlH+ap0IuGZSKs9676uZO5qyp3Tm
         9xew==
X-Forwarded-Encrypted: i=1; AJvYcCXoMnz70zExC4H+MBdQM3PhYelBaicsYlBuC01PAsQyfIzuEgkSKC6ld3rgFIcXRM00cRWDG/nzhfmmWeN9m5/qdanylArpJFwHejPGwS4=
X-Gm-Message-State: AOJu0Yx4E47EJCjeh5mYeQie6PB0pmzLJ+GH/VK1OkVGYTd2fFiiQuKW
	uqJNoT6Gu61uaXfEGlZ+yOGL29roAPCltNAyoxYkqRggr64WZ3I3
X-Google-Smtp-Source: AGHT+IHB+8D92ICxDGrelbsO6+AY0q19flJoPxzsqBAYCuqHkQXeoHpWCeXCgy/9CJA3vEU2E60bXg==
X-Received: by 2002:a05:6830:2007:b0:700:d1c1:e12d with SMTP id 46e09a7af769-7020775bef2mr12607744a34.3.1720042987444;
        Wed, 03 Jul 2024 14:43:07 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:05 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 08/29] wifi: mt76: mt7925: add mt7925_change_sta_links
Date: Wed,  3 Jul 2024 14:42:13 -0700
Message-Id: <8003cfbdec2c1357fb9d7ac8ba93af5fd0b4ec5d.1720042294.git.sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1720042294.git.sean.wang@kernel.org>
References: <cover.1720042294.git.sean.wang@kernel.org>
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
index c9119a222427..0e554b21692e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -811,16 +811,79 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 					link_conf, link_sta, false);
 	}
 
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


