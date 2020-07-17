Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847082230F8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgGQCCz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgGQCCo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A89C08C5E3
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:31 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w17so5800536otl.4
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iDdYf1/jPGQUwPY8eSrRptsNVaTu9M9BVv9ktSqaI8s=;
        b=DU1YsuyMJ2xMP+ZfqG0HQvCD+A+h/uHn0V3S7MyM10CSaR995FmmmEMKcaDrKTVmrc
         z36am2G775791s4An53FXw19PPPuMk22pMNBB7UFPc/xU03hMJjG2Tiebm8TdWkADJCK
         QWxXxISv3jHe0ZyO5h9AqEyIYfWwC5y76PRLrM+94f3jsydNkl5Iwkp9nDNdUDiX1OVs
         D3ZIK/XI443yq6NsZQN1LL82B13kQ1UauAFhKCjpecV7vRvQY4GNUtqEuYVgFOIv4/kU
         JzdqlLHeQ/rdt3LOjWUNWicrmPPBfnbxL3uv53bT0YGqW0Ir+pJNS0EFgig80dKAV+lp
         TjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iDdYf1/jPGQUwPY8eSrRptsNVaTu9M9BVv9ktSqaI8s=;
        b=RCo5x1dmOpIhQET31Q6oLQkoBPh3Irq5lpDL3EAjNrxMnQrdX1Dvbj9rN4Fi6EkcB6
         EDCQZ3LiUSPtnFNXSn+q/bPGw0vBCrahYziv3JVspmYZuQZD/QXtVB2Ohekjrz2UO+ks
         exoTBvofJj3e3sAB6Aai82EzkRvsHNnjSy/sHW8Ba9UQAiVW0EJMOFMdqPQMe8tSk2fh
         0X1mOCfj9cRa0m+Eh21GUOQMeEF0AEjkbyvPx9Cn1OmpS6JP+VZUP8kDMImibFtGWDjM
         X7akaC+McmM43WrdmP/dssGW0lRrc5G2V1m4RCdn+nT7j+WHCBm3dy56NHnEGIdpt7Nu
         VlLQ==
X-Gm-Message-State: AOAM530qS08+sIfN0VIo2a/OAWkVuzRcNDzuzKpC6kXeozV4sriiqe5q
        gxaHdIv3GslPLrgWJBYyY9Y5256S
X-Google-Smtp-Source: ABdhPJy2+noq6/U9T322xvqGwqjXlj1sL/8ZQYUKlhGrlb3TXnF6kd5UCYsCfWY0UgEGrBnZU3fI1w==
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr6754708ots.118.1594951350525;
        Thu, 16 Jul 2020 19:02:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:29 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 10/14] rtlwifi: rtl8723ae: Rename RT_TRACE to RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:57 -0500
Message-Id: <20200717020201.18209-11-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
References: <20200717020201.18209-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Change the misleading macro name to one that is more descriptive for
rtl8723ae.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8723ae/dm.c   |  58 +--
 .../wireless/realtek/rtlwifi/rtl8723ae/fw.c   |  32 +-
 .../rtlwifi/rtl8723ae/hal_bt_coexist.c        |  72 ++--
 .../realtek/rtlwifi/rtl8723ae/hal_btc.c       | 330 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8723ae/hw.c   | 112 +++---
 .../wireless/realtek/rtlwifi/rtl8723ae/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/phy.c  | 108 +++---
 .../wireless/realtek/rtlwifi/rtl8723ae/rf.c   |   4 +-
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.c  |   8 +-
 9 files changed, 365 insertions(+), 365 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
index c61a92df9d73..fcdfc5aea21b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
@@ -82,13 +82,13 @@ static void rtl8723e_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 0);
 	rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
 
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
@@ -150,7 +150,7 @@ static void rtl92c_dm_ctrl_initgain_by_rssi(struct ieee80211_hw *hw)
 		dm_digtable->cur_igvalue = dm_digtable->rssi_val_min + 10 -
 		    dm_digtable->back_val;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "rssi_val_min = %x back_val %x\n",
 		  dm_digtable->rssi_val_min, dm_digtable->back_val);
 
@@ -201,7 +201,7 @@ static void rtl8723e_dm_initial_gain_multi_sta(struct ieee80211_hw *hw)
 		rtl8723e_dm_write_dig(hw);
 	}
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "curmultista_cstate = %x dig_ext_port_stage %x\n",
 		 dm_digtable->curmultista_cstate,
 		 dm_digtable->dig_ext_port_stage);
@@ -212,7 +212,7 @@ static void rtl8723e_dm_initial_gain_sta(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "presta_cstate = %x, cursta_cstate = %x\n",
 		  dm_digtable->presta_cstate,
 		  dm_digtable->cursta_cstate);
@@ -296,7 +296,7 @@ static void rtl8723e_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 		dm_digtable->pre_cck_pd_state = dm_digtable->cur_cck_pd_state;
 	}
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_TRACE,
 		 "CCKPDStage=%x\n", dm_digtable->cur_cck_pd_state);
 
 }
@@ -354,7 +354,7 @@ static void rtl8723e_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
@@ -367,13 +367,13 @@ static void rtl8723e_dm_dynamic_txpower(struct ieee80211_hw *hw)
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
@@ -381,31 +381,31 @@ static void rtl8723e_dm_dynamic_txpower(struct ieee80211_hw *hw)
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
 			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
 	} else if ((undec_sm_pwdb <
 		    (TX_POWER_NEAR_FIELD_THRESH_LVL2 - 3)) &&
 		   (undec_sm_pwdb >=
 		    TX_POWER_NEAR_FIELD_THRESH_LVL1)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
 	} else if (undec_sm_pwdb <
 		   (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "TXHIGHPWRLEVEL_NORMAL\n");
 	}
 
 	if (rtlpriv->dm.dynamic_txhighpower_lvl != rtlpriv->dm.last_dtp_lvl) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
 			  rtlphy->current_channel);
 		rtl8723e_phy_set_txpower_level(hw, rtlphy->current_channel);
@@ -419,7 +419,7 @@ void rtl8723e_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
 		  dm_digtable->cur_igvalue, dm_digtable->pre_igvalue,
 		  dm_digtable->back_val);
@@ -521,7 +521,7 @@ static void rtl8723e_dm_initialize_txpower_tracking_thermalmeter(
 	rtlpriv->dm.txpower_tracking = true;
 	rtlpriv->dm.txpower_trackinginit = false;
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "pMgntInfo->txpower_tracking = %d\n",
 		  rtlpriv->dm.txpower_tracking);
 }
@@ -561,13 +561,13 @@ static void rtl8723e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
 	struct ieee80211_sta *sta = NULL;
 
 	if (is_hal_stop(rtlhal)) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 			 " driver is going to unload\n");
 		return;
 	}
 
 	if (!rtlpriv->dm.useramask) {
-		RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 			 " driver does not control rate adaptive mask\n");
 		return;
 	}
@@ -612,12 +612,12 @@ static void rtl8723e_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
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
 
@@ -716,7 +716,7 @@ static void rtl8723e_dm_dynamic_bb_powersaving(struct ieee80211_hw *hw)
 	if (((mac->link_state == MAC80211_NOLINK)) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
 		dm_pstable->rssi_val_min = 0;
-		RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, DBG_LOUD, DBG_LOUD,
 			 "Not connected to any\n");
 	}
 
@@ -724,13 +724,13 @@ static void rtl8723e_dm_dynamic_bb_powersaving(struct ieee80211_hw *hw)
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			dm_pstable->rssi_val_min =
 			    rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, DBG_LOUD, DBG_LOUD,
 				 "AP Client PWDB = 0x%lx\n",
 				  dm_pstable->rssi_val_min);
 		} else {
 			dm_pstable->rssi_val_min =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, DBG_LOUD, DBG_LOUD,
 				 "STA Default Port PWDB = 0x%lx\n",
 				  dm_pstable->rssi_val_min);
 		}
@@ -738,7 +738,7 @@ static void rtl8723e_dm_dynamic_bb_powersaving(struct ieee80211_hw *hw)
 		dm_pstable->rssi_val_min =
 		    rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, DBG_LOUD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, DBG_LOUD, DBG_LOUD,
 			 "AP Ext Port PWDB = 0x%lx\n",
 			  dm_pstable->rssi_val_min);
 	}
@@ -820,21 +820,21 @@ void rtl8723e_dm_bt_coexist(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 tmp_byte = 0;
 	if (!rtlpriv->btcoexist.bt_coexistence) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[DM]{BT], BT not exist!!\n");
 		return;
 	}
 
 	if (!rtlpriv->btcoexist.init_set) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 			 "[DM][BT], rtl8723e_dm_bt_coexist()\n");
 		rtl8723e_dm_init_bt_coexist(hw);
 	}
 
 	tmp_byte = rtl_read_byte(rtlpriv, 0x40);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
 		 "[DM][BT], 0x40 is 0x%x\n", tmp_byte);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[DM][BT], bt_dm_coexist start\n");
 	rtl8723e_dm_bt_coexist_8723(hw);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c
index 33481232fad0..8790e9aca6d4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.c
@@ -43,12 +43,12 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
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
 
@@ -56,7 +56,7 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
 						       flag);
 				h2c_waitcounter++;
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Wait 100 us (%d times)...\n",
 					  h2c_waitcounter);
 				udelay(100);
@@ -110,7 +110,7 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 
 			wait_h2c_limmit--;
 			if (wait_h2c_limmit == 0) {
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Waiting too long for FW read clear HMEBox(%d)!\n",
 					 boxnum);
 				break;
@@ -121,13 +121,13 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 			isfw_read = _rtl8723e_check_fw_read_last_h2c(hw,
 								boxnum);
 			u1b_tmp = rtl_read_byte(rtlpriv, 0x1BF);
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Waiting for FW read clear HMEBox(%d)!!! 0x1BF = %2x\n",
 				 boxnum, u1b_tmp);
 		}
 
 		if (!isfw_read) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Write H2C register BOX[%d] fail!!!!! Fw do not read.\n",
 				 boxnum);
 			break;
@@ -136,7 +136,7 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 		memset(boxcontent, 0, sizeof(boxcontent));
 		memset(boxextcontent, 0, sizeof(boxextcontent));
 		boxcontent[0] = element_id;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "Write element_id box_reg(%4x) = %2x\n",
 			  box_reg, element_id);
 
@@ -217,7 +217,7 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
 
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "pHalData->last_hmeboxnum  = %d\n",
 			  rtlhal->last_hmeboxnum);
 	}
@@ -226,7 +226,7 @@ static void _rtl8723e_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 	rtlhal->h2c_setinprogress = false;
 	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
 }
 
 void rtl8723e_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -252,7 +252,7 @@ void rtl8723e_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	u8 u1_h2c_set_pwrmode[3] = { 0 };
 	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
 
 	SET_H2CCMD_PWRMODE_PARM_MODE(u1_h2c_set_pwrmode, mode);
 	SET_H2CCMD_PWRMODE_PARM_SMART_PS(u1_h2c_set_pwrmode,
@@ -458,7 +458,7 @@ void rtl8723e_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 			      "H2C_RSVDPAGE:\n",
@@ -466,7 +466,7 @@ void rtl8723e_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		rtl8723e_fill_h2c_cmd(hw, H2C_RSVDPAGE,
 				      sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
 }
 
@@ -501,11 +501,11 @@ void rtl8723e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
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
@@ -564,11 +564,11 @@ void rtl8723e_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c
index 3ac31ec26517..24abb7a6a8d2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_bt_coexist.c
@@ -102,11 +102,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					BT_COEX_STATE_WIFI_RSSI_1_HIGH;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state switch to High\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state stay at Low\n");
 			}
 		} else {
@@ -116,17 +116,17 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					BT_COEX_STATE_WIFI_RSSI_1_LOW;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "[DM][BT], RSSI_1 thresh error!!\n");
 			return rtlpriv->btcoexist.bt_pre_rssi_state;
 		}
@@ -144,11 +144,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state stay at Low\n");
 			}
 		} else if ((rtlpriv->btcoexist.bt_pre_rssi_state ==
@@ -164,7 +164,7 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state switch to High\n");
 			} else if (undecoratedsmoothed_pwdb < rssi_thresh) {
 				bt_rssi_state = BT_RSSI_STATE_LOW;
@@ -174,11 +174,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state stay at Medium\n");
 			}
 		} else {
@@ -190,11 +190,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state1(struct ieee80211_hw *hw,
 					~BT_COEX_STATE_WIFI_RSSI_1_HIGH;
 				rtlpriv->btcoexist.cstate &=
 					~BT_COEX_STATE_WIFI_RSSI_1_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI_1 state stay at High\n");
 			}
 		}
@@ -230,11 +230,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					|= BT_COEX_STATE_WIFI_RSSI_HIGH;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state switch to High\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state stay at Low\n");
 			}
 		} else {
@@ -244,17 +244,17 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					|= BT_COEX_STATE_WIFI_RSSI_LOW;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state stay at High\n");
 			}
 		}
 	} else if (level_num == 3) {
 		if (rssi_thresh > rssi_thresh1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "[DM][BT], RSSI thresh error!!\n");
 			return rtlpriv->btcoexist.bt_pre_rssi_state;
 		}
@@ -271,11 +271,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state stay at Low\n");
 			}
 		} else if ((rtlpriv->btcoexist.bt_pre_rssi_state ==
@@ -291,7 +291,7 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state switch to High\n");
 			} else if (undecoratedsmoothed_pwdb < rssi_thresh) {
 				bt_rssi_state = BT_RSSI_STATE_LOW;
@@ -301,11 +301,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state switch to Low\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_MEDIUM;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state stay at Medium\n");
 			}
 		} else {
@@ -317,11 +317,11 @@ u8 rtl8723e_dm_bt_check_coex_rssi_state(struct ieee80211_hw *hw,
 					&= ~BT_COEX_STATE_WIFI_RSSI_HIGH;
 				rtlpriv->btcoexist.cstate
 					&= ~BT_COEX_STATE_WIFI_RSSI_LOW;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state switch to Medium\n");
 			} else {
 				bt_rssi_state = BT_RSSI_STATE_STAY_HIGH;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 					 "[DM][BT], RSSI state stay at High\n");
 			}
 		}
@@ -342,7 +342,7 @@ long rtl8723e_dm_bt_get_rx_ss(struct ieee80211_hw *hw)
 		undecoratedsmoothed_pwdb
 			= rtlpriv->dm.entry_min_undec_sm_pwdb;
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_get_rx_ss() = %ld\n",
 		 undecoratedsmoothed_pwdb);
 
@@ -367,7 +367,7 @@ void rtl8723e_dm_bt_balance(struct ieee80211_hw *hw,
 	}
 	rtlpriv->btcoexist.balance_on = balance_on;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "[DM][BT], Balance=[%s:%dms:%dms], write 0xc=0x%x\n",
 		 balance_on ? "ON" : "OFF", ms0, ms1, h2c_parameter[0]<<16 |
 		 h2c_parameter[1]<<8 | h2c_parameter[2]);
@@ -381,7 +381,7 @@ void rtl8723e_dm_bt_agc_table(struct ieee80211_hw *hw, u8 type)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (type == BT_AGCTABLE_OFF) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BT]AGCTable Off!\n");
 		rtl_write_dword(rtlpriv, 0xc78, 0x641c0001);
 		rtl_write_dword(rtlpriv, 0xc78, 0x631d0001);
@@ -400,7 +400,7 @@ void rtl8723e_dm_bt_agc_table(struct ieee80211_hw *hw, u8 type)
 		rtl8723e_phy_set_rf_reg(hw, RF90_PATH_A,
 					RF_RX_G1, 0xfffff, 0x30355);
 	} else if (type == BT_AGCTABLE_ON) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BT]AGCTable On!\n");
 		rtl_write_dword(rtlpriv, 0xc78, 0x4e1c0001);
 		rtl_write_dword(rtlpriv, 0xc78, 0x4d1d0001);
@@ -428,11 +428,11 @@ void rtl8723e_dm_bt_bb_back_off_level(struct ieee80211_hw *hw, u8 type)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (type == BT_BB_BACKOFF_OFF) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BT]BBBackOffLevel Off!\n");
 		rtl_write_dword(rtlpriv, 0xc04, 0x3a05611);
 	} else if (type == BT_BB_BACKOFF_ON) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BT]BBBackOffLevel On!\n");
 		rtl_write_dword(rtlpriv, 0xc04, 0x3a07611);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
@@ -442,13 +442,13 @@ void rtl8723e_dm_bt_bb_back_off_level(struct ieee80211_hw *hw, u8 type)
 void rtl8723e_dm_bt_fw_coex_all_off(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_fw_coex_all_off()\n");
 
 	if (rtlpriv->btcoexist.fw_coexist_all_off)
 		return;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_fw_coex_all_off(), real Do\n");
 	rtl8723e_dm_bt_fw_coex_all_off_8723a(hw);
 	rtlpriv->btcoexist.fw_coexist_all_off = true;
@@ -458,13 +458,13 @@ void rtl8723e_dm_bt_sw_coex_all_off(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_sw_coex_all_off()\n");
 
 	if (rtlpriv->btcoexist.sw_coexist_all_off)
 		return;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_sw_coex_all_off(), real Do\n");
 	rtl8723e_dm_bt_sw_coex_all_off_8723a(hw);
 	rtlpriv->btcoexist.sw_coexist_all_off = true;
@@ -474,12 +474,12 @@ void rtl8723e_dm_bt_hw_coex_all_off(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_hw_coex_all_off()\n");
 
 	if (rtlpriv->btcoexist.hw_coexist_all_off)
 		return;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "rtl8723e_dm_bt_hw_coex_all_off(), real Do\n");
 
 	rtl8723e_dm_bt_hw_coex_all_off_8723a(hw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
index 652d8ff9cccb..8947ebebd987 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hal_btc.c
@@ -20,7 +20,7 @@ void rtl8723e_dm_bt_turn_off_bt_coexist_before_enter_lps(struct ieee80211_hw *hw
 		return;
 
 	if (ppsc->inactiveps) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BT][DM], Before enter IPS, turn off all Coexist DM\n");
 		rtlpriv->btcoexist.cstate = 0;
 		rtlpriv->btcoexist.previous_state = 0;
@@ -68,7 +68,7 @@ void rtl_8723e_bt_wifi_media_status_notify(struct ieee80211_hw *hw,
 	else
 		h2c_parameter[2] = 0x20;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[BTCoex], FW write 0x19=0x%x\n",
 		 h2c_parameter[0]<<16|h2c_parameter[1]<<8|h2c_parameter[2]);
 
@@ -98,7 +98,7 @@ static void rtl8723e_dm_bt_set_fw_3a(struct ieee80211_hw *hw,
 	h2c_parameter[2] = byte3;
 	h2c_parameter[3] = byte4;
 	h2c_parameter[4] = byte5;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], FW write 0x3a(4bytes)=0x%x%8x\n",
 		h2c_parameter[0], h2c_parameter[1]<<24 |
 		h2c_parameter[2]<<16 | h2c_parameter[3]<<8 |
@@ -111,7 +111,7 @@ static bool rtl8723e_dm_bt_need_to_dec_bt_pwr(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (mgnt_link_status_query(hw) == RT_MEDIA_CONNECT) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"Need to decrease bt power\n");
 		rtlpriv->btcoexist.cstate |=
 		BT_COEX_STATE_DEC_BT_POWER;
@@ -130,11 +130,11 @@ static bool rtl8723e_dm_bt_is_same_coexist_state(struct ieee80211_hw *hw)
 	     rtlpriv->btcoexist.cstate) &&
 	    (rtlpriv->btcoexist.previous_state_h ==
 	     rtlpriv->btcoexist.cstate_h)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[DM][BT], Coexist state do not change!!\n");
 		return true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[DM][BT], Coexist state changed!!\n");
 		return false;
 	}
@@ -146,15 +146,15 @@ static void rtl8723e_dm_bt_set_coex_table(struct ieee80211_hw *hw,
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "set coex table, set 0x6c0=0x%x\n", val_0x6c0);
 	rtl_write_dword(rtlpriv, 0x6c0, val_0x6c0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "set coex table, set 0x6c8=0x%x\n", val_0x6c8);
 	rtl_write_dword(rtlpriv, 0x6c8, val_0x6c8);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "set coex table, set 0x6cc=0x%x\n", val_0x6cc);
 	rtl_write_byte(rtlpriv, 0x6cc, val_0x6cc);
 }
@@ -164,12 +164,12 @@ static void rtl8723e_dm_bt_set_hw_pta_mode(struct ieee80211_hw *hw, bool b_mode)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (BT_PTA_MODE_ON == b_mode) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode on\n");
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode on\n");
 		/*  Enable GPIO 0/1/2/3/8 pins for bt */
 		rtl_write_byte(rtlpriv, 0x40, 0x20);
 		rtlpriv->btcoexist.hw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode off\n");
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE, "PTA mode off\n");
 		rtl_write_byte(rtlpriv, 0x40, 0x0);
 	}
 }
@@ -181,14 +181,14 @@ static void rtl8723e_dm_bt_set_sw_rf_rx_lpf_corner(struct ieee80211_hw *hw,
 
 	if (BT_RF_RX_LPF_CORNER_SHRINK == type) {
 		/* Shrink RF Rx LPF corner, 0x1e[7:4]=1111 ==> [11:4] */
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "Shrink RF Rx LPF corner!!\n");
 		rtl8723e_phy_set_rf_reg(hw, RF90_PATH_A, 0x1e,
 					0xfffff, 0xf0ff7);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	} else if (BT_RF_RX_LPF_CORNER_RESUME == type) {
 		/*Resume RF Rx LPF corner*/
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "Resume RF Rx LPF corner!!\n");
 		rtl8723e_phy_set_rf_reg(hw, RF90_PATH_A, 0x1e, 0xfffff,
 					rtlpriv->btcoexist.bt_rfreg_origin_1e);
@@ -204,12 +204,12 @@ static void dm_bt_set_sw_penalty_tx_rate_adapt(struct ieee80211_hw *hw,
 	tmp_u1 = rtl_read_byte(rtlpriv, 0x4fd);
 	tmp_u1 |= BIT(0);
 	if (BT_TX_RATE_ADAPTIVE_LOW_PENALTY == ra_type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"Tx rate adaptive, set low penalty!!\n");
 		tmp_u1 &= ~BIT(2);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	} else if (BT_TX_RATE_ADAPTIVE_NORMAL == ra_type) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"Tx rate adaptive, set normal!!\n");
 		tmp_u1 |= BIT(2);
 	}
@@ -279,13 +279,13 @@ static bool rtl8723e_dm_bt_is_2_ant_common_action(struct ieee80211_hw *hw)
 
 	if (!rtl8723e_dm_bt_is_wifi_busy(hw) &&
 	    !rtlpriv->btcoexist.bt_busy) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "Wifi idle + Bt idle, bt coex mechanism always off!!\n");
 		rtl8723e_dm_bt_btdm_structure_reload_all_off(hw, &btdm8723);
 		b_common = true;
 	} else if (rtl8723e_dm_bt_is_wifi_busy(hw) &&
 		   !rtlpriv->btcoexist.bt_busy) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "Wifi non-idle + Bt disabled/idle!!\n");
 		btdm8723.low_penalty_rate_adaptive = true;
 		btdm8723.rf_rx_lpf_shrink = false;
@@ -307,14 +307,14 @@ static bool rtl8723e_dm_bt_is_2_ant_common_action(struct ieee80211_hw *hw)
 
 		b_common = true;
 	} else if (rtlpriv->btcoexist.bt_busy) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"Bt non-idle!\n");
 		if (mgnt_link_status_query(hw) == RT_MEDIA_CONNECT) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"Wifi connection exist\n");
 			b_common = false;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"No Wifi connection!\n");
 			btdm8723.rf_rx_lpf_shrink = true;
 			btdm8723.low_penalty_rate_adaptive = false;
@@ -359,13 +359,13 @@ static void rtl8723e_dm_bt_set_sw_full_time_dac_swing(
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (sw_dac_swing_on) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], SwDacSwing = 0x%x\n", sw_dac_swing_lvl);
 		rtl8723_phy_set_bb_reg(hw, 0x880, 0xff000000,
 				       sw_dac_swing_lvl);
 		rtlpriv->btcoexist.sw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], SwDacSwing Off!\n");
 		rtl8723_phy_set_bb_reg(hw, 0x880, 0xff000000, 0xc0);
 	}
@@ -384,7 +384,7 @@ static void rtl8723e_dm_bt_set_fw_dec_bt_pwr(
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "[BTCoex], decrease Bt Power : %s, write 0x21=0x%x\n",
 		 (dec_bt_pwr ? "Yes!!" : "No!!"), h2c_parameter[0]);
 
@@ -404,7 +404,7 @@ static void rtl8723e_dm_bt_set_fw_2_ant_hid(struct ieee80211_hw *hw,
 	if (b_dac_swing_on)
 		h2c_parameter[0] |= BIT(1); /* Dac Swing default enable */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "[BTCoex], turn 2-Ant+HID mode %s, DACSwing:%s, write 0x15=0x%x\n",
 		 (b_enable ? "ON!!" : "OFF!!"), (b_dac_swing_on ? "ON" : "OFF"),
 		 h2c_parameter[0]);
@@ -424,56 +424,56 @@ static void rtl8723e_dm_bt_set_fw_tdma_ctrl(struct ieee80211_hw *hw,
 	h2c_parameter1[0] = 0;
 
 	if (b_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], set BT PTA update manager to trigger update!!\n");
 		h2c_parameter1[0] |= BIT(0);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], turn TDMA mode ON!!\n");
 		h2c_parameter[0] |= BIT(0);		/* function enable */
 		if (TDMA_1ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TDMA_1ANT\n");
 			h2c_parameter[0] |= BIT(1);
 		} else if (TDMA_2ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TDMA_2ANT\n");
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], Unknown Ant\n");
 		}
 
 		if (TDMA_NAV_OFF == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TDMA_NAV_OFF\n");
 		} else if (TDMA_NAV_ON == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TDMA_NAV_ON\n");
 			h2c_parameter[0] |= BIT(2);
 		}
 
 		if (TDMA_DAC_SWING_OFF == dac_swing_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex], TDMA_DAC_SWING_OFF\n");
 		} else if (TDMA_DAC_SWING_ON == dac_swing_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex], TDMA_DAC_SWING_ON\n");
 			h2c_parameter[0] |= BIT(4);
 		}
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], set BT PTA update manager to no update!!\n");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], turn TDMA mode OFF!!\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "[BTCoex], FW2AntTDMA, write 0x26=0x%x\n",
 		 h2c_parameter1[0]);
 	rtl8723e_fill_h2c_cmd(hw, 0x26, 1, h2c_parameter1);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], FW2AntTDMA, write 0x14=0x%x\n",
 		h2c_parameter[0]);
 	rtl8723e_fill_h2c_cmd(hw, 0x14, 1, h2c_parameter);
@@ -486,16 +486,16 @@ static void rtl8723e_dm_bt_set_fw_ignore_wlan_act(struct ieee80211_hw *hw,
 	u8 h2c_parameter[1] = {0};
 
 	if (b_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], BT Ignore Wlan_Act !!\n");
 		h2c_parameter[0] |= BIT(0);		/* function enable */
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], BT don't ignore Wlan_Act !!\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "[BTCoex], set FW for BT Ignore Wlan_Act, write 0x25=0x%x\n",
 		 h2c_parameter[0]);
 
@@ -513,43 +513,43 @@ static void rtl8723e_dm_bt_set_fw_tra_tdma_ctrl(struct ieee80211_hw *hw,
 
 	/* Only 8723 B cut should do this */
 	if (IS_VENDOR_8723_A_CUT(rtlhal->version)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], not 8723B cut, don't set Traditional TDMA!!\n");
 		return;
 	}
 
 	if (b_enable) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "[BTCoex], turn TTDMA mode ON!!\n");
 		h2c_parameter[0] |= BIT(0);	/* function enable */
 		if (TDMA_1ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "[BTCoex], TTDMA_1ANT\n");
 			h2c_parameter[0] |= BIT(1);
 		} else if (TDMA_2ANT == ant_num) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TTDMA_2ANT\n");
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], Unknown Ant\n");
 		}
 
 		if (TDMA_NAV_OFF == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TTDMA_NAV_OFF\n");
 		} else if (TDMA_NAV_ON == nav_en) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], TTDMA_NAV_ON\n");
 			h2c_parameter[1] |= BIT(0);
 		}
 
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], turn TTDMA mode OFF!!\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], FW Traditional TDMA, write 0x33=0x%x\n",
 		h2c_parameter[0] << 8 | h2c_parameter[1]);
 
@@ -563,9 +563,9 @@ static void rtl8723e_dm_bt_set_fw_dac_swing_level(struct ieee80211_hw *hw,
 	u8 h2c_parameter[1] = {0};
 	h2c_parameter[0] = dac_swing_lvl;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set Dac Swing Level=0x%x\n", dac_swing_lvl);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x29=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x29, 1, h2c_parameter);
@@ -582,9 +582,9 @@ static void rtl8723e_dm_bt_set_fw_bt_hid_info(struct ieee80211_hw *hw,
 		h2c_parameter[0] |= BIT(0);
 		rtlpriv->btcoexist.fw_coexist_all_off = false;
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set BT HID information=0x%x\n", b_enable);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x24=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x24, 1, h2c_parameter);
@@ -597,9 +597,9 @@ static void rtl8723e_dm_bt_set_fw_bt_retry_index(struct ieee80211_hw *hw,
 	u8 h2c_parameter[1] = {0};
 	h2c_parameter[0] = retry_index;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set BT Retry Index=%d\n", retry_index);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x23=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x23, 1, h2c_parameter);
@@ -614,12 +614,12 @@ static void rtl8723e_dm_bt_set_fw_wlan_act(struct ieee80211_hw *hw,
 	h2c_parameter_hi[0] = wlan_act_hi;
 	h2c_parameter_lo[0] = wlan_act_lo;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], Set WLAN_ACT Hi:Lo=0x%x/0x%x\n",
 		wlan_act_hi, wlan_act_lo);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x22=0x%x\n", h2c_parameter_hi[0]);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"[BTCoex], write 0x11=0x%x\n", h2c_parameter_lo[0]);
 
 	/* WLAN_ACT = High duration, unit:ms */
@@ -646,105 +646,105 @@ void rtl8723e_dm_bt_set_bt_dm(struct ieee80211_hw *hw,
 	/* check new setting is different with the old one, */
 	/* if all the same, don't do the setting again. */
 	if (memcmp(btdm_8723, btdm, sizeof(struct btdm_8723)) == 0) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], the same coexist setting, return!!\n");
 		return;
 	} else {	/* save the new coexist setting */
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], UPDATE TO NEW COEX SETTING!!\n");
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new bAllOff=0x%x/ 0x%x\n",
 			btdm_8723->all_off, btdm->all_off);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new agc_table_en=0x%x/ 0x%x\n",
 			btdm_8723->agc_table_en, btdm->agc_table_en);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new adc_back_off_on=0x%x/ 0x%x\n",
 			 btdm_8723->adc_back_off_on,
 			 btdm->adc_back_off_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new b2_ant_hid_en=0x%x/ 0x%x\n",
 			 btdm_8723->b2_ant_hid_en, btdm->b2_ant_hid_en);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new bLowPenaltyRateAdaptive=0x%x/ 0x%x\n",
 			 btdm_8723->low_penalty_rate_adaptive,
 			 btdm->low_penalty_rate_adaptive);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new bRfRxLpfShrink=0x%x/ 0x%x\n",
 			 btdm_8723->rf_rx_lpf_shrink,
 			 btdm->rf_rx_lpf_shrink);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new bRejectAggrePkt=0x%x/ 0x%x\n",
 			 btdm_8723->reject_aggre_pkt,
 			 btdm->reject_aggre_pkt);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new tdma_on=0x%x/ 0x%x\n",
 			 btdm_8723->tdma_on, btdm->tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new tdmaAnt=0x%x/ 0x%x\n",
 			 btdm_8723->tdma_ant, btdm->tdma_ant);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new tdmaNav=0x%x/ 0x%x\n",
 			 btdm_8723->tdma_nav, btdm->tdma_nav);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new tdma_dac_swing=0x%x/ 0x%x\n",
 			 btdm_8723->tdma_dac_swing, btdm->tdma_dac_swing);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new fw_dac_swing_lvl=0x%x/ 0x%x\n",
 			 btdm_8723->fw_dac_swing_lvl,
 			 btdm->fw_dac_swing_lvl);
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new bTraTdmaOn=0x%x/ 0x%x\n",
 			 btdm_8723->tra_tdma_on, btdm->tra_tdma_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new traTdmaAnt=0x%x/ 0x%x\n",
 			 btdm_8723->tra_tdma_ant, btdm->tra_tdma_ant);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new traTdmaNav=0x%x/ 0x%x\n",
 			 btdm_8723->tra_tdma_nav, btdm->tra_tdma_nav);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new bPsTdmaOn=0x%x/ 0x%x\n",
 			 btdm_8723->ps_tdma_on, btdm->ps_tdma_on);
 		for (i = 0; i < 5; i++) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "[BTCoex], original/new psTdmaByte[i]=0x%x/ 0x%x\n",
 				 btdm_8723->ps_tdma_byte[i],
 				 btdm->ps_tdma_byte[i]);
 		}
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new bIgnoreWlanAct=0x%x/ 0x%x\n",
 			btdm_8723->ignore_wlan_act,
 			btdm->ignore_wlan_act);
 
 
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new bPtaOn=0x%x/ 0x%x\n",
 			btdm_8723->pta_on, btdm->pta_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new val_0x6c0=0x%x/ 0x%x\n",
 			btdm_8723->val_0x6c0, btdm->val_0x6c0);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new val_0x6c8=0x%x/ 0x%x\n",
 			btdm_8723->val_0x6c8, btdm->val_0x6c8);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], original/new val_0x6cc=0x%x/ 0x%x\n",
 			btdm_8723->val_0x6cc, btdm->val_0x6cc);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new sw_dac_swing_on=0x%x/ 0x%x\n",
 			 btdm_8723->sw_dac_swing_on,
 			 btdm->sw_dac_swing_on);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new sw_dac_swing_lvl=0x%x/ 0x%x\n",
 			 btdm_8723->sw_dac_swing_lvl,
 			 btdm->sw_dac_swing_lvl);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new wlanActHi=0x%x/ 0x%x\n",
 			 btdm_8723->wlan_act_hi, btdm->wlan_act_hi);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new wlanActLo=0x%x/ 0x%x\n",
 			 btdm_8723->wlan_act_lo, btdm->wlan_act_lo);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], original/new btRetryIndex=0x%x/ 0x%x\n",
 			 btdm_8723->bt_retry_index, btdm->bt_retry_index);
 
@@ -756,14 +756,14 @@ void rtl8723e_dm_bt_set_bt_dm(struct ieee80211_hw *hw,
 	 */
 
 	if (rtlpriv->btcoexist.hold_for_bt_operation) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], set to ignore wlanAct for BT OP!!\n");
 		rtl8723e_dm_bt_set_fw_ignore_wlan_act(hw, true);
 		return;
 	}
 
 	if (btdm->all_off) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], disable all coexist mechanism !!\n");
 		rtl8723e_btdm_coex_all_off(hw);
 		return;
@@ -929,7 +929,7 @@ static u8 rtl8723e_dm_bt_bt_tx_rx_counter_level(struct ieee80211_hw *hw)
 
 	bt_tx_rx_cnt = rtl8723e_dm_bt_tx_rx_couter_h(hw)
 				+ rtl8723e_dm_bt_tx_rx_couter_l(hw);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt);
 
 	rtlpriv->btcoexist.cstate_h &= ~
@@ -937,25 +937,25 @@ static u8 rtl8723e_dm_bt_bt_tx_rx_counter_level(struct ieee80211_hw *hw)
 		  BT_COEX_STATE_BT_CNT_LEVEL_2);
 
 	if (bt_tx_rx_cnt >= BT_TXRX_CNT_THRES_3) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], BT TxRx Counters at level 3\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_3;
 		rtlpriv->btcoexist.cstate_h |=
 			BT_COEX_STATE_BT_CNT_LEVEL_3;
 	} else if (bt_tx_rx_cnt >= BT_TXRX_CNT_THRES_2) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], BT TxRx Counters at level 2\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_2;
 		rtlpriv->btcoexist.cstate_h |=
 			BT_COEX_STATE_BT_CNT_LEVEL_2;
 	} else if (bt_tx_rx_cnt >= BT_TXRX_CNT_THRES_1) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], BT TxRx Counters at level 1\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_1;
 		rtlpriv->btcoexist.cstate_h  |=
 			BT_COEX_STATE_BT_CNT_LEVEL_1;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], BT TxRx Counters at level 0\n");
 		bt_tx_rx_cnt_lvl = BT_TXRX_CNT_LEVEL_0;
 		rtlpriv->btcoexist.cstate_h |=
@@ -979,11 +979,11 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 	btdm8723.reject_aggre_pkt = false;
 
 	bt_tx_rx_cnt_lvl = rtl8723e_dm_bt_bt_tx_rx_counter_level(hw);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt_lvl);
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
 		/* coex table */
 		btdm8723.val_0x6c0 = 0x55555555;
 		btdm8723.val_0x6c8 = 0xffff;
@@ -997,7 +997,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 		/* fw mechanism */
 		btdm8723.ps_tdma_on = true;
 		if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "[BTCoex], BT TxRx Counters >= 1400\n");
 			btdm8723.ps_tdma_byte[0] = 0xa3;
 			btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1005,7 +1005,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 			btdm8723.ps_tdma_byte[3] = 0x2;
 			btdm8723.ps_tdma_byte[4] = 0x80;
 		} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 			btdm8723.ps_tdma_byte[0] = 0xa3;
 			btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1013,7 +1013,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 			btdm8723.ps_tdma_byte[3] = 0x2;
 			btdm8723.ps_tdma_byte[4] = 0x80;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "[BTCoex], BT TxRx Counters < 1200\n");
 			btdm8723.ps_tdma_byte[0] = 0xa3;
 			btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1022,7 +1022,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 			btdm8723.ps_tdma_byte[4] = 0x80;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "HT20 or Legacy\n");
 		bt_rssi_state =
 		  rtl8723e_dm_bt_check_coex_rssi_state(hw, 2, 47, 0);
@@ -1037,13 +1037,13 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 		/* sw mechanism */
 		if ((bt_rssi_state == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					"Wifi rssi high\n");
 			btdm8723.agc_table_en = true;
 			btdm8723.adc_back_off_on = true;
 			btdm8723.sw_dac_swing_on = false;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					"Wifi rssi low\n");
 			btdm8723.agc_table_en = false;
 			btdm8723.adc_back_off_on = false;
@@ -1054,13 +1054,13 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 		btdm8723.ps_tdma_on = true;
 		if ((bt_rssi_state1 == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state1 == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "Wifi rssi-1 high\n");
 			/* only rssi high we need to do this, */
 			/* when rssi low, the value will modified by fw */
 			rtl_write_byte(rtlpriv, 0x883, 0x40);
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1068,7 +1068,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x83;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters>= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1076,7 +1076,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x83;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1085,10 +1085,10 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					"Wifi rssi-1 low\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1096,7 +1096,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x2;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1104,7 +1104,7 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x2;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1120,12 +1120,12 @@ static void rtl8723e_dm_bt_2_ant_hid_sco_esco(struct ieee80211_hw *hw)
 
 	/* Always ignore WlanAct if bHid|bSCOBusy|bSCOeSCO */
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
 		 hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
 	if ((hal_coex_8723.bt_inq_page_start_time) ||
 	    (BT_TXRX_CNT_LEVEL_3 == bt_tx_rx_cnt_lvl)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], Set BT inquiry / page scan 0x3a setting\n");
 		btdm8723.ps_tdma_on = true;
 		btdm8723.ps_tdma_byte[0] = 0xa3;
@@ -1157,11 +1157,11 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 
 	bt_tx_rx_cnt_lvl = rtl8723e_dm_bt_bt_tx_rx_counter_level(hw);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 	"[BTCoex], BT TxRx Counters = %d\n", bt_tx_rx_cnt_lvl);
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG, "HT40\n");
 		bt_rssi_state =
 		  rtl8723e_dm_bt_check_coex_rssi_state(hw, 2, 37, 0);
 
@@ -1179,10 +1179,10 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		btdm8723.ps_tdma_on = true;
 		if ((bt_rssi_state == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 						"Wifi rssi high\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1190,7 +1190,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1198,7 +1198,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1207,10 +1207,10 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "Wifi rssi low\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1219,7 +1219,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl ==
 				BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1227,7 +1227,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x0;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1237,7 +1237,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 			}
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "HT20 or Legacy\n");
 		bt_rssi_state =
 		  rtl8723e_dm_bt_check_coex_rssi_state(hw, 2, 47, 0);
@@ -1252,13 +1252,13 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		/* sw mechanism */
 		if ((bt_rssi_state == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "Wifi rssi high\n");
 			btdm8723.agc_table_en = true;
 			btdm8723.adc_back_off_on = true;
 			btdm8723.sw_dac_swing_on = false;
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "Wifi rssi low\n");
 			btdm8723.agc_table_en = false;
 			btdm8723.adc_back_off_on = false;
@@ -1269,13 +1269,13 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 		btdm8723.ps_tdma_on = true;
 		if ((bt_rssi_state1 == BT_RSSI_STATE_HIGH) ||
 			(bt_rssi_state1 == BT_RSSI_STATE_STAY_HIGH)) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "Wifi rssi-1 high\n");
 			/* only rssi high we need to do this, */
 			/* when rssi low, the value will modified by fw */
 			rtl_write_byte(rtlpriv, 0x883, 0x40);
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1283,7 +1283,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1291,7 +1291,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x81;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1300,10 +1300,10 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			}
 		} else {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "Wifi rssi-1 low\n");
 			if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_2) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0x5;
@@ -1311,7 +1311,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x0;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else if (bt_tx_rx_cnt_lvl == BT_TXRX_CNT_LEVEL_1) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters >= 1200 && < 1400\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xa;
@@ -1319,7 +1319,7 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 				btdm8723.ps_tdma_byte[3] = 0x0;
 				btdm8723.ps_tdma_byte[4] = 0x80;
 			} else {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BT TxRx Counters < 1200\n");
 				btdm8723.ps_tdma_byte[0] = 0xa3;
 				btdm8723.ps_tdma_byte[1] = 0xf;
@@ -1333,13 +1333,13 @@ static void rtl8723e_dm_bt_2_ant_ftp_a2dp(struct ieee80211_hw *hw)
 	if (rtl8723e_dm_bt_need_to_dec_bt_pwr(hw))
 		btdm8723.dec_bt_pwr = true;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[BTCoex], BT btInqPageStartTime = 0x%x, btTxRxCntLvl = %d\n",
 		 hal_coex_8723.bt_inq_page_start_time, bt_tx_rx_cnt_lvl);
 
 	if ((hal_coex_8723.bt_inq_page_start_time) ||
 	    (BT_TXRX_CNT_LEVEL_3 == bt_tx_rx_cnt_lvl)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], Set BT inquiry / page scan 0x3a setting\n");
 		btdm8723.ps_tdma_on = true;
 		btdm8723.ps_tdma_byte[0] = 0xa3;
@@ -1366,12 +1366,12 @@ static void rtl8723e_dm_bt_inq_page_monitor(struct ieee80211_hw *hw)
 			rtlpriv->btcoexist.cstate  |=
 			BT_COEX_STATE_BT_INQ_PAGE;
 			hal_coex_8723.bt_inq_page_start_time = cur_time;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				 "[BTCoex], BT Inquiry/page is started at time : 0x%x\n",
 				 hal_coex_8723.bt_inq_page_start_time);
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		 "[BTCoex], BT Inquiry/page started time : 0x%x, cur_time : 0x%x\n",
 		 hal_coex_8723.bt_inq_page_start_time, cur_time);
 
@@ -1379,7 +1379,7 @@ static void rtl8723e_dm_bt_inq_page_monitor(struct ieee80211_hw *hw)
 		if ((((long)cur_time -
 			(long)hal_coex_8723.bt_inq_page_start_time) / HZ)
 			>= 10) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 				"[BTCoex], BT Inquiry/page >= 10sec!!!\n");
 			hal_coex_8723.bt_inq_page_start_time = 0;
 			rtlpriv->btcoexist.cstate &=
@@ -1406,13 +1406,13 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 {
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 bt_info_original;
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"[BTCoex] Get bt info by fw!!\n");
 
 	_rtl8723_dm_bt_check_wifi_state(hw);
 
 	if (hal_coex_8723.c2h_bt_info_req_sent) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				"[BTCoex] c2h for bt_info not rcvd yet!!\n");
 	}
 
@@ -1426,7 +1426,7 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 	if (rtl8723e_dm_bt_is_2_ant_common_action(hw)) {
 		rtlpriv->btcoexist.bt_profile_case = BT_COEX_MECH_COMMON;
 		rtlpriv->btcoexist.bt_profile_action = BT_COEX_MECH_COMMON;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"Action 2-Ant common.\n");
 	} else {
 		if ((bt_info_original & BTINFO_B_HID) ||
@@ -1438,7 +1438,7 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 					BT_COEX_MECH_HID_SCO_ESCO;
 				rtlpriv->btcoexist.bt_profile_action =
 					BT_COEX_MECH_HID_SCO_ESCO;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BTInfo: bHid|bSCOBusy|bSCOeSCO\n");
 				rtl8723e_dm_bt_2_ant_hid_sco_esco(hw);
 		} else if ((bt_info_original & BTINFO_B_FTP) ||
@@ -1449,7 +1449,7 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 					BT_COEX_MECH_FTP_A2DP;
 				rtlpriv->btcoexist.bt_profile_action =
 					BT_COEX_MECH_FTP_A2DP;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "BTInfo: bFTP|bA2DP\n");
 				rtl8723e_dm_bt_2_ant_ftp_a2dp(hw);
 		} else {
@@ -1459,7 +1459,7 @@ static void _rtl8723e_dm_bt_coexist_2_ant(struct ieee80211_hw *hw)
 					BT_COEX_MECH_NONE;
 				rtlpriv->btcoexist.bt_profile_action =
 					BT_COEX_MECH_NONE;
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 					 "[BTCoex], BTInfo: undefined case!!!!\n");
 				rtl8723e_dm_bt_2_ant_hid_sco_esco(hw);
 		}
@@ -1513,7 +1513,7 @@ static void rtl8723e_dm_bt_query_bt_information(struct ieee80211_hw *hw)
 
 	h2c_parameter[0] |=  BIT(0);
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		"Query Bt information, write 0x38=0x%x\n", h2c_parameter[0]);
 
 	rtl8723e_fill_h2c_cmd(hw, 0x38, 1, h2c_parameter);
@@ -1548,10 +1548,10 @@ static void rtl8723e_dm_bt_bt_hw_counters_monitor(struct ieee80211_hw *hw)
 	hal_coex_8723.low_priority_tx = reg_lp_tx;
 	hal_coex_8723.low_priority_rx = reg_lp_rx;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"High Priority Tx/Rx (reg 0x%x)=%x(%d)/%x(%d)\n",
 		reg_hp_tx_rx, reg_hp_tx, reg_hp_tx, reg_hp_rx, reg_hp_rx);
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"Low Priority Tx/Rx (reg 0x%x)=%x(%d)/%x(%d)\n",
 		reg_lp_tx_rx, reg_lp_tx, reg_lp_tx, reg_lp_rx, reg_lp_rx);
 	rtlpriv->btcoexist.lps_counter = 0;
@@ -1584,22 +1584,22 @@ static void rtl8723e_dm_bt_bt_enable_disable_check(struct ieee80211_hw *hw)
 	if (bt_alife) {
 		rtlpriv->btcoexist.bt_active_zero_cnt = 0;
 		rtlpriv->btcoexist.cur_bt_disabled = false;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "8723A BT is enabled !!\n");
 	} else {
 		rtlpriv->btcoexist.bt_active_zero_cnt++;
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "8723A bt all counters=0, %d times!!\n",
 			 rtlpriv->btcoexist.bt_active_zero_cnt);
 		if (rtlpriv->btcoexist.bt_active_zero_cnt >= 2) {
 			rtlpriv->btcoexist.cur_bt_disabled = true;
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "8723A BT is disabled !!\n");
 		}
 	}
 	if (rtlpriv->btcoexist.pre_bt_disabled !=
 		rtlpriv->btcoexist.cur_bt_disabled) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST,
 			 DBG_TRACE, "8723A BT is from %s to %s!!\n",
 			 (rtlpriv->btcoexist.pre_bt_disabled ?
 				"disabled" : "enabled"),
@@ -1620,17 +1620,17 @@ void rtl8723e_dm_bt_coexist_8723(struct ieee80211_hw *hw)
 	rtl8723e_dm_bt_bt_enable_disable_check(hw);
 
 	if (rtlpriv->btcoexist.bt_ant_num == ANT_X2) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTCoex], 2 Ant mechanism\n");
 		_rtl8723e_dm_bt_coexist_2_ant(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			"[BTCoex], 1 Ant mechanism\n");
 		_rtl8723e_dm_bt_coexist_1_ant(hw);
 	}
 
 	if (!rtl8723e_dm_bt_is_same_coexist_state(hw)) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			 "[BTCoex], Coexist State[bitMap] change from 0x%x%8x to 0x%x%8x\n",
 			 rtlpriv->btcoexist.previous_state_h,
 			 rtlpriv->btcoexist.previous_state,
@@ -1658,14 +1658,14 @@ static void rtl8723e_dm_bt_parse_bt_info(struct ieee80211_hw *hw,
 		else if (i == 1)
 			hal_coex_8723.bt_retry_cnt = tmp_buf[i];
 		if (i == len-1)
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "0x%2x]", tmp_buf[i]);
 		else
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "0x%2x, ", tmp_buf[i]);
 
 	}
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 		"BT info bt_info (Data)= 0x%x\n",
 			hal_coex_8723.c2h_bt_info_original);
 	bt_info = hal_coex_8723.c2h_bt_info_original;
@@ -1677,12 +1677,12 @@ static void rtl8723e_dm_bt_parse_bt_info(struct ieee80211_hw *hw,
 
 
 	if (bt_info & BTINFO_B_CONNECTION) {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTC2H], BTInfo: bConnect=true\n");
 		rtlpriv->btcoexist.bt_busy = true;
 		rtlpriv->btcoexist.cstate &= ~BT_COEX_STATE_BT_IDLE;
 	} else {
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_DMESG,
 			"[BTC2H], BTInfo: bConnect=false\n");
 		rtlpriv->btcoexist.bt_busy = false;
 		rtlpriv->btcoexist.cstate |= BT_COEX_STATE_BT_IDLE;
@@ -1697,12 +1697,12 @@ void rtl_8723e_c2h_command_handle(struct ieee80211_hw *hw)
 	u8 u1b_tmp = 0;
 	memset(&c2h_event, 0, sizeof(c2h_event));
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_C2HEVT_MSG_NORMAL);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 		"&&&&&&: REG_C2HEVT_MSG_NORMAL is 0x%x\n", u1b_tmp);
 	c2h_event.cmd_id = u1b_tmp & 0xF;
 	c2h_event.cmd_len = (u1b_tmp & 0xF0) >> 4;
 	c2h_event.cmd_seq = rtl_read_byte(rtlpriv, REG_C2HEVT_MSG_NORMAL + 1);
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 		 "cmd_id: %d, cmd_len: %d, cmd_seq: %d\n",
 		 c2h_event.cmd_id , c2h_event.cmd_len, c2h_event.cmd_seq);
 	u1b_tmp = rtl_read_byte(rtlpriv, 0x01AF);
@@ -1714,7 +1714,7 @@ void rtl_8723e_c2h_command_handle(struct ieee80211_hw *hw)
 	}
 	ptmp_buf = kzalloc(c2h_event.cmd_len, GFP_KERNEL);
 	if (ptmp_buf == NULL) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			 "malloc cmd buf failed\n");
 		return;
 	}
@@ -1733,13 +1733,13 @@ void rtl_8723e_c2h_command_handle(struct ieee80211_hw *hw)
 			break;
 
 	case C2H_V0_BT_INFO:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			"BT info Byte[0] (ID) is 0x%x\n",
 			c2h_event.cmd_id);
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			"BT info Byte[1] (Seq) is 0x%x\n",
 			c2h_event.cmd_seq);
-		RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE,
 			"BT info Byte[2] (Data)= 0x%x\n", ptmp_buf[0]);
 
 		rtl8723e_dm_bt_parse_bt_info(hw, ptmp_buf, c2h_event.cmd_len);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
index 7a46c6a9deae..77da084baeda 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/hw.c
@@ -122,7 +122,7 @@ void rtl8723e_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HAL_DEF_WOWLAN:
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n", variable);
 		break;
 	}
@@ -187,7 +187,7 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 			u8 e_aci;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "HW_VAR_SLOT_TIME %x\n", val[0]);
 
 			rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
@@ -227,7 +227,7 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 				*val = min_spacing_to_set;
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 					 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
 					  mac->min_space_cfg);
 
@@ -242,7 +242,7 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			density_to_set = *((u8 *)val);
 			mac->min_space_cfg |= (density_to_set << 3);
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
 				  mac->min_space_cfg);
 
@@ -289,7 +289,7 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 						       p_regtoset[index]);
 				}
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 					 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
 					  factor_toset);
 			}
@@ -328,7 +328,7 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					acm_ctrl |= ACMHW_VOQEN;
 					break;
 				default:
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 						 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
 						 acm);
 					break;
@@ -345,14 +345,14 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					acm_ctrl &= (~ACMHW_VOQEN);
 					break;
 				default:
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 						 "switch case %#x not processed\n",
 						 e_aci);
 					break;
 				}
 			}
 
-			RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_QOS, DBG_TRACE,
 				 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
 				 acm_ctrl);
 			rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
@@ -526,7 +526,7 @@ void rtl8723e_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			 break;
 		}
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n", variable);
 		break;
 	}
@@ -703,7 +703,7 @@ static bool _rtl8712e_init_mac(struct ieee80211_hw *hw)
 	} while (tmpu2b != 0xc290 && retry < 100);
 
 	if (retry >= 100) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "InitMAC(): ePHY configure fail!!!\n");
 		return false;
 	}
@@ -878,13 +878,13 @@ void rtl8723e_enable_hw_security_config(struct ieee80211_hw *hw)
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
@@ -900,7 +900,7 @@ void rtl8723e_enable_hw_security_config(struct ieee80211_hw *hw)
 
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 		 "The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
@@ -942,7 +942,7 @@ int rtl8723e_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl8723_download_fw(hw, false, FW_8723A_POLLING_TIMEOUT_COUNT);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
@@ -1009,7 +1009,7 @@ int rtl8723e_hw_init(struct ieee80211_hw *hw)
 	tmp_u1b = efuse_read_1byte(hw, 0x1FA);
 	if (!(tmp_u1b & BIT(0))) {
 		rtl_set_rfreg(hw, RF90_PATH_A, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path A\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path A\n");
 	}
 
 	if (!(tmp_u1b & BIT(4))) {
@@ -1018,7 +1018,7 @@ int rtl8723e_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x80);
 		udelay(10);
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x90);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "under 1.5V\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "under 1.5V\n");
 	}
 	rtl8723e_dm_init(hw);
 exit:
@@ -1069,15 +1069,15 @@ static enum version_8723e _rtl8723e_read_chip_version(struct ieee80211_hw *hw)
 	}
 	switch (version) {
 	case VERSION_TEST_UMC_CHIP_8723:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Chip Version ID: VERSION_TEST_UMC_CHIP_8723.\n");
 			break;
 	case VERSION_NORMAL_UMC_CHIP_8723_1T1R_A_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Chip Version ID: VERSION_NORMAL_UMC_CHIP_8723_1T1R_A_CUT.\n");
 		break;
 	case VERSION_NORMAL_UMC_CHIP_8723_1T1R_B_CUT:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Chip Version ID: VERSION_NORMAL_UMC_CHIP_8723_1T1R_B_CUT.\n");
 		break;
 	default:
@@ -1088,7 +1088,7 @@ static enum version_8723e _rtl8723e_read_chip_version(struct ieee80211_hw *hw)
 	if (IS_8723_SERIES(version))
 		rtlphy->rf_type = RF_1T1R;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Chip RF Type: %s\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Chip RF Type: %s\n",
 		(rtlphy->rf_type == RF_2T2R) ? "RF_2T2R" : "RF_1T1R");
 
 	return version;
@@ -1103,30 +1103,30 @@ static int _rtl8723e_set_media_status(struct ieee80211_hw *hw,
 	u8 mode = MSR_NOLINK;
 
 	rtl_write_dword(rtlpriv, REG_BCN_CTRL, 0);
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_BEACON, DBG_LOUD,
 		"clear 0x550 when set HW_VAR_MEDIA_STATUS\n");
 
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		mode = MSR_NOLINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
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
@@ -1153,7 +1153,7 @@ static int _rtl8723e_set_media_status(struct ieee80211_hw *hw,
 		_rtl8723e_resume_tx_beacon(hw);
 		_rtl8723e_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
 			 mode);
 	}
@@ -1350,7 +1350,7 @@ void rtl8723e_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BEACON, DBG_DMESG,
 		 "beacon_interval:%d\n", bcn_interval);
 	rtl8723e_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
@@ -1363,7 +1363,7 @@ void rtl8723e_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD,
 		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
@@ -1782,7 +1782,7 @@ static void _rtl8723e_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
@@ -1806,19 +1806,19 @@ void rtl8723e_read_eeprom_info(struct ieee80211_hw *hw)
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
 		_rtl8723e_read_adapter_info(hw, false);
 	} else {
@@ -1914,7 +1914,7 @@ static void rtl8723e_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "%x\n", rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
@@ -2036,12 +2036,12 @@ static void rtl8723e_update_hal_rate_mask(struct ieee80211_hw *hw,
 	}
 	sta_entry->ratr_index = ratr_index;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "ratr_bitmap :%x\n", ratr_bitmap);
 	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
 			     (ratr_index << 28);
 	rate_mask[4] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x\n",
 		  ratr_index, ratr_bitmap,
 		  rate_mask[0], rate_mask[1],
@@ -2111,14 +2111,14 @@ bool rtl8723e_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 		e_rfpowerstate_toset = (u1tmp & BIT(1)) ? ERFON : ERFOFF;
 
 	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
 
 		e_rfpowerstate_toset = ERFON;
 		ppsc->hwradiooff = false;
 		b_actuallyset = true;
 	} else if (!ppsc->hwradiooff && (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 
 		e_rfpowerstate_toset = ERFOFF;
@@ -2170,7 +2170,7 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2198,7 +2198,7 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
 			enc_algo = CAM_AES;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 				 "switch case %#x not processed\n", enc_algo);
 			enc_algo = CAM_TKIP;
 			break;
@@ -2229,17 +2229,17 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "delete one entry, entry_id is %d\n",
 				 entry_id);
 			if (mac->opmode == NL80211_IFTYPE_AP)
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
@@ -2247,7 +2247,7 @@ void rtl8723e_set_key(struct ieee80211_hw *hw, u32 key_index,
 						      CAM_CONFIG_NO_USEDK,
 						      rtlpriv->sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 					 "set group key\n");
 
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
@@ -2288,7 +2288,7 @@ static void rtl8723e_bt_var_init(struct ieee80211_hw *hw)
 	rtlpriv->btcoexist.bt_radio_shared_type =
 		rtlpriv->btcoexist.eeprom_bt_radio_shared;
 
-	RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 		 "BT Coexistence = 0x%x\n",
 		 rtlpriv->btcoexist.bt_coexistence);
 
@@ -2301,46 +2301,46 @@ static void rtl8723e_bt_var_init(struct ieee80211_hw *hw)
 		rtlpriv->btcoexist.previous_state = 0;
 
 		if (rtlpriv->btcoexist.bt_ant_num == ANT_X2) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_Ant_Num = Antx2\n");
 		} else if (rtlpriv->btcoexist.bt_ant_num == ANT_X1) {
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_Ant_Num = Antx1\n");
 		}
 		switch (rtlpriv->btcoexist.bt_coexist_type) {
 		case BT_2WIRE:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = BT_2Wire\n");
 			break;
 		case BT_ISSC_3WIRE:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = BT_ISSC_3Wire\n");
 			break;
 		case BT_ACCEL:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = BT_ACCEL\n");
 			break;
 		case BT_CSR_BC4:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = BT_CSR_BC4\n");
 			break;
 		case BT_CSR_BC8:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = BT_CSR_BC8\n");
 			break;
 		case BT_RTL8756:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = BT_RTL8756\n");
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 				 "BlueTooth BT_CoexistType = Unknown\n");
 			break;
 		}
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "BlueTooth BT_Ant_isolation = %d\n",
 			 rtlpriv->btcoexist.bt_ant_isolation);
-		RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_BT_COEXIST, DBG_TRACE,
 			 "BT_RadioSharedType = 0x%x\n",
 			 rtlpriv->btcoexist.bt_radio_shared_type);
 		rtlpriv->btcoexist.bt_active_zero_cnt = 0;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
index 5e503dbc463b..fde39add64ac 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/led.c
@@ -19,7 +19,7 @@ void rtl8723e_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD,
 		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
@@ -48,7 +48,7 @@ void rtl8723e_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD,
 		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
@@ -128,7 +128,7 @@ void rtl8723e_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n",
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n",
 		 ledaction);
 	_rtl8723e_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
index 772aecedf0b4..b0f27c8047eb 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c
@@ -38,7 +38,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 	u32 original_value = 0, readback_value, bitshift;
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
@@ -54,7 +54,7 @@ u32 rtl8723e_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		  regaddr, rfpath, bitmask, original_value);
 
@@ -69,7 +69,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 original_value = 0, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		  regaddr, bitmask, data, rfpath);
 
@@ -99,7 +99,7 @@ void rtl8723e_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 
@@ -185,7 +185,7 @@ static bool _rtl8723e_phy_bb8192c_config_parafile(struct ieee80211_hw *hw)
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	bool rtstatus;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "\n");
 	rtstatus = _rtl8723e_phy_config_bb_with_headerfile(hw,
 						BASEBAND_CONFIG_PHY_REG);
 	if (rtstatus != true) {
@@ -195,7 +195,7 @@ static bool _rtl8723e_phy_bb8192c_config_parafile(struct ieee80211_hw *hw)
 
 	if (rtlphy->rf_type == RF_1T2R) {
 		_rtl8723e_phy_bb_config_1t(hw);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
 	}
 	if (rtlefuse->autoload_failflag == false) {
 		rtlphy->pwrgroup_cnt = 0;
@@ -226,11 +226,11 @@ static bool _rtl8723e_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl723MACPHY_Array\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl723MACPHY_Array\n");
 	arraylength = RTL8723E_MACARRAYLENGTH;
 	ptrarray = RTL8723EMAC_ARRAY;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Img:RTL8192CEMAC_2T_ARRAY\n");
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8) ptrarray[i + 1]);
@@ -267,7 +267,7 @@ static bool _rtl8723e_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 			rtl_set_bbreg(hw, phy_regarray_table[i], MASKDWORD,
 				      phy_regarray_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 				 "The phy_regarray_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
 				 phy_regarray_table[i],
 				 phy_regarray_table[i + 1]);
@@ -277,7 +277,7 @@ static bool _rtl8723e_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 			rtl_set_bbreg(hw, agctab_array_table[i], MASKDWORD,
 				      agctab_array_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 				 "The agctab_array_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
 				 agctab_array_table[i],
 				 agctab_array_table[i + 1]);
@@ -296,7 +296,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][0] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][0] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -305,7 +305,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][1] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][1] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -314,7 +314,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_CCK1_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][6] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][6] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -323,7 +323,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0xffffff00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][7] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][7] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -332,7 +332,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][2] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][2] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -341,7 +341,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][3] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][3] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -350,7 +350,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][4] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][4] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -359,7 +359,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_A_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][5] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][5] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -368,7 +368,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_RATE18_06) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][8] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][8] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -377,7 +377,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_RATE54_24) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][9] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][9] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -386,7 +386,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_CCK1_55_MCS32) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][14] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][14] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -395,7 +395,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_CCK11_A_CCK2_11 && bitmask == 0x000000ff) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][15] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][15] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -404,7 +404,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_MCS03_MCS00) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][10] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][10] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -413,7 +413,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_MCS07_MCS04) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][11] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][11] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -422,7 +422,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_MCS11_MCS08) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][12] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][12] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -431,7 +431,7 @@ static void store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 	if (regaddr == RTXAGC_B_MCS15_MCS12) {
 		rtlphy->mcs_txpwrlevel_origoffset[rtlphy->pwrgroup_cnt][13] =
 		    data;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "MCSTxPowerLevelOriginalOffset[%d][13] = 0x%x\n",
 			  rtlphy->pwrgroup_cnt,
 			  rtlphy->mcs_txpwrlevel_origoffset[rtlphy->
@@ -473,7 +473,7 @@ static bool _rtl8723e_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 						phy_regarray_table_pg[i + 2]);
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "configtype != BaseBand_Config_PHY_REG\n");
 	}
 	return true;
@@ -534,7 +534,7 @@ void rtl8723e_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->default_initialgain[3] =
 	    (u8) rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
 		 rtlphy->default_initialgain[0],
 		 rtlphy->default_initialgain[1],
@@ -546,7 +546,7 @@ void rtl8723e_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw,
 					      ROFDM0_RXDETECTOR2, MASKDWORD);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Default framesync (0x%x) = 0x%x\n",
 		  ROFDM0_RXDETECTOR3, rtlphy->framesync);
 }
@@ -650,7 +650,7 @@ bool rtl8723e_phy_update_txpower_dbm(struct ieee80211_hw *hw, long power_indbm)
 		ofdmtxpwridx -= rtlefuse->legacy_ht_txpowerdiff;
 	else
 		ofdmtxpwridx = 0;
-	RT_TRACE(rtlpriv, COMP_TXAGC, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_TXAGC, DBG_TRACE,
 		 "%lx dBm, ccktxpwridx = %d, ofdmtxpwridx = %d\n",
 		  power_indbm, ccktxpwridx, ofdmtxpwridx);
 	for (idx = 0; idx < 14; idx++) {
@@ -734,7 +734,7 @@ void rtl8723e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	u8 reg_bw_opmode;
 	u8 reg_prsr_rsc;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE,
 		 "Switch to %s bandwidth\n",
 		  rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
 		  "20MHz" : "40MHz");
@@ -791,7 +791,7 @@ void rtl8723e_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl8723e_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 void rtl8723e_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -808,7 +808,7 @@ void rtl8723e_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl8723e_phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
@@ -822,7 +822,7 @@ void rtl8723e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 delay;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE,
 		 "switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
@@ -841,7 +841,7 @@ void rtl8723e_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl8723e_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -861,11 +861,11 @@ u8 rtl8723e_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl8723e_phy_sw_chnl_callback(hw);
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CHAN, DBG_LOUD,
 			 "sw_chnl_inprogress false schedule workitem\n");
 		rtlphy->sw_chnl_inprogress = false;
 	} else {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CHAN, DBG_LOUD,
 			 "sw_chnl_inprogress false driver sleep or unload\n");
 		rtlphy->sw_chnl_inprogress = false;
 	}
@@ -991,7 +991,7 @@ static bool _rtl8723e_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
 			_rtl8723e_phy_sw_rf_seting(hw, channel);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 				 "switch case %#x not processed\n",
 				 currentcmd->cmdid);
 			break;
@@ -1444,23 +1444,23 @@ bool rtl8723e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
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
@@ -1472,7 +1472,7 @@ bool rtl8723e_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl8723e_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -1482,7 +1482,7 @@ static void rtl8723e_phy_set_io(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct dig_t *dm_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
 		  rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
@@ -1497,13 +1497,13 @@ static void rtl8723e_phy_set_io(struct ieee80211_hw *hw)
 		rtl8723e_dm_write_dig(hw);
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
 
@@ -1541,7 +1541,7 @@ static void _rtl8723e_phy_set_rf_sleep(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "Switch RF timeout !!!.\n");
 		return;
 	}
@@ -1569,14 +1569,14 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
 			do {
 				initializecount++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 					 "IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus && (initializecount < 10));
 			RT_CLEAR_PS_LEVEL(ppsc,
 					  RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "Set ERFON sleeped:%d ms\n",
 				  jiffies_to_msecs(jiffies -
 						   ppsc->
@@ -1594,7 +1594,7 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		break;
 	case ERFOFF:
 		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "IPS Set eRf nic disable\n");
 			rtl_ps_disable_nic(hw);
 			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
@@ -1619,7 +1619,7 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
 			} else {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
 					 (i + 1), queue_id,
 					 skb_queue_len(&ring->queue));
@@ -1628,7 +1628,7 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				i++;
 			}
 			if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
 					  MAX_DOZE_WAITING_TIMES_9x,
 					  queue_id,
@@ -1636,7 +1636,7 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				break;
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "Set ERFSLEEP awaked:%d ms\n",
 			  jiffies_to_msecs(jiffies -
 					   ppsc->last_awake_jiffies));
@@ -1644,7 +1644,7 @@ static bool _rtl8723e_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		_rtl8723e_phy_set_rf_sleep(hw);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "switch case %#x not processed\n", rfpwr_state);
 		bresult = false;
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c
index 9058527a7f94..3a4005a53d75 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c
@@ -480,12 +480,12 @@ static bool _rtl8723e_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 		}
 
 		if (rtstatus != true) {
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
index a04ce15d5538..f5dbc6a47436 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c
@@ -368,7 +368,7 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 	u8 bw_40 = 0;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
@@ -477,7 +477,7 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
@@ -517,7 +517,7 @@ void rtl8723e_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(pdesc, 1);
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -537,7 +537,7 @@ void rtl8723e_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le16 fc = hdr->frame_control;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
-- 
2.27.0

