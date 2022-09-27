Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9045EBA99
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Sep 2022 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiI0G2C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Sep 2022 02:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiI0G2B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Sep 2022 02:28:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC0C3857D6
        for <linux-wireless@vger.kernel.org>; Mon, 26 Sep 2022 23:27:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28R6QlAK2008416, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28R6QlAK2008416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 27 Sep 2022 14:26:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 14:27:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 27 Sep
 2022 14:27:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 8/9] wifi: rtw89: check DLE FIFO size with reserved size
Date:   Tue, 27 Sep 2022 14:26:10 +0800
Message-ID: <20220927062611.30484-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220927062611.30484-1-pkshih@realtek.com>
References: <20220927062611.30484-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/27/2022 06:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjcgpFekyCAwNDo1MzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For SCC mode, some FIFO are reserved, so compare the quantity after minus
the reserved size.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 17 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index be01350ee0e29..db041b32a8c2c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2612,6 +2612,7 @@ struct rtw89_chip_info {
 	const struct rtw89_chip_ops *ops;
 	const char *fw_name;
 	u32 fifo_size;
+	u32 dle_scc_rsvd_size;
 	u16 max_amsdu_limit;
 	bool dis_2g_40m_ul_ofdma;
 	u32 rsvd_ple_ofst;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8fd70730689f8..892fdb7f090ef 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1324,6 +1324,17 @@ static inline u32 dle_used_size(const struct rtw89_dle_size *wde,
 	       ple->pge_size * (ple->lnk_pge_num + ple->unlnk_pge_num);
 }
 
+static u32 dle_expected_used_size(struct rtw89_dev *rtwdev,
+				  enum rtw89_qta_mode mode)
+{
+	u32 size = rtwdev->chip->fifo_size;
+
+	if (mode == RTW89_QTA_SCC)
+		size -= rtwdev->chip->dle_scc_rsvd_size;
+
+	return size;
+}
+
 static void dle_func_en(struct rtw89_dev *rtwdev, bool enable)
 {
 	if (enable)
@@ -1491,7 +1502,8 @@ static int dle_init(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
 		ext_wde_min_qt_wcpu = ext_cfg->wde_min_qt->wcpu;
 	}
 
-	if (dle_used_size(cfg->wde_size, cfg->ple_size) != rtwdev->chip->fifo_size) {
+	if (dle_used_size(cfg->wde_size, cfg->ple_size) !=
+	    dle_expected_used_size(rtwdev, mode)) {
 		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
 		ret = -EINVAL;
 		goto error;
@@ -2604,7 +2616,8 @@ static int dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
 		return -EINVAL;
 	}
 
-	if (dle_used_size(cfg->wde_size, cfg->ple_size) != rtwdev->chip->fifo_size) {
+	if (dle_used_size(cfg->wde_size, cfg->ple_size) !=
+	    dle_expected_used_size(rtwdev, mode)) {
 		rtw89_err(rtwdev, "[ERR]wd/dle mem cfg\n");
 		return -EINVAL;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 948a2027ed69c..7841476803535 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2190,6 +2190,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ops			= &rtw8852a_chip_ops,
 	.fw_name		= "rtw89/rtw8852a_fw.bin",
 	.fifo_size		= 458752,
+	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 3500,
 	.dis_2g_40m_ul_ofdma	= true,
 	.rsvd_ple_ofst		= 0x6f800,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 799da0c9f75ad..8428614a3b150 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -66,6 +66,8 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
+	.fifo_size		= 196608,
+	.dle_scc_rsvd_size	= 98304,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c8c0d68e16014..67653b3e1a356 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3039,6 +3039,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
 	.fifo_size		= 458752,
+	.dle_scc_rsvd_size	= 0,
 	.max_amsdu_limit	= 8000,
 	.dis_2g_40m_ul_ofdma	= false,
 	.rsvd_ple_ofst		= 0x6f800,
-- 
2.25.1

