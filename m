Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A084318A4
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Oct 2021 14:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhJRMQc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Oct 2021 08:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:32812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhJRMQb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Oct 2021 08:16:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95B0560FC3;
        Mon, 18 Oct 2021 12:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634559260;
        bh=kIFsICiYIMMZqothnYWoJoywfwoJtIP7v5L+4FE5g7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UX1i/tnaTs/d8BPKeJlfmieb1jobUT4YzgdvT0fDXw4/bTSkU6b0EqVR32IzmNdDO
         stiWI5QgRi9oHxXV7eS+WXxhtyqbCXaNuIzaHI47ZEjUXF6gGzxhrYO5oAYSUZilJq
         m9MctqrYxGXIX0KvxirzXiNjeBExog8aN/DIzkPbmlr3mwNGuJjeCa/RJ6vzPaWA33
         OKrTO1x9ELIptqr4hXf7cp4HytvdPjhfjok6i9f7dRQN+Ghdcr+QBdIi0zZfpNQBtm
         kryhZs1AMOcjtB/hdlHF3Swyvh/DC/7ImRRc1FvTj32m/sU9TghsdBIjNYgzJaiDUX
         KmxwDyYzZD3+A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, greearb@candelatech.com
Subject: [PATCH 03/10] mt76: mt7921: add some more MIB counters
Date:   Mon, 18 Oct 2021 14:14:02 +0200
Message-Id: <3473b16000edd7cd44bf468f7d32d0f9b5c27ca7.1634558817.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1634558817.git.lorenzo@kernel.org>
References: <cover.1634558817.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce ethtool stats support to mt7921
driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 26 ++++++++++++++++-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    | 18 ++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  | 28 +++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5380e91c5886..f9b2b17be454 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1662,6 +1662,7 @@ void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	struct mt7921_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
 	int i, aggr0 = 0, aggr1;
+	u32 val;
 
 	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(0),
 					   MT_MIB_SDR3_FCS_ERR_MASK);
@@ -1674,8 +1675,31 @@ void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	mib->rts_retries_cnt += mt76_get_field(dev, MT_MIB_MB_BSDR1(0),
 					       MT_MIB_RTS_FAIL_COUNT_MASK);
 
+	mib->tx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR12(0));
+	mib->tx_mpdu_attempts_cnt += mt76_rr(dev, MT_MIB_SDR14(0));
+	mib->tx_mpdu_success_cnt += mt76_rr(dev, MT_MIB_SDR15(0));
+
+	val = mt76_rr(dev, MT_MIB_SDR32(0));
+	mib->tx_pkt_ebf_cnt += FIELD_GET(MT_MIB_SDR9_EBF_CNT_MASK, val);
+	mib->tx_pkt_ibf_cnt += FIELD_GET(MT_MIB_SDR9_IBF_CNT_MASK, val);
+
+	val = mt76_rr(dev, MT_ETBF_TX_APP_CNT(0));
+	mib->tx_bf_ibf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_IBF_CNT, val);
+	mib->tx_bf_ebf_ppdu_cnt += FIELD_GET(MT_ETBF_TX_EBF_CNT, val);
+
+	val = mt76_rr(dev, MT_ETBF_RX_FB_CNT(0));
+	mib->tx_bf_rx_fb_all_cnt += FIELD_GET(MT_ETBF_RX_FB_ALL, val);
+	mib->tx_bf_rx_fb_he_cnt += FIELD_GET(MT_ETBF_RX_FB_HE, val);
+	mib->tx_bf_rx_fb_vht_cnt += FIELD_GET(MT_ETBF_RX_FB_VHT, val);
+	mib->tx_bf_rx_fb_ht_cnt += FIELD_GET(MT_ETBF_RX_FB_HT, val);
+
+	mib->rx_mpdu_cnt += mt76_rr(dev, MT_MIB_SDR5(0));
+	mib->rx_ampdu_cnt += mt76_rr(dev, MT_MIB_SDR22(0));
+	mib->rx_ampdu_bytes_cnt += mt76_rr(dev, MT_MIB_SDR23(0));
+	mib->rx_ba_cnt += mt76_rr(dev, MT_MIB_SDR31(0));
+
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
-		u32 val, val2;
+		u32 val2;
 
 		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
 		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index be9da985d129..3da9261809d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -107,6 +107,24 @@ struct mib_stats {
 	u32 rts_cnt;
 	u32 rts_retries_cnt;
 	u32 ba_miss_cnt;
+
+	u32 tx_bf_ibf_ppdu_cnt;
+	u32 tx_bf_ebf_ppdu_cnt;
+	u32 tx_bf_rx_fb_all_cnt;
+	u32 tx_bf_rx_fb_he_cnt;
+	u32 tx_bf_rx_fb_vht_cnt;
+	u32 tx_bf_rx_fb_ht_cnt;
+
+	u32 tx_ampdu_cnt;
+	u32 tx_mpdu_attempts_cnt;
+	u32 tx_mpdu_success_cnt;
+	u32 tx_pkt_ebf_cnt;
+	u32 tx_pkt_ibf_cnt;
+
+	u32 rx_mpdu_cnt;
+	u32 rx_ampdu_cnt;
+	u32 rx_ampdu_bytes_cnt;
+	u32 rx_ba_cnt;
 };
 
 struct mt7921_phy {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index 26fb11823762..80f23f1b835a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -92,6 +92,20 @@
 #define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
 #define MT_LPON_TCR_SW_WRITE		BIT(0)
 
+/* ETBF: band 0(0x24000), band 1(0xa4000) */
+#define MT_WF_ETBF_BASE(_band)		((_band) ? 0xa4000 : 0x24000)
+#define MT_WF_ETBF(_band, ofs)		(MT_WF_ETBF_BASE(_band) + (ofs))
+
+#define MT_ETBF_TX_APP_CNT(_band)	MT_WF_ETBF(_band, 0x150)
+#define MT_ETBF_TX_IBF_CNT		GENMASK(31, 16)
+#define MT_ETBF_TX_EBF_CNT		GENMASK(15, 0)
+
+#define MT_ETBF_RX_FB_CNT(_band)	MT_WF_ETBF(_band, 0x158)
+#define MT_ETBF_RX_FB_ALL		GENMASK(31, 24)
+#define MT_ETBF_RX_FB_HE		GENMASK(23, 16)
+#define MT_ETBF_RX_FB_VHT		GENMASK(15, 8)
+#define MT_ETBF_RX_FB_HT		GENMASK(7, 0)
+
 /* MIB: band 0(0x24800), band 1(0xa4800) */
 #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
 #define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
@@ -103,12 +117,26 @@
 #define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x698)
 #define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(31, 16)
 
+#define MT_MIB_SDR5(_band)		MT_WF_MIB(_band, 0x780)
+
 #define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
 #define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
 
+#define MT_MIB_SDR12(_band)		MT_WF_MIB(_band, 0x558)
+#define MT_MIB_SDR14(_band)		MT_WF_MIB(_band, 0x564)
+#define MT_MIB_SDR15(_band)		MT_WF_MIB(_band, 0x568)
+
 #define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
 #define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
 
+#define MT_MIB_SDR22(_band)		MT_WF_MIB(_band, 0x770)
+#define MT_MIB_SDR23(_band)		MT_WF_MIB(_band, 0x774)
+#define MT_MIB_SDR31(_band)		MT_WF_MIB(_band, 0x55c)
+
+#define MT_MIB_SDR32(_band)		MT_WF_MIB(_band, 0x7a8)
+#define MT_MIB_SDR9_IBF_CNT_MASK	GENMASK(31, 16)
+#define MT_MIB_SDR9_EBF_CNT_MASK	GENMASK(15, 0)
+
 #define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
 #define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
 
-- 
2.31.1

