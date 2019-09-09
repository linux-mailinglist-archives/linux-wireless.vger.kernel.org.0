Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B5DAD377
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 09:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfIIHQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 03:16:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57962 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731902AbfIIHQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 03:16:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x897GMb8014370, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x897GMb8014370
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Sep 2019 15:16:22 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 9 Sep 2019 15:16:21 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 6/8] rtw88: move IQK/DPK into phy_calibration
Date:   Mon, 9 Sep 2019 15:16:09 +0800
Message-ID: <1568013371-21805-7-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568013371-21805-1-git-send-email-yhchuang@realtek.com>
References: <1568013371-21805-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Since 8822c requires to do not only IQK, but also DPK.
Move these calibrations that need to be done once the channel
is determined, into phy_calibration.

And note that the order of the calibrations matters, 8822c
should do IQK first, then DPK.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
   * no change

 drivers/net/wireless/realtek/rtw88/mac80211.c | 2 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 3 +--
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 6 +++---
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 9 +++++++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index fedea28..e5e3605 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -256,7 +256,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 		if (conf->assoc) {
 			rtw_coex_connect_notify(rtwdev, COEX_ASSOCIATE_FINISH);
 			net_type = RTW_NET_MGD_LINKED;
-			chip->ops->do_iqk(rtwdev);
+			chip->ops->phy_calibration(rtwdev);
 
 			rtwvif->aid = conf->aid;
 			rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 1ed7eb0..76d9253 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -640,9 +640,8 @@ struct rtw_chip_ops {
 			    u8 antenna_rx);
 	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
 	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
-	void (*do_iqk)(struct rtw_dev *rtwdev);
+	void (*phy_calibration)(struct rtw_dev *rtwdev);
 	void (*dpk_track)(struct rtw_dev *rtwdev);
-	void (*do_dpk)(struct rtw_dev *rtwdev);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 3679505..7056ea3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1001,8 +1001,9 @@ static void rtw8822b_do_iqk(struct rtw_dev *rtwdev)
 		counter, reload, ++do_iqk_cnt, iqk_fail_mask);
 }
 
-static void rtw8822b_do_dpk(struct rtw_dev *rtwdev)
+static void rtw8822b_phy_calibration(struct rtw_dev *rtwdev)
 {
+	rtw8822b_do_iqk(rtwdev);
 }
 
 static void rtw8822b_coex_cfg_init(struct rtw_dev *rtwdev)
@@ -1798,8 +1799,7 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.set_antenna		= rtw8822b_set_antenna,
 	.cfg_ldo25		= rtw8822b_cfg_ldo25,
 	.false_alarm_statistics	= rtw8822b_false_alarm_statistics,
-	.do_iqk			= rtw8822b_do_iqk,
-	.do_dpk			= rtw8822b_do_dpk,
+	.phy_calibration	= rtw8822b_phy_calibration,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index cee12b1..5a428e0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3078,6 +3078,12 @@ static void rtw8822c_do_dpk(struct rtw_dev *rtwdev)
 	rtw8822c_dpk_restore_registers(rtwdev, DPK_BB_REG_NUM, bckp);
 }
 
+static void rtw8822c_phy_calibration(struct rtw_dev *rtwdev)
+{
+	rtw8822c_do_iqk(rtwdev);
+	rtw8822c_do_dpk(rtwdev);
+}
+
 void rtw8822c_dpk_track(struct rtw_dev *rtwdev)
 {
 	struct rtw_dpk_info *dpk_info = &rtwdev->dm_info.dpk_info;
@@ -3487,9 +3493,8 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.set_tx_power_index	= rtw8822c_set_tx_power_index,
 	.cfg_ldo25		= rtw8822c_cfg_ldo25,
 	.false_alarm_statistics	= rtw8822c_false_alarm_statistics,
-	.do_iqk			= rtw8822c_do_iqk,
-	.do_dpk			= rtw8822c_do_dpk,
 	.dpk_track		= rtw8822c_dpk_track,
+	.phy_calibration	= rtw8822c_phy_calibration,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
-- 
2.7.4

