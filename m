Return-Path: <linux-wireless+bounces-9952-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB79926A96
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 23:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1619B2550C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jul 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56E3190694;
	Wed,  3 Jul 2024 21:43:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46997194A5D
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jul 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042997; cv=none; b=QUntUhi3WHpaseYcM10XgI/0XVZlv1+5NjaFwPnpD2OQGTgSxrLPLq7MVOh0DYxUQEosDKSBdglhJJX+PdlwJfroLM2uk7aql92bP3iOtcz/gT1lYt+rEWsEg2oYHRTjpDO1dfTt5kQK4covuS9VSaG/60+FOMPVZmgJ9lRP7DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042997; c=relaxed/simple;
	bh=o3JWqIB+QFj3PR4Zo0Mi3St9FZxkV/2KV9p0sfLibg0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p0r3aXW1bH96QWz6TCX9W12rDvSqRrkL6+XipTR1ewycGJ539Nunr0F5/lOgWjeVfYd/pSjTDhf904+lew4gkWsrTHNfbvCzn9pFKp0Lj5pAHJ6jiNeggxSZ6oGns2OBvmhl0hxxe/xDOHMbQnLG0rs/hSGjCjtDHWr23k1f7CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-701fa02e5c1so84613a34.2
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jul 2024 14:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042995; x=1720647795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9X2Ept/O0sdVjyMsMVTI9tmtIsMoebdCU/+EmBDr+w=;
        b=da58I72q29kkIXWq/c0AiSC4FisasDb3yPVVyhwrfmh05bW/8DvwdehTnIH7L3juN6
         lQfdZfWlWc5j65FdG4d/Gua4KEt6zc95an7AOKpIqPPDlEUA9t5qzf5ICjFyuOaprBwb
         YKPQfRvUKMrh797Xeb5XjQtmJ+YACymZH/8ouXAtaeC0tvWWDMFCtZ+L8DuAenyH+zfr
         OpGdLxr4F7zXJqDr1wXfjP8C1Q+DXaDYfyKkL8lVT2Me14/bZRRcjgWSYEmzUWwFPFIq
         qCqTvbC/Vp2/sDEjdppHVhbBe1lQ6PpIM8dSMl6IOG7aP0VlIQ1Z84JJYXuEQeJRM0NH
         69VA==
X-Forwarded-Encrypted: i=1; AJvYcCXYLSq7cPGRGEi/f6IoKWp8bNqAPHsdV8045He7N7rKDa6O0VWPro6kEVlThn7AIL9rngSOHABWWoDYWOUW4cHmmQMg+JV2l+xDAXO1vKE=
X-Gm-Message-State: AOJu0YxLNoib5dplacXgBAm4ogvBFttPlLM2VRi/U2ZLVN1WqnyTSow/
	XQZtmFH+CZ5m4p/0/6hkpLSMLtYyaZ170UC8anaasoY+EkjgZ5Y3
X-Google-Smtp-Source: AGHT+IGGHAjakzXvQuXS7WHahMXqf59L78wQDAu9H4Irc6qqb9rGmo15ve1Zm6DDdwZ7tNsGV/Gmdg==
X-Received: by 2002:a05:6830:68cd:b0:700:d697:6ca7 with SMTP id 46e09a7af769-70207554355mr12585002a34.0.1720042995442;
        Wed, 03 Jul 2024 14:43:15 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b20953sm2111417a34.54.2024.07.03.14.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:43:13 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 12/29] wifi: mt76: mt7925: add link handling in mt7925_set_key
Date: Wed,  3 Jul 2024 14:42:17 -0700
Message-Id: <dc2b3c8b0bc52902cc4b25ce8912f4f27159caa4.1720042294.git.sean.wang@kernel.org>
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

add link handling in mt7925_set_key to support MLO-enabled
firmware.

Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 5360f8a71655..f85f7ea01f67 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -610,6 +610,9 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			  struct ieee80211_key_conf *key)
 {
 	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
+				  &mvif->sta;
 	int err;
 
 	/* The hardware does not support per-STA RX GTK, fallback
@@ -624,7 +627,20 @@ static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	mt792x_mutex_acquire(dev);
 
-	err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+	if (ieee80211_vif_is_mld(vif)) {
+		unsigned int link_id;
+		unsigned long add;
+
+		add = key->link_id != -1 ? BIT(key->link_id) : msta->valid_links;
+
+		for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
+			err = mt7925_set_link_key(hw, cmd, vif, sta, key, link_id);
+			if (err < 0)
+				break;
+		}
+	} else {
+		err = mt7925_set_link_key(hw, cmd, vif, sta, key, vif->bss_conf.link_id);
+	}
 
 	mt792x_mutex_release(dev);
 
-- 
2.25.1


