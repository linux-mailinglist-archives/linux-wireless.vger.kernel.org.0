Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84A8413F85
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Sep 2021 04:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhIVCin (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 22:38:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:60320 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhIVCim (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 22:38:42 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 18M2b72X1024572, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 18M2b72X1024572
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Sep 2021 10:37:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 22 Sep 2021 10:37:07 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 22 Sep
 2021 10:37:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH 2/2] rtw88: 8821c: correct 2.4G tx power for type 2/4 NIC
Date:   Wed, 22 Sep 2021 10:36:37 +0800
Message-ID: <20210922023637.9357-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922023637.9357-1-pkshih@realtek.com>
References: <20210922023637.9357-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/22/2021 02:12:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzkvMjIgpFekyCAwMTowNjowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

NIC card saves calibrated TX power index in the efuse(ROM).
Driver loads TX power idex when interface is up.

The problem is type2/4 NICs loads 2.4G TX power index
from wrong position. This patch corrects the offsets.
So, driver loads real 2.4G TX power index for type 2/4 NICs.

2.4G performance increased when using correct TX power index.

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 3effdf902f22..80a6f4da6acd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -61,6 +61,9 @@ static int rtw8821c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	for (i = 0; i < 4; i++)
 		efuse->txpwr_idx_table[i] = map->txpwr_idx_table[i];
 
+	if (rtwdev->efuse.rfe_option == 2 || rtwdev->efuse.rfe_option == 4)
+		efuse->txpwr_idx_table[0].pwr_idx_2g = map->txpwr_idx_table[1].pwr_idx_2g;
+
 	switch (rtw_hci_type(rtwdev)) {
 	case RTW_HCI_TYPE_PCIE:
 		rtw8821ce_efuse_parsing(efuse, map);
-- 
2.25.1

