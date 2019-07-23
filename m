Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0770FAB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 05:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGWDKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 23:10:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48975 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfGWDKp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 23:10:45 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6N3ARIK028393, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6N3ARIK028393
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 23 Jul 2019 11:10:27 +0800
Received: from localhost.localdomain (172.21.69.114) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Jul 2019 11:10:26 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <dcb314@hotmail.com>, <Larry.Finger@lwfinger.net>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtlwifi: remove assignment to itself
Date:   Tue, 23 Jul 2019 11:10:23 +0800
Message-ID: <20190723031023.6777-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.114]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Module parameters of 'sw_crypto' and 'disable_watchdog' are false by
default. If new value is desired, we can do it during inserting module,
assignment existing in source code is not reasonable.

Reported-by: David Binderman <dcb314@hotmail.com>
CC: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c | 2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c | 2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c | 2 --
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c | 4 ----
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c | 4 ----
 7 files changed, 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
index eab48fed61ed..a0eda51e833c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
@@ -115,10 +115,6 @@ int rtl88e_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
 	rtlpci->msi_support = rtlpriv->cfg->mod_params->msi_support;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		rtlpriv->cfg->mod_params->sw_crypto;
-	rtlpriv->cfg->mod_params->disable_watchdog =
-		rtlpriv->cfg->mod_params->disable_watchdog;
 	if (rtlpriv->cfg->mod_params->disable_watchdog)
 		pr_info("watchdog disabled\n");
 	if (!rtlpriv->psc.inactiveps)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
index a9c0111444bc..900788e4018c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
@@ -113,8 +113,6 @@ int rtl92c_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.inactiveps = rtlpriv->cfg->mod_params->inactiveps;
 	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		rtlpriv->cfg->mod_params->sw_crypto;
 	if (!rtlpriv->psc.inactiveps)
 		pr_info("rtl8192ce: Power Save off (module option)\n");
 	if (!rtlpriv->psc.fwctrl_lps)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index c1c34dca39d2..ab3e4aebad39 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -39,8 +39,6 @@ static int rtl92cu_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->dm.dm_flag = 0;
 	rtlpriv->dm.disable_framebursting = false;
 	rtlpriv->dm.thermalvalue = 0;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		rtlpriv->cfg->mod_params->sw_crypto;
 
 	/* for firmware buf */
 	rtlpriv->rtlhal.pfirmware = vzalloc(0x4000);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index d1d84e7d47a4..1c7ee569f4bf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -161,8 +161,6 @@ static int rtl92s_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.inactiveps = rtlpriv->cfg->mod_params->inactiveps;
 	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		rtlpriv->cfg->mod_params->sw_crypto;
 	if (!rtlpriv->psc.inactiveps)
 		pr_info("Power Save off (module option)\n");
 	if (!rtlpriv->psc.fwctrl_lps)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
index 4b370410c83c..5702ac6deebf 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
@@ -129,10 +129,6 @@ int rtl8723e_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
 	rtlpci->msi_support = rtlpriv->cfg->mod_params->msi_support;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		rtlpriv->cfg->mod_params->sw_crypto;
-	rtlpriv->cfg->mod_params->disable_watchdog =
-		rtlpriv->cfg->mod_params->disable_watchdog;
 	if (rtlpriv->cfg->mod_params->disable_watchdog)
 		pr_info("watchdog disabled\n");
 	rtlpriv->psc.reg_fwctrl_lps = 3;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 00e6254bf82b..3c8528f0ecb3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -128,10 +128,6 @@ int rtl8723be_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.swctrl_lps = rtlpriv->cfg->mod_params->swctrl_lps;
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
 	rtlpci->msi_support = rtlpriv->cfg->mod_params->msi_support;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		 rtlpriv->cfg->mod_params->sw_crypto;
-	rtlpriv->cfg->mod_params->disable_watchdog =
-		 rtlpriv->cfg->mod_params->disable_watchdog;
 	if (rtlpriv->cfg->mod_params->disable_watchdog)
 		pr_info("watchdog disabled\n");
 	rtlpriv->psc.reg_fwctrl_lps = 2;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
index eec7c4ecf3ad..3def6a2b3450 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
@@ -145,10 +145,6 @@ int rtl8821ae_init_sw_vars(struct ieee80211_hw *hw)
 	rtlpriv->psc.fwctrl_lps = rtlpriv->cfg->mod_params->fwctrl_lps;
 	rtlpci->msi_support = rtlpriv->cfg->mod_params->msi_support;
 	rtlpci->int_clear = rtlpriv->cfg->mod_params->int_clear;
-	rtlpriv->cfg->mod_params->sw_crypto =
-		rtlpriv->cfg->mod_params->sw_crypto;
-	rtlpriv->cfg->mod_params->disable_watchdog =
-		rtlpriv->cfg->mod_params->disable_watchdog;
 	if (rtlpriv->cfg->mod_params->disable_watchdog)
 		pr_info("watchdog disabled\n");
 	rtlpriv->psc.reg_fwctrl_lps = 2;
-- 
2.21.0

