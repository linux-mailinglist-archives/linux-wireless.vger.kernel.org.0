Return-Path: <linux-wireless+bounces-14850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAB9BA66E
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 16:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 191642817B7
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Nov 2024 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFED8183CBE;
	Sun,  3 Nov 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="NHAQZaIq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD77189B82;
	Sun,  3 Nov 2024 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730648353; cv=none; b=PTVbQ+mSPYiwZDXF5o9f8HestvubKoP4slpuaL5+Wp/blJV/yS48WC27vnUo51SW0EIPr28L0hIQDjreqIjTQ6KjBKfV1Gyln5qU+ezObc3om3QGU6IgEw/CPDquz42VH2ZbQfF6oZP7vws4ArIfOYdiY1B3rkLNfZiKWEVqyQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730648353; c=relaxed/simple;
	bh=VrV5V8pPXmKij4eyzacWrrfe8cr4hHTzEO3Lac46D6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyQPt0UYJzhsR99vB4Oxz8HRpD9h609E0nOMP0zdixYW1EsZDlr5S2iWb6GfxQK43oEuTIMCv1Ds24TYadwRkfaHK48wk/QZ8ABg0xgE4aLKU1+EowkcpyEC8JtMI43CMSYgrLH1pJKw9Ie25H+SqpkutmmJzv3q29YUoQRk02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=NHAQZaIq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=DiM0W+kg+uOIF10fnTLqxEjyQYgvWTRXLvemg+S9EwQ=; b=NHAQZaIqai48yqgy
	31exwqhKXfgJHxinC6u3qdV8R/Jbk/xPSuaKbbFGbB1JKicurV6Rb6HcubpPF7i1KGUp0j4SvStvA
	gh6uPLntHqAdzKNmn3g5Ku0kNNfurtJLgo6NpeHECqClEnv5sjiKUG50OSyk7Zn3LnWKFuv6UEylP
	UmC1JA6xhapEfzmmYw22cg5pydL9xI3s+HTPxwXnh0tFCuT6GZPIM5ji8sxkORnwT0koj7fcbaBrb
	pOF9X1JW/eIX0gvwnN2KIlz9NbRGPtOA89CmdC2wDh4Cvxf6EMwrdk4eQmlAzzYeaCCpYDzV4jTD3
	VNCirrcYmi/gOcWAAw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1t7cgt-00FBKZ-0r;
	Sun, 03 Nov 2024 15:38:59 +0000
From: linux@treblig.org
To: pkshih@realtek.com,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/2] rtlwifi: Remove unused functions
Date: Sun,  3 Nov 2024 15:38:56 +0000
Message-ID: <20241103153857.255450-2-linux@treblig.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103153857.255450-1-linux@treblig.org>
References: <20241103153857.255450-1-linux@treblig.org>
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

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 .../rtlwifi/btcoexist/halbtc8723b1ant.c       | 11 -----
 .../rtlwifi/btcoexist/halbtc8723b1ant.h       |  1 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  | 45 -------------------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h  |  4 --
 4 files changed, 61 deletions(-)

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
index be4c0e60d44d..74c4504065c0 100644
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
@@ -1832,13 +1794,6 @@ void exhalbtc_dbg_control(struct btc_coexist *btcoexist,
 	halbtc_normal_low_power(btcoexist);
 }
 
-void exhalbtc_antenna_detection(struct btc_coexist *btcoexist, u32 cent_freq,
-				u32 offset, u32 span, u32 seconds)
-{
-	if (!halbtc_is_bt_coexist_available(btcoexist))
-		return;
-}
-
 void exhalbtc_stack_update_profile_info(void)
 {
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
index a96a995dd850..5d146fcb7852 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.h
@@ -763,15 +763,11 @@ void exhalbtc_mediastatus_notify(struct btc_coexist *btcoexist,
 void exhalbtc_special_packet_notify(struct btc_coexist *btcoexist, u8 pkt_type);
 void exhalbtc_bt_info_notify(struct btc_coexist *btcoexist, u8 *tmp_buf,
 			     u8 length);
-void exhalbtc_rf_status_notify(struct btc_coexist *btcoexist, u8 type);
 void exhalbtc_halt_notify(struct btc_coexist *btcoexist);
 void exhalbtc_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state);
-void exhalbtc_coex_dm_switch(struct btc_coexist *btcoexist);
 void exhalbtc_periodical(struct btc_coexist *btcoexist);
 void exhalbtc_dbg_control(struct btc_coexist *btcoexist, u8 code, u8 len,
 			  u8 *data);
-void exhalbtc_antenna_detection(struct btc_coexist *btcoexist, u32 cent_freq,
-				u32 offset, u32 span, u32 seconds);
 void exhalbtc_stack_update_profile_info(void);
 void exhalbtc_set_hci_version(struct btc_coexist *btcoexist, u16 hci_version);
 void exhalbtc_set_bt_patch_version(struct btc_coexist *btcoexist,
-- 
2.47.0


