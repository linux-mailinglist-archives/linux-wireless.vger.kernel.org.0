Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D26422B803
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGWUnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgGWUm7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64810C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k6so6181369oij.11
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jLY885LUNWrr9seSkcshgs/CjXaNz9TOHG2B/JMKilI=;
        b=qjF2q5OVmOvE1SL9JlHTnCzwnLN1QERbhPm2sUgKlmlceJ8qV6pZckBVEsQigftYZg
         zb9AyQlCJnJwBByKxqvCrDRd7rg9NlRpjQXV6XoIG+1/qCvvQw/cv6mI73yqqGwAmlSx
         EHsV4lux9vIiWyWxdVojb93H4U0trw6hld5cu5okY2Yw3GF8yinSR+g166pzh3jSDAL0
         FEh3SHoc2UAH1eTaNG5dP4ho+Fb/pYFCDV/68dytw9t5BfyU/Av/E41I2kaYZQ2jo07O
         49ECjcW+gjSKG629P5JsV04h7Y+x2zMPaKHHmfs/urqyjiwkUBu/nZ409VdrobPTDuTL
         KSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jLY885LUNWrr9seSkcshgs/CjXaNz9TOHG2B/JMKilI=;
        b=GqMe01Kj5ShVOm1m7ULOMuoSk/kV0g8z9ih9bizMPXhNiRxF7RBDtQV3oJf/lcgV3M
         Ajlt/NOpk+QTL/8FyVDK0Xy3JNmGgEQbKWHAraCzX7CzXiad4fijBGWmrzPV6EDhCe8V
         xUpFXWvVP1PtdZ6izsiD9+3QNMIqdv0RHD4pC/IFttjp9zdtVxnDi5WfdpZCu++yAhWh
         kNjXGATwNKRKQk0YYWwvjf2Jj+j2WygSKtaSUBO+nLDDJJ/oz8jWCOf5Vxt/9aWLP0EB
         DUHjTt7X8R8Hex8zKO9mgYByhUFIA2jp2FsNDgwyWS5gPFLbnNQVD11Wna21+t+pA3Ol
         wTlQ==
X-Gm-Message-State: AOAM533HDHF/XkSKkHd9DVHZKCgnHXFDO3MF1ruiyyL+EFpHf8V+n/vB
        f3F13uzmVW4y1iUmhEFMahs=
X-Google-Smtp-Source: ABdhPJxOlqKGCaxpJh50JjfSdmmqhPom3n+rTW6mJ4nPfzyOIb9lDoeWsnWDO8So8Cto6+bWbUAJmA==
X-Received: by 2002:aca:4b88:: with SMTP id y130mr5393111oia.36.1595536977810;
        Thu, 23 Jul 2020 13:42:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:57 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 11/15] rtlwifi: rtl8723ae Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:40 -0500
Message-Id: <20200723204244.24457-12-Larry.Finger@lwfinger.net>
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
rtl8723ae. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8723ae/dm.c   | 162 ++---
 .../wireless/realtek/rtlwifi/rtl8723ae/fw.c   |  64 +-
 .../rtlwifi/rtl8723ae/hal_bt_coexist.c        | 150 ++--
 .../realtek/rtlwifi/rtl8723ae/hal_btc.c       | 649 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 232 +++----
 .../wireless/realtek/rtlwifi/rtl8723ae/led.c  |  12 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/phy.c  | 357 +++++-----
 .../wireless/realtek/rtlwifi/rtl8723ae/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  |  14 +-
 9 files changed, 823 insertions(+), 823 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
index c61a92df9d73..8ada31380efa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
@@ -82,16 +82,16 @@ static void rtl8723e_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 0);
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
 
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
 
 static void rtl92c_dm_ctrl_initgain_by_fa(struct ieee80211_hw *hw)
@@ -150,9 +150,9 @@ static void rtl92c_dm_ctrl_initgain_by_rssi(struct ieee80211_hw *hw)
 		dm_digtable->cur_igvalue = dm_digtable->rssi_val_min + 10 -
 		    dm_digtable->back_val;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "rssi_val_min = %x back_val %x\n",
-		  dm_digtable->rssi_val_min, dm_digtable->back_val);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"rssi_val_min = %x back_val %x\n",
+		dm_digtable->rssi_val_min, dm_digtable->back_val);
 
 	rtl8723e_dm_write_dig(hw);
 }
@@ -201,10 +201,10 @@ static void rtl8723e_dm_initial_gain_multi_sta(struct ieee80211_hw *hw)
 		rtl8723e_dm_write_dig(hw);
 	}
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "curmultista_cstate = %x dig_ext_port_stage %x\n",
-		 dm_digtable->curmultista_cstate,
-		 dm_digtable->dig_ext_port_stage);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"curmultista_cstate = %x dig_ext_port_stage %x\n",
+		dm_digtable->curmultista_cstate,
+		dm_digtable->dig_ext_port_stage);
 }
 
 static void rtl8723e_dm_initial_gain_sta(struct ieee80211_hw *hw)
@@ -212,10 +212,10 @@ static void rtl8723e_dm_initial_gain_sta(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "presta_cstate = %x, cursta_cstate = %x\n",
-		  dm_digtable->presta_cstate,
-		  dm_digtable->cursta_cstate);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"presta_cstate = %x, cursta_cstate = %x\n",
+		dm_digtable->presta_cstate,
+		dm_digtable->cursta_cstate);
 
 	if (dm_digtable->presta_cstate == dm_digtable->cursta_cstate ||
 	    dm_digtable->cursta_cstate == DIG_STA_BEFORE_CONNECT ||
@@ -296,8 +296,8 @@ static void rtl8723e_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 		dm_digtable->pre_cck_pd_state = dm_digtable->cur_cck_pd_state;
 	}
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "CCKPDStage=%x\n", dm_digtable->cur_cck_pd_state);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"CCKPDStage=%x\n", dm_digtable->cur_cck_pd_state);
 
 }
 
@@ -354,8 +354,8 @@ static void rtl8723e_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 
@@ -367,47 +367,47 @@ static void rtl8723e_dm_dynamic_txpower(struct ieee80211_hw *hw)
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
-			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
 	} else if ((undec_sm_pwdb <
 		    (TX_POWER_NEAR_FIELD_THRESH_LVL2 - 3)) &&
 		   (undec_sm_pwdb >=
 		    TX_POWER_NEAR_FIELD_THRESH_LVL1)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
 	} else if (undec_sm_pwdb <
 		   (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_NORMAL\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_NORMAL\n");
 	}
 
 	if (rtlpriv->dm.dynamic_txhighpower_lvl != rtlpriv->dm.last_dtp_lvl) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
-			  rtlphy->current_channel);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"PHY_SetTxPowerLevel8192S() Channel = %d\n",
+			rtlphy->current_channel);
 		rtl8723e_phy_set_txpower_level(hw, rtlphy->current_channel);
 	}
 
@@ -419,10 +419,10 @@ void rtl8723e_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
-		  dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
-		  dm_digtable->back_val);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
+		dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
+		dm_digtable->back_val);
 
 	if (dm_digtable->pre_igvalue != dm_digtable->cur_igvalue) {
 		rtl_set_bbreg(hw, ROFDM0_XAAGCCORE1, 0x7f,
@@ -521,9 +521,9 @@ static void rtl8723e_dm_initialize_txpower_tracking_thermalmeter(
 	rtlpriv->dm.txpower_tracking = true;
 	rtlpriv->dm.txpower_trackinginit = false;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "pMgntInfo->txpower_tracking = %d\n",
-		  rtlpriv->dm.txpower_tracking);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"pMgntInfo->txpower_tracking = %d\n",
+		rtlpriv->dm.txpower_tracking);
 }
 
 static void rtl8723e_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
@@ -561,14 +561,14 @@ static void rtl8723e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 	struct ieee80211_sta *sta = NULL;
 
 	if (is_hal_stop(rtlhal)) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-			 " driver is going to unload\n");
+		rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+			" driver is going to unload\n");
 		return;
 	}
 
 	if (!rtlpriv->dm.useramask) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-			 " driver does not control rate adaptive mask\n");
+		rtl_dbg(rtlpriv, COMP_RATE, DBG_LOUD,
+			" driver does not control rate adaptive mask\n");
 		return;
 	}
 
@@ -612,14 +612,14 @@ static void rtl8723e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 			p_ra->ratr_state = DM_RATR_STA_LOW;
 
 		if (p_ra->pre_ratr_state != p_ra->ratr_state) {
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI = %ld\n",
-				 rtlpriv->dm.undec_sm_pwdb);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "RSSI_LEVEL = %d\n", p_ra->ratr_state);
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
-				 "PreState = %d, CurState = %d\n",
-				 p_ra->pre_ratr_state, p_ra->ratr_state);
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
@@ -716,31 +716,31 @@ static void rtl8723e_dm_dynamic_bb_powersaving(struct ieee80211_hw *hw)
 	if (((mac->link_state == MAC80211_NOLINK)) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
 		dm_pstable->rssi_val_min = 0;
-		RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+			"Not connected to any\n");
 	}
 
 	if (mac->link_state == MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			dm_pstable->rssi_val_min =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-				  dm_pstable->rssi_val_min);
+			rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				dm_pstable->rssi_val_min);
 		} else {
 			dm_pstable->rssi_val_min =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%lx\n",
-				  dm_pstable->rssi_val_min);
+			rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+				"STA Default Port PWDB = 0x%lx\n",
+				dm_pstable->rssi_val_min);
 		}
 	} else {
 		dm_pstable->rssi_val_min =
 		    rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-			 "AP Ext Port PWDB = 0x%lx\n",
-			  dm_pstable->rssi_val_min);
+		rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+			"AP Ext Port PWDB = 0x%lx\n",
+			dm_pstable->rssi_val_min);
 	}
 
 	rtl8723e_dm_rf_saving(hw, false);
@@ -820,21 +820,21 @@ void rtl8723e_dm_bt_coexist(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 tmp_byte = 0;
 	if (!rtlpriv->btcoexist.bt_coexistence) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-			 "[DM]{BT], BT not exist!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			"[DM]{BT], BT not exist!!\n");
 		return;
 	}
 
 	if (!rtlpriv->btcoexist.init_set) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-			 "[DM][BT], rtl8723e_dm_bt_coexist()\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+			"[DM][BT], %s\n", __func__);
 		rtl8723e_dm_init_bt_coexist(hw);
 	}
 
 	tmp_byte = rtl_read_byte(rtlpriv, 0x40);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-		 "[DM][BT], 0x40 is 0x%x\n", tmp_byte);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[DM][BT], bt_dm_coexist start\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		"[DM][BT], 0x40 is 0x%x\n", tmp_byte);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[DM][BT], bt_dm_coexist start\n");
 	rtl8723e_dm_bt_coexist_8723(hw);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c
index 33481232fad0..d1b50a80c191 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c
@@ -43,22 +43,22 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
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
-					  h2c_waitcounter);
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Wait 100 us (%d times)...\n",
+					h2c_waitcounter);
 				udelay(100);
 
 				if (h2c_waitcounter > 1000)
@@ -110,9 +110,9 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 
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
 
@@ -121,24 +121,24 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 			isfw_read = _rtl8723e_check_fw_read_last_h2c(hw,
 								boxnum);
 			u1b_tmp = rtl_read_byte(rtlpriv, 0x1BF);
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
-				 boxnum, u1b_tmp);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
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
@@ -217,16 +217,16 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
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
 
 void rtl8723e_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -252,7 +252,7 @@ void rtl8723e_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	u8 u1_h2c_set_pwrmode[3] = { 0 };
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
 
 	SET_H2CCMD_PWRMODE_PARM_MODE(u1_h2c_set_pwrmode, mode);
 	SET_H2CCMD_PWRMODE_PARM_SMART_PS(u1_h2c_set_pwrmode,
@@ -458,16 +458,16 @@ void rtl8723e_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Set RSVD page location to Fw.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 			      "H2C_RSVDPAGE:\n",
 			      u1rsvdpageloc, 3);
 		rtl8723e_fill_h2c_cmd(hw, H2C_RSVDPAGE,
 				      sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 
 void rtl8723e_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus)
@@ -501,11 +501,11 @@ void rtl8723e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
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
@@ -564,11 +564,11 @@ void rtl8723e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c
index 3ac31ec26517..6c4fedc3ed63 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c
@@ -102,12 +102,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					BT_COEX_STATE_WIFI_RSSI_1_HIGH;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state switch to High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state switch to High\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state stay at Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state stay at Low\n");
 			}
 		} else {
 			if (undecoratedsmoothed_pwdb < rssi_thresh) {
@@ -116,18 +116,18 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					BT_COEX_STATE_WIFI_RSSI_1_LOW;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state switch to Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state stay at High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "[DM][BT], RSSI_1 thresh error!!\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[DM][BT], RSSI_1 thresh error!!\n");
 			return rtlpriv->btcoexist.bt_pre_rssi_state;
 		}
 
@@ -144,12 +144,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state switch to Medium\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state stay at Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state stay at Low\n");
 			}
 		} else if ((rtlpriv->btcoexist.bt_pre_rssi_state ==
 			    BT_RSSI_STATE_MEDIUM) ||
@@ -164,8 +164,8 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state switch to High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state switch to High\n");
 			} else if (undecoratedsmoothed_pwdb < rssi_thresh) {
 				bt_rssi_state = BT_RSSI_STATE_LOW;
 				rtlpriv->btcoexist.cstate |=
@@ -174,12 +174,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state switch to Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state stay at Medium\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state stay at Medium\n");
 			}
 		} else {
 			if (undecoratedsmoothed_pwdb < rssi_thresh1) {
@@ -190,12 +190,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state switch to Medium\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI_1 state stay at High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI_1 state stay at High\n");
 			}
 		}
 	}
@@ -230,12 +230,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					|= BT_COEX_STATE_WIFI_RSSI_HIGH;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state switch to High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state switch to High\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state stay at Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state stay at Low\n");
 			}
 		} else {
 			if (undecoratedsmoothed_pwdb < rssi_thresh) {
@@ -244,18 +244,18 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					|= BT_COEX_STATE_WIFI_RSSI_LOW;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state switch to Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state stay at High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "[DM][BT], RSSI thresh error!!\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[DM][BT], RSSI thresh error!!\n");
 			return rtlpriv->btcoexist.bt_pre_rssi_state;
 		}
 		if ((rtlpriv->btcoexist.bt_pre_rssi_state ==
@@ -271,12 +271,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state switch to Medium\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state stay at Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state stay at Low\n");
 			}
 		} else if ((rtlpriv->btcoexist.bt_pre_rssi_state ==
 				BT_RSSI_STATE_MEDIUM) ||
@@ -291,8 +291,8 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state switch to High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state switch to High\n");
 			} else if (undecoratedsmoothed_pwdb < rssi_thresh) {
 				bt_rssi_state = BT_RSSI_STATE_LOW;
 				rtlpriv->btcoexist.cstate
@@ -301,12 +301,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state switch to Low\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state stay at Medium\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state stay at Medium\n");
 			}
 		} else {
 			if (undecoratedsmoothed_pwdb < rssi_thresh1) {
@@ -317,12 +317,12 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state switch to Medium\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-					 "[DM][BT], RSSI state stay at High\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+					"[DM][BT], RSSI state stay at High\n");
 			}
 		}
 	}
@@ -342,9 +342,9 @@ long rtl8723e_dm_bt_get_rx_ss(struct ieee80211_hw *hw)
 		undecoratedsmoothed_pwdb
 			= rtlpriv->dm.entry_min_undec_sm_pwdb;
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_get_rx_ss() = %ld\n",
-		 undecoratedsmoothed_pwdb);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"%s = %ld\n", __func__,
+		undecoratedsmoothed_pwdb);
 
 	return undecoratedsmoothed_pwdb;
 }
@@ -367,10 +367,10 @@ void rtl8723e_dm_bt_balance(struct ieee80211_hw *hw,
 	}
 	rtlpriv->btcoexist.balance_on = balance_on;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "[DM][BT], Balance=[%s:%dms:%dms], write 0xc=0x%x\n",
-		 balance_on ? "ON" : "OFF", ms0, ms1, h2c_parameter[0]<<16 |
-		 h2c_parameter[1]<<8 | h2c_parameter[2]);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"[DM][BT], Balance=[%s:%dms:%dms], write 0xc=0x%x\n",
+		balance_on ? "ON" : "OFF", ms0, ms1, h2c_parameter[0] << 16 |
+		h2c_parameter[1] << 8 | h2c_parameter[2]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0xc, 3, h2c_parameter);
 }
@@ -381,8 +381,8 @@ void rtl8723e_dm_bt_agc_table(struct ieee80211_hw *hw, u8 type)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (type == BT_AGCTABLE_OFF) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BT]AGCTable Off!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BT]AGCTable Off!\n");
 		rtl_write_dword(rtlpriv, 0xc78, 0x641c0001);
 		rtl_write_dword(rtlpriv, 0xc78, 0x631d0001);
 		rtl_write_dword(rtlpriv, 0xc78, 0x621e0001);
@@ -400,8 +400,8 @@ void rtl8723e_dm_bt_agc_table(struct ieee80211_hw *hw, u8 type)
 		rtl8723e_phy_set_rf_reg(hw, RF90_PATH_A,
 					RF_RX_G1, 0xfffff, 0x30355);
 	} else if (type == BT_AGCTABLE_ON) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BT]AGCTable On!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BT]AGCTable On!\n");
 		rtl_write_dword(rtlpriv, 0xc78, 0x4e1c0001);
 		rtl_write_dword(rtlpriv, 0xc78, 0x4d1d0001);
 		rtl_write_dword(rtlpriv, 0xc78, 0x4c1e0001);
@@ -428,12 +428,12 @@ void rtl8723e_dm_bt_bb_back_off_level(struct ieee80211_hw *hw, u8 type)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (type == BT_BB_BACKOFF_OFF) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BT]BBBackOffLevel Off!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BT]BBBackOffLevel Off!\n");
 		rtl_write_dword(rtlpriv, 0xc04, 0x3a05611);
 	} else if (type == BT_BB_BACKOFF_ON) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BT]BBBackOffLevel On!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BT]BBBackOffLevel On!\n");
 		rtl_write_dword(rtlpriv, 0xc04, 0x3a07611);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	}
@@ -442,14 +442,14 @@ void rtl8723e_dm_bt_bb_back_off_level(struct ieee80211_hw *hw, u8 type)
 void rtl8723e_dm_bt_fw_coex_all_off(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_fw_coex_all_off()\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"rtl8723e_dm_bt_fw_coex_all_off()\n");
 
 	if (rtlpriv->btcoexist.fw_coexist_all_off)
 		return;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_fw_coex_all_off(), real Do\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"rtl8723e_dm_bt_fw_coex_all_off(), real Do\n");
 	rtl8723e_dm_bt_fw_coex_all_off_8723a(hw);
 	rtlpriv->btcoexist.fw_coexist_all_off = true;
 }
@@ -458,14 +458,14 @@ void rtl8723e_dm_bt_sw_coex_all_off(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_sw_coex_all_off()\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"%s\n", __func__);
 
 	if (rtlpriv->btcoexist.sw_coexist_all_off)
 		return;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_sw_coex_all_off(), real Do\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"%s, real Do\n", __func__);
 	rtl8723e_dm_bt_sw_coex_all_off_8723a(hw);
 	rtlpriv->btcoexist.sw_coexist_all_off = true;
 }
@@ -474,13 +474,13 @@ void rtl8723e_dm_bt_hw_coex_all_off(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_hw_coex_all_off()\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"%s\n", __func__);
 
 	if (rtlpriv->btcoexist.hw_coexist_all_off)
 		return;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "rtl8723e_dm_bt_hw_coex_all_off(), real Do\n");
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"%s, real Do\n", __func__);
 
 	rtl8723e_dm_bt_hw_coex_all_off_8723a(hw);
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
index 652d8ff9cccb..16c6007861ff 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
@@ -20,7 +20,7 @@ void rtl8723e_dm_bt_turn_off_bt_coexist_before_enter_lps(struct ieee80211_hw *hw
 		return;
 
 	if (ppsc->inactiveps) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BT][DM], Before enter IPS, turn off all Coexist DM\n");
 		rtlpriv->btcoexist.cstate = 0;
 		rtlpriv->btcoexist.previous_state = 0;
@@ -68,9 +68,10 @@ void rtl_8723e_bt_wifi_media_status_notify(struct ieee80211_hw *hw,
 	else
 		h2c_parameter[2] = 0x20;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[BTCoex], FW write 0x19=0x%x\n",
-		 h2c_parameter[0]<<16|h2c_parameter[1]<<8|h2c_parameter[2]);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], FW write 0x19=0x%x\n",
+		h2c_parameter[0] << 16 | h2c_parameter[1] << 8 |
+		h2c_parameter[2]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x19, 3, h2c_parameter);
 }
@@ -98,7 +99,7 @@ static void rtl8723e_dm_bt_set_fw_3a(struct ieee80211_hw *hw,
 	h2c_parameter[2] = byte3;
 	h2c_parameter[3] = byte4;
 	h2c_parameter[4] = byte5;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], FW write 0x3a(4bytes)=0x%x%8x\n",
 		h2c_parameter[0], h2c_parameter[1]<<24 |
 		h2c_parameter[2]<<16 | h2c_parameter[3]<<8 |
@@ -111,7 +112,7 @@ static bool rtl8723e_dm_bt_need_to_dec_bt_pwr(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (mgnt_link_status_query(hw) == RT_MEDIA_CONNECT) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"Need to decrease bt power\n");
 		rtlpriv->btcoexist.cstate |=
 		BT_COEX_STATE_DEC_BT_POWER;
@@ -130,12 +131,12 @@ static bool rtl8723e_dm_bt_is_same_coexist_state(struct ieee80211_hw *hw)
 	     rtlpriv->btcoexist.cstate) &&
 	    (rtlpriv->btcoexist.previous_state_h ==
 	     rtlpriv->btcoexist.cstate_h)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[DM][BT], Coexist state do not change!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[DM][BT], Coexist state do not change!!\n");
 		return true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[DM][BT], Coexist state changed!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[DM][BT], Coexist state changed!!\n");
 		return false;
 	}
 }
@@ -146,16 +147,16 @@ static void rtl8723e_dm_bt_set_coex_table(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "set coex table, set 0x6c0=0x%x\n", val_0x6c0);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"set coex table, set 0x6c0=0x%x\n", val_0x6c0);
 	rtl_write_dword(rtlpriv, 0x6c0, val_0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "set coex table, set 0x6c8=0x%x\n", val_0x6c8);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"set coex table, set 0x6c8=0x%x\n", val_0x6c8);
 	rtl_write_dword(rtlpriv, 0x6c8, val_0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "set coex table, set 0x6cc=0x%x\n", val_0x6cc);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"set coex table, set 0x6cc=0x%x\n", val_0x6cc);
 	rtl_write_byte(rtlpriv, 0x6cc, val_0x6cc);
 }
 
@@ -164,12 +165,12 @@ static void rtl8723e_dm_bt_set_hw_pta_mode(struct ieee80211_hw *hw, bool b_mode)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (BT_PTA_MODE_ON == b_mode) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode on\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode on\n");
 		/*  Enable GPIO 0/1/2/3/8 pins for bt */
 		rtl_write_byte(rtlpriv, 0x40, 0x20);
 		rtlpriv->btcoexist.hw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode off\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode off\n");
 		rtl_write_byte(rtlpriv, 0x40, 0x0);
 	}
 }
@@ -181,15 +182,15 @@ static void rtl8723e_dm_bt_set_sw_rf_rx_lpf_corner(struct ieee80211_hw *hw,
 
 	if (BT_RF_RX_LPF_CORNER_SHRINK == type) {
 		/* Shrink RF Rx LPF corner, 0x1e[7:4]=1111 ==> [11:4] */
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "Shrink RF Rx LPF corner!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"Shrink RF Rx LPF corner!!\n");
 		rtl8723e_phy_set_rf_reg(hw, RF90_PATH_A, 0x1e,
 					0xfffff, 0xf0ff7);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	} else if (BT_RF_RX_LPF_CORNER_RESUME == type) {
 		/*Resume RF Rx LPF corner*/
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "Resume RF Rx LPF corner!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"Resume RF Rx LPF corner!!\n");
 		rtl8723e_phy_set_rf_reg(hw, RF90_PATH_A, 0x1e, 0xfffff,
 					rtlpriv->btcoexist.bt_rfreg_origin_1e);
 	}
@@ -204,12 +205,12 @@ static void dm_bt_set_sw_penalty_tx_rate_adapt(struct ieee80211_hw *hw,
 	tmp_u1 = rtl_read_byte(rtlpriv, 0x4fd);
 	tmp_u1 |= BIT(0);
 	if (BT_TX_RATE_ADAPTIVE_LOW_PENALTY == ra_type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"Tx rate adaptive, set low penalty!!\n");
 		tmp_u1 &= ~BIT(2);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	} else if (BT_TX_RATE_ADAPTIVE_NORMAL == ra_type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"Tx rate adaptive, set normal!!\n");
 		tmp_u1 |= BIT(2);
 	}
@@ -279,14 +280,14 @@ static bool rtl8723e_dm_bt_is_2_ant_common_action(struct ieee80211_hw *hw)
 
 	if (!rtl8723e_dm_bt_is_wifi_busy(hw) &&
 	    !rtlpriv->btcoexist.bt_busy) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "Wifi idle + Bt idle, bt coex mechanism always off!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"Wifi idle + Bt idle, bt coex mechanism always off!!\n");
 		rtl8723e_dm_bt_btdm_structure_reload_all_off(hw, &btdm8723);
 		b_common = true;
 	} else if (rtl8723e_dm_bt_is_wifi_busy(hw) &&
 		   !rtlpriv->btcoexist.bt_busy) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "Wifi non-idle + Bt disabled/idle!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"Wifi non-idle + Bt disabled/idle!!\n");
 		btdm8723.low_penalty_rate_adaptive = true;
 		btdm8723.rf_rx_lpf_shrink = false;
 		btdm8723.reject_aggre_pkt = false;
@@ -307,14 +308,14 @@ static bool rtl8723e_dm_bt_is_2_ant_common_action(struct ieee80211_hw *hw)
 
 		b_common = true;
 	} else if (rtlpriv->btcoexist.bt_busy) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"Bt non-idle!\n");
 		if (mgnt_link_status_query(hw) == RT_MEDIA_CONNECT) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"Wifi connection exist\n");
 			b_common = false;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"No Wifi connection!\n");
 			btdm8723.rf_rx_lpf_shrink = true;
 			btdm8723.low_penalty_rate_adaptive = false;
@@ -359,14 +360,14 @@ static void rtl8723e_dm_bt_set_sw_full_time_dac_swing(
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (sw_dac_swing_on) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], SwDacSwing = 0x%x\n", sw_dac_swing_lvl);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], SwDacSwing = 0x%x\n", sw_dac_swing_lvl);
 		rtl8723_phy_set_bb_reg(hw, 0x880, 0xff000000,
 				       sw_dac_swing_lvl);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], SwDacSwing Off!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], SwDacSwing Off!\n");
 		rtl8723_phy_set_bb_reg(hw, 0x880, 0xff000000, 0xc0);
 	}
 }
@@ -384,9 +385,9 @@ static void rtl8723e_dm_bt_set_fw_dec_bt_pwr(
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "[BTCoex], decrease Bt Power : %s, write 0x21=0x%x\n",
-		 (dec_bt_pwr ? "Yes!!" : "No!!"), h2c_parameter[0]);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"[BTCoex], decrease Bt Power : %s, write 0x21=0x%x\n",
+		(dec_bt_pwr ? "Yes!!" : "No!!"), h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x21, 1, h2c_parameter);
 }
@@ -404,10 +405,10 @@ static void rtl8723e_dm_bt_set_fw_2_ant_hid(struct ieee80211_hw *hw,
 	if (b_dac_swing_on)
 		h2c_parameter[0] |= BIT(1); /* Dac Swing default enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "[BTCoex], turn 2-Ant+HID mode %s, DACSwing:%s, write 0x15=0x%x\n",
-		 (b_enable ? "ON!!" : "OFF!!"), (b_dac_swing_on ? "ON" : "OFF"),
-		 h2c_parameter[0]);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"[BTCoex], turn 2-Ant+HID mode %s, DACSwing:%s, write 0x15=0x%x\n",
+		(b_enable ? "ON!!" : "OFF!!"), (b_dac_swing_on ? "ON" : "OFF"),
+		h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x15, 1, h2c_parameter);
 }
@@ -424,56 +425,56 @@ static void rtl8723e_dm_bt_set_fw_tdma_ctrl(struct ieee80211_hw *hw,
 	h2c_parameter1[0] = 0;
 
 	if (b_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], set BT PTA update manager to trigger update!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], set BT PTA update manager to trigger update!!\n");
 		h2c_parameter1[0] |= BIT(0);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], turn TDMA mode ON!!\n");
 		h2c_parameter[0] |= BIT(0);		/* function enable */
 		if (TDMA_1ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TDMA_1ANT\n");
-			h2c_parameter[0] |= BIT(1);
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TDMA_1ANT\n");
+				h2c_parameter[0] |= BIT(1);
 		} else if (TDMA_2ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TDMA_2ANT\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TDMA_2ANT\n");
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], Unknown Ant\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], Unknown Ant\n");
 		}
 
 		if (TDMA_NAV_OFF == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TDMA_NAV_OFF\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TDMA_NAV_OFF\n");
 		} else if (TDMA_NAV_ON == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TDMA_NAV_ON\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TDMA_NAV_ON\n");
 			h2c_parameter[0] |= BIT(2);
 		}
 
 		if (TDMA_DAC_SWING_OFF == dac_swing_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex], TDMA_DAC_SWING_OFF\n");
 		} else if (TDMA_DAC_SWING_ON == dac_swing_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex], TDMA_DAC_SWING_ON\n");
 			h2c_parameter[0] |= BIT(4);
 		}
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], set BT PTA update manager to no update!!\n");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], turn TDMA mode OFF!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], set BT PTA update manager to no update!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], turn TDMA mode OFF!!\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "[BTCoex], FW2AntTDMA, write 0x26=0x%x\n",
-		 h2c_parameter1[0]);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"[BTCoex], FW2AntTDMA, write 0x26=0x%x\n",
+		h2c_parameter1[0]);
 	rtl8723e_fill_h2c_cmd(hw, 0x26, 1, h2c_parameter1);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], FW2AntTDMA, write 0x14=0x%x\n",
 		h2c_parameter[0]);
 	rtl8723e_fill_h2c_cmd(hw, 0x14, 1, h2c_parameter);
@@ -486,18 +487,18 @@ static void rtl8723e_dm_bt_set_fw_ignore_wlan_act(struct ieee80211_hw *hw,
 	u8 h2c_parameter[1] = {0};
 
 	if (b_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], BT Ignore Wlan_Act !!\n");
 		h2c_parameter[0] |= BIT(0);		/* function enable */
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], BT don't ignore Wlan_Act !!\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "[BTCoex], set FW for BT Ignore Wlan_Act, write 0x25=0x%x\n",
-		 h2c_parameter[0]);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"[BTCoex], set FW for BT Ignore Wlan_Act, write 0x25=0x%x\n",
+		h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x25, 1, h2c_parameter);
 }
@@ -513,43 +514,43 @@ static void rtl8723e_dm_bt_set_fw_tra_tdma_ctrl(struct ieee80211_hw *hw,
 
 	/* Only 8723 B cut should do this */
 	if (IS_VENDOR_8723_A_CUT(rtlhal->version)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], not 8723B cut, don't set Traditional TDMA!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], not 8723B cut, don't set Traditional TDMA!!\n");
 		return;
 	}
 
 	if (b_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "[BTCoex], turn TTDMA mode ON!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex], turn TTDMA mode ON!!\n");
 		h2c_parameter[0] |= BIT(0);	/* function enable */
 		if (TDMA_1ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "[BTCoex], TTDMA_1ANT\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TTDMA_1ANT\n");
 			h2c_parameter[0] |= BIT(1);
 		} else if (TDMA_2ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TTDMA_2ANT\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TTDMA_2ANT\n");
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], Unknown Ant\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], Unknown Ant\n");
 		}
 
 		if (TDMA_NAV_OFF == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TTDMA_NAV_OFF\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TTDMA_NAV_OFF\n");
 		} else if (TDMA_NAV_ON == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			"[BTCoex], TTDMA_NAV_ON\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"[BTCoex], TTDMA_NAV_ON\n");
 			h2c_parameter[1] |= BIT(0);
 		}
 
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], turn TTDMA mode OFF!!\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], FW Traditional TDMA, write 0x33=0x%x\n",
 		h2c_parameter[0] << 8 | h2c_parameter[1]);
 
@@ -563,9 +564,9 @@ static void rtl8723e_dm_bt_set_fw_dac_swing_level(struct ieee80211_hw *hw,
 	u8 h2c_parameter[1] = {0};
 	h2c_parameter[0] = dac_swing_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set Dac Swing Level=0x%x\n", dac_swing_lvl);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x29=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x29, 1, h2c_parameter);
@@ -582,9 +583,9 @@ static void rtl8723e_dm_bt_set_fw_bt_hid_info(struct ieee80211_hw *hw,
 		h2c_parameter[0] |= BIT(0);
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set BT HID information=0x%x\n", b_enable);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x24=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x24, 1, h2c_parameter);
@@ -597,9 +598,9 @@ static void rtl8723e_dm_bt_set_fw_bt_retry_index(struct ieee80211_hw *hw,
 	u8 h2c_parameter[1] = {0};
 	h2c_parameter[0] = retry_index;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set BT Retry Index=%d\n", retry_index);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x23=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x23, 1, h2c_parameter);
@@ -614,12 +615,12 @@ static void rtl8723e_dm_bt_set_fw_wlan_act(struct ieee80211_hw *hw,
 	h2c_parameter_hi[0] = wlan_act_hi;
 	h2c_parameter_lo[0] = wlan_act_lo;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set WLAN_ACT Hi:Lo=0x%x/0x%x\n",
 		wlan_act_hi, wlan_act_lo);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x22=0x%x\n", h2c_parameter_hi[0]);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x11=0x%x\n", h2c_parameter_lo[0]);
 
 	/* WLAN_ACT = High duration, unit:ms */
@@ -646,107 +647,107 @@ void rtl8723e_dm_bt_set_bt_dm(struct ieee80211_hw *hw,
 	/* check new setting is different with the old one, */
 	/* if all the same, don't do the setting again. */
 	if (memcmp(btdm_8723, btdm, sizeof(struct btdm_8723)) == 0) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], the same coexist setting, return!!\n");
 		return;
 	} else {	/* save the new coexist setting */
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], UPDATE TO NEW COEX SETTING!!\n");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new bAllOff=0x%x/ 0x%x\n",
 			btdm_8723->all_off, btdm->all_off);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new agc_table_en=0x%x/ 0x%x\n",
 			btdm_8723->agc_table_en, btdm->agc_table_en);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new adc_back_off_on=0x%x/ 0x%x\n",
-			 btdm_8723->adc_back_off_on,
-			 btdm->adc_back_off_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new b2_ant_hid_en=0x%x/ 0x%x\n",
-			 btdm_8723->b2_ant_hid_en, btdm->b2_ant_hid_en);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new bLowPenaltyRateAdaptive=0x%x/ 0x%x\n",
-			 btdm_8723->low_penalty_rate_adaptive,
-			 btdm->low_penalty_rate_adaptive);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new bRfRxLpfShrink=0x%x/ 0x%x\n",
-			 btdm_8723->rf_rx_lpf_shrink,
-			 btdm->rf_rx_lpf_shrink);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new bRejectAggrePkt=0x%x/ 0x%x\n",
-			 btdm_8723->reject_aggre_pkt,
-			 btdm->reject_aggre_pkt);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new tdma_on=0x%x/ 0x%x\n",
-			 btdm_8723->tdma_on, btdm->tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new tdmaAnt=0x%x/ 0x%x\n",
-			 btdm_8723->tdma_ant, btdm->tdma_ant);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new tdmaNav=0x%x/ 0x%x\n",
-			 btdm_8723->tdma_nav, btdm->tdma_nav);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new tdma_dac_swing=0x%x/ 0x%x\n",
-			 btdm_8723->tdma_dac_swing, btdm->tdma_dac_swing);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new fw_dac_swing_lvl=0x%x/ 0x%x\n",
-			 btdm_8723->fw_dac_swing_lvl,
-			 btdm->fw_dac_swing_lvl);
-
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new bTraTdmaOn=0x%x/ 0x%x\n",
-			 btdm_8723->tra_tdma_on, btdm->tra_tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new traTdmaAnt=0x%x/ 0x%x\n",
-			 btdm_8723->tra_tdma_ant, btdm->tra_tdma_ant);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new traTdmaNav=0x%x/ 0x%x\n",
-			 btdm_8723->tra_tdma_nav, btdm->tra_tdma_nav);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new bPsTdmaOn=0x%x/ 0x%x\n",
-			 btdm_8723->ps_tdma_on, btdm->ps_tdma_on);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new adc_back_off_on=0x%x/ 0x%x\n",
+			btdm_8723->adc_back_off_on,
+			btdm->adc_back_off_on);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new b2_ant_hid_en=0x%x/ 0x%x\n",
+			btdm_8723->b2_ant_hid_en, btdm->b2_ant_hid_en);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new bLowPenaltyRateAdaptive=0x%x/ 0x%x\n",
+			btdm_8723->low_penalty_rate_adaptive,
+			btdm->low_penalty_rate_adaptive);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new bRfRxLpfShrink=0x%x/ 0x%x\n",
+			btdm_8723->rf_rx_lpf_shrink,
+			btdm->rf_rx_lpf_shrink);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new bRejectAggrePkt=0x%x/ 0x%x\n",
+			btdm_8723->reject_aggre_pkt,
+			btdm->reject_aggre_pkt);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new tdma_on=0x%x/ 0x%x\n",
+			btdm_8723->tdma_on, btdm->tdma_on);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new tdmaAnt=0x%x/ 0x%x\n",
+			btdm_8723->tdma_ant, btdm->tdma_ant);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new tdmaNav=0x%x/ 0x%x\n",
+			btdm_8723->tdma_nav, btdm->tdma_nav);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new tdma_dac_swing=0x%x/ 0x%x\n",
+			btdm_8723->tdma_dac_swing, btdm->tdma_dac_swing);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new fw_dac_swing_lvl=0x%x/ 0x%x\n",
+			btdm_8723->fw_dac_swing_lvl,
+			btdm->fw_dac_swing_lvl);
+
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new bTraTdmaOn=0x%x/ 0x%x\n",
+			btdm_8723->tra_tdma_on, btdm->tra_tdma_on);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new traTdmaAnt=0x%x/ 0x%x\n",
+			btdm_8723->tra_tdma_ant, btdm->tra_tdma_ant);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new traTdmaNav=0x%x/ 0x%x\n",
+			btdm_8723->tra_tdma_nav, btdm->tra_tdma_nav);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new bPsTdmaOn=0x%x/ 0x%x\n",
+			btdm_8723->ps_tdma_on, btdm->ps_tdma_on);
 		for (i = 0; i < 5; i++) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "[BTCoex], original/new psTdmaByte[i]=0x%x/ 0x%x\n",
-				 btdm_8723->ps_tdma_byte[i],
-				 btdm->ps_tdma_byte[i]);
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"[BTCoex], original/new psTdmaByte[i]=0x%x/ 0x%x\n",
+				btdm_8723->ps_tdma_byte[i],
+				btdm->ps_tdma_byte[i]);
 		}
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new bIgnoreWlanAct=0x%x/ 0x%x\n",
 			btdm_8723->ignore_wlan_act,
 			btdm->ignore_wlan_act);
 
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new bPtaOn=0x%x/ 0x%x\n",
 			btdm_8723->pta_on, btdm->pta_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new val_0x6c0=0x%x/ 0x%x\n",
 			btdm_8723->val_0x6c0, btdm->val_0x6c0);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new val_0x6c8=0x%x/ 0x%x\n",
 			btdm_8723->val_0x6c8, btdm->val_0x6c8);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new val_0x6cc=0x%x/ 0x%x\n",
 			btdm_8723->val_0x6cc, btdm->val_0x6cc);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new sw_dac_swing_on=0x%x/ 0x%x\n",
-			 btdm_8723->sw_dac_swing_on,
-			 btdm->sw_dac_swing_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new sw_dac_swing_lvl=0x%x/ 0x%x\n",
-			 btdm_8723->sw_dac_swing_lvl,
-			 btdm->sw_dac_swing_lvl);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new wlanActHi=0x%x/ 0x%x\n",
-			 btdm_8723->wlan_act_hi, btdm->wlan_act_hi);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new wlanActLo=0x%x/ 0x%x\n",
-			 btdm_8723->wlan_act_lo, btdm->wlan_act_lo);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], original/new btRetryIndex=0x%x/ 0x%x\n",
-			 btdm_8723->bt_retry_index, btdm->bt_retry_index);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new sw_dac_swing_on=0x%x/ 0x%x\n",
+			btdm_8723->sw_dac_swing_on,
+			btdm->sw_dac_swing_on);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new sw_dac_swing_lvl=0x%x/ 0x%x\n",
+			btdm_8723->sw_dac_swing_lvl,
+			btdm->sw_dac_swing_lvl);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new wlanActHi=0x%x/ 0x%x\n",
+			btdm_8723->wlan_act_hi, btdm->wlan_act_hi);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new wlanActLo=0x%x/ 0x%x\n",
+			btdm_8723->wlan_act_lo, btdm->wlan_act_lo);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], original/new btRetryIndex=0x%x/ 0x%x\n",
+			btdm_8723->bt_retry_index, btdm->bt_retry_index);
 
 		memcpy(btdm_8723, btdm, sizeof(struct btdm_8723));
 	}
@@ -756,14 +757,14 @@ void rtl8723e_dm_bt_set_bt_dm(struct ieee80211_hw *hw,
 	 */
 
 	if (rtlpriv->btcoexist.hold_for_bt_operation) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], set to ignore wlanAct for BT OP!!\n");
 		rtl8723e_dm_bt_set_fw_ignore_wlan_act(hw, true);
 		return;
 	}
 
 	if (btdm->all_off) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], disable all coexist mechanism !!\n");
 		rtl8723e_btdm_coex_all_off(hw);
 		return;
@@ -929,34 +930,34 @@ static u8 rtl8723e_dm_bt_bt_tx_rx_counter_level(struct ieee80211_hw *hw)
 
 	bt_tx_rx_cnt = rtl8723e_dm_bt_tx_rx_couter_h(hw)
 				+ rtl8723e_dm_bt_tx_rx_couter_l(hw);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt);
 
 	rtlpriv->btcoexist.cstate_h &= ~
 		 (BT_COEX_STATE_BT_CNT_LEVEL_0 | BT_COEX_STATE_BT_CNT_LEVEL_1|
 		  BT_COEX_STATE_BT_CNT_LEVEL_2);
 
 	if (bt_tx_rx_cnt >= BT_TXRX_CNT_THRES_3) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], BT TxRx Counters at level 3\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], BT TxRx Counters at level 3\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_3;
 		rtlpriv->btcoexist.cstate_h |=
 			BT_COEX_STATE_BT_CNT_LEVEL_3;
 	} else if (bt_tx_rx_cnt >= BT_TXRX_CNT_THRES_2) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], BT TxRx Counters at level 2\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], BT TxRx Counters at level 2\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_2;
 		rtlpriv->btcoexist.cstate_h |=
 			BT_COEX_STATE_BT_CNT_LEVEL_2;
 	} else if (bt_tx_rx_cnt >= BT_TXRX_CNT_THRES_1) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], BT TxRx Counters at level 1\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], BT TxRx Counters at level 1\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_1;
 		rtlpriv->btcoexist.cstate_h  |=
 			BT_COEX_STATE_BT_CNT_LEVEL_1;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], BT TxRx Counters at level 0\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], BT TxRx Counters at level 0\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_0;
 		rtlpriv->btcoexist.cstate_h |=
 			BT_COEX_STATE_BT_CNT_LEVEL_0;
@@ -979,11 +980,11 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 	btdm8723.reject_aggre_pkt = false;
 
 	bt_tx_rx_cnt_lvl = rtl8723e_dm_bt_bt_tx_rx_counter_level(hw);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt_lvl);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt_lvl);
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
 		/* coex table */
 		btdm8723.val_0x6c0 = 0x55555555;
 		btdm8723.val_0x6c8 = 0xffff;
@@ -997,24 +998,24 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 		/* fw mechanism */
 		btdm8723.ps_tdma_on = true;
 		if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "[BTCoex], BT TxRx Counters >= 1400\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"[BTCoex], BT TxRx Counters >= 1400\n");
 			btdm8723.ps_tdma_byte[0] = 0xa3;
 			btdm8723.ps_tdma_byte[1] = 0x5;
 			btdm8723.ps_tdma_byte[2] = 0x5;
 			btdm8723.ps_tdma_byte[3] = 0x2;
 			btdm8723.ps_tdma_byte[4] = 0x80;
 		} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 			btdm8723.ps_tdma_byte[0] = 0xa3;
 			btdm8723.ps_tdma_byte[1] = 0xa;
 			btdm8723.ps_tdma_byte[2] = 0xa;
 			btdm8723.ps_tdma_byte[3] = 0x2;
 			btdm8723.ps_tdma_byte[4] = 0x80;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "[BTCoex], BT TxRx Counters < 1200\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"[BTCoex], BT TxRx Counters < 1200\n");
 			btdm8723.ps_tdma_byte[0] = 0xa3;
 			btdm8723.ps_tdma_byte[1] = 0xf;
 			btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1022,8 +1023,8 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 			btdm8723.ps_tdma_byte[4] = 0x80;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "HT20 or Legacy\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"HT20 or Legacy\n");
 		bt_rssi_state =
 		  rtl8723e_dm_bt_check_coex_rssi_state(hw, 2, 47, 0);
 		bt_rssi_state1 =
@@ -1037,14 +1038,14 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 		/* sw mechanism */
 		if ((bt_rssi_state == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					"Wifi rssi high\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi high\n");
 			btdm8723.agc_table_en = true;
 			btdm8723.adc_back_off_on = true;
 			btdm8723.sw_dac_swing_on = false;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					"Wifi rssi low\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi low\n");
 			btdm8723.agc_table_en = false;
 			btdm8723.adc_back_off_on = false;
 			btdm8723.sw_dac_swing_on = false;
@@ -1054,30 +1055,30 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 		btdm8723.ps_tdma_on = true;
 		if ((bt_rssi_state1 == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state1 == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "Wifi rssi-1 high\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi-1 high\n");
 			/* only rssi high we need to do this, */
 			/* when rssi low, the value will modified by fw */
 			rtl_write_byte(rtlpriv, 0x883, 0x40);
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				"[BTCoex], BT TxRx Counters >= 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
 				btdm8723.ps_tdma_byte[2] = 0x5;
 				btdm8723.ps_tdma_byte[3] = 0x83;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters>= 1200 && < 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters>= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
 				btdm8723.ps_tdma_byte[2] = 0xa;
 				btdm8723.ps_tdma_byte[3] = 0x83;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters < 1200\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
 				btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1085,27 +1086,27 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					"Wifi rssi-1 low\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi-1 low\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
 				btdm8723.ps_tdma_byte[2] = 0x5;
 				btdm8723.ps_tdma_byte[3] = 0x2;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
 				btdm8723.ps_tdma_byte[2] = 0xa;
 				btdm8723.ps_tdma_byte[3] = 0x2;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters < 1200\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
 				btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1120,13 +1121,13 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 
 	/* Always ignore WlanAct if bHid|bSCOBusy|bSCOeSCO */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
-		 hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
+		hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
 	if ((hal_coex_8723.bt_inq_page_start_time) ||
 	    (BT_TXRX_CNT_LEVEL_3 == bt_tx_rx_cnt_lvl)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], Set BT inquiry / page scan 0x3a setting\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], Set BT inquiry / page scan 0x3a setting\n");
 		btdm8723.ps_tdma_on = true;
 		btdm8723.ps_tdma_byte[0] = 0xa3;
 		btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1157,11 +1158,11 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 
 	bt_tx_rx_cnt_lvl = rtl8723e_dm_bt_bt_tx_rx_counter_level(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-	"[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt_lvl);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt_lvl);
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
 		bt_rssi_state =
 		  rtl8723e_dm_bt_check_coex_rssi_state(hw, 2, 37, 0);
 
@@ -1179,27 +1180,27 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		btdm8723.ps_tdma_on = true;
 		if ((bt_rssi_state == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-						"Wifi rssi high\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi high\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				"[BTCoex], BT TxRx Counters >= 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
 				btdm8723.ps_tdma_byte[2] = 0x5;
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
 				btdm8723.ps_tdma_byte[2] = 0xa;
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters < 1200\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
 				btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1207,11 +1208,11 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "Wifi rssi low\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi low\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
 				btdm8723.ps_tdma_byte[2] = 0x5;
@@ -1219,16 +1220,16 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl ==
 				BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
 				btdm8723.ps_tdma_byte[2] = 0xa;
 				btdm8723.ps_tdma_byte[3] = 0x0;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters < 1200\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
 				btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1237,8 +1238,8 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 			}
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "HT20 or Legacy\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"HT20 or Legacy\n");
 		bt_rssi_state =
 		  rtl8723e_dm_bt_check_coex_rssi_state(hw, 2, 47, 0);
 		bt_rssi_state1 =
@@ -1252,14 +1253,14 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		/* sw mechanism */
 		if ((bt_rssi_state == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "Wifi rssi high\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi high\n");
 			btdm8723.agc_table_en = true;
 			btdm8723.adc_back_off_on = true;
 			btdm8723.sw_dac_swing_on = false;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "Wifi rssi low\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi low\n");
 			btdm8723.agc_table_en = false;
 			btdm8723.adc_back_off_on = false;
 			btdm8723.sw_dac_swing_on = false;
@@ -1269,30 +1270,30 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		btdm8723.ps_tdma_on = true;
 		if ((bt_rssi_state1 == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state1 == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "Wifi rssi-1 high\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi-1 high\n");
 			/* only rssi high we need to do this, */
 			/* when rssi low, the value will modified by fw */
 			rtl_write_byte(rtlpriv, 0x883, 0x40);
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
 				btdm8723.ps_tdma_byte[2] = 0x5;
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
 				btdm8723.ps_tdma_byte[2] = 0xa;
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters < 1200\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
 				btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1300,27 +1301,27 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "Wifi rssi-1 low\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"Wifi rssi-1 low\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
 				btdm8723.ps_tdma_byte[2] = 0x5;
 				btdm8723.ps_tdma_byte[3] = 0x0;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
 				btdm8723.ps_tdma_byte[2] = 0xa;
 				btdm8723.ps_tdma_byte[3] = 0x0;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BT TxRx Counters < 1200\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
 				btdm8723.ps_tdma_byte[2] = 0xf;
@@ -1333,14 +1334,14 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 	if (rtl8723e_dm_bt_need_to_dec_bt_pwr(hw))
 		btdm8723.dec_bt_pwr = true;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
-		 hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
+		hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
 
 	if ((hal_coex_8723.bt_inq_page_start_time) ||
 	    (BT_TXRX_CNT_LEVEL_3 == bt_tx_rx_cnt_lvl)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], Set BT inquiry / page scan 0x3a setting\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], Set BT inquiry / page scan 0x3a setting\n");
 		btdm8723.ps_tdma_on = true;
 		btdm8723.ps_tdma_byte[0] = 0xa3;
 		btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1366,20 +1367,20 @@ static void rtl8723e_dm_bt_inq_page_monitor(struct ieee80211_hw *hw)
 			rtlpriv->btcoexist.cstate  |=
 			BT_COEX_STATE_BT_INQ_PAGE;
 			hal_coex_8723.bt_inq_page_start_time = cur_time;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-				 "[BTCoex], BT Inquiry/page is started at time : 0x%x\n",
-				 hal_coex_8723.bt_inq_page_start_time);
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				"[BTCoex], BT Inquiry/page is started at time : 0x%x\n",
+				hal_coex_8723.bt_inq_page_start_time);
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		 "[BTCoex], BT Inquiry/page started time : 0x%x, cur_time : 0x%x\n",
-		 hal_coex_8723.bt_inq_page_start_time, cur_time);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		"[BTCoex], BT Inquiry/page started time : 0x%x, cur_time : 0x%x\n",
+		hal_coex_8723.bt_inq_page_start_time, cur_time);
 
 	if (hal_coex_8723.bt_inq_page_start_time) {
 		if ((((long)cur_time -
 			(long)hal_coex_8723.bt_inq_page_start_time) / HZ)
 			>= 10) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"[BTCoex], BT Inquiry/page >= 10sec!!!\n");
 			hal_coex_8723.bt_inq_page_start_time = 0;
 			rtlpriv->btcoexist.cstate &=
@@ -1406,14 +1407,14 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 bt_info_original;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"[BTCoex] Get bt info by fw!!\n");
 
 	_rtl8723_dm_bt_check_wifi_state(hw);
 
 	if (hal_coex_8723.c2h_bt_info_req_sent) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				"[BTCoex] c2h for bt_info not rcvd yet!!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"[BTCoex] c2h for bt_info not rcvd yet!!\n");
 	}
 
 	bt_info_original = hal_coex_8723.c2h_bt_info_original;
@@ -1426,8 +1427,8 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 	if (rtl8723e_dm_bt_is_2_ant_common_action(hw)) {
 		rtlpriv->btcoexist.bt_profile_case = BT_COEX_MECH_COMMON;
 		rtlpriv->btcoexist.bt_profile_action = BT_COEX_MECH_COMMON;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-		"Action 2-Ant common.\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"Action 2-Ant common.\n");
 	} else {
 		if ((bt_info_original & BTINFO_B_HID) ||
 			(bt_info_original & BTINFO_B_SCO_BUSY) ||
@@ -1438,8 +1439,8 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 					BT_COEX_MECH_HID_SCO_ESCO;
 				rtlpriv->btcoexist.bt_profile_action =
 					BT_COEX_MECH_HID_SCO_ESCO;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BTInfo: bHid|bSCOBusy|bSCOeSCO\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BTInfo: bHid|bSCOBusy|bSCOeSCO\n");
 				rtl8723e_dm_bt_2_ant_hid_sco_esco(hw);
 		} else if ((bt_info_original & BTINFO_B_FTP) ||
 				(bt_info_original & BTINFO_B_A2DP)) {
@@ -1449,8 +1450,8 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 					BT_COEX_MECH_FTP_A2DP;
 				rtlpriv->btcoexist.bt_profile_action =
 					BT_COEX_MECH_FTP_A2DP;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "BTInfo: bFTP|bA2DP\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"BTInfo: bFTP|bA2DP\n");
 				rtl8723e_dm_bt_2_ant_ftp_a2dp(hw);
 		} else {
 				rtlpriv->btcoexist.cstate |=
@@ -1459,8 +1460,8 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 					BT_COEX_MECH_NONE;
 				rtlpriv->btcoexist.bt_profile_action =
 					BT_COEX_MECH_NONE;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-					 "[BTCoex], BTInfo: undefined case!!!!\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+					"[BTCoex], BTInfo: undefined case!!!!\n");
 				rtl8723e_dm_bt_2_ant_hid_sco_esco(hw);
 		}
 	}
@@ -1513,7 +1514,7 @@ static void rtl8723e_dm_bt_query_bt_information(struct ieee80211_hw *hw)
 
 	h2c_parameter[0] |=  BIT(0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"Query Bt information, write 0x38=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x38, 1, h2c_parameter);
@@ -1548,10 +1549,10 @@ static void rtl8723e_dm_bt_bt_hw_counters_monitor(struct ieee80211_hw *hw)
 	hal_coex_8723.low_priority_tx = reg_lp_tx;
 	hal_coex_8723.low_priority_rx = reg_lp_rx;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"High Priority Tx/Rx (reg 0x%x)=%x(%d)/%x(%d)\n",
 		reg_hp_tx_rx, reg_hp_tx, reg_hp_tx, reg_hp_rx, reg_hp_rx);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"Low Priority Tx/Rx (reg 0x%x)=%x(%d)/%x(%d)\n",
 		reg_lp_tx_rx, reg_lp_tx, reg_lp_tx, reg_lp_rx, reg_lp_rx);
 	rtlpriv->btcoexist.lps_counter = 0;
@@ -1584,26 +1585,26 @@ static void rtl8723e_dm_bt_bt_enable_disable_check(struct ieee80211_hw *hw)
 	if (bt_alife) {
 		rtlpriv->btcoexist.bt_active_zero_cnt = 0;
 		rtlpriv->btcoexist.cur_bt_disabled = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "8723A BT is enabled !!\n");
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"8723A BT is enabled !!\n");
 	} else {
 		rtlpriv->btcoexist.bt_active_zero_cnt++;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "8723A bt all counters=0, %d times!!\n",
-			 rtlpriv->btcoexist.bt_active_zero_cnt);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"8723A bt all counters=0, %d times!!\n",
+			rtlpriv->btcoexist.bt_active_zero_cnt);
 		if (rtlpriv->btcoexist.bt_active_zero_cnt >= 2) {
 			rtlpriv->btcoexist.cur_bt_disabled = true;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "8723A BT is disabled !!\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"8723A BT is disabled !!\n");
 		}
 	}
 	if (rtlpriv->btcoexist.pre_bt_disabled !=
 		rtlpriv->btcoexist.cur_bt_disabled) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST,
-			 DBG_TRACE, "8723A BT is from %s to %s!!\n",
-			 (rtlpriv->btcoexist.pre_bt_disabled ?
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST,
+			DBG_TRACE, "8723A BT is from %s to %s!!\n",
+			(rtlpriv->btcoexist.pre_bt_disabled ?
 				"disabled" : "enabled"),
-			 (rtlpriv->btcoexist.cur_bt_disabled ?
+			(rtlpriv->btcoexist.cur_bt_disabled ?
 				"disabled" : "enabled"));
 		rtlpriv->btcoexist.pre_bt_disabled
 			= rtlpriv->btcoexist.cur_bt_disabled;
@@ -1620,22 +1621,22 @@ void rtl8723e_dm_bt_coexist_8723(struct ieee80211_hw *hw)
 	rtl8723e_dm_bt_bt_enable_disable_check(hw);
 
 	if (rtlpriv->btcoexist.bt_ant_num == ANT_X2) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], 2 Ant mechanism\n");
 		_rtl8723e_dm_bt_coexist_2_ant(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], 1 Ant mechanism\n");
 		_rtl8723e_dm_bt_coexist_1_ant(hw);
 	}
 
 	if (!rtl8723e_dm_bt_is_same_coexist_state(hw)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
-			 "[BTCoex], Coexist State[bitMap] change from 0x%x%8x to 0x%x%8x\n",
-			 rtlpriv->btcoexist.previous_state_h,
-			 rtlpriv->btcoexist.previous_state,
-			 rtlpriv->btcoexist.cstate_h,
-			 rtlpriv->btcoexist.cstate);
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			"[BTCoex], Coexist State[bitMap] change from 0x%x%8x to 0x%x%8x\n",
+			rtlpriv->btcoexist.previous_state_h,
+			rtlpriv->btcoexist.previous_state,
+			rtlpriv->btcoexist.cstate_h,
+			rtlpriv->btcoexist.cstate);
 		rtlpriv->btcoexist.previous_state
 			= rtlpriv->btcoexist.cstate;
 		rtlpriv->btcoexist.previous_state_h
@@ -1658,14 +1659,14 @@ static void rtl8723e_dm_bt_parse_bt_info(struct ieee80211_hw *hw,
 		else if (i == 1)
 			hal_coex_8723.bt_retry_cnt = tmp_buf[i];
 		if (i == len-1)
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "0x%2x]", tmp_buf[i]);
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"0x%2x]", tmp_buf[i]);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "0x%2x, ", tmp_buf[i]);
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"0x%2x, ", tmp_buf[i]);
 
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"BT info bt_info (Data)= 0x%x\n",
 			hal_coex_8723.c2h_bt_info_original);
 	bt_info = hal_coex_8723.c2h_bt_info_original;
@@ -1677,12 +1678,12 @@ static void rtl8723e_dm_bt_parse_bt_info(struct ieee80211_hw *hw,
 
 
 	if (bt_info & BTINFO_B_CONNECTION) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTC2H], BTInfo: bConnect=true\n");
 		rtlpriv->btcoexist.bt_busy = true;
 		rtlpriv->btcoexist.cstate &= ~BT_COEX_STATE_BT_IDLE;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTC2H], BTInfo: bConnect=false\n");
 		rtlpriv->btcoexist.bt_busy = false;
 		rtlpriv->btcoexist.cstate |= BT_COEX_STATE_BT_IDLE;
@@ -1697,14 +1698,14 @@ void rtl_8723e_c2h_command_handle(struct ieee80211_hw *hw)
 	u8 u1b_tmp = 0;
 	memset(&c2h_event, 0, sizeof(c2h_event));
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_C2HEVT_MSG_NORMAL);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
 		"&&&&&&: REG_C2HEVT_MSG_NORMAL is 0x%x\n", u1b_tmp);
 	c2h_event.cmd_id = u1b_tmp & 0xF;
 	c2h_event.cmd_len = (u1b_tmp & 0xF0) >> 4;
 	c2h_event.cmd_seq = rtl_read_byte(rtlpriv, REG_C2HEVT_MSG_NORMAL + 1);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "cmd_id: %d, cmd_len: %d, cmd_seq: %d\n",
-		 c2h_event.cmd_id , c2h_event.cmd_len, c2h_event.cmd_seq);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"cmd_id: %d, cmd_len: %d, cmd_seq: %d\n",
+		c2h_event.cmd_id, c2h_event.cmd_len, c2h_event.cmd_seq);
 	u1b_tmp = rtl_read_byte(rtlpriv, 0x01AF);
 	if (u1b_tmp == C2H_EVT_HOST_CLOSE) {
 		return;
@@ -1714,8 +1715,8 @@ void rtl_8723e_c2h_command_handle(struct ieee80211_hw *hw)
 	}
 	ptmp_buf = kzalloc(c2h_event.cmd_len, GFP_KERNEL);
 	if (ptmp_buf == NULL) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
-			 "malloc cmd buf failed\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
+			"malloc cmd buf failed\n");
 		return;
 	}
 
@@ -1733,13 +1734,13 @@ void rtl_8723e_c2h_command_handle(struct ieee80211_hw *hw)
 			break;
 
 	case C2H_V0_BT_INFO:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
 			"BT info Byte[0] (ID) is 0x%x\n",
 			c2h_event.cmd_id);
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
 			"BT info Byte[1] (Seq) is 0x%x\n",
 			c2h_event.cmd_seq);
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE,
 			"BT info Byte[2] (Data)= 0x%x\n", ptmp_buf[0]);
 
 		rtl8723e_dm_bt_parse_bt_info(hw, ptmp_buf, c2h_event.cmd_len);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 7a46c6a9deae..a36dc6e726d2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -122,8 +122,8 @@ void rtl8723e_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -187,8 +187,8 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 			u8 e_aci;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "HW_VAR_SLOT_TIME %x\n", val[0]);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 			rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 
@@ -227,9 +227,9 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 				*val = min_spacing_to_set;
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-					  mac->min_space_cfg);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+					mac->min_space_cfg);
 
 				rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 					       mac->min_space_cfg);
@@ -242,9 +242,9 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			density_to_set = *((u8 *)val);
 			mac->min_space_cfg |= (density_to_set << 3);
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-				  mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+				mac->min_space_cfg);
 
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
@@ -289,9 +289,9 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 						       p_regtoset[index]);
 				}
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
-					  factor_toset);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+					factor_toset);
 			}
 			break;
 		}
@@ -328,9 +328,9 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					acm_ctrl |= ACMHW_VOQEN;
 					break;
 				default:
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
-						 acm);
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
+						acm);
 					break;
 				}
 			} else {
@@ -345,16 +345,16 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					acm_ctrl &= (~ACMHW_VOQEN);
 					break;
 				default:
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-						 "switch case %#x not processed\n",
-						 e_aci);
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+						"switch case %#x not processed\n",
+						e_aci);
 					break;
 				}
 			}
 
-			RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
-				 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
-				 acm_ctrl);
+			rtl_dbg(rtlpriv, COMP_QOS, DBG_TRACE,
+				"SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
+				acm_ctrl);
 			rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
 			break;
 		}
@@ -526,8 +526,8 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			 break;
 		}
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -703,8 +703,8 @@ static bool _rtl8712e_init_mac(struct ieee80211_hw *hw)
 	} while (tmpu2b != 0xc290 && retry < 100);
 
 	if (retry >= 100) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "InitMAC(): ePHY configure fail!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"InitMAC(): ePHY configure fail!!!\n");
 		return false;
 	}
 
@@ -878,14 +878,14 @@ void rtl8723e_enable_hw_security_config(struct ieee80211_hw *hw)
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
 
@@ -900,8 +900,8 @@ void rtl8723e_enable_hw_security_config(struct ieee80211_hw *hw)
 
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 
@@ -942,8 +942,8 @@ int rtl8723e_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl8723_download_fw(hw, false, FW_8723A_POLLING_TIMEOUT_COUNT);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
 	}
@@ -1009,7 +1009,7 @@ int rtl8723e_hw_init(struct ieee80211_hw *hw)
 	tmp_u1b = efuse_read_1byte(hw, 0x1FA);
 	if (!(tmp_u1b & BIT(0))) {
 		rtl_set_rfreg(hw, RF90_PATH_A, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path A\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path A\n");
 	}
 
 	if (!(tmp_u1b & BIT(4))) {
@@ -1018,7 +1018,7 @@ int rtl8723e_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x80);
 		udelay(10);
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x90);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "under 1.5V\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "under 1.5V\n");
 	}
 	rtl8723e_dm_init(hw);
 exit:
@@ -1069,16 +1069,16 @@ static enum version_8723e _rtl8723e_read_chip_version(struct ieee80211_hw *hw)
 	}
 	switch (version) {
 	case VERSION_TEST_UMC_CHIP_8723:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Chip Version ID: VERSION_TEST_UMC_CHIP_8723.\n");
-			break;
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Chip Version ID: VERSION_TEST_UMC_CHIP_8723.\n");
+		break;
 	case VERSION_NORMAL_UMC_CHIP_8723_1T1R_A_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Chip Version ID: VERSION_NORMAL_UMC_CHIP_8723_1T1R_A_CUT.\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Chip Version ID: VERSION_NORMAL_UMC_CHIP_8723_1T1R_A_CUT.\n");
 		break;
 	case VERSION_NORMAL_UMC_CHIP_8723_1T1R_B_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Chip Version ID: VERSION_NORMAL_UMC_CHIP_8723_1T1R_B_CUT.\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Chip Version ID: VERSION_NORMAL_UMC_CHIP_8723_1T1R_B_CUT.\n");
 		break;
 	default:
 		pr_err("Chip Version ID: Unknown. Bug?\n");
@@ -1088,7 +1088,7 @@ static enum version_8723e _rtl8723e_read_chip_version(struct ieee80211_hw *hw)
 	if (IS_8723_SERIES(version))
 		rtlphy->rf_type = RF_1T1R;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Chip RF Type: %s\n",
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Chip RF Type: %s\n",
 		(rtlphy->rf_type == RF_2T2R) ? "RF_2T2R" : "RF_1T1R");
 
 	return version;
@@ -1103,30 +1103,30 @@ static int _rtl8723e_set_media_status(struct ieee80211_hw *hw,
 	u8 mode = MSR_NOLINK;
 
 	rtl_write_dword(rtlpriv, REG_BCN_CTRL, 0);
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_LOUD,
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_LOUD,
 		"clear 0x550 when set HW_VAR_MEDIA_STATUS\n");
 
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		mode = MSR_NOLINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		mode = MSR_ADHOC;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 			"Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		mode = MSR_INFRA;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 			"Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		mode = MSR_AP;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 			"Set Network type to AP!\n");
 		break;
 	default:
@@ -1153,9 +1153,9 @@ static int _rtl8723e_set_media_status(struct ieee80211_hw *hw,
 		_rtl8723e_resume_tx_beacon(hw);
 		_rtl8723e_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
-			 mode);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
+			mode);
 	}
 
 	rtl_write_byte(rtlpriv, MSR, bt_msr | mode);
@@ -1350,8 +1350,8 @@ void rtl8723e_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	rtl8723e_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	rtl8723e_enable_interrupt(hw);
@@ -1363,8 +1363,8 @@ void rtl8723e_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1782,8 +1782,8 @@ static void _rtl8723e_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
 void rtl8723e_read_eeprom_info(struct ieee80211_hw *hw)
@@ -1806,19 +1806,19 @@ void rtl8723e_read_eeprom_info(struct ieee80211_hw *hw)
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
 		_rtl8723e_read_adapter_info(hw, false);
 	} else {
@@ -1914,8 +1914,8 @@ static void rtl8723e_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
 static void rtl8723e_update_hal_rate_mask(struct ieee80211_hw *hw,
@@ -2036,17 +2036,17 @@ static void rtl8723e_update_hal_rate_mask(struct ieee80211_hw *hw,
 	}
 	sta_entry->ratr_index = ratr_index;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "ratr_bitmap :%x\n", ratr_bitmap);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"ratr_bitmap :%x\n", ratr_bitmap);
 	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
 			     (ratr_index << 28);
 	rate_mask[4] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x\n",
-		  ratr_index, ratr_bitmap,
-		  rate_mask[0], rate_mask[1],
-		  rate_mask[2], rate_mask[3],
-		  rate_mask[4]);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x\n",
+		ratr_index, ratr_bitmap,
+		rate_mask[0], rate_mask[1],
+		rate_mask[2], rate_mask[3],
+		rate_mask[4]);
 	rtl8723e_fill_h2c_cmd(hw, H2C_RA_MASK, 5, rate_mask);
 }
 
@@ -2111,15 +2111,15 @@ bool rtl8723e_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 		e_rfpowerstate_toset = (u1tmp & BIT(1)) ? ERFON : ERFOFF;
 
 	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
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
@@ -2170,7 +2170,7 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2198,8 +2198,8 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
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
@@ -2229,26 +2229,26 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "delete one entry, entry_id is %d\n",
-				 entry_id);
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
@@ -2288,9 +2288,9 @@ static void rtl8723e_bt_var_init(struct ieee80211_hw *hw)
 	rtlpriv->btcoexist.bt_radio_shared_type =
 		rtlpriv->btcoexist.eeprom_bt_radio_shared;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-		 "BT Coexistence = 0x%x\n",
-		 rtlpriv->btcoexist.bt_coexistence);
+	rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		"BT Coexistence = 0x%x\n",
+		rtlpriv->btcoexist.bt_coexistence);
 
 	if (rtlpriv->btcoexist.bt_coexistence) {
 		rtlpriv->btcoexist.bt_busy_traffic = false;
@@ -2301,47 +2301,47 @@ static void rtl8723e_bt_var_init(struct ieee80211_hw *hw)
 		rtlpriv->btcoexist.previous_state = 0;
 
 		if (rtlpriv->btcoexist.bt_ant_num == ANT_X2) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_Ant_Num = Antx2\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_Ant_Num = Antx2\n");
 		} else if (rtlpriv->btcoexist.bt_ant_num == ANT_X1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_Ant_Num = Antx1\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_Ant_Num = Antx1\n");
 		}
 		switch (rtlpriv->btcoexist.bt_coexist_type) {
 		case BT_2WIRE:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = BT_2Wire\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = BT_2Wire\n");
 			break;
 		case BT_ISSC_3WIRE:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = BT_ISSC_3Wire\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = BT_ISSC_3Wire\n");
 			break;
 		case BT_ACCEL:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = BT_ACCEL\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = BT_ACCEL\n");
 			break;
 		case BT_CSR_BC4:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = BT_CSR_BC4\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = BT_CSR_BC4\n");
 			break;
 		case BT_CSR_BC8:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = BT_CSR_BC8\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = BT_CSR_BC8\n");
 			break;
 		case BT_RTL8756:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = BT_RTL8756\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = BT_RTL8756\n");
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-				 "BlueTooth BT_CoexistType = Unknown\n");
+			rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				"BlueTooth BT_CoexistType = Unknown\n");
 			break;
 		}
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "BlueTooth BT_Ant_isolation = %d\n",
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"BlueTooth BT_Ant_isolation = %d\n",
 			 rtlpriv->btcoexist.bt_ant_isolation);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
-			 "BT_RadioSharedType = 0x%x\n",
+		rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			"BT_RadioSharedType = 0x%x\n",
 			 rtlpriv->btcoexist.bt_radio_shared_type);
 		rtlpriv->btcoexist.bt_active_zero_cnt = 0;
 		rtlpriv->btcoexist.cur_bt_disabled = false;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
index 5e503dbc463b..7fab02e01a8c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
@@ -19,8 +19,8 @@ void rtl8723e_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -48,8 +48,8 @@ void rtl8723e_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
@@ -128,7 +128,7 @@ void rtl8723e_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n",
-		 ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n",
+		ledaction);
 	_rtl8723e_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index 772aecedf0b4..5ba645bc46dc 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -38,9 +38,9 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 	u32 original_value = 0, readback_value, bitshift;
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		 regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -54,9 +54,9 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		  regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 
 	return readback_value;
 }
@@ -69,9 +69,9 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 original_value = 0, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -99,9 +99,9 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 }
 
@@ -185,7 +185,7 @@ static bool _rtl8723e_phy_bb8192c_config_parafile(struct ieee80211_hw *hw)
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	bool rtstatus;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
 	rtstatus = _rtl8723e_phy_config_bb_with_headerfile(hw,
 						BASEBAND_CONFIG_PHY_REG);
 	if (rtstatus != true) {
@@ -195,7 +195,7 @@ static bool _rtl8723e_phy_bb8192c_config_parafile(struct ieee80211_hw *hw)
 
 	if (rtlphy->rf_type == RF_1T2R) {
 		_rtl8723e_phy_bb_config_1t(hw);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
 	}
 	if (rtlefuse->autoload_failflag == false) {
 		rtlphy->pwrgroup_cnt = 0;
@@ -226,12 +226,12 @@ static bool _rtl8723e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl723MACPHY_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl723MACPHY_Array\n");
 	arraylength = RTL8723E_MACARRAYLENGTH;
 	ptrarray = RTL8723EMAC_ARRAY;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "Img:RTL8192CEMAC_2T_ARRAY\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Img:RTL8192CEMAC_2T_ARRAY\n");
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8) ptrarray[i + 1]);
 	return true;
@@ -267,20 +267,20 @@ static bool _rtl8723e_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 			rtl_set_bbreg(hw, phy_regarray_table[i], MASKDWORD,
 				      phy_regarray_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "The phy_regarray_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
-				 phy_regarray_table[i],
-				 phy_regarray_table[i + 1]);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"The phy_regarray_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
+				phy_regarray_table[i],
+				phy_regarray_table[i + 1]);
 		}
 	} else if (configtype == BASEBAND_CONFIG_AGC_TAB) {
 		for (i = 0; i < agctab_arraylen; i = i + 2) {
 			rtl_set_bbreg(hw, agctab_array_table[i], MASKDWORD,
 				      agctab_array_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "The agctab_array_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
-				 agctab_array_table[i],
-				 agctab_array_table[i + 1]);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"The agctab_array_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
+				agctab_array_table[i],
+				agctab_array_table[i + 1]);
 		}
 	}
 	return true;
@@ -296,146 +296,146 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][0] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][0]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][0]);
 	}
 	if (regaddr == RTXAGC_A_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][1] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][1]);
 	}
 	if (regaddr == RTXAGC_A_CCK1_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][6] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][6] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][6]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][6] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][6]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0xffffff00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][7] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][7]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][7]);
 	}
 	if (regaddr == RTXAGC_A_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][2] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][2]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][2]);
 	}
 	if (regaddr == RTXAGC_A_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][3] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][3]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][3]);
 	}
 	if (regaddr == RTXAGC_A_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][4] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][4]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][4]);
 	}
 	if (regaddr == RTXAGC_A_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][5] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][5]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][5]);
 	}
 	if (regaddr == RTXAGC_B_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][8] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][8]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][8]);
 	}
 	if (regaddr == RTXAGC_B_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][9] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][9]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][9]);
 	}
 	if (regaddr == RTXAGC_B_CCK1_55_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][14] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][14]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][14]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][15] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][15]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][15]);
 	}
 	if (regaddr == RTXAGC_B_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][10] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][10]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][10]);
 	}
 	if (regaddr == RTXAGC_B_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][11] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][11]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][11]);
 	}
 	if (regaddr == RTXAGC_B_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][12] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][12]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][12]);
 	}
 	if (regaddr == RTXAGC_B_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][13] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
-							    pwrgroup_cnt][13]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][13]);
 
 		rtlphy->pwrgroup_cnt++;
 	}
@@ -473,8 +473,8 @@ static bool _rtl8723e_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 						phy_regarray_table_pg[i + 2]);
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "configtype != BaseBand_Config_PHY_REG\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"configtype != BaseBand_Config_PHY_REG\n");
 	}
 	return true;
 }
@@ -534,21 +534,21 @@ void rtl8723e_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->default_initialgain[3] =
 	    (u8) rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
 
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
 
 	rtlphy->framesync = (u8) rtl_get_bbreg(hw,
 					       ROFDM0_RXDETECTOR3, MASKBYTE0);
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw,
 					      ROFDM0_RXDETECTOR2, MASKDWORD);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "Default framesync (0x%x) = 0x%x\n",
-		  ROFDM0_RXDETECTOR3, rtlphy->framesync);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default framesync (0x%x) = 0x%x\n",
+		ROFDM0_RXDETECTOR3, rtlphy->framesync);
 }
 
 void rtl8723e_phy_get_txpower_level(struct ieee80211_hw *hw, long *powerlevel)
@@ -650,9 +650,9 @@ bool rtl8723e_phy_update_txpower_dbm(struct ieee80211_hw *hw, long power_indbm)
 		ofdmtxpwridx -= rtlefuse->legacy_ht_txpowerdiff;
 	else
 		ofdmtxpwridx = 0;
-	RT_TRACE(rtlpriv, COMP_TXAGC, DBG_TRACE,
-		 "%lx dBm, ccktxpwridx = %d, ofdmtxpwridx = %d\n",
-		  power_indbm, ccktxpwridx, ofdmtxpwridx);
+	rtl_dbg(rtlpriv, COMP_TXAGC, DBG_TRACE,
+		"%lx dBm, ccktxpwridx = %d, ofdmtxpwridx = %d\n",
+		power_indbm, ccktxpwridx, ofdmtxpwridx);
 	for (idx = 0; idx < 14; idx++) {
 		for (rf_path = 0; rf_path < 2; rf_path++) {
 			rtlefuse->txpwrlevel_cck[rf_path][idx] = ccktxpwridx;
@@ -734,10 +734,10 @@ void rtl8723e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
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
@@ -791,7 +791,7 @@ void rtl8723e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl8723e_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 void rtl8723e_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -808,8 +808,8 @@ void rtl8723e_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl8723e_phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
 	}
@@ -822,8 +822,8 @@ void rtl8723e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 delay;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
 	do {
@@ -841,7 +841,7 @@ void rtl8723e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl8723e_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -861,12 +861,12 @@ u8 rtl8723e_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl8723e_phy_sw_chnl_callback(hw);
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
-			 "sw_chnl_inprogress false schedule workitem\n");
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false schedule workitem\n");
 		rtlphy->sw_chnl_inprogress = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
-			 "sw_chnl_inprogress false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false driver sleep or unload\n");
 		rtlphy->sw_chnl_inprogress = false;
 	}
 	return 1;
@@ -991,9 +991,9 @@ static bool _rtl8723e_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
 			_rtl8723e_phy_sw_rf_seting(hw, channel);
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
 
@@ -1444,24 +1444,24 @@ bool rtl8723e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
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
@@ -1472,7 +1472,7 @@ bool rtl8723e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl8723e_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -1482,9 +1482,9 @@ static void rtl8723e_phy_set_io(struct ieee80211_hw *hw)
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
@@ -1497,14 +1497,14 @@ static void rtl8723e_phy_set_io(struct ieee80211_hw *hw)
 		rtl8723e_dm_write_dig(hw);
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
 
 static void rtl8723e_phy_set_rf_on(struct ieee80211_hw *hw)
@@ -1541,8 +1541,8 @@ static void _rtl8723e_phy_set_rf_sleep(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Switch RF timeout !!!.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Switch RF timeout !!!.\n");
 		return;
 	}
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
@@ -1569,18 +1569,17 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
 			do {
 				initializecount++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "IPS Set eRf nic enable\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus && (initializecount < 10));
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
+					   ppsc->last_sleep_jiffies));
 			ppsc->last_awake_jiffies = jiffies;
 			rtl8723e_phy_set_rf_on(hw);
 		}
@@ -1594,8 +1593,8 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		break;
 	case ERFOFF:
 		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "IPS Set eRf nic disable\n");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"IPS Set eRf nic disable\n");
 			rtl_ps_disable_nic(hw);
 			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
@@ -1619,33 +1618,33 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "Set ERFSLEEP awaked:%d ms\n",
-			  jiffies_to_msecs(jiffies -
-					   ppsc->last_awake_jiffies));
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"Set ERFSLEEP awaked:%d ms\n",
+			jiffies_to_msecs(jiffies -
+			   ppsc->last_awake_jiffies));
 		ppsc->last_sleep_jiffies = jiffies;
 		_rtl8723e_phy_set_rf_sleep(hw);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", rfpwr_state);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", rfpwr_state);
 		bresult = false;
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c
index 9058527a7f94..ecec8c9f0992 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c
@@ -480,12 +480,12 @@ static bool _rtl8723e_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 		}
 
 		if (rtstatus != true) {
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index a04ce15d5538..6bcd897512ac 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -368,8 +368,8 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 	u8 bw_40 = 0;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	if (mac->opmode == NL80211_IFTYPE_STATION) {
@@ -477,8 +477,8 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Enable RDG function.\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
 			}
@@ -517,7 +517,7 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(pdesc, 1);
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -537,8 +537,8 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
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

