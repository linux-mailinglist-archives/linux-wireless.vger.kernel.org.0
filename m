Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E831CF247
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgELK04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:26:56 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36520 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgELK0g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:26:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAQPYf8009505, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAQPYf8009505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:26:25 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:24 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:24 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3 5/9] rtw88: 8723d: implement flush queue
Date:   Tue, 12 May 2020 18:26:17 +0800
Message-ID: <20200512102621.5148-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512102621.5148-1-yhchuang@realtek.com>
References: <20200512102621.5148-1-yhchuang@realtek.com>
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

Flush queue is used to check if queue is empty, before doing something
else. Since 8723D uses different registers and page number of
availabl/reserved occupy 8 bits instead of 16 bits, so use a 'wsize' field
to discriminate which rtw_read{8,16} is adopted.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c      | 29 +++++++------------
 drivers/net/wireless/realtek/rtw88/main.h     | 11 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 17 +++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 17 +++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 17 +++++++++++
 5 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index e8ffeb338584..3a5cfebe5a62 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -919,31 +919,24 @@ static u32 get_priority_queues(struct rtw_dev *rtwdev, u32 queues)
 static void __rtw_mac_flush_prio_queue(struct rtw_dev *rtwdev,
 				       u32 prio_queue, bool drop)
 {
-	u32 addr;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_prioq_addr *addr;
+	bool wsize;
 	u16 avail_page, rsvd_page;
 	int i;
 
-	switch (prio_queue) {
-	case RTW_DMA_MAPPING_EXTRA:
-		addr = REG_FIFOPAGE_INFO_4;
-		break;
-	case RTW_DMA_MAPPING_LOW:
-		addr = REG_FIFOPAGE_INFO_2;
-		break;
-	case RTW_DMA_MAPPING_NORMAL:
-		addr = REG_FIFOPAGE_INFO_3;
-		break;
-	case RTW_DMA_MAPPING_HIGH:
-		addr = REG_FIFOPAGE_INFO_1;
-		break;
-	default:
+	if (prio_queue >= RTW_DMA_MAPPING_MAX)
 		return;
-	}
+
+	addr = &chip->prioq_addrs->prio[prio_queue];
+	wsize = chip->prioq_addrs->wsize;
 
 	/* check if all of the reserved pages are available for 100 msecs */
 	for (i = 0; i < 5; i++) {
-		rsvd_page = rtw_read16(rtwdev, addr);
-		avail_page = rtw_read16(rtwdev, addr + 2);
+		rsvd_page = wsize ? rtw_read16(rtwdev, addr->rsvd) :
+				     rtw_read8(rtwdev, addr->rsvd);
+		avail_page = wsize ? rtw_read16(rtwdev, addr->avail) :
+				      rtw_read8(rtwdev, addr->avail);
 		if (rsvd_page == avail_page)
 			return;
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 592b28ed9376..28f88c44cb84 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -945,6 +945,16 @@ struct rtw_rqpn {
 	enum rtw_dma_mapping dma_map_hi;
 };
 
+struct rtw_prioq_addr {
+	u32 rsvd;
+	u32 avail;
+};
+
+struct rtw_prioq_addrs {
+	struct rtw_prioq_addr prio[RTW_DMA_MAPPING_MAX];
+	bool wsize;
+};
+
 struct rtw_page_table {
 	u16 hq_num;
 	u16 nq_num;
@@ -1101,6 +1111,7 @@ struct rtw_chip_info {
 	const struct rtw_pwr_seq_cmd **pwr_on_seq;
 	const struct rtw_pwr_seq_cmd **pwr_off_seq;
 	const struct rtw_rqpn *rqpn_table;
+	const struct rtw_prioq_addrs *prioq_addrs;
 	const struct rtw_page_table *page_table;
 	const struct rtw_intf_phy_para_table *intf_table;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index bfad27d10c40..66bf907131d7 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2237,6 +2237,22 @@ static const struct rtw_rqpn rqpn_table_8723d[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
+static const struct rtw_prioq_addrs prioq_addrs_8723d = {
+	.prio[RTW_DMA_MAPPING_EXTRA] = {
+		.rsvd = REG_RQPN_NPQ + 2, .avail = REG_RQPN_NPQ + 3,
+	},
+	.prio[RTW_DMA_MAPPING_LOW] = {
+		.rsvd = REG_RQPN + 1, .avail = REG_FIFOPAGE_CTRL_2 + 1,
+	},
+	.prio[RTW_DMA_MAPPING_NORMAL] = {
+		.rsvd = REG_RQPN_NPQ, .avail = REG_RQPN_NPQ + 1,
+	},
+	.prio[RTW_DMA_MAPPING_HIGH] = {
+		.rsvd = REG_RQPN, .avail = REG_FIFOPAGE_CTRL_2,
+	},
+	.wsize = false,
+};
+
 static const struct rtw_intf_phy_para pcie_gen1_param_8723d[] = {
 	{0x0008, 0x4a22,
 	 RTW_IP_SEL_PHY,
@@ -2370,6 +2386,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.pwr_off_seq = card_disable_flow_8723d,
 	.page_table = page_table_8723d,
 	.rqpn_table = rqpn_table_8723d,
+	.prioq_addrs = &prioq_addrs_8723d,
 	.intf_table = &phy_para_table_8723d,
 	.dig = rtw8723d_dig,
 	.dig_cck = rtw8723d_dig_cck,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 45636382dafd..22a7baeb87f6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2083,6 +2083,22 @@ static const struct rtw_rqpn rqpn_table_8822b[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
+static struct rtw_prioq_addrs prioq_addrs_8822b = {
+	.prio[RTW_DMA_MAPPING_EXTRA] = {
+		.rsvd = REG_FIFOPAGE_INFO_4, .avail = REG_FIFOPAGE_INFO_4 + 2,
+	},
+	.prio[RTW_DMA_MAPPING_LOW] = {
+		.rsvd = REG_FIFOPAGE_INFO_2, .avail = REG_FIFOPAGE_INFO_2 + 2,
+	},
+	.prio[RTW_DMA_MAPPING_NORMAL] = {
+		.rsvd = REG_FIFOPAGE_INFO_3, .avail = REG_FIFOPAGE_INFO_3 + 2,
+	},
+	.prio[RTW_DMA_MAPPING_HIGH] = {
+		.rsvd = REG_FIFOPAGE_INFO_1, .avail = REG_FIFOPAGE_INFO_1 + 2,
+	},
+	.wsize = true,
+};
+
 static struct rtw_chip_ops rtw8822b_ops = {
 	.phy_set_param		= rtw8822b_phy_set_param,
 	.read_efuse		= rtw8822b_read_efuse,
@@ -2433,6 +2449,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.pwr_off_seq = card_disable_flow_8822b,
 	.page_table = page_table_8822b,
 	.rqpn_table = rqpn_table_8822b,
+	.prioq_addrs = &prioq_addrs_8822b,
 	.intf_table = &phy_para_table_8822b,
 	.dig = rtw8822b_dig,
 	.dig_cck = NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 64b77a7cbffd..e4b184485cad 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3933,6 +3933,22 @@ static const struct rtw_rqpn rqpn_table_8822c[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
+static struct rtw_prioq_addrs prioq_addrs_8822c = {
+	.prio[RTW_DMA_MAPPING_EXTRA] = {
+		.rsvd = REG_FIFOPAGE_INFO_4, .avail = REG_FIFOPAGE_INFO_4 + 2,
+	},
+	.prio[RTW_DMA_MAPPING_LOW] = {
+		.rsvd = REG_FIFOPAGE_INFO_2, .avail = REG_FIFOPAGE_INFO_2 + 2,
+	},
+	.prio[RTW_DMA_MAPPING_NORMAL] = {
+		.rsvd = REG_FIFOPAGE_INFO_3, .avail = REG_FIFOPAGE_INFO_3 + 2,
+	},
+	.prio[RTW_DMA_MAPPING_HIGH] = {
+		.rsvd = REG_FIFOPAGE_INFO_1, .avail = REG_FIFOPAGE_INFO_1 + 2,
+	},
+	.wsize = true,
+};
+
 static struct rtw_chip_ops rtw8822c_ops = {
 	.phy_set_param		= rtw8822c_phy_set_param,
 	.read_efuse		= rtw8822c_read_efuse,
@@ -4295,6 +4311,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.pwr_off_seq = card_disable_flow_8822c,
 	.page_table = page_table_8822c,
 	.rqpn_table = rqpn_table_8822c,
+	.prioq_addrs = &prioq_addrs_8822c,
 	.intf_table = &phy_para_table_8822c,
 	.dig = rtw8822c_dig,
 	.dig_cck = NULL,
-- 
2.17.1

