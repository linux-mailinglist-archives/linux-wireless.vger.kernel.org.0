Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE304375A03
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 20:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhEFSOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 14:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231955AbhEFSOu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 14:14:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C48561166;
        Thu,  6 May 2021 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620324832;
        bh=xaFRhd0QOsz5lSn7IUQqZ+Yn1OtoFZpN0FOw1VjOczY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGyx9gkBvCWjkvc+FotYwuo3c9DXBf1YkP4gkyrRYz3baWNkXmZ5a7lR55PJkilMA
         BL7rKCfzyGOURiadQbKrocSlbWKmjdvNLFM7ZY4ll3Fq5DA1ek4CHbNFp2jasTGTli
         pUNJFHnn2jnzxOgKtbd3695+P1kygwYFzBf+MJ59KvsuzZUg/Pfq2DkycFFCm3WDHD
         cK3ao1rypzecy5Ttb6L5cLyF+H6IPZfaBG13pVPTZsYul7QUxz7P2du1SlD9KCxJvP
         S/sqHdKfwBL+4TH+/WaHPfCCCxDtxi1v9DKzcBcF1NGL+DlM3zIk1VTY3pn1G54Ew/
         3VGxuftEDmZiw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 4/4] mt76: mt7921: enable rx csum offload
Date:   Thu,  6 May 2021 20:13:35 +0200
Message-Id: <b1ba0b425913f0a1940a2fa586e9d882eba00c11.1620322988.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620322988.git.lorenzo@kernel.org>
References: <cover.1620322988.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7615 and mt7915, enable hw rx checksum offload.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c |  1 +
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c  | 10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 91885d7417a4..0f8cb1a798bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -50,6 +50,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF;
+	hw->netdev_features = NETIF_F_RXCSUM;
 
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 74974f689462..44b8918db95b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -308,22 +308,23 @@ mt7921_mac_assoc_rssi(struct mt7921_dev *dev, struct sk_buff *skb)
 
 int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 {
+	u32 csum_mask = MT_RXD0_NORMAL_IP_SUM | MT_RXD0_NORMAL_UDP_TCP_SUM;
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	bool hdr_trans, unicast, insert_ccmp_hdr = false;
 	u8 chfreq, qos_ctl = 0, remove_pad, amsdu_info;
+	__le32 *rxv = NULL, *rxd = (__le32 *)skb->data;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt7921_phy *phy = &dev->phy;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_hdr *hdr;
-	__le32 *rxd = (__le32 *)skb->data;
-	__le32 *rxv = NULL;
-	u32 mode = 0;
+	u32 rxd0 = le32_to_cpu(rxd[0]);
 	u32 rxd1 = le32_to_cpu(rxd[1]);
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
+	u32 mode = 0;
 	int i, idx;
 
 	memset(status, 0, sizeof(*status));
@@ -363,6 +364,9 @@ int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (!sband->channels)
 		return -EINVAL;
 
+	if ((rxd0 & csum_mask) == csum_mask)
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
 	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
 		status->flag |= RX_FLAG_FAILED_FCS_CRC;
 
-- 
2.30.2

