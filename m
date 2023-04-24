Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F416EC691
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 08:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjDXGxW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 02:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDXGxV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 02:53:21 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D0311A
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 23:53:18 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O6rA0h9029988, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O6rA0h9029988
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 14:53:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 24 Apr 2023 14:53:11 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 24 Apr
 2023 14:53:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: 8851b: rfk: add DACK
Date:   Mon, 24 Apr 2023 14:52:41 +0800
Message-ID: <20230424065242.17477-5-pkshih@realtek.com>
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

DACK (digital-to-analog converters calibration) is used to calibrate DAC
to output good quality signals.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  11 +
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 343 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |   1 +
 3 files changed, 355 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c840a96b79f23..c967bf75a0f6d 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4736,11 +4736,15 @@
 #define B_IQKINF2_KCNT GENMASK(15, 8)
 #define B_IQKINF2_NCTLV GENMASK(7, 0)
 #define R_DCOF0 0xC000
+#define B_DCOF0_RST BIT(17)
 #define B_DCOF0_V GENMASK(4, 1)
 #define R_DCOF1 0xC004
+#define B_DCOF1_RST BIT(17)
 #define B_DCOF1_S BIT(0)
 #define R_DCOF8 0xC020
 #define B_DCOF8_V GENMASK(4, 1)
+#define R_DCOF9 0xC024
+#define B_DCOF9_RST BIT(17)
 #define R_DACK_S0P0 0xC040
 #define B_DACK_S0P0_OK BIT(31)
 #define R_DACK_BIAS00 0xc048
@@ -4792,6 +4796,7 @@
 #define B_ADDCK0D_VAL GENMASK(25, 16)
 #define R_ADDCK0 0xC0F4
 #define B_ADDCK0_TRG BIT(11)
+#define B_ADDCK0_IQ BIT(10)
 #define B_ADDCK0 GENMASK(9, 8)
 #define B_ADDCK0_MAN GENMASK(5, 4)
 #define B_ADDCK0_EN BIT(4)
@@ -4803,6 +4808,7 @@
 #define B_ADDCK0_RL0 GENMASK(17, 8)
 #define R_ADDCKR0 0xC0FC
 #define B_ADDCKR0_A0 GENMASK(19, 10)
+#define B_ADDCKR0_DC GENMASK(15, 4)
 #define B_ADDCKR0_A1 GENMASK(9, 0)
 #define R_DACK10 0xC100
 #define B_DACK10 GENMASK(4, 1)
@@ -4853,6 +4859,11 @@
 #define R_ADDCKR1 0xC1fC
 #define B_ADDCKR1_A0 GENMASK(19, 10)
 #define B_ADDCKR1_A1 GENMASK(9, 0)
+#define R_DACKN0_CTL 0xC210
+#define B_DACKN0_EN BIT(0)
+#define B_DACKN0_V GENMASK(21, 14)
+#define R_DACKN1_CTL 0xC224
+#define B_DACKN1_V GENMASK(21, 14)
 
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 7f454f68d08d8..816f365ae822b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -17,6 +17,344 @@ static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return RF_A;
 }
 
+static void _dack_reset(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_RST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_RST, 0x1);
+}
+
+static void _drck(struct rtw89_dev *rtwdev)
+{
+	u32 rck_d;
+	u32 val;
+	int ret;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]Ddie RCK start!!!\n");
+
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_IDLE, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_EN, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val,
+				       1, 10000, false,
+				       rtwdev, R_DRCK_RES, B_DRCK_POL);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DRCK timeout\n");
+
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_FH, B_DRCK_LAT, 0x1);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_FH, B_DRCK_LAT, 0x0);
+
+	rck_d = rtw89_phy_read32_mask(rtwdev, R_DRCK_RES, 0x7c00);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_IDLE, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_VAL, rck_d);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0xc0c4 = 0x%x\n",
+		    rtw89_phy_read32_mask(rtwdev, R_DRCK, MASKDWORD));
+}
+
+static void _addck_backup(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0, 0x0);
+
+	dack->addck_d[0][0] = rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_A0);
+	dack->addck_d[0][1] = rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_A1);
+}
+
+static void _addck_reload(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RL1, dack->addck_d[0][0]);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RL0, dack->addck_d[0][1]);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RLS, 0x3);
+}
+
+static void _dack_backup_s0(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_V, i);
+		dack->msbk_d[0][0][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK_S0P2, B_DACK_S0M0);
+
+		rtw89_phy_write32_mask(rtwdev, R_DCOF8, B_DCOF8_V, i);
+		dack->msbk_d[0][1][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK_S0P3, B_DACK_S0M1);
+	}
+
+	dack->biask_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS00, B_DACK_BIAS00);
+	dack->biask_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS01, B_DACK_BIAS01);
+	dack->dadck_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK00, B_DACK_DADCK00) + 24;
+	dack->dadck_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK01, B_DACK_DADCK01) + 24;
+}
+
+static void _dack_reload_by_path(struct rtw89_dev *rtwdev,
+				 enum rtw89_rf_path path, u8 index)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 idx_offset, path_offset;
+	u32 offset, reg;
+	u32 tmp;
+	u8 i;
+
+	if (index == 0)
+		idx_offset = 0;
+	else
+		idx_offset = 0x14;
+
+	if (path == RF_PATH_A)
+		path_offset = 0;
+	else
+		path_offset = 0x28;
+
+	offset = idx_offset + path_offset;
+
+	rtw89_phy_write32_mask(rtwdev, R_DCOF1, B_DCOF1_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DCOF9, B_DCOF9_RST, 0x1);
+
+	/* msbk_d: 15/14/13/12 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i + 12] << (i * 8);
+	reg = 0xc200 + offset;
+	rtw89_phy_write32(rtwdev, reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", reg,
+		    rtw89_phy_read32_mask(rtwdev, reg, MASKDWORD));
+
+	/* msbk_d: 11/10/9/8 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i + 8] << (i * 8);
+	reg = 0xc204 + offset;
+	rtw89_phy_write32(rtwdev, reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", reg,
+		    rtw89_phy_read32_mask(rtwdev, reg, MASKDWORD));
+
+	/* msbk_d: 7/6/5/4 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i + 4] << (i * 8);
+	reg = 0xc208 + offset;
+	rtw89_phy_write32(rtwdev, reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", reg,
+		    rtw89_phy_read32_mask(rtwdev, reg, MASKDWORD));
+
+	/* msbk_d: 3/2/1/0 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i] << (i * 8);
+	reg = 0xc20c + offset;
+	rtw89_phy_write32(rtwdev, reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", reg,
+		    rtw89_phy_read32_mask(rtwdev, reg, MASKDWORD));
+
+	/* dadak_d/biask_d */
+	tmp = 0x0;
+	tmp = (dack->biask_d[path][index] << 22) |
+	      (dack->dadck_d[path][index] << 14);
+	reg = 0xc210 + offset;
+	rtw89_phy_write32(rtwdev, reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", reg,
+		    rtw89_phy_read32_mask(rtwdev, reg, MASKDWORD));
+
+	rtw89_phy_write32_mask(rtwdev, R_DACKN0_CTL + offset, B_DACKN0_EN, 0x1);
+}
+
+static void _dack_reload(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	u8 index;
+
+	for (index = 0; index < 2; index++)
+		_dack_reload_by_path(rtwdev, path, index);
+}
+
+static void _addck(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 val;
+	int ret;
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_EN, 0x0);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val,
+				       1, 10000, false,
+				       rtwdev, R_ADDCKR0, BIT(0));
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADDCK timeout\n");
+		dack->addck_timeout[0] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]ADDCK ret = %d\n", ret);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_RST, 0x0);
+}
+
+static void _new_dadck(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 i_dc, q_dc, ic, qc;
+	u32 val;
+	int ret;
+
+	rtw89_rfk_parser(rtwdev, &rtw8851b_dadck_setup_defs_tbl);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val,
+				       1, 10000, false,
+				       rtwdev, R_ADDCKR0, BIT(0));
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 DADCK timeout\n");
+		dack->addck_timeout[0] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DADCK ret = %d\n", ret);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_IQ, 0x0);
+	i_dc = rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_DC);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_IQ, 0x1);
+	q_dc = rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_DC);
+
+	ic = 0x80 - sign_extend32(i_dc, 11) * 6;
+	qc = 0x80 - sign_extend32(q_dc, 11) * 6;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]before DADCK, i_dc=0x%x, q_dc=0x%x\n", i_dc, q_dc);
+
+	dack->dadck_d[0][0] = ic;
+	dack->dadck_d[0][1] = qc;
+
+	rtw89_phy_write32_mask(rtwdev, R_DACKN0_CTL, B_DACKN0_V, dack->dadck_d[0][0]);
+	rtw89_phy_write32_mask(rtwdev, R_DACKN1_CTL, B_DACKN1_V, dack->dadck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]after DADCK, 0xc210=0x%x, 0xc224=0x%x\n",
+		    rtw89_phy_read32_mask(rtwdev, R_DACKN0_CTL, MASKDWORD),
+		    rtw89_phy_read32_mask(rtwdev, R_DACKN1_CTL, MASKDWORD));
+
+	rtw89_rfk_parser(rtwdev, &rtw8851b_dadck_post_defs_tbl);
+}
+
+static bool _dack_s0_poll(struct rtw89_dev *rtwdev)
+{
+	if (rtw89_phy_read32_mask(rtwdev, R_DACK_S0P0, B_DACK_S0P0_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P1, B_DACK_S0P1_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P2, B_DACK_S0P2_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P3, B_DACK_S0P3_OK) == 0)
+		return false;
+
+	return true;
+}
+
+static void _dack_s0(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	bool done;
+	int ret;
+
+	rtw89_rfk_parser(rtwdev, &rtw8851b_dack_s0_1_defs_tbl);
+	_dack_reset(rtwdev, RF_PATH_A);
+	rtw89_phy_write32_mask(rtwdev, R_DCOF1, B_DCOF1_S, 0x1);
+
+	ret = read_poll_timeout_atomic(_dack_s0_poll, done, done,
+				       1, 10000, false, rtwdev);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 DACK timeout\n");
+		dack->msbk_timeout[0] = true;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK ret = %d\n", ret);
+
+	rtw89_rfk_parser(rtwdev, &rtw8851b_dack_s0_2_defs_tbl);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]after S0 DADCK\n");
+
+	_dack_backup_s0(rtwdev);
+	_dack_reload(rtwdev, RF_PATH_A);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+}
+
+static void _dack(struct rtw89_dev *rtwdev)
+{
+	_dack_s0(rtwdev);
+}
+
+static void _dack_dump(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+	u8 t;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->addck_d[0][0], dack->addck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->dadck_d[0][0], dack->dadck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 biask ic = 0x%x, qc = 0x%x\n",
+		    dack->biask_d[0][0], dack->biask_d[0][1]);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK ic:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[0][0][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK qc:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[0][1][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+}
+
+static void _dack_manual_off(struct rtw89_dev *rtwdev)
+{
+	rtw89_rfk_parser(rtwdev, &rtw8851b_dack_manual_off_defs_tbl);
+}
+
+static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 rf0_0;
+
+	dack->dack_done = false;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK 0x2\n");
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK start!!!\n");
+	rf0_0 = rtw89_read_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]RF0=0x%x\n", rf0_0);
+
+	_drck(rtwdev);
+	_dack_manual_off(rtwdev);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK, 0x337e1);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RR_RSV1_RST, 0x0);
+
+	_addck(rtwdev);
+	_addck_backup(rtwdev);
+	_addck_reload(rtwdev);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK, 0x40001);
+
+	_dack(rtwdev);
+	_new_dadck(rtwdev);
+	_dack_dump(rtwdev);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RR_RSV1_RST, 0x1);
+
+	dack->dack_done = true;
+	dack->dack_cnt++;
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
+}
+
 static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 {
 	u32 rf_reg5;
@@ -99,6 +437,11 @@ void rtw8851b_rck(struct rtw89_dev *rtwdev)
 	_rck(rtwdev, RF_PATH_A);
 }
 
+void rtw8851b_dack(struct rtw89_dev *rtwdev)
+{
+	_dac_cal(rtwdev, false);
+}
+
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 			enum rtw89_bandwidth bw, bool dav)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
index 9f67a8c3b9d90..a6ebe4d29573f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -9,6 +9,7 @@
 
 void rtw8851b_aack(struct rtw89_dev *rtwdev);
 void rtw8851b_rck(struct rtw89_dev *rtwdev);
+void rtw8851b_dack(struct rtw89_dev *rtwdev);
 void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
-- 
2.25.1

