Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539CA3C6ECE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jul 2021 12:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbhGMKsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jul 2021 06:48:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59980 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbhGMKsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jul 2021 06:48:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16DAjwfgF025065, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16DAjwfgF025065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 13 Jul 2021 18:45:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Jul 2021 18:45:57 +0800
Received: from localhost (172.16.20.72) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 13 Jul
 2021 18:45:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH 2/3] rtw88: 8822c: add tx stbc support under HT mode
Date:   Tue, 13 Jul 2021 18:45:23 +0800
Message-ID: <20210713104524.47101-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713104524.47101-1-pkshih@realtek.com>
References: <20210713104524.47101-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.20.72]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/13/2021 03:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTMgpFekyCAwMTowNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMTMgpFekyCAwODoyNzowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/13/2021 10:34:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165004 [Jul 13 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_from_exist}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/13/2021 10:36:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Enabling this improves tx performance for long distance transmission.
We used to enable stbc by the rx stbc cap of the associated station.
But rx cap will be masked out in ieee80211_ht_cap_ie_to_sta_ht_cap
if we do not declare tx stbc.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     | 2 ++
 drivers/net/wireless/realtek/rtw88/main.h     | 6 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index c6364837e83b..6bb55e663fc3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1338,6 +1338,8 @@ static void rtw_init_ht_cap(struct rtw_dev *rtwdev,
 
 	if (rtw_chip_has_rx_ldpc(rtwdev))
 		ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
+	if (rtw_chip_has_tx_stbc(rtwdev))
+		ht_cap->cap |= IEEE80211_HT_CAP_TX_STBC;
 
 	if (efuse->hw_cap.bw & BIT(RTW_CHANNEL_WIDTH_40))
 		ht_cap->cap |= IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e5af375b3dd0..56812127a053 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1146,6 +1146,7 @@ struct rtw_chip_info {
 	u8 txgi_factor;
 	bool is_pwr_by_rate_dec;
 	bool rx_ldpc;
+	bool tx_stbc;
 	u8 max_power_index;
 
 	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
@@ -1959,6 +1960,11 @@ static inline bool rtw_chip_has_rx_ldpc(struct rtw_dev *rtwdev)
 	return rtwdev->chip->rx_ldpc;
 }
 
+static inline bool rtw_chip_has_tx_stbc(struct rtw_dev *rtwdev)
+{
+	return rtwdev->chip->tx_stbc;
+}
+
 static inline void rtw_release_macid(struct rtw_dev *rtwdev, u8 mac_id)
 {
 	clear_bit(mac_id, rtwdev->mac_id_map);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 8bf3cd3a3678..f3ad079967a6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5288,6 +5288,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
+	.tx_stbc = true,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
-- 
2.25.1

