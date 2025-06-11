Return-Path: <linux-wireless+bounces-23983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8A9AD49D4
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3471017BF71
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E501FDA94;
	Wed, 11 Jun 2025 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="r5fJOy4u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB0520E034
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749614186; cv=none; b=GAZYWf2fzF8wQ+mOuK75c9wz3CbaJVEYPfAYL4Rw818u4zm7iRFI7NMt66zEX51kwALXfg4Qqat2prbikRoYZhnFe3gII4UHUO9Fz9JuQ/EgwLDBa/Wwc7kBvwU2zl+XLz1TV6f1Q6Y4Ot0ELkpTHkDL9QYeDxYfEm62xpcgztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749614186; c=relaxed/simple;
	bh=ioiIO8EBvAH6ZxzP54FhUtdGzMMtXnWUjUn0sTVwaXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cn1fiubHbr+H73WMWidGippnreqGThHvOKRntSRQugSMxprsUUAYW66rv89frJEidOLabzzNYq7721rRsponXJ8SpJ03iwZ4iKCLs+1XNs+PaitL7AvhwiqtRsAQGZxrxTUc9NQSyj+1c0AEo+J/jeg46ICFUk7ckq1uiFPiBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=r5fJOy4u; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55B3uMwkD4132637, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749614182; bh=HBo/h0AOe+l0hNLyA+/46/M2ckN1cPpp1b+MUIb4+VU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=r5fJOy4uyQ9JTzOSsuSLJmEhlts8dw1Z8hmjKngS8Ww4Dy/FHM+6cJsYyYj9tp4R7
	 pgq7qWcKJjAdn5DdzP4IHl/1AGj5A5PXdWml6MwS+rX/1OaBkOrAeonNRertZo71Tk
	 vTv9X1m8rNAlOPwWpB9Wk4Rjg972IA8rD0WQh/HWXpn7o42+OAvtqKtPswUq5Bn3Lk
	 zELiBkV3Ga5OYwgRmMRkiYA22hQCfu3FkWKskkfoiEpZwJrBYsZlPMxPIvPFK20WXn
	 gk1HY+eX84YXhYkS13hFYvY9xY1Yq+p6JpdvbmUabyVbN/WzNc/033t7/HmrE1rOYm
	 skSlkz6qy8GQA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55B3uMwkD4132637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 11:56:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 11:56:22 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 11 Jun
 2025 11:56:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 10/10] wifi: rtw89: coex: Add PTA grant signal setting offload to firmware feature
Date: Wed, 11 Jun 2025 11:55:23 +0800
Message-ID: <20250611035523.36432-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611035523.36432-1-pkshih@realtek.com>
References: <20250611035523.36432-1-pkshih@realtek.com>
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

In the before experience there are many issue occurred because of the
grant control signal can not be set in time especially WiFi power save
enter/leave. To control the signal more accuracy, offload the control
to firmware.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 30 +++++++++++++++++------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 97df4b2b3368..934407dc53ea 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -2866,6 +2866,8 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_fbtc_outsrc_set_info *osi = &dm->ost_info;
+	struct rtw89_mac_ax_wl_act *b = dm->gnt.bt;
 	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
 	u8 i, bt_idx = dm->bt_select + 1;
 
@@ -2914,21 +2916,35 @@ static void _set_gnt_v1(struct rtw89_dev *rtwdev, u8 phy_map,
 
 			switch (wlact_state) {
 			case BTC_WLACT_HW:
-				dm->gnt.bt[i].wlan_act_en = 0;
-				dm->gnt.bt[i].wlan_act = 0;
+				b[i].wlan_act_en = 0;
+				b[i].wlan_act = 0;
 				break;
 			case BTC_WLACT_SW_LO:
-				dm->gnt.bt[i].wlan_act_en = 1;
-				dm->gnt.bt[i].wlan_act = 0;
+				b[i].wlan_act_en = 1;
+				b[i].wlan_act = 0;
 				break;
 			case BTC_WLACT_SW_HI:
-				dm->gnt.bt[i].wlan_act_en = 1;
-				dm->gnt.bt[i].wlan_act = 1;
+				b[i].wlan_act_en = 1;
+				b[i].wlan_act = 1;
 				break;
 			}
 		}
 	}
-	rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+
+	if (!btc->ver->fcxosi) {
+		rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+		return;
+	}
+
+	memcpy(osi->gnt_set, dm->gnt.band, sizeof(osi->gnt_set));
+	memcpy(osi->wlact_set, dm->gnt.bt, sizeof(osi->wlact_set));
+
+	/* GBT source should be GBT_S1 in 1+1 (HWB0:5G + HWB1:2G) case */
+	if (osi->rf_band[BTC_RF_S0] == 1 &&
+	    osi->rf_band[BTC_RF_S1] == 0)
+		osi->rf_gbt_source = BTC_RF_S1;
+	else
+		osi->rf_gbt_source = BTC_RF_S0;
 }
 
 #define BTC_TDMA_WLROLE_MAX 3
-- 
2.25.1


