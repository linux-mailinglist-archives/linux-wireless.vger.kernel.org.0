Return-Path: <linux-wireless+bounces-38893-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iMziMbgEU2pKWAMAu9opvQ
	(envelope-from <linux-wireless+bounces-38893-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25646743A38
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 05:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=pRYp+EOj;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38893-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38893-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F613300D930
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jul 2026 03:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030D27A476;
	Sun, 12 Jul 2026 03:06:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720E42773DE
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 03:06:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783825590; cv=none; b=DIr+RQvYVnApHdOLl2uR4xhvb3NPwlnmAcR5mSJ5l2iSro2EccecbT+B1H08Qqe06rpwF8PnDpQ6jmLfxFu7nxhgpFIUsiUj5tltl4ccaiz/gsnn6lAVVBpWbs8Z5IdhRo11am+puVukSNI3TOJua0jJqb7rCWXS9Fx4p3YnBns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783825590; c=relaxed/simple;
	bh=45EswpKYlbCjATSSaWuYU4mVRPvkp5YCV00NkrFOQ6Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2yaKqIkWhh+SWlFcqMIzbtSa0r5dmr2mW1tIKs000dCConjLYMMa9KMKNDZHGfLauHHhOfFIZJ8x8LHUC8dOXjOBMXXH/oirSFGfbE0eLIrVBcapSWPbLlovtLgz28objlbg1g0Ofz+iLxL7ZOom96jYEZrneHfEGJkLnvOmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pRYp+EOj; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66C36PLR0525873, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783825585; bh=MbLrM++YT5Xs+/FaEI6ZpI5d5raBd7UMyM7hHBCukuc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pRYp+EOjLOIgq2K8KWqP7MpQFOk864IAKpBVNyMzuwqK43X83HJ3Y/XOqCC1JuCop
	 NF01NH/jD3KwPumuba6NeRptqCrE+21S7bOGelvYKz5YuOoEzLLlFGWLhu1Gzhug/h
	 VNkG3uuxlaX0DC1kq6s5JAdX98gmvsOljjWVGwwhRx8zsefMIpQtAHOD40Dsckm7li
	 UVdfHPwvcJHFcIY9kO9+/YAe7aUr2zRE47fq2FbOmxrFqaRmiH9JRh9zyv0rpR8sf/
	 ngoVAT9xxtA6whWZHL7QaQ2rusnvIw3iapLaMcEPRMJc9JYpVuJy6ZTqwFQSFZjOTm
	 iuxY0mxETS6+w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66C36PLR0525873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 11:06:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 12 Jul 2026 11:06:25 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Sun, 12 Jul 2026 11:06:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: ceox: Update antenna & grant signal setting
Date: Sun, 12 Jul 2026 11:04:59 +0800
Message-ID: <20260712030506.43438-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260712030506.43438-1-pkshih@realtek.com>
References: <20260712030506.43438-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-38893-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:ku920601@realtek.com,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25646743A38

From: Ching-Te Ku <ku920601@realtek.com>

Merge set antenna & grant signal logic. Combine all information to big
structure for runtime logic using, only separate to version format while
it is going to assign value to register or offload to firmware. Add new
format for dual-BT & external BT for RTL8922D.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c   | 501 ++++++++------------
 drivers/net/wireless/realtek/rtw89/core.h   |   4 +-
 drivers/net/wireless/realtek/rtw89/mac.c    |  27 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c |  21 +-
 4 files changed, 216 insertions(+), 337 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 78360e73d959..2ca6090e9f62 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -492,7 +492,7 @@ enum btc_ant_phase {
 	BTC_ANT_WONLY,
 	BTC_ANT_WOFF,
 	BTC_ANT_W2G,
-	BTC_ANT_W5G,
+	BTC_ANT_FDD,
 	BTC_ANT_W25G,
 	BTC_ANT_FREERUN,
 	BTC_ANT_WRFK,
@@ -841,7 +841,9 @@ enum btc_gnt_state {
 	BTC_GNT_HW	= 0,
 	BTC_GNT_SW_LO,
 	BTC_GNT_SW_HI,
-	BTC_GNT_MAX
+	BTC_GNT_MAX,
+
+	BTC_GNT_SET_SKIP = 0xff,
 };
 
 enum btc_ctr_path {
@@ -1787,8 +1789,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			dm->wl_fw_cx_offload = !!le32_to_cpu(prpt->v4.wl_fw_info.cx_offload);
 
 			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
-				memcpy(&dm->gnt.band[i], &prpt->v4.gnt_val[i],
-				       sizeof(dm->gnt.band[i]));
+				memcpy(&dm->gnt_set[i], &prpt->v4.gnt_val[i],
+				       sizeof(dm->gnt_set[i]));
 
 			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le32_to_cpu(prpt->v4.bt_cnt[BTC_BCNT_HI_TX]);
@@ -1819,8 +1821,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			dm->wl_fw_cx_offload = 0;
 
 			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
-				memcpy(&dm->gnt.band[i], &prpt->v5.gnt_val[i][0],
-				       sizeof(dm->gnt.band[i]));
+				memcpy(&dm->gnt_set[i], &prpt->v5.gnt_val[i],
+				       sizeof(dm->gnt_set[i]));
 
 			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v5.bt_cnt[BTC_BCNT_HI_TX]);
@@ -1846,8 +1848,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			dm->wl_fw_cx_offload = 0;
 
 			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
-				memcpy(&dm->gnt.band[i], &prpt->v105.gnt_val[i][0],
-				       sizeof(dm->gnt.band[i]));
+				memcpy(&dm->gnt_set[i], &prpt->v105.gnt_val[i],
+				       sizeof(dm->gnt_set[i]));
 
 			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v105.bt_cnt[BTC_BCNT_HI_TX_V105]);
@@ -1872,8 +1874,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw = le32_to_cpu(prpt->v7.rpt_info.fw_ver);
 
 			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
-				memcpy(&dm->gnt.band[i], &prpt->v7.gnt_val[i][0],
-				       sizeof(dm->gnt.band[i]));
+				memcpy(&dm->gnt_set[i], &prpt->v7.gnt_val[i],
+				       sizeof(dm->gnt_set[i]));
 
 			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v7.bt_cnt[BTC_BCNT_HI_TX_V105]);
@@ -1904,8 +1906,8 @@ static u32 _chk_btc_report(struct rtw89_dev *rtwdev,
 			wl->ver_info.fw = le32_to_cpu(prpt->v8.rpt_info.fw_ver);
 
 			for (i = RTW89_PHY_0; i < RTW89_PHY_NUM; i++)
-				memcpy(&dm->gnt.band[i], &prpt->v8.gnt_val[i][0],
-				       sizeof(dm->gnt.band[i]));
+				memcpy(&dm->gnt_set[i], &prpt->v8.gnt_val[i],
+				       sizeof(dm->gnt_set[i]));
 
 			bt->bcnt[BTC_BCNT_HIPRI_TX] =
 				le16_to_cpu(prpt->v8.bt_cnt[BTC_BCNT_HI_TX_V105]);
@@ -2971,11 +2973,14 @@ void btc_fw_event(struct rtw89_dev *rtwdev, u8 evt_id, void *data, u32 len)
 		btc->dm.scbd_b2w_update = 0;
 }
 
-static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map, u8 wl_state, u8 bt_state)
+static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map,
+		     u8 wl_state, u8 bt_state, u8 wlact_state)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	struct rtw89_btc_fbtc_outsrc_set_info *o = &dm->ost_info;
+	struct rtw89_mac_ax_wl_act *wlact_set;
+	struct rtw89_mac_ax_coex_gnt mg;
 	u8 i;
 
 	if (phy_map > BTC_PHY_ALL)
@@ -2987,126 +2992,118 @@ static void _set_gnt(struct rtw89_dev *rtwdev, u8 phy_map, u8 wl_state, u8 bt_st
 
 		switch (wl_state) {
 		case BTC_GNT_HW:
-			g[i].gnt_wl_sw_en = 0;
-			g[i].gnt_wl = 0;
+			dm->gnt_set[i].gnt_wl_sw_en = 0;
+			dm->gnt_set[i].gnt_wl = 0;
 			break;
 		case BTC_GNT_SW_LO:
-			g[i].gnt_wl_sw_en = 1;
-			g[i].gnt_wl = 0;
+			dm->gnt_set[i].gnt_wl_sw_en = 1;
+			dm->gnt_set[i].gnt_wl = 0;
 			break;
 		case BTC_GNT_SW_HI:
-			g[i].gnt_wl_sw_en = 1;
-			g[i].gnt_wl = 1;
+			dm->gnt_set[i].gnt_wl_sw_en = 1;
+			dm->gnt_set[i].gnt_wl = 1;
+			break;
+		case BTC_GNT_SET_SKIP:
+		default:
 			break;
 		}
 
 		switch (bt_state) {
 		case BTC_GNT_HW:
-			g[i].gnt_bt_sw_en = 0;
-			g[i].gnt_bt = 0;
+			dm->gnt_set[i].gnt_bt0_sw_en = 0;
+			dm->gnt_set[i].gnt_bt0 = 0;
+			dm->gnt_set[i].gnt_bt1_sw_en = 0;
+			dm->gnt_set[i].gnt_bt1 = 0;
+			dm->gnt_set[i].gnt_zb_sw_en = 0;
+			dm->gnt_set[i].gnt_zb = 0;
 			break;
 		case BTC_GNT_SW_LO:
-			g[i].gnt_bt_sw_en = 1;
-			g[i].gnt_bt = 0;
+			dm->gnt_set[i].gnt_bt0_sw_en = 1;
+			dm->gnt_set[i].gnt_bt0 = 0;
+			dm->gnt_set[i].gnt_bt1_sw_en = 1;
+			dm->gnt_set[i].gnt_bt1 = 0;
+			dm->gnt_set[i].gnt_zb_sw_en = 1;
+			dm->gnt_set[i].gnt_zb = 0;
 			break;
 		case BTC_GNT_SW_HI:
-			g[i].gnt_bt_sw_en = 1;
-			g[i].gnt_bt = 1;
+			dm->gnt_set[i].gnt_bt0_sw_en = 1;
+			dm->gnt_set[i].gnt_bt0 = 1;
+			dm->gnt_set[i].gnt_bt1_sw_en = 1;
+			dm->gnt_set[i].gnt_bt1 = 1;
+			dm->gnt_set[i].gnt_zb_sw_en = 1;
+			dm->gnt_set[i].gnt_zb = 1;
+			break;
+		case BTC_GNT_SET_SKIP:
+		default:
 			break;
 		}
 	}
 
-	rtw89_chip_mac_cfg_gnt(rtwdev, &dm->gnt);
-}
-
-static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
-			u8 wl_state, u8 bt_state, u8 wlact_state)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_btc_fbtc_outsrc_set_info *osi = &dm->ost_info;
-	struct rtw89_mac_ax_wl_act *b = dm->gnt.bt;
-	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
-	u8 i, bt_idx = dm->bt_select + 1;
-
-	if (phy_map > BTC_PHY_ALL)
-		return;
-
-	for (i = 0; i < RTW89_PHY_NUM; i++) {
-		if (!(phy_map & BIT(i)))
-			continue;
+	for (i = 0; i < BTC_ALL_BT_EZL; i++) {
+		if (!(rtwdev->chip->para_ver & BTC_FEAT_WLAN_ACT_MUX))
+			break;
 
-		switch (wl_state) {
-		case BTC_GNT_HW:
-			g[i].gnt_wl_sw_en = 0;
-			g[i].gnt_wl = 0;
+		switch (wlact_state) {
+		case BTC_WLACT_HW:
+			dm->wlact_set[i].wlan_act_en = 0;
+			dm->wlact_set[i].wlan_act = 0;
 			break;
-		case BTC_GNT_SW_LO:
-			g[i].gnt_wl_sw_en = 1;
-			g[i].gnt_wl = 0;
+		case BTC_WLACT_SW_LO:
+			dm->wlact_set[i].wlan_act_en = 1;
+			dm->wlact_set[i].wlan_act = 0;
 			break;
-		case BTC_GNT_SW_HI:
-			g[i].gnt_wl_sw_en = 1;
-			g[i].gnt_wl = 1;
+		case BTC_WLACT_SW_HI:
+			dm->wlact_set[i].wlan_act_en = 1;
+			dm->wlact_set[i].wlan_act = 1;
+			break;
+		default:
 			break;
 		}
 
-		switch (bt_state) {
-		case BTC_GNT_HW:
-			g[i].gnt_bt_sw_en = 0;
-			g[i].gnt_bt = 0;
-			break;
-		case BTC_GNT_SW_LO:
-			g[i].gnt_bt_sw_en = 1;
-			g[i].gnt_bt = 0;
-			break;
-		case BTC_GNT_SW_HI:
-			g[i].gnt_bt_sw_en = 1;
-			g[i].gnt_bt = 1;
+		if (!(rtwdev->chip->para_ver & BTC_FEAT_DUAL_BT))
 			break;
-		}
 	}
 
-	if (rtwdev->chip->para_ver & BTC_FEAT_WLAN_ACT_MUX) {
-		for (i = 0; i < 2; i++) {
-			if (!(bt_idx & BIT(i)))
-				continue;
+	rtw89_debug(rtwdev, RTW89_DBG_BTC,
+		    "[BTC], %s(): phy_map=0x%x, gnt_wl:%d, gnt_bt:%d, wl_act:%d\n",
+		    __func__, phy_map, wl_state, bt_state, wlact_state);
 
-			switch (wlact_state) {
-			case BTC_WLACT_HW:
-				b[i].wlan_act_en = 0;
-				b[i].wlan_act = 0;
-				break;
-			case BTC_WLACT_SW_LO:
-				b[i].wlan_act_en = 1;
-				b[i].wlan_act = 0;
-				break;
-			case BTC_WLACT_SW_HI:
-				b[i].wlan_act_en = 1;
-				b[i].wlan_act = 1;
-				break;
+	if (rtwdev->chip->para_ver & BTC_FEAT_H2C_MACRO) {
+		if (o->rf_band[BTC_RF_S0] == 1 && o->rf_band[BTC_RF_S1] == 0)
+			o->rf_gbt_source = BTC_RF_S1;
+		else
+			o->rf_gbt_source = BTC_RF_S0;
+
+		memcpy(o->wlact_set, dm->wlact_set, sizeof(o->wlact_set));
+
+		if (btc->ver->fcxosi == 6) {
+			memcpy(o->gnt_set_be, dm->gnt_set, sizeof(o->gnt_set_be));
+			return;
+		} else if (btc->ver->fcxosi == 1) {
+			for (i = 0; i < RTW89_PHY_NUM; i++) { /* gnt[MAC0/MAC1] */
+				mg.band[i].gnt_bt_sw_en = dm->gnt_set[i].gnt_bt0_sw_en;
+				mg.band[i].gnt_bt = dm->gnt_set[i].gnt_bt0;
+				mg.band[i].gnt_wl_sw_en = dm->gnt_set[i].gnt_wl_sw_en;
+				mg.band[i].gnt_wl = dm->gnt_set[i].gnt_wl;
+				memcpy(o->gnt_set, mg.band, sizeof(o->gnt_set));
 			}
+			return;
 		}
 	}
 
-	if (!btc->ver->fcxosi) {
-		rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
-		return;
+	for (i = 0; i < RTW89_PHY_NUM; i++) { /* gnt[MAC0/MAC1] */
+		mg.band[i].gnt_bt_sw_en = dm->gnt_set[i].gnt_bt0_sw_en;
+		mg.band[i].gnt_bt = dm->gnt_set[i].gnt_bt0;
+		mg.band[i].gnt_wl_sw_en = dm->gnt_set[i].gnt_wl_sw_en;
+		mg.band[i].gnt_wl = dm->gnt_set[i].gnt_wl;
 	}
-
-	memcpy(osi->gnt_set, dm->gnt.band, sizeof(osi->gnt_set));
-
-	for (i = 0; i < BTC_ALL_BT; i++) {
-		osi->wlact_set[i].wlan_act_en = dm->gnt.bt[i].wlan_act_en;
-		osi->wlact_set[i].wlan_act = dm->gnt.bt[i].wlan_act;
+	for (i = 0; i < BTC_ALL_BT; i++) { /* wlact[BT0/BT1] */
+		wlact_set = &dm->wlact_set[i];
+		mg.bt[i].wlan_act_en = wlact_set->wlan_act_en;
+		mg.bt[i].wlan_act = wlact_set->wlan_act;
 	}
 
-	/* GBT source should be GBT_S1 in 1+1 (HWB0:5G + HWB1:2G) case */
-	if (osi->rf_band[BTC_RF_S0] == 1 &&
-	    osi->rf_band[BTC_RF_S1] == 0)
-		osi->rf_gbt_source = BTC_RF_S1;
-	else
-		osi->rf_gbt_source = BTC_RF_S0;
+	rtw89_chip_mac_cfg_gnt(rtwdev, &mg);
 }
 
 #define BTC_TDMA_WLROLE_MAX 3
@@ -4961,157 +4958,22 @@ static void _set_bt_plut(struct rtw89_dev *rtwdev, u8 phy_map,
 	}
 }
 
-static void _set_ant_v0(struct rtw89_dev *rtwdev, bool force_exec,
-			u8 phy_map, u8 type)
+static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
+		     u8 phy_map, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_wl_role_info *r = &btc->cx.wl.role_info;
-	struct rtw89_btc_bt_info *bt = &cx->bt0;
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
-	u8 gwl, gwl0, gwl1, gbt, plt_ctrl, i, b2g = 0;
-	u32 ant_path_type;
-
-	ant_path_type = ((phy_map << 8) + type);
-
-	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
-	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
-	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || r->dbcc_chg)
-		force_exec = FC_EXEC;
-
-	if (!force_exec && ant_path_type == dm->set_ant_path) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return by no change!!\n",
-			     __func__);
-		return;
-	} else if (bt->rfk_info.map.run) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return by bt rfk!!\n", __func__);
-		return;
-	} else if (btc->dm.run_reason != BTC_RSN_NTFY_WL_RFK &&
-		   wl->rfk_info.state != BTC_WRFK_STOP) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return by wl rfk!!\n", __func__);
-		return;
-	}
-
-	dm->set_ant_path = ant_path_type;
-
-	rtw89_debug(rtwdev,
-		    RTW89_DBG_BTC,
-		    "[BTC], %s(): path=0x%x, set_type=0x%x\n",
-		    __func__, phy_map, dm->set_ant_path & 0xff);
-
-	switch (type) {
-	case BTC_ANT_WPOWERON:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_BT);
-		break;
-	case BTC_ANT_WINIT:
-		if (bt->enable.now)
-			_set_gnt(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI);
-		else
-			_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
-
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_BT, BTC_PLT_BT);
-		break;
-	case BTC_ANT_WONLY:
-		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
-	case BTC_ANT_WOFF:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_BT);
-		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
-	case BTC_ANT_W2G:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		if (rtwdev->dbcc_en) {
-			for (i = 0; i < RTW89_PHY_NUM; i++) {
-				b2g = (wl_dinfo->real_band[i] == RTW89_BAND_2G);
-
-				gwl = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
-				gbt = b2g ? BTC_GNT_HW : BTC_GNT_SW_HI;
-				/* BT should control by GNT_BT if WL_2G at S0 */
-				if (i == 1 &&
-				    wl_dinfo->real_band[0] == RTW89_BAND_2G &&
-				    wl_dinfo->real_band[1] == RTW89_BAND_5G)
-					gbt = BTC_GNT_HW;
-				_set_gnt(rtwdev, BIT(i), gwl, gbt);
-				plt_ctrl = b2g ? BTC_PLT_BT : BTC_PLT_NONE;
-				_set_bt_plut(rtwdev, BIT(i),
-					     plt_ctrl, plt_ctrl);
-			}
-		} else {
-			_set_gnt(rtwdev, phy_map, BTC_GNT_HW, BTC_GNT_HW);
-			_set_bt_plut(rtwdev, BTC_PHY_ALL,
-				     BTC_PLT_BT, BTC_PLT_BT);
-		}
-		break;
-	case BTC_ANT_W5G:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_HW);
-		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
-	case BTC_ANT_W25G:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_gnt(rtwdev, phy_map, BTC_GNT_HW, BTC_GNT_HW);
-		_set_bt_plut(rtwdev, BTC_PHY_ALL,
-			     BTC_PLT_GNT_WL, BTC_PLT_GNT_WL);
-		break;
-	case BTC_ANT_FREERUN:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_HI);
-		_set_bt_plut(rtwdev, BTC_PHY_ALL, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
-	case BTC_ANT_WRFK:
-	case BTC_ANT_WRFK2:
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_gnt(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO);
-		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
-	case BTC_ANT_PTA:
-	default:
-		gbt = BTC_GNT_HW;
-		if ((rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA) ||
-		    !r->dbcc_en) {
-			gwl = BTC_GNT_HW;
-			_set_gnt(rtwdev, BTC_PHY_ALL, gwl, gbt);
-		} else {
-			/* for DBCC Only-1-PTA */
-			if (r->dbcc_2g_phy == RTW89_PHY_0) {
-				gwl0 = BTC_GNT_HW;
-				gwl1 = BTC_GNT_SW_HI;
-			} else {
-				gwl0 = BTC_GNT_SW_HI;
-				gwl1 = BTC_GNT_HW;
-			}
-			_set_gnt(rtwdev, BTC_PHY_0, gwl0, gbt);
-			_set_gnt(rtwdev, BTC_PHY_1, gwl1, gbt);
-		}
-		rtw89_chip_cfg_ctrl_path(rtwdev, BTC_CTRL_BY_WL);
-		_set_bt_plut(rtwdev, phy_map, BTC_PLT_NONE, BTC_PLT_NONE);
-		break;
-	}
-}
-
-static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
-			u8 phy_map, u8 type)
-{
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
-	struct rtw89_btc_bt_info *bt = &btc->cx.bt0;
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	u32 ant_path_type = rtw89_get_antpath_type(phy_map, type);
-	struct rtw89_btc_wl_dbcc_info *wl_dinfo = &wl->dbcc_info;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	u8 gwl = BTC_GNT_HW, gwl0, gwl1, gbt;
+	bool cx_ctrl;
 
-	if (btc->dm.run_reason == BTC_RSN_NTFY_POWEROFF ||
-	    btc->dm.run_reason == BTC_RSN_NTFY_RADIO_STATE ||
-	    btc->dm.run_reason == BTC_RSN_CMD_SET_COEX || wl_rinfo->dbcc_chg)
+	if (btc->cli_h2c_cmd || wl_rinfo->dbcc_chg ||
+	    dm->run_reason == BTC_RSN_NTFY_POWEROFF ||
+	    dm->run_reason == BTC_RSN_NTFY_RADIO_STATE ||
+	    dm->run_reason == BTC_RSN_CMD_SET_COEX)
 		force_exec = FC_EXEC;
 
 	if (wl_rinfo->link_mode != BTC_WLINK_DB_MCC &&
@@ -5123,10 +4985,6 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 			    "[BTC], %s(): return by no change!!\n",
 			     __func__);
 		return;
-	} else if (bt->rfk_info.map.run) {
-		rtw89_debug(rtwdev, RTW89_DBG_BTC,
-			    "[BTC], %s(): return by bt rfk!!\n", __func__);
-		return;
 	} else if (btc->dm.run_reason != BTC_RSN_NTFY_WL_RFK &&
 		   wl->rfk_info.state != BTC_WRFK_STOP) {
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -5141,64 +4999,38 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 		    __func__, phy_map, dm->set_ant_path & 0xff);
 
 	switch (type) {
+	case BTC_ANT_WPOWERON:
+		cx_ctrl = BTC_CTRL_BY_BT;
+		break;
 	case BTC_ANT_WINIT:
+		cx_ctrl = BTC_CTRL_BY_WL;
 		/* To avoid BT MP driver case (bt_enable but no mailbox) */
-		if (bt->enable.now && bt->run_patch_code)
-			_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI,
-				    BTC_WLACT_SW_LO);
+		if ((cx->bt0.enable.now && cx->bt0.run_patch_code) ||
+		    (cx->bt1.enable.now && cx->bt1.run_patch_code))
+			_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_LO, BTC_GNT_SW_HI,
+				 BTC_WLACT_SW_LO);
 		else
-			_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
-				    BTC_WLACT_SW_HI);
+			_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+				 BTC_WLACT_SW_HI);
 		break;
 	case BTC_ANT_WONLY:
-		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
-			    BTC_WLACT_SW_HI);
+		cx_ctrl = BTC_CTRL_BY_WL;
+		_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+			 BTC_WLACT_SW_HI);
 		break;
 	case BTC_ANT_WOFF:
-		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_LO, BTC_GNT_SW_HI,
-			    BTC_WLACT_SW_LO);
-		break;
-	case BTC_ANT_W2G:
-	case BTC_ANT_W25G:
-		if (wl_rinfo->dbcc_en) {
-			if (wl_dinfo->real_band[RTW89_PHY_0] == RTW89_BAND_2G)
-				gwl = BTC_GNT_HW;
-			else
-				gwl = BTC_GNT_SW_HI;
-			_set_gnt_v1(rtwdev, BTC_PHY_0, gwl, BTC_GNT_HW, BTC_WLACT_HW);
-
-			if (wl_dinfo->real_band[RTW89_PHY_1] == RTW89_BAND_2G)
-				gwl = BTC_GNT_HW;
-			else
-				gwl = BTC_GNT_SW_HI;
-			_set_gnt_v1(rtwdev, BTC_PHY_1, gwl, BTC_GNT_HW, BTC_WLACT_HW);
-		} else {
-			gwl = BTC_GNT_HW;
-			_set_gnt_v1(rtwdev, phy_map, gwl, BTC_GNT_HW, BTC_WLACT_HW);
-		}
-		break;
-	case BTC_ANT_W5G:
-		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_HW, BTC_WLACT_HW);
-		break;
-	case BTC_ANT_FREERUN:
-		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_HI,
-			    BTC_WLACT_SW_LO);
-		break;
-	case BTC_ANT_WRFK:
-		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
-			    BTC_WLACT_HW);
-		break;
-	case BTC_ANT_WRFK2:
-		_set_gnt_v1(rtwdev, phy_map, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
-			    BTC_WLACT_SW_HI); /* no BT-Tx */
+		cx_ctrl = BTC_CTRL_BY_BT;
+		_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_LO, BTC_GNT_SW_HI,
+			 BTC_WLACT_SW_LO);
 		break;
 	case BTC_ANT_PTA:
 	default:
+		cx_ctrl = BTC_CTRL_BY_WL;
 		gbt = BTC_GNT_HW;
 		if ((rtwdev->chip->para_ver & BTC_FEAT_MULTI_PTA) ||
 		    !wl_rinfo->dbcc_en) {
 			gwl = BTC_GNT_HW;
-			_set_gnt_v1(rtwdev, BTC_PHY_ALL, gwl, gbt, BTC_WLACT_HW);
+			_set_gnt(rtwdev, BTC_PHY_ALL, gwl, gbt, BTC_WLACT_HW);
 		} else {
 			/* for DBCC Only-1-PTA */
 			if (wl_rinfo->dbcc_2g_phy == RTW89_PHY_0) {
@@ -5208,24 +5040,36 @@ static void _set_ant_v1(struct rtw89_dev *rtwdev, bool force_exec,
 				gwl0 = BTC_GNT_SW_HI;
 				gwl1 = BTC_GNT_HW;
 			}
-			_set_gnt_v1(rtwdev, BTC_PHY_0, gwl0, gbt, BTC_WLACT_HW);
-			_set_gnt_v1(rtwdev, BTC_PHY_1, gwl1, gbt, BTC_WLACT_HW);
+			_set_gnt(rtwdev, BTC_PHY_0, gwl0, gbt, BTC_WLACT_HW);
+			_set_gnt(rtwdev, BTC_PHY_1, gwl1, gbt, BTC_WLACT_HW);
 		}
 		break;
+	case BTC_ANT_FDD:
+		cx_ctrl = BTC_CTRL_BY_WL;
+		_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_HI, BTC_GNT_HW,
+			 BTC_WLACT_HW);
+		break;
+	case BTC_ANT_FREERUN:
+		cx_ctrl = BTC_CTRL_BY_WL;
+		_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_HI, BTC_GNT_SW_HI,
+			 BTC_WLACT_SW_LO);
+		break;
+	case BTC_ANT_WRFK:
+		cx_ctrl = BTC_CTRL_BY_WL;
+		_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+			 BTC_WLACT_HW);
+		break;
+	case BTC_ANT_WRFK2:
+		cx_ctrl = BTC_CTRL_BY_WL;
+		_set_gnt(rtwdev, BTC_PHY_ALL, BTC_GNT_SW_HI, BTC_GNT_SW_LO,
+			 BTC_WLACT_SW_HI); /* no BT-Tx */
+		break;
 	}
 
+	rtw89_chip_cfg_ctrl_path(rtwdev, cx_ctrl);
 	_set_bt_plut(rtwdev, phy_map, BTC_PLT_GNT_WL, BTC_PLT_GNT_WL);
 }
 
-static void _set_ant(struct rtw89_dev *rtwdev, bool force_exec,
-		     u8 phy_map, u8 type)
-{
-	if (rtwdev->chip->chip_id >= RTL8922A)
-		_set_ant_v1(rtwdev, force_exec, phy_map, type);
-	else
-		_set_ant_v0(rtwdev, force_exec, phy_map, type);
-}
-
 static void _action_wl_only(struct rtw89_dev *rtwdev)
 {
 	_set_ant(rtwdev, FC_EXEC, BTC_PHY_ALL, BTC_ANT_WONLY);
@@ -5619,7 +5463,7 @@ static void _action_bt_a2dp_pan_hid(struct rtw89_dev *rtwdev)
 
 static void _action_wl_5g(struct rtw89_dev *rtwdev)
 {
-	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_W5G);
+	_set_ant(rtwdev, NM_EXEC, BTC_PHY_ALL, BTC_ANT_FDD);
 	_set_policy(rtwdev, BTC_CXP_OFF_EQ0, BTC_ACT_WL_5G);
 }
 
@@ -9674,7 +9518,7 @@ static const char *id_to_ant(u32 id)
 	CASE_BTC_ANTPATH_STR(WONLY);
 	CASE_BTC_ANTPATH_STR(WOFF);
 	CASE_BTC_ANTPATH_STR(W2G);
-	CASE_BTC_ANTPATH_STR(W5G);
+	CASE_BTC_ANTPATH_STR(FDD);
 	CASE_BTC_ANTPATH_STR(W25G);
 	CASE_BTC_ANTPATH_STR(FREERUN);
 	CASE_BTC_ANTPATH_STR(WRFK);
@@ -10898,6 +10742,7 @@ static int _show_fw_dm_msg(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt_cfg)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_mac_ax_wl_act *bt;
 	struct rtw89_mac_ax_gnt *gnt;
 	u32 val, status;
 
@@ -10932,7 +10777,39 @@ static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt
 		gnt->gnt_bt = !!(status & B_AX_GNT_BT_RFC_S1);
 		gnt->gnt_wl_sw_en = !!(val & B_AX_GNT_WL_RFC_S1_SWCTRL);
 		gnt->gnt_wl = !!(status & B_AX_GNT_WL_RFC_S1);
-	} else {
+
+		bt = &gnt_cfg->bt[0];
+		bt->wlan_act_en = !!(val & B_BE_WL_ACT_SWCTRL);
+		bt->wlan_act = !!(status & B_BE_WL_ACT_VAL);
+
+		bt = &gnt_cfg->bt[1];
+		bt->wlan_act_en = !!(val & B_BE_WL_ACT2_SWCTRL);
+		bt->wlan_act = !!(status & B_BE_WL_ACT2_VAL);
+	} else if (chip->chip_id == RTL8922A) {
+		val = rtw89_read32(rtwdev, R_BE_GNT_SW_CTRL);
+		status = rtw89_read32(rtwdev, R_BE_PTA_GNT_VAL);
+
+		gnt = &gnt_cfg->band[0];
+		gnt->gnt_bt_sw_en = !!(val & B_BE_GNT_BT_BB0_SWCTRL);
+		gnt->gnt_bt = !!(status & B_BE_GNT_BT_BB0_VAL);
+		gnt->gnt_wl_sw_en = !!(val & B_BE_GNT_WL_BB0_SWCTRL);
+		gnt->gnt_wl = !!(status & B_BE_GNT_WL_BB0_VAL);
+
+		gnt = &gnt_cfg->band[1];
+		gnt->gnt_bt_sw_en = !!(val & B_BE_GNT_BT_BB1_SWCTRL);
+		gnt->gnt_bt = !!(status & B_BE_GNT_BT_BB1_VAL);
+		gnt->gnt_wl_sw_en = !!(val & B_BE_GNT_WL_BB1_SWCTRL);
+		gnt->gnt_wl = !!(status & B_BE_GNT_WL_BB1_VAL);
+
+		bt = &gnt_cfg->bt[0];
+		bt->wlan_act_en = !!(val & B_BE_WL_ACT_SWCTRL);
+		bt->wlan_act = !!(status & B_BE_WL_ACT_VAL);
+
+		bt = &gnt_cfg->bt[1];
+		bt->wlan_act_en = !!(val & B_BE_WL_ACT2_SWCTRL);
+		bt->wlan_act = !!(status & B_BE_WL_ACT2_VAL);
+	} else if (chip->chip_id == RTL8922D) {
+		/* Get from firmware */
 		return;
 	}
 }
@@ -11181,7 +11058,6 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 	struct rtw89_btc_bt_info *bt0 = &cx->bt0;
 	struct rtw89_btc_bt_info *bt1 = &cx->bt1;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
-	struct rtw89_mac_ax_gnt *gnt = NULL;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	char *p = buf, *end = buf + bufsz;
 	u8 i, type, cnt = 0;
@@ -11219,18 +11095,19 @@ static int _show_mreg_v7(struct rtw89_dev *rtwdev, char *buf, size_t bufsz)
 		       wl->pta_req_mac,
 		       id_to_polut(wl->bt_polut_type[wl->pta_req_mac]));
 
-	gnt = &dm->gnt.band[RTW89_PHY_0];
-
 	p += scnprintf(p, end - p, ", phy-0[gnt_wl:%s-%d/gnt_bt:%s-%d]",
-		       gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
-		       gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
+		      dm->gnt_set[RTW89_PHY_0].gnt_wl_sw_en ? "SW" : "HW",
+		      dm->gnt_set[RTW89_PHY_0].gnt_wl,
+		      dm->gnt_set[RTW89_PHY_0].gnt_bt0_sw_en ? "SW" : "HW",
+		      dm->gnt_set[RTW89_PHY_0].gnt_bt0);
 
 	if (rtwdev->dbcc_en) {
-		gnt = &dm->gnt.band[RTW89_PHY_1];
 		p += scnprintf(p, end - p,
 			       ", phy-1[gnt_wl:%s-%d/gnt_bt:%s-%d]",
-			       gnt->gnt_wl_sw_en ? "SW" : "HW", gnt->gnt_wl,
-			       gnt->gnt_bt_sw_en ? "SW" : "HW", gnt->gnt_bt);
+			       dm->gnt_set[RTW89_PHY_1].gnt_wl_sw_en ? "SW" : "HW",
+			       dm->gnt_set[RTW89_PHY_1].gnt_wl,
+			       dm->gnt_set[RTW89_PHY_1].gnt_bt0_sw_en ? "SW" : "HW",
+			       dm->gnt_set[RTW89_PHY_1].gnt_bt0);
 	}
 
 	pcinfo = &pfwinfo->rpt_fbtc_mregval.cinfo;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 676d3ba855d7..a928140300b9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3481,7 +3481,9 @@ struct rtw89_btc_dm {
 	union rtw89_btc_fbtc_slot_u slot_now;
 	struct rtw89_btc_fbtc_tdma tdma;
 	struct rtw89_btc_fbtc_tdma tdma_now;
-	struct rtw89_mac_ax_coex_gnt gnt;
+	struct rtw89_btc_gnt_ctrl gnt_set[RTW89_MAC_AX_COEX_GNT_NR];
+	struct rtw89_btc_gnt_ctrl gnt_val[RTW89_MAC_AX_COEX_GNT_NR];
+	struct rtw89_mac_ax_wl_act wlact_set[BTC_ALL_BT_EZL];
 	union rtw89_btc_init_info_u init_info; /* pass to wl_fw if offload */
 	struct rtw89_btc_rf_trx_para_v9 rf_trx_para;
 	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 6e3da5e4a1b3..b9cd7fd8d76b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6538,8 +6538,6 @@ int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 	if (gnt_cfg->band[0].gnt_bt)
 		val |= B_AX_GNT_BT_RFC_S0_VAL | B_AX_GNT_BT_RX_VAL |
 		       B_AX_GNT_BT_TX_VAL;
-	else
-		val |= B_AX_WL_ACT_VAL;
 
 	if (gnt_cfg->band[0].gnt_bt_sw_en)
 		val |= B_AX_GNT_BT_RFC_S0_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
@@ -6556,8 +6554,6 @@ int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 	if (gnt_cfg->band[1].gnt_bt)
 		val |= B_AX_GNT_BT_RFC_S1_VAL | B_AX_GNT_BT_RX_VAL |
 		       B_AX_GNT_BT_TX_VAL;
-	else
-		val |= B_AX_WL_ACT_VAL;
 
 	if (gnt_cfg->band[1].gnt_bt_sw_en)
 		val |= B_AX_GNT_BT_RFC_S1_SWCTRL | B_AX_GNT_BT_RX_SWCTRL |
@@ -6571,6 +6567,15 @@ int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 		val |= B_AX_GNT_WL_RFC_S1_SWCTRL | B_AX_GNT_WL_RX_SWCTRL |
 		       B_AX_GNT_WL_TX_SWCTRL | B_AX_GNT_WL_BB_SWCTRL;
 
+	if (gnt_cfg->bt[0].wlan_act_en)
+		val |= B_AX_WL_ACT_SWCTRL;
+	if (gnt_cfg->bt[0].wlan_act)
+		val |= B_AX_WL_ACT_VAL;
+	if (gnt_cfg->bt[1].wlan_act_en)
+		val |= B_AX_WL_ACT2_SWCTRL;
+	if (gnt_cfg->bt[1].wlan_act)
+		val |= B_AX_WL_ACT2_VAL;
+
 	rtw89_write32(rtwdev, R_AX_GNT_SW_CTRL, val);
 
 	return 0;
@@ -6645,22 +6650,20 @@ EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path);
 
 int rtw89_mac_cfg_ctrl_path_v1(struct rtw89_dev *rtwdev, bool wl)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
+	struct rtw89_mac_ax_coex_gnt gnt = {};
 	int i;
 
 	if (wl)
 		return 0;
 
 	for (i = 0; i < RTW89_PHY_NUM; i++) {
-		g[i].gnt_bt_sw_en = 1;
-		g[i].gnt_bt = 1;
-		g[i].gnt_wl_sw_en = 1;
-		g[i].gnt_wl = 0;
+		gnt.band[i].gnt_bt_sw_en = 1;
+		gnt.band[i].gnt_bt = 1;
+		gnt.band[i].gnt_wl_sw_en = 1;
+		gnt.band[i].gnt_wl = 0;
 	}
 
-	return rtw89_mac_cfg_gnt_v1(rtwdev, &dm->gnt);
+	return rtw89_mac_cfg_gnt_v1(rtwdev, &gnt);
 }
 EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path_v1);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 4bdf20b7ba6d..33513b283d84 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2466,29 +2466,26 @@ EXPORT_SYMBOL(rtw89_mac_cfg_gnt_v3);
 
 int rtw89_mac_cfg_ctrl_path_v2(struct rtw89_dev *rtwdev, bool wl)
 {
-	struct rtw89_btc *btc = &rtwdev->btc;
-	struct rtw89_btc_dm *dm = &btc->dm;
-	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
-	struct rtw89_mac_ax_wl_act *gbt = dm->gnt.bt;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_mac_ax_coex_gnt gnt = {};
 	int i;
 
 	if (wl)
 		return 0;
 
 	for (i = 0; i < RTW89_PHY_NUM; i++) {
-		g[i].gnt_bt_sw_en = 1;
-		g[i].gnt_bt = 1;
-		g[i].gnt_wl_sw_en = 1;
-		g[i].gnt_wl = 0;
-		gbt[i].wlan_act = 1;
-		gbt[i].wlan_act_en = 0;
+		gnt.band[i].gnt_bt_sw_en = 1;
+		gnt.band[i].gnt_bt = 1;
+		gnt.band[i].gnt_wl_sw_en = 1;
+		gnt.band[i].gnt_wl = 0;
+		gnt.bt[i].wlan_act = 1;
+		gnt.bt[i].wlan_act_en = 0;
 	}
 
 	if (chip->chip_id == RTL8922A)
-		return rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+		return rtw89_mac_cfg_gnt_v2(rtwdev, &gnt);
 	else
-		return rtw89_mac_cfg_gnt_v3(rtwdev, &dm->gnt);
+		return rtw89_mac_cfg_gnt_v3(rtwdev, &gnt);
 
 }
 EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path_v2);
-- 
2.25.1


