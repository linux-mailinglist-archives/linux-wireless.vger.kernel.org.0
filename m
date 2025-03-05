Return-Path: <linux-wireless+bounces-19782-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 266EFA4F21D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 01:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35662188D7F4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Mar 2025 00:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDEE802;
	Wed,  5 Mar 2025 00:08:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3AAA32;
	Wed,  5 Mar 2025 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741133339; cv=none; b=ncr6UKtV/KFLUghxqQ7Ujs1e8mv+60YBp+9yi6HR5k9Nhn4GWYtGHMqFxMKuY/QqgjGt0uY9Z/LUhGm8gVsQPDQHjyL+y9uqPVdqtdQut9uun9eUXpzptOrwhm+d0qnXsQCdIhKF7OMPLVc2Q2AaXz3l06iiBk1XLTYC/rUmkAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741133339; c=relaxed/simple;
	bh=ZJG9elMQkSWmEX5IzF4UeLk4BbCDVjkAqaI/c3MTZd4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L4Lw4UsfUhJ4/dHL1XObZrree50l9pOkgQKG96tk8Oa0+6oEhhQM2q/kn8U8UaQT5Y3FDzbhSglJfLoGie7lUaJWXZi9PK1qHM3kwhQhdjjvuCSmZnnJODkpVeJ8pGdM/9jcoQKPRjjZFcFW2Fbv1CtC6ShxXVyZbczm4GT/MSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f66bf7602eso919887b6e.3;
        Tue, 04 Mar 2025 16:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741133337; x=1741738137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qbgU2cH7rLMVRgOlRIA1RhS/ev6Ps58SctfJOQWg6L0=;
        b=Q9R0MwNFudHsahxUgIhgoLpYYYY0sR5rpjwQ547w9Jn9MkJa5euSSsUKyvynuC79G7
         hIrC0lY4xNq/e0JmUFzn0FANUS6Amu4bVvWdiwdpqHuy8RTtcR2V75SG4bzX/Pigxlzs
         tRn+O5GuAE6K7r5R6lBNq5t7F34KC9F+NjnID1dIVnqx471QCfiXBMHza/B0uoxAIl90
         mqi1uJwm3DNsxXTxzjPvUcyOZ3aBgpoqBn/bPbfv7YOa1SdOQqYNmdAr7g45paPx1HJH
         q8A6GGAyocF2blpsCzODSPQBZPod8bPxfIw/rPEWK+IofjdJ3FNIaLctMGXSy09SODHF
         DJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUVJWWs8PK9i+z0oTYB4aPsJww2xQzp/n1fh23NzbCagjfaRQNvTA/jZfJ2sLIXt5HMepFWVMzN@vger.kernel.org, AJvYcCWxIM9+k8EuL2ojf9CkpqQJItr1brv98otcfFDtElpcisH/C3zeCMlyKy0bw4ISY5Yij9qqgapXGCS5eHyuRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywyIpXMkWWhIxYGyzK1mtJoEdXTitQcQP6SW5drw4ZPQWRPM3b
	33mQzWN1FvGrTWtI23lq3RElxJZtFIGAqiIlu6+I/e3/p9jTjxMw
X-Gm-Gg: ASbGncvpgWt+lNTeYiFznf3aRXb2G68u4Hy9wVBBkw4sCW0gcSx0NbV/BCo4aQKG8/8
	AnKSk1C2/tPRCIaPknWWxnstvfhu7YNaHo4sjmWNuDkIzvybX/573/ZjYLMtYql3F4pi/oap7Km
	9TTSSZ2HYQ7qBcTChEE03UkabPtrbJlQcsC1L3oI32CYTKute5NYGXqv5tWF3YbKi740UHcnmkk
	M2AIqOtREJfdwfIZeJK7BknHCgf8TxYCL5HU/DN3QFyOPUA7lA74swhfBCOxODl0LUS5pVGfftW
	v9R9KrvQIfqSjfZjKmPNmnJcvoitlirs2QzhgBkRQwpDSK0+TZqHEed8c99rpw==
X-Google-Smtp-Source: AGHT+IF1g8YRle5yYBcIvy9QWurAvDWoewqdz0axwJqoemwv8scXo9RxJe3DHXRGLaoFj/gkINBMfg==
X-Received: by 2002:a05:6808:1889:b0:3f4:2209:c018 with SMTP id 5614622812f47-3f6831d34a4mr672670b6e.26.1741133337136;
        Tue, 04 Mar 2025 16:08:57 -0800 (PST)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f67ee8f479sm299985b6e.40.2025.03.04.16.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 16:08:55 -0800 (PST)
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
Subject: [PATCH v5 1/6] Revert "wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO"
Date: Tue,  4 Mar 2025 16:08:46 -0800
Message-Id: <20250305000851.493671-1-sean.wang@kernel.org>
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

Fixes: eb2a9a12c609 ("wifi: mt76: mt7925: Update mt7925_mcu_uni_[tx,rx]_ba for MLO")
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
v5:
  1) update the Fixes tag
  2) rebase to wireless.git
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


