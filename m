Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D956D4223
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Apr 2023 12:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjDCKeh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 06:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjDCKec (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 06:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5882B778
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 03:34:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63537618A9
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 10:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74003C4339B;
        Mon,  3 Apr 2023 10:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518069;
        bh=Zlb53Z7XXnTLbU0ztzJQfTcfYFLwAnDPYCuP0+QSJXM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+qw+O/Ov4+pg2Py4J62kQG4FT4RBZblLkpBXFrgTfWnAYrU3f50BaeZFoLFH1+z5
         5yPDwkWEjuj6qUB3ltcW6v6LQ8+mDGjMerih6lg5bOPDbEqixAaBzjuwyyddPOffE7
         SId24w4Yf2Ofz8Jtbn9yOccAFp5M3Hw91WDYOPsAyMB26CyKkaMSFG0M6xKBPb4gkO
         KhnwO5oJQtwQaRbz+KIzSdroMtVYF1GnmdRH4dP1TX6+461jiUdpmiTiBUBMV5LZe/
         VhENM6s0CbKfHH7NPiBkEGovGudR+npIVgtVhG//vzYDWWUBvVAg+5kCyCp1THeY6l
         BDls7DOxEvR0w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] wifi: mt76: move shared mac definitions in mt76_connac2_mac.h
Date:   Mon,  3 Apr 2023 12:34:00 +0200
Message-Id: <a637981066d5d7b2fe597cdaec57c8cf032eac49.1680517676.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680517676.git.lorenzo@kernel.org>
References: <cover.1680517676.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move some mac shared definitions between mt7996, mt7921 and mt7915 in
mt76_connac2_mac.h.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.h   | 12 -----
 .../net/wireless/mediatek/mt76/mt76_connac.h  | 14 +++++
 .../wireless/mediatek/mt76/mt76_connac2_mac.h | 22 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.h   | 33 +-----------
 .../net/wireless/mediatek/mt76/mt7921/dma.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 13 ++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.h   | 53 -------------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mac.c  |  2 +-
 .../wireless/mediatek/mt76/mt7921/sdio_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  2 +-
 .../wireless/mediatek/mt76/mt7921/usb_mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.h   | 12 -----
 17 files changed, 59 insertions(+), 120 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
index 880c9f74a7f1..d08fbe64c262 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.h
@@ -19,18 +19,6 @@
 #define MT_RXD0_NORMAL_GROUP_3		BIT(27)
 #define MT_RXD0_NORMAL_GROUP_4		BIT(28)
 
-enum rx_pkt_type {
-	PKT_TYPE_TXS,
-	PKT_TYPE_TXRXV,
-	PKT_TYPE_NORMAL,
-	PKT_TYPE_RX_DUP_RFB,
-	PKT_TYPE_RX_TMR,
-	PKT_TYPE_RETRIEVE,
-	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT,
-	PKT_TYPE_NORMAL_MCU,
-};
-
 #define MT_RXD1_NORMAL_BSSID		GENMASK(31, 26)
 #define MT_RXD1_NORMAL_PAYLOAD_FORMAT	GENMASK(25, 24)
 #define MT_RXD1_FIRST_AMSDU_FRAME	GENMASK(1, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index fc8e999a431a..15653b274f83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -6,6 +6,20 @@
 
 #include "mt76.h"
 
+enum rx_pkt_type {
+	PKT_TYPE_TXS,
+	PKT_TYPE_TXRXV,
+	PKT_TYPE_NORMAL,
+	PKT_TYPE_RX_DUP_RFB,
+	PKT_TYPE_RX_TMR,
+	PKT_TYPE_RETRIEVE,
+	PKT_TYPE_TXRX_NOTIFY,
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_NORMAL_MCU,
+	PKT_TYPE_RX_FW_MONITOR	= 0x0c,
+	PKT_TYPE_TXRX_NOTIFY_V0	= 0x18,
+};
+
 #define MT76_CONNAC_SCAN_IE_LEN			600
 #define MT76_CONNAC_MAX_NUM_SCHED_SCAN_INTERVAL	 10
 #define MT76_CONNAC_MAX_TIME_SCHED_SCAN_INTERVAL U16_MAX
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index f33171bcd343..a5ec0f631385 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -32,6 +32,16 @@ enum {
 	MT_LMAC_PSMP0,
 };
 
+#define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
+#define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
+#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
+/* 0: success, others: dropped */
+#define MT_TX_FREE_STATUS		GENMASK(14, 13)
+#define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
+#define MT_TX_FREE_PAIR			BIT(31)
+/* will support this field in further revision */
+#define MT_TX_FREE_RATE			GENMASK(13, 0)
+
 #define MT_TXD0_Q_IDX			GENMASK(31, 25)
 #define MT_TXD0_PKT_FMT			GENMASK(24, 23)
 #define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
@@ -166,6 +176,15 @@ enum {
 
 #define MT_TXS7_MPDU_RETRY_CNT		GENMASK(31, 23)
 
+/* RXD DW0 */
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
 /* RXD DW1 */
 #define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
 #define MT_RXD1_NORMAL_GROUP_1		BIT(11)
@@ -308,6 +327,9 @@ enum {
 #define MT_CRXV_FOE_HI		GENMASK(6, 0)
 #define MT_CRXV_FOE_SHIFT	13
 
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
 #define MT_CT_INFO_APPLY_TXD		BIT(0)
 #define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
 #define MT_CT_INFO_MGMT_FRAME		BIT(2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 6fa9c79f3e5f..ce94f87e2042 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -6,43 +6,12 @@
 
 #include "../mt76_connac2_mac.h"
 
-#define MT_CT_PARSE_LEN			72
-#define MT_CT_DMA_BUF_NUM		2
-
-#define MT_RXD0_LENGTH			GENMASK(15, 0)
-#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
-
-#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
-
-enum rx_pkt_type {
-	PKT_TYPE_TXS,
-	PKT_TYPE_TXRXV,
-	PKT_TYPE_NORMAL,
-	PKT_TYPE_RX_DUP_RFB,
-	PKT_TYPE_RX_TMR,
-	PKT_TYPE_RETRIEVE,
-	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT,
-	PKT_TYPE_RX_FW_MONITOR = 0x0c,
-	PKT_TYPE_TXRX_NOTIFY_V0 = 0x18,
-};
-
 #define MT_TX_FREE_VER			GENMASK(18, 16)
-#define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
-#define MT_TX_FREE_MSDU_CNT_V0	GENMASK(6, 0)
-#define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
-#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
+#define MT_TX_FREE_MSDU_CNT_V0		GENMASK(6, 0)
 /* 0: success, others: dropped */
-#define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
-#define MT_TX_FREE_PAIR			BIT(31)
 #define MT_TX_FREE_MPDU_HEADER		BIT(30)
 #define MT_TX_FREE_MSDU_ID_V3		GENMASK(14, 0)
 
-/* will support this field in further revision */
-#define MT_TX_FREE_RATE			GENMASK(13, 0)
-
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
 #define MT_TXS5_F0_QOS			BIT(30)
 #define MT_TXS5_F0_TX_COUNT		GENMASK(29, 25)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 7b33881a4b54..1d85c0c10049 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -3,7 +3,7 @@
 
 #include "mt7921.h"
 #include "../dma.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 
 static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 2b1147761724..8c1cc372cf87 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -4,7 +4,7 @@
 #include <linux/etherdevice.h>
 #include <linux/firmware.h>
 #include "mt7921.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 #include "mcu.h"
 
 static const struct ieee80211_iface_limit if_limits[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 2eeea43f6bf6..1675bf520481 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -6,9 +6,20 @@
 #include <linux/timekeeping.h>
 #include "mt7921.h"
 #include "../dma.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 #include "mcu.h"
 
+#define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
+#define MT_WTBL_TXRX_RATE_G2_HE		24
+#define MT_WTBL_TXRX_RATE_G2		12
+
+#define MT_WTBL_AC0_CTT_OFFSET		20
+
+static u32 mt7921_mac_wtbl_lmac_addr(int idx, u8 offset)
+{
+	return MT_WTBL_LMAC_OFFS(idx, 0) + offset * 4;
+}
+
 static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 					    u16 idx, bool unicast)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
deleted file mode 100644
index 8afec600364f..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: ISC */
-/* Copyright (C) 2020 MediaTek Inc. */
-
-#ifndef __MT7921_MAC_H
-#define __MT7921_MAC_H
-
-#include "../mt76_connac2_mac.h"
-
-#define MT_CT_PARSE_LEN			72
-#define MT_CT_DMA_BUF_NUM		2
-
-#define MT_RXD0_LENGTH			GENMASK(15, 0)
-#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
-#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
-
-#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
-#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
-#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
-
-enum rx_pkt_type {
-	PKT_TYPE_TXS,
-	PKT_TYPE_TXRXV,
-	PKT_TYPE_NORMAL,
-	PKT_TYPE_RX_DUP_RFB,
-	PKT_TYPE_RX_TMR,
-	PKT_TYPE_RETRIEVE,
-	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT,
-	PKT_TYPE_NORMAL_MCU,
-};
-
-#define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
-#define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
-#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
-/* 0: success, others: dropped */
-#define MT_TX_FREE_STATUS		GENMASK(14, 13)
-#define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
-#define MT_TX_FREE_PAIR			BIT(31)
-/* will support this field in further revision */
-#define MT_TX_FREE_RATE			GENMASK(13, 0)
-
-#define MT_WTBL_TXRX_CAP_RATE_OFFSET	7
-#define MT_WTBL_TXRX_RATE_G2_HE		24
-#define MT_WTBL_TXRX_RATE_G2		12
-
-#define MT_WTBL_AC0_CTT_OFFSET		20
-
-static inline u32 mt7921_mac_wtbl_lmac_addr(int idx, u8 offset)
-{
-	return MT_WTBL_LMAC_OFFS(idx, 0) + offset * 4;
-}
-
-#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 601d5aadb4f4..04925e66f15b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -6,7 +6,7 @@
 #include "mt7921.h"
 #include "mt7921_trace.h"
 #include "mcu.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 
 #define MT_STA_BFER			BIT(0)
 #define MT_STA_BFEE			BIT(1)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index ab3ddf4e2f4d..8471bb8279e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -8,7 +8,7 @@
 #include <linux/pci.h>
 
 #include "mt7921.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 #include "mcu.h"
 #include "../trace.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 8dd60408b117..6053a2556c20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -3,7 +3,7 @@
 
 #include "mt7921.h"
 #include "../dma.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 
 int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 77001a0602c1..ff3c21801e48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -13,7 +13,7 @@
 
 #include "mt7921.h"
 #include "../sdio.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 #include "mcu.h"
 
 static const struct sdio_device_id mt7921s_table[] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 1b3adb3d91e8..cff9925c41ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -4,7 +4,7 @@
 #include <linux/iopoll.h>
 #include <linux/mmc/sdio_func.h>
 #include "mt7921.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 #include "../sdio.h"
 
 static void mt7921s_enable_irq(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 5c1489766d9f..177679ce1c80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -8,7 +8,7 @@
 
 #include "mt7921.h"
 #include "../sdio.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 #include "mcu.h"
 #include "regs.h"
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index d8218ed7980a..3f555b3ceed7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -10,7 +10,7 @@
 
 #include "mt7921.h"
 #include "mcu.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 
 static const struct usb_device_id mt7921u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7961, 0xff, 0xff, 0xff),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
index efbd3954c883..50eb6e7fd6b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb_mac.c
@@ -10,7 +10,7 @@
 
 #include "mt7921.h"
 #include "mcu.h"
-#include "mac.h"
+#include "../mt76_connac2_mac.h"
 
 static u32 mt7921u_uhw_rr(struct mt76_dev *dev, u32 addr)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
index 2cc218f735d8..0318e16fcfab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.h
@@ -20,18 +20,6 @@
 #define MT_RXD0_SW_PKT_TYPE_MAP		0x380F
 #define MT_RXD0_SW_PKT_TYPE_FRAME	0x3801
 
-enum rx_pkt_type {
-	PKT_TYPE_TXS,
-	PKT_TYPE_TXRXV,
-	PKT_TYPE_NORMAL,
-	PKT_TYPE_RX_DUP_RFB,
-	PKT_TYPE_RX_TMR,
-	PKT_TYPE_RETRIEVE,
-	PKT_TYPE_TXRX_NOTIFY,
-	PKT_TYPE_RX_EVENT,
-	PKT_TYPE_RX_FW_MONITOR = 0x0c,
-};
-
 /* RXD DW1 */
 #define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(11, 0)
 #define MT_RXD1_NORMAL_GROUP_1		BIT(16)
-- 
2.39.2

