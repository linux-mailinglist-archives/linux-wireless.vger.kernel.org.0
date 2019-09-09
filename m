Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4EFAD374
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 09:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfIIHQ0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 03:16:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57957 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfIIHQ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 03:16:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x897GKgT014356, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x897GKgT014356
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 9 Sep 2019 15:16:20 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 9 Sep 2019 15:16:20 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 4/8] rtw88: 8822c: add FW IQK support
Date:   Mon, 9 Sep 2019 15:16:07 +0800
Message-ID: <1568013371-21805-5-git-send-email-yhchuang@realtek.com>
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

Add support for doing IQK in firmware

Ideally the RF component's I/Q vectors should be orthogonal,
but usually they are not. So we need to calibrate for the RF
components, ex. PA/LNA, ADC/DAC.

And if the I/Q vectors are more orthogonal, the mixed signal
will have less deviation. This helps with those rates with
higher modulation (MCS8-9), because they have more strict
EVM/SNR requirement. Also the better of the quality of the
signal, the longer it can propagate, and the better throughput
performance we can get.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
   * add more log to describe IQK

 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 16 ++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index e11bbc3..176ca5f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1876,6 +1876,22 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 
 static void rtw8822c_do_iqk(struct rtw_dev *rtwdev)
 {
+	struct rtw_iqk_para para = {0};
+	u8 iqk_chk;
+	int counter;
+
+	para.clear = 1;
+	rtw_fw_do_iqk(rtwdev, &para);
+
+	for (counter = 0; counter < 300; counter++) {
+		iqk_chk = rtw_read8(rtwdev, REG_RPT_CIP);
+		if (iqk_chk == 0xaa)
+			break;
+		msleep(20);
+	}
+	rtw_write8(rtwdev, REG_IQKSTAT, 0x0);
+
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "iqk counter=%d\n", counter);
 }
 
 /* for coex */
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 5ee1de4..14a8894 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -176,6 +176,7 @@ struct rtw8822c_efuse {
 #define REG_TXF7	0x1ab0
 #define REG_CCK_SOURCE	0x1abc
 #define BIT_NBI_EN		BIT(30)
+#define REG_IQKSTAT	0x1b10
 #define REG_TXANT	0x1c28
 #define REG_ENCCK	0x1c3c
 #define BIT_CCK_BLK_EN		BIT(1)
@@ -197,6 +198,7 @@ struct rtw8822c_efuse {
 #define REG_OFDM_FACNT3	0x2d0c
 #define REG_OFDM_FACNT4	0x2d10
 #define REG_OFDM_FACNT5	0x2d20
+#define REG_RPT_CIP	0x2d9c
 #define REG_OFDM_TXCNT	0x2de0
 #define REG_ORITXCODE2	0x4100
 #define REG_3WIRE2	0x410c
-- 
2.7.4

