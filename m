Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4285A5F8B65
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJIMy6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJIMyq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 433FAC3D
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299Cs2n05029536, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299Cs2n05029536
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:54:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Sun, 9 Oct 2022 20:54:30 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/9] wifi: rtw89: 8852b: add functions to control BB to assist RF calibrations
Date:   Sun, 9 Oct 2022 20:54:02 +0800
Message-ID: <20221009125403.19662-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009125403.19662-1-pkshih@realtek.com>
References: <20221009125403.19662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.215]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/09/2022 12:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzkgpFekyCAwOTowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

When we are going to do RF calibrations, they need BB helpers to control
TX PLCP, power, path and mode. Also, it they need helpers to backup and
restore some registers before and after RF calibrations. Then, use flow of
RF calibrations will be like backup registers, configure calibration,
configure TX parameters, measure calibration result, and finally restore
registers.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 288 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |  44 +++
 2 files changed, 332 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a5156d7aca5b8..290d83cb83d5a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -56,6 +56,129 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static const struct rtw89_reg3_def rtw8852b_pmac_ht20_mcs7_tbl[] = {
+	{0x4580, 0x0000ffff, 0x0},
+	{0x4580, 0xffff0000, 0x0},
+	{0x4584, 0x0000ffff, 0x0},
+	{0x4584, 0xffff0000, 0x0},
+	{0x4580, 0x0000ffff, 0x1},
+	{0x4578, 0x00ffffff, 0x2018b},
+	{0x4570, 0x03ffffff, 0x7},
+	{0x4574, 0x03ffffff, 0x32407},
+	{0x45b8, 0x00000010, 0x0},
+	{0x45b8, 0x00000100, 0x0},
+	{0x45b8, 0x00000080, 0x0},
+	{0x45b8, 0x00000008, 0x0},
+	{0x45a0, 0x0000ff00, 0x0},
+	{0x45a0, 0xff000000, 0x1},
+	{0x45a4, 0x0000ff00, 0x2},
+	{0x45a4, 0xff000000, 0x3},
+	{0x45b8, 0x00000020, 0x0},
+	{0x4568, 0xe0000000, 0x0},
+	{0x45b8, 0x00000002, 0x1},
+	{0x456c, 0xe0000000, 0x0},
+	{0x45b4, 0x00006000, 0x0},
+	{0x45b4, 0x00001800, 0x1},
+	{0x45b8, 0x00000040, 0x0},
+	{0x45b8, 0x00000004, 0x0},
+	{0x45b8, 0x00000200, 0x0},
+	{0x4598, 0xf8000000, 0x0},
+	{0x45b8, 0x00100000, 0x0},
+	{0x45a8, 0x00000fc0, 0x0},
+	{0x45b8, 0x00200000, 0x0},
+	{0x45b0, 0x00000038, 0x0},
+	{0x45b0, 0x000001c0, 0x0},
+	{0x45a0, 0x000000ff, 0x0},
+	{0x45b8, 0x00400000, 0x0},
+	{0x4590, 0x000007ff, 0x0},
+	{0x45b0, 0x00000e00, 0x0},
+	{0x45ac, 0x0000001f, 0x0},
+	{0x45b8, 0x00800000, 0x0},
+	{0x45a8, 0x0003f000, 0x0},
+	{0x45b8, 0x01000000, 0x0},
+	{0x45b0, 0x00007000, 0x0},
+	{0x45b0, 0x00038000, 0x0},
+	{0x45a0, 0x00ff0000, 0x0},
+	{0x45b8, 0x02000000, 0x0},
+	{0x4590, 0x003ff800, 0x0},
+	{0x45b0, 0x001c0000, 0x0},
+	{0x45ac, 0x000003e0, 0x0},
+	{0x45b8, 0x04000000, 0x0},
+	{0x45a8, 0x00fc0000, 0x0},
+	{0x45b8, 0x08000000, 0x0},
+	{0x45b0, 0x00e00000, 0x0},
+	{0x45b0, 0x07000000, 0x0},
+	{0x45a4, 0x000000ff, 0x0},
+	{0x45b8, 0x10000000, 0x0},
+	{0x4594, 0x000007ff, 0x0},
+	{0x45b0, 0x38000000, 0x0},
+	{0x45ac, 0x00007c00, 0x0},
+	{0x45b8, 0x20000000, 0x0},
+	{0x45a8, 0x3f000000, 0x0},
+	{0x45b8, 0x40000000, 0x0},
+	{0x45b4, 0x00000007, 0x0},
+	{0x45b4, 0x00000038, 0x0},
+	{0x45a4, 0x00ff0000, 0x0},
+	{0x45b8, 0x80000000, 0x0},
+	{0x4594, 0x003ff800, 0x0},
+	{0x45b4, 0x000001c0, 0x0},
+	{0x4598, 0xf8000000, 0x0},
+	{0x45b8, 0x00100000, 0x0},
+	{0x45a8, 0x00000fc0, 0x7},
+	{0x45b8, 0x00200000, 0x0},
+	{0x45b0, 0x00000038, 0x0},
+	{0x45b0, 0x000001c0, 0x0},
+	{0x45a0, 0x000000ff, 0x0},
+	{0x45b4, 0x06000000, 0x0},
+	{0x45b0, 0x00000007, 0x0},
+	{0x45b8, 0x00080000, 0x0},
+	{0x45a8, 0x0000003f, 0x0},
+	{0x457c, 0xffe00000, 0x1},
+	{0x4530, 0xffffffff, 0x0},
+	{0x4588, 0x00003fff, 0x0},
+	{0x4598, 0x000001ff, 0x0},
+	{0x4534, 0xffffffff, 0x0},
+	{0x4538, 0xffffffff, 0x0},
+	{0x453c, 0xffffffff, 0x0},
+	{0x4588, 0x0fffc000, 0x0},
+	{0x4598, 0x0003fe00, 0x0},
+	{0x4540, 0xffffffff, 0x0},
+	{0x4544, 0xffffffff, 0x0},
+	{0x4548, 0xffffffff, 0x0},
+	{0x458c, 0x00003fff, 0x0},
+	{0x4598, 0x07fc0000, 0x0},
+	{0x454c, 0xffffffff, 0x0},
+	{0x4550, 0xffffffff, 0x0},
+	{0x4554, 0xffffffff, 0x0},
+	{0x458c, 0x0fffc000, 0x0},
+	{0x459c, 0x000001ff, 0x0},
+	{0x4558, 0xffffffff, 0x0},
+	{0x455c, 0xffffffff, 0x0},
+	{0x4530, 0xffffffff, 0x4e790001},
+	{0x4588, 0x00003fff, 0x0},
+	{0x4598, 0x000001ff, 0x1},
+	{0x4534, 0xffffffff, 0x0},
+	{0x4538, 0xffffffff, 0x4b},
+	{0x45ac, 0x38000000, 0x7},
+	{0x4588, 0xf0000000, 0x0},
+	{0x459c, 0x7e000000, 0x0},
+	{0x45b8, 0x00040000, 0x0},
+	{0x45b8, 0x00020000, 0x0},
+	{0x4590, 0xffc00000, 0x0},
+	{0x45b8, 0x00004000, 0x0},
+	{0x4578, 0xff000000, 0x0},
+	{0x45b8, 0x00000400, 0x0},
+	{0x45b8, 0x00000800, 0x0},
+	{0x45b8, 0x00001000, 0x0},
+	{0x45b8, 0x00002000, 0x0},
+	{0x45b4, 0x00018000, 0x0},
+	{0x45ac, 0x07800000, 0x0},
+	{0x45b4, 0x00000600, 0x2},
+	{0x459c, 0x0001fe00, 0x80},
+	{0x45ac, 0x00078000, 0x3},
+	{0x459c, 0x01fe0000, 0x1},
+};
+
 static const struct rtw89_reg3_def rtw8852b_btc_preagc_en_defs[] = {
 	{0x46D0, GENMASK(1, 0), 0x3},
 	{0x4790, GENMASK(1, 0), 0x3},
@@ -1435,6 +1558,171 @@ rtw8852b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	return 0;
 }
 
+void rtw8852b_bb_set_plcp_tx(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_reg3_def *def = rtw8852b_pmac_ht20_mcs7_tbl;
+	u8 i;
+
+	for (i = 0; i < ARRAY_SIZE(rtw8852b_pmac_ht20_mcs7_tbl); i++, def++)
+		rtw89_phy_write32_mask(rtwdev, def->addr, def->mask, def->data);
+}
+
+static void rtw8852b_stop_pmac_tx(struct rtw89_dev *rtwdev,
+				  struct rtw8852b_bb_pmac_info *tx_info,
+				  enum rtw89_phy_idx idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC Stop Tx");
+	if (tx_info->mode == CONT_TX)
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_CTX_EN, 0, idx);
+	else if (tx_info->mode == PKTS_TX)
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_PTX_EN, 0, idx);
+}
+
+static void rtw8852b_start_pmac_tx(struct rtw89_dev *rtwdev,
+				   struct rtw8852b_bb_pmac_info *tx_info,
+				   enum rtw89_phy_idx idx)
+{
+	enum rtw8852b_pmac_mode mode = tx_info->mode;
+	u32 pkt_cnt = tx_info->tx_cnt;
+	u16 period = tx_info->period;
+
+	if (mode == CONT_TX && !tx_info->is_cck) {
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_CTX_EN, 1, idx);
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CTx Start");
+	} else if (mode == PKTS_TX) {
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD, B_PMAC_PTX_EN, 1, idx);
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_PRD,
+				      B_PMAC_TX_PRD_MSK, period, idx);
+		rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CNT, B_PMAC_TX_CNT_MSK,
+				      pkt_cnt, idx);
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC PTx Start");
+	}
+
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CTRL, B_PMAC_TXEN_DIS, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_TX_CTRL, B_PMAC_TXEN_DIS, 0, idx);
+}
+
+void rtw8852b_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
+			     struct rtw8852b_bb_pmac_info *tx_info,
+			     enum rtw89_phy_idx idx)
+{
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+
+	if (!tx_info->en_pmac_tx) {
+		rtw8852b_stop_pmac_tx(rtwdev, tx_info, idx);
+		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0, idx);
+		if (chan->band_type == RTW89_BAND_2G)
+			rtw89_phy_write32_clr(rtwdev, R_RXCCA, B_RXCCA_DIS);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC Tx Enable");
+
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_TXEN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_RXEN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_RX_CFG1, B_PMAC_OPT1_MSK, 0x3f, idx);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 1, idx);
+	rtw89_phy_write32_set(rtwdev, R_RXCCA, B_RXCCA_DIS);
+	rtw89_phy_write32_idx(rtwdev, R_RSTB_ASYNC, B_RSTB_ASYNC_ALL, 1, idx);
+
+	rtw8852b_start_pmac_tx(rtwdev, tx_info, idx);
+}
+
+void rtw8852b_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
+				 u16 tx_cnt, u16 period, u16 tx_time,
+				 enum rtw89_phy_idx idx)
+{
+	struct rtw8852b_bb_pmac_info tx_info = {0};
+
+	tx_info.en_pmac_tx = enable;
+	tx_info.is_cck = 0;
+	tx_info.mode = PKTS_TX;
+	tx_info.tx_cnt = tx_cnt;
+	tx_info.period = period;
+	tx_info.tx_time = tx_time;
+
+	rtw8852b_bb_set_pmac_tx(rtwdev, &tx_info, idx);
+}
+
+void rtw8852b_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
+			   enum rtw89_phy_idx idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CFG Tx PWR = %d", pwr_dbm);
+
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, pwr_dbm, idx);
+}
+
+void rtw8852b_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path)
+{
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 7, RTW89_PHY_0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "PMAC CFG Tx Path = %d", tx_path);
+
+	if (tx_path == RF_PATH_A) {
+		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 1);
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0);
+	} else if (tx_path == RF_PATH_B) {
+		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 2);
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0);
+	} else if (tx_path == RF_PATH_AB) {
+		rtw89_phy_write32_mask(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, 3);
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 4);
+	} else {
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "Error Tx Path");
+	}
+}
+
+void rtw8852b_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx idx, u8 mode)
+{
+	if (mode != 0)
+		return;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "Tx mode switch");
+
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_TXEN, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_GNT, B_PMAC_GNT_RXEN, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_RX_CFG1, B_PMAC_OPT1_MSK, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_PMAC_RXMOD, B_PMAC_RXMOD_MSK, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_DPD_EN, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_MOD, 0, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 0, idx);
+}
+
+void rtw8852b_bb_backup_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			     struct rtw8852b_bb_tssi_bak *bak)
+{
+	s32 tmp;
+
+	bak->tx_path = rtw89_phy_read32_idx(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, idx);
+	bak->rx_path = rtw89_phy_read32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, idx);
+	bak->p0_rfmode = rtw89_phy_read32_idx(rtwdev, R_P0_RFMODE, MASKDWORD, idx);
+	bak->p0_rfmode_ftm = rtw89_phy_read32_idx(rtwdev, R_P0_RFMODE_FTM_RX, MASKDWORD, idx);
+	bak->p1_rfmode = rtw89_phy_read32_idx(rtwdev, R_P1_RFMODE, MASKDWORD, idx);
+	bak->p1_rfmode_ftm = rtw89_phy_read32_idx(rtwdev, R_P1_RFMODE_FTM_RX, MASKDWORD, idx);
+	tmp = rtw89_phy_read32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, idx);
+	bak->tx_pwr = sign_extend32(tmp, 8);
+}
+
+void rtw8852b_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			      const struct rtw8852b_bb_tssi_bak *bak)
+{
+	rtw89_phy_write32_idx(rtwdev, R_TXPATH_SEL, B_TXPATH_SEL_MSK, bak->tx_path, idx);
+	if (bak->tx_path == RF_AB)
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0x4);
+	else
+		rtw89_phy_write32_mask(rtwdev, R_TXNSS_MAP, B_TXNSS_MAP_MSK, 0x0);
+	rtw89_phy_write32_idx(rtwdev, R_CHBW_MOD_V1, B_ANT_RX_SEG0, bak->rx_path, idx);
+	rtw89_phy_write32_idx(rtwdev, R_MAC_SEL, B_MAC_SEL_PWR_EN, 1, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE, MASKDWORD, bak->p0_rfmode, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P0_RFMODE_FTM_RX, MASKDWORD, bak->p0_rfmode_ftm, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE, MASKDWORD, bak->p1_rfmode, idx);
+	rtw89_phy_write32_idx(rtwdev, R_P1_RFMODE_FTM_RX, MASKDWORD, bak->p1_rfmode_ftm, idx);
+	rtw89_phy_write32_idx(rtwdev, R_TXPWR, B_TXPWR_MSK, bak->tx_pwr, idx);
+}
+
 static void rtw8852b_bb_ctrl_btc_preagc(struct rtw89_dev *rtwdev, bool bt_en)
 {
 	rtw89_phy_write_reg3_tbl(rtwdev, bt_en ? &rtw8852b_btc_preagc_en_defs_tbl :
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.h b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
index 33f621014e497..4f9b3d4768790 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
@@ -10,6 +10,13 @@
 #define RF_PATH_NUM_8852B 2
 #define BB_PATH_NUM_8852B 2
 
+enum rtw8852b_pmac_mode {
+	NONE_TEST,
+	PKTS_TX,
+	PKTS_RX,
+	CONT_TX
+};
+
 struct rtw8852b_u_efuse {
 	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
@@ -85,9 +92,46 @@ struct rtw8852b_efuse {
 	};
 } __packed;
 
+struct rtw8852b_bb_pmac_info {
+	u8 en_pmac_tx:1;
+	u8 is_cck:1;
+	u8 mode:3;
+	u8 rsvd:3;
+	u16 tx_cnt;
+	u16 period;
+	u16 tx_time;
+	u8 duty_cycle;
+};
+
+struct rtw8852b_bb_tssi_bak {
+	u8 tx_path;
+	u8 rx_path;
+	u32 p0_rfmode;
+	u32 p0_rfmode_ftm;
+	u32 p1_rfmode;
+	u32 p1_rfmode_ftm;
+	s16 tx_pwr; /* S9 */
+};
+
 extern const struct rtw89_chip_info rtw8852b_chip_info;
 
+void rtw8852b_bb_set_plcp_tx(struct rtw89_dev *rtwdev);
+void rtw8852b_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
+			     struct rtw8852b_bb_pmac_info *tx_info,
+			     enum rtw89_phy_idx idx);
+void rtw8852b_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
+				 u16 tx_cnt, u16 period, u16 tx_time,
+				 enum rtw89_phy_idx idx);
+void rtw8852b_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
+			   enum rtw89_phy_idx idx);
+void rtw8852b_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path);
 void rtw8852b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
 			      enum rtw89_rf_path_bit rx_path);
+void rtw8852b_bb_tx_mode_switch(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx idx, u8 mode);
+void rtw8852b_bb_backup_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			     struct rtw8852b_bb_tssi_bak *bak);
+void rtw8852b_bb_restore_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
+			      const struct rtw8852b_bb_tssi_bak *bak);
 
 #endif
-- 
2.25.1

