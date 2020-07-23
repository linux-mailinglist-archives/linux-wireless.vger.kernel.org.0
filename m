Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3093A22B802
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGWUnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbgGWUnA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:43:00 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2414C0619E2
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id z127so1383939ooa.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wF3FqRh8h+teGn07cAeYM5DGmwkOmuoui9JwSUyYt+M=;
        b=l6zuMNazi87Z5oAC80+kIDILfE//dRFye+xtwrWUiP34p81TFjjzI6d58BUdh1tMl6
         l9UWEbeoojNNkawFv56I/p8lt8+vRNhatjhkcXmCNtxFYYLzKHHM+Sc/ZHHbuTqNU0Ij
         ZakNpFtQJy0WI0G+zTYbxLnZZdetPkUXXfXO2X0FSmuFxYlq9WL/rCo2AxI69aba6UDk
         wd3cA0cZji0KWTd72kDOsW+GCtfVYGjADU1BQBf5TRIe+WvV/3ekxBx+u6Pq4ChwaMd5
         WrnLEf771wVDqUtrPE4hjsQatxnQJ3I2r/xIAuPes1q8oEgjufqzh0jV2gVDpcYnt7Wv
         R2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wF3FqRh8h+teGn07cAeYM5DGmwkOmuoui9JwSUyYt+M=;
        b=J9lNQIsg6Anvz52qWuw3Jt9udW+x64PG8Vsqijms9ooDKPzTby1S0OkITznxAAq2ar
         XrKnCmTwnQoMOnSTbKGgT2DZW3/xwZFLo4P72kSXW8j87i6BfY1SK50rpeW6t253jn1l
         ed2GCi4Xz/IEATiB4BExJdIXL8rUsssVwG/Z8qM9d40cau2EY2xArv+Rq/vpsGaH16/V
         riWom8MaVJ632eYME7o2rPuOfP1RHOf5uQGptTH8J27xJGlFglmDL01fNZjXmm3IIVPT
         N5Wz3rnO9y2e4tGjqQHFiLb9erzwVqbJBHo14UgYCdg3kPfoMQtmRW+UOHOcHOzaSzV1
         TvAA==
X-Gm-Message-State: AOAM531OIiT05SNrcS1WRNe3Xb+WOAn011czydBewT2x11102EDfFR5u
        iXXRnQUgwXiQ/8LQAtVBWH7DX+kC
X-Google-Smtp-Source: ABdhPJzOhIdQ0XWHS8j0X5DVhbdbg091v0g+JREbC+isGAT3XuzkfJaLXoWDZfbACMCCw8zdPqwsnA==
X-Received: by 2002:a4a:675a:: with SMTP id j26mr6176877oof.1.1595536978596;
        Thu, 23 Jul 2020 13:42:58 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:58 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 12/15] rtlwifi: rtl8723be Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:41 -0500
Message-Id: <20200723204244.24457-13-Larry.Finger@lwfinger.net>
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
rtl8723be. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8723be/dm.c   | 118 +++----
 .../wireless/realtek/rtlwifi/rtl8723be/fw.c   |  66 ++--
 .../wireless/realtek/rtlwifi/rtl8723be/hw.c   | 202 ++++++------
 .../wireless/realtek/rtlwifi/rtl8723be/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8723be/phy.c  | 310 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8723be/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723be/trx.c  |  24 +-
 7 files changed, 368 insertions(+), 368 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
index c9b3d9d09c48..fbcff23eb058 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/dm.c
@@ -225,9 +225,9 @@ static void rtl8723be_dm_init_txpower_tracking(struct ieee80211_hw *hw)
 	rtlpriv->dm.delta_power_index_last[RF90_PATH_A] = 0;
 	rtlpriv->dm.power_index_offset[RF90_PATH_A] = 0;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "  rtlpriv->dm.txpower_tracking = %d\n",
-		  rtlpriv->dm.txpower_tracking);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"rtlpriv->dm.txpower_tracking = %d\n",
+		rtlpriv->dm.txpower_tracking);
 }
 
 static void rtl8723be_dm_init_dynamic_atc_switch(struct ieee80211_hw *hw)
@@ -265,33 +265,33 @@ static void rtl8723be_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
 		rtl_dm_dig->min_undec_pwdb_for_dm = 0;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"Not connected to any\n");
 	}
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_AP ||
 		    mac->opmode == NL80211_IFTYPE_ADHOC) {
 			rtl_dm_dig->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-			       rtlpriv->dm.entry_min_undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				rtlpriv->dm.entry_min_undec_sm_pwdb);
 		} else {
 			rtl_dm_dig->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%x\n",
-				  rtl_dm_dig->min_undec_pwdb_for_dm);
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"STA Default Port PWDB = 0x%x\n",
+				rtl_dm_dig->min_undec_pwdb_for_dm);
 		}
 	} else {
 		rtl_dm_dig->min_undec_pwdb_for_dm =
 				rtlpriv->dm.entry_min_undec_sm_pwdb;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			 "AP Ext Port or disconnect PWDB = 0x%x\n",
-			  rtl_dm_dig->min_undec_pwdb_for_dm);
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"AP Ext Port or disconnect PWDB = 0x%x\n",
+			rtl_dm_dig->min_undec_pwdb_for_dm);
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
-		 rtl_dm_dig->min_undec_pwdb_for_dm);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
+		rtl_dm_dig->min_undec_pwdb_for_dm);
 }
 
 static void rtl8723be_dm_check_rssi_monitor(struct ieee80211_hw *hw)
@@ -421,7 +421,7 @@ static void rtl8723be_dm_dig(struct ieee80211_hw *hw)
 	} else {
 		dm_digtable->rx_gain_max = dm_dig_max;
 		dig_min_0 = dm_dig_min;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
 	}
 
 	if (rtlpriv->falsealm_cnt.cnt_all > 10000) {
@@ -576,18 +576,18 @@ static void rtl8723be_dm_false_alarm_counter_statistics(
 	rtl_set_bbreg(hw, DM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 0);
 	rtl_set_bbreg(hw, DM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 2);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "cnt_parity_fail = %d, cnt_rate_illegal = %d, cnt_crc8_fail = %d, cnt_mcs_fail = %d\n",
-		 falsealm_cnt->cnt_parity_fail,
-		 falsealm_cnt->cnt_rate_illegal,
-		 falsealm_cnt->cnt_crc8_fail,
-		 falsealm_cnt->cnt_mcs_fail);
-
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "cnt_ofdm_fail = %x, cnt_cck_fail = %x, cnt_all = %x\n",
-		 falsealm_cnt->cnt_ofdm_fail,
-		 falsealm_cnt->cnt_cck_fail,
-		 falsealm_cnt->cnt_all);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"cnt_parity_fail = %d, cnt_rate_illegal = %d, cnt_crc8_fail = %d, cnt_mcs_fail = %d\n",
+		falsealm_cnt->cnt_parity_fail,
+		falsealm_cnt->cnt_rate_illegal,
+		falsealm_cnt->cnt_crc8_fail,
+		falsealm_cnt->cnt_mcs_fail);
+
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"cnt_ofdm_fail = %x, cnt_cck_fail = %x, cnt_all = %x\n",
+		falsealm_cnt->cnt_ofdm_fail,
+		falsealm_cnt->cnt_cck_fail,
+		falsealm_cnt->cnt_all);
 }
 
 static void rtl8723be_dm_dynamic_txpower(struct ieee80211_hw *hw)
@@ -747,18 +747,18 @@ static void rtl8723be_dm_txpower_tracking_callback_thermalmeter(
 
 	/*Initilization ( 7 steps in total )*/
 	rtlpriv->dm.txpower_trackinginit = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "rtl8723be_dm_txpower_tracking_callback_thermalmeter\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"%s\n", __func__);
 
 	thermalvalue = (u8)rtl_get_rfreg(hw,
 		RF90_PATH_A, RF_T_METER, 0xfc00);
 	if (!rtlpriv->dm.txpower_track_control || thermalvalue == 0 ||
 	    rtlefuse->eeprom_thermalmeter == 0xFF)
 		return;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
-		 thermalvalue, rtldm->thermalvalue,
-		 rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
+		thermalvalue, rtldm->thermalvalue,
+		rtlefuse->eeprom_thermalmeter);
 	/*3 Initialize ThermalValues of RFCalibrateInfo*/
 	if (!rtldm->thermalvalue) {
 		rtlpriv->dm.thermalvalue_lck = thermalvalue;
@@ -792,10 +792,10 @@ static void rtl8723be_dm_txpower_tracking_callback_thermalmeter(
 		    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
 		    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
-		 thermalvalue, rtlpriv->dm.thermalvalue,
-		 rtlefuse->eeprom_thermalmeter, delta, delta_lck, delta_iqk);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
+		thermalvalue, rtlpriv->dm.thermalvalue,
+		rtlefuse->eeprom_thermalmeter, delta, delta_lck, delta_iqk);
 	/* 6 If necessary, do LCK.*/
 	if (delta_lck >= IQK_THRESHOLD) {
 		rtlpriv->dm.thermalvalue_lck = thermalvalue;
@@ -876,7 +876,7 @@ static void rtl8723be_dm_txpower_tracking_callback_thermalmeter(
 	}
 
 	rtldm->txpowercount = 0;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "end\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "end\n");
 
 }
 
@@ -890,13 +890,13 @@ void rtl8723be_dm_check_txpower_tracking(struct ieee80211_hw *hw)
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17) | BIT(16),
 			      0x03);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Trigger 8723be Thermal Meter!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Trigger 8723be Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Schedule TxPowerTracking !!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Schedule TxPowerTracking !!\n");
 		rtl8723be_dm_txpower_tracking_callback_thermalmeter(hw);
 		rtlpriv->dm.tm_trigger = 0;
 	}
@@ -914,14 +914,14 @@ static void rtl8723be_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
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
 
@@ -949,14 +949,14 @@ static void rtl8723be_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 			p_ra->ratr_state = DM_RATR_STA_LOW;
 
 		if (p_ra->pre_ratr_state != p_ra->ratr_state) {
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI = %ld\n",
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"RSSI = %ld\n",
 				 rtlpriv->dm.undec_sm_pwdb);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI_LEVEL = %d\n", p_ra->ratr_state);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "PreState = %d, CurState = %d\n",
-				  p_ra->pre_ratr_state, p_ra->ratr_state);
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"RSSI_LEVEL = %d\n", p_ra->ratr_state);
+			rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+				"PreState = %d, CurState = %d\n",
+				p_ra->pre_ratr_state, p_ra->ratr_state);
 
 			rcu_read_lock();
 			sta = rtl_find_sta(hw, mac->bssid);
@@ -1073,8 +1073,8 @@ static void rtl8723be_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 
 	dm_digtable->pre_cck_cca_thres = dm_digtable->cur_cck_cca_thres;
 	dm_digtable->cur_cck_cca_thres = cur_cck_cca_thresh;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "CCK cca thresh hold =%x\n", dm_digtable->cur_cck_cca_thres);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"CCK cca thresh hold =%x\n", dm_digtable->cur_cck_cca_thres);
 }
 
 static void rtl8723be_dm_dynamic_edcca(struct ieee80211_hw *hw)
@@ -1121,8 +1121,8 @@ static void rtl8723be_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 		}
 		if (rtlpriv->cfg->ops->get_btc_status()) {
 			if (!rtlpriv->btcoexist.btc_ops->btc_is_bt_disabled(rtlpriv)) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-					 "odm_DynamicATCSwitch(): Disable CFO tracking for BT!!\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+					"odm_DynamicATCSwitch(): Disable CFO tracking for BT!!\n");
 				return;
 			}
 		}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.c
index aa56058af56e..b3e6c91e26c0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.c
@@ -41,22 +41,22 @@ static void _rtl8723be_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
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
@@ -107,9 +107,9 @@ static void _rtl8723be_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
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
 
@@ -118,24 +118,24 @@ static void _rtl8723be_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 			isfw_read = _rtl8723be_check_fw_read_last_h2c(hw,
 								boxnum);
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
-			  box_reg, element_id);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Write element_id box_reg(%4x) = %2x\n",
+			box_reg, element_id);
 
 		switch (cmd_len) {
 		case 1:
@@ -182,16 +182,16 @@ static void _rtl8723be_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
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
 
 void rtl8723be_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
@@ -229,8 +229,8 @@ void rtl8723be_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	if (bt_ctrl_lps)
 		mode = (bt_lps_on ? FW_PS_MIN_MODE : FW_PS_ACTIVE_MODE);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "FW LPS mode = %d (coex:%d)\n",
-		 mode, bt_ctrl_lps);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG, "FW LPS mode = %d (coex:%d)\n",
+		mode, bt_ctrl_lps);
 
 	switch (mode) {
 	case FW_PS_MIN_MODE:
@@ -572,15 +572,15 @@ void rtl8723be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw,
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Set RSVD page location to Fw.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG, "H2C_RSVDPAGE:\n",
 			      u1rsvdpageloc, sizeof(u1rsvdpageloc));
 		rtl8723be_fill_h2c_cmd(hw, H2C_8723B_RSVDPAGE,
 				       sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 
 /*Should check FW support p2p or not.*/
@@ -607,11 +607,11 @@ void rtl8723be_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw,
 
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
@@ -668,11 +668,11 @@ void rtl8723be_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw,
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
index 979e5bfe5f45..fcbe47279206 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c
@@ -146,9 +146,9 @@ static void _rtl8723be_set_fw_clock_on(struct ieee80211_hw *hw, u8 rpwm_val,
 			if (content & IMR_CPWM) {
 				rtl_write_word(rtlpriv, isr_regaddr, 0x0100);
 				rtlhal->fw_ps_state = FW_PS_STATE_RF_ON;
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-					 "Receive CPWM INT!!! Set pHalData->FwPSState = %X\n",
-					 rtlhal->fw_ps_state);
+				rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+					"Receive CPWM INT!!! Set pHalData->FwPSState = %X\n",
+					rtlhal->fw_ps_state);
 			}
 		}
 
@@ -331,8 +331,8 @@ void rtl8723be_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HAL_DEF_WOWLAN:
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -436,8 +436,8 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "HW_VAR_SLOT_TIME %x\n", val[0]);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 
@@ -479,9 +479,9 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			*val = min_spacing_to_set;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-				  mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+				mac->min_space_cfg);
 
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
@@ -494,9 +494,9 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		density_to_set = *((u8 *)val);
 		mac->min_space_cfg |= (density_to_set << 3);
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-			  mac->min_space_cfg);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+			mac->min_space_cfg);
 
 		rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 			       mac->min_space_cfg);
@@ -534,9 +534,9 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			}
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
-				  factor_toset);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+				factor_toset);
 		}
 		}
 		break;
@@ -571,9 +571,9 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -588,16 +588,16 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				acm_ctrl &= (~ACMHW_VOQEN);
 				break;
 			default:
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-					 "switch case %#x not processed\n",
-					 e_aci);
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+					"switch case %#x not processed\n",
+					e_aci);
 				break;
 			}
 		}
 
-		RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
-			 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
-			 acm_ctrl);
+		rtl_dbg(rtlpriv, COMP_QOS, DBG_TRACE,
+			"SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
+			acm_ctrl);
 		rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
 		}
 		break;
@@ -705,8 +705,8 @@ void rtl8723be_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		}
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -821,8 +821,8 @@ static bool _rtl8723be_init_mac(struct ieee80211_hw *hw)
 	if (!rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_ALL_MSK,
 				      PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK,
 				      RTL8723_NIC_ENABLE_FLOW)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "init MAC Fail as power on failure\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"init MAC Fail as power on failure\n");
 		return false;
 	}
 
@@ -1121,14 +1121,14 @@ void rtl8723be_enable_hw_security_config(struct ieee80211_hw *hw)
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
 
@@ -1143,8 +1143,8 @@ void rtl8723be_enable_hw_security_config(struct ieee80211_hw *hw)
 
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
@@ -1208,8 +1208,8 @@ static bool _rtl8723be_check_pcie_dma_hang(struct rtl_priv *rtlpriv)
 	 */
 	tmp = rtl_read_byte(rtlpriv, REG_DBI_CTRL + 3);
 	if ((tmp & BIT(0)) || (tmp & BIT(1))) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "CheckPcieDMAHang8723BE(): true!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"CheckPcieDMAHang8723BE(): true!!\n");
 		return true;
 	}
 	return false;
@@ -1222,8 +1222,8 @@ static void _rtl8723be_reset_pcie_interface_dma(struct rtl_priv *rtlpriv,
 	bool release_mac_rx_pause;
 	u8 backup_pcie_dma_pause;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "ResetPcieInterfaceDMA8723BE()\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"ResetPcieInterfaceDMA8723BE()\n");
 
 	/* Revise Note: Follow the document "PCIe RX DMA Hang Reset Flow_v03"
 	 * released by SD1 Alan.
@@ -1375,8 +1375,8 @@ int rtl8723be_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl8723_download_fw(hw, true, FW_8723B_POLLING_TIMEOUT_COUNT);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
 	}
@@ -1460,7 +1460,7 @@ static enum version_8723e _rtl8723be_read_chip_version(struct ieee80211_hw *hw)
 
 	value32 = rtl_read_dword(rtlpriv, REG_SYS_CFG1);
 	if ((value32 & (CHIP_8723B)) != CHIP_8723B)
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "unknown chip version\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "unknown chip version\n");
 	else
 		version = (enum version_8723e)CHIP_8723B;
 
@@ -1476,9 +1476,9 @@ static enum version_8723e _rtl8723be_read_chip_version(struct ieee80211_hw *hw)
 	if (((value32 & EXT_VENDOR_ID) >> 18) == 0x01)
 		version = (enum version_8723e)(version | CHIP_VENDOR_SMIC);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
-		  "RF_2T2R" : "RF_1T1R");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
+		"RF_2T2R" : "RF_1T1R");
 
 	return version;
 }
@@ -1494,26 +1494,26 @@ static int _rtl8723be_set_media_status(struct ieee80211_hw *hw,
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
@@ -1538,9 +1538,9 @@ static int _rtl8723be_set_media_status(struct ieee80211_hw *hw,
 		_rtl8723be_resume_tx_beacon(hw);
 		_rtl8723be_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
-			 mode);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
+			mode);
 	}
 
 	rtl_write_byte(rtlpriv, MSR, bt_msr | mode);
@@ -1702,8 +1702,8 @@ void rtl8723be_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	rtl8723be_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	rtl8723be_enable_interrupt(hw);
@@ -1715,8 +1715,8 @@ void rtl8723be_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1747,15 +1747,15 @@ static void _rtl8723be_read_power_value_fromprom(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 path, addr = EEPROM_TX_PWR_INX, group, cnt = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "hal_ReadPowerValueFromPROM8723BE(): PROMContent[0x%x]=0x%x\n",
-		 (addr + 1), hwinfo[addr + 1]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"hal_ReadPowerValueFromPROM8723BE(): PROMContent[0x%x]=0x%x\n",
+		(addr + 1), hwinfo[addr + 1]);
 	if (0xFF == hwinfo[addr + 1])  /*YJ,add,120316*/
 		autoload_fail = true;
 
 	if (autoload_fail) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "auto load fail : Use Default value!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"auto load fail : Use Default value!\n");
 		for (path = 0; path < MAX_RF_PATH; path++) {
 			/* 2.4G default value */
 			for (group = 0 ; group < MAX_CHNL_GROUP_24G; group++) {
@@ -2099,8 +2099,8 @@ static void _rtl8723be_read_adapter_info(struct ieee80211_hw *hw,
 		rtlefuse->board_type |= BIT(2); /* ODM_BOARD_BT */
 
 	rtlhal->board_type = rtlefuse->board_type;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "board_type = 0x%x\n", rtlefuse->board_type);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"board_type = 0x%x\n", rtlefuse->board_type);
 
 	rtlhal->package_type = _rtl8723be_read_package_type(hw);
 
@@ -2237,8 +2237,8 @@ static void _rtl8723be_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
 void rtl8723be_read_eeprom_info(struct ieee80211_hw *hw)
@@ -2255,18 +2255,18 @@ void rtl8723be_read_eeprom_info(struct ieee80211_hw *hw)
 	else
 		rtlpriv->dm.rfpath_rxenable[0] =
 		    rtlpriv->dm.rfpath_rxenable[1] = true;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
-		 rtlhal->version);
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
 		_rtl8723be_read_adapter_info(hw, false);
 	} else {
@@ -2417,8 +2417,8 @@ static void rtl8723be_update_hal_rate_mask(struct ieee80211_hw *hw,
 
 	sta_entry->ratr_index = ratr_index;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "ratr_bitmap :%x\n", ratr_bitmap);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"ratr_bitmap :%x\n", ratr_bitmap);
 	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
 				       (ratr_index << 28);
 	rate_mask[0] = macid;
@@ -2431,13 +2431,13 @@ static void rtl8723be_update_hal_rate_mask(struct ieee80211_hw *hw,
 	rate_mask[5] = (u8)((ratr_bitmap & 0x00ff0000) >> 16);
 	rate_mask[6] = (u8)((ratr_bitmap & 0xff000000) >> 24);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x:%x:%x\n",
-		 ratr_index, ratr_bitmap,
-		 rate_mask[0], rate_mask[1],
-		 rate_mask[2], rate_mask[3],
-		 rate_mask[4], rate_mask[5],
-		 rate_mask[6]);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x:%x:%x\n",
+		ratr_index, ratr_bitmap,
+		rate_mask[0], rate_mask[1],
+		rate_mask[2], rate_mask[3],
+		rate_mask[4], rate_mask[5],
+		rate_mask[6]);
 	rtl8723be_fill_h2c_cmd(hw, H2C_8723B_RA_MASK, 7, rate_mask);
 	_rtl8723be_set_bcn_ctrl_reg(hw, BIT(3), 0);
 }
@@ -2500,15 +2500,15 @@ bool rtl8723be_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 		e_rfpowerstate_toset = (u1tmp & BIT(1)) ? ERFON : ERFOFF;
 
 	if ((ppsc->hwradiooff) && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio ON, RF ON\n");
 
 		e_rfpowerstate_toset = ERFON;
 		ppsc->hwradiooff = false;
 		b_actuallyset = true;
 	} else if (!ppsc->hwradiooff && (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 
 		e_rfpowerstate_toset = ERFOFF;
 		ppsc->hwradiooff = true;
@@ -2559,7 +2559,7 @@ void rtl8723be_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2587,8 +2587,8 @@ void rtl8723be_set_key(struct ieee80211_hw *hw, u32 key_index,
 			enc_algo = CAM_AES;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", enc_algo);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", enc_algo);
 			enc_algo = CAM_TKIP;
 			break;
 		}
@@ -2618,26 +2618,26 @@ void rtl8723be_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "delete one entry, entry_id is %d\n",
-				  entry_id);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"delete one entry, entry_id is %d\n",
+				entry_id);
 			if (mac->opmode == NL80211_IFTYPE_AP)
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c
index 525f2c47da5b..3954624ab314 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/led.c
@@ -19,8 +19,8 @@ void rtl8723be_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -47,8 +47,8 @@ void rtl8723be_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
@@ -127,6 +127,6 @@ void rtl8723be_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n", ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n", ledaction);
 	_rtl8723be_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
index 9528ac3f3b87..f09f55b0468a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/phy.c
@@ -34,9 +34,9 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		  regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -46,9 +46,9 @@ u32 rtl8723be_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		 regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 
 	return readback_value;
 }
@@ -59,9 +59,9 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  regaddr, bitmask, data, path);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, path);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -77,9 +77,9 @@ void rtl8723be_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path path,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  regaddr, bitmask, data, path);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, path);
 
 }
 
@@ -158,18 +158,18 @@ static bool _rtl8723be_check_positive(struct ieee80211_hw *hw,
 		      rtlhal->type_alna << 16 |
 		      rtlhal->type_apa  << 24;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "===> [8812A] CheckPositive (cond1, cond2) = (0x%X 0x%X)\n",
-		 cond1, cond2);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "===> [8812A] CheckPositive (driver1, driver2) = (0x%X 0x%X)\n",
-		 driver1, driver2);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"===> [8812A] CheckPositive (cond1, cond2) = (0x%X 0x%X)\n",
+		cond1, cond2);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"===> [8812A] CheckPositive (driver1, driver2) = (0x%X 0x%X)\n",
+		driver1, driver2);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "	(Platform, Interface) = (0x%X, 0x%X)\n", 0x04, intf);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "	(Board, Package) = (0x%X, 0x%X)\n",
-		 rtlhal->board_type, rtlhal->package_type);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"(Platform, Interface) = (0x%X, 0x%X)\n", 0x04, intf);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"(Board, Package) = (0x%X, 0x%X)\n",
+		rtlhal->board_type, rtlhal->package_type);
 
 	/*============== Value Defined Check ===============*/
 	/*QFN Type [15:12] and Cut Version [27:24] need to do value check*/
@@ -283,9 +283,9 @@ static void _rtl8723be_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
 	if (path > RF90_PATH_D) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Rf Path %d in phy_SetTxPowerByRatBase()\n",
-			  path);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Rf Path %d in phy_SetTxPowerByRatBase()\n",
+			path);
 		return;
 	}
 
@@ -304,15 +304,15 @@ static void _rtl8723be_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 			rtlphy->txpwr_by_rate_base_24g[path][txnum][3] = value;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Invalid RateSection %d in Band 2.4G, Rf Path %d, %dTx in PHY_SetTxPowerByRateBase()\n",
-				 rate_section, path, txnum);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Invalid RateSection %d in Band 2.4G, Rf Path %d, %dTx in PHY_SetTxPowerByRateBase()\n",
+				rate_section, path, txnum);
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Band %d in PHY_SetTxPowerByRateBase()\n",
-			 band);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Band %d in PHY_SetTxPowerByRateBase()\n",
+			band);
 	}
 
 }
@@ -325,9 +325,9 @@ static u8 _rtl8723be_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u8 value = 0;
 	if (path > RF90_PATH_D) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Rf Path %d in PHY_GetTxPowerByRateBase()\n",
-			  path);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Rf Path %d in PHY_GetTxPowerByRateBase()\n",
+			path);
 		return 0;
 	}
 
@@ -346,15 +346,15 @@ static u8 _rtl8723be_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 			value = rtlphy->txpwr_by_rate_base_24g[path][txnum][3];
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Invalid RateSection %d in Band 2.4G, Rf Path %d, %dTx in PHY_GetTxPowerByRateBase()\n",
-				 rate_section, path, txnum);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Invalid RateSection %d in Band 2.4G, Rf Path %d, %dTx in PHY_GetTxPowerByRateBase()\n",
+				rate_section, path, txnum);
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Band %d in PHY_GetTxPowerByRateBase()\n",
-			 band);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Band %d in PHY_GetTxPowerByRateBase()\n",
+			band);
 	}
 
 	return value;
@@ -477,8 +477,8 @@ static void _rtl8723be_phy_convert_txpower_dbm_to_relative_value(
 	    &rtlphy->tx_power_by_rate_offset[BAND_ON_2_4G][rfpath][RF_2TX][7],
 	    0, 3, base);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-	    "<===_rtl8723be_phy_convert_txpower_dbm_to_relative_value()\n");
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+		"<===%s\n", __func__);
 }
 
 static void phy_txpower_by_rate_config(struct ieee80211_hw *hw)
@@ -588,7 +588,7 @@ static bool _rtl8723be_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read rtl8723beMACPHY_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read rtl8723beMACPHY_Array\n");
 
 	return rtl8723be_phy_config_with_headerfile(hw,
 			RTL8723BEMAC_1T_ARRAY, RTL8723BEMAC_1T_ARRAYLEN,
@@ -684,16 +684,16 @@ static void _rtl8723be_store_tx_power_by_rate(struct ieee80211_hw *hw,
 	u8 rate_section = _rtl8723be_get_rate_section_index(regaddr);
 
 	if (band != BAND_ON_2_4G && band != BAND_ON_5G) {
-		RT_TRACE(rtlpriv, FPHY, PHY_TXPWR, "Invalid Band %d\n", band);
+		rtl_dbg(rtlpriv, FPHY, PHY_TXPWR, "Invalid Band %d\n", band);
 		return;
 	}
 	if (rfpath > MAX_RF_PATH - 1) {
-		RT_TRACE(rtlpriv, FPHY, PHY_TXPWR,
-			 "Invalid RfPath %d\n", rfpath);
+		rtl_dbg(rtlpriv, FPHY, PHY_TXPWR,
+			"Invalid RfPath %d\n", rfpath);
 		return;
 	}
 	if (txnum > MAX_RF_PATH - 1) {
-		RT_TRACE(rtlpriv, FPHY, PHY_TXPWR, "Invalid TxNum %d\n", txnum);
+		rtl_dbg(rtlpriv, FPHY, PHY_TXPWR, "Invalid TxNum %d\n", txnum);
 		return;
 	}
 
@@ -734,8 +734,8 @@ static bool _rtl8723be_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
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
@@ -747,7 +747,7 @@ bool rtl8723be_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	bool ret = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		ret =  rtl8723be_phy_config_with_headerfile(hw,
@@ -762,8 +762,8 @@ bool rtl8723be_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 	case RF90_PATH_C:
 		break;
 	case RF90_PATH_D:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", rfpath);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", rfpath);
 		break;
 	}
 	return ret;
@@ -783,21 +783,21 @@ void rtl8723be_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
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
-		  ROFDM0_RXDETECTOR3, rtlphy->framesync);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default framesync (0x%x) = 0x%x\n",
+		ROFDM0_RXDETECTOR3, rtlphy->framesync);
 }
 
 static u8 _rtl8723be_phy_get_ratesection_intxpower_byrate(enum radio_path path,
@@ -950,16 +950,16 @@ static u8 _rtl8723be_get_txpower_index(struct ieee80211_hw *hw, u8 path,
 
 	if (channel > 14 || channel < 1) {
 		index = 0;
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Illegal channel!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Illegal channel!\n");
 	}
 	if (RX_HAL_IS_CCK_RATE(rate))
 		txpower = rtlefuse->txpwrlevel_cck[path][index];
 	else if (DESC92C_RATE6M <= rate)
 		txpower = rtlefuse->txpwrlevel_ht40_1s[path][index];
 	else
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "invalid rate\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"invalid rate\n");
 
 	if (DESC92C_RATE6M <= rate && rate <= DESC92C_RATE54M &&
 	    !RX_HAL_IS_CCK_RATE(rate))
@@ -1099,11 +1099,11 @@ static void _rtl8723be_phy_set_txpower_index(struct ieee80211_hw *hw,
 			break;
 
 		default:
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid Rate!!\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid Rate!!\n");
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid RFPath!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid RFPath!!\n");
 	}
 }
 
@@ -1187,10 +1187,10 @@ void rtl8723be_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
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
@@ -1244,7 +1244,7 @@ void rtl8723be_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl8723be_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
 }
 
 void rtl8723be_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -1261,8 +1261,8 @@ void rtl8723be_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl8723be_phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
 	}
@@ -1275,8 +1275,8 @@ void rtl8723be_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 delay = 0;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
 	do {
@@ -1296,7 +1296,7 @@ void rtl8723be_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl8723be_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -1316,13 +1316,13 @@ u8 rtl8723be_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl8723be_phy_sw_chnl_callback(hw);
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
@@ -1428,9 +1428,9 @@ static bool _rtl8723be_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
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
 
@@ -2058,7 +2058,7 @@ static void _rtl8723be_phy_iq_calibrate(struct ieee80211_hw *hw,
 	for (i = 0; i < retrycount; i++) {
 		patha_ok = _rtl8723be_phy_path_a_iqk(hw);
 		if (patha_ok == 0x01) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 				"Path A Tx IQK Success!!\n");
 			result[t][0] = (rtl_get_bbreg(hw, 0xe94, MASKDWORD) &
 					0x3FF0000) >> 16;
@@ -2066,36 +2066,36 @@ static void _rtl8723be_phy_iq_calibrate(struct ieee80211_hw *hw,
 					0x3FF0000) >> 16;
 			break;
 		} else {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Path A Tx IQK Fail!!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Path A Tx IQK Fail!!\n");
 		}
 	}
 	/* path A RX IQK */
 	for (i = 0; i < retrycount; i++) {
 		patha_ok = _rtl8723be_phy_path_a_rx_iqk(hw);
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
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Path A Rx IQK Fail!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Path A Rx IQK Fail!!\n");
 	}
 
 	if (0x00 == patha_ok)
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Path A IQK Fail!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Path A IQK Fail!!\n");
 
 	if (is2t) {
 		/* path B TX IQK */
 		for (i = 0; i < retrycount; i++) {
 			pathb_ok = _rtl8723be_phy_path_b_iqk(hw);
 			if (pathb_ok == 0x01) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "Path B Tx IQK Success!!\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Path B Tx IQK Success!!\n");
 				result[t][4] = (rtl_get_bbreg(hw, 0xe94,
 							      MASKDWORD) &
 							      0x3FF0000) >> 16;
@@ -2104,15 +2104,15 @@ static void _rtl8723be_phy_iq_calibrate(struct ieee80211_hw *hw,
 							      0x3FF0000) >> 16;
 				break;
 			}
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Path B Tx IQK Fail!!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Path B Tx IQK Fail!!\n");
 		}
 		/* path B RX IQK */
 		for (i = 0; i < retrycount; i++) {
 			pathb_ok = _rtl8723be_phy_path_b_rx_iqk(hw);
 			if (pathb_ok == 0x03) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "Path B Rx IQK Success!!\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Path B Rx IQK Success!!\n");
 				result[t][6] = (rtl_get_bbreg(hw, 0xea4,
 							      MASKDWORD) &
 							      0x3FF0000) >> 16;
@@ -2121,8 +2121,8 @@ static void _rtl8723be_phy_iq_calibrate(struct ieee80211_hw *hw,
 							      0x3FF0000) >> 16;
 				break;
 			}
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Path B Rx IQK Fail!!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Path B Rx IQK Fail!!\n");
 		}
 	}
 
@@ -2150,7 +2150,7 @@ static void _rtl8723be_phy_iq_calibrate(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, 0xe30, MASKDWORD, 0x01008c00);
 		rtl_set_bbreg(hw, 0xe34, MASKDWORD, 0x01008c00);
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "8723be IQK Finish!!\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "8723be IQK Finish!!\n");
 }
 
 static u8 _get_right_chnl_place_for_iqk(u8 chnl)
@@ -2224,14 +2224,14 @@ static void _rtl8723be_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
 	} else {
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 }
 
 static void _rtl8723be_phy_set_rfpath_switch(struct ieee80211_hw *hw,
 					     bool bmain, bool is2t)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 
 	if (bmain) /* left antenna */
 		rtl_set_bbreg(hw, 0x92C, MASKDWORD, 0x1);
@@ -2418,24 +2418,24 @@ bool rtl8723be_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	bool b_postprocessing = false;
 
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
 			b_postprocessing = true;
 			break;
 		case IO_CMD_PAUSE_BAND0_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-				 "[IO CMD] Pause DM before scan.\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Pause DM before scan.\n");
 			b_postprocessing = true;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", iotype);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", iotype);
 			break;
 		}
 	} while (false);
@@ -2446,7 +2446,7 @@ bool rtl8723be_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl8723be_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -2456,9 +2456,9 @@ static void rtl8723be_phy_set_io(struct ieee80211_hw *hw)
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
-		  rtlphy->current_io_type, rtlphy->set_io_inprogress);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"--->Cmd(%#x), set_io_inprogress(%d)\n",
+		rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
 	case IO_CMD_RESUME_DM_BY_SCAN:
 		dm_digtable->cur_igvalue = rtlphy->initgain_backup.xaagccore1;
@@ -2472,14 +2472,14 @@ static void rtl8723be_phy_set_io(struct ieee80211_hw *hw)
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
 
 static void rtl8723be_phy_set_rf_on(struct ieee80211_hw *hw)
@@ -2522,16 +2522,16 @@ static bool _rtl8723be_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			u32 initializecount = 0;
 			do {
 				initializecount++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "IPS Set eRf nic enable\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus && (initializecount < 10));
 			RT_CLEAR_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "Set ERFON sleeped:%d ms\n",
-				  jiffies_to_msecs(jiffies -
-						   ppsc->last_sleep_jiffies));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"Set ERFON slept:%d ms\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies));
 			ppsc->last_awake_jiffies = jiffies;
 			rtl8723be_phy_set_rf_on(hw);
 		}
@@ -2555,27 +2555,27 @@ static bool _rtl8723be_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
-					 "ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
-					  MAX_DOZE_WAITING_TIMES_9x,
-					  queue_id,
-					  skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
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
@@ -2599,34 +2599,34 @@ static bool _rtl8723be_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
-					 "ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
-					 MAX_DOZE_WAITING_TIMES_9x,
-					 queue_id,
-					 skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
+					MAX_DOZE_WAITING_TIMES_9x,
+					queue_id,
+					skb_queue_len(&ring->queue));
 				break;
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "Set ERFSLEEP awaked:%d ms\n",
-			  jiffies_to_msecs(jiffies -
-					   ppsc->last_awake_jiffies));
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"Set ERFSLEEP awaked:%d ms\n",
+			jiffies_to_msecs(jiffies -
+					 ppsc->last_awake_jiffies));
 		ppsc->last_sleep_jiffies = jiffies;
 		_rtl8723be_phy_set_rf_sleep(hw);
 		break;
 
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", rfpwr_state);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", rfpwr_state);
 		bresult = false;
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/rf.c
index af72e489e31c..8a856fb42b8d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/rf.c
@@ -478,12 +478,12 @@ static bool _rtl8723be_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
index b8081e196cdf..9ab0e3061517 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.c
@@ -340,9 +340,9 @@ bool rtl8723be_rx_query_desc(struct ieee80211_hw *hw,
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
 
@@ -445,7 +445,7 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "DMA mapping error\n");
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_8723be));
@@ -459,9 +459,9 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
-					  ptcb_desc->empkt_num);
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Insert 8 byte.pTcb->EMPktNum:%d\n",
+					ptcb_desc->empkt_num);
 				_rtl8723be_insert_emcontent(ptcb_desc,
 							    (__le32 *)(skb->data));
 			}
@@ -551,8 +551,8 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 		/* from being overwritten by retried  packet rate.*/
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Enable RDG function.\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
 			}
@@ -583,7 +583,7 @@ void rtl8723be_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(pdesc, 1);
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
@@ -600,8 +600,8 @@ void rtl8723be_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
 					    PCI_DMA_TODEVICE);
 
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

