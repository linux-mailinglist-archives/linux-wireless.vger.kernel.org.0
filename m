Return-Path: <linux-wireless+bounces-6729-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A008AE760
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 15:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123BEB263A7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153CB134427;
	Tue, 23 Apr 2024 13:06:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF937134CFE
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877561; cv=none; b=nax3/flyodjnHBlnx54AYr7fexst9u7rrS3Z5TslJVXxEdWclFsrDY9kKG8wfLvziVs5Cvc26uOzS0gmRTbv12sPXrDWKJdBEMPXxXtkEWJ5YU7jTMbEU0zgNBfAAFYeeZfLeYMWMf6qWs9viSQSzggObjou2G6tQJLYZHo87O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877561; c=relaxed/simple;
	bh=q13LdCQXcAE5bk7SxfJ5XaEdiVrlShqFe4fTkGWHvRQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mthmPd8hHzr5TZUq4ANQS1ydiuf2ePC+Wgty3SfwlEk0Plm4szL9+6ODwwDyZuLKq9y9vaNqK5qy5CWjiIh3Zw8Ej2GPChvVACuaYjs/xA41gmO0ixq5w1yFaBiC+dCCD3BNCfX5K7gkO0iYkVpI2dUGzRPK/TmJL5Borba1uRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43ND5sRjA1251208, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43ND5sRjA1251208
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 21:05:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 21:05:55 +0800
Received: from [127.0.1.1] (172.16.20.182) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 23 Apr
 2024 21:05:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 6/8] wifi: rtw89: coex: Add Wi-Fi role v8 condition when set Bluetooth channel
Date: Tue, 23 Apr 2024 21:05:00 +0800
Message-ID: <20240423130502.32682-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240423130502.32682-1-pkshih@realtek.com>
References: <20240423130502.32682-1-pkshih@realtek.com>
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

This function is to let Bluetooth know Wi-Fi is using which channel,
and ask Bluetooth do not hop into the nearby channel. Wi-Fi channel
is saved at role info, this patch make the logic also get the channel
value from version 8 role info.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 374bc5aad2e8..ab51aa3ffbe1 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2981,9 +2981,11 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_active_role *r;
 	struct rtw89_btc_wl_active_role_v1 *r1;
 	struct rtw89_btc_wl_active_role_v2 *r2;
+	struct rtw89_btc_wl_rlink *rlink;
 	u8 en = 0, i, ch = 0, bw = 0;
 	u8 mode, connect_cnt;
 
@@ -2999,6 +3001,9 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	} else if (ver->fwlrole == 2) {
 		mode = wl_rinfo_v2->link_mode;
 		connect_cnt = wl_rinfo_v2->connect_cnt;
+	} else if (ver->fwlrole == 8) {
+		mode = wl_rinfo_v8->link_mode;
+		connect_cnt = wl_rinfo_v8->connect_cnt;
 	} else {
 		return;
 	}
@@ -3014,6 +3019,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
 			r2 = &wl_rinfo_v2->active_role_v2[i];
+			rlink = &wl_rinfo_v8->rlink[i][0];
 
 			if (ver->fwlrole == 0 &&
 			    (r->role == RTW89_WIFI_ROLE_P2P_GO ||
@@ -3033,6 +3039,12 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 				ch = r2->ch;
 				bw = r2->bw;
 				break;
+			} else if (ver->fwlrole == 8 &&
+				   (rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
+				    rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
+				ch = rlink->ch;
+				bw = rlink->bw;
+				break;
 			}
 		}
 	} else {
@@ -3042,6 +3054,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
 			r2 = &wl_rinfo_v2->active_role_v2[i];
+			rlink = &wl_rinfo_v8->rlink[i][0];
 
 			if (ver->fwlrole == 0 &&
 			    r->connected && r->band == RTW89_BAND_2G) {
@@ -3058,6 +3071,11 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 				ch = r2->ch;
 				bw = r2->bw;
 				break;
+			} else if (ver->fwlrole == 8 &&
+				   rlink->connected && rlink->rf_band == RTW89_BAND_2G) {
+				ch = rlink->ch;
+				bw = rlink->bw;
+				break;
 			}
 		}
 	}
-- 
2.25.1


