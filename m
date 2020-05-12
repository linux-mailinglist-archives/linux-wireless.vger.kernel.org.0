Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2701CF24D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgELK1D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:27:03 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36525 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgELK0l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:26:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAQPYi8009505, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAQPYi8009505
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:26:25 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:25 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:26:24 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v3 8/9] rtw88: fill zeros to words 0x06 and 0x07 of security cam entry
Date:   Tue, 12 May 2020 18:26:20 +0800
Message-ID: <20200512102621.5148-9-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512102621.5148-1-yhchuang@realtek.com>
References: <20200512102621.5148-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8723D adds some experimental features to word 0x06 of cam entry, so fill
zeros to initialize them to off state. For existing chips, these two words
are reserved and always zeros, so this change is harmless for them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/sec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/sec.c b/drivers/net/wireless/realtek/rtw88/sec.c
index d0d7fbb10d58..ce46e5b4a60a 100644
--- a/drivers/net/wireless/realtek/rtw88/sec.c
+++ b/drivers/net/wireless/realtek/rtw88/sec.c
@@ -44,7 +44,7 @@ void rtw_sec_write_cam(struct rtw_dev *rtwdev,
 
 	write_cmd = RTW_SEC_CMD_WRITE_ENABLE | RTW_SEC_CMD_POLLING;
 	addr = hw_key_idx << RTW_SEC_CAM_ENTRY_SHIFT;
-	for (i = 5; i >= 0; i--) {
+	for (i = 7; i >= 0; i--) {
 		switch (i) {
 		case 0:
 			content = ((key->keyidx & 0x3))		|
@@ -60,6 +60,10 @@ void rtw_sec_write_cam(struct rtw_dev *rtwdev,
 				  (cam->addr[4]		<< 16)	|
 				  (cam->addr[5]		<< 24);
 			break;
+		case 6:
+		case 7:
+			content = 0;
+			break;
 		default:
 			j = (i - 2) << 2;
 			content = (key->key[j])			|
-- 
2.17.1

