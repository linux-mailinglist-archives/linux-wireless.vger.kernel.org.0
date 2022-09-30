Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE175F0CAA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 15:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiI3Npu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiI3Npm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 09:45:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAE263AB09
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 06:45:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28UDiWMF1006177, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28UDiWMF1006177
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 30 Sep 2022 21:44:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 30 Sep 2022 21:44:58 +0800
Received: from localhost (172.16.20.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 30 Sep
 2022 21:44:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: add to dump TX FIFO 0/1 for 8852C
Date:   Fri, 30 Sep 2022 21:44:17 +0800
Message-ID: <20220930134417.10282-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930134417.10282-1-pkshih@realtek.com>
References: <20220930134417.10282-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.103]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/30/2022 13:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMzAgpFekyCAxMToxNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MAC maintains TX FIFO to transmit packets with meta data to BB layer. To
debug abnormal transmission, we need to dump the content to dig problem.
Since FIFO of 8852C locates on different address with different size and
need additional switch to enable read operation, this patch adds the
changes accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 21 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c   |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.h   |  4 ++++
 3 files changed, 27 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 730e83d54257f..89bf4c20d96ce 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -770,13 +770,34 @@ rtw89_debug_priv_mac_mem_dump_get(struct seq_file *m, void *v)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	bool grant_read = false;
+
+	if (debugfs_priv->mac_mem.sel >= RTW89_MAC_MEM_NUM)
+		return -ENOENT;
+
+	if (rtwdev->chip->chip_id == RTL8852C) {
+		switch (debugfs_priv->mac_mem.sel) {
+		case RTW89_MAC_MEM_TXD_FIFO_0_V1:
+		case RTW89_MAC_MEM_TXD_FIFO_1_V1:
+		case RTW89_MAC_MEM_TXDATA_FIFO_0:
+		case RTW89_MAC_MEM_TXDATA_FIFO_1:
+			grant_read = true;
+			break;
+		default:
+			break;
+		}
+	}
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
+	if (grant_read)
+		rtw89_write32_set(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
 	rtw89_debug_dump_mac_mem(m, rtwdev,
 				 debugfs_priv->mac_mem.sel,
 				 debugfs_priv->mac_mem.start,
 				 debugfs_priv->mac_mem.len);
+	if (grant_read)
+		rtw89_write32_clr(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0508dfca8edf7..e0bce60db2599 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -31,6 +31,8 @@ const u32 rtw89_mac_mem_base_addrs[RTW89_MAC_MEM_NUM] = {
 	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR,
 	[RTW89_MAC_MEM_CPU_LOCAL]	= CPU_LOCAL_BASE_ADDR,
 	[RTW89_MAC_MEM_BSSID_CAM]	= BSSID_CAM_BASE_ADDR,
+	[RTW89_MAC_MEM_TXD_FIFO_0_V1]	= TXD_FIFO_0_BASE_ADDR_V1,
+	[RTW89_MAC_MEM_TXD_FIFO_1_V1]	= TXD_FIFO_1_BASE_ADDR_V1,
 };
 
 static void rtw89_mac_mem_write(struct rtw89_dev *rtwdev, u32 offset,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6f4ada1869a17..a9867ac351da7 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -245,6 +245,8 @@ enum rtw89_mac_dbg_port_sel {
 #define	BCN_IE_CAM1_BASE_ADDR		0x188A0000
 #define	TXD_FIFO_0_BASE_ADDR		0x18856200
 #define	TXD_FIFO_1_BASE_ADDR		0x188A1080
+#define	TXD_FIFO_0_BASE_ADDR_V1		0x18856400 /* for 8852C */
+#define	TXD_FIFO_1_BASE_ADDR_V1		0x188A1080 /* for 8852C */
 #define	TXDATA_FIFO_0_BASE_ADDR		0x18856000
 #define	TXDATA_FIFO_1_BASE_ADDR		0x188A1000
 #define	CPU_LOCAL_BASE_ADDR		0x18003000
@@ -271,6 +273,8 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_TXDATA_FIFO_1,
 	RTW89_MAC_MEM_CPU_LOCAL,
 	RTW89_MAC_MEM_BSSID_CAM,
+	RTW89_MAC_MEM_TXD_FIFO_0_V1,
+	RTW89_MAC_MEM_TXD_FIFO_1_V1,
 
 	/* keep last */
 	RTW89_MAC_MEM_NUM,
-- 
2.25.1

