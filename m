Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A567F3DEC
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Nov 2023 07:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjKVGGQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Nov 2023 01:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjKVGGM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Nov 2023 01:06:12 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019661A2
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 22:06:06 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AM65xnI62079016, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AM65xnI62079016
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Nov 2023 14:05:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 22 Nov 2023 14:05:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 22 Nov
 2023 14:05:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <jamie_chen@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: phy: dynamically adjust EDCCA threshold
Date:   Wed, 22 Nov 2023 14:04:56 +0800
Message-ID: <20231122060458.30878-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231122060458.30878-1-pkshih@realtek.com>
References: <20231122060458.30878-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yi-Chen Chen <jamie_chen@realtek.com>

Add dynamic mechanism EDCCA (Energy Detection Clear Channel Assessment)
in track work. Using a fixed-value threshold will make EDCCA particularly
sensitive and cause failure to transmit under certain circumstances.
Therefore, the threshold is dynamically adjusted to make EDCCA suitable
for any situation.

However, in some cases, we will adjust the EDCCA threshold to the highest
level so that urgent transmissions can be performed successfully, such as
scanning.

Finally, in order to observe the EDCCA report in time, add the EDCCA perIC
register macro and EDCCA HW report analysis. EDCCA logs can be displayed
by using the EDCCA debug mask.

Signed-off-by: Yi-Chen Chen <jamie_chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   1 +
 drivers/net/wireless/realtek/rtw89/core.h     |  27 ++-
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 206 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h      |   9 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  39 +++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  16 +-
 10 files changed, 327 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b18f54b16f9a..920263b47f11 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3129,6 +3129,7 @@ static void rtw89_track_work(struct work_struct *work)
 	rtw89_phy_tx_path_div_track(rtwdev);
 	rtw89_phy_antdiv_track(rtwdev);
 	rtw89_phy_ul_tb_ctrl_track(rtwdev);
+	rtw89_phy_edcca_track(rtwdev);
 	rtw89_tas_track(rtwdev);
 	rtw89_chanctx_track(rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9c9e8427abd5..429904987d2e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3566,6 +3566,22 @@ struct rtw89_dig_regs {
 	struct rtw89_reg_def p1_s20_pagcugc_en;
 };
 
+struct rtw89_edcca_regs {
+	u32 edcca_level;
+	u32 edcca_mask;
+	u32 edcca_p_mask;
+	u32 ppdu_level;
+	u32 ppdu_mask;
+	u32 rpt_a;
+	u32 rpt_b;
+	u32 rpt_sel;
+	u32 rpt_sel_mask;
+	u32 rpt_sel_be;
+	u32 rpt_sel_be_mask;
+	u32 tx_collision_t2r_st;
+	u32 tx_collision_t2r_st_mask;
+};
+
 struct rtw89_phy_ul_tb_info {
 	bool dyn_tb_tri_en;
 	u8 def_if_bandedge;
@@ -3716,7 +3732,7 @@ struct rtw89_chip_info {
 	struct rtw89_reg_def bss_clr_vld;
 	u32 bss_clr_map_reg;
 	u32 dma_ch_mask;
-	u32 edcca_lvl_reg;
+	const struct rtw89_edcca_regs *edcca_regs;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const struct rtw89_xtal_info *xtal_info;
 };
@@ -3985,6 +4001,13 @@ struct rtw89_sub_entity {
 	struct rtw89_chanctx_cfg *cfg;
 };
 
+struct rtw89_edcca_bak {
+	u8 a;
+	u8 p;
+	u8 ppdu;
+	u8 th_old;
+};
+
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
@@ -4009,7 +4032,7 @@ struct rtw89_hal {
 	bool entity_pause;
 	enum rtw89_entity_mode entity_mode;
 
-	u32 edcca_bak;
+	struct rtw89_edcca_bak edcca_bak;
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index f18021f9046d..a4cdc3c8c622 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -30,6 +30,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_UL_TB = BIT(19),
 	RTW89_DBG_CHAN = BIT(20),
 	RTW89_DBG_ACPI = BIT(21),
+	RTW89_DBG_EDCCA = BIT(22),
 
 	RTW89_DBG_UNEXP = BIT(31),
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 17ccc9efed28..3d5bd888218e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4620,6 +4620,29 @@ static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_ifs_clm_setting_init(rtwdev);
 }
 
+static void rtw89_phy_edcca_init(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
+	struct rtw89_edcca_bak *edcca_bak = &rtwdev->hal.edcca_bak;
+
+	memset(edcca_bak, 0, sizeof(*edcca_bak));
+
+	if (rtwdev->chip->chip_id == RTL8922A && rtwdev->hal.cv == CHIP_CAV) {
+		rtw89_phy_set_phy_regs(rtwdev, R_TXGATING, B_TXGATING_EN, 0);
+		rtw89_phy_set_phy_regs(rtwdev, R_CTLTOP, B_CTLTOP_VAL, 2);
+		rtw89_phy_set_phy_regs(rtwdev, R_CTLTOP, B_CTLTOP_ON, 1);
+		rtw89_phy_set_phy_regs(rtwdev, R_SPOOF_CG, B_SPOOF_CG_EN, 0);
+		rtw89_phy_set_phy_regs(rtwdev, R_DFS_FFT_CG, B_DFS_CG_EN, 0);
+		rtw89_phy_set_phy_regs(rtwdev, R_DFS_FFT_CG, B_DFS_FFT_EN, 0);
+		rtw89_phy_set_phy_regs(rtwdev, R_SEGSND, B_SEGSND_EN, 0);
+		rtw89_phy_set_phy_regs(rtwdev, R_SEGSND, B_SEGSND_EN, 1);
+		rtw89_phy_set_phy_regs(rtwdev, R_DFS_FFT_CG, B_DFS_FFT_EN, 1);
+	}
+
+	rtw89_phy_write32_mask(rtwdev, edcca_regs->tx_collision_t2r_st,
+			       edcca_regs->tx_collision_t2r_st_mask, 0x29);
+}
+
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_stat_init(rtwdev);
@@ -4630,6 +4653,7 @@ void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
 	rtw89_physts_parsing_init(rtwdev);
 	rtw89_phy_dig_init(rtwdev);
 	rtw89_phy_cfo_init(rtwdev);
+	rtw89_phy_edcca_init(rtwdev);
 	rtw89_phy_ul_tb_info_init(rtwdev);
 	rtw89_phy_antdiv_init(rtwdev);
 	rtw89_chip_rfe_gpio(rtwdev);
@@ -4892,23 +4916,183 @@ void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 }
 EXPORT_SYMBOL(rtw89_decode_chan_idx);
 
-#define EDCCA_DEFAULT 249
 void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan)
 {
-	u32 reg = rtwdev->chip->edcca_lvl_reg;
-	struct rtw89_hal *hal = &rtwdev->hal;
-	u32 val;
+	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
+	struct rtw89_edcca_bak *edcca_bak = &rtwdev->hal.edcca_bak;
 
 	if (scan) {
-		hal->edcca_bak = rtw89_phy_read32(rtwdev, reg);
-		val = hal->edcca_bak;
-		u32p_replace_bits(&val, EDCCA_DEFAULT, B_SEG0R_EDCCA_LVL_A_MSK);
-		u32p_replace_bits(&val, EDCCA_DEFAULT, B_SEG0R_EDCCA_LVL_P_MSK);
-		u32p_replace_bits(&val, EDCCA_DEFAULT, B_SEG0R_PPDU_LVL_MSK);
-		rtw89_phy_write32(rtwdev, reg, val);
+		edcca_bak->a =
+			rtw89_phy_read32_mask(rtwdev, edcca_regs->edcca_level,
+					      edcca_regs->edcca_mask);
+		edcca_bak->p =
+			rtw89_phy_read32_mask(rtwdev, edcca_regs->edcca_level,
+					      edcca_regs->edcca_p_mask);
+		edcca_bak->ppdu =
+			rtw89_phy_read32_mask(rtwdev, edcca_regs->ppdu_level,
+					      edcca_regs->ppdu_mask);
+
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
+				       edcca_regs->edcca_mask, EDCCA_MAX);
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
+				       edcca_regs->edcca_p_mask, EDCCA_MAX);
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->ppdu_level,
+				       edcca_regs->ppdu_mask, EDCCA_MAX);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
+				       edcca_regs->edcca_mask,
+				       edcca_bak->a);
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
+				       edcca_regs->edcca_p_mask,
+				       edcca_bak->p);
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->ppdu_level,
+				       edcca_regs->ppdu_mask,
+				       edcca_bak->ppdu);
+	}
+}
+
+static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
+	bool flag_fb, flag_p20, flag_s20, flag_s40, flag_s80;
+	s8 pwdb_fb, pwdb_p20, pwdb_s20, pwdb_s40, pwdb_s80;
+	u8 path, per20_bitmap;
+	u8 pwdb[8];
+	u32 tmp;
+
+	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_EDCCA))
+		return;
+
+	if (rtwdev->chip->chip_id == RTL8922A)
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
+				       edcca_regs->rpt_sel_be_mask, 0);
+
+	rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
+			       edcca_regs->rpt_sel_mask, 0);
+	tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+	path = u32_get_bits(tmp, B_EDCCA_RPT_B_PATH_MASK);
+	flag_s80 = u32_get_bits(tmp, B_EDCCA_RPT_B_S80);
+	flag_s40 = u32_get_bits(tmp, B_EDCCA_RPT_B_S40);
+	flag_s20 = u32_get_bits(tmp, B_EDCCA_RPT_B_S20);
+	flag_p20 = u32_get_bits(tmp, B_EDCCA_RPT_B_P20);
+	flag_fb = u32_get_bits(tmp, B_EDCCA_RPT_B_FB);
+	pwdb_s20 = u32_get_bits(tmp, MASKBYTE1);
+	pwdb_p20 = u32_get_bits(tmp, MASKBYTE2);
+	pwdb_fb = u32_get_bits(tmp, MASKBYTE3);
+
+	rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
+			       edcca_regs->rpt_sel_mask, 4);
+	tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+	pwdb_s80 = u32_get_bits(tmp, MASKBYTE1);
+	pwdb_s40 = u32_get_bits(tmp, MASKBYTE2);
+
+	per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_regs->rpt_a,
+					     MASKBYTE0);
+
+	if (rtwdev->chip->chip_id == RTL8922A) {
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
+				       edcca_regs->rpt_sel_be_mask, 4);
+		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+		pwdb[0] = u32_get_bits(tmp, MASKBYTE3);
+		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
+		pwdb[2] = u32_get_bits(tmp, MASKBYTE1);
+		pwdb[3] = u32_get_bits(tmp, MASKBYTE0);
+
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
+				       edcca_regs->rpt_sel_be_mask, 5);
+		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_b);
+		pwdb[4] = u32_get_bits(tmp, MASKBYTE3);
+		pwdb[5] = u32_get_bits(tmp, MASKBYTE2);
+		pwdb[6] = u32_get_bits(tmp, MASKBYTE1);
+		pwdb[7] = u32_get_bits(tmp, MASKBYTE0);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
+				       edcca_regs->rpt_sel_mask, 0);
+		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		pwdb[0] = u32_get_bits(tmp, MASKBYTE3);
+		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
+
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
+				       edcca_regs->rpt_sel_mask, 1);
+		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		pwdb[2] = u32_get_bits(tmp, MASKBYTE3);
+		pwdb[3] = u32_get_bits(tmp, MASKBYTE2);
+
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
+				       edcca_regs->rpt_sel_mask, 2);
+		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		pwdb[4] = u32_get_bits(tmp, MASKBYTE3);
+		pwdb[5] = u32_get_bits(tmp, MASKBYTE2);
+
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel,
+				       edcca_regs->rpt_sel_mask, 3);
+		tmp = rtw89_phy_read32(rtwdev, edcca_regs->rpt_a);
+		pwdb[6] = u32_get_bits(tmp, MASKBYTE3);
+		pwdb[7] = u32_get_bits(tmp, MASKBYTE2);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA,
+		    "[EDCCA]: edcca_bitmap = %04x\n", per20_bitmap);
+
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA,
+		    "[EDCCA]: pwdb per20{0,1,2,3,4,5,6,7} = {%d,%d,%d,%d,%d,%d,%d,%d}(dBm)\n",
+		    pwdb[0], pwdb[1], pwdb[2], pwdb[3], pwdb[4], pwdb[5],
+		    pwdb[6], pwdb[7]);
+
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA,
+		    "[EDCCA]: path=%d, flag {FB,p20,s20,s40,s80} = {%d,%d,%d,%d,%d}\n",
+		    path, flag_fb, flag_p20, flag_s20, flag_s40, flag_s80);
+
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA,
+		    "[EDCCA]: pwdb {FB,p20,s20,s40,s80} = {%d,%d,%d,%d,%d}(dBm)\n",
+		    pwdb_fb, pwdb_p20, pwdb_s20, pwdb_s40, pwdb_s80);
+}
+
+static u8 rtw89_phy_edcca_get_thre_by_rssi(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_phy_ch_info *ch_info = &rtwdev->ch_info;
+	bool is_linked = rtwdev->total_sta_assoc > 0;
+	u8 rssi_min = ch_info->rssi_min >> 1;
+	u8 edcca_thre;
+
+	if (!is_linked) {
+		edcca_thre = EDCCA_MAX;
 	} else {
-		rtw89_phy_write32(rtwdev, reg, hal->edcca_bak);
+		edcca_thre = rssi_min - RSSI_UNIT_CONVER + EDCCA_UNIT_CONVER -
+			     EDCCA_TH_REF;
+		edcca_thre = max_t(u8, edcca_thre, EDCCA_TH_L2H_LB);
 	}
+
+	return edcca_thre;
+}
+
+void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
+	struct rtw89_edcca_bak *edcca_bak = &rtwdev->hal.edcca_bak;
+	u8 th;
+
+	th = rtw89_phy_edcca_get_thre_by_rssi(rtwdev);
+	if (th == edcca_bak->th_old)
+		return;
+
+	edcca_bak->th_old = th;
+
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA,
+		    "[EDCCA]: Normal Mode, EDCCA_th = %d\n", th);
+
+	rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
+			       edcca_regs->edcca_mask, th);
+	rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
+			       edcca_regs->edcca_p_mask, th);
+	rtw89_phy_write32_mask(rtwdev, edcca_regs->ppdu_level,
+			       edcca_regs->ppdu_mask, th);
+}
+
+void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_edcca_thre_calc(rtwdev);
+	rtw89_phy_edcca_log(rtwdev);
 }
 
 static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 5c85122e7bb5..8a016a1a05d1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -122,6 +122,13 @@
 #define PHYSTS_RSVD BIT(RTW89_RX_TYPE_RSVD)
 #define PPDU_FILTER_BITMAP (PHYSTS_MGNT | PHYSTS_DATA)
 
+#define EDCCA_MAX 249
+#define EDCCA_TH_L2H_LB 66
+#define EDCCA_TH_REF 3
+#define EDCCA_HL_DIFF_NORMAL 8
+#define RSSI_UNIT_CONVER 110
+#define EDCCA_UNIT_CONVER 128
+
 enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_STS_RPT,
 	RTW89_PHY_C2H_FUNC_MU_GPTBL_RPT,
@@ -791,5 +798,7 @@ u8 rtw89_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band);
 void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 			   u8 *ch, enum nl80211_band *band);
 void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan);
+void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev);
+void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 080db70b87d2..6e26842b16e0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4649,6 +4649,11 @@
 #define B_P0_RSTB_WATCH_DOG BIT(0)
 #define B_P1_RSTB_WATCH_DOG BIT(1)
 #define B_UPD_P0_EN BIT(31)
+#define R_SPOOF_CG 0x00B4
+#define B_SPOOF_CG_EN BIT(17)
+#define R_DFS_FFT_CG 0x00B8
+#define B_DFS_CG_EN BIT(1)
+#define B_DFS_FFT_EN BIT(0)
 #define R_ANAPAR_PW15 0x030C
 #define B_ANAPAR_PW15 GENMASK(31, 24)
 #define B_ANAPAR_PW15_H GENMASK(27, 24)
@@ -4711,6 +4716,8 @@
 #define R_PHY_STS_BITMAP_HT 0x076C
 #define R_PHY_STS_BITMAP_VHT 0x0770
 #define R_PHY_STS_BITMAP_HE 0x0774
+#define R_EDCCA_RPTREG_SEL_BE 0x078C
+#define B_EDCCA_RPTREG_SEL_BE_MSK GENMASK(22, 20)
 #define R_PMAC_GNT 0x0980
 #define B_PMAC_GNT_TXEN BIT(0)
 #define B_PMAC_GNT_RXEN BIT(16)
@@ -4770,12 +4777,18 @@
 #define B_IOQ_IQK_DPK_EN BIT(1)
 #define R_GNT_BT_WGT_EN 0x0C6C
 #define B_GNT_BT_WGT_EN BIT(21)
+#define R_TX_COLLISION_T2R_ST 0x0C70
+#define B_TX_COLLISION_T2R_ST_M GENMASK(25, 20)
+#define R_TXGATING 0x0C74
+#define B_TXGATING_EN BIT(4)
 #define R_PD_ARBITER_OFF 0x0C80
 #define B_PD_ARBITER_OFF BIT(31)
 #define R_SNDCCA_A1 0x0C9C
 #define B_SNDCCA_A1_EN GENMASK(19, 12)
 #define R_SNDCCA_A2 0x0CA0
 #define B_SNDCCA_A2_VAL GENMASK(19, 12)
+#define R_TX_COLLISION_T2R_ST_BE 0x0CC8
+#define B_TX_COLLISION_T2R_ST_BE_M GENMASK(13, 8)
 #define R_RXHT_MCS_LIMIT 0x0D18
 #define B_RXHT_MCS_LIMIT GENMASK(9, 8)
 #define R_RXVHT_MCS_LIMIT 0x0D18
@@ -4794,6 +4807,10 @@
 #define R_BRK_ASYNC_RST_EN_1 0x0DC0
 #define R_BRK_ASYNC_RST_EN_2 0x0DC4
 #define R_BRK_ASYNC_RST_EN_3 0x0DC8
+#define R_CTLTOP 0x1008
+#define B_CTLTOP_ON BIT(23)
+#define B_CTLTOP_VAL GENMASK(15, 12)
+#define R_EDCCA_RPT_SEL_BE 0x10CC
 #define R_S0_HW_SI_DIS 0x1200
 #define B_S0_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P0_RXCK 0x12A0
@@ -4825,6 +4842,14 @@
 #define R_CFO_COMP_SEG0_H 0x1388
 #define R_CFO_COMP_SEG0_CTRL 0x138C
 #define R_DBG32_D 0x1730
+#define R_EDCCA_RPT_A 0x1738
+#define R_EDCCA_RPT_B 0x173c
+#define B_EDCCA_RPT_B_FB BIT(7)
+#define B_EDCCA_RPT_B_P20 BIT(6)
+#define B_EDCCA_RPT_B_S20 BIT(5)
+#define B_EDCCA_RPT_B_S40 BIT(4)
+#define B_EDCCA_RPT_B_S80 BIT(3)
+#define B_EDCCA_RPT_B_PATH_MASK GENMASK(2, 1)
 #define R_SWSI_V1 0x174C
 #define B_SWSI_W_BUSY_V1 BIT(24)
 #define B_SWSI_R_BUSY_V1 BIT(25)
@@ -4886,6 +4911,8 @@
 #define R_S0_ADDCK 0x1E00
 #define B_S0_ADDCK_I GENMASK(9, 0)
 #define B_S0_ADDCK_Q GENMASK(19, 10)
+#define R_EDCCA_RPT_SEL 0x20CC
+#define B_EDCCA_RPT_SEL_MSK GENMASK(2, 0)
 #define R_ADC_FIFO 0x20fc
 #define B_ADC_FIFO_RST GENMASK(31, 24)
 #define B_ADC_FIFO_RXK GENMASK(31, 16)
@@ -4932,6 +4959,8 @@
 #define B_DBCC_80P80_SEL_EVM_RPT2_EN BIT(0)
 #define R_P1_EN_SOUND_WO_NDP 0x2D7C
 #define B_P1_EN_SOUND_WO_NDP BIT(1)
+#define R_EDCCA_RPT_A_BE 0x2E38
+#define R_EDCCA_RPT_B_BE 0x2E3C
 #define R_S1_HW_SI_DIS 0x3200
 #define B_S1_HW_SI_DIS_W_R_TRIG GENMASK(30, 28)
 #define R_P1_RXCK 0x32A0
@@ -5139,9 +5168,9 @@
 #define R_SEG0R_PD_V2 0x6A74
 #define R_SEG0R_EDCCA_LVL 0x4840
 #define R_SEG0R_EDCCA_LVL_V1 0x4884
-#define B_SEG0R_PPDU_LVL_MSK GENMASK(31, 24)
-#define B_SEG0R_EDCCA_LVL_P_MSK GENMASK(15, 8)
-#define B_SEG0R_EDCCA_LVL_A_MSK GENMASK(7, 0)
+#define B_EDCCA_LVL_MSK3 GENMASK(31, 24)
+#define B_EDCCA_LVL_MSK1 GENMASK(15, 8)
+#define B_EDCCA_LVL_MSK0 GENMASK(7, 0)
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1 BIT(30)
 #define B_SEG0R_PD_SPATIAL_REUSE_EN_MSK BIT(29)
 #define B_SEG0R_PD_LOWER_BOUND_MSK GENMASK(10, 6)
@@ -5395,6 +5424,10 @@
 #define B_DCFO_WEIGHT_MSK_V1 GENMASK(31, 28)
 #define R_DCFO_OPT_V1 0x6260
 #define B_DCFO_OPT_EN_V1 BIT(17)
+#define R_SEG0R_EDCCA_LVL_BE 0x69EC
+#define R_SEG0R_PPDU_LVL_BE 0x69F0
+#define R_SEGSND 0x6A14
+#define B_SEGSND_EN BIT(31)
 #define R_RPL_BIAS_COMP1 0x6DF0
 #define B_RPL_BIAS_COMP1_MASK GENMASK(7, 0)
 #define R_P1_TSSI_ALIM1 0x7630
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index ffc464b2ac10..884de5b5a071 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -205,6 +205,20 @@ static const struct rtw89_dig_regs rtw8851b_dig_regs = {
 			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
 };
 
+static const struct rtw89_edcca_regs rtw8851b_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL_V1,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_EDCCA_LVL_V1,
+	.ppdu_mask			= B_EDCCA_LVL_MSK3,
+	.rpt_a				= R_EDCCA_RPT_A,
+	.rpt_b				= R_EDCCA_RPT_B,
+	.rpt_sel			= R_EDCCA_RPT_SEL,
+	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
+};
+
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8851b_rf_ul[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
@@ -2444,7 +2458,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
-	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
+	.edcca_regs		= &rtw8851b_edcca_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8851b,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0d6f87b900d5..2cd09de39a24 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -498,6 +498,20 @@ static const struct rtw89_dig_regs rtw8852a_dig_regs = {
 			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
 };
 
+static const struct rtw89_edcca_regs rtw8852a_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_EDCCA_LVL,
+	.ppdu_mask			= B_EDCCA_LVL_MSK3,
+	.rpt_a				= R_EDCCA_RPT_A,
+	.rpt_b				= R_EDCCA_RPT_B,
+	.rpt_sel			= R_EDCCA_RPT_SEL,
+	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
+};
+
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852a_efuse *map)
 {
@@ -2179,7 +2193,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.bss_clr_vld		= {R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
-	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL,
+	.edcca_regs		= &rtw8852a_edcca_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852a,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 62c2feab569c..52dbea94e658 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -330,6 +330,20 @@ static const struct rtw89_dig_regs rtw8852b_dig_regs = {
 			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
 };
 
+static const struct rtw89_edcca_regs rtw8852b_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL_V1,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_EDCCA_LVL_V1,
+	.ppdu_mask			= B_EDCCA_LVL_MSK3,
+	.rpt_a				= R_EDCCA_RPT_A,
+	.rpt_b				= R_EDCCA_RPT_B,
+	.rpt_sel			= R_EDCCA_RPT_SEL,
+	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
+};
+
 static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
 	{255, 0, 0, 7}, /* 0 -> original */
 	{255, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
@@ -2615,7 +2629,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
-	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
+	.edcca_regs		= &rtw8852b_edcca_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852b,
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 7bb5d359a06a..2dd7ebfe1892 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -167,6 +167,20 @@ static const struct rtw89_dig_regs rtw8852c_dig_regs = {
 			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
 };
 
+static const struct rtw89_edcca_regs rtw8852c_edcca_regs = {
+	.edcca_level			= R_SEG0R_EDCCA_LVL,
+	.edcca_mask			= B_EDCCA_LVL_MSK0,
+	.edcca_p_mask			= B_EDCCA_LVL_MSK1,
+	.ppdu_level			= R_SEG0R_EDCCA_LVL,
+	.ppdu_mask			= B_EDCCA_LVL_MSK3,
+	.rpt_a				= R_EDCCA_RPT_A,
+	.rpt_b				= R_EDCCA_RPT_B,
+	.rpt_sel			= R_EDCCA_RPT_SEL,
+	.rpt_sel_mask			= B_EDCCA_RPT_SEL_MSK,
+	.tx_collision_t2r_st		= R_TX_COLLISION_T2R_ST,
+	.tx_collision_t2r_st_mask	= B_TX_COLLISION_T2R_ST_M,
+};
+
 static void rtw8852c_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
 				    enum rtw89_phy_idx phy_idx);
 
@@ -2928,7 +2942,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.bss_clr_vld		= {R_BSS_CLR_MAP, B_BSS_CLR_MAP_VLD0},
 	.bss_clr_map_reg	= R_BSS_CLR_MAP,
 	.dma_ch_mask		= 0,
-	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL,
+	.edcca_regs		= &rtw8852c_edcca_regs,
 #ifdef CONFIG_PM
 	.wowlan_stub		= &rtw_wowlan_stub_8852c,
 #endif
-- 
2.25.1

