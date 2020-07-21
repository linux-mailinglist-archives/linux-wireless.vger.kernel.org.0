Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0151B22811D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Jul 2020 15:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgGUNjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Jul 2020 09:39:17 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727914AbgGUNjQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Jul 2020 09:39:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 020FECD3B2A77F10C0E1;
        Tue, 21 Jul 2020 21:39:13 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 21:39:04 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Tzu-En Huang" <tehuang@realtek.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH -next] rtw88: 8821c: make symbol 'rtw8821c_rtw_pwr_track_tbl' static
Date:   Tue, 21 Jul 2020 21:49:01 +0800
Message-ID: <20200721134901.33968-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The sparse tool complains as follows:

drivers/net/wireless/realtek/rtw88/rtw8821c.c:1374:32: warning:
 symbol 'rtw8821c_rtw_pwr_track_tbl' was not declared. Should it be static?

This variable is not used outside of rtw8821c.c, so this commit
marks it static.

Fixes: 3a4312828ce1 ("rtw88: 8821c: add power tracking")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index c41c61ee2fb6..5fef19f19ac1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1371,7 +1371,7 @@ static const u8 rtw8821c_pwrtrk_2g_cck_a_p[] = {
 	5, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 9, 9, 9
 };
 
-const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
+static const struct rtw_pwr_track_tbl rtw8821c_rtw_pwr_track_tbl = {
 	.pwrtrk_5gb_n[0] = rtw8821c_pwrtrk_5gb_n[0],
 	.pwrtrk_5gb_n[1] = rtw8821c_pwrtrk_5gb_n[1],
 	.pwrtrk_5gb_n[2] = rtw8821c_pwrtrk_5gb_n[2],

