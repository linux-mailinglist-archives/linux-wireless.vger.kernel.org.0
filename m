Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B5522B7F3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGWUmz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGWUmx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:53 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981AC0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:53 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 12so6218565oir.4
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SVBTIjF+AvcWWhUrTrZsZOqPzSWw2Ift5XnZAmfYhrw=;
        b=KNwch8YIdeycROdrbC/vT+kIyt5p+WokyPR9OflCZ45cDmyejOKvTT9WjZbfm26+eq
         5s3+9KnCBRw9ltPCAz6mJ1JlNWB6P15GDnzURZfHBHzlLw77Bk5KCofu99HxQR6N9U0E
         RpfE+GBJc+ZWekP7xGwdUnCHrNafHsa6dgQc+IN6AVfzzOcUJmbrARhmKwbLTZ8l8x3x
         CXhWyQHOp8l4GwbpryEQXtHEy9LpzIa/RZNAtXHewMR6vgaKm0eyhj/yfKRyKQEyVib/
         qj5m7x33ALgvu6/URuwb5Ekg47ayML9CZ2gk2tR3yybQR/Yv3SoAdu9nzfCYzclqD38O
         1gPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SVBTIjF+AvcWWhUrTrZsZOqPzSWw2Ift5XnZAmfYhrw=;
        b=PzDzpt0kEcxh3jvp7T1RGieZ7ITeRmnrnM6QPU7zZxRd2RBj3otir0gPONcjWVRBjH
         5I2zJY4FHDHVCL8UMsuLvfQ5I02+yzNXFUIw1z0+jib9t740Hf6IBA4QfQcEAynTUxJf
         5Iq2yC/YnghHfifdsSBitdSe7J9XRVT5CfaT5Z8O/CNdwYOolPp9raJz/qu5lg92+B11
         vb5xbsUDBPeKYL2vlU+v+aL9PmWkmJ31msF+L+DkyYO27/kxG52vl0rt7mYVmIe24sIg
         pk6On1+CXO5D/NQeHcZYQscgqTr33h4sZ6uemibaAwI/DRBMdxsZnfwzeXlaeIWi0Sgv
         ODIQ==
X-Gm-Message-State: AOAM531WAfuc9gr/90mgRFNBGsDnrGOT1iYViCBU9iRdNU7sMcLFjRVJ
        90dIytJCrPB61OKv/fNsv90ucRT2
X-Google-Smtp-Source: ABdhPJxmEdR0igJ/csZU+puVYXOGe+4SHYuhNhC1dLF0K049d7n931vCV8ZDk3XpbKHt+gJy778a7A==
X-Received: by 2002:aca:4a47:: with SMTP id x68mr5283625oia.24.1595536972779;
        Thu, 23 Jul 2020 13:42:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:52 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 05/15] rtlwifi: rtl8192-common: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:34 -0500
Message-Id: <20200723204244.24457-6-Larry.Finger@lwfinger.net>
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
rtl8192-common. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../realtek/rtlwifi/rtl8192c/dm_common.c      | 224 +++++++--------
 .../realtek/rtlwifi/rtl8192c/fw_common.c      |  88 +++---
 .../realtek/rtlwifi/rtl8192c/phy_common.c     | 258 +++++++++---------
 3 files changed, 285 insertions(+), 285 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index 06fc9b5cdd8f..265a1a336304 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -242,16 +242,16 @@ static void rtl92c_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
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
@@ -408,10 +408,10 @@ static void rtl92c_dm_initial_gain_multi_sta(struct ieee80211_hw *hw)
 		rtl92c_dm_write_dig(hw);
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
 
 static void rtl92c_dm_initial_gain_sta(struct ieee80211_hw *hw)
@@ -419,9 +419,9 @@ static void rtl92c_dm_initial_gain_sta(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "presta_cstate = %x, cursta_cstate = %x\n",
-		 dm_digtable->presta_cstate, dm_digtable->cursta_cstate);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_TRACE,
+		"presta_cstate = %x, cursta_cstate = %x\n",
+		dm_digtable->presta_cstate, dm_digtable->cursta_cstate);
 	if (dm_digtable->presta_cstate == dm_digtable->cursta_cstate ||
 	    dm_digtable->cursta_cstate == DIG_STA_BEFORE_CONNECT ||
 	    dm_digtable->cursta_cstate == DIG_STA_CONNECT) {
@@ -537,10 +537,10 @@ void rtl92c_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
-		 dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
-		 dm_digtable->back_val);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
+		dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
+		dm_digtable->back_val);
 
 	if (rtlpriv->rtlhal.interface == INTF_USB &&
 	    !dm_digtable->dig_enable_flag) {
@@ -559,12 +559,12 @@ void rtl92c_dm_write_dig(struct ieee80211_hw *hw)
 
 		dm_digtable->pre_igvalue = dm_digtable->cur_igvalue;
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_WARNING,
-		 "dig values 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
-		 dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
-		 dm_digtable->rssi_val_min, dm_digtable->back_val,
-		 dm_digtable->rx_gain_max, dm_digtable->rx_gain_min,
-		 dm_digtable->large_fa_hit, dm_digtable->forbidden_igi);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_WARNING,
+		"dig values 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+		dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
+		dm_digtable->rssi_val_min, dm_digtable->back_val,
+		dm_digtable->rx_gain_max, dm_digtable->rx_gain_min,
+		dm_digtable->large_fa_hit, dm_digtable->forbidden_igi);
 }
 EXPORT_SYMBOL(rtl92c_dm_write_dig);
 
@@ -713,15 +713,15 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 	u8 ofdm_min_index = 6, rf;
 
 	rtlpriv->dm.txpower_trackinginit = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "rtl92c_dm_txpower_tracking_callback_thermalmeter\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"%s\n", __func__);
 
 	thermalvalue = (u8) rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0x1f);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
-		 thermalvalue, rtlpriv->dm.thermalvalue,
-		 rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
+		thermalvalue, rtlpriv->dm.thermalvalue,
+		rtlefuse->eeprom_thermalmeter);
 
 	rtl92c_phy_ap_calibrate(hw, (thermalvalue -
 				     rtlefuse->eeprom_thermalmeter));
@@ -738,10 +738,10 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 			if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 				ofdm_index_old[0] = (u8) i;
 
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
-					 ROFDM0_XATXIQIMBALANCE,
-					 ele_d, ofdm_index_old[0]);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
+					ROFDM0_XATXIQIMBALANCE,
+					ele_d, ofdm_index_old[0]);
 				break;
 			}
 		}
@@ -754,11 +754,11 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 				if (ele_d == (ofdmswing_table[i] &
 				    MASKOFDM_D)) {
 					ofdm_index_old[1] = (u8) i;
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-						 DBG_LOUD,
-						 "Initial pathB ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
-						 ROFDM0_XBTXIQIMBALANCE, ele_d,
-						 ofdm_index_old[1]);
+					rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+						DBG_LOUD,
+						"Initial pathB ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
+						ROFDM0_XBTXIQIMBALANCE, ele_d,
+						ofdm_index_old[1]);
 					break;
 				}
 			}
@@ -774,12 +774,12 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 					   4) == 0) {
 					cck_index_old = (u8) i;
 
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-						 DBG_LOUD,
-						 "Initial reg0x%x = 0x%lx, cck_index=0x%x, ch 14 %d\n",
-						 RCCK0_TXFILTER2, temp_cck,
-						 cck_index_old,
-						 rtlpriv->dm.cck_inch14);
+					rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+						DBG_LOUD,
+						"Initial reg0x%x = 0x%lx, cck_index=0x%x, ch 14 %d\n",
+						RCCK0_TXFILTER2, temp_cck,
+						cck_index_old,
+						rtlpriv->dm.cck_inch14);
 					break;
 				}
 			} else {
@@ -789,12 +789,12 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 					   4) == 0) {
 					cck_index_old = (u8) i;
 
-					RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-						 DBG_LOUD,
-						 "Initial reg0x%x = 0x%lx, cck_index=0x%x, ch14 %d\n",
-						 RCCK0_TXFILTER2, temp_cck,
-						 cck_index_old,
-						 rtlpriv->dm.cck_inch14);
+					rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+						DBG_LOUD,
+						"Initial reg0x%x = 0x%lx, cck_index=0x%x, ch14 %d\n",
+						RCCK0_TXFILTER2, temp_cck,
+						cck_index_old,
+						rtlpriv->dm.cck_inch14);
 					break;
 				}
 			}
@@ -823,11 +823,11 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 		    (thermalvalue - rtlpriv->dm.thermalvalue_iqk) :
 		    (rtlpriv->dm.thermalvalue_iqk - thermalvalue);
 
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
-			 thermalvalue, rtlpriv->dm.thermalvalue,
-			 rtlefuse->eeprom_thermalmeter, delta, delta_lck,
-			 delta_iqk);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
+			thermalvalue, rtlpriv->dm.thermalvalue,
+			rtlefuse->eeprom_thermalmeter, delta, delta_lck,
+			delta_iqk);
 
 		if (delta_lck > 1) {
 			rtlpriv->dm.thermalvalue_lck = thermalvalue;
@@ -846,16 +846,16 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 			}
 
 			if (is2t) {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "temp OFDM_A_index=0x%x, OFDM_B_index=0x%x, cck_index=0x%x\n",
-					 rtlpriv->dm.ofdm_index[0],
-					 rtlpriv->dm.ofdm_index[1],
-					 rtlpriv->dm.cck_index);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"temp OFDM_A_index=0x%x, OFDM_B_index=0x%x, cck_index=0x%x\n",
+					rtlpriv->dm.ofdm_index[0],
+					rtlpriv->dm.ofdm_index[1],
+					rtlpriv->dm.cck_index);
 			} else {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "temp OFDM_A_index=0x%x, cck_index=0x%x\n",
-					 rtlpriv->dm.ofdm_index[0],
-					 rtlpriv->dm.cck_index);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"temp OFDM_A_index=0x%x, cck_index=0x%x\n",
+					rtlpriv->dm.ofdm_index[0],
+					rtlpriv->dm.cck_index);
 			}
 
 			if (thermalvalue > rtlefuse->eeprom_thermalmeter) {
@@ -946,14 +946,14 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 				cck_index = 0;
 
 			if (is2t) {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "new OFDM_A_index=0x%x, OFDM_B_index=0x%x, cck_index=0x%x\n",
-					 ofdm_index[0], ofdm_index[1],
-					 cck_index);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"new OFDM_A_index=0x%x, OFDM_B_index=0x%x, cck_index=0x%x\n",
+					ofdm_index[0], ofdm_index[1],
+					cck_index);
 			} else {
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-					 "new OFDM_A_index=0x%x, cck_index=0x%x\n",
-					 ofdm_index[0], cck_index);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+					"new OFDM_A_index=0x%x, cck_index=0x%x\n",
+					ofdm_index[0], cck_index);
 			}
 		}
 
@@ -1111,7 +1111,7 @@ static void rtl92c_dm_txpower_tracking_callback_thermalmeter(struct ieee80211_hw
 			rtlpriv->dm.thermalvalue = thermalvalue;
 	}
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
 
 }
 
@@ -1123,9 +1123,9 @@ static void rtl92c_dm_initialize_txpower_tracking_thermalmeter(
 	rtlpriv->dm.txpower_tracking = true;
 	rtlpriv->dm.txpower_trackinginit = false;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "pMgntInfo->txpower_tracking = %d\n",
-		 rtlpriv->dm.txpower_tracking);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"pMgntInfo->txpower_tracking = %d\n",
+		rtlpriv->dm.txpower_tracking);
 }
 
 static void rtl92c_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
@@ -1149,13 +1149,13 @@ static void rtl92c_dm_check_txpower_tracking_thermal_meter(
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, RFREG_OFFSET_MASK,
 			      0x60);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Trigger 92S Thermal Meter!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Trigger 92S Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "Schedule TxPowerTracking direct call!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"Schedule TxPowerTracking direct call!!\n");
 		rtl92c_dm_txpower_tracking_directcall(hw);
 		rtlpriv->dm.tm_trigger = 0;
 	}
@@ -1276,29 +1276,29 @@ static void rtl92c_dm_dynamic_bb_powersaving(struct ieee80211_hw *hw)
 	if (((mac->link_state == MAC80211_NOLINK)) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
 		dm_pstable->rssi_val_min = 0;
-		RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD, "Not connected to any\n");
+		rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD, "Not connected to any\n");
 	}
 
 	if (mac->link_state == MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			dm_pstable->rssi_val_min =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-				 dm_pstable->rssi_val_min);
+			rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				dm_pstable->rssi_val_min);
 		} else {
 			dm_pstable->rssi_val_min = rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%lx\n",
-				 dm_pstable->rssi_val_min);
+			rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+				"STA Default Port PWDB = 0x%lx\n",
+				dm_pstable->rssi_val_min);
 		}
 	} else {
 		dm_pstable->rssi_val_min =
 		    rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
-			 "AP Ext Port PWDB = 0x%lx\n",
-			 dm_pstable->rssi_val_min);
+		rtl_dbg(rtlpriv, DBG_LOUD, DBG_LOUD,
+			"AP Ext Port PWDB = 0x%lx\n",
+			dm_pstable->rssi_val_min);
 	}
 
 	/* Power Saving for 92C */
@@ -1350,8 +1350,8 @@ void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 
@@ -1362,42 +1362,42 @@ void rtl92c_dm_dynamic_txpower(struct ieee80211_hw *hw)
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb = rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
-				 undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb = rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%lx\n",
-				 undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"STA Default Port PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		}
 	} else {
 		undec_sm_pwdb = rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "AP Ext Port PWDB = 0x%lx\n",
-			 undec_sm_pwdb);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"AP Ext Port PWDB = 0x%lx\n",
+			undec_sm_pwdb);
 	}
 
 	if (undec_sm_pwdb >= TX_POWER_NEAR_FIELD_THRESH_LVL2) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL2;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
 	} else if ((undec_sm_pwdb < (TX_POWER_NEAR_FIELD_THRESH_LVL2 - 3)) &&
 		   (undec_sm_pwdb >= TX_POWER_NEAR_FIELD_THRESH_LVL1)) {
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
 	} else if (undec_sm_pwdb < (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "TXHIGHPWRLEVEL_NORMAL\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"TXHIGHPWRLEVEL_NORMAL\n");
 	}
 
 	if ((rtlpriv->dm.dynamic_txhighpower_lvl != rtlpriv->dm.last_dtp_lvl)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"PHY_SetTxPowerLevel8192S() Channel = %d\n",
 			 rtlphy->current_channel);
 		rtl92c_phy_set_txpower_level(hw, rtlphy->current_channel);
 		if (rtlpriv->dm.dynamic_txhighpower_lvl ==
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
index 86b1b88cc4ed..b618f07f29b0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.c
@@ -54,7 +54,7 @@ static void _rtl92c_write_fw(struct ieee80211_hw *hw,
 	bool is_version_b;
 	u8 *bufferptr = (u8 *)buffer;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
 	is_version_b = IS_NORMAL_CHIP(version);
 	if (is_version_b) {
 		u32 pagenums, remainsize;
@@ -143,10 +143,10 @@ int rtl92c_download_fw(struct ieee80211_hw *hw)
 	pfwdata = (u8 *)rtlhal->pfirmware;
 	fwsize = rtlhal->fwsize;
 	if (IS_FW_HEADER_EXIST(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Firmware Version(%d), Signature(%#x),Size(%d)\n",
-			  pfwheader->version, pfwheader->signature,
-			  (int)sizeof(struct rtlwifi_firmware_header));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Firmware Version(%d), Signature(%#x),Size(%d)\n",
+			pfwheader->version, pfwheader->signature,
+			(int)sizeof(struct rtlwifi_firmware_header));
 
 		rtlhal->fw_version = le16_to_cpu(pfwheader->version);
 		rtlhal->fw_subversion = pfwheader->subversion;
@@ -198,21 +198,21 @@ static void _rtl92c_fill_h2c_command(struct ieee80211_hw *hw,
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
+					 h2c_waitcounter);
 				udelay(100);
 
 				if (h2c_waitcounter > 1000)
@@ -254,8 +254,8 @@ static void _rtl92c_fill_h2c_command(struct ieee80211_hw *hw,
 			box_extreg = REG_HMEBOX_EXT_3;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", boxnum);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", boxnum);
 			break;
 		}
 
@@ -263,9 +263,9 @@ static void _rtl92c_fill_h2c_command(struct ieee80211_hw *hw,
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
 
@@ -273,24 +273,24 @@ static void _rtl92c_fill_h2c_command(struct ieee80211_hw *hw,
 
 			isfw_read = _rtl92c_check_fw_read_last_h2c(hw, boxnum);
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
@@ -358,8 +358,8 @@ static void _rtl92c_fill_h2c_command(struct ieee80211_hw *hw,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", cmd_len);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", cmd_len);
 			break;
 		}
 
@@ -369,16 +369,16 @@ static void _rtl92c_fill_h2c_command(struct ieee80211_hw *hw,
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
 
 void rtl92c_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -428,7 +428,7 @@ void rtl92c_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	u8 u1_h2c_set_pwrmode[3] = { 0 };
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
 
 	SET_H2CCMD_PWRMODE_PARM_MODE(u1_h2c_set_pwrmode, mode);
 	SET_H2CCMD_PWRMODE_PARM_SMART_PS(u1_h2c_set_pwrmode,
@@ -636,16 +636,16 @@ void rtl92c_set_fw_rsvdpagepkt(struct ieee80211_hw *hw,
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Set RSVD page location to Fw.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 				"H2C_RSVDPAGE:\n",
 				u1rsvdpageloc, 3);
 		rtl92c_fill_h2c_cmd(hw, H2C_RSVDPAGE,
 				    sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 EXPORT_SYMBOL(rtl92c_set_fw_rsvdpagepkt);
 
@@ -717,13 +717,13 @@ void rtl92c_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
-			RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-				 "P2P_PS_DISABLE\n");
+			rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+				"P2P_PS_DISABLE\n");
 			memset(p2p_ps_offload, 0, sizeof(*p2p_ps_offload));
 			break;
 	case P2P_PS_ENABLE:
-			RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-				 "P2P_PS_ENABLE\n");
+			rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+				"P2P_PS_ENABLE\n");
 			/* update CTWindow value. */
 			if (p2pinfo->ctwindow > 0) {
 				p2p_ps_offload->ctwindow_en = 1;
@@ -751,12 +751,12 @@ void rtl92c_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 			}
 			break;
 	case P2P_PS_SCAN:
-			RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
+			rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
 			p2p_ps_offload->discovery = 1;
 			break;
 	case P2P_PS_SCAN_DONE:
-			RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD,
-				 "P2P_PS_SCAN_DONE\n");
+			rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD,
+				"P2P_PS_SCAN_DONE\n");
 			p2p_ps_offload->discovery = 0;
 			p2pinfo->p2p_ps_state = P2P_PS_ENABLE;
 			break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
index 661249d618c0..e633a8e7f48a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/phy_common.c
@@ -14,15 +14,15 @@ u32 rtl92c_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
-		 regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
+		regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
-		 bitmask, regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+		bitmask, regaddr, originalvalue);
 
 	return returnvalue;
 }
@@ -34,9 +34,9 @@ void rtl92c_phy_set_bb_reg(struct ieee80211_hw *hw,
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
@@ -46,9 +46,9 @@ void rtl92c_phy_set_bb_reg(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 }
 EXPORT_SYMBOL(rtl92c_phy_set_bb_reg);
 
@@ -112,9 +112,9 @@ u32 _rtl92c_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 					 BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x]=0x%x\n",
-					       rfpath, pphyreg->rf_rb,
-					       retvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf_rb,
+		retvalue);
 	return retvalue;
 }
 EXPORT_SYMBOL(_rtl92c_phy_rf_serial_read);
@@ -137,9 +137,9 @@ void _rtl92c_phy_rf_serial_write(struct ieee80211_hw *hw,
 	newoffset = offset;
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
-					       rfpath, pphyreg->rf3wire_offset,
-					       data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset,
+		data_and_addr);
 }
 EXPORT_SYMBOL(_rtl92c_phy_rf_serial_write);
 
@@ -192,7 +192,7 @@ bool _rtl92c_phy_bb8192c_config_parafile(struct ieee80211_hw *hw)
 	}
 	if (rtlphy->rf_type == RF_1T2R) {
 		_rtl92c_phy_bb_config_1t(hw);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
 	}
 	if (rtlefuse->autoload_failflag == false) {
 		rtlphy->pwrgroup_cnt = 0;
@@ -227,145 +227,145 @@ void _rtl92c_store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
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
-							    pwrgroup_cnt][1]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset
+			[rtlphy->pwrgroup_cnt][1]);
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
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][7]);
 	}
 	if (regaddr == RTXAGC_A_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][2] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][2]);
 	}
 	if (regaddr == RTXAGC_A_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][3] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][3]);
 	}
 	if (regaddr == RTXAGC_A_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][4] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][4]);
 	}
 	if (regaddr == RTXAGC_A_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][5] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][5]);
 	}
 	if (regaddr == RTXAGC_B_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][8] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][8]);
 	}
 	if (regaddr == RTXAGC_B_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][9] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][9]);
 	}
 	if (regaddr == RTXAGC_B_CCK1_55_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][14] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][14]);
 	}
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][15] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][15]);
 	}
 	if (regaddr == RTXAGC_B_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][10] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][10]);
 	}
 	if (regaddr == RTXAGC_B_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][11] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][11]);
 	}
 	if (regaddr == RTXAGC_B_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][12] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][12]);
 	}
 	if (regaddr == RTXAGC_B_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][13] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
-			  rtlphy->pwrgroup_cnt,
-			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
+			rtlphy->pwrgroup_cnt,
+			rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
 							    pwrgroup_cnt][13]);
 
 		rtlphy->pwrgroup_cnt++;
@@ -387,21 +387,21 @@ void rtl92c_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
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
 
 void _rtl92c_phy_init_bb_rf_register_definition(struct ieee80211_hw *hw)
@@ -588,9 +588,9 @@ bool rtl92c_phy_update_txpower_dbm(struct ieee80211_hw *hw, long power_indbm)
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
@@ -675,8 +675,8 @@ void rtl92c_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtlpriv->cfg->ops->phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
 	}
@@ -690,8 +690,8 @@ void rtl92c_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u32 delay;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
 	do {
@@ -709,7 +709,7 @@ void rtl92c_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 EXPORT_SYMBOL(rtl92c_phy_sw_chnl_callback);
 
@@ -730,12 +730,12 @@ u8 rtl92c_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl92c_phy_sw_chnl_callback(hw);
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
@@ -884,9 +884,9 @@ bool _rtl92c_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
 			_rtl92c_phy_sw_rf_seting(hw, channel);
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
 
@@ -1522,24 +1522,24 @@ bool rtl92c_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
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
@@ -1550,7 +1550,7 @@ bool rtl92c_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl92c_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 EXPORT_SYMBOL(rtl92c_phy_set_io_cmd);
@@ -1561,9 +1561,9 @@ void rtl92c_phy_set_io(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
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
@@ -1576,14 +1576,14 @@ void rtl92c_phy_set_io(struct ieee80211_hw *hw)
 		rtl92c_dm_write_dig(hw);
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
 EXPORT_SYMBOL(rtl92c_phy_set_io);
 
@@ -1622,8 +1622,8 @@ void _rtl92c_phy_set_rf_sleep(struct ieee80211_hw *hw)
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
-- 
2.27.0

