Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1B11E5A8A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 10:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgE1IPg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 04:15:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54752 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgE1IP3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 04:15:29 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04S8FMxrC027380, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04S8FMxrC027380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 16:15:22 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:15:22 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:15:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH v2 2/7] rtw88: 8821c: add set tx power index
Date:   Thu, 28 May 2020 16:15:08 +0800
Message-ID: <20200528081513.26415-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528081513.26415-1-yhchuang@realtek.com>
References: <20200528081513.26415-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

To configure the transmit power of 8821c, implements trasmit
power index setting callback function for 8821c, which is very
similar to the callback function of 8822b.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index baf0cf5a35b3..ce580dace83c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -162,6 +162,44 @@ static void rtw8821c_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
 	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
 }
 
+static void
+rtw8821c_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 rs)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	static const u32 offset_txagc[2] = {0x1d00, 0x1d80};
+	static u32 phy_pwr_idx;
+	u8 rate, rate_idx, pwr_index, shift;
+	int j;
+
+	for (j = 0; j < rtw_rate_size[rs]; j++) {
+		rate = rtw_rate_section[rs][j];
+		pwr_index = hal->tx_pwr_tbl[path][rate];
+		shift = rate & 0x3;
+		phy_pwr_idx |= ((u32)pwr_index << (shift * 8));
+		if (shift == 0x3 || rate == DESC_RATEVHT1SS_MCS9) {
+			rate_idx = rate & 0xfc;
+			rtw_write32(rtwdev, offset_txagc[path] + rate_idx,
+				    phy_pwr_idx);
+			phy_pwr_idx = 0;
+		}
+	}
+}
+
+static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	int rs, path;
+
+	for (path = 0; path < hal->rf_path_num; path++) {
+		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+			if (rs == RTW_RATE_SECTION_HT_2S ||
+			    rs == RTW_RATE_SECTION_VHT_2S)
+				continue;
+			rtw8821c_set_tx_power_index_by_rate(rtwdev, path, rs);
+		}
+	}
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -591,6 +629,7 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.read_rf		= rtw_phy_read_rf,
 	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
+	.set_tx_power_index	= rtw8821c_set_tx_power_index,
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
 };
 
-- 
2.17.1

