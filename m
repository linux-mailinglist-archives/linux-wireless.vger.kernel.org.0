Return-Path: <linux-wireless+bounces-7088-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE78B9366
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170D71F2346F
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3995171AA;
	Thu,  2 May 2024 02:25:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3B21862F
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616727; cv=none; b=ooadresdXXVt1dWpTlki3FsH9v2ONmYAHNRqGBoSRrma4VdNP2JGkBTASOCx2514521JFhstwMorL3CVJ8OkJq1IDpBLGC3/VTHG/tfOvdhKs61fM8C9SFpPEtGDcuDC9uhL50zrqZYmczZArfSOETXYXCjkUh5zkJQC7uzwSX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616727; c=relaxed/simple;
	bh=Epnh8Zz6nAbgQp9ljunITpwsy7xtbtb7BSkqfljswAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uIZQNGVO0bDLFuLC1iZNXKSEBHieYJBKeaXfLtNdEJX/lCmnK7TAWHgAuhi7QmqidX34R/yWCiwQVuAvUIcfcGUgTRt9H3zquzH22Af4x9JEsRUfEhW7j92k/g3N19XCfpymB8AHiCIJ429pNu93+aLYo4Zv7R57wpZ1RtG5Im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422PL3b82026285, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422PL3b82026285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:25:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:25:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:25:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH v2 01/12] wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
Date: Thu, 2 May 2024 10:24:54 +0800
Message-ID: <20240502022505.28966-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502022505.28966-1-pkshih@realtek.com>
References: <20240502022505.28966-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

802.11be WiFi chips need a RFK (RF calibration) notify H2C command after
downloading WoWLAN firmware to make sure RF TX/RX work fine when leaving
power save mode, so add it to correct RF TX/RX in WoWLAN mode.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/wow.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index ccad026defb5..f7e96fcbbaba 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -454,6 +454,7 @@ static int rtw89_wow_check_fw_status(struct rtw89_dev *rtwdev, bool wow_enable)
 static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 {
 	enum rtw89_fw_type fw_type = wow ? RTW89_FW_WOWLAN : RTW89_FW_NORMAL;
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct ieee80211_vif *wow_vif = rtw_wow->wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
@@ -519,6 +520,9 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 		rtw89_chip_cfg_txpwr_ul_tb_offset(rtwdev, wow_vif);
 	}
 
+	if (chip_gen == RTW89_CHIP_BE)
+		rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, RTW89_PHY_0, 5);
+
 	rtw89_mac_hw_mgnt_sec(rtwdev, wow);
 	rtw89_hci_enable_intr(rtwdev);
 
-- 
2.25.1


