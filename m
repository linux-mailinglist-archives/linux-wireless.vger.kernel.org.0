Return-Path: <linux-wireless+bounces-17624-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C095A14A20
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80DAA1884F70
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8542B1F63CF;
	Fri, 17 Jan 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QgO8UW7X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD51F7917
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098945; cv=none; b=H8pI60bR4jhYDjXW0eCr2eTSxFnCiDo1ezSUThUv4g78P1U9Z8uhhvq6gq5WQq/B2hjnC647vUczWGNaM2XqqTyJop9lJdqNFjg+OPxjXmqb04T9w9CoYSiKDvOTkoq/94OCL5arrQvHy84DoM+9zT6ijGNWFHo6Bm4jRz+Y1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098945; c=relaxed/simple;
	bh=cz6Zk+MZfgqE42bc/NGTn7u6XQJ9nf55168V2WuxmhQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NOD/STE/AzEI3Bn3sF3DDn3myLcKvV3wj9jhFzABqXvqjWctw26yRm0KWRJoIpHJM0euudx1iUfuhr65TA4y0W2Id9RHkxUbNPsnXJVryorL3ljv/4GeVVyQlxs165Z+3yyP1akdv1gtMd9iqAhJotoJPyY0aPYi+yMX3ickxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QgO8UW7X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7SxfcE2337745, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098939; bh=cz6Zk+MZfgqE42bc/NGTn7u6XQJ9nf55168V2WuxmhQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=QgO8UW7X0ghKHWxyZhz/lNdkcb5mIKnKBs1SzJOscXuPlono0a1ssSnwJ0G2WEsZa
	 AgGiEXvWndg15NIBRPhEKbJ0IKaZiM94bQxTxGPO+T/rlsTh7kyey3sj1zEZOcHiFo
	 un1qoYGlYffmtOiIxvgx6TjK86zDIA60cLLzt/GjBIkEnbQlyk7QvMe2N5V5svJW7V
	 3PRRUqQ8k0b+HGwRTHZjInyrw0SG6f7Tjj16fI8RvcebI3ZzuLqzse1paQGad94S8U
	 DUTATuBpsQnp0FyK8MIcMjHRYYSPc0TkVix7L+9Te4w+bVCnJqRJtwVk07XvAkdeX8
	 eMYuxWgk+xv5g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7SxfcE2337745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:28:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:28:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:28:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: phy: rename to RTW89_PHY_NUM as proper naming
Date: Fri, 17 Jan 2025 15:28:21 +0800
Message-ID: <20250117072828.16728-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

The meaning is number of PHY, not maximum ID of PHY. Change to proper
naming.

No change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c   | 38 ++++++++++-----------
 drivers/net/wireless/realtek/rtw89/core.c   |  4 +--
 drivers/net/wireless/realtek/rtw89/core.h   | 36 +++++++++----------
 drivers/net/wireless/realtek/rtw89/fw.h     | 14 ++++----
 drivers/net/wireless/realtek/rtw89/mac.c    |  2 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c |  2 +-
 6 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 68316d44b204..b380871f148d 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1602,7 +1602,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw = le32_to_cpu(prpt->v4.wl_fw_info.fw_ver);
 			dm->wl_fw_cx_offload = !!le32_to_cpu(prpt->v4.wl_fw_info.cx_offload);
 
-			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
 				memcpy(&dm->gnt.band[i], &prpt->v4.gnt_val[i],
 				       sizeof(dm->gnt.band[i]));
 
@@ -1634,7 +1634,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw = le32_to_cpu(prpt->v5.rpt_info.fw_ver);
 			dm->wl_fw_cx_offload = 0;
 
-			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
 				memcpy(&dm->gnt.band[i], &prpt->v5.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
@@ -1661,7 +1661,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw = le32_to_cpu(prpt->v105.rpt_info.fw_ver);
 			dm->wl_fw_cx_offload = 0;
 
-			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
 				memcpy(&dm->gnt.band[i], &prpt->v105.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
@@ -1687,7 +1687,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw_coex = le32_to_cpu(prpt->v7.rpt_info.cx_ver);
 			wl->ver_info.fw = le32_to_cpu(prpt->v7.rpt_info.fw_ver);
 
-			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
 				memcpy(&dm->gnt.band[i], &prpt->v7.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
@@ -1719,7 +1719,7 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw_coex = le32_to_cpu(prpt->v8.rpt_info.cx_ver);
 			wl->ver_info.fw = le32_to_cpu(prpt->v8.rpt_info.fw_ver);
 
-			for (i = RTW89_PHY_0; i < RTW89_PHY_MAX; i++)
+			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
 				memcpy(&dm->gnt.band[i], &prpt->v8.gnt_val[i][0],
 				       sizeof(dm->gnt.band[i]));
 
@@ -2706,7 +2706,7 @@ static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map, u8 wl_state, u8 bt_st
 	if (phy_map > BTC_PHY_ALL)
 		return;
 
-	for (i = 0; i < RTW89_PHY_MAX; i++) {
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
 		if (!(phy_map & BIT(i)))
 			continue;
 
@@ -2755,7 +2755,7 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 	if (phy_map > BTC_PHY_ALL)
 		return;
 
-	for (i = 0; i < RTW89_PHY_MAX; i++) {
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
 		if (!(phy_map & BIT(i)))
 			continue;
 
@@ -2955,7 +2955,7 @@ static void _set_rf_trx_para(struct rtw89_dev *rtwdev)
 
 	if (ver->fwlrole == 0) {
 		link_mode = wl->role_info.link_mode;
-		for (i = 0; i < RTW89_PHY_MAX; i++) {
+		for (i = 0; i < RTW89_PHY_NUM; i++) {
 			if (wl->dbcc_info.real_band[i] == RTW89_BAND_2G)
 				dbcc_2g_phy = i;
 		}
@@ -4240,7 +4240,7 @@ static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
 	case BTC_ANT_W2G:
 		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
 		if (rtwdev->dbcc_en) {
-			for (i = 0; i < RTW89_PHY_MAX; i++) {
+			for (i = 0; i < RTW89_PHY_NUM; i++) {
 				b2g = (wl_dinfo->real_band[i] == RTW89_BAND_2G);
 
 				gnt_wl_ctrl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
@@ -4905,9 +4905,9 @@ static void _set_btg_ctrl(struct rtw89_dev *rtwdev)
 
 	if (rtwdev->dbcc_en) {
 		if (ver->fwlrole == 0) {
-			wl_rinfo.dbcc_2g_phy = RTW89_PHY_MAX;
+			wl_rinfo.dbcc_2g_phy = RTW89_PHY_NUM;
 
-			for (i = 0; i < RTW89_PHY_MAX; i++) {
+			for (i = 0; i < RTW89_PHY_NUM; i++) {
 				if (wl_dinfo->real_band[i] == RTW89_BAND_2G)
 					wl_rinfo.dbcc_2g_phy = i;
 			}
@@ -5798,7 +5798,7 @@ static void _update_wl_info(struct rtw89_dev *rtwdev)
 		phy = wl_linfo[i].phy;
 
 		/* check dbcc role */
-		if (rtwdev->dbcc_en && phy < RTW89_PHY_MAX) {
+		if (rtwdev->dbcc_en && phy < RTW89_PHY_NUM) {
 			wl_dinfo->role[phy] = wl_linfo[i].role;
 			wl_dinfo->op_band[phy] = wl_linfo[i].band;
 			_update_dbcc_band(rtwdev, phy);
@@ -5948,7 +5948,7 @@ static void _update_wl_info_v1(struct rtw89_dev *rtwdev)
 
 		phy = wl_linfo[i].phy;
 
-		if (rtwdev->dbcc_en && phy < RTW89_PHY_MAX) {
+		if (rtwdev->dbcc_en && phy < RTW89_PHY_NUM) {
 			wl_dinfo->role[phy] = wl_linfo[i].role;
 			wl_dinfo->op_band[phy] = wl_linfo[i].band;
 			_update_dbcc_band(rtwdev, phy);
@@ -6098,7 +6098,7 @@ static void _update_wl_info_v2(struct rtw89_dev *rtwdev)
 
 		phy = wl_linfo[i].phy;
 
-		if (rtwdev->dbcc_en && phy < RTW89_PHY_MAX) {
+		if (rtwdev->dbcc_en && phy < RTW89_PHY_NUM) {
 			wl_dinfo->role[phy] = wl_linfo[i].role;
 			wl_dinfo->op_band[phy] = wl_linfo[i].band;
 			_update_dbcc_band(rtwdev, phy);
@@ -6389,7 +6389,7 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	struct rtw89_btc_wl_link_info *wl_linfo = wl->link_info;
 	struct rtw89_btc_wl_active_role_v7 *act_role = NULL;
-	u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_MAX, phy_dbcc;
+	u8 i, mode, cnt = 0, cnt_2g = 0, cnt_5g = 0, phy_now = RTW89_PHY_NUM, phy_dbcc;
 	bool b2g = false, b5g = false, client_joined = false, client_inc_2g = false;
 	u8 client_cnt_last[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
 	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
@@ -6400,7 +6400,7 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 	memset(wl_rinfo, 0, sizeof(*wl_rinfo));
 
 	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		if (!wl_linfo[i].active || wl_linfo[i].phy >= RTW89_PHY_MAX)
+		if (!wl_linfo[i].active || wl_linfo[i].phy >= RTW89_PHY_NUM)
 			continue;
 
 		act_role = &wl_rinfo->active_role[i];
@@ -6494,7 +6494,7 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, &dbcc_2g_phy);
 
 		/* correct 2G-located PHY band for gnt ctrl */
-		if (dbcc_2g_phy < RTW89_PHY_MAX)
+		if (dbcc_2g_phy < RTW89_PHY_NUM)
 			wl_dinfo->op_band[dbcc_2g_phy] = RTW89_BAND_2G;
 	} else if (b2g && b5g && cnt == 2) {
 		mode = BTC_WLINK_25G_MCC;
@@ -7187,7 +7187,7 @@ void rtw89_btc_ntfy_scan_start(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 		    "[BTC], %s(): phy_idx=%d, band=%d\n",
 		    __func__, phy_idx, band);
 
-	if (phy_idx >= RTW89_PHY_MAX)
+	if (phy_idx >= RTW89_PHY_NUM)
 		return;
 
 	btc->dm.cnt_notify[BTC_NCNT_SCAN_START]++;
@@ -7235,7 +7235,7 @@ void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band)
 		    "[BTC], %s(): phy_idx=%d, band=%d\n",
 		    __func__, phy_idx, band);
 
-	if (phy_idx >= RTW89_PHY_MAX)
+	if (phy_idx >= RTW89_PHY_NUM)
 		return;
 
 	btc->dm.cnt_notify[BTC_NCNT_SWITCH_BAND]++;
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 85f739f1173d..b7987c6b1cd5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4432,9 +4432,9 @@ static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
 {
 	int i;
 
-	for (i = 0; i < RTW89_PHY_MAX; i++)
+	for (i = 0; i < RTW89_PHY_NUM; i++)
 		skb_queue_head_init(&rtwdev->ppdu_sts.rx_queue[i]);
-	for (i = 0; i < RTW89_PHY_MAX; i++)
+	for (i = 0; i < RTW89_PHY_NUM; i++)
 		rtwdev->ppdu_sts.curr_rx_ppdu_cnt[i] = U8_MAX;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ff4894c7fa8a..2e04d0eb9405 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -826,7 +826,7 @@ enum rtw89_mac_idx {
 enum rtw89_phy_idx {
 	RTW89_PHY_0 = 0,
 	RTW89_PHY_1 = 1,
-	RTW89_PHY_MAX
+	RTW89_PHY_NUM,
 };
 
 #define __RTW89_MLD_MAX_LINK_NUM 2
@@ -1540,16 +1540,16 @@ struct rtw89_btc_u8_sta_chg {
 };
 
 struct rtw89_btc_wl_scan_info {
-	u8 band[RTW89_PHY_MAX];
+	u8 band[RTW89_PHY_NUM];
 	u8 phy_map;
 	u8 rsvd;
 };
 
 struct rtw89_btc_wl_dbcc_info {
-	u8 op_band[RTW89_PHY_MAX]; /* op band in each phy */
-	u8 scan_band[RTW89_PHY_MAX]; /* scan band in  each phy */
-	u8 real_band[RTW89_PHY_MAX];
-	u8 role[RTW89_PHY_MAX]; /* role in each phy */
+	u8 op_band[RTW89_PHY_NUM]; /* op band in each phy */
+	u8 scan_band[RTW89_PHY_NUM]; /* scan band in  each phy */
+	u8 real_band[RTW89_PHY_NUM];
+	u8 role[RTW89_PHY_NUM]; /* role in each phy */
 };
 
 struct rtw89_btc_wl_active_role {
@@ -1898,7 +1898,7 @@ struct rtw89_btc_wl_info {
 	u8 cn_report;
 	u8 coex_mode;
 	u8 pta_req_mac;
-	u8 bt_polut_type[RTW89_PHY_MAX]; /* BT polluted WL-Tx type for phy0/1  */
+	u8 bt_polut_type[RTW89_PHY_NUM]; /* BT polluted WL-Tx type for phy0/1  */
 
 	bool is_5g_hi_channel;
 	bool pta_reg_mac_chg;
@@ -2230,7 +2230,7 @@ struct rtw89_btc_fbtc_rpt_ctrl_v4 {
 	struct rtw89_btc_fbtc_rpt_ctrl_wl_fw_info wl_fw_info;
 	struct rtw89_btc_fbtc_rpt_ctrl_bt_mailbox bt_mbx_info;
 	__le32 bt_cnt[BTC_BCNT_STA_MAX];
-	struct rtw89_mac_ax_gnt gnt_val[RTW89_PHY_MAX];
+	struct rtw89_mac_ax_gnt gnt_val[RTW89_PHY_NUM];
 } __packed;
 
 struct rtw89_btc_fbtc_rpt_ctrl_v5 {
@@ -2238,7 +2238,7 @@ struct rtw89_btc_fbtc_rpt_ctrl_v5 {
 	u8 rsvd;
 	__le16 rsvd1;
 
-	u8 gnt_val[RTW89_PHY_MAX][4];
+	u8 gnt_val[RTW89_PHY_NUM][4];
 	__le16 bt_cnt[BTC_BCNT_STA_MAX];
 
 	struct rtw89_btc_fbtc_rpt_ctrl_info_v5 rpt_info;
@@ -2250,7 +2250,7 @@ struct rtw89_btc_fbtc_rpt_ctrl_v105 {
 	u8 rsvd;
 	__le16 rsvd1;
 
-	u8 gnt_val[RTW89_PHY_MAX][4];
+	u8 gnt_val[RTW89_PHY_NUM][4];
 	__le16 bt_cnt[BTC_BCNT_STA_MAX_V105];
 
 	struct rtw89_btc_fbtc_rpt_ctrl_info_v5 rpt_info;
@@ -2263,7 +2263,7 @@ struct rtw89_btc_fbtc_rpt_ctrl_v7 {
 	u8 rsvd1;
 	u8 rsvd2;
 
-	u8 gnt_val[RTW89_PHY_MAX][4];
+	u8 gnt_val[RTW89_PHY_NUM][4];
 	__le16 bt_cnt[BTC_BCNT_STA_MAX_V105];
 
 	struct rtw89_btc_fbtc_rpt_ctrl_info_v8 rpt_info;
@@ -2276,7 +2276,7 @@ struct rtw89_btc_fbtc_rpt_ctrl_v8 {
 	u8 rpt_len_max_l; /* BTC_RPT_MAX bit0~7 */
 	u8 rpt_len_max_h; /* BTC_RPT_MAX bit8~15 */
 
-	u8 gnt_val[RTW89_PHY_MAX][4];
+	u8 gnt_val[RTW89_PHY_NUM][4];
 	__le16 bt_cnt[BTC_BCNT_STA_MAX_V105];
 
 	struct rtw89_btc_fbtc_rpt_ctrl_info_v8 rpt_info;
@@ -4762,7 +4762,7 @@ struct rtw89_hal {
 	struct rtw89_chanctx chanctx[NUM_OF_RTW89_CHANCTX];
 	struct cfg80211_chan_def roc_chandef;
 
-	bool entity_active[RTW89_PHY_MAX];
+	bool entity_active[RTW89_PHY_NUM];
 	bool entity_pause;
 	enum rtw89_entity_mode entity_mode;
 	struct rtw89_entity_mgnt entity_mgnt;
@@ -4973,7 +4973,7 @@ struct rtw89_dpk_bkup_para {
 struct rtw89_dpk_info {
 	bool is_dpk_enable;
 	bool is_dpk_reload_en;
-	u8 dpk_gs[RTW89_PHY_MAX];
+	u8 dpk_gs[RTW89_PHY_NUM];
 	u16 dc_i[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
 	u16 dc_q[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
 	u8 corr_val[RTW89_DPK_RF_PATH][RTW89_DPK_BKUP_NUM];
@@ -5299,8 +5299,8 @@ struct rtw89_lps_parm {
 };
 
 struct rtw89_ppdu_sts_info {
-	struct sk_buff_head rx_queue[RTW89_PHY_MAX];
-	u8 curr_rx_ppdu_cnt[RTW89_PHY_MAX];
+	struct sk_buff_head rx_queue[RTW89_PHY_NUM];
+	u8 curr_rx_ppdu_cnt[RTW89_PHY_NUM];
 };
 
 struct rtw89_early_h2c {
@@ -5419,8 +5419,8 @@ struct rtw89_phy_efuse_gain {
 	bool offset_valid;
 	bool comp_valid;
 	s8 offset[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
-	s8 offset_base[RTW89_PHY_MAX]; /* S(8, 4) */
-	s8 rssi_base[RTW89_PHY_MAX]; /* S(8, 4) */
+	s8 offset_base[RTW89_PHY_NUM]; /* S(8, 4) */
+	s8 rssi_base[RTW89_PHY_NUM]; /* S(8, 4) */
 	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2026bc2fd2ac..3cc514de073a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1803,14 +1803,14 @@ struct rtw89_h2c_lps_ml_cmn_info {
 	u8 fmt_id;
 	u8 rsvd0[3];
 	__le32 mlo_dbcc_mode;
-	u8 central_ch[RTW89_PHY_MAX];
-	u8 pri_ch[RTW89_PHY_MAX];
-	u8 bw[RTW89_PHY_MAX];
-	u8 band[RTW89_PHY_MAX];
-	u8 bcn_rate_type[RTW89_PHY_MAX];
+	u8 central_ch[RTW89_PHY_NUM];
+	u8 pri_ch[RTW89_PHY_NUM];
+	u8 bw[RTW89_PHY_NUM];
+	u8 band[RTW89_PHY_NUM];
+	u8 bcn_rate_type[RTW89_PHY_NUM];
 	u8 rsvd1[2];
-	__le16 tia_gain[RTW89_PHY_MAX][TIA_GAIN_NUM];
-	u8 lna_gain[RTW89_PHY_MAX][LNA_GAIN_NUM];
+	__le16 tia_gain[RTW89_PHY_NUM][TIA_GAIN_NUM];
+	u8 lna_gain[RTW89_PHY_NUM][LNA_GAIN_NUM];
 	u8 rsvd2[2];
 } __packed;
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a37c6d525d6f..f698807790ff 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6031,7 +6031,7 @@ int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl)
 	if (wl)
 		return 0;
 
-	for (i = 0; i < RTW89_PHY_MAX; i++) {
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
 		g[i].gnt_bt_sw_en = 1;
 		g[i].gnt_bt = 1;
 		g[i].gnt_wl_sw_en = 1;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 2dbdeae904ad..16ee378c5418 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1865,7 +1865,7 @@ int rtw89_mac_cfg_ctrl_path_v2(struct rtw89_dev *rtwdev, bool wl)
 	if (wl)
 		return 0;
 
-	for (i = 0; i < RTW89_PHY_MAX; i++) {
+	for (i = 0; i < RTW89_PHY_NUM; i++) {
 		g[i].gnt_bt_sw_en = 1;
 		g[i].gnt_bt = 1;
 		g[i].gnt_wl_sw_en = 1;
-- 
2.25.1


