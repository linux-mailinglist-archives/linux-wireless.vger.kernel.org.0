Return-Path: <linux-wireless+bounces-28274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B08C0A098
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 00:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A203B34C43D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 22:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09B8275AFB;
	Sat, 25 Oct 2025 22:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="PICc6vnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199731B6CE9
	for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 22:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761430125; cv=none; b=gStcrpTqvdRplOGXYERL5no364oqn1mUhfUqdeFx3ZKj2CzeX2A9sq/N/bhYB60jLhHHI7ynYh96glMQb1YrjOR7tIzz7JBHt2ai7woK+JzATqmai11w6iZ7/i9+CccYUpvPkzj4uHlLsS/6guS+6pFueaJYoq3g3KYmwnQu2nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761430125; c=relaxed/simple;
	bh=f9ih9tij0KNNhi1lebuB1Vprue5IVVThcI2hedxKFNY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PYtATG7Ex3cgiV7CYR+0WnFE8D6/xn79ab6zcDVtia/QYb82dpTBWEZOepN3/gbImTo+UhH6Ll2uik68Gtpum5ZkXb4S55L1z1olTFH8Xm0w6ibom0Pu7FX7OaMMvnrdAeJeyBe4047Zp/xlK0HOL5c3HG4XcAcqyH8qH1TL0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=PICc6vnv; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 43762 invoked from network); 26 Oct 2025 00:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1761430119; bh=eSfAFgNC/0EjC5j9png0rjSse9w3FkoN70Emx1DMA7I=;
          h=From:To:Subject;
          b=PICc6vnvSevny8x5kIS0tnj7B2G2/oWevjwDAp2oFTE84vH7qTgowC7OiM2CTd5jw
           dPW2j46cZ4GAIKVjEqtdZ/Ag0E8UKRJ4tfTwaYD0Rv9DKVSJyZbC7Zdij3PWWZGduD
           0MeidUMxMW3n1BYgIIKdB8GKh8BAe/5qBOzA6NTnBW6XINwJKLBp593ZFbPHBwuKJe
           Im441USdXY6oAk5R8Rbk9wALMnsyuCO0/73/B4mSj138Jgtt2gLcQir1EdPZGA4weZ
           I5LyM408nEK9PSAZ4Prdj6khs49e/37fIX9l/ZeijCEFvnnRjqhwQqbGeMiLeXUeeY
           w+Tg1yQPRSFDg==
Received: from 83.24.132.245.ipv4.supernova.orange.pl (HELO laptop-olek.home) (olek2@wp.pl@[83.24.132.245])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <nbd@nbd.name>; 26 Oct 2025 00:08:39 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	StanleyYP.Wang@mediatek.com,
	howard-yh.hsu@mediatek.com,
	chad@monroe.io,
	rosenp@gmail.com,
	luoxueqin@kylinos.cn,
	olek2@wp.pl,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH wireless-next v2] wifi: mt76: add tx checksum offload for mt7915, mt7921, mt7981 and mt7986
Date: Sun, 26 Oct 2025 00:07:06 +0200
Message-ID: <20251025220837.1128924-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 4b191366fa77f2d6b256f30d3de3f17e
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4VME]                               

Supports IPv4 and IPv6 TCP + UDP

In various tests between MT7986 and Intel BE200, I observed a performance
boost ranging from 2 to 12%, with an average of 5.5%.

I did the tests on the MT7915, MT7981, MT7986, and MT7921 variants. The
MT7922, MT7925, and MT799x are untouched for now and still have
checksumming disabled.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
[rebased and resolved conflicts]
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
v2:
- corrected TX CSUM enabling for MT7921
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt7915/init.c     | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt792x_core.c     | 3 +++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0db00efe88b0..e31b3e7e2038 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -372,6 +372,9 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
 		wmm = sta->wme;
 	}
 
+	val = FIELD_PREP(MT_TXD0_ETH_TYPE_OFFSET, 10);
+	txwi[0] |= cpu_to_le32(val);
+
 	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
 	      FIELD_PREP(MT_TXD1_TID, tid);
 
@@ -391,6 +394,8 @@ mt76_connac2_mac_write_txwi_8023(__le32 *txwi, struct sk_buff *skb,
 
 	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	if (skb->ip_summed == CHECKSUM_PARTIAL)
+		val |= MT_TXD7_IP_SUM | MT_TXD7_UDP_TCP_SUM;
 
 	txwi[7] |= cpu_to_le32(val);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 5ea8b46e092e..a3bab240afb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -359,7 +359,8 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	hw->queues = 4;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
-	hw->netdev_features = NETIF_F_RXCSUM;
+	hw->netdev_features = NETIF_F_RXCSUM |
+			      NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
 
 	if (mtk_wed_device_active(&mdev->mmio.wed))
 		hw->netdev_features |= NETIF_F_HW_TC;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index c0e56541a954..a1e5c77d4f75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -632,6 +632,9 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
 	}
 	hw->netdev_features = NETIF_F_RXCSUM;
 
+	if (is_mt7921(&dev->mt76))
+		hw->netdev_features |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM;
+
 	hw->radiotap_timestamp.units_pos =
 		IEEE80211_RADIOTAP_TIMESTAMP_UNIT_US;
 
-- 
2.47.3


