Return-Path: <linux-wireless+bounces-14882-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DDA9BB82A
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 15:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F55B271DB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2041369B6;
	Mon,  4 Nov 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lXS/O6AD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD7433FE;
	Mon,  4 Nov 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730731423; cv=none; b=Gv6FA2GVYB4MqhCGjUbXgrBhi0zM8yYdeal83BZ2upbwQoG3Astoy/jatNhZOplaVr/Ar2s/07yPqknXp8OBDhx4xyWStgzkD1el0znz4/AjYtmzrcElJQ9N0RKrjhAz98l78DrI3MTLJT7tv7chqBbp+LQ01HTO0lDpS0oI1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730731423; c=relaxed/simple;
	bh=ijgQU0+eO0qXU44b40w/VCG1UuGwEIvODuM/LYdJkAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/Efy8ucUW1uusnT9nxPpc9dBhjEll7fqo0SQaKO1uH/+dm3O8XeJTdRX2ETHTfpHKin5t0PqQCQJCbCHPQDHezxSGGDCAtu9izMfbVWiEjJmNvOa1frKKCzieg3ongruVebi/fve/MtFP3VEJNUOEBkS/F+uQIg4JLvnIKuVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lXS/O6AD; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=v9p+fDPULefYeYR05M2yrJxg/cfLTDU/hHtfl2JV4pU=; b=lXS/O6ADZI1vTbEZ
	dGn2EHwrgUKEyprPd53V2NXhU86SZIGkuDVBts3V+p/pWzWXtgkqhV3Sw3vrcIa51W3CMIDzt8bFn
	GNIOGI0wGRTNut3Cp3tJImC+h5VxEHWpFKNmyOF9n/zGdsZlN9mb1l2TW7QSKSvGq+ydeyo1e+GzV
	AFpRM1UciWPBbtjFKtGgnA7IgB1Bzc/jPMbpBuweLumJV78eqLmUFkYNzXnHRV2zbovA0ba3iKkhC
	YBBwf/RiWgUW+h60+/i6QETtAPmJTAD7AU4id437TwJsH9u83QsSVD4lQHBEHPVrksR8dQlkLFqqY
	zxAH+XwzDIAnfohWeA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7yIn-00FLmY-0e;
	Mon, 04 Nov 2024 14:43:33 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2] wifi: rtlwifi: Remove some exhalbtc deadcode
Date: Mon,  4 Nov 2024 14:43:31 +0000
Message-ID: <20241104144331.29262-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

exhalbtc_rf_status_notify(), exhalbtc_coex_dm_switch() and
exhalbtc_antenna_detection() are unused since they were added in 2017's
commit 7937f02d1953 ("rtlwifi: btcoex: hook external functions for newer
chips")

Remove them.

This leaves ex_btc8723b1ant_coex_dm_reset() unused.

Remove it.

exhalbtc_dbg_control(), exhalbtc_stack_update_profile_info(),
exhalbtc_set_hci_version(), and exhalbtc_set_bt_patch_version() are
unused since their addition in 2014 by
commit aa45a673b291 ("rtlwifi: btcoexist: Add new mini driver")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../rtlwifi/btcoexist/halbtc8723b1ant.c       | 11 ---
 .../rtlwifi/btcoexist/halbtc8723b1ant.h       |  1 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  | 79 -------------------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h  | 10 ---
 4 files changed, 101 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c
index 039bbedb41c2..379193b24428 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c
@@ -3409,17 +3409,6 @@ void ex_btc8723b1ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 	}
 }
 
-void ex_btc8723b1ant_coex_dm_reset(struct btc_coexist *btcoexist)
-{
-	struct rtl_priv *rtlpriv = btcoexist->adapter;
-
-	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-		"[BTCoex], *****************Coex DM Reset****************\n");
-
-	halbtc8723b1ant_init_hw_config(btcoexist, false, false);
-	halbtc8723b1ant_init_coex_dm(btcoexist);
-}
-
 void ex_btc8723b1ant_periodical(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.h
index 9d41e11388ad..a4506d838dc7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.h
@@ -197,7 +197,6 @@ void ex_btc8723b1ant_rf_status_notify(struct btc_coexist *btcoexist,
 				      u8 type);
 void ex_btc8723b1ant_halt_notify(struct btc_coexist *btcoexist);
 void ex_btc8723b1ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnpstate);
-void ex_btc8723b1ant_coex_dm_reset(struct btc_coexist *btcoexist);
 void ex_btc8723b1ant_periodical(struct btc_coexist *btcoexist);
 void ex_btc8723b1ant_display_coex_info(struct btc_coexist *btcoexist,
 				       struct seq_file *m);
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index be4c0e60d44d..478cca33e5e3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -1708,19 +1708,6 @@ void exhalbtc_bt_info_notify(struct btc_coexist *btcoexist,
 	halbtc_normal_low_power(btcoexist);
 }
 
-void exhalbtc_rf_status_notify(struct btc_coexist *btcoexist, u8 type)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-
-	if (IS_HARDWARE_TYPE_8821(btcoexist->adapter)) {
-	} else if (IS_HARDWARE_TYPE_8723B(btcoexist->adapter)) {
-		if (btcoexist->board_info.btdm_ant_num == 1)
-			ex_btc8723b1ant_rf_status_notify(btcoexist, type);
-	} else if (IS_HARDWARE_TYPE_8192E(btcoexist->adapter)) {
-	}
-}
-
 void exhalbtc_halt_notify(struct btc_coexist *btcoexist)
 {
 	if (!halbtc_is_bt_coexist_available(btcoexist))
@@ -1768,31 +1755,6 @@ void exhalbtc_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 	}
 }
 
-void exhalbtc_coex_dm_switch(struct btc_coexist *btcoexist)
-{
-	struct rtl_priv *rtlpriv = btcoexist->adapter;
-
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-	btcoexist->statistics.cnt_coex_dm_switch++;
-
-	halbtc_leave_low_power(btcoexist);
-
-	if (IS_HARDWARE_TYPE_8723B(btcoexist->adapter)) {
-		if (btcoexist->board_info.btdm_ant_num == 1) {
-			btcoexist->stop_coex_dm = true;
-			ex_btc8723b1ant_coex_dm_reset(btcoexist);
-			exhalbtc_set_ant_num(rtlpriv,
-					     BT_COEX_ANT_TYPE_DETECTED, 2);
-			ex_btc8723b2ant_init_hwconfig(btcoexist);
-			ex_btc8723b2ant_init_coex_dm(btcoexist);
-			btcoexist->stop_coex_dm = false;
-		}
-	}
-
-	halbtc_normal_low_power(btcoexist);
-}
-
 void exhalbtc_periodical(struct btc_coexist *btcoexist)
 {
 	if (!halbtc_is_bt_coexist_available(btcoexist))
@@ -1820,29 +1782,6 @@ void exhalbtc_periodical(struct btc_coexist *btcoexist)
 	halbtc_normal_low_power(btcoexist);
 }
 
-void exhalbtc_dbg_control(struct btc_coexist *btcoexist,
-			  u8 code, u8 len, u8 *data)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-	btcoexist->statistics.cnt_dbg_ctrl++;
-
-	halbtc_leave_low_power(btcoexist);
-
-	halbtc_normal_low_power(btcoexist);
-}
-
-void exhalbtc_antenna_detection(struct btc_coexist *btcoexist, u32 cent_freq,
-				u32 offset, u32 span, u32 seconds)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-}
-
-void exhalbtc_stack_update_profile_info(void)
-{
-}
-
 void exhalbtc_update_min_bt_rssi(struct btc_coexist *btcoexist, s8 bt_rssi)
 {
 	if (!halbtc_is_bt_coexist_available(btcoexist))
@@ -1851,24 +1790,6 @@ void exhalbtc_update_min_bt_rssi(struct btc_coexist *btcoexist, s8 bt_rssi)
 	btcoexist->stack_info.min_bt_rssi = bt_rssi;
 }
 
-void exhalbtc_set_hci_version(struct btc_coexist *btcoexist, u16 hci_version)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-
-	btcoexist->stack_info.hci_version = hci_version;
-}
-
-void exhalbtc_set_bt_patch_version(struct btc_coexist *btcoexist,
-				   u16 bt_hci_version, u16 bt_patch_version)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-
-	btcoexist->bt_info.bt_real_fw_ver = bt_patch_version;
-	btcoexist->bt_info.bt_hci_ver = bt_hci_version;
-}
-
 void exhalbtc_set_chip_type(struct btc_coexist *btcoexist, u8 chip_type)
 {
 	switch (chip_type) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
index a96a995dd850..d8d88a989806 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
@@ -763,19 +763,9 @@ void exhalbtc_mediastatus_notify(struct btc_coexist *btcoexist,
 void exhalbtc_special_packet_notify(struct btc_coexist *btcoexist, u8 pkt_type);
 void exhalbtc_bt_info_notify(struct btc_coexist *btcoexist, u8 *tmp_buf,
 			     u8 length);
-void exhalbtc_rf_status_notify(struct btc_coexist *btcoexist, u8 type);
 void exhalbtc_halt_notify(struct btc_coexist *btcoexist);
 void exhalbtc_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state);
-void exhalbtc_coex_dm_switch(struct btc_coexist *btcoexist);
 void exhalbtc_periodical(struct btc_coexist *btcoexist);
-void exhalbtc_dbg_control(struct btc_coexist *btcoexist, u8 code, u8 len,
-			  u8 *data);
-void exhalbtc_antenna_detection(struct btc_coexist *btcoexist, u32 cent_freq,
-				u32 offset, u32 span, u32 seconds);
-void exhalbtc_stack_update_profile_info(void);
-void exhalbtc_set_hci_version(struct btc_coexist *btcoexist, u16 hci_version);
-void exhalbtc_set_bt_patch_version(struct btc_coexist *btcoexist,
-				   u16 bt_hci_version, u16 bt_patch_version);
 void exhalbtc_update_min_bt_rssi(struct btc_coexist *btcoexist, s8 bt_rssi);
 void exhalbtc_set_bt_exist(struct btc_coexist *btcoexist, bool bt_exist);
 void exhalbtc_set_chip_type(struct btc_coexist *btcoexist, u8 chip_type);
-- 
2.47.0


