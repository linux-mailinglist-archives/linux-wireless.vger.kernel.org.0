Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916272563D4
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 02:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgH2Aze (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 20:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgH2AzJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 20:55:09 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BF5C061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 17:55:08 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id m4so174332oos.6
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 17:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=neYIRCiubgJU+N23lGln46aBZ3ipFInmdMx+R6P/Wx0=;
        b=uCH8sTclp9yNvbOnZNyLTlQWb1wyy9ll9JVWKAsb7+pDbrJGClUVj9PJwDe8NfIi4l
         5fWoJuhv/naTO0FloktcWeuWw+gSZ7ASQsx3WvW0Yx0xOj04xsoIpjEjctxjy3Q4Edfn
         a9AkY7NqGvadlPxvDJeo/vBJWzSPGRxJnBy8B9daJ/O5QJVsNyBAZmTm6nmB7KdXoesu
         fQowrSzKYliCah9XvItDw7qXPXnnCPotqARE0fsb01NprQ9Rp5dxXBs7qjcKKhcMMUiw
         5MFFy9SdUgLDsaW66fffPY6Baqx56PsrfgVkRCGBTx1ENVSdDOkUY/GFMWFwQe17Hjhg
         6mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=neYIRCiubgJU+N23lGln46aBZ3ipFInmdMx+R6P/Wx0=;
        b=dTZfxrO/ZsBl2QkVZuo1ba7BgB/Eo8Oy//eO0mDgC5FcWIpXCZSvTiP2uCSQZ063DL
         AR2KlwxqriwdA2aXK37mL2USAmW1J1UxVrZwzv6x+5o19BgDaTZX9XcAfiHb3g9ROr9a
         7U8FKVBoCe1cKM0nZtZ5GrE/PjK5q7BV9WUYXPTzzP4PzyZDrbOkUVU+EY8MNM46LER8
         J9ONDYMegxok8MA/TKTF+M1S6GN85h2TKn7KKr+iBLxsADbQiP+zLHYIKl3gdUV+td8q
         K1cXnCcqV+vgKo5hts1eSwlephH1hQMaE0OoTHvtvC4cW+/4OLUfX5vWbFe8CWWTT/v6
         q/uA==
X-Gm-Message-State: AOAM531Fj5FHJJ7UsxvR4HIck3hGID4weESwTD28blEMmNLHZ/9+MrWf
        Vb8UtsAiawcsGZxNG/TttemeJDR/hKE=
X-Google-Smtp-Source: ABdhPJxSlIrfQCGBGb/wgHHMJ51NUvbs8q6eJCLUQl1z/11Q/weRHaLboqzFRrVTQE2sWQP4hXz9Hw==
X-Received: by 2002:a4a:9e05:: with SMTP id t5mr830054ook.89.1598662505774;
        Fri, 28 Aug 2020 17:55:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id w136sm202253oif.14.2020.08.28.17.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 17:55:04 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v3 14/15] rtlwifi: rtl8821ae: Rename RT_TRACE to rtl_dbg
Date:   Fri, 28 Aug 2020 19:54:41 -0500
Message-Id: <20200829005442.32318-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200829005442.32318-1-Larry.Finger@lwfinger.net>
References: <20200829005442.32318-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the misleading macro name to one that is more descriptive for
rtl8821ae. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

v2 - rtl_dbg is used rather than RTL_DEBUG
v3 - the problems with the original submission are fixed.
---

 .../wireless/realtek/rtlwifi/rtl8821ae/dm.c   | 821 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8821ae/fw.c   | 134 +--
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   | 456 +++++-----
 .../wireless/realtek/rtlwifi/rtl8821ae/led.c  |  32 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/phy.c  | 527 +++++------
 .../wireless/realtek/rtlwifi/rtl8821ae/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.c  |  59 +-
 7 files changed, 1020 insertions(+), 1015 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
index 97a30ccf0b27..93893825e6d6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/dm.c
@@ -437,26 +437,26 @@ static void rtl8821ae_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 		    mac->opmode == NL80211_IFTYPE_ADHOC) {
 			rtl_dm_dig->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-				 rtlpriv->dm.entry_min_undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				rtlpriv->dm.entry_min_undec_sm_pwdb);
 		} else {
 			rtl_dm_dig->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%x\n",
-				 rtl_dm_dig->min_undec_pwdb_for_dm);
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"STA Default Port PWDB = 0x%x\n",
+				rtl_dm_dig->min_undec_pwdb_for_dm);
 		}
 	} else {
 		rtl_dm_dig->min_undec_pwdb_for_dm =
 		    rtlpriv->dm.entry_min_undec_sm_pwdb;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			 "AP Ext Port or disconnect PWDB = 0x%x\n",
-			 rtl_dm_dig->min_undec_pwdb_for_dm);
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"AP Ext Port or disconnect PWDB = 0x%x\n",
+			rtl_dm_dig->min_undec_pwdb_for_dm);
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "MinUndecoratedPWDBForDM =%d\n",
-		 rtl_dm_dig->min_undec_pwdb_for_dm);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"MinUndecoratedPWDBForDM =%d\n",
+		rtl_dm_dig->min_undec_pwdb_for_dm);
 }
 
 static void  rtl8812ae_dm_rssi_dump_to_register(struct ieee80211_hw *hw)
@@ -626,11 +626,11 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 	u8 dm_dig_max, dm_dig_min, offset;
 	u8 current_igi = dm_digtable->cur_igvalue;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "\n");
 
 	if (mac->act_scanning) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "Return: In Scan Progress\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"Return: In Scan Progress\n");
 		return;
 	}
 
@@ -666,10 +666,10 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 			dm_digtable->rx_gain_max =
 				dm_digtable->rssi_val_min + offset;
 
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "dm_digtable->rssi_val_min=0x%x,dm_digtable->rx_gain_max = 0x%x\n",
-			 dm_digtable->rssi_val_min,
-			 dm_digtable->rx_gain_max);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"dm_digtable->rssi_val_min=0x%x,dm_digtable->rx_gain_max = 0x%x\n",
+			dm_digtable->rssi_val_min,
+			dm_digtable->rx_gain_max);
 		if (rtlpriv->dm.one_entry_only) {
 			offset = 0;
 
@@ -682,22 +682,21 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 				dig_min_0 =
 					dm_digtable->rssi_val_min - offset;
 
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "bOneEntryOnly=TRUE, dig_min_0=0x%x\n",
-				 dig_min_0);
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"bOneEntryOnly=TRUE, dig_min_0=0x%x\n",
+				dig_min_0);
 		} else {
 			dig_min_0 = dm_dig_min;
 		}
 	} else {
 		dm_digtable->rx_gain_max = dm_dig_max;
 		dig_min_0 = dm_dig_min;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "No Link\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "No Link\n");
 	}
 
 	if (rtlpriv->falsealm_cnt.cnt_all > 10000) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "Abnormally false alarm case.\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"Abnormally false alarm case.\n");
 
 		if (dm_digtable->large_fa_hit != 3)
 			dm_digtable->large_fa_hit++;
@@ -728,23 +727,23 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 						dig_min_0;
 					dm_digtable->rx_gain_min =
 						dig_min_0;
-					RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-						 "Normal Case: At Lower Bound\n");
+					rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+						"Normal Case: At Lower Bound\n");
 				} else {
 					dm_digtable->forbidden_igi--;
 					dm_digtable->rx_gain_min =
 					  (dm_digtable->forbidden_igi + 1);
-					RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-						 "Normal Case: Approach Lower Bound\n");
+					rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+						"Normal Case: Approach Lower Bound\n");
 				}
 			} else {
 				dm_digtable->large_fa_hit = 0;
 			}
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "pDM_DigTable->LargeFAHit=%d\n",
-		 dm_digtable->large_fa_hit);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"pDM_DigTable->LargeFAHit=%d\n",
+		dm_digtable->large_fa_hit);
 
 	if (rtlpriv->dm.dbginfo.num_qry_beacon_pkt < 10)
 		dm_digtable->rx_gain_min = dm_dig_min;
@@ -754,15 +753,15 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 
 	/*Adjust initial gain by false alarm*/
 	if (mac->link_state >= MAC80211_LINKED) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "DIG AfterLink\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"DIG AfterLink\n");
 		if (first_connect) {
 			if (dm_digtable->rssi_val_min <= dig_max_of_min)
 				current_igi = dm_digtable->rssi_val_min;
 			else
 				current_igi = dig_max_of_min;
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "First Connect\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"First Connect\n");
 		} else {
 			if (rtlpriv->falsealm_cnt.cnt_all > DM_DIG_FA_TH2)
 				current_igi = current_igi + 4;
@@ -774,17 +773,17 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 			if ((rtlpriv->dm.dbginfo.num_qry_beacon_pkt < 10) &&
 			    (rtlpriv->falsealm_cnt.cnt_all < DM_DIG_FA_TH1)) {
 				current_igi = dm_digtable->rx_gain_min;
-				RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-					 "Beacon is less than 10 and FA is less than 768, IGI GOES TO 0x1E!!!!!!!!!!!!\n");
+				rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+					"Beacon is less than 10 and FA is less than 768, IGI GOES TO 0x1E!!!!!!!!!!!!\n");
 			}
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "DIG BeforeLink\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"DIG BeforeLink\n");
 		if (first_disconnect) {
 			current_igi = dm_digtable->rx_gain_min;
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "First DisConnect\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"First DisConnect\n");
 		} else {
 			/* 2012.03.30 LukeLee: enable DIG before
 			 * link but with very high thresholds
@@ -799,11 +798,11 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 			if (current_igi >= 0x3e)
 				current_igi = 0x3e;
 
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "England DIG\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "England DIG\n");
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "DIG End Adjust IGI\n");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"DIG End Adjust IGI\n");
 	/* Check initial gain by upper/lower bound*/
 
 	if (current_igi > dm_digtable->rx_gain_max)
@@ -811,13 +810,13 @@ static void rtl8821ae_dm_dig(struct ieee80211_hw *hw)
 	if (current_igi < dm_digtable->rx_gain_min)
 		current_igi = dm_digtable->rx_gain_min;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "rx_gain_max=0x%x, rx_gain_min=0x%x\n",
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"rx_gain_max=0x%x, rx_gain_min=0x%x\n",
 		dm_digtable->rx_gain_max, dm_digtable->rx_gain_min);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "TotalFA=%d\n", rtlpriv->falsealm_cnt.cnt_all);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "CurIGValue=0x%x\n", current_igi);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"TotalFA=%d\n", rtlpriv->falsealm_cnt.cnt_all);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"CurIGValue=0x%x\n", current_igi);
 
 	rtl8821ae_dm_write_dig(hw, current_igi);
 	dm_digtable->media_connect_0 =
@@ -880,12 +879,12 @@ static void rtl8821ae_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 	rtl_set_bbreg(hw, ODM_REG_CCK_FA_RST_11AC, BIT(15), 0);
 	rtl_set_bbreg(hw, ODM_REG_CCK_FA_RST_11AC, BIT(15), 1);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "Cnt_Cck_fail=%d\n",
-		 falsealm_cnt->cnt_cck_fail);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "cnt_ofdm_fail=%d\n",
-		 falsealm_cnt->cnt_ofdm_fail);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "Total False Alarm=%d\n",
-		 falsealm_cnt->cnt_all);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "Cnt_Cck_fail=%d\n",
+		falsealm_cnt->cnt_cck_fail);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "cnt_ofdm_fail=%d\n",
+		falsealm_cnt->cnt_ofdm_fail);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "Total False Alarm=%d\n",
+		falsealm_cnt->cnt_all);
 }
 
 static void rtl8812ae_dm_check_txpower_tracking_thermalmeter(
@@ -896,13 +895,13 @@ static void rtl8812ae_dm_check_txpower_tracking_thermalmeter(
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER_88E,
 			      BIT(17) | BIT(16), 0x03);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Trigger 8812 Thermal Meter!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Trigger 8812 Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Schedule TxPowerTracking direct call!!\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Schedule TxPowerTracking direct call!!\n");
 	rtl8812ae_dm_txpower_tracking_callback_thermalmeter(hw);
 }
 
@@ -981,8 +980,8 @@ void rtl8821ae_dm_update_init_rate(struct ieee80211_hw *hw, u8 rate)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u8 p = 0;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Get C2H Command! Rate=0x%x\n", rate);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Get C2H Command! Rate=0x%x\n", rate);
 
 	rtldm->tx_rate = rate;
 
@@ -1145,9 +1144,9 @@ u8 rtl8821ae_hw_rate_to_mrate(struct ieee80211_hw *hw, u8 rate)
 		ret_rate = MGN_VHT2SS_MCS9;
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "HwRateToMRate8812(): Non supported Rate [%x]!!!\n",
-			 rate);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"HwRateToMRate8812(): Non supported Rate [%x]!!!\n",
+			rate);
 		break;
 	}
 	return ret_rate;
@@ -1187,8 +1186,8 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 		tx_rate =
 			rtl8821ae_hw_rate_to_mrate(hw, rtldm->tx_rate);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "===>rtl8812ae_dm_txpwr_track_set_pwr\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"===>%s\n", __func__);
 	/*20130429 Mimic Modify High Rate BBSwing Limit.*/
 	if (tx_rate != 0xFF) {
 		/*CCK*/
@@ -1259,13 +1258,13 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 		else
 			pwr_tracking_limit = 24;
 	}
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "TxRate=0x%x, PwrTrackingLimit=%d\n",
-		 tx_rate, pwr_tracking_limit);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxRate=0x%x, PwrTrackingLimit=%d\n",
+		tx_rate, pwr_tracking_limit);
 
 	if (method == BBSWING) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "===>rtl8812ae_dm_txpwr_track_set_pwr\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"===>%s\n", __func__);
 
 		if (rf_path == RF90_PATH_A) {
 			u32 tmp;
@@ -1276,10 +1275,10 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 				pwr_tracking_limit :
 				rtldm->ofdm_index[RF90_PATH_A];
 			tmp = final_swing_idx[RF90_PATH_A];
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "pDM_Odm->RFCalibrateInfo.OFDM_index[ODM_RF_PATH_A]=%d,pDM_Odm->RealBbSwingIdx[ODM_RF_PATH_A]=%d\n",
-				 rtldm->ofdm_index[RF90_PATH_A],
-				 final_swing_idx[RF90_PATH_A]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"pDM_Odm->RFCalibrateInfo.OFDM_index[ODM_RF_PATH_A]=%d,pDM_Odm->RealBbSwingIdx[ODM_RF_PATH_A]=%d\n",
+				rtldm->ofdm_index[RF90_PATH_A],
+				final_swing_idx[RF90_PATH_A]);
 
 			rtl_set_bbreg(hw, RA_TXSCALE, 0xFFE00000,
 				      txscaling_tbl[tmp]);
@@ -1292,20 +1291,20 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 				pwr_tracking_limit :
 				rtldm->ofdm_index[RF90_PATH_B];
 			tmp = final_swing_idx[RF90_PATH_B];
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "pDM_Odm->RFCalibrateInfo.OFDM_index[ODM_RF_PATH_B]=%d, pDM_Odm->RealBbSwingIdx[ODM_RF_PATH_B]=%d\n",
-				 rtldm->ofdm_index[RF90_PATH_B],
-				 final_swing_idx[RF90_PATH_B]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"pDM_Odm->RFCalibrateInfo.OFDM_index[ODM_RF_PATH_B]=%d, pDM_Odm->RealBbSwingIdx[ODM_RF_PATH_B]=%d\n",
+				rtldm->ofdm_index[RF90_PATH_B],
+				final_swing_idx[RF90_PATH_B]);
 
 			rtl_set_bbreg(hw, RB_TXSCALE, 0xFFE00000,
 				      txscaling_tbl[tmp]);
 		}
 	} else if (method == MIX_MODE) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "pDM_Odm->DefaultOfdmIndex=%d, pDM_Odm->Absolute_OFDMSwingIdx[RFPath]=%d, RF_Path = %d\n",
-			 rtldm->default_ofdm_index,
-			 rtldm->absolute_ofdm_swing_idx[rf_path],
-			 rf_path);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"pDM_Odm->DefaultOfdmIndex=%d, pDM_Odm->Absolute_OFDMSwingIdx[RFPath]=%d, RF_Path = %d\n",
+			rtldm->default_ofdm_index,
+			rtldm->absolute_ofdm_swing_idx[rf_path],
+			rf_path);
 
 		final_ofdm_swing_index = rtldm->default_ofdm_index +
 				rtldm->absolute_ofdm_swing_idx[rf_path];
@@ -1333,10 +1332,10 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 					rtlphy->current_channel,
 					RF90_PATH_A);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_A Over BBSwing Limit ,PwrTrackingLimit = %d ,Remnant TxAGC Value = %d\n",
-					 pwr_tracking_limit,
-					 rtldm->remnant_ofdm_swing_idx[rf_path]);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_A Over BBSwing Limit ,PwrTrackingLimit = %d ,Remnant TxAGC Value = %d\n",
+					pwr_tracking_limit,
+					rtldm->remnant_ofdm_swing_idx[rf_path]);
 			} else if (final_ofdm_swing_index < 0) {
 				rtldm->remnant_cck_idx = final_ofdm_swing_index;
 				/* CCK Follow the same compensate value as Path A*/
@@ -1352,15 +1351,15 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 				rtl8821ae_phy_set_txpower_level_by_path(hw,
 					rtlphy->current_channel, RF90_PATH_A);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_A Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
-					 rtldm->remnant_ofdm_swing_idx[rf_path]);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_A Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
+					rtldm->remnant_ofdm_swing_idx[rf_path]);
 			} else {
 				rtl_set_bbreg(hw, RA_TXSCALE, 0xFFE00000,
 					txscaling_tbl[(u8)final_ofdm_swing_index]);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_A Compensate with BBSwing, Final_OFDM_Swing_Index = %d\n",
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_A Compensate with BBSwing, Final_OFDM_Swing_Index = %d\n",
 					final_ofdm_swing_index);
 				/*If TxAGC has changed, reset TxAGC again*/
 				if (rtldm->modify_txagc_flag_path_a) {
@@ -1372,9 +1371,9 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 						rtlphy->current_channel, RF90_PATH_A);
 					rtldm->modify_txagc_flag_path_a = false;
 
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-						 DBG_LOUD,
-						 "******Path_A pDM_Odm->Modify_TxAGC_Flag = FALSE\n");
+					rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+						DBG_LOUD,
+						"******Path_A pDM_Odm->Modify_TxAGC_Flag = FALSE\n");
 				}
 			}
 		}
@@ -1395,9 +1394,9 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 				rtl8821ae_phy_set_txpower_level_by_path(hw,
 					rtlphy->current_channel, RF90_PATH_B);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_B Over BBSwing Limit , PwrTrackingLimit = %d , Remnant TxAGC Value = %d\n",
-					 pwr_tracking_limit,
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_B Over BBSwing Limit , PwrTrackingLimit = %d , Remnant TxAGC Value = %d\n",
+					pwr_tracking_limit,
 					 rtldm->remnant_ofdm_swing_idx[rf_path]);
 			} else if (final_ofdm_swing_index < 0) {
 				rtldm->remnant_ofdm_swing_idx[rf_path] =
@@ -1412,15 +1411,15 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 				rtl8821ae_phy_set_txpower_level_by_path(hw,
 					rtlphy->current_channel, RF90_PATH_B);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_B Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
-					 rtldm->remnant_ofdm_swing_idx[rf_path]);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_B Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
+					rtldm->remnant_ofdm_swing_idx[rf_path]);
 			} else {
 				rtl_set_bbreg(hw, RB_TXSCALE, 0xFFE00000,
 					txscaling_tbl[(u8)final_ofdm_swing_index]);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_B Compensate with BBSwing ,Final_OFDM_Swing_Index = %d\n",
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_B Compensate with BBSwing ,Final_OFDM_Swing_Index = %d\n",
 					final_ofdm_swing_index);
 				 /*If TxAGC has changed, reset TxAGC again*/
 				if (rtldm->modify_txagc_flag_path_b) {
@@ -1433,8 +1432,8 @@ void rtl8812ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 					rtldm->modify_txagc_flag_path_b =
 						false;
 
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-						 "******Path_B pDM_Odm->Modify_TxAGC_Flag = FALSE\n");
+					rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+						"******Path_B pDM_Odm->Modify_TxAGC_Flag = FALSE\n");
 				}
 			}
 		}
@@ -1474,18 +1473,18 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 
 	rtldm->txpower_trackinginit = true;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "pDM_Odm->BbSwingIdxCckBase: %d, pDM_Odm->BbSwingIdxOfdmBase[A]:%d, pDM_Odm->DefaultOfdmIndex: %d\n",
-		 rtldm->swing_idx_cck_base,
-		 rtldm->swing_idx_ofdm_base[RF90_PATH_A],
-		 rtldm->default_ofdm_index);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"pDM_Odm->BbSwingIdxCckBase: %d, pDM_Odm->BbSwingIdxOfdmBase[A]:%d, pDM_Odm->DefaultOfdmIndex: %d\n",
+		rtldm->swing_idx_cck_base,
+		rtldm->swing_idx_ofdm_base[RF90_PATH_A],
+		rtldm->default_ofdm_index);
 
 	thermal_value = (u8)rtl_get_rfreg(hw, RF90_PATH_A,
 		/*0x42: RF Reg[15:10] 88E*/
 		RF_T_METER_8812A, 0xfc00);
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
-		 thermal_value, rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
+		thermal_value, rtlefuse->eeprom_thermalmeter);
 	if (!rtldm->txpower_track_control ||
 	    rtlefuse->eeprom_thermalmeter == 0 ||
 	    rtlefuse->eeprom_thermalmeter == 0xFF)
@@ -1494,8 +1493,8 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 	/* 3. Initialize ThermalValues of RFCalibrateInfo*/
 
 	if (rtlhal->reloadtxpowerindex)
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "reload ofdm index for band switch\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"reload ofdm index for band switch\n");
 
 	/*4. Calculate average thermal meter*/
 	rtldm->thermalvalue_avg[rtldm->thermalvalue_avg_index] = thermal_value;
@@ -1514,9 +1513,9 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 	if (thermal_value_avg_count) {
 		thermal_value = (u8)(thermal_value_avg /
 				thermal_value_avg_count);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "AVG Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
-			 thermal_value, rtlefuse->eeprom_thermalmeter);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"AVG Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
+			thermal_value, rtlefuse->eeprom_thermalmeter);
 	}
 
 	/*5. Calculate delta, delta_LCK, delta_IQK.
@@ -1533,17 +1532,17 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 		(thermal_value - rtldm->thermalvalue_iqk) :
 		(rtldm->thermalvalue_iqk - thermal_value);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "(delta, delta_LCK, delta_IQK) = (%d, %d, %d)\n",
-		 delta, delta_lck, delta_iqk);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"(delta, delta_LCK, delta_IQK) = (%d, %d, %d)\n",
+		delta, delta_lck, delta_iqk);
 
 	/* 6. If necessary, do LCK.
 	 * Delta temperature is equal to or larger than 20 centigrade.
 	 */
 	if (delta_lck >= IQK_THRESHOLD) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "delta_LCK(%d) >= Threshold_IQK(%d)\n",
-			 delta_lck, IQK_THRESHOLD);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"delta_LCK(%d) >= Threshold_IQK(%d)\n",
+			delta_lck, IQK_THRESHOLD);
 		rtldm->thermalvalue_lck = thermal_value;
 		rtl8821ae_phy_lc_calibrate(hw);
 	}
@@ -1564,9 +1563,9 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 		/*7.1 The Final Power Index = BaseIndex + PowerIndexOffset*/
 
 		if (thermal_value > rtlefuse->eeprom_thermalmeter) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "delta_swing_table_idx_tup_a[%d] = %d\n",
-				 delta, delta_swing_table_idx_tup_a[delta]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"delta_swing_table_idx_tup_a[%d] = %d\n",
+				delta, delta_swing_table_idx_tup_a[delta]);
 			rtldm->delta_power_index_last[RF90_PATH_A] =
 				rtldm->delta_power_index[RF90_PATH_A];
 			rtldm->delta_power_index[RF90_PATH_A] =
@@ -1576,13 +1575,13 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 				delta_swing_table_idx_tup_a[delta];
 			/*Record delta swing for mix mode power tracking*/
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
 			rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "delta_swing_table_idx_tup_b[%d] = %d\n",
-				 delta, delta_swing_table_idx_tup_b[delta]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"delta_swing_table_idx_tup_b[%d] = %d\n",
+				delta, delta_swing_table_idx_tup_b[delta]);
 			rtldm->delta_power_index_last[RF90_PATH_B] =
 				rtldm->delta_power_index[RF90_PATH_B];
 			rtldm->delta_power_index[RF90_PATH_B] =
@@ -1592,13 +1591,13 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 				delta_swing_table_idx_tup_b[delta];
 			/*Record delta swing for mix mode power tracking*/
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] = %d\n",
-				 rtldm->absolute_ofdm_swing_idx[RF90_PATH_B]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] = %d\n",
+				rtldm->absolute_ofdm_swing_idx[RF90_PATH_B]);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "delta_swing_table_idx_tdown_a[%d] = %d\n",
-				 delta, delta_swing_table_idx_tdown_a[delta]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"delta_swing_table_idx_tdown_a[%d] = %d\n",
+				delta, delta_swing_table_idx_tdown_a[delta]);
 
 			rtldm->delta_power_index_last[RF90_PATH_A] =
 				rtldm->delta_power_index[RF90_PATH_A];
@@ -1608,13 +1607,13 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 			rtldm->absolute_ofdm_swing_idx[RF90_PATH_A] =
 				-1 * delta_swing_table_idx_tdown_a[delta];
 			/* Record delta swing for mix mode power tracking*/
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
-				 rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
+				rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "deltaSwingTableIdx_TDOWN_B[%d] = %d\n",
-				 delta, delta_swing_table_idx_tdown_b[delta]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"deltaSwingTableIdx_TDOWN_B[%d] = %d\n",
+				delta, delta_swing_table_idx_tdown_b[delta]);
 
 			rtldm->delta_power_index_last[RF90_PATH_B] =
 				rtldm->delta_power_index[RF90_PATH_B];
@@ -1625,15 +1624,15 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 				-1 * delta_swing_table_idx_tdown_b[delta];
 			/*Record delta swing for mix mode power tracking*/
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] = %d\n",
-				 rtldm->absolute_ofdm_swing_idx[RF90_PATH_B]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_B] = %d\n",
+				rtldm->absolute_ofdm_swing_idx[RF90_PATH_B]);
 		}
 
 		for (p = RF90_PATH_A; p < MAX_PATH_NUM_8812A; p++) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "============================= [Path-%c]Calculating PowerIndexOffset =============================\n",
-				 (p == RF90_PATH_A ? 'A' : 'B'));
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"============================= [Path-%c]Calculating PowerIndexOffset =============================\n",
+				(p == RF90_PATH_A ? 'A' : 'B'));
 
 			if (rtldm->delta_power_index[p] ==
 				rtldm->delta_power_index_last[p])
@@ -1647,12 +1646,12 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 				/* Power Index Diff between 2
 				 * times Power Tracking
 				 */
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "[Path-%c] PowerIndexOffset(%d) =DeltaPowerIndex(%d) -DeltaPowerIndexLast(%d)\n",
-				 (p == RF90_PATH_A ? 'A' : 'B'),
-				 rtldm->power_index_offset[p],
-				 rtldm->delta_power_index[p] ,
-				 rtldm->delta_power_index_last[p]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"[Path-%c] PowerIndexOffset(%d) =DeltaPowerIndex(%d) -DeltaPowerIndexLast(%d)\n",
+				(p == RF90_PATH_A ? 'A' : 'B'),
+				rtldm->power_index_offset[p],
+				rtldm->delta_power_index[p],
+				rtldm->delta_power_index_last[p]);
 
 			rtldm->ofdm_index[p] =
 					rtldm->swing_idx_ofdm_base[p] +
@@ -1666,17 +1665,17 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 
 			/****Print BB Swing Base and Index Offset */
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "The 'CCK' final index(%d) = BaseIndex(%d) + PowerIndexOffset(%d)\n",
-				 rtldm->swing_idx_cck,
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"The 'CCK' final index(%d) = BaseIndex(%d) + PowerIndexOffset(%d)\n",
+				rtldm->swing_idx_cck,
 				rtldm->swing_idx_cck_base,
 				rtldm->power_index_offset[p]);
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "The 'OFDM' final index(%d) = BaseIndex[%c](%d) + PowerIndexOffset(%d)\n",
-				 rtldm->swing_idx_ofdm[p],
-				 (p == RF90_PATH_A ? 'A' : 'B'),
-				 rtldm->swing_idx_ofdm_base[p],
-				 rtldm->power_index_offset[p]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"The 'OFDM' final index(%d) = BaseIndex[%c](%d) + PowerIndexOffset(%d)\n",
+				rtldm->swing_idx_ofdm[p],
+				(p == RF90_PATH_A ? 'A' : 'B'),
+				rtldm->swing_idx_ofdm_base[p],
+				rtldm->power_index_offset[p]);
 
 			/*7.1 Handle boundary conditions of index.*/
 
@@ -1685,32 +1684,32 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 			else if (rtldm->ofdm_index[p] < ofdm_min_index)
 				rtldm->ofdm_index[p] = ofdm_min_index;
 		}
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "\n\n====================================================================================\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"\n\n====================================================================================\n");
 		if (rtldm->cck_index > TXSCALE_TABLE_SIZE - 1)
 			rtldm->cck_index = TXSCALE_TABLE_SIZE - 1;
 		else if (rtldm->cck_index < 0)
 			rtldm->cck_index = 0;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "The thermal meter is unchanged or TxPowerTracking OFF(%d): ThermalValue: %d , pDM_Odm->RFCalibrateInfo.ThermalValue: %d\n",
-			 rtldm->txpower_track_control,
-			 thermal_value,
-			 rtldm->thermalvalue);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"The thermal meter is unchanged or TxPowerTracking OFF(%d): ThermalValue: %d , pDM_Odm->RFCalibrateInfo.ThermalValue: %d\n",
+			rtldm->txpower_track_control,
+			thermal_value,
+			rtldm->thermalvalue);
 
 		for (p = RF90_PATH_A; p < MAX_PATH_NUM_8812A; p++)
 			rtldm->power_index_offset[p] = 0;
 	}
 	/*Print Swing base & current*/
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "TxPowerTracking: [CCK] Swing Current Index: %d,Swing Base Index: %d\n",
-		 rtldm->cck_index, rtldm->swing_idx_cck_base);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxPowerTracking: [CCK] Swing Current Index: %d,Swing Base Index: %d\n",
+		rtldm->cck_index, rtldm->swing_idx_cck_base);
 	for (p = RF90_PATH_A; p < MAX_PATH_NUM_8812A; p++) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "TxPowerTracking: [OFDM] Swing Current Index: %d,Swing Base Index[%c]: %d\n",
-			 rtldm->ofdm_index[p],
-			 (p == RF90_PATH_A ? 'A' : 'B'),
-			 rtldm->swing_idx_ofdm_base[p]);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"TxPowerTracking: [OFDM] Swing Current Index: %d,Swing Base Index[%c]: %d\n",
+			rtldm->ofdm_index[p],
+			(p == RF90_PATH_A ? 'A' : 'B'),
+			rtldm->swing_idx_ofdm_base[p]);
 	}
 
 	if ((rtldm->power_index_offset[RF90_PATH_A] != 0 ||
@@ -1727,52 +1726,52 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 		 *tx power in tx agc for 88E.
 		 */
 		if (thermal_value > rtldm->thermalvalue) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature Increasing(A): delta_pi: %d , delta_t: %d, Now_t: %d,EFUSE_t: %d, Last_t: %d\n",
-				 rtldm->power_index_offset[RF90_PATH_A],
-				 delta, thermal_value,
-				 rtlefuse->eeprom_thermalmeter,
-				 rtldm->thermalvalue);
-
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature Increasing(B): delta_pi: %d ,delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-				 rtldm->power_index_offset[RF90_PATH_B],
-				 delta, thermal_value,
-				 rtlefuse->eeprom_thermalmeter,
-				 rtldm->thermalvalue);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature Increasing(A): delta_pi: %d , delta_t: %d, Now_t: %d,EFUSE_t: %d, Last_t: %d\n",
+				rtldm->power_index_offset[RF90_PATH_A],
+				delta, thermal_value,
+				rtlefuse->eeprom_thermalmeter,
+				rtldm->thermalvalue);
+
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature Increasing(B): delta_pi: %d ,delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
+				rtldm->power_index_offset[RF90_PATH_B],
+				delta, thermal_value,
+				rtlefuse->eeprom_thermalmeter,
+				rtldm->thermalvalue);
 		} else if (thermal_value < rtldm->thermalvalue) { /*Low temperature*/
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature Decreasing(A): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-				 rtldm->power_index_offset[RF90_PATH_A],
-				 delta, thermal_value,
-				 rtlefuse->eeprom_thermalmeter,
-				 rtldm->thermalvalue);
-
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature Decreasing(B): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-				 rtldm->power_index_offset[RF90_PATH_B],
-				 delta, thermal_value,
-				 rtlefuse->eeprom_thermalmeter,
-				 rtldm->thermalvalue);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature Decreasing(A): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
+				rtldm->power_index_offset[RF90_PATH_A],
+				delta, thermal_value,
+				rtlefuse->eeprom_thermalmeter,
+				rtldm->thermalvalue);
+
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature Decreasing(B): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
+				rtldm->power_index_offset[RF90_PATH_B],
+				delta, thermal_value,
+				rtlefuse->eeprom_thermalmeter,
+				rtldm->thermalvalue);
 		}
 
 		if (thermal_value > rtlefuse->eeprom_thermalmeter) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature(%d) higher than PG value(%d)\n",
-				 thermal_value, rtlefuse->eeprom_thermalmeter);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature(%d) higher than PG value(%d)\n",
+				thermal_value, rtlefuse->eeprom_thermalmeter);
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "**********Enter POWER Tracking MIX_MODE**********\n");
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"**********Enter POWER Tracking MIX_MODE**********\n");
 			for (p = RF90_PATH_A; p < MAX_PATH_NUM_8812A; p++)
 				rtl8812ae_dm_txpwr_track_set_pwr(hw, MIX_MODE,
 								 p, 0);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature(%d) lower than PG value(%d)\n",
-				 thermal_value, rtlefuse->eeprom_thermalmeter);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature(%d) lower than PG value(%d)\n",
+				thermal_value, rtlefuse->eeprom_thermalmeter);
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "**********Enter POWER Tracking MIX_MODE**********\n");
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"**********Enter POWER Tracking MIX_MODE**********\n");
 			for (p = RF90_PATH_A; p < MAX_PATH_NUM_8812A; p++)
 				rtl8812ae_dm_txpwr_track_set_pwr(hw, MIX_MODE,
 								 p, index_for_channel);
@@ -1783,9 +1782,9 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 				rtldm->swing_idx_ofdm_base[p] =
 					rtldm->swing_idx_ofdm[p];
 
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "pDM_Odm->RFCalibrateInfo.ThermalValue =%d ThermalValue= %d\n",
-			 rtldm->thermalvalue, thermal_value);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"pDM_Odm->RFCalibrateInfo.ThermalValue =%d ThermalValue= %d\n",
+			rtldm->thermalvalue, thermal_value);
 		/*Record last Power Tracking Thermal Value*/
 		rtldm->thermalvalue = thermal_value;
 	}
@@ -1794,8 +1793,8 @@ void rtl8812ae_dm_txpower_tracking_callback_thermalmeter(
 	if (delta_iqk >= IQK_THRESHOLD)
 		rtl8812ae_do_iqk(hw, delta_iqk, thermal_value, 8);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "<===rtl8812ae_dm_txpower_tracking_callback_thermalmeter\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"<===%s\n", __func__);
 }
 
 static void rtl8821ae_get_delta_swing_table(struct ieee80211_hw *hw,
@@ -1865,7 +1864,7 @@ void rtl8821ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 	if (rtldm->tx_rate != 0xFF)
 		tx_rate = rtl8821ae_hw_rate_to_mrate(hw, rtldm->tx_rate);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "===>%s\n", __func__);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "===>%s\n", __func__);
 
 	if (tx_rate != 0xFF) { /* Mimic Modify High Rate BBSwing Limit.*/
 		/*CCK*/
@@ -1908,33 +1907,33 @@ void rtl8821ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 		else
 			pwr_tracking_limit = 24;
 	}
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "TxRate=0x%x, PwrTrackingLimit=%d\n",
-		 tx_rate, pwr_tracking_limit);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxRate=0x%x, PwrTrackingLimit=%d\n",
+		tx_rate, pwr_tracking_limit);
 
 	if (method == BBSWING) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "===>%s\n", __func__);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"===>%s\n", __func__);
 		if (rf_path == RF90_PATH_A) {
 			final_swing_idx[RF90_PATH_A] =
 				(rtldm->ofdm_index[RF90_PATH_A] >
 				pwr_tracking_limit) ?
 				pwr_tracking_limit :
 				rtldm->ofdm_index[RF90_PATH_A];
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "pDM_Odm->RFCalibrateInfo.OFDM_index[ODM_RF_PATH_A]=%d,pDM_Odm->RealBbSwingIdx[ODM_RF_PATH_A]=%d\n",
-				 rtldm->ofdm_index[RF90_PATH_A],
-				 final_swing_idx[RF90_PATH_A]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"pDM_Odm->RFCalibrateInfo.OFDM_index[ODM_RF_PATH_A]=%d,pDM_Odm->RealBbSwingIdx[ODM_RF_PATH_A]=%d\n",
+				rtldm->ofdm_index[RF90_PATH_A],
+				final_swing_idx[RF90_PATH_A]);
 
 			rtl_set_bbreg(hw, RA_TXSCALE, 0xFFE00000,
 				txscaling_tbl[final_swing_idx[RF90_PATH_A]]);
 		}
 	} else if (method == MIX_MODE) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "pDM_Odm->DefaultOfdmIndex=%d,pDM_Odm->Absolute_OFDMSwingIdx[RFPath]=%d, RF_Path = %d\n",
-			 rtldm->default_ofdm_index,
-			 rtldm->absolute_ofdm_swing_idx[rf_path],
-			 rf_path);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"pDM_Odm->DefaultOfdmIndex=%d,pDM_Odm->Absolute_OFDMSwingIdx[RFPath]=%d, RF_Path = %d\n",
+			rtldm->default_ofdm_index,
+			rtldm->absolute_ofdm_swing_idx[rf_path],
+			rf_path);
 
 		final_ofdm_swing_index =
 			rtldm->default_ofdm_index +
@@ -1961,10 +1960,10 @@ void rtl8821ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 					rtlphy->current_channel,
 					RF90_PATH_A);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 					" ******Path_A Over BBSwing Limit , PwrTrackingLimit = %d , Remnant TxAGC Value = %d\n",
-					 pwr_tracking_limit,
-					 rtldm->remnant_ofdm_swing_idx[rf_path]);
+					pwr_tracking_limit,
+					rtldm->remnant_ofdm_swing_idx[rf_path]);
 			} else if (final_ofdm_swing_index < 0) {
 				rtldm->remnant_cck_idx = final_ofdm_swing_index;
 				/* CCK Follow the same compensate value as Path A*/
@@ -1980,16 +1979,16 @@ void rtl8821ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 				rtl8821ae_phy_set_txpower_level_by_path(hw,
 					rtlphy->current_channel, RF90_PATH_A);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_A Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
-					 rtldm->remnant_ofdm_swing_idx[rf_path]);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_A Lower then BBSwing lower bound  0 , Remnant TxAGC Value = %d\n",
+					rtldm->remnant_ofdm_swing_idx[rf_path]);
 			} else {
 				rtl_set_bbreg(hw, RA_TXSCALE, 0xFFE00000,
 					txscaling_tbl[(u8)final_ofdm_swing_index]);
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "******Path_A Compensate with BBSwing ,Final_OFDM_Swing_Index = %d\n",
-					 final_ofdm_swing_index);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"******Path_A Compensate with BBSwing ,Final_OFDM_Swing_Index = %d\n",
+					final_ofdm_swing_index);
 				/*If TxAGC has changed, reset TxAGC again*/
 				if (rtldm->modify_txagc_flag_path_a) {
 					rtldm->remnant_cck_idx = 0;
@@ -2001,9 +2000,9 @@ void rtl8821ae_dm_txpwr_track_set_pwr(struct ieee80211_hw *hw,
 
 					rtldm->modify_txagc_flag_path_a = false;
 
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-						 DBG_LOUD,
-						 "******Path_A pDM_Odm->Modify_TxAGC_Flag= FALSE\n");
+					rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+						DBG_LOUD,
+						"******Path_A pDM_Odm->Modify_TxAGC_Flag= FALSE\n");
 				}
 			}
 		}
@@ -2042,12 +2041,12 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 
 	rtldm->txpower_trackinginit = true;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "===>%s,\n pDM_Odm->BbSwingIdxCckBase: %d,pDM_Odm->BbSwingIdxOfdmBase[A]:%d, pDM_Odm->DefaultOfdmIndex: %d\n",
-		 __func__,
-		 rtldm->swing_idx_cck_base,
-		 rtldm->swing_idx_ofdm_base[RF90_PATH_A],
-		 rtldm->default_ofdm_index);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"===>%s,\n pDM_Odm->BbSwingIdxCckBase: %d,pDM_Odm->BbSwingIdxOfdmBase[A]:%d, pDM_Odm->DefaultOfdmIndex: %d\n",
+		__func__,
+		rtldm->swing_idx_cck_base,
+		rtldm->swing_idx_ofdm_base[RF90_PATH_A],
+		rtldm->default_ofdm_index);
 	/*0x42: RF Reg[15:10] 88E*/
 	thermal_value = (u8)rtl_get_rfreg(hw,
 		RF90_PATH_A, RF_T_METER_8812A, 0xfc00);
@@ -2059,8 +2058,8 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 	/* 3. Initialize ThermalValues of RFCalibrateInfo*/
 
 	if (rtlhal->reloadtxpowerindex) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "reload ofdm index for band switch\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"reload ofdm index for band switch\n");
 	}
 
 	/*4. Calculate average thermal meter*/
@@ -2080,9 +2079,9 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 	if (thermal_value_avg_count) {
 		thermal_value = (u8)(thermal_value_avg /
 				thermal_value_avg_count);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "AVG Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
-			 thermal_value, rtlefuse->eeprom_thermalmeter);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"AVG Thermal Meter = 0x%X, EFUSE Thermal Base = 0x%X\n",
+			thermal_value, rtlefuse->eeprom_thermalmeter);
 	}
 
 	/*5. Calculate delta, delta_LCK, delta_IQK.
@@ -2099,16 +2098,16 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 		(thermal_value - rtldm->thermalvalue_iqk) :
 		(rtldm->thermalvalue_iqk - thermal_value);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "(delta, delta_LCK, delta_IQK) = (%d, %d, %d)\n",
-		 delta, delta_lck, delta_iqk);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"(delta, delta_LCK, delta_IQK) = (%d, %d, %d)\n",
+		delta, delta_lck, delta_iqk);
 
 	/* 6. If necessary, do LCK.	*/
 	/*Delta temperature is equal to or larger than 20 centigrade.*/
 	if (delta_lck >= IQK_THRESHOLD) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "delta_LCK(%d) >= Threshold_IQK(%d)\n",
-			 delta_lck, IQK_THRESHOLD);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"delta_LCK(%d) >= Threshold_IQK(%d)\n",
+			delta_lck, IQK_THRESHOLD);
 		rtldm->thermalvalue_lck = thermal_value;
 		rtl8821ae_phy_lc_calibrate(hw);
 	}
@@ -2129,9 +2128,9 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 		/*7.1 The Final Power Index = BaseIndex + PowerIndexOffset*/
 
 		if (thermal_value > rtlefuse->eeprom_thermalmeter) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "delta_swing_table_idx_tup_a[%d] = %d\n",
-				 delta, delta_swing_table_idx_tup_a[delta]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"delta_swing_table_idx_tup_a[%d] = %d\n",
+				delta, delta_swing_table_idx_tup_a[delta]);
 			rtldm->delta_power_index_last[RF90_PATH_A] =
 				rtldm->delta_power_index[RF90_PATH_A];
 			rtldm->delta_power_index[RF90_PATH_A] =
@@ -2141,13 +2140,13 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 				delta_swing_table_idx_tup_a[delta];
 			/*Record delta swing for mix mode power tracking*/
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
-				 rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"******Temp is higher and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
+				rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "delta_swing_table_idx_tdown_a[%d] = %d\n",
-				 delta, delta_swing_table_idx_tdown_a[delta]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"delta_swing_table_idx_tdown_a[%d] = %d\n",
+				delta, delta_swing_table_idx_tdown_a[delta]);
 
 			rtldm->delta_power_index_last[RF90_PATH_A] =
 				rtldm->delta_power_index[RF90_PATH_A];
@@ -2157,15 +2156,15 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 			rtldm->absolute_ofdm_swing_idx[RF90_PATH_A] =
 				-1 * delta_swing_table_idx_tdown_a[delta];
 			/* Record delta swing for mix mode power tracking*/
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
-				 rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"******Temp is lower and pDM_Odm->Absolute_OFDMSwingIdx[ODM_RF_PATH_A] = %d\n",
+				rtldm->absolute_ofdm_swing_idx[RF90_PATH_A]);
 		}
 
 		for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "\n\n================================ [Path-%c]Calculating PowerIndexOffset ================================\n",
-				 (p == RF90_PATH_A ? 'A' : 'B'));
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"\n\n================================ [Path-%c]Calculating PowerIndexOffset ================================\n",
+				(p == RF90_PATH_A ? 'A' : 'B'));
 			/*If Thermal value changes but lookup table value
 			 * still the same
 			 */
@@ -2179,9 +2178,9 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 					rtldm->delta_power_index_last[p];
 			/*Power Index Diff between 2 times Power Tracking*/
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "[Path-%c] PowerIndexOffset(%d) = DeltaPowerIndex(%d) - DeltaPowerIndexLast(%d)\n",
-				 (p == RF90_PATH_A ? 'A' : 'B'),
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"[Path-%c] PowerIndexOffset(%d) = DeltaPowerIndex(%d) - DeltaPowerIndexLast(%d)\n",
+				(p == RF90_PATH_A ? 'A' : 'B'),
 				rtldm->power_index_offset[p],
 				rtldm->delta_power_index[p] ,
 				rtldm->delta_power_index_last[p]);
@@ -2198,17 +2197,17 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 
 			/*********Print BB Swing Base and Index Offset********/
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "The 'CCK' final index(%d) = BaseIndex(%d) + PowerIndexOffset(%d)\n",
-				 rtldm->swing_idx_cck,
-				 rtldm->swing_idx_cck_base,
-				 rtldm->power_index_offset[p]);
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "The 'OFDM' final index(%d) = BaseIndex[%c](%d) + PowerIndexOffset(%d)\n",
-				 rtldm->swing_idx_ofdm[p],
-				 (p == RF90_PATH_A ? 'A' : 'B'),
-				 rtldm->swing_idx_ofdm_base[p],
-				 rtldm->power_index_offset[p]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"The 'CCK' final index(%d) = BaseIndex(%d) + PowerIndexOffset(%d)\n",
+				rtldm->swing_idx_cck,
+				rtldm->swing_idx_cck_base,
+				rtldm->power_index_offset[p]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"The 'OFDM' final index(%d) = BaseIndex[%c](%d) + PowerIndexOffset(%d)\n",
+				rtldm->swing_idx_ofdm[p],
+				(p == RF90_PATH_A ? 'A' : 'B'),
+				rtldm->swing_idx_ofdm_base[p],
+				rtldm->power_index_offset[p]);
 
 			/*7.1 Handle boundary conditions of index.*/
 
@@ -2217,32 +2216,32 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 			else if (rtldm->ofdm_index[p] < ofdm_min_index)
 				rtldm->ofdm_index[p] = ofdm_min_index;
 		}
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "\n\n========================================================================================================\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"\n\n========================================================================================================\n");
 		if (rtldm->cck_index > TXSCALE_TABLE_SIZE - 1)
 			rtldm->cck_index = TXSCALE_TABLE_SIZE - 1;
 		else if (rtldm->cck_index < 0)
 			rtldm->cck_index = 0;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "The thermal meter is unchanged or TxPowerTracking OFF(%d):ThermalValue: %d , pDM_Odm->RFCalibrateInfo.ThermalValue: %d\n",
-			 rtldm->txpower_track_control,
-			 thermal_value,
-			 rtldm->thermalvalue);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"The thermal meter is unchanged or TxPowerTracking OFF(%d):ThermalValue: %d , pDM_Odm->RFCalibrateInfo.ThermalValue: %d\n",
+			rtldm->txpower_track_control,
+			thermal_value,
+			rtldm->thermalvalue);
 
 		for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++)
 			rtldm->power_index_offset[p] = 0;
 	}
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "TxPowerTracking: [CCK] Swing Current Index: %d, Swing Base Index: %d\n",
-		 /*Print Swing base & current*/
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxPowerTracking: [CCK] Swing Current Index: %d, Swing Base Index: %d\n",
+		/*Print Swing base & current*/
 		rtldm->cck_index, rtldm->swing_idx_cck_base);
 	for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "TxPowerTracking: [OFDM] Swing Current Index: %d, Swing Base Index[%c]: %d\n",
-			 rtldm->ofdm_index[p],
-			 (p == RF90_PATH_A ? 'A' : 'B'),
-			 rtldm->swing_idx_ofdm_base[p]);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"TxPowerTracking: [OFDM] Swing Current Index: %d, Swing Base Index[%c]: %d\n",
+			rtldm->ofdm_index[p],
+			(p == RF90_PATH_A ? 'A' : 'B'),
+			rtldm->swing_idx_ofdm_base[p]);
 	}
 
 	if ((rtldm->power_index_offset[RF90_PATH_A] != 0 ||
@@ -2259,38 +2258,38 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 		 *  set tx power in tx agc for 88E.
 		 */
 		if (thermal_value > rtldm->thermalvalue) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature Increasing(A): delta_pi: %d , delta_t: %d,Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-				 rtldm->power_index_offset[RF90_PATH_A],
-				 delta, thermal_value,
-				 rtlefuse->eeprom_thermalmeter,
-				 rtldm->thermalvalue);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature Increasing(A): delta_pi: %d , delta_t: %d,Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
+				rtldm->power_index_offset[RF90_PATH_A],
+				delta, thermal_value,
+				rtlefuse->eeprom_thermalmeter,
+				rtldm->thermalvalue);
 		} else if (thermal_value < rtldm->thermalvalue) { /*Low temperature*/
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature Decreasing(A): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
-				 rtldm->power_index_offset[RF90_PATH_A],
-				 delta, thermal_value,
-				 rtlefuse->eeprom_thermalmeter,
-				 rtldm->thermalvalue);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature Decreasing(A): delta_pi: %d , delta_t: %d, Now_t: %d, EFUSE_t: %d, Last_t: %d\n",
+				rtldm->power_index_offset[RF90_PATH_A],
+				delta, thermal_value,
+				rtlefuse->eeprom_thermalmeter,
+				rtldm->thermalvalue);
 		}
 
 		if (thermal_value > rtlefuse->eeprom_thermalmeter) {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature(%d) higher than PG value(%d)\n",
-				 thermal_value, rtlefuse->eeprom_thermalmeter);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature(%d) higher than PG value(%d)\n",
+				thermal_value, rtlefuse->eeprom_thermalmeter);
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "****Enter POWER Tracking MIX_MODE****\n");
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"****Enter POWER Tracking MIX_MODE****\n");
 			for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++)
 					rtl8821ae_dm_txpwr_track_set_pwr(hw,
 						MIX_MODE, p, index_for_channel);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Temperature(%d) lower than PG value(%d)\n",
-				 thermal_value, rtlefuse->eeprom_thermalmeter);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Temperature(%d) lower than PG value(%d)\n",
+				thermal_value, rtlefuse->eeprom_thermalmeter);
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "*****Enter POWER Tracking MIX_MODE*****\n");
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"*****Enter POWER Tracking MIX_MODE*****\n");
 			for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++)
 				rtl8812ae_dm_txpwr_track_set_pwr(hw,
 					MIX_MODE, p, index_for_channel);
@@ -2300,9 +2299,9 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 		for (p = RF90_PATH_A; p < MAX_PATH_NUM_8821A; p++)
 			rtldm->swing_idx_ofdm_base[p] = rtldm->swing_idx_ofdm[p];
 
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "pDM_Odm->RFCalibrateInfo.ThermalValue = %d ThermalValue= %d\n",
-			 rtldm->thermalvalue, thermal_value);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"pDM_Odm->RFCalibrateInfo.ThermalValue = %d ThermalValue= %d\n",
+			rtldm->thermalvalue, thermal_value);
 		/*Record last Power Tracking Thermal Value*/
 		rtldm->thermalvalue = thermal_value;
 	}
@@ -2323,7 +2322,7 @@ void rtl8821ae_dm_txpower_tracking_callback_thermalmeter(
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===%s\n", __func__);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===%s\n", __func__);
 }
 
 void rtl8821ae_dm_check_txpower_tracking_thermalmeter(struct ieee80211_hw *hw)
@@ -2332,13 +2331,13 @@ void rtl8821ae_dm_check_txpower_tracking_thermalmeter(struct ieee80211_hw *hw)
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER_88E, BIT(17)|BIT(16),
 			      0x03);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Trigger 8821ae Thermal Meter!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Trigger 8821ae Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Schedule TxPowerTracking !!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Schedule TxPowerTracking !!\n");
 
 		rtl8821ae_dm_txpower_tracking_callback_thermalmeter(hw);
 		rtlpriv->dm.tm_trigger = 0;
@@ -2357,14 +2356,14 @@ static void rtl8821ae_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
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
 
@@ -2392,14 +2391,14 @@ static void rtl8821ae_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
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
@@ -2454,22 +2453,22 @@ static void rtl8821ae_dm_edca_choose_traffic_idx(
 	if (b_bias_on_rx) {
 		if (cur_tx_bytes > (cur_rx_bytes*4)) {
 			*pb_is_cur_rdl_state = false;
-			RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-				 "Uplink Traffic\n");
+			rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+				"Uplink Traffic\n");
 		} else {
 			*pb_is_cur_rdl_state = true;
-			RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-				 "Balance Traffic\n");
+			rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+				"Balance Traffic\n");
 		}
 	} else {
 		if (cur_rx_bytes > (cur_tx_bytes*4)) {
 			*pb_is_cur_rdl_state = true;
-			RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-				 "Downlink	Traffic\n");
+			rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+				"Downlink	Traffic\n");
 		} else {
 			*pb_is_cur_rdl_state = false;
-			RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-				 "Balance Traffic\n");
+			rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+				"Balance Traffic\n");
 		}
 	}
 	return;
@@ -2492,11 +2491,11 @@ static void rtl8821ae_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	bool b_bias_on_rx = false;
 	bool b_edca_turbo_on = false;
 
-	RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-		 "rtl8821ae_dm_check_edca_turbo=====>\n");
-	RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-		 "Original BE PARAM: 0x%x\n",
-		 rtl_read_dword(rtlpriv, DM_REG_EDCA_BE_11N));
+	rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+		"%s=====>\n", __func__);
+	rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+		"Original BE PARAM: 0x%x\n",
+		rtl_read_dword(rtlpriv, DM_REG_EDCA_BE_11N));
 
 	if (rtlpriv->dm.dbginfo.num_non_be_pkt > 0x100)
 		rtlpriv->dm.is_any_nonbepkts = true;
@@ -2528,20 +2527,20 @@ static void rtl8821ae_dm_check_edca_turbo(struct ieee80211_hw *hw)
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-		 "bIsAnyNonBEPkts : 0x%x  bDisableFrameBursting : 0x%x\n",
-		 rtlpriv->dm.is_any_nonbepkts,
-		 rtlpriv->dm.disable_framebursting);
+	rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+		"bIsAnyNonBEPkts : 0x%x  bDisableFrameBursting : 0x%x\n",
+		rtlpriv->dm.is_any_nonbepkts,
+		rtlpriv->dm.disable_framebursting);
 
-	RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-		 "bEdcaTurboOn : 0x%x bBiasOnRx : 0x%x\n",
-		 b_edca_turbo_on, b_bias_on_rx);
+	rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+		"bEdcaTurboOn : 0x%x bBiasOnRx : 0x%x\n",
+		b_edca_turbo_on, b_bias_on_rx);
 
 	if (b_edca_turbo_on) {
-		RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-			 "curTxOkCnt : 0x%llx\n", cur_tx_ok_cnt);
-		RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-			 "curRxOkCnt : 0x%llx\n", cur_rx_ok_cnt);
+		rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+			"curTxOkCnt : 0x%llx\n", cur_tx_ok_cnt);
+		rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+			"curRxOkCnt : 0x%llx\n", cur_rx_ok_cnt);
 		if (b_bias_on_rx)
 			rtl8821ae_dm_edca_choose_traffic_idx(hw, cur_tx_ok_cnt,
 				cur_rx_ok_cnt, true, pb_is_cur_rdl_state);
@@ -2553,14 +2552,14 @@ static void rtl8821ae_dm_check_edca_turbo(struct ieee80211_hw *hw)
 
 		rtl_write_dword(rtlpriv, DM_REG_EDCA_BE_11N, edca_be);
 
-		RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-			 "EDCA Turbo on: EDCA_BE:0x%x\n", edca_be);
+		rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+			"EDCA Turbo on: EDCA_BE:0x%x\n", edca_be);
 
 		rtlpriv->dm.current_turbo_edca = true;
 
-		RT_TRACE(rtlpriv, COMP_TURBO, DBG_LOUD,
-			 "EDCA_BE_DL : 0x%x  EDCA_BE_UL : 0x%x  EDCA_BE : 0x%x\n",
-			 edca_be_dl, edca_be_ul, edca_be);
+		rtl_dbg(rtlpriv, COMP_TURBO, DBG_LOUD,
+			"EDCA_BE_DL : 0x%x  EDCA_BE_UL : 0x%x  EDCA_BE : 0x%x\n",
+			edca_be_dl, edca_be_ul, edca_be);
 	} else {
 		if (rtlpriv->dm.current_turbo_edca) {
 			u8 tmp = AC0_BE;
@@ -2606,8 +2605,8 @@ static void rtl8821ae_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 
 	dm_digtable->pre_cck_cca_thres = dm_digtable->cur_cck_cca_thres;
 	dm_digtable->cur_cck_cca_thres = cur_cck_cca_thresh;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "CCK cca thresh hold =%x\n", dm_digtable->cur_cck_cca_thres);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"CCK cca thresh hold =%x\n", dm_digtable->cur_cck_cca_thres);
 }
 
 static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
@@ -2626,9 +2625,9 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 			rtldm->atc_status = ATC_STATUS_ON;
 		}
 
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "No link!!\n");
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "atc_status = %d\n", rtldm->atc_status);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "No link!!\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"atc_status = %d\n", rtldm->atc_status);
 
 		if (rtldm->crystal_cap != rtlpriv->efuse.crystalcap) {
 			rtldm->crystal_cap = rtlpriv->efuse.crystalcap;
@@ -2643,8 +2642,8 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 					      0xfff000, (crystal_cap |
 					      (crystal_cap << 6)));
 		}
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "crystal_cap = 0x%x\n",
-			 rtldm->crystal_cap);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "crystal_cap = 0x%x\n",
+			rtldm->crystal_cap);
 	} else{
 		/*1. Calculate CFO for path-A & path-B*/
 		cfo_khz_a = (int)(rtldm->cfo_tail[0] * 3125) / 1280;
@@ -2653,15 +2652,15 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 
 		/*2.No new packet*/
 		if (packet_count == rtldm->packet_count_pre) {
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "packet counter doesn't change\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"packet counter doesn't change\n");
 			return;
 		}
 
 		rtldm->packet_count_pre = packet_count;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "packet counter = %d\n",
-			 rtldm->packet_count);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"packet counter = %d\n",
+			rtldm->packet_count);
 
 		/*3.Average CFO*/
 		if (rtlpriv->phy.rf_type == RF_1T1R)
@@ -2669,9 +2668,9 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 		else
 			cfo_ave = (cfo_khz_a + cfo_khz_b) >> 1;
 
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "cfo_khz_a = %dkHz, cfo_khz_b = %dkHz, cfo_ave = %dkHz\n",
-			 cfo_khz_a, cfo_khz_b, cfo_ave);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"cfo_khz_a = %dkHz, cfo_khz_b = %dkHz, cfo_ave = %dkHz\n",
+			cfo_khz_a, cfo_khz_b, cfo_ave);
 
 		/*4.Avoid abnormal large CFO*/
 		cfo_ave_diff = (rtldm->cfo_ave_pre >= cfo_ave) ?
@@ -2679,8 +2678,8 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 						(cfo_ave - rtldm->cfo_ave_pre);
 
 		if (cfo_ave_diff > 20 && rtldm->large_cfo_hit == 0) {
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "first large CFO hit\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"first large CFO hit\n");
 			rtldm->large_cfo_hit = 1;
 			return;
 		} else
@@ -2701,9 +2700,9 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 				rtldm->cfo_threshold = CFO_THRESHOLD_XTAL;
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "Dynamic threshold = %d\n",
-			 rtldm->cfo_threshold);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"Dynamic threshold = %d\n",
+			rtldm->cfo_threshold);
 
 		/* 2.Calculate Xtal offset*/
 		if (cfo_ave > rtldm->cfo_threshold && rtldm->crystal_cap < 0x3f)
@@ -2711,9 +2710,9 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 		else if ((cfo_ave < -rtlpriv->dm.cfo_threshold) &&
 			 rtlpriv->dm.crystal_cap > 0)
 			adjust_xtal = ((cfo_ave + CFO_THRESHOLD_XTAL) >> 2) - 1;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "Crystal cap = 0x%x, Crystal cap offset = %d\n",
-			 rtldm->crystal_cap, adjust_xtal);
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"Crystal cap = 0x%x, Crystal cap offset = %d\n",
+			rtldm->crystal_cap, adjust_xtal);
 
 		/*3.Adjudt Crystal Cap.*/
 		if (adjust_xtal != 0) {
@@ -2735,9 +2734,9 @@ static void rtl8821ae_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 				rtl_set_bbreg(hw, REG_MAC_PHY_CTRL,
 					      0xfff000, (crystal_cap |
 					      (crystal_cap << 6)));
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "New crystal cap = 0x%x\n",
-				 rtldm->crystal_cap);
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"New crystal cap = 0x%x\n",
+				rtldm->crystal_cap);
 		}
 	}
 }
@@ -2781,7 +2780,7 @@ void rtl8821ae_dm_watchdog(struct ieee80211_hw *hw)
 	spin_unlock(&rtlpriv->locks.rf_ps_lock);
 
 	rtlpriv->dm.dbginfo.num_qry_beacon_pkt = 0;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_DMESG, "\n");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_DMESG, "\n");
 }
 
 void rtl8821ae_dm_set_tx_ant_by_tx_info(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c
index fe32d397d287..1ae56e15ca7f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.c
@@ -39,7 +39,7 @@ static void _rtl8821ae_write_fw(struct ieee80211_hw *hw,
 	u32 pagenums, remainsize;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
 
 	rtl_fill_dummy(bufferptr, &size);
 
@@ -75,9 +75,9 @@ static int _rtl8821ae_fw_free_to_go(struct ieee80211_hw *hw)
 		 (!(value32 & FWDL_CHKSUM_RPT)));
 
 	if (counter >= FW_8821AE_POLLING_TIMEOUT_COUNT) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "chksum report fail! REG_MCUFWDL:0x%08x .\n",
-			  value32);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"chksum report fail! REG_MCUFWDL:0x%08x .\n",
+			value32);
 		goto exit;
 	}
 	value32 = rtl_read_dword(rtlpriv, REG_MCUFWDL);
@@ -154,15 +154,15 @@ int rtl8821ae_download_fw(struct ieee80211_hw *hw, bool buse_wake_on_wlan_fw)
 		fwsize = rtlhal->fwsize;
 	}
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "%s Firmware SIZE %d\n",
-		 buse_wake_on_wlan_fw ? "Wowlan" : "Normal", fwsize);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"%s Firmware SIZE %d\n",
+		buse_wake_on_wlan_fw ? "Wowlan" : "Normal", fwsize);
 
 	if (IS_FW_HEADER_EXIST_8812(pfwheader) ||
 	    IS_FW_HEADER_EXIST_8821(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Firmware Version(%d), Signature(%#x)\n",
-			 pfwheader->version, pfwheader->signature);
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Firmware Version(%d), Signature(%#x)\n",
+			pfwheader->version, pfwheader->signature);
 
 		pfwdata = pfwdata + sizeof(struct rtlwifi_firmware_header);
 		fwsize = fwsize - sizeof(struct rtlwifi_firmware_header);
@@ -180,11 +180,11 @@ int rtl8821ae_download_fw(struct ieee80211_hw *hw, bool buse_wake_on_wlan_fw)
 
 	err = _rtl8821ae_fw_free_to_go(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-			 "Firmware is not ready to run!\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+			"Firmware is not ready to run!\n");
 	} else {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-			 "Firmware is ready to run!\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+			"Firmware is ready to run!\n");
 	}
 
 	return 0;
@@ -199,13 +199,13 @@ void rtl8821ae_set_fw_related_for_wowlan(struct ieee80211_hw *hw,
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	/* 1. Before WoWLAN or After WOWLAN we need to re-download Fw. */
 	if (rtl8821ae_download_fw(hw, used_wowlan_fw)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Re-Download Firmware failed!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Re-Download Firmware failed!!\n");
 		rtlhal->fw_ready = false;
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "Re-Download Firmware Success !!\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"Re-Download Firmware Success !!\n");
 	rtlhal->fw_ready = true;
 
 	/* 2. Re-Init the variables about Fw related setting. */
@@ -249,22 +249,22 @@ static void _rtl8821ae_fill_h2c_command(struct ieee80211_hw *hw,
 	unsigned long flag = 0;
 	u8 idx = 0;
 
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
@@ -300,8 +300,8 @@ static void _rtl8821ae_fill_h2c_command(struct ieee80211_hw *hw,
 			box_extreg = REG_HMEBOX_EXT_3;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", boxnum);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", boxnum);
 			break;
 		}
 
@@ -324,9 +324,9 @@ static void _rtl8821ae_fill_h2c_command(struct ieee80211_hw *hw,
 				/*wait until Fw read*/
 				wait_h2c_limmit--;
 				if (wait_h2c_limmit == 0) {
-					RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-						 "Waiting too long for FW read clear HMEBox(%d)!\n",
-						 boxnum);
+					rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+						"Waiting too long for FW read clear HMEBox(%d)!\n",
+						boxnum);
 					break;
 				}
 
@@ -335,25 +335,25 @@ static void _rtl8821ae_fill_h2c_command(struct ieee80211_hw *hw,
 				isfw_read =
 				  _rtl8821ae_check_fw_read_last_h2c(hw, boxnum);
 				u1b_tmp = rtl_read_byte(rtlpriv, 0x130);
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-					 "Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
-					 boxnum, u1b_tmp);
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
+					boxnum, u1b_tmp);
 			}
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
@@ -389,8 +389,8 @@ static void _rtl8821ae_fill_h2c_command(struct ieee80211_hw *hw,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", cmd_len);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", cmd_len);
 			break;
 		}
 
@@ -400,16 +400,16 @@ static void _rtl8821ae_fill_h2c_command(struct ieee80211_hw *hw,
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
 
 void rtl8821ae_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -458,8 +458,8 @@ void rtl8821ae_firmware_selfreset(struct ieee80211_hw *hw)
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN+1);
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN+1, (u1b_tmp | BIT(2)));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "_8051Reset8812ae(): 8051 reset success .\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"_8051Reset8812ae(): 8051 reset success .\n");
 }
 
 void rtl8821ae_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
@@ -478,8 +478,8 @@ void rtl8821ae_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	if (bt_ctrl_lps)
 		mode = (bt_lps_on ? FW_PS_MIN_MODE : FW_PS_ACTIVE_MODE);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "FW LPS mode = %d (coex:%d)\n",
-		 mode, bt_ctrl_lps);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG, "FW LPS mode = %d (coex:%d)\n",
+		mode, bt_ctrl_lps);
 
 	switch (mode) {
 	case FW_PS_MIN_MODE:
@@ -590,7 +590,7 @@ void rtl8821ae_set_fw_wowlan_mode(struct ieee80211_hw *hw, bool func_en)
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 	u8 fw_wowlan_info[H2C_8821AE_WOWLAN_LENGTH] = {0};
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "enable(%d)\n", func_en);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "enable(%d)\n", func_en);
 
 	SET_8812_H2CCMD_WOWLAN_FUNC_ENABLE(fw_wowlan_info,
 					   (func_en ? true : false));
@@ -624,9 +624,9 @@ void rtl8821ae_set_fw_remote_wake_ctrl_cmd(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u8 remote_wake_ctrl_parm[H2C_8821AE_REMOTE_WAKE_CTRL_LEN] = {0};
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-		 "enable=%d, ARP offload=%d, GTK offload=%d\n",
-		 enable, ppsc->arp_offload_enable, ppsc->gtk_offload_enable);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+		"enable=%d, ARP offload=%d, GTK offload=%d\n",
+		enable, ppsc->arp_offload_enable, ppsc->gtk_offload_enable);
 
 	SET_8812_H2CCMD_REMOTE_WAKECTRL_ENABLE(remote_wake_ctrl_parm, enable);
 	SET_8812_H2CCMD_REMOTE_WAKE_CTRL_ARP_OFFLOAD_EN(remote_wake_ctrl_parm,
@@ -651,7 +651,7 @@ void rtl8821ae_set_fw_keep_alive_cmd(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 keep_alive_info[H2C_8821AE_KEEP_ALIVE_CTRL_LENGTH] = {0};
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Enable(%d)\n", func_en);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Enable(%d)\n", func_en);
 
 	SET_8812_H2CCMD_KEEP_ALIVE_ENABLE(keep_alive_info, func_en);
 	/* 1: the period is controled by driver, 0: by Fw default */
@@ -690,9 +690,9 @@ void rtl8821ae_set_fw_global_info_cmd(struct ieee80211_hw *hw)
 	struct rtl_security *sec = &rtlpriv->sec;
 	u8 remote_wakeup_sec_info[H2C_8821AE_AOAC_GLOBAL_INFO_LEN] = {0};
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-		 "PairwiseEncAlgorithm=%d, GroupEncAlgorithm=%d\n",
-		 sec->pairwise_enc_algorithm, sec->group_enc_algorithm);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+		"PairwiseEncAlgorithm=%d, GroupEncAlgorithm=%d\n",
+		sec->pairwise_enc_algorithm, sec->group_enc_algorithm);
 
 	SET_8812_H2CCMD_AOAC_GLOBAL_INFO_PAIRWISE_ENC_ALG(
 						remote_wakeup_sec_info,
@@ -1646,8 +1646,8 @@ void rtl8812ae_set_fw_rsvdpagepkt(struct ieee80211_hw *hw,
 	}
 
 	if (!b_dlok)
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 
 void rtl8821ae_set_fw_rsvdpagepkt(struct ieee80211_hw *hw,
@@ -1771,8 +1771,8 @@ void rtl8821ae_set_fw_rsvdpagepkt(struct ieee80211_hw *hw,
 		b_dlok = true;
 
 	if (!b_dl_finished && b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Set RSVD page location to Fw.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 				"H2C_RSVDPAGE:\n", u1rsvdpageloc, 5);
 		rtl8821ae_fill_h2c_cmd(hw, H2C_8821AE_RSVDPAGE,
@@ -1788,8 +1788,8 @@ void rtl8821ae_set_fw_rsvdpagepkt(struct ieee80211_hw *hw,
 	}
 
 	if (!b_dlok) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 	}
 }
 
@@ -1815,11 +1815,11 @@ void rtl8821ae_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
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
@@ -1873,11 +1873,11 @@ void rtl8821ae_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
index 198d419ebb9c..0212a85e7488 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c
@@ -143,9 +143,9 @@ static void _rtl8821ae_set_fw_clock_on(struct ieee80211_hw *hw,
 			if (content & IMR_CPWM) {
 				rtl_write_word(rtlpriv, isr_regaddr, 0x0100);
 				rtlhal->fw_ps_state = FW_PS_STATE_RF_ON_8821AE;
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-					 "Receive CPWM INT!!! Set rtlhal->FwPSState = %X\n",
-					 rtlhal->fw_ps_state);
+				rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+					"Receive CPWM INT!!! Set rtlhal->FwPSState = %X\n",
+					rtlhal->fw_ps_state);
 			}
 		}
 
@@ -330,8 +330,8 @@ static void _rtl8821ae_download_rsvd_page(struct ieee80211_hw *hw,
 	} while (!(bcnvalid_reg & BIT(0)) && dlbcn_count < 5);
 
 	if (!(bcnvalid_reg & BIT(0)))
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Download RSVD page failed!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Download RSVD page failed!\n");
 	if (bcnvalid_reg & BIT(0) && rtlhal->enter_pnp_sleep) {
 		rtl_write_byte(rtlpriv, REG_TDECTRL + 2, bcnvalid_reg | BIT(0));
 		_rtl8821ae_return_beacon_queue_skb(hw);
@@ -365,8 +365,8 @@ static void _rtl8821ae_download_rsvd_page(struct ieee80211_hw *hw,
 			} while (!(bcnvalid_reg & BIT(0)) && dlbcn_count < 5);
 
 			if (!(bcnvalid_reg & BIT(0)))
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "2 Download RSVD page failed!\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"2 Download RSVD page failed!\n");
 		}
 	}
 
@@ -458,8 +458,8 @@ void rtl8821ae_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			*((bool *)(val)) = false;
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -511,8 +511,8 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "HW_VAR_SLOT_TIME %x\n", val[0]);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 
@@ -558,9 +558,9 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 			*val = min_spacing_to_set;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-				  mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+				mac->min_space_cfg);
 
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
@@ -572,9 +572,9 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -632,9 +632,9 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -649,16 +649,16 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
 		break; }
 	case HW_VAR_RCR:
@@ -761,9 +761,9 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		u32	us_nav_upper = *(u32 *)val;
 
 		if (us_nav_upper > HAL_92C_NAV_UPPER_UNIT * 0xFF) {
-			RT_TRACE(rtlpriv, COMP_INIT , DBG_WARNING,
-				 "The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n",
-				 us_nav_upper, HAL_92C_NAV_UPPER_UNIT);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
+				"The setting value (0x%08X us) of NAV_UPPER is larger than (%d * 0xFF)!!!\n",
+				us_nav_upper, HAL_92C_NAV_UPPER_UNIT);
 			break;
 		}
 		rtl_write_byte(rtlpriv, REG_NAV_UPPER,
@@ -779,8 +779,8 @@ void rtl8821ae_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				       array);
 		break; }
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -910,16 +910,16 @@ static bool _rtl8821ae_init_mac(struct ieee80211_hw *hw)
 		if (!rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_ALL_MSK,
 					      PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK,
 					      RTL8812_NIC_ENABLE_FLOW)) {
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "init 8812 MAC Fail as power on failure\n");
-				return false;
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"init 8812 MAC Fail as power on failure\n");
+			return false;
 		}
 	} else {
 		/* HW Power on sequence */
 		if (!rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_A_MSK,
 					      PWR_FAB_ALL_MSK, PWR_INTF_PCI_MSK,
 					      RTL8821A_NIC_ENABLE_FLOW)){
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 				"init 8821 MAC Fail as power on failure\n");
 			return false;
 		}
@@ -1161,14 +1161,14 @@ void rtl8821ae_enable_hw_security_config(struct ieee80211_hw *hw)
 	u8 sec_reg_value;
 	u8 tmp;
 
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
 
@@ -1184,8 +1184,8 @@ void rtl8821ae_enable_hw_security_config(struct ieee80211_hw *hw)
 	tmp = rtl_read_byte(rtlpriv, REG_CR + 1);
 	rtl_write_byte(rtlpriv, REG_CR + 1, tmp | BIT(1));
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
@@ -1207,10 +1207,10 @@ static void rtl8821ae_macid_initialize_mediastatus(struct ieee80211_hw *hw)
 	rtlpriv->cfg->ops->set_hw_reg(hw,
 		HW_VAR_H2C_FW_MEDIASTATUSRPT, media_rpt);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Initialize MacId media status: from %d to %d\n",
-		 MAC_ID_STATIC_FOR_BROADCAST_MULTICAST,
-		 MAC_ID_STATIC_FOR_BT_CLIENT_END);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Initialize MacId media status: from %d to %d\n",
+		MAC_ID_STATIC_FOR_BROADCAST_MULTICAST,
+		MAC_ID_STATIC_FOR_BT_CLIENT_END);
 }
 
 static bool _rtl8821ae_check_pcie_dma_hang(struct ieee80211_hw *hw)
@@ -1229,8 +1229,8 @@ static bool _rtl8821ae_check_pcie_dma_hang(struct ieee80211_hw *hw)
 	/* read reg 0x350 Bit[24] if 1 : TX hang */
 	tmp = rtl_read_byte(rtlpriv, REG_DBI_CTRL + 3);
 	if ((tmp & BIT(0)) || (tmp & BIT(1))) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "CheckPcieDMAHang8821AE(): true! Reset PCIE DMA!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"CheckPcieDMAHang8821AE(): true! Reset PCIE DMA!\n");
 		return true;
 	} else {
 		return false;
@@ -1247,7 +1247,7 @@ static bool _rtl8821ae_reset_pcie_interface_dma(struct ieee80211_hw *hw,
 	bool release_mac_rx_pause;
 	u8 backup_pcie_dma_pause;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 
 	/* 1. Disable register write lock. 0x1c[1] = 0 */
 	tmp = rtl_read_byte(rtlpriv, REG_RSV_CTRL);
@@ -1346,8 +1346,8 @@ static void _rtl8821ae_get_wakeup_reason(struct ieee80211_hw *hw)
 
 	fw_reason = rtl_read_byte(rtlpriv, REG_MCUTST_WOWLAN);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "WOL Read 0x1c7 = %02X\n",
-		 fw_reason);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "WOL Read 0x1c7 = %02X\n",
+		fw_reason);
 
 	ppsc->wakeup_reason = 0;
 
@@ -1356,63 +1356,63 @@ static void _rtl8821ae_get_wakeup_reason(struct ieee80211_hw *hw)
 	switch (fw_reason) {
 	case FW_WOW_V2_PTK_UPDATE_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_PTK_UPDATE;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a WOL PTK Key update event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a WOL PTK Key update event!\n");
 		break;
 	case FW_WOW_V2_GTK_UPDATE_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_GTK_UPDATE;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a WOL GTK Key update event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a WOL GTK Key update event!\n");
 		break;
 	case FW_WOW_V2_DISASSOC_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_DISASSOC;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a disassociation event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a disassociation event!\n");
 		break;
 	case FW_WOW_V2_DEAUTH_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_DEAUTH;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a deauth event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a deauth event!\n");
 		break;
 	case FW_WOW_V2_FW_DISCONNECT_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_AP_LOST;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a Fw disconnect decision (AP lost) event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a Fw disconnect decision (AP lost) event!\n");
 	break;
 	case FW_WOW_V2_MAGIC_PKT_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_MAGIC_PKT;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a magic packet event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a magic packet event!\n");
 		break;
 	case FW_WOW_V2_UNICAST_PKT_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_UNICAST_PKT;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's an unicast packet event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's an unicast packet event!\n");
 		break;
 	case FW_WOW_V2_PATTERN_PKT_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_PATTERN_PKT;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's a pattern match event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's a pattern match event!\n");
 		break;
 	case FW_WOW_V2_RTD3_SSID_MATCH_EVENT:
 		ppsc->wakeup_reason = WOL_REASON_RTD3_SSID_MATCH;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's an RTD3 Ssid match event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's an RTD3 Ssid match event!\n");
 		break;
 	case FW_WOW_V2_REALWOW_V2_WAKEUPPKT:
 		ppsc->wakeup_reason = WOL_REASON_REALWOW_V2_WAKEUPPKT;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's an RealWoW wake packet event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's an RealWoW wake packet event!\n");
 		break;
 	case FW_WOW_V2_REALWOW_V2_ACKLOST:
 		ppsc->wakeup_reason = WOL_REASON_REALWOW_V2_ACKLOST;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "It's an RealWoW ack lost event!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"It's an RealWoW ack lost event!\n");
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "WOL Read 0x1c7 = %02X, Unknown reason!\n",
-			  fw_reason);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"WOL Read 0x1c7 = %02X, Unknown reason!\n",
+			fw_reason);
 		break;
 	}
 }
@@ -1484,9 +1484,9 @@ static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
 	rtlpriv->cfg->ops->get_hw_reg(hw, HAL_DEF_WOWLAN,
 				      (u8 *)(&support_remote_wakeup));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "boundary=%#X, NPQ_RQPNValue=%#X, RQPNValue=%#X\n",
-		  boundary, npq_rqpn_value, rqpn_val);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"boundary=%#X, NPQ_RQPNValue=%#X, RQPNValue=%#X\n",
+		boundary, npq_rqpn_value, rqpn_val);
 
 	/* stop PCIe DMA
 	 * 1. 0x301[7:0] = 0xFE */
@@ -1500,12 +1500,12 @@ static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
 		tmp16 = rtl_read_word(rtlpriv, REG_TXPKT_EMPTY);
 		count++;
 		if ((count % 200) == 0) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Tx queue is not empty for 20ms!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Tx queue is not empty for 20ms!\n");
 		}
 		if (count >= 1000) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Wait for Tx FIFO empty timeout!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Wait for Tx FIFO empty timeout!\n");
 			break;
 		}
 	}
@@ -1521,8 +1521,8 @@ static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
 		udelay(100);
 		count++;
 		if (count >= 500) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Wait for TX State Machine ready timeout !!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Wait for TX State Machine ready timeout !!\n");
 			break;
 		}
 	}
@@ -1540,9 +1540,9 @@ static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
 		count++;
 	} while (!(tmp & BIT(1)) && count < 100);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Wait until Rx DMA Idle. count=%d REG[0x286]=0x%x\n",
-		  count, tmp);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Wait until Rx DMA Idle. count=%d REG[0x286]=0x%x\n",
+		count, tmp);
 
 	/* reset BB
 	 * 7.	0x02 [0] = 0 */
@@ -1599,8 +1599,8 @@ static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
 	/* init LLT
 	 * 17. init LLT */
 	if (!_rtl8821ae_init_llt_table(hw, boundary)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_WARNING,
-			 "Failed to init LLT table!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
+			"Failed to init LLT table!\n");
 		return false;
 	}
 
@@ -1620,7 +1620,7 @@ static bool _rtl8821ae_dynamic_rqpn(struct ieee80211_hw *hw, u32 boundary,
 	tmp = rtl_read_byte(rtlpriv, REG_RXDMA_CONTROL);
 	rtl_write_byte(rtlpriv, REG_RXDMA_CONTROL, (tmp&~BIT(2)));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "End.\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "End.\n");
 	return ret;
 }
 
@@ -1655,12 +1655,12 @@ static void _rtl8821ae_enable_l1off(struct ieee80211_hw *hw)
 	u8 tmp  = 0;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "--->\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "--->\n");
 
 	tmp = _rtl8821ae_dbi_read(rtlpriv, 0x160);
 	if (!(tmp & (BIT(2) | BIT(3)))) {
-		RT_TRACE(rtlpriv, COMP_POWER | COMP_INIT, DBG_LOUD,
-			 "0x160(%#x)return!!\n", tmp);
+		rtl_dbg(rtlpriv, COMP_POWER | COMP_INIT, DBG_LOUD,
+			"0x160(%#x)return!!\n", tmp);
 		return;
 	}
 
@@ -1670,7 +1670,7 @@ static void _rtl8821ae_enable_l1off(struct ieee80211_hw *hw)
 	tmp = _rtl8821ae_dbi_read(rtlpriv, 0x718);
 	_rtl8821ae_dbi_write(rtlpriv, 0x718, tmp | BIT(5));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<---\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<---\n");
 }
 
 static void _rtl8821ae_enable_ltr(struct ieee80211_hw *hw)
@@ -1678,13 +1678,13 @@ static void _rtl8821ae_enable_ltr(struct ieee80211_hw *hw)
 	u8 tmp  = 0;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "--->\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "--->\n");
 
 	/* Check 0x98[10] */
 	tmp = _rtl8821ae_dbi_read(rtlpriv, 0x99);
 	if (!(tmp & BIT(2))) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "<---0x99(%#x) return!!\n", tmp);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"<---0x99(%#x) return!!\n", tmp);
 		return;
 	}
 
@@ -1701,7 +1701,7 @@ static void _rtl8821ae_enable_ltr(struct ieee80211_hw *hw)
 	rtl_write_byte(rtlpriv, 0x7a4, (tmp & (~BIT(0))));
 	rtl_write_byte(rtlpriv, 0x7a4, (tmp | BIT(0)));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<---\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<---\n");
 }
 
 static bool _rtl8821ae_wowlan_initialize_adapter(struct ieee80211_hw *hw)
@@ -1724,14 +1724,14 @@ static bool _rtl8821ae_wowlan_initialize_adapter(struct ieee80211_hw *hw)
 
 	/* Release Pcie Interface Rx DMA to allow wake packet DMA. */
 	rtl_write_byte(rtlpriv, REG_PCIE_CTRL_REG + 1, 0xFE);
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Enable PCIE Rx DMA.\n");
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Enable PCIE Rx DMA.\n");
 
 	/* Check wake up event.
 	 * We should check wake packet bit before disable wowlan by H2C or
 	 * Fw will clear the bit. */
 	tmp = rtl_read_byte(rtlpriv, REG_FTISR + 3);
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-		 "Read REG_FTISR 0x13f = %#X\n", tmp);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+		"Read REG_FTISR 0x13f = %#X\n", tmp);
 
 	/* Set the WoWLAN related function control disable. */
 	rtl8821ae_set_fw_wowlan_mode(hw, false);
@@ -1796,7 +1796,7 @@ static void _rtl8821ae_poweroff_adapter(struct ieee80211_hw *hw)
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) {
 		/* Combo (PCIe + USB) Card and PCIe-MF Card */
 		/* 1. Run LPS WL RFOFF flow */
-		/* RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		/* rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 		"=====>CardDisableRTL8812E,RTL8821A_NIC_LPS_ENTER_FLOW\n");
 		*/
 		rtl_hal_pwrseqcmdparsing(rtlpriv,
@@ -1862,8 +1862,8 @@ int rtl8821ae_hw_init(struct ieee80211_hw *hw)
 	tmp_u1b = rtl_read_byte(rtlpriv, REG_CR);
 	if (tmp_u1b != 0 && tmp_u1b != 0xEA) {
 		rtlhal->mac_func_enable = true;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "MAC has already power on.\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MAC has already power on.\n");
 	} else {
 		rtlhal->mac_func_enable = false;
 		rtlhal->fw_ps_state = FW_PS_STATE_ALL_ON_8821AE;
@@ -1907,8 +1907,8 @@ int rtl8821ae_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl8821ae_download_fw(hw, false);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now\n");
 		err = 1;
 		rtlhal->fw_ready = false;
 		return err;
@@ -1987,7 +1987,7 @@ int rtl8821ae_hw_init(struct ieee80211_hw *hw)
 	rtl8821ae_dm_init(hw);
 	rtl8821ae_macid_initialize_mediastatus(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "rtl8821ae_hw_init() <====\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "%s() <====\n", __func__);
 	return err;
 }
 
@@ -2000,16 +2000,16 @@ static enum version_8821ae _rtl8821ae_read_chip_version(struct ieee80211_hw *hw)
 	u32 value32;
 
 	value32 = rtl_read_dword(rtlpriv, REG_SYS_CFG);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "ReadChipVersion8812A 0xF0 = 0x%x\n", value32);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"ReadChipVersion8812A 0xF0 = 0x%x\n", value32);
 
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE)
 		rtlphy->rf_type = RF_2T2R;
 	else if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE)
 		rtlphy->rf_type = RF_1T1R;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "RF_Type is %x!!\n", rtlphy->rf_type);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"RF_Type is %x!!\n", rtlphy->rf_type);
 
 	if (value32 & TRP_VAUX_EN) {
 		if (rtlhal->hw_type == HARDWARE_TYPE_RTL8812AE) {
@@ -2049,44 +2049,44 @@ static enum version_8821ae _rtl8821ae_read_chip_version(struct ieee80211_hw *hw)
 
 	switch (version) {
 	case VERSION_TEST_CHIP_1T1R_8812:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_TEST_CHIP_1T1R_8812\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_TEST_CHIP_1T1R_8812\n");
 		break;
 	case VERSION_TEST_CHIP_2T2R_8812:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_TEST_CHIP_2T2R_8812\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_TEST_CHIP_2T2R_8812\n");
 		break;
 	case VERSION_NORMAL_TSMC_CHIP_1T1R_8812:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID:VERSION_NORMAL_TSMC_CHIP_1T1R_8812\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID:VERSION_NORMAL_TSMC_CHIP_1T1R_8812\n");
 		break;
 	case VERSION_NORMAL_TSMC_CHIP_2T2R_8812:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_NORMAL_TSMC_CHIP_2T2R_8812\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_NORMAL_TSMC_CHIP_2T2R_8812\n");
 		break;
 	case VERSION_NORMAL_TSMC_CHIP_1T1R_8812_C_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_NORMAL_TSMC_CHIP_1T1R_8812 C CUT\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_NORMAL_TSMC_CHIP_1T1R_8812 C CUT\n");
 		break;
 	case VERSION_NORMAL_TSMC_CHIP_2T2R_8812_C_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_NORMAL_TSMC_CHIP_2T2R_8812 C CUT\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_NORMAL_TSMC_CHIP_2T2R_8812 C CUT\n");
 		break;
 	case VERSION_TEST_CHIP_8821:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_TEST_CHIP_8821\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_TEST_CHIP_8821\n");
 		break;
 	case VERSION_NORMAL_TSMC_CHIP_8821:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_NORMAL_TSMC_CHIP_8821 A CUT\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_NORMAL_TSMC_CHIP_8821 A CUT\n");
 		break;
 	case VERSION_NORMAL_TSMC_CHIP_8821_B_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: VERSION_NORMAL_TSMC_CHIP_8821 B CUT\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: VERSION_NORMAL_TSMC_CHIP_8821 B CUT\n");
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Chip Version ID: Unknown (0x%X)\n", version);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Chip Version ID: Unknown (0x%X)\n", version);
 		break;
 	}
 
@@ -2102,7 +2102,7 @@ static int _rtl8821ae_set_media_status(struct ieee80211_hw *hw,
 	bt_msr &= 0xfc;
 
 	rtl_write_dword(rtlpriv, REG_BCN_CTRL, 0);
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_LOUD,
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_LOUD,
 		"clear 0x550 when set HW_VAR_MEDIA_STATUS\n");
 
 	if (type == NL80211_IFTYPE_UNSPECIFIED ||
@@ -2114,33 +2114,33 @@ static int _rtl8821ae_set_media_status(struct ieee80211_hw *hw,
 		_rtl8821ae_resume_tx_beacon(hw);
 		_rtl8821ae_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
-			 type);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
+			type);
 	}
 
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		bt_msr |= MSR_NOLINK;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to NO LINK!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		bt_msr |= MSR_ADHOC;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to Ad Hoc!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		bt_msr |= MSR_INFRA;
 		ledaction = LED_CTL_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to STA!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		bt_msr |= MSR_AP;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to AP!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to AP!\n");
 		break;
 	default:
 		pr_err("Network type %d not support!\n", type);
@@ -2183,7 +2183,7 @@ int rtl8821ae_set_network_type(struct ieee80211_hw *hw, enum nl80211_iftype type
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "rtl8821ae_set_network_type!\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "%s!\n", __func__);
 
 	if (_rtl8821ae_set_media_status(hw, type))
 		return -EOPNOTSUPP;
@@ -2283,16 +2283,16 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 	 * offset 0x34 from the Function Header */
 
 	pci_read_config_byte(rtlpci->pdev, 0x34, &cap_pointer);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "PCI configuration 0x34 = 0x%2x\n", cap_pointer);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PCI configuration 0x34 = 0x%2x\n", cap_pointer);
 
 	do {
 		pci_read_config_word(rtlpci->pdev, cap_pointer, &cap_hdr);
 		cap_id = cap_hdr & 0xFF;
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "in pci configuration, cap_pointer%x = %x\n",
-			  cap_pointer, cap_id);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"in pci configuration, cap_pointer%x = %x\n",
+			cap_pointer, cap_id);
 
 		if (cap_id == 0x01) {
 			break;
@@ -2322,17 +2322,17 @@ static void _rtl8821ae_clear_pci_pme_status(struct ieee80211_hw *hw)
 			/* Read it back to check */
 			pci_read_config_byte(rtlpci->pdev, cap_pointer + 5,
 					     &pmcs_reg);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "Clear PME status 0x%2x to 0x%2x\n",
-				  cap_pointer + 5, pmcs_reg);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"Clear PME status 0x%2x to 0x%2x\n",
+				cap_pointer + 5, pmcs_reg);
 		} else {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "PME status(0x%2x) = 0x%2x\n",
-				  cap_pointer + 5, pmcs_reg);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"PME status(0x%2x) = 0x%2x\n",
+				cap_pointer + 5, pmcs_reg);
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_WARNING,
-			 "Cannot find PME Capability\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING,
+			"Cannot find PME Capability\n");
 	}
 }
 
@@ -2354,13 +2354,13 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 
 	if (!(support_remote_wakeup && mac->opmode == NL80211_IFTYPE_STATION)
 	    || !rtlhal->enter_pnp_sleep) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Normal Power off\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Normal Power off\n");
 		mac->link_state = MAC80211_NOLINK;
 		opmode = NL80211_IFTYPE_UNSPECIFIED;
 		_rtl8821ae_set_media_status(hw, opmode);
 		_rtl8821ae_poweroff_adapter(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Wowlan Supported.\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Wowlan Supported.\n");
 		/* 3 <1> Prepare for configuring wowlan related infomations */
 		/* Clear Fw WoWLAN event. */
 		rtl_write_byte(rtlpriv, REG_MCUTST_WOWLAN, 0x0);
@@ -2410,9 +2410,9 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 			udelay(10);
 			tmp = rtl_read_byte(rtlpriv, REG_RXDMA_CONTROL);
 		}
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Wait Rx DMA Finished before host sleep. count=%d\n",
-			  count);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Wait Rx DMA Finished before host sleep. count=%d\n",
+			count);
 
 		/* reset trx ring */
 		rtlpriv->intf_ops->reset_trx_ring(hw);
@@ -2438,7 +2438,7 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 
 		/* Stop Pcie Interface Tx DMA. */
 		rtl_write_byte(rtlpriv, REG_PCIE_CTRL_REG + 1, 0xff);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Stop PCIE Tx DMA.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Stop PCIE Tx DMA.\n");
 
 		/* Wait for TxDMA idle. */
 		count = 0;
@@ -2447,9 +2447,9 @@ void rtl8821ae_card_disable(struct ieee80211_hw *hw)
 			udelay(10);
 			count++;
 		} while ((tmp != 0) && (count < 100));
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Wait Tx DMA Finished before host sleep. count=%d\n",
-			  count);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Wait Tx DMA Finished before host sleep. count=%d\n",
+			count);
 
 		if (rtlhal->hw_rof_enable) {
 			printk("hw_rof_enable\n");
@@ -2501,8 +2501,8 @@ void rtl8821ae_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	rtl8821ae_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	rtl8821ae_enable_interrupt(hw);
@@ -2514,8 +2514,8 @@ void rtl8821ae_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -2586,15 +2586,15 @@ static void _rtl8821ae_read_power_value_fromprom(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 rfpath, eeaddr = EEPROM_TX_PWR_INX, group, txcount = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "hal_ReadPowerValueFromPROM8821ae(): hwinfo[0x%x]=0x%x\n",
-		 (eeaddr + 1), hwinfo[eeaddr + 1]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"hal_ReadPowerValueFromPROM8821ae(): hwinfo[0x%x]=0x%x\n",
+		(eeaddr + 1), hwinfo[eeaddr + 1]);
 	if (hwinfo[eeaddr + 1] == 0xFF)  /*YJ,add,120316*/
 		autoload_fail = true;
 
 	if (autoload_fail) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "auto load fail : Use Default value!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"auto load fail : Use Default value!\n");
 		for (rfpath = 0 ; rfpath < MAX_RF_PATH ; rfpath++) {
 			/*2.4G default value*/
 			for (group = 0 ; group < MAX_CHNL_GROUP_24G; group++) {
@@ -3048,8 +3048,8 @@ static void _rtl8821ae_read_rfe_type(struct ieee80211_hw *hw, u8 *hwinfo,
 		rtlhal->rfe_type = 0x04;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "RFE Type: 0x%2x\n", rtlhal->rfe_type);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"RFE Type: 0x%2x\n", rtlhal->rfe_type);
 }
 
 static void _rtl8812ae_read_bt_coexist_info_from_hwpg(struct ieee80211_hw *hw,
@@ -3153,8 +3153,8 @@ static void _rtl8821ae_read_adapter_info(struct ieee80211_hw *hw, bool b_pseudo_
 		rtlefuse->board_type |= ODM_BOARD_BT;
 
 	rtlhal->board_type = rtlefuse->board_type;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "board_type = 0x%x\n", rtlefuse->board_type);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"board_type = 0x%x\n", rtlefuse->board_type);
 
 	rtlefuse->eeprom_channelplan = *(u8 *)&hwinfo[EEPROM_CHANNELPLAN];
 	if (rtlefuse->eeprom_channelplan == 0xff)
@@ -3176,8 +3176,8 @@ static void _rtl8821ae_read_adapter_info(struct ieee80211_hw *hw, bool b_pseudo_
 	}
 
 	rtlefuse->thermalmeter[0] = rtlefuse->eeprom_thermalmeter;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "thermalmeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"thermalmeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
 
 	if (!rtlefuse->autoload_failflag) {
 		rtlefuse->antenna_div_cfg =
@@ -3197,7 +3197,7 @@ static void _rtl8821ae_read_adapter_info(struct ieee80211_hw *hw, bool b_pseudo_
 		rtlefuse->antenna_div_type = 0;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 		"SWAS: bHwAntDiv = %x, TRxAntDivType = %x\n",
 		rtlefuse->antenna_div_cfg, rtlefuse->antenna_div_type);
 
@@ -3246,8 +3246,8 @@ static void _rtl8821ae_read_adapter_info(struct ieee80211_hw *hw, bool b_pseudo_
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }*/
 
 void rtl8821ae_read_eeprom_info(struct ieee80211_hw *hw)
@@ -3264,20 +3264,20 @@ void rtl8821ae_read_eeprom_info(struct ieee80211_hw *hw)
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
 		_rtl8821ae_read_adapter_info(hw, false);
 	} else {
@@ -3378,8 +3378,8 @@ static void rtl8821ae_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
 static u32 _rtl8821ae_rate_to_bitmap_2ssvht(__le16 vht_rate)
@@ -3524,8 +3524,8 @@ static void rtl8821ae_update_hal_rate_mask(struct ieee80211_hw *hw,
 	sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 	wirelessmode = sta_entry->wireless_mode;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_LOUD,
-		 "wireless mode = 0x%x\n", wirelessmode);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_LOUD,
+		"wireless mode = 0x%x\n", wirelessmode);
 	if (mac->opmode == NL80211_IFTYPE_STATION ||
 		mac->opmode == NL80211_IFTYPE_MESH_POINT) {
 		curtxbw_40mhz = mac->bw_40;
@@ -3675,8 +3675,8 @@ static void rtl8821ae_update_hal_rate_mask(struct ieee80211_hw *hw,
 	ratr_bitmap = _rtl8821ae_set_ra_vht_ratr_bitmap(hw, wirelessmode,
 							ratr_bitmap);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_LOUD,
-		 "ratr_bitmap :%x\n", ratr_bitmap);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_LOUD,
+		"ratr_bitmap :%x\n", ratr_bitmap);
 
 	/* *(u32 *)& rate_mask = EF4BYTE((ratr_bitmap & 0x0fffffff) |
 				       (ratr_index << 28)); */
@@ -3692,10 +3692,10 @@ static void rtl8821ae_update_hal_rate_mask(struct ieee80211_hw *hw,
 	rate_mask[5] = (u8)((ratr_bitmap & 0x00ff0000) >> 16);
 	rate_mask[6] = (u8)((ratr_bitmap & 0xff000000) >> 24);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x:%x:%x\n",
-		 ratr_index, ratr_bitmap,
-		 rate_mask[0], rate_mask[1],
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x:%x:%x\n",
+		ratr_index, ratr_bitmap,
+		rate_mask[0], rate_mask[1],
 		 rate_mask[2], rate_mask[3],
 		 rate_mask[4], rate_mask[5],
 		 rate_mask[6]);
@@ -3710,7 +3710,7 @@ void rtl8821ae_update_hal_rate_tbl(struct ieee80211_hw *hw,
 	if (rtlpriv->dm.useramask)
 		rtl8821ae_update_hal_rate_mask(hw, sta, rssi_level, update_bw);
 	else
-		/*RT_TRACE(rtlpriv, COMP_RATR,DBG_LOUD,
+		/*rtl_dbg(rtlpriv, COMP_RATR,DBG_LOUD,
 			   "rtl8821ae_update_hal_rate_tbl() Error! 8821ae FW RA Only\n");*/
 		rtl8821ae_update_hal_rate_table(hw, sta);
 }
@@ -3782,16 +3782,16 @@ bool rtl8821ae_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 		e_rfpowerstate_toset = (u1tmp & BIT(1)) ? ERFON : ERFOFF;
 
 	if ((ppsc->hwradiooff) && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio ON, RF ON\n");
 
 		e_rfpowerstate_toset = ERFON;
 		ppsc->hwradiooff = false;
 		b_actuallyset = true;
 	} else if ((!ppsc->hwradiooff)
 		   && (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 
 		e_rfpowerstate_toset = ERFOFF;
 		ppsc->hwradiooff = true;
@@ -3841,7 +3841,7 @@ void rtl8821ae_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -3868,8 +3868,8 @@ void rtl8821ae_set_key(struct ieee80211_hw *hw, u32 key_index,
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
@@ -3898,26 +3898,26 @@ void rtl8821ae_set_key(struct ieee80211_hw *hw, u32 key_index,
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
@@ -3982,7 +3982,7 @@ void rtl8821ae_allow_all_destaddr(struct ieee80211_hw *hw,
 	if (write_into_reg)
 		rtl_write_dword(rtlpriv, REG_RCR, rtlpci->receive_config);
 
-	RT_TRACE(rtlpriv, COMP_TURBO | COMP_INIT, DBG_LOUD,
+	rtl_dbg(rtlpriv, COMP_TURBO | COMP_INIT, DBG_LOUD,
 		"receive_config=0x%08X, write_into_reg=%d\n",
 		rtlpci->receive_config, write_into_reg);
 }
@@ -4035,9 +4035,9 @@ void rtl8821ae_add_wowlan_pattern(struct ieee80211_hw *hw,
 				cam |= BIT(26);
 
 			rtl_write_dword(rtlpriv, REG_PKTBUF_DBG_DATA_L, cam);
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-				 "WRITE entry[%d] 0x%x: %x\n", addr,
-				  REG_PKTBUF_DBG_DATA_L, cam);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+				"WRITE entry[%d] 0x%x: %x\n", addr,
+				REG_PKTBUF_DBG_DATA_L, cam);
 
 			/* Write to Rx packet buffer. */
 			rtl_write_word(rtlpriv, REG_RXPKTBUF_CTRL, 0x0f01);
@@ -4045,18 +4045,18 @@ void rtl8821ae_add_wowlan_pattern(struct ieee80211_hw *hw,
 			cam = rtl_pattern->mask[addr - 2];
 
 			rtl_write_dword(rtlpriv, REG_PKTBUF_DBG_DATA_L, cam);
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-				 "WRITE entry[%d] 0x%x: %x\n", addr,
-				  REG_PKTBUF_DBG_DATA_L, cam);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+				"WRITE entry[%d] 0x%x: %x\n", addr,
+				REG_PKTBUF_DBG_DATA_L, cam);
 
 			rtl_write_word(rtlpriv, REG_RXPKTBUF_CTRL, 0x0f01);
 		} else if (addr == 3 || addr == 5) {/* WKFM[127:0] */
 			cam = rtl_pattern->mask[addr - 2];
 
 			rtl_write_dword(rtlpriv, REG_PKTBUF_DBG_DATA_H, cam);
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-				 "WRITE entry[%d] 0x%x: %x\n", addr,
-				  REG_PKTBUF_DBG_DATA_H, cam);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+				"WRITE entry[%d] 0x%x: %x\n", addr,
+				REG_PKTBUF_DBG_DATA_H, cam);
 
 			rtl_write_word(rtlpriv, REG_RXPKTBUF_CTRL, 0xf001);
 		}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c
index dd7553e80ab1..7d6fb134c10f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/led.c
@@ -20,8 +20,8 @@ void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -37,8 +37,8 @@ void rtl8821ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
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
@@ -64,9 +64,9 @@ void rtl8812ae_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	}
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "In SwLedOn, LedAddr:%X LEDPIN=%d\n",
-		 ledreg, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"In SwLedOn, LedAddr:%X LEDPIN=%d\n",
+		ledreg, pled->ledpin);
 
 	ledcfg =  rtl_read_byte(rtlpriv, ledreg);
 	ledcfg |= BIT(5); /*Set 0x4c[21]*/
@@ -81,8 +81,8 @@ void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
@@ -109,8 +109,8 @@ void rtl8821ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		rtl_write_byte(rtlpriv, REG_LEDCFG1, ledcfg|BIT(3));
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
 	pled->ledon = false;
@@ -135,9 +135,9 @@ void rtl8812ae_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 		break;
 	}
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "In SwLedOff,LedAddr:%X LEDPIN=%d\n",
-		 ledreg, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"In SwLedOff,LedAddr:%X LEDPIN=%d\n",
+		ledreg, pled->ledpin);
 	/*Open-drain arrangement for controlling the LED*/
 	if (rtlpriv->ledctl.led_opendrain) {
 		u8 ledcfg = rtl_read_byte(rtlpriv, ledreg);
@@ -207,7 +207,7 @@ void rtl8821ae_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n",
-		 ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n",
+		ledaction);
 	_rtl8821ae_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
index b8a2b2326902..4b8cd35c8bc4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
@@ -96,16 +96,16 @@ u32 rtl8821ae_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x)\n",
-		 regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x)\n",
+		regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl8821ae_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
-		 bitmask, regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+		bitmask, regaddr, originalvalue);
 	return returnvalue;
 }
 
@@ -115,9 +115,9 @@ void rtl8821ae_phy_set_bb_reg(struct ieee80211_hw *hw,
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
@@ -128,9 +128,9 @@ void rtl8821ae_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 }
 
 u32 rtl8821ae_phy_query_rf_reg(struct ieee80211_hw *hw,
@@ -140,9 +140,9 @@ u32 rtl8821ae_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		 regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -152,9 +152,9 @@ u32 rtl8821ae_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		 regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 
 	return readback_value;
 }
@@ -166,9 +166,9 @@ void rtl8821ae_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -183,8 +183,8 @@ void rtl8821ae_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 }
 
@@ -267,9 +267,9 @@ static void _rtl8821ae_phy_rf_serial_write(struct ieee80211_hw *hw,
 	data_and_addr = ((newoffset << 20) |
 			 (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFW-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
 static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
@@ -450,10 +450,10 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8	band,
 	u32  out = 0x200;
 	const s8 auto_temp = -1;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-		 "===> PHY_GetTXBBSwing_8812A, bbSwing_2G: %d, bbSwing_5G: %d,autoload_failflag=%d.\n",
-		 (int)swing_2g, (int)swing_5g,
-		 (int)rtlefuse->autoload_failflag);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+		"===> PHY_GetTXBBSwing_8812A, bbSwing_2G: %d, bbSwing_5G: %d,autoload_failflag=%d.\n",
+		(int)swing_2g, (int)swing_5g,
+		(int)rtlefuse->autoload_failflag);
 
 	if (rtlefuse->autoload_failflag) {
 		if (band == BAND_ON_2_4G) {
@@ -531,9 +531,9 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8	band,
 
 		swing_a = (swing & 0x3) >> 0; /* 0xC6/C7[1:0] */
 		swing_b = (swing & 0xC) >> 2; /* 0xC6/C7[3:2] */
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-			 "===> PHY_GetTXBBSwing_8812A, swingA: 0x%X, swingB: 0x%X\n",
-			 swing_a, swing_b);
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"===> PHY_GetTXBBSwing_8812A, swingA: 0x%X, swingB: 0x%X\n",
+			swing_a, swing_b);
 
 		/* 3 Path-A */
 		if (swing_a == 0x0) {
@@ -589,8 +589,8 @@ u32 phy_get_tx_swing_8812A(struct ieee80211_hw *hw, u8	band,
 		}
 	}
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-		 "<=== PHY_GetTXBBSwing_8812A, out = 0x%X\n", out);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+		"<=== PHY_GetTXBBSwing_8812A, out = 0x%X\n", out);
 	return out;
 }
 
@@ -652,23 +652,23 @@ void rtl8821ae_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 
 		count = 0;
 		reg_41a = rtl_read_word(rtlpriv, REG_TXPKT_EMPTY);
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-			 "Reg41A value %d\n", reg_41a);
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"Reg41A value %d\n", reg_41a);
 		reg_41a &= 0x30;
 		while ((reg_41a != 0x30) && (count < 50)) {
 			udelay(50);
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD, "Delay 50us\n");
+			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD, "Delay 50us\n");
 
 			reg_41a = rtl_read_word(rtlpriv, REG_TXPKT_EMPTY);
 			reg_41a &= 0x30;
 			count++;
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-				 "Reg41A value %d\n", reg_41a);
+			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+				"Reg41A value %d\n", reg_41a);
 		}
 		if (count != 0)
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "PHY_SwitchWirelessBand8812(): Switch to 5G Band. Count = %d reg41A=0x%x\n",
-				 count, reg_41a);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"PHY_SwitchWirelessBand8812(): Switch to 5G Band. Count = %d reg41A=0x%x\n",
+				count, reg_41a);
 
 		/* 2012/02/01, Sinda add registry to switch workaround
 		without long-run verification for scan issue. */
@@ -693,9 +693,9 @@ void rtl8821ae_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 		rtl_set_bbreg(hw, RTXPATH, 0xf0, 0);
 		rtl_set_bbreg(hw, RCCK_RX, 0x0f000000, 0xf);
 
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-			 "==>PHY_SwitchWirelessBand8812() BAND_ON_5G settings OFDM index 0x%x\n",
-			 rtlpriv->dm.ofdm_index[RF90_PATH_A]);
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"==>PHY_SwitchWirelessBand8812() BAND_ON_5G settings OFDM index 0x%x\n",
+			rtlpriv->dm.ofdm_index[RF90_PATH_A]);
 	}
 
 	if ((rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) ||
@@ -722,8 +722,8 @@ void rtl8821ae_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 		rtl8821ae_dm_clear_txpower_tracking_state(hw);
 	}
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "<==rtl8821ae_phy_switch_wirelessband():Switch Band OK.\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"<==%s():Switch Band OK.\n", __func__);
 	return;
 }
 
@@ -756,18 +756,18 @@ static bool _rtl8821ae_check_positive(struct ieee80211_hw *hw,
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
+		"	(Platform, Interface) = (0x%X, 0x%X)\n", 0x04, intf);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"	(Board, Package) = (0x%X, 0x%X)\n",
+		rtlhal->board_type, rtlhal->package_type);
 
 	/*============== Value Defined Check ===============*/
 	/*QFN Type [15:12] and Cut Version [27:24] need to do value check*/
@@ -918,7 +918,7 @@ static void _rtl8821ae_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
 	if (path > RF90_PATH_D) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"Invalid Rf Path %d in phy_SetTxPowerByRatBase()\n", path);
 		return;
 	}
@@ -944,9 +944,9 @@ static void _rtl8821ae_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 			rtlphy->txpwr_by_rate_base_24g[path][txnum][5] = value;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Invalid RateSection %d in Band 2.4G,Rf Path %d, %dTx in PHY_SetTxPowerByRateBase()\n",
-				 rate_section, path, txnum);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Invalid RateSection %d in Band 2.4G,Rf Path %d, %dTx in PHY_SetTxPowerByRateBase()\n",
+				rate_section, path, txnum);
 			break;
 		}
 	} else if (band == BAND_ON_5G) {
@@ -967,13 +967,13 @@ static void _rtl8821ae_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 			rtlphy->txpwr_by_rate_base_5g[path][txnum][4] = value;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 				"Invalid RateSection %d in Band 5G, Rf Path %d, %dTx in PHY_SetTxPowerByRateBase()\n",
 				rate_section, path, txnum);
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 			"Invalid Band %d in PHY_SetTxPowerByRateBase()\n", band);
 	}
 }
@@ -987,9 +987,9 @@ static u8 _rtl8821ae_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 	u8 value = 0;
 
 	if (path > RF90_PATH_D) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Rf Path %d in PHY_GetTxPowerByRateBase()\n",
-			 path);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Rf Path %d in PHY_GetTxPowerByRateBase()\n",
+			path);
 		return 0;
 	}
 
@@ -1014,9 +1014,9 @@ static u8 _rtl8821ae_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 			value = rtlphy->txpwr_by_rate_base_24g[path][txnum][5];
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
 	} else if (band == BAND_ON_5G) {
@@ -1037,14 +1037,14 @@ static u8 _rtl8821ae_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 			value = rtlphy->txpwr_by_rate_base_5g[path][txnum][4];
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Invalid RateSection %d in Band 5G, Rf Path %d, %dTx in PHY_GetTxPowerByRateBase()\n",
-				 rate_section, path, txnum);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Invalid RateSection %d in Band 5G, Rf Path %d, %dTx in PHY_GetTxPowerByRateBase()\n",
+				rate_section, path, txnum);
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Band %d in PHY_GetTxPowerByRateBase()\n", band);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Band %d in PHY_GetTxPowerByRateBase()\n", band);
 	}
 
 	return value;
@@ -1144,7 +1144,7 @@ static void _rtl8812ae_phy_cross_reference_ht_and_vht_txpower_limit(struct ieee8
 						[bw][rate_section][channel][RF90_PATH_A];
 					if (temp_pwrlmt == MAX_POWER_INDEX) {
 						if (bw == 0 || bw == 1) { /*5G 20M 40M VHT and HT can cross reference*/
-							RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+							rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 								"No power limit table of the specified band %d, bandwidth %d, ratesection %d, channel %d, rf path %d\n",
 								1, bw, rate_section, channel, RF90_PATH_A);
 							if (rate_section == 2) {
@@ -1161,7 +1161,9 @@ static void _rtl8812ae_phy_cross_reference_ht_and_vht_txpower_limit(struct ieee8
 									rtlphy->txpwr_limit_5g[regulation][bw][3][channel][RF90_PATH_A];
 							}
 
-							RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "use other value %d\n", temp_pwrlmt);
+							rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+								"use other value %d\n",
+								temp_pwrlmt);
 						}
 					}
 				}
@@ -1218,7 +1220,7 @@ static u8 _rtl8812ae_phy_get_txpower_by_rate_base_index(struct ieee80211_hw *hw,
 			break;
 
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 				"Wrong rate 0x%x to obtain index in 2.4G in PHY_GetTxPowerByRateBaseIndex()\n",
 				rate);
 			break;
@@ -1285,7 +1287,7 @@ static u8 _rtl8812ae_phy_get_txpower_by_rate_base_index(struct ieee80211_hw *hw,
 			break;
 
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
 				"Wrong rate 0x%x to obtain index in 5G in PHY_GetTxPowerByRateBaseIndex()\n",
 				rate);
 			break;
@@ -1306,7 +1308,7 @@ static void _rtl8812ae_phy_convert_txpower_limit_to_power_index(struct ieee80211
 	s8 temp_value = 0, temp_pwrlmt = 0;
 	u8 rf_path = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 		"=====> _rtl8812ae_phy_convert_txpower_limit_to_power_index()\n");
 
 	_rtl8812ae_phy_cross_reference_ht_and_vht_txpower_limit(hw);
@@ -1355,7 +1357,7 @@ static void _rtl8812ae_phy_convert_txpower_limit_to_power_index(struct ieee80211
 								temp_value;
 						}
 
-						RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+						rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 							"TxPwrLimit_2_4G[regulation %d][bw %d][rateSection %d][channel %d] = %d\n(TxPwrLimit in dBm %d - BW40PwrLmt2_4G[channel %d][rfpath %d] %d)\n",
 							regulation, bw, rate_section, channel,
 							rtlphy->txpwr_limit_2_4g[regulation][bw]
@@ -1420,7 +1422,7 @@ static void _rtl8812ae_phy_convert_txpower_limit_to_power_index(struct ieee80211
 								[rf_path] = temp_value;
 						}
 
-						RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+						rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
 							"TxPwrLimit_5G[regulation %d][bw %d][rateSection %d][channel %d] =%d\n(TxPwrLimit in dBm %d - BW40PwrLmt5G[chnl group %d][rfpath %d] %d)\n",
 							regulation, bw, rate_section,
 							channel, rtlphy->txpwr_limit_5g[regulation]
@@ -1431,8 +1433,8 @@ static void _rtl8812ae_phy_convert_txpower_limit_to_power_index(struct ieee80211
 			}
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "<===== _rtl8812ae_phy_convert_txpower_limit_to_power_index()\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"<===== %s()\n", __func__);
 }
 
 static void _rtl8821ae_phy_init_txpower_limit(struct ieee80211_hw *hw)
@@ -1441,8 +1443,8 @@ static void _rtl8821ae_phy_init_txpower_limit(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u8 i, j, k, l, m;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "=====> _rtl8821ae_phy_init_txpower_limit()!\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"=====>`%s()!\n", __func__);
 
 	for (i = 0; i < MAX_REGULATION_NUM; ++i) {
 		for (j = 0; j < MAX_2_4G_BANDWIDTH_NUM; ++j)
@@ -1463,8 +1465,8 @@ static void _rtl8821ae_phy_init_txpower_limit(struct ieee80211_hw *hw)
 							= MAX_POWER_INDEX;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "<===== _rtl8821ae_phy_init_txpower_limit()!\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"<===== %s()!\n", __func__);
 }
 
 static void _rtl8821ae_phy_convert_txpower_dbm_to_relative_value(struct ieee80211_hw *hw)
@@ -1574,7 +1576,7 @@ static void _rtl8821ae_phy_convert_txpower_dbm_to_relative_value(struct ieee8021
 			0, 3, base);
 	}
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
 		"<===_rtl8821ae_phy_convert_txpower_dbm_to_relative_value()\n");
 }
 
@@ -1630,13 +1632,13 @@ static s8 _rtl8812ae_phy_get_chnl_idx_of_txpwr_lmt(struct ieee80211_hw *hw,
 				channel_index = i;
 		}
 	} else
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid Band %d in %s\n",
-			 band,  __func__);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid Band %d in %s\n",
+			band,  __func__);
 
 	if (channel_index == -1)
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Invalid Channel %d of Band %d in %s\n", channel,
-			 band, __func__);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Invalid Channel %d of Band %d in %s\n", channel,
+			band, __func__);
 
 	return channel_index;
 }
@@ -1655,9 +1657,9 @@ static void _rtl8812ae_phy_set_txpower_limit(struct ieee80211_hw *hw, u8 *pregul
 	if (!_rtl8812ae_get_integer_from_string((char *)pchannel, &channel) ||
 	    !_rtl8812ae_get_integer_from_string((char *)ppower_limit,
 						&power_limit)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Illegal index of pwr_lmt table [chnl %d][val %d]\n",
-			  channel, power_limit);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Illegal index of pwr_lmt table [chnl %d][val %d]\n",
+			channel, power_limit);
 	}
 
 	power_limit = power_limit > MAX_POWER_INDEX ?
@@ -1717,10 +1719,10 @@ static void _rtl8812ae_phy_set_txpower_limit(struct ieee80211_hw *hw, u8 *pregul
 				[rate_section][channel_index][RF90_PATH_A] =
 								   power_limit;
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "2.4G [regula %d][bw %d][sec %d][chnl %d][val %d]\n",
-			  regulation, bandwidth, rate_section, channel_index,
-			  rtlphy->txpwr_limit_2_4g[regulation][bandwidth]
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"2.4G [regula %d][bw %d][sec %d][chnl %d][val %d]\n",
+			regulation, bandwidth, rate_section, channel_index,
+			rtlphy->txpwr_limit_2_4g[regulation][bandwidth]
 				[rate_section][channel_index][RF90_PATH_A]);
 	} else if (_rtl8812ae_eq_n_byte(pband, (u8 *)("5G"), 2)) {
 		ret = _rtl8812ae_phy_get_chnl_idx_of_txpwr_lmt(hw,
@@ -1740,14 +1742,14 @@ static void _rtl8812ae_phy_set_txpower_limit(struct ieee80211_hw *hw, u8 *pregul
 			rtlphy->txpwr_limit_5g[regulation][bandwidth]
 			[rate_section][channel_index][RF90_PATH_A] = power_limit;
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "5G: [regul %d][bw %d][sec %d][chnl %d][val %d]\n",
-			  regulation, bandwidth, rate_section, channel,
-			  rtlphy->txpwr_limit_5g[regulation][bandwidth]
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"5G: [regul %d][bw %d][sec %d][chnl %d][val %d]\n",
+			regulation, bandwidth, rate_section, channel,
+			rtlphy->txpwr_limit_5g[regulation][bandwidth]
 				[rate_section][channel_index][RF90_PATH_A]);
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Cannot recognize the band info in %s\n", pband);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Cannot recognize the band info in %s\n", pband);
 		return;
 	}
 }
@@ -1779,8 +1781,7 @@ static void _rtl8821ae_phy_read_and_config_txpwr_lmt(struct ieee80211_hw *hw)
 		array = RTL8821AE_TXPWR_LMT;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
 
 	for (i = 0; i < array_len; i += 7) {
 		u8 *regulation = array[i];
@@ -1903,7 +1904,7 @@ static bool _rtl8821ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read MAC_REG_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read MAC_REG_Array\n");
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8821AE) {
 		arraylength = RTL8821AE_MAC_1T_ARRAYLEN;
 		ptrarray = RTL8821AE_MAC_REG_ARRAY;
@@ -1911,8 +1912,8 @@ static bool _rtl8821ae_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 		arraylength = RTL8812AE_MAC_1T_ARRAYLEN;
 		ptrarray = RTL8812AE_MAC_REG_ARRAY;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Img: MAC_REG_ARRAY LEN %d\n", arraylength);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Img: MAC_REG_ARRAY LEN %d\n", arraylength);
 
 	return __rtl8821ae_phy_config_with_headerfile(hw,
 			ptrarray, arraylength, rtl_write_byte_with_val32);
@@ -1978,22 +1979,22 @@ static void _rtl8821ae_store_tx_power_by_rate(struct ieee80211_hw *hw,
 	u8 rate_section = _rtl8821ae_get_rate_section_index(regaddr);
 
 	if (band != BAND_ON_2_4G && band != BAND_ON_5G) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_WARNING, "Invalid Band %d\n", band);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING, "Invalid Band %d\n", band);
 		band = BAND_ON_2_4G;
 	}
 	if (rfpath >= MAX_RF_PATH) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_WARNING, "Invalid RfPath %d\n", rfpath);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING, "Invalid RfPath %d\n", rfpath);
 		rfpath = MAX_RF_PATH - 1;
 	}
 	if (txnum >= MAX_RF_PATH) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_WARNING, "Invalid TxNum %d\n", txnum);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_WARNING, "Invalid TxNum %d\n", txnum);
 		txnum = MAX_RF_PATH - 1;
 	}
 	rtlphy->tx_power_by_rate_offset[band][rfpath][txnum][rate_section] = data;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "TxPwrByRateOffset[Band %d][RfPath %d][TxNum %d][RateSection %d] = 0x%x\n",
-		 band, rfpath, txnum, rate_section,
-		 rtlphy->tx_power_by_rate_offset[band][rfpath][txnum][rate_section]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"TxPwrByRateOffset[Band %d][RfPath %d][TxNum %d][RateSection %d] = 0x%x\n",
+		band, rfpath, txnum, rate_section,
+		rtlphy->tx_power_by_rate_offset[band][rfpath][txnum][rate_section]);
 }
 
 static bool _rtl8821ae_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
@@ -2015,8 +2016,8 @@ static bool _rtl8821ae_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 	}
 
 	if (configtype != BASEBAND_CONFIG_PHY_REG) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "configtype != BaseBand_Config_PHY_REG\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"configtype != BaseBand_Config_PHY_REG\n");
 		return true;
 	}
 	for (i = 0; i < arraylen; i += 6) {
@@ -2082,9 +2083,9 @@ bool rtl8812ae_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 	radioa_array_table_a = RTL8812AE_RADIOA_ARRAY;
 	radioa_arraylen_b = RTL8812AE_RADIOB_1TARRAYLEN;
 	radioa_array_table_b = RTL8812AE_RADIOB_ARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Radio_A:RTL8821AE_RADIOA_ARRAY %d\n", radioa_arraylen_a);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Radio_A:RTL8821AE_RADIOA_ARRAY %d\n", radioa_arraylen_a);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		return __rtl8821ae_phy_config_with_headerfile(hw,
@@ -2113,9 +2114,9 @@ bool rtl8821ae_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 
 	radioa_arraylen = RTL8821AE_RADIOA_1TARRAYLEN;
 	radioa_array_table = RTL8821AE_RADIOA_ARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Radio_A:RTL8821AE_RADIOA_ARRAY %d\n", radioa_arraylen);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Radio_A:RTL8821AE_RADIOA_ARRAY %d\n", radioa_arraylen);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		return __rtl8821ae_phy_config_with_headerfile(hw,
@@ -2146,21 +2147,21 @@ void rtl8821ae_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->default_initialgain[3] =
 	    (u8)rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
-		  rtlphy->default_initialgain[0],
-		  rtlphy->default_initialgain[1],
-		  rtlphy->default_initialgain[2],
-		  rtlphy->default_initialgain[3]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
+		rtlphy->default_initialgain[0],
+		rtlphy->default_initialgain[1],
+		rtlphy->default_initialgain[2],
+		rtlphy->default_initialgain[3]);
 
 	rtlphy->framesync = (u8)rtl_get_bbreg(hw,
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
 
 static void phy_init_bb_rf_register_definition(struct ieee80211_hw *hw)
@@ -2427,14 +2428,14 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 		rate_section = 5;
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
 			"Wrong rate 0x%x\n", rate);
 		break;
 	}
 
 	if (band_temp == BAND_ON_5G  && rate_section == 0)
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Wrong rate 0x%x: No CCK in 5G Band\n", rate);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Wrong rate 0x%x: No CCK in 5G Band\n", rate);
 
 	/*workaround for wrong index combination to obtain tx power limit,
 	  OFDM only exists in BW 20M*/
@@ -2459,10 +2460,10 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 
 	if (band_temp == -1 || regulation == -1 || bandwidth_temp == -1 ||
 		rate_section == -1 || channel_temp == -1) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Wrong index value to access power limit table [band %d][regulation %d][bandwidth %d][rf_path %d][rate_section %d][chnl %d]\n",
-			 band_temp, regulation, bandwidth_temp, rf_path,
-			 rate_section, channel_temp);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Wrong index value to access power limit table [band %d][regulation %d][bandwidth %d][rf_path %d][rate_section %d][chnl %d]\n",
+			band_temp, regulation, bandwidth_temp, rf_path,
+			rate_section, channel_temp);
 		return MAX_POWER_INDEX;
 	}
 
@@ -2496,8 +2497,8 @@ static s8 _rtl8812ae_phy_get_txpower_limit(struct ieee80211_hw *hw,
 			rtlphy->txpwr_limit_5g[regu][chnl]
 			[sec][chnl][rf_path];
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "No power limit table of the specified band\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"No power limit table of the specified band\n");
 	}
 	return power_limit;
 }
@@ -2605,7 +2606,7 @@ static s8 _rtl8821ae_phy_get_txpower_by_rate(struct ieee80211_hw *hw,
 			else
 				tx_pwr_diff = tx_pwr_diff > limit ? limit : tx_pwr_diff;
 		}
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			"Maximum power by rate %d, final power by rate %d\n",
 			limit, tx_pwr_diff);
 	}
@@ -2628,7 +2629,7 @@ static u8 _rtl8821ae_get_txpower_index(struct ieee80211_hw *hw, u8 path,
 	    (channel > 14 || channel < 1)) ||
 	    ((rtlhal->current_bandtype == BAND_ON_5G) && (channel <= 14))) {
 		index = 0;
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			"Illegal channel!!\n");
 	}
 
@@ -2639,7 +2640,7 @@ static u8 _rtl8821ae_get_txpower_index(struct ieee80211_hw *hw, u8 path,
 		else if (DESC_RATE6M <= rate)
 			txpower = rtlefuse->txpwrlevel_ht40_1s[path][index];
 		else
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "invalid rate\n");
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "invalid rate\n");
 
 		if (DESC_RATE6M <= rate && rate <= DESC_RATE54M &&
 		    !RTL8821AE_RX_HAL_IS_CCK_RATE(rate))
@@ -2673,8 +2674,8 @@ static u8 _rtl8821ae_get_txpower_index(struct ieee80211_hw *hw, u8 path,
 		if (DESC_RATE6M <= rate)
 			txpower = rtlefuse->txpwr_5g_bw40base[path][index];
 		else
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_WARNING,
-				 "INVALID Rate.\n");
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_WARNING,
+				"INVALID Rate.\n");
 
 		if (DESC_RATE6M <= rate && rate <= DESC_RATE54M &&
 		    !RTL8821AE_RX_HAL_IS_CCK_RATE(rate))
@@ -2940,7 +2941,7 @@ static void _rtl8821ae_phy_set_txpower_index(struct ieee80211_hw *hw,
 				      MASKBYTE3, power_index);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
 				"Invalid Rate!!\n");
 			break;
 		}
@@ -3139,13 +3140,13 @@ static void _rtl8821ae_phy_set_txpower_index(struct ieee80211_hw *hw,
 				      MASKBYTE3, power_index);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "Invalid Rate!!\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"Invalid Rate!!\n");
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Invalid RFPath!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Invalid RFPath!!\n");
 	}
 }
 
@@ -3352,7 +3353,7 @@ static void _rtl8821ae_phy_set_reg_bw(struct rtl_priv *rtlpriv, u8 bw)
 		rtl_write_word(rtlpriv, REG_TRXPTCL_CTL, tmp & 0xFF7F);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING, "unknown Bandwidth: 0x%x\n", bw);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING, "unknown Bandwidth: 0x%x\n", bw);
 		break;
 	}
 }
@@ -3403,11 +3404,11 @@ void rtl8821ae_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	u8 sub_chnl = 0;
 	u8 l1pk_val = 0;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "Switch to %s bandwidth\n",
-		  (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
-		  "20MHz" :
-		  (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40 ?
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"Switch to %s bandwidth\n",
+		(rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
+		 "20MHz" :
+		 (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40 ?
 		  "40MHz" : "80MHz")));
 
 	_rtl8821ae_phy_set_reg_bw(rtlpriv, rtlphy->current_chan_bw);
@@ -3477,7 +3478,7 @@ void rtl8821ae_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	rtl8821ae_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
 }
 
 void rtl8821ae_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -3494,8 +3495,8 @@ void rtl8821ae_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw)))
 		rtl8821ae_phy_set_bw_mode_callback(hw);
 	else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "FALSE driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"FALSE driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
 	}
@@ -3510,8 +3511,8 @@ void rtl8821ae_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	u8 path;
 	u32 data;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
 
@@ -3553,7 +3554,7 @@ void rtl8821ae_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 			}
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl8821ae_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -3570,8 +3571,8 @@ u8 rtl8821ae_phy_sw_chnl(struct ieee80211_hw *hw)
 		return 0;
 
 	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
-			 "sw_chnl_inprogress false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false driver sleep or unload\n");
 		return 0;
 	}
 	while (rtlphy->lck_inprogress && timecount < timeout) {
@@ -3588,16 +3589,16 @@ u8 rtl8821ae_phy_sw_chnl(struct ieee80211_hw *hw)
 	if (channel == 0)
 		channel = 1;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d, band type is %d\n",
-		 rtlphy->current_channel, rtlhal->current_bandtype);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d, band type is %d\n",
+		rtlphy->current_channel, rtlhal->current_bandtype);
 
 	rtl8821ae_phy_sw_chnl_callback(hw);
 
 	rtl8821ae_dm_clear_txpower_tracking_state(hw);
 	rtl8821ae_phy_set_txpower_level(hw, rtlphy->current_channel);
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 	rtlphy->sw_chnl_inprogress = false;
 	return 1;
 }
@@ -3638,7 +3639,7 @@ static void _rtl8821ae_iqk_backup_macbb(struct ieee80211_hw *hw,
 	for (i = 0; i < mac_bb_num; i++)
 		macbb_backup[i] = rtl_read_dword(rtlpriv, backup_macbb_reg[i]);
 
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "BackupMacBB Success!!!!\n");
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "BackupMacBB Success!!!!\n");
 }
 
 static void _rtl8821ae_iqk_backup_afe(struct ieee80211_hw *hw, u32 *afe_backup,
@@ -3651,7 +3652,7 @@ static void _rtl8821ae_iqk_backup_afe(struct ieee80211_hw *hw, u32 *afe_backup,
 	/*Save AFE Parameters */
 	for (i = 0; i < afe_num; i++)
 		afe_backup[i] = rtl_read_dword(rtlpriv, backup_afe_REG[i]);
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "BackupAFE Success!!!!\n");
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "BackupAFE Success!!!!\n");
 }
 
 static void _rtl8821ae_iqk_backup_rf(struct ieee80211_hw *hw, u32 *rfa_backup,
@@ -3669,7 +3670,7 @@ static void _rtl8821ae_iqk_backup_rf(struct ieee80211_hw *hw, u32 *rfa_backup,
 		rfb_backup[i] = rtl_get_rfreg(hw, RF90_PATH_B, backup_rf_reg[i],
 					      BMASKDWORD);
 	}
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "BackupRF Success!!!!\n");
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "BackupRF Success!!!!\n");
 }
 
 static void _rtl8821ae_iqk_configure_mac(
@@ -3698,13 +3699,13 @@ static void _rtl8821ae_iqk_tx_fill_iqc(struct ieee80211_hw *hw,
 		rtl_write_dword(rtlpriv, 0xcc8, 0x20000000);
 		rtl_set_bbreg(hw, 0xccc, 0x000007ff, tx_y);
 		rtl_set_bbreg(hw, 0xcd4, 0x000007ff, tx_x);
-		RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			 "TX_X = %x;;TX_Y = %x =====> fill to IQC\n",
-			 tx_x, tx_y);
-		RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			 "0xcd4 = %x;;0xccc = %x ====>fill to IQC\n",
-			 rtl_get_bbreg(hw, 0xcd4, 0x000007ff),
-			 rtl_get_bbreg(hw, 0xccc, 0x000007ff));
+		rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+			"TX_X = %x;;TX_Y = %x =====> fill to IQC\n",
+			tx_x, tx_y);
+		rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+			"0xcd4 = %x;;0xccc = %x ====>fill to IQC\n",
+			rtl_get_bbreg(hw, 0xcd4, 0x000007ff),
+			rtl_get_bbreg(hw, 0xccc, 0x000007ff));
 		break;
 	default:
 		break;
@@ -3720,12 +3721,12 @@ static void _rtl8821ae_iqk_rx_fill_iqc(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, 0x82c, BIT(31), 0x0); /* [31] = 0 --> Page C */
 		rtl_set_bbreg(hw, 0xc10, 0x000003ff, rx_x>>1);
 		rtl_set_bbreg(hw, 0xc10, 0x03ff0000, rx_y>>1);
-		RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			 "rx_x = %x;;rx_y = %x ====>fill to IQC\n",
-			 rx_x>>1, rx_y>>1);
-		RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			 "0xc10 = %x ====>fill to IQC\n",
-			 rtl_read_dword(rtlpriv, 0xc10));
+		rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+			"rx_x = %x;;rx_y = %x ====>fill to IQC\n",
+			rx_x >> 1, rx_y >> 1);
+		rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+			"0xc10 = %x ====>fill to IQC\n",
+			rtl_read_dword(rtlpriv, 0xc10));
 		break;
 	default:
 		break;
@@ -3750,9 +3751,9 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 	int	i, k, vdf_y[3], vdf_x[3],
 		ii, dx = 0, dy = 0, tx_finish = 0, rx_finish = 0;
 
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			"BandWidth = %d.\n",
-			 rtlphy->current_chan_bw);
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+		"BandWidth = %d.\n",
+		rtlphy->current_chan_bw);
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_80)
 		vdf_enable = true;
 
@@ -3856,7 +3857,7 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 				rtl_write_dword(rtlpriv, 0xc8c, 0x00163e96);
 
 			if (vdf_enable == 1) {
-				RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "VDF_enable\n");
+				rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "VDF_enable\n");
 				for (k = 0; k <= 2; k++) {
 					switch (k) {
 					case 0:
@@ -3870,9 +3871,9 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 						rtl_set_bbreg(hw, 0xce8, BIT(31), 0x0);
 						break;
 					case 2:
-						RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
+						rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
 							"vdf_y[1] = %x;;;vdf_y[0] = %x\n", vdf_y[1]>>21 & 0x00007ff, vdf_y[0]>>21 & 0x00007ff);
-						RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
+						rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
 							"vdf_x[1] = %x;;;vdf_x[0] = %x\n", vdf_x[1]>>21 & 0x00007ff, vdf_x[0]>>21 & 0x00007ff);
 						tx_dt[cal] = (vdf_y[1]>>20)-(vdf_y[0]>>20);
 						tx_dt[cal] = ((16*tx_dt[cal])*10000/15708);
@@ -3992,7 +3993,7 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 
 			if (vdf_enable == 1) {
 				rtl_set_bbreg(hw, 0xce8, BIT(31), 0x0);    /* TX VDF Disable */
-				RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "RXVDF Start\n");
+				rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "RXVDF Start\n");
 				for (k = 0; k <= 2; k++) {
 					/* ====== RX mode TXK (RXK Step 1) ====== */
 					rtl_set_bbreg(hw, 0x82c, BIT(31), 0x0); /* [31] = 0 --> Page C */
@@ -4029,14 +4030,17 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 						break;
 					case 2:
 						{
-							RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-							"VDF_Y[1] = %x;;;VDF_Y[0] = %x\n",
-							vdf_y[1]>>21 & 0x00007ff, vdf_y[0]>>21 & 0x00007ff);
-							RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-							"VDF_X[1] = %x;;;VDF_X[0] = %x\n",
-							vdf_x[1]>>21 & 0x00007ff, vdf_x[0]>>21 & 0x00007ff);
+							rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+								"VDF_Y[1] = %x;;;VDF_Y[0] = %x\n",
+								vdf_y[1] >> 21 & 0x00007ff,
+								vdf_y[0] >> 21 & 0x00007ff);
+							rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+								"VDF_X[1] = %x;;;VDF_X[0] = %x\n",
+								vdf_x[1] >> 21 & 0x00007ff,
+								vdf_x[0] >> 21 & 0x00007ff);
 							rx_dt[cal] = (vdf_y[1]>>20)-(vdf_y[0]>>20);
-							RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "Rx_dt = %d\n", rx_dt[cal]);
+							rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "Rx_dt = %d\n",
+								rx_dt[cal]);
 							rx_dt[cal] = ((16*rx_dt[cal])*10000/13823);
 							rx_dt[cal] = (rx_dt[cal] >> 1)+(rx_dt[cal] & BIT(0));
 							rtl_write_dword(rtlpriv, 0xc80, 0x18008c20);/* TX_TONE_idx[9:0], TxK_Mask[29] TX_Tone = 16 */
@@ -4098,10 +4102,10 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 						tx_x0_rxk[cal] = tx_x0[cal];
 						tx_y0_rxk[cal] = tx_y0[cal];
 						tx0iqkok = true;
-						RT_TRACE(rtlpriv,
-							 COMP_IQK,
-							 DBG_LOUD,
-							 "RXK Step 1 fail\n");
+						rtl_dbg(rtlpriv,
+							COMP_IQK,
+							DBG_LOUD,
+							"RXK Step 1 fail\n");
 					}
 
 					/* ====== RX IQK ====== */
@@ -4257,8 +4261,8 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 					tx_x0_rxk[cal] = tx_x0[cal];
 					tx_y0_rxk[cal] = tx_y0[cal];
 					tx0iqkok = true;
-					RT_TRACE(rtlpriv, COMP_IQK,
-						 DBG_LOUD, "1");
+					rtl_dbg(rtlpriv, COMP_IQK,
+						DBG_LOUD, "1");
 				}
 
 				/* ====== RX IQK ====== */
@@ -4352,20 +4356,20 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 	/* FillIQK Result */
 	switch (path) {
 	case RF90_PATH_A:
-		RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			 "========Path_A =======\n");
+		rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+			"========Path_A =======\n");
 		if (tx_average == 0)
 			break;
 
 		for (i = 0; i < tx_average; i++) {
-			RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-				 "TX_X0_RXK[%d] = %x ;; TX_Y0_RXK[%d] = %x\n", i,
-				 (tx_x0_rxk[i])>>21&0x000007ff, i,
-				 (tx_y0_rxk[i])>>21&0x000007ff);
-			RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-				 "TX_X0[%d] = %x ;; TX_Y0[%d] = %x\n", i,
-				 (tx_x0[i])>>21&0x000007ff, i,
-				 (tx_y0[i])>>21&0x000007ff);
+			rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+				"TX_X0_RXK[%d] = %x ;; TX_Y0_RXK[%d] = %x\n", i,
+				(tx_x0_rxk[i]) >> 21 & 0x000007ff, i,
+				(tx_y0_rxk[i]) >> 21 & 0x000007ff);
+			rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+				"TX_X0[%d] = %x ;; TX_Y0[%d] = %x\n", i,
+				(tx_x0[i]) >> 21 & 0x000007ff, i,
+				(tx_y0[i]) >> 21 & 0x000007ff);
 		}
 		for (i = 0; i < tx_average; i++) {
 			for (ii = i+1; ii < tx_average; ii++) {
@@ -4393,7 +4397,7 @@ static void _rtl8821ae_iqk_tx(struct ieee80211_hw *hw, enum radio_path path)
 			break;
 
 		for (i = 0; i < rx_average; i++)
-			RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
+			rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
 				"RX_X0[%d] = %x ;; RX_Y0[%d] = %x\n", i,
 				(rx_x0[i])>>21&0x000007ff, i,
 				(rx_y0[i])>>21&0x000007ff);
@@ -4439,8 +4443,8 @@ static void _rtl8821ae_iqk_restore_rf(struct ieee80211_hw *hw,
 
 	switch (path) {
 	case RF90_PATH_A:
-		RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-			 "RestoreRF Path A Success!!!!\n");
+		rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+			"RestoreRF Path A Success!!!!\n");
 		break;
 	default:
 			break;
@@ -4468,7 +4472,7 @@ static void _rtl8821ae_iqk_restore_afe(struct ieee80211_hw *hw,
 	rtl_write_dword(rtlpriv, 0xcc4, 0x20040000);
 	rtl_write_dword(rtlpriv, 0xcc8, 0x20000000);
 	rtl_write_dword(rtlpriv, 0xcb8, 0x0);
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "RestoreAFE Success!!!!\n");
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "RestoreAFE Success!!!!\n");
 }
 
 static void _rtl8821ae_iqk_restore_macbb(struct ieee80211_hw *hw,
@@ -4483,7 +4487,7 @@ static void _rtl8821ae_iqk_restore_macbb(struct ieee80211_hw *hw,
 	/* Reload MacBB Parameters */
 	for (i = 0; i < macbb_num; i++)
 		rtl_write_dword(rtlpriv, backup_macbb_reg[i], macbb_backup[i]);
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD, "RestoreMacBB Success!!!!\n");
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD, "RestoreMacBB Success!!!!\n");
 }
 
 #undef MACBB_REG_NUM
@@ -4531,7 +4535,7 @@ static void _rtl8821ae_phy_set_rfpath_switch(struct ieee80211_hw *hw, bool main)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	/* struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw)); */
 	/* struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw)); */
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 
 	if (main)
 		rtl_set_bbreg(hw, RA_RFE_PINMUX + 4, BIT(29) | BIT(28), 0x1);
@@ -4579,11 +4583,11 @@ void rtl8821ae_reset_iqk_result(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u8 i;
 
-	RT_TRACE(rtlpriv, COMP_IQK, DBG_LOUD,
-		 "rtl8812ae_dm_reset_iqk_result:: settings regs %d default regs %d\n",
-		 (int)(sizeof(rtlphy->iqk_matrix) /
-		 sizeof(struct iqk_matrix_regs)),
-		 IQK_MATRIX_SETTINGS_NUM);
+	rtl_dbg(rtlpriv, COMP_IQK, DBG_LOUD,
+		"rtl8812ae_dm_reset_iqk_result:: settings regs %d default regs %d\n",
+		(int)(sizeof(rtlphy->iqk_matrix) /
+		sizeof(struct iqk_matrix_regs)),
+		IQK_MATRIX_SETTINGS_NUM);
 
 	for (i = 0; i < IQK_MATRIX_SETTINGS_NUM; i++) {
 		rtlphy->iqk_matrix[i].value[0][0] = 0x100;
@@ -4630,20 +4634,20 @@ bool rtl8821ae_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
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
 		case IO_CMD_PAUSE_BAND1_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-				 "[IO CMD] Pause DM before scan.\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Pause DM before scan.\n");
 			postprocessing = true;
 			break;
 		default:
@@ -4659,7 +4663,7 @@ bool rtl8821ae_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl8821ae_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -4669,9 +4673,9 @@ static void rtl8821ae_phy_set_io(struct ieee80211_hw *hw)
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
 		if (rtlpriv->mac80211.opmode == NL80211_IFTYPE_ADHOC)
@@ -4696,8 +4700,8 @@ static void rtl8821ae_phy_set_io(struct ieee80211_hw *hw)
 		break;
 	}
 	rtlphy->set_io_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "(%#x)\n", rtlphy->current_io_type);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"(%#x)\n", rtlphy->current_io_type);
 }
 
 static void rtl8821ae_phy_set_rf_on(struct ieee80211_hw *hw)
@@ -4731,18 +4735,17 @@ static bool _rtl8821ae_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
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
+						 ppsc->last_sleep_jiffies));
 			ppsc->last_awake_jiffies = jiffies;
 			rtl8821ae_phy_set_rf_on(hw);
 		}
@@ -4763,27 +4766,27 @@ static bool _rtl8821ae_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rf.c
index a6e56872e063..e339f2383e6d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rf.c
@@ -428,13 +428,13 @@ static bool _rtl8821ae_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 		}
 
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "Radio[%d] Fail!!\n", rfpath);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
 			return false;
 		}
 	}
 
 	/*put arrays in dm.c*/
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
 	return rtstatus;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
index cd809c992245..c0f298c9da40 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.c
@@ -391,7 +391,7 @@ static bool rtl8821ae_get_rxdesc_is_ht(struct ieee80211_hw *hw, __le32 *pdesc)
 
 	rx_rate = get_rx_desc_rxmcs(pdesc);
 
-	RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD, "rx_rate=0x%02x.\n", rx_rate);
+	rtl_dbg(rtlpriv, COMP_RXDESC, DBG_LOUD, "rx_rate=0x%02x.\n", rx_rate);
 
 	if ((rx_rate >= DESC_RATEMCS0) && (rx_rate <= DESC_RATEMCS15))
 		return true;
@@ -405,7 +405,7 @@ static bool rtl8821ae_get_rxdesc_is_vht(struct ieee80211_hw *hw, __le32 *pdesc)
 
 	rx_rate = get_rx_desc_rxmcs(pdesc);
 
-	RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD, "rx_rate=0x%02x.\n", rx_rate);
+	rtl_dbg(rtlpriv, COMP_RXDESC, DBG_LOUD, "rx_rate=0x%02x.\n", rx_rate);
 
 	if (rx_rate >= DESC_RATEVHT1SS_MCS0)
 		return true;
@@ -461,12 +461,12 @@ bool rtl8821ae_rx_query_desc(struct ieee80211_hw *hw,
 	status->vht_nss = rtl8821ae_get_rx_vht_nss(hw, pdesc);
 	status->is_cck = RTL8821AE_RX_HAL_IS_CCK_RATE(status->rate);
 
-	RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD,
-		 "rx_packet_bw=%s,is_ht %d, is_vht %d, vht_nss=%d,is_short_gi %d.\n",
-		 (status->rx_packet_bw == 2) ? "80M" :
-		 (status->rx_packet_bw == 1) ? "40M" : "20M",
-		 status->is_ht, status->is_vht, status->vht_nss,
-		 status->is_short_gi);
+	rtl_dbg(rtlpriv, COMP_RXDESC, DBG_LOUD,
+		"rx_packet_bw=%s,is_ht %d, is_vht %d, vht_nss=%d,is_short_gi %d.\n",
+		(status->rx_packet_bw == 2) ? "80M" :
+		(status->rx_packet_bw == 1) ? "40M" : "20M",
+		status->is_ht, status->is_vht, status->vht_nss,
+		status->is_short_gi);
 
 	if (get_rx_status_desc_rpt_sel(pdesc))
 		status->packet_report_type = C2H_PACKET;
@@ -483,9 +483,9 @@ bool rtl8821ae_rx_query_desc(struct ieee80211_hw *hw,
 		wake_match = 0;
 
 	if (wake_match)
-		RT_TRACE(rtlpriv, COMP_RXDESC, DBG_LOUD,
-			 "GGGGGGGGGGGGGet Wakeup Packet!! WakeMatch=%d\n",
-			 wake_match);
+		rtl_dbg(rtlpriv, COMP_RXDESC, DBG_LOUD,
+			"GGGGGGGGGGGGGet Wakeup Packet!! WakeMatch=%d\n",
+			wake_match);
 	rx_status->freq = hw->conf.chandef.chan->center_freq;
 	rx_status->band = hw->conf.chandef.chan->band;
 
@@ -558,9 +558,10 @@ static u8 rtl8821ae_bw_mapping(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u8 bw_setting_of_desc = 0;
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-		 "rtl8821ae_bw_mapping, current_chan_bw %d, packet_bw %d\n",
-		 rtlphy->current_chan_bw, ptcb_desc->packet_bw);
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+		"%s, current_chan_bw %d, packet_bw %d\n",
+		__func__,
+		rtlphy->current_chan_bw, ptcb_desc->packet_bw);
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_80) {
 		if (ptcb_desc->packet_bw == HT_CHANNEL_WIDTH_80)
@@ -602,8 +603,9 @@ static u8 rtl8821ae_sc_mapping(struct ieee80211_hw *hw,
 				sc_setting_of_desc =
 					VHT_DATA_SC_40_UPPER_OF_80MHZ;
 			else
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_LOUD,
-					 "rtl8821ae_sc_mapping: Not Correct Primary40MHz Setting\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_LOUD,
+					"%s: Not Correct Primary40MHz Setting\n",
+					__func__);
 		} else {
 			if ((mac->cur_40_prime_sc ==
 			     HAL_PRIME_CHNL_OFFSET_LOWER) &&
@@ -630,8 +632,9 @@ static u8 rtl8821ae_sc_mapping(struct ieee80211_hw *hw,
 				sc_setting_of_desc =
 					VHT_DATA_SC_20_UPPERST_OF_80MHZ;
 			else
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_LOUD,
-					 "rtl8821ae_sc_mapping: Not Correct Primary40MHz Setting\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_LOUD,
+					"%s: Not Correct Primary40MHz Setting\n",
+					__func__);
 		}
 	} else if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
 		if (ptcb_desc->packet_bw == HT_CHANNEL_WIDTH_20_40) {
@@ -693,8 +696,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_8821ae));
@@ -708,9 +711,9 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
-					  ptcb_desc->empkt_num);
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Insert 8 byte.pTcb->EMPktNum:%d\n",
+					ptcb_desc->empkt_num);
 				rtl8821ae_insert_emcontent(ptcb_desc,
 							   (__le32 *)skb->data);
 			}
@@ -789,8 +792,8 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Enable RDG function.\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
 			}
@@ -822,7 +825,7 @@ void rtl8821ae_tx_fill_desc(struct ieee80211_hw *hw,
 	}
 
 	rtl8821ae_dm_set_tx_ant_by_tx_info(hw, pdesc8, ptcb_desc->mac_id);
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -839,8 +842,8 @@ void rtl8821ae_tx_fill_cmddesc(struct ieee80211_hw *hw,
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
2.28.0

