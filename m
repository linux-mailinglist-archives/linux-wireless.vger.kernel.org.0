Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19956626A54
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Nov 2022 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiKLPlk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Nov 2022 10:41:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiKLPli (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Nov 2022 10:41:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500D1AF30
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 07:41:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B909B80835
        for <linux-wireless@vger.kernel.org>; Sat, 12 Nov 2022 15:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D8C433C1;
        Sat, 12 Nov 2022 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267694;
        bh=mBS4IwG1iUteGESi3ge3ftHDKsfpFTLGISf4VmlZBOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TdNJin2/l/D/WeINSVvQswxt++ymJLOC+FpzhajO4dHwzY9zuZfEZeQJWTDJhzxES
         hVDVo5m7omOkfld/p+Q/DK42lF3w8bW0jheeg7ogQrXuadLU+UAGMuRQwpd4f3A2oz
         IhIZqas5juqe+NveUk4H6NavCydYoGM+ymxq9NvCGYwWF+Xs3Lay38DF0KhaChjbWx
         mKserWizt5Upd7bI/X1zeZnBuO0QYgMOc9U5bYoQTHlqwqoE0ef9mC25RViQDXQL7/
         mm3WlUdhRFfTMptGMFa+KEU56/Aa0WiJE87WcVoguownByIv8WHkOzfYY18jm0aEMD
         Bw1aZeJJz2THg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Bo.Jiao@mediatek.com, sujuan.chen@mediatek.com,
        ryder.Lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 8/8] wifi: mt76: mt7915: enable WED RX stats
Date:   Sat, 12 Nov 2022 16:40:41 +0100
Message-Id: <90de3874da1cbf4a495cfd0c1c8cfa5a081ca933.1668267241.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1668267241.git.lorenzo@kernel.org>
References: <cover.1668267241.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sujuan Chen <sujuan.chen@mediatek.com>

Introduce the capability to report WED RX stats to mac80211.

Tested-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  6 +++++
 .../net/wireless/mediatek/mt76/mt7915/dma.c   |  6 +++++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  8 ++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 18 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 26 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 6 files changed, 65 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index bf4ad629df3f..33f87e518d68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -273,9 +273,15 @@ struct mt76_sta_stats {
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
 	u64 tx_bytes;
+	/* WED TX */
 	u32 tx_packets;
 	u32 tx_retries;
 	u32 tx_failed;
+	/* WED RX */
+	u64 rx_bytes;
+	u32 rx_packets;
+	u32 rx_errors;
+	u32 rx_drops;
 };
 
 enum mt76_wcid_flags {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index e102a717fc01..ae5be28fdd9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -361,12 +361,18 @@ static int mt7915_dma_enable(struct mt7915_dev *dev)
 
 	if (mtk_wed_device_active(&dev->mt76.mmio.wed)) {
 		u32 wed_irq_mask = irq_mask;
+		int ret;
 
 		wed_irq_mask |= MT_INT_TX_DONE_BAND0 | MT_INT_TX_DONE_BAND1;
 		if (!is_mt7986(&dev->mt76))
 			mt76_wr(dev, MT_INT_WED_MASK_CSR, wed_irq_mask);
 		else
 			mt76_wr(dev, MT_INT_MASK_CSR, wed_irq_mask);
+
+		ret = mt7915_mcu_wed_enable_rx_stats(dev);
+		if (ret)
+			return ret;
+
 		mtk_wed_device_start(&dev->mt76.mmio.wed, wed_irq_mask);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 3933f4f2d71d..90c5d8fe4f73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1037,6 +1037,14 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 
 		sinfo->tx_retries = msta->wcid.stats.tx_retries;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
+		if (mtk_wed_get_rx_capa(&phy->dev->mt76.mmio.wed)) {
+			sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+
+			sinfo->rx_packets = msta->wcid.stats.rx_packets;
+			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+		}
 	}
 
 	sinfo->ack_signal = (s8)msta->ack_signal;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f63ed0378802..f0db4100d008 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1685,6 +1685,24 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
+int mt7915_mcu_wed_enable_rx_stats(struct mt7915_dev *dev)
+{
+#ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
+	struct {
+		__le32 args[2];
+	} req = {
+		.args[0] = cpu_to_le32(1),
+		.args[1] = cpu_to_le32(6),
+	};
+
+	return mtk_wed_device_update_msg(wed, MTK_WED_WO_CMD_RXCNT_CTRL,
+					 &req, sizeof(req));
+#else
+	return 0;
+#endif
+}
+
 int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, bool enable)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 04f38755056f..1fcf34f57a16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -663,6 +663,31 @@ static u32 mt7915_wed_init_rx_buf(struct mtk_wed_device *wed, int size)
 	mt7915_wed_release_rx_buf(wed);
 	return -ENOMEM;
 }
+
+static void mt7915_mmio_wed_update_rx_stats(struct mtk_wed_device *wed,
+					    struct mtk_wed_wo_rx_stats *stats)
+{
+	int idx = le16_to_cpu(stats->wlan_idx);
+	struct mt7915_dev *dev;
+	struct mt76_wcid *wcid;
+
+	dev = container_of(wed, struct mt7915_dev, mt76.mmio.wed);
+
+	if (idx >= mt7915_wtbl_size(dev))
+		return;
+
+	rcu_read_lock();
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (wcid) {
+		wcid->stats.rx_bytes += le32_to_cpu(stats->rx_byte_cnt);
+		wcid->stats.rx_packets += le32_to_cpu(stats->rx_pkt_cnt);
+		wcid->stats.rx_errors += le32_to_cpu(stats->rx_err_cnt);
+		wcid->stats.rx_drops += le32_to_cpu(stats->rx_drop_cnt);
+	}
+
+	rcu_read_unlock();
+}
 #endif
 
 int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
@@ -744,6 +769,7 @@ int mt7915_mmio_wed_init(struct mt7915_dev *dev, void *pdev_ptr,
 	wed->wlan.offload_disable = mt7915_mmio_wed_offload_disable;
 	wed->wlan.init_rx_buf = mt7915_wed_init_rx_buf;
 	wed->wlan.release_rx_buf = mt7915_wed_release_rx_buf;
+	wed->wlan.update_wo_rx_stats = mt7915_mmio_wed_update_rx_stats;
 
 	dev->mt76.rx_token_size = wed->wlan.rx_npkt;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 574f712b5fe1..3fc3c48997e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -630,6 +630,7 @@ void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
 int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
 int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
+int mt7915_mcu_wed_enable_rx_stats(struct mt7915_dev *dev);
 int mt7915_init_debugfs(struct mt7915_phy *phy);
 void mt7915_debugfs_rx_fw_monitor(struct mt7915_dev *dev, const void *data, int len);
 bool mt7915_debugfs_rx_log(struct mt7915_dev *dev, const void *data, int len);
-- 
2.38.1

