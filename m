Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29037325F6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 05:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbjFPDpc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 23:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239284AbjFPDp1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 23:45:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141B13E
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 20:45:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35G3ixUT3029367, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35G3ixUT3029367
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 11:45:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 16 Jun 2023 11:45:18 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 11:45:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] wifi: rtw88: refine register based H2C command
Date:   Fri, 16 Jun 2023 11:44:30 +0800
Message-ID: <20230616034431.17403-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616034431.17403-1-pkshih@realtek.com>
References: <20230616034431.17403-1-pkshih@realtek.com>
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

From: Po-Hao Huang <phhuang@realtek.com>

Since register based H2C commands don't need endian conversion.
Introduce a new API that don't do conversion and send it directly.
New caller are expected to encode with cpu order and gradually
replace the old ones.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 51 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h |  5 +++
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 2a8ccc8a7f60d..5e329bb95bb89 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -308,6 +308,57 @@ void rtw_fw_c2h_cmd_isr(struct rtw_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw_fw_c2h_cmd_isr);
 
+static void rtw_fw_send_h2c_command_register(struct rtw_dev *rtwdev,
+					     struct rtw_h2c_register *h2c)
+{
+	u32 box_reg, box_ex_reg;
+	u8 box_state, box;
+	int ret;
+
+	rtw_dbg(rtwdev, RTW_DBG_FW, "send H2C content %08x %08x\n", h2c->w0,
+		h2c->w1);
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	box = rtwdev->h2c.last_box_num;
+	switch (box) {
+	case 0:
+		box_reg = REG_HMEBOX0;
+		box_ex_reg = REG_HMEBOX0_EX;
+		break;
+	case 1:
+		box_reg = REG_HMEBOX1;
+		box_ex_reg = REG_HMEBOX1_EX;
+		break;
+	case 2:
+		box_reg = REG_HMEBOX2;
+		box_ex_reg = REG_HMEBOX2_EX;
+		break;
+	case 3:
+		box_reg = REG_HMEBOX3;
+		box_ex_reg = REG_HMEBOX3_EX;
+		break;
+	default:
+		WARN(1, "invalid h2c mail box number\n");
+		return;
+	}
+
+	ret = read_poll_timeout_atomic(rtw_read8, box_state,
+				       !((box_state >> box) & 0x1), 100, 3000,
+				       false, rtwdev, REG_HMETFR);
+
+	if (ret) {
+		rtw_err(rtwdev, "failed to send h2c command\n");
+		return;
+	}
+
+	rtw_write32(rtwdev, box_ex_reg, h2c->w1);
+	rtw_write32(rtwdev, box_reg, h2c->w0);
+
+	if (++rtwdev->h2c.last_box_num >= 4)
+		rtwdev->h2c.last_box_num = 0;
+}
+
 static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 				    u8 *h2c)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 397cbc3f6af6e..11a77d86cd144 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -81,6 +81,11 @@ struct rtw_c2h_adaptivity {
 	u8 option;
 } __packed;
 
+struct rtw_h2c_register {
+	u32 w0;
+	u32 w1;
+} __packed;
+
 struct rtw_h2c_cmd {
 	__le32 msg;
 	__le32 msg_ext;
-- 
2.25.1

