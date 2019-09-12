Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE579B08F2
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2019 08:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfILGjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Sep 2019 02:39:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:41620 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfILGjl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Sep 2019 02:39:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8C6dMVp009945, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8C6dMVp009945
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 12 Sep 2019 14:39:23 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Thu, 12 Sep 2019 14:39:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 1/2] rtw88: fix wrong rx power calculation
Date:   Thu, 12 Sep 2019 14:39:14 +0800
Message-ID: <1568270355-29727-2-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568270355-29727-1-git-send-email-yhchuang@realtek.com>
References: <1568270355-29727-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tsang-Shian Lin <thlin@realtek.com>

Fix the wrong RF path for CCK rx power calculation.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 207f64c..24b27bc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1620,9 +1620,9 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	else if (gain_a > u_bnd)
 		rx_power[RF_PATH_A] -= (gain_a - u_bnd) << 1;
 	if (gain_b < l_bnd)
-		rx_power[RF_PATH_A] += (l_bnd - gain_b) << 1;
+		rx_power[RF_PATH_B] += (l_bnd - gain_b) << 1;
 	else if (gain_b > u_bnd)
-		rx_power[RF_PATH_A] -= (gain_b - u_bnd) << 1;
+		rx_power[RF_PATH_B] -= (gain_b - u_bnd) << 1;
 
 	rx_power[RF_PATH_A] -= 110;
 	rx_power[RF_PATH_B] -= 110;
-- 
2.7.4

