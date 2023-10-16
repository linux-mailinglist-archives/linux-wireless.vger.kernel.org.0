Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3C47C9EF8
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 07:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjJPFhG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 01:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjJPFgq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 01:36:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A0D4A
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 22:36:37 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G5aT0X12175063, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G5aT0X12175063
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 13:36:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 16 Oct 2023 13:36:29 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 13:36:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw88: dump firmware debug information in abnormal state
Date:   Mon, 16 Oct 2023 13:35:54 +0800
Message-ID: <20231016053554.744180-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016053554.744180-1-pkshih@realtek.com>
References: <20231016053554.744180-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.71.113]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

Sometimes firmware may enter strange state or infinite
loop due to unknown bug, and then it will lead critical
function fail, such as sending H2C command or changing
power mode. In these abnormal states, we add more debug
information, including hardware register status, to help
further investigation.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c   | 74 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h   |  3 +
 drivers/net/wireless/realtek/rtw88/main.h |  6 ++
 drivers/net/wireless/realtek/rtw88/ps.c   |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h  | 23 +++++++
 5 files changed, 108 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index a1b674e3caaa..acd78311c8c4 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -17,6 +17,79 @@
 #include "phy.h"
 #include "mac.h"
 
+static const struct rtw_hw_reg_desc fw_h2c_regs[] = {
+	{REG_FWIMR, MASKDWORD, "FWIMR"},
+	{REG_FWIMR, BIT_FS_H2CCMD_INT_EN, "FWIMR enable"},
+	{REG_FWISR, MASKDWORD, "FWISR"},
+	{REG_FWISR, BIT_FS_H2CCMD_INT, "FWISR enable"},
+	{REG_HMETFR, BIT_INT_BOX_ALL, "BoxBitMap"},
+	{REG_HMEBOX0, MASKDWORD, "MSG 0"},
+	{REG_HMEBOX0_EX, MASKDWORD, "MSG_EX 0"},
+	{REG_HMEBOX1, MASKDWORD, "MSG 1"},
+	{REG_HMEBOX1_EX, MASKDWORD, "MSG_EX 1"},
+	{REG_HMEBOX2, MASKDWORD, "MSG 2"},
+	{REG_HMEBOX2_EX, MASKDWORD, "MSG_EX 2"},
+	{REG_HMEBOX3, MASKDWORD, "MSG 3"},
+	{REG_HMEBOX3_EX, MASKDWORD, "MSG_EX 3"},
+	{REG_FT1IMR, MASKDWORD, "FT1IMR"},
+	{REG_FT1IMR, BIT_FS_H2C_CMD_OK_INT_EN, "FT1IMR enable"},
+	{REG_FT1ISR, MASKDWORD, "FT1ISR"},
+	{REG_FT1ISR, BIT_FS_H2C_CMD_OK_INT, "FT1ISR enable "},
+};
+
+static const struct rtw_hw_reg_desc fw_c2h_regs[] = {
+	{REG_FWIMR, MASKDWORD, "FWIMR"},
+	{REG_FWIMR, BIT_FS_H2CCMD_INT_EN, "CPWM"},
+	{REG_FWIMR, BIT_FS_HRCV_INT_EN, "HRECV"},
+	{REG_FWISR, MASKDWORD, "FWISR"},
+	{REG_FWISR, BIT_FS_H2CCMD_INT, "CPWM"},
+	{REG_FWISR, BIT_FS_HRCV_INT, "HRECV"},
+	{REG_CPWM, MASKDWORD, "REG_CPWM"},
+};
+
+static const struct rtw_hw_reg_desc fw_core_regs[] = {
+	{REG_ARFR2_V1, MASKDWORD, "EPC"},
+	{REG_ARFRH2_V1, MASKDWORD, "BADADDR"},
+	{REG_ARFR3_V1, MASKDWORD, "CAUSE"},
+	{REG_ARFR3_V1, BIT_EXC_CODE, "ExcCode"},
+	{REG_ARFRH3_V1, MASKDWORD, "Status"},
+	{REG_ARFR4, MASKDWORD, "SP"},
+	{REG_ARFRH4, MASKDWORD, "RA"},
+	{REG_FW_DBG6, MASKDWORD, "DBG 6"},
+	{REG_FW_DBG7, MASKDWORD, "DBG 7"},
+};
+
+static void _rtw_fw_dump_dbg_info(struct rtw_dev *rtwdev,
+				  const struct rtw_hw_reg_desc regs[], u32 size)
+{
+	const struct rtw_hw_reg_desc *reg;
+	u32 val;
+	int i;
+
+	for (i = 0;  i < size; i++) {
+		reg = &regs[i];
+		val = rtw_read32_mask(rtwdev, reg->addr, reg->mask);
+
+		rtw_dbg(rtwdev, RTW_DBG_FW, "[%s]addr:0x%x mask:0x%x value:0x%x\n",
+			reg->desc, reg->addr, reg->mask, val);
+	}
+}
+
+void rtw_fw_dump_dbg_info(struct rtw_dev *rtwdev)
+{
+	int i;
+
+	if (!rtw_dbg_is_enabled(rtwdev, RTW_DBG_FW))
+		return;
+
+	_rtw_fw_dump_dbg_info(rtwdev, fw_h2c_regs, ARRAY_SIZE(fw_h2c_regs));
+	_rtw_fw_dump_dbg_info(rtwdev, fw_c2h_regs, ARRAY_SIZE(fw_c2h_regs));
+	for (i = 0 ; i < RTW_DEBUG_DUMP_TIMES; i++) {
+		rtw_dbg(rtwdev, RTW_DBG_FW, "Firmware Coredump %dth\n", i + 1);
+		_rtw_fw_dump_dbg_info(rtwdev, fw_core_regs, ARRAY_SIZE(fw_core_regs));
+	}
+}
+
 static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 				      struct sk_buff *skb)
 {
@@ -349,6 +422,7 @@ static void rtw_fw_send_h2c_command_register(struct rtw_dev *rtwdev,
 
 	if (ret) {
 		rtw_err(rtwdev, "failed to send h2c command\n");
+		rtw_fw_dump_dbg_info(rtwdev);
 		return;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 43ccdf9965ac..84e47c71ea12 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -44,6 +44,8 @@
 #define RTW_OLD_PROBE_PG_CNT		2
 #define RTW_PROBE_PG_CNT		4
 
+#define RTW_DEBUG_DUMP_TIMES		10
+
 enum rtw_c2h_cmd_id {
 	C2H_CCX_TX_RPT = 0x03,
 	C2H_BT_INFO = 0x09,
@@ -808,6 +810,7 @@ static inline bool rtw_fw_feature_ext_check(struct rtw_fw_state *fw,
 	return !!(fw->feature_ext & feature);
 }
 
+void rtw_fw_dump_dbg_info(struct rtw_dev *rtwdev);
 void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 			       struct sk_buff *skb);
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 86dc1516effa..b6bfd4c02e2d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -524,6 +524,12 @@ struct rtw_hw_reg {
 	u32 mask;
 };
 
+struct rtw_hw_reg_desc {
+	u32 addr;
+	u32 mask;
+	const char *desc;
+};
+
 struct rtw_ltecoex_addr {
 	u32 ctrl;
 	u32 wdata;
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 07e8cbd436cd..add5a20b8432 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -104,6 +104,7 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 		 */
 		WARN(1, "firmware failed to ack driver for %s Deep Power mode\n",
 		     enter ? "entering" : "leaving");
+		rtw_fw_dump_dbg_info(rtwdev);
 	}
 }
 EXPORT_SYMBOL(rtw_power_mode_change);
@@ -164,6 +165,7 @@ static void rtw_fw_leave_lps_check(struct rtw_dev *rtwdev)
 	if (ret) {
 		rtw_write32_clr(rtwdev, REG_TCR, BIT_PWRMGT_HWDATA_EN);
 		rtw_warn(rtwdev, "firmware failed to leave lps state\n");
+		rtw_fw_dump_dbg_info(rtwdev);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 7c6c11d50ff3..1634f03784f1 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -224,12 +224,25 @@
 #define REG_RXFF_BNDY		0x011C
 #define REG_FE1IMR		0x0120
 #define BIT_FS_RXDONE		BIT(16)
+#define REG_CPWM		0x012C
+#define REG_FWIMR		0x0130
+#define BIT_FS_H2CCMD_INT_EN	BIT(4)
+#define BIT_FS_HRCV_INT_EN	BIT(5)
+#define REG_FWISR		0x0134
+#define BIT_FS_H2CCMD_INT	BIT(4)
+#define BIT_FS_HRCV_INT		BIT(5)
 #define REG_PKTBUF_DBG_CTRL	0x0140
 #define REG_C2HEVT		0x01A0
 #define REG_MCUTST_1		0x01C0
 #define REG_MCUTST_II		0x01C4
 #define REG_WOWLAN_WAKE_REASON	0x01C7
 #define REG_HMETFR		0x01CC
+#define BIT_INT_BOX0		BIT(0)
+#define BIT_INT_BOX1		BIT(1)
+#define BIT_INT_BOX2		BIT(2)
+#define BIT_INT_BOX3		BIT(3)
+#define BIT_INT_BOX_ALL		(BIT_INT_BOX0 | BIT_INT_BOX1 | BIT_INT_BOX2 | \
+				 BIT_INT_BOX3)
 #define REG_HMEBOX0		0x01D0
 #define REG_HMEBOX1		0x01D4
 #define REG_HMEBOX2		0x01D8
@@ -338,6 +351,11 @@
 #define BIT_EN_GNT_BT_AWAKE	BIT(3)
 #define BIT_EN_EOF_V1		BIT(2)
 #define REG_DATA_SC		0x0483
+#define REG_ARFR2_V1		0x048C
+#define REG_ARFRH2_V1		0x0490
+#define REG_ARFR3_V1		0x0494
+#define BIT_EXC_CODE		GENMASK(6, 2)
+#define REG_ARFRH3_V1		0x0498
 #define REG_ARFR4		0x049C
 #define BIT_WL_RFK		BIT(0)
 #define REG_ARFRH4		0x04A0
@@ -548,11 +566,16 @@
 
 #define REG_H2C_PKT_READADDR	0x10D0
 #define REG_H2C_PKT_WRITEADDR	0x10D4
+#define REG_FW_DBG6		0x10F8
 #define REG_FW_DBG7		0x10FC
 #define FW_KEY_MASK		0xffffff00
 
 #define REG_CR_EXT		0x1100
 
+#define REG_FT1IMR		0x1138
+#define BIT_FS_H2C_CMD_OK_INT_EN BIT(25)
+#define REG_FT1ISR		0x113c
+#define BIT_FS_H2C_CMD_OK_INT	BIT(25)
 #define REG_DDMA_CH0SA		0x1200
 #define REG_DDMA_CH0DA		0x1204
 #define REG_DDMA_CH0CTRL	0x1208
-- 
2.25.1

