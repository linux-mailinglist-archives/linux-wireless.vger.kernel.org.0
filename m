Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FD63727D
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 07:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKXGpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 01:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXGpq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 01:45:46 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2B35EE2A
        for <linux-wireless@vger.kernel.org>; Wed, 23 Nov 2022 22:45:44 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AO6ijpZ7000339, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AO6ijpZ7000339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 24 Nov 2022 14:44:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 24 Nov 2022 14:45:28 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 24 Nov
 2022 14:45:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <neo_jou@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw88: fix race condition when doing H2C command
Date:   Thu, 24 Nov 2022 14:44:42 +0800
Message-ID: <20221124064442.28042-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 11/24/2022 06:09:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI0IKRXpMggMDQ6NDY6MDA=?=
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

From: Ji-Pin Jou <neo_jou@realtek.com>

For SDIO/USB interface, since the tranferring speed is slower than
that in PCIE, it may have race condition when the driver sets down
H2C command to the FW.

In the function rtw_fw_send_h2c_command, before the patch, box_reg
is written first, then box_ex_reg is written. FW starts to work and
fetch the value of box_ex_reg,  when the most significant byte of
box_reg(4 bytes) is written. Meanwhile, for SDIO/USB interface,
since the transferring speed is slow, the driver is still in writing
the new value of box_ex_reg through the bus, and FW may get the
wrong value of box_ex_reg at the moment.

To prevent the above driver/FW racing situation, box_ex_reg is
written first then box_reg. Furthermore, it is written in 4 bytes at
a time, instead of written in one byte one by one. It can increase
the speed for SDIO/USB interface.

Signed-off-by: Ji-Pin Jou <neo_jou@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 8 +++-----
 drivers/net/wireless/realtek/rtw88/fw.h | 5 +++++
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 0b5f903c0f366..b290811d75e1c 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -311,10 +311,10 @@ EXPORT_SYMBOL(rtw_fw_c2h_cmd_isr);
 static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 				    u8 *h2c)
 {
+	struct rtw_h2c_cmd *h2c_cmd = (struct rtw_h2c_cmd *)h2c;
 	u8 box;
 	u8 box_state;
 	u32 box_reg, box_ex_reg;
-	int idx;
 	int ret;
 
 	rtw_dbg(rtwdev, RTW_DBG_FW,
@@ -356,10 +356,8 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 		goto out;
 	}
 
-	for (idx = 0; idx < 4; idx++)
-		rtw_write8(rtwdev, box_reg + idx, h2c[idx]);
-	for (idx = 0; idx < 4; idx++)
-		rtw_write8(rtwdev, box_ex_reg + idx, h2c[idx + 4]);
+	rtw_write32(rtwdev, box_ex_reg, le32_to_cpu(h2c_cmd->msg_ext));
+	rtw_write32(rtwdev, box_reg, le32_to_cpu(h2c_cmd->msg));
 
 	if (++rtwdev->h2c.last_box_num >= 4)
 		rtwdev->h2c.last_box_num = 0;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index a5a965803a3cc..bca610dc99ab7 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -81,6 +81,11 @@ struct rtw_c2h_adaptivity {
 	u8 option;
 } __packed;
 
+struct rtw_h2c_cmd {
+	__le32 msg;
+	__le32 msg_ext;
+} __packed;
+
 enum rtw_rsvd_packet_type {
 	RSVD_BEACON,
 	RSVD_DUMMY,
-- 
2.25.1

