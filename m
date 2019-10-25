Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A91E45C7
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 10:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408256AbfJYIcJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 04:32:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46816 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407824AbfJYIcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 04:32:08 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P8W3cS003652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P8W3cS003652
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 16:32:03 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 16:32:03 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] rtw88: fix sparse warnings for power tracking
Date:   Fri, 25 Oct 2019 16:32:00 +0800
Message-ID: <20191025083200.20245-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025083200.20245-1-yhchuang@realtek.com>
References: <20191025083200.20245-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

sparse warnings:
    drivers/net/wireless/realtek/rtw88/rtw8822b.c:1440:6: sparse: sparse:
    symbol 'rtw8822b_pwr_track' was not declared. Should it be static?
    drivers/net/wireless/realtek/rtw88/rtw8822c.c:1008:6: sparse: sparse:
    symbol 'rtw8822c_pwrtrack_init' was not declared. Should it be static?

Fixes: c97ee3e0bea2 ("rtw88: add power tracking support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 6f4e7326068c..3ec3e8eb3ecd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1492,7 +1492,7 @@ static void rtw8822b_phy_pwrtrack(struct rtw_dev *rtwdev)
 		rtw8822b_do_iqk(rtwdev);
 }
 
-void rtw8822b_pwr_track(struct rtw_dev *rtwdev)
+static void rtw8822b_pwr_track(struct rtw_dev *rtwdev)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 97f4c4e1d7e9..04ced3b2a247 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1006,7 +1006,7 @@ static void rtw8822c_rf_init(struct rtw_dev *rtwdev)
 	rtw8822c_rf_x2_check(rtwdev);
 }
 
-void rtw8822c_pwrtrack_init(struct rtw_dev *rtwdev)
+static void rtw8822c_pwrtrack_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 path;
-- 
2.17.1

