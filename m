Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011E22AFE85
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 06:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgKLFio (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 00:38:44 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:38673 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgKLDPg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Nov 2020 22:15:36 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AC3FVTi8025866, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AC3FVTi8025866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 11:15:31 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 12 Nov 2020 11:15:31 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>, <tony0620emma@gmail.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 06/11] rtw88: coex: update the TDMA parameter when leave LPS
Date:   Thu, 12 Nov 2020 11:14:25 +0800
Message-ID: <20201112031430.4846-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201112031430.4846-1-pkshih@realtek.com>
References: <20201112031430.4846-1-pkshih@realtek.com>
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

The updated parameter and original parameter all means TDMA-OFF.
The original setting write 0x8 to firmware, but it only works for
some old IC series.
To avoid the confusing, update a proper parameter.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 9ab31fbcb593..57b7776cf263 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -928,7 +928,7 @@ static void rtw_coex_power_save_state(struct rtw_dev *rtwdev, u8 ps_type,
 	case COEX_PS_LPS_OFF:
 		coex_stat->wl_force_lps_ctrl = true;
 		if (lps_mode)
-			rtw_fw_coex_tdma_type(rtwdev, 0x8, 0, 0, 0, 0);
+			rtw_fw_coex_tdma_type(rtwdev, 0, 0, 0, 0, 0);
 
 		rtw_leave_lps(rtwdev);
 		rtw_dbg(rtwdev, RTW_DBG_COEX,
-- 
2.21.0

