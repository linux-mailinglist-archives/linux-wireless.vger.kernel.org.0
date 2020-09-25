Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877B6278073
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 08:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgIYGTg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 02:19:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39827 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIYGTg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:36 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P6CMvU4010490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P6CMvU4010490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 14:12:22 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 14:12:22 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <yhchuang@realtek.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/5] rtw88: add dump firmware fifo support
Date:   Fri, 25 Sep 2020 14:12:17 +0800
Message-ID: <20200925061219.23754-4-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925061219.23754-1-tehuang@realtek.com>
References: <20200925061219.23754-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Rtw88 currently has a function to dump reserved page section of the
firmware fifo. Reserved page is just part of the firmware fifo, there
are multiple sections in the firmware fifo for different usages, such as
firmware rx fifo and tx fifo.
This commit adds a function to check not only the reserved page section
but also other parts of the firmware fifo. In addition, we need to dump
firmware fifo to dump the debug log message if firmware crashes.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    |  3 +-
 drivers/net/wireless/realtek/rtw88/fw.c       | 77 +++++++++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       |  3 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 14 ++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  3 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  3 +
 6 files changed, 85 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 985cf5d60615..bff6ce19345a 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -229,7 +229,8 @@ static int rtw_debugfs_get_rsvd_page(struct seq_file *m, void *v)
 	if (!buf)
 		return -ENOMEM;
 
-	ret = rtw_dump_drv_rsvd_page(rtwdev, offset, buf_size, (u32 *)buf);
+	ret = rtw_fw_dump_fifo(rtwdev, RTW_FW_FIFO_SEL_RSVD_PAGE, offset,
+			       buf_size, (u32 *)buf);
 	if (ret) {
 		rtw_err(rtwdev, "failed to dump rsvd page\n");
 		vfree(buf);
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 6a50bb993caf..042015bc8055 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1413,29 +1413,16 @@ int rtw_fw_download_rsvd_page(struct rtw_dev *rtwdev)
 	return ret;
 }
 
-int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
-			   u32 offset, u32 size, u32 *buf)
+static void rtw_fw_read_fifo_page(struct rtw_dev *rtwdev, u32 offset, u32 size,
+				  u32 *buf, u32 residue, u16 start_pg)
 {
-	struct rtw_fifo_conf *fifo = &rtwdev->fifo;
-	u32 residue, i;
-	u16 start_pg;
+	u32 i;
 	u16 idx = 0;
 	u16 ctl;
 	u8 rcr;
 
-	if (size & 0x3) {
-		rtw_warn(rtwdev, "should be 4-byte aligned\n");
-		return -EINVAL;
-	}
-
-	offset += fifo->rsvd_boundary << TX_PAGE_SIZE_SHIFT;
-	residue = offset & (FIFO_PAGE_SIZE - 1);
-	start_pg = offset >> FIFO_PAGE_SIZE_SHIFT;
-	start_pg += RSVD_PAGE_START_ADDR;
-
 	rcr = rtw_read8(rtwdev, REG_RCR + 2);
 	ctl = rtw_read16(rtwdev, REG_PKTBUF_DBG_CTRL) & 0xf000;
-
 	/* disable rx clock gate */
 	rtw_write8(rtwdev, REG_RCR, rcr | BIT(3));
 
@@ -1457,6 +1444,64 @@ int rtw_dump_drv_rsvd_page(struct rtw_dev *rtwdev,
 out:
 	rtw_write16(rtwdev, REG_PKTBUF_DBG_CTRL, ctl);
 	rtw_write8(rtwdev, REG_RCR + 2, rcr);
+}
+
+static void rtw_fw_read_fifo(struct rtw_dev *rtwdev, enum rtw_fw_fifo_sel sel,
+			     u32 offset, u32 size, u32 *buf)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u32 start_pg, residue;
+
+	if (sel >= RTW_FW_FIFO_MAX) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "wrong fw fifo sel\n");
+		return;
+	}
+	if (sel == RTW_FW_FIFO_SEL_RSVD_PAGE)
+		offset += rtwdev->fifo.rsvd_boundary << TX_PAGE_SIZE_SHIFT;
+	residue = offset & (FIFO_PAGE_SIZE - 1);
+	start_pg = (offset >> FIFO_PAGE_SIZE_SHIFT) + chip->fw_fifo_addr[sel];
+
+	rtw_fw_read_fifo_page(rtwdev, offset, size, buf, residue, start_pg);
+}
+
+static bool rtw_fw_dump_check_size(struct rtw_dev *rtwdev,
+				   enum rtw_fw_fifo_sel sel,
+				   u32 start_addr, u32 size)
+{
+	switch (sel) {
+	case RTW_FW_FIFO_SEL_TX:
+	case RTW_FW_FIFO_SEL_RX:
+		if ((start_addr + size) > rtwdev->chip->fw_fifo_addr[sel])
+			return false;
+		/*fall through*/
+	default:
+		return true;
+	}
+}
+
+int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
+		     u32 *buffer)
+{
+	if (!rtwdev->chip->fw_fifo_addr) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "chip not support dump fw fifo\n");
+		return -ENOTSUPP;
+	}
+
+	if (size == 0 || !buffer)
+		return -EINVAL;
+
+	if (size & 0x3) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "not 4byte alignment\n");
+		return -EINVAL;
+	}
+
+	if (!rtw_fw_dump_check_size(rtwdev, fifo_sel, addr, size)) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "fw fifo dump size overflow\n");
+		return -EINVAL;
+	}
+
+	rtw_fw_read_fifo(rtwdev, fifo_sel, addr, size, buffer);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index b4e3f755e8fb..9c4863c011ba 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -16,7 +16,6 @@
 
 #define FIFO_PAGE_SIZE_SHIFT		12
 #define FIFO_PAGE_SIZE			4096
-#define RSVD_PAGE_START_ADDR		0x780
 #define FIFO_DUMP_ADDR			0x8000
 
 #define DLFW_PAGE_SIZE_SHIFT_LEGACY	12
@@ -565,5 +564,7 @@ void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
 void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable);
 void rtw_fw_h2c_cmd_dbg(struct rtw_dev *rtwdev, u8 *h2c);
 void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev);
+int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
+		     u32 *buffer);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 292336387b89..06bdc68555e7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1083,6 +1083,17 @@ enum rtw_wlan_cpu {
 	RTW_WCPU_11N,
 };
 
+enum rtw_fw_fifo_sel {
+	RTW_FW_FIFO_SEL_TX,
+	RTW_FW_FIFO_SEL_RX,
+	RTW_FW_FIFO_SEL_RSVD_PAGE,
+	RTW_FW_FIFO_SEL_REPORT,
+	RTW_FW_FIFO_SEL_LLT,
+	RTW_FW_FIFO_SEL_RXBUF_FW,
+
+	RTW_FW_FIFO_MAX,
+};
+
 /* hardware configuration for each IC */
 struct rtw_chip_info {
 	struct rtw_chip_ops *ops;
@@ -1099,6 +1110,7 @@ struct rtw_chip_info {
 	u32 ptct_efuse_size;
 	u32 txff_size;
 	u32 rxff_size;
+	u32 fw_rxff_size;
 	u8 band;
 	u8 page_size;
 	u8 csi_buf_pg_num;
@@ -1109,6 +1121,8 @@ struct rtw_chip_info {
 	bool rx_ldpc;
 	u8 max_power_index;
 
+	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
+
 	bool ht_supported;
 	bool vht_supported;
 	u8 lps_deep_mode_supported;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index b7a98dbbb09c..22d0dd640ac9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2442,6 +2442,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.ptct_efuse_size = 96,
 	.txff_size = 262144,
 	.rxff_size = 24576,
+	.fw_rxff_size = 12288,
 	.txgi_factor = 1,
 	.is_pwr_by_rate_dec = true,
 	.max_power_index = 0x3f,
@@ -2504,6 +2505,8 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 
 	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822b),
 	.coex_info_hw_regs = coex_info_hw_regs_8822b,
+
+	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
 };
 EXPORT_SYMBOL(rtw8822b_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index dd216a23fc99..e37300e98517 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4294,6 +4294,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.ptct_efuse_size = 124,
 	.txff_size = 262144,
 	.rxff_size = 24576,
+	.fw_rxff_size = 12288,
 	.txgi_factor = 2,
 	.is_pwr_by_rate_dec = false,
 	.max_power_index = 0x7f,
@@ -4364,6 +4365,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 
 	.coex_info_hw_regs_num = ARRAY_SIZE(coex_info_hw_regs_8822c),
 	.coex_info_hw_regs = coex_info_hw_regs_8822c,
+
+	.fw_fifo_addr = {0x780, 0x700, 0x780, 0x660, 0x650, 0x680},
 };
 EXPORT_SYMBOL(rtw8822c_hw_spec);
 
-- 
2.17.1

