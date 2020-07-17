Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97ED82230EF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQCCp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgGQCC0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:26 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2DDC08C5DB
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:26 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id k22so6788668oib.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wsy3QokVH7mkTyTYLRF0tdsJ38KM5kptril+QS+xYRY=;
        b=L7kkrrXSS0br7JDYpQyy4xG0qdPpwv2+R1EE7EY2IsC3iEoORNYmBvaXDncMNATWOa
         sNn/t0v2G0bhgLoWrJB4L4poWHm795Lto8ZzK9bsx1VD4L3peX8/SIqBhYvoIWMT08Nb
         x/s/iRUpGIJHtX+2/qmHuF1mSRsJU44bhrC8VGAfV2Y1BRyV4ts1huyuq4y9JMWW3uu/
         s4arTIq8QAImkY/LoDZYua9DcnHH9yShzPbrFDWCed8KWNEZIAHueuWWIKrOgK+3xLqj
         MjPqg73Ugp479mNqZK4fENR9lg9VdbXK6FA2XzKDAXx0kmjnqSvnFUsaby63d79Bb9PK
         tdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Wsy3QokVH7mkTyTYLRF0tdsJ38KM5kptril+QS+xYRY=;
        b=B2QHEwYo6jdGG4jwvcL1u51k7FzRT8Ok3KE9pEN9lNVGScZYMfKDcCLFwErctgIgjq
         hn8zLN9sCBgXL3/0h7zvNYv1lqqdLxnEHRDtVDnQwSaus3ZnPdiCtWSgYqkbWCKVk1b4
         1QLJqOm7vjuZSjDIMeuwOBiuTYi7J9/7cs/J3I/Z4twijfdixgs2S92JL0Fqu9cdkicm
         mmh2UxIS2VK9Na97gayxG2tK5OR4aH+h1y0Vhora6bybKzwhTOAT3Ni0ClhGpjvMcRhP
         MSDmRiOD5FMZUIqea8OU3tS1wh54b6kNEmfLER8BVjPYwu6Mkd2AQgMPpf63RS7hnHeG
         am6A==
X-Gm-Message-State: AOAM533XBD8vkf9scayZncbCYa46s1pFAtWdhJvzpMXUX+qidvA/pB5m
        x74M78Mce82EMwu0dpH88V0=
X-Google-Smtp-Source: ABdhPJxJJpCRtzqmfY8cGoBHtrq+oG0AmuGqjN5LjhF7lPaajtlPDExmOYspnu5A/R/j15d5wvbTqw==
X-Received: by 2002:aca:30c8:: with SMTP id w191mr5677578oiw.120.1594951344208;
        Thu, 16 Jul 2020 19:02:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:23 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 02/14] rtlwifi: btcoexist: Replace RT_TRACE with RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:49 -0500
Message-Id: <20200717020201.18209-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the macro name in module btcoexist.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../rtlwifi/btcoexist/halbtc8192e2ant.c       | 286 ++++++++--------
 .../rtlwifi/btcoexist/halbtc8723b1ant.c       | 156 ++++-----
 .../rtlwifi/btcoexist/halbtc8723b2ant.c       | 300 ++++++++---------
 .../rtlwifi/btcoexist/halbtc8821a1ant.c       | 286 ++++++++--------
 .../rtlwifi/btcoexist/halbtc8821a2ant.c       | 308 +++++++++---------
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c  |  14 +-
 .../realtek/rtlwifi/btcoexist/rtl_btc.c       |   4 +-
 7 files changed, 677 insertions(+), 677 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c
index 658ff425c256..2ce8d9389e01 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8192e2ant.c
@@ -54,7 +54,7 @@ static u8 btc8192e2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT Rssi thresh error!!\n");
 			return coex_sta->pre_bt_rssi_state;
 		}
@@ -118,7 +118,7 @@ static u8 btc8192e2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], wifi RSSI thresh error!!\n");
 			return coex_sta->pre_wifi_rssi_state[index];
 		}
@@ -183,23 +183,23 @@ static void btc8192e2ant_monitor_bt_enable_disable(struct btc_coexist
 		bt_disabled = false;
 		btcoexist->btc_set(btcoexist, BTC_SET_BL_BT_DISABLE,
 				   &bt_disabled);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT is enabled !!\n");
 	} else {
 		bt_disable_cnt++;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bt all counters = 0, %d times!!\n",
 			 bt_disable_cnt);
 		if (bt_disable_cnt >= 2) {
 			bt_disabled = true;
 			btcoexist->btc_set(btcoexist, BTC_SET_BL_BT_DISABLE,
 					   &bt_disabled);
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT is disabled !!\n");
 		}
 	}
 	if (pre_bt_disabled != bt_disabled) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT is from %s to %s!!\n",
 			 (pre_bt_disabled ? "disabled" : "enabled"),
 			 (bt_disabled ? "disabled" : "enabled"));
@@ -398,10 +398,10 @@ static void btc8192e2ant_monitor_bt_ctr(struct btc_coexist *btcoexist)
 	coex_sta->low_priority_tx = reg_lp_tx;
 	coex_sta->low_priority_rx = reg_lp_rx;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex] High Priority Tx/Rx (reg 0x%x) = 0x%x(%d)/0x%x(%d)\n",
 		 reg_hp_txrx, reg_hp_tx, reg_hp_tx, reg_hp_rx, reg_hp_rx);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex] Low Priority Tx/Rx (reg 0x%x) = 0x%x(%d)/0x%x(%d)\n",
 		 reg_lp_txrx, reg_lp_tx, reg_lp_tx, reg_lp_rx, reg_lp_rx);
 
@@ -418,7 +418,7 @@ static void btc8192e2ant_query_bt_info(struct btc_coexist *btcoexist)
 
 	h2c_parameter[0] |= BIT0; /* trigger */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -526,7 +526,7 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_HS_OPERATION, &bt_hs_on);
 
 	if (!bt_link_info->bt_link_exist) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "No BT link exists!!!\n");
 		return algorithm;
 	}
@@ -542,27 +542,27 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 
 	if (num_of_diff_profile == 1) {
 		if (bt_link_info->sco_exist) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "SCO only\n");
 			algorithm = BT_8192E_2ANT_COEX_ALGO_SCO;
 		} else {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "HID only\n");
 				algorithm = BT_8192E_2ANT_COEX_ALGO_HID;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "A2DP only\n");
 				algorithm = BT_8192E_2ANT_COEX_ALGO_A2DP;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "PAN(HS) only\n");
 					algorithm =
 						BT_8192E_2ANT_COEX_ALGO_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "PAN(EDR) only\n");
 					algorithm =
@@ -573,21 +573,21 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 	} else if (num_of_diff_profile == 2) {
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "SCO + HID\n");
 				algorithm = BT_8192E_2ANT_COEX_ALGO_SCO;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "SCO + A2DP ==> SCO\n");
 				algorithm = BT_8192E_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO + PAN(HS)\n");
 					algorithm = BT_8192E_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO + PAN(EDR)\n");
 					algorithm =
@@ -598,13 +598,13 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (stack_info->num_of_hid >= 2) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "HID*2 + A2DP\n");
 					algorithm =
 					BT_8192E_2ANT_COEX_ALGO_HID_A2DP_PANEDR;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "HID + A2DP\n");
 					algorithm =
@@ -613,12 +613,12 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->hid_exist &&
 				   bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "HID + PAN(HS)\n");
 					algorithm = BT_8192E_2ANT_COEX_ALGO_HID;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "HID + PAN(EDR)\n");
 					algorithm =
@@ -627,13 +627,13 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8192E_2ANT_COEX_ALGO_A2DP_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "A2DP + PAN(EDR)\n");
 					algorithm =
@@ -645,18 +645,18 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "SCO + HID + A2DP ==> HID\n");
 				algorithm = BT_8192E_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (bt_link_info->hid_exist &&
 				   bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO + HID + PAN(HS)\n");
 					algorithm = BT_8192E_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO + HID + PAN(EDR)\n");
 					algorithm =
@@ -665,12 +665,12 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO + A2DP + PAN(HS)\n");
 					algorithm = BT_8192E_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO + A2DP + PAN(EDR)\n");
 					algorithm =
@@ -682,13 +682,13 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "HID + A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8192E_2ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "HID + A2DP + PAN(EDR)\n");
 					algorithm =
@@ -702,12 +702,12 @@ static u8 btc8192e2ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "ErrorSCO+HID+A2DP+PAN(HS)\n");
 
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "SCO+HID+A2DP+PAN(EDR)\n");
 					algorithm =
@@ -731,9 +731,9 @@ static void btc8192e2ant_set_fw_dac_swing_level(struct btc_coexist *btcoexist,
 	 */
 	h2c_parameter[0] = dac_swing_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Set Dac Swing Level = 0x%x\n", dac_swing_lvl);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x64 = 0x%x\n", h2c_parameter[0]);
 
 	btcoexist->btc_fill_h2c(btcoexist, 0x64, 1, h2c_parameter);
@@ -747,7 +747,7 @@ static void btc8192e2ant_set_fw_dec_bt_pwr(struct btc_coexist *btcoexist,
 
 	h2c_parameter[0] = dec_bt_pwr_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex] decrease Bt Power level = %d, FW write 0x62 = 0x%x\n",
 		 dec_bt_pwr_lvl, h2c_parameter[0]);
 
@@ -759,13 +759,13 @@ static void btc8192e2ant_dec_bt_pwr(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s Dec BT power level = %d\n",
 		 force_exec ? "force to" : "", dec_bt_pwr_lvl);
 	coex_dm->cur_dec_bt_pwr = dec_bt_pwr_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], preBtDecPwrLvl=%d, curBtDecPwrLvl=%d\n",
 			 coex_dm->pre_dec_bt_pwr, coex_dm->cur_dec_bt_pwr);
 	}
@@ -785,7 +785,7 @@ static void btc8192e2ant_set_bt_auto_report(struct btc_coexist *btcoexist,
 	if (enable_auto_report)
 		h2c_parameter[0] |= BIT0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], BT FW auto report : %s, FW write 0x68 = 0x%x\n",
 		 (enable_auto_report ? "Enabled!!" : "Disabled!!"),
 		 h2c_parameter[0]);
@@ -799,14 +799,14 @@ static void btc8192e2ant_bt_auto_report(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s BT Auto report = %s\n",
 		 (force_exec ? "force to" : ""),
 		 ((enable_auto_report) ? "Enabled" : "Disabled"));
 	coex_dm->cur_bt_auto_report = enable_auto_report;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex] bPreBtAutoReport=%d, bCurBtAutoReport=%d\n",
 			 coex_dm->pre_bt_auto_report,
 			 coex_dm->cur_bt_auto_report);
@@ -825,13 +825,13 @@ static void btc8192e2ant_fw_dac_swing_lvl(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s set FW Dac Swing level = %d\n",
 		 (force_exec ? "force to" : ""), fw_dac_swing_lvl);
 	coex_dm->cur_fw_dac_swing_lvl = fw_dac_swing_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex] preFwDacSwingLvl=%d, curFwDacSwingLvl=%d\n",
 			 coex_dm->pre_fw_dac_swing_lvl,
 			 coex_dm->cur_fw_dac_swing_lvl);
@@ -854,7 +854,7 @@ static void btc8192e2ant_set_sw_rf_rx_lpf_corner(struct btc_coexist *btcoexist,
 
 	if (rx_rf_shrink_on) {
 		/* Shrink RF Rx LPF corner */
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Shrink RF Rx LPF corner!!\n");
 		btcoexist->btc_set_rf_reg(btcoexist, BTC_RF_A, 0x1e,
 					  0xfffff, 0xffffc);
@@ -863,7 +863,7 @@ static void btc8192e2ant_set_sw_rf_rx_lpf_corner(struct btc_coexist *btcoexist,
 		 * After initialized, we can use coex_dm->btRf0x1eBackup
 		 */
 		if (btcoexist->initialized) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Resume RF Rx LPF corner!!\n");
 			btcoexist->btc_set_rf_reg(btcoexist, BTC_RF_A, 0x1e,
 						  0xfffff,
@@ -877,14 +877,14 @@ static void btc8192e2ant_rf_shrink(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn Rx RF Shrink = %s\n",
 		 (force_exec ? "force to" : ""),
 		 ((rx_rf_shrink_on) ? "ON" : "OFF"));
 	coex_dm->cur_rf_rx_lpf_shrink = rx_rf_shrink_on;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex]bPreRfRxLpfShrink=%d,bCurRfRxLpfShrink=%d\n",
 			 coex_dm->pre_rf_rx_lpf_shrink,
 			 coex_dm->cur_rf_rx_lpf_shrink);
@@ -905,7 +905,7 @@ static void btc8192e2ant_set_dac_swing_reg(struct btc_coexist *btcoexist,
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	u8 val = (u8)level;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Write SwDacSwing = 0x%x\n", level);
 	btcoexist->btc_write_1byte_bitmask(btcoexist, 0x883, 0x3e, val);
 }
@@ -926,7 +926,7 @@ static void btc8192e2ant_dac_swing(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn DacSwing=%s, dac_swing_lvl = 0x%x\n",
 		 (force_exec ? "force to" : ""),
 		 ((dac_swing_on) ? "ON" : "OFF"), dac_swing_lvl);
@@ -934,11 +934,11 @@ static void btc8192e2ant_dac_swing(struct btc_coexist *btcoexist,
 	coex_dm->cur_dac_swing_lvl = dac_swing_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreDacSwingOn=%d, preDacSwingLvl = 0x%x, ",
 			 coex_dm->pre_dac_swing_on,
 			 coex_dm->pre_dac_swing_lvl);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "bCurDacSwingOn=%d, curDacSwingLvl = 0x%x\n",
 			 coex_dm->cur_dac_swing_on,
 			 coex_dm->cur_dac_swing_lvl);
@@ -961,7 +961,7 @@ static void btc8192e2ant_set_agc_table(struct btc_coexist *btcoexist,
 
 	/* BB AGC Gain Table */
 	if (agc_table_en) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BB Agc Table On!\n");
 		btcoexist->btc_write_4byte(btcoexist, 0xc78, 0x0a1A0001);
 		btcoexist->btc_write_4byte(btcoexist, 0xc78, 0x091B0001);
@@ -970,7 +970,7 @@ static void btc8192e2ant_set_agc_table(struct btc_coexist *btcoexist,
 		btcoexist->btc_write_4byte(btcoexist, 0xc78, 0x061E0001);
 		btcoexist->btc_write_4byte(btcoexist, 0xc78, 0x051F0001);
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BB Agc Table Off!\n");
 		btcoexist->btc_write_4byte(btcoexist, 0xc78, 0xaa1A0001);
 		btcoexist->btc_write_4byte(btcoexist, 0xc78, 0xa91B0001);
@@ -986,14 +986,14 @@ static void btc8192e2ant_agc_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s %s Agc Table\n",
 		 (force_exec ? "force to" : ""),
 		 ((agc_table_en) ? "Enable" : "Disable"));
 	coex_dm->cur_agc_table_en = agc_table_en;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreAgcTableEn=%d, bCurAgcTableEn=%d\n",
 			 coex_dm->pre_agc_table_en,
 			 coex_dm->cur_agc_table_en);
@@ -1012,19 +1012,19 @@ static void btc8192e2ant_set_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c0, val0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c4, val0x6c4);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c8, val0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc);
 	btcoexist->btc_write_1byte(btcoexist, 0x6cc, val0x6cc);
 }
@@ -1035,10 +1035,10 @@ static void btc8192e2ant_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s write Coex Table 0x6c0 = 0x%x, ",
 		 (force_exec ? "force to" : ""), val0x6c0);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "0x6c4 = 0x%x, 0x6c8 = 0x%x, 0x6cc = 0x%x\n",
 		 val0x6c4, val0x6c8, val0x6cc);
 	coex_dm->cur_val0x6c0 = val0x6c0;
@@ -1047,16 +1047,16 @@ static void btc8192e2ant_coex_table(struct btc_coexist *btcoexist,
 	coex_dm->cur_val0x6cc = val0x6cc;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], preVal0x6c0 = 0x%x, preVal0x6c4 = 0x%x, ",
 			 coex_dm->pre_val0x6c0, coex_dm->pre_val0x6c4);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "preVal0x6c8 = 0x%x, preVal0x6cc = 0x%x !!\n",
 			 coex_dm->pre_val0x6c8, coex_dm->pre_val0x6cc);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], curVal0x6c0 = 0x%x, curVal0x6c4 = 0x%x\n",
 			 coex_dm->cur_val0x6c0, coex_dm->cur_val0x6c4);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "curVal0x6c8 = 0x%x, curVal0x6cc = 0x%x !!\n",
 			 coex_dm->cur_val0x6c8, coex_dm->cur_val0x6cc);
 
@@ -1113,7 +1113,7 @@ static void btc8192e2ant_set_fw_ignore_wlan_act(struct btc_coexist *btcoexist,
 	if (enable)
 		h2c_parameter[0] |= BIT0; /* function enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex]set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -1125,16 +1125,16 @@ static void btc8192e2ant_ignore_wlan_act(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn Ignore WlanAct %s\n",
 		 (force_exec ? "force to" : ""), (enable ? "ON" : "OFF"));
 	coex_dm->cur_ignore_wlan_act = enable;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreIgnoreWlanAct = %d ",
 			 coex_dm->pre_ignore_wlan_act);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "bCurIgnoreWlanAct = %d!!\n",
 			 coex_dm->cur_ignore_wlan_act);
 
@@ -1166,7 +1166,7 @@ static void btc8192e2ant_set_fw_ps_tdma(struct btc_coexist *btcoexist, u8 byte1,
 	coex_dm->ps_tdma_para[3] = byte4;
 	coex_dm->ps_tdma_para[4] = byte5;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x60(5bytes) = 0x%x%08x\n",
 		 h2c_parameter[0],
 		 h2c_parameter[1] << 24 | h2c_parameter[2] << 16 |
@@ -1196,7 +1196,7 @@ static void btc8192e2ant_ps_tdma(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn %s PS TDMA, type=%d\n",
 		 (force_exec ? "force to" : ""),
 		 (turn_on ? "ON" : "OFF"), type);
@@ -1204,10 +1204,10 @@ static void btc8192e2ant_ps_tdma(struct btc_coexist *btcoexist,
 	coex_dm->cur_ps_tdma = type;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPrePsTdmaOn = %d, bCurPsTdmaOn = %d!!\n",
 			 coex_dm->pre_ps_tdma_on, coex_dm->cur_ps_tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], prePsTdma = %d, curPsTdma = %d!!\n",
 			 coex_dm->pre_ps_tdma, coex_dm->cur_ps_tdma);
 
@@ -1337,7 +1337,7 @@ static void btc8192e2ant_set_switch_ss_type(struct btc_coexist *btcoexist,
 	u8 mimops = BTC_MIMO_PS_DYNAMIC;
 	u32 dis_ra_mask = 0x0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], REAL set SS Type = %d\n", ss_type);
 
 	dis_ra_mask = btc8192e2ant_decide_ra_mask(btcoexist, ss_type,
@@ -1372,7 +1372,7 @@ static void btc8192e2ant_switch_ss_type(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s Switch SS Type = %d\n",
 		 (force_exec ? "force to" : ""), new_ss_type);
 	coex_dm->cur_ss_type = new_ss_type;
@@ -1456,7 +1456,7 @@ static bool btc8192e2ant_is_common_action(struct btc_coexist *btcoexist)
 		btcoexist->btc_set(btcoexist, BTC_SET_ACT_DISABLE_LOW_POWER,
 				   &low_pwr_disable);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi non-connected idle!!\n");
 
 		if ((BT_8192E_2ANT_BT_STATUS_NON_CONNECTED_IDLE ==
@@ -1491,7 +1491,7 @@ static bool btc8192e2ant_is_common_action(struct btc_coexist *btcoexist)
 					   BTC_SET_ACT_DISABLE_LOW_POWER,
 					   &low_pwr_disable);
 
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Wifi connected + BT non connected-idle!!\n");
 
 			btc8192e2ant_switch_ss_type(btcoexist, NORMAL_EXEC, 2);
@@ -1517,7 +1517,7 @@ static bool btc8192e2ant_is_common_action(struct btc_coexist *btcoexist)
 
 			if (bt_hs_on)
 				return false;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Wifi connected + BT connected-idle!!\n");
 
 			btc8192e2ant_switch_ss_type(btcoexist,
@@ -1543,11 +1543,11 @@ static bool btc8192e2ant_is_common_action(struct btc_coexist *btcoexist)
 					   &low_pwr_disable);
 
 			if (wifi_busy) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "Wifi Connected-Busy + BT Busy!!\n");
 				common = false;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "Wifi Connected-Idle + BT Busy!!\n");
 
 				btc8192e2ant_switch_ss_type(btcoexist,
@@ -1580,12 +1580,12 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	static int up, dn, m, n, wait_cnt;
 	u8 retry_cnt = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], TdmaDurationAdjust()\n");
 
 	if (!coex_dm->auto_tdma_adjust) {
 		coex_dm->auto_tdma_adjust = true;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], first run TdmaDurationAdjust()!!\n");
 		if (sco_hid) {
 			if (tx_pause) {
@@ -1669,9 +1669,9 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	} else {
 		/* accquire the BT TRx retry count from BT_Info byte2 */
 		retry_cnt = coex_sta->bt_retry_cnt;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], retry_cnt = %d\n", retry_cnt);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], up=%d, dn=%d, m=%d, n=%d, wait_cnt=%d\n",
 			 up, dn, m, n, wait_cnt);
 		wait_cnt++;
@@ -1688,7 +1688,7 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 				n = 3;
 				up = 0;
 				dn = 0;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex]Increase wifi duration!!\n");
 			}
 		} else if (retry_cnt <= 3) {
@@ -1711,7 +1711,7 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 				up = 0;
 				dn = 0;
 				wait_cnt = 0;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "Reduce wifi duration for retry<3\n");
 			}
 		} else {
@@ -1727,11 +1727,11 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 			up = 0;
 			dn = 0;
 			wait_cnt = 0;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Decrease wifi duration for retryCounter>3!!\n");
 		}
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], max Interval = %d\n", max_interval);
 	}
 
@@ -1742,9 +1742,9 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	if (coex_dm->cur_ps_tdma != coex_dm->tdma_adj_type) {
 		bool scan = false, link = false, roam = false;
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], PsTdma type mismatch!!!, ");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "curPsTdma=%d, recordPsTdma=%d\n",
 			 coex_dm->cur_ps_tdma, coex_dm->tdma_adj_type);
 
@@ -1756,7 +1756,7 @@ static void btc8192e2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 			btc8192e2ant_ps_tdma(btcoexist, NORMAL_EXEC,
 					     true, coex_dm->tdma_adj_type);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], roaming/link/scan is under progress, will adjust next time!!!\n");
 	}
 }
@@ -1962,7 +1962,7 @@ static void btc8192e2ant_action_a2dp(struct btc_coexist *btcoexist)
 	     bt_rssi_state == BTC_RSSI_STATE_STAY_LOW) &&
 	    (wifi_rssi_state == BTC_RSSI_STATE_LOW ||
 	     wifi_rssi_state == BTC_RSSI_STATE_STAY_LOW)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], A2dp, wifi/bt rssi both LOW!!\n");
 		long_dist = true;
 	}
@@ -2464,17 +2464,17 @@ static void btc8192e2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	u8 algorithm = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], RunCoexistMechanism()===>\n");
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], return for Manual CTRL <===\n");
 		return;
 	}
 
 	if (coex_sta->under_ips) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is under IPS !!!\n");
 		return;
 	}
@@ -2482,23 +2482,23 @@ static void btc8192e2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	algorithm = btc8192e2ant_action_algorithm(btcoexist);
 	if (coex_sta->c2h_bt_inquiry_page &&
 	    (BT_8192E_2ANT_COEX_ALGO_PANHS != algorithm)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT is under inquiry/page scan !!\n");
 		btc8192e2ant_action_bt_inquiry(btcoexist);
 		return;
 	}
 
 	coex_dm->cur_algorithm = algorithm;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Algorithm = %d\n", coex_dm->cur_algorithm);
 
 	if (btc8192e2ant_is_common_action(btcoexist)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Action 2-Ant common\n");
 		coex_dm->auto_tdma_adjust = false;
 	} else {
 		if (coex_dm->cur_algorithm != coex_dm->pre_algorithm) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex] preAlgorithm=%d, curAlgorithm=%d\n",
 				 coex_dm->pre_algorithm,
 				 coex_dm->cur_algorithm);
@@ -2506,62 +2506,62 @@ static void btc8192e2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 		}
 		switch (coex_dm->cur_algorithm) {
 		case BT_8192E_2ANT_COEX_ALGO_SCO:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = SCO\n");
 			btc8192e2ant_action_sco(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_SCO_PAN:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = SCO+PAN(EDR)\n");
 			btc8192e2ant_action_sco_pan(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = HID\n");
 			btc8192e2ant_action_hid(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = A2DP\n");
 			btc8192e2ant_action_a2dp(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_A2DP_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = A2DP+PAN(HS)\n");
 			btc8192e2ant_action_a2dp_pan_hs(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = PAN(EDR)\n");
 			btc8192e2ant_action_pan_edr(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = HS mode\n");
 			btc8192e2ant_action_pan_hs(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_PANEDR_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = PAN+A2DP\n");
 			btc8192e2ant_action_pan_edr_a2dp(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_PANEDR_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = PAN(EDR)+HID\n");
 			btc8192e2ant_action_pan_edr_hid(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_HID_A2DP_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = HID+A2DP+PAN\n");
 			btc8192e2ant_action_hid_a2dp_pan_edr(btcoexist);
 			break;
 		case BT_8192E_2ANT_COEX_ALGO_HID_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = HID+A2DP\n");
 			btc8192e2ant_action_hid_a2dp(btcoexist);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "Action 2-Ant, algorithm = unknown!!\n");
 			/* btc8192e2ant_coex_all_off(btcoexist); */
 			break;
@@ -2577,7 +2577,7 @@ static void btc8192e2ant_init_hwconfig(struct btc_coexist *btcoexist,
 	u16 u16tmp = 0;
 	u8 u8tmp = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 2Ant Init HW Config!!\n");
 
 	if (backup) {
@@ -2659,7 +2659,7 @@ void ex_btc8192e2ant_init_coex_dm(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Coex Mechanism Init!!\n");
 	btc8192e2ant_init_coex_dm(btcoexist);
 }
@@ -2876,12 +2876,12 @@ void ex_btc8192e2ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_IPS_ENTER == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS ENTER notify\n");
 		coex_sta->under_ips = true;
 		btc8192e2ant_coex_all_off(btcoexist);
 	} else if (BTC_IPS_LEAVE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS LEAVE notify\n");
 		coex_sta->under_ips = false;
 	}
@@ -2892,11 +2892,11 @@ void ex_btc8192e2ant_lps_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_LPS_ENABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS ENABLE notify\n");
 		coex_sta->under_lps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS DISABLE notify\n");
 		coex_sta->under_lps = false;
 	}
@@ -2907,10 +2907,10 @@ void ex_btc8192e2ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_SCAN_START == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 	else if (BTC_SCAN_FINISH == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 }
 
@@ -2919,10 +2919,10 @@ void ex_btc8192e2ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_ASSOCIATE_START == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 	else if (BTC_ASSOCIATE_FINISH == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 }
 
@@ -2940,10 +2940,10 @@ void ex_btc8192e2ant_media_status_notify(struct btc_coexist *btcoexist,
 		return;
 
 	if (BTC_MEDIA_CONNECT == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA connect notify\n");
 	else
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA disconnect notify\n");
 
 	/* only 2.4G we need to inform bt the chnl mask */
@@ -2964,7 +2964,7 @@ void ex_btc8192e2ant_media_status_notify(struct btc_coexist *btcoexist,
 	coex_dm->wifi_chnl_info[1] = h2c_parameter[1];
 	coex_dm->wifi_chnl_info[2] = h2c_parameter[2];
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x66 = 0x%x\n",
 		 h2c_parameter[0] << 16 | h2c_parameter[1] << 8 |
 		 h2c_parameter[2]);
@@ -2978,7 +2978,7 @@ void ex_btc8192e2ant_special_packet_notify(struct btc_coexist *btcoexist,
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (type == BTC_PACKET_DHCP)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], DHCP Packet notify\n");
 }
 
@@ -2998,7 +2998,7 @@ void ex_btc8192e2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		rsp_source = BT_INFO_SRC_8192E_2ANT_WIFI_FW;
 	coex_sta->bt_info_c2h_cnt[rsp_source]++;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Bt info[%d], length=%d, hex data = [",
 		 rsp_source, length);
 	for (i = 0; i < length; i++) {
@@ -3006,10 +3006,10 @@ void ex_btc8192e2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if (i == 1)
 			bt_info = tmp_buf[i];
 		if (i == length-1)
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x]\n", tmp_buf[i]);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x, ", tmp_buf[i]);
 	}
 
@@ -3028,7 +3028,7 @@ void ex_btc8192e2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		 * because bt is reset and loss of the info.
 		 */
 		if ((coex_sta->bt_info_ext & BIT1)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "bit1, send wifi BW&Chnl to BT!!\n");
 			btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_CONNECTED,
 					   &wifi_connected);
@@ -3045,7 +3045,7 @@ void ex_btc8192e2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if ((coex_sta->bt_info_ext & BIT3)) {
 			if (!btcoexist->manual_control &&
 			    !btcoexist->stop_coex_dm) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "bit3, BT NOT ignore Wlan active!\n");
 				btc8192e2ant_ignore_wlan_act(btcoexist,
 							     FORCE_EXEC,
@@ -3102,24 +3102,24 @@ void ex_btc8192e2ant_bt_info_notify(struct btc_coexist *btcoexist,
 
 	if (!(bt_info & BT_INFO_8192E_2ANT_B_CONNECTION)) {
 		coex_dm->bt_status = BT_8192E_2ANT_BT_STATUS_NON_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT Non-Connected idle!!!\n");
 	} else if (bt_info == BT_INFO_8192E_2ANT_B_CONNECTION) {
 		coex_dm->bt_status = BT_8192E_2ANT_BT_STATUS_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bt_infoNotify(), BT Connected-idle!!!\n");
 	} else if ((bt_info & BT_INFO_8192E_2ANT_B_SCO_ESCO) ||
 		   (bt_info & BT_INFO_8192E_2ANT_B_SCO_BUSY)) {
 		coex_dm->bt_status = BT_8192E_2ANT_BT_STATUS_SCO_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bt_infoNotify(), BT SCO busy!!!\n");
 	} else if (bt_info & BT_INFO_8192E_2ANT_B_ACL_BUSY) {
 		coex_dm->bt_status = BT_8192E_2ANT_BT_STATUS_ACL_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bt_infoNotify(), BT ACL busy!!!\n");
 	} else {
 		coex_dm->bt_status = BT_8192E_2ANT_BT_STATUS_MAX;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex]bt_infoNotify(), BT Non-Defined state!!!\n");
 	}
 
@@ -3145,7 +3145,7 @@ void ex_btc8192e2ant_halt_notify(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Halt notify\n");
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Halt notify\n");
 
 	btc8192e2ant_ignore_wlan_act(btcoexist, FORCE_EXEC, true);
 	ex_btc8192e2ant_media_status_notify(btcoexist, BTC_MEDIA_DISCONNECT);
@@ -3159,28 +3159,28 @@ void ex_btc8192e2ant_periodical(struct btc_coexist *btcoexist)
 	struct btc_board_info *board_info = &btcoexist->board_info;
 	struct btc_stack_info *stack_info = &btcoexist->stack_info;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "=======================Periodical=======================\n");
 	if (dis_ver_info_cnt <= 5) {
 		dis_ver_info_cnt += 1;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "************************************************\n");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "Ant PG Num/ Ant Mech/ Ant Pos = %d/ %d/ %d\n",
 			 board_info->pg_ant_num, board_info->btdm_ant_num,
 			 board_info->btdm_ant_pos);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "BT stack/ hci ext ver = %s / %d\n",
 			 ((stack_info->profile_notified) ? "Yes" : "No"),
 			 stack_info->hci_version);
 		btcoexist->btc_get(btcoexist, BTC_GET_U4_BT_PATCH_VER,
 				   &bt_patch_ver);
 		btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_FW_VER, &fw_ver);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "CoexVer/ FwVer/ PatchVer = %d_%x/ 0x%x/ 0x%x(%d)\n",
 			 glcoex_ver_date_8192e_2ant, glcoex_ver_8192e_2ant,
 			 fw_ver, bt_patch_ver, bt_patch_ver);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "************************************************\n");
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c
index 528e442f25a4..b30720c48edd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b1ant.c
@@ -468,7 +468,7 @@ static void btc8723b1ant_set_sw_pen_tx_rate_adapt(struct btc_coexist *btcoexist,
 		h2c_parameter[5] = 0xf9;  /* MCS5 or OFDM36 */
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set WiFi Low-Penalty Retry: %s",
 		 (low_penalty_ra ? "ON!!" : "OFF!!"));
 
@@ -496,19 +496,19 @@ static void halbtc8723b1ant_set_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c0, val0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c4, val0x6c4);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c8, val0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc);
 	btcoexist->btc_write_1byte(btcoexist, 0x6cc, val0x6cc);
 }
@@ -520,7 +520,7 @@ static void halbtc8723b1ant_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s write Coex Table 0x6c0 = 0x%x, 0x6c4 = 0x%x, 0x6cc = 0x%x\n",
 		 (force_exec ? "force to" : ""),
 		 val0x6c0, val0x6c4, val0x6cc);
@@ -636,7 +636,7 @@ halbtc8723b1ant_set_fw_ignore_wlan_act(struct btc_coexist *btcoexist,
 	if (enable)
 		h2c_parameter[0] |= BIT0;	/* function enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -648,13 +648,13 @@ static void halbtc8723b1ant_ignore_wlan_act(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn Ignore WlanAct %s\n",
 		 (force_exec ? "force to" : ""), (enable ? "ON" : "OFF"));
 	coex_dm->cur_ignore_wlan_act = enable;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreIgnoreWlanAct = %d, bCurIgnoreWlanAct = %d!!\n",
 			 coex_dm->pre_ignore_wlan_act,
 			 coex_dm->cur_ignore_wlan_act);
@@ -682,7 +682,7 @@ static void halbtc8723b1ant_set_fw_ps_tdma(struct btc_coexist *btcoexist,
 
 	if (ap_enable) {
 		if ((byte1 & BIT4) && !(byte1 & BIT5)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], FW for 1Ant AP mode\n");
 			real_byte1 &= ~BIT4;
 			real_byte1 |= BIT5;
@@ -704,7 +704,7 @@ static void halbtc8723b1ant_set_fw_ps_tdma(struct btc_coexist *btcoexist,
 	coex_dm->ps_tdma_para[3] = byte4;
 	coex_dm->ps_tdma_para[4] = real_byte5;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], PS-TDMA H2C cmd =0x%x%08x\n",
 		    h2c_parameter[0],
 		    h2c_parameter[1] << 24 |
@@ -731,20 +731,20 @@ static void halbtc8723b1ant_lps_rpwm(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s set lps/rpwm = 0x%x/0x%x\n",
 		 (force_exec ? "force to" : ""), lps_val, rpwm_val);
 	coex_dm->cur_lps = lps_val;
 	coex_dm->cur_rpwm = rpwm_val;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS-RxBeaconMode = 0x%x , LPS-RPWM = 0x%x!!\n",
 			 coex_dm->cur_lps, coex_dm->cur_rpwm);
 
 		if ((coex_dm->pre_lps == coex_dm->cur_lps) &&
 		    (coex_dm->pre_rpwm == coex_dm->cur_rpwm)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], LPS-RPWM_Last = 0x%x , LPS-RPWM_Now = 0x%x!!\n",
 				 coex_dm->pre_rpwm, coex_dm->cur_rpwm);
 
@@ -762,7 +762,7 @@ static void halbtc8723b1ant_sw_mechanism(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], SM[LpRA] = %d\n", low_penalty_ra);
 
 	halbtc8723b1ant_low_penalty_ra(btcoexist, NORMAL_EXEC, low_penalty_ra);
@@ -861,13 +861,13 @@ static void halbtc8723b1ant_set_ant_path(struct btc_coexist *btcoexist,
 								  0x49d);
 				cnt_bt_cal_chk++;
 				if (u8tmp & BIT(0)) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], ########### BT is calibrating (wait cnt=%d) ###########\n",
 						 cnt_bt_cal_chk);
 					mdelay(50);
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], ********** BT is NOT calibrating (wait cnt=%d)**********\n",
 						 cnt_bt_cal_chk);
@@ -1426,7 +1426,7 @@ void btc8723b1ant_tdma_dur_adj_for_acl(struct btc_coexist *btcoexist,
 	s32 result;
 	u8 retry_count = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], TdmaDurationAdjustForAcl()\n");
 
 	if ((wifi_status ==
@@ -1451,7 +1451,7 @@ void btc8723b1ant_tdma_dur_adj_for_acl(struct btc_coexist *btcoexist,
 
 	if (!coex_dm->auto_tdma_adjust) {
 		coex_dm->auto_tdma_adjust = true;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], first run TdmaDurationAdjust()!!\n");
 
 		halbtc8723b1ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 2);
@@ -1490,7 +1490,7 @@ void btc8723b1ant_tdma_dur_adj_for_acl(struct btc_coexist *btcoexist,
 				up = 0;
 				dn = 0;
 				result = 1;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Increase wifi duration!!\n");
 			}
 		} else if (retry_count <= 3) {
@@ -1523,7 +1523,7 @@ void btc8723b1ant_tdma_dur_adj_for_acl(struct btc_coexist *btcoexist,
 				dn = 0;
 				wait_count = 0;
 				result = -1;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Decrease wifi duration for retryCounter<3!!\n");
 			}
 		} else {
@@ -1548,7 +1548,7 @@ void btc8723b1ant_tdma_dur_adj_for_acl(struct btc_coexist *btcoexist,
 			dn = 0;
 			wait_count = 0;
 			result = -1;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Decrease wifi duration for retryCounter>3!!\n");
 		}
 
@@ -1690,7 +1690,7 @@ static void halbtc8723b1ant_monitor_bt_enable_disable(struct btc_coexist
 			bt_disabled = true;
 	}
 	if (coex_sta->bt_disabled != bt_disabled) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT is from %s to %s!!\n",
 			 (coex_sta->bt_disabled ? "disabled" : "enabled"),
 			 (bt_disabled ? "disabled" : "enabled"));
@@ -2029,14 +2029,14 @@ static void halbtc8723b1ant_action_wifi_connected(struct btc_coexist *btcoexist)
 	bool scan = false, link = false, roam = false;
 	bool under_4way = false, ap_enable = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], CoexForWifiConnect()===>\n");
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS,
 			   &under_4way);
 	if (under_4way) {
 		halbtc8723b1ant_action_wifi_connected_special_packet(btcoexist);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CoexForWifiConnect(), return for wifi is under 4way<===\n");
 		return;
 	}
@@ -2051,7 +2051,7 @@ static void halbtc8723b1ant_action_wifi_connected(struct btc_coexist *btcoexist)
 		else
 			halbtc8723b1ant_action_wifi_connected_special_packet(
 								     btcoexist);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CoexForWifiConnect(), return for wifi is under scan<===\n");
 		return;
 	}
@@ -2152,29 +2152,29 @@ static void halbtc8723b1ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	u32 num_of_wifi_link = 0;
 	u32 wifi_bw;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], RunCoexistMechanism()===>\n");
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for Manual CTRL <===\n");
 		return;
 	}
 
 	if (btcoexist->stop_coex_dm) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for Stop Coex DM <===\n");
 		return;
 	}
 
 	if (coex_sta->under_ips) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is under IPS !!!\n");
 		return;
 	}
 
 	if (coex_sta->bt_whck_test) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is under IPS !!!\n");
 		halbtc8723b1ant_action_bt_whck_test(btcoexist);
 		return;
@@ -2276,7 +2276,7 @@ static void halbtc8723b1ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	if (!wifi_connected) {
 		bool scan = false, link = false, roam = false;
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is non connected-idle !!!\n");
 
 		btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_SCAN, &scan);
@@ -2314,7 +2314,7 @@ static void halbtc8723b1ant_init_hw_config(struct btc_coexist *btcoexist,
 	u32 u32tmp = 0;
 	u8 u8tmpa = 0, u8tmpb = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 1Ant Init HW Config!!\n");
 
 	/* 0xf0[15:12] --> Chip Cut information */
@@ -2347,7 +2347,7 @@ static void halbtc8723b1ant_init_hw_config(struct btc_coexist *btcoexist,
 	u8tmpa = btcoexist->btc_read_1byte(btcoexist, 0x765);
 	u8tmpb = btcoexist->btc_read_1byte(btcoexist, 0x67);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "############# [BTCoex], 0x948=0x%x, 0x765=0x%x, 0x67=0x%x\n",
 		 u32tmp, u8tmpa, u8tmpb);
 }
@@ -2363,7 +2363,7 @@ void ex_btc8723b1ant_power_on_setting(struct btc_coexist *btcoexist)
 	u16 u16tmp = 0x0;
 	u32 value;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "xxxxxxxxxxxxxxxx Execute 8723b 1-Ant PowerOn Setting xxxxxxxxxxxxxxxx!!\n");
 
 	btcoexist->stop_coex_dm = true;
@@ -2436,7 +2436,7 @@ void ex_btc8723b1ant_init_coex_dm(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Coex Mechanism Init!!\n");
 
 	btcoexist->stop_coex_dm = false;
@@ -2718,7 +2718,7 @@ void ex_btc8723b1ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 		return;
 
 	if (BTC_IPS_ENTER == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS ENTER notify\n");
 		coex_sta->under_ips = true;
 
@@ -2729,7 +2729,7 @@ void ex_btc8723b1ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 		halbtc8723b1ant_coex_table_with_type(btcoexist,
 						     NORMAL_EXEC, 0);
 	} else if (BTC_IPS_LEAVE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS LEAVE notify\n");
 		coex_sta->under_ips = false;
 
@@ -2747,11 +2747,11 @@ void ex_btc8723b1ant_lps_notify(struct btc_coexist *btcoexist, u8 type)
 		return;
 
 	if (BTC_LPS_ENABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS ENABLE notify\n");
 		coex_sta->under_lps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS DISABLE notify\n");
 		coex_sta->under_lps = false;
 	}
@@ -2773,7 +2773,7 @@ void ex_btc8723b1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 
 	if (type == BTC_SCAN_START) {
 		coex_sta->wifi_is_high_pri_task = true;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 		/* Force antenna setup for no scan result issue */
 		halbtc8723b1ant_ps_tdma(btcoexist, FORCE_EXEC, false, 8);
@@ -2783,12 +2783,12 @@ void ex_btc8723b1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 		u8tmpa = btcoexist->btc_read_1byte(btcoexist, 0x765);
 		u8tmpb = btcoexist->btc_read_1byte(btcoexist, 0x67);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], 0x948=0x%x, 0x765=0x%x, 0x67=0x%x\n",
 			 u32tmp, u8tmpa, u8tmpb);
 	} else {
 		coex_sta->wifi_is_high_pri_task = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 
 		btcoexist->btc_get(btcoexist, BTC_GET_U1_AP_NUM,
@@ -2824,7 +2824,7 @@ void ex_btc8723b1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 	}
 
 	if (BTC_SCAN_START == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 		if (!wifi_connected)
 			/* non-connected scan */
@@ -2833,7 +2833,7 @@ void ex_btc8723b1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 			/* wifi is connected */
 			btc8723b1ant_action_wifi_conn_scan(btcoexist);
 	} else if (BTC_SCAN_FINISH == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 		if (!wifi_connected)
 			/* non-connected scan */
@@ -2866,12 +2866,12 @@ void ex_btc8723b1ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 		halbtc8723b1ant_ps_tdma(btcoexist, FORCE_EXEC, false, 8);
 		halbtc8723b1ant_set_ant_path(btcoexist, BTC_ANT_PATH_PTA,
 					     FORCE_EXEC, false, false);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 		coex_dm->arp_cnt = 0;
 	} else {
 		coex_sta->wifi_is_high_pri_task = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 	}
 
@@ -2896,11 +2896,11 @@ void ex_btc8723b1ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 	}
 
 	if (BTC_ASSOCIATE_START == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 		btc8723b1ant_act_wifi_not_conn_asso_auth(btcoexist);
 	} else if (BTC_ASSOCIATE_FINISH == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 
 		btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_CONNECTED,
@@ -2927,7 +2927,7 @@ void ex_btc8723b1ant_media_status_notify(struct btc_coexist *btcoexist,
 		return;
 
 	if (type == BTC_MEDIA_CONNECT) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA connect notify\n");
 		/* Force antenna setup for no scan result issue */
 		halbtc8723b1ant_ps_tdma(btcoexist, FORCE_EXEC, false, 8);
@@ -2958,7 +2958,7 @@ void ex_btc8723b1ant_media_status_notify(struct btc_coexist *btcoexist,
 		coex_dm->backup_ampdu_max_time =
 			btcoexist->btc_read_1byte(btcoexist, 0x456);
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA disconnect notify\n");
 		coex_dm->arp_cnt = 0;
 
@@ -2986,7 +2986,7 @@ void ex_btc8723b1ant_media_status_notify(struct btc_coexist *btcoexist,
 	coex_dm->wifi_chnl_info[1] = h2c_parameter[1];
 	coex_dm->wifi_chnl_info[2] = h2c_parameter[2];
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x66 = 0x%x\n",
 		 h2c_parameter[0] << 16 | h2c_parameter[1] << 8 |
 		 h2c_parameter[2]);
@@ -3014,11 +3014,11 @@ void ex_btc8723b1ant_special_packet_notify(struct btc_coexist *btcoexist,
 	if (type == BTC_PACKET_DHCP || type == BTC_PACKET_EAPOL ||
 	    type == BTC_PACKET_ARP) {
 		if (type == BTC_PACKET_ARP) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], special Packet ARP notify\n");
 
 			coex_dm->arp_cnt++;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], ARP Packet Count = %d\n",
 				 coex_dm->arp_cnt);
 
@@ -3031,12 +3031,12 @@ void ex_btc8723b1ant_special_packet_notify(struct btc_coexist *btcoexist,
 				coex_sta->wifi_is_high_pri_task = true;
 		} else {
 			coex_sta->wifi_is_high_pri_task = true;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], special Packet DHCP or EAPOL notify\n");
 		}
 	} else {
 		coex_sta->wifi_is_high_pri_task = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], special Packet [Type = %d] notify\n",
 			 type);
 	}
@@ -3065,7 +3065,7 @@ void ex_btc8723b1ant_special_packet_notify(struct btc_coexist *btcoexist,
 
 	if (BTC_PACKET_DHCP == type ||
 	    BTC_PACKET_EAPOL == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], special Packet(%d) notify\n", type);
 		halbtc8723b1ant_action_wifi_connected_special_packet(btcoexist);
 	}
@@ -3087,7 +3087,7 @@ void ex_btc8723b1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		rsp_source = BT_INFO_SRC_8723B_1ANT_WIFI_FW;
 	coex_sta->bt_info_c2h_cnt[rsp_source]++;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Bt info[%d], length=%d, hex data = [",
 		 rsp_source, length);
 	for (i = 0; i < length; i++) {
@@ -3095,10 +3095,10 @@ void ex_btc8723b1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if (i == 1)
 			bt_info = tmp_buf[i];
 		if (i == length - 1)
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x]\n", tmp_buf[i]);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x, ", tmp_buf[i]);
 	}
 
@@ -3142,7 +3142,7 @@ void ex_btc8723b1ant_bt_info_notify(struct btc_coexist *btcoexist,
 			/* BT into is responded by BT FW and BT RF REG
 			 * 0x3C != 0x15 => Need to switch BT TRx Mask
 			 */
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Switch BT TRx Mask since BT RF REG 0x3C != 0x15\n");
 			btcoexist->btc_set_bt_reg(btcoexist, BTC_BT_REG_RF,
 						  0x3c, 0x15);
@@ -3158,7 +3158,7 @@ void ex_btc8723b1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		 * because bt is reset and loss of the info.
 		 */
 		if (coex_sta->bt_info_ext & BIT1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT ext info bit1 check, send wifi BW&Chnl to BT!!\n");
 			btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_CONNECTED,
 					   &wifi_connected);
@@ -3173,7 +3173,7 @@ void ex_btc8723b1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if (coex_sta->bt_info_ext & BIT3) {
 			if (!btcoexist->manual_control &&
 			    !btcoexist->stop_coex_dm) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT ext info bit3 check, set BT NOT ignore Wlan active!!\n");
 				halbtc8723b1ant_ignore_wlan_act(btcoexist,
 								FORCE_EXEC,
@@ -3280,28 +3280,28 @@ void ex_btc8723b1ant_bt_info_notify(struct btc_coexist *btcoexist,
 
 	if (!(bt_info & BT_INFO_8723B_1ANT_B_CONNECTION)) {
 		coex_dm->bt_status = BT_8723B_1ANT_BT_STATUS_NON_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Connected idle!\n");
 	/* connection exists but no busy */
 	} else if (bt_info == BT_INFO_8723B_1ANT_B_CONNECTION) {
 		coex_dm->bt_status = BT_8723B_1ANT_BT_STATUS_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n");
 	} else if ((bt_info & BT_INFO_8723B_1ANT_B_SCO_ESCO) ||
 		(bt_info & BT_INFO_8723B_1ANT_B_SCO_BUSY)) {
 		coex_dm->bt_status = BT_8723B_1ANT_BT_STATUS_SCO_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT SCO busy!!!\n");
 	} else if (bt_info & BT_INFO_8723B_1ANT_B_ACL_BUSY) {
 		if (BT_8723B_1ANT_BT_STATUS_ACL_BUSY != coex_dm->bt_status)
 			coex_dm->auto_tdma_adjust = false;
 
 		coex_dm->bt_status = BT_8723B_1ANT_BT_STATUS_ACL_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT ACL busy!!!\n");
 	} else {
 		coex_dm->bt_status = BT_8723B_1ANT_BT_STATUS_MAX;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Defined state!!\n");
 	}
 
@@ -3322,15 +3322,15 @@ void ex_btc8723b1ant_rf_status_notify(struct btc_coexist *btcoexist, u8 type)
 	u32 u32tmp;
 	u8 u8tmpa, u8tmpb, u8tmpc;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], RF Status notify\n");
 
 	if (type == BTC_RF_ON) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RF is turned ON!!\n");
 		btcoexist->stop_coex_dm = false;
 	} else if (type == BTC_RF_OFF) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RF is turned OFF!!\n");
 
 		halbtc8723b1ant_power_save_state(btcoexist, BTC_PS_WIFI_NATIVE,
@@ -3347,7 +3347,7 @@ void ex_btc8723b1ant_rf_status_notify(struct btc_coexist *btcoexist, u8 type)
 		u8tmpb = btcoexist->btc_read_1byte(btcoexist, 0x67);
 		u8tmpc = btcoexist->btc_read_1byte(btcoexist, 0x76e);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "############# [BTCoex], 0x948=0x%x, 0x765=0x%x, 0x67=0x%x, 0x76e=0x%x\n",
 			 u32tmp, u8tmpa, u8tmpb, u8tmpc);
 	}
@@ -3357,7 +3357,7 @@ void ex_btc8723b1ant_halt_notify(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Halt notify\n");
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Halt notify\n");
 
 	btcoexist->stop_coex_dm = true;
 
@@ -3379,10 +3379,10 @@ void ex_btc8723b1ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Pnp notify\n");
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Pnp notify\n");
 
 	if (BTC_WIFI_PNP_SLEEP == pnp_state) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to SLEEP\n");
 		halbtc8723b1ant_set_ant_path(btcoexist, BTC_ANT_PATH_BT,
 					     FORCE_EXEC, false, true);
@@ -3401,7 +3401,7 @@ void ex_btc8723b1ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 		coex_sta->under_lps = false;
 		btcoexist->stop_coex_dm = true;
 	} else if (BTC_WIFI_PNP_WAKE_UP == pnp_state) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to WAKE UP\n");
 		btcoexist->stop_coex_dm = false;
 		halbtc8723b1ant_init_hw_config(btcoexist, false, false);
@@ -3414,7 +3414,7 @@ void ex_btc8723b1ant_coex_dm_reset(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], *****************Coex DM Reset****************\n");
 
 	halbtc8723b1ant_init_hw_config(btcoexist, false, false);
@@ -3426,7 +3426,7 @@ void ex_btc8723b1ant_periodical(struct btc_coexist *btcoexist)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	struct btc_bt_link_info *bt_link_info = &btcoexist->bt_link_info;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], ==========================Periodical===========================\n");
 
 	if (!btcoexist->auto_report_1ant) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
index 9f7b9af5bdcd..8385df292b0a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8723b2ant.c
@@ -53,27 +53,27 @@ static u8 btc8723b2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >= rssi_thresh +
 				       BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT) {
 				bt_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to High\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Low\n");
 			}
 		} else {
 			if (bt_rssi < rssi_thresh) {
 				bt_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Low\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT Rssi thresh error!!\n");
 			return coex_sta->pre_bt_rssi_state;
 		}
@@ -83,11 +83,11 @@ static u8 btc8723b2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >= rssi_thresh +
 				       BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT) {
 				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Medium\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Low\n");
 			}
 		} else if ((coex_sta->pre_bt_rssi_state ==
@@ -97,25 +97,25 @@ static u8 btc8723b2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >= rssi_thresh1 +
 				       BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT) {
 				bt_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to High\n");
 			} else if (bt_rssi < rssi_thresh) {
 				bt_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Low\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Medium\n");
 			}
 		} else {
 			if (bt_rssi < rssi_thresh1) {
 				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Medium\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at High\n");
 			}
 		}
@@ -144,27 +144,27 @@ static u8 btc8723b2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= rssi_thresh +
 					 BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT) {
 				wifi_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to High\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Low\n");
 			}
 		} else {
 			if (wifi_rssi < rssi_thresh) {
 				wifi_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Low\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], wifi RSSI thresh error!!\n");
 			return coex_sta->pre_wifi_rssi_state[index];
 		}
@@ -176,11 +176,11 @@ static u8 btc8723b2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= rssi_thresh +
 					BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT) {
 				wifi_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Medium\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Low\n");
 			}
 		} else if ((coex_sta->pre_wifi_rssi_state[index] ==
@@ -190,25 +190,25 @@ static u8 btc8723b2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= rssi_thresh1 +
 					 BTC_RSSI_COEX_THRESH_TOL_8723B_2ANT) {
 				wifi_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to High\n");
 			} else if (wifi_rssi < rssi_thresh) {
 				wifi_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Low\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Medium\n");
 			}
 		} else {
 			if (wifi_rssi < rssi_thresh1) {
 				wifi_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Medium\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at High\n");
 			}
 		}
@@ -277,10 +277,10 @@ static void btc8723b2ant_monitor_bt_ctr(struct btc_coexist *btcoexist)
 	else
 		bt_link_info->slave_role = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], High Priority Tx/Rx(reg 0x%x)=0x%x(%d)/0x%x(%d)\n",
 		 reg_hp_txrx, reg_hp_tx, reg_hp_tx, reg_hp_rx, reg_hp_rx);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Low Priority Tx/Rx(reg 0x%x)=0x%x(%d)/0x%x(%d)\n",
 		 reg_lp_txrx, reg_lp_tx, reg_lp_tx, reg_lp_rx, reg_lp_rx);
 
@@ -334,7 +334,7 @@ static void btc8723b2ant_query_bt_info(struct btc_coexist *btcoexist)
 
 	h2c_parameter[0] |= BIT0;	/* trigger */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -446,7 +446,7 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_HS_OPERATION, &bt_hs_on);
 
 	if (!bt_link_info->bt_link_exist) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], No BT link exists!!!\n");
 		return algorithm;
 	}
@@ -462,27 +462,27 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 
 	if (num_of_diff_profile == 1) {
 		if (bt_link_info->sco_exist) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], SCO only\n");
 			algorithm = BT_8723B_2ANT_COEX_ALGO_SCO;
 		} else {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], HID only\n");
 				algorithm = BT_8723B_2ANT_COEX_ALGO_HID;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], A2DP only\n");
 				algorithm = BT_8723B_2ANT_COEX_ALGO_A2DP;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], PAN(HS) only\n");
 					algorithm =
 						BT_8723B_2ANT_COEX_ALGO_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], PAN(EDR) only\n");
 					algorithm =
@@ -493,21 +493,21 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 	} else if (num_of_diff_profile == 2) {
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], SCO + HID\n");
 				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], SCO + A2DP ==> SCO\n");
 				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + PAN(HS)\n");
 					algorithm = BT_8723B_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + PAN(EDR)\n");
 					algorithm =
@@ -517,18 +517,18 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 		} else {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], HID + A2DP\n");
 				algorithm = BT_8723B_2ANT_COEX_ALGO_HID_A2DP;
 			} else if (bt_link_info->hid_exist &&
 				   bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + PAN(HS)\n");
 					algorithm = BT_8723B_2ANT_COEX_ALGO_HID;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + PAN(EDR)\n");
 					algorithm =
@@ -537,13 +537,13 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8723B_2ANT_COEX_ALGO_A2DP_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex],A2DP + PAN(EDR)\n");
 					algorithm =
@@ -555,19 +555,19 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], SCO + HID + A2DP ==> HID\n");
 				algorithm = BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 			} else if (bt_link_info->hid_exist &&
 				   bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + HID + PAN(HS)\n");
 					algorithm =
 					    BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + HID + PAN(EDR)\n");
 					algorithm =
@@ -576,13 +576,13 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8723B_2ANT_COEX_ALGO_PANEDR_HID;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + A2DP + PAN(EDR) ==> HID\n");
 					algorithm =
@@ -594,13 +594,13 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8723B_2ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + A2DP + PAN(EDR)\n");
 					algorithm =
@@ -614,11 +614,11 @@ static u8 btc8723b2ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], Error!!! SCO + HID + A2DP + PAN(HS)\n");
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + HID + A2DP + PAN(EDR)==>PAN(EDR)+HID\n");
 					algorithm =
@@ -641,9 +641,9 @@ static void btc8723b2ant_set_fw_dac_swing_level(struct btc_coexist *btcoexist,
 	 */
 	h2c_parameter[0] = dac_swing_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Set Dac Swing Level=0x%x\n", dac_swing_lvl);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x64=0x%x\n", h2c_parameter[0]);
 
 	btcoexist->btc_fill_h2c(btcoexist, 0x64, 1, h2c_parameter);
@@ -657,7 +657,7 @@ static void btc8723b2ant_set_fw_dec_bt_pwr(struct btc_coexist *btcoexist,
 
 	h2c_parameter[0] = dec_bt_pwr_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], decrease Bt Power Level : %u\n", dec_bt_pwr_lvl);
 
 	btcoexist->btc_fill_h2c(btcoexist, 0x62, 1, h2c_parameter);
@@ -668,12 +668,12 @@ static void btc8723b2ant_dec_bt_pwr(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Dec BT power level = %u\n", dec_bt_pwr_lvl);
 	coex_dm->cur_dec_bt_pwr_lvl = dec_bt_pwr_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], PreDecBtPwrLvl=%d, CurDecBtPwrLvl=%d\n",
 			    coex_dm->pre_dec_bt_pwr_lvl,
 			    coex_dm->cur_dec_bt_pwr_lvl);
@@ -721,13 +721,13 @@ static void btc8723b2ant_fw_dac_swing_lvl(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s set FW Dac Swing level = %d\n",
 		    (force_exec ? "force to" : ""), fw_dac_swing_lvl);
 	coex_dm->cur_fw_dac_swing_lvl = fw_dac_swing_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], preFwDacSwingLvl=%d, curFwDacSwingLvl=%d\n",
 			    coex_dm->pre_fw_dac_swing_lvl,
 			    coex_dm->cur_fw_dac_swing_lvl);
@@ -759,7 +759,7 @@ static void btc8723b_set_penalty_txrate(struct btc_coexist *btcoexist,
 		h2c_parameter[5] = 0xf6; /* MCS5 or OFDM36 */
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set WiFi Low-Penalty Retry: %s",
 		 (low_penalty_ra ? "ON!!" : "OFF!!"));
 
@@ -771,14 +771,14 @@ static void btc8723b2ant_low_penalty_ra(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn LowPenaltyRA = %s\n",
 		 (force_exec ? "force to" : ""), (low_penalty_ra ?
 						  "ON" : "OFF"));
 	coex_dm->cur_low_penalty_ra = low_penalty_ra;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreLowPenaltyRa=%d, bCurLowPenaltyRa=%d\n",
 			 coex_dm->pre_low_penalty_ra,
 			 coex_dm->cur_low_penalty_ra);
@@ -797,7 +797,7 @@ static void btc8723b2ant_set_dac_swing_reg(struct btc_coexist *btcoexist,
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	u8 val = (u8) level;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Write SwDacSwing = 0x%x\n", level);
 	btcoexist->btc_write_1byte_bitmask(btcoexist, 0x883, 0x3e, val);
 }
@@ -818,7 +818,7 @@ static void btc8723b2ant_dac_swing(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn DacSwing=%s, dac_swing_lvl=0x%x\n",
 		 (force_exec ? "force to" : ""),
 		 (dac_swing_on ? "ON" : "OFF"), dac_swing_lvl);
@@ -826,7 +826,7 @@ static void btc8723b2ant_dac_swing(struct btc_coexist *btcoexist,
 	coex_dm->cur_dac_swing_lvl = dac_swing_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreDacSwingOn=%d, preDacSwingLvl=0x%x, bCurDacSwingOn=%d, curDacSwingLvl=0x%x\n",
 			 coex_dm->pre_dac_swing_on,
 			 coex_dm->pre_dac_swing_lvl,
@@ -851,19 +851,19 @@ static void btc8723b2ant_set_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c0=0x%x\n", val0x6c0);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c0, val0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c4=0x%x\n", val0x6c4);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c4, val0x6c4);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c8=0x%x\n", val0x6c8);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c8, val0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6cc=0x%x\n", val0x6cc);
 	btcoexist->btc_write_1byte(btcoexist, 0x6cc, val0x6cc);
 }
@@ -875,7 +875,7 @@ static void btc8723b2ant_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s write Coex Table 0x6c0=0x%x, 0x6c4=0x%x, 0x6c8=0x%x, 0x6cc=0x%x\n",
 		 force_exec ? "force to" : "",
 		 val0x6c0, val0x6c4, val0x6c8, val0x6cc);
@@ -885,11 +885,11 @@ static void btc8723b2ant_coex_table(struct btc_coexist *btcoexist,
 	coex_dm->cur_val0x6cc = val0x6cc;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], preVal0x6c0=0x%x, preVal0x6c4=0x%x, preVal0x6c8=0x%x, preVal0x6cc=0x%x !!\n",
 			 coex_dm->pre_val0x6c0, coex_dm->pre_val0x6c4,
 			 coex_dm->pre_val0x6c8, coex_dm->pre_val0x6cc);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], curVal0x6c0=0x%x, curVal0x6c4=0x%x, curVal0x6c8=0x%x, curVal0x6cc=0x%x !!\n",
 			 coex_dm->cur_val0x6c0, coex_dm->cur_val0x6c4,
 			 coex_dm->cur_val0x6c8, coex_dm->cur_val0x6cc);
@@ -991,7 +991,7 @@ static void btc8723b2ant_set_fw_ignore_wlan_act(struct btc_coexist *btcoexist,
 	if (enable)
 		h2c_parameter[0] |= BIT0; /* function enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63=0x%x\n",
 		 h2c_parameter[0]);
 
@@ -1030,13 +1030,13 @@ static void btc8723b2ant_ignore_wlan_act(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn Ignore WlanAct %s\n",
 		 (force_exec ? "force to" : ""), (enable ? "ON" : "OFF"));
 	coex_dm->cur_ignore_wlan_act = enable;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPreIgnoreWlanAct = %d, bCurIgnoreWlanAct = %d!!\n",
 			 coex_dm->pre_ignore_wlan_act,
 			 coex_dm->cur_ignore_wlan_act);
@@ -1070,7 +1070,7 @@ static void btc8723b2ant_set_fw_ps_tdma(struct btc_coexist *btcoexist, u8 byte1,
 	coex_dm->ps_tdma_para[3] = byte4;
 	coex_dm->ps_tdma_para[4] = byte5;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x60(5bytes)=0x%x%08x\n",
 		 h2c_parameter[0],
 		 h2c_parameter[1] << 24 | h2c_parameter[2] << 16 |
@@ -1220,7 +1220,7 @@ static void btc8723b2ant_ps_tdma(struct btc_coexist *btcoexist, bool force_exec,
 			coex_dm->switch_thres_offset;
 	bt_rssi_state = btc8723b2ant_bt_rssi_state(btcoexist, 2, tmp, 0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn %s PS TDMA, type=%d\n",
 		 (force_exec ? "force to" : ""),
 		 (turn_on ? "ON" : "OFF"), type);
@@ -1237,10 +1237,10 @@ static void btc8723b2ant_ps_tdma(struct btc_coexist *btcoexist, bool force_exec,
 	}
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], bPrePsTdmaOn = %d, bCurPsTdmaOn = %d!!\n",
 			 coex_dm->pre_ps_tdma_on, coex_dm->cur_ps_tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], prePsTdma = %d, curPsTdma = %d!!\n",
 			 coex_dm->pre_ps_tdma, coex_dm->cur_ps_tdma);
 
@@ -1585,12 +1585,12 @@ static void btc8723b2ant_action_bt_inquiry(struct btc_coexist *btcoexist)
 		btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 23);
 		btc8723b2ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 3);
 	} else if (scan || link || roam) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi link process + BT Inq/Page!!\n");
 		btc8723b2ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 15);
 		btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 22);
 	} else if (wifi_connected) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi connected + BT Inq/Page!!\n");
 		btc8723b2ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 15);
 		btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 22);
@@ -1620,7 +1620,7 @@ static void btc8723b2ant_action_wifi_link_process(struct btc_coexist
 	u8tmpa = btcoexist->btc_read_1byte(btcoexist, 0x765);
 	u8tmpb = btcoexist->btc_read_1byte(btcoexist, 0x76e);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 0x948 = 0x%x, 0x765 = 0x%x, 0x76e = 0x%x\n",
 		 u32tmp, u8tmpa, u8tmpb);
 }
@@ -1645,7 +1645,7 @@ static bool btc8723b2ant_action_wifi_idle_process(struct btc_coexist *btcoexist)
 	/* office environment */
 	if (BTC_RSSI_HIGH(wifi_rssi_state1) && (coex_sta->hid_exist) &&
 	    (coex_sta->a2dp_exist)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi  idle process for BT HID+A2DP exist!!\n");
 
 		btc8723b2ant_dac_swing(btcoexist, NORMAL_EXEC, true, 0x6);
@@ -1685,7 +1685,7 @@ static bool btc8723b2ant_is_common_action(struct btc_coexist *btcoexist)
 		btc8723b2ant_limited_rx(btcoexist, NORMAL_EXEC,
 					false, false, 0x8);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi non-connected idle!!\n");
 
 		btcoexist->btc_set_rf_reg(btcoexist, BTC_RF_A, 0x1, 0xfffff,
@@ -1709,7 +1709,7 @@ static bool btc8723b2ant_is_common_action(struct btc_coexist *btcoexist)
 			btc8723b2ant_limited_rx(btcoexist, NORMAL_EXEC,
 						false, false, 0x8);
 
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Wifi connected + BT non connected-idle!!\n");
 
 			btcoexist->btc_set_rf_reg(btcoexist, BTC_RF_A, 0x1,
@@ -1734,7 +1734,7 @@ static bool btc8723b2ant_is_common_action(struct btc_coexist *btcoexist)
 
 			if (bt_hs_on)
 				return false;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Wifi connected + BT connected-idle!!\n");
 			btc8723b2ant_limited_rx(btcoexist, NORMAL_EXEC,
 						false, false, 0x8);
@@ -1759,11 +1759,11 @@ static bool btc8723b2ant_is_common_action(struct btc_coexist *btcoexist)
 					   &low_pwr_disable);
 
 			if (wifi_busy) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Wifi Connected-Busy + BT Busy!!\n");
 				common = false;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Wifi Connected-Idle + BT Busy!!\n");
 
 				common =
@@ -1786,12 +1786,12 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	s32 result;
 	u8 retry_count = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], TdmaDurationAdjust()\n");
 
 	if (!coex_dm->auto_tdma_adjust) {
 		coex_dm->auto_tdma_adjust = true;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], first run TdmaDurationAdjust()!!\n");
 		if (sco_hid) {
 			if (tx_pause) {
@@ -1901,9 +1901,9 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 		    (coex_sta->low_priority_rx) > 1250)
 			retry_count++;
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], retry_count = %d\n", retry_count);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], up=%d, dn=%d, m=%d, n=%d, wait_count=%d\n",
 			 up, dn, m, n, wait_count);
 		result = 0;
@@ -1925,7 +1925,7 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 				up = 0;
 				dn = 0;
 				result = 1;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Increase wifi duration!!\n");
 			} /* <=3 retry in the last 2-second duration*/
 		} else if (retry_count <= 3) {
@@ -1957,7 +1957,7 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 				dn = 0;
 				wait_count = 0;
 				result = -1;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Decrease wifi duration for retry_counter<3!!\n");
 			}
 		} else {
@@ -1982,11 +1982,11 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 			dn = 0;
 			wait_count = 0;
 			result = -1;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Decrease wifi duration for retry_counter>3!!\n");
 		}
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], max Interval = %d\n", max_interval);
 		if (max_interval == 1) {
 			if (tx_pause) {
@@ -2736,7 +2736,7 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], max Interval = %d\n", max_interval);
 
 	/* if current PsTdma not match with the recorded one (scan, dhcp, ...),
@@ -2744,7 +2744,7 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	 */
 	if (coex_dm->cur_ps_tdma != coex_dm->ps_tdma_du_adj_type) {
 		bool scan = false, link = false, roam = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], PsTdma type mismatch!!!, curPsTdma=%d, recordPsTdma=%d\n",
 			 coex_dm->cur_ps_tdma, coex_dm->ps_tdma_du_adj_type);
 
@@ -2756,7 +2756,7 @@ static void btc8723b2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 			btc8723b2ant_ps_tdma(btcoexist, NORMAL_EXEC, true,
 					     coex_dm->ps_tdma_du_adj_type);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], roaming/link/scan is under progress, will adjust next time!!!\n");
 	}
 }
@@ -3352,17 +3352,17 @@ static void btc8723b2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	bool miracast_plus_bt = false;
 	bool scan = false, link = false, roam = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], RunCoexistMechanism()===>\n");
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for Manual CTRL <===\n");
 		return;
 	}
 
 	if (coex_sta->under_ips) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is under IPS !!!\n");
 		return;
 	}
@@ -3370,7 +3370,7 @@ static void btc8723b2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	algorithm = btc8723b2ant_action_algorithm(btcoexist);
 	if (coex_sta->c2h_bt_inquiry_page &&
 	    (BT_8723B_2ANT_COEX_ALGO_PANHS != algorithm)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT is under inquiry/page scan !!\n");
 		btc8723b2ant_action_bt_inquiry(btcoexist);
 		return;
@@ -3381,7 +3381,7 @@ static void btc8723b2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_ROAM, &roam);
 
 	if (scan || link || roam) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], WiFi is under Link Process !!\n");
 		btc8723b2ant_action_wifi_link_process(btcoexist);
 		return;
@@ -3394,7 +3394,7 @@ static void btc8723b2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 
 	if ((num_of_wifi_link >= 2) ||
 	    (wifi_link_status & WIFI_P2P_GO_CONNECTED)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "############# [BTCoex],  Multi-Port num_of_wifi_link = %d, wifi_link_status = 0x%x\n",
 			 num_of_wifi_link, wifi_link_status);
 
@@ -3415,17 +3415,17 @@ static void btc8723b2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 			   &miracast_plus_bt);
 
 	coex_dm->cur_algorithm = algorithm;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Algorithm = %d\n",
 		 coex_dm->cur_algorithm);
 
 	if (btc8723b2ant_is_common_action(btcoexist)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Action 2-Ant common\n");
 		coex_dm->auto_tdma_adjust = false;
 	} else {
 		if (coex_dm->cur_algorithm != coex_dm->pre_algorithm) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], preAlgorithm=%d, curAlgorithm=%d\n",
 				 coex_dm->pre_algorithm,
 				 coex_dm->cur_algorithm);
@@ -3433,57 +3433,57 @@ static void btc8723b2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 		}
 		switch (coex_dm->cur_algorithm) {
 		case BT_8723B_2ANT_COEX_ALGO_SCO:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = SCO\n");
 			btc8723b2ant_action_sco(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HID\n");
 			btc8723b2ant_action_hid(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = A2DP\n");
 			btc8723b2ant_action_a2dp(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_A2DP_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = A2DP+PAN(HS)\n");
 			btc8723b2ant_action_a2dp_pan_hs(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = PAN(EDR)\n");
 			btc8723b2ant_action_pan_edr(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HS mode\n");
 			btc8723b2ant_action_pan_hs(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANEDR_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = PAN+A2DP\n");
 			btc8723b2ant_action_pan_edr_a2dp(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_PANEDR_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = PAN(EDR)+HID\n");
 			btc8723b2ant_action_pan_edr_hid(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_HID_A2DP_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HID+A2DP+PAN\n");
 			btc8723b2ant_action_hid_a2dp_pan_edr(btcoexist);
 			break;
 		case BT_8723B_2ANT_COEX_ALGO_HID_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HID+A2DP\n");
 			btc8723b2ant_action_hid_a2dp(btcoexist);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = coexist All Off!!\n");
 			btc8723b2ant_coex_alloff(btcoexist);
 			break;
@@ -3531,7 +3531,7 @@ void ex_btc8723b2ant_init_hwconfig(struct btc_coexist *btcoexist)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	u8 u8tmp = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 2Ant Init HW Config!!\n");
 	coex_dm->bt_rf0x1e_backup =
 		btcoexist->btc_get_rf_reg(btcoexist, BTC_RF_A, 0x1e, 0xfffff);
@@ -3631,7 +3631,7 @@ void ex_btc8723b2ant_init_coex_dm(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Coex Mechanism Init!!\n");
 	btc8723b2ant_init_coex_dm(btcoexist);
 }
@@ -3853,14 +3853,14 @@ void ex_btc8723b2ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_IPS_ENTER == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS ENTER notify\n");
 		coex_sta->under_ips = true;
 		btc8723b2ant_wifioff_hwcfg(btcoexist);
 		btc8723b2ant_ignore_wlan_act(btcoexist, FORCE_EXEC, true);
 		btc8723b2ant_coex_alloff(btcoexist);
 	} else if (BTC_IPS_LEAVE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS LEAVE notify\n");
 		coex_sta->under_ips = false;
 		ex_btc8723b2ant_init_hwconfig(btcoexist);
@@ -3874,11 +3874,11 @@ void ex_btc8723b2ant_lps_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_LPS_ENABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS ENABLE notify\n");
 		coex_sta->under_lps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS DISABLE notify\n");
 		coex_sta->under_lps = false;
 	}
@@ -3895,15 +3895,15 @@ void ex_btc8723b2ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 	u8tmpb = btcoexist->btc_read_1byte(btcoexist, 0x76e);
 
 	if (BTC_SCAN_START == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 	else if (BTC_SCAN_FINISH == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 	btcoexist->btc_get(btcoexist, BTC_GET_U1_AP_NUM,
 			   &coex_sta->scan_ap_num);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "############# [BTCoex], 0x948=0x%x, 0x765=0x%x, 0x76e=0x%x\n",
 		u32tmp, u8tmpa, u8tmpb);
 }
@@ -3913,10 +3913,10 @@ void ex_btc8723b2ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_ASSOCIATE_START == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 	else if (BTC_ASSOCIATE_FINISH == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 }
 
@@ -3930,10 +3930,10 @@ void ex_btc8723b2ant_media_status_notify(struct btc_coexist *btcoexist,
 	u8 ap_num = 0;
 
 	if (BTC_MEDIA_CONNECT == type)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA connect notify\n");
 	else
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA disconnect notify\n");
 
 	/* only 2.4G we need to inform bt the chnl mask */
@@ -3961,7 +3961,7 @@ void ex_btc8723b2ant_media_status_notify(struct btc_coexist *btcoexist,
 	coex_dm->wifi_chnl_info[1] = h2c_parameter[1];
 	coex_dm->wifi_chnl_info[2] = h2c_parameter[2];
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x66=0x%x\n",
 		 h2c_parameter[0] << 16 | h2c_parameter[1] << 8 |
 		 h2c_parameter[2]);
@@ -3975,7 +3975,7 @@ void ex_btc8723b2ant_special_packet_notify(struct btc_coexist *btcoexist,
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (type == BTC_PACKET_DHCP)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], DHCP Packet notify\n");
 }
 
@@ -3995,7 +3995,7 @@ void ex_btc8723b2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		rsp_source = BT_INFO_SRC_8723B_2ANT_WIFI_FW;
 	coex_sta->bt_info_c2h_cnt[rsp_source]++;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Bt info[%d], length=%d, hex data=[",
 		 rsp_source, length);
 	for (i = 0; i < length; i++) {
@@ -4003,15 +4003,15 @@ void ex_btc8723b2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if (i == 1)
 			bt_info = tmpbuf[i];
 		if (i == length - 1)
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x]\n", tmpbuf[i]);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x, ", tmpbuf[i]);
 	}
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), return for Manual CTRL<===\n");
 		return;
 	}
@@ -4043,7 +4043,7 @@ void ex_btc8723b2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		 * because BT is reset and loss of the info.
 		 */
 		if ((coex_sta->bt_info_ext & BIT1)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT ext info bit1 check, send wifi BW&Chnl to BT!!\n");
 			btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_CONNECTED,
 					   &wifi_connected);
@@ -4058,7 +4058,7 @@ void ex_btc8723b2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		}
 
 		if ((coex_sta->bt_info_ext & BIT3)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n");
 			btc8723b2ant_ignore_wlan_act(btcoexist, FORCE_EXEC,
 						     false);
@@ -4120,25 +4120,25 @@ void ex_btc8723b2ant_bt_info_notify(struct btc_coexist *btcoexist,
 
 	if (!(bt_info & BT_INFO_8723B_2ANT_B_CONNECTION)) {
 		coex_dm->bt_status = BT_8723B_2ANT_BT_STATUS_NON_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n");
 	/* connection exists but no busy */
 	} else if (bt_info == BT_INFO_8723B_2ANT_B_CONNECTION) {
 		coex_dm->bt_status = BT_8723B_2ANT_BT_STATUS_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n");
 	} else if ((bt_info & BT_INFO_8723B_2ANT_B_SCO_ESCO) ||
 		   (bt_info & BT_INFO_8723B_2ANT_B_SCO_BUSY)) {
 		coex_dm->bt_status = BT_8723B_2ANT_BT_STATUS_SCO_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT SCO busy!!!\n");
 	} else if (bt_info&BT_INFO_8723B_2ANT_B_ACL_BUSY) {
 		coex_dm->bt_status = BT_8723B_2ANT_BT_STATUS_ACL_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT ACL busy!!!\n");
 	} else {
 		coex_dm->bt_status = BT_8723B_2ANT_BT_STATUS_MAX;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Defined state!!!\n");
 	}
 
@@ -4164,7 +4164,7 @@ void ex_btc8723b2ant_halt_notify(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Halt notify\n");
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Halt notify\n");
 
 	btc8723b2ant_wifioff_hwcfg(btcoexist);
 	btc8723b2ant_ignore_wlan_act(btcoexist, FORCE_EXEC, true);
@@ -4175,10 +4175,10 @@ void ex_btc8723b2ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Pnp notify\n");
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Pnp notify\n");
 
 	if (pnp_state == BTC_WIFI_PNP_SLEEP) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to SLEEP\n");
 
 		/* Driver do not leave IPS/LPS when driver is going to sleep, so
@@ -4190,7 +4190,7 @@ void ex_btc8723b2ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 		coex_sta->under_ips = false;
 		coex_sta->under_lps = false;
 	} else if (pnp_state == BTC_WIFI_PNP_WAKE_UP) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to WAKE UP\n");
 		ex_btc8723b2ant_init_hwconfig(btcoexist);
 		btc8723b2ant_init_coex_dm(btcoexist);
@@ -4203,7 +4203,7 @@ void ex_btc8723b2ant_periodical(struct btc_coexist *btcoexist)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	struct btc_bt_link_info *bt_link_info = &btcoexist->bt_link_info;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], ==========================Periodical===========================\n");
 
 	if (coex_sta->dis_ver_info_cnt <= 5) {
@@ -4212,7 +4212,7 @@ void ex_btc8723b2ant_periodical(struct btc_coexist *btcoexist)
 			/* Antenna config to set 0x765 = 0x0 (GNT_BT control by
 			 * PTA) after initial
 			 */
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Set GNT_BT control by PTA\n");
 			btc8723b2ant_set_ant_path(
 				btcoexist, BTC_ANT_WIFI_AT_MAIN, false, false);
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c
index fa5b73f81c57..a2b88dda81ef 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a1ant.c
@@ -55,27 +55,27 @@ static u8 btc8821a1ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >= (rssi_thresh +
 					BTC_RSSI_COEX_THRESH_TOL_8821A_1ANT)) {
 				bt_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to High\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Low\n");
 			}
 		} else {
 			if (bt_rssi < rssi_thresh) {
 				bt_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Low\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT Rssi thresh error!!\n");
 			return coex_sta->pre_bt_rssi_state;
 		}
@@ -85,11 +85,11 @@ static u8 btc8821a1ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >= (rssi_thresh +
 					BTC_RSSI_COEX_THRESH_TOL_8821A_1ANT)) {
 				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Medium\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Low\n");
 			}
 		} else if ((coex_sta->pre_bt_rssi_state ==
@@ -99,25 +99,25 @@ static u8 btc8821a1ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >= (rssi_thresh1 +
 					BTC_RSSI_COEX_THRESH_TOL_8821A_1ANT)) {
 				bt_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to High\n");
 			} else if (bt_rssi < rssi_thresh) {
 				bt_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Low\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Medium\n");
 			}
 		} else {
 			if (bt_rssi < rssi_thresh1) {
 				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Medium\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at High\n");
 			}
 		}
@@ -145,27 +145,27 @@ static u8 btc8821a1ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= (rssi_thresh +
 					BTC_RSSI_COEX_THRESH_TOL_8821A_1ANT)) {
 				wifi_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to High\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Low\n");
 			}
 		} else {
 			if (wifi_rssi < rssi_thresh) {
 				wifi_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Low\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], wifi RSSI thresh error!!\n");
 			return coex_sta->pre_wifi_rssi_state[index];
 		}
@@ -177,11 +177,11 @@ static u8 btc8821a1ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= (rssi_thresh +
 					BTC_RSSI_COEX_THRESH_TOL_8821A_1ANT)) {
 				wifi_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Medium\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Low\n");
 			}
 		} else if ((coex_sta->pre_wifi_rssi_state[index] ==
@@ -191,25 +191,25 @@ static u8 btc8821a1ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= (rssi_thresh1 +
 					BTC_RSSI_COEX_THRESH_TOL_8821A_1ANT)) {
 				wifi_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to High\n");
 			} else if (wifi_rssi < rssi_thresh) {
 				wifi_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Low\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Medium\n");
 			}
 		} else {
 			if (wifi_rssi < rssi_thresh1) {
 				wifi_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Medium\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at High\n");
 			}
 		}
@@ -397,7 +397,7 @@ static void btc8821a1ant_query_bt_info(struct btc_coexist *btcoexist)
 
 	h2c_parameter[0] |= BIT0; /* trigger */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -471,7 +471,7 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_HS_OPERATION, &bt_hs_on);
 
 	if (!bt_link_info->bt_link_exist) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], No BT link exists!!!\n");
 		return algorithm;
 	}
@@ -487,26 +487,26 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 
 	if (num_of_diff_profile == 1) {
 		if (bt_link_info->sco_exist) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT Profile = SCO only\n");
 			algorithm = BT_8821A_1ANT_COEX_ALGO_SCO;
 		} else {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Profile = HID only\n");
 				algorithm = BT_8821A_1ANT_COEX_ALGO_HID;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Profile = A2DP only\n");
 				algorithm = BT_8821A_1ANT_COEX_ALGO_A2DP;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = PAN(HS) only\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = PAN(EDR) only\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR;
@@ -516,21 +516,21 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 	} else if (num_of_diff_profile == 2) {
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Profile = SCO + HID\n");
 				algorithm = BT_8821A_1ANT_COEX_ALGO_HID;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Profile = SCO + A2DP ==> SCO\n");
 				algorithm = BT_8821A_1ANT_COEX_ALGO_SCO;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + PAN(HS)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + PAN(EDR)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR_HID;
@@ -539,18 +539,18 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 		} else {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Profile = HID + A2DP\n");
 				algorithm = BT_8821A_1ANT_COEX_ALGO_HID_A2DP;
 			} else if (bt_link_info->hid_exist &&
 				   bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = HID + PAN(HS)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = HID + PAN(EDR)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR_HID;
@@ -558,12 +558,12 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = A2DP + PAN(HS)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_A2DP_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = A2DP + PAN(EDR)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR_A2DP;
@@ -574,18 +574,18 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Profile = SCO + HID + A2DP ==> HID\n");
 				algorithm = BT_8821A_1ANT_COEX_ALGO_HID;
 			} else if (bt_link_info->hid_exist &&
 				   bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + HID + PAN(HS)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + HID + PAN(EDR)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR_HID;
@@ -593,12 +593,12 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + A2DP + PAN(HS)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + A2DP + PAN(EDR) ==> HID\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR_HID;
@@ -609,12 +609,12 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = HID + A2DP + PAN(HS)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = HID + A2DP + PAN(EDR)\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_HID_A2DP_PANEDR;
@@ -627,12 +627,12 @@ static u8 btc8821a1ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], Error!!! BT Profile = SCO + HID + A2DP + PAN(HS)\n");
 
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT Profile = SCO + HID + A2DP + PAN(EDR)==>PAN(EDR)+HID\n");
 					algorithm = BT_8821A_1ANT_COEX_ALGO_PANEDR_HID;
@@ -660,7 +660,7 @@ static void btc8821a1ant_set_sw_penalty_tx_rate(struct btc_coexist *btcoexist,
 		h2c_parameter[5] = 0xf9; /* MCS5 or OFDM36 */
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set WiFi Low-Penalty Retry: %s",
 		 (low_penalty_ra ? "ON!!" : "OFF!!"));
 
@@ -688,19 +688,19 @@ static void btc8821a1ant_set_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c0, val0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c4, val0x6c4);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c8, val0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc);
 	btcoexist->btc_write_1byte(btcoexist, 0x6cc, val0x6cc);
 }
@@ -711,7 +711,7 @@ static void btc8821a1ant_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s write Coex Table 0x6c0 = 0x%x, 0x6c4 = 0x%x, 0x6c8 = 0x%x, 0x6cc = 0x%x\n",
 		    (force_exec ? "force to" : ""), val0x6c0, val0x6c4,
 		    val0x6c8, val0x6cc);
@@ -786,7 +786,7 @@ static void btc8821a1ant_set_fw_ignore_wlan_act(struct btc_coexist *btcoexist,
 	if (enable)
 		h2c_parameter[0] |= BIT0; /* function enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -798,13 +798,13 @@ static void btc8821a1ant_ignore_wlan_act(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn Ignore WlanAct %s\n",
 		 (force_exec ? "force to" : ""), (enable ? "ON" : "OFF"));
 	coex_dm->cur_ignore_wlan_act = enable;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_ignore_wlan_act = %d, cur_ignore_wlan_act = %d!!\n",
 			 coex_dm->pre_ignore_wlan_act,
 			 coex_dm->cur_ignore_wlan_act);
@@ -831,7 +831,7 @@ static void btc8821a1ant_set_fw_ps_tdma(struct btc_coexist *btcoexist, u8 byte1,
 
 	if (ap_enable) {
 		if (byte1 & BIT4 && !(byte1 & BIT5)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], FW for 1Ant AP mode\n");
 			real_byte1 &= ~BIT4;
 			real_byte1 |= BIT5;
@@ -853,7 +853,7 @@ static void btc8821a1ant_set_fw_ps_tdma(struct btc_coexist *btcoexist, u8 byte1,
 	coex_dm->ps_tdma_para[3] = byte4;
 	coex_dm->ps_tdma_para[4] = real_byte5;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], PS-TDMA H2C cmd =0x%x%08x\n",
 		 h2c_parameter[0],
 		 h2c_parameter[1] << 24 |
@@ -878,20 +878,20 @@ static void btc8821a1ant_lps_rpwm(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s set lps/rpwm = 0x%x/0x%x\n",
 		 (force_exec ? "force to" : ""), lps_val, rpwm_val);
 	coex_dm->cur_lps = lps_val;
 	coex_dm->cur_rpwm = rpwm_val;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS-RxBeaconMode = 0x%x, LPS-RPWM = 0x%x!!\n",
 			 coex_dm->cur_lps, coex_dm->cur_rpwm);
 
 		if ((coex_dm->pre_lps == coex_dm->cur_lps) &&
 		    (coex_dm->pre_rpwm == coex_dm->cur_rpwm)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], LPS-RPWM_Last = 0x%x, LPS-RPWM_Now = 0x%x!!\n",
 				 coex_dm->pre_rpwm, coex_dm->cur_rpwm);
 
@@ -909,7 +909,7 @@ static void btc8821a1ant_sw_mechanism(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], SM[LpRA] = %d\n", low_penalty_ra);
 
 	btc8821a1ant_low_penalty_ra(btcoexist, NORMAL_EXEC, low_penalty_ra);
@@ -1010,11 +1010,11 @@ static void btc8821a1ant_ps_tdma(struct btc_coexist *btcoexist,
 
 	if (!force_exec) {
 		if (coex_dm->cur_ps_tdma_on) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], ********** TDMA(on, %d) **********\n",
 				 coex_dm->cur_ps_tdma);
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], ********** TDMA(off, %d) **********\n",
 				 coex_dm->cur_ps_tdma);
 		}
@@ -1254,7 +1254,7 @@ static bool btc8821a1ant_is_common_action(struct btc_coexist *btcoexist)
 	if (!wifi_connected &&
 	    BT_8821A_1ANT_BT_STATUS_NON_CONNECTED_IDLE ==
 	    coex_dm->bt_status) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi non connected-idle + BT non connected-idle!!\n");
 		btc8821a1ant_sw_mechanism(btcoexist, false);
 
@@ -1262,7 +1262,7 @@ static bool btc8821a1ant_is_common_action(struct btc_coexist *btcoexist)
 	} else if (wifi_connected &&
 		   (BT_8821A_1ANT_BT_STATUS_NON_CONNECTED_IDLE ==
 		    coex_dm->bt_status)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi connected + BT non connected-idle!!\n");
 		btc8821a1ant_sw_mechanism(btcoexist, false);
 
@@ -1270,7 +1270,7 @@ static bool btc8821a1ant_is_common_action(struct btc_coexist *btcoexist)
 	} else if (!wifi_connected &&
 		   (BT_8821A_1ANT_BT_STATUS_CONNECTED_IDLE ==
 		    coex_dm->bt_status)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi non connected-idle + BT connected-idle!!\n");
 		btc8821a1ant_sw_mechanism(btcoexist, false);
 
@@ -1278,7 +1278,7 @@ static bool btc8821a1ant_is_common_action(struct btc_coexist *btcoexist)
 	} else if (wifi_connected &&
 		   (BT_8821A_1ANT_BT_STATUS_CONNECTED_IDLE ==
 		    coex_dm->bt_status)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi connected + BT connected-idle!!\n");
 		btc8821a1ant_sw_mechanism(btcoexist, false);
 
@@ -1286,17 +1286,17 @@ static bool btc8821a1ant_is_common_action(struct btc_coexist *btcoexist)
 	} else if (!wifi_connected &&
 		   (BT_8821A_1ANT_BT_STATUS_CONNECTED_IDLE !=
 		    coex_dm->bt_status)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi non connected-idle + BT Busy!!\n");
 		btc8821a1ant_sw_mechanism(btcoexist, false);
 
 		common = true;
 	} else {
 		if (wifi_busy) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Wifi Connected-Busy + BT Busy!!\n");
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Wifi Connected-Idle + BT Busy!!\n");
 		}
 
@@ -1743,14 +1743,14 @@ static void btc8821a1ant_action_wifi_connected(struct btc_coexist *btcoexist)
 	bool under_4way = false;
 	bool ap_enable = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], CoexForWifiConnect()===>\n");
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_4_WAY_PROGRESS,
 			   &under_4way);
 	if (under_4way) {
 		btc8821a1ant_act_wifi_conn_sp_pkt(btcoexist);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CoexForWifiConnect(), return for wifi is under 4way<===\n");
 		return;
 	}
@@ -1764,7 +1764,7 @@ static void btc8821a1ant_action_wifi_connected(struct btc_coexist *btcoexist)
 		else
 			btc8821a1ant_act_wifi_conn_sp_pkt(btcoexist);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CoexForWifiConnect(), return for wifi is under scan<===\n");
 		return;
 	}
@@ -1834,57 +1834,57 @@ static void btc8821a1ant_run_sw_coex_mech(struct btc_coexist *btcoexist)
 	if (!btc8821a1ant_is_common_action(btcoexist)) {
 		switch (coex_dm->cur_algorithm) {
 		case BT_8821A_1ANT_COEX_ALGO_SCO:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = SCO\n");
 			btc8821a1ant_action_sco(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = HID\n");
 			btc8821a1ant_action_hid(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = A2DP\n");
 			btc8821a1ant_action_a2dp(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_A2DP_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = A2DP+PAN(HS)\n");
 			btc8821a1ant_action_a2dp_pan_hs(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = PAN(EDR)\n");
 			btc8821a1ant_action_pan_edr(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = HS mode\n");
 			btc8821a1ant_action_pan_hs(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_PANEDR_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = PAN+A2DP\n");
 			btc8821a1ant_action_pan_edr_a2dp(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_PANEDR_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = PAN(EDR)+HID\n");
 			btc8821a1ant_action_pan_edr_hid(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_HID_A2DP_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = HID+A2DP+PAN\n");
 			btc8821a1ant_action_hid_a2dp_pan_edr(btcoexist);
 			break;
 		case BT_8821A_1ANT_COEX_ALGO_HID_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = HID+A2DP\n");
 			btc8821a1ant_action_hid_a2dp(btcoexist);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action algorithm = coexist All Off!!\n");
 			/*btc8821a1ant_coex_all_off(btcoexist);*/
 			break;
@@ -1906,30 +1906,30 @@ static void btc8821a1ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	u32 num_of_wifi_link = 0;
 	bool wifi_under_5g = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], RunCoexistMechanism()===>\n");
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for Manual CTRL <===\n");
 		return;
 	}
 
 	if (btcoexist->stop_coex_dm) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for Stop Coex DM <===\n");
 		return;
 	}
 
 	if (coex_sta->under_ips) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is under IPS !!!\n");
 		return;
 	}
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
@@ -2001,7 +2001,7 @@ static void btc8821a1ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	if (!wifi_connected) {
 		bool scan = false, link = false, roam = false;
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is non connected-idle !!!\n");
 
 		btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_SCAN, &scan);
@@ -2040,7 +2040,7 @@ static void btc8821a1ant_init_hw_config(struct btc_coexist *btcoexist,
 	u8 u1_tmp = 0;
 	bool wifi_under_5g = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 1Ant Init HW Config!!\n");
 
 	if (wifi_only)
@@ -2096,7 +2096,7 @@ void ex_btc8821a1ant_init_coex_dm(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Coex Mechanism Init!!\n");
 
 	btcoexist->stop_coex_dm = false;
@@ -2353,14 +2353,14 @@ void ex_btc8821a1ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 		return;
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
 	}
 
 	if (BTC_IPS_ENTER == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS ENTER notify\n");
 		coex_sta->under_ips = true;
 		btc8821a1ant_set_ant_path(btcoexist,
@@ -2370,7 +2370,7 @@ void ex_btc8821a1ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 		btc8821a1ant_coex_table_with_type(btcoexist,
 						  NORMAL_EXEC, 0);
 	} else if (BTC_IPS_LEAVE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS LEAVE notify\n");
 		coex_sta->under_ips = false;
 
@@ -2388,11 +2388,11 @@ void ex_btc8821a1ant_lps_notify(struct btc_coexist *btcoexist, u8 type)
 		return;
 
 	if (BTC_LPS_ENABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS ENABLE notify\n");
 		coex_sta->under_lps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS DISABLE notify\n");
 		coex_sta->under_lps = false;
 	}
@@ -2412,7 +2412,7 @@ void ex_btc8821a1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 		return;
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
@@ -2420,14 +2420,14 @@ void ex_btc8821a1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 
 	if (type == BTC_SCAN_START) {
 		coex_sta->wifi_is_high_pri_task = true;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 
 		/* Force antenna setup for no scan result issue */
 		btc8821a1ant_ps_tdma(btcoexist, FORCE_EXEC, false, 8);
 	} else {
 		coex_sta->wifi_is_high_pri_task = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 	}
 
@@ -2461,7 +2461,7 @@ void ex_btc8821a1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 	}
 
 	if (BTC_SCAN_START == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 		if (!wifi_connected) {
 			/* non-connected scan */
@@ -2471,7 +2471,7 @@ void ex_btc8821a1ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 			btc8821a1ant_action_wifi_connected_scan(btcoexist);
 		}
 	} else if (BTC_SCAN_FINISH == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 		if (!wifi_connected) {
 			/* non-connected scan */
@@ -2497,7 +2497,7 @@ void ex_btc8821a1ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 		return;
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
@@ -2505,12 +2505,12 @@ void ex_btc8821a1ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 
 	if (type == BTC_ASSOCIATE_START) {
 		coex_sta->wifi_is_high_pri_task = true;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 		coex_dm->arp_cnt = 0;
 	} else {
 		coex_sta->wifi_is_high_pri_task = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 		coex_dm->arp_cnt = 0;
 	}
@@ -2536,11 +2536,11 @@ void ex_btc8821a1ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 	}
 
 	if (BTC_ASSOCIATE_START == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 		btc8821a1ant_act_wifi_not_conn_scan(btcoexist);
 	} else if (BTC_ASSOCIATE_FINISH == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 
 		btcoexist->btc_get(btcoexist,
@@ -2568,17 +2568,17 @@ void ex_btc8821a1ant_media_status_notify(struct btc_coexist *btcoexist,
 		return;
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
 	}
 
 	if (BTC_MEDIA_CONNECT == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA connect notify\n");
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA disconnect notify\n");
 		coex_dm->arp_cnt = 0;
 	}
@@ -2602,7 +2602,7 @@ void ex_btc8821a1ant_media_status_notify(struct btc_coexist *btcoexist,
 	coex_dm->wifi_chnl_info[1] = h2c_parameter[1];
 	coex_dm->wifi_chnl_info[2] = h2c_parameter[2];
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x66 = 0x%x\n",
 		 h2c_parameter[0] << 16 |
 		 h2c_parameter[1] << 8 |
@@ -2628,7 +2628,7 @@ void ex_btc8821a1ant_special_packet_notify(struct btc_coexist *btcoexist,
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
@@ -2639,15 +2639,15 @@ void ex_btc8821a1ant_special_packet_notify(struct btc_coexist *btcoexist,
 		coex_sta->wifi_is_high_pri_task = true;
 
 		if (type == BTC_PACKET_ARP) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], specific Packet ARP notify\n");
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], specific Packet DHCP or EAPOL notify\n");
 		}
 	} else {
 		coex_sta->wifi_is_high_pri_task = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], specific Packet [Type = %d] notify\n",
 			 type);
 	}
@@ -2678,7 +2678,7 @@ void ex_btc8821a1ant_special_packet_notify(struct btc_coexist *btcoexist,
 	    type == BTC_PACKET_ARP) {
 		if (type == BTC_PACKET_ARP) {
 			coex_dm->arp_cnt++;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], ARP Packet Count = %d\n",
 				 coex_dm->arp_cnt);
 			if (coex_dm->arp_cnt >= 10)
@@ -2688,7 +2688,7 @@ void ex_btc8821a1ant_special_packet_notify(struct btc_coexist *btcoexist,
 				return;
 		}
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], special Packet(%d) notify\n", type);
 		btc8821a1ant_act_wifi_conn_sp_pkt(btcoexist);
 	}
@@ -2715,7 +2715,7 @@ void ex_btc8821a1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		rsp_source = BT_INFO_SRC_8821A_1ANT_WIFI_FW;
 	coex_sta->bt_info_c2h_cnt[rsp_source]++;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Bt info[%d], length = %d, hex data = [",
 		 rsp_source, length);
 	for (i = 0; i < length; i++) {
@@ -2723,10 +2723,10 @@ void ex_btc8821a1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if (i == 1)
 			bt_info = tmp_buf[i];
 		if (i == length - 1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x]\n", tmp_buf[i]);
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x, ", tmp_buf[i]);
 		}
 	}
@@ -2749,7 +2749,7 @@ void ex_btc8821a1ant_bt_info_notify(struct btc_coexist *btcoexist,
 			/* BT into is responded by BT FW and BT RF REG 0x3C !=
 			 * 0x15 => Need to switch BT TRx Mask
 			 */
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Switch BT TRx Mask since BT RF REG 0x3C != 0x15\n");
 			btcoexist->btc_set_bt_reg(btcoexist, BTC_BT_REG_RF,
 						  0x3c, 0x15);
@@ -2759,7 +2759,7 @@ void ex_btc8821a1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		 * because bt is reset and lost the info
 		 */
 		if (coex_sta->bt_info_ext & BIT1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT ext info bit1 check, send wifi BW&Chnl to BT!!\n");
 			btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_CONNECTED,
 					   &wifi_connected);
@@ -2775,7 +2775,7 @@ void ex_btc8821a1ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if ((coex_sta->bt_info_ext & BIT3) && !wifi_under_5g) {
 			if (!btcoexist->manual_control &&
 			    !btcoexist->stop_coex_dm) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n");
 				btc8821a1ant_ignore_wlan_act(btcoexist,
 							     FORCE_EXEC,
@@ -2827,27 +2827,27 @@ void ex_btc8821a1ant_bt_info_notify(struct btc_coexist *btcoexist,
 
 	if (!(bt_info & BT_INFO_8821A_1ANT_B_CONNECTION)) {
 		coex_dm->bt_status = BT_8821A_1ANT_BT_STATUS_NON_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n");
 	} else if (bt_info == BT_INFO_8821A_1ANT_B_CONNECTION) {
 		/* connection exists but no busy */
 		coex_dm->bt_status = BT_8821A_1ANT_BT_STATUS_CONNECTED_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n");
 	} else if ((bt_info&BT_INFO_8821A_1ANT_B_SCO_ESCO) ||
 		(bt_info & BT_INFO_8821A_1ANT_B_SCO_BUSY)) {
 		coex_dm->bt_status = BT_8821A_1ANT_BT_STATUS_SCO_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT SCO busy!!!\n");
 	} else if (bt_info & BT_INFO_8821A_1ANT_B_ACL_BUSY) {
 		if (BT_8821A_1ANT_BT_STATUS_ACL_BUSY != coex_dm->bt_status)
 			coex_dm->auto_tdma_adjust = false;
 		coex_dm->bt_status = BT_8821A_1ANT_BT_STATUS_ACL_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT ACL busy!!!\n");
 	} else {
 		coex_dm->bt_status = BT_8821A_1ANT_BT_STATUS_MAX;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Defined state!!!\n");
 	}
 
@@ -2868,11 +2868,11 @@ void ex_btc8821a1ant_halt_notify(struct btc_coexist *btcoexist)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	bool wifi_under_5g = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Halt notify\n");
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
@@ -2897,17 +2897,17 @@ void ex_btc8821a1ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), return for 5G <===\n");
 		btc8821a1ant_coex_under_5g(btcoexist);
 		return;
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Pnp notify\n");
 
 	if (BTC_WIFI_PNP_SLEEP == pnp_state) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to SLEEP\n");
 		/* BT should clear UnderIPS/UnderLPS state to avoid mismatch
 		 * state after wakeup.
@@ -2922,7 +2922,7 @@ void ex_btc8821a1ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 		btc8821a1ant_set_ant_path(btcoexist, BTC_ANT_PATH_BT, false,
 					  true);
 	} else if (BTC_WIFI_PNP_WAKE_UP == pnp_state) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to WAKE UP\n");
 		btcoexist->stop_coex_dm = false;
 		btc8821a1ant_init_hw_config(btcoexist, false, false);
@@ -2939,32 +2939,32 @@ void ex_btc8821a1ant_periodical(struct btc_coexist *btcoexist)
 	struct btc_board_info *board_info = &btcoexist->board_info;
 	struct btc_stack_info *stack_info = &btcoexist->stack_info;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], ==========================Periodical===========================\n");
 
 	if (dis_ver_info_cnt <= 5) {
 		dis_ver_info_cnt += 1;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], ****************************************************************\n");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Ant PG Num/ Ant Mech/ Ant Pos = %d/ %d/ %d\n",
 			      board_info->pg_ant_num,
 			      board_info->btdm_ant_num,
 			      board_info->btdm_ant_pos);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT stack/ hci ext ver = %s / %d\n",
 			      stack_info->profile_notified ? "Yes" : "No",
 			      stack_info->hci_version);
 		btcoexist->btc_get(btcoexist, BTC_GET_U4_BT_PATCH_VER,
 				   &bt_patch_ver);
 		btcoexist->btc_get(btcoexist, BTC_GET_U4_WIFI_FW_VER, &fw_ver);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CoexVer/ FwVer/ PatchVer = %d_%x/ 0x%x/ 0x%x(%d)\n",
 			      glcoex_ver_date_8821a_1ant,
 			      glcoex_ver_8821a_1ant,
 			      fw_ver, bt_patch_ver,
 			      bt_patch_ver);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], ****************************************************************\n");
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c
index e9e211fda264..622c2f5200ec 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtc8821a2ant.c
@@ -54,27 +54,27 @@ static u8 btc8821a2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			if (bt_rssi >=
 			    rssi_thresh + BTC_RSSI_COEX_THRESH_TOL_8821A_2ANT) {
 				bt_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to High\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Low\n");
 			}
 		} else {
 			if (bt_rssi < rssi_thresh) {
 				bt_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Low\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT Rssi thresh error!!\n");
 			return coex_sta->pre_bt_rssi_state;
 		}
@@ -85,11 +85,11 @@ static u8 btc8821a2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			    (rssi_thresh +
 			     BTC_RSSI_COEX_THRESH_TOL_8821A_2ANT)) {
 				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Medium\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Low\n");
 			}
 		} else if ((coex_sta->pre_bt_rssi_state ==
@@ -100,25 +100,25 @@ static u8 btc8821a2ant_bt_rssi_state(struct btc_coexist *btcoexist,
 			    (rssi_thresh1 +
 			     BTC_RSSI_COEX_THRESH_TOL_8821A_2ANT)) {
 				bt_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to High\n");
 			} else if (bt_rssi < rssi_thresh) {
 				bt_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Low\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at Medium\n");
 			}
 		} else {
 			if (bt_rssi < rssi_thresh1) {
 				bt_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state switch to Medium\n");
 			} else {
 				bt_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT Rssi state stay at High\n");
 			}
 		}
@@ -147,27 +147,27 @@ static u8 btc8821a2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >=
 			    (rssi_thresh+BTC_RSSI_COEX_THRESH_TOL_8821A_2ANT)) {
 				wifi_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to High\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Low\n");
 			}
 		} else {
 			if (wifi_rssi < rssi_thresh) {
 				wifi_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Low\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], wifi RSSI thresh error!!\n");
 			return coex_sta->pre_wifi_rssi_state[index];
 		}
@@ -180,11 +180,11 @@ static u8 btc8821a2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			    (rssi_thresh +
 			     BTC_RSSI_COEX_THRESH_TOL_8821A_2ANT)) {
 				wifi_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Medium\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Low\n");
 			}
 		} else if ((coex_sta->pre_wifi_rssi_state[index] ==
@@ -194,25 +194,25 @@ static u8 btc8821a2ant_wifi_rssi_state(struct btc_coexist *btcoexist,
 			if (wifi_rssi >= (rssi_thresh1 +
 			    BTC_RSSI_COEX_THRESH_TOL_8821A_2ANT)) {
 				wifi_rssi_state = BTC_RSSI_STATE_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to High\n");
 			} else if (wifi_rssi < rssi_thresh) {
 				wifi_rssi_state = BTC_RSSI_STATE_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Low\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at Medium\n");
 			}
 		} else {
 			if (wifi_rssi < rssi_thresh1) {
 				wifi_rssi_state = BTC_RSSI_STATE_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state switch to Medium\n");
 			} else {
 				wifi_rssi_state = BTC_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], wifi RSSI state stay at High\n");
 			}
 		}
@@ -273,10 +273,10 @@ static void btc8821a2ant_monitor_bt_ctr(struct btc_coexist *btcoexist)
 	else
 		bt_link_info->slave_role = false;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], High Priority Tx/Rx (reg 0x%x) = 0x%x(%d)/0x%x(%d)\n",
 		    reg_hp_txrx, reg_hp_tx, reg_hp_tx, reg_hp_rx, reg_hp_rx);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Low Priority Tx/Rx (reg 0x%x) = 0x%x(%d)/0x%x(%d)\n",
 		 reg_lp_txrx, reg_lp_tx, reg_lp_tx, reg_lp_rx, reg_lp_rx);
 
@@ -330,7 +330,7 @@ static void btc8821a2ant_query_bt_info(struct btc_coexist *btcoexist)
 
 	h2c_parameter[0] |= BIT0; /* trigger */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Query Bt Info, FW write 0x61 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -437,7 +437,7 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_HS_OPERATION, &bt_hs_on);
 
 	if (!bt_link_info->bt_link_exist) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			"[BTCoex], No BT link exists!!!\n");
 		return algorithm;
 	}
@@ -453,26 +453,26 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 
 	if (num_of_diff_profile == 1) {
 		if (bt_link_info->sco_exist) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], SCO only\n");
 			algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 		} else {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], HID only\n");
 				algorithm = BT_8821A_2ANT_COEX_ALGO_HID;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], A2DP only\n");
 				algorithm = BT_8821A_2ANT_COEX_ALGO_A2DP;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], PAN(HS) only\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], PAN(EDR) only\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_PANEDR;
@@ -482,21 +482,21 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 	} else if (num_of_diff_profile == 2) {
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], SCO + HID\n");
 				algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 			} else if (bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], SCO + A2DP ==> SCO\n");
 				algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 			} else if (bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + PAN(HS)\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + PAN(EDR)\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
@@ -505,18 +505,18 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 		} else {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], HID + A2DP\n");
 				algorithm = BT_8821A_2ANT_COEX_ALGO_HID_A2DP;
 			} else if (bt_link_info->hid_exist &&
 				bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + PAN(HS)\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_HID;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + PAN(EDR)\n");
 					algorithm =
@@ -525,13 +525,13 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8821A_2ANT_COEX_ALGO_A2DP_PANHS;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], A2DP + PAN(EDR)\n");
 					algorithm =
@@ -543,18 +543,18 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 		if (bt_link_info->sco_exist) {
 			if (bt_link_info->hid_exist &&
 			    bt_link_info->a2dp_exist) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], SCO + HID + A2DP ==> HID\n");
 				algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 			} else if (bt_link_info->hid_exist &&
 				bt_link_info->pan_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + HID + PAN(HS)\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + HID + PAN(EDR)\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
@@ -562,12 +562,12 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 			} else if (bt_link_info->pan_exist &&
 				   bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + A2DP + PAN(HS)\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + A2DP + PAN(EDR) ==> HID\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
@@ -578,13 +578,13 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + A2DP + PAN(HS)\n");
 					algorithm =
 					    BT_8821A_2ANT_COEX_ALGO_HID_A2DP;
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], HID + A2DP + PAN(EDR)\n");
 					algorithm =
@@ -598,12 +598,12 @@ static u8 btc8821a2ant_action_algorithm(struct btc_coexist *btcoexist)
 			    bt_link_info->pan_exist &&
 			    bt_link_info->a2dp_exist) {
 				if (bt_hs_on) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], Error!!! SCO + HID + A2DP + PAN(HS)\n");
 
 				} else {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], SCO + HID + A2DP + PAN(EDR)==>PAN(EDR)+HID\n");
 					algorithm = BT_8821A_2ANT_COEX_ALGO_SCO;
@@ -625,9 +625,9 @@ static void btc8821a2ant_set_fw_dac_swing_lvl(struct btc_coexist *btcoexist,
 	 */
 	h2c_parameter[0] = dac_swing_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Set Dac Swing Level = 0x%x\n", dac_swing_lvl);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x64 = 0x%x\n", h2c_parameter[0]);
 
 	btcoexist->btc_fill_h2c(btcoexist, 0x64, 1, h2c_parameter);
@@ -641,7 +641,7 @@ static void btc8821a2ant_set_fw_dec_bt_pwr(struct btc_coexist *btcoexist,
 
 	h2c_parameter[0] = dec_bt_pwr_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], decrease Bt Power Level : %u, FW write 0x62 = 0x%x\n",
 		 dec_bt_pwr_lvl, h2c_parameter[0]);
 
@@ -653,13 +653,13 @@ static void btc8821a2ant_dec_bt_pwr(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s Dec BT power level = %u\n",
 		    (force_exec ? "force to" : ""), dec_bt_pwr_lvl);
 	coex_dm->cur_dec_bt_pwr_lvl = dec_bt_pwr_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_dec_bt_pwr_lvl = %d, cur_dec_bt_pwr_lvl = %d\n",
 			    coex_dm->pre_dec_bt_pwr_lvl,
 			    coex_dm->cur_dec_bt_pwr_lvl);
@@ -677,13 +677,13 @@ static void btc8821a2ant_fw_dac_swing_lvl(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s set FW Dac Swing level = %d\n",
 		 (force_exec ? "force to" : ""), fw_dac_swing_lvl);
 	coex_dm->cur_fw_dac_swing_lvl = fw_dac_swing_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_fw_dac_swing_lvl = %d, cur_fw_dac_swing_lvl = %d\n",
 			 coex_dm->pre_fw_dac_swing_lvl,
 			 coex_dm->cur_fw_dac_swing_lvl);
@@ -719,7 +719,7 @@ static void btc8821a2ant_set_sw_penalty_tx_rate_adaptive(
 		h2c_parameter[5] = 0xa0;
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set WiFi Low-Penalty Retry: %s",
 		 (low_penalty_ra ? "ON!!" : "OFF!!"));
 
@@ -731,14 +731,14 @@ static void btc8821a2ant_low_penalty_ra(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn LowPenaltyRA = %s\n",
 		 (force_exec ? "force to" : ""),
 		 ((low_penalty_ra) ? "ON" : "OFF"));
 	coex_dm->cur_low_penalty_ra = low_penalty_ra;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_low_penalty_ra = %d, cur_low_penalty_ra = %d\n",
 			 coex_dm->pre_low_penalty_ra,
 			 coex_dm->cur_low_penalty_ra);
@@ -758,7 +758,7 @@ static void btc8821a2ant_set_dac_swing_reg(struct btc_coexist *btcoexist,
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	u8 val = (u8)level;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Write SwDacSwing = 0x%x\n", level);
 	btcoexist->btc_write_1byte_bitmask(btcoexist, 0xc5b, 0x3e, val);
 }
@@ -779,7 +779,7 @@ static void btc8821a2ant_dac_swing(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn DacSwing = %s, dac_swing_lvl = 0x%x\n",
 		 (force_exec ? "force to" : ""),
 		 ((dac_swing_on) ? "ON" : "OFF"),
@@ -788,7 +788,7 @@ static void btc8821a2ant_dac_swing(struct btc_coexist *btcoexist,
 	coex_dm->cur_dac_swing_lvl = dac_swing_lvl;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_dac_swing_on = %d, pre_dac_swing_lvl = 0x%x, cur_dac_swing_on = %d, cur_dac_swing_lvl = 0x%x\n",
 			 coex_dm->pre_dac_swing_on,
 			 coex_dm->pre_dac_swing_lvl,
@@ -814,19 +814,19 @@ static void btc8821a2ant_set_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c0 = 0x%x\n", val0x6c0);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c0, val0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c4 = 0x%x\n", val0x6c4);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c4, val0x6c4);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6c8 = 0x%x\n", val0x6c8);
 	btcoexist->btc_write_4byte(btcoexist, 0x6c8, val0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set coex table, set 0x6cc = 0x%x\n", val0x6cc);
 	btcoexist->btc_write_1byte(btcoexist, 0x6cc, val0x6cc);
 }
@@ -837,7 +837,7 @@ static void btc8821a2ant_coex_table(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s write Coex Table 0x6c0 = 0x%x, 0x6c4 = 0x%x, 0x6c8 = 0x%x, 0x6cc = 0x%x\n",
 		 (force_exec ? "force to" : ""),
 		 val0x6c0, val0x6c4, val0x6c8, val0x6cc);
@@ -847,13 +847,13 @@ static void btc8821a2ant_coex_table(struct btc_coexist *btcoexist,
 	coex_dm->cur_val0x6cc = val0x6cc;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_val0x6c0 = 0x%x, pre_val0x6c4 = 0x%x, pre_val0x6c8 = 0x%x, pre_val0x6cc = 0x%x !!\n",
 			 coex_dm->pre_val0x6c0,
 			 coex_dm->pre_val0x6c4,
 			 coex_dm->pre_val0x6c8,
 			 coex_dm->pre_val0x6cc);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], cur_val0x6c0 = 0x%x, cur_val0x6c4 = 0x%x, cur_val0x6c8 = 0x%x, cur_val0x6cc = 0x%x !!\n",
 			 coex_dm->cur_val0x6c0,
 			 coex_dm->cur_val0x6c4,
@@ -967,7 +967,7 @@ static void btc8821a2ant_set_fw_ignore_wlan_act(struct btc_coexist *btcoex,
 	if (enable)
 		h2c_parameter[0] |= BIT0; /* function enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], set FW for BT Ignore Wlan_Act, FW write 0x63 = 0x%x\n",
 		 h2c_parameter[0]);
 
@@ -1006,13 +1006,13 @@ static void btc8821a2ant_ignore_wlan_act(struct btc_coexist *btcoexist,
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn Ignore WlanAct %s\n",
 		 (force_exec ? "force to" : ""), (enable ? "ON" : "OFF"));
 	coex_dm->cur_ignore_wlan_act = enable;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_ignore_wlan_act = %d, cur_ignore_wlan_act = %d!!\n",
 			 coex_dm->pre_ignore_wlan_act,
 			 coex_dm->cur_ignore_wlan_act);
@@ -1045,7 +1045,7 @@ static void btc8821a2ant_set_fw_ps_tdma(struct btc_coexist *btcoexist,
 	coex_dm->ps_tdma_para[3] = byte4;
 	coex_dm->ps_tdma_para[4] = byte5;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x60(5bytes) = 0x%x%08x\n",
 		 h2c_parameter[0],
 		 h2c_parameter[1] << 24 |
@@ -1137,7 +1137,7 @@ static void btc8821a2ant_ps_tdma(struct btc_coexist *btcoexist,
 		type = type + 100;
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], %s turn %s PS TDMA, type = %d\n",
 		 (force_exec ? "force to" : ""), (turn_on ? "ON" : "OFF"),
 		 type);
@@ -1145,10 +1145,10 @@ static void btc8821a2ant_ps_tdma(struct btc_coexist *btcoexist,
 	coex_dm->cur_ps_tdma = type;
 
 	if (!force_exec) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_ps_tdma_on = %d, cur_ps_tdma_on = %d!!\n",
 			 coex_dm->pre_ps_tdma_on, coex_dm->cur_ps_tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], pre_ps_tdma = %d, cur_ps_tdma = %d!!\n",
 			 coex_dm->pre_ps_tdma, coex_dm->cur_ps_tdma);
 
@@ -1472,17 +1472,17 @@ static void btc8821a2ant_action_bt_inquiry(struct btc_coexist *btcoexist)
 	btc8821a2ant_power_save_state(btcoexist, BTC_PS_WIFI_NATIVE, 0x0, 0x0);
 
 	if (scan || link || roam) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi link process + BT Inq/Page!!\n");
 		btc8821a2ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 15);
 		btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 22);
 	} else if (wifi_connected) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi connected + BT Inq/Page!!\n");
 		btc8821a2ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 15);
 		btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true, 22);
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi no-link + BT Inq/Page!!\n");
 		btc8821a2ant_coex_table_with_type(btcoexist, NORMAL_EXEC, 0);
 		btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, false, 1);
@@ -1509,7 +1509,7 @@ static void btc8821a2ant_action_wifi_link_process(struct btc_coexist *btcoexist)
 	u8tmpa = btcoexist->btc_read_1byte(btcoexist, 0x765);
 	u8tmpb = btcoexist->btc_read_1byte(btcoexist, 0x76e);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 0x765=0x%x, 0x76e=0x%x\n", u8tmpa, u8tmpb);
 }
 
@@ -1531,7 +1531,7 @@ static bool btc8821a2ant_action_wifi_idle_process(struct btc_coexist *btcoexist)
 	/* define the office environment */
 	if (BTC_RSSI_HIGH(wifi_rssi_state1) && (coex_sta->hid_exist) &&
 	    (coex_sta->a2dp_exist)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi  idle process for BT HID+A2DP exist!!\n");
 
 		btc8821a2ant_dac_swing(btcoexist, NORMAL_EXEC, true, 0x6);
@@ -1550,7 +1550,7 @@ static bool btc8821a2ant_action_wifi_idle_process(struct btc_coexist *btcoexist)
 
 		return true;
 	} else if (coex_sta->pan_exist) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Wifi  idle process for BT PAN exist!!\n");
 
 		btc8821a2ant_dac_swing(btcoexist, NORMAL_EXEC, true, 0x6);
@@ -1592,7 +1592,7 @@ static bool btc8821a2ant_is_common_action(struct btc_coexist *btcoexist)
 		btc8821a2ant_limited_rx(btcoexist, NORMAL_EXEC, false, false,
 					0x8);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			    "[BTCoex], Wifi non-connected idle!!\n");
 
 		btcoexist->btc_set_rf_reg(btcoexist, BTC_RF_A, 0x1, 0xfffff,
@@ -1620,7 +1620,7 @@ static bool btc8821a2ant_is_common_action(struct btc_coexist *btcoexist)
 			btc8821a2ant_limited_rx(btcoexist, NORMAL_EXEC,
 						false, false, 0x8);
 
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Wifi connected + BT non connected-idle!!\n");
 
 			btcoexist->btc_set_rf_reg(btcoexist, BTC_RF_A, 0x1,
@@ -1650,7 +1650,7 @@ static bool btc8821a2ant_is_common_action(struct btc_coexist *btcoexist)
 
 			if (bt_hs_on)
 				return false;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Wifi connected + BT connected-idle!!\n");
 			btc8821a2ant_limited_rx(btcoexist, NORMAL_EXEC,
 						false, false, 0x8);
@@ -1679,11 +1679,11 @@ static bool btc8821a2ant_is_common_action(struct btc_coexist *btcoexist)
 					   &low_pwr_disable);
 
 			if (wifi_busy) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Wifi Connected-Busy + BT Busy!!\n");
 				common = false;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Wifi Connected-Idle + BT Busy!!\n");
 				common =
 				    btc8821a2ant_action_wifi_idle_process(
@@ -1707,12 +1707,12 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	int result;
 	u8 retry_count = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], TdmaDurationAdjust()\n");
 
 	if (coex_dm->auto_tdma_adjust) {
 		coex_dm->auto_tdma_adjust = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], first run TdmaDurationAdjust()!!\n");
 		if (sco_hid) {
 			if (tx_pause) {
@@ -1801,9 +1801,9 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	} else {
 		/* accquire the BT TRx retry count from BT_Info byte2 */
 		retry_count = coex_sta->bt_retry_cnt;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], retry_count = %d\n", retry_count);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], up = %d, dn = %d, m = %d, n = %d, wait_count = %d\n",
 			    (int)up, (int)dn, (int)m, (int)n, (int)wait_count);
 		result = 0;
@@ -1826,7 +1826,7 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 				up = 0;
 				dn = 0;
 				result = 1;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Increase wifi duration!!\n");
 			}
 		} else if (retry_count <= 3) {
@@ -1856,7 +1856,7 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 				dn = 0;
 				wait_count = 0;
 				result = -1;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], Decrease wifi duration for retryCounter<3!!\n");
 			}
 		} else {
@@ -1878,11 +1878,11 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 			dn = 0;
 			wait_count = 0;
 			result = -1;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Decrease wifi duration for retryCounter>3!!\n");
 		}
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], max Interval = %d\n", max_interval);
 
 		if (max_interval == 1) {
@@ -2591,7 +2591,7 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 	if (coex_dm->cur_ps_tdma != coex_dm->ps_tdma_du_adj_type) {
 		bool scan = false, link = false, roam = false;
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], PsTdma type mismatch!!!, cur_ps_tdma = %d, recordPsTdma = %d\n",
 			 coex_dm->cur_ps_tdma, coex_dm->ps_tdma_du_adj_type);
 
@@ -2603,7 +2603,7 @@ static void btc8821a2ant_tdma_duration_adjust(struct btc_coexist *btcoexist,
 			btc8821a2ant_ps_tdma(btcoexist, NORMAL_EXEC, true,
 					     coex_dm->ps_tdma_du_adj_type);
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], roaming/link/scan is under progress, will adjust next time!!!\n");
 		}
 	}
@@ -3389,7 +3389,7 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	bool scan = false, link = false, roam = false;
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Manual control!!!\n");
 		return;
 	}
@@ -3397,14 +3397,14 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_UNDER_5G, &wifi_under_5g);
 
 	if (wifi_under_5g) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], RunCoexistMechanism(), run 5G coex setting!!<===\n");
 		btc8821a2ant_coex_under_5g(btcoexist);
 		return;
 	}
 
 	if (coex_sta->under_ips) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], wifi is under IPS !!!\n");
 		return;
 	}
@@ -3412,7 +3412,7 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	algorithm = btc8821a2ant_action_algorithm(btcoexist);
 	if (coex_sta->c2h_bt_inquiry_page &&
 	    (BT_8821A_2ANT_COEX_ALGO_PANHS != algorithm)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BT is under inquiry/page scan !!\n");
 		btc8821a2ant_action_bt_inquiry(btcoexist);
 		return;
@@ -3423,7 +3423,7 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 	btcoexist->btc_get(btcoexist, BTC_GET_BL_WIFI_ROAM, &roam);
 
 	if (scan || link || roam) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], WiFi is under Link Process !!\n");
 		btc8821a2ant_action_wifi_link_process(btcoexist);
 		return;
@@ -3436,7 +3436,7 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 
 	if ((num_of_wifi_link >= 2) ||
 	    (wifi_link_status & WIFI_P2P_GO_CONNECTED)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "############# [BTCoex],  Multi-Port num_of_wifi_link = %d, wifi_link_status = 0x%x\n",
 			 num_of_wifi_link, wifi_link_status);
 
@@ -3457,16 +3457,16 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 			   &miracast_plus_bt);
 
 	coex_dm->cur_algorithm = algorithm;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Algorithm = %d\n", coex_dm->cur_algorithm);
 
 	if (btc8821a2ant_is_common_action(btcoexist)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Action 2-Ant common\n");
 		coex_dm->auto_tdma_adjust = true;
 	} else {
 		if (coex_dm->cur_algorithm != coex_dm->pre_algorithm) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], pre_algorithm = %d, cur_algorithm = %d\n",
 				    coex_dm->pre_algorithm,
 				    coex_dm->cur_algorithm);
@@ -3474,57 +3474,57 @@ static void btc8821a2ant_run_coexist_mechanism(struct btc_coexist *btcoexist)
 		}
 		switch (coex_dm->cur_algorithm) {
 		case BT_8821A_2ANT_COEX_ALGO_SCO:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = SCO\n");
 			btc8821a2ant_action_sco(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HID\n");
 			btc8821a2ant_action_hid(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = A2DP\n");
 			btc8821a2ant_action_a2dp(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_A2DP_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = A2DP+PAN(HS)\n");
 			btc8821a2ant_action_a2dp_pan_hs(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = PAN(EDR)\n");
 			btc8821a2ant_action_pan_edr(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_PANHS:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HS mode\n");
 			btc8821a2ant_action_pan_hs(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_PANEDR_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = PAN+A2DP\n");
 			btc8821a2ant_action_pan_edr_a2dp(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_PANEDR_HID:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = PAN(EDR)+HID\n");
 			btc8821a2ant_action_pan_edr_hid(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_HID_A2DP_PANEDR:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HID+A2DP+PAN\n");
 			btc8821a2ant_act_hid_a2dp_pan_edr(btcoexist);
 			break;
 		case BT_8821A_2ANT_COEX_ALGO_HID_A2DP:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = HID+A2DP\n");
 			btc8821a2ant_action_hid_a2dp(btcoexist);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Action 2-Ant, algorithm = coexist All Off!!\n");
 			btc8821a2ant_coex_all_off(btcoexist);
 			break;
@@ -3561,7 +3561,7 @@ void ex_btc8821a2ant_init_hwconfig(struct btc_coexist *btcoexist)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 	u8 u1tmp = 0;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], 2Ant Init HW Config!!\n");
 
 	/* backup rf 0x1e value */
@@ -3629,7 +3629,7 @@ void ex_btc8821a2ant_init_coex_dm(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Coex Mechanism Init!!\n");
 
 	btc8821a2ant_init_coex_dm(btcoexist);
@@ -3840,14 +3840,14 @@ void ex_btc8821a2ant_ips_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_IPS_ENTER == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS ENTER notify\n");
 		coex_sta->under_ips = true;
 		btc8821a2ant_wifi_off_hw_cfg(btcoexist);
 		btc8821a2ant_ignore_wlan_act(btcoexist, FORCE_EXEC, true);
 		btc8821a2ant_coex_all_off(btcoexist);
 	} else if (BTC_IPS_LEAVE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], IPS LEAVE notify\n");
 		coex_sta->under_ips = false;
 		ex_btc8821a2ant_init_hwconfig(btcoexist);
@@ -3861,11 +3861,11 @@ void ex_btc8821a2ant_lps_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_LPS_ENABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS ENABLE notify\n");
 		coex_sta->under_lps = true;
 	} else if (BTC_LPS_DISABLE == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], LPS DISABLE notify\n");
 		coex_sta->under_lps = false;
 	}
@@ -3876,10 +3876,10 @@ void ex_btc8821a2ant_scan_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_SCAN_START == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN START notify\n");
 	} else if (BTC_SCAN_FINISH == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], SCAN FINISH notify\n");
 	}
 }
@@ -3889,10 +3889,10 @@ void ex_btc8821a2ant_connect_notify(struct btc_coexist *btcoexist, u8 type)
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (BTC_ASSOCIATE_START == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT START notify\n");
 	} else if (BTC_ASSOCIATE_FINISH == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], CONNECT FINISH notify\n");
 	}
 }
@@ -3907,10 +3907,10 @@ void ex_btc8821a2ant_media_status_notify(struct btc_coexist *btcoexist,
 	u8 ap_num = 0;
 
 	if (BTC_MEDIA_CONNECT == type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA connect notify\n");
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], MEDIA disconnect notify\n");
 	}
 
@@ -3937,7 +3937,7 @@ void ex_btc8821a2ant_media_status_notify(struct btc_coexist *btcoexist,
 	coex_dm->wifi_chnl_info[1] = h2c_parameter[1];
 	coex_dm->wifi_chnl_info[2] = h2c_parameter[2];
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], FW write 0x66 = 0x%x\n",
 		 h2c_parameter[0] << 16 |
 		 h2c_parameter[1] << 8 |
@@ -3952,7 +3952,7 @@ void ex_btc8821a2ant_special_packet_notify(struct btc_coexist *btcoexist,
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
 	if (type == BTC_PACKET_DHCP) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], DHCP Packet notify\n");
 	}
 }
@@ -3976,7 +3976,7 @@ void ex_btc8821a2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		rsp_source = BT_INFO_SRC_8821A_2ANT_WIFI_FW;
 	coex_sta->bt_info_c2h_cnt[rsp_source]++;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Bt info[%d], length = %d, hex data = [",
 		      rsp_source, length);
 	for (i = 0; i < length; i++) {
@@ -3984,16 +3984,16 @@ void ex_btc8821a2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		if (i == 1)
 			bt_info = tmp_buf[i];
 		if (i == length - 1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x]\n", tmp_buf[i]);
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "0x%02x, ", tmp_buf[i]);
 		}
 	}
 
 	if (btcoexist->manual_control) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), return for Manual CTRL<===\n");
 		return;
 	}
@@ -4016,7 +4016,7 @@ void ex_btc8821a2ant_bt_info_notify(struct btc_coexist *btcoexist,
 			/* BT into is responded by BT FW and BT RF REG 0x3C !=
 			 * 0x01 => Need to switch BT TRx Mask
 			 */
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Switch BT TRx Mask since BT RF REG 0x3C != 0x01\n");
 			btcoexist->btc_set_bt_reg(btcoexist, BTC_BT_REG_RF,
 						  0x3c, 0x01);
@@ -4039,15 +4039,15 @@ void ex_btc8821a2ant_bt_info_notify(struct btc_coexist *btcoexist,
 		}
 
 		if (!btcoexist->manual_control && !wifi_under_5g) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], BT ext info = 0x%x!!\n",
 				    coex_sta->bt_info_ext);
 			if ((coex_sta->bt_info_ext & BIT(3))) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT ext info bit3=1, wifi_connected=%d\n",
 					 wifi_connected);
 				if (wifi_connected) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						 "[BTCoex], BT ext info bit3 check, set BT NOT to ignore Wlan active!!\n");
 					btc8821a2ant_ignore_wlan_act(btcoexist,
@@ -4055,14 +4055,14 @@ void ex_btc8821a2ant_bt_info_notify(struct btc_coexist *btcoexist,
 								     false);
 				}
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 					 "[BTCoex], BT ext info bit3=0, wifi_connected=%d\n",
 					 wifi_connected);
 				/* BT already NOT ignore Wlan active, do nothing
 				 * here.
 				 */
 				if (!wifi_connected) {
-					RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+					RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 						 DBG_LOUD,
 						"[BTCoex], BT ext info bit3 check, set BT to ignore Wlan active!!\n");
 					btc8821a2ant_ignore_wlan_act(
@@ -4117,25 +4117,25 @@ void ex_btc8821a2ant_bt_info_notify(struct btc_coexist *btcoexist,
 
 	if (!(bt_info & BT_INFO_8821A_2ANT_B_CONNECTION)) {
 		coex_dm->bt_status = BT_8821A_2ANT_BT_STATUS_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Connected idle!!!\n");
 	} else if (bt_info == BT_INFO_8821A_2ANT_B_CONNECTION) {
 		/* connection exists but no busy */
 		coex_dm->bt_status = BT_8821A_2ANT_BT_STATUS_CON_IDLE;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Connected-idle!!!\n");
 	} else if ((bt_info & BT_INFO_8821A_2ANT_B_SCO_ESCO) ||
 		   (bt_info & BT_INFO_8821A_2ANT_B_SCO_BUSY)) {
 		coex_dm->bt_status = BT_8821A_2ANT_BT_STATUS_SCO_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT SCO busy!!!\n");
 	} else if (bt_info & BT_INFO_8821A_2ANT_B_ACL_BUSY) {
 		coex_dm->bt_status = BT_8821A_2ANT_BT_STATUS_ACL_BUSY;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT ACL busy!!!\n");
 	} else {
 		coex_dm->bt_status = BT_8821A_2ANT_BT_STATUS_MAX;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], BtInfoNotify(), BT Non-Defined state!!!\n");
 	}
 
@@ -4161,7 +4161,7 @@ void ex_btc8821a2ant_halt_notify(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], Halt notify\n");
 
 	btc8821a2ant_wifi_off_hw_cfg(btcoexist);
@@ -4173,13 +4173,13 @@ void ex_btc8821a2ant_pnp_notify(struct btc_coexist *btcoexist, u8 pnp_state)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Pnp notify\n");
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD, "[BTCoex], Pnp notify\n");
 
 	if (pnp_state == BTC_WIFI_PNP_SLEEP) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to SLEEP\n");
 	} else if (pnp_state == BTC_WIFI_PNP_WAKE_UP) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Pnp notify to WAKE UP\n");
 		ex_btc8821a2ant_init_hwconfig(btcoexist);
 		btc8821a2ant_init_coex_dm(btcoexist);
@@ -4191,7 +4191,7 @@ void ex_btc8821a2ant_periodical(struct btc_coexist *btcoexist)
 {
 	struct rtl_priv *rtlpriv = btcoexist->adapter;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[BTCoex], ==========================Periodical===========================\n");
 
 	if (coex_sta->dis_ver_info_cnt <= 5) {
@@ -4200,7 +4200,7 @@ void ex_btc8821a2ant_periodical(struct btc_coexist *btcoexist)
 			/* Antenna config to set 0x765 = 0x0 (GNT_BT control by
 			 * PTA) after initial
 			 */
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 				 "[BTCoex], Set GNT_BT control by PTA\n");
 			btc8821a2ant_set_ant_path(btcoexist,
 					BTC_ANT_WIFI_AT_MAIN, false, false);
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
index a4940a3842de..a3f7c1799240 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/halbtcoutsrc.c
@@ -129,7 +129,7 @@ static u8 halbtc_get_wifi_central_chnl(struct btc_coexist *btcoexist)
 
 	if (rtlphy->current_channel != 0)
 		chnl = rtlphy->current_channel;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "static halbtc_get_wifi_central_chnl:%d\n", chnl);
 	return chnl;
 }
@@ -250,7 +250,7 @@ bool halbtc_send_bt_mp_operation(struct btc_coexist *btcoexist, u8 op_code,
 	if (!wait_ms)
 		return true;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "btmpinfo wait req_num=%d wait=%ld\n", req_num, wait_ms);
 
 	if (in_interrupt())
@@ -258,7 +258,7 @@ bool halbtc_send_bt_mp_operation(struct btc_coexist *btcoexist, u8 op_code,
 
 	if (wait_for_completion_timeout(&btcoexist->bt_mp_comp,
 					msecs_to_jiffies(wait_ms)) == 0) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "btmpinfo wait (req_num=%d) timeout\n", req_num);
 
 		return false;	/* timeout */
@@ -278,7 +278,7 @@ static void halbtc_leave_lps(struct btc_coexist *btcoexist)
 			   &ap_enable);
 
 	if (ap_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "%s()<--dont leave lps under AP mode\n", __func__);
 		return;
 	}
@@ -299,7 +299,7 @@ static void halbtc_enter_lps(struct btc_coexist *btcoexist)
 			   &ap_enable);
 
 	if (ap_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "%s()<--dont enter lps under AP mode\n", __func__);
 		return;
 	}
@@ -1370,10 +1370,10 @@ bool exhalbtc_bind_bt_coex_withadapter(void *adapter)
 		btcoexist->board_info.tfbga_package = true;
 
 	if (btcoexist->board_info.tfbga_package)
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Package Type = TFBGA\n");
 	else
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[BTCoex], Package Type = Non-TFBGA\n");
 
 	btcoexist->board_info.rfe_type = rtl_get_hwpg_rfe_type(rtlpriv);
diff --git a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
index b8c4536af6c0..f59ab3e00bfa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/btcoexist/rtl_btc.c
@@ -191,7 +191,7 @@ void rtl_btc_init_hw_config(struct rtl_priv *rtlpriv)
 	u8 bt_exist;
 
 	bt_exist = rtl_get_hwpg_bt_exist(rtlpriv);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		"%s, bt_exist is %d\n", __func__, bt_exist);
 
 	if (!btcoexist)
@@ -383,7 +383,7 @@ void rtl_btc_btmpinfo_notify(struct rtl_priv *rtlpriv, u8 *tmp_buf, u8 length)
 		break;
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "btmpinfo complete req_num=%d\n", seq);
 
 	complete(&btcoexist->bt_mp_comp);
-- 
2.27.0

