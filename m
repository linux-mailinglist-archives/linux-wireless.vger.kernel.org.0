Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A05AB2E3
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238771AbiIBOFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbiIBOEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:04:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 926A91306C0
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 06:32:59 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 282CiUxfD014091, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 282CiUxfD014091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 2 Sep 2022 20:44:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 2 Sep 2022 20:44:47 +0800
Received: from localhost (172.16.17.75) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 2 Sep 2022
 20:44:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: parse phycap of TX/RX antenna number
Date:   Fri, 2 Sep 2022 20:44:19 +0800
Message-ID: <20220902124422.13610-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902124422.13610-1-pkshih@realtek.com>
References: <20220902124422.13610-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.75]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/02/2022 12:31:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMiCkV6TIIDA3OjQ1OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Two fields, TX/RX ANT NUM, are introduced to address variant TX/RX antenna
number of hardware. For example, a 1x1 chip with TX diversity, TX NSS = 1
and TX/RX ANT NUM = 2.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 ++-
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5fa61eb24f06..3f944e631ee23 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2823,6 +2823,7 @@ struct rtw89_hal {
 	u32 antenna_rx;
 	u8 tx_nss;
 	u8 rx_nss;
+	bool tx_path_diversity;
 	bool support_cckpd;
 	bool support_igi;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a845575124486..f7b30b767c3dc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2264,6 +2264,8 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 	struct rtw89_mac_c2h_info c2h_info = {0};
 	u8 tx_nss;
 	u8 rx_nss;
+	u8 tx_ant;
+	u8 rx_ant;
 	u32 ret;
 
 	ret = rtw89_mac_read_phycap(rtwdev, &c2h_info);
@@ -2272,14 +2274,30 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 
 	tx_nss = RTW89_GET_C2H_PHYCAP_TX_NSS(c2h_info.c2hreg);
 	rx_nss = RTW89_GET_C2H_PHYCAP_RX_NSS(c2h_info.c2hreg);
+	tx_ant = RTW89_GET_C2H_PHYCAP_ANT_TX_NUM(c2h_info.c2hreg);
+	rx_ant = RTW89_GET_C2H_PHYCAP_ANT_RX_NUM(c2h_info.c2hreg);
 
 	hal->tx_nss = tx_nss ? min_t(u8, tx_nss, chip->tx_nss) : chip->tx_nss;
 	hal->rx_nss = rx_nss ? min_t(u8, rx_nss, chip->rx_nss) : chip->rx_nss;
 
+	if (tx_ant == 1)
+		hal->antenna_tx = RF_B;
+	if (rx_ant == 1)
+		hal->antenna_rx = RF_B;
+
+	if (tx_nss == 1 && tx_ant == 2 && rx_ant == 2) {
+		hal->antenna_tx = RF_B;
+		hal->tx_path_diversity = true;
+	}
+
 	rtw89_debug(rtwdev, RTW89_DBG_FW,
 		    "phycap hal/phy/chip: tx_nss=0x%x/0x%x/0x%x rx_nss=0x%x/0x%x/0x%x\n",
 		    hal->tx_nss, tx_nss, chip->tx_nss,
 		    hal->rx_nss, rx_nss, chip->rx_nss);
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "ant num/bitmap: tx=%d/0x%x rx=%d/0x%x\n",
+		    tx_ant, hal->antenna_tx, rx_ant, hal->antenna_rx);
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "TX path diversity=%d\n", hal->tx_path_diversity);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 668370cf8158a..a8c711ea5d456 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -674,12 +674,13 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	if (rx_ant != hw->wiphy->available_antennas_rx)
+	if (rx_ant != hw->wiphy->available_antennas_rx && rx_ant != hal->antenna_rx)
 		return -EINVAL;
 
 	mutex_lock(&rtwdev->mutex);
 	hal->antenna_tx = tx_ant;
 	hal->antenna_rx = rx_ant;
+	hal->tx_path_diversity = false;
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
-- 
2.25.1

