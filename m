Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E274D6EC68E
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjDXGxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 02:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjDXGxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 02:53:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D943112D
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 23:53:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O6r8tZ5029972, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O6r8tZ5029972
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 14:53:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 24 Apr 2023 14:53:09 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 24 Apr
 2023 14:53:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: 8851b: rfk: add AACK
Date:   Mon, 24 Apr 2023 14:52:39 +0800
Message-ID: <20230424065242.17477-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424065242.17477-1-pkshih@realtek.com>
References: <20230424065242.17477-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Automatic amplitude control calibration (AACK) is the calibration to ensure
the oscillator is biased for a constant output amplitude. We do this
calibration if card does power on.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  6 +++
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 42 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |  1 +
 3 files changed, 49 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 266e4231b5f34..c840a96b79f23 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3776,15 +3776,21 @@
 #define RR_LOGEN 0xa3
 #define RR_LOGEN_RPT GENMASK(19, 16)
 #define RR_SX 0xaf
+#define RR_IBD 0xc9
+#define RR_IBD_VAL GENMASK(4, 0)
 #define RR_LDO 0xb1
 #define RR_LDO_SEL GENMASK(8, 6)
 #define RR_VCO 0xb2
+#define RR_VCO_SEL GENMASK(9, 8)
+#define RR_VCI 0xb3
+#define RR_VCI_ON BIT(7)
 #define RR_LPF 0xb7
 #define RR_LPF_BUSY BIT(8)
 #define RR_XTALX2 0xb8
 #define RR_MALSEL 0xbe
 #define RR_SYNFB 0xc5
 #define RR_SYNFB_LK BIT(15)
+#define RR_AACK 0xca
 #define RR_LCKST 0xcf
 #define RR_LCKST_BIN BIT(0)
 #define RR_LCK_TRG 0xd3
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 9276e852bb051..471ed1a634765 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -17,6 +17,48 @@ static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return RF_A;
 }
 
+void rtw8851b_aack(struct rtw89_dev *rtwdev)
+{
+	u32 tmp05, ib[4];
+	u32 tmp;
+	int ret;
+	int rek;
+	int i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]DO AACK\n");
+
+	tmp05 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RR_MOD_MASK, 0x3);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, 0x0);
+
+	for (rek = 0; rek < 4; rek++) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_AACK, RFREG_MASK, 0x8201e);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_AACK, RFREG_MASK, 0x8201f);
+		fsleep(100);
+
+		ret = read_poll_timeout_atomic(rtw89_read_rf, tmp, tmp,
+					       1, 1000, false,
+					       rtwdev, RF_PATH_A, 0xd0, BIT(16));
+		if (ret)
+			rtw89_warn(rtwdev, "[LCK]AACK timeout\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_VCI, RR_VCI_ON, 0x1);
+		for (i = 0; i < 4; i++) {
+			rtw89_write_rf(rtwdev, RF_PATH_A, RR_VCO, RR_VCO_SEL, i);
+			ib[i] = rtw89_read_rf(rtwdev, RF_PATH_A, RR_IBD, RR_IBD_VAL);
+		}
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_VCI, RR_VCI_ON, 0x0);
+
+		if (ib[0] != 0 && ib[1] != 0 && ib[2] != 0 && ib[3] != 0)
+			break;
+	}
+
+	if (rek != 0)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]AACK rek = %d\n", rek);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, tmp05);
+}
+
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool dav)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
index c81eb98dcf928..cd38d9ed1ff39 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8851b_aack(struct rtw89_dev *rtwdev);
 void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

