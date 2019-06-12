Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39E41C7F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 08:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfFLGpk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 02:45:40 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51310 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfFLGpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 02:45:39 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5C6jXuf004384, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5C6jXuf004384
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 12 Jun 2019 14:45:33 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 12 Jun 2019 14:45:33 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 09/11] rtw88: restore DACK results to save time
Date:   Wed, 12 Jun 2019 14:45:15 +0800
Message-ID: <1560321917-17751-10-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
References: <1560321917-17751-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

DACK is done right after the hardware has been turned on, which
means it will be done every time we leave the IDLE state.
But it takes ~2 seconds to finish DACK.

We can back up the results and restore them. And it only takes a few
milliseconds to restore the results to the hardware, saving a lot of
time.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |   8 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 351 +++++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |   8 +
 3 files changed, 355 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 414d21f..92730507 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -841,6 +841,9 @@ struct rtw_chip_info {
 	u32 rfe_defs_size;
 };
 
+#define DACK_MSBK_BACKUP_NUM	0xf
+#define DACK_DCK_BACKUP_NUM	0x2
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
@@ -856,6 +859,11 @@ struct rtw_dm_info {
 
 	u8 cck_gi_u_bnd;
 	u8 cck_gi_l_bnd;
+
+	/* backup dack results for each path and I/Q */
+	u32 dack_adck[RTW_RF_PATH_MAX];
+	u16 dack_msbk[RTW_RF_PATH_MAX][2][DACK_MSBK_BACKUP_NUM];
+	u8 dack_dck[RTW_RF_PATH_MAX][2][DACK_DCK_BACKUP_NUM];
 };
 
 struct rtw_efuse {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 4896f25..8198f2e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -203,7 +203,7 @@ static void rtw8822c_dac_iq_offset(struct rtw_dev *rtwdev, u32 *vec, u32 *val)
 	*val = t;
 }
 
-static u32 rtw8822c_get_path_base_addr(u8 path)
+static u32 rtw8822c_get_path_write_addr(u8 path)
 {
 	u32 base_addr;
 
@@ -222,6 +222,25 @@ static u32 rtw8822c_get_path_base_addr(u8 path)
 	return base_addr;
 }
 
+static u32 rtw8822c_get_path_read_addr(u8 path)
+{
+	u32 base_addr;
+
+	switch (path) {
+	case RF_PATH_A:
+		base_addr = 0x2800;
+		break;
+	case RF_PATH_B:
+		base_addr = 0x4500;
+		break;
+	default:
+		WARN_ON(1);
+		return -1;
+	}
+
+	return base_addr;
+}
+
 static bool rtw8822c_dac_iq_check(struct rtw_dev *rtwdev, u32 value)
 {
 	bool ret = true;
@@ -316,8 +335,6 @@ static void rtw8822c_dac_cal_rf_mode(struct rtw_dev *rtwdev,
 	u32 iv[DACK_SN_8822C], qv[DACK_SN_8822C];
 	u32 rf_a, rf_b;
 
-	mdelay(10);
-
 	rf_a = rtw_read_rf(rtwdev, RF_PATH_A, 0x0, RFREG_MASK);
 	rf_b = rtw_read_rf(rtwdev, RF_PATH_B, 0x0, RFREG_MASK);
 
@@ -347,6 +364,7 @@ static void rtw8822c_dac_bb_setting(struct rtw_dev *rtwdev)
 static void rtw8822c_dac_cal_adc(struct rtw_dev *rtwdev,
 				 u8 path, u32 *adc_ic, u32 *adc_qc)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u32 ic = 0, qc = 0, temp = 0;
 	u32 base_addr;
 	u32 path_sel;
@@ -354,7 +372,7 @@ static void rtw8822c_dac_cal_adc(struct rtw_dev *rtwdev,
 
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] ADCK path(%d)\n", path);
 
-	base_addr = rtw8822c_get_path_base_addr(path);
+	base_addr = rtw8822c_get_path_write_addr(path);
 	switch (path) {
 	case RF_PATH_A:
 		path_sel = 0xa0000;
@@ -396,6 +414,7 @@ static void rtw8822c_dac_cal_adc(struct rtw_dev *rtwdev,
 		}
 		temp = (ic & 0x3ff) | ((qc & 0x3ff) << 10);
 		rtw_write32(rtwdev, base_addr + 0x68, temp);
+		dm_info->dack_adck[path] = temp;
 		rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] ADCK 0x%08x=0x08%x\n",
 			base_addr + 0x68, temp);
 		/* check ADC DC offset */
@@ -422,10 +441,14 @@ static void rtw8822c_dac_cal_adc(struct rtw_dev *rtwdev,
 
 static void rtw8822c_dac_cal_step1(struct rtw_dev *rtwdev, u8 path)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u32 base_addr;
+	u32 read_addr;
 
-	base_addr = rtw8822c_get_path_base_addr(path);
+	base_addr = rtw8822c_get_path_write_addr(path);
+	read_addr = rtw8822c_get_path_read_addr(path);
 
+	rtw_write32(rtwdev, base_addr + 0x68, dm_info->dack_adck[path]);
 	rtw_write32(rtwdev, base_addr + 0x0c, 0xdff00220);
 	if (path == RF_PATH_A) {
 		rtw_write32(rtwdev, base_addr + 0x60, 0xf0040ff0);
@@ -447,11 +470,13 @@ static void rtw8822c_dac_cal_step1(struct rtw_dev *rtwdev, u8 path)
 	rtw_write32(rtwdev, base_addr + 0xcc, 0x0a11fb89);
 	mdelay(1);
 	rtw_write32(rtwdev, base_addr + 0xb8, 0x62000000);
-	mdelay(20);
 	rtw_write32(rtwdev, base_addr + 0xd4, 0x62000000);
 	mdelay(20);
+	if (!check_hw_ready(rtwdev, read_addr + 0x08, 0x7fff80, 0xffff) ||
+	    !check_hw_ready(rtwdev, read_addr + 0x34, 0x7fff80, 0xffff))
+		rtw_err(rtwdev, "failed to wait for dack ready\n");
 	rtw_write32(rtwdev, base_addr + 0xb8, 0x02000000);
-	mdelay(20);
+	mdelay(1);
 	rtw_write32(rtwdev, base_addr + 0xbc, 0x0008ff87);
 	rtw_write32(rtwdev, 0x9b4, 0xdb6db600);
 	rtw_write32(rtwdev, base_addr + 0x10, 0x02d508c5);
@@ -465,7 +490,7 @@ static void rtw8822c_dac_cal_step2(struct rtw_dev *rtwdev,
 	u32 base_addr;
 	u32 ic, qc, ic_in, qc_in;
 
-	base_addr = rtw8822c_get_path_base_addr(path);
+	base_addr = rtw8822c_get_path_write_addr(path);
 	rtw_write32_mask(rtwdev, base_addr + 0xbc, 0xf0000000, 0x0);
 	rtw_write32_mask(rtwdev, base_addr + 0xc0, 0xf, 0x8);
 	rtw_write32_mask(rtwdev, base_addr + 0xd8, 0xf0000000, 0x0);
@@ -514,10 +539,12 @@ static void rtw8822c_dac_cal_step3(struct rtw_dev *rtwdev, u8 path,
 				   u32 *i_out, u32 *q_out)
 {
 	u32 base_addr;
+	u32 read_addr;
 	u32 ic, qc;
 	u32 temp;
 
-	base_addr = rtw8822c_get_path_base_addr(path);
+	base_addr = rtw8822c_get_path_write_addr(path);
+	read_addr = rtw8822c_get_path_read_addr(path);
 	ic = *ic_in;
 	qc = *qc_in;
 
@@ -542,11 +569,13 @@ static void rtw8822c_dac_cal_step3(struct rtw_dev *rtwdev, u8 path,
 	rtw_write32(rtwdev, base_addr + 0xcc, 0x0a11fb89);
 	mdelay(1);
 	rtw_write32(rtwdev, base_addr + 0xb8, 0x62000000);
-	mdelay(20);
 	rtw_write32(rtwdev, base_addr + 0xd4, 0x62000000);
 	mdelay(20);
+	if (!check_hw_ready(rtwdev, read_addr + 0x24, 0x07f80000, ic) ||
+	    !check_hw_ready(rtwdev, read_addr + 0x50, 0x07f80000, qc))
+		rtw_err(rtwdev, "failed to write IQ vector to hardware\n");
 	rtw_write32(rtwdev, base_addr + 0xb8, 0x02000000);
-	mdelay(20);
+	mdelay(1);
 	rtw_write32_mask(rtwdev, base_addr + 0xbc, 0xe, 0x3);
 	rtw_write32(rtwdev, 0x9b4, 0xdb6db600);
 
@@ -583,7 +612,7 @@ static void rtw8822c_dac_cal_step3(struct rtw_dev *rtwdev, u8 path,
 
 static void rtw8822c_dac_cal_step4(struct rtw_dev *rtwdev, u8 path)
 {
-	u32 base_addr = rtw8822c_get_path_base_addr(path);
+	u32 base_addr = rtw8822c_get_path_write_addr(path);
 
 	rtw_write32(rtwdev, base_addr + 0x68, 0x0);
 	rtw_write32(rtwdev, base_addr + 0x10, 0x02d508c4);
@@ -591,6 +620,296 @@ static void rtw8822c_dac_cal_step4(struct rtw_dev *rtwdev, u8 path)
 	rtw_write32_mask(rtwdev, base_addr + 0x30, BIT(30), 0x1);
 }
 
+static void rtw8822c_dac_cal_backup_vec(struct rtw_dev *rtwdev,
+					u8 path, u8 vec, u32 w_addr, u32 r_addr)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u16 val;
+	u32 i;
+
+	if (WARN_ON(vec >= 2))
+		return;
+
+	for (i = 0; i < DACK_MSBK_BACKUP_NUM; i++) {
+		rtw_write32_mask(rtwdev, w_addr, 0xf0000000, i);
+		val = (u16)rtw_read32_mask(rtwdev, r_addr, 0x7fc0000);
+		dm_info->dack_msbk[path][vec][i] = val;
+	}
+}
+
+static void rtw8822c_dac_cal_backup_path(struct rtw_dev *rtwdev, u8 path)
+{
+	u32 w_off = 0x1c;
+	u32 r_off = 0x2c;
+	u32 w_addr, r_addr;
+
+	if (WARN_ON(path >= 2))
+		return;
+
+	/* backup I vector */
+	w_addr = rtw8822c_get_path_write_addr(path) + 0xb0;
+	r_addr = rtw8822c_get_path_read_addr(path) + 0x10;
+	rtw8822c_dac_cal_backup_vec(rtwdev, path, 0, w_addr, r_addr);
+
+	/* backup Q vector */
+	w_addr = rtw8822c_get_path_write_addr(path) + 0xb0 + w_off;
+	r_addr = rtw8822c_get_path_read_addr(path) + 0x10 + r_off;
+	rtw8822c_dac_cal_backup_vec(rtwdev, path, 1, w_addr, r_addr);
+}
+
+static void rtw8822c_dac_cal_backup_dck(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 val;
+
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKA_I_0, 0xf0000000);
+	dm_info->dack_dck[RF_PATH_A][0][0] = val;
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKA_I_1, 0xf);
+	dm_info->dack_dck[RF_PATH_A][0][1] = val;
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKA_Q_0, 0xf0000000);
+	dm_info->dack_dck[RF_PATH_A][1][0] = val;
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKA_Q_1, 0xf);
+	dm_info->dack_dck[RF_PATH_A][1][1] = val;
+
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKB_I_0, 0xf0000000);
+	dm_info->dack_dck[RF_PATH_B][0][0] = val;
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKB_I_1, 0xf);
+	dm_info->dack_dck[RF_PATH_B][1][0] = val;
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKB_Q_0, 0xf0000000);
+	dm_info->dack_dck[RF_PATH_B][0][1] = val;
+	val = (u8)rtw_read32_mask(rtwdev, REG_DCKB_Q_1, 0xf);
+	dm_info->dack_dck[RF_PATH_B][1][1] = val;
+}
+
+static void rtw8822c_dac_cal_backup(struct rtw_dev *rtwdev)
+{
+	u32 temp[3];
+
+	temp[0] = rtw_read32(rtwdev, 0x1860);
+	temp[1] = rtw_read32(rtwdev, 0x4160);
+	temp[2] = rtw_read32(rtwdev, 0x9b4);
+
+	/* set clock */
+	rtw_write32(rtwdev, 0x9b4, 0xdb66db00);
+
+	/* backup path-A I/Q */
+	rtw_write32_clr(rtwdev, 0x1830, BIT(30));
+	rtw_write32_mask(rtwdev, 0x1860, 0xfc000000, 0x3c);
+	rtw8822c_dac_cal_backup_path(rtwdev, RF_PATH_A);
+
+	/* backup path-B I/Q */
+	rtw_write32_clr(rtwdev, 0x4130, BIT(30));
+	rtw_write32_mask(rtwdev, 0x4160, 0xfc000000, 0x3c);
+	rtw8822c_dac_cal_backup_path(rtwdev, RF_PATH_B);
+
+	rtw8822c_dac_cal_backup_dck(rtwdev);
+	rtw_write32_set(rtwdev, 0x1830, BIT(30));
+	rtw_write32_set(rtwdev, 0x4130, BIT(30));
+
+	rtw_write32(rtwdev, 0x1860, temp[0]);
+	rtw_write32(rtwdev, 0x4160, temp[1]);
+	rtw_write32(rtwdev, 0x9b4, temp[2]);
+}
+
+static void rtw8822c_dac_cal_restore_dck(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 val;
+
+	rtw_write32_set(rtwdev, REG_DCKA_I_0, BIT(19));
+	val = dm_info->dack_dck[RF_PATH_A][0][0];
+	rtw_write32_mask(rtwdev, REG_DCKA_I_0, 0xf0000000, val);
+	val = dm_info->dack_dck[RF_PATH_A][0][1];
+	rtw_write32_mask(rtwdev, REG_DCKA_I_1, 0xf, val);
+
+	rtw_write32_set(rtwdev, REG_DCKA_Q_0, BIT(19));
+	val = dm_info->dack_dck[RF_PATH_A][1][0];
+	rtw_write32_mask(rtwdev, REG_DCKA_Q_0, 0xf0000000, val);
+	val = dm_info->dack_dck[RF_PATH_A][1][1];
+	rtw_write32_mask(rtwdev, REG_DCKA_Q_1, 0xf, val);
+
+	rtw_write32_set(rtwdev, REG_DCKB_I_0, BIT(19));
+	val = dm_info->dack_dck[RF_PATH_B][0][0];
+	rtw_write32_mask(rtwdev, REG_DCKB_I_0, 0xf0000000, val);
+	val = dm_info->dack_dck[RF_PATH_B][0][1];
+	rtw_write32_mask(rtwdev, REG_DCKB_I_1, 0xf, val);
+
+	rtw_write32_set(rtwdev, REG_DCKB_Q_0, BIT(19));
+	val = dm_info->dack_dck[RF_PATH_B][1][0];
+	rtw_write32_mask(rtwdev, REG_DCKB_Q_0, 0xf0000000, val);
+	val = dm_info->dack_dck[RF_PATH_B][1][1];
+	rtw_write32_mask(rtwdev, REG_DCKB_Q_1, 0xf, val);
+}
+
+static void rtw8822c_dac_cal_restore_prepare(struct rtw_dev *rtwdev)
+{
+	rtw_write32(rtwdev, 0x9b4, 0xdb66db00);
+
+	rtw_write32_mask(rtwdev, 0x18b0, BIT(27), 0x0);
+	rtw_write32_mask(rtwdev, 0x18cc, BIT(27), 0x0);
+	rtw_write32_mask(rtwdev, 0x41b0, BIT(27), 0x0);
+	rtw_write32_mask(rtwdev, 0x41cc, BIT(27), 0x0);
+
+	rtw_write32_mask(rtwdev, 0x1830, BIT(30), 0x0);
+	rtw_write32_mask(rtwdev, 0x1860, 0xfc000000, 0x3c);
+	rtw_write32_mask(rtwdev, 0x18b4, BIT(0), 0x1);
+	rtw_write32_mask(rtwdev, 0x18d0, BIT(0), 0x1);
+
+	rtw_write32_mask(rtwdev, 0x4130, BIT(30), 0x0);
+	rtw_write32_mask(rtwdev, 0x4160, 0xfc000000, 0x3c);
+	rtw_write32_mask(rtwdev, 0x41b4, BIT(0), 0x1);
+	rtw_write32_mask(rtwdev, 0x41d0, BIT(0), 0x1);
+
+	rtw_write32_mask(rtwdev, 0x18b0, 0xf00, 0x0);
+	rtw_write32_mask(rtwdev, 0x18c0, BIT(14), 0x0);
+	rtw_write32_mask(rtwdev, 0x18cc, 0xf00, 0x0);
+	rtw_write32_mask(rtwdev, 0x18dc, BIT(14), 0x0);
+
+	rtw_write32_mask(rtwdev, 0x18b0, BIT(0), 0x0);
+	rtw_write32_mask(rtwdev, 0x18cc, BIT(0), 0x0);
+	rtw_write32_mask(rtwdev, 0x18b0, BIT(0), 0x1);
+	rtw_write32_mask(rtwdev, 0x18cc, BIT(0), 0x1);
+
+	rtw8822c_dac_cal_restore_dck(rtwdev);
+
+	rtw_write32_mask(rtwdev, 0x18c0, 0x38000, 0x7);
+	rtw_write32_mask(rtwdev, 0x18dc, 0x38000, 0x7);
+	rtw_write32_mask(rtwdev, 0x41c0, 0x38000, 0x7);
+	rtw_write32_mask(rtwdev, 0x41dc, 0x38000, 0x7);
+
+	rtw_write32_mask(rtwdev, 0x18b8, BIT(26) | BIT(25), 0x1);
+	rtw_write32_mask(rtwdev, 0x18d4, BIT(26) | BIT(25), 0x1);
+
+	rtw_write32_mask(rtwdev, 0x41b0, 0xf00, 0x0);
+	rtw_write32_mask(rtwdev, 0x41c0, BIT(14), 0x0);
+	rtw_write32_mask(rtwdev, 0x41cc, 0xf00, 0x0);
+	rtw_write32_mask(rtwdev, 0x41dc, BIT(14), 0x0);
+
+	rtw_write32_mask(rtwdev, 0x41b0, BIT(0), 0x0);
+	rtw_write32_mask(rtwdev, 0x41cc, BIT(0), 0x0);
+	rtw_write32_mask(rtwdev, 0x41b0, BIT(0), 0x1);
+	rtw_write32_mask(rtwdev, 0x41cc, BIT(0), 0x1);
+
+	rtw_write32_mask(rtwdev, 0x41b8, BIT(26) | BIT(25), 0x1);
+	rtw_write32_mask(rtwdev, 0x41d4, BIT(26) | BIT(25), 0x1);
+}
+
+static bool rtw8822c_dac_cal_restore_wait(struct rtw_dev *rtwdev,
+					  u32 target_addr, u32 toggle_addr)
+{
+	u32 cnt = 0;
+
+	do {
+		rtw_write32_mask(rtwdev, toggle_addr, BIT(26) | BIT(25), 0x0);
+		rtw_write32_mask(rtwdev, toggle_addr, BIT(26) | BIT(25), 0x2);
+
+		if (rtw_read32_mask(rtwdev, target_addr, 0xf) == 0x6)
+			return true;
+
+	} while (cnt++ < 100);
+
+	return false;
+}
+
+static bool rtw8822c_dac_cal_restore_path(struct rtw_dev *rtwdev, u8 path)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 w_off = 0x1c;
+	u32 r_off = 0x2c;
+	u32 w_i, r_i, w_q, r_q;
+	u32 value;
+	u32 i;
+
+	w_i = rtw8822c_get_path_write_addr(path) + 0xb0;
+	r_i = rtw8822c_get_path_read_addr(path) + 0x08;
+	w_q = rtw8822c_get_path_write_addr(path) + 0xb0 + w_off;
+	r_q = rtw8822c_get_path_read_addr(path) + 0x08 + r_off;
+
+	if (!rtw8822c_dac_cal_restore_wait(rtwdev, r_i, w_i + 0x8))
+		return false;
+
+	for (i = 0; i < DACK_MSBK_BACKUP_NUM; i++) {
+		rtw_write32_mask(rtwdev, w_i + 0x4, BIT(2), 0x0);
+		value = dm_info->dack_msbk[path][0][i];
+		rtw_write32_mask(rtwdev, w_i + 0x4, 0xff8, value);
+		rtw_write32_mask(rtwdev, w_i, 0xf0000000, i);
+		rtw_write32_mask(rtwdev, w_i + 0x4, BIT(2), 0x1);
+	}
+
+	rtw_write32_mask(rtwdev, w_i + 0x4, BIT(2), 0x0);
+
+	if (!rtw8822c_dac_cal_restore_wait(rtwdev, r_q, w_q + 0x8))
+		return false;
+
+	for (i = 0; i < DACK_MSBK_BACKUP_NUM; i++) {
+		rtw_write32_mask(rtwdev, w_q + 0x4, BIT(2), 0x0);
+		value = dm_info->dack_msbk[path][1][i];
+		rtw_write32_mask(rtwdev, w_q + 0x4, 0xff8, value);
+		rtw_write32_mask(rtwdev, w_q, 0xf0000000, i);
+		rtw_write32_mask(rtwdev, w_q + 0x4, BIT(2), 0x1);
+	}
+	rtw_write32_mask(rtwdev, w_q + 0x4, BIT(2), 0x0);
+
+	rtw_write32_mask(rtwdev, w_i + 0x8, BIT(26) | BIT(25), 0x0);
+	rtw_write32_mask(rtwdev, w_q + 0x8, BIT(26) | BIT(25), 0x0);
+	rtw_write32_mask(rtwdev, w_i + 0x4, BIT(0), 0x0);
+	rtw_write32_mask(rtwdev, w_q + 0x4, BIT(0), 0x0);
+
+	return true;
+}
+
+static bool __rtw8822c_dac_cal_restore(struct rtw_dev *rtwdev)
+{
+	if (!rtw8822c_dac_cal_restore_path(rtwdev, RF_PATH_A))
+		return false;
+
+	if (!rtw8822c_dac_cal_restore_path(rtwdev, RF_PATH_B))
+		return false;
+
+	return true;
+}
+
+static bool rtw8822c_dac_cal_restore(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 temp[3];
+
+	/* sample the first element for both path's IQ vector */
+	if (dm_info->dack_msbk[RF_PATH_A][0][0] == 0 &&
+	    dm_info->dack_msbk[RF_PATH_A][1][0] == 0 &&
+	    dm_info->dack_msbk[RF_PATH_B][0][0] == 0 &&
+	    dm_info->dack_msbk[RF_PATH_B][1][0] == 0)
+		return false;
+
+	temp[0] = rtw_read32(rtwdev, 0x1860);
+	temp[1] = rtw_read32(rtwdev, 0x4160);
+	temp[2] = rtw_read32(rtwdev, 0x9b4);
+
+	rtw8822c_dac_cal_restore_prepare(rtwdev);
+	if (!check_hw_ready(rtwdev, 0x2808, 0x7fff80, 0xffff) ||
+	    !check_hw_ready(rtwdev, 0x2834, 0x7fff80, 0xffff) ||
+	    !check_hw_ready(rtwdev, 0x4508, 0x7fff80, 0xffff) ||
+	    !check_hw_ready(rtwdev, 0x4534, 0x7fff80, 0xffff))
+		return false;
+
+	if (!__rtw8822c_dac_cal_restore(rtwdev)) {
+		rtw_err(rtwdev, "failed to restore dack vectors\n");
+		return false;
+	}
+
+	rtw_write32_mask(rtwdev, 0x1830, BIT(30), 0x1);
+	rtw_write32_mask(rtwdev, 0x4130, BIT(30), 0x1);
+	rtw_write32(rtwdev, 0x1860, temp[0]);
+	rtw_write32(rtwdev, 0x4160, temp[1]);
+	rtw_write32_mask(rtwdev, 0x18b0, BIT(27), 0x1);
+	rtw_write32_mask(rtwdev, 0x18cc, BIT(27), 0x1);
+	rtw_write32_mask(rtwdev, 0x41b0, BIT(27), 0x1);
+	rtw_write32_mask(rtwdev, 0x41cc, BIT(27), 0x1);
+	rtw_write32(rtwdev, 0x9b4, temp[2]);
+
+	return true;
+}
+
 static void rtw8822c_rf_dac_cal(struct rtw_dev *rtwdev)
 {
 	struct rtw_backup_info backup_rf[DACK_RF_8822C * DACK_PATH_8822C];
@@ -600,6 +919,11 @@ static void rtw8822c_rf_dac_cal(struct rtw_dev *rtwdev)
 	u32 ic_a = 0x0, qc_a = 0x0, ic_b = 0x0, qc_b = 0x0;
 	u32 adc_ic_a = 0x0, adc_qc_a = 0x0, adc_ic_b = 0x0, adc_qc_b = 0x0;
 
+	if (rtw8822c_dac_cal_restore(rtwdev))
+		return;
+
+	/* not able to restore, do it */
+
 	rtw8822c_dac_backup_reg(rtwdev, backup, backup_rf);
 
 	rtw8822c_dac_bb_setting(rtwdev);
@@ -644,6 +968,9 @@ static void rtw8822c_rf_dac_cal(struct rtw_dev *rtwdev)
 
 	rtw8822c_dac_restore_reg(rtwdev, backup, backup_rf);
 
+	/* backup results to restore, saving a lot of time */
+	rtw8822c_dac_cal_backup(rtwdev);
+
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] path A: ic=0x%x, qc=0x%x\n", ic_a, qc_a);
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] path B: ic=0x%x, qc=0x%x\n", ic_b, qc_b);
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] path A: i=0x%x, q=0x%x\n", i_a, q_a);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 62ef128..ac730e7 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -150,6 +150,10 @@ struct rtw8822c_efuse {
 #define BIT_3WIRE_RX_EN		BIT(1)
 #define BIT_3WIRE_PI_ON		BIT(28)
 #define REG_RXAGCCTL0	0x18ac
+#define REG_DCKA_I_0	0x18bc
+#define REG_DCKA_I_1	0x18c0
+#define REG_DCKA_Q_0	0x18d8
+#define REG_DCKA_Q_1	0x18dc
 #define BIT_RXAGC_CCK	0xf000
 #define BIT_RXAGC_OFDM	0x1f0
 #define REG_CCKSB	0x1a00
@@ -196,5 +200,9 @@ struct rtw8822c_efuse {
 #define REG_ORITXCODE2	0x4100
 #define REG_3WIRE2	0x410c
 #define REG_RXAGCCTL	0x41ac
+#define REG_DCKB_I_0	0x41bc
+#define REG_DCKB_I_1	0x41c0
+#define REG_DCKB_Q_0	0x41d8
+#define REG_DCKB_Q_1	0x41dc
 
 #endif
-- 
2.7.4

