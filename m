Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50F34A287
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 08:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCZHaO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 03:30:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42529 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZH34 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 03:29:56 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12Q7ToEdA013108, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12Q7ToEdA013108
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 15:29:50 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 15:29:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH 2/3] rtw88: 8822c: Add gap-k calibration to improve long range performance
Date:   Fri, 26 Mar 2021 15:29:25 +0800
Message-ID: <20210326072926.28313-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210326072926.28313-1-pkshih@realtek.com>
References: <20210326072926.28313-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

gap-k is a calibration mechanism to eliminate power gaps between
two nearly rate groups.

This mechanism improves performance in long range test by applying
proper power value to those rate groups which have nonlinear power gap.

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       |  12 +
 drivers/net/wireless/realtek/rtw88/fw.h       |   5 +
 drivers/net/wireless/realtek/rtw88/main.h     |  23 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   8 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 697 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  65 +-
 6 files changed, 809 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 6649b84f6b1e..76c43830dfc2 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -350,6 +350,18 @@ void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para)
 }
 EXPORT_SYMBOL(rtw_fw_do_iqk);
 
+void rtw_fw_inform_rfk_status(struct rtw_dev *rtwdev, bool start)
+{
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_WIFI_CALIBRATION);
+
+	RFK_SET_INFORM_START(h2c_pkt, start);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+EXPORT_SYMBOL(rtw_fw_inform_rfk_status);
+
 void rtw_fw_query_bt_info(struct rtw_dev *rtwdev)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 39c905c1b1d8..c3d4c83dd5df 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -353,6 +353,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_WL_CH_INFO		0x66
 #define H2C_CMD_QUERY_BT_MP_INFO	0x67
 #define H2C_CMD_BT_WIFI_CONTROL		0x69
+#define H2C_CMD_WIFI_CALIBRATION	0x6d
 
 #define H2C_CMD_KEEP_ALIVE		0x03
 #define H2C_CMD_DISCONNECT_DECISION	0x04
@@ -530,6 +531,9 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 	le32_get_bits(*((__le32 *)(_header) + 0x01), GENMASK(31, 16))
 #define GET_FW_DUMP_TLV_VAL(_header)					\
 	le32_get_bits(*((__le32 *)(_header) + 0x02), GENMASK(31, 0))
+
+#define RFK_SET_INFORM_START(h2c_pkt, value)				\
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
 static inline struct rtw_c2h_cmd *get_c2h_from_skb(struct sk_buff *skb)
 {
 	u32 pkt_offset;
@@ -545,6 +549,7 @@ void rtw_fw_send_general_info(struct rtw_dev *rtwdev);
 void rtw_fw_send_phydm_info(struct rtw_dev *rtwdev);
 
 void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para);
+void rtw_fw_inform_rfk_status(struct rtw_dev *rtwdev, bool start);
 void rtw_fw_set_pwr_mode(struct rtw_dev *rtwdev);
 void rtw_fw_set_pg_info(struct rtw_dev *rtwdev);
 void rtw_fw_query_bt_info(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ef77b9cb3e21..b3463fee8a62 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1503,6 +1503,27 @@ struct rtw_iqk_info {
 	} result;
 };
 
+enum rtw_rf_band {
+	RF_BAND_2G_CCK,
+	RF_BAND_2G_OFDM,
+	RF_BAND_5G_L,
+	RF_BAND_5G_M,
+	RF_BAND_5G_H,
+	RF_BAND_MAX
+};
+
+#define RF_GAIN_NUM 11
+#define RF_HW_OFFSET_NUM 10
+
+struct rtw_gapk_info {
+	u32 rf3f_bp[RF_BAND_MAX][RF_GAIN_NUM][RTW_RF_PATH_MAX];
+	bool txgapk_bp_done;
+	s8 offset[RF_GAIN_NUM][RTW_RF_PATH_MAX];
+	s8 fianl_offset[RF_GAIN_NUM][RTW_RF_PATH_MAX];
+	u8 read_txgain;
+	u8 channel;
+};
+
 struct rtw_cfo_track {
 	bool is_adjust;
 	u8 crystal_cap;
@@ -1584,6 +1605,8 @@ struct rtw_dm_info {
 	struct ewma_snr ewma_snr[RTW_SNR_NUM];
 
 	struct rtw_iqk_info iqk;
+	struct rtw_gapk_info gapk;
+	bool is_bt_iqk_timeout;
 };
 
 struct rtw_efuse {
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index f719a39cc575..b8d834ceb48b 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -129,6 +129,9 @@
 #define REG_MCU_TST_CFG		0x84
 #define VAL_FW_TRIGGER		0x1
 
+#define REG_PMC_DBG_CTRL1	0xa8
+#define BITS_PMC_BT_IQK_STS	GENMASK(22, 21)
+
 #define REG_EFUSE_ACCESS	0x00CF
 #define EFUSE_ACCESS_ON		0x69
 #define EFUSE_ACCESS_OFF	0x00
@@ -360,6 +363,7 @@
 #define REG_TX_PTCL_CTRL	0x0520
 #define BIT_SIFS_BK_EN		BIT(12)
 #define REG_TXPAUSE		0x0522
+#define BIT_AC_QUEUE		GENMASK(7, 0)
 #define REG_RD_CTRL		0x0524
 #define BIT_DIS_TXOP_CFE	BIT(10)
 #define BIT_DIS_LSIG_CFE	BIT(9)
@@ -644,10 +648,13 @@
 #define RF_WLSEL	0x02
 #define RF_DTXLOK	0x08
 #define RF_CFGCH	0x18
+#define BIT_BAND	GENMASK(18, 16)
 #define RF_RCK		0x1d
 #define RF_LUTWA	0x33
 #define RF_LUTWD1	0x3e
 #define RF_LUTWD0	0x3f
+#define BIT_GAIN_EXT	BIT(12)
+#define BIT_DATA_L	GENMASK(11, 0)
 #define RF_T_METER	0x42
 #define RF_BSPAD	0x54
 #define RF_GAINTX	0x56
@@ -664,6 +671,7 @@
 #define RF_RCKD		0xde
 #define RF_TXADBG	0xde
 #define RF_LUTDBG	0xdf
+#define BIT_TXA_TANK	BIT(4)
 #define RF_LUTWE2	0xee
 #define RF_LUTWE	0xef
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 39232a4aa65f..daa5150de87b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1105,6 +1105,700 @@ static void rtw8822c_pa_bias(struct rtw_dev *rtwdev)
 	}
 }
 
+static void rtw8822c_rfk_handshake(struct rtw_dev *rtwdev, bool is_before_k)
+{
+	struct rtw_dm_info *dm = &rtwdev->dm_info;
+	u8 u1b_tmp;
+	u8 u4b_tmp;
+	int ret;
+
+	if (is_before_k) {
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[RFK] WiFi / BT RFK handshake start!!\n");
+
+		if (!dm->is_bt_iqk_timeout) {
+			ret = read_poll_timeout(rtw_read32_mask, u4b_tmp,
+						u4b_tmp == 0, 20, 600000, false,
+						rtwdev, REG_PMC_DBG_CTRL1,
+						BITS_PMC_BT_IQK_STS);
+			if (ret) {
+				rtw_dbg(rtwdev, RTW_DBG_RFK,
+					"[RFK] Wait BT IQK finish timeout!!\n");
+				dm->is_bt_iqk_timeout = true;
+			}
+		}
+
+		rtw_fw_inform_rfk_status(rtwdev, true);
+
+		ret = read_poll_timeout(rtw_read8_mask, u1b_tmp,
+					u1b_tmp == 1, 20, 100000, false,
+					rtwdev, REG_ARFR4, BIT_WL_RFK);
+		if (ret)
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[RFK] Send WiFi RFK start H2C cmd FAIL!!\n");
+	} else {
+		rtw_fw_inform_rfk_status(rtwdev, false);
+		ret = read_poll_timeout(rtw_read8_mask, u1b_tmp,
+					u1b_tmp == 1, 20, 100000, false,
+					rtwdev, REG_ARFR4,
+					BIT_WL_RFK);
+		if (ret)
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[RFK] Send WiFi RFK finish H2C cmd FAIL!!\n");
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[RFK] WiFi / BT RFK handshake finish!!\n");
+	}
+}
+
+static void rtw8822c_rfk_power_save(struct rtw_dev *rtwdev,
+				    bool is_power_save)
+{
+	u8 path;
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, path);
+		rtw_write32_mask(rtwdev, REG_DPD_CTL1_S0, BIT_PS_EN,
+				 is_power_save ? 0 : 1);
+	}
+}
+
+static void rtw8822c_txgapk_backup_bb_reg(struct rtw_dev *rtwdev, const u32 reg[],
+					  u32 reg_backup[], u32 reg_num)
+{
+	u32 i;
+
+	for (i = 0; i < reg_num; i++) {
+		reg_backup[i] = rtw_read32(rtwdev, reg[i]);
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] Backup BB 0x%x = 0x%x\n",
+			reg[i], reg_backup[i]);
+	}
+}
+
+static void rtw8822c_txgapk_reload_bb_reg(struct rtw_dev *rtwdev,
+					  const u32 reg[], u32 reg_backup[],
+					  u32 reg_num)
+{
+	u32 i;
+
+	for (i = 0; i < reg_num; i++) {
+		rtw_write32(rtwdev, reg[i], reg_backup[i]);
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] Reload BB 0x%x = 0x%x\n",
+			reg[i], reg_backup[i]);
+	}
+}
+
+static bool check_rf_status(struct rtw_dev *rtwdev, u8 status)
+{
+	u8 reg_rf0_a, reg_rf0_b;
+
+	reg_rf0_a = (u8)rtw_read_rf(rtwdev, RF_PATH_A,
+				    RF_MODE_TRXAGC, BIT_RF_MODE);
+	reg_rf0_b = (u8)rtw_read_rf(rtwdev, RF_PATH_B,
+				    RF_MODE_TRXAGC, BIT_RF_MODE);
+
+	if (reg_rf0_a == status || reg_rf0_b == status)
+		return false;
+
+	return true;
+}
+
+static void rtw8822c_txgapk_tx_pause(struct rtw_dev *rtwdev)
+{
+	bool status;
+	int ret;
+
+	rtw_write8(rtwdev, REG_TXPAUSE, BIT_AC_QUEUE);
+	rtw_write32_mask(rtwdev, REG_TX_FIFO, BIT_STOP_TX, 0x2);
+
+	ret = read_poll_timeout_atomic(check_rf_status, status, status,
+				       2, 5000, false, rtwdev, 2);
+	if (ret)
+		rtw_warn(rtwdev, "failed to pause TX\n");
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] Tx pause!!\n");
+}
+
+static void rtw8822c_txgapk_bb_dpk(struct rtw_dev *rtwdev, u8 path)
+{
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	rtw_write32_mask(rtwdev, REG_ENFN, BIT_IQK_DPK_EN, 0x1);
+	rtw_write32_mask(rtwdev, REG_CH_DELAY_EXTR2,
+			 BIT_IQK_DPK_CLOCK_SRC, 0x1);
+	rtw_write32_mask(rtwdev, REG_CH_DELAY_EXTR2,
+			 BIT_IQK_DPK_RESET_SRC, 0x1);
+	rtw_write32_mask(rtwdev, REG_CH_DELAY_EXTR2, BIT_EN_IOQ_IQK_DPK, 0x1);
+	rtw_write32_mask(rtwdev, REG_CH_DELAY_EXTR2, BIT_TST_IQK2SET_SRC, 0x0);
+	rtw_write32_mask(rtwdev, REG_CCA_OFF, BIT_CCA_ON_BY_PW, 0x1ff);
+
+	if (path == RF_PATH_A) {
+		rtw_write32_mask(rtwdev, REG_RFTXEN_GCK_A,
+				 BIT_RFTXEN_GCK_FORCE_ON, 0x1);
+		rtw_write32_mask(rtwdev, REG_3WIRE, BIT_DIS_SHARERX_TXGAT, 0x1);
+		rtw_write32_mask(rtwdev, REG_DIS_SHARE_RX_A,
+				 BIT_TX_SCALE_0DB, 0x1);
+		rtw_write32_mask(rtwdev, REG_3WIRE, BIT_3WIRE_EN, 0x0);
+	} else if (path == RF_PATH_B) {
+		rtw_write32_mask(rtwdev, REG_RFTXEN_GCK_B,
+				 BIT_RFTXEN_GCK_FORCE_ON, 0x1);
+		rtw_write32_mask(rtwdev, REG_3WIRE2,
+				 BIT_DIS_SHARERX_TXGAT, 0x1);
+		rtw_write32_mask(rtwdev, REG_DIS_SHARE_RX_B,
+				 BIT_TX_SCALE_0DB, 0x1);
+		rtw_write32_mask(rtwdev, REG_3WIRE2, BIT_3WIRE_EN, 0x0);
+	}
+	rtw_write32_mask(rtwdev, REG_CCKSB, BIT_BBMODE, 0x2);
+}
+
+static void rtw8822c_txgapk_afe_dpk(struct rtw_dev *rtwdev, u8 path)
+{
+	u32 reg;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	if (path == RF_PATH_A) {
+		reg = REG_ANAPAR_A;
+	} else if (path == RF_PATH_B) {
+		reg = REG_ANAPAR_B;
+	} else {
+		rtw_err(rtwdev, "[TXGAPK] unknown path %d!!\n", path);
+		return;
+	}
+
+	rtw_write32_mask(rtwdev, REG_IQK_CTRL, MASKDWORD, MASKDWORD);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x700f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x700f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x701f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x702f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x703f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x704f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x705f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x706f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x707f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x708f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x709f0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70af0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70bf0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70cf0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70df0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70ef0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70ff0001);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70ff0001);
+}
+
+static void rtw8822c_txgapk_afe_dpk_restore(struct rtw_dev *rtwdev, u8 path)
+{
+	u32 reg;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	if (path == RF_PATH_A) {
+		reg = REG_ANAPAR_A;
+	} else if (path == RF_PATH_B) {
+		reg = REG_ANAPAR_B;
+	} else {
+		rtw_err(rtwdev, "[TXGAPK] unknown path %d!!\n", path);
+		return;
+	}
+	rtw_write32_mask(rtwdev, REG_IQK_CTRL, MASKDWORD, 0xffa1005e);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x700b8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70144041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70244041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70344041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70444041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x705b8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70644041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x707b8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x708b8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x709b8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70ab8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70bb8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70cb8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70db8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70eb8041);
+	rtw_write32_mask(rtwdev, reg, MASKDWORD, 0x70fb8041);
+}
+
+static void rtw8822c_txgapk_bb_dpk_restore(struct rtw_dev *rtwdev, u8 path)
+{
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TX_GAIN, 0x0);
+	rtw_write_rf(rtwdev, path, RF_DIS_BYPASS_TXBB, BIT_TIA_BYPASS, 0x0);
+	rtw_write_rf(rtwdev, path, RF_DIS_BYPASS_TXBB, BIT_TXBB, 0x0);
+
+	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, 0x0);
+	rtw_write32_mask(rtwdev, REG_IQK_CTL1, BIT_TX_CFIR, 0x0);
+	rtw_write32_mask(rtwdev, REG_SINGLE_TONE_SW, BIT_IRQ_TEST_MODE, 0x0);
+	rtw_write32_mask(rtwdev, REG_R_CONFIG, MASKBYTE0, 0x00);
+	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, 0x1);
+	rtw_write32_mask(rtwdev, REG_IQK_CTL1, BIT_TX_CFIR, 0x0);
+	rtw_write32_mask(rtwdev, REG_SINGLE_TONE_SW, BIT_IRQ_TEST_MODE, 0x0);
+	rtw_write32_mask(rtwdev, REG_R_CONFIG, MASKBYTE0, 0x00);
+	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, 0x0);
+	rtw_write32_mask(rtwdev, REG_CCA_OFF, BIT_CCA_ON_BY_PW, 0x0);
+
+	if (path == RF_PATH_A) {
+		rtw_write32_mask(rtwdev, REG_RFTXEN_GCK_A,
+				 BIT_RFTXEN_GCK_FORCE_ON, 0x0);
+		rtw_write32_mask(rtwdev, REG_3WIRE, BIT_DIS_SHARERX_TXGAT, 0x0);
+		rtw_write32_mask(rtwdev, REG_DIS_SHARE_RX_A,
+				 BIT_TX_SCALE_0DB, 0x0);
+		rtw_write32_mask(rtwdev, REG_3WIRE, BIT_3WIRE_EN, 0x3);
+	} else if (path == RF_PATH_B) {
+		rtw_write32_mask(rtwdev, REG_RFTXEN_GCK_B,
+				 BIT_RFTXEN_GCK_FORCE_ON, 0x0);
+		rtw_write32_mask(rtwdev, REG_3WIRE2,
+				 BIT_DIS_SHARERX_TXGAT, 0x0);
+		rtw_write32_mask(rtwdev, REG_DIS_SHARE_RX_B,
+				 BIT_TX_SCALE_0DB, 0x0);
+		rtw_write32_mask(rtwdev, REG_3WIRE2, BIT_3WIRE_EN, 0x3);
+	}
+
+	rtw_write32_mask(rtwdev, REG_CCKSB, BIT_BBMODE, 0x0);
+	rtw_write32_mask(rtwdev, REG_IQK_CTL1, BIT_CFIR_EN, 0x5);
+}
+
+static bool _rtw8822c_txgapk_gain_valid(struct rtw_dev *rtwdev, u32 gain)
+{
+	if ((FIELD_GET(BIT_GAIN_TX_PAD_H, gain) >= 0xc) &&
+	    (FIELD_GET(BIT_GAIN_TX_PAD_L, gain) >= 0xe))
+		return true;
+
+	return false;
+}
+
+static void _rtw8822c_txgapk_write_gain_bb_table(struct rtw_dev *rtwdev,
+						 u8 band, u8 path)
+{
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	u32 v, tmp_3f = 0;
+	u8 gain, check_txgain;
+
+	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, path);
+
+	switch (band) {
+	case RF_BAND_2G_OFDM:
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x0);
+		break;
+	case RF_BAND_5G_L:
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x2);
+		break;
+	case RF_BAND_5G_M:
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x3);
+		break;
+	case RF_BAND_5G_H:
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x4);
+		break;
+	default:
+		break;
+	}
+
+	rtw_write32_mask(rtwdev, REG_TX_GAIN_SET, MASKBYTE0, 0x88);
+
+	check_txgain = 0;
+	for (gain = 0; gain < RF_GAIN_NUM; gain++) {
+		v = txgapk->rf3f_bp[band][gain][path];
+		if (_rtw8822c_txgapk_gain_valid(rtwdev, v)) {
+			if (!check_txgain) {
+				tmp_3f = txgapk->rf3f_bp[band][gain][path];
+				check_txgain = 1;
+			}
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[TXGAPK] tx_gain=0x%03X >= 0xCEX\n",
+				txgapk->rf3f_bp[band][gain][path]);
+		} else {
+			tmp_3f = txgapk->rf3f_bp[band][gain][path];
+		}
+
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_Q_GAIN, tmp_3f);
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_I_GAIN, gain);
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_GAIN_RST, 0x1);
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_GAIN_RST, 0x0);
+
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[TXGAPK] Band=%d 0x1b98[11:0]=0x%03X path=%d\n",
+			band, tmp_3f, path);
+	}
+}
+
+static void rtw8822c_txgapk_write_gain_bb_table(struct rtw_dev *rtwdev)
+{
+	u8 path, band;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s channel=%d\n",
+		__func__, rtwdev->dm_info.gapk.channel);
+
+	for (band = 0; band < RF_BAND_MAX; band++) {
+		for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+			_rtw8822c_txgapk_write_gain_bb_table(rtwdev,
+							     band, path);
+		}
+	}
+}
+
+static void rtw8822c_txgapk_read_offset(struct rtw_dev *rtwdev, u8 path)
+{
+	static const u32 cfg1_1b00[2] = {0x00000d18, 0x00000d2a};
+	static const u32 cfg2_1b00[2] = {0x00000d19, 0x00000d2b};
+	static const u32 set_pi[2] = {REG_RSV_CTRL, REG_WLRF1};
+	static const u32 path_setting[2] = {REG_ORITXCODE, REG_ORITXCODE2};
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	u8 channel = txgapk->channel;
+	u32 val;
+	int i;
+
+	if (path >= ARRAY_SIZE(cfg1_1b00) ||
+	    path >= ARRAY_SIZE(cfg2_1b00) ||
+	    path >= ARRAY_SIZE(set_pi) ||
+	    path >= ARRAY_SIZE(path_setting)) {
+		rtw_warn(rtwdev, "[TXGAPK] wrong path %d\n", path);
+		return;
+	}
+
+	rtw_write32_mask(rtwdev, REG_ANTMAP0, BIT_ANT_PATH, path + 1);
+	rtw_write32_mask(rtwdev, REG_TXLGMAP, MASKDWORD, 0xe4e40000);
+	rtw_write32_mask(rtwdev, REG_TXANTSEG, BIT_ANTSEG, 0x3);
+	rtw_write32_mask(rtwdev, path_setting[path], MASK20BITS, 0x33312);
+	rtw_write32_mask(rtwdev, path_setting[path], BIT_PATH_EN, 0x1);
+	rtw_write32_mask(rtwdev, set_pi[path], BITS_RFC_DIRECT, 0x0);
+	rtw_write_rf(rtwdev, path, RF_LUTDBG, BIT_TXA_TANK, 0x1);
+	rtw_write_rf(rtwdev, path, RF_IDAC, BIT_TX_MODE, 0x820);
+	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, path);
+	rtw_write32_mask(rtwdev, REG_IQKSTAT, MASKBYTE0, 0x0);
+
+	rtw_write32_mask(rtwdev, REG_TX_TONE_IDX, MASKBYTE0, 0x018);
+	fsleep(1000);
+	if (channel >= 1 && channel <= 14)
+		rtw_write32_mask(rtwdev, REG_R_CONFIG, MASKBYTE0, BIT_2G_SWING);
+	else
+		rtw_write32_mask(rtwdev, REG_R_CONFIG, MASKBYTE0, BIT_5G_SWING);
+	fsleep(1000);
+
+	rtw_write32_mask(rtwdev, REG_NCTL0, MASKDWORD, cfg1_1b00[path]);
+	rtw_write32_mask(rtwdev, REG_NCTL0, MASKDWORD, cfg2_1b00[path]);
+
+	read_poll_timeout(rtw_read32_mask, val,
+			  val == 0x55, 1000, 100000, false,
+			  rtwdev, REG_RPT_CIP, BIT_RPT_CIP_STATUS);
+
+	rtw_write32_mask(rtwdev, set_pi[path], BITS_RFC_DIRECT, 0x2);
+	rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, path);
+	rtw_write32_mask(rtwdev, REG_RXSRAM_CTL, BIT_RPT_EN, 0x1);
+	rtw_write32_mask(rtwdev, REG_RXSRAM_CTL, BIT_RPT_SEL, 0x12);
+	rtw_write32_mask(rtwdev, REG_TX_GAIN_SET, BIT_GAPK_RPT_IDX, 0x3);
+	val = rtw_read32(rtwdev, REG_STAT_RPT);
+
+	txgapk->offset[0][path] = (s8)FIELD_GET(BIT_GAPK_RPT0, val);
+	txgapk->offset[1][path] = (s8)FIELD_GET(BIT_GAPK_RPT1, val);
+	txgapk->offset[2][path] = (s8)FIELD_GET(BIT_GAPK_RPT2, val);
+	txgapk->offset[3][path] = (s8)FIELD_GET(BIT_GAPK_RPT3, val);
+	txgapk->offset[4][path] = (s8)FIELD_GET(BIT_GAPK_RPT4, val);
+	txgapk->offset[5][path] = (s8)FIELD_GET(BIT_GAPK_RPT5, val);
+	txgapk->offset[6][path] = (s8)FIELD_GET(BIT_GAPK_RPT6, val);
+	txgapk->offset[7][path] = (s8)FIELD_GET(BIT_GAPK_RPT7, val);
+
+	rtw_write32_mask(rtwdev, REG_TX_GAIN_SET, BIT_GAPK_RPT_IDX, 0x4);
+	val = rtw_read32(rtwdev, REG_STAT_RPT);
+
+	txgapk->offset[8][path] = (s8)FIELD_GET(BIT_GAPK_RPT0, val);
+	txgapk->offset[9][path] = (s8)FIELD_GET(BIT_GAPK_RPT1, val);
+
+	for (i = 0; i < RF_HW_OFFSET_NUM; i++)
+		if (txgapk->offset[i][path] & BIT(3))
+			txgapk->offset[i][path] = txgapk->offset[i][path] |
+						  0xf0;
+	for (i = 0; i < RF_HW_OFFSET_NUM; i++)
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[TXGAPK] offset %d %d path=%d\n",
+			txgapk->offset[i][path], i, path);
+}
+
+static void rtw8822c_txgapk_calculate_offset(struct rtw_dev *rtwdev, u8 path)
+{
+	static const u32 bb_reg[] = {REG_ANTMAP0, REG_TXLGMAP, REG_TXANTSEG,
+				     REG_ORITXCODE, REG_ORITXCODE2};
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	u8 channel = txgapk->channel;
+	u32 reg_backup[ARRAY_SIZE(bb_reg)] = {0};
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s channel=%d\n",
+		__func__, channel);
+
+	rtw8822c_txgapk_backup_bb_reg(rtwdev, bb_reg,
+				      reg_backup, ARRAY_SIZE(bb_reg));
+
+	if (channel >= 1 && channel <= 14) {
+		rtw_write32_mask(rtwdev,
+				 REG_SINGLE_TONE_SW, BIT_IRQ_TEST_MODE, 0x0);
+		rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, path);
+		rtw_write32_mask(rtwdev, REG_R_CONFIG, BIT_IQ_SWITCH, 0x3f);
+		rtw_write32_mask(rtwdev, REG_IQK_CTL1, BIT_TX_CFIR, 0x0);
+		rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TX_GAIN, 0x1);
+		rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC, RFREG_MASK, 0x5000f);
+		rtw_write_rf(rtwdev, path, RF_TX_GAIN_OFFSET, BIT_RF_GAIN, 0x0);
+		rtw_write_rf(rtwdev, path, RF_RXG_GAIN, BIT_RXG_GAIN, 0x1);
+		rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC, BIT_RXAGC, 0x0f);
+		rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TRXBW, 0x1);
+		rtw_write_rf(rtwdev, path, RF_BW_TRXBB, BIT_BW_TXBB, 0x1);
+		rtw_write_rf(rtwdev, path, RF_BW_TRXBB, BIT_BW_RXBB, 0x0);
+		rtw_write_rf(rtwdev, path, RF_EXT_TIA_BW, BIT_PW_EXT_TIA, 0x1);
+
+		rtw_write32_mask(rtwdev, REG_IQKSTAT, MASKBYTE0, 0x00);
+		rtw_write32_mask(rtwdev, REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x0);
+
+		rtw8822c_txgapk_read_offset(rtwdev, path);
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "=============================\n");
+
+	} else {
+		rtw_write32_mask(rtwdev,
+				 REG_SINGLE_TONE_SW, BIT_IRQ_TEST_MODE, 0x0);
+		rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SEL_PATH, path);
+		rtw_write32_mask(rtwdev, REG_R_CONFIG, BIT_IQ_SWITCH, 0x3f);
+		rtw_write32_mask(rtwdev, REG_IQK_CTL1, BIT_TX_CFIR, 0x0);
+		rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TX_GAIN, 0x1);
+		rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC, RFREG_MASK, 0x50011);
+		rtw_write_rf(rtwdev, path, RF_TXA_LB_SW, BIT_TXA_LB_ATT, 0x3);
+		rtw_write_rf(rtwdev, path, RF_TXA_LB_SW, BIT_LB_ATT, 0x3);
+		rtw_write_rf(rtwdev, path, RF_TXA_LB_SW, BIT_LB_SW, 0x1);
+		rtw_write_rf(rtwdev, path,
+			     RF_RXA_MIX_GAIN, BIT_RXA_MIX_GAIN, 0x2);
+		rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC, BIT_RXAGC, 0x12);
+		rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TRXBW, 0x1);
+		rtw_write_rf(rtwdev, path, RF_BW_TRXBB, BIT_BW_RXBB, 0x0);
+		rtw_write_rf(rtwdev, path, RF_EXT_TIA_BW, BIT_PW_EXT_TIA, 0x1);
+		rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC, BIT_RF_MODE, 0x5);
+
+		rtw_write32_mask(rtwdev, REG_IQKSTAT, MASKBYTE0, 0x0);
+
+		if (channel >= 36 && channel <= 64)
+			rtw_write32_mask(rtwdev,
+					 REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x2);
+		else if (channel >= 100 && channel <= 144)
+			rtw_write32_mask(rtwdev,
+					 REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x3);
+		else if (channel >= 149 && channel <= 177)
+			rtw_write32_mask(rtwdev,
+					 REG_TABLE_SEL, BIT_Q_GAIN_SEL, 0x4);
+
+		rtw8822c_txgapk_read_offset(rtwdev, path);
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "=============================\n");
+	}
+	rtw8822c_txgapk_reload_bb_reg(rtwdev, bb_reg,
+				      reg_backup, ARRAY_SIZE(bb_reg));
+}
+
+static void rtw8822c_txgapk_rf_restore(struct rtw_dev *rtwdev, u8 path)
+{
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	if (path >= rtwdev->hal.rf_path_num)
+		return;
+
+	rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC, BIT_RF_MODE, 0x3);
+	rtw_write_rf(rtwdev, path, RF_DEBUG, BIT_DE_TRXBW, 0x0);
+	rtw_write_rf(rtwdev, path, RF_EXT_TIA_BW, BIT_PW_EXT_TIA, 0x0);
+}
+
+static u32 rtw8822c_txgapk_cal_gain(struct rtw_dev *rtwdev, u32 gain, s8 offset)
+{
+	u32 gain_x2, new_gain;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	if (_rtw8822c_txgapk_gain_valid(rtwdev, gain)) {
+		new_gain = gain;
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[TXGAPK] gain=0x%03X(>=0xCEX) offset=%d new_gain=0x%03X\n",
+			gain, offset, new_gain);
+		return new_gain;
+	}
+
+	gain_x2 = (gain << 1) + offset;
+	new_gain = (gain_x2 >> 1) | (gain_x2 & BIT(0) ? BIT_GAIN_EXT : 0);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK,
+		"[TXGAPK] gain=0x%X offset=%d new_gain=0x%X\n",
+		gain, offset, new_gain);
+
+	return new_gain;
+}
+
+static void rtw8822c_txgapk_write_tx_gain(struct rtw_dev *rtwdev)
+{
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	u32 i, j, tmp = 0x20, tmp_3f, v;
+	s8 offset_tmp[RF_GAIN_NUM] = {0};
+	u8 path, band = RF_BAND_2G_OFDM, channel = txgapk->channel;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	if (channel >= 1 && channel <= 14) {
+		tmp = 0x20;
+		band = RF_BAND_2G_OFDM;
+	} else if (channel >= 36 && channel <= 64) {
+		tmp = 0x200;
+		band = RF_BAND_5G_L;
+	} else if (channel >= 100 && channel <= 144) {
+		tmp = 0x280;
+		band = RF_BAND_5G_M;
+	} else if (channel >= 149 && channel <= 177) {
+		tmp = 0x300;
+		band = RF_BAND_5G_H;
+	} else {
+		rtw_err(rtwdev, "[TXGAPK] unknown channel %d!!\n", channel);
+		return;
+	}
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		for (i = 0; i < RF_GAIN_NUM; i++) {
+			offset_tmp[i] = 0;
+			for (j = i; j < RF_GAIN_NUM; j++) {
+				v = txgapk->rf3f_bp[band][j][path];
+				if (_rtw8822c_txgapk_gain_valid(rtwdev, v))
+					continue;
+
+				offset_tmp[i] += txgapk->offset[j][path];
+				txgapk->fianl_offset[i][path] = offset_tmp[i];
+			}
+
+			v = txgapk->rf3f_bp[band][i][path];
+			if (_rtw8822c_txgapk_gain_valid(rtwdev, v))
+				rtw_dbg(rtwdev, RTW_DBG_RFK,
+					"[TXGAPK] tx_gain=0x%03X >= 0xCEX\n",
+					txgapk->rf3f_bp[band][i][path]);
+			else
+				rtw_dbg(rtwdev, RTW_DBG_RFK,
+					"[TXGAPK] offset %d %d\n",
+					offset_tmp[i], i);
+		}
+
+		rtw_write_rf(rtwdev, path, RF_LUTWE2, RFREG_MASK, 0x10000);
+		for (i = 0; i < RF_GAIN_NUM; i++) {
+			rtw_write_rf(rtwdev, path,
+				     RF_LUTWA, RFREG_MASK, tmp + i);
+
+			tmp_3f = rtw8822c_txgapk_cal_gain(rtwdev,
+							  txgapk->rf3f_bp[band][i][path],
+							  offset_tmp[i]);
+			rtw_write_rf(rtwdev, path, RF_LUTWD0,
+				     BIT_GAIN_EXT | BIT_DATA_L, tmp_3f);
+
+			rtw_dbg(rtwdev, RTW_DBG_RFK,
+				"[TXGAPK] 0x33=0x%05X 0x3f=0x%04X\n",
+				tmp + i, tmp_3f);
+		}
+		rtw_write_rf(rtwdev, path, RF_LUTWE2, RFREG_MASK, 0x0);
+	}
+}
+
+static void rtw8822c_txgapk_save_all_tx_gain_table(struct rtw_dev *rtwdev)
+{
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	static const u32 three_wire[2] = {REG_3WIRE, REG_3WIRE2};
+	static const u8 ch_num[RF_BAND_MAX] = {1, 1, 36, 100, 149};
+	static const u8 band_num[RF_BAND_MAX] = {0x0, 0x0, 0x1, 0x3, 0x5};
+	static const u8 cck[RF_BAND_MAX] = {0x1, 0x0, 0x0, 0x0, 0x0};
+	u8 path, band, gain, rf0_idx;
+	u32 rf18, v;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	if (txgapk->read_txgain == 1) {
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[TXGAPK] Already Read txgapk->read_txgain return!!!\n");
+		rtw8822c_txgapk_write_gain_bb_table(rtwdev);
+		return;
+	}
+
+	for (band = 0; band < RF_BAND_MAX; band++) {
+		for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+			rf18 = rtw_read_rf(rtwdev, path, RF_CFGCH, RFREG_MASK);
+
+			rtw_write32_mask(rtwdev,
+					 three_wire[path], BIT_3WIRE_EN, 0x0);
+			rtw_write_rf(rtwdev, path,
+				     RF_CFGCH, MASKBYTE0, ch_num[band]);
+			rtw_write_rf(rtwdev, path,
+				     RF_CFGCH, BIT_BAND, band_num[band]);
+			rtw_write_rf(rtwdev, path,
+				     RF_BW_TRXBB, BIT_DBG_CCK_CCA, cck[band]);
+			rtw_write_rf(rtwdev, path,
+				     RF_BW_TRXBB, BIT_TX_CCK_IND, cck[band]);
+			gain = 0;
+			for (rf0_idx = 1; rf0_idx < 32; rf0_idx += 3) {
+				rtw_write_rf(rtwdev, path, RF_MODE_TRXAGC,
+					     MASKBYTE0, rf0_idx);
+				v = rtw_read_rf(rtwdev, path,
+						RF_TX_RESULT, RFREG_MASK);
+				txgapk->rf3f_bp[band][gain][path] = v & BIT_DATA_L;
+
+				rtw_dbg(rtwdev, RTW_DBG_RFK,
+					"[TXGAPK] 0x5f=0x%03X band=%d path=%d\n",
+					txgapk->rf3f_bp[band][gain][path],
+					band, path);
+				gain++;
+			}
+			rtw_write_rf(rtwdev, path, RF_CFGCH, RFREG_MASK, rf18);
+			rtw_write32_mask(rtwdev,
+					 three_wire[path], BIT_3WIRE_EN, 0x3);
+		}
+	}
+	rtw8822c_txgapk_write_gain_bb_table(rtwdev);
+	txgapk->read_txgain = 1;
+}
+
+static void rtw8822c_txgapk(struct rtw_dev *rtwdev)
+{
+	static const u32 bb_reg[2] = {REG_TX_PTCL_CTRL, REG_TX_FIFO};
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	u32 bb_reg_backup[2];
+	u8 path;
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
+
+	rtw8822c_txgapk_save_all_tx_gain_table(rtwdev);
+
+	if (txgapk->read_txgain == 0) {
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[TXGAPK] txgapk->read_txgain == 0 return!!!\n");
+		return;
+	}
+
+	if (rtwdev->efuse.power_track_type >= 4 &&
+	    rtwdev->efuse.power_track_type <= 7) {
+		rtw_dbg(rtwdev, RTW_DBG_RFK,
+			"[TXGAPK] Normal Mode in TSSI mode. return!!!\n");
+		return;
+	}
+
+	rtw8822c_txgapk_backup_bb_reg(rtwdev, bb_reg,
+				      bb_reg_backup, ARRAY_SIZE(bb_reg));
+	rtw8822c_txgapk_tx_pause(rtwdev);
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		txgapk->channel = rtw_read_rf(rtwdev, path,
+					      RF_CFGCH, RFREG_MASK) & MASKBYTE0;
+		rtw8822c_txgapk_bb_dpk(rtwdev, path);
+		rtw8822c_txgapk_afe_dpk(rtwdev, path);
+		rtw8822c_txgapk_calculate_offset(rtwdev, path);
+		rtw8822c_txgapk_rf_restore(rtwdev, path);
+		rtw8822c_txgapk_afe_dpk_restore(rtwdev, path);
+		rtw8822c_txgapk_bb_dpk_restore(rtwdev, path);
+	}
+	rtw8822c_txgapk_write_tx_gain(rtwdev);
+	rtw8822c_txgapk_reload_bb_reg(rtwdev, bb_reg,
+				      bb_reg_backup, ARRAY_SIZE(bb_reg));
+}
+
+static void rtw8822c_do_gapk(struct rtw_dev *rtwdev)
+{
+	rtw8822c_rfk_handshake(rtwdev, true);
+	rtw8822c_txgapk(rtwdev);
+	rtw8822c_rfk_handshake(rtwdev, false);
+}
+
 static void rtw8822c_rf_init(struct rtw_dev *rtwdev)
 {
 	rtw8822c_rf_dac_cal(rtwdev);
@@ -3403,8 +4097,11 @@ static void rtw8822c_do_dpk(struct rtw_dev *rtwdev)
 
 static void rtw8822c_phy_calibration(struct rtw_dev *rtwdev)
 {
+	rtw8822c_rfk_power_save(rtwdev, false);
+	rtw8822c_do_gapk(rtwdev);
 	rtw8822c_do_iqk(rtwdev);
 	rtw8822c_do_dpk(rtwdev);
+	rtw8822c_rfk_power_save(rtwdev, true);
 }
 
 static void rtw8822c_dpk_track(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 04ec1d7ab8f6..364afc6d851b 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -172,6 +172,7 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_TXDFIR0		0x808
 #define REG_DFIRBW		0x810
 #define REG_ANTMAP0		0x820
+#define BIT_ANT_PATH		GENMASK(1, 0)
 #define REG_ANTMAP		0x824
 #define REG_DYMPRITH		0x86c
 #define REG_DYMENTH0		0x870
@@ -191,12 +192,19 @@ const struct rtw_table name ## _tbl = {			\
 #define BIT_PT_OPT		BIT(21)
 
 #define REG_ORITXCODE		0x1800
+#define BIT_PATH_EN		BIT(31)
 #define REG_3WIRE		0x180c
+#define BIT_DIS_SHARERX_TXGAT	BIT(27)
 #define BIT_3WIRE_TX_EN		BIT(0)
 #define BIT_3WIRE_RX_EN		BIT(1)
+#define BIT_3WIRE_EN		GENMASK(1, 0)
 #define BIT_3WIRE_PI_ON		BIT(28)
 #define REG_ANAPAR_A		0x1830
 #define BIT_ANAPAR_UPDATE	BIT(29)
+#define REG_RFTXEN_GCK_A	0x1864
+#define BIT_RFTXEN_GCK_FORCE_ON	BIT(31)
+#define REG_DIS_SHARE_RX_A	0x186c
+#define BIT_TX_SCALE_0DB	BIT(7)
 #define REG_RXAGCCTL0		0x18ac
 #define BITS_RXAGC_CCK		GENMASK(15, 12)
 #define BITS_RXAGC_OFDM		GENMASK(8, 4)
@@ -206,6 +214,7 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_DCKA_Q_1		0x18dc
 
 #define REG_CCKSB		0x1a00
+#define BIT_BBMODE		GENMASK(2, 1)
 #define REG_RXCCKSEL		0x1a04
 #define REG_BGCTRL		0x1a14
 #define BITS_RX_IQ_WEIGHT	(BIT(8) | BIT(9))
@@ -227,25 +236,42 @@ const struct rtw_table name ## _tbl = {			\
 #define BIT_NBI_EN		BIT(30)
 
 #define REG_NCTL0		0x1b00
+#define BIT_SEL_PATH		GENMASK(2, 1)
 #define BIT_SUBPAGE		GENMASK(3, 0)
 #define REG_DPD_CTL0_S0		0x1b04
 #define BIT_GS_PWSF		GENMASK(27, 0)
 #define REG_DPD_CTL1_S0		0x1b08
 #define BIT_DPD_EN		BIT(31)
+#define BIT_PS_EN		BIT(7)
 #define REG_IQKSTAT		0x1b10
 #define REG_IQK_CTL1		0x1b20
-#define BIT_BYPASS_DPD		BIT(25)
 #define BIT_TX_CFIR		GENMASK(31, 30)
+#define BIT_CFIR_EN		GENMASK(26, 24)
+#define BIT_BYPASS_DPD		BIT(25)
+
+#define REG_TX_TONE_IDX		0x1b2c
 #define REG_DPD_LUT0		0x1b44
 #define BIT_GLOSS_DB		GENMASK(14, 12)
 #define REG_DPD_CTL0_S1		0x1b5c
 #define REG_DPD_CTL1_S1		0x1b60
 #define REG_DPD_AGC		0x1b67
+#define REG_TABLE_SEL		0x1b98
+#define BIT_I_GAIN		GENMASK(19, 16)
+#define BIT_GAIN_RST		BIT(15)
+#define BIT_Q_GAIN_SEL		GENMASK(14, 12)
+#define BIT_Q_GAIN		GENMASK(11, 0)
+#define REG_TX_GAIN_SET		0x1b9c
+#define BIT_GAPK_RPT_IDX	GENMASK(11, 8)
 #define REG_DPD_CTL0		0x1bb4
+#define REG_SINGLE_TONE_SW	0x1bb8
+#define BIT_IRQ_TEST_MODE	BIT(20)
 #define REG_R_CONFIG		0x1bcc
 #define BIT_INNER_LB		BIT(21)
 #define BIT_IQ_SWITCH		GENMASK(5, 0)
+#define BIT_2G_SWING		0x2d
+#define BIT_5G_SWING		0x36
 #define REG_RXSRAM_CTL		0x1bd4
+#define BIT_RPT_EN		BIT(21)
 #define BIT_RPT_SEL		GENMASK(20, 16)
 #define BIT_DPD_CLK		GENMASK(7, 4)
 #define REG_DPD_CTL11		0x1be4
@@ -254,23 +280,44 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_DPD_CTL16		0x1bf8
 #define REG_STAT_RPT		0x1bfc
 #define BIT_RPT_DGAIN		GENMASK(27, 16)
+#define BIT_GAPK_RPT0		GENMASK(3, 0)
+#define BIT_GAPK_RPT1		GENMASK(7, 4)
+#define BIT_GAPK_RPT2		GENMASK(11, 8)
+#define BIT_GAPK_RPT3		GENMASK(15, 12)
+#define BIT_GAPK_RPT4		GENMASK(19, 16)
+#define BIT_GAPK_RPT5		GENMASK(23, 20)
+#define BIT_GAPK_RPT6		GENMASK(27, 24)
+#define BIT_GAPK_RPT7		GENMASK(31, 28)
 
 #define REG_TXANT		0x1c28
+#define REG_IQK_CTRL		0x1c38
 #define REG_ENCCK		0x1c3c
 #define BIT_CCK_BLK_EN		BIT(1)
 #define BIT_CCK_OFDM_BLK_EN	(BIT(0) | BIT(1))
 #define REG_CCAMSK		0x1c80
 #define REG_RSTB		0x1c90
 #define BIT_RSTB_3WIRE		BIT(8)
+#define REG_CH_DELAY_EXTR2	0x1cd0
+#define BIT_TST_IQK2SET_SRC	BIT(31)
+#define BIT_EN_IOQ_IQK_DPK	BIT(30)
+#define BIT_IQK_DPK_RESET_SRC	BIT(29)
+#define BIT_IQK_DPK_CLOCK_SRC	BIT(28)
 
 #define REG_RX_BREAK		0x1d2c
 #define BIT_COM_RX_GCK_EN	BIT(31)
 #define REG_RXFNCTL		0x1d30
+#define REG_CCA_OFF		0x1d58
+#define BIT_CCA_ON_BY_PW	GENMASK(11, 3)
 #define REG_RXIGI		0x1d70
+
 #define REG_ENFN		0x1e24
+#define BIT_IQK_DPK_EN		BIT(17)
 #define REG_TXANTSEG		0x1e28
+#define BIT_ANTSEG		GENMASK(3, 0)
 #define REG_TXLGMAP		0x1e2c
 #define REG_CCKPATH		0x1e5c
+#define REG_TX_FIFO		0x1e70
+#define BIT_STOP_TX		GENMASK(3, 0)
 #define REG_CNT_CTRL		0x1eb4
 #define BIT_ALL_CNT_RST		BIT(25)
 
@@ -281,11 +328,15 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_OFDM_FACNT4		0x2d10
 #define REG_OFDM_FACNT5		0x2d20
 #define REG_RPT_CIP		0x2d9c
+#define BIT_RPT_CIP_STATUS	GENMASK(7, 0)
 #define REG_OFDM_TXCNT		0x2de0
 
 #define REG_ORITXCODE2		0x4100
 #define REG_3WIRE2		0x410c
 #define REG_ANAPAR_B		0x4130
+#define REG_RFTXEN_GCK_B	0x4164
+#define REG_DIS_SHARE_RX_B	0x416c
+#define BIT_EXT_TIA_BW		BIT(1)
 #define REG_RXAGCCTL		0x41ac
 #define REG_DCKB_I_0		0x41bc
 #define REG_DCKB_I_1		0x41c0
@@ -293,17 +344,25 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_DCKB_Q_1		0x41dc
 
 #define RF_MODE_TRXAGC		0x00
+#define BIT_RF_MODE		GENMASK(19, 16)
 #define BIT_RXAGC		GENMASK(9, 5)
 #define BIT_TXAGC		GENMASK(4, 0)
 #define RF_RXAGC_OFFSET		0x19
 #define RF_BW_TRXBB		0x1a
+#define BIT_TX_CCK_IND		BIT(16)
 #define BIT_BW_TXBB		GENMASK(14, 12)
 #define BIT_BW_RXBB		GENMASK(11, 10)
+#define BIT_DBG_CCK_CCA		BIT(1)
 #define RF_TX_GAIN_OFFSET	0x55
 #define BIT_BB_GAIN		GENMASK(18, 14)
 #define BIT_RF_GAIN		GENMASK(4, 2)
 #define RF_TX_GAIN		0x56
 #define BIT_GAIN_TXBB		GENMASK(4, 0)
+#define RF_IDAC			0x58
+#define BIT_TX_MODE		GENMASK(19, 8)
+#define RF_TX_RESULT		0x5f
+#define BIT_GAIN_TX_PAD_H	GENMASK(11, 8)
+#define BIT_GAIN_TX_PAD_L	GENMASK(7, 4)
 #define RF_PA			0x60
 #define RF_PABIAS_2G_MASK	GENMASK(15, 12)
 #define RF_PABIAS_5G_MASK	GENMASK(19, 16)
@@ -316,6 +375,10 @@ const struct rtw_table name ## _tbl = {			\
 #define RF_RXA_MIX_GAIN		0x8a
 #define BIT_RXA_MIX_GAIN	GENMASK(4, 3)
 #define RF_EXT_TIA_BW		0x8f
+#define BIT_PW_EXT_TIA		BIT(1)
+#define RF_DIS_BYPASS_TXBB	0x9e
+#define BIT_TXBB		BIT(10)
+#define BIT_TIA_BYPASS		BIT(5)
 #define RF_DEBUG		0xde
 #define BIT_DE_PWR_TRIM		BIT(19)
 #define BIT_DE_TX_GAIN		BIT(16)
-- 
2.21.0

