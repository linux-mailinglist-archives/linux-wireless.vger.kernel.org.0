Return-Path: <linux-wireless+bounces-19453-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8AA45375
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 03:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AC818969A6
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B70221C9F7;
	Wed, 26 Feb 2025 02:56:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FC2AE7F;
	Wed, 26 Feb 2025 02:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538614; cv=none; b=QP3LzDT0UrQ9OURjC0gGe8DneFJv9K6XbzmEqSiF1kIRormdx3JmYl6X6KXiwo4Pmtw/gW9bTduD3FJqG1Rh/GllU6GaDLdSDqw6RrFa7lwKbvppfpejYAQ1DUzQ6brq+CK199xAC5sJbDMHiF6XRi446kNTGa3+KTA26qGIvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538614; c=relaxed/simple;
	bh=dxWFre1PqnGEfm8+97WeMgiXHFjOi4wavGCeSR/d7Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sCFKhIY8AzzNFATmVbERtOccFZpsla6bGRzzLDz7VyOUaFzGUHSF1PUPi9mUNJeBA9Bqr9RV0QkctTul/ylYFgzudYwbmrYJevQ5l9C+6niksTGKKAiony+57bpsStAlGc7GSNoxetEh7BHOLgrpQoWqZMev3zyNsRjXU+0ephw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2bc56e74e75so3302896fac.3;
        Tue, 25 Feb 2025 18:56:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740538612; x=1741143412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFB2FQZDy728LR2oVXqYPx5IKjU9F4S0qm3mUOW2x/Y=;
        b=ws2+MPO46+KqLCwYnJ3zNVsIvxSaDXOk1BQB4svNqqn6YfP4EJhpd+Gv+V6hvnhc6J
         udK+J3r5r/wixAF3QIFN1IdeDWkaPVWmhr85+QCMQKcKenWA3aZMsq1LBMnMBaAU6mGy
         eH7ETVnBODKMe0NvIGZJ3Y+/aY3O7Rb8IQ57YyBu4a1SXeUqaLUv4LanJB0FSmc5gLoF
         8sqF9/pgxbxZSal1tZRTAf/rfaTCRkMYP0DyrlFGTs/ndepOKhqdNYPLqBQw93XiAV+0
         wLXr3fiEt19NT1WON8StYl3HhDibrAc8tPZsdXeoND4JkTSmQhdQBR6cjzT9LAM2mvNK
         TSSw==
X-Forwarded-Encrypted: i=1; AJvYcCUsLxkfRbwLoxSioOn1GGAh8EA2ey+AAxbmds6gNPgcYWeSlVAOU8lMSUi1UPbMr+eLI96hFXmV+Du2Qi5CKA==@vger.kernel.org, AJvYcCWH4ZEN0MMNq2av0lUtAHV3Hx+Xdm4z33HgBtsy/8x/VM8sbWZjtEPItcda/I3+zR9hohh1nWI6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx64XHTMPfS59Ldd2V/Tqf7UEi+PEgOZ2UMDlI3yi9ycJPiIKy
	STykIhf3/rPsH+FPuByS0ltLthVEH17UtgcyAFM6PFYlWsYDmcHY
X-Gm-Gg: ASbGnctZJnulNgYtzBta5KxWUhv4UUSu5JlauBrA1WCtKJ1wjib87objofmyZD9fRby
	QOyRAbpCan4A9OmsGFpTMIkv7vlsfNrl8vDQY+sPOYiZoid58g+tiga4+bKZtrG9Gv3VdU9o+EA
	jaXm0u/F/qtgFUud2/dRulWSfTjiQGGUVoMBtF0oAhz59zsAaJFGu/rw3o6Oiixh+aAYjHY+lNI
	SeJr0T3GayEwdkH9XKec+yc/L/F26o3WbMeIaEdH1mLFTjUxQ1XxlJOV/n3pVd6AtzYJyz76Zvc
	ZpT1bpIJ5FXWhcJYWlIXqU1SfVXaic/Q+2JYAstUUoU=
X-Google-Smtp-Source: AGHT+IHmwTTDvrBamsH9SHOSAyCie3DX9via90/cp21qptTv4gjlI8FuHuK5o3aDlvrSKUjqZLEcWw==
X-Received: by 2002:a05:6871:eb18:b0:29f:df6d:999b with SMTP id 586e51a60fabf-2c10f533092mr3549074fac.39.1740538611881;
        Tue, 25 Feb 2025 18:56:51 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f0135sm676360fac.27.2025.02.25.18.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 18:56:50 -0800 (PST)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	Caleb Jorden <cjorden@gmail.com>
Subject: [PATCH v4 1/6] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"
Date: Tue, 25 Feb 2025 18:56:42 -0800
Message-Id: <20250226025647.102904-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

For MLO, mac80211 will send the BA action for each link to
the driver, so the driver does not need to handle it itself.
Therefore, revert this patch.

Fixes: e38a82d25b08 ("wifi: mt76: connac: Extend mt76_connac_mcu_uni_add_dev for MLO")
Cc: stable@vger.kernel.org
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Tested-by: Caleb Jorden <cjorden@gmail.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2:
  1) generate the patch based on the latest mt76 tree
  2) update the commit message
v3:
  1) fixed the merge conflict
v4:
  1) added tested-by tag
---
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 10 ++--
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 50 ++++---------------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  2 -
 3 files changed, 15 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 98daf80ac131..8dba17c8697c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1289,22 +1289,22 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->deflink.wcid, tid, ssn,
 				   params->buf_size);
-		mt7925_mcu_uni_rx_ba(dev, vif, params, true);
+		mt7925_mcu_uni_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->deflink.wcid, tid);
-		mt7925_mcu_uni_rx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7925_mcu_uni_tx_ba(dev, vif, params, true);
+		mt7925_mcu_uni_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->deflink.wcid.ampdu_state);
@@ -1313,7 +1313,7 @@ mt7925_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->deflink.wcid.ampdu_state);
-		mt7925_mcu_uni_tx_ba(dev, vif, params, false);
+		mt7925_mcu_uni_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 15815ad84713..4c133200c70b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -607,60 +607,30 @@ mt7925_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif_link *mvif,
 
 /** starec & wtbl **/
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_link_sta *mlink;
-	struct mt792x_bss_conf *mconf;
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct mt76_wcid *wcid;
-	u8 link_id, ret;
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(msta, link_id);
-		wcid = &mlink->wcid;
-
-		if (enable && !params->amsdu)
-			mlink->wcid.amsdu = false;
+	struct mt792x_vif *mvif = msta->vif;
+	struct mt76_wcid *wcid = &mvif->sta.deflink.wcid;
 
-		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
-					enable, true);
-		if (ret < 0)
-			break;
-	}
+	if (enable && !params->amsdu)
+		msta->deflink.wcid.amsdu = false;
 
-	return ret;
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, wcid,
+				 params, enable, true);
 }
 
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
 	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
-	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt792x_link_sta *mlink;
-	struct mt792x_bss_conf *mconf;
-	unsigned long usable_links = ieee80211_vif_usable_links(vif);
-	struct mt76_wcid *wcid;
-	u8 link_id, ret;
-
-	for_each_set_bit(link_id, &usable_links, IEEE80211_MLD_MAX_NUM_LINKS) {
-		mconf = mt792x_vif_to_link(mvif, link_id);
-		mlink = mt792x_sta_to_link(msta, link_id);
-		wcid = &mlink->wcid;
-
-		ret = mt7925_mcu_sta_ba(&dev->mt76, &mconf->mt76, wcid, params,
-					enable, false);
-		if (ret < 0)
-			break;
-	}
+	struct mt792x_vif *mvif = msta->vif;
+	struct mt76_wcid *wcid = &mvif->sta.deflink.wcid;
 
-	return ret;
+	return mt7925_mcu_sta_ba(&dev->mt76, &mvif->bss_conf.mt76, wcid,
+				 params, enable, false);
 }
 
 static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 8707b5d04743..fd5f9d4ea4a7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -263,11 +263,9 @@ int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable);
 int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
-			 struct ieee80211_vif *vif,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable);
 void mt7925_scan_work(struct work_struct *work);
-- 
2.25.1


