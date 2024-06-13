Return-Path: <linux-wireless+bounces-8929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839390624D
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A803283BBF
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 03:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2312E1CD;
	Thu, 13 Jun 2024 03:03:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F07A12D76B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718247810; cv=none; b=qKb72iDEfOkTBxywl/QdYx812x5d8BQy/Xpm+oU1YZATkfm8txjUxd7obgUzzXyCAXWIqtN9QssRedvpDWfoGixr5uEIhjvsKfuLWKTUhZPfdgeNBTZmii5CTMNJ+rJa/IVoHCQv7Zm6igZl/PElB4tBkucO1pGs4vuxfx8LY94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718247810; c=relaxed/simple;
	bh=yiAvEprllkOOJ3Cs5mUeMCJbHzQ1KX7fOCz6K92XQx8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GS7/Wif//LnDW0MOqVtDpDRTY4vLmSYwLmBwBFkgjNhlvZEcVp1dmE5V5TxqkGpNQJLLmzU52l6+i3oMHHiLML+WDc1iSspvReJuuNEFtXxfzrEjtCCn7/wZUVr+HbCpcSjTMSARTbmcYDsDN0cLXZDWP4E1BxDz0Jfdv0GExy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-254976d3327so77684fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 20:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718247808; x=1718852608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5Ixihb5+/Ac4FqRSaORRJ9EOehUjft02rbomkCQY7Y=;
        b=iAB//joWgR+2Wgx16BEWZvkxKBi4pz9+7viH+EulUCP5H7s1WyPNDRs7lZQA+WdGZN
         PyvVP7WWqe6jogxTjn7bfmK5Pv3lwy8J+goOwH5j8UYk7DB29HuWUq8pyUv1wWhY+MVX
         QtYIXo6pGzjceuvqROHBu2M9SqDsn4ziDazWcE/sMBP3UaNcvNG2cFA/trxEfpd2a4J3
         fbkHo7KmmrxIZfZDAoeIYy6XwuWdTj/xG9WMgVmvOWdJRGX7RH4iJbYPL61v/iIhHq6b
         5jtY4LOzS5tgtfjjgjYcSracaYUJN6xRIgyvQwUZc1EXtTnlFc0Dftxjx/1aPUlwv/E/
         Ptig==
X-Forwarded-Encrypted: i=1; AJvYcCWhaTRHao08meOoCL2qaxg/prbbiTxov4IG6p5DuLz3Csd6QNli7veP6WS7vI3Kl0kWqrtrpXBvJ5uhnkv7I7l2EkQd4BjKEKVvH5K5S+E=
X-Gm-Message-State: AOJu0Ywb1WtTYfxhaKB+BMc/JBr/IieQgDnwEfGoElLoyAg+vi73fEOG
	bQ2FC11OubSBv1JNSCiPakroqjltgCIGz+kjWirNgRjEh1mc6Ua8
X-Google-Smtp-Source: AGHT+IGDTHOgtVT/95Hk2G2qO7v3gsdpwBALKEJ1QGY3fm1CGLY8vR3hjc+0x0gz/D/7VX5N0Zit7A==
X-Received: by 2002:a4a:d196:0:b0:5bd:87a0:66d with SMTP id 006d021491bc7-5bd87a01b93mr285708eaf.1.1718247807616;
        Wed, 12 Jun 2024 20:03:27 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5bd629263c5sm67685eaf.46.2024.06.12.20.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:03:25 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 19/47] wifi: mt76: mt7925: extend mt7925_mcu_[abort, set]_roc for per-link BSS
Date: Wed, 12 Jun 2024 20:02:13 -0700
Message-Id: <20240613030241.5771-20-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613030241.5771-1-sean.wang@kernel.org>
References: <20240613030241.5771-1-sean.wang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

The channel context has to be bound with the per-link BSS, thus,
we extend mt7925_mcu_[abort, set]_roc to work with the per-link BSS
configuration.

The patch we created is a prerequisite to enable the MLO function in the
driver. It is purely a refactoring patch so the functionality should
remain unchanged.

Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 23 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  8 +++----
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  4 ++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index aeed2c777a20..bba17e51a023 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -387,7 +387,7 @@ static void mt7925_roc_iter(void *priv, u8 *mac,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = priv;
 
-	mt7925_mcu_abort_roc(phy, mvif, phy->roc_token_id);
+	mt7925_mcu_abort_roc(phy, &mvif->bss_conf, phy->roc_token_id);
 }
 
 void mt7925_roc_work(struct work_struct *work)
@@ -408,7 +408,8 @@ void mt7925_roc_work(struct work_struct *work)
 	ieee80211_remain_on_channel_expired(phy->mt76->hw);
 }
 
-static int mt7925_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
+static int mt7925_abort_roc(struct mt792x_phy *phy,
+			    struct mt792x_bss_conf *mconf)
 {
 	int err = 0;
 
@@ -417,14 +418,14 @@ static int mt7925_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif)
 
 	mt792x_mutex_acquire(phy->dev);
 	if (test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
-		err = mt7925_mcu_abort_roc(phy, vif, phy->roc_token_id);
+		err = mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
 	mt792x_mutex_release(phy->dev);
 
 	return err;
 }
 
 static int mt7925_set_roc(struct mt792x_phy *phy,
-			  struct mt792x_vif *vif,
+			  struct mt792x_bss_conf *mconf,
 			  struct ieee80211_channel *chan,
 			  int duration,
 			  enum mt7925_roc_req type)
@@ -436,7 +437,7 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
 
 	phy->roc_grant = false;
 
-	err = mt7925_mcu_set_roc(phy, vif, chan, duration, type,
+	err = mt7925_mcu_set_roc(phy, mconf, chan, duration, type,
 				 ++phy->roc_token_id);
 	if (err < 0) {
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
@@ -444,7 +445,7 @@ static int mt7925_set_roc(struct mt792x_phy *phy,
 	}
 
 	if (!wait_event_timeout(phy->roc_wait, phy->roc_grant, 4 * HZ)) {
-		mt7925_mcu_abort_roc(phy, vif, phy->roc_token_id);
+		mt7925_mcu_abort_roc(phy, mconf, phy->roc_token_id);
 		clear_bit(MT76_STATE_ROC, &phy->mt76->state);
 		err = -ETIMEDOUT;
 	}
@@ -464,7 +465,8 @@ static int mt7925_remain_on_channel(struct ieee80211_hw *hw,
 	int err;
 
 	mt792x_mutex_acquire(phy->dev);
-	err = mt7925_set_roc(phy, mvif, chan, duration, MT7925_ROC_REQ_ROC);
+	err = mt7925_set_roc(phy, &mvif->bss_conf,
+			     chan, duration, MT7925_ROC_REQ_ROC);
 	mt792x_mutex_release(phy->dev);
 
 	return err;
@@ -476,7 +478,7 @@ static int mt7925_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	struct mt792x_phy *phy = mt792x_hw_phy(hw);
 
-	return mt7925_abort_roc(phy, mvif);
+	return mt7925_abort_roc(phy, &mvif->bss_conf);
 }
 
 static int mt7925_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
@@ -1345,7 +1347,8 @@ static void mt7925_mgd_prepare_tx(struct ieee80211_hw *hw,
 		       jiffies_to_msecs(HZ);
 
 	mt792x_mutex_acquire(dev);
-	mt7925_set_roc(mvif->phy, mvif, mvif->bss_conf.mt76.ctx->def.chan, duration,
+	mt7925_set_roc(mvif->phy, &mvif->bss_conf,
+		       mvif->bss_conf.mt76.ctx->def.chan, duration,
 		       MT7925_ROC_REQ_JOIN);
 	mt792x_mutex_release(dev);
 }
@@ -1356,7 +1359,7 @@ static void mt7925_mgd_complete_tx(struct ieee80211_hw *hw,
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
-	mt7925_abort_roc(mvif->phy, mvif);
+	mt7925_abort_roc(mvif->phy, &mvif->bss_conf);
 }
 
 static void mt7925_vif_cfg_changed(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0350f0e34690..a40ad1578212 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1050,7 +1050,7 @@ int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_skb_send_msg(dev, skb, mcu_cmd, true);
 }
 
-int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7925_roc_req type, u8 token_id)
 {
@@ -1086,7 +1086,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			.tokenid = token_id,
 			.reqtype = type,
 			.maxinterval = cpu_to_le32(duration),
-			.bss_idx = vif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 			.control_channel = chan->hw_value,
 			.bw = CMD_CBW_20MHZ,
 			.bw_from_ap = CMD_CBW_20MHZ,
@@ -1117,7 +1117,7 @@ int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 				 &req, sizeof(req), false);
 }
 
-int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			 u8 token_id)
 {
 	struct mt792x_dev *dev = phy->dev;
@@ -1138,7 +1138,7 @@ int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			.tag = cpu_to_le16(UNI_ROC_ABORT),
 			.len = cpu_to_le16(sizeof(struct roc_abort_tlv)),
 			.tokenid = token_id,
-			.bss_idx = vif->bss_conf.mt76.idx,
+			.bss_idx = mconf->mt76.idx,
 			.dbdcband = 0xff, /* auto*/
 		},
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 07ea03195e4e..8ab2bb01ba73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -292,10 +292,10 @@ int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
 int mt7925_mcu_regval(struct mt792x_dev *dev, u32 regidx, u32 *val, bool set);
 int mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		       enum environment_cap env_cap);
-int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 		       struct ieee80211_channel *chan, int duration,
 		       enum mt7925_roc_req type, u8 token_id);
-int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_bss_conf *mconf,
 			 u8 token_id);
 int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq);
-- 
2.34.1


