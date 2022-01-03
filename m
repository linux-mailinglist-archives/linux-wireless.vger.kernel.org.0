Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533BB482D73
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jan 2022 02:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiACBhP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 20:37:15 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:56768 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiACBhP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 20:37:15 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2031anu87024262, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2031anu87024262
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 3 Jan 2022 09:36:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 3 Jan 2022 09:36:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 3 Jan
 2022 09:36:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>, <rgoldwyn@suse.com>
Subject: [PATCH v2 2/3] rtw89: Add RX counters of VHT MCS-10/11 to debugfs
Date:   Mon, 3 Jan 2022 09:36:22 +0800
Message-ID: <20220103013623.17052-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103013623.17052-1-pkshih@realtek.com>
References: <20220103013623.17052-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/03/2022 01:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMiCkVaTIIDA2OjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8852AE can receive packets with VHT MCS10/11, and we want to know we have
received this kind of packets, so show the counter of VHT MCS10/11 in
debugfs, like:

TP TX: 1 [1] Mbps (lv: 1), RX: 420 [422] Mbps (lv: 4)
Beacon: 19
Avg packet length: TX=102, RX=3081
RX count:
   Legacy: [0, 0, 0, 0]
     OFDM: [0, 0, 0, 0, 0, 0, 0, 0]
     HT 0: [0, 0, 0, 0, 0, 0, 0, 0]
     HT 1: [0, 0, 0, 0, 0, 0, 0, 0]
  VHT 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0][0, 0]
  VHT 2SS: [0, 0, 0, 0, 0, 0, 0, 4, 624, 4818][29913, 556]
   HE 1SS: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
   HE 2ss: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
TX rate [0]: VHT 2SS MCS-9 SGI	(hw_rate=0x119)	==> agg_wait=1 (3500)
RX rate [0]: VHT 2SS MCS-10 SGI	(hw_rate=0x11a)
RSSI: -30 dBm (raw=161, prev=165)

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: remove VHT MCS-10/11 limit from driver, and change subject.
---
 drivers/net/wireless/realtek/rtw89/debug.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 9756d75ef24e1..fb2f4870172d9 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2322,16 +2322,17 @@ rtw89_debug_append_rx_rate(struct seq_file *m, struct rtw89_pkt_stat *pkt_stat,
 static const struct rtw89_rx_rate_cnt_info {
 	enum rtw89_hw_rate first_rate;
 	int len;
+	int ext;
 	const char *rate_mode;
 } rtw89_rx_rate_cnt_infos[] = {
-	{RTW89_HW_RATE_CCK1, 4, "Legacy:"},
-	{RTW89_HW_RATE_OFDM6, 8, "OFDM:"},
-	{RTW89_HW_RATE_MCS0, 8, "HT 0:"},
-	{RTW89_HW_RATE_MCS8, 8, "HT 1:"},
-	{RTW89_HW_RATE_VHT_NSS1_MCS0, 10, "VHT 1SS:"},
-	{RTW89_HW_RATE_VHT_NSS2_MCS0, 10, "VHT 2SS:"},
-	{RTW89_HW_RATE_HE_NSS1_MCS0, 12, "HE 1SS:"},
-	{RTW89_HW_RATE_HE_NSS2_MCS0, 12, "HE 2ss:"},
+	{RTW89_HW_RATE_CCK1, 4, 0, "Legacy:"},
+	{RTW89_HW_RATE_OFDM6, 8, 0, "OFDM:"},
+	{RTW89_HW_RATE_MCS0, 8, 0, "HT 0:"},
+	{RTW89_HW_RATE_MCS8, 8, 0, "HT 1:"},
+	{RTW89_HW_RATE_VHT_NSS1_MCS0, 10, 2, "VHT 1SS:"},
+	{RTW89_HW_RATE_VHT_NSS2_MCS0, 10, 2, "VHT 2SS:"},
+	{RTW89_HW_RATE_HE_NSS1_MCS0, 12, 0, "HE 1SS:"},
+	{RTW89_HW_RATE_HE_NSS2_MCS0, 12, 0, "HE 2ss:"},
 };
 
 static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
@@ -2356,6 +2357,11 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 		seq_printf(m, "%10s [", info->rate_mode);
 		rtw89_debug_append_rx_rate(m, pkt_stat,
 					   info->first_rate, info->len);
+		if (info->ext) {
+			seq_puts(m, "][");
+			rtw89_debug_append_rx_rate(m, pkt_stat,
+						   info->first_rate + info->len, info->ext);
+		}
 		seq_puts(m, "]\n");
 	}
 
-- 
2.25.1

