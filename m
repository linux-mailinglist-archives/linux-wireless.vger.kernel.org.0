Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326201C3734
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 12:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbgEDKu2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 06:50:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51273 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgEDKu1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 06:50:27 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 044AoEf05003119, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 044AoEf05003119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 May 2020 18:50:14 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 18:50:14 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 May 2020 18:50:14 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 6/8] rtw88: 8723d: Add chip_ops::false_alarm_statistics
Date:   Mon, 4 May 2020 18:50:08 +0800
Message-ID: <20200504105010.10780-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504105010.10780-1-yhchuang@realtek.com>
References: <20200504105010.10780-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This ops is used to do statistics of false alarm periodically, and then
fine tune RX initial gain to adaptive different circumstance.

There are three steps, hold/get/reset counter, to retrieve false alarm
counters that consist of CCK and OFDM. In addition to false alarm
counters, it also collects CRC ok/error counters of CCK, OFDM and HT.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 65 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 41 ++++++++++++
 2 files changed, 106 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 6fe7596d6a11..2f98e58396b0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -539,6 +539,70 @@ static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
 	}
 }
 
+static void rtw8723d_false_alarm_statistics(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 cck_fa_cnt;
+	u32 ofdm_fa_cnt;
+	u32 crc32_cnt;
+	u32 val32;
+
+	/* hold counter */
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_HOLDC_11N, BIT_MASK_OFDM_FA_KEEP, 1);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_KEEP1, 1);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KEEP, 1);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KEEP, 1);
+
+	cck_fa_cnt = rtw_read32_mask(rtwdev, REG_CCK_FA_LSB_11N, MASKBYTE0);
+	cck_fa_cnt += rtw_read32_mask(rtwdev, REG_CCK_FA_MSB_11N, MASKBYTE3) << 8;
+
+	val32 = rtw_read32(rtwdev, REG_OFDM_FA_TYPE1_11N);
+	ofdm_fa_cnt = u32_get_bits(val32, BIT_MASK_OFDM_FF_CNT);
+	ofdm_fa_cnt += u32_get_bits(val32, BIT_MASK_OFDM_SF_CNT);
+	val32 = rtw_read32(rtwdev, REG_OFDM_FA_TYPE2_11N);
+	dm_info->ofdm_cca_cnt = u32_get_bits(val32, BIT_MASK_OFDM_CCA_CNT);
+	ofdm_fa_cnt += u32_get_bits(val32, BIT_MASK_OFDM_PF_CNT);
+	val32 = rtw_read32(rtwdev, REG_OFDM_FA_TYPE3_11N);
+	ofdm_fa_cnt += u32_get_bits(val32, BIT_MASK_OFDM_RI_CNT);
+	ofdm_fa_cnt += u32_get_bits(val32, BIT_MASK_OFDM_CRC_CNT);
+	val32 = rtw_read32(rtwdev, REG_OFDM_FA_TYPE4_11N);
+	ofdm_fa_cnt += u32_get_bits(val32, BIT_MASK_OFDM_MNS_CNT);
+
+	dm_info->cck_fa_cnt = cck_fa_cnt;
+	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	dm_info->total_fa_cnt = cck_fa_cnt + ofdm_fa_cnt;
+
+	dm_info->cck_err_cnt = rtw_read32(rtwdev, REG_IGI_C_11N);
+	dm_info->cck_ok_cnt = rtw_read32(rtwdev, REG_IGI_D_11N);
+	crc32_cnt = rtw_read32(rtwdev, REG_OFDM_CRC32_CNT_11N);
+	dm_info->ofdm_err_cnt = u32_get_bits(crc32_cnt, BIT_MASK_OFDM_LCRC_ERR);
+	dm_info->ofdm_ok_cnt = u32_get_bits(crc32_cnt, BIT_MASK_OFDM_LCRC_OK);
+	crc32_cnt = rtw_read32(rtwdev, REG_HT_CRC32_CNT_11N);
+	dm_info->ht_err_cnt = u32_get_bits(crc32_cnt, BIT_MASK_HT_CRC_ERR);
+	dm_info->ht_ok_cnt = u32_get_bits(crc32_cnt, BIT_MASK_HT_CRC_OK);
+	dm_info->vht_err_cnt = 0;
+	dm_info->vht_ok_cnt = 0;
+
+	val32 = rtw_read32(rtwdev, REG_CCK_CCA_CNT_11N);
+	dm_info->cck_cca_cnt = (u32_get_bits(val32, BIT_MASK_CCK_FA_MSB) << 8) |
+			       u32_get_bits(val32, BIT_MASK_CCK_FA_LSB);
+	dm_info->total_cca_cnt = dm_info->cck_cca_cnt + dm_info->ofdm_cca_cnt;
+
+	/* reset counter */
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTC_11N, BIT_MASK_OFDM_FA_RST, 1);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTC_11N, BIT_MASK_OFDM_FA_RST, 0);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_RST1, 1);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_RST1, 0);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_HOLDC_11N, BIT_MASK_OFDM_FA_KEEP, 0);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_KEEP1, 0);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KPEN, 0);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KPEN, 2);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KPEN, 0);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KPEN, 2);
+	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 1);
+	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 0);
+}
+
 static struct rtw_chip_ops rtw8723d_ops = {
 	.phy_set_param		= rtw8723d_phy_set_param,
 	.read_efuse		= rtw8723d_read_efuse,
@@ -551,6 +615,7 @@ static struct rtw_chip_ops rtw8723d_ops = {
 	.set_antenna		= NULL,
 	.cfg_ldo25		= rtw8723d_cfg_ldo25,
 	.efuse_grant		= rtw8723d_efuse_grant,
+	.false_alarm_statistics	= rtw8723d_false_alarm_statistics,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
 	.cfg_csi_rate		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index 06614602de54..ac66f672bec8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -88,16 +88,57 @@ struct rtw8723d_efuse {
 #define BIT_RXBB_DFIR_EN	BIT(19)
 #define REG_CCK0_SYS		0x0a00
 #define BIT_CCK_SIDE_BAND	BIT(4)
+#define REG_CCK_FA_RST_11N	0x0a2c
+#define BIT_MASK_CCK_CNT_KEEP	BIT(12)
+#define BIT_MASK_CCK_CNT_EN	BIT(13)
+#define BIT_MASK_CCK_CNT_KPEN	(BIT_MASK_CCK_CNT_KEEP | BIT_MASK_CCK_CNT_EN)
+#define BIT_MASK_CCK_FA_KEEP	BIT(14)
+#define BIT_MASK_CCK_FA_EN	BIT(15)
+#define BIT_MASK_CCK_FA_KPEN	(BIT_MASK_CCK_FA_KEEP | BIT_MASK_CCK_FA_EN)
+#define REG_CCK_FA_LSB_11N	0x0a5c
+#define REG_CCK_FA_MSB_11N	0x0a58
+#define REG_CCK_CCA_CNT_11N	0x0a60
+#define BIT_MASK_CCK_FA_MSB	GENMASK(7, 0)
+#define BIT_MASK_CCK_FA_LSB	GENMASK(15, 8)
+#define REG_OFDM_FA_HOLDC_11N	0x0c00
+#define BIT_MASK_OFDM_FA_KEEP	BIT(31)
+#define REG_OFDM_FA_RSTC_11N	0x0c0c
+#define BIT_MASK_OFDM_FA_RST	BIT(31)
 #define REG_OFDM0_RXDSP		0x0c40
 #define BIT_MASK_RXDSP		GENMASK(28, 24)
 #define BIT_EN_RXDSP		BIT(9)
 #define REG_OFDM0_XAAGC1	0x0c50
 #define REG_OFDM0_XBAGC1	0x0c58
+#define REG_OFDM_FA_TYPE1_11N	0x0cf0
+#define BIT_MASK_OFDM_FF_CNT	GENMASK(15, 0)
+#define BIT_MASK_OFDM_SF_CNT	GENMASK(31, 16)
+#define REG_OFDM_FA_RSTD_11N	0x0d00
+#define BIT_MASK_OFDM_FA_RST1	BIT(27)
+#define BIT_MASK_OFDM_FA_KEEP1	BIT(31)
 #define REG_OFDM1_CFOTRK	0x0d2c
 #define BIT_EN_CFOTRK		BIT(28)
 #define REG_OFDM1_CSI1		0x0d40
 #define REG_OFDM1_CSI2		0x0d44
 #define REG_OFDM1_CSI3		0x0d48
 #define REG_OFDM1_CSI4		0x0d4c
+#define REG_OFDM_FA_TYPE2_11N	0x0da0
+#define BIT_MASK_OFDM_CCA_CNT	GENMASK(15, 0)
+#define BIT_MASK_OFDM_PF_CNT	GENMASK(31, 16)
+#define REG_OFDM_FA_TYPE3_11N	0x0da4
+#define BIT_MASK_OFDM_RI_CNT	GENMASK(15, 0)
+#define BIT_MASK_OFDM_CRC_CNT	GENMASK(31, 16)
+#define REG_OFDM_FA_TYPE4_11N	0x0da8
+#define BIT_MASK_OFDM_MNS_CNT	GENMASK(15, 0)
+#define REG_PAGE_F_RST_11N		0x0f14
+#define BIT_MASK_F_RST_ALL		BIT(16)
+#define REG_IGI_C_11N			0x0f84
+#define REG_IGI_D_11N			0x0f88
+#define REG_HT_CRC32_CNT_11N		0x0f90
+#define BIT_MASK_HT_CRC_OK		GENMASK(15, 0)
+#define BIT_MASK_HT_CRC_ERR		GENMASK(31, 16)
+#define REG_OFDM_CRC32_CNT_11N		0x0f94
+#define BIT_MASK_OFDM_LCRC_OK		GENMASK(15, 0)
+#define BIT_MASK_OFDM_LCRC_ERR		GENMASK(31, 16)
+#define REG_HT_CRC32_CNT_11N_AGG	0x0fb8
 
 #endif
-- 
2.17.1

