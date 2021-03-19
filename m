Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859BA3414FE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhCSFnb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:43:31 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39717 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbhCSFnN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:13 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5h7aN5007706, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5h7aN5007706
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:43:07 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:43:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 3/7] rtw88: fix DIG min setting
Date:   Fri, 19 Mar 2021 13:42:14 +0800
Message-ID: <20210319054218.3319-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319054218.3319-1-pkshih@realtek.com>
References: <20210319054218.3319-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

DIG min is expected to be set according to chip. And actually we assigned
it under each chip information. However, we didn't use the setting when we
did DIG process. It is unexpected, so we fix it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e114ddecac09..f96edc049718 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -316,7 +316,8 @@ rtw_phy_dig_check_damping(struct rtw_dm_info *dm_info)
 	return damping;
 }
 
-static void rtw_phy_dig_get_boundary(struct rtw_dm_info *dm_info,
+static void rtw_phy_dig_get_boundary(struct rtw_dev *rtwdev,
+				     struct rtw_dm_info *dm_info,
 				     u8 *upper, u8 *lower, bool linked)
 {
 	u8 dig_max, dig_min, dig_mid;
@@ -325,8 +326,7 @@ static void rtw_phy_dig_get_boundary(struct rtw_dm_info *dm_info,
 	if (linked) {
 		dig_max = DIG_PERF_MAX;
 		dig_mid = DIG_PERF_MID;
-		/* 22B=0x1c, 22C=0x20 */
-		dig_min = 0x1c;
+		dig_min = rtwdev->chip->dig_min;
 		min_rssi = max_t(u8, dm_info->min_rssi, dig_min);
 	} else {
 		dig_max = DIG_CVRG_MAX;
@@ -437,7 +437,8 @@ static void rtw_phy_dig(struct rtw_dev *rtwdev)
 	 * the peers connected with us, meanwhile make sure the igi value does
 	 * not beyond the hardware limitation
 	 */
-	rtw_phy_dig_get_boundary(dm_info, &upper_bound, &lower_bound, linked);
+	rtw_phy_dig_get_boundary(rtwdev, dm_info, &upper_bound, &lower_bound,
+				 linked);
 	cur_igi = clamp_t(u8, cur_igi, lower_bound, upper_bound);
 
 	/* record current igi value and false alarm statistics for further
-- 
2.21.0

