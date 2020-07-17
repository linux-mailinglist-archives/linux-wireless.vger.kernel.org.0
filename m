Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1492230F1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgGQCCq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGQCC1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:27 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B26C08C5DC
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:26 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id a9so1571278oof.12
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IsFwMGQf6/P7NXhFeNTRnV7WtOFeFHKtoyqQD3QYpT4=;
        b=twxH8klmTwiT9Y69VsIle30GhUn2pj96m29gG6uA5S+tMF0lYklAmC8BV06SALPEvr
         vcW+ey1gRGuBONtciGHT154uSPHFchbMdlerUWW1fBzlOLfd3vmymImgf1vEsjqbmYqA
         ViFGlDT4UiZ8GcHxaqpSbIWDNHn/2/fUWKoR1TzpczqolL5+5/eQZj8L8o2hP37RBEiJ
         9zaBo5fPTVNSHmgHDJob58+r9m7pMbIn6n4PD6V5bXIgCb6KWzCJHfEliZbvLrcSugvs
         OVAKz9KsJrq6hEF10+Ccjv30Xl5m9no3Q/8+PBHj1eqWwqr/DWUjWTULdbiIwN52jqga
         Wpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IsFwMGQf6/P7NXhFeNTRnV7WtOFeFHKtoyqQD3QYpT4=;
        b=smwF+i4qcG0h0fGaiUt27/CDqz836LcmPgsp74H92QHqqH+wS6VJwc1WnQOsWR2e3i
         OYoDzobpldf75JmYTGq6vZNr3tYyQFI33F1BVnfEKqyZq83XF79AKxYHLJLDKdIEfwpY
         iYyWd7WghIJFulNFW1pTGJ4praBn5eB7uFzTZ2Yth4w7EJWAQ80r/10AOfPjDd+7XczG
         7lamzfgwMzUAuOy92OuNem437I5hLBxj05kPbmtg46t7HXM56zuCLkqwo4EEuKgnnElV
         ft7x/n3JdNCORb1js9P0S8yIVWZsLG0C/ZLZqbO/eWQwZe3drHNnJc2yllSLmjx2gt0N
         50eg==
X-Gm-Message-State: AOAM533ERh9jke2iP1Dz1QHrW+1/LsJzS3BYkgchuQNmr5Jev7JjhSoZ
        1DgU6I21982jBUSRQ7BLTBo=
X-Google-Smtp-Source: ABdhPJxCwt4qYgnQgm8ZVyvVn0izH3WkjfWAdQ6Ht0ONw3PV/NLO7Qvqo8IJd/WELQ114mSjCBVxdA==
X-Received: by 2002:a4a:a8cc:: with SMTP id r12mr6802151oom.86.1594951344908;
        Thu, 16 Jul 2020 19:02:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:24 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 03/14] rtlwifi: rtl8188ee: Change RT_TRACE to RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:50 -0500
Message-Id: <20200717020201.18209-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rename the macro for driver rtl8188ee.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8188ee/dm.c   |  76 +++++-----
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.c   |  44 +++---
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   |  88 ++++++------
 .../wireless/realtek/rtlwifi/rtl8188ee/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/phy.c  | 132 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8188ee/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.c  |  12 +-
 7 files changed, 183 insertions(+), 183 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index dceb04a9b3f5..ea61a2a878f9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -415,13 +415,13 @@ static void rtl88e_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, BIT(15)|BIT(14), 0);
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, BIT(15)|BIT(14), 2);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "cnt_parity_fail = %d, cnt_rate_illegal = %d, cnt_crc8_fail = %d, cnt_mcs_fail = %d\n",
 		 falsealm_cnt->cnt_parity_fail,
 		 falsealm_cnt->cnt_rate_illegal,
 		 falsealm_cnt->cnt_crc8_fail, falsealm_cnt->cnt_mcs_fail);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "cnt_ofdm_fail = %x, cnt_cck_fail = %x, cnt_all = %x\n",
 		 falsealm_cnt->cnt_ofdm_fail,
 		 falsealm_cnt->cnt_cck_fail, falsealm_cnt->cnt_all);
@@ -459,7 +459,7 @@ static void rtl88e_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 
 	dm_dig->cur_cck_cca_thres = cur_cck_cca_thresh;
 	dm_dig->pre_cck_cca_thres = dm_dig->cur_cck_cca_thres;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "CCK cca thresh hold =%x\n", dm_dig->cur_cck_cca_thres);
 }
 
@@ -520,7 +520,7 @@ static void rtl88e_dm_dig(struct ieee80211_hw *hw)
 	} else {
 		dm_dig->rx_gain_max = dm_dig_max;
 		dig_dynamic_min = dm_dig_min;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
+		RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
 	}
 
 	if (rtlpriv->falsealm_cnt.cnt_all > 10000) {
@@ -624,7 +624,7 @@ static void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
@@ -637,13 +637,13 @@ static void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "AP Client PWDB = 0x%lx\n",
 				  undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "STA Default Port PWDB = 0x%lx\n",
 				  undec_sm_pwdb);
 		}
@@ -651,32 +651,32 @@ static void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		undec_sm_pwdb =
 		    rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "AP Ext Port PWDB = 0x%lx\n",
 			  undec_sm_pwdb);
 	}
 
 	if (undec_sm_pwdb >= TX_POWER_NEAR_FIELD_THRESH_LVL2) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr = 0x0)\n");
 	} else if ((undec_sm_pwdb <
 		    (TX_POWER_NEAR_FIELD_THRESH_LVL2 - 3)) &&
 		   (undec_sm_pwdb >=
 		    TX_POWER_NEAR_FIELD_THRESH_LVL1)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr = 0x10)\n");
 	} else if (undec_sm_pwdb <
 		   (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "TXHIGHPWRLEVEL_NORMAL\n");
 	}
 
 	if ((rtlpriv->dm.dynamic_txhighpower_lvl !=
 		rtlpriv->dm.last_dtp_lvl)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
 			  rtlphy->current_channel);
 		rtl88e_phy_set_txpower_level(hw, rtlphy->current_channel);
@@ -690,7 +690,7 @@ void rtl88e_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_dig = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, backoff_val = %d\n",
 		 dm_dig->cur_igvalue, dm_dig->pre_igvalue,
 		 dm_dig->back_val);
@@ -881,14 +881,14 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 
 	/*Initilization (7 steps in total) */
 	rtlpriv->dm.txpower_trackinginit = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "dm_txpower_track_cb_therm\n");
 
 	thermalvalue = (u8)rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER,
 					 0xfc00);
 	if (!thermalvalue)
 		return;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
 		 thermalvalue, rtlpriv->dm.thermalvalue,
 		 rtlefuse->eeprom_thermalmeter);
@@ -900,7 +900,7 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 			ofdm_index_old[0] = (u8)i;
 			rtldm->swing_idx_ofdm_base[RF90_PATH_A] = (u8)i;
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 				 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index = 0x%x\n",
 				 ROFDM0_XATXIQIMBALANCE,
 				 ele_d, ofdm_index_old[0]);
@@ -915,7 +915,7 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 			if (memcmp(&temp_cck, &cck_tbl_ch14[i][2], 4) == 0) {
 				cck_index_old = (u8)i;
 				rtldm->swing_idx_cck_base = (u8)i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
+				RT_DEBUG(rtlpriv, COMP_POWER_TRACKING,
 					 DBG_LOUD,
 					 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch 14 %d\n",
 					 RCCK0_TXFILTER2, temp_cck,
@@ -927,7 +927,7 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 			if (memcmp(&temp_cck, &cck_tbl_ch1_13[i][2], 4) == 0) {
 				cck_index_old = (u8)i;
 				rtldm->swing_idx_cck_base = (u8)i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
+				RT_DEBUG(rtlpriv, COMP_POWER_TRACKING,
 					 DBG_LOUD,
 					 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
 					 RCCK0_TXFILTER2, temp_cck,
@@ -987,7 +987,7 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 	    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
 	    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
 		 thermalvalue, rtlpriv->dm.thermalvalue,
 		 rtlefuse->eeprom_thermalmeter, delta, delta_lck,
@@ -1072,7 +1072,7 @@ static void dm_txpower_track_cb_therm(struct ieee80211_hw *hw)
 	if (rtldm->txpower_track_control)
 		rtldm->thermalvalue = thermalvalue;
 	rtldm->txpowercount = 0;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "end\n");
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "end\n");
 }
 
 static void rtl88e_dm_init_txpower_tracking(struct ieee80211_hw *hw)
@@ -1087,7 +1087,7 @@ static void rtl88e_dm_init_txpower_tracking(struct ieee80211_hw *hw)
 	rtlpriv->dm.swing_idx_ofdm[RF90_PATH_A] = 12;
 	rtlpriv->dm.swing_idx_ofdm_cur = 12;
 	rtlpriv->dm.swing_flag_ofdm = false;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "rtlpriv->dm.txpower_tracking = %d\n",
 		 rtlpriv->dm.txpower_tracking);
 }
@@ -1102,12 +1102,12 @@ void rtl88e_dm_check_txpower_tracking(struct ieee80211_hw *hw)
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17)|BIT(16),
 			      0x03);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "Trigger 88E Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "Schedule TxPowerTracking !!\n");
 		dm_txpower_track_cb_therm(hw);
 		rtlpriv->dm.tm_trigger = 0;
@@ -1138,13 +1138,13 @@ static void rtl88e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 	struct ieee80211_sta *sta = NULL;
 
 	if (is_hal_stop(rtlhal)) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 			 "driver is going to unload\n");
 		return;
 	}
 
 	if (!rtlpriv->dm.useramask) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 			 "driver does not control rate adaptive mask\n");
 		return;
 	}
@@ -1180,12 +1180,12 @@ static void rtl88e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 			p_ra->ratr_state = DM_RATR_STA_LOW;
 
 		if (p_ra->pre_ratr_state != p_ra->ratr_state) {
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 				 "RSSI = %ld\n",
 				  rtlpriv->dm.undec_sm_pwdb);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 				 "RSSI_LEVEL = %d\n", p_ra->ratr_state);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 				 "PreState = %d, CurState = %d\n",
 				  p_ra->pre_ratr_state, p_ra->ratr_state);
 
@@ -1224,7 +1224,7 @@ static void rtl88e_dm_update_rx_idle_ant(struct ieee80211_hw *hw,
 	u32 default_ant, optional_ant;
 
 	if (pfat_table->rx_idle_ant != ant) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "need to update rx idle ant\n");
 		if (ant == MAIN_ANT) {
 			default_ant =
@@ -1260,7 +1260,7 @@ static void rtl88e_dm_update_rx_idle_ant(struct ieee80211_hw *hw,
 		}
 	}
 	pfat_table->rx_idle_ant = ant;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "RxIdleAnt %s\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "RxIdleAnt %s\n",
 		 (ant == MAIN_ANT) ? ("MAIN_ANT") : ("AUX_ANT"));
 }
 
@@ -1280,9 +1280,9 @@ static void rtl88e_dm_update_tx_ant(struct ieee80211_hw *hw,
 	pfat_table->antsel_a[mac_id] = target_ant & BIT(0);
 	pfat_table->antsel_b[mac_id] = (target_ant & BIT(1)) >> 1;
 	pfat_table->antsel_c[mac_id] = (target_ant & BIT(2)) >> 2;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "txfrominfo target ant %s\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "txfrominfo target ant %s\n",
 		(ant == MAIN_ANT) ? ("MAIN_ANT") : ("AUX_ANT"));
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "antsel_tr_mux = 3'b%d%d%d\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "antsel_tr_mux = 3'b%d%d%d\n",
 		pfat_table->antsel_c[mac_id],
 		pfat_table->antsel_b[mac_id],
 		pfat_table->antsel_a[mac_id]);
@@ -1464,14 +1464,14 @@ static void rtl88e_dm_hw_ant_div(struct ieee80211_hw *hw)
 	target_ant = (main_rssi == aux_rssi) ?
 		pfat_table->rx_idle_ant : ((main_rssi >= aux_rssi) ?
 		MAIN_ANT : AUX_ANT);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		"main_ant_sum %d main_ant_cnt %d\n",
 		pfat_table->main_ant_sum[i],
 		pfat_table->main_ant_cnt[i]);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "aux_ant_sum %d aux_ant_cnt %d\n",
 		 pfat_table->aux_ant_sum[i], pfat_table->aux_ant_cnt[i]);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "main_rssi %d aux_rssi%d\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "main_rssi %d aux_rssi%d\n",
 		 main_rssi, aux_rssi);
 	local_max_rssi = (main_rssi > aux_rssi) ? main_rssi : aux_rssi;
 	if ((local_max_rssi > ant_div_max_rssi) && (local_max_rssi < 40))
@@ -1699,9 +1699,9 @@ static void rtl88e_dm_antenna_diversity(struct ieee80211_hw *hw)
 	struct fast_ant_training *pfat_table = &rtldm->fat_table;
 
 	if (mac->link_state < MAC80211_LINKED) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "No Link\n");
+		RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "No Link\n");
 		if (pfat_table->becomelinked) {
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 				 "need to turn off HW AntDiv\n");
 			rtl_set_bbreg(hw, DM_REG_IGI_A_11N, BIT(7), 0);
 			rtl_set_bbreg(hw, DM_REG_CCK_ANTDIV_PARA1_11N,
@@ -1716,7 +1716,7 @@ static void rtl88e_dm_antenna_diversity(struct ieee80211_hw *hw)
 		return;
 	} else {
 		if (!pfat_table->becomelinked) {
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 				 "Need to turn on HW AntDiv\n");
 			rtl_set_bbreg(hw, DM_REG_IGI_A_11N, BIT(7), 1);
 			rtl_set_bbreg(hw, DM_REG_CCK_ANTDIV_PARA1_11N,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index fc7b9ad7e5d0..b2763411fdc5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -40,7 +40,7 @@ static void _rtl88e_write_fw(struct ieee80211_hw *hw,
 	u32 pagenums, remainsize;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
 
 	rtl_fill_dummy(bufferptr, &size);
 
@@ -123,11 +123,11 @@ int rtl88e_download_fw(struct ieee80211_hw *hw,
 	rtlhal->fw_subversion = pfwheader->subversion;
 	pfwdata = rtlhal->pfirmware;
 	fwsize = rtlhal->fwsize;
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 		 "normal Firmware SIZE %d\n", fwsize);
 
 	if (IS_FW_HEADER_EXIST(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 			 "Firmware Version(%d), Signature(%#x), Size(%d)\n",
 			  pfwheader->version, pfwheader->signature,
 			  (int)sizeof(struct rtlwifi_firmware_header));
@@ -181,12 +181,12 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 	unsigned long flag;
 	u8 idx;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
 
 	while (true) {
 		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 		if (rtlhal->h2c_setinprogress) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "H2C set in progress! Wait to set..element_id(%d).\n",
 				 element_id);
 
@@ -194,7 +194,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
 						       flag);
 				h2c_waitcounter++;
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Wait 100 us (%d times)...\n",
 					 h2c_waitcounter);
 				udelay(100);
@@ -238,7 +238,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 			box_extreg = REG_HMEBOX_EXT_3;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 				 "switch case %#x not processed\n", boxnum);
 			break;
 		}
@@ -246,7 +246,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 		while (!isfw_read) {
 			wait_h2c_limmit--;
 			if (wait_h2c_limmit == 0) {
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Waiting too long for FW read clear HMEBox(%d)!\n",
 					 boxnum);
 				break;
@@ -256,13 +256,13 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 
 			isfw_read = _rtl88e_check_fw_read_last_h2c(hw, boxnum);
 			u1b_tmp = rtl_read_byte(rtlpriv, 0x130);
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
 				 boxnum, u1b_tmp);
 		}
 
 		if (!isfw_read) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
 				 boxnum);
 			break;
@@ -271,7 +271,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 		memset(boxcontent, 0, sizeof(boxcontent));
 		memset(boxextcontent, 0, sizeof(boxextcontent));
 		boxcontent[0] = element_id;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "Write element_id box_reg(%4x) = %2x\n",
 			 box_reg, element_id);
 
@@ -309,7 +309,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 				 "switch case %#x not processed\n", cmd_len);
 			break;
 		}
@@ -320,7 +320,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
 
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "pHalData->last_hmeboxnum  = %d\n",
 			  rtlhal->last_hmeboxnum);
 	}
@@ -329,7 +329,7 @@ static void _rtl88e_fill_h2c_command(struct ieee80211_hw *hw,
 	rtlhal->h2c_setinprogress = false;
 	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
 }
 
 void rtl88e_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -359,7 +359,7 @@ void rtl88e_firmware_selfreset(struct ieee80211_hw *hw)
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN+1);
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN+1, (u1b_tmp & (~BIT(2))));
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN+1, (u1b_tmp | BIT(2)));
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "8051Reset88E(): 8051 reset success\n");
 
 }
@@ -370,7 +370,7 @@ void rtl88e_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	u8 u1_h2c_set_pwrmode[H2C_88E_PWEMODE_LENGTH] = { 0 };
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	u8 rlbm, power_state = 0;
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
 
 	set_h2ccmd_pwrmode_parm_mode(u1_h2c_set_pwrmode, ((mode) ? 1 : 0));
 	rlbm = 0;/*YJ, temp, 120316. FW now not support RLBM=2.*/
@@ -610,14 +610,14 @@ void rtl88e_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 			      "H2C_RSVDPAGE:\n", u1rsvdpageloc, 3);
 		rtl88e_fill_h2c_cmd(hw, H2C_88E_RSVDPAGE,
 				    sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 
@@ -643,11 +643,11 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_DISABLE\n");
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_DISABLE\n");
 		memset(p2p_ps_offload, 0, sizeof(*p2p_ps_offload));
 		break;
 	case P2P_PS_ENABLE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_ENABLE\n");
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_ENABLE\n");
 		/* update CTWindow value. */
 		if (p2pinfo->ctwindow > 0) {
 			p2p_ps_offload->ctwindow_en = 1;
@@ -703,11 +703,11 @@ void rtl88e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 		}
 		break;
 	case P2P_PS_SCAN:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
 		p2p_ps_offload->discovery = 1;
 		break;
 	case P2P_PS_SCAN_DONE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN_DONE\n");
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN_DONE\n");
 		p2p_ps_offload->discovery = 0;
 		p2pinfo->p2p_ps_state = P2P_PS_ENABLE;
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index 70716631de85..c51157aedf6e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -140,7 +140,7 @@ static void _rtl88ee_set_fw_clock_on(struct ieee80211_hw *hw,
 			if (content & IMR_CPWM) {
 				rtl_write_word(rtlpriv, isr_regaddr, 0x0100);
 				rtlhal->fw_ps_state = FW_PS_STATE_RF_ON_88E;
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 					 "Receive CPWM INT!!! Set pHalData->FwPSState = %X\n",
 					 rtlhal->fw_ps_state);
 			}
@@ -400,7 +400,7 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 			 "HW_VAR_SLOT_TIME %x\n", val[0]);
 
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
@@ -445,7 +445,7 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			*val = min_spacing_to_set;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
 				  mac->min_space_cfg);
 
@@ -459,7 +459,7 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		density_to_set = *val;
 		mac->min_space_cfg |= (density_to_set << 3);
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 			 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
 			  mac->min_space_cfg);
 
@@ -500,7 +500,7 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			}
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
 				  factor_toset);
 		}
@@ -536,7 +536,7 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				acm_ctrl |= ACMHW_VOQEN;
 				break;
 			default:
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
 					 acm);
 				break;
@@ -559,7 +559,7 @@ void rtl88ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			}
 		}
 
-		RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_QOS, DBG_TRACE,
 			 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
 			 acm_ctrl);
 		rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
@@ -834,7 +834,7 @@ static bool _rtl88ee_init_mac(struct ieee80211_hw *hw)
 	if (!rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_ALL_MSK,
 				      PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK,
 				      RTL8188EE_NIC_ENABLE_FLOW)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "init MAC Fail as rtl_hal_pwrseqcmdparsing\n");
 		return false;
 	}
@@ -870,7 +870,7 @@ static bool _rtl88ee_init_mac(struct ieee80211_hw *hw)
 
 	if (!rtlhal->mac_func_enable) {
 		if (_rtl88ee_llt_table_init(hw) == false) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "LLT table init fail\n");
 			return false;
 		}
@@ -1002,13 +1002,13 @@ void rtl88ee_enable_hw_security_config(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		 "PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
 		  rtlpriv->sec.pairwise_enc_algorithm,
 		  rtlpriv->sec.group_enc_algorithm);
 
 	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 			 "not open hw encryption\n");
 		return;
 	}
@@ -1024,7 +1024,7 @@ void rtl88ee_enable_hw_security_config(struct ieee80211_hw *hw)
 
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
@@ -1076,7 +1076,7 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl88e_download_fw(hw, false);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
@@ -1130,7 +1130,7 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 			rtl88e_phy_set_rfpath_switch(hw, false);
 			rtlpriv->dm.fat_table.rx_idle_ant = AUX_ANT;
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "rx idle ant %s\n",
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "rx idle ant %s\n",
 			 (rtlpriv->dm.fat_table.rx_idle_ant == MAIN_ANT) ?
 			 ("MAIN_ANT") : ("AUX_ANT"));
 
@@ -1148,7 +1148,7 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 	tmp_u1b = efuse_read_1byte(hw, 0x1FA);
 	if (!(tmp_u1b & BIT(0))) {
 		rtl_set_rfreg(hw, RF90_PATH_A, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path A\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path A\n");
 	}
 
 	if (!(tmp_u1b & BIT(4))) {
@@ -1157,7 +1157,7 @@ int rtl88ee_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x80);
 		udelay(10);
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x90);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "under 1.5V\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "under 1.5V\n");
 	}
 	rtl_write_byte(rtlpriv, REG_NAV_CTRL+2,  ((30000+127)/128));
 	rtl88e_dm_init(hw);
@@ -1185,7 +1185,7 @@ static enum version_8188e _rtl88ee_read_chip_version(struct ieee80211_hw *hw)
 	}
 
 	rtlphy->rf_type = RF_1T1R;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
 		 "RF_2T2R" : "RF_1T1R");
 
@@ -1203,25 +1203,25 @@ static int _rtl88ee_set_media_status(struct ieee80211_hw *hw,
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		mode = MSR_NOLINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 	case NL80211_IFTYPE_MESH_POINT:
 		mode = MSR_ADHOC;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		mode = MSR_INFRA;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		mode = MSR_AP;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to AP!\n");
 		break;
 	default:
@@ -1248,7 +1248,7 @@ static int _rtl88ee_set_media_status(struct ieee80211_hw *hw,
 		_rtl88ee_resume_tx_beacon(hw);
 		_rtl88ee_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
 			 mode);
 	}
@@ -1370,7 +1370,7 @@ static void _rtl88ee_poweroff_adapter(struct ieee80211_hw *hw)
 	rtlhal->mac_func_enable = false;
 	rtlpriv->intf_ops->enable_aspm(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "POWER OFF adapter\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "POWER OFF adapter\n");
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_TX_RPT_CTRL);
 	rtl_write_byte(rtlpriv, REG_TX_RPT_CTRL, u1b_tmp & (~BIT(1)));
 
@@ -1427,7 +1427,7 @@ void rtl88ee_card_disable(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	enum nl80211_iftype opmode;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "RTL8188ee card disable\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "RTL8188ee card disable\n");
 
 	mac->link_state = MAC80211_NOLINK;
 	opmode = NL80211_IFTYPE_UNSPECIFIED;
@@ -1486,7 +1486,7 @@ void rtl88ee_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BEACON, DBG_DMESG,
 		 "beacon_interval:%d\n", bcn_interval);
 	/*rtl88ee_disable_interrupt(hw);*/
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
@@ -1499,7 +1499,7 @@ void rtl88ee_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD,
 		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
@@ -1559,14 +1559,14 @@ static void read_power_value_fromprom(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 rfpath, eeaddr = EEPROM_TX_PWR_INX, group, txcnt = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "hal_ReadPowerValueFromPROM88E():PROMContent[0x%x]=0x%x\n",
 		 (eeaddr+1), hwinfo[eeaddr+1]);
 	if (0xFF == hwinfo[eeaddr+1])  /*YJ,add,120316*/
 		autoload_fail = true;
 
 	if (autoload_fail) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "auto load fail : Use Default value!\n");
 		for (rfpath = 0 ; rfpath < MAX_RF_PATH ; rfpath++) {
 			/* 2.4G default value */
@@ -1826,7 +1826,7 @@ static void _rtl88ee_read_adapter_info(struct ieee80211_hw *hw)
 	if (rtlefuse->eeprom_oemid == 0xFF)
 		rtlefuse->eeprom_oemid = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
 	/* set channel plan from efuse */
 	rtlefuse->channel_plan = rtlefuse->eeprom_channelplan;
@@ -1925,7 +1925,7 @@ static void _rtl88ee_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
@@ -1943,18 +1943,18 @@ void rtl88ee_read_eeprom_info(struct ieee80211_hw *hw)
 	else
 		rtlpriv->dm.rfpath_rxenable[0] =
 		    rtlpriv->dm.rfpath_rxenable[1] = true;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
 						rtlhal->version);
 	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
 	if (tmp_u1b & BIT(4)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EEPROM\n");
 		rtlefuse->epromtype = EEPROM_93C46;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from EFUSE\n");
 		rtlefuse->epromtype = EEPROM_BOOT_EFUSE;
 	}
 	if (tmp_u1b & BIT(5)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 		_rtl88ee_read_adapter_info(hw);
 	} else {
@@ -2049,7 +2049,7 @@ static void rtl88ee_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
@@ -2169,12 +2169,12 @@ static void rtl88ee_update_hal_rate_mask(struct ieee80211_hw *hw,
 	}
 	sta_entry->ratr_index = ratr_index;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "ratr_bitmap :%x\n", ratr_bitmap);
 	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
 			     (ratr_index << 28);
 	rate_mask[4] = macid | (b_shortgi ? 0x20 : 0x00) | 0x80;
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x\n",
 		 ratr_index, ratr_bitmap,
 		 rate_mask[0], rate_mask[1],
@@ -2236,7 +2236,7 @@ bool rtl88ee_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	e_rfpowerstate_toset = (u4tmp & BIT(31)) ? ERFON : ERFOFF;
 
 	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
 
 		e_rfpowerstate_toset = ERFON;
@@ -2244,7 +2244,7 @@ bool rtl88ee_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 		b_actuallyset = true;
 	} else if ((!ppsc->hwradiooff) &&
 		   (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 
 		e_rfpowerstate_toset = ERFOFF;
@@ -2295,7 +2295,7 @@ void rtl88ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2354,7 +2354,7 @@ void rtl88ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "delete one entry, entry_id is %d\n",
 				 entry_id);
 			if (mac->opmode == NL80211_IFTYPE_AP ||
@@ -2362,10 +2362,10 @@ void rtl88ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 				rtl_cam_del_entry(hw, p_macaddr);
 			rtl_cam_delete_one_entry(hw, p_macaddr, entry_id);
 		} else {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "add one entry\n");
 			if (is_pairwise) {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 					 "set Pairwise key\n");
 
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
@@ -2373,7 +2373,7 @@ void rtl88ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 						      CAM_CONFIG_NO_USEDK,
 						      rtlpriv->sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 					 "set group key\n");
 
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
index 4ef6d5907521..c2b665b1cfe4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/led.c
@@ -19,7 +19,7 @@ void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD,
 		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
@@ -35,7 +35,7 @@ void rtl88ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, ledcfg & 0x10);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
@@ -47,7 +47,7 @@ void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD,
 		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
@@ -72,7 +72,7 @@ void rtl88ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, (ledcfg | BIT(3)));
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
@@ -123,7 +123,7 @@ void rtl88ee_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_TRACE, "ledaction %d,\n",
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_TRACE, "ledaction %d,\n",
 				ledaction);
 	_rtl88ee_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
index d13983ec09ad..654be0e564a1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c
@@ -43,13 +43,13 @@ u32 rtl88e_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl88e_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n", bitmask,
 		 regaddr, originalvalue);
 
@@ -63,7 +63,7 @@ void rtl88e_phy_set_bb_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 
@@ -75,7 +75,7 @@ void rtl88e_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 }
@@ -86,7 +86,7 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
@@ -99,7 +99,7 @@ u32 rtl88e_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		  regaddr, rfpath, bitmask, original_value);
 	return readback_value;
@@ -112,7 +112,7 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  regaddr, bitmask, data, rfpath);
 
@@ -133,7 +133,7 @@ void rtl88e_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 }
@@ -179,7 +179,7 @@ static u32 _rtl88e_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 					 BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "RFR-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
@@ -203,7 +203,7 @@ static void _rtl88e_phy_rf_serial_write(struct ieee80211_hw *hw,
 	newoffset = offset;
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "RFW-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
@@ -381,10 +381,10 @@ static bool _rtl88e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl8188EMACPHY_Array\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl8188EMACPHY_Array\n");
 	arraylength = RTL8188EEMAC_1T_ARRAYLEN;
 	ptrarray = RTL8188EEMAC_1T_ARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "Img:RTL8188EEMAC_1T_ARRAY LEN %d\n", arraylength);
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8)ptrarray[i + 1]);
@@ -487,7 +487,7 @@ static void handle_branch2(struct ieee80211_hw *hw, u16 arraylen,
 					READ_NEXT_PAIR(v1, v2, i);
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "The agctab_array_table[0] is %x Rtl818EEPHY_REGArray[1] is %x\n",
 			 array_table[i], array_table[i + 1]);
 	}
@@ -521,49 +521,49 @@ static void store_pwrindex_rate_offset(struct ieee80211_hw *hw,
 
 	if (regaddr == RTXAGC_A_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][0] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][0]);
 	}
 	if (regaddr == RTXAGC_A_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][1] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][1]);
 	}
 	if (regaddr == RTXAGC_A_CCK1_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][6] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][6] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][6]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0xffffff00) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][7] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][7]);
 	}
 	if (regaddr == RTXAGC_A_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][2] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][2]);
 	}
 	if (regaddr == RTXAGC_A_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][3] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][3]);
 	}
 	if (regaddr == RTXAGC_A_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][4] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][4]);
@@ -574,63 +574,63 @@ static void store_pwrindex_rate_offset(struct ieee80211_hw *hw,
 			count++;
 			rtlphy->pwrgroup_cnt = count;
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][5]);
 	}
 	if (regaddr == RTXAGC_B_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][8] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][8]);
 	}
 	if (regaddr == RTXAGC_B_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][9] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][9]);
 	}
 	if (regaddr == RTXAGC_B_CCK1_55_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][14] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][14]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][15] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][15]);
 	}
 	if (regaddr == RTXAGC_B_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][10] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][10]);
 	}
 	if (regaddr == RTXAGC_B_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][11] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][11]);
 	}
 	if (regaddr == RTXAGC_B_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][12] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][12]);
 	}
 	if (regaddr == RTXAGC_B_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[count][13] = data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
 			  count,
 			  rtlphy->mcs_txpwrlevel_origoffset[count][13]);
@@ -696,7 +696,7 @@ static bool phy_config_bb_with_pghdr(struct ieee80211_hw *hw, u8 configtype)
 			}
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "configtype != BaseBand_Config_PHY_REG\n");
 	}
 	return true;
@@ -769,9 +769,9 @@ bool rtl88e_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 
 	radioa_arraylen = RTL8188EE_RADIOA_1TARRAYLEN;
 	radioa_array_table = RTL8188EE_RADIOA_1TARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "Radio_A:RTL8188EE_RADIOA_1TARRAY %d\n", radioa_arraylen);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		process_path_a(hw, radioa_arraylen, radioa_array_table);
@@ -798,7 +798,7 @@ void rtl88e_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->default_initialgain[3] =
 	    (u8)rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
 		 rtlphy->default_initialgain[0],
 		 rtlphy->default_initialgain[1],
@@ -810,7 +810,7 @@ void rtl88e_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
 					      MASKDWORD);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Default framesync (0x%x) = 0x%x\n",
 		 ROFDM0_RXDETECTOR3, rtlphy->framesync);
 }
@@ -1081,7 +1081,7 @@ void rtl88e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	u8 reg_bw_opmode;
 	u8 reg_prsr_rsc;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE,
 		 "Switch to %s bandwidth\n",
 		  rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
 		  "20MHz" : "40MHz");
@@ -1138,7 +1138,7 @@ void rtl88e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl88e_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
 }
 
 void rtl88e_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -1155,7 +1155,7 @@ void rtl88e_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl88e_phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
@@ -1169,7 +1169,7 @@ void rtl88e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 delay;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE,
 		 "switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
@@ -1188,7 +1188,7 @@ void rtl88e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl88e_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -1208,12 +1208,12 @@ u8 rtl88e_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl88e_phy_sw_chnl_callback(hw);
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CHAN, DBG_LOUD,
 			 "sw_chnl_inprogress false schedule workitem current channel %d\n",
 			 rtlphy->current_channel);
 		rtlphy->sw_chnl_inprogress = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CHAN, DBG_LOUD,
 			 "sw_chnl_inprogress false driver sleep or unload\n");
 		rtlphy->sw_chnl_inprogress = false;
 	}
@@ -1315,7 +1315,7 @@ static bool _rtl88e_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 				 "switch case %#x not processed\n",
 				 currentcmd->cmdid);
 			break;
@@ -1749,7 +1749,7 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 	for (i = 0; i < retrycount; i++) {
 		patha_ok = _rtl88e_phy_path_a_iqk(hw, is2t);
 		if (patha_ok == 0x01) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "Path A Tx IQK Success!!\n");
 			result[t][0] = (rtl_get_bbreg(hw, 0xe94, MASKDWORD) &
 					0x3FF0000) >> 16;
@@ -1762,7 +1762,7 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 	for (i = 0; i < retrycount; i++) {
 		patha_ok = _rtl88e_phy_path_a_rx_iqk(hw, is2t);
 		if (patha_ok == 0x03) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "Path A Rx IQK Success!!\n");
 			result[t][2] = (rtl_get_bbreg(hw, 0xea4, MASKDWORD) &
 					0x3FF0000) >> 16;
@@ -1770,13 +1770,13 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 					0x3FF0000) >> 16;
 			break;
 		} else {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "Path a RX iqk fail!!!\n");
 		}
 	}
 
 	if (0 == patha_ok)
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Path A IQK Success!!\n");
 	if (is2t) {
 		_rtl88e_phy_path_a_standby(hw);
@@ -1828,7 +1828,7 @@ static void _rtl88e_phy_iq_calibrate(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, 0xe30, MASKDWORD, 0x01008c00);
 		rtl_set_bbreg(hw, 0xe34, MASKDWORD, 0x01008c00);
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "88ee IQK Finish!!\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "88ee IQK Finish!!\n");
 }
 
 static void _rtl88e_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
@@ -1874,7 +1874,7 @@ static void _rtl88e_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 	} else {
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 }
 
 static void _rtl88e_phy_set_rfpath_switch(struct ieee80211_hw *hw,
@@ -1883,7 +1883,7 @@ static void _rtl88e_phy_set_rfpath_switch(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 
 	if (is_hal_stop(rtlhal)) {
 		u8 u1btmp;
@@ -2074,23 +2074,23 @@ bool rtl88e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	bool postprocessing = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 		 "-->IO Cmd(%#x), set_io_inprogress(%d)\n",
 		  iotype, rtlphy->set_io_inprogress);
 	do {
 		switch (iotype) {
 		case IO_CMD_RESUME_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 				 "[IO CMD] Resume DM after scan.\n");
 			postprocessing = true;
 			break;
 		case IO_CMD_PAUSE_BAND0_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 				 "[IO CMD] Pause DM before scan.\n");
 			postprocessing = true;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 				 "switch case %#x not processed\n", iotype);
 			break;
 		}
@@ -2102,7 +2102,7 @@ bool rtl88e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl88e_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -2112,7 +2112,7 @@ static void rtl88e_phy_set_io(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
 		  rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
@@ -2128,13 +2128,13 @@ static void rtl88e_phy_set_io(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_CCA, 0xff0000, 0x40);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n",
 			 rtlphy->current_io_type);
 		break;
 	}
 	rtlphy->set_io_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 		 "(%#x)\n", rtlphy->current_io_type);
 }
 
@@ -2180,7 +2180,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
 			do {
 				initializecount++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 					 "IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus &&
@@ -2188,7 +2188,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			RT_CLEAR_PS_LEVEL(ppsc,
 					  RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "Set ERFON sleeped:%d ms\n",
 				  jiffies_to_msecs(jiffies -
 						   ppsc->
@@ -2213,7 +2213,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
 			} else {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
 					 (i + 1), queue_id,
 					 skb_queue_len(&ring->queue));
@@ -2222,7 +2222,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				i++;
 			}
 			if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "\n ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
 					  MAX_DOZE_WAITING_TIMES_9x,
 					  queue_id,
@@ -2232,7 +2232,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		}
 
 		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "IPS Set eRf nic disable\n");
 			rtl_ps_disable_nic(hw);
 			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
@@ -2256,7 +2256,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					queue_id++;
 					continue;
 				} else {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
 						 (i + 1), queue_id,
 						 skb_queue_len(&ring->queue));
@@ -2265,7 +2265,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					i++;
 				}
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 						 "\n ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
 						 MAX_DOZE_WAITING_TIMES_9x,
 						 queue_id,
@@ -2273,7 +2273,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					break;
 				}
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "Set ERFSLEEP awaked:%d ms\n",
 				  jiffies_to_msecs(jiffies -
 				  ppsc->last_awake_jiffies));
@@ -2282,7 +2282,7 @@ static bool _rtl88ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			break;
 		}
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n", rfpwr_state);
 		bresult = false;
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c
index c376817a1bf4..a15a6ccd9350 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/rf.c
@@ -474,13 +474,13 @@ static bool _rtl88e_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 		}
 
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 				 "Radio[%d] Fail!!\n", rfpath);
 			return false;
 		}
 
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
 	return rtstatus;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
index aa2e9e88be53..faf0db81757d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c
@@ -410,7 +410,7 @@ bool rtl88ee_rx_query_desc(struct ieee80211_hw *hw,
 	else
 		wake_match = 0;
 	if (wake_match)
-		RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_RXDESC, DBG_LOUD,
 		"GGGGGGGGGGGGGet Wakeup Packet!! WakeMatch=%d\n",
 		wake_match);
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
@@ -518,7 +518,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
@@ -533,7 +533,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
 					  ptcb_desc->empkt_num);
 				rtl88ee_insert_emcontent(ptcb_desc,
@@ -631,7 +631,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 		}
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 					"Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
@@ -662,7 +662,7 @@ void rtl88ee_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 
 	rtl88e_dm_set_tx_ant_by_tx_info(hw, pdesc8, ptcb_desc->mac_id);
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -682,7 +682,7 @@ void rtl88ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le16 fc = hdr->frame_control;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
-- 
2.27.0

