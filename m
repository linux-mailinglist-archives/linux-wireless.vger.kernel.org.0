Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1464C47D9
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbfJBGfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57727 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727283AbfJBGfu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:50 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZiNL013117, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZiNL013117
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:45 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:44 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 14/14] rtw88: fix error handling when setup efuse info
Date:   Wed, 2 Oct 2019 14:35:31 +0800
Message-ID: <20191002063531.18135-15-yhchuang@realtek.com>
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

Disable efuse if the efuse is enabled when we failed to setup the efuse
information, otherwise the hardware will not turn off.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index bd2d3f9bc049..e0cc4c11e513 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1105,19 +1105,19 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
 	/* power on mac to read efuse */
 	ret = rtw_chip_efuse_enable(rtwdev);
 	if (ret)
-		goto out;
+		goto out_unlock;
 
 	ret = rtw_parse_efuse_map(rtwdev);
 	if (ret)
-		goto out;
+		goto out_disable;
 
 	ret = rtw_dump_hw_feature(rtwdev);
 	if (ret)
-		goto out;
+		goto out_disable;
 
 	ret = rtw_check_supported_rfe(rtwdev);
 	if (ret)
-		goto out;
+		goto out_disable;
 
 	if (efuse->crystal_cap == 0xff)
 		efuse->crystal_cap = 0;
@@ -1144,9 +1144,10 @@ static int rtw_chip_efuse_info_setup(struct rtw_dev *rtwdev)
 	efuse->ext_pa_5g = efuse->pa_type_5g & BIT(0) ? 1 : 0;
 	efuse->ext_lna_2g = efuse->lna_type_5g & BIT(3) ? 1 : 0;
 
+out_disable:
 	rtw_chip_efuse_disable(rtwdev);
 
-out:
+out_unlock:
 	mutex_unlock(&rtwdev->mutex);
 	return ret;
 }
-- 
2.17.1

