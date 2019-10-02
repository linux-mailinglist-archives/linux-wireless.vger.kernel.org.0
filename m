Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458B5C47DA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfJBGfx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57728 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfJBGfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:50 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZiWX013110, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZiWX013110
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:44 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:43 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 13/14] rtw88: fix NSS of hw_cap
Date:   Wed, 2 Oct 2019 14:35:30 +0800
Message-ID: <20191002063531.18135-14-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8822C is a 2x2 11ac chip, and then NSS must be less or equal to 2. However,
current nss of hw cap is 3, likes
	hw cap: hci=0x0f, bw=0x07, ptcl=0x03, ant_num=7, nss=3

This commit adds constraint to make sure NSS <= rf_path_num, and result
looks like
	hw cap: hci=0x0f, bw=0x07, ptcl=0x03, ant_num=7, nss=2

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f7044e8bcb5b..bd2d3f9bc049 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1077,7 +1077,8 @@ static int rtw_dump_hw_feature(struct rtw_dev *rtwdev)
 
 	rtw_hw_config_rf_ant_num(rtwdev, efuse->hw_cap.ant_num);
 
-	if (efuse->hw_cap.nss == EFUSE_HW_CAP_IGNORE)
+	if (efuse->hw_cap.nss == EFUSE_HW_CAP_IGNORE ||
+	    efuse->hw_cap.nss > rtwdev->hal.rf_path_num)
 		efuse->hw_cap.nss = rtwdev->hal.rf_path_num;
 
 	rtw_dbg(rtwdev, RTW_DBG_EFUSE,
-- 
2.17.1

