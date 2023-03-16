Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69476BC638
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 07:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCPGl0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 02:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCPGlZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 02:41:25 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50BE196AC
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 23:41:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32G6f2oJ5004279, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32G6f2oJ5004279
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 14:41:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 14:40:54 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 16 Mar
 2023 14:40:53 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: rtw89: add counters of register-based H2C/C2H
Date:   Thu, 16 Mar 2023 14:39:56 +0800
Message-ID: <20230316063956.71687-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The register-based H2C/C2H are used to exchange information between driver
and firmware, but only apply to narrow area because its data size is
smaller than regular packet-based H2C/C2H.

This kind of H2C/C2H must be paired. To identify if any H2C/C2H is missing,
update counters to help diagnose this kind of problems.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: driver maintains counters to avoid using rtw89_write8_mask_add(), so
    we don't need to add it.
---
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 ++
 drivers/net/wireless/realtek/rtw89/reg.h      |  5 +++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  2 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 ++
 7 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e447bfec508b8..01e9444e221c3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3116,8 +3116,10 @@ struct rtw89_chip_info {
 	u32 txwd_body_size;
 	u32 h2c_ctrl_reg;
 	const u32 *h2c_regs;
+	struct rtw89_reg_def h2c_counter_reg;
 	u32 c2h_ctrl_reg;
 	const u32 *c2h_regs;
+	struct rtw89_reg_def c2h_counter_reg;
 	const struct rtw89_page_regs *page_regs;
 	bool cfo_src_fd;
 	const struct rtw89_reg_def *dcfo_comp;
@@ -3244,6 +3246,8 @@ struct rtw89_fw_info {
 	struct completion completion;
 	u8 h2c_seq;
 	u8 rec_seq;
+	u8 h2c_counter;
+	u8 c2h_counter;
 	struct rtw89_fw_suit normal;
 	struct rtw89_fw_suit wowlan;
 	bool fw_log_enable;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 713aefd0cf8dd..5fa6863d36b30 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -615,6 +615,8 @@ int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type)
 
 	fw_info->h2c_seq = 0;
 	fw_info->rec_seq = 0;
+	fw_info->h2c_counter = 0;
+	fw_info->c2h_counter = 0;
 	rtwdev->mac.rpwm_seq_num = RPWM_SEQ_NUM_MAX;
 	rtwdev->mac.cpwm_seq_num = CPWM_SEQ_NUM_MAX;
 
@@ -2724,6 +2726,7 @@ static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 				  struct rtw89_mac_h2c_info *info)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const u32 *h2c_reg = chip->h2c_regs;
 	u8 i, val, len;
 	int ret;
@@ -2743,6 +2746,9 @@ static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 	for (i = 0; i < RTW89_H2CREG_MAX; i++)
 		rtw89_write32(rtwdev, h2c_reg[i], info->h2creg[i]);
 
+	fw_info->h2c_counter++;
+	rtw89_write8_mask(rtwdev, chip->h2c_counter_reg.addr,
+			  chip->h2c_counter_reg.mask, fw_info->h2c_counter);
 	rtw89_write8(rtwdev, chip->h2c_ctrl_reg, B_AX_H2CREG_TRIGGER);
 
 	return 0;
@@ -2752,6 +2758,7 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 				 struct rtw89_mac_c2h_info *info)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 	const u32 *c2h_reg = chip->c2h_regs;
 	u32 ret;
 	u8 i, val;
@@ -2775,6 +2782,10 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	info->content_len = (RTW89_GET_C2H_HDR_LEN(*info->c2hreg) << 2) -
 				RTW89_C2HREG_HDR_LEN;
 
+	fw_info->c2h_counter++;
+	rtw89_write8_mask(rtwdev, chip->c2h_counter_reg.addr,
+			  chip->c2h_counter_reg.mask, fw_info->c2h_counter);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7866fe925d248..d0e138f8b880a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3398,6 +3398,8 @@ int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 	if (rtw89_read32(rtwdev, R_AX_PLATFORM_ENABLE) & B_AX_WCPU_EN)
 		return -EFAULT;
 
+	rtw89_write32(rtwdev, R_AX_UDM1, 0);
+	rtw89_write32(rtwdev, R_AX_UDM2, 0);
 	rtw89_write32(rtwdev, R_AX_HALT_H2C_CTRL, 0);
 	rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
 	rtw89_write32(rtwdev, R_AX_HALT_H2C, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e5c0ab43ab7a0..c75aee61f383d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -207,6 +207,11 @@
 
 #define R_AX_UDM0 0x01F0
 #define R_AX_UDM1 0x01F4
+#define B_AX_UDM1_MASK GENMASK(31, 16)
+#define B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK GENMASK(15, 12)
+#define B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK GENMASK(11, 8)
+#define B_AX_UDM1_WCPU_C2H_ENQ_CNT_MASK GENMASK(7, 4)
+#define B_AX_UDM1_WCPU_H2C_DEQ_CNT_MASK GENMASK(3, 0)
 #define R_AX_UDM2 0x01F8
 #define R_AX_UDM3 0x01FC
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9c42b6abd2232..5f7e948507f8a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2131,9 +2131,11 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
+	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8852a_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
 	.c2h_regs		= rtw8852a_c2h_regs,
+	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.page_regs		= &rtw8852a_page_regs,
 	.cfo_src_fd		= false,
 	.dcfo_comp		= &rtw8852a_dcfo_comp,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 499ae0389c715..895d216cfa27b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2508,8 +2508,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
+	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8852b_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
+	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8852b_c2h_regs,
 	.page_regs		= &rtw8852b_page_regs,
 	.cfo_src_fd		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8af813132f71d..e8e577a1b9fc4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2867,8 +2867,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v1),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL_V1,
+	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
 	.h2c_regs		= rtw8852c_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL_V1,
+	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
 	.c2h_regs		= rtw8852c_c2h_regs,
 	.page_regs		= &rtw8852c_page_regs,
 	.cfo_src_fd		= false,
-- 
2.25.1

