Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC951DDE72
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 05:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEVDzg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 23:55:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40706 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgEVDzg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 23:55:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04M3tOO21010863, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04M3tOO21010863
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 May 2020 11:55:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 11:55:23 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 22 May 2020 11:55:23 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <oliver.sang@intel.com>
Subject: [PATCH] rtw88: 8822c: fix missing brace warning for old compilers
Date:   Fri, 22 May 2020 11:55:21 +0800
Message-ID: <20200522035521.12295-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

For older versions of gcc, the array = {0}; will cause warnings:

drivers/net/wireless/realtek/rtw88/rtw8822c.c: In function 'rtw8822c_power_trim':
>> drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning:
>> missing braces around initializer [-Wmissing-braces]
s8 bb_gain[2][8] = {0};
^
drivers/net/wireless/realtek/rtw88/rtw8822c.c:1039:2: warning: (near
initialization for 'bb_gain[0]') [-Wmissing-braces]

Fixes: 5ad4d8957b69 ("rtw88: set power trim according to efuse PG values")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 2cf1c1f0a639..c3d72ef611c6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1037,7 +1037,7 @@ static void rtw8822c_set_power_trim(struct rtw_dev *rtwdev, s8 bb_gain[2][8])
 static void rtw8822c_power_trim(struct rtw_dev *rtwdev)
 {
 	u8 pg_pwr = 0xff, i, path, idx;
-	s8 bb_gain[2][8] = {0};
+	s8 bb_gain[2][8] = {};
 	u16 rf_efuse_2g[3] = {PPG_2GL_TXAB, PPG_2GM_TXAB, PPG_2GH_TXAB};
 	u16 rf_efuse_5g[2][5] = {{PPG_5GL1_TXA, PPG_5GL2_TXA, PPG_5GM1_TXA,
 				  PPG_5GM2_TXA, PPG_5GH1_TXA},
-- 
2.17.1

