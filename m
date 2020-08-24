Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 678ED24F524
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 10:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgHXIpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 04:45:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:52540 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgHXIpC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 04:45:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 07O8itWD3021373, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 07O8itWD3021373
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 24 Aug 2020 16:44:55 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Aug 2020 16:44:55 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 24 Aug 2020 16:44:54 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH] rtw88: 8822c: update tx power limit tables to RF v20.1
Date:   Mon, 24 Aug 2020 16:44:53 +0800
Message-ID: <20200824084453.29953-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

update tx power limits of channels 12, 13 for FCC

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 .../wireless/realtek/rtw88/rtw8822c_table.c   | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c b/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
index 08d01a7bb1bf..3a204a7533df 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
@@ -23889,7 +23889,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 0, 11, 60, },
 	{ 8, 0, 0, 0, 11, 72, },
 	{ 9, 0, 0, 0, 11, 60, },
-	{ 0, 0, 0, 0, 12, 52, },
+	{ 0, 0, 0, 0, 12, 44, },
 	{ 2, 0, 0, 0, 12, 60, },
 	{ 1, 0, 0, 0, 12, 68, },
 	{ 3, 0, 0, 0, 12, 52, },
@@ -23899,7 +23899,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 0, 12, 60, },
 	{ 8, 0, 0, 0, 12, 52, },
 	{ 9, 0, 0, 0, 12, 60, },
-	{ 0, 0, 0, 0, 13, 48, },
+	{ 0, 0, 0, 0, 13, 40, },
 	{ 2, 0, 0, 0, 13, 60, },
 	{ 1, 0, 0, 0, 13, 68, },
 	{ 3, 0, 0, 0, 13, 48, },
@@ -24029,7 +24029,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 1, 11, 60, },
 	{ 8, 0, 0, 1, 11, 52, },
 	{ 9, 0, 0, 1, 11, 60, },
-	{ 0, 0, 0, 1, 12, 40, },
+	{ 0, 0, 0, 1, 12, 32, },
 	{ 2, 0, 0, 1, 12, 60, },
 	{ 1, 0, 0, 1, 12, 76, },
 	{ 3, 0, 0, 1, 12, 40, },
@@ -24039,7 +24039,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 1, 12, 60, },
 	{ 8, 0, 0, 1, 12, 40, },
 	{ 9, 0, 0, 1, 12, 60, },
-	{ 0, 0, 0, 1, 13, 28, },
+	{ 0, 0, 0, 1, 13, 20, },
 	{ 2, 0, 0, 1, 13, 60, },
 	{ 1, 0, 0, 1, 13, 76, },
 	{ 3, 0, 0, 1, 13, 28, },
@@ -24169,7 +24169,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 2, 11, 60, },
 	{ 8, 0, 0, 2, 11, 52, },
 	{ 9, 0, 0, 2, 11, 60, },
-	{ 0, 0, 0, 2, 12, 40, },
+	{ 0, 0, 0, 2, 12, 32, },
 	{ 2, 0, 0, 2, 12, 60, },
 	{ 1, 0, 0, 2, 12, 76, },
 	{ 3, 0, 0, 2, 12, 40, },
@@ -24179,7 +24179,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 2, 12, 60, },
 	{ 8, 0, 0, 2, 12, 40, },
 	{ 9, 0, 0, 2, 12, 60, },
-	{ 0, 0, 0, 2, 13, 28, },
+	{ 0, 0, 0, 2, 13, 20, },
 	{ 2, 0, 0, 2, 13, 60, },
 	{ 1, 0, 0, 2, 13, 76, },
 	{ 3, 0, 0, 2, 13, 28, },
@@ -24309,7 +24309,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 3, 11, 36, },
 	{ 8, 0, 0, 3, 11, 52, },
 	{ 9, 0, 0, 3, 11, 36, },
-	{ 0, 0, 0, 3, 12, 40, },
+	{ 0, 0, 0, 3, 12, 32, },
 	{ 2, 0, 0, 3, 12, 36, },
 	{ 1, 0, 0, 3, 12, 66, },
 	{ 3, 0, 0, 3, 12, 40, },
@@ -24319,7 +24319,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type0[] = {
 	{ 7, 0, 0, 3, 12, 36, },
 	{ 8, 0, 0, 3, 12, 40, },
 	{ 9, 0, 0, 3, 12, 36, },
-	{ 0, 0, 0, 3, 13, 28, },
+	{ 0, 0, 0, 3, 13, 20, },
 	{ 2, 0, 0, 3, 13, 36, },
 	{ 1, 0, 0, 3, 13, 66, },
 	{ 3, 0, 0, 3, 13, 28, },
@@ -25844,7 +25844,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 0, 11, 60, },
 	{ 8, 0, 0, 0, 11, 72, },
 	{ 9, 0, 0, 0, 11, 60, },
-	{ 0, 0, 0, 0, 12, 52, },
+	{ 0, 0, 0, 0, 12, 44, },
 	{ 2, 0, 0, 0, 12, 60, },
 	{ 1, 0, 0, 0, 12, 68, },
 	{ 3, 0, 0, 0, 12, 52, },
@@ -25854,7 +25854,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 0, 12, 60, },
 	{ 8, 0, 0, 0, 12, 52, },
 	{ 9, 0, 0, 0, 12, 60, },
-	{ 0, 0, 0, 0, 13, 48, },
+	{ 0, 0, 0, 0, 13, 40, },
 	{ 2, 0, 0, 0, 13, 60, },
 	{ 1, 0, 0, 0, 13, 68, },
 	{ 3, 0, 0, 0, 13, 48, },
@@ -25984,7 +25984,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 1, 11, 60, },
 	{ 8, 0, 0, 1, 11, 52, },
 	{ 9, 0, 0, 1, 11, 60, },
-	{ 0, 0, 0, 1, 12, 40, },
+	{ 0, 0, 0, 1, 12, 32, },
 	{ 2, 0, 0, 1, 12, 60, },
 	{ 1, 0, 0, 1, 12, 76, },
 	{ 3, 0, 0, 1, 12, 40, },
@@ -25994,7 +25994,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 1, 12, 60, },
 	{ 8, 0, 0, 1, 12, 40, },
 	{ 9, 0, 0, 1, 12, 60, },
-	{ 0, 0, 0, 1, 13, 28, },
+	{ 0, 0, 0, 1, 13, 20, },
 	{ 2, 0, 0, 1, 13, 60, },
 	{ 1, 0, 0, 1, 13, 76, },
 	{ 3, 0, 0, 1, 13, 28, },
@@ -26124,7 +26124,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 2, 11, 60, },
 	{ 8, 0, 0, 2, 11, 52, },
 	{ 9, 0, 0, 2, 11, 60, },
-	{ 0, 0, 0, 2, 12, 40, },
+	{ 0, 0, 0, 2, 12, 32, },
 	{ 2, 0, 0, 2, 12, 60, },
 	{ 1, 0, 0, 2, 12, 76, },
 	{ 3, 0, 0, 2, 12, 40, },
@@ -26134,7 +26134,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 2, 12, 60, },
 	{ 8, 0, 0, 2, 12, 40, },
 	{ 9, 0, 0, 2, 12, 60, },
-	{ 0, 0, 0, 2, 13, 28, },
+	{ 0, 0, 0, 2, 13, 20, },
 	{ 2, 0, 0, 2, 13, 60, },
 	{ 1, 0, 0, 2, 13, 76, },
 	{ 3, 0, 0, 2, 13, 28, },
@@ -26264,7 +26264,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 3, 11, 36, },
 	{ 8, 0, 0, 3, 11, 52, },
 	{ 9, 0, 0, 3, 11, 36, },
-	{ 0, 0, 0, 3, 12, 40, },
+	{ 0, 0, 0, 3, 12, 32, },
 	{ 2, 0, 0, 3, 12, 36, },
 	{ 1, 0, 0, 3, 12, 66, },
 	{ 3, 0, 0, 3, 12, 40, },
@@ -26274,7 +26274,7 @@ static const struct rtw_txpwr_lmt_cfg_pair rtw8822c_txpwr_lmt_type5[] = {
 	{ 7, 0, 0, 3, 12, 36, },
 	{ 8, 0, 0, 3, 12, 40, },
 	{ 9, 0, 0, 3, 12, 36, },
-	{ 0, 0, 0, 3, 13, 28, },
+	{ 0, 0, 0, 3, 13, 20, },
 	{ 2, 0, 0, 3, 13, 36, },
 	{ 1, 0, 0, 3, 13, 66, },
 	{ 3, 0, 0, 3, 13, 28, },
-- 
2.17.1

