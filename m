Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4524278071
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Sep 2020 08:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgIYGTc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Sep 2020 02:19:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39823 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIYGTb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Sep 2020 02:19:31 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08P6CNYL0010530, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08P6CNYL0010530
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Sep 2020 14:12:23 +0800
Received: from localhost.localdomain (172.21.69.222) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Fri, 25 Sep 2020 14:12:22 +0800
From:   <tehuang@realtek.com>
To:     <kvalo@codeaurora.org>, <yhchuang@realtek.com>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] rtw88: show current regulatory in tx power table
Date:   Fri, 25 Sep 2020 14:12:19 +0800
Message-ID: <20200925061219.23754-6-tehuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200925061219.23754-1-tehuang@realtek.com>
References: <20200925061219.23754-1-tehuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.222]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

In the transmit power table, it is important to know what the regulatory
currently is. For different regulatories, there are different
transmit power limits. Show which regulatory the driver is currently
using.

Change-Id: Id92aa6a833053fbf0b065c9ff946d7d4722897fd
Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index bff6ce19345a..3852c4f0ac0b 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -544,6 +544,28 @@ static void rtw_print_rate(struct seq_file *m, u8 rate)
 	}
 }
 
+#define case_REGD(src) \
+	case RTW_REGD_##src: return #src
+
+static const char *rtw_get_regd_string(u8 regd)
+{
+	switch (regd) {
+	case_REGD(FCC);
+	case_REGD(MKK);
+	case_REGD(ETSI);
+	case_REGD(IC);
+	case_REGD(KCC);
+	case_REGD(ACMA);
+	case_REGD(CHILE);
+	case_REGD(UKRAINE);
+	case_REGD(MEXICO);
+	case_REGD(CN);
+	case_REGD(WW);
+	default:
+		return "Unknown";
+	}
+}
+
 static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
@@ -555,6 +577,7 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	u8 ch = hal->current_channel;
 	u8 regd = rtwdev->regd.txpwr_regd;
 
+	seq_printf(m, "regulatory: %s\n", rtw_get_regd_string(regd));
 	seq_printf(m, "%-4s %-10s %-3s%6s %-4s %4s (%-4s %-4s) %-4s\n",
 		   "path", "rate", "pwr", "", "base", "", "byr", "lmt", "rem");
 
-- 
2.17.1

