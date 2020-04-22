Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489121B4982
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 18:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgDVQEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Apr 2020 12:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgDVQEn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:43 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F24C03C1AF
        for <linux-wireless@vger.kernel.org>; Wed, 22 Apr 2020 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0kx/H3L4bPfmGOSTBkYH8IypHBsw70fhlWoenjwMJbk=; b=EGUPIpil8uIgOtEUBjFFgSHMI+
        9ArtigWb59Qm+etAbdCTs6hZPhW0sG/3ZCblxKCoRMXUw/KGAE4c8z/SQmMQKaL11jab9kd2M5J/+
        3YE3za8v1etAMzsD7PUP+jz3NWyGCyu3z85KxknaHR45HiBKdJg3Lfer1rKbrJgdLJqY=;
Received: from p54ae965b.dip0.t-ipconnect.de ([84.174.150.91] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jRHrb-000558-Vf
        for linux-wireless@vger.kernel.org; Wed, 22 Apr 2020 18:04:40 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id A043B8419630; Wed, 22 Apr 2020 18:04:38 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/9] mt76: fix A-MPDU density handling
Date:   Wed, 22 Apr 2020 18:04:30 +0200
Message-Id: <20200422160437.99466-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200422160437.99466-1-nbd@nbd.name>
References: <20200422160437.99466-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware requirements for A-MPDU density are entirely on the tx side,
not the rx side. Because of that, the IE value should stay at 0 and the
minimum value should instead be enforced in WTBL/TXWI

MT7615 has no restrictions here

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 1 -
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 7 +++++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 39abedc45e4a..b6c0a6d0dfc1 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -198,7 +198,6 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 
 	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
 	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
-	ht_cap->ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
 
 	mt76_init_stream_cap(dev, sband, vht);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 39b7c5d6e6cd..73c6a3ff399c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -318,11 +318,16 @@ void mt7603_wtbl_update_cap(struct mt7603_dev *dev, struct ieee80211_sta *sta)
 {
 	struct mt7603_sta *msta = (struct mt7603_sta *)sta->drv_priv;
 	int idx = msta->wcid.idx;
+	u8 ampdu_density;
 	u32 addr;
 	u32 val;
 
 	addr = mt7603_wtbl1_addr(idx);
 
+	ampdu_density = sta->ht_cap.ampdu_density;
+	if (ampdu_density < IEEE80211_HT_MPDU_DENSITY_4)
+		ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
+
 	val = mt76_rr(dev, addr + 2 * 4);
 	val &= MT_WTBL1_W2_KEY_TYPE | MT_WTBL1_W2_ADMISSION_CONTROL;
 	val |= FIELD_PREP(MT_WTBL1_W2_AMPDU_FACTOR, sta->ht_cap.ampdu_factor) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 8b072277ea10..a5a3bcd30d6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -409,6 +409,7 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 		txwi->ack_ctl |= MT_TXWI_ACK_CTL_NSEQ;
 	if ((info->flags & IEEE80211_TX_CTL_AMPDU) && sta) {
 		u8 ba_size = IEEE80211_MIN_AMPDU_BUF;
+		u8 ampdu_density = sta->ht_cap.ampdu_density;
 
 		ba_size <<= sta->ht_cap.ampdu_factor;
 		ba_size = min_t(int, 63, ba_size - 1);
@@ -416,9 +417,11 @@ void mt76x02_mac_write_txwi(struct mt76x02_dev *dev, struct mt76x02_txwi *txwi,
 			ba_size = 0;
 		txwi->ack_ctl |= FIELD_PREP(MT_TXWI_ACK_CTL_BA_WINDOW, ba_size);
 
+		if (ampdu_density < IEEE80211_HT_MPDU_DENSITY_4)
+			ampdu_density = IEEE80211_HT_MPDU_DENSITY_4;
+
 		txwi_flags |= MT_TXWI_FLAGS_AMPDU |
-			 FIELD_PREP(MT_TXWI_FLAGS_MPDU_DENSITY,
-				    sta->ht_cap.ampdu_density);
+			 FIELD_PREP(MT_TXWI_FLAGS_MPDU_DENSITY, ampdu_density);
 	}
 
 	if (ieee80211_is_probe_resp(hdr->frame_control) ||
-- 
2.24.0

