Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9654678F874
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbjIAGQq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348360AbjIAGQY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:16:24 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8722DEA
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 23:16:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3816FlwV6006384, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3816FlwV6006384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 14:15:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 1 Sep 2023 14:16:13 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 14:16:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: 8922a: add chip_ops::bb_preinit to enable BB before downloading firmware
Date:   Fri, 1 Sep 2023 14:15:05 +0800
Message-ID: <20230901061507.34312-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901061507.34312-1-pkshih@realtek.com>
References: <20230901061507.34312-1-pkshih@realtek.com>
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before downloading firmware for BB MCU, call this ops to enable baseband
hardware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  6 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 6 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 368aaf850b5a..725292f67968 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3032,6 +3032,7 @@ struct rtw89_hci_info {
 struct rtw89_chip_ops {
 	int (*enable_bb_rf)(struct rtw89_dev *rtwdev);
 	int (*disable_bb_rf)(struct rtw89_dev *rtwdev);
+	void (*bb_preinit)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 	void (*bb_reset)(struct rtw89_dev *rtwdev,
 			 enum rtw89_phy_idx phy_idx);
 	void (*bb_sethw)(struct rtw89_dev *rtwdev);
@@ -5026,6 +5027,15 @@ static inline void rtw89_chip_rfe_gpio(struct rtw89_dev *rtwdev)
 		chip->ops->rfe_gpio(rtwdev);
 }
 
+static inline
+void rtw89_chip_bb_preinit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->bb_preinit)
+		chip->ops->bb_preinit(rtwdev, phy_idx);
+}
+
 static inline void rtw89_chip_bb_sethw(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 9a03f7fa9188..1b57c356a7a5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3607,6 +3607,12 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb)
 
 	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
 
+	if (include_bb) {
+		rtw89_chip_bb_preinit(rtwdev, RTW89_PHY_0);
+		if (rtwdev->dbcc_en)
+			rtw89_chip_bb_preinit(rtwdev, RTW89_PHY_1);
+	}
+
 	ret = rtw89_mac_dmac_pre_init(rtwdev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 401c2b68dd5f..7c14638b6474 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2280,6 +2280,7 @@ static int rtw8851b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.enable_bb_rf		= rtw8851b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8851b_mac_disable_bb_rf,
+	.bb_preinit		= NULL,
 	.bb_reset		= rtw8851b_bb_reset,
 	.bb_sethw		= rtw8851b_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 7810f72e8457..fa5ed7b42af6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2025,6 +2025,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8852a = {
 static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.enable_bb_rf		= rtw89_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw89_mac_disable_bb_rf,
+	.bb_preinit		= NULL,
 	.bb_reset		= rtw8852a_bb_reset,
 	.bb_sethw		= rtw8852a_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 38a00c26e2ad..b2bd843451a2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2449,6 +2449,7 @@ static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+	.bb_preinit		= NULL,
 	.bb_reset		= rtw8852b_bb_reset,
 	.bb_sethw		= rtw8852b_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 56d85d5a6eb9..414cc730e442 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2755,6 +2755,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8852c = {
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.enable_bb_rf		= rtw8852c_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852c_mac_disable_bb_rf,
+	.bb_preinit		= NULL,
 	.bb_reset		= rtw8852c_bb_reset,
 	.bb_sethw		= rtw8852c_bb_sethw,
 	.read_rf		= rtw89_phy_read_rf_v1,
-- 
2.25.1

