Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E16B4D87D3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 16:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242473AbiCNPMY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 11:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiCNPMX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 11:12:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3D43EF3
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 08:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30E80B80E3A
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 15:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4AAC340E9;
        Mon, 14 Mar 2022 15:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647270665;
        bh=TjFXY1PLMPmn45MMd18YrVcpeBIXkMa96WVOBZ+EbpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eIYBuSGpiCRGmtuNLCE5deX66pASzqQqVgU2UpjGlVy/3nZMlUVC7PDyavgiDDJSu
         zCdUOrSgW+0Bk/iGgHQCdRL5mhj5uuIkq1C5W2L0xIpG1ACqvEqD38acPL9XUHB5rp
         gROehZGBEhk7NcIxJbZOglZsUGXEvibENsgx19nh7O76LrqEe90Sb2XRZPyY79nL1k
         5Ztb2DKfbxGVHhPpi+AdtrRx2w7wWYKwKMSHjiZ5XuBkJ5rclQAyikLEc8QLQkoPUn
         E7PMn2k3RcwXdFYtgu0Gw2pd5urYi5iTv3V12Zh+Cmi3w6RrTgKchZcNkDzONw7s+T
         2w9WqQufEtdsQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v5 7/9] mt76: mt7921: move mt7921_usb_sdio_tx_complete_skb in common mac code.
Date:   Mon, 14 Mar 2022 16:10:29 +0100
Message-Id: <2aff0517bb4ca03cc3a88b24f8b5808fb551953e.1647270525.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647270525.git.lorenzo@kernel.org>
References: <cover.1647270525.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add mt7921u driver support.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 21 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 ++-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  | 19 -----------------
 4 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index dd1a241c45d6..0c1b65653102 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1680,3 +1680,24 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return err;
 }
 EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_prepare_skb);
+
+void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e)
+{
+	__le32 *txwi = (__le32 *)(e->skb->data + MT_SDIO_HDR_SIZE);
+	unsigned int headroom = MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
+	struct ieee80211_sta *sta;
+	struct mt76_wcid *wcid;
+	u16 idx;
+
+	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
+	wcid = rcu_dereference(mdev->wcid[idx]);
+	sta = wcid_to_sta(wcid);
+
+	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+		mt7921_tx_check_aggr(sta, txwi);
+
+	skb_pull(e->skb, headroom);
+	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
+}
+EXPORT_SYMBOL_GPL(mt7921_usb_sdio_tx_complete_skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 06db3e1f39a2..32b77fe49abd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -444,7 +444,6 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_init(struct mt7921_dev *dev);
 int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev);
-void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
 bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update);
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data);
 void mt7921_set_runtime_pm(struct mt7921_dev *dev);
@@ -455,4 +454,6 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
 				   struct ieee80211_sta *sta,
 				   struct mt76_tx_info *tx_info);
+void mt7921_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index fc6499640a1c..507bd550b063 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -92,7 +92,7 @@ static int mt7921s_probe(struct sdio_func *func,
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
 		.tx_prepare_skb = mt7921_usb_sdio_tx_prepare_skb,
-		.tx_complete_skb = mt7921s_tx_complete_skb,
+		.tx_complete_skb = mt7921_usb_sdio_tx_complete_skb,
 		.tx_status_data = mt7921s_tx_status_data,
 		.rx_skb = mt7921_queue_rx_skb,
 		.sta_ps = mt7921_sta_ps,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index d741a58c1260..fa9db21bb3e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -141,25 +141,6 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 	return err;
 }
 
-void mt7921s_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
-{
-	__le32 *txwi = (__le32 *)(e->skb->data + MT_SDIO_HDR_SIZE);
-	unsigned int headroom = MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
-	struct ieee80211_sta *sta;
-	struct mt76_wcid *wcid;
-	u16 idx;
-
-	idx = le32_get_bits(txwi[1], MT_TXD1_WLAN_IDX);
-	wcid = rcu_dereference(mdev->wcid[idx]);
-	sta = wcid_to_sta(wcid);
-
-	if (sta && likely(e->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt7921_tx_check_aggr(sta, txwi);
-
-	skb_pull(e->skb, headroom);
-	mt76_tx_complete_skb(mdev, e->wcid, e->skb);
-}
-
 bool mt7921s_tx_status_data(struct mt76_dev *mdev, u8 *update)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-- 
2.35.1

