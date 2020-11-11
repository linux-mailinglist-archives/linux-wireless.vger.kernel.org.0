Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE3B2AE657
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Nov 2020 03:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbgKKCWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 21:22:21 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39284 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731900AbgKKCWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 21:22:20 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AB2MEdmC027738, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AB2MEdmC027738
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Nov 2020 10:22:14 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 11 Nov 2020 10:22:13 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 11/11] rtw88: coex: change the decode method from firmware
Date:   Wed, 11 Nov 2020 10:21:08 +0800
Message-ID: <20201111022108.9834-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201111022108.9834-1-pkshih@realtek.com>
References: <20201111022108.9834-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Fix sometimes FW information will be parsed as wrong value,
do a correction of sign bit to show the correct information.
(Ex, Value should be 20, but it shows 236.)

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 95e5ff5abae5..36b446133cd2 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -2883,7 +2883,7 @@ void rtw_coex_wl_fwdbginfo_notify(struct rtw_dev *rtwdev, u8 *buf, u8 length)
 		if (buf[i] >= val)
 			coex_stat->wl_fw_dbg_info[i] = buf[i] - val;
 		else
-			coex_stat->wl_fw_dbg_info[i] = val - buf[i];
+			coex_stat->wl_fw_dbg_info[i] = 255 - val + buf[i];
 
 		coex_stat->wl_fw_dbg_info_pre[i] = buf[i];
 	}
-- 
2.21.0

