Return-Path: <linux-wireless+bounces-15949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 331FF9E670B
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0182188571D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140E198840;
	Fri,  6 Dec 2024 05:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="JJ2Uy5aw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E74198A0F
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464666; cv=none; b=cVeRos514KuqDO7EoaROCSIBsOQCjJF7RMPDCR9cXXldzPZLkOb0ECmt4jXc1gbILGIcF2vWxlRtrPOqLd6FSwDYCHBRuk5x/IsJTla/4qS5S18SNXx9A24FO1Zrn22+mt5d77lLMB+5i98xtX5ardSPfiGjW9Y8lqCJn4wHeGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464666; c=relaxed/simple;
	bh=M+bKj+N/SSq1gfBJOSPMNfOw5ObTZ0wKCNyyVUXMz84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3v0nsx6npKCp+9+pkmijmZ6ztYZEsdd7FOFVC3Tz+S8G/J47tYnuePEJC8gtimv6Nf/EXQYUWWUd+wjAeQEVi+hL5gr9GuW8qv9m7QDzO64jVDfMvzVR/Lfpi3pkYJN+SZR4MVcqwNDiP/djtBoVnx2RfWxpIolGJQCfoYhFzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=JJ2Uy5aw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65veaV74127168, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464660; bh=M+bKj+N/SSq1gfBJOSPMNfOw5ObTZ0wKCNyyVUXMz84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JJ2Uy5awsrA65KxRS00DE/IBNpLCfCf6EVqeEDjuaGMSSSSRWyHKsxYlAAeUwfZrS
	 wkZ84/ssgZIMHkXYdtN9Ury4d5OAjiDpTcRTbdfA8QUrrnjKu3qenxPOJeeP2bD54o
	 uBcizymrfYDxSC6MkguDpZ5N5BqWsEavdEudEx/WAqgHoIZTb+SPrPi7DXWX2rMO44
	 BEVY6wIccKyDm37GTyojdKJRWT6YLDjJIrP3i1wBFCVah/067q/v+DaxSuoyfl49ok
	 iYKpV8nE7IAnhMKlPQ2HQqqYCO5ftxzaQalTQX6dpQxiEu3rdprmYtW9b3zXo7MXIW
	 bfuaerNzcOvMw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65veaV74127168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:57:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:57:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:57:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 1/7] wifi: rtw89: ps: refactor PS flow to support MLO
Date: Fri, 6 Dec 2024 13:57:10 +0800
Message-ID: <20241206055716.18598-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
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

Firmware can only support PS on single one VIF operating in station mode,
so argument of PS entry rtw89_enter_lps() should be rtwvif insetad of
rtwvif_link.

To enter PS under MLO, for each rtwvif, driver sends H2C command to tell
firmware which mac_id will enter PS one by one, and afterward asks
firmware to enter deep PS.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 26 ++++++------------
 drivers/net/wireless/realtek/rtw89/ps.c   | 33 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw89/ps.h   |  4 +--
 drivers/net/wireless/realtek/rtw89/wow.c  |  6 ++---
 4 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 29d0ac502bab..0519b0826281 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2729,10 +2729,6 @@ static enum rtw89_ps_mode rtw89_update_ps_mode(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	/* FIXME: Fix __rtw89_enter_ps_mode() to consider MLO cases. */
-	if (rtwdev->support_mlo)
-		return RTW89_PS_MODE_NONE;
-
 	if (rtw89_disable_ps_mode || !chip->ps_mode_supported ||
 	    RTW89_CHK_FW_FEATURE(NO_DEEP_PS, &rtwdev->fw))
 		return RTW89_PS_MODE_NONE;
@@ -3469,21 +3465,10 @@ static bool rtw89_traffic_stats_track(struct rtw89_dev *rtwdev)
 	return tfc_changed;
 }
 
-static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev,
-				struct rtw89_vif_link *rtwvif_link)
-{
-	if (rtwvif_link->wifi_role != RTW89_WIFI_ROLE_STATION &&
-	    rtwvif_link->wifi_role != RTW89_WIFI_ROLE_P2P_CLIENT)
-		return;
-
-	rtw89_enter_lps(rtwdev, rtwvif_link, true);
-}
-
 static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif_link *rtwvif_link;
+	struct ieee80211_vif *vif;
 	struct rtw89_vif *rtwvif;
-	unsigned int link_id;
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		if (rtwvif->tdls_peer)
@@ -3495,8 +3480,13 @@ static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
 		    rtwvif->stats.rx_tfc_lv != RTW89_TFC_IDLE)
 			continue;
 
-		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
-			rtw89_vif_enter_lps(rtwdev, rtwvif_link);
+		vif = rtwvif_to_vif(rtwvif);
+
+		if (!(vif->type == NL80211_IFTYPE_STATION ||
+		      vif->type == NL80211_IFTYPE_P2P_CLIENT))
+			continue;
+
+		rtw89_enter_lps(rtwdev, rtwvif, true);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index c1c12abc2ea9..5e3a5e3c9776 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -62,11 +62,8 @@ static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 		rtw89_mac_power_mode_change(rtwdev, enter);
 }
 
-void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link)
+void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev)
 {
-	if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
-		return;
-
 	if (!rtwdev->ps_mode)
 		return;
 
@@ -85,8 +82,8 @@ void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 		rtw89_ps_power_mode_change(rtwdev, false);
 }
 
-static void __rtw89_enter_lps(struct rtw89_dev *rtwdev,
-			      struct rtw89_vif_link *rtwvif_link)
+static void __rtw89_enter_lps_link(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_lps_parm lps_param = {
 		.macid = rtwvif_link->mac_id,
@@ -121,17 +118,27 @@ void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 	__rtw89_leave_ps_mode(rtwdev);
 }
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		     bool ps_mode)
 {
+	struct rtw89_vif_link *rtwvif_link;
+	bool can_ps_mode = true;
+	unsigned int link_id;
+
 	lockdep_assert_held(&rtwdev->mutex);
 
 	if (test_and_set_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
 
-	__rtw89_enter_lps(rtwdev, rtwvif_link);
-	if (ps_mode)
-		__rtw89_enter_ps_mode(rtwdev, rtwvif_link);
+	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id) {
+		__rtw89_enter_lps_link(rtwdev, rtwvif_link);
+
+		if (rtwvif_link->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT)
+			can_ps_mode = false;
+	}
+
+	if (ps_mode && can_ps_mode)
+		__rtw89_enter_ps_mode(rtwdev);
 }
 
 static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev,
@@ -282,12 +289,6 @@ void rtw89_recalc_lps(struct rtw89_dev *rtwdev)
 	enum rtw89_entity_mode mode;
 	int count = 0;
 
-	/* FIXME: Fix rtw89_enter_lps() and __rtw89_enter_ps_mode()
-	 * to take MLO cases into account before doing the following.
-	 */
-	if (rtwdev->support_mlo)
-		goto disable_lps;
-
 	mode = rtw89_get_entity_mode(rtwdev);
 	if (mode == RTW89_ENTITY_MODE_MCC)
 		goto disable_lps;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index cdd712966b09..2b88f254a32d 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -5,11 +5,11 @@
 #ifndef __RTW89_PS_H_
 #define __RTW89_PS_H_
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		     bool ps_mode);
 void rtw89_leave_lps(struct rtw89_dev *rtwdev);
 void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
-void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link);
+void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void rtw89_enter_ips(struct rtw89_dev *rtwdev);
 void rtw89_leave_ips(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 1e1dbb20d47a..01754d031bb4 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -694,9 +694,7 @@ static void rtw89_wow_leave_deep_ps(struct rtw89_dev *rtwdev)
 
 static void rtw89_wow_enter_deep_ps(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
-
-	__rtw89_enter_ps_mode(rtwdev, rtwvif_link);
+	__rtw89_enter_ps_mode(rtwdev);
 }
 
 static void rtw89_wow_enter_ps(struct rtw89_dev *rtwdev)
@@ -704,7 +702,7 @@ static void rtw89_wow_enter_ps(struct rtw89_dev *rtwdev)
 	struct rtw89_vif_link *rtwvif_link = rtwdev->wow.rtwvif_link;
 
 	if (rtw89_wow_mgd_linked(rtwdev))
-		rtw89_enter_lps(rtwdev, rtwvif_link, false);
+		rtw89_enter_lps(rtwdev, rtwvif_link->rtwvif, false);
 	else if (rtw89_wow_no_link(rtwdev))
 		rtw89_fw_h2c_fwips(rtwdev, rtwvif_link, true);
 }
-- 
2.25.1


