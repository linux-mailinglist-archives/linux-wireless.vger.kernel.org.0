Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2382678F93E
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 09:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348516AbjIAHlJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 03:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348513AbjIAHlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 03:41:08 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BB6EF10DA
        for <linux-wireless@vger.kernel.org>; Fri,  1 Sep 2023 00:41:04 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3817eV6c9006883, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3817eV6c9006883
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 15:40:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 1 Sep 2023 15:40:57 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 1 Sep 2023
 15:40:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/8] wifi: rtw89: fw: implement supported functions of download firmware for WiFi 7 chips
Date:   Fri, 1 Sep 2023 15:39:51 +0800
Message-ID: <20230901073956.54203-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230901073956.54203-1-pkshih@realtek.com>
References: <20230901073956.54203-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

To work with generalized flow of download firmware, implement WiFi 7
specific functions to support it. These functions include disable/enable
WiFi CPU, status of path ready, and status of firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
  - correct settings I miss from internal commit
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 131 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 107 ++++++++++++++++
 2 files changed, 238 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 9a63fb35e867..0b389eb656ac 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "debug.h"
+#include "fw.h"
 #include "mac.h"
 #include "reg.h"
 
@@ -28,11 +30,140 @@ static const u32 rtw89_mac_mem_base_addrs_be[RTW89_MAC_MEM_NUM] = {
 	[RTW89_MAC_MEM_WD_PAGE]		= WD_PAGE_BASE_ADDR_BE,
 };
 
+static void rtw89_mac_disable_cpu_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+
+	clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
+
+	rtw89_write32_clr(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_WCPU_EN);
+	rtw89_write32_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_HOLD_AFTER_RESET);
+	rtw89_write32_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_WCPU_EN);
+
+	val32 = rtw89_read32(rtwdev, R_BE_WCPU_FW_CTRL);
+	val32 &= B_BE_RUN_ENV_MASK;
+	rtw89_write32(rtwdev, R_BE_WCPU_FW_CTRL, val32);
+
+	rtw89_write32_set(rtwdev, R_BE_DCPU_PLATFORM_ENABLE, B_BE_DCPU_PLATFORM_EN);
+
+	rtw89_write32(rtwdev, R_BE_UDM0, 0);
+	rtw89_write32(rtwdev, R_BE_HALT_C2H, 0);
+	rtw89_write32(rtwdev, R_BE_UDM2, 0);
+}
+
+static void set_cpu_en(struct rtw89_dev *rtwdev)
+{
+	u32 set = B_BE_WLANCPU_FWDL_EN;
+
+	rtw89_write32_set(rtwdev, R_BE_WCPU_FW_CTRL, set);
+}
+
+static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
+{
+	u32 val32;
+	int ret;
+
+	rtw89_write32_set(rtwdev, R_BE_UDM0, B_BE_UDM0_DBG_MODE_CTRL);
+
+	val32 = rtw89_read32(rtwdev, R_BE_HALT_C2H);
+	if (val32) {
+		rtw89_warn(rtwdev, "[SER] AON L2 Debug register not empty before Boot.\n");
+		rtw89_warn(rtwdev, "[SER] %s: R_BE_HALT_C2H = 0x%x\n", __func__, val32);
+	}
+	val32 = rtw89_read32(rtwdev, R_BE_UDM1);
+	if (val32) {
+		rtw89_warn(rtwdev, "[SER] AON L2 Debug register not empty before Boot.\n");
+		rtw89_warn(rtwdev, "[SER] %s: R_BE_UDM1 = 0x%x\n", __func__, val32);
+	}
+	val32 = rtw89_read32(rtwdev, R_BE_UDM2);
+	if (val32) {
+		rtw89_warn(rtwdev, "[SER] AON L2 Debug register not empty before Boot.\n");
+		rtw89_warn(rtwdev, "[SER] %s: R_BE_UDM2 = 0x%x\n", __func__, val32);
+	}
+
+	rtw89_write32(rtwdev, R_BE_UDM1, 0);
+	rtw89_write32(rtwdev, R_BE_UDM2, 0);
+	rtw89_write32(rtwdev, R_BE_HALT_H2C, 0);
+	rtw89_write32(rtwdev, R_BE_HALT_C2H, 0);
+	rtw89_write32(rtwdev, R_BE_HALT_H2C_CTRL, 0);
+	rtw89_write32(rtwdev, R_BE_HALT_C2H_CTRL, 0);
+
+	rtw89_write32_set(rtwdev, R_BE_SYS_CLK_CTRL, B_BE_CPU_CLK_EN);
+	rtw89_write32_clr(rtwdev, R_BE_SYS_CFG5,
+			  B_BE_WDT_WAKE_PCIE_EN | B_BE_WDT_WAKE_USB_EN);
+	rtw89_write32_clr(rtwdev, R_BE_WCPU_FW_CTRL,
+			  B_BE_WDT_PLT_RST_EN | B_BE_WCPU_ROM_CUT_GET);
+
+	rtw89_write16_mask(rtwdev, R_BE_BOOT_REASON, B_BE_BOOT_REASON_MASK, boot_reason);
+	rtw89_write32_clr(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_WCPU_EN);
+	rtw89_write32_clr(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_HOLD_AFTER_RESET);
+	rtw89_write32_set(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_WCPU_EN);
+
+	if (!dlfw) {
+		ret = rtw89_fw_check_rdy(rtwdev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_mac_fwdl_enable_wcpu_be(struct rtw89_dev *rtwdev,
+					 u8 boot_reason, bool dlfw)
+{
+	set_cpu_en(rtwdev);
+
+	return wcpu_on(rtwdev, boot_reason, dlfw);
+}
+
+static const u8 fwdl_status_map[] = {
+	[0] = RTW89_FWDL_INITIAL_STATE,
+	[1] = RTW89_FWDL_FWDL_ONGOING,
+	[4] = RTW89_FWDL_CHECKSUM_FAIL,
+	[5] = RTW89_FWDL_SECURITY_FAIL,
+	[6] = RTW89_FWDL_SECURITY_FAIL,
+	[7] = RTW89_FWDL_CV_NOT_MATCH,
+	[8] = RTW89_FWDL_RSVD0,
+	[2] = RTW89_FWDL_WCPU_FWDL_RDY,
+	[3] = RTW89_FWDL_WCPU_FW_INIT_RDY,
+	[9] = RTW89_FWDL_RSVD0,
+};
+
+static u8 fwdl_get_status_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u8 st;
+
+	val32 = rtw89_read32(rtwdev, R_BE_WCPU_FW_CTRL);
+
+	st = u32_get_bits(val32, B_BE_WCPU_FWDL_STATUS_MASK);
+	if (st < ARRAY_SIZE(fwdl_status_map))
+		return fwdl_status_map[st];
+
+	return st;
+}
+
+static int rtw89_fwdl_check_path_ready_be(struct rtw89_dev *rtwdev,
+					  bool h2c_or_fwdl)
+{
+	u32 check = h2c_or_fwdl ? B_BE_H2C_PATH_RDY : B_BE_DLFW_PATH_RDY;
+	u32 val;
+
+	return read_poll_timeout_atomic(rtw89_read32, val, val & check,
+					1, 1000000, false,
+					rtwdev, R_BE_WCPU_FW_CTRL);
+}
+
 const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.band1_offset = RTW89_MAC_BE_BAND_REG_OFFSET,
 	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
 	.indir_access_addr = R_BE_INDIR_ACCESS_ENTRY,
 	.mem_base_addrs = rtw89_mac_mem_base_addrs_be,
 	.rx_fltr = R_BE_RX_FLTR_OPT,
+
+	.disable_cpu = rtw89_mac_disable_cpu_be,
+	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
+	.fwdl_get_status = fwdl_get_status_be,
+	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c0aac4d3678a..7798866d20c6 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3625,8 +3625,115 @@
 #define B_AX_GNT_BT_TX_SW_VAL BIT(1)
 #define B_AX_GNT_BT_TX_SW_CTRL BIT(0)
 
+#define R_BE_SYS_CLK_CTRL 0x0008
+#define B_BE_CPU_CLK_EN BIT(14)
+#define B_BE_SYMR_BE_CLK_EN BIT(13)
+#define B_BE_MAC_CLK_EN BIT(11)
+#define B_BE_EXT_32K_EN BIT(8)
+#define B_BE_WL_CLK_TEST BIT(7)
+#define B_BE_LOADER_CLK_EN BIT(5)
+#define B_BE_ANA_CLK_DIVISION_2 BIT(1)
+#define B_BE_CNTD16V_EN BIT(0)
+
+#define R_BE_PLATFORM_ENABLE 0x0088
+#define B_BE_HOLD_AFTER_RESET BIT(11)
+#define B_BE_SYM_WLPLT_MEM_MUX_EN BIT(10)
+#define B_BE_WCPU_WARM_EN BIT(9)
+#define B_BE_SPIC_EN BIT(8)
+#define B_BE_UART_EN BIT(7)
+#define B_BE_IDDMA_EN BIT(6)
+#define B_BE_IPSEC_EN BIT(5)
+#define B_BE_HIOE_EN BIT(4)
+#define B_BE_APB_WRAP_EN BIT(2)
+#define B_BE_WCPU_EN BIT(1)
+#define B_BE_PLATFORM_EN BIT(0)
+
+#define R_BE_HALT_H2C_CTRL 0x0160
+#define B_BE_HALT_H2C_TRIGGER BIT(0)
+
+#define R_BE_HALT_C2H_CTRL 0x0164
+#define B_BE_HALT_C2H_TRIGGER BIT(0)
+
+#define R_BE_HALT_H2C 0x0168
+#define B_BE_HALT_H2C_MASK GENMASK(31, 0)
+
+#define R_BE_HALT_C2H 0x016C
+#define B_BE_HALT_C2H_ERROR_SENARIO_MASK GENMASK(31, 28)
+#define B_BE_ERROR_CODE_MASK GENMASK(15, 0)
+
+#define R_BE_SYS_CFG5 0x0170
+#define B_BE_WDT_DATACPU_WAKE_PCIE_EN BIT(12)
+#define B_BE_WDT_DATACPU_WAKE_USB_EN BIT(11)
+#define B_BE_WDT_WAKE_PCIE_EN BIT(10)
+#define B_BE_WDT_WAKE_USB_EN BIT(9)
+#define B_BE_SYM_DIS_HC_ACCESS_MAC BIT(8)
+#define B_BE_LPS_STATUS BIT(3)
+#define B_BE_HCI_TXDMA_BUSY BIT(2)
+
+#define R_BE_WCPU_FW_CTRL 0x01E0
+#define B_BE_RUN_ENV_MASK GENMASK(31, 30)
+#define B_BE_WCPU_FWDL_STATUS_MASK GENMASK(29, 26)
+#define B_BE_WDT_PLT_RST_EN BIT(17)
+#define B_BE_FW_SEC_AUTH_DONE BIT(14)
+#define B_BE_FW_CPU_UTIL_STS_EN BIT(13)
+#define B_BE_BBMCU1_FWDL_EN BIT(12)
+#define B_BE_BBMCU0_FWDL_EN BIT(11)
+#define B_BE_DATACPU_FWDL_EN BIT(10)
+#define B_BE_WLANCPU_FWDL_EN BIT(9)
+#define B_BE_WCPU_ROM_CUT_GET BIT(8)
+#define B_BE_WCPU_ROM_CUT_VAL_MASK GENMASK(7, 4)
+#define B_BE_FW_BOOT_MODE_MASK GENMASK(3, 2)
+#define B_BE_H2C_PATH_RDY BIT(1)
+#define B_BE_DLFW_PATH_RDY BIT(0)
+
+#define R_BE_BOOT_REASON 0x01E6
+#define B_BE_BOOT_REASON_MASK GENMASK(2, 0)
+
+#define R_BE_LDM 0x01E8
+#define B_BE_EN_32K BIT(31)
+#define B_BE_LDM_MASK GENMASK(30, 0)
+
+#define R_BE_UDM0 0x01F0
+#define B_BE_UDM0_SEND2RA_CNT_MASK GENMASK(31, 28)
+#define B_BE_UDM0_TX_RPT_CNT_MASK GENMASK(27, 24)
+#define B_BE_UDM0_FS_CODE_MASK GENMASK(23, 8)
+#define B_BE_NULL_POINTER_INDC BIT(7)
+#define B_BE_ROM_ASSERT_INDC BIT(6)
+#define B_BE_RAM_ASSERT_INDC BIT(5)
+#define B_BE_FW_IMAGE_TYPE BIT(4)
+#define B_BE_UDM0_TRAP_LOOP_CTRL BIT(2)
+#define B_BE_UDM0_SEND_HALTC2H_CTRL BIT(1)
+#define B_BE_UDM0_DBG_MODE_CTRL BIT(0)
+
+#define R_BE_UDM1 0x01F4
+#define B_BE_UDM1_ERROR_ADDR_MASK GENMASK(31, 16)
+#define B_BE_UDM1_HALMAC_C2H_ENQ_CNT_MASK GENMASK(15, 12)
+#define B_BE_UDM1_HALMAC_H2C_DEQ_CNT_MASK GENMASK(11, 8)
+#define B_BE_UDM1_WCPU_C2H_ENQ_CNT_MASK GENMASK(7, 4)
+#define B_BE_UDM1_WCPU_H2C_DEQ_CNT_MASK GENMASK(3, 0)
+
+#define R_BE_UDM2 0x01F8
+#define B_BE_UDM2_EPC_RA_MASK GENMASK(31, 0)
+
+#define R_BE_DCPU_PLATFORM_ENABLE 0x0888
+#define B_BE_DCPU_SYM_DPLT_MEM_MUX_EN BIT(10)
+#define B_BE_DCPU_WARM_EN BIT(9)
+#define B_BE_DCPU_UART_EN BIT(7)
+#define B_BE_DCPU_IDDMA_EN BIT(6)
+#define B_BE_DCPU_APB_WRAP_EN BIT(2)
+#define B_BE_DCPU_EN BIT(1)
+#define B_BE_DCPU_PLATFORM_EN BIT(0)
+
 #define R_BE_FILTER_MODEL_ADDR 0x0C04
 
+#define R_BE_PLE_DBG_FUN_INTF_CTL 0x9110
+#define B_BE_PLE_DFI_ACTIVE BIT(31)
+#define B_BE_PLE_DFI_TRGSEL_MASK GENMASK(19, 16)
+#define B_BE_PLE_DFI_ADDR_MASK GENMASK(15, 0)
+
+#define R_BE_PLE_DBG_FUN_INTF_DATA 0x9114
+#define B_BE_PLE_DFI_DATA_MASK GENMASK(31, 0)
+
 #define R_BE_RX_FLTR_OPT 0x11420
 #define R_BE_RX_FLTR_OPT_C1 0x15420
 #define B_BE_UID_FILTER_MASK GENMASK(31, 24)
-- 
2.25.1

