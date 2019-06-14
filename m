Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9868C45607
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 09:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFNHY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 03:24:29 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48179 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfFNHY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 03:24:29 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x5E7OO9s024954, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x5E7OO9s024954
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 14 Jun 2019 15:24:25 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 15:24:24 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 08/11] rtw88: power on again if it was already on
Date:   Fri, 14 Jun 2019 15:24:12 +0800
Message-ID: <1560497055-17197-9-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
References: <1560497055-17197-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

We could fail to power on because it was already on. If the return
value is -EALREADY, power off and then power on again to turn on the
hardware as expected.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 25a923b..fc14b37 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -285,8 +285,14 @@ int rtw_mac_power_on(struct rtw_dev *rtwdev)
 		goto err;
 
 	ret = rtw_mac_power_switch(rtwdev, true);
-	if (ret)
+	if (ret == -EALREADY) {
+		rtw_mac_power_switch(rtwdev, false);
+		ret = rtw_mac_power_switch(rtwdev, true);
+		if (ret)
+			goto err;
+	} else if (ret) {
 		goto err;
+	}
 
 	ret = rtw_mac_init_system_cfg(rtwdev);
 	if (ret)
-- 
2.7.4

