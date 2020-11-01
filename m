Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11AA2A21D1
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Nov 2020 22:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgKAVRW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Nov 2020 16:17:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbgKAVRV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Nov 2020 16:17:21 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604265439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7dfqGTYtqpcpmGTqy7nqHoH75ex9DbnMN+AG/6sfCw=;
        b=Tlr4dsNtCmfF2/kuPComNnd5xkzqoe4h9o7h9OCyO2zs4UQdD47qgl1XMiZs2XRWRYICsd
        gq+rLE/JvAt37sGrXyDNXge3lsSl2rvtZMZGYtQPv4Xiw59IhC/3wQycmK8XU2+JD99ktN
        wsyXXRwstKeMg+Bxh1FTtwPkcg/dXNA+1GdoSrKYU94a/eFcqJjByXh5IkcaiunMvYuOpO
        qhQ8XW5EGfrtXoarwC1duRp6xRd0C61bcaI+Mrm8LhNHdP3reiGAj2/1Bq4vm2feDduotU
        jhb5D4OTiP6VUOj9GAN8A99oTF7/kDk0sFB/1m4kOwV73Rag6Gwo1ZAnmrQk4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604265439;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R7dfqGTYtqpcpmGTqy7nqHoH75ex9DbnMN+AG/6sfCw=;
        b=I9UKaBvLknzfO/lJc5hpe7amspmzTqgHOuOrgX1e08MRYu/X9EWtdGvw6CuDCrPbLirGtR
        Wn4Te3rh9l8XoECw==
To:     linux-wireless@vger.kernel.org
Cc:     Jouni Malinen <j@w1.fi>, Kalle Valo <kvalo@codeaurora.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Ulrich Kunitz <kune@deine-taler.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 8/8] rtlwifi: Remove in_interrupt() usage in halbtc_send_bt_mp_operation()
Date:   Sun,  1 Nov 2020 22:15:36 +0100
Message-Id: <20201101211536.2966644-9-bigeasy@linutronix.de>
In-Reply-To: <20201101211536.2966644-1-bigeasy@linutronix.de>
References: <20201101211536.2966644-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

halbtc_send_bt_mp_operation() uses in_interrupt() to determine if it is
safe to invoke wait_for_completion().

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

Aside of that in_interrupt() is not correct as it does not catch preempt
disabled regions which neither can sleep.

halbtc_send_bt_mp_operation() is called from:

 rtl_watchdog_wq_callback()
   rtl_btc_periodical()
     halbtc_get()
       case BTC_GET_U4_BT_PATCH_VER:
         halbtc_get_bt_patch_version()

 which is preemtible context.

   rtl_c2h_content_parsing()
     btc_ops->btc_btinfo_notify()
       rtl_btc_btinfo_notify()
         exhalbtc_bt_info_notify()
           ex_btc8723b1ant_bt_info_notify()
	   ex_btc8821a1ant_bt_info_notify()
	   ex_btc8821a2ant_bt_info_notify()
             btcoexist->btc_set_bt_reg()
               halbtc_set_bt_reg()

   rtl_c2h_content_parsing() is in turn called from:

   rtl_c2hcmd_wq_callback()
     rtl_c2hcmd_launcher()

   which is preemptible context and from:

   _rtl_pci_rx_interrupt
     rtl_c2hcmd_enqueue()

   which is obviously not preemptible but limited to C2H_BT_MP commands
   which does invoke rtl_c2h_content_parsing().

Aside of that it can be reached from:

     halbtc_get()
       case BTC_GET_U4_SUPPORTED_FEATURE:
         halbtc_get_bt_coex_supported_feature()
       case BTC_GET_U4_BT_FORBIDDEN_SLOT_VAL:
         halbtc_get_bt_forbidden_slot_val()
       case BTC_GET_U4_BT_DEVICE_INFO:
         halbtc_get_bt_device_info()
       case BTC_GET_U4_SUPPORTED_VERSION:
         halbtc_get_bt_coex_supported_version()
       case BTC_GET_U4_SUPPORTED_FEATURE:
         halbtc_get_bt_coex_supported_feature()

   btcoexist->btc_get_bt_afh_map_from_bt()
     halbtc_get_bt_afh_map_from_bt()

   btcoexist->btc_get_ble_scan_para_from_bt()
     halbtc_get_ble_scan_para_from_bt()

   btcoexist->btc_get_ble_scan_type_from_bt()
     halbtc_get_ble_scan_type_from_bt()

   btcoexist->btc_get_ant_det_val_from_bt()
     halbtc_get_ant_det_val_from_bt()

   btcoexist->btc_get_bt_coex_supported_version()
     halbtc_get_bt_coex_supported_version()

   btcoexist->btc_get_bt_coex_supported_feature()
     halbtc_get_bt_coex_supported_feature()

None of these have a caller. Welcome to the wonderful world of HALs and
onion layers.

Remove in_interrupt() check.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c =
b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index 2155a6699ef8d..be4c0e60d44d1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -240,9 +240,6 @@ bool halbtc_send_bt_mp_operation(struct btc_coexist *bt=
coexist, u8 op_code,
 	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		"btmpinfo wait req_num=3D%d wait=3D%ld\n", req_num, wait_ms);
=20
-	if (in_interrupt())
-		return false;
-
 	if (wait_for_completion_timeout(&btcoexist->bt_mp_comp,
 					msecs_to_jiffies(wait_ms)) =3D=3D 0) {
 		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
--=20
2.29.1

