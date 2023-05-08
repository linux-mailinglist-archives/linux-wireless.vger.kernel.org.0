Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8566FA284
	for <lists+linux-wireless@lfdr.de>; Mon,  8 May 2023 10:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjEHIoF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 May 2023 04:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjEHIoB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 May 2023 04:44:01 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06FE1AEF6
        for <linux-wireless@vger.kernel.org>; Mon,  8 May 2023 01:43:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3488hk353007928, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3488hk353007928
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 8 May 2023 16:43:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 May 2023 16:43:52 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 May 2023
 16:43:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: pci: fix interrupt enable mask for HALT C2H of RTL8851B
Date:   Mon, 8 May 2023 16:43:33 +0800
Message-ID: <20230508084335.42953-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230508084335.42953-1-pkshih@realtek.com>
References: <20230508084335.42953-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

RTL8851B keeps almost the same interrupt flow as RTL8852A and RTL8852B.
But, it uses a different bitmask for interrupt indicator of FW HALT C2H.
So, we make a chip judgement in pci when configuring interrupt mask.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c | 9 +++++++--
 drivers/net/wireless/realtek/rtw89/pci.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index b53f346fef979..92bfef942d3a9 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3216,11 +3216,16 @@ static void rtw89_pci_clear_resource(struct rtw89_dev *rtwdev,
 void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 hs0isr_ind_int_en = B_AX_HS0ISR_IND_INT_EN;
+
+	if (chip->chip_id == RTL8851B)
+		hs0isr_ind_int_en = B_AX_HS0ISR_IND_INT_EN_WKARND;
 
 	rtwpci->halt_c2h_intrs = B_AX_HALT_C2H_INT_EN | 0;
 
 	if (rtwpci->under_recovery) {
-		rtwpci->intrs[0] = B_AX_HS0ISR_IND_INT_EN;
+		rtwpci->intrs[0] = hs0isr_ind_int_en;
 		rtwpci->intrs[1] = 0;
 	} else {
 		rtwpci->intrs[0] = B_AX_TXDMA_STUCK_INT_EN |
@@ -3230,7 +3235,7 @@ void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev)
 				   B_AX_RXDMA_STUCK_INT_EN |
 				   B_AX_RDU_INT_EN |
 				   B_AX_RPQBD_FULL_INT_EN |
-				   B_AX_HS0ISR_IND_INT_EN;
+				   hs0isr_ind_int_en;
 
 		rtwpci->intrs[1] = B_AX_HC10ISR_IND_INT_EN;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 0e4bd210b100f..2f3d1ad3b0f7d 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -150,6 +150,7 @@
 #define B_AX_HD1ISR_IND_INT_EN		BIT(26)
 #define B_AX_HD0ISR_IND_INT_EN		BIT(25)
 #define B_AX_HS0ISR_IND_INT_EN		BIT(24)
+#define B_AX_HS0ISR_IND_INT_EN_WKARND	BIT(23)
 #define B_AX_RETRAIN_INT_EN		BIT(21)
 #define B_AX_RPQBD_FULL_INT_EN		BIT(20)
 #define B_AX_RDU_INT_EN			BIT(19)
-- 
2.25.1

