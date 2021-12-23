Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9DA47E2F3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348138AbhLWMI1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:27 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39604 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348135AbhLWMI0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537A461E2E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF7AC36AEA;
        Thu, 23 Dec 2021 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261305;
        bh=4ngCAseo6uiwrbxQaqb2yl6PTlLCQTi0Jkx2sjnFtfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H0yJWwhjk5QSlT2EKEJ+lMewR7U48M+4N1MFNrZdssCujvdPDcfolPev38OfeagLt
         oYY8KyGkyId5LCkRWAAX0VTFgRJlkbeHb1go91F/cNjBbg/mAaf4gjG2nRNmuFFH2B
         BjqYgvd1hBWv3WIF7GOgbTxzeqgvUHbiZP0KRd4KTEgrM0dWPMwxBahjGWkZBcWeAQ
         tr6nPxGno5MMHrg7ycZXqm5DJsa9+6iSc00aTHuXKs6vNPLLWwl0hd2boMsEaNnOUD
         iVCdh6ngk6DuQNViipnUaI857xRGmKsi/nYTyQeSE2RgLLkGm3gRUpJm7rbrGZbykZ
         xnjXCO1la6h7A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 15/15] mt76: connac: introduce is_connac_v2 utility routine
Date:   Thu, 23 Dec 2021 13:07:43 +0100
Message-Id: <df4d462f1ef4cfc1ae4f6482051a28a10c78262b.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce is_connac_v2 inline utility routine to check if the device is
generation v2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  5 +++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++------
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 8701f04a28e3..bbfc574f999a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -115,6 +115,11 @@ static inline bool is_mt7916(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7906;
 }
 
+static inline bool is_connac_v2(struct mt76_dev *dev)
+{
+	return is_mt7921(dev) || is_mt7915(dev) || is_mt7916(dev);
+}
+
 static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
 {
 	static const u8 width_to_bw[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 33ea01486035..f5ddcbf97bf6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -553,8 +553,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 		generic->muar_idx = mvif->omac_idx;
 		generic->qos = sta->wme;
 	} else {
-		if ((is_mt7921(dev) || is_mt7915(dev)) &&
-		    vif->type == NL80211_IFTYPE_STATION)
+		if (is_connac_v2(dev) && vif->type == NL80211_IFTYPE_STATION)
 			memcpy(generic->peer_addr, vif->bss_conf.bssid,
 			       ETH_ALEN);
 		else
@@ -571,7 +570,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 	rx->rca2 = 1;
 	rx->rv = 1;
 
-	if (is_mt7921(dev) || is_mt7915(dev))
+	if (is_connac_v2(dev))
 		return;
 
 	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SPE, sizeof(*spe),
@@ -937,7 +936,7 @@ void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 
 	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
 
-	if (!is_mt7921(dev) && !is_mt7915(dev) && sta->ht_cap.ht_supported) {
+	if (!is_connac_v2(dev) && sta->ht_cap.ht_supported) {
 		/* sgi */
 		u32 msk = MT_WTBL_W5_SHORT_GI_20 | MT_WTBL_W5_SHORT_GI_40 |
 			  MT_WTBL_W5_SHORT_GI_80 | MT_WTBL_W5_SHORT_GI_160;
@@ -1039,7 +1038,7 @@ void mt76_connac_mcu_wtbl_ba_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		ba->rst_ba_sb = 1;
 	}
 
-	if (is_mt7921(dev) || is_mt7915(dev)) {
+	if (is_connac_v2(dev)) {
 		ba->ba_winsize = enable ? cpu_to_le16(params->buf_size) : 0;
 		return;
 	}
@@ -1218,7 +1217,7 @@ u8 mt76_connac_get_phy_mode(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	struct ieee80211_sta_ht_cap *ht_cap;
 	u8 mode = 0;
 
-	if (!is_mt7921(dev) && !is_mt7915(dev))
+	if (!is_connac_v2(dev))
 		return 0x38;
 
 	if (sta) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 2c41d81c230e..c4d02300c7c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1464,7 +1464,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, struct mt76_wcid *wcid,
 {
 	*wlan_idx_hi = 0;
 
-	if (is_mt7921(dev) || is_mt7915(dev) || is_mt7916(dev)) {
+	if (is_connac_v2(dev)) {
 		*wlan_idx_lo = wcid ? to_wcid_lo(wcid->idx) : 0;
 		*wlan_idx_hi = wcid ? to_wcid_hi(wcid->idx) : 0;
 	} else {
-- 
2.33.1

