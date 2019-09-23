Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A801DBACC0
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 04:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfIWCrO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Sep 2019 22:47:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47834 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbfIWCrO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Sep 2019 22:47:14 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8N2l6lV027779, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8N2l6lV027779
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 23 Sep 2019 10:47:06 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 23 Sep 2019 10:47:06 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 5.4 v2] rtw88: configure firmware after HCI started
Date:   Mon, 23 Sep 2019 10:47:03 +0800
Message-ID: <20190923024703.2995-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

After firmware has been downloaded, driver should send
some information to it through H2C commands. Those H2C
commands are transmitted through TX path.

But before HCI has been started, the TX path is not
working completely. Such as PCI interfaces, the interrupts
are not enabled, hence TX interrupts will not be issued
after H2C skb has been DMAed to the device. And the H2C
skbs will not be released until the device is powered off.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/mac.c  | 3 ---
 drivers/net/wireless/realtek/rtw88/main.c | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index fc14b37d927d..b61b073031e5 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -707,9 +707,6 @@ int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *fw)
 	rtwdev->h2c.last_box_num = 0;
 	rtwdev->h2c.seq = 0;
 
-	rtw_fw_send_general_info(rtwdev);
-	rtw_fw_send_phydm_info(rtwdev);
-
 	rtw_flag_set(rtwdev, RTW_FLAG_FW_RUNNING);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index fc8f6213fc8f..6dd457741b15 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -704,6 +704,10 @@ static int rtw_power_on(struct rtw_dev *rtwdev)
 		goto err_off;
 	}
 
+	/* send H2C after HCI has started */
+	rtw_fw_send_general_info(rtwdev);
+	rtw_fw_send_phydm_info(rtwdev);
+
 	wifi_only = !rtwdev->efuse.btcoex;
 	rtw_coex_power_on_setting(rtwdev);
 	rtw_coex_init_hw_config(rtwdev, wifi_only);
-- 
2.17.1

