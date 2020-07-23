Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB8A22B7F4
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGWUm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgGWUmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:54 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2AC0619E2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:54 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id h17so6219565oie.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KumTcds8e9x7Fpj8O+PgNsblzb30Kp2mdIqn0U7PPDE=;
        b=bzOMCgBk388/fKvpPv/yNTyQTtm8Jyn8pZ46eJef2ZUBeKXBI75w3AhWgHwKgO3IqV
         UYFWghUERJag921SO+VBfxXpMwXw1YnDhoLOHBINAfwqxdbUrH2DAS5Ta+QuEssteoNv
         Jqw1AAfpmL6p6yX73TpWvxsMACzSLALYyhXyVOdxSgHXg04FzW36FU3WQpUVMOjjyhIf
         KsDci45Fcg6MKVH+WsJPxNUivNIDq0ITrjA8zzMgQKge25Ec7vPudTTyMYxfqXJp5TBr
         c0wyfEt+/bcBdt7OElwVoaPP2+pnmO18vE9ZfVAUVeSzUYENx+O6CZkW0p5rpYm1k1E7
         C9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KumTcds8e9x7Fpj8O+PgNsblzb30Kp2mdIqn0U7PPDE=;
        b=romzWK6v2YpBVrQg2+D1Uo1mgw6zQs4Md7bjPT/tzKnuWXmdG7qJFCbrhOq83HO7j1
         wpsaOsb2XQlH7Oj6Ij+vYSBKL48UM+ZEFBZrVOc23X38KXrMau7nVaBbcJiin5uyKEFk
         L57uAVc5sKZodfFM9Ov/1e6DiCOdBbm5W4aG6Wdm6lbeWgqxzKNVSRZa2jQx/lmfLIJf
         3ncP9+u6QqMWXwy55jFdtalRnTY737n28lCOQ28bCFVOmsaUTARBeSprlF9agOnQrXgw
         CiLZjjK0mzN2pY14iJgb61Mtlw//vvzI6JTv0MJ/tUcZDU0yfZdl8SHY5DDycxhIb7Aa
         v0xg==
X-Gm-Message-State: AOAM530cHeAjnwIs4dMbbmGhTJQEDT4TEesMXD2CTIfCNdAb3WbQ6cEH
        gr02HWjvvaMycxURpijARKw=
X-Google-Smtp-Source: ABdhPJyfkNvqlsirl36swI5JJSYHBTCe7inj1Sre+etBOgNRKnW+vx1R7HmKLFyVHsRckgkeOb7hrA==
X-Received: by 2002:aca:c392:: with SMTP id t140mr5231680oif.131.1595536971901;
        Thu, 23 Jul 2020 13:42:51 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:51 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 04/15] rtlwifi: rtl8188ee: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:33 -0500
Message-Id: <20200723204244.24457-5-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
References: <20200723204244.24457-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the misleading macro name to one that is more descriptive for
rtl8188ee. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   | 192 ++++-----
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.c   |  90 ++--
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   | 194 ++++-----
 .../wireless/realtek/rtlwifi/rtl8188ee/led.c  |  20 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/phy.c  | 385 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8188ee/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.c  |  24 +-
 7 files changed, 455 insertions(+), 456 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index 1ffa188a65c9..d10c14c694da 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -415,16 +415,16 @@ static void rtl88e_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, BIT(15)|BIT(14), 0);
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, BIT(15)|BIT(14), 2);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "cnt_parity_fail = %d, cnt_rate_illegal = %d, cnt_crc8_fail = %d, cnt_mcs_fail = %d\n",
-		 falsealm_cnt->cnt_parity_fail,
-		 falsealm_cnt->cnt_rate_illegal,
-		 falsealm_cnt->cnt_crc8_fail, falsealm_cnt->cnt_mcs_fail);
-
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "cnt_ofdm_fail = %x, cnt_cck_fail = %x, cnt_all = %x\n",
-		 falsealm_cnt->cnt_ofdm_fail,
-		 falsealm_cnt->cnt_cck_fail, falsealm_cnt->cnt_all);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"cnt_parity_fail = %d, cnt_rate_illegal = %d, cnt_crc8_fail = %d, cnt_mcs_fail = %d\n",
+		falsealm_cnt->cnt_parity_fail,
+		falsealm_cnt->cnt_rate_illegal,
+		falsealm_cnt->cnt_crc8_fail, falsealm_cnt->cnt_mcs_fail);
+
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"cnt_ofdm_fail = %x, cnt_cck_fail = %x, cnt_all = %x\n",
+		falsealm_cnt->cnt_ofdm_fail,
+		falsealm_cnt->cnt_cck_fail, falsealm_cnt->cnt_all);
 }
 
 static void rtl88e_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
@@ -459,8 +459,8 @@ static void rtl88e_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 
 	dm_dig->cur_cck_cca_thres = cur_cck_cca_thresh;
 	dm_dig->pre_cck_cca_thres = dm_dig->cur_cck_cca_thres;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "CCK cca thresh hold =%x\n", dm_dig->cur_cck_cca_thres);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"CCK cca thresh hold =%x\n", dm_dig->cur_cck_cca_thres);
 }
 
 static void rtl88e_dm_dig(struct ieee80211_hw *hw)
@@ -520,7 +520,7 @@ static void rtl88e_dm_dig(struct ieee80211_hw *hw)
 	} else {
 		dm_dig->rx_gain_max = dm_dig_max;
 		dig_dynamic_min = dm_dig_min;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
 	}
 
 	if (rtlpriv->falsealm_cnt.cnt_all > 10000) {
@@ -624,8 +624,8 @@ static void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 
@@ -637,47 +637,47 @@ static void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-				  undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%lx\n",
-				  undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"STA Default Port PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		}
 	} else {
 		undec_sm_pwdb =
 		    rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "AP Ext Port PWDB = 0x%lx\n",
-			  undec_sm_pwdb);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"AP Ext Port PWDB = 0x%lx\n",
+			undec_sm_pwdb);
 	}
 
 	if (undec_sm_pwdb >= TX_POWER_NEAR_FIELD_THRESH_LVL2) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr = 0x0)\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_LEVEL1 (TxPwr = 0x0)\n");
 	} else if ((undec_sm_pwdb <
 		    (TX_POWER_NEAR_FIELD_THRESH_LVL2 - 3)) &&
 		   (undec_sm_pwdb >=
 		    TX_POWER_NEAR_FIELD_THRESH_LVL1)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr = 0x10)\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_LEVEL1 (TxPwr = 0x10)\n");
 	} else if (undec_sm_pwdb <
 		   (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_NORMAL\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_NORMAL\n");
 	}
 
 	if ((rtlpriv->dm.dynamic_txhighpower_lvl !=
 		rtlpriv->dm.last_dtp_lvl)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"PHY_SetTxPowerLevel8192S() Channel = %d\n",
 			  rtlphy->current_channel);
 		rtl88e_phy_set_txpower_level(hw, rtlphy->current_channel);
 	}
@@ -690,8 +690,8 @@ void rtl88e_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_dig = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, backoff_val = %d\n",
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"cur_igvalue = 0x%x, pre_igvalue = 0x%x, backoff_val = %d\n",
 		 dm_dig->cur_igvalue, dm_dig->pre_igvalue,
 		 dm_dig->back_val);
 
@@ -881,17 +881,17 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 
 	/*Initilization (7 steps in total) */
 	rtlpriv->dm.txpower_trackinginit = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "dm_txpower_track_cb_therm\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"%s\n", __func__);
 
 	thermalvalue = (u8)rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER,
 					 0xfc00);
 	if (!thermalvalue)
 		return;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
-		 thermalvalue, rtlpriv->dm.thermalvalue,
-		 rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
+		thermalvalue, rtlpriv->dm.thermalvalue,
+		rtlefuse->eeprom_thermalmeter);
 
 	/*1. Query OFDM Default Setting: Path A*/
 	ele_d = rtl_get_bbreg(hw, ROFDM0_XATXIQIMBALANCE, MASKDWORD) &
@@ -900,8 +900,8 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 			ofdm_index_old[0] = (u8)i;
 			rtldm->swing_idx_ofdm_base[RF90_PATH_A] = (u8)i;
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index = 0x%x\n",
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index = 0x%x\n",
 				 ROFDM0_XATXIQIMBALANCE,
 				 ele_d, ofdm_index_old[0]);
 			break;
@@ -915,24 +915,24 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 			if (memcmp(&temp_cck, &cck_tbl_ch14[i][2], 4) == 0) {
 				cck_index_old = (u8)i;
 				rtldm->swing_idx_cck_base = (u8)i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-					 DBG_LOUD,
-					 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch 14 %d\n",
-					 RCCK0_TXFILTER2, temp_cck,
-					 cck_index_old,
-					 rtlpriv->dm.cck_inch14);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+					DBG_LOUD,
+					"Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch 14 %d\n",
+					RCCK0_TXFILTER2, temp_cck,
+					cck_index_old,
+					rtlpriv->dm.cck_inch14);
 				break;
 			}
 		} else {
 			if (memcmp(&temp_cck, &cck_tbl_ch1_13[i][2], 4) == 0) {
 				cck_index_old = (u8)i;
 				rtldm->swing_idx_cck_base = (u8)i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-					 DBG_LOUD,
-					 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
-					 RCCK0_TXFILTER2, temp_cck,
-					 cck_index_old,
-					 rtlpriv->dm.cck_inch14);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+					DBG_LOUD,
+					"Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
+					RCCK0_TXFILTER2, temp_cck,
+					cck_index_old,
+					rtlpriv->dm.cck_inch14);
 				break;
 			}
 		}
@@ -987,11 +987,11 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 	    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
 	    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
-		 thermalvalue, rtlpriv->dm.thermalvalue,
-		 rtlefuse->eeprom_thermalmeter, delta, delta_lck,
-		 delta_iqk);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
+		thermalvalue, rtlpriv->dm.thermalvalue,
+		rtlefuse->eeprom_thermalmeter, delta, delta_lck,
+		delta_iqk);
 	/* 6 If necessary, do LCK.*/
 	if (delta_lck >= 8) {
 		rtlpriv->dm.thermalvalue_lck = thermalvalue;
@@ -1072,7 +1072,7 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 	if (rtldm->txpower_track_control)
 		rtldm->thermalvalue = thermalvalue;
 	rtldm->txpowercount = 0;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "end\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "end\n");
 }
 
 static void rtl88e_dm_init_txpower_tracking(struct ieee80211_hw *hw)
@@ -1087,9 +1087,9 @@ static void rtl88e_dm_init_txpower_tracking(struct ieee80211_hw *hw)
 	rtlpriv->dm.swing_idx_ofdm[RF90_PATH_A] = 12;
 	rtlpriv->dm.swing_idx_ofdm_cur = 12;
 	rtlpriv->dm.swing_flag_ofdm = false;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "rtlpriv->dm.txpower_tracking = %d\n",
-		 rtlpriv->dm.txpower_tracking);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"rtlpriv->dm.txpower_tracking = %d\n",
+		rtlpriv->dm.txpower_tracking);
 }
 
 void rtl88e_dm_check_txpower_tracking(struct ieee80211_hw *hw)
@@ -1102,13 +1102,13 @@ void rtl88e_dm_check_txpower_tracking(struct ieee80211_hw *hw)
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17)|BIT(16),
 			      0x03);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Trigger 88E Thermal Meter!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Trigger 88E Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Schedule TxPowerTracking !!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Schedule TxPowerTracking !!\n");
 		dm_txpower_track_cb_therm(hw);
 		rtlpriv->dm.tm_trigger = 0;
 	}
@@ -1138,14 +1138,14 @@ static void rtl88e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 	struct ieee80211_sta *sta = NULL;
 
 	if (is_hal_stop(rtlhal)) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-			 "driver is going to unload\n");
+		rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+			"driver is going to unload\n");
 		return;
 	}
 
 	if (!rtlpriv->dm.useramask) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-			 "driver does not control rate adaptive mask\n");
+		rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+			"driver does not control rate adaptive mask\n");
 		return;
 	}
 
@@ -1180,14 +1180,14 @@ static void rtl88e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 			p_ra->ratr_state = DM_RATR_STA_LOW;
 
 		if (p_ra->pre_ratr_state != p_ra->ratr_state) {
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI = %ld\n",
-				  rtlpriv->dm.undec_sm_pwdb);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI_LEVEL = %d\n", p_ra->ratr_state);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "PreState = %d, CurState = %d\n",
-				  p_ra->pre_ratr_state, p_ra->ratr_state);
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"RSSI = %ld\n",
+				rtlpriv->dm.undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"RSSI_LEVEL = %d\n", p_ra->ratr_state);
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"PreState = %d, CurState = %d\n",
+				p_ra->pre_ratr_state, p_ra->ratr_state);
 
 			rcu_read_lock();
 			sta = rtl_find_sta(hw, mac->bssid);
@@ -1224,8 +1224,8 @@ static void rtl88e_dm_update_rx_idle_ant(struct ieee80211_hw *hw,
 	u32 default_ant, optional_ant;
 
 	if (pfat_table->rx_idle_ant != ant) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "need to update rx idle ant\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"need to update rx idle ant\n");
 		if (ant == MAIN_ANT) {
 			default_ant =
 			  (pfat_table->rx_idle_ant == CG_TRX_HW_ANTDIV) ?
@@ -1260,8 +1260,8 @@ static void rtl88e_dm_update_rx_idle_ant(struct ieee80211_hw *hw,
 		}
 	}
 	pfat_table->rx_idle_ant = ant;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "RxIdleAnt %s\n",
-		 (ant == MAIN_ANT) ? ("MAIN_ANT") : ("AUX_ANT"));
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "RxIdleAnt %s\n",
+		(ant == MAIN_ANT) ? ("MAIN_ANT") : ("AUX_ANT"));
 }
 
 static void rtl88e_dm_update_tx_ant(struct ieee80211_hw *hw,
@@ -1280,9 +1280,9 @@ static void rtl88e_dm_update_tx_ant(struct ieee80211_hw *hw,
 	pfat_table->antsel_a[mac_id] = target_ant & BIT(0);
 	pfat_table->antsel_b[mac_id] = (target_ant & BIT(1)) >> 1;
 	pfat_table->antsel_c[mac_id] = (target_ant & BIT(2)) >> 2;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "txfrominfo target ant %s\n",
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "txfrominfo target ant %s\n",
 		(ant == MAIN_ANT) ? ("MAIN_ANT") : ("AUX_ANT"));
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "antsel_tr_mux = 3'b%d%d%d\n",
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "antsel_tr_mux = 3'b%d%d%d\n",
 		pfat_table->antsel_c[mac_id],
 		pfat_table->antsel_b[mac_id],
 		pfat_table->antsel_a[mac_id]);
@@ -1464,15 +1464,15 @@ static void rtl88e_dm_hw_ant_div(struct ieee80211_hw *hw)
 	target_ant = (main_rssi == aux_rssi) ?
 		pfat_table->rx_idle_ant : ((main_rssi >= aux_rssi) ?
 		MAIN_ANT : AUX_ANT);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 		"main_ant_sum %d main_ant_cnt %d\n",
 		pfat_table->main_ant_sum[i],
 		pfat_table->main_ant_cnt[i]);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "aux_ant_sum %d aux_ant_cnt %d\n",
-		 pfat_table->aux_ant_sum[i], pfat_table->aux_ant_cnt[i]);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "main_rssi %d aux_rssi%d\n",
-		 main_rssi, aux_rssi);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"aux_ant_sum %d aux_ant_cnt %d\n",
+		pfat_table->aux_ant_sum[i], pfat_table->aux_ant_cnt[i]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "main_rssi %d aux_rssi%d\n",
+		main_rssi, aux_rssi);
 	local_max_rssi = (main_rssi > aux_rssi) ? main_rssi : aux_rssi;
 	if ((local_max_rssi > ant_div_max_rssi) && (local_max_rssi < 40))
 		ant_div_max_rssi = local_max_rssi;
@@ -1699,10 +1699,10 @@ static void rtl88e_dm_antenna_diversity(struct ieee80211_hw *hw)
 	struct fast_ant_training *pfat_table = &rtldm->fat_table;
 
 	if (mac->link_state < MAC80211_LINKED) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "No Link\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "No Link\n");
 		if (pfat_table->becomelinked) {
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "need to turn off HW AntDiv\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"need to turn off HW AntDiv\n");
 			rtl_set_bbreg(hw, DM_REG_IGI_A_11N, BIT(7), 0);
 			rtl_set_bbreg(hw, DM_REG_CCK_ANTDIV_PARA1_11N,
 				      BIT(15), 0);
@@ -1716,8 +1716,8 @@ static void rtl88e_dm_antenna_diversity(struct ieee80211_hw *hw)
 		return;
 	} else {
 		if (!pfat_table->becomelinked) {
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "Need to turn on HW AntDiv\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"Need to turn on HW AntDiv\n");
 			rtl_set_bbreg(hw, DM_REG_IGI_A_11N, BIT(7), 1);
 			rtl_set_bbreg(hw, DM_REG_CCK_ANTDIV_PARA1_11N,
 				      BIT(15), 1);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index fc7b9ad7e5d0..7252bc621211 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -40,7 +40,7 @@ static void _rtl88e_write_fw(struct ieee80211_hw *hw,
 	u32 pagenums, remainsize;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
 
 	rtl_fill_dummy(bufferptr, &size);
 
@@ -123,14 +123,14 @@ int rtl88e_download_fw(struct ieee80211_hw *hw,
 	rtlhal->fw_subversion = pfwheader->subversion;
 	pfwdata = rtlhal->pfirmware;
 	fwsize = rtlhal->fwsize;
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "normal Firmware SIZE %d\n", fwsize);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"normal Firmware SIZE %d\n", fwsize);
 
 	if (IS_FW_HEADER_EXIST(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Firmware Version(%d), Signature(%#x), Size(%d)\n",
-			  pfwheader->version, pfwheader->signature,
-			  (int)sizeof(struct rtlwifi_firmware_header));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Firmware Version(%d), Signature(%#x), Size(%d)\n",
+			pfwheader->version, pfwheader->signature,
+			(int)sizeof(struct rtlwifi_firmware_header));
 
 		pfwdata = pfwdata + sizeof(struct rtlwifi_firmware_header);
 		fwsize = fwsize - sizeof(struct rtlwifi_firmware_header);
@@ -181,22 +181,22 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 	unsigned long flag;
 	u8 idx;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
 
 	while (true) {
 		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 		if (rtlhal->h2c_setinprogress) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "H2C set in progress! Wait to set..element_id(%d).\n",
-				 element_id);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"H2C set in progress! Wait to set..element_id(%d).\n",
+				element_id);
 
 			while (rtlhal->h2c_setinprogress) {
 				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
 						       flag);
 				h2c_waitcounter++;
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-					 "Wait 100 us (%d times)...\n",
-					 h2c_waitcounter);
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Wait 100 us (%d times)...\n",
+					h2c_waitcounter);
 				udelay(100);
 
 				if (h2c_waitcounter > 1000)
@@ -238,17 +238,17 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 			box_extreg = REG_HMEBOX_EXT_3;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", boxnum);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", boxnum);
 			break;
 		}
 		isfw_read = _rtl88e_check_fw_read_last_h2c(hw, boxnum);
 		while (!isfw_read) {
 			wait_h2c_limmit--;
 			if (wait_h2c_limmit == 0) {
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-					 "Waiting too long for FW read clear HMEBox(%d)!\n",
-					 boxnum);
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Waiting too long for FW read clear HMEBox(%d)!\n",
+					boxnum);
 				break;
 			}
 
@@ -256,24 +256,24 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 
 			isfw_read = _rtl88e_check_fw_read_last_h2c(hw, boxnum);
 			u1b_tmp = rtl_read_byte(rtlpriv, 0x130);
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
-				 boxnum, u1b_tmp);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
+				boxnum, u1b_tmp);
 		}
 
 		if (!isfw_read) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
-				 boxnum);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
+				boxnum);
 			break;
 		}
 
 		memset(boxcontent, 0, sizeof(boxcontent));
 		memset(boxextcontent, 0, sizeof(boxextcontent));
 		boxcontent[0] = element_id;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-			 "Write element_id box_reg(%4x) = %2x\n",
-			 box_reg, element_id);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Write element_id box_reg(%4x) = %2x\n",
+			box_reg, element_id);
 
 		switch (cmd_len) {
 		case 1:
@@ -309,8 +309,8 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", cmd_len);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", cmd_len);
 			break;
 		}
 
@@ -320,16 +320,16 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
 
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-			 "pHalData->last_hmeboxnum  = %d\n",
-			  rtlhal->last_hmeboxnum);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"pHalData->last_hmeboxnum  = %d\n",
+			rtlhal->last_hmeboxnum);
 	}
 
 	spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 	rtlhal->h2c_setinprogress = false;
 	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
 }
 
 void rtl88e_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -359,8 +359,8 @@ void rtl88e_firmware_selfreset(struct ieee80211_hw *hw)
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN+1);
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN+1, (u1b_tmp & (~BIT(2))));
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN+1, (u1b_tmp | BIT(2)));
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "8051Reset88E(): 8051 reset success\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"8051Reset88E(): 8051 reset success\n");
 
 }
 
@@ -370,7 +370,7 @@ void rtl88e_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	u8 u1_h2c_set_pwrmode[H2C_88E_PWEMODE_LENGTH] = { 0 };
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	u8 rlbm, power_state = 0;
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
 
 	set_h2ccmd_pwrmode_parm_mode(u1_h2c_set_pwrmode, ((mode) ? 1 : 0));
 	rlbm = 0;/*YJ, temp, 120316. FW now not support RLBM=2.*/
@@ -610,15 +610,15 @@ void rtl88e_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Set RSVD page location to Fw.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 			      "H2C_RSVDPAGE:\n", u1rsvdpageloc, 3);
 		rtl88e_fill_h2c_cmd(hw, H2C_88E_RSVDPAGE,
 				    sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 
 /*Should check FW support p2p or not.*/
@@ -643,11 +643,11 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_DISABLE\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_DISABLE\n");
 		memset(p2p_ps_offload, 0, sizeof(*p2p_ps_offload));
 		break;
 	case P2P_PS_ENABLE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_ENABLE\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_ENABLE\n");
 		/* update CTWindow value. */
 		if (p2pinfo->ctwindow > 0) {
 			p2p_ps_offload->ctwindow_en = 1;
@@ -703,11 +703,11 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 		}
 		break;
 	case P2P_PS_SCAN:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
 		p2p_ps_offload->discovery = 1;
 		break;
 	case P2P_PS_SCAN_DONE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN_DONE\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN_DONE\n");
 		p2p_ps_offload->discovery = 0;
 		p2pinfo->p2p_ps_state = P2P_PS_ENABLE;
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index 70716631de85..98b1665ea7aa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -140,9 +140,9 @@ static void _rtl88ee_set_fw_clock_on(struct ieee80211_hw *hw,
 			if (content & IMR_CPWM) {
 				rtl_write_word(rtlpriv, isr_regaddr, 0x0100);
 				rtlhal->fw_ps_state = FW_PS_STATE_RF_ON_88E;
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-					 "Receive CPWM INT!!! Set pHalData->FwPSState = %X\n",
-					 rtlhal->fw_ps_state);
+				rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+					"Receive CPWM INT!!! Set pHalData->FwPSState = %X\n",
+					rtlhal->fw_ps_state);
 			}
 		}
 
@@ -400,8 +400,8 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "HW_VAR_SLOT_TIME %x\n", val[0]);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 
@@ -445,9 +445,9 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			*val = min_spacing_to_set;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-				  mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+				mac->min_space_cfg);
 
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
@@ -459,9 +459,9 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		density_to_set = *val;
 		mac->min_space_cfg |= (density_to_set << 3);
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-			  mac->min_space_cfg);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+			mac->min_space_cfg);
 
 		rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 			       mac->min_space_cfg);
@@ -500,9 +500,9 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			}
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
-				  factor_toset);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+				factor_toset);
 		}
 		break; }
 	case HW_VAR_AC_PARAM:{
@@ -536,9 +536,9 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				acm_ctrl |= ACMHW_VOQEN;
 				break;
 			default:
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
-					 acm);
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
+					acm);
 				break;
 			}
 		} else {
@@ -559,9 +559,9 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			}
 		}
 
-		RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
-			 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
-			 acm_ctrl);
+		rtl_dbg(rtlpriv, COMP_QOS, DBG_TRACE,
+			"SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
+			acm_ctrl);
 		rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
 		break; }
 	case HW_VAR_RCR:
@@ -834,8 +834,8 @@ static bool _rtl88ee_init_mac(struct ieee80211_hw *hw)
 	if (!rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_ALL_MSK,
 				      PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK,
 				      RTL8188EE_NIC_ENABLE_FLOW)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "init MAC Fail as rtl_hal_pwrseqcmdparsing\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"init MAC Fail as rtl_hal_pwrseqcmdparsing\n");
 		return false;
 	}
 
@@ -870,8 +870,8 @@ static bool _rtl88ee_init_mac(struct ieee80211_hw *hw)
 
 	if (!rtlhal->mac_func_enable) {
 		if (_rtl88ee_llt_table_init(hw) == false) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "LLT table init fail\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"LLT table init fail\n");
 			return false;
 		}
 	}
@@ -1002,14 +1002,14 @@ void rtl88ee_enable_hw_security_config(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
-		  rtlpriv->sec.pairwise_enc_algorithm,
-		  rtlpriv->sec.group_enc_algorithm);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
+		rtlpriv->sec.pairwise_enc_algorithm,
+		rtlpriv->sec.group_enc_algorithm);
 
 	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-			 "not open hw encryption\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"not open hw encryption\n");
 		return;
 	}
 
@@ -1024,8 +1024,8 @@ void rtl88ee_enable_hw_security_config(struct ieee80211_hw *hw)
 
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
@@ -1076,8 +1076,8 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl88e_download_fw(hw, false);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
 	}
@@ -1130,9 +1130,9 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 			rtl88e_phy_set_rfpath_switch(hw, false);
 			rtlpriv->dm.fat_table.rx_idle_ant = AUX_ANT;
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "rx idle ant %s\n",
-			 (rtlpriv->dm.fat_table.rx_idle_ant == MAIN_ANT) ?
-			 ("MAIN_ANT") : ("AUX_ANT"));
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "rx idle ant %s\n",
+			(rtlpriv->dm.fat_table.rx_idle_ant == MAIN_ANT) ?
+			("MAIN_ANT") : ("AUX_ANT"));
 
 		if (rtlphy->iqk_initialized) {
 			rtl88e_phy_iq_calibrate(hw, true);
@@ -1148,7 +1148,7 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 	tmp_u1b = efuse_read_1byte(hw, 0x1FA);
 	if (!(tmp_u1b & BIT(0))) {
 		rtl_set_rfreg(hw, RF90_PATH_A, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path A\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path A\n");
 	}
 
 	if (!(tmp_u1b & BIT(4))) {
@@ -1157,7 +1157,7 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x80);
 		udelay(10);
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x90);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "under 1.5V\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "under 1.5V\n");
 	}
 	rtl_write_byte(rtlpriv, REG_NAV_CTRL+2,  ((30000+127)/128));
 	rtl88e_dm_init(hw);
@@ -1185,9 +1185,9 @@ static enum version_8188e _rtl88ee_read_chip_version(struct ieee80211_hw *hw)
 	}
 
 	rtlphy->rf_type = RF_1T1R;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
-		 "RF_2T2R" : "RF_1T1R");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
+		"RF_2T2R" : "RF_1T1R");
 
 	return version;
 }
@@ -1203,26 +1203,26 @@ static int _rtl88ee_set_media_status(struct ieee80211_hw *hw,
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		mode = MSR_NOLINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to NO LINK!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_MESH_POINT:
 		mode = MSR_ADHOC;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to Ad Hoc!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		mode = MSR_INFRA;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to STA!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		mode = MSR_AP;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to AP!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to AP!\n");
 		break;
 	default:
 		pr_err("Network type %d not support!\n", type);
@@ -1248,9 +1248,9 @@ static int _rtl88ee_set_media_status(struct ieee80211_hw *hw,
 		_rtl88ee_resume_tx_beacon(hw);
 		_rtl88ee_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
-			 mode);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
+			mode);
 	}
 
 	rtl_write_byte(rtlpriv, MSR, bt_msr | mode);
@@ -1370,7 +1370,7 @@ static void _rtl88ee_poweroff_adapter(struct ieee80211_hw *hw)
 	rtlhal->mac_func_enable = false;
 	rtlpriv->intf_ops->enable_aspm(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "POWER OFF adapter\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "POWER OFF adapter\n");
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_TX_RPT_CTRL);
 	rtl_write_byte(rtlpriv, REG_TX_RPT_CTRL, u1b_tmp & (~BIT(1)));
 
@@ -1427,7 +1427,7 @@ void rtl88ee_card_disable(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	enum nl80211_iftype opmode;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "RTL8188ee card disable\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "RTL8188ee card disable\n");
 
 	mac->link_state = MAC80211_NOLINK;
 	opmode = NL80211_IFTYPE_UNSPECIFIED;
@@ -1486,8 +1486,8 @@ void rtl88ee_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	/*rtl88ee_disable_interrupt(hw);*/
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	/*rtl88ee_enable_interrupt(hw);*/
@@ -1499,8 +1499,8 @@ void rtl88ee_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1559,15 +1559,15 @@ static void read_power_value_fromprom(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 rfpath, eeaddr = EEPROM_TX_PWR_INX, group, txcnt = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "hal_ReadPowerValueFromPROM88E():PROMContent[0x%x]=0x%x\n",
-		 (eeaddr+1), hwinfo[eeaddr+1]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"hal_ReadPowerValueFromPROM88E():PROMContent[0x%x]=0x%x\n",
+		(eeaddr + 1), hwinfo[eeaddr + 1]);
 	if (0xFF == hwinfo[eeaddr+1])  /*YJ,add,120316*/
 		autoload_fail = true;
 
 	if (autoload_fail) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "auto load fail : Use Default value!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"auto load fail : Use Default value!\n");
 		for (rfpath = 0 ; rfpath < MAX_RF_PATH ; rfpath++) {
 			/* 2.4G default value */
 			set_24g_base(pwrinfo24g, rfpath);
@@ -1826,8 +1826,8 @@ static void _rtl88ee_read_adapter_info(struct ieee80211_hw *hw)
 	if (rtlefuse->eeprom_oemid == 0xFF)
 		rtlefuse->eeprom_oemid = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
 	/* set channel plan from efuse */
 	rtlefuse->channel_plan = rtlefuse->eeprom_channelplan;
 	/*tx power*/
@@ -1925,8 +1925,8 @@ static void _rtl88ee_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
 void rtl88ee_read_eeprom_info(struct ieee80211_hw *hw)
@@ -1943,18 +1943,18 @@ void rtl88ee_read_eeprom_info(struct ieee80211_hw *hw)
 	else
 		rtlpriv->dm.rfpath_rxenable[0] =
 		    rtlpriv->dm.rfpath_rxenable[1] = true;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
-						rtlhal->version);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
+		rtlhal->version);
 	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
 	if (tmp_u1b & BIT(4)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
 		rtlefuse->epromtype = EEPROM_93C46;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
 		rtlefuse->epromtype = EEPROM_BOOT_EFUSE;
 	}
 	if (tmp_u1b & BIT(5)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 		_rtl88ee_read_adapter_info(hw);
 	} else {
@@ -2049,8 +2049,8 @@ static void rtl88ee_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
 static void rtl88ee_update_hal_rate_mask(struct ieee80211_hw *hw,
@@ -2169,17 +2169,17 @@ static void rtl88ee_update_hal_rate_mask(struct ieee80211_hw *hw,
 	}
 	sta_entry->ratr_index = ratr_index;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "ratr_bitmap :%x\n", ratr_bitmap);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"ratr_bitmap :%x\n", ratr_bitmap);
 	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
 			     (ratr_index << 28);
 	rate_mask[4] = macid | (b_shortgi ? 0x20 : 0x00) | 0x80;
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x\n",
-		 ratr_index, ratr_bitmap,
-		 rate_mask[0], rate_mask[1],
-		 rate_mask[2], rate_mask[3],
-		 rate_mask[4]);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x\n",
+		ratr_index, ratr_bitmap,
+		rate_mask[0], rate_mask[1],
+		rate_mask[2], rate_mask[3],
+		rate_mask[4]);
 	rtl88e_fill_h2c_cmd(hw, H2C_88E_RA_MASK, 5, rate_mask);
 	_rtl88ee_set_bcn_ctrl_reg(hw, BIT(3), 0);
 }
@@ -2236,16 +2236,16 @@ bool rtl88ee_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	e_rfpowerstate_toset = (u4tmp & BIT(31)) ? ERFON : ERFOFF;
 
 	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio ON, RF ON\n");
 
 		e_rfpowerstate_toset = ERFON;
 		ppsc->hwradiooff = false;
 		b_actuallyset = true;
 	} else if ((!ppsc->hwradiooff) &&
 		   (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 
 		e_rfpowerstate_toset = ERFOFF;
 		ppsc->hwradiooff = true;
@@ -2295,7 +2295,7 @@ void rtl88ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2354,27 +2354,27 @@ void rtl88ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "delete one entry, entry_id is %d\n",
-				 entry_id);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"delete one entry, entry_id is %d\n",
+				entry_id);
 			if (mac->opmode == NL80211_IFTYPE_AP ||
 				mac->opmode == NL80211_IFTYPE_MESH_POINT)
 				rtl_cam_del_entry(hw, p_macaddr);
 			rtl_cam_delete_one_entry(hw, p_macaddr, entry_id);
 		} else {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "add one entry\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"add one entry\n");
 			if (is_pairwise) {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set Pairwise key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set Pairwise key\n");
 
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
 						      entry_id, enc_algo,
 						      CAM_CONFIG_NO_USEDK,
 						      rtlpriv->sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set group key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set group key\n");
 
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 					rtl_cam_add_one_entry(hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
index 4ef6d5907521..006b979da1c6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
@@ -19,8 +19,8 @@ void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -35,8 +35,8 @@ void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, ledcfg & 0x10);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
 	pled->ledon = true;
@@ -47,8 +47,8 @@ void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -72,8 +72,8 @@ void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, (ledcfg | BIT(3)));
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
 	pled->ledon = false;
@@ -123,7 +123,7 @@ void rtl88ee_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_TRACE, "ledaction %d,\n",
-				ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_TRACE, "ledaction %d,\n",
+		ledaction);
 	_rtl88ee_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index d13983ec09ad..63ec5a20b67b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -43,15 +43,15 @@ u32 rtl88e_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n", bitmask,
-		 regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n", bitmask,
+		regaddr, originalvalue);
 
 	return returnvalue;
 
@@ -63,9 +63,9 @@ void rtl88e_phy_set_bb_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
@@ -75,9 +75,9 @@ void rtl88e_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 }
 
 u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
@@ -86,9 +86,9 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		 regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -99,9 +99,9 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		  regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 	return readback_value;
 }
 
@@ -112,9 +112,9 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -133,9 +133,9 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 }
 
 static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
@@ -179,9 +179,9 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 					 BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFR-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf_rb, retvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFR-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
 }
 
@@ -203,9 +203,9 @@ static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
 	newoffset = offset;
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFW-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
 static u32 _rtl88e_phy_calculate_bit_shift(u32 bitmask)
@@ -381,11 +381,11 @@ static bool _rtl88e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl8188EMACPHY_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl8188EMACPHY_Array\n");
 	arraylength = RTL8188EEMAC_1T_ARRAYLEN;
 	ptrarray = RTL8188EEMAC_1T_ARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Img:RTL8188EEMAC_1T_ARRAY LEN %d\n", arraylength);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Img:RTL8188EEMAC_1T_ARRAY LEN %d\n", arraylength);
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8)ptrarray[i + 1]);
 	return true;
@@ -487,9 +487,9 @@ static void handle_branch2(struct ieee80211_hw *hw, u16 arraylen,
 					READ_NEXT_PAIR(v1, v2, i);
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "The agctab_array_table[0] is %x Rtl818EEPHY_REGArray[1] is %x\n",
-			 array_table[i], array_table[i + 1]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"The agctab_array_table[0] is %x Rtl818EEPHY_REGArray[1] is %x\n",
+			array_table[i], array_table[i + 1]);
 	}
 }
 
@@ -521,52 +521,52 @@ static void store_pwrindex_rate_offset(struct ieee80211_hw *hw,
 
 	if (regaddr == RTXAGC_A_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][0] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][0]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][0]);
 	}
 	if (regaddr == RTXAGC_A_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][1] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][1]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][1]);
 	}
 	if (regaddr == RTXAGC_A_CCK1_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][6] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][6] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][6]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][6] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][6]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0xffffff00) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][7] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][7]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][7]);
 	}
 	if (regaddr == RTXAGC_A_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][2] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][2]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][2]);
 	}
 	if (regaddr == RTXAGC_A_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][3] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][3]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][3]);
 	}
 	if (regaddr == RTXAGC_A_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][4] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][4]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][4]);
 	}
 	if (regaddr == RTXAGC_A_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][5] = data;
@@ -574,66 +574,66 @@ static void store_pwrindex_rate_offset(struct ieee80211_hw *hw,
 			count++;
 			rtlphy->pwrgroup_cnt = count;
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][5]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][5]);
 	}
 	if (regaddr == RTXAGC_B_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][8] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][8]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][8]);
 	}
 	if (regaddr == RTXAGC_B_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][9] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][9]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][9]);
 	}
 	if (regaddr == RTXAGC_B_CCK1_55_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][14] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][14]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][14]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][15] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][15]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][15]);
 	}
 	if (regaddr == RTXAGC_B_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][10] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][10]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][10]);
 	}
 	if (regaddr == RTXAGC_B_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][11] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][11]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][11]);
 	}
 	if (regaddr == RTXAGC_B_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][12] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][12]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][12]);
 	}
 	if (regaddr == RTXAGC_B_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][13] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
-			  count,
-			  rtlphy->mcs_txpwrlevel_origoffset[count][13]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
+			count,
+			rtlphy->mcs_txpwrlevel_origoffset[count][13]);
 		if (get_rf_type(rtlphy) != RF_1T1R) {
 			count++;
 			rtlphy->pwrgroup_cnt = count;
@@ -696,8 +696,8 @@ static bool phy_config_bb_with_pghdr(struct ieee80211_hw *hw, u8 configtype)
 			}
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "configtype != BaseBand_Config_PHY_REG\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"configtype != BaseBand_Config_PHY_REG\n");
 	}
 	return true;
 }
@@ -769,9 +769,9 @@ bool rtl88e_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 
 	radioa_arraylen = RTL8188EE_RADIOA_1TARRAYLEN;
 	radioa_array_table = RTL8188EE_RADIOA_1TARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Radio_A:RTL8188EE_RADIOA_1TARRAY %d\n", radioa_arraylen);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Radio_A:RTL8188EE_RADIOA_1TARRAY %d\n", radioa_arraylen);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		process_path_a(hw, radioa_arraylen, radioa_array_table);
@@ -798,21 +798,21 @@ void rtl88e_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->default_initialgain[3] =
 	    (u8)rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
-		 rtlphy->default_initialgain[0],
-		 rtlphy->default_initialgain[1],
-		 rtlphy->default_initialgain[2],
-		 rtlphy->default_initialgain[3]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
+		rtlphy->default_initialgain[0],
+		rtlphy->default_initialgain[1],
+		rtlphy->default_initialgain[2],
+		rtlphy->default_initialgain[3]);
 
 	rtlphy->framesync = (u8)rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3,
 					      MASKBYTE0);
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
 					      MASKDWORD);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "Default framesync (0x%x) = 0x%x\n",
-		 ROFDM0_RXDETECTOR3, rtlphy->framesync);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default framesync (0x%x) = 0x%x\n",
+		ROFDM0_RXDETECTOR3, rtlphy->framesync);
 }
 
 static void _rtl88e_phy_init_bb_rf_register_definition(struct ieee80211_hw *hw)
@@ -1081,10 +1081,10 @@ void rtl88e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	u8 reg_bw_opmode;
 	u8 reg_prsr_rsc;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "Switch to %s bandwidth\n",
-		  rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
-		  "20MHz" : "40MHz");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"Switch to %s bandwidth\n",
+		rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
+		"20MHz" : "40MHz");
 
 	if (is_hal_stop(rtlhal)) {
 		rtlphy->set_bwmode_inprogress = false;
@@ -1138,7 +1138,7 @@ void rtl88e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl88e_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
 }
 
 void rtl88e_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -1155,8 +1155,8 @@ void rtl88e_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl88e_phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
 	}
@@ -1169,8 +1169,8 @@ void rtl88e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 delay;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
 	do {
@@ -1188,7 +1188,7 @@ void rtl88e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl88e_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -1208,13 +1208,13 @@ u8 rtl88e_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl88e_phy_sw_chnl_callback(hw);
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
-			 "sw_chnl_inprogress false schedule workitem current channel %d\n",
-			 rtlphy->current_channel);
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false schedule workitem current channel %d\n",
+			rtlphy->current_channel);
 		rtlphy->sw_chnl_inprogress = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
-			 "sw_chnl_inprogress false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false driver sleep or unload\n");
 		rtlphy->sw_chnl_inprogress = false;
 	}
 	return 1;
@@ -1315,9 +1315,9 @@ static bool _rtl88e_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n",
-				 currentcmd->cmdid);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n",
+				currentcmd->cmdid);
 			break;
 		}
 
@@ -1749,8 +1749,8 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 	for (i = 0; i < retrycount; i++) {
 		patha_ok = _rtl88e_phy_path_a_iqk(hw, is2t);
 		if (patha_ok == 0x01) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Path A Tx IQK Success!!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Path A Tx IQK Success!!\n");
 			result[t][0] = (rtl_get_bbreg(hw, 0xe94, MASKDWORD) &
 					0x3FF0000) >> 16;
 			result[t][1] = (rtl_get_bbreg(hw, 0xe9c, MASKDWORD) &
@@ -1762,22 +1762,22 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 	for (i = 0; i < retrycount; i++) {
 		patha_ok = _rtl88e_phy_path_a_rx_iqk(hw, is2t);
 		if (patha_ok == 0x03) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Path A Rx IQK Success!!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Path A Rx IQK Success!!\n");
 			result[t][2] = (rtl_get_bbreg(hw, 0xea4, MASKDWORD) &
 					0x3FF0000) >> 16;
 			result[t][3] = (rtl_get_bbreg(hw, 0xeac, MASKDWORD) &
 					0x3FF0000) >> 16;
 			break;
 		} else {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Path a RX iqk fail!!!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Path a RX iqk fail!!!\n");
 		}
 	}
 
 	if (0 == patha_ok)
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Path A IQK Success!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Path A IQK Success!!\n");
 	if (is2t) {
 		_rtl88e_phy_path_a_standby(hw);
 		_rtl88e_phy_path_adda_on(hw, adda_reg, false, is2t);
@@ -1828,7 +1828,7 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, 0xe30, MASKDWORD, 0x01008c00);
 		rtl_set_bbreg(hw, 0xe34, MASKDWORD, 0x01008c00);
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "88ee IQK Finish!!\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "88ee IQK Finish!!\n");
 }
 
 static void _rtl88e_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
@@ -1874,7 +1874,7 @@ static void _rtl88e_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 	} else {
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 }
 
 static void _rtl88e_phy_set_rfpath_switch(struct ieee80211_hw *hw,
@@ -1883,7 +1883,7 @@ static void _rtl88e_phy_set_rfpath_switch(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 
 	if (is_hal_stop(rtlhal)) {
 		u8 u1btmp;
@@ -2074,24 +2074,24 @@ bool rtl88e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	bool postprocessing = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "-->IO Cmd(%#x), set_io_inprogress(%d)\n",
-		  iotype, rtlphy->set_io_inprogress);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"-->IO Cmd(%#x), set_io_inprogress(%d)\n",
+		iotype, rtlphy->set_io_inprogress);
 	do {
 		switch (iotype) {
 		case IO_CMD_RESUME_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-				 "[IO CMD] Resume DM after scan.\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Resume DM after scan.\n");
 			postprocessing = true;
 			break;
 		case IO_CMD_PAUSE_BAND0_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-				 "[IO CMD] Pause DM before scan.\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Pause DM before scan.\n");
 			postprocessing = true;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", iotype);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", iotype);
 			break;
 		}
 	} while (false);
@@ -2102,7 +2102,7 @@ bool rtl88e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl88e_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -2112,9 +2112,9 @@ static void rtl88e_phy_set_io(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
-		  rtlphy->current_io_type, rtlphy->set_io_inprogress);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"--->Cmd(%#x), set_io_inprogress(%d)\n",
+		rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
 	case IO_CMD_RESUME_DM_BY_SCAN:
 		dm_digtable->cur_igvalue = rtlphy->initgain_backup.xaagccore1;
@@ -2128,14 +2128,14 @@ static void rtl88e_phy_set_io(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_CCA, 0xff0000, 0x40);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n",
-			 rtlphy->current_io_type);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n",
+			rtlphy->current_io_type);
 		break;
 	}
 	rtlphy->set_io_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "(%#x)\n", rtlphy->current_io_type);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"(%#x)\n", rtlphy->current_io_type);
 }
 
 static void rtl88ee_phy_set_rf_on(struct ieee80211_hw *hw)
@@ -2180,19 +2180,18 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
 			do {
 				initializecount++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "IPS Set eRf nic enable\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus &&
 				 (initializecount < 10));
 			RT_CLEAR_PS_LEVEL(ppsc,
 					  RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "Set ERFON sleeped:%d ms\n",
-				  jiffies_to_msecs(jiffies -
-						   ppsc->
-						   last_sleep_jiffies));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"Set ERFON slept:%d ms\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies));
 			ppsc->last_awake_jiffies = jiffies;
 			rtl88ee_phy_set_rf_on(hw);
 		}
@@ -2213,27 +2212,27 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
 			} else {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
-					 (i + 1), queue_id,
-					 skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
+					(i + 1), queue_id,
+					skb_queue_len(&ring->queue));
 
 				udelay(10);
 				i++;
 			}
 			if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "\n ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
-					  MAX_DOZE_WAITING_TIMES_9x,
-					  queue_id,
-					  skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"\n ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
+					MAX_DOZE_WAITING_TIMES_9x,
+					queue_id,
+					skb_queue_len(&ring->queue));
 				break;
 			}
 		}
 
 		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "IPS Set eRf nic disable\n");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"IPS Set eRf nic disable\n");
 			rtl_ps_disable_nic(hw);
 			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
@@ -2256,34 +2255,34 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					queue_id++;
 					continue;
 				} else {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
-						 (i + 1), queue_id,
-						 skb_queue_len(&ring->queue));
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
+						(i + 1), queue_id,
+						skb_queue_len(&ring->queue));
 
 					udelay(10);
 					i++;
 				}
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "\n ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
-						 MAX_DOZE_WAITING_TIMES_9x,
-						 queue_id,
-						 skb_queue_len(&ring->queue));
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"\n ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
+						MAX_DOZE_WAITING_TIMES_9x,
+						queue_id,
+						skb_queue_len(&ring->queue));
 					break;
 				}
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "Set ERFSLEEP awaked:%d ms\n",
-				  jiffies_to_msecs(jiffies -
-				  ppsc->last_awake_jiffies));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"Set ERFSLEEP awaked:%d ms\n",
+				jiffies_to_msecs(jiffies -
+				ppsc->last_awake_jiffies));
 			ppsc->last_sleep_jiffies = jiffies;
 			_rtl88ee_phy_set_rf_sleep(hw);
 			break;
 		}
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", rfpwr_state);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", rfpwr_state);
 		bresult = false;
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c
index c376817a1bf4..24dc7011b7b2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c
@@ -474,13 +474,13 @@ static bool _rtl88e_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 		}
 
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "Radio[%d] Fail!!\n", rfpath);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
 			return false;
 		}
 
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
 	return rtstatus;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index a5d2d6ece8db..eda4aefa6497 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -410,9 +410,9 @@ bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
 	else
 		wake_match = 0;
 	if (wake_match)
-		RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD,
-		"GGGGGGGGGGGGGet Wakeup Packet!! WakeMatch=%d\n",
-		wake_match);
+		rtl_dbg(rtlpriv, COMP_RXDESC, DBG_LOUD,
+			"GGGGGGGGGGGGGet Wakeup Packet!! WakeMatch=%d\n",
+			wake_match);
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
 	rx_status->band = hw->conf.chandef.chan->band;
 
@@ -518,8 +518,8 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_88e));
@@ -533,9 +533,9 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
-					  ptcb_desc->empkt_num);
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Insert 8 byte.pTcb->EMPktNum:%d\n",
+					ptcb_desc->empkt_num);
 				rtl88ee_insert_emcontent(ptcb_desc,
 							 (__le32 *)(skb->data));
 			}
@@ -631,7 +631,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 		}
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
 					"Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
@@ -662,7 +662,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 
 	rtl88e_dm_set_tx_ant_by_tx_info(hw, pdesc8, ptcb_desc->mac_id);
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -682,8 +682,8 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le16 fc = hdr->frame_control;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, TX_DESC_SIZE);
-- 
2.27.0

