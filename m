Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53E61CF2A3
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgELKfl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:35:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36866 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgELKfl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:35:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAZaZN2010601, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAZaZN2010601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:35:36 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:35:36 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:35:36 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH] rtw88: 8723d: fix sparse warnings for power tracking
Date:   Tue, 12 May 2020 18:35:34 +0800
Message-ID: <20200512103534.5889-1-yhchuang@realtek.com>
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

sparse warnings: (new ones prefixed by >>)

>> drivers/net/wireless/realtek/rtw88/rtw8723d.c:1899:6: sparse: sparse:
symbol 'rtw8723d_pwr_track' was not declared. Should it be static?

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 2a5479af092e..340c8c455802 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1897,7 +1897,7 @@ static void rtw8723d_phy_pwrtrack(struct rtw_dev *rtwdev)
 		rtw8723d_phy_calibration(rtwdev);
 }
 
-void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
+static void rtw8723d_pwr_track(struct rtw_dev *rtwdev)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
-- 
2.17.1

