Return-Path: <linux-wireless+bounces-11555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD69954915
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF751F2182C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8B12D1EA;
	Fri, 16 Aug 2024 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Zd8uhsOM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982261B86C0
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 12:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812405; cv=none; b=MnG8mt/9yNKBo9lH7ADbdL+Za9Ang8kt2XreatqeR95zEFq69z/LqZXkpjlnmQk85OgErR6AClZQie5qCUhjX1LE2rbnBN2LLDg6ccPMDxXDkjh8k/fcWIqYV1QN/UV9qENcVS7aOdGnS7WFM0WSZcfqc4WZ8RXB8gIpDSMSw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812405; c=relaxed/simple;
	bh=NB2NczJthzVOXhz0N7cCLrTwslN5kH4Hs+8NmGxrKUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ikzx6L/5Jlwhk4sJl/bxoxMNxEYvnrATXYkSBR5Hknl4pajEv5QXo1q2dj8cIIO3rFHkpcoNi7oLr/omi8IHkXYGBIpqBu+pNiXZg6nPaEyyUXGLow320EAArQVV8wZnYDvplqjhWyfNGFIYCnRBfsR5wVY7E7nYcYIiLaC/+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Zd8uhsOM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47GCke7T31028468, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723812400; bh=NB2NczJthzVOXhz0N7cCLrTwslN5kH4Hs+8NmGxrKUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Zd8uhsOMR5Wr7uvT/3SJdM0V48JuN+FhC8hulPNTVVup7T2VayVEaTKx9x1m9+QXc
	 lDSMEeh2gBMw6WLfvvLwCcXq0NC/7jr70H210L1EwdC+D6iwjZQyZme2swxJHgFh2z
	 6cLzuN0Xi/kqguYomVIpwTUxtG38GvTBy6zLKO44KVDwcMZGC8PvuZbTBH4Uzw8Wkx
	 asGPqmXX4t3bOF4CjKHfkoYZOcODO38icPIgG5e6HjE/NT5YWv//Ik+tWlQ+99G4C0
	 hVTIzSD0M0a/BedlVNyNYEbQPvTOeJ9A5bhjXjiqbNziPS6ezfk0+JB5LCYLHUpGp3
	 L7zL3b8v+4aEw==
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47GCke7T31028468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 20:46:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 20:46:41 +0800
Received: from [127.0.1.1] (172.16.21.174) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 Aug
 2024 20:46:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH 3/4] wifi: rtw89: coex: Bluetooth hopping map for Wi-Fi role version 7
Date: Fri, 16 Aug 2024 20:46:13 +0800
Message-ID: <20240816124614.25592-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816124614.25592-1-pkshih@realtek.com>
References: <20240816124614.25592-1-pkshih@realtek.com>
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

To get Wi-Fi channel & bandwidth information from new Wi-Fi role format.
Bluetooth will negotiate which channel to do TX/RX with connected device.
And Bluetooth will maintain a hopping map, that describe the usable
channels. To avoid the interference from Wi-Fi 2.4GHz/Bluetooth each other,
Bluetooth must not to hop into Wi-Fi channel.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 0a8480644b0c..44e066a04b97 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -3045,10 +3045,12 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	struct rtw89_btc_wl_role_info *wl_rinfo = &wl->role_info;
 	struct rtw89_btc_wl_role_info_v1 *wl_rinfo_v1 = &wl->role_info_v1;
 	struct rtw89_btc_wl_role_info_v2 *wl_rinfo_v2 = &wl->role_info_v2;
+	struct rtw89_btc_wl_role_info_v7 *wl_rinfo_v7 = &wl->role_info_v7;
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	struct rtw89_btc_wl_active_role *r;
 	struct rtw89_btc_wl_active_role_v1 *r1;
 	struct rtw89_btc_wl_active_role_v2 *r2;
+	struct rtw89_btc_wl_active_role_v7 *r7;
 	struct rtw89_btc_wl_rlink *rlink;
 	u8 en = 0, i, ch = 0, bw = 0;
 	u8 mode, connect_cnt;
@@ -3065,6 +3067,9 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 	} else if (ver->fwlrole == 2) {
 		mode = wl_rinfo_v2->link_mode;
 		connect_cnt = wl_rinfo_v2->connect_cnt;
+	} else if (ver->fwlrole == 7) {
+		mode = wl_rinfo_v7->link_mode;
+		connect_cnt = wl_rinfo_v7->connect_cnt;
 	} else if (ver->fwlrole == 8) {
 		mode = wl_rinfo_v8->link_mode;
 		connect_cnt = wl_rinfo_v8->connect_cnt;
@@ -3083,6 +3088,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
 			r2 = &wl_rinfo_v2->active_role_v2[i];
+			r7 = &wl_rinfo_v7->active_role[i];
 			rlink = &wl_rinfo_v8->rlink[i][0];
 
 			if (ver->fwlrole == 0 &&
@@ -3103,6 +3109,12 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 				ch = r2->ch;
 				bw = r2->bw;
 				break;
+			} else if (ver->fwlrole == 7 &&
+				   (r7->role == RTW89_WIFI_ROLE_P2P_GO ||
+				    r7->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
+				ch = r7->ch;
+				bw = r7->bw;
+				break;
 			} else if (ver->fwlrole == 8 &&
 				   (rlink->role == RTW89_WIFI_ROLE_P2P_GO ||
 				    rlink->role == RTW89_WIFI_ROLE_P2P_CLIENT)) {
@@ -3118,6 +3130,7 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 			r = &wl_rinfo->active_role[i];
 			r1 = &wl_rinfo_v1->active_role_v1[i];
 			r2 = &wl_rinfo_v2->active_role_v2[i];
+			r7 = &wl_rinfo_v7->active_role[i];
 			rlink = &wl_rinfo_v8->rlink[i][0];
 
 			if (ver->fwlrole == 0 &&
@@ -3135,6 +3148,11 @@ static void _set_bt_afh_info(struct rtw89_dev *rtwdev)
 				ch = r2->ch;
 				bw = r2->bw;
 				break;
+			} else if (ver->fwlrole == 7 &&
+				   r7->connected && r7->band == RTW89_BAND_2G) {
+				ch = r7->ch;
+				bw = r7->bw;
+				break;
 			} else if (ver->fwlrole == 8 &&
 				   rlink->connected && rlink->rf_band == RTW89_BAND_2G) {
 				ch = rlink->ch;
-- 
2.25.1


