Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F8E67753E
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 07:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAWGyq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 01:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjAWGyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:45 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5FFB11423A
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 22:54:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30N6sVDL1012879, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30N6sVDL1012879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Jan 2023 14:54:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Mon, 23 Jan 2023 14:54:34 +0800
Received: from localhost (172.16.16.32) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 23 Jan
 2023 14:54:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: 8852b: reset IDMEM mode to default value
Date:   Mon, 23 Jan 2023 14:53:59 +0800
Message-ID: <20230123065401.14174-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123065401.14174-1-pkshih@realtek.com>
References: <20230123065401.14174-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.32]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2023 06:33:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjMgpFekyCAxMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For different firmware type, it could use different IDMEM mode, so reset
it to default to avoid encountering error during we bisect firmware
version, like

  rtw89_8852be 0000:03:00.0: Firmware version 0.29.26.0, cmd version 0, type 5
  rtw89_8852be 0000:03:00.0: Firmware version 0.29.26.0, cmd version 0, type 3
  rtw89_8852be 0000:03:00.0: fw security fail
  rtw89_8852be 0000:03:00.0: download firmware fail
  rtw89_8852be 0000:03:00.0: [ERR]fwdl 0x1E0 = 0x62
  rtw89_8852be 0000:03:00.0: [ERR]fwdl 0x83F2 = 0x8
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb8931154
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb8931154
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb8931150
  rtw89_8852be 0000:03:00.0: [ERR]fw PC = 0xb8931154

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 5 +++++
 drivers/net/wireless/realtek/rtw89/reg.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5ab0590485e0d..af1196cbf3a55 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3411,6 +3411,11 @@ int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 		val |= B_AX_WCPU_FWDL_EN;
 
 	rtw89_write32(rtwdev, R_AX_WCPU_FW_CTRL, val);
+
+	if (rtwdev->chip->chip_id == RTL8852B)
+		rtw89_write32_mask(rtwdev, R_AX_SEC_CTRL,
+				   B_AX_SEC_IDMEM_SIZE_CONFIG_MASK, 0x2);
+
 	rtw89_write16_mask(rtwdev, R_AX_BOOT_REASON, B_AX_BOOT_REASON_MASK,
 			   boot_reason);
 	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_WCPU_EN);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 036953f0ec464..600257909df27 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -275,6 +275,9 @@
 #define B_AX_S1_LDO2PWRCUT_F BIT(23)
 #define B_AX_S0_LDO_VSEL_F_MASK GENMASK(22, 21)
 
+#define R_AX_SEC_CTRL 0x0C00
+#define B_AX_SEC_IDMEM_SIZE_CONFIG_MASK GENMASK(17, 16)
+
 #define R_AX_FILTER_MODEL_ADDR 0x0C04
 
 #define R_AX_HAXI_INIT_CFG1 0x1000
-- 
2.25.1

