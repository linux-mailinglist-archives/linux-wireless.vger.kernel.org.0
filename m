Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13ECFE475F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2019 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392763AbfJYJd6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Oct 2019 05:33:58 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50463 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730193AbfJYJd6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Oct 2019 05:33:58 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9P9Xnva026475, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9P9Xnva026475
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 25 Oct 2019 17:33:49 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 25 Oct 2019 17:33:48 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
Subject: [PATCH 2/6] rtw88: use rtw_phy_pg_cfg_pair struct, not arrays
Date:   Fri, 25 Oct 2019 17:33:41 +0800
Message-ID: <20191025093345.22643-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025093345.22643-1-yhchuang@realtek.com>
References: <20191025093345.22643-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Use proper struct for BB PG tables.

TODO: we need to find a way to store the tables that have
      condition values.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/phy.c      |  15 +-
 drivers/net/wireless/realtek/rtw88/phy.h      |   9 +
 .../wireless/realtek/rtw88/rtw8822b_table.c   | 283 +++++++++---------
 .../wireless/realtek/rtw88/rtw8822c_table.c   |  94 +++---
 4 files changed, 199 insertions(+), 202 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 69e7edb629f4..4a41134c420e 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -20,15 +20,6 @@ union phy_table_tile {
 	struct phy_cfg_pair cfg;
 };
 
-struct phy_pg_cfg_pair {
-	u32 band;
-	u32 rf_path;
-	u32 tx_num;
-	u32 addr;
-	u32 bitmask;
-	u32 data;
-};
-
 static const u32 db_invert_table[12][8] = {
 	{10,		13,		16,		20,
 	 25,		32,		40,		50},
@@ -1226,10 +1217,8 @@ static void rtw_phy_store_tx_power_by_rate(struct rtw_dev *rtwdev,
 
 void rtw_parse_tbl_bb_pg(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 {
-	const struct phy_pg_cfg_pair *p = tbl->data;
-	const struct phy_pg_cfg_pair *end = p + tbl->size / 6;
-
-	BUILD_BUG_ON(sizeof(struct phy_pg_cfg_pair) != sizeof(u32) * 6);
+	const struct rtw_phy_pg_cfg_pair *p = tbl->data;
+	const struct rtw_phy_pg_cfg_pair *end = p + tbl->size;
 
 	for (; p < end; p++) {
 		if (p->addr == 0xfe || p->addr == 0xffe) {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 0dc7720aaad7..c389ef274ed8 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -66,6 +66,15 @@ struct rtw_txpwr_lmt_cfg_pair {
 	s8 txpwr_lmt;
 };
 
+struct rtw_phy_pg_cfg_pair {
+	u32 band;
+	u32 rf_path;
+	u32 tx_num;
+	u32 addr;
+	u32 bitmask;
+	u32 data;
+};
+
 #define RTW_DECL_TABLE_PHY_COND_CORE(name, cfg, path)	\
 const struct rtw_table name ## _tbl = {			\
 	.data = name,					\
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b_table.c b/drivers/net/wireless/realtek/rtw88/rtw8822b_table.c
index 25537d147e86..b9010b111a13 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b_table.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b_table.c
@@ -11643,156 +11643,155 @@ static const u32 rtw8822b_bb[] = {
 
 RTW_DECL_TABLE_PHY_COND(rtw8822b_bb, rtw_phy_cfg_bb);
 
-static const u32 rtw8822b_bb_pg_type2[] = {
-	0, 0, 0, 0x00000c20, 0xffffffff, 0x32343638,
-	0, 0, 0, 0x00000c24, 0xffffffff, 0x36384042,
-	0, 0, 0, 0x00000c28, 0xffffffff, 0x28303234,
-	0, 0, 0, 0x00000c2c, 0xffffffff, 0x34363840,
-	0, 0, 0, 0x00000c30, 0xffffffff, 0x26283032,
-	0, 0, 1, 0x00000c34, 0xffffffff, 0x34363840,
-	0, 0, 1, 0x00000c38, 0xffffffff, 0x26283032,
-	0, 0, 0, 0x00000c3c, 0xffffffff, 0x34363840,
-	0, 0, 0, 0x00000c40, 0xffffffff, 0x26283032,
-	0, 0, 0, 0x00000c44, 0xffffffff, 0x38402224,
-	0, 0, 1, 0x00000c48, 0xffffffff, 0x30323436,
-	0, 0, 1, 0x00000c4c, 0xffffffff, 0x22242628,
-	0, 1, 0, 0x00000e20, 0xffffffff, 0x32343638,
-	0, 1, 0, 0x00000e24, 0xffffffff, 0x36384042,
-	0, 1, 0, 0x00000e28, 0xffffffff, 0x28303234,
-	0, 1, 0, 0x00000e2c, 0xffffffff, 0x34363840,
-	0, 1, 0, 0x00000e30, 0xffffffff, 0x26283032,
-	0, 1, 1, 0x00000e34, 0xffffffff, 0x34363840,
-	0, 1, 1, 0x00000e38, 0xffffffff, 0x26283032,
-	0, 1, 0, 0x00000e3c, 0xffffffff, 0x34363840,
-	0, 1, 0, 0x00000e40, 0xffffffff, 0x26283032,
-	0, 1, 0, 0x00000e44, 0xffffffff, 0x38402224,
-	0, 1, 1, 0x00000e48, 0xffffffff, 0x30323436,
-	0, 1, 1, 0x00000e4c, 0xffffffff, 0x22242628,
-	1, 0, 0, 0x00000c24, 0xffffffff, 0x40424446,
-	1, 0, 0, 0x00000c28, 0xffffffff, 0x32343638,
-	1, 0, 0, 0x00000c2c, 0xffffffff, 0x38404244,
-	1, 0, 0, 0x00000c30, 0xffffffff, 0x30323436,
-	1, 0, 1, 0x00000c34, 0xffffffff, 0x38404244,
-	1, 0, 1, 0x00000c38, 0xffffffff, 0x30323436,
-	1, 0, 0, 0x00000c3c, 0xffffffff, 0x38404244,
-	1, 0, 0, 0x00000c40, 0xffffffff, 0x30323436,
-	1, 0, 0, 0x00000c44, 0xffffffff, 0x42442628,
-	1, 0, 1, 0x00000c48, 0xffffffff, 0x34363840,
-	1, 0, 1, 0x00000c4c, 0xffffffff, 0x26283032,
-	1, 1, 0, 0x00000e24, 0xffffffff, 0x40424446,
-	1, 1, 0, 0x00000e28, 0xffffffff, 0x32343638,
-	1, 1, 0, 0x00000e2c, 0xffffffff, 0x38404244,
-	1, 1, 0, 0x00000e30, 0xffffffff, 0x30323436,
-	1, 1, 1, 0x00000e34, 0xffffffff, 0x38404244,
-	1, 1, 1, 0x00000e38, 0xffffffff, 0x30323436,
-	1, 1, 0, 0x00000e3c, 0xffffffff, 0x38404244,
-	1, 1, 0, 0x00000e40, 0xffffffff, 0x30323436,
-	1, 1, 0, 0x00000e44, 0xffffffff, 0x42442628,
-	1, 1, 1, 0x00000e48, 0xffffffff, 0x34363840,
-	1, 1, 1, 0x00000e4c, 0xffffffff, 0x26283032
+static const struct rtw_phy_pg_cfg_pair rtw8822b_bb_pg_type2[] = {
+	{ 0, 0, 0, 0x00000c20, 0xffffffff, 0x32343638, },
+	{ 0, 0, 0, 0x00000c24, 0xffffffff, 0x36384042, },
+	{ 0, 0, 0, 0x00000c28, 0xffffffff, 0x28303234, },
+	{ 0, 0, 0, 0x00000c2c, 0xffffffff, 0x34363840, },
+	{ 0, 0, 0, 0x00000c30, 0xffffffff, 0x26283032, },
+	{ 0, 0, 1, 0x00000c34, 0xffffffff, 0x34363840, },
+	{ 0, 0, 1, 0x00000c38, 0xffffffff, 0x26283032, },
+	{ 0, 0, 0, 0x00000c3c, 0xffffffff, 0x34363840, },
+	{ 0, 0, 0, 0x00000c40, 0xffffffff, 0x26283032, },
+	{ 0, 0, 0, 0x00000c44, 0xffffffff, 0x38402224, },
+	{ 0, 0, 1, 0x00000c48, 0xffffffff, 0x30323436, },
+	{ 0, 0, 1, 0x00000c4c, 0xffffffff, 0x22242628, },
+	{ 0, 1, 0, 0x00000e20, 0xffffffff, 0x32343638, },
+	{ 0, 1, 0, 0x00000e24, 0xffffffff, 0x36384042, },
+	{ 0, 1, 0, 0x00000e28, 0xffffffff, 0x28303234, },
+	{ 0, 1, 0, 0x00000e2c, 0xffffffff, 0x34363840, },
+	{ 0, 1, 0, 0x00000e30, 0xffffffff, 0x26283032, },
+	{ 0, 1, 1, 0x00000e34, 0xffffffff, 0x34363840, },
+	{ 0, 1, 1, 0x00000e38, 0xffffffff, 0x26283032, },
+	{ 0, 1, 0, 0x00000e3c, 0xffffffff, 0x34363840, },
+	{ 0, 1, 0, 0x00000e40, 0xffffffff, 0x26283032, },
+	{ 0, 1, 0, 0x00000e44, 0xffffffff, 0x38402224, },
+	{ 0, 1, 1, 0x00000e48, 0xffffffff, 0x30323436, },
+	{ 0, 1, 1, 0x00000e4c, 0xffffffff, 0x22242628, },
+	{ 1, 0, 0, 0x00000c24, 0xffffffff, 0x40424446, },
+	{ 1, 0, 0, 0x00000c28, 0xffffffff, 0x32343638, },
+	{ 1, 0, 0, 0x00000c2c, 0xffffffff, 0x38404244, },
+	{ 1, 0, 0, 0x00000c30, 0xffffffff, 0x30323436, },
+	{ 1, 0, 1, 0x00000c34, 0xffffffff, 0x38404244, },
+	{ 1, 0, 1, 0x00000c38, 0xffffffff, 0x30323436, },
+	{ 1, 0, 0, 0x00000c3c, 0xffffffff, 0x38404244, },
+	{ 1, 0, 0, 0x00000c40, 0xffffffff, 0x30323436, },
+	{ 1, 0, 0, 0x00000c44, 0xffffffff, 0x42442628, },
+	{ 1, 0, 1, 0x00000c48, 0xffffffff, 0x34363840, },
+	{ 1, 0, 1, 0x00000c4c, 0xffffffff, 0x26283032, },
+	{ 1, 1, 0, 0x00000e24, 0xffffffff, 0x40424446, },
+	{ 1, 1, 0, 0x00000e28, 0xffffffff, 0x32343638, },
+	{ 1, 1, 0, 0x00000e2c, 0xffffffff, 0x38404244, },
+	{ 1, 1, 0, 0x00000e30, 0xffffffff, 0x30323436, },
+	{ 1, 1, 1, 0x00000e34, 0xffffffff, 0x38404244, },
+	{ 1, 1, 1, 0x00000e38, 0xffffffff, 0x30323436, },
+	{ 1, 1, 0, 0x00000e3c, 0xffffffff, 0x38404244, },
+	{ 1, 1, 0, 0x00000e40, 0xffffffff, 0x30323436, },
+	{ 1, 1, 0, 0x00000e44, 0xffffffff, 0x42442628, },
+	{ 1, 1, 1, 0x00000e48, 0xffffffff, 0x34363840, },
+	{ 1, 1, 1, 0x00000e4c, 0xffffffff, 0x26283032, },
 };
 
 RTW_DECL_TABLE_BB_PG(rtw8822b_bb_pg_type2);
 
-static const u32 rtw8822b_bb_pg_type3[] = {
-	0, 0, 0, 0x00000c20, 0xffffffff, 0x32343638,
-	0, 0, 0, 0x00000c24, 0xffffffff, 0x36384042,
-	0, 0, 0, 0x00000c28, 0xffffffff, 0x28303234,
-	0, 0, 0, 0x00000c2c, 0xffffffff, 0x34363840,
-	0, 0, 0, 0x00000c30, 0xffffffff, 0x26283032,
-	0, 0, 1, 0x00000c34, 0xffffffff, 0x34363840,
-	0, 0, 1, 0x00000c38, 0xffffffff, 0x26283032,
-	0, 0, 0, 0x00000c3c, 0xffffffff, 0x34363840,
-	0, 0, 0, 0x00000c40, 0xffffffff, 0x26283032,
-	0, 0, 0, 0x00000c44, 0xffffffff, 0x38402224,
-	0, 0, 1, 0x00000c48, 0xffffffff, 0x30323436,
-	0, 0, 1, 0x00000c4c, 0xffffffff, 0x22242628,
-	0, 1, 0, 0x00000e20, 0xffffffff, 0x32343638,
-	0, 1, 0, 0x00000e24, 0xffffffff, 0x36384042,
-	0, 1, 0, 0x00000e28, 0xffffffff, 0x28303234,
-	0, 1, 0, 0x00000e2c, 0xffffffff, 0x34363840,
-	0, 1, 0, 0x00000e30, 0xffffffff, 0x26283032,
-	0, 1, 1, 0x00000e34, 0xffffffff, 0x34363840,
-	0, 1, 1, 0x00000e38, 0xffffffff, 0x26283032,
-	0, 1, 0, 0x00000e3c, 0xffffffff, 0x34363840,
-	0, 1, 0, 0x00000e40, 0xffffffff, 0x26283032,
-	0, 1, 0, 0x00000e44, 0xffffffff, 0x38402224,
-	0, 1, 1, 0x00000e48, 0xffffffff, 0x30323436,
-	0, 1, 1, 0x00000e4c, 0xffffffff, 0x22242628,
-	1, 0, 0, 0x00000c24, 0xffffffff, 0x34363840,
-	1, 0, 0, 0x00000c28, 0xffffffff, 0x26283032,
-	1, 0, 0, 0x00000c2c, 0xffffffff, 0x32343638,
-	1, 0, 0, 0x00000c30, 0xffffffff, 0x24262830,
-	1, 0, 1, 0x00000c34, 0xffffffff, 0x32343638,
-	1, 0, 1, 0x00000c38, 0xffffffff, 0x24262830,
-	1, 0, 0, 0x00000c3c, 0xffffffff, 0x32343638,
-	1, 0, 0, 0x00000c40, 0xffffffff, 0x24262830,
-	1, 0, 0, 0x00000c44, 0xffffffff, 0x36382022,
-	1, 0, 1, 0x00000c48, 0xffffffff, 0x28303234,
-	1, 0, 1, 0x00000c4c, 0xffffffff, 0x20222426,
-	1, 1, 0, 0x00000e24, 0xffffffff, 0x34363840,
-	1, 1, 0, 0x00000e28, 0xffffffff, 0x26283032,
-	1, 1, 0, 0x00000e2c, 0xffffffff, 0x32343638,
-	1, 1, 0, 0x00000e30, 0xffffffff, 0x24262830,
-	1, 1, 1, 0x00000e34, 0xffffffff, 0x32343638,
-	1, 1, 1, 0x00000e38, 0xffffffff, 0x24262830,
-	1, 1, 0, 0x00000e3c, 0xffffffff, 0x32343638,
-	1, 1, 0, 0x00000e40, 0xffffffff, 0x24262830,
-	1, 1, 0, 0x00000e44, 0xffffffff, 0x36382022,
-	1, 1, 1, 0x00000e48, 0xffffffff, 0x28303234,
-	1, 1, 1, 0x00000e4c, 0xffffffff, 0x20222426
-
+static const struct rtw_phy_pg_cfg_pair rtw8822b_bb_pg_type3[] = {
+	{ 0, 0, 0, 0x00000c20, 0xffffffff, 0x32343638, },
+	{ 0, 0, 0, 0x00000c24, 0xffffffff, 0x36384042, },
+	{ 0, 0, 0, 0x00000c28, 0xffffffff, 0x28303234, },
+	{ 0, 0, 0, 0x00000c2c, 0xffffffff, 0x34363840, },
+	{ 0, 0, 0, 0x00000c30, 0xffffffff, 0x26283032, },
+	{ 0, 0, 1, 0x00000c34, 0xffffffff, 0x34363840, },
+	{ 0, 0, 1, 0x00000c38, 0xffffffff, 0x26283032, },
+	{ 0, 0, 0, 0x00000c3c, 0xffffffff, 0x34363840, },
+	{ 0, 0, 0, 0x00000c40, 0xffffffff, 0x26283032, },
+	{ 0, 0, 0, 0x00000c44, 0xffffffff, 0x38402224, },
+	{ 0, 0, 1, 0x00000c48, 0xffffffff, 0x30323436, },
+	{ 0, 0, 1, 0x00000c4c, 0xffffffff, 0x22242628, },
+	{ 0, 1, 0, 0x00000e20, 0xffffffff, 0x32343638, },
+	{ 0, 1, 0, 0x00000e24, 0xffffffff, 0x36384042, },
+	{ 0, 1, 0, 0x00000e28, 0xffffffff, 0x28303234, },
+	{ 0, 1, 0, 0x00000e2c, 0xffffffff, 0x34363840, },
+	{ 0, 1, 0, 0x00000e30, 0xffffffff, 0x26283032, },
+	{ 0, 1, 1, 0x00000e34, 0xffffffff, 0x34363840, },
+	{ 0, 1, 1, 0x00000e38, 0xffffffff, 0x26283032, },
+	{ 0, 1, 0, 0x00000e3c, 0xffffffff, 0x34363840, },
+	{ 0, 1, 0, 0x00000e40, 0xffffffff, 0x26283032, },
+	{ 0, 1, 0, 0x00000e44, 0xffffffff, 0x38402224, },
+	{ 0, 1, 1, 0x00000e48, 0xffffffff, 0x30323436, },
+	{ 0, 1, 1, 0x00000e4c, 0xffffffff, 0x22242628, },
+	{ 1, 0, 0, 0x00000c24, 0xffffffff, 0x34363840, },
+	{ 1, 0, 0, 0x00000c28, 0xffffffff, 0x26283032, },
+	{ 1, 0, 0, 0x00000c2c, 0xffffffff, 0x32343638, },
+	{ 1, 0, 0, 0x00000c30, 0xffffffff, 0x24262830, },
+	{ 1, 0, 1, 0x00000c34, 0xffffffff, 0x32343638, },
+	{ 1, 0, 1, 0x00000c38, 0xffffffff, 0x24262830, },
+	{ 1, 0, 0, 0x00000c3c, 0xffffffff, 0x32343638, },
+	{ 1, 0, 0, 0x00000c40, 0xffffffff, 0x24262830, },
+	{ 1, 0, 0, 0x00000c44, 0xffffffff, 0x36382022, },
+	{ 1, 0, 1, 0x00000c48, 0xffffffff, 0x28303234, },
+	{ 1, 0, 1, 0x00000c4c, 0xffffffff, 0x20222426, },
+	{ 1, 1, 0, 0x00000e24, 0xffffffff, 0x34363840, },
+	{ 1, 1, 0, 0x00000e28, 0xffffffff, 0x26283032, },
+	{ 1, 1, 0, 0x00000e2c, 0xffffffff, 0x32343638, },
+	{ 1, 1, 0, 0x00000e30, 0xffffffff, 0x24262830, },
+	{ 1, 1, 1, 0x00000e34, 0xffffffff, 0x32343638, },
+	{ 1, 1, 1, 0x00000e38, 0xffffffff, 0x24262830, },
+	{ 1, 1, 0, 0x00000e3c, 0xffffffff, 0x32343638, },
+	{ 1, 1, 0, 0x00000e40, 0xffffffff, 0x24262830, },
+	{ 1, 1, 0, 0x00000e44, 0xffffffff, 0x36382022, },
+	{ 1, 1, 1, 0x00000e48, 0xffffffff, 0x28303234, },
+	{ 1, 1, 1, 0x00000e4c, 0xffffffff, 0x20222426, },
 };
 
 RTW_DECL_TABLE_BB_PG(rtw8822b_bb_pg_type3);
 
-static const u32 rtw8822b_bb_pg_type5[] = {
-	0, 0, 0, 0x00000c20, 0xffffffff, 0x32343638,
-	0, 0, 0, 0x00000c24, 0xffffffff, 0x36384042,
-	0, 0, 0, 0x00000c28, 0xffffffff, 0x28303234,
-	0, 0, 0, 0x00000c2c, 0xffffffff, 0x34363840,
-	0, 0, 0, 0x00000c30, 0xffffffff, 0x26283032,
-	0, 0, 1, 0x00000c34, 0xffffffff, 0x34363840,
-	0, 0, 1, 0x00000c38, 0xffffffff, 0x26283032,
-	0, 0, 0, 0x00000c3c, 0xffffffff, 0x34363840,
-	0, 0, 0, 0x00000c40, 0xffffffff, 0x26283032,
-	0, 0, 0, 0x00000c44, 0xffffffff, 0x38402224,
-	0, 0, 1, 0x00000c48, 0xffffffff, 0x30323436,
-	0, 0, 1, 0x00000c4c, 0xffffffff, 0x22242628,
-	0, 1, 0, 0x00000e20, 0xffffffff, 0x32343638,
-	0, 1, 0, 0x00000e24, 0xffffffff, 0x36384042,
-	0, 1, 0, 0x00000e28, 0xffffffff, 0x28303234,
-	0, 1, 0, 0x00000e2c, 0xffffffff, 0x34363840,
-	0, 1, 0, 0x00000e30, 0xffffffff, 0x26283032,
-	0, 1, 1, 0x00000e34, 0xffffffff, 0x34363840,
-	0, 1, 1, 0x00000e38, 0xffffffff, 0x26283032,
-	0, 1, 0, 0x00000e3c, 0xffffffff, 0x34363840,
-	0, 1, 0, 0x00000e40, 0xffffffff, 0x26283032,
-	0, 1, 0, 0x00000e44, 0xffffffff, 0x38402224,
-	0, 1, 1, 0x00000e48, 0xffffffff, 0x30323436,
-	0, 1, 1, 0x00000e4c, 0xffffffff, 0x22242628,
-	1, 0, 0, 0x00000c24, 0xffffffff, 0x34363840,
-	1, 0, 0, 0x00000c28, 0xffffffff, 0x26283032,
-	1, 0, 0, 0x00000c2c, 0xffffffff, 0x32343638,
-	1, 0, 0, 0x00000c30, 0xffffffff, 0x24262830,
-	1, 0, 1, 0x00000c34, 0xffffffff, 0x32343638,
-	1, 0, 1, 0x00000c38, 0xffffffff, 0x24262830,
-	1, 0, 0, 0x00000c3c, 0xffffffff, 0x32343638,
-	1, 0, 0, 0x00000c40, 0xffffffff, 0x24262830,
-	1, 0, 0, 0x00000c44, 0xffffffff, 0x36382022,
-	1, 0, 1, 0x00000c48, 0xffffffff, 0x28303234,
-	1, 0, 1, 0x00000c4c, 0xffffffff, 0x20222426,
-	1, 1, 0, 0x00000e24, 0xffffffff, 0x34363840,
-	1, 1, 0, 0x00000e28, 0xffffffff, 0x26283032,
-	1, 1, 0, 0x00000e2c, 0xffffffff, 0x32343638,
-	1, 1, 0, 0x00000e30, 0xffffffff, 0x24262830,
-	1, 1, 1, 0x00000e34, 0xffffffff, 0x32343638,
-	1, 1, 1, 0x00000e38, 0xffffffff, 0x24262830,
-	1, 1, 0, 0x00000e3c, 0xffffffff, 0x32343638,
-	1, 1, 0, 0x00000e40, 0xffffffff, 0x24262830,
-	1, 1, 0, 0x00000e44, 0xffffffff, 0x36382022,
-	1, 1, 1, 0x00000e48, 0xffffffff, 0x28303234,
-	1, 1, 1, 0x00000e4c, 0xffffffff, 0x20222426
+static const struct rtw_phy_pg_cfg_pair rtw8822b_bb_pg_type5[] = {
+	{ 0, 0, 0, 0x00000c20, 0xffffffff, 0x32343638, },
+	{ 0, 0, 0, 0x00000c24, 0xffffffff, 0x36384042, },
+	{ 0, 0, 0, 0x00000c28, 0xffffffff, 0x28303234, },
+	{ 0, 0, 0, 0x00000c2c, 0xffffffff, 0x34363840, },
+	{ 0, 0, 0, 0x00000c30, 0xffffffff, 0x26283032, },
+	{ 0, 0, 1, 0x00000c34, 0xffffffff, 0x34363840, },
+	{ 0, 0, 1, 0x00000c38, 0xffffffff, 0x26283032, },
+	{ 0, 0, 0, 0x00000c3c, 0xffffffff, 0x34363840, },
+	{ 0, 0, 0, 0x00000c40, 0xffffffff, 0x26283032, },
+	{ 0, 0, 0, 0x00000c44, 0xffffffff, 0x38402224, },
+	{ 0, 0, 1, 0x00000c48, 0xffffffff, 0x30323436, },
+	{ 0, 0, 1, 0x00000c4c, 0xffffffff, 0x22242628, },
+	{ 0, 1, 0, 0x00000e20, 0xffffffff, 0x32343638, },
+	{ 0, 1, 0, 0x00000e24, 0xffffffff, 0x36384042, },
+	{ 0, 1, 0, 0x00000e28, 0xffffffff, 0x28303234, },
+	{ 0, 1, 0, 0x00000e2c, 0xffffffff, 0x34363840, },
+	{ 0, 1, 0, 0x00000e30, 0xffffffff, 0x26283032, },
+	{ 0, 1, 1, 0x00000e34, 0xffffffff, 0x34363840, },
+	{ 0, 1, 1, 0x00000e38, 0xffffffff, 0x26283032, },
+	{ 0, 1, 0, 0x00000e3c, 0xffffffff, 0x34363840, },
+	{ 0, 1, 0, 0x00000e40, 0xffffffff, 0x26283032, },
+	{ 0, 1, 0, 0x00000e44, 0xffffffff, 0x38402224, },
+	{ 0, 1, 1, 0x00000e48, 0xffffffff, 0x30323436, },
+	{ 0, 1, 1, 0x00000e4c, 0xffffffff, 0x22242628, },
+	{ 1, 0, 0, 0x00000c24, 0xffffffff, 0x34363840, },
+	{ 1, 0, 0, 0x00000c28, 0xffffffff, 0x26283032, },
+	{ 1, 0, 0, 0x00000c2c, 0xffffffff, 0x32343638, },
+	{ 1, 0, 0, 0x00000c30, 0xffffffff, 0x24262830, },
+	{ 1, 0, 1, 0x00000c34, 0xffffffff, 0x32343638, },
+	{ 1, 0, 1, 0x00000c38, 0xffffffff, 0x24262830, },
+	{ 1, 0, 0, 0x00000c3c, 0xffffffff, 0x32343638, },
+	{ 1, 0, 0, 0x00000c40, 0xffffffff, 0x24262830, },
+	{ 1, 0, 0, 0x00000c44, 0xffffffff, 0x36382022, },
+	{ 1, 0, 1, 0x00000c48, 0xffffffff, 0x28303234, },
+	{ 1, 0, 1, 0x00000c4c, 0xffffffff, 0x20222426, },
+	{ 1, 1, 0, 0x00000e24, 0xffffffff, 0x34363840, },
+	{ 1, 1, 0, 0x00000e28, 0xffffffff, 0x26283032, },
+	{ 1, 1, 0, 0x00000e2c, 0xffffffff, 0x32343638, },
+	{ 1, 1, 0, 0x00000e30, 0xffffffff, 0x24262830, },
+	{ 1, 1, 1, 0x00000e34, 0xffffffff, 0x32343638, },
+	{ 1, 1, 1, 0x00000e38, 0xffffffff, 0x24262830, },
+	{ 1, 1, 0, 0x00000e3c, 0xffffffff, 0x32343638, },
+	{ 1, 1, 0, 0x00000e40, 0xffffffff, 0x24262830, },
+	{ 1, 1, 0, 0x00000e44, 0xffffffff, 0x36382022, },
+	{ 1, 1, 1, 0x00000e48, 0xffffffff, 0x28303234, },
+	{ 1, 1, 1, 0x00000e4c, 0xffffffff, 0x20222426, },
 };
 
 RTW_DECL_TABLE_BB_PG(rtw8822b_bb_pg_type5);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c b/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
index e2dd4c766077..d102a2c27757 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c_table.c
@@ -1762,53 +1762,53 @@ static const u32 rtw8822c_bb[] = {
 
 RTW_DECL_TABLE_PHY_COND(rtw8822c_bb, rtw_phy_cfg_bb);
 
-static const u32 rtw8822c_bb_pg_type0[] = {
-	0, 0, 0, 0x00000c20, 0xffffffff, 0x484c5054,
-	0, 0, 0, 0x00000c24, 0xffffffff, 0x54585c60,
-	0, 0, 0, 0x00000c28, 0xffffffff, 0x44484c50,
-	0, 0, 0, 0x00000c2c, 0xffffffff, 0x5054585c,
-	0, 0, 0, 0x00000c30, 0xffffffff, 0x4044484c,
-	0, 0, 1, 0x00000c34, 0xffffffff, 0x5054585c,
-	0, 0, 1, 0x00000c38, 0xffffffff, 0x4044484c,
-	0, 0, 0, 0x00000c3c, 0xffffffff, 0x5054585c,
-	0, 0, 0, 0x00000c40, 0xffffffff, 0x4044484c,
-	0, 0, 0, 0x00000c44, 0xffffffff, 0x585c383c,
-	0, 0, 1, 0x00000c48, 0xffffffff, 0x484c5054,
-	0, 0, 1, 0x00000c4c, 0xffffffff, 0x383c4044,
-	0, 1, 0, 0x00000e20, 0xffffffff, 0x484c5054,
-	0, 1, 0, 0x00000e24, 0xffffffff, 0x54585c60,
-	0, 1, 0, 0x00000e28, 0xffffffff, 0x44484c50,
-	0, 1, 0, 0x00000e2c, 0xffffffff, 0x5054585c,
-	0, 1, 0, 0x00000e30, 0xffffffff, 0x4044484c,
-	0, 1, 1, 0x00000e34, 0xffffffff, 0x5054585c,
-	0, 1, 1, 0x00000e38, 0xffffffff, 0x4044484c,
-	0, 1, 0, 0x00000e3c, 0xffffffff, 0x5054585c,
-	0, 1, 0, 0x00000e40, 0xffffffff, 0x4044484c,
-	0, 1, 0, 0x00000e44, 0xffffffff, 0x585c383c,
-	0, 1, 1, 0x00000e48, 0xffffffff, 0x484c5054,
-	0, 1, 1, 0x00000e4c, 0xffffffff, 0x383c4044,
-	1, 0, 0, 0x00000c24, 0xffffffff, 0x54585c60,
-	1, 0, 0, 0x00000c28, 0xffffffff, 0x44484c50,
-	1, 0, 0, 0x00000c2c, 0xffffffff, 0x5054585c,
-	1, 0, 0, 0x00000c30, 0xffffffff, 0x4044484c,
-	1, 0, 1, 0x00000c34, 0xffffffff, 0x5054585c,
-	1, 0, 1, 0x00000c38, 0xffffffff, 0x4044484c,
-	1, 0, 0, 0x00000c3c, 0xffffffff, 0x5054585c,
-	1, 0, 0, 0x00000c40, 0xffffffff, 0x4044484c,
-	1, 0, 0, 0x00000c44, 0xffffffff, 0x585c383c,
-	1, 0, 1, 0x00000c48, 0xffffffff, 0x484c5054,
-	1, 0, 1, 0x00000c4c, 0xffffffff, 0x383c4044,
-	1, 1, 0, 0x00000e24, 0xffffffff, 0x54585c60,
-	1, 1, 0, 0x00000e28, 0xffffffff, 0x44484c50,
-	1, 1, 0, 0x00000e2c, 0xffffffff, 0x5054585c,
-	1, 1, 0, 0x00000e30, 0xffffffff, 0x4044484c,
-	1, 1, 1, 0x00000e34, 0xffffffff, 0x5054585c,
-	1, 1, 1, 0x00000e38, 0xffffffff, 0x4044484c,
-	1, 1, 0, 0x00000e3c, 0xffffffff, 0x5054585c,
-	1, 1, 0, 0x00000e40, 0xffffffff, 0x4044484c,
-	1, 1, 0, 0x00000e44, 0xffffffff, 0x585c383c,
-	1, 1, 1, 0x00000e48, 0xffffffff, 0x484c5054,
-	1, 1, 1, 0x00000e4c, 0xffffffff, 0x383c4044
+static const struct rtw_phy_pg_cfg_pair rtw8822c_bb_pg_type0[] = {
+	{ 0, 0, 0, 0x00000c20, 0xffffffff, 0x484c5054, },
+	{ 0, 0, 0, 0x00000c24, 0xffffffff, 0x54585c60, },
+	{ 0, 0, 0, 0x00000c28, 0xffffffff, 0x44484c50, },
+	{ 0, 0, 0, 0x00000c2c, 0xffffffff, 0x5054585c, },
+	{ 0, 0, 0, 0x00000c30, 0xffffffff, 0x4044484c, },
+	{ 0, 0, 1, 0x00000c34, 0xffffffff, 0x5054585c, },
+	{ 0, 0, 1, 0x00000c38, 0xffffffff, 0x4044484c, },
+	{ 0, 0, 0, 0x00000c3c, 0xffffffff, 0x5054585c, },
+	{ 0, 0, 0, 0x00000c40, 0xffffffff, 0x4044484c, },
+	{ 0, 0, 0, 0x00000c44, 0xffffffff, 0x585c383c, },
+	{ 0, 0, 1, 0x00000c48, 0xffffffff, 0x484c5054, },
+	{ 0, 0, 1, 0x00000c4c, 0xffffffff, 0x383c4044, },
+	{ 0, 1, 0, 0x00000e20, 0xffffffff, 0x484c5054, },
+	{ 0, 1, 0, 0x00000e24, 0xffffffff, 0x54585c60, },
+	{ 0, 1, 0, 0x00000e28, 0xffffffff, 0x44484c50, },
+	{ 0, 1, 0, 0x00000e2c, 0xffffffff, 0x5054585c, },
+	{ 0, 1, 0, 0x00000e30, 0xffffffff, 0x4044484c, },
+	{ 0, 1, 1, 0x00000e34, 0xffffffff, 0x5054585c, },
+	{ 0, 1, 1, 0x00000e38, 0xffffffff, 0x4044484c, },
+	{ 0, 1, 0, 0x00000e3c, 0xffffffff, 0x5054585c, },
+	{ 0, 1, 0, 0x00000e40, 0xffffffff, 0x4044484c, },
+	{ 0, 1, 0, 0x00000e44, 0xffffffff, 0x585c383c, },
+	{ 0, 1, 1, 0x00000e48, 0xffffffff, 0x484c5054, },
+	{ 0, 1, 1, 0x00000e4c, 0xffffffff, 0x383c4044, },
+	{ 1, 0, 0, 0x00000c24, 0xffffffff, 0x54585c60, },
+	{ 1, 0, 0, 0x00000c28, 0xffffffff, 0x44484c50, },
+	{ 1, 0, 0, 0x00000c2c, 0xffffffff, 0x5054585c, },
+	{ 1, 0, 0, 0x00000c30, 0xffffffff, 0x4044484c, },
+	{ 1, 0, 1, 0x00000c34, 0xffffffff, 0x5054585c, },
+	{ 1, 0, 1, 0x00000c38, 0xffffffff, 0x4044484c, },
+	{ 1, 0, 0, 0x00000c3c, 0xffffffff, 0x5054585c, },
+	{ 1, 0, 0, 0x00000c40, 0xffffffff, 0x4044484c, },
+	{ 1, 0, 0, 0x00000c44, 0xffffffff, 0x585c383c, },
+	{ 1, 0, 1, 0x00000c48, 0xffffffff, 0x484c5054, },
+	{ 1, 0, 1, 0x00000c4c, 0xffffffff, 0x383c4044, },
+	{ 1, 1, 0, 0x00000e24, 0xffffffff, 0x54585c60, },
+	{ 1, 1, 0, 0x00000e28, 0xffffffff, 0x44484c50, },
+	{ 1, 1, 0, 0x00000e2c, 0xffffffff, 0x5054585c, },
+	{ 1, 1, 0, 0x00000e30, 0xffffffff, 0x4044484c, },
+	{ 1, 1, 1, 0x00000e34, 0xffffffff, 0x5054585c, },
+	{ 1, 1, 1, 0x00000e38, 0xffffffff, 0x4044484c, },
+	{ 1, 1, 0, 0x00000e3c, 0xffffffff, 0x5054585c, },
+	{ 1, 1, 0, 0x00000e40, 0xffffffff, 0x4044484c, },
+	{ 1, 1, 0, 0x00000e44, 0xffffffff, 0x585c383c, },
+	{ 1, 1, 1, 0x00000e48, 0xffffffff, 0x484c5054, },
+	{ 1, 1, 1, 0x00000e4c, 0xffffffff, 0x383c4044, },
 };
 
 RTW_DECL_TABLE_BB_PG(rtw8822c_bb_pg_type0);
-- 
2.17.1

