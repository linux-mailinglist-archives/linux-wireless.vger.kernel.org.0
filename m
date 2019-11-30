Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1D0F10DE12
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfK3Pa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:56 -0500
Received: from nbd.name ([46.4.11.11]:56054 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jRZQUQmvMTT/XRR8655+O/MtwhlQ0mXCmEr9wiuKFbM=; b=giqjqM39vH41wZT64xIgAf3nxM
        tgRpz1K9+nZyHAIsWZRFtZjcOek4MnnzRAET2dqyvm8s5yRM1Iwq3xIzylm1Fw98fhMvtb/T9AvGN
        GS3WJGbBe3bS0YXJajOG/kZMAe+PtiYbvlKwIxZGwyN5sAOR/9imQZYMEMD2Y1xCOhhA=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iF-P9
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0AE5B721EBE3; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 27/29] mt76: mt7615: select the correct tx queue for frames sent to the second phy
Date:   Sat, 30 Nov 2019 16:30:43 +0100
Message-Id: <20191130153045.28105-27-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Beacons and management frames need to explicitly select the alternate tx
queues in order to be sent out on the right phy

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 13 ++++++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.h |  4 ++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 886c54a91252..4d528aa725fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -382,6 +382,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
+	bool ext_phy = info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY;
 	int tx_count = 8;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	__le16 fc = hdr->frame_control;
@@ -401,7 +402,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		tx_count = msta->rate_count;
 	}
 
-	if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && dev->mt76.phy2)
+	if (ext_phy && dev->mt76.phy2)
 		mphy = dev->mt76.phy2;
 
 	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
@@ -412,10 +413,16 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			skb_get_queue_mapping(skb);
 		p_fmt = MT_TX_TYPE_CT;
 	} else if (ieee80211_is_beacon(fc)) {
-		q_idx = MT_LMAC_BCN0;
+		if (ext_phy)
+			q_idx = MT_LMAC_BCN1;
+		else
+			q_idx = MT_LMAC_BCN0;
 		p_fmt = MT_TX_TYPE_FW;
 	} else {
-		q_idx = MT_LMAC_ALTX0;
+		if (ext_phy)
+			q_idx = MT_LMAC_ALTX1;
+		else
+			q_idx = MT_LMAC_ALTX0;
 		p_fmt = MT_TX_TYPE_CT;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 38695d4f92e2..8579b829778d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -126,6 +126,10 @@ enum tx_pkt_queue_idx {
 	MT_LMAC_BMC0,
 	MT_LMAC_BCN0,
 	MT_LMAC_PSMP0,
+	MT_LMAC_ALTX1,
+	MT_LMAC_BMC1,
+	MT_LMAC_BCN1,
+	MT_LMAC_PSMP1,
 };
 
 enum tx_port_idx {
-- 
2.24.0

