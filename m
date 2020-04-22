Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430E71B35BA
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Apr 2020 05:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgDVDqX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Apr 2020 23:46:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36998 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgDVDqS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Apr 2020 23:46:18 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03M3kAzD5004569, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03M3kAzD5004569
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 11:46:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 22 Apr 2020 11:46:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>
Subject: [PATCH v2 2/8] rtw88: no need to send additional information to legacy firmware
Date:   Wed, 22 Apr 2020 11:46:01 +0800
Message-ID: <20200422034607.28747-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422034607.28747-1-yhchuang@realtek.com>
References: <20200422034607.28747-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

The firmware of 11AC devices need more information to support more offload
functions, such as IQK. And 11N devices such as 8723D does not support
offload these function in firmware, there is no need to send these additional
information to firmware when it comes to 11N devices.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 209853fdcb42..dde7823143ea 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -271,6 +271,9 @@ rtw_fw_send_general_info(struct rtw_dev *rtwdev)
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
 	u16 total_size = H2C_PKT_HDR_SIZE + 4;
 
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return;
+
 	rtw_h2c_pkt_set_header(h2c_pkt, H2C_PKT_GENERAL_INFO);
 
 	SET_PKT_H2C_TOTAL_LEN(h2c_pkt, total_size);
@@ -291,6 +294,9 @@ rtw_fw_send_phydm_info(struct rtw_dev *rtwdev)
 	u16 total_size = H2C_PKT_HDR_SIZE + 8;
 	u8 fw_rf_type = 0;
 
+	if (rtw_chip_wcpu_11n(rtwdev))
+		return;
+
 	if (hal->rf_type == RF_1T1R)
 		fw_rf_type = FW_RF_1T1R;
 	else if (hal->rf_type == RF_2T2R)
-- 
2.17.1

