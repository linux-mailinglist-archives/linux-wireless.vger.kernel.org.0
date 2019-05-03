Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AA412CF4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2019 13:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfECLxs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 May 2019 07:53:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58264 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfECLxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 May 2019 07:53:46 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x43BrgOg000732, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x43BrgOg000732
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 3 May 2019 19:53:42 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 3 May 2019 19:53:42 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 5/5] rtw88: more descriptions about LPS
Date:   Fri, 3 May 2019 19:53:35 +0800
Message-ID: <1556884415-23474-6-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
References: <1556884415-23474-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The LPS represents Leisure Power Save. When enabled, firmware will be in
charge of turning radio off between beacons. Also firmware should turn
on the radio when beacon is coming, and the data queued should be
transmitted in TBTT period.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f447361..142e530 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -20,7 +20,7 @@ EXPORT_SYMBOL(rtw_debug_mask);
 module_param_named(support_lps, rtw_fw_support_lps, bool, 0644);
 module_param_named(debug_mask, rtw_debug_mask, uint, 0644);
 
-MODULE_PARM_DESC(support_lps, "Set Y to enable LPS support");
+MODULE_PARM_DESC(support_lps, "Set Y to enable Leisure Power Save support, to turn radio off between beacons");
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
 static struct ieee80211_channel rtw_channeltable_2g[] = {
-- 
2.7.4

