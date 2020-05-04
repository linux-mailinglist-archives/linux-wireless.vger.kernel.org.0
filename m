Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCA251C3731
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 12:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgEDKuV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 06:50:21 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51258 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727916AbgEDKuU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 06:50:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 044AoEezD003119, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 044AoEezD003119
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
Subject: [PATCH v4 5/8] rtw88: 8723d: some chips don't support LDPC
Date:   Mon, 4 May 2020 18:50:07 +0800
Message-ID: <20200504105010.10780-6-yhchuang@realtek.com>
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

Some chips are not able to receive LDPC packets. Add an attribute
to rtw_chip_info to determine if the LDPC capability in [ht/vht]_cap
should be advertised or not.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 9 +++++++--
 drivers/net/wireless/realtek/rtw88/main.h     | 6 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 5 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index b0dadff0dc7b..f88a7d2370aa 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -933,8 +933,11 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 	ht_cap->cap = 0;
 	ht_cap->cap |= IEEE80211_HT_CAP_SGI_20 |
 			IEEE80211_HT_CAP_MAX_AMSDU |
-			IEEE80211_HT_CAP_LDPC_CODING |
 			(1 << IEEE80211_HT_CAP_RX_STBC_SHIFT);
+
+	if (rtw_chip_has_rx_ldpc(rtwdev))
+		ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
+
 	if (efuse->hw_cap.bw & BIT(RTW_CHANNEL_WIDTH_40))
 		ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 				IEEE80211_HT_CAP_DSSSCCK40 |
@@ -968,7 +971,6 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 
 	vht_cap->vht_supported = true;
 	vht_cap->cap = IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454 |
-		       IEEE80211_VHT_CAP_RXLDPC |
 		       IEEE80211_VHT_CAP_SHORT_GI_80 |
 		       IEEE80211_VHT_CAP_TXSTBC |
 		       IEEE80211_VHT_CAP_RXSTBC_1 |
@@ -981,6 +983,9 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	vht_cap->cap |= (rtwdev->hal.bfee_sts_cap <<
 			IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT);
 
+	if (rtw_chip_has_rx_ldpc(rtwdev))
+		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
+
 	mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9 << 0 |
 		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
 		  IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 157aca641f6d..454ed4415e09 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1084,6 +1084,7 @@ struct rtw_chip_info {
 	u8 dig_min;
 	u8 txgi_factor;
 	bool is_pwr_by_rate_dec;
+	bool rx_ldpc;
 	u8 max_power_index;
 
 	bool ht_supported;
@@ -1742,6 +1743,11 @@ static inline bool rtw_chip_wcpu_11ac(struct rtw_dev *rtwdev)
 	return rtwdev->chip->wlan_cpu == RTW_WCPU_11AC;
 }
 
+static inline bool rtw_chip_has_rx_ldpc(struct rtw_dev *rtwdev)
+{
+	return rtwdev->chip->rx_ldpc;
+}
+
 void rtw_get_channel_params(struct cfg80211_chan_def *chandef,
 			    struct rtw_channel_params *ch_param);
 bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 6011ca8352b3..6fe7596d6a11 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1039,6 +1039,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.rf_tbl = {&rtw8723d_rf_a_tbl},
 	.rfe_defs = rtw8723d_rfe_defs,
 	.rfe_defs_size = ARRAY_SIZE(rtw8723d_rfe_defs),
+	.rx_ldpc = false,
 };
 EXPORT_SYMBOL(rtw8723d_hw_spec);
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index ffee8111d145..f1019e196918 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2447,6 +2447,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
+	.rx_ldpc = true,
 
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 8dd92136145d..008debde165e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4311,6 +4311,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
+	.rx_ldpc = true,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
-- 
2.17.1

