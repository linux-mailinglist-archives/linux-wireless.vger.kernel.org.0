Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5197B79A5EC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjIKIWU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjIKIWS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CB8E7
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:13 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8M4WF01002935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8M4WF01002935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:22:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Sep 2023 16:22:04 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:22:03 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: add chip_info::txwd_info size to generalize TX WD submit
Date:   Mon, 11 Sep 2023 16:20:47 +0800
Message-ID: <20230911082049.33541-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911082049.33541-1-pkshih@realtek.com>
References: <20230911082049.33541-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For existing chips, size of TX WD info is 6 words, but upcoming WiFi 7
chips become 8 words, so add a chip_info to reuse the code.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 1 +
 drivers/net/wireless/realtek/rtw89/pci.c      | 3 +--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 6 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 72327b67c4f3..77d283db4f49 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3575,6 +3575,7 @@ struct rtw89_chip_info {
 	u32 hci_func_en_addr;
 	u32 h2c_desc_size;
 	u32 txwd_body_size;
+	u32 txwd_info_size;
 	u32 h2c_ctrl_reg;
 	const u32 *h2c_regs;
 	struct rtw89_reg_def h2c_counter_reg;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 3a4bfc44142b..14ddb0d39e63 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1196,7 +1196,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
-	struct rtw89_txwd_info *txwd_info;
 	struct rtw89_pci_tx_wp_info *txwp_info;
 	void *txaddr_info_addr;
 	struct pci_dev *pdev = rtwpci->pdev;
@@ -1222,7 +1221,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 
 	txwp_len = sizeof(*txwp_info);
 	txwd_len = chip->txwd_body_size;
-	txwd_len += en_wd_info ? sizeof(*txwd_info) : 0;
+	txwd_len += en_wd_info ? chip->txwd_info_size : 0;
 
 	txwp_info = txwd->vaddr + txwd_len;
 	txwp_info->seq0 = cpu_to_le16(txwd->seq | RTW89_PCI_TXWP_VALID);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 7c14638b6474..f4ef2a7e4b1a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2421,6 +2421,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
 	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8851b_h2c_regs,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index fa5ed7b42af6..db2eb93ef87f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2159,6 +2159,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
 	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8852a_h2c_regs,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index b2bd843451a2..f6222e9c7eda 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2592,6 +2592,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
 	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8852b_h2c_regs,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7f80e0bf40a4..cba55f0d8486 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2896,6 +2896,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v1),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL_V1,
 	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8852c_h2c_regs,
-- 
2.25.1

