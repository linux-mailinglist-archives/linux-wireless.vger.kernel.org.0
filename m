Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9804F4DD31B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiCRCew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiCRCeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1349A19B091
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XIFX0017670, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XIFX0017670
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 10:33:18 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 08/11] rtw89: pci: support variant of fill_txaddr_info
Date:   Fri, 18 Mar 2022 10:32:11 +0800
Message-ID: <20220318023214.32411-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318023214.32411-1-pkshih@realtek.com>
References: <20220318023214.32411-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The txaddr_info is used to fill the DMA address of skb->data. The v1
version can support up to 10 entries, but the maximum size of each entry
is 2047, so it fill more than one entry for large packet, like 3000 bytes.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/pci.c      | 64 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/pci.h      | 33 ++++++++++
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  2 +
 5 files changed, 95 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c17756ff54762..501381bb74adf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -721,6 +721,7 @@ struct rtw89_tx_desc_info {
 	u8 ampdu_density;
 	u8 ampdu_num;
 	bool sec_en;
+	u8 addr_info_nr;
 	u8 sec_type;
 	u8 sec_cam_idx;
 	u16 data_rate;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 9335fba28fc1e..48a5feaf27222 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -977,6 +977,58 @@ static void rtw89_pci_ops_flush_queues(struct rtw89_dev *rtwdev, u32 queues,
 	__rtw89_pci_ops_flush_txchs(rtwdev, BIT(RTW89_TXCH_NUM) - 1, drop);
 }
 
+u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
+			       void *txaddr_info_addr, u32 total_len,
+			       dma_addr_t dma, u8 *add_info_nr)
+{
+	struct rtw89_pci_tx_addr_info_32 *txaddr_info = txaddr_info_addr;
+
+	txaddr_info->length = cpu_to_le16(total_len);
+	txaddr_info->option = cpu_to_le16(RTW89_PCI_ADDR_MSDU_LS |
+					  RTW89_PCI_ADDR_NUM(1));
+	txaddr_info->dma = cpu_to_le32(dma);
+
+	*add_info_nr = 1;
+
+	return sizeof(*txaddr_info);
+}
+EXPORT_SYMBOL(rtw89_pci_fill_txaddr_info);
+
+u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
+				  void *txaddr_info_addr, u32 total_len,
+				  dma_addr_t dma, u8 *add_info_nr)
+{
+	struct rtw89_pci_tx_addr_info_32_v1 *txaddr_info = txaddr_info_addr;
+	u32 remain = total_len;
+	u32 len;
+	u16 length_option;
+	int n;
+
+	for (n = 0; n < RTW89_TXADDR_INFO_NR_V1 && remain; n++) {
+		len = remain >= TXADDR_INFO_LENTHG_V1_MAX ?
+		      TXADDR_INFO_LENTHG_V1_MAX : remain;
+		remain -= len;
+
+		length_option = FIELD_PREP(B_PCIADDR_LEN_V1_MASK, len) |
+				FIELD_PREP(B_PCIADDR_HIGH_SEL_V1_MASK, 0) |
+				FIELD_PREP(B_PCIADDR_LS_V1_MASK, remain == 0);
+		txaddr_info->length_opt = cpu_to_le16(length_option);
+		txaddr_info->dma_low_lsb = cpu_to_le16(FIELD_GET(GENMASK(15, 0), dma));
+		txaddr_info->dma_low_msb = cpu_to_le16(FIELD_GET(GENMASK(31, 16), dma));
+
+		dma += len;
+		txaddr_info++;
+	}
+
+	WARN_ONCE(remain, "length overflow remain=%u total_len=%u",
+		  remain, total_len);
+
+	*add_info_nr = n;
+
+	return n * sizeof(*txaddr_info);
+}
+EXPORT_SYMBOL(rtw89_pci_fill_txaddr_info_v1);
+
 static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 				 struct rtw89_pci_tx_ring *tx_ring,
 				 struct rtw89_pci_tx_wd *txwd,
@@ -987,7 +1039,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct rtw89_txwd_body *txwd_body;
 	struct rtw89_txwd_info *txwd_info;
 	struct rtw89_pci_tx_wp_info *txwp_info;
-	struct rtw89_pci_tx_addr_info_32 *txaddr_info;
+	void *txaddr_info_addr;
 	struct pci_dev *pdev = rtwpci->pdev;
 	struct sk_buff *skb = tx_req->skb;
 	struct rtw89_pci_tx_data *tx_data = RTW89_PCI_TX_SKB_CB(skb);
@@ -1009,7 +1061,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 
 	tx_data->dma = dma;
 
-	txaddr_info_len = sizeof(*txaddr_info);
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = sizeof(*txwd_body);
 	txwd_len += en_wd_info ? sizeof(*txwd_info) : 0;
@@ -1021,11 +1072,10 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	txwp_info->seq3 = 0;
 
 	tx_ring->tx_cnt++;
-	txaddr_info = txwd->vaddr + txwd_len + txwp_len;
-	txaddr_info->length = cpu_to_le16(skb->len);
-	txaddr_info->option = cpu_to_le16(RTW89_PCI_ADDR_MSDU_LS |
-					  RTW89_PCI_ADDR_NUM(1));
-	txaddr_info->dma = cpu_to_le32(dma);
+	txaddr_info_addr = txwd->vaddr + txwd_len + txwp_len;
+	txaddr_info_len =
+		rtw89_chip_fill_txaddr_info(rtwdev, txaddr_info_addr, skb->len,
+					    dma, &desc_info->addr_info_nr);
 
 	txwd->len = txwd_len + txwp_len + txaddr_info_len;
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 2c8030af3e72f..a67595b211853 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -448,6 +448,10 @@ struct rtw89_pci_ch_dma_addr_set {
 
 struct rtw89_pci_info {
 	const struct rtw89_pci_ch_dma_addr_set *dma_addr_set;
+
+	u32 (*fill_txaddr_info)(struct rtw89_dev *rtwdev,
+				void *txaddr_info_addr, u32 total_len,
+				dma_addr_t dma, u8 *add_info_nr);
 };
 
 struct rtw89_pci_bd_ram {
@@ -493,6 +497,18 @@ struct rtw89_pci_tx_addr_info_32 {
 	__le32 dma;
 } __packed;
 
+#define RTW89_TXADDR_INFO_NR_V1		10
+
+struct rtw89_pci_tx_addr_info_32_v1 {
+	__le16 length_opt;
+#define B_PCIADDR_LEN_V1_MASK		GENMASK(10, 0)
+#define B_PCIADDR_HIGH_SEL_V1_MASK	GENMASK(14, 11)
+#define B_PCIADDR_LS_V1_MASK		BIT(15)
+#define TXADDR_INFO_LENTHG_V1_MAX	ALIGN_DOWN(BIT(11) - 1, 4)
+	__le16 dma_low_lsb;
+	__le16 dma_low_msb;
+} __packed;
+
 #define RTW89_PCI_RPP_POLLUTED		BIT(31)
 #define RTW89_PCI_RPP_SEQ		GENMASK(30, 16)
 #define RTW89_PCI_RPP_TX_STATUS		GENMASK(15, 13)
@@ -698,5 +714,22 @@ struct pci_device_id;
 
 int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id);
 void rtw89_pci_remove(struct pci_dev *pdev);
+u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
+			       void *txaddr_info_addr, u32 total_len,
+			       dma_addr_t dma, u8 *add_info_nr);
+u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
+				  void *txaddr_info_addr, u32 total_len,
+				  dma_addr_t dma, u8 *add_info_nr);
+
+static inline
+u32 rtw89_chip_fill_txaddr_info(struct rtw89_dev *rtwdev,
+				void *txaddr_info_addr, u32 total_len,
+				dma_addr_t dma, u8 *add_info_nr)
+{
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+
+	return info->fill_txaddr_info(rtwdev, txaddr_info_addr, total_len,
+				      dma, add_info_nr);
+}
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index 48459aba441df..8ffc0dd90d41c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -10,6 +10,8 @@
 
 static const struct rtw89_pci_info rtw8852a_pci_info = {
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set,
+
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info,
 };
 
 static const struct rtw89_driver_info rtw89_8852ae_info = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index e71370585b4da..09794836d5c0f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -11,6 +11,8 @@
 
 static const struct rtw89_pci_info rtw8852c_pci_info = {
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_v1,
+
+	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
 };
 
 static const struct rtw89_driver_info rtw89_8852ce_info = {
-- 
2.25.1

