Return-Path: <linux-wireless+bounces-16223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F239EC174
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C03F168F20
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 01:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63255134AC;
	Wed, 11 Dec 2024 01:20:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4414F9EC
	for <linux-wireless@vger.kernel.org>; Wed, 11 Dec 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880032; cv=none; b=G/XCTgs3/wWj5/H6dkztvGXJ1yLgtscsodYdcjqWkMa0WEs6JHz4+avpQgTa4Q6vTcx5SidQ35uK0EkXUlel7nPFqhQSKDn4RGVlHsD6MVioz4UeyLUtnkp/18+dQzpzjswzOyttVPd8X6CiZkxceRZAMK4Pkw8GHW4cvSzWBBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880032; c=relaxed/simple;
	bh=MgyreksPsqCeG9MiEK0kcGpdCeFXecM94xNCH5PbR8o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Onfm7UHVIy2SYZYxzYpr3telzryBosE1OpTi3ETh0kwflGHgK4ggyTUwdCaiivbwpa+m6RetywEys4RK3rG7cK9SOyodra+qR2n6SwN+8hHKSYXDN7bcjgA2FxZTDf7tsFP8h0ChtlM5IkLXzZiswBQfPnV9rb3Yhp/Jp7y6GOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3eb3c143727so106192b6e.1
        for <linux-wireless@vger.kernel.org>; Tue, 10 Dec 2024 17:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880030; x=1734484830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR5d/wysEF0Kf7ZmoLEbw9RGTdi/T9opkbjQB4jDM80=;
        b=XSuoL1ry8YiKhimEPKmu2MsPwV1xEhWXafWPYsmtlRgj93dY1weKXJmdqSlrwVTTCT
         YwcYCH3Uo194MjdGMcWSKL7SbeuSPs1ZViViFxQ8/qFYuUmGEVU6OGefM0g9goKdG67L
         ofvQ1RgUoPY+dV5mTPcgkl73De6LzVNE5CPpXp6F6OqQEnObuoCbLW4bN9+EFAAV3uzx
         2f5qwujifBbjEyAlfFSe/sDQEBFPyongYP154zEpdE8bn5smem4C4Rll7F5jUU4FR2bq
         5gB31mkfhQQlL9hc6trGN15HsxuZZ4EUe7EkIY83VbefMn+LCmMwy1GY4qu04jpJVtxn
         uH6w==
X-Forwarded-Encrypted: i=1; AJvYcCWei8ixmRrEfQ/q7zAtHpyuq0jl2Ds0qjKZwCm1lNaYrvkDNurks/h52Wn2GROYYWBEhXfTdzYPoLEB3IVs1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcI2TotmUY5v+XmaqcvcTBf9HTw+z42/LK/m5RacCgQlZjvM82
	69QC2jGKmWLMNcjBVBPkviEYXXegU18e4OedsqTjUDQpdJowsrfe
X-Gm-Gg: ASbGnctdDxfE3icz3b4Cr6uu/PdwOlL+ym1gKIKA5h+NxPt9TbS80xtXSVzC5NRPsif
	msJXjvR8uq8W9zhbZuFFgsoK6JPzbXGOM6en9CLV7E5GIISxA1iSmyiiwd6fJ4uwsUCmdVXSdow
	jTXsOc3qfqbGWHS4gEpdXFTSn5pAI9L7gHotss3etGmm5lCSBoBhbbcu55LFx4+QHO0QXtXtnFo
	2teDc2tk0mpMEtrXsystimjNTQpjClc6m9F5K/m4A4XZanZEhHbkbPwpf204hmneDxNznY=
X-Google-Smtp-Source: AGHT+IEOqF5pb1wUGU1VDty28sTsMA6yF3gA7xTiIBtgG0SjYjInlv2zCwobaX0GRnv9XZ04592Gfg==
X-Received: by 2002:a05:6871:58b:b0:29e:2a06:8405 with SMTP id 586e51a60fabf-2a0155a6f54mr463201fac.19.1733880029797;
        Tue, 10 Dec 2024 17:20:29 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29f93552d34sm2705701fac.24.2024.12.10.17.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:20:28 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 15/17] wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO
Date: Tue, 10 Dec 2024 17:19:24 -0800
Message-Id: <20241211011926.5002-15-sean.wang@kernel.org>
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

Update mt7925_mcu_uni_[tx,rx]_ba for MLO support in firmware.

Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the firmware supports it")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 10 ++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 50 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  2 +
 3 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 6b2b91a0475e..da7a2a798545 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1258,22 +1258,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, params, true);
+		mt7925_mcu_uni_rx_ba(dev, vif, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, params, false);
+		mt7925_mcu_uni_rx_ba(dev, vif, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, params, true);
+		mt7925_mcu_uni_tx_ba(dev, vif, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1282,7 +1282,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, params, false);
+		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9fafb7cce356..551b1827bb40 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -531,10 +531,10 @@ void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 
 static int
 mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
+		  struct mt76_wcid *wcid,
 		  struct ieee80211_ampdu_params *params,
 		  bool enable, bool tx)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -562,28 +562,60 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 /** starec & wtbl **/
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct mt76_wcid *wcid;
+	u8 link_id, ret;
 
-	if (enable && !params->amsdu)
-		msta->deflink.wcid.amsdu = false;
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mlink = mt792x_sta_to_link(msta, link_id);
+		wcid = &mlink->wcid;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
-				 enable, true);
+		if (enable && !params->amsdu)
+			mlink->wcid.amsdu = false;
+
+		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
+					enable, true);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = msta->vif;
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt792x_link_sta *mlink;
+	struct mt792x_bss_conf *mconf;
+	unsigned long usable_links = ieee80211_vif_usable_links(vif);
+	struct mt76_wcid *wcid;
+	u8 link_id, ret;
 
-	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, params,
-				 enable, false);
+	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
+		mconf = mt792x_vif_to_link(mvif, link_id);
+		mlink = mt792x_sta_to_link(msta, link_id);
+		wcid = &mlink->wcid;
+
+		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
+					enable, false);
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
 }
 
 static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index f5c02e5f5066..df3c705d1cb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -242,9 +242,11 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable);
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7925_scan_work(struct work_struct *work);
-- 
2.25.1


