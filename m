Return-Path: <linux-wireless+bounces-3375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C884F072
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71842B28CF7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B3657AA;
	Fri,  9 Feb 2024 06:53:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28751651BA
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461630; cv=none; b=sjdiREPaw9YmXa1j/Fk4FcdIDmqZpaLyaoFyCKZjfSiJp2bk7EWEJoSpL++H+enqlfRvS+UtlWHADCHvqVg2LuP8aiKHVXg7k8sAhYDmD7tGeErQL/5c9CDkZh5Rp7Xj6xLXNkkHu71Zw9EESK4r+Ms4YAisPIykjA0IbD87ibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461630; c=relaxed/simple;
	bh=Gqnm/gVqc2JGfTxIppAPs8VgVuKtVFeqp44sbQjHpoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mdn8Aucm+TX3d2ltGKrk4kyLbAwXeFwzNSzxwVx9E1W/JCOYoGbx1ukWlQ5QMMX8zKj+IfSqN3jI0NWydoC1XSUhekzuY2lUSzw677PFrOuave+N12A9FMjGEtKc7FZU/65B6egBRfcGtxuKq9ZPcJx/hTIqgGqQxLBqCTSUIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196rhYE3548402, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196rhYE3548402
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:53:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 9 Feb 2024 14:53:44 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:53:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 06/11] wifi: rtw89: use PLCP information to match BSS_COLOR and AID
Date: Fri, 9 Feb 2024 14:52:24 +0800
Message-ID: <20240209065229.34515-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209065229.34515-1-pkshih@realtek.com>
References: <20240209065229.34515-1-pkshih@realtek.com>
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

Hardware can use spatial reuse to reduce interference in OBSS environment,
and originally use MAC header to match BSS color and AID. Change to use
PLCP to match them earlier to prevent margin timing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    |  3 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  3 +++
 drivers/net/wireless/realtek/rtw89/reg.h    | 14 ++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index bad716cc9839..44d5195437de 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2537,6 +2537,9 @@ static int spatial_reuse_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_SR_CTRL, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_AX_SR_EN);
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BSSID_SRC_CTRL, mac_idx);
+	rtw89_write8_set(rtwdev, reg, B_AX_PLCP_SRC_EN);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f3c82751993c..f4b51183e3f4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -988,6 +988,9 @@ static int spatial_reuse_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_SR_CTRL, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_BE_SR_EN | B_BE_SR_CTRL_PLCP_EN);
 
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_BSSID_SRC_CTRL, mac_idx);
+	rtw89_write8_set(rtwdev, reg, B_BE_PLCP_SRC_EN);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 20b538526541..31bdc7616749 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3246,6 +3246,13 @@
 #define R_AX_RX_SR_CTRL_C1 0xEE4A
 #define B_AX_SR_EN BIT(0)
 
+#define R_AX_BSSID_SRC_CTRL 0xCE4B
+#define R_AX_BSSID_SRC_CTRL_C1 0xEE4B
+#define B_AX_BSSID_MATCH BIT(3)
+#define B_AX_PARTIAL_AID_MATCH BIT(2)
+#define B_AX_BSSCOLOR_MATCH BIT(1)
+#define B_AX_PLCP_SRC_EN BIT(0)
+
 #define R_AX_CSIRPT_OPTION 0xCE64
 #define R_AX_CSIRPT_OPTION_C1 0xEE64
 #define B_AX_CSIPRT_HESU_AID_EN BIT(25)
@@ -7208,6 +7215,13 @@
 #define B_BE_SR_CTRL_PLCP_EN BIT(1)
 #define B_BE_SR_EN BIT(0)
 
+#define R_BE_BSSID_SRC_CTRL 0x1144B
+#define R_BE_BSSID_SRC_CTRL_C1 0x1544B
+#define B_BE_BSSID_MATCH BIT(3)
+#define B_BE_PARTIAL_AID_MATCH BIT(2)
+#define B_BE_BSSCOLOR_MATCH BIT(1)
+#define B_BE_PLCP_SRC_EN BIT(0)
+
 #define R_BE_CSIRPT_OPTION 0x11464
 #define R_BE_CSIRPT_OPTION_C1 0x15464
 #define B_BE_CSIPRT_EHTSU_AID_EN BIT(26)
-- 
2.25.1


