Return-Path: <linux-wireless+bounces-24907-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B561AFC3C9
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 09:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8694A11D0
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938321B905;
	Tue,  8 Jul 2025 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEDKP191"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CBC21D3E8
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 07:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751958753; cv=none; b=dzQdZN9//hxNIBuORehD4pWpW0vbhTClK1t6Caz9m/JlW8mr06dI6pAx2wDmunHcP+88Y4Cze+zPJFemlwbHjWKPdJ7AgrbBC/907+yKCo6KAWwuWd7IfN4WBPSHtCQxqi9wfC+K6orVGwH9HgxgYZtU9KjQUcu1+kmjZNFZE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751958753; c=relaxed/simple;
	bh=LeS2SICgV/5MqAA9eQYNW8wxvh5FPWeUvlj4KtSg9A0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aCw8tgGSEjMxvhjqBtD2yboqBL+Fv46YBYd6ZHDd632IfuGnuJ23xOvLJHa2czWcaa/21TuCg3GKEHg7BiE/UEIxhWqMQ77vTxv7zdqu5gbETlpEsellS2MEFmMhszNhKlWfUrXyhfdi1YFiyTciXqWrLxc1+7bAlpBMmt/Px4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEDKP191; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F25AC4CEED;
	Tue,  8 Jul 2025 07:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751958752;
	bh=LeS2SICgV/5MqAA9eQYNW8wxvh5FPWeUvlj4KtSg9A0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bEDKP191w6cYbB3YOJ+oedL0pWFUvCQJw+CJbwh95JzBZpWY11hQBE4xctGOHFMJF
	 J6NeBGWNAqNEEbkSGo3L/c2BlLUHSTPIv0tVgqgtvQgKQbbOsFOeotaUNMRxewXXoz
	 K1cH2u4l9vk9q2iiKg/l3SCj6LCbH1mgby6hJ6kOjJkVYysBL6C+DT4IwJFBSFS3S3
	 1p4rAF1syrYB5TMOj4Jn81ike3Na8P4Mm5CazPFoKpSOqxY5fStcZh/zm5Lc2E9mJ8
	 jXdKV9dEmERxMEvCDVqwsLt2lFOiUvm2AAAoT/7MIUgj5wR7nIWaVwctBSaRRK3BsP
	 xHdVT0slsytJg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 08 Jul 2025 09:12:05 +0200
Subject: [PATCH mt76 2/2] wifi: mt76: mt7996: Fix mt7996_mcu_sta_ba wcid
 configuration
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-mt7996-mlo-fixes-v2-v1-2-f2682818a8a3@kernel.org>
References: <20250708-mt7996-mlo-fixes-v2-v1-0-f2682818a8a3@kernel.org>
In-Reply-To: <20250708-mt7996-mlo-fixes-v2-v1-0-f2682818a8a3@kernel.org>
To: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>, 
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Peter Chiu <chui-hao.chiu@mediatek.com>, 
 Money Wang <Money.Wang@mediatek.com>, 
 Evelyn Tsai <evelyn.tsai@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 MeiChia Chiu <meichia.chiu@mediatek.com>, 
 Howard Hsu <howard-yh.hsu@mediatek.com>, Bo Jiao <Bo.Jiao@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Fix the wcid pointer used in mt7996_mcu_sta_ba routine to properly
support MLO scenario.

Fixes: 98686cd21624c ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |  6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c    | 12 +++++++-----
 drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h |  3 ++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 03ec3edc9a632390cb6d86d75b2e65a302a9a372..4f7db05902fb35641ee5e5d1d921a7ca437ec3dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1331,11 +1331,13 @@ mt7996_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		case IEEE80211_AMPDU_RX_START:
 			mt76_rx_aggr_start(&dev->mt76, &msta_link->wcid, tid,
 					   ssn, params->buf_size);
-			ret = mt7996_mcu_add_rx_ba(dev, params, link, true);
+			ret = mt7996_mcu_add_rx_ba(dev, params, link,
+						   msta_link, true);
 			break;
 		case IEEE80211_AMPDU_RX_STOP:
 			mt76_rx_aggr_stop(&dev->mt76, &msta_link->wcid, tid);
-			ret = mt7996_mcu_add_rx_ba(dev, params, link, false);
+			ret = mt7996_mcu_add_rx_ba(dev, params, link,
+						   msta_link, false);
 			break;
 		case IEEE80211_AMPDU_TX_OPERATIONAL:
 			mtxq->aggr = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 0374872db4777cc85eed594f7d977dd822927b6d..edfbea813bfc0e5edbe4c33e90bf4ceacb533ac1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -1152,9 +1152,8 @@ int mt7996_mcu_set_timing(struct mt7996_phy *phy, struct ieee80211_vif *vif,
 static int
 mt7996_mcu_sta_ba(struct mt7996_dev *dev, struct mt76_vif_link *mvif,
 		  struct ieee80211_ampdu_params *params,
-		  bool enable, bool tx)
+		  struct mt76_wcid *wcid, bool enable, bool tx)
 {
-	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct sta_rec_ba_uni *ba;
 	struct sk_buff *skb;
 	struct tlv *tlv;
@@ -1188,14 +1187,17 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 	if (enable && !params->amsdu)
 		msta_link->wcid.amsdu = false;
 
-	return mt7996_mcu_sta_ba(dev, &link->mt76, params, enable, true);
+	return mt7996_mcu_sta_ba(dev, &link->mt76, params, &msta_link->wcid,
+				 enable, true);
 }
 
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 struct mt7996_vif_link *link, bool enable)
+			 struct mt7996_vif_link *link,
+			 struct mt7996_sta_link *msta_link, bool enable)
 {
-	return mt7996_mcu_sta_ba(dev, &link->mt76, params, enable, false);
+	return mt7996_mcu_sta_ba(dev, &link->mt76, params, &msta_link->wcid,
+				 enable, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 1ad6bc046f7c01d43452252ed46677d42e0c8850..19e115e316df05640062ca9fa56d4bcc8d41956e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -608,7 +608,8 @@ int mt7996_mcu_add_tx_ba(struct mt7996_dev *dev,
 			 struct mt7996_sta_link *msta_link, bool enable);
 int mt7996_mcu_add_rx_ba(struct mt7996_dev *dev,
 			 struct ieee80211_ampdu_params *params,
-			 struct mt7996_vif_link *link, bool enable);
+			 struct mt7996_vif_link *link,
+			 struct mt7996_sta_link *msta_link, bool enable);
 int mt7996_mcu_update_bss_color(struct mt7996_dev *dev,
 				struct mt76_vif_link *mlink,
 				struct cfg80211_he_bss_color *he_bss_color);

-- 
2.50.0


