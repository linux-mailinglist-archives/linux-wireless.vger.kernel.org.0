Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C112D2234E8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGQGuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:06 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55018 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6o0Mt9028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6o0Mt9028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:50:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/7] rtw88: fix LDPC field for RA info
Date:   Fri, 17 Jul 2020 14:49:31 +0800
Message-ID: <20200717064937.27966-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717064937.27966-1-yhchuang@realtek.com>
References: <20200717064937.27966-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tsang-Shian Lin <thlin@realtek.com>

Convert the type of LDPC field to boolen because
LDPC field of RA info H2C command to firmware
is only one bit.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 6478fd7a78f6..13e79482f6d5 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -456,7 +456,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	SET_RA_INFO_INIT_RA_LVL(h2c_pkt, si->init_ra_lv);
 	SET_RA_INFO_SGI_EN(h2c_pkt, si->sgi_enable);
 	SET_RA_INFO_BW_MODE(h2c_pkt, si->bw_mode);
-	SET_RA_INFO_LDPC(h2c_pkt, si->ldpc_en);
+	SET_RA_INFO_LDPC(h2c_pkt, !!si->ldpc_en);
 	SET_RA_INFO_NO_UPDATE(h2c_pkt, no_update);
 	SET_RA_INFO_VHT_EN(h2c_pkt, si->vht_enable);
 	SET_RA_INFO_DIS_PT(h2c_pkt, disable_pt);
-- 
2.17.1

