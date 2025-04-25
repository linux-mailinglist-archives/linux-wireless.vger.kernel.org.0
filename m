Return-Path: <linux-wireless+bounces-22092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BCDA9D673
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Apr 2025 01:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932561B885E0
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Apr 2025 23:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7834297A6E;
	Fri, 25 Apr 2025 23:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="mg8QfJNR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1166A297A5D;
	Fri, 25 Apr 2025 23:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745625241; cv=none; b=UWLvN/k1+zp7hlEufi++yPOkAWpcTydhDfUH3+p6wVtMjUcGxaDeUW8ibhJakEaLb1fSlkYeiQONMzuldtEXMibUD8BKpP/Q3xthFlgqtrdXVRxv/WsJsXxzN5H87+BkB5msqxiiZEP7Ag/UFyGGltf0az+AL7Ws6tcoNx1ShM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745625241; c=relaxed/simple;
	bh=VhixheG1Wplmz7S572+3BgDmsjmacYJa36yizj/aDtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LF6scRBGYFbEyMKCeeVu12lZjnSyg8JfzgksQAcda32O19wFpqttChMteXN6kJRjzHZJb4WskQNqJMpKiozVSMJy5O04Bm2uXjsrjp6OrS4Me64urb2x1ZshA9Rx2vFwR/m0ZkqUp5WJwhYh8UyuePyc2F1LDXkjO8NXIprahb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=mg8QfJNR; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=xn+8TrVL8Y3/LGl56SBQX3ieIVg7QnQS/KxOHtkrtM8=; b=mg8QfJNRAfz4t/nc
	1OZ4sbf1Ar/E1OUuse302pw1SLZm9Di79pkW8KvKtLCV1xUPV9XN2v5N8/MMj6ACAdu+P6iP/0prj
	Dg7MdE5E2BBnXd+GuyZCDMzeZ+1uRYnX9gyv0zkKR/mB4BYgpUOOfCQBlTivHQrgkjABWAoNNi6OS
	U9pBp9NXL1+RE/s/sF0tkErjVs/5XHk9Jw8oTgpr90xl5qQjQNKs78eqoHbWyf7NwX7CpoepCUz3+
	i83HteXrU41zozrxLOeiCBOT0DiIi2mz1R8aiMLjSKuSw8gIjIloB+P9q0QuzZtK02gsYYwgEmXCx
	OpZi+J0cMaKdGV51yw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1u8SrV-00Dznj-2C;
	Fri, 25 Apr 2025 23:53:41 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
Date: Sat, 26 Apr 2025 00:53:39 +0100
Message-ID: <20250425235340.288340-3-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425235340.288340-1-linux@treblig.org>
References: <20250425235340.288340-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

  rtl92d_phy_ap_calibrate(),
  rtl92du_phy_ap_calibrate(),
  rtl92ee_phy_ap_calibrate(), and
  rtl8821ae_phy_ap_calibrate()

are all empty function stubs that are never called anywhere.

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c | 5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c | 5 -----
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.h | 1 -
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.h | 1 -
 8 files changed, 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index e07402e73ba3..68f890050afb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -2055,11 +2055,6 @@ void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LCK:Finish!!!\n");
 }
 
-void rtl92d_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta)
-{
-	return;
-}
-
 static bool _rtl92d_phy_set_sw_chnl_cmdarray(struct swchnlcmd *cmdtable,
 		u32 cmdtableidx, u32 cmdtablesz, enum swchnlcmd_id cmdid,
 		u32 para1, u32 para2, u32 msdelay)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h
index bbe9ef77225e..a9bfe54f2802 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.h
@@ -83,7 +83,6 @@ void rtl92d_phy_set_poweron(struct ieee80211_hw *hw);
 bool rtl92d_phy_check_poweroff(struct ieee80211_hw *hw);
 void rtl92d_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t);
 void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw);
-void rtl92d_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta);
 void rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw);
 void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
index 289ec71ce3e5..8c2167cc1f13 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
@@ -2445,11 +2445,6 @@ void rtl92du_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "LCK:Finish!!!\n");
 }
 
-void rtl92du_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta)
-{
-	/* Nothing to do. */
-}
-
 u8 rtl92du_phy_sw_chnl(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
index 090a6203db7e..a107a5a76beb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
@@ -24,7 +24,6 @@ void rtl92du_phy_set_poweron(struct ieee80211_hw *hw);
 bool rtl92du_phy_check_poweroff(struct ieee80211_hw *hw);
 void rtl92du_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t);
 void rtl92du_update_bbrf_configuration(struct ieee80211_hw *hw);
-void rtl92du_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta);
 void rtl92du_phy_iq_calibrate(struct ieee80211_hw *hw);
 void rtl92du_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel);
 void rtl92du_phy_init_pa_bias(struct ieee80211_hw *hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index 73ef602bfb01..1e7f0cd1c86e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -2926,10 +2926,6 @@ void rtl92ee_phy_lc_calibrate(struct ieee80211_hw *hw)
 	rtlphy->lck_inprogress = false;
 }
 
-void rtl92ee_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta)
-{
-}
-
 void rtl92ee_phy_set_rfpath_switch(struct ieee80211_hw *hw, bool bmain)
 {
 	_rtl92ee_phy_set_rfpath_switch(hw, bmain, false);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.h
index 1a5dbc628379..ec4c26b81c48 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.h
@@ -119,7 +119,6 @@ void rtl92ee_phy_set_bw_mode(struct ieee80211_hw *hw,
 void rtl92ee_phy_sw_chnl_callback(struct ieee80211_hw *hw);
 u8 rtl92ee_phy_sw_chnl(struct ieee80211_hw *hw);
 void rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw, bool b_recovery);
-void rtl92ee_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta);
 void rtl92ee_phy_lc_calibrate(struct ieee80211_hw *hw);
 void rtl92ee_phy_set_rfpath_switch(struct ieee80211_hw *hw, bool bmain);
 bool rtl92ee_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index 9eddbada8af1..13a05066e8a6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -4586,10 +4586,6 @@ void rtl8821ae_phy_lc_calibrate(struct ieee80211_hw *hw)
 {
 }
 
-void rtl8821ae_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta)
-{
-}
-
 void rtl8821ae_phy_set_rfpath_switch(struct ieee80211_hw *hw, bool bmain)
 {
 	_rtl8821ae_phy_set_rfpath_switch(hw, bmain);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.h
index 35b7d0f70125..90bf5462a3f8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.h
@@ -214,7 +214,6 @@ void rtl8821ae_phy_iq_calibrate(struct ieee80211_hw *hw,
 				bool b_recovery);
 void rtl8812ae_phy_iq_calibrate(struct ieee80211_hw *hw,
 				bool b_recovery);
-void rtl8821ae_phy_ap_calibrate(struct ieee80211_hw *hw, s8 delta);
 void rtl8821ae_phy_lc_calibrate(struct ieee80211_hw *hw);
 void rtl8821ae_phy_set_rfpath_switch(struct ieee80211_hw *hw, bool bmain);
 bool rtl8812ae_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
-- 
2.49.0


