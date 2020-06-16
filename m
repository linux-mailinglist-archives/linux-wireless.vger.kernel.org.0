Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D671FAC1F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 11:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgFPJQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 05:16:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46540 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgFPJQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 05:16:49 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05G9GX6i8021732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05G9GX6i8021732
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 16 Jun 2020 17:16:33 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:33 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 16 Jun 2020 17:16:32 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v4 6/7] rtw88: 8821c: add false alarm statistics
Date:   Tue, 16 Jun 2020 17:16:24 +0800
Message-ID: <20200616091625.26489-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616091625.26489-1-yhchuang@realtek.com>
References: <20200616091625.26489-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

False alarm statistics can be used to adjust the RX gain. This
helps the driver to adapt to different circumstances.

Implement rtw_chip_ops::false_alarm_statistics() for 8821c.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 53 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h | 10 ++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index bf1a2c92f2a5..ffcb427468d7 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -511,6 +511,58 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 	}
 }
 
+static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u32 cck_enable;
+	u32 cck_fa_cnt;
+	u32 ofdm_fa_cnt;
+	u32 crc32_cnt;
+	u32 cca32_cnt;
+
+	cck_enable = rtw_read32(rtwdev, REG_RXPSEL) & BIT(28);
+	cck_fa_cnt = rtw_read16(rtwdev, REG_FA_CCK);
+	ofdm_fa_cnt = rtw_read16(rtwdev, REG_FA_OFDM);
+
+	dm_info->cck_fa_cnt = cck_fa_cnt;
+	dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
+	if (cck_enable)
+		dm_info->total_fa_cnt += cck_fa_cnt;
+	dm_info->total_fa_cnt = ofdm_fa_cnt;
+
+	crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
+	dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
+	dm_info->cck_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);
+
+	crc32_cnt = rtw_read32(rtwdev, REG_CRC_OFDM);
+	dm_info->ofdm_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
+	dm_info->ofdm_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);
+
+	crc32_cnt = rtw_read32(rtwdev, REG_CRC_HT);
+	dm_info->ht_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
+	dm_info->ht_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);
+
+	crc32_cnt = rtw_read32(rtwdev, REG_CRC_VHT);
+	dm_info->vht_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
+	dm_info->vht_err_cnt = FIELD_GET(GENMASK(31, 16), crc32_cnt);
+
+	cca32_cnt = rtw_read32(rtwdev, REG_CCA_OFDM);
+	dm_info->ofdm_cca_cnt = FIELD_GET(GENMASK(31, 16), cca32_cnt);
+	dm_info->total_cca_cnt = dm_info->ofdm_cca_cnt;
+	if (cck_enable) {
+		cca32_cnt = rtw_read32(rtwdev, REG_CCA_CCK);
+		dm_info->cck_cca_cnt = FIELD_GET(GENMASK(15, 0), cca32_cnt);
+		dm_info->total_cca_cnt += dm_info->cck_cca_cnt;
+	}
+
+	rtw_write32_set(rtwdev, REG_FAS, BIT(17));
+	rtw_write32_clr(rtwdev, REG_FAS, BIT(17));
+	rtw_write32_clr(rtwdev, REG_RXDESC, BIT(15));
+	rtw_write32_set(rtwdev, REG_RXDESC, BIT(15));
+	rtw_write32_set(rtwdev, REG_CNTRST, BIT(0));
+	rtw_write32_clr(rtwdev, REG_CNTRST, BIT(0));
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -948,6 +1000,7 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.set_antenna		= NULL,
 	.set_tx_power_index	= rtw8821c_set_tx_power_index,
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
+	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
 };
 
 struct rtw_chip_info rtw8821c_hw_spec = {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 741f78829c17..3b7d12bf7728 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -183,13 +183,16 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_ACBB0	0x948
 #define REG_ACBBRXFIR	0x94c
 #define REG_ACGG2TBL	0x958
+#define REG_FAS		0x9a4
 #define REG_RXSB	0xa00
 #define REG_ADCINI	0xa04
 #define REG_TXSF2	0xa24
 #define REG_TXSF6	0xa28
+#define REG_FA_CCK	0xa5c
 #define REG_RXDESC	0xa2c
 #define REG_ENTXCCK	0xa80
 #define REG_TXFILTER	0xaac
+#define REG_CNTRST	0xb58
 #define REG_AGCTR_A	0xc08
 #define REG_TXSCALE_A	0xc1c
 #define REG_TXDFIR	0xc20
@@ -201,6 +204,13 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_RFEINV	0xcbc
 #define REG_AGCTR_B	0xe08
 #define REG_RXIGI_B	0xe50
+#define REG_CRC_CCK	0xf04
+#define REG_CRC_OFDM	0xf14
+#define REG_CRC_HT	0xf10
+#define REG_CRC_VHT	0xf0c
+#define REG_CCA_OFDM	0xf08
+#define REG_FA_OFDM	0xf48
+#define REG_CCA_CCK	0xfcc
 #define REG_ANTWT	0x1904
 #define REG_IQKFAILMSK	0x1bf0
 
-- 
2.17.1

