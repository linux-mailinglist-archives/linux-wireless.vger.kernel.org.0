Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA5E7E7680
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345556AbjKJBYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345552AbjKJBY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8B6182
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1OIwxC1890540, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1OIwxC1890540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Nov 2023 09:24:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: pci: update interrupt mitigation register for 8922AE
Date:   Fri, 10 Nov 2023 09:23:19 +0800
Message-ID: <20231110012319.12727-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110012319.12727-1-pkshih@realtek.com>
References: <20231110012319.12727-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To reduce interrupts, configure the mitigation setting of 8922AE when
bringing interface up, and then check situations to decide turning on or
off the function. With this, interrupt count decreases to 20,141 from
202,141 in period of 20 seconds.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c       | 11 +++++++++--
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 09de12a9e3c2..0ca07ae63594 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -3620,19 +3620,26 @@ static void rtw89_pci_aspm_set(struct rtw89_dev *rtwdev, bool enable)
 
 static void rtw89_pci_recalc_int_mit(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
 	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	struct rtw89_traffic_stats *stats = &rtwdev->stats;
 	enum rtw89_tfc_lv tx_tfc_lv = stats->tx_tfc_lv;
 	enum rtw89_tfc_lv rx_tfc_lv = stats->rx_tfc_lv;
 	u32 val = 0;
 
-	if (!rtwdev->scanning &&
-	    (tx_tfc_lv >= RTW89_TFC_HIGH || rx_tfc_lv >= RTW89_TFC_HIGH))
+	if (rtwdev->scanning ||
+	    (tx_tfc_lv < RTW89_TFC_HIGH && rx_tfc_lv < RTW89_TFC_HIGH))
+		goto out;
+
+	if (chip_gen == RTW89_CHIP_BE)
+		val = B_BE_PCIE_MIT_RX0P2_EN | B_BE_PCIE_MIT_RX0P1_EN;
+	else
 		val = B_AX_RXMIT_RXP2_SEL | B_AX_RXMIT_RXP1_SEL |
 		      FIELD_PREP(B_AX_RXCOUNTER_MATCH_MASK, RTW89_PCI_RXBD_NUM_MAX / 2) |
 		      FIELD_PREP(B_AX_RXTIMER_UNIT_MASK, AX_RXTIMER_UNIT_64US) |
 		      FIELD_PREP(B_AX_RXTIMER_MATCH_MASK, 2048 / 64);
 
+out:
 	rtw89_write32(rtwdev, info->mit_addr, val);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 2a9ad5a254d8..414635d301aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -43,6 +43,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 
 	.rpwm_addr		= R_BE_PCIE_HRPWM,
 	.cpwm_addr		= R_BE_PCIE_CRPWM,
+	.mit_addr		= R_BE_PCIE_MIT_CH_EN,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_be,
-- 
2.25.1

