Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1530E45C5
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 10:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408286AbfJYIcI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 04:32:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46818 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407828AbfJYIcI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 04:32:08 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P8W2Ht003648, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P8W2Ht003648
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 16:32:03 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 16:32:02 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] rtw88: fix sparse warnings for DPK
Date:   Fri, 25 Oct 2019 16:31:59 +0800
Message-ID: <20191025083200.20245-2-yhchuang@realtek.com>
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
    drivers/net/wireless/realtek/rtw88/rtw8822c.c:2871:6: sparse:
sparse: symbol 'rtw8822c_dpk_cal_coef1' was not declared. Should it be
static?
    drivers/net/wireless/realtek/rtw88/rtw8822c.c:3112:6: sparse:
sparse: symbol 'rtw8822c_dpk_track' was not declared. Should it be
static?

Fixes: 5227c2ee453d ("rtw88: 8822c: add SW DPK support")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index b77905196ffb..97f4c4e1d7e9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2970,7 +2970,7 @@ static void rtw8822c_dpk_cal_gs(struct rtw_dev *rtwdev, u8 path)
 	dpk_info->dpk_gs[path] = tmp_gs;
 }
 
-void rtw8822c_dpk_cal_coef1(struct rtw_dev *rtwdev)
+static void rtw8822c_dpk_cal_coef1(struct rtw_dev *rtwdev)
 {
 	struct rtw_dpk_info *dpk_info = &rtwdev->dm_info.dpk_info;
 	u32 offset[DPK_RF_PATH_NUM] = {0, 0x58};
@@ -3211,7 +3211,7 @@ static void rtw8822c_phy_calibration(struct rtw_dev *rtwdev)
 	rtw8822c_do_dpk(rtwdev);
 }
 
-void rtw8822c_dpk_track(struct rtw_dev *rtwdev)
+static void rtw8822c_dpk_track(struct rtw_dev *rtwdev)
 {
 	struct rtw_dpk_info *dpk_info = &rtwdev->dm_info.dpk_info;
 	u8 path;
-- 
2.17.1

