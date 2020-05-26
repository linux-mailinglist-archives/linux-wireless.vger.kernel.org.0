Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013761AD7E4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgDQHrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37034 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbgDQHrK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:10 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l4oH5020081, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l4oH5020081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:04 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:02 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:01 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 15/40] rtw88: 8723d: Organize chip TX/RX FIFO
Date:   Fri, 17 Apr 2020 15:46:28 +0800
Message-ID: <20200417074653.15591-16-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

TX FIFO size is 32k and it was divided into 256 pages with 128 bytes.
A boundary is used to split pages into two parts, head part is used to
store TX packets coming from host, and tail part is reserved for special
purposes, such as beacon packet, null data packet and so on.

The TX packets coming from host have many categories, such as VO, VI, BE,
BK, MG and etc. When going into head part of TX FIFO, they are classified
to four priority queue named low, normal, high and extra priority queues.
Each priority queue occupies predefined number of page, if a certain
priority queue is full, TX packet will store into PUB priority queue.

Similarly, RX FIFO is 16k and split into two parts, head part is used to
store RX packets, and tail part is 128 bytes and used to store report.
Thus, we fill this boundary to register as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c      | 140 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/mac.h      |   1 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  28 ++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  31 ++++
 4 files changed, 154 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index f4a504b350cf..645207a01525 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1032,13 +1032,16 @@ static int set_trx_fifo_info(struct rtw_dev *rtwdev)
 	/* config rsvd page num */
 	fifo->rsvd_drv_pg_num = 8;
 	fifo->txff_pg_num = chip->txff_size >> 7;
-	fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num +
-			   RSVD_PG_H2C_EXTRAINFO_NUM +
-			   RSVD_PG_H2C_STATICINFO_NUM +
-			   RSVD_PG_H2CQ_NUM +
-			   RSVD_PG_CPU_INSTRUCTION_NUM +
-			   RSVD_PG_FW_TXBUF_NUM +
-			   csi_buf_pg_num;
+	if (rtw_chip_wcpu_11n(rtwdev))
+		fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num;
+	else
+		fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num +
+				   RSVD_PG_H2C_EXTRAINFO_NUM +
+				   RSVD_PG_H2C_STATICINFO_NUM +
+				   RSVD_PG_H2CQ_NUM +
+				   RSVD_PG_CPU_INSTRUCTION_NUM +
+				   RSVD_PG_FW_TXBUF_NUM +
+				   csi_buf_pg_num;
 
 	if (fifo->rsvd_pg_num > fifo->txff_pg_num)
 		return -ENOMEM;
@@ -1047,18 +1050,20 @@ static int set_trx_fifo_info(struct rtw_dev *rtwdev)
 	fifo->rsvd_boundary = fifo->txff_pg_num - fifo->rsvd_pg_num;
 
 	cur_pg_addr = fifo->txff_pg_num;
-	cur_pg_addr -= csi_buf_pg_num;
-	fifo->rsvd_csibuf_addr = cur_pg_addr;
-	cur_pg_addr -= RSVD_PG_FW_TXBUF_NUM;
-	fifo->rsvd_fw_txbuf_addr = cur_pg_addr;
-	cur_pg_addr -= RSVD_PG_CPU_INSTRUCTION_NUM;
-	fifo->rsvd_cpu_instr_addr = cur_pg_addr;
-	cur_pg_addr -= RSVD_PG_H2CQ_NUM;
-	fifo->rsvd_h2cq_addr = cur_pg_addr;
-	cur_pg_addr -= RSVD_PG_H2C_STATICINFO_NUM;
-	fifo->rsvd_h2c_sta_info_addr = cur_pg_addr;
-	cur_pg_addr -= RSVD_PG_H2C_EXTRAINFO_NUM;
-	fifo->rsvd_h2c_info_addr = cur_pg_addr;
+	if (rtw_chip_wcpu_11ac(rtwdev)) {
+		cur_pg_addr -= csi_buf_pg_num;
+		fifo->rsvd_csibuf_addr = cur_pg_addr;
+		cur_pg_addr -= RSVD_PG_FW_TXBUF_NUM;
+		fifo->rsvd_fw_txbuf_addr = cur_pg_addr;
+		cur_pg_addr -= RSVD_PG_CPU_INSTRUCTION_NUM;
+		fifo->rsvd_cpu_instr_addr = cur_pg_addr;
+		cur_pg_addr -= RSVD_PG_H2CQ_NUM;
+		fifo->rsvd_h2cq_addr = cur_pg_addr;
+		cur_pg_addr -= RSVD_PG_H2C_STATICINFO_NUM;
+		fifo->rsvd_h2c_sta_info_addr = cur_pg_addr;
+		cur_pg_addr -= RSVD_PG_H2C_EXTRAINFO_NUM;
+		fifo->rsvd_h2c_info_addr = cur_pg_addr;
+	}
 	cur_pg_addr -= fifo->rsvd_drv_pg_num;
 	fifo->rsvd_drv_addr = cur_pg_addr;
 
@@ -1070,6 +1075,65 @@ static int set_trx_fifo_info(struct rtw_dev *rtwdev)
 	return 0;
 }
 
+static int __priority_queue_cfg(struct rtw_dev *rtwdev,
+				const struct rtw_page_table *pg_tbl,
+				u16 pubq_num)
+{
+	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_1, pg_tbl->hq_num);
+	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_2, pg_tbl->lq_num);
+	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_3, pg_tbl->nq_num);
+	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_4, pg_tbl->exq_num);
+	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_5, pubq_num);
+	rtw_write32_set(rtwdev, REG_RQPN_CTRL_2, BIT_LD_RQPN);
+
+	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2, fifo->rsvd_boundary);
+	rtw_write8_set(rtwdev, REG_FWHW_TXQ_CTRL + 2, BIT_EN_WR_FREE_TAIL >> 16);
+
+	rtw_write16(rtwdev, REG_BCNQ_BDNY_V1, fifo->rsvd_boundary);
+	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2 + 2, fifo->rsvd_boundary);
+	rtw_write16(rtwdev, REG_BCNQ1_BDNY_V1, fifo->rsvd_boundary);
+	rtw_write32(rtwdev, REG_RXFF_BNDY, chip->rxff_size - C2H_PKT_BUF - 1);
+	rtw_write8_set(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1);
+
+	if (!check_hw_ready(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1, 0))
+		return -EBUSY;
+
+	rtw_write8(rtwdev, REG_CR + 3, 0);
+
+	return 0;
+}
+
+static int __priority_queue_cfg_legacy(struct rtw_dev *rtwdev,
+				       const struct rtw_page_table *pg_tbl,
+				       u16 pubq_num)
+{
+	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u32 val32;
+
+	val32 = BIT_RQPN_NE(pg_tbl->nq_num, pg_tbl->exq_num);
+	rtw_write32(rtwdev, REG_RQPN_NPQ, val32);
+	val32 = BIT_RQPN_HLP(pg_tbl->hq_num, pg_tbl->lq_num, pubq_num);
+	rtw_write32(rtwdev, REG_RQPN, val32);
+
+	rtw_write8(rtwdev, REG_TRXFF_BNDY, fifo->rsvd_boundary);
+	rtw_write16(rtwdev, REG_TRXFF_BNDY + 2, chip->rxff_size - REPORT_BUF - 1);
+	rtw_write8(rtwdev, REG_DWBCN0_CTRL + 1, fifo->rsvd_boundary);
+	rtw_write8(rtwdev, REG_BCNQ_BDNY, fifo->rsvd_boundary);
+	rtw_write8(rtwdev, REG_MGQ_BDNY, fifo->rsvd_boundary);
+	rtw_write8(rtwdev, REG_WMAC_LBK_BF_HD, fifo->rsvd_boundary);
+
+	rtw_write32_set(rtwdev, REG_AUTO_LLT, BIT_AUTO_INIT_LLT);
+
+	if (!check_hw_ready(rtwdev, REG_AUTO_LLT, BIT_AUTO_INIT_LLT, 0))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int priority_queue_cfg(struct rtw_dev *rtwdev)
 {
 	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
@@ -1102,28 +1166,10 @@ static int priority_queue_cfg(struct rtw_dev *rtwdev)
 
 	pubq_num = fifo->acq_pg_num - pg_tbl->hq_num - pg_tbl->lq_num -
 		   pg_tbl->nq_num - pg_tbl->exq_num - pg_tbl->gapq_num;
-	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_1, pg_tbl->hq_num);
-	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_2, pg_tbl->lq_num);
-	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_3, pg_tbl->nq_num);
-	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_4, pg_tbl->exq_num);
-	rtw_write16(rtwdev, REG_FIFOPAGE_INFO_5, pubq_num);
-	rtw_write32_set(rtwdev, REG_RQPN_CTRL_2, BIT_LD_RQPN);
-
-	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2, fifo->rsvd_boundary);
-	rtw_write8_set(rtwdev, REG_FWHW_TXQ_CTRL + 2, BIT_EN_WR_FREE_TAIL >> 16);
-
-	rtw_write16(rtwdev, REG_BCNQ_BDNY_V1, fifo->rsvd_boundary);
-	rtw_write16(rtwdev, REG_FIFOPAGE_CTRL_2 + 2, fifo->rsvd_boundary);
-	rtw_write16(rtwdev, REG_BCNQ1_BDNY_V1, fifo->rsvd_boundary);
-	rtw_write32(rtwdev, REG_RXFF_BNDY, chip->rxff_size - C2H_PKT_BUF - 1);
-	rtw_write8_set(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1);
-
-	if (!check_hw_ready(rtwdev, REG_AUTO_LLT_V1, BIT_AUTO_INIT_LLT_V1, 0))
-		return -EBUSY;
-
-	rtw_write8(rtwdev, REG_CR + 3, 0);
-
-	return 0;
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return __priority_queue_cfg_legacy(rtwdev, pg_tbl, pubq_num);
+	else
+		return __priority_queue_cfg(rtwdev, pg_tbl, pubq_num);
 }
 
 static int init_h2c(struct rtw_dev *rtwdev)
@@ -1203,11 +1249,13 @@ static int rtw_drv_info_cfg(struct rtw_dev *rtwdev)
 	u8 value8;
 
 	rtw_write8(rtwdev, REG_RX_DRVINFO_SZ, PHY_STATUS_SIZE);
-	value8 = rtw_read8(rtwdev, REG_TRXFF_BNDY + 1);
-	value8 &= 0xF0;
-	/* For rxdesc len = 0 issue */
-	value8 |= 0xF;
-	rtw_write8(rtwdev, REG_TRXFF_BNDY + 1, value8);
+	if (rtw_chip_wcpu_11ac(rtwdev)) {
+		value8 = rtw_read8(rtwdev, REG_TRXFF_BNDY + 1);
+		value8 &= 0xF0;
+		/* For rxdesc len = 0 issue */
+		value8 |= 0xF;
+		rtw_write8(rtwdev, REG_TRXFF_BNDY + 1, value8);
+	}
 	rtw_write32_set(rtwdev, REG_RCR, BIT_APP_PHYSTS);
 	rtw_write32_clr(rtwdev, REG_WMAC_OPTION_FUNCTION + 4, BIT(8) | BIT(9));
 
diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wireless/realtek/rtw88/mac.h
index 592dc830160c..ce64cdf7a565 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.h
+++ b/drivers/net/wireless/realtek/rtw88/mac.h
@@ -10,6 +10,7 @@
 #define SDIO_LOCAL_OFFSET	0x10250000
 #define DDMA_POLLING_COUNT	1000
 #define C2H_PKT_BUF		256
+#define REPORT_BUF		128
 #define PHY_STATUS_SIZE		4
 #define ILLEGAL_KEY_GROUP	0xFAAAAA00
 
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index c1e66d656307..00eb6b6a1f5b 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -209,6 +209,19 @@
 #define REG_HMEBOX2_EX		0x01F8
 #define REG_HMEBOX3_EX		0x01FC
 
+#define REG_RQPN		0x0200
+#define BIT_MASK_HPQ		0xff
+#define BIT_SHIFT_HPQ		0
+#define BIT_RQPN_HPQ(x)		(((x) & BIT_MASK_HPQ) << BIT_SHIFT_HPQ)
+#define BIT_MASK_LPQ		0xff
+#define BIT_SHIFT_LPQ		8
+#define BIT_RQPN_LPQ(x)		(((x) & BIT_MASK_LPQ) << BIT_SHIFT_LPQ)
+#define BIT_MASK_PUBQ		0xff
+#define BIT_SHIFT_PUBQ		16
+#define BIT_RQPN_PUBQ(x)	(((x) & BIT_MASK_PUBQ) << BIT_SHIFT_PUBQ)
+#define BIT_RQPN_HLP(h, l, p)	(BIT_LD_RQPN | BIT_RQPN_HPQ(h) |	       \
+				 BIT_RQPN_LPQ(l) | BIT_RQPN_PUBQ(p))
+
 #define REG_FIFOPAGE_CTRL_2	0x0204
 #define BIT_BCN_VALID_V1	BIT(15)
 #define BIT_MASK_BCN_HEAD_1_V1	0xfff
@@ -219,6 +232,18 @@
 #define REG_TXDMA_OFFSET_CHK	0x020C
 #define REG_TXDMA_STATUS	0x0210
 #define BTI_PAGE_OVF		BIT(2)
+
+#define REG_RQPN_NPQ		0x0214
+#define BIT_MASK_NPQ		0xff
+#define BIT_SHIFT_NPQ		0
+#define BIT_MASK_EPQ		0xff
+#define BIT_SHIFT_EPQ		16
+#define BIT_RQPN_NPQ(x)		(((x) & BIT_MASK_NPQ) << BIT_SHIFT_NPQ)
+#define BIT_RQPN_EPQ(x)		(((x) & BIT_MASK_EPQ) << BIT_SHIFT_EPQ)
+#define BIT_RQPN_NE(n, e)	(BIT_RQPN_NPQ(n) | BIT_RQPN_EPQ(e))
+
+#define REG_AUTO_LLT		0x0224
+#define BIT_AUTO_INIT_LLT	BIT(16)
 #define REG_RQPN_CTRL_1		0x0228
 #define REG_RQPN_CTRL_2		0x022C
 #define BIT_LD_RQPN		BIT(31)
@@ -249,6 +274,8 @@
 #define REG_HWSEQ_CTRL		0x0423
 
 #define REG_BCNQ_BDNY_V1	0x0424
+#define REG_BCNQ_BDNY		0x0424
+#define REG_MGQ_BDNY		0x0425
 #define REG_LIFETIME_EN		0x0426
 #define BIT_BA_PARSER_EN	BIT(5)
 #define REG_SPEC_SIFS		0x0428
@@ -264,6 +291,7 @@
 #define BIT_CHECK_CCK_EN	BIT(7)
 #define REG_AMPDU_MAX_TIME_V1	0x0455
 #define REG_BCNQ1_BDNY_V1	0x0456
+#define REG_WMAC_LBK_BF_HD	0x045D
 #define REG_TX_HANG_CTRL	0x045E
 #define BIT_EN_GNT_BT_AWAKE	BIT(3)
 #define BIT_EN_EOF_V1		BIT(2)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index f2d21272b237..c03ed91349e5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -556,6 +556,32 @@ static const struct rtw_pwr_seq_cmd *card_disable_flow_8723d[] = {
 	NULL
 };
 
+static const struct rtw_page_table page_table_8723d[] = {
+	{12, 2, 2, 0, 1},
+	{12, 2, 2, 0, 1},
+	{12, 2, 2, 0, 1},
+	{12, 2, 2, 0, 1},
+	{12, 2, 2, 0, 1},
+};
+
+static const struct rtw_rqpn rqpn_table_8723d[] = {
+	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
+	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
+	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
+	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
+	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
+	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
+	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
+	 RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_HIGH,
+	 RTW_DMA_MAPPING_HIGH, RTW_DMA_MAPPING_HIGH},
+	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
+	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
+	 RTW_DMA_MAPPING_HIGH, RTW_DMA_MAPPING_HIGH},
+	{RTW_DMA_MAPPING_NORMAL, RTW_DMA_MAPPING_NORMAL,
+	 RTW_DMA_MAPPING_LOW, RTW_DMA_MAPPING_LOW,
+	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
+};
+
 static const struct rtw_rf_sipi_addr rtw8723d_rf_sipi_addr[] = {
 	[RF_PATH_A] = { .hssi_1 = 0x820, .lssi_read    = 0x8a0,
 			.hssi_2 = 0x824, .lssi_read_pi = 0x8b8},
@@ -580,17 +606,22 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.phy_efuse_size = 512,
 	.log_efuse_size = 512,
 	.ptct_efuse_size = 96 + 1,
+	.txff_size = 32768,
+	.rxff_size = 16384,
 	.txgi_factor = 1,
 	.is_pwr_by_rate_dec = true,
 	.max_power_index = 0x3f,
 	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G,
+	.page_size = 128,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
 	.sys_func_en = 0xFD,
 	.pwr_on_seq = card_enable_flow_8723d,
 	.pwr_off_seq = card_disable_flow_8723d,
+	.page_table = page_table_8723d,
+	.rqpn_table = rqpn_table_8723d,
 	.rf_sipi_addr = {0x840, 0x844},
 	.rf_sipi_read_addr = rtw8723d_rf_sipi_addr,
 	.fix_rf_phy_num = 2,
-- 
2.17.1

