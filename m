Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D457C45EB
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfJBCbn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:43 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46011 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbfJBCbm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:42 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922Va9i031852, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922Va9i031852
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:36 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:36 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 07/12] rtw88: leave PS state for dynamic mechanism
Date:   Wed, 2 Oct 2019 10:31:23 +0800
Message-ID: <20191002023128.12090-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002023128.12090-1-yhchuang@realtek.com>
References: <20191002023128.12090-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Dynamic mechanism requires BB/RF working to adjust
hardware settings. But PS state periodically turns
off BB/RF, could lead to wrong setting.

So leave PS state before DM to make sure it works.
And then check if we can enter PS state again.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  - rebase on top of wireless-drivers-next

 drivers/net/wireless/realtek/rtw88/main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f55eda9da827..00ebf8cc81b1 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -174,6 +174,14 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	rtwdev->stats.tx_cnt = 0;
 	rtwdev->stats.rx_cnt = 0;
 
+	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
+		goto unlock;
+
+	/* make sure BB/RF is working for dynamic mech */
+	rtw_leave_lps(rtwdev);
+
+	rtw_phy_dynamic_mechanism(rtwdev);
+
 	/* use atomic version to avoid taking local->iflist_mtx mutex */
 	rtw_iterate_vifs_atomic(rtwdev, rtw_vif_watch_dog_iter, &data);
 
@@ -184,13 +192,6 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	if (rtw_fw_support_lps &&
 	    data.rtwvif && !data.active && data.assoc_cnt == 1)
 		rtw_enter_lps(rtwdev, data.rtwvif->port);
-	else
-		rtw_leave_lps(rtwdev);
-
-	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
-		goto unlock;
-
-	rtw_phy_dynamic_mechanism(rtwdev);
 
 	rtwdev->watch_dog_cnt++;
 
-- 
2.17.1

