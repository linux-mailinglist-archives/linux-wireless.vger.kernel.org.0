Return-Path: <linux-wireless+bounces-23948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D50B6AD47F0
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091047AC50E
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 01:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3951742AA4;
	Wed, 11 Jun 2025 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NQWLNoib"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B081ACA
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 01:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605754; cv=none; b=PXGULcEUrysRPeg0Wt2q4dKhHMLlMNbUKHPWXvg1bd8ciud6QveUedlV+AZQlc/mRqdRXwFM4bfpUJd7E4k00eaThUQEBRNKGmVRNcyqTDEWyG+uPxIft1tRrAeRCu2dVgVIfS9Ut5gw6/FY5fFdNIe8QL1xs90Umzcn/SHbSv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605754; c=relaxed/simple;
	bh=+RQxZreEp9jeV4u58Z+EPFmIkeyh4m7hcFzu0SVwNg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzCq61jlkI5UbKx8Ra1EHBL9cR9uw32cabuC7y6psautVG2/FmEZ7+Z8VAxU6VV+JkXKlULrvB9HSVOMlw/AxD5yNxjyMPUpRLsqSGHbH0XkIf+O05QdFXfaby+AIDw7c5YDCNG8fg9zpB8t6N/3qeiUJ/ty058BYy+RUAKI2aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NQWLNoib; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B1Zn4tA3937531, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749605749; bh=zpp1sGRouP9Y1NuDu8214lmurFHUECM/PK9YroyQGVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=NQWLNoibdcJhpYI4fipM0sXg8wFG4eB2qz7rP3OgwGp9mr652aG6t+z2Q05jpR5XL
	 VmY75KsNAY1s3cKYDMAQVNbeZyuTHg1va2I3cF6Mw/6ElWmDwfxjuGFwFhK2JiJINi
	 buksRZk5FpNqWgAGLWUqWG2UEfBE0G7apK+Mto49yew321mTA7Viz0aWDpIwIJnXT4
	 8X4/bLcR7gJmQSkauHsgDnDP0s72dtZM9B4Ug6G8ghkcGITqLaC3A8PgO65JkXtkYj
	 WTs4o6Ow5BhI6+bo9dvanUO3GnefZrj00LehoTngvUhLWETwCOMMsr2HLcAwKPaheB
	 oQF90fvCUjtQw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B1Zn4tA3937531
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:35:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 09:35:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 09:35:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 03/10] wifi: rtw89: coex: Implement Wi-Fi MLO related logic
Date: Wed, 11 Jun 2025 09:35:03 +0800
Message-ID: <20250611013510.15519-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611013510.15519-1-pkshih@realtek.com>
References: <20250611013510.15519-1-pkshih@realtek.com>
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

From: Ching-Te Ku <ku920601@realtek.com>

To make the logic can work well with WiFi 7 & before generations,
extend & add logic for WiFi 7.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 620 +++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/coex.h |   7 +
 drivers/net/wireless/realtek/rtw89/core.h |  30 ++
 3 files changed, 476 insertions(+), 181 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 2b23febc6f26..73801c84ec6f 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2020  Realtek Corporation
  */
 
+#include "chan.h"
 #include "coex.h"
 #include "debug.h"
 #include "fw.h"
@@ -676,6 +677,27 @@ enum btc_wl_link_mode {
 	BTC_WLINK_MAX
 };
 
+#define CASE_BTC_WL_LINK_MODE(e) case BTC_WLINK_## e: return #e
+
+static const char *id_to_linkmode(u8 id)
+{
+	switch (id) {
+	CASE_BTC_WL_LINK_MODE(NOLINK);
+	CASE_BTC_WL_LINK_MODE(2G_STA);
+	CASE_BTC_WL_LINK_MODE(2G_AP);
+	CASE_BTC_WL_LINK_MODE(2G_GO);
+	CASE_BTC_WL_LINK_MODE(2G_GC);
+	CASE_BTC_WL_LINK_MODE(2G_SCC);
+	CASE_BTC_WL_LINK_MODE(2G_MCC);
+	CASE_BTC_WL_LINK_MODE(25G_MCC);
+	CASE_BTC_WL_LINK_MODE(25G_DBCC);
+	CASE_BTC_WL_LINK_MODE(5G);
+	CASE_BTC_WL_LINK_MODE(OTHER);
+	default:
+		return "unknown";
+	}
+}
+
 enum btc_wl_mrole_type {
 	BTC_WLMROLE_NONE = 0x0,
 	BTC_WLMROLE_STA_GC,
@@ -6247,23 +6269,16 @@ static bool _chk_role_ch_group(const struct rtw89_btc_chdef *r1,
 }
 
 static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
-		    u8 *phy, u8 *role, u8 *dbcc_2g_phy)
+		    u8 *phy, u8 *role, u8 link_cnt)
 {
 	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
 	struct rtw89_btc_wl_role_info_v7 *rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *rinfo_v8 = &wl->role_info_v8;
 	bool is_2g_ch_exist = false, is_multi_role_in_2g_phy = false;
-	u8 j, k, dbcc_2g_cid, dbcc_2g_cid2, connect_cnt;
-
-	if (rtwdev->btc.ver->fwlrole == 7)
-		connect_cnt = rinfo_v7->connect_cnt;
-	else if (rtwdev->btc.ver->fwlrole == 8)
-		connect_cnt = rinfo_v8->connect_cnt;
-	else
-		return BTC_WLINK_NOLINK;
+	u8 j, k, dbcc_2g_cid, dbcc_2g_cid2, dbcc_2g_phy, pta_req_band;
 
 	/* find out the 2G-PHY by connect-id ->ch  */
-	for (j = 0; j < connect_cnt; j++) {
+	for (j = 0; j < link_cnt; j++) {
 		if (ch[j].center_ch <= 14) {
 			is_2g_ch_exist = true;
 			break;
@@ -6272,21 +6287,33 @@ static u8 _chk_dbcc(struct rtw89_dev *rtwdev, struct rtw89_btc_chdef *ch,
 
 	/* If no any 2G-port exist, it's impossible because 5G-exclude */
 	if (!is_2g_ch_exist)
-		return BTC_WLINK_OTHER;
+		return BTC_WLINK_5G;
 
 	dbcc_2g_cid = j;
-	*dbcc_2g_phy = phy[dbcc_2g_cid];
+	dbcc_2g_phy = phy[dbcc_2g_cid];
+
+	if (dbcc_2g_phy == RTW89_PHY_1)
+		pta_req_band = RTW89_PHY_1;
+	else
+		pta_req_band = RTW89_PHY_0;
+
+	if (rtwdev->btc.ver->fwlrole == 7) {
+		rinfo_v7->dbcc_2g_phy = dbcc_2g_phy;
+	} else if (rtwdev->btc.ver->fwlrole == 8) {
+		rinfo_v8->dbcc_2g_phy = dbcc_2g_phy;
+		rinfo_v8->pta_req_band = pta_req_band;
+	}
 
 	/* connect_cnt <= 2 */
-	if (connect_cnt < BTC_TDMA_WLROLE_MAX)
+	if (link_cnt < BTC_TDMA_WLROLE_MAX)
 		return (_get_role_link_mode((role[dbcc_2g_cid])));
 
 	/* find the other-port in the 2G-PHY, ex: PHY-0:6G, PHY1: mcc/scc */
-	for (k = 0; k < connect_cnt; k++) {
+	for (k = 0; k < link_cnt; k++) {
 		if (k == dbcc_2g_cid)
 			continue;
 
-		if (phy[k] == *dbcc_2g_phy) {
+		if (phy[k] == dbcc_2g_phy) {
 			is_multi_role_in_2g_phy = true;
 			dbcc_2g_cid2 = k;
 			break;
@@ -6488,7 +6515,7 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 	} else if (cnt > BTC_TDMA_WLROLE_MAX) {
 		mode = BTC_WLINK_OTHER;
 	} else if (rtwdev->dbcc_en) {
-		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, &dbcc_2g_phy);
+		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, cnt);
 
 		/* correct 2G-located PHY band for gnt ctrl */
 		if (dbcc_2g_phy < RTW89_PHY_NUM)
@@ -6533,26 +6560,333 @@ static void _update_wl_info_v7(struct rtw89_dev *rtwdev, u8 rid)
 	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
 }
 
+static u8 _update_wl_link_mode(struct rtw89_dev *rtwdev, u8 hw_band, u8 type)
+{
+	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
+	struct rtw89_btc_wl_mlo_info *mlo_info = &wl->mlo_info;
+	u8 mode = BTC_WLINK_NOLINK;
+
+	switch (type) {
+	case RTW89_MR_WTYPE_NONE: /* no-link */
+		mode = BTC_WLINK_NOLINK;
+		break;
+	case RTW89_MR_WTYPE_NONMLD:  /* Non_MLO 1-role 2+0/0+2 */
+	case RTW89_MR_WTYPE_MLD1L1R: /* MLO only-1 link 2+0/0+2 */
+		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G) {
+			mode = BTC_WLINK_5G;
+		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1AP) {
+			mode = BTC_WLINK_2G_GO;
+		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1CLIENT) {
+			if (wl->role_info_v8.p2p_2g)
+				mode = BTC_WLINK_2G_GC;
+			else
+				mode = BTC_WLINK_2G_STA;
+		}
+		break;
+	case RTW89_MR_WTYPE_NONMLD_NONMLD: /* Non_MLO 2-role 2+0/0+2 */
+	case RTW89_MR_WTYPE_MLD1L1R_NONMLD: /* MLO only-1 link + P2P 2+0/0+2 */
+		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G) {
+			mode = BTC_WLINK_5G;
+		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ_5GHZ ||
+			   mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ_6GHZ) {
+			mode = BTC_WLINK_25G_MCC;
+		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX2_2GHZ) {
+			mode = BTC_WLINK_2G_MCC;
+		} else if (mlo_info->ch_type[hw_band] == RTW89_MR_CTX1_2GHZ) {
+			mode = BTC_WLINK_2G_SCC;
+		}
+		break;
+	case RTW89_MR_WTYPE_MLD2L1R: /* MLO_MLSR 2+0/0+2 */
+		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G)
+			mode = BTC_WLINK_5G;
+		else if (wl->role_info_v8.p2p_2g)
+			mode = BTC_WLINK_2G_GC;
+		else
+			mode = BTC_WLINK_2G_STA;
+		break;
+	case RTW89_MR_WTYPE_MLD2L1R_NONMLD: /* MLO_MLSR + P2P 2+0/0+2 */
+	case RTW89_MR_WTYPE_MLD2L2R_NONMLD: /* MLO_MLMR + P2P 1+1/2+2 */
+		/* driver may doze 1-link to
+		 * 2G+5G   -> TDMA slot switch by E2G/E5G
+		 * 5G only -> TDMA slot switch by E5G
+		 */
+		mode = BTC_WLINK_25G_MCC;
+		break;
+	case RTW89_MR_WTYPE_MLD2L2R: /* MLO_MLMR  1+1/2+2 */
+		if (mlo_info->hwb_rf_band[hw_band] != RTW89_BAND_2G) {
+			mode = BTC_WLINK_5G;
+		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1AP) {
+			mode = BTC_WLINK_2G_GO;
+		} else if (mlo_info->wmode[hw_band] == RTW89_MR_WMODE_1CLIENT) {
+			if (wl->role_info_v8.p2p_2g)
+				mode = BTC_WLINK_2G_GC;
+			else
+				mode = BTC_WLINK_2G_STA;
+		}
+		break;
+	}
+	return mode;
+}
+
+static void _update_wl_mlo_info(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_wl_mlo_info *mlo_info = &wl->mlo_info;
+	struct rtw89_mr_chanctx_info qinfo;
+	u8 track_band = RTW89_PHY_0;
+	u8 rf_band = RTW89_BAND_2G;
+	u8 i, type;
+
+	/* parse MLO info form PHL API for each HW-band */
+	for (i = RTW89_MAC_0; i <= RTW89_MAC_1; i++) {
+		memset(&qinfo, 0, sizeof(qinfo));
+
+		rtw89_query_mr_chanctx_info(rtwdev, i, &qinfo);
+		mlo_info->wmode[i] = qinfo.wmode;
+		mlo_info->ch_type[i] = qinfo.ctxtype;
+		mlo_info->wtype = qinfo.wtype;
+
+		if (mlo_info->ch_type[i] == RTW89_MR_CTX1_5GHZ ||
+		    mlo_info->ch_type[i] == RTW89_MR_CTX2_5GHZ ||
+		    mlo_info->ch_type[i] == RTW89_MR_CTX2_5GHZ_6GHZ)
+			mlo_info->hwb_rf_band[i] = RTW89_BAND_5G;
+		else if (mlo_info->ch_type[i] == RTW89_MR_CTX1_6GHZ ||
+			 mlo_info->ch_type[i] == RTW89_MR_CTX2_6GHZ)
+			mlo_info->hwb_rf_band[i] = RTW89_BAND_6G;
+		else /* check if "2G-included" or unknown in each HW-band */
+			mlo_info->hwb_rf_band[i] = RTW89_BAND_2G;
+	}
+
+	mlo_info->link_status = rtwdev->mlo_dbcc_mode;
+	type = mlo_info->wtype;
+
+	if (mlo_info->wtype == RTW89_MR_WTYPE_MLD1L1R ||
+	    mlo_info->wtype == RTW89_MR_WTYPE_MLD2L1R ||
+	    mlo_info->wtype == RTW89_MR_WTYPE_MLD2L2R ||
+	    mlo_info->wtype == RTW89_MR_WTYPE_MLD1L1R_NONMLD ||
+	    mlo_info->wtype == RTW89_MR_WTYPE_MLD2L1R_NONMLD ||
+	    mlo_info->wtype == RTW89_MR_WTYPE_MLD2L2R_NONMLD)
+		mlo_info->mlo_en = 1;
+	else
+		mlo_info->mlo_en = 0;
+
+	if (mlo_info->ch_type[RTW89_MAC_0] != RTW89_MR_CTX_NONE &&
+	    mlo_info->ch_type[RTW89_MAC_0] != RTW89_MR_CTX_UNKNOWN &&
+	    mlo_info->ch_type[RTW89_MAC_1] != RTW89_MR_CTX_NONE &&
+	    mlo_info->ch_type[RTW89_MAC_1] != RTW89_MR_CTX_UNKNOWN)
+		mlo_info->dual_hw_band_en = 1; /* two HW-hand link exist */
+	else
+		mlo_info->dual_hw_band_en = 0;
+
+	if (mlo_info->link_status == MLO_2_PLUS_0_2RF ||
+	    mlo_info->link_status == MLO_0_PLUS_2_2RF ||
+	    mlo_info->link_status == MLO_2_PLUS_2_2RF)
+		mlo_info->mlo_adie = 2;
+	else
+		mlo_info->mlo_adie = 1;
+
+	switch (mlo_info->link_status) {
+	default:
+	case MLO_2_PLUS_0_1RF: /* 2+0 */
+	case MLO_2_PLUS_0_2RF:
+		mlo_info->rf_combination = BTC_MLO_RF_2_PLUS_0;
+		track_band = RTW89_MAC_0;
+		rf_band = mlo_info->hwb_rf_band[RTW89_MAC_0];
+		mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
+		mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
+
+		wl_rinfo->pta_req_band = RTW89_MAC_0;
+		wl_rinfo->dbcc_2g_phy = RTW89_PHY_0;
+		wl_rinfo->dbcc_en = 0;
+		break;
+	case MLO_0_PLUS_2_1RF: /* 0+2 */
+	case MLO_0_PLUS_2_2RF:
+		mlo_info->rf_combination = BTC_MLO_RF_0_PLUS_2;
+		track_band = RTW89_MAC_1;
+		rf_band = mlo_info->hwb_rf_band[RTW89_MAC_1];
+		mlo_info->path_rf_band[BTC_RF_S0] = rf_band;
+		mlo_info->path_rf_band[BTC_RF_S1] = rf_band;
+
+		wl_rinfo->pta_req_band = RTW89_MAC_1;
+		wl_rinfo->dbcc_2g_phy = RTW89_PHY_1;
+		wl_rinfo->dbcc_en = 0;
+		break;
+	case MLO_1_PLUS_1_1RF: /* 1+1 */
+	case MLO_1_PLUS_1_2RF: /* 1+1 */
+	case MLO_2_PLUS_2_2RF: /* 2+2 */
+	case DBCC_LEGACY: /* DBCC 1+1 */
+		if (mlo_info->link_status == MLO_2_PLUS_2_2RF)
+			mlo_info->rf_combination = BTC_MLO_RF_2_PLUS_2;
+		else
+			mlo_info->rf_combination = BTC_MLO_RF_1_PLUS_1;
+
+		if (mlo_info->hwb_rf_band[RTW89_MAC_0] == RTW89_BAND_2G)
+			track_band = RTW89_MAC_0;
+		else
+			track_band = RTW89_MAC_1;
+
+		mlo_info->path_rf_band[BTC_RF_S0] =
+					mlo_info->hwb_rf_band[RTW89_MAC_0];
+		mlo_info->path_rf_band[BTC_RF_S1] =
+					mlo_info->hwb_rf_band[RTW89_MAC_1];
+
+		/* Check ch count from ch_type @ 2.4G HW-band, and modify type */
+		if (mlo_info->ch_type[track_band] == RTW89_MR_CTX1_2GHZ)
+			type = RTW89_MR_WTYPE_NONMLD; /* only 1-role at 2G */
+		else
+			type = RTW89_MR_WTYPE_NONMLD_NONMLD;
+
+		if (mlo_info->hwb_rf_band[RTW89_MAC_0] == RTW89_BAND_2G) {
+			wl_rinfo->pta_req_band = RTW89_MAC_0;
+			wl_rinfo->dbcc_2g_phy = RTW89_PHY_0;
+		} else {
+			wl_rinfo->pta_req_band = RTW89_MAC_1;
+			wl_rinfo->dbcc_2g_phy = RTW89_PHY_1;
+		}
+
+		if (mlo_info->wmode[RTW89_MAC_0] == RTW89_MR_WMODE_NONE &&
+		    mlo_info->wmode[RTW89_MAC_1] == RTW89_MR_WMODE_NONE)
+			wl_rinfo->dbcc_en = 0;
+		else
+			wl_rinfo->dbcc_en = 1;
+		break;
+	}
+
+	wl_rinfo->link_mode = _update_wl_link_mode(rtwdev, track_band, type);
+
+	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(), mode=%s, pta_band=%d",
+		    __func__, id_to_linkmode(wl_rinfo->link_mode),
+		    wl_rinfo->pta_req_band);
+}
+
+static void _update_wl_non_mlo_info(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
+	struct rtw89_btc_wl_rlink *rlink = NULL;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
+	bool b2g = false, b5g = false, outloop = false;
+	u8 mode = BTC_WLINK_NOLINK;
+	u8 cnt_2g = 0, cnt_5g = 0;
+	u8 i, j, cnt = 0;
+
+	for (j = RTW89_PHY_0; j < RTW89_PHY_NUM; j++) {
+		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
+			rlink = &wl_rinfo->rlink[i][j];
+
+			if (!rlink->active || !rlink->connected)
+				continue;
+
+			if (cnt >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER) {
+				outloop = true;
+				break;
+			}
+
+			cid_ch[cnt] = wl->rlink_info[i][j].chdef;
+			cid_phy[cnt] = rlink->phy;
+			cid_role[cnt] = rlink->role;
+			cnt++;
+
+			if (rlink->rf_band != RTW89_BAND_2G) {
+				cnt_5g++;
+				b5g = true;
+			} else {
+				cnt_2g++;
+				b2g = true;
+			}
+		}
+		if (outloop)
+			break;
+	}
+
+	wl_rinfo->dbcc_en = rtwdev->dbcc_en;
+	/* Be careful to change the following sequence!! */
+	if (cnt == 0) {
+		mode = BTC_WLINK_NOLINK;
+	} else if (!b2g && b5g) {
+		mode = BTC_WLINK_5G;
+	} else if (wl_rinfo->dbcc_en) {
+		mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role, cnt);
+	} else if (b2g && b5g) {
+		mode = BTC_WLINK_25G_MCC;
+	} else if (!b5g && cnt >= 2) {
+		if (_chk_role_ch_group(&cid_ch[0], &cid_ch[1]))
+			mode = BTC_WLINK_2G_SCC;
+		else
+			mode = BTC_WLINK_2G_MCC;
+	} else if (!b5g) { /* cnt_connect = 1 */
+		mode = _get_role_link_mode(cid_role[0]);
+	}
+
+	wl_rinfo->link_mode = mode;
+}
+
+static void _modify_role_link_mode(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc_wl_info *wl = &rtwdev->btc.cx.wl;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
+	u8 go_cleint_exist = wl->go_client_exist;
+	u8 link_mode = wl_rinfo->link_mode;
+	u32 role_map = wl_rinfo->role_map;
+	u8 noa_exist = wl->noa_exist;
+	u32 mrole = BTC_WLMROLE_NONE;
+
+	/* if no client_joined, don't care P2P-GO/AP role */
+	if (((role_map & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
+	     (role_map & BIT(RTW89_WIFI_ROLE_AP))) && !go_cleint_exist) {
+		if (link_mode == BTC_WLINK_2G_SCC) {
+			wl_rinfo->link_mode = BTC_WLINK_2G_STA;
+		} else if (link_mode == BTC_WLINK_2G_GO ||
+			   link_mode == BTC_WLINK_2G_AP) {
+			wl_rinfo->link_mode = BTC_WLINK_NOLINK;
+		}
+	}
+
+	/* Identify 2-Role type */
+	if  (link_mode == BTC_WLINK_2G_SCC ||
+	     link_mode == BTC_WLINK_2G_MCC ||
+	     link_mode == BTC_WLINK_25G_MCC ||
+	     link_mode == BTC_WLINK_5G) {
+		if ((role_map & BIT(RTW89_WIFI_ROLE_P2P_GO)) ||
+		    (role_map & BIT(RTW89_WIFI_ROLE_AP))) {
+			if (noa_exist)
+				mrole = BTC_WLMROLE_STA_GO_NOA;
+			else
+				mrole = BTC_WLMROLE_STA_GO;
+		} else if (role_map & BIT(RTW89_WIFI_ROLE_P2P_CLIENT)) {
+			if (noa_exist)
+				mrole = BTC_WLMROLE_STA_GC_NOA;
+			else
+				mrole = BTC_WLMROLE_STA_GC;
+		} else {
+			mrole = BTC_WLMROLE_STA_STA;
+		}
+	}
+
+	wl_rinfo->mrole_type = mrole;
+
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): link_mode=%s, mrole_type=%d\n", __func__,
+		    id_to_linkmode(wl_rinfo->link_mode), wl_rinfo->mrole_type);
+}
+
 static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id,
 			       enum btc_role_state state)
 {
+	struct rtw89_btc_wl_rlink *rlink = NULL;
+	struct rtw89_btc_wl_link_info *wl_linfo;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_chdef cid_ch[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER];
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo = &wl->role_info_v8;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	bool client_joined = false, b2g = false, b5g = false;
-	u8 cid_role[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
-	u8 cid_phy[RTW89_BE_BTC_WL_MAX_ROLE_NUMBER] = {};
-	u8 dbcc_en = 0, pta_req_band = RTW89_MAC_0;
-	u8 i, j, cnt = 0, cnt_2g = 0, cnt_5g = 0;
-	struct rtw89_btc_wl_link_info *wl_linfo;
-	struct rtw89_btc_wl_rlink *rlink = NULL;
-	u8 dbcc_2g_phy = RTW89_PHY_0;
-	u8 mode = BTC_WLINK_NOLINK;
-	u32 noa_dur = 0;
+	bool client_joined = false, noa_exist = false, p2p_exist = false;
+	bool is_5g_hi_channel = false, bg_mode = false, dbcc_en_ori;
+	u8 i, j, link_mode_ori;
+	u32 role_map = 0;
 
-	if (role_id >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER || rlink_id > RTW89_MAC_1)
+	if (role_id >= RTW89_BE_BTC_WL_MAX_ROLE_NUMBER || rlink_id >= RTW89_MAC_NUM)
 		return;
 
 	/* Extract wl->link_info[role_id][rlink_id] to wl->role_info
@@ -6562,10 +6896,8 @@ static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id
 	 */
 
 	wl_linfo = &wl->rlink_info[role_id][rlink_id];
-	if (wl_linfo->connected == MLME_LINKING)
-		return;
-
 	rlink = &wl_rinfo->rlink[role_id][rlink_id];
+
 	rlink->role = wl_linfo->role;
 	rlink->active = wl_linfo->active; /* Doze or not */
 	rlink->pid = wl_linfo->pid;
@@ -6581,8 +6913,6 @@ static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id
 	switch (wl_linfo->connected) {
 	case MLME_NO_LINK:
 		rlink->connected = 0;
-		if (rlink->role == RTW89_WIFI_ROLE_STATION)
-			btc->dm.leak_ap = 0;
 		break;
 	case MLME_LINKED:
 		rlink->connected = 1;
@@ -6591,130 +6921,72 @@ static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id
 		return;
 	}
 
-	wl->is_5g_hi_channel = false;
-	wl->bg_mode = false;
-	wl_rinfo->role_map = 0;
-	wl_rinfo->p2p_2g = 0;
-	memset(cid_ch, 0, sizeof(cid_ch));
-
-	for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
-		for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
+	for (j = RTW89_MAC_0; j <= RTW89_MAC_1; j++) {
+		for (i = 0; i < RTW89_BE_BTC_WL_MAX_ROLE_NUMBER; i++) {
 			rlink = &wl_rinfo->rlink[i][j];
 
 			if (!rlink->active || !rlink->connected)
 				continue;
 
-			cnt++;
-			wl_rinfo->role_map |= BIT(rlink->role);
-
-			/* only if client connect for p2p-Go/AP */
-			if ((rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
-			     rlink->role == RTW89_WIFI_ROLE_AP) &&
-			     rlink->client_cnt > 1)
-				client_joined = true;
-
-			/* Identufy if P2P-Go (GO/GC/AP) exist at 2G band*/
-			if (rlink->rf_band == RTW89_BAND_2G &&
-			    (client_joined || rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT))
-				wl_rinfo->p2p_2g = 1;
+			role_map |= BIT(rlink->role);
 
 			/* only one noa-role exist */
 			if (rlink->noa && rlink->noa_dur > 0)
-				noa_dur = rlink->noa_dur;
+				noa_exist = true;
 
 			/* for WL 5G-Rx interfered with BT issue */
-			if (rlink->rf_band == RTW89_BAND_5G && rlink->ch >= 100)
-				wl->is_5g_hi_channel = 1;
+			if (rlink->rf_band == RTW89_BAND_5G) {
+				if (rlink->ch >= 100)
+					is_5g_hi_channel = true;
 
-			if ((rlink->mode & BIT(BTC_WL_MODE_11B)) ||
-			    (rlink->mode & BIT(BTC_WL_MODE_11G)))
-				wl->bg_mode = 1;
-
-			if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT)
 				continue;
+			}
 
-			cid_ch[cnt - 1] = wl_linfo->chdef;
-			cid_phy[cnt - 1] = rlink->phy;
-			cid_role[cnt - 1] = rlink->role;
-
-			if (rlink->rf_band != RTW89_BAND_2G) {
-				cnt_5g++;
-				b5g = true;
-			} else {
-				cnt_2g++;
-				b2g = true;
+			/* only if client connect for p2p-Go/AP */
+			if ((rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
+			     rlink->role == RTW89_WIFI_ROLE_AP) &&
+			     rlink->client_cnt > 1) {
+				p2p_exist = true;
+				client_joined = true;
 			}
-		}
-	}
 
-	if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC] rlink cnt_2g=%d cnt_5g=%d\n", cnt_2g, cnt_5g);
-		rtw89_warn(rtwdev, "not support MLO feature yet");
-	} else {
-		dbcc_en = rtwdev->dbcc_en;
+			/* Identify if P2P-Go (GO/GC/AP) exist at 2G band */
+			if (rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)
+				p2p_exist = true;
 
-		/* Be careful to change the following sequence!! */
-		if (cnt == 0) {
-			mode = BTC_WLINK_NOLINK;
-		} else if (!b2g && b5g) {
-			mode = BTC_WLINK_5G;
-		} else if (wl_rinfo->role_map & BIT(RTW89_WIFI_ROLE_NAN)) {
-			mode = BTC_WLINK_2G_NAN;
-		} else if (cnt > BTC_TDMA_WLROLE_MAX) {
-			mode = BTC_WLINK_OTHER;
-		} else if (dbcc_en) {
-			mode = _chk_dbcc(rtwdev, cid_ch, cid_phy, cid_role,
-					 &dbcc_2g_phy);
-		} else if (b2g && b5g && cnt == 2) {
-			mode = BTC_WLINK_25G_MCC;
-		} else if (!b5g && cnt == 2) { /* cnt_connect = 2 */
-			if (_chk_role_ch_group(&cid_ch[0], &cid_ch[cnt - 1]))
-				mode = BTC_WLINK_2G_SCC;
-			else
-				mode = BTC_WLINK_2G_MCC;
-		} else if (!b5g && cnt == 1) { /* cnt_connect = 1 */
-			mode = _get_role_link_mode(cid_role[0]);
+			if ((rlink->mode & BIT(BTC_WL_MODE_11B)) ||
+			    (rlink->mode & BIT(BTC_WL_MODE_11G)))
+				bg_mode = true;
 		}
 	}
 
-	wl_rinfo->link_mode = mode;
-	wl_rinfo->connect_cnt = cnt;
-	if (wl_rinfo->connect_cnt == 0)
-		wl_rinfo->role_map = BIT(RTW89_WIFI_ROLE_NONE);
-	_update_role_link_mode(rtwdev, client_joined, noa_dur);
+	link_mode_ori = wl_rinfo->link_mode;
+	wl->is_5g_hi_channel = is_5g_hi_channel;
+	wl->bg_mode = bg_mode;
+	wl->go_client_exist = client_joined;
+	wl->noa_exist = noa_exist;
+	wl_rinfo->p2p_2g = p2p_exist;
+	wl_rinfo->role_map = role_map;
 
-	wl_rinfo->dbcc_2g_phy = dbcc_2g_phy;
-	if (wl_rinfo->dbcc_en != dbcc_en) {
-		wl_rinfo->dbcc_en = dbcc_en;
-		wl_rinfo->dbcc_chg = 1;
-		btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
+	dbcc_en_ori = wl_rinfo->dbcc_en;
+
+	if (rtwdev->chip->para_ver & BTC_FEAT_MLO_SUPPORT) {
+		/* for MLO-supported, link-mode from driver directly */
+		_update_wl_mlo_info(rtwdev);
 	} else {
-		wl_rinfo->dbcc_chg = 0;
+		/* for non-MLO-supported, link-mode by BTC */
+		_update_wl_non_mlo_info(rtwdev);
 	}
 
-	if (wl_rinfo->dbcc_en) {
-		memset(wl_dinfo, 0, sizeof(struct rtw89_btc_wl_dbcc_info));
+	_modify_role_link_mode(rtwdev);
 
-		if (mode == BTC_WLINK_5G) {
-			pta_req_band = RTW89_PHY_0;
-			wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_5G;
-			wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_2G;
-		} else if (wl_rinfo->dbcc_2g_phy == RTW89_PHY_1) {
-			pta_req_band = RTW89_PHY_1;
-			wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_5G;
-			wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_2G;
-		} else {
-			pta_req_band = RTW89_PHY_0;
-			wl_dinfo->op_band[RTW89_PHY_0] = RTW89_BAND_2G;
-			wl_dinfo->op_band[RTW89_PHY_1] = RTW89_BAND_5G;
-		}
-		_update_dbcc_band(rtwdev, RTW89_PHY_0);
-		_update_dbcc_band(rtwdev, RTW89_PHY_1);
-	}
+	if (link_mode_ori != wl_rinfo->link_mode)
+		wl->link_mode_chg = true;
 
-	wl_rinfo->pta_req_band = pta_req_band;
-	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
+	if (wl_rinfo->dbcc_en != dbcc_en_ori) {
+		wl->dbcc_chg = true;
+		btc->cx.cnt_wl[BTC_WCNT_DBCC_CHG]++;
+	}
 }
 
 void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -7626,7 +7898,6 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 
 	wlinfo = &wl->link_info[r.pid];
 
-	rlink_id = 0; /* to do */
 	if (ver->fwlrole == 0) {
 		*wlinfo = r;
 		_update_wl_info(rtwdev);
@@ -7640,6 +7911,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 		*wlinfo = r;
 		_update_wl_info_v7(rtwdev, r.pid);
 	} else if (ver->fwlrole == 8) {
+		rlink_id = rtwvif_link->mac_idx;
 		wlinfo = &wl->rlink_info[r.pid][rlink_id];
 		*wlinfo = r;
 		link_mode_ori = wl->role_info_v8.link_mode;
@@ -8256,65 +8528,51 @@ static int _show_wl_role_info(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_wl_link_info *plink = NULL;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	struct rtw89_traffic_stats *t;
 	char *p = buf, *end = buf + bufsz;
-	u8 i;
-
-	if (rtwdev->dbcc_en) {
-		p += scnprintf(p, end - p,
-			       " %-15s : PHY0_band(op:%d/scan:%d/real:%d), ",
-			       "[dbcc_info]", wl_dinfo->op_band[RTW89_PHY_0],
-			       wl_dinfo->scan_band[RTW89_PHY_0],
-			       wl_dinfo->real_band[RTW89_PHY_0]);
-		p += scnprintf(p, end - p,
-			       "PHY1_band(op:%d/scan:%d/real:%d)\n",
-			       wl_dinfo->op_band[RTW89_PHY_1],
-			       wl_dinfo->scan_band[RTW89_PHY_1],
-			       wl_dinfo->real_band[RTW89_PHY_1]);
-	}
+	u8 i, j;
 
-	for (i = 0; i < RTW89_PORT_NUM; i++) {
-		if (btc->ver->fwlrole == 8)
-			plink = &btc->cx.wl.rlink_info[i][0];
-		else
-			plink = &btc->cx.wl.link_info[i];
+	for (i = 0; i < btc->ver->max_role_num; i++) {
+		for (j = 0; j < RTW89_MAC_NUM; j++) {
+			if (btc->ver->fwlrole == 8)
+				plink = &btc->cx.wl.rlink_info[i][j];
+			else
+				plink = &btc->cx.wl.link_info[i];
 
-		if (!plink->active)
-			continue;
+			if (!plink->active)
+				continue;
 
-		p += scnprintf(p, end - p,
-			       " [port_%d]        : role=%d(phy-%d), connect=%d(client_cnt=%d), mode=%d, center_ch=%d, bw=%d",
-			       plink->pid, (u32)plink->role, plink->phy,
-			       (u32)plink->connected, plink->client_cnt - 1,
-			       (u32)plink->mode, plink->ch, (u32)plink->bw);
+			p += scnprintf(p, end - p,
+				       " [port_%d]        : role=%d(phy-%d), connect=%d(client_cnt=%d), mode=%d, center_ch=%d, bw=%d",
+				       plink->pid, plink->role, plink->phy,
+				       plink->connected, plink->client_cnt - 1,
+				       plink->mode, plink->ch, plink->bw);
 
-		if (plink->connected == MLME_NO_LINK)
-			continue;
+			if (plink->connected == MLME_NO_LINK)
+				continue;
 
-		p += scnprintf(p, end - p,
-			       ", mac_id=%d, max_tx_time=%dus, max_tx_retry=%d\n",
-			       plink->mac_id, plink->tx_time, plink->tx_retry);
+			p += scnprintf(p, end - p,
+				       ", mac_id=%d, max_tx_time=%dus, max_tx_retry=%d\n",
+				       plink->mac_id, plink->tx_time, plink->tx_retry);
 
-		p += scnprintf(p, end - p,
-			       " [port_%d]        : rssi=-%ddBm(%d), busy=%d, dir=%s, ",
-			       plink->pid, 110 - plink->stat.rssi,
-			       plink->stat.rssi, plink->busy,
-			       plink->dir == RTW89_TFC_UL ? "UL" : "DL");
+			p += scnprintf(p, end - p,
+				       " [port_%d]        : rssi=-%ddBm(%d), busy=%d, dir=%s, ",
+				       plink->pid, 110 - plink->stat.rssi,
+				       plink->stat.rssi, plink->busy,
+				       plink->dir == RTW89_TFC_UL ? "UL" : "DL");
 
-		t = &plink->stat.traffic;
+			t = &plink->stat.traffic;
 
-		p += scnprintf(p, end - p,
-			       "tx[rate:%d/busy_level:%d], ",
-			       (u32)t->tx_rate, t->tx_tfc_lv);
+			p += scnprintf(p, end - p,
+				       "tx[rate:%d/busy_level:%d], ",
+				       t->tx_rate, t->tx_tfc_lv);
 
-		p += scnprintf(p, end - p,
-			       "rx[rate:%d/busy_level:%d/drop:%d]\n",
-			       (u32)t->rx_rate,
-			       t->rx_tfc_lv, plink->rx_rate_drop_cnt);
+			p += scnprintf(p, end - p,
+				       "rx[rate:%d/busy_level:%d/drop:%d]\n",
+				       t->rx_rate,
+				       t->rx_tfc_lv, plink->rx_rate_drop_cnt);
+		}
 	}
-
 	return p - buf;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index e3a1fcd79620..ea2c1e5d70f5 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -224,6 +224,13 @@ enum btc_wl_mode {
 	BTC_WL_MODE_NUM,
 };
 
+enum btc_mlo_rf_combin {
+	BTC_MLO_RF_2_PLUS_0 = 0,
+	BTC_MLO_RF_0_PLUS_2 = 1,
+	BTC_MLO_RF_1_PLUS_1 = 2,
+	BTC_MLO_RF_2_PLUS_2 = 3,
+};
+
 enum btc_wl_gpio_debug {
 	BTC_DBG_GNT_BT = 0,
 	BTC_DBG_GNT_WL = 1,
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index daf9a30409ab..6ddc819d6ad0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1557,6 +1557,25 @@ struct rtw89_btc_wl_dbcc_info {
 	u8 role[RTW89_PHY_NUM]; /* role in each phy */
 };
 
+struct rtw89_btc_wl_mlo_info {
+	u8 wmode[RTW89_PHY_NUM]; /* enum phl_mr_wmode */
+	u8 ch_type[RTW89_PHY_NUM]; /* enum phl_mr_ch_type */
+	u8 hwb_rf_band[RTW89_PHY_NUM]; /* enum band_type, RF-band for HW-band */
+	u8 path_rf_band[RTW89_PHY_NUM]; /* enum band_type, RF-band for PHY0/1 */
+
+	u8 wtype; /* enum phl_mr_wtype */
+	u8 mrcx_mode;
+	u8 mrcx_act_hwb_map;
+	u8 mrcx_bt_slot_rsp;
+
+	u8 rf_combination; /* enum btc_mlo_rf_combin 0:2+0, 1:0+2, 2:1+1,3:2+2 */
+	u8 mlo_en; /* MLO enable */
+	u8 mlo_adie; /* a-die count */
+	u8 dual_hw_band_en; /* both 2 HW-band link exist */
+
+	u32 link_status; /* enum mlo_dbcc_mode_type */
+};
+
 struct rtw89_btc_wl_active_role {
 	u8 connected: 1;
 	u8 pid: 3;
@@ -1895,6 +1914,7 @@ struct rtw89_btc_wl_info {
 	struct rtw89_btc_wl_role_info_v8 role_info_v8;
 	struct rtw89_btc_wl_scan_info scan_info;
 	struct rtw89_btc_wl_dbcc_info dbcc_info;
+	struct rtw89_btc_wl_mlo_info mlo_info;
 	struct rtw89_btc_rf_para rf_para;
 	struct rtw89_btc_wl_nhm nhm;
 	union rtw89_btc_wl_state_map status;
@@ -1907,12 +1927,16 @@ struct rtw89_btc_wl_info {
 	u8 bt_polut_type[RTW89_PHY_NUM]; /* BT polluted WL-Tx type for phy0/1  */
 
 	bool is_5g_hi_channel;
+	bool go_client_exist;
+	bool noa_exist;
 	bool pta_reg_mac_chg;
 	bool bg_mode;
 	bool he_mode;
 	bool scbd_change;
 	bool fw_ver_mismatch;
 	bool client_cnt_inc_2g;
+	bool link_mode_chg;
+	bool dbcc_chg;
 	u32 scbd;
 };
 
@@ -2903,6 +2927,12 @@ struct rtw89_btc_trx_info {
 	u32 rx_err_ratio;
 };
 
+enum btc_rf_path {
+	BTC_RF_S0 = 0,
+	BTC_RF_S1 = 1,
+	BTC_RF_NUM,
+};
+
 union rtw89_btc_fbtc_slot_u {
 	struct rtw89_btc_fbtc_slot v1[CXST_MAX];
 	struct rtw89_btc_fbtc_slot_v7 v7[CXST_MAX];
-- 
2.25.1


