Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6FC25A510
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 07:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIBFeM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 01:34:12 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40280 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgIBFeL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 01:34:11 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0825Y4Z80018092, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0825Y4Z80018092
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 2 Sep 2020 13:34:05 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 2 Sep 2020 13:34:04 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 2 Sep 2020 13:34:04 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH] rtw88: fix compile warning: [-Wignored-qualifiers]
Date:   Wed, 2 Sep 2020 13:34:02 +0800
Message-ID: <20200902053402.12839-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB04.realtek.com.tw (172.21.6.97) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Remove function return type const in rtw8821c_get_swing_index().
This is unused, and unnecessary to be const.

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/realtek/rtw88/rtw8821c.c:71:8: warning: type
qualifiers ignored on function return type [-Wignored-qualifiers]
       71 | static const u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
          |        ^~~~~

Fixes: f745eb9ca5bf ("rtw88: 8821c: Add 8821CE to Kconfig and Makefile")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index d8863d8a5468..da2e7415be8f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -68,7 +68,7 @@ static const u32 rtw8821c_txscale_tbl[] = {
 	0x2d3, 0x2fe, 0x32b, 0x35c, 0x38e, 0x3c4, 0x3fe
 };
 
-static const u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
+static u8 rtw8821c_get_swing_index(struct rtw_dev *rtwdev)
 {
 	u8 i = 0;
 	u32 swing, table_value;
-- 
2.17.1

