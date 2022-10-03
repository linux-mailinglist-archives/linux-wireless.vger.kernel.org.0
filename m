Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBAE5F2E63
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Oct 2022 11:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbiJCJqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Oct 2022 05:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJCJpz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Oct 2022 05:45:55 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45D5208C
        for <linux-wireless@vger.kernel.org>; Mon,  3 Oct 2022 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CT+N0HRKZuO2n/t0F7xayK9+lB29LjF6g9ytY2Bn2Bc=; b=MQY90g0Y7INvU/gDH1BziGCIOy
        RSV2eEC+uG4ocE90ZDY0L0b5sF+aFNxsNKvFWCUn62sUUvoFLMcFWlQQRbiYUrB3M+e32hNvnYyqf
        aC+w9fEj2Vxx5ivXb6ytQrhzxXEN686IDRj50hjdToX6r7aFy5CTtrG9MGw3oYWjkChA=;
Received: from p200300daa7301d00d4086823c46c59c0.dip0.t-ipconnect.de ([2003:da:a730:1d00:d408:6823:c46c:59c0] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ofHny-009qu9-WE; Mon, 03 Oct 2022 11:32:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>,
        Carson Vandegriffe <carson.vandegriffe@candelatech.com>
Subject: [PATCH 1/4] Revert "mt76: use IEEE80211_OFFLOAD_ENCAP_ENABLED instead of MT_DRV_AMSDU_OFFLOAD"
Date:   Mon,  3 Oct 2022 11:32:03 +0200
Message-Id: <20221003093206.86323-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This reverts commit f17f4864504d754bcbf31e4c89412cdf9946c409 and adds the
MT_DRV_AMSDU_OFFLOAD flag for MT7921 USB/SDIO

The reverted commit significantly decreases performance when running
a test where two MT7915 radios have 16 station vdevs each, configured
for AC mode, and transmitting UDP traffic to AP.

Co-developed-by: Felix Fietkau <nbd@nbd.name>
Reported-by: Carson Vandegriffe <carson.vandegriffe@candelatech.com>
Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 8 ++++++--
 drivers/net/wireless/mediatek/mt76/mt76.h        | 1 +
 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c  | 3 ++-
 6 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6de13d641438..4bdbfd0f6233 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -443,8 +443,12 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	ieee80211_hw_set(hw, SUPPORTS_CLONED_SKBS);
 	ieee80211_hw_set(hw, SUPPORTS_AMSDU_IN_AMPDU);
 	ieee80211_hw_set(hw, SUPPORTS_REORDERING_BUFFER);
-	ieee80211_hw_set(hw, TX_AMSDU);
-	ieee80211_hw_set(hw, TX_FRAG_LIST);
+
+	if (!(dev->drv->drv_flags & MT_DRV_AMSDU_OFFLOAD)) {
+		ieee80211_hw_set(hw, TX_AMSDU);
+		ieee80211_hw_set(hw, TX_FRAG_LIST);
+	}
+
 	ieee80211_hw_set(hw, MFP_CAPABLE);
 	ieee80211_hw_set(hw, AP_LINK_PS);
 	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 26febc0c261a..f9bdf16fc6c4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -415,6 +415,7 @@ struct mt76_hw_cap {
 #define MT_DRV_SW_RX_AIRTIME		BIT(2)
 #define MT_DRV_RX_DMA_HDR		BIT(3)
 #define MT_DRV_HW_MGMT_TXQ		BIT(4)
+#define MT_DRV_AMSDU_OFFLOAD		BIT(5)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index 2ffb509cad5c..be1b8ea711c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -781,7 +781,8 @@ struct mt7915_dev *mt7915_mmio_probe(struct device *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_fw_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 8a53d8f286db..b38d119b2ea9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -228,7 +228,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	static const struct mt76_driver_ops drv_ops = {
 		/* txwi_size = txd size + txp size */
 		.txwi_size = MT_TXD_SIZE + sizeof(struct mt76_connac_hw_txp),
-		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 3b25a06fd946..377ca5fa3f6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -89,6 +89,7 @@ static int mt7921s_probe(struct sdio_func *func,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = MT_SDIO_TXD_SIZE,
+		.drv_flags = MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 29c0ee330dbe..89249f0b6aba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -170,7 +170,8 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = MT_SDIO_TXD_SIZE,
-		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ,
+		.drv_flags = MT_DRV_RX_DMA_HDR | MT_DRV_HW_MGMT_TXQ |
+			     MT_DRV_AMSDU_OFFLOAD,
 		.survey_flags = SURVEY_INFO_TIME_TX |
 				SURVEY_INFO_TIME_RX |
 				SURVEY_INFO_TIME_BSS_RX,
-- 
2.36.1

