Return-Path: <linux-wireless+bounces-9942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A72F926A8C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08DD328325A
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EC7191F91;
	Wed,  3 Jul 2024 21:42:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AF01940A1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042973; cv=none; b=hIXmLkWYEssuQmr95MbrlIaX0FFAUCbYqaTkTGu2WKVCI79SnTA5PU6Oi97xn3hgZxBbpLknKD0A5TzasZ3tcNhiOoo+sJQLrdZMYs/T2IiaoOhqyLf4in/ZFRr6Yn1mtxK8ZD4BFVfLCKoz3YeTYQ3ZGshAxTwAmPq04jPkpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042973; c=relaxed/simple;
	bh=BQOKox6gvCJPMPBKCw8xwpXd8RFIe6cdNw0D1f+XhFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdD+RklLJ9fVlj7vXkKjEQx0i/R0BHGOQ1+RVSvQI2KLLKz371cZdI1eYCRHL3Fakt0w+X3qFgZKfFOOII/VWHTww6LwamfC6lcswGobiDgomO74TaZXys3jbuYSn8p6bZOsBZZcLnj5wXoTc0AXJ2ZGetuVbpN8HO+fWMT+NnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-700caf4cc3bso113609a34.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042971; x=1720647771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4D8GOqEYIjIhd4nO67HazbxOlKo7VMKVeEfzgJOHMfM=;
        b=p21t8oiWEeL4Q8wp1vrZi8e8ozFqeLoHjib4MwBn4OMlj8IY4f0SZ0PY0dbL4dRa/W
         wAESa/l+WNOrariHubQSmozZfKjBqr1lOteWniH/AEMm7try58nwL1d0uU0EX2Td9VRg
         efPBzQcIvJ/DLVhpWvS6N17AdcEtFqdWNIJBBSzJawnwek6WxDvMS+em0108SnT3r54o
         uU8YebFb/gI1f/VfpBjBReBW/GwR5TcOV4aL+MLQIbhU/7X3Llj4TrKiJFR0dGAinkpg
         RRF+KBo4dgeAF1JscNnFiDJtTPWYmGxia8o/l4Q+UQp5MVk5XMHktCtnm78sE6bKIpa5
         9jwg==
X-Forwarded-Encrypted: i=1; AJvYcCVbZCHgZpfS5fnmH8pO8qoPgEqCpnwksAekpb/usV7CYv2GVJXiwtDBos5SdmRyLCfxGGl7L97Xgx7lFIUDK/aw+7CY7H+30t5uJc6wXjs=
X-Gm-Message-State: AOJu0YzxnjoPc9tfA1RcSOrXYQnQY8mf9jX98eTg615Y+81Vu/JRlFHq
	RFnOSBFuimy/WV9tV8SvfBYgAv3Ve127fZedRCi90sD7JwoYFUWpfHHL1p7U
X-Google-Smtp-Source: AGHT+IFEM8AtOC4VbrN1MHEZJ0NHJbO6KnrzFOQm439w+AkKKPB6yfmZQC83oKo5lnuyh8d2s8jkcQ==
X-Received: by 2002:a05:6830:1bfb:b0:700:d064:36d3 with SMTP id 46e09a7af769-70207742e4bmr13770945a34.2.1720042970791;
        Wed, 03 Jul 2024 14:42:50 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:42:48 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 02/29] wifi: mt76: mt7925: update mt7925_mac_link_sta_[add, remove] for MLO
Date: Wed,  3 Jul 2024 14:42:07 -0700
Message-Id: <0fce480ad67237ce4f65138fe5e45f8090ae08f2.1720042294.git.sean.wang@kernel.org>
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

[add, remove] the per-link STA from the corresponding to per-link BSS with
the same link id. The change remains compatible with the non-MLO mode.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8b10b63bc98d..1c8a44789e51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -728,12 +728,13 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct ieee80211_bss_conf *link_conf;
+	u8 link_id = link_sta->link_id;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 	int ret, idx;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	mlink = mt792x_sta_to_link(msta, link_id);
 
 	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT792x_WTBL_STA - 1);
 	if (idx < 0)
@@ -753,12 +754,16 @@ static int mt7925_mac_link_sta_add(struct mt76_dev *mdev,
 	mt7925_mac_wtbl_update(dev, idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
 	/* should update bss info before STA add */
-	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls)
-		mt7925_mcu_add_bss_info(&dev->phy, mvif->bss_conf.mt76.ctx,
+	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
+		struct mt792x_bss_conf *mconf;
+
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx,
 					link_conf, link_sta, false);
+	}
 
 	ret = mt7925_mcu_sta_update(dev, link_sta, vif, true,
 				    MT76_STA_INFO_STATE_NONE);
@@ -830,11 +835,12 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct ieee80211_bss_conf *link_conf;
+	u8 link_id = link_sta->link_id;
 	struct mt792x_link_sta *mlink;
 	struct mt792x_sta *msta;
 
 	msta = (struct mt792x_sta *)link_sta->sta->drv_priv;
-	mlink = mt792x_sta_to_link(msta, link_sta->link_id);
+	mlink = mt792x_sta_to_link(msta, link_id);
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &mlink->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
@@ -844,12 +850,14 @@ static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 	mt7925_mac_wtbl_update(dev, mlink->wcid.idx,
 			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
-	link_conf = mt792x_vif_to_bss_conf(vif, vif->bss_conf.link_id);
+	link_conf = mt792x_vif_to_bss_conf(vif, link_id);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !link_sta->sta->tdls) {
 		struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-		mt7925_mcu_add_bss_info(&dev->phy,
-					mvif->bss_conf.mt76.ctx, link_conf,
+		struct mt792x_bss_conf *mconf;
+
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mt7925_mcu_add_bss_info(&dev->phy, mconf->mt76.ctx, link_conf,
 					link_sta, false);
 	}
 
-- 
2.25.1


