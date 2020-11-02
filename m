Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F662A293B
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Nov 2020 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgKBL0j (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Nov 2020 06:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgKBLZA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Nov 2020 06:25:00 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4066C061A48
        for <linux-wireless@vger.kernel.org>; Mon,  2 Nov 2020 03:24:59 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 33so3352123wrl.7
        for <linux-wireless@vger.kernel.org>; Mon, 02 Nov 2020 03:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Pvo42v/kJ/vLmxqQnQsm2TCAkZQVRpe9y8RdPxlBHY=;
        b=kiYyEpRLzuA8lk60AYv8IA4Y+hGNe1AjIWaQeOy7Ws/idMRJ6A/pgdhraTwcZziE5/
         TPBOYJ0p36URj13Rwy9/MEUrnUbItohwVTmQ/jEVQXkx5KZm3oMSiTYZ9PaftBcsxe8V
         ohKsLOwwxoS9rAQYN7/IUezVhH5vuufmIWi0D2uweZScvF9oK752VrEkJ3yNXhEShGkP
         4FydRoZ/2pEcem1VWVEYES714X9TldVD34jPDTtnYJEb40S9Pc01NGyajTbK0bbIGD7E
         59CRQcoIoOTox+clhVnAORT/aKSm7g2R1A5+RQ4M3zHELyPrVE/mBmTkgsCc6criB5HB
         hkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Pvo42v/kJ/vLmxqQnQsm2TCAkZQVRpe9y8RdPxlBHY=;
        b=AWhLnDHTtF87zclwpVPrSeMNvK79QSF7B0djyyjP7G6K9kqXaDhHRQ1qn1YDMGg1RM
         PM4wg6Ya0Y4i2V6WnoewMZpA+APZRCAQt5pxOqFw8NhhLvLxHNcudp2tkJuBJsE3oUmq
         CLrG44BzBgq3FXQMB/ox9ZTAqZaW6ff/kgC6KucMSBNmCGJ938rVxOXNn+npXK+lCY+l
         mtmFCd7RkRi3c08eb1AIFOjyl5Rt0aMUZ9vqE6ukbKrl2sfsy1vAby0wYbvfigbsTjmU
         VMhOnVqkHMAhCvfOviLBfOVp4KnrpjROeDlTNJmOtYnONsS8a3J7sJ2fu/CSk5oGl+WV
         eyLw==
X-Gm-Message-State: AOAM5332RX2Z/nAYmEODH1rGpAeowQ4elzg21viZN7+WSjWs4Cg/+3YR
        iub2HAtN4Vtij/eUtwfmOCcLBA==
X-Google-Smtp-Source: ABdhPJwGxwzfBfHUY2LMmHWG8zdlcXGWtE7PUwZJlDnnRDZWHi0lEqWB/fD6OcWDX5ElSU4CK12E6Q==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr20762894wrt.175.1604316298607;
        Mon, 02 Nov 2020 03:24:58 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id m14sm21867354wro.43.2020.11.02.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:24:58 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Ping-Ke Shih <pkshih@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 30/41] rtlwifi: halbtc8821a2ant: Remove a bunch of unused variables
Date:   Mon,  2 Nov 2020 11:23:59 +0000
Message-Id: <20201102112410.1049272-31-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201102112410.1049272-1-lee.jones@linaro.org>
References: <20201102112410.1049272-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c: In function ‘btc8821a2ant_action_bt_inquiry’:
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:1451:40: warning: variable ‘bt_rssi_state’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:1451:22: warning: variable ‘wifi_rssi_state1’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:1451:5: warning: variable ‘wifi_rssi_state’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c: In function ‘btc8821a2ant_action_wifi_idle_process’:
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:1519:40: warning: variable ‘bt_rssi_state’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:1519:5: warning: variable ‘wifi_rssi_state’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c: In function ‘btc8821a2ant_action_pan_hs’:
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:2990:22: warning: variable ‘wifi_rssi_state1’ set but not used [-Wunused-but-set-variable]
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c: In function ‘btc8821a2ant_action_hid_a2dp’:
 drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c:3277:22: warning: variable ‘wifi_rssi_state1’ set but not used [-Wunused-but-set-variable]

Cc: Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../rtlwifi/btcoexist/halbtc8821a2ant.c       | 27 +++++++++----------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c
index e53789f11b08a..447caa4aad325 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c
@@ -1448,17 +1448,15 @@ static void btc8821a2ant_init_coex_dm(struct btc_coexist *btcoexist)
 static void btc8821a2ant_action_bt_inquiry(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
-	u8 wifi_rssi_state, wifi_rssi_state1, bt_rssi_state;
 	bool wifi_connected = false;
 	bool low_pwr_disable = true;
 	bool scan = false, link = false, roam = false;
 
-	wifi_rssi_state =
-		btc8821a2ant_wifi_rssi_state(btcoexist, 0, 2, 15, 0);
-	wifi_rssi_state1 = btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
+	btc8821a2ant_wifi_rssi_state(btcoexist, 0, 2, 15, 0);
+	btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
 				BT_8821A_2ANT_WIFI_RSSI_COEXSWITCH_THRES, 0);
-	bt_rssi_state = btc8821a2ant_bt_rssi_state(btcoexist,
-		2, BT_8821A_2ANT_BT_RSSI_COEXSWITCH_THRES, 0);
+	btc8821a2ant_bt_rssi_state(btcoexist,
+				2, BT_8821A_2ANT_BT_RSSI_COEXSWITCH_THRES, 0);
 
 	btcoexist->btc_set(btcoexist, BTC_SET_ACT_DISABLE_LOW_POWER,
 			   &low_pwr_disable);
@@ -1516,15 +1514,14 @@ static void btc8821a2ant_action_wifi_link_process(struct btc_coexist *btcoexist)
 static bool btc8821a2ant_action_wifi_idle_process(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
-	u8 wifi_rssi_state, wifi_rssi_state1, bt_rssi_state;
+	u8 wifi_rssi_state1;
 	u8 ap_num = 0;
 
-	wifi_rssi_state =
-		btc8821a2ant_wifi_rssi_state(btcoexist, 0, 2, 15, 0);
+	btc8821a2ant_wifi_rssi_state(btcoexist, 0, 2, 15, 0);
 	wifi_rssi_state1 = btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
 			BT_8821A_2ANT_WIFI_RSSI_COEXSWITCH_THRES - 20, 0);
-	bt_rssi_state = btc8821a2ant_bt_rssi_state(btcoexist,
-			2, BT_8821A_2ANT_BT_RSSI_COEXSWITCH_THRES, 0);
+	btc8821a2ant_bt_rssi_state(btcoexist,
+				2, BT_8821A_2ANT_BT_RSSI_COEXSWITCH_THRES, 0);
 
 	btcoexist->btc_get(btcoexist, BTC_GET_U1_AP_NUM, &ap_num);
 
@@ -2987,11 +2984,11 @@ static void btc8821a2ant_action_pan_edr(struct btc_coexist *btcoexist)
 /* PAN(HS) only */
 static void btc8821a2ant_action_pan_hs(struct btc_coexist *btcoexist)
 {
-	u8 wifi_rssi_state, wifi_rssi_state1, bt_rssi_state;
+	u8 wifi_rssi_state, bt_rssi_state;
 	u32 wifi_bw;
 
 	wifi_rssi_state = btc8821a2ant_wifi_rssi_state(btcoexist, 0, 2, 15, 0);
-	wifi_rssi_state1 = btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
+	btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
 				BT_8821A_2ANT_WIFI_RSSI_COEXSWITCH_THRES, 0);
 	bt_rssi_state = btc8821a2ant_bt_rssi_state(btcoexist,
 				2, BT_8821A_2ANT_BT_RSSI_COEXSWITCH_THRES, 0);
@@ -3274,11 +3271,11 @@ static void btc8821a2ant_act_hid_a2dp_pan_edr(struct btc_coexist *btcoexist)
 static void btc8821a2ant_action_hid_a2dp(struct btc_coexist *btcoexist)
 {
 	u32 wifi_bw;
-	u8 wifi_rssi_state, wifi_rssi_state1, bt_rssi_state;
+	u8 wifi_rssi_state, bt_rssi_state;
 	u8 ap_num = 0;
 
 	wifi_rssi_state = btc8821a2ant_wifi_rssi_state(btcoexist, 0, 2, 15, 0);
-	wifi_rssi_state1 = btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
+	btc8821a2ant_wifi_rssi_state(btcoexist, 1, 2,
 				BT_8821A_2ANT_WIFI_RSSI_COEXSWITCH_THRES, 0);
 	bt_rssi_state = btc8821a2ant_bt_rssi_state(btcoexist,
 				3, BT_8821A_2ANT_BT_RSSI_COEXSWITCH_THRES, 37);
-- 
2.25.1

