Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5C6E22E5
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjDNMML (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjDNMMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:12:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE83E8
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:12:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33ECBYgB4007089, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33ECBYgB4007089
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 14 Apr 2023 20:11:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 14 Apr 2023 20:11:57 +0800
Received: from localhost (172.16.20.53) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Apr
 2023 20:11:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/8] wifi: rtw88: 8822c: extend reserved page number
Date:   Fri, 14 Apr 2023 20:11:30 +0800
Message-ID: <20230414121135.17828-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230414121135.17828-1-pkshih@realtek.com>
References: <20230414121135.17828-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.53]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Extend 8822c's reserved page number to accommodate additional required
pages. Reserved page is an area of memory in the FIFO dedicated for
special purposes. Previously only one interface is supported so 8 pages
should suffice, extend it so we can support 2 interfaces concurrently.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw88/mac.c      | 2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 6 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 44e07b61b9b9c..a168f36c38ece 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -1119,7 +1119,7 @@ static int set_trx_fifo_info(struct rtw_dev *rtwdev)
 	u8 csi_buf_pg_num = chip->csi_buf_pg_num;
 
 	/* config rsvd page num */
-	fifo->rsvd_drv_pg_num = 8;
+	fifo->rsvd_drv_pg_num = chip->rsvd_drv_pg_num;
 	fifo->txff_pg_num = chip->txff_size >> 7;
 	if (rtw_chip_wcpu_11n(rtwdev))
 		fifo->rsvd_pg_num = fifo->rsvd_drv_pg_num;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 790ebf781bc41..532c56219a5f5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1177,6 +1177,7 @@ struct rtw_chip_info {
 	u32 txff_size;
 	u32 rxff_size;
 	u32 fw_rxff_size;
+	u16 rsvd_drv_pg_num;
 	u8 band;
 	u8 page_size;
 	u8 csi_buf_pg_num;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 2d2f768bae2ea..06e7454c9ca69 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2743,6 +2743,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.ptct_efuse_size = 96 + 1,
 	.txff_size = 32768,
 	.rxff_size = 16384,
+	.rsvd_drv_pg_num = 8,
 	.txgi_factor = 1,
 	.is_pwr_by_rate_dec = true,
 	.max_power_index = 0x3f,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 7ae0541d7b995..e538367683784 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1920,6 +1920,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.ptct_efuse_size = 96,
 	.txff_size = 65536,
 	.rxff_size = 16384,
+	.rsvd_drv_pg_num = 8,
 	.txgi_factor = 1,
 	.is_pwr_by_rate_dec = true,
 	.max_power_index = 0x3f,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 531b67787e2eb..3017a9760da8d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2540,6 +2540,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.txff_size = 262144,
 	.rxff_size = 24576,
 	.fw_rxff_size = 12288,
+	.rsvd_drv_pg_num = 8,
 	.txgi_factor = 1,
 	.is_pwr_by_rate_dec = true,
 	.max_power_index = 0x3f,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 5a2c004b12df1..cd965edc29cea 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5358,6 +5358,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.txff_size = 262144,
 	.rxff_size = 24576,
 	.fw_rxff_size = 12288,
+	.rsvd_drv_pg_num = 16,
 	.txgi_factor = 2,
 	.is_pwr_by_rate_dec = false,
 	.max_power_index = 0x7f,
-- 
2.25.1

