Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53F6E22FC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjDNMTm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjDNMTR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:17 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E343AD34
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OoK4N3JAdR+6jE+GCG09CL+9J0zhObgRe4yJcf3GsIw=; b=uAyHUfMlBpQa67vLG4iPEC3MNx
        hcpw9cLvGs6BV4HTvrNm30djgHYBq5x6LBanEK4fCnW2nfCun5dN7LYgJ+A0zg8lqwyLPKC0bAnCe
        jczNYxFHmQDqTUEpHIOjaBES4celDOGFTOdLffMucHEpLe6zx7G0jz6bsxLiCF6D7xJg=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pnION-00EltZ-LG; Fri, 14 Apr 2023 14:19:03 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org
Subject: [PATCH wireless] mt76: add missing locking to protect against concurrent rx/status calls
Date:   Fri, 14 Apr 2023 14:19:03 +0200
Message-Id: <20230414121903.90080-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to the documentation, ieee80211_rx_list must not run concurrently
with ieee80211_tx_status (or its variants).

Cc: stable@vger.kernel.org
Fixes: 88046b2c9f6d ("mt76: add support for reporting tx status with skb")
Reported-by: Brian Coverstone <brian@mainsequence.net>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/dma.c         | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c  | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 5 ++++-
 drivers/net/wireless/mediatek/mt76/mt76x02_mac.c | 5 ++++-
 drivers/net/wireless/mediatek/mt76/tx.c          | 4 ++++
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireless/mediatek/mt76/dma.c
index da281cd1d36f..10c6d96dc149 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -576,7 +576,9 @@ mt76_dma_tx_queue_skb(struct mt76_dev *dev, struct mt76_queue *q,
 free_skb:
 	status.skb = tx_info.skb;
 	hw = mt76_tx_status_get_hw(dev, tx_info.skb);
+	spin_lock_bh(&dev->rx_lock);
 	ieee80211_tx_status_ext(hw, &status);
+	spin_unlock_bh(&dev->rx_lock);
 
 	return ret;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 70a7f84af028..12e0af52082a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1279,8 +1279,11 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 	if (wcidx >= MT7603_WTBL_STA || !sta)
 		goto out;
 
-	if (mt7603_fill_txs(dev, msta, &info, txs_data))
+	if (mt7603_fill_txs(dev, msta, &info, txs_data)) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_noskb(mt76_hw(dev), sta, &info);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 51a968a6afdc..5c41ad5955f4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1530,8 +1530,11 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 	if (wcid->phy_idx && dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
-	if (mt7615_fill_txs(dev, msta, &info, txs_data))
+	if (mt7615_fill_txs(dev, msta, &info, txs_data)) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_noskb(mphy->hw, sta, &info);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index d3f74473e6fb..3e41d809ade3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -631,8 +631,11 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 
 	mt76_tx_status_unlock(mdev, &list);
 
-	if (!status.skb)
+	if (!status.skb) {
+		spin_lock_bh(&dev->mt76.rx_lock);
 		ieee80211_tx_status_ext(mt76_hw(dev), &status);
+		spin_unlock_bh(&dev->mt76.rx_lock);
+	}
 
 	if (!len)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1f309d05380a..b435aed6aff7 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -77,7 +77,9 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 	}
 	rcu_read_unlock();
 }
@@ -263,7 +265,9 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	if (cb->pktid < MT_PACKET_ID_FIRST) {
 		hw = mt76_tx_status_get_hw(dev, skb);
 		status.sta = wcid_to_sta(wcid);
+		spin_lock_bh(&dev->rx_lock);
 		ieee80211_tx_status_ext(hw, &status);
+		spin_unlock_bh(&dev->rx_lock);
 		goto out;
 	}
 
-- 
2.39.0

