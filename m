Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722031E5A86
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgE1IPd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 04:15:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54754 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgE1IPa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 04:15:30 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04S8FNE60027394, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04S8FNE60027394
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 16:15:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:15:22 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:15:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH v2 7/7] rtw88: 8821c: add phy calibration
Date:   Thu, 28 May 2020 16:15:13 +0800
Message-ID: <20200528081513.26415-8-yhchuang@realtek.com>
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

In order to get a better tramit EVM, we need to perform calibration
after association.
The calibration needed for 8821c is called iq calibration, which is
done in firmware. Implement the callback function for triggering
firmware to do it.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 7169e6fb9ca9..749569eab912 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -555,6 +555,39 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	rtw_write32_clr(rtwdev, 0xb58, BIT(0));
 }
 
+static void rtw8821c_do_iqk(struct rtw_dev *rtwdev)
+{
+	static int do_iqk_cnt;
+	struct rtw_iqk_para para = {.clear = 0, .segment_iqk = 0};
+	u32 rf_reg, iqk_fail_mask;
+	int counter;
+	bool reload;
+
+	if (rtw_is_assoc(rtwdev))
+		para.segment_iqk = 1;
+
+	rtw_fw_do_iqk(rtwdev, &para);
+
+	for (counter = 0; counter < 300; counter++) {
+		rf_reg = rtw_read_rf(rtwdev, RF_PATH_A, RF_DTXLOK, RFREG_MASK);
+		if (rf_reg == 0xabcde)
+			break;
+		msleep(20);
+	}
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_DTXLOK, RFREG_MASK, 0x0);
+
+	reload = !!rtw_read32_mask(rtwdev, REG_IQKFAILMSK, BIT(16));
+	iqk_fail_mask = rtw_read32_mask(rtwdev, REG_IQKFAILMSK, GENMASK(7, 0));
+	rtw_dbg(rtwdev, RTW_DBG_PHY,
+		"iqk counter=%d reload=%d do_iqk_cnt=%d n_iqk_fail(mask)=0x%02x\n",
+		counter, reload, ++do_iqk_cnt, iqk_fail_mask);
+}
+
+static void rtw8821c_phy_calibration(struct rtw_dev *rtwdev)
+{
+	rtw8821c_do_iqk(rtwdev);
+}
+
 static struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8821c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -993,6 +1026,7 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.set_tx_power_index	= rtw8821c_set_tx_power_index,
 	.cfg_ldo25		= rtw8821c_cfg_ldo25,
 	.false_alarm_statistics	= rtw8821c_false_alarm_statistics,
+	.phy_calibration	= rtw8821c_phy_calibration,
 };
 
 struct rtw_chip_info rtw8821c_hw_spec = {
-- 
2.17.1

