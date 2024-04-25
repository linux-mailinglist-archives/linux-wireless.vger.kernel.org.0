Return-Path: <linux-wireless+bounces-6835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367338B202E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7AE288F6C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2B912A16C;
	Thu, 25 Apr 2024 11:28:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008983CCD
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044532; cv=none; b=M3TChyyrtyM8r7v8KCRs+s9Sv9kEalUt1cPVfzXfM4ya+UsQcilvxwRlp8c4OleWOqNG3HOTjepvZz9Yzb/eTrpLZoWCgSy//ISoMHOr120Um2JgnczGIraXPTTQ8KYvqd/vMp3DjM3aO5QcSb0CL0QQAsXe5gczxWDY/2OY+MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044532; c=relaxed/simple;
	bh=WKXRFEY/FAdH6+wuPAxppGrfKMglAxG4tZ4jCJ/EY1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pnv/93oZBVxyXLWjnq4F3XLs6iZk2l7mYI1FlgR5zVeO1jIi5cVwjs2XhRecvIsU6gWfc4hsmw1FpGdgbtem/DSK5R8ht6rG1x/bOaKjN0cruA/C/jtZRB+VJTCwpU58YJRnZ2m3fPoLtQszdx6EHKDCewulwSRb/sASqP0r+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43PBSmGsA3482257, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43PBSmGsA3482257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 19:28:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 19:28:48 +0800
Received: from [127.0.1.1] (172.16.16.129) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 25 Apr
 2024 19:28:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH 02/12] wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power mode
Date: Thu, 25 Apr 2024 19:28:06 +0800
Message-ID: <20240425112816.26431-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240425112816.26431-1-pkshih@realtek.com>
References: <20240425112816.26431-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chih-Kang Chang <gary.chang@realtek.com>

After enabling packet offload, the TX will be stuck after resume from
WoWLAN mode. And the 8852c gets error messages like

rtw89_8852ce 0000:04:00.0: No busy txwd pages available
rtw89_8852ce 0000:04:00.0: queue 0 txwd 100 is not idle
rtw89_8852ce 0000:04:00.0: queue 0 txwd 101 is not idle
rtw89_8852ce 0000:04:00.0: queue 0 txwd 102 is not idle
rtw89_8852ce 0000:04:00.0: queue 0 txwd 103 is not idle

If suspend/resume many times that firmware will download failed and
disconnection.

To fix these issues, We removed the rtw89_hci_disable_intr() and
rtw89_hci_enable_intr() during rtw89_wow_swap_fw() to prevent add packet
offload can't receive c2h back due to interrupt disable. Only 8852C and
8922A needs to disable interrupt before downloading fw.

Furthermore, we avoid using low power HCI mode on WoWLAN mode, to prevent
interrupt enabled, then get interrupt and calculate RXBD mismatched due to
software RXBD index already reset but hardware RXBD index not yet.

Fixes: 5c12bb66b79d ("wifi: rtw89: refine packet offload flow")
Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/ps.c  |  3 ++-
 drivers/net/wireless/realtek/rtw89/wow.c | 12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 31290d8cb7f7..92074b73ebeb 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -55,7 +55,8 @@ static void rtw89_ps_power_mode_change_with_hci(struct rtw89_dev *rtwdev,
 
 static void rtw89_ps_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 {
-	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode))
+	if (rtwdev->chip->low_power_hci_modes & BIT(rtwdev->ps_mode) &&
+	    !test_bit(RTW89_FLAG_WOWLAN, rtwdev->flags))
 		rtw89_ps_power_mode_change_with_hci(rtwdev, enter);
 	else
 		rtw89_mac_power_mode_change(rtwdev, enter);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index f7e96fcbbaba..ea555f29442d 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -458,14 +458,17 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool include_bb = !!chip->bbmcu_nr;
+	bool disable_intr_for_dlfw = false;
 	struct ieee80211_sta *wow_sta;
 	struct rtw89_sta *rtwsta = NULL;
 	bool is_conn = true;
 	int ret;
 
-	rtw89_hci_disable_intr(rtwdev);
+	if (chip_id == RTL8852C || chip_id == RTL8922A)
+		disable_intr_for_dlfw = true;
 
 	wow_sta = ieee80211_find_sta(wow_vif, rtwvif->bssid);
 	if (wow_sta)
@@ -473,12 +476,18 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 	else
 		is_conn = false;
 
+	if (disable_intr_for_dlfw)
+		rtw89_hci_disable_intr(rtwdev);
+
 	ret = rtw89_fw_download(rtwdev, fw_type, include_bb);
 	if (ret) {
 		rtw89_warn(rtwdev, "download fw failed\n");
 		return ret;
 	}
 
+	if (disable_intr_for_dlfw)
+		rtw89_hci_enable_intr(rtwdev);
+
 	rtw89_phy_init_rf_reg(rtwdev, true);
 
 	ret = rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, rtwsta,
@@ -524,7 +533,6 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 		rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, RTW89_PHY_0, 5);
 
 	rtw89_mac_hw_mgnt_sec(rtwdev, wow);
-	rtw89_hci_enable_intr(rtwdev);
 
 	return 0;
 }
-- 
2.25.1


