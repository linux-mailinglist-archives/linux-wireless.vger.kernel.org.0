Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680A72230F6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgGQCCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgGQCCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C5C08C5E1
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:29 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id r8so6762467oij.5
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z2xzhmMINNUhsHmkAzeFxLnoUhjN773nqxaRPsswbdM=;
        b=JRzuk39aQfpl14KrWiPXcxyG0HaIrLZuxZCsTvGiavcYL2QAPxnb9/qrEQgBUZVGWj
         COjODBHXxgfZhmtaMTmxdzTj23miExLWI1YL4zbmkozKPcAZzvAPM7zq8llXM2G8aTpw
         dTZapnZWfhP7mV5qWEeGEFVIt3pZ8rmBqUzLIRKRmqsd2AcOLR/q+Q7N9hTiGt2izURN
         8JUfAS0hX0uRCz5DQcPbshIvSNuth1745jQP/PcGOgZWIquSpzRwJVsxeac6mBQtF3UP
         LPb6+nNEtHfol9xJqjkgUpdTRw2rylPxCKTwv2PWCe9vHfpHIqQnBUWonO6Bf5iBaHi3
         YugQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=z2xzhmMINNUhsHmkAzeFxLnoUhjN773nqxaRPsswbdM=;
        b=gfefqEAX7YmqsaavP/DqjB12EO1ufoVXdisOmtGtOtb+YN4Kplm5DkPyK+mQb8Gehk
         VJ9MqihPKuo8sEoBBkA5RDibzHd0kjxVZxVEjk42p/y9WZ9f+Xly3dkAbKOBJSY4KHiH
         7vkHdULJgysilriBm8slSp2xHdHkPVbDq+9RgudgQgIv2CgHE2LuUks9J0Kwy/hd4XmM
         3XbwSb0vL6C7zxGFin8IuP3RFLGxbCo9b9c5GBx+YEOS47i+k6weigt+lyfEnykNTxA4
         SmmxQRg1XGuCwHpwdGhDuH9JbrwRgzEfmWVL41Cy3aprkB/zaApq4BQfmIbwpHDwpgV4
         eRzg==
X-Gm-Message-State: AOAM532PA9TbXu4eF5mCA6LSV9+EbbcE0rYsWKiDBpzH+uZVGQRDXHkG
        gKW9uGJmGneJ08tyYKWUw7A=
X-Google-Smtp-Source: ABdhPJxR8/SRJRNuFB7CbIHOMkuYzD110UYTsKDSMTXdj0wa0f8pi2Y0wUsHEV6XnIbEtEMxL/a+cA==
X-Received: by 2002:aca:fd0a:: with SMTP id b10mr5654007oii.111.1594951348001;
        Thu, 16 Jul 2020 19:02:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:27 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 07/14] rtlwifi: rtl8192de: Rename RT_TRACE to RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:54 -0500
Message-Id: <20200717020201.18209-8-Larry.Finger@lwfinger.net>
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
rtl8192de.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 110 +++++------
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   |  46 ++---
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   |  98 +++++-----
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  | 182 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  20 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  10 +-
 7 files changed, 236 insertions(+), 236 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index 71f3b6b5d7bd..08c5d9644465 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -194,17 +194,17 @@ static void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
 		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "Cnt_Fast_Fsync_fail = %x, Cnt_SB_Search_fail = %x\n",
 		 falsealm_cnt->cnt_fast_fsync_fail,
 		 falsealm_cnt->cnt_sb_search_fail);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "Cnt_Parity_Fail = %x, Cnt_Rate_Illegal = %x, Cnt_Crc8_fail = %x, Cnt_Mcs_fail = %x\n",
 		 falsealm_cnt->cnt_parity_fail,
 		 falsealm_cnt->cnt_rate_illegal,
 		 falsealm_cnt->cnt_crc8_fail,
 		 falsealm_cnt->cnt_mcs_fail);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "Cnt_Ofdm_fail = %x, Cnt_Cck_fail = %x, Cnt_all = %x\n",
 		 falsealm_cnt->cnt_ofdm_fail,
 		 falsealm_cnt->cnt_cck_fail,
@@ -221,7 +221,7 @@ static void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.UNDEC_SM_PWDB == 0)) {
 		de_digtable->min_undec_pwdb_for_dm = 0;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 			 "Not connected to any\n");
 	}
 	if (mac->link_state >= MAC80211_LINKED) {
@@ -229,24 +229,24 @@ static void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 		    mac->opmode == NL80211_IFTYPE_ADHOC) {
 			de_digtable->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.UNDEC_SM_PWDB;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 				 "AP Client PWDB = 0x%lx\n",
 				 rtlpriv->dm.UNDEC_SM_PWDB);
 		} else {
 			de_digtable->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 				 "STA Default Port PWDB = 0x%x\n",
 				 de_digtable->min_undec_pwdb_for_dm);
 		}
 	} else {
 		de_digtable->min_undec_pwdb_for_dm = rtlpriv->dm.UNDEC_SM_PWDB;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
 			 "AP Ext Port or disconnect PWDB = 0x%x\n",
 			 de_digtable->min_undec_pwdb_for_dm);
 	}
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
 		 de_digtable->min_undec_pwdb_for_dm);
 }
 
@@ -287,13 +287,13 @@ static void rtl92d_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 		}
 		de_digtable->pre_cck_pd_state = de_digtable->cur_cck_pd_state;
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "CurSTAConnectState=%s\n",
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "CurSTAConnectState=%s\n",
 		 de_digtable->cursta_cstate == DIG_STA_CONNECT ?
 		 "DIG_STA_CONNECT " : "DIG_STA_DISCONNECT");
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "CCKPDStage=%s\n",
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "CCKPDStage=%s\n",
 		 de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI ?
 		 "Low RSSI " : "High RSSI ");
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "is92d single phy =%x\n",
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "is92d single phy =%x\n",
 		 IS_92D_SINGLEPHY(rtlpriv->rtlhal.version));
 
 }
@@ -303,12 +303,12 @@ void rtl92d_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
 		 de_digtable->cur_igvalue, de_digtable->pre_igvalue,
 		 de_digtable->back_val);
 	if (de_digtable->dig_enable_flag == false) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "DIG is disabled\n");
+		RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "DIG is disabled\n");
 		de_digtable->pre_igvalue = 0x17;
 		return;
 	}
@@ -327,21 +327,21 @@ static void rtl92d_early_mode_enabled(struct rtl_priv *rtlpriv)
 
 	if ((rtlpriv->mac80211.link_state >= MAC80211_LINKED) &&
 	    (rtlpriv->mac80211.vendor == PEER_CISCO)) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "IOT_PEER = CISCO\n");
+		RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "IOT_PEER = CISCO\n");
 		if (de_digtable->last_min_undec_pwdb_for_dm >= 50
 		    && de_digtable->min_undec_pwdb_for_dm < 50) {
 			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x00);
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 				 "Early Mode Off\n");
 		} else if (de_digtable->last_min_undec_pwdb_for_dm <= 55 &&
 			   de_digtable->min_undec_pwdb_for_dm > 55) {
 			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 				 "Early Mode On\n");
 		}
 	} else if (!(rtl_read_byte(rtlpriv, REG_EARLY_MODE_CONTROL) & 0xf)) {
 		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "Early Mode On\n");
+		RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "Early Mode On\n");
 	}
 }
 
@@ -352,7 +352,7 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 	u8 value_igi = de_digtable->cur_igvalue;
 	struct false_alarm_statistics *falsealm_cnt = &(rtlpriv->falsealm_cnt);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "==>\n");
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "==>\n");
 	if (rtlpriv->rtlhal.earlymode_enable) {
 		rtl92d_early_mode_enabled(rtlpriv);
 		de_digtable->last_min_undec_pwdb_for_dm =
@@ -371,7 +371,7 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 	/* Not STA mode return tmp */
 	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
 		return;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "progress\n");
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "progress\n");
 	/* Decide the current status and if modify initial gain or not */
 	if (rtlpriv->mac80211.link_state >= MAC80211_LINKED)
 		de_digtable->cursta_cstate = DIG_STA_CONNECT;
@@ -387,16 +387,16 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 		value_igi++;
 	else if (falsealm_cnt->cnt_all >= DM_DIG_FA_TH2)
 		value_igi += 2;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "dm_DIG() Before: large_fa_hit=%d, forbidden_igi=%x\n",
 		 de_digtable->large_fa_hit, de_digtable->forbidden_igi);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "dm_DIG() Before: Recover_cnt=%d, rx_gain_min=%x\n",
 		 de_digtable->recover_cnt, de_digtable->rx_gain_min);
 
 	/* deal with abnormally large false alarm */
 	if (falsealm_cnt->cnt_all > 10000) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 			 "dm_DIG(): Abnormally false alarm case\n");
 
 		de_digtable->large_fa_hit++;
@@ -435,10 +435,10 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 			}
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "dm_DIG() After: large_fa_hit=%d, forbidden_igi=%x\n",
 		 de_digtable->large_fa_hit, de_digtable->forbidden_igi);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD,
 		 "dm_DIG() After: recover_cnt=%d, rx_gain_min=%x\n",
 		 de_digtable->recover_cnt, de_digtable->rx_gain_min);
 
@@ -450,7 +450,7 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 	rtl92d_dm_write_dig(hw);
 	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G)
 		rtl92d_dm_cck_packet_detection_thresh(hw);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "<<==\n");
+	RT_DEBUG(rtlpriv, COMP_DIG, DBG_LOUD, "<<==\n");
 }
 
 static void rtl92d_dm_init_dynamic_txpower(struct ieee80211_hw *hw)
@@ -477,7 +477,7 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 	}
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.UNDEC_SM_PWDB == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "Not connected to any\n");
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 		rtlpriv->dm.last_dtp_lvl = TXHIGHPWRLEVEL_NORMAL;
@@ -487,13 +487,13 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb =
 			    rtlpriv->dm.UNDEC_SM_PWDB;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "IBSS Client PWDB = 0x%lx\n",
 				 undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "STA Default Port PWDB = 0x%lx\n",
 				 undec_sm_pwdb);
 		}
@@ -501,7 +501,7 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		undec_sm_pwdb =
 		    rtlpriv->dm.UNDEC_SM_PWDB;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "AP Ext Port PWDB = 0x%lx\n",
 			 undec_sm_pwdb);
 	}
@@ -509,18 +509,18 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		if (undec_sm_pwdb >= 0x33) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL2;
-			RT_TRACE(rtlpriv, COMP_HIPWR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_HIPWR, DBG_LOUD,
 				 "5G:TxHighPwrLevel_Level2 (TxPwr=0x0)\n");
 		} else if ((undec_sm_pwdb < 0x33)
 			   && (undec_sm_pwdb >= 0x2b)) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL1;
-			RT_TRACE(rtlpriv, COMP_HIPWR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_HIPWR, DBG_LOUD,
 				 "5G:TxHighPwrLevel_Level1 (TxPwr=0x10)\n");
 		} else if (undec_sm_pwdb < 0x2b) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_NORMAL;
-			RT_TRACE(rtlpriv, COMP_HIPWR, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_HIPWR, DBG_LOUD,
 				 "5G:TxHighPwrLevel_Normal\n");
 		}
 	} else {
@@ -528,7 +528,7 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		    TX_POWER_NEAR_FIELD_THRESH_LVL2) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL2;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
 		} else
 		    if ((undec_sm_pwdb <
@@ -538,18 +538,18 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL1;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
 		} else if (undec_sm_pwdb <
 			   (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_NORMAL;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "TXHIGHPWRLEVEL_NORMAL\n");
 		}
 	}
 	if ((rtlpriv->dm.dynamic_txhighpower_lvl != rtlpriv->dm.last_dtp_lvl)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
 			 rtlphy->current_channel);
 		rtl92d_phy_set_txpower_level(hw, rtlphy->current_channel);
@@ -666,7 +666,7 @@ static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
 
 	u4tmp = (index_mapping[(rtlpriv->efuse.eeprom_thermalmeter -
 				rtlpriv->dm.thermalvalue_rxgain)]) << 12;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "===> Rx Gain %x\n", u4tmp);
 	for (i = RF90_PATH_A; i < rtlpriv->phy.num_total_rfpath; i++)
 		rtl_set_rfreg(hw, i, 0x3C, RFREG_OFFSET_MASK,
@@ -695,7 +695,7 @@ static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
 
 		if (temp_cck == le32_to_cpu(*((__le32 *)cckswing))) {
 			*cck_index_old = (u8)i;
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 				 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
 				 RCCK0_TXFILTER2, temp_cck,
 				 *cck_index_old,
@@ -821,9 +821,9 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 	};
 
 	rtlpriv->dm.txpower_trackinginit = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
 	thermalvalue = (u8) rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0xf800);
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
 		 thermalvalue,
 		 rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
@@ -846,7 +846,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 			ofdm_index_old[0] = (u8)i;
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 				 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
 				 ROFDM0_XATXIQIMBALANCE,
 				 ele_d, ofdm_index_old[0]);
@@ -860,7 +860,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			if (ele_d ==
 			    (ofdmswing_table[i] & MASKOFDM_D)) {
 				ofdm_index_old[1] = (u8)i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
+				RT_DEBUG(rtlpriv, COMP_POWER_TRACKING,
 					 DBG_LOUD,
 					 "Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
 					 ROFDM0_XBTXIQIMBALANCE, ele_d,
@@ -889,7 +889,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		for (i = 0; i < rf; i++)
 			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
 		rtlpriv->dm.cck_index = cck_index_old;
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "reload ofdm index for band switch\n");
 	}
 old_index_done:
@@ -934,7 +934,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
 		(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
 		(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x delta 0x%x delta_lck 0x%x delta_iqk 0x%x\n",
 		 thermalvalue, rtlpriv->dm.thermalvalue,
 		 rtlefuse->eeprom_thermalmeter, delta, delta_lck,
@@ -974,13 +974,13 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 				   index_mapping_internal_pa);
 	}
 	if (is2t) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
 			 rtlpriv->dm.ofdm_index[0],
 			 rtlpriv->dm.ofdm_index[1],
 			 rtlpriv->dm.cck_index);
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
 			 rtlpriv->dm.ofdm_index[0],
 			 rtlpriv->dm.cck_index);
@@ -1003,12 +1003,12 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		}
 	}
 	if (is2t) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
 			 ofdm_index[0], ofdm_index[1],
 			 cck_index);
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "new OFDM_A_index=0x%x,cck_index = 0x%x\n",
 			 ofdm_index[0], cck_index);
 	}
@@ -1050,7 +1050,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			      BIT(24), 0x00);
 	}
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
 		 rtlhal->interfaceindex,
 		 val_x, val_y, ele_a, ele_c, ele_d,
@@ -1134,12 +1134,12 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
 				      BIT(28), 0x00);
 		}
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
 			 val_x, val_y, ele_a, ele_c,
 			 ele_d, val_x, val_y);
 	}
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
 		 rtl_get_bbreg(hw, 0xc80, MASKDWORD),
 		 rtl_get_bbreg(hw, 0xc94, MASKDWORD),
@@ -1161,7 +1161,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		rtlpriv->dm.thermalvalue = thermalvalue;
 
 exit:
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
 }
 
 static void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
@@ -1171,7 +1171,7 @@ static void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
 	rtlpriv->dm.txpower_tracking = true;
 	rtlpriv->dm.txpower_trackinginit = false;
 	rtlpriv->dm.txpower_track_control = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "pMgntInfo->txpower_tracking = %d\n",
 		 rtlpriv->dm.txpower_tracking);
 }
@@ -1186,12 +1186,12 @@ void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17) |
 			      BIT(16), 0x03);
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "Trigger 92S Thermal Meter!!\n");
 		rtlpriv->dm.tm_trigger = 1;
 		return;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 			 "Schedule TxPowerTracking direct call!!\n");
 		rtl92d_dm_txpower_tracking_callback_thermalmeter(hw);
 		rtlpriv->dm.tm_trigger = 0;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
index 2064813f9381..546c0a64c337 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
@@ -47,7 +47,7 @@ static void _rtl92d_write_fw(struct ieee80211_hw *hw,
 	u32 pagenums, remainsize;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE)
 		rtl_fill_dummy(bufferptr, &size);
 	pagenums = size / FW_8192D_PAGE_SIZE;
@@ -104,7 +104,7 @@ void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
 		u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	}
 	WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 		 "=====> 8051 reset success (%d)\n", delay);
 }
 
@@ -114,14 +114,14 @@ static int _rtl92d_fw_init(struct ieee80211_hw *hw)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u32 counter;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG, "FW already have download\n");
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG, "FW already have download\n");
 	/* polling for FW ready */
 	counter = 0;
 	do {
 		if (rtlhal->interfaceindex == 0) {
 			if (rtl_read_byte(rtlpriv, FW_MAC0_READY) &
 			    MAC0_READY) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 					 "Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
 					 rtl_read_byte(rtlpriv,
 						       FW_MAC0_READY));
@@ -131,7 +131,7 @@ static int _rtl92d_fw_init(struct ieee80211_hw *hw)
 		} else {
 			if (rtl_read_byte(rtlpriv, FW_MAC1_READY) &
 			    MAC1_READY) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 					 "Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
 					 rtl_read_byte(rtlpriv,
 						       FW_MAC1_READY));
@@ -142,15 +142,15 @@ static int _rtl92d_fw_init(struct ieee80211_hw *hw)
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
 	if (rtlhal->interfaceindex == 0) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 			 "Polling FW ready fail!! MAC0 FW init not ready: 0x%x\n",
 			 rtl_read_byte(rtlpriv, FW_MAC0_READY));
 	} else {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 			 "Polling FW ready fail!! MAC1 FW init not ready: 0x%x\n",
 			 rtl_read_byte(rtlpriv, FW_MAC1_READY));
 	}
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 		 "Polling FW ready fail!! REG_MCUFWDL:0x%08x\n",
 		 rtl_read_dword(rtlpriv, REG_MCUFWDL));
 	return -1;
@@ -177,12 +177,12 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 	pfwdata = rtlhal->pfirmware;
 	rtlhal->fw_version = (u16) GET_FIRMWARE_HDR_VERSION(pfwheader);
 	rtlhal->fw_subversion = (u16) GET_FIRMWARE_HDR_SUB_VER(pfwheader);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "FirmwareVersion(%d), FirmwareSubVersion(%d), Signature(%#x)\n",
 		 rtlhal->fw_version, rtlhal->fw_subversion,
 		 GET_FIRMWARE_HDR_SIGNATURE(pfwheader));
 	if (IS_FW_HEADER_EXIST(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Shift 32 bytes for FW header!!\n");
 		pfwdata = pfwdata + 32;
 		fwsize = fwsize - 32;
@@ -214,7 +214,7 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 			else if (!fwdl_in_process)
 				break;
 			else
-				RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_FW, DBG_DMESG,
 					 "Wait for another mac download fw\n");
 		}
 		spin_lock_irqsave(&globalmutex_for_fwdownload, flags);
@@ -286,15 +286,15 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 	u8 idx;
 
 	if (ppsc->rfpwr_state == ERFOFF || ppsc->inactive_pwrstate == ERFOFF) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "Return as RF is off!!!\n");
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
 	while (true) {
 		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 		if (rtlhal->h2c_setinprogress) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "H2C set in progress! Wait to set..element_id(%d)\n",
 				 element_id);
 
@@ -302,7 +302,7 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
 						       flag);
 				h2c_waitcounter++;
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Wait 100 us (%d times)...\n",
 					 h2c_waitcounter);
 				udelay(100);
@@ -353,7 +353,7 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 		while (!isfw_read) {
 			wait_h2c_limmit--;
 			if (wait_h2c_limmit == 0) {
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Waiting too long for FW read clear HMEBox(%d)!\n",
 					 boxnum);
 				break;
@@ -361,12 +361,12 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 			udelay(10);
 			isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
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
@@ -374,7 +374,7 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 		memset(boxcontent, 0, sizeof(boxcontent));
 		memset(boxextcontent, 0, sizeof(boxextcontent));
 		boxcontent[0] = element_id;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "Write element_id box_reg(%4x) = %2x\n",
 			 box_reg, element_id);
 		switch (cmd_len) {
@@ -430,14 +430,14 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 		rtlhal->last_hmeboxnum = boxnum + 1;
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "pHalData->last_hmeboxnum  = %d\n",
 			 rtlhal->last_hmeboxnum);
 	}
 	spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 	rtlhal->h2c_setinprogress = false;
 	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
 }
 
 void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -653,14 +653,14 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 			dlok = true;
 	}
 	if (dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Set RSVD page location to Fw\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 			      "H2C_RSVDPAGE", u1rsvdpageloc, 3);
 		rtl92d_fill_h2c_cmd(hw, H2C_RSVDPAGE,
 			sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Set RSVD page location to Fw FAIL!!!!!!\n");
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index 146fe144f5f5..c88297ea02b2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -204,7 +204,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME: {
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 			 "HW_VAR_SLOT_TIME %x\n", val[0]);
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 		for (e_aci = 0; e_aci < AC_MAX; e_aci++)
@@ -235,7 +235,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			mac->min_space_cfg = ((mac->min_space_cfg & 0xf8) |
 					      min_spacing_to_set);
 			*val = min_spacing_to_set;
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
 				 mac->min_space_cfg);
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
@@ -249,7 +249,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		density_to_set = *val;
 		mac->min_space_cfg = rtlpriv->rtlhal.minspace_cfg;
 		mac->min_space_cfg |= (density_to_set << 3);
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 			 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
 			 mac->min_space_cfg);
 		rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
@@ -284,7 +284,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 						     | (factor_toset);
 			}
 			rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, regtoset);
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
 				 factor_toset);
 		}
@@ -318,7 +318,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				acm_ctrl |= ACMHW_VOQEN;
 				break;
 			default:
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
 					 acm);
 				break;
@@ -340,7 +340,7 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				break;
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_QOS, DBG_TRACE,
 			 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
 			 acm_ctrl);
 		rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
@@ -851,12 +851,12 @@ void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
 		 rtlpriv->sec.pairwise_enc_algorithm,
 		 rtlpriv->sec.group_enc_algorithm);
 	if (rtlpriv->cfg->mod_params->sw_crypto || rtlpriv->sec.use_sw_sec) {
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 			 "not open hw encryption\n");
 		return;
 	}
@@ -867,7 +867,7 @@ void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
 	}
 	sec_reg_value |= (SCR_RXBCUSEDK | SCR_TXBCUSEDK);
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 		 "The SECR-value %x\n", sec_reg_value);
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
@@ -902,7 +902,7 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 	err = rtl92d_download_fw(hw);
 	spin_unlock_irqrestore(&globalmutex_for_power_and_efuse, flags);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Failed to download FW. Init HW without FW..\n");
 		return 1;
 	}
@@ -914,7 +914,7 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 	rtl_write_byte(rtlpriv, 0x605, tmp_u1b);
 
 	if (rtlhal->earlymode_enable) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "EarlyMode Enabled!!!\n");
 
 		tmp_u1b = rtl_read_byte(rtlpriv, 0x4d0);
@@ -1033,10 +1033,10 @@ static enum version_8192d _rtl92de_read_chip_version(struct ieee80211_hw *hw)
 	value32 = rtl_read_dword(rtlpriv, REG_SYS_CFG);
 	if (!(value32 & 0x000f0000)) {
 		version = VERSION_TEST_CHIP_92D_SINGLEPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "TEST CHIP!!!\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "TEST CHIP!!!\n");
 	} else {
 		version = VERSION_NORMAL_CHIP_92D_SINGLEPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Normal CHIP!!!\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Normal CHIP!!!\n");
 	}
 	return version;
 }
@@ -1060,7 +1060,7 @@ static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 		_rtl92de_resume_tx_beacon(hw);
 		_rtl92de_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x)\n",
 			 type);
 	}
@@ -1070,26 +1070,26 @@ static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 		bt_msr |= MSR_NOLINK;
 		ledaction = LED_CTL_LINK;
 		bcnfunc_enable &= 0xF7;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		bt_msr |= MSR_ADHOC;
 		bcnfunc_enable |= 0x08;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		bt_msr |= MSR_INFRA;
 		ledaction = LED_CTL_LINK;
 		bcnfunc_enable &= 0xF7;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		bt_msr |= MSR_AP;
 		bcnfunc_enable |= 0x08;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to AP!\n");
 		break;
 	default:
@@ -1156,7 +1156,7 @@ void rtl92d_linked_set_reg(struct ieee80211_hw *hw)
 
 	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(channel);
 	if (!rtlphy->iqk_matrix[indexforchannel].iqk_done) {
-		RT_TRACE(rtlpriv, COMP_SCAN | COMP_INIT, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_SCAN | COMP_INIT, DBG_DMESG,
 			 "Do IQK for channel:%d\n", channel);
 		rtl92d_phy_iq_calibrate(hw);
 	}
@@ -1255,7 +1255,7 @@ static void _rtl92de_poweroff_adapter(struct ieee80211_hw *hw)
 	/* is set as 0x18, they had ever met auto load fail problem. */
 	rtl_write_byte(rtlpriv, REG_APS_FSMCO + 1, 0x10);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "In PowerOff,reg0x%x=%X\n",
 		 REG_SPS0_CTRL, rtl_read_byte(rtlpriv, REG_SPS0_CTRL));
 	/* r.   Note: for PCIe interface, PON will not turn */
@@ -1270,7 +1270,7 @@ static void _rtl92de_poweroff_adapter(struct ieee80211_hw *hw)
 		spin_unlock_irqrestore(&globalmutex_power, flags);
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<=======\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "<=======\n");
 }
 
 void rtl92de_card_disable(struct ieee80211_hw *hw)
@@ -1328,7 +1328,7 @@ void rtl92de_card_disable(struct ieee80211_hw *hw)
 	rtl_write_byte(rtlpriv, REG_PCIE_CTRL_REG + 1, 0xff);
 	udelay(50);
 	rtl_write_byte(rtlpriv, REG_CR, 0x0);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "==> Do power off.......\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "==> Do power off.......\n");
 	if (rtl92d_phy_check_poweroff(hw))
 		_rtl92de_poweroff_adapter(hw);
 	return;
@@ -1370,7 +1370,7 @@ void rtl92de_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_BEACON, DBG_DMESG,
 		 "beacon_interval:%d\n", bcn_interval);
 	rtl92de_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
@@ -1383,7 +1383,7 @@ void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
 		 add_msr, rm_msr);
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1560,7 +1560,7 @@ static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
 				!((hwinfo[EEPROM_TSSI_A_5G] & BIT(6)) >> 6);
 			rtlefuse->internal_pa_5g[1] =
 				!((hwinfo[EEPROM_TSSI_B_5G] & BIT(6)) >> 6);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG,
 				 "Is D cut,Internal PA0 %d Internal PA1 %d\n",
 				 rtlefuse->internal_pa_5g[0],
 				 rtlefuse->internal_pa_5g[1]);
@@ -1612,13 +1612,13 @@ static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
 		rtlefuse->delta_lck = tempval[1] - 1;
 	if (rtlefuse->eeprom_c9 == 0xFF)
 		rtlefuse->eeprom_c9 = 0x00;
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD,
 		 "EEPROMRegulatory = 0x%x\n", rtlefuse->eeprom_regulatory);
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD,
 		 "ThermalMeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD,
 		 "CrystalCap = 0x%x\n", rtlefuse->crystalcap);
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD,
 		 "Delta_IQK = 0x%x Delta_LCK = 0x%x\n",
 		 rtlefuse->delta_iqk, rtlefuse->delta_lck);
 
@@ -1655,11 +1655,11 @@ static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
 
 	if (macphy_crvalue & BIT(3)) {
 		rtlhal->macphymode = SINGLEMAC_SINGLEPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "MacPhyMode SINGLEMAC_SINGLEPHY\n");
 	} else {
 		rtlhal->macphymode = DUALMAC_DUALPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "MacPhyMode DUALMAC_DUALPHY\n");
 	}
 }
@@ -1687,15 +1687,15 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 	switch (chipvalue) {
 	case 0xAA55:
 		chipver |= CHIP_92D_C_CUT;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "C-CUT!!!\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "C-CUT!!!\n");
 		break;
 	case 0x9966:
 		chipver |= CHIP_92D_D_CUT;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
 		break;
 	case 0xCC33:
 		chipver |= CHIP_92D_E_CUT;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
 		break;
 	default:
 		chipver |= CHIP_92D_D_CUT;
@@ -1737,7 +1737,7 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 	}
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_ETHER_ADDR,
 				      rtlefuse->dev_addr);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
 	_rtl92de_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);
 
 	/* Read Channel Plan */
@@ -1771,14 +1771,14 @@ void rtl92de_read_eeprom_info(struct ieee80211_hw *hw)
 	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
 	rtlefuse->autoload_status = tmp_u1b;
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
 		_rtl92de_read_adapter_info(hw);
@@ -1866,7 +1866,7 @@ static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
 		    (shortgi_rate << 4) | (shortgi_rate);
 	}
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
 		 rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
@@ -1998,7 +1998,7 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 
 	value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
 	value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG,
 		 "ratr_bitmap :%x value0:%x value1:%x\n",
 		 ratr_bitmap, value[0], value[1]);
 	rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *) value);
@@ -2059,13 +2059,13 @@ bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	u1tmp = rtl_read_byte(rtlpriv, REG_GPIO_IO_SEL);
 	e_rfpowerstate_toset = (u1tmp & BIT(3)) ? ERFON : ERFOFF;
 	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
 		e_rfpowerstate_toset = ERFON;
 		ppsc->hwradiooff = false;
 		actuallyset = true;
 	} else if (!ppsc->hwradiooff && (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 		e_rfpowerstate_toset = ERFOFF;
 		ppsc->hwradiooff = true;
@@ -2110,7 +2110,7 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 idx;
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
 			rtl_cam_empty_entry(hw, cam_offset + idx);
@@ -2164,21 +2164,21 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 			}
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
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "The insert KEY length is %d\n",
 				 rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD,
 				 "The insert KEY is %x %x\n",
 				 rtlpriv->sec.key_buf[0][0],
 				 rtlpriv->sec.key_buf[0][1]);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 				 "add one entry\n");
 			if (is_pairwise) {
 				RT_PRINT_DATA(rtlpriv, COMP_SEC, DBG_LOUD,
@@ -2186,7 +2186,7 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 					      rtlpriv->sec.pairwise_key,
 					      rtlpriv->
 					      sec.key_len[PAIRWISE_KEYIDX]);
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 					 "set Pairwise key\n");
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
 						      entry_id, enc_algo,
@@ -2194,7 +2194,7 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 						      rtlpriv->
 						      sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 					 "set group key\n");
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 					rtl_cam_add_one_entry(hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
index 2b76a025deb8..31b52cb36066 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
@@ -19,7 +19,7 @@ void rtl92de_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
 		 REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
@@ -56,7 +56,7 @@ void rtl92de_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
 		 REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
@@ -128,7 +128,7 @@ void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n", ledaction);
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n", ledaction);
 
 	_rtl92ce_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index 4b672199c81d..cd96c28b14aa 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -178,7 +178,7 @@ u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
 		 regaddr, bitmask);
 	if (rtlhal->during_mac1init_radioa || rtlhal->during_mac0init_radiob) {
 		u8 dbi_direct = 0;
@@ -196,7 +196,7 @@ u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	}
 	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
 		 bitmask, regaddr, originalvalue);
 	return returnvalue;
@@ -210,7 +210,7 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 	u8 dbi_direct = 0;
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 	if (rtlhal->during_mac1init_radioa)
@@ -233,7 +233,7 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 		rtl92de_write_dword_dbi(hw, (u16) regaddr, data, dbi_direct);
 	else
 		rtl_write_dword(rtlpriv, regaddr, data);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 }
@@ -279,7 +279,7 @@ static u32 _rtl92d_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 			BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x] = 0x%x\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x] = 0x%x\n",
 		 rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
 }
@@ -298,7 +298,7 @@ static void _rtl92d_phy_rf_serial_write(struct ieee80211_hw *hw,
 	/* T65 RF */
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
@@ -308,7 +308,7 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 	spin_lock(&rtlpriv->locks.rf_lock);
@@ -316,7 +316,7 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
 	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 	spin_unlock(&rtlpriv->locks.rf_lock);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		 regaddr, rfpath, bitmask, original_value);
 	return readback_value;
@@ -329,7 +329,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 	if (bitmask == 0)
@@ -346,7 +346,7 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	}
 	spin_unlock(&rtlpriv->locks.rf_lock);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 }
@@ -358,10 +358,10 @@ bool rtl92d_phy_mac_config(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
 	arraylength = MAC_2T_ARRAYLENGTH;
 	ptrarray = rtl8192de_mac_2tarray;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Img:Rtl819XMAC_Array\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Img:Rtl819XMAC_Array\n");
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8) ptrarray[i + 1]);
 	if (rtlpriv->rtlhal.macphymode == SINGLEMAC_SINGLEPHY) {
@@ -519,25 +519,25 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 	if (rtlhal->interfaceindex == 0) {
 		agctab_arraylen = AGCTAB_ARRAYLENGTH;
 		agctab_array_table = rtl8192de_agctab_array;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 " ===> phy:MAC0, Rtl819XAGCTAB_Array\n");
 	} else {
 		if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 			agctab_arraylen = AGCTAB_2G_ARRAYLENGTH;
 			agctab_array_table = rtl8192de_agctab_2garray;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 " ===> phy:MAC1, Rtl819XAGCTAB_2GArray\n");
 		} else {
 			agctab_5garraylen = AGCTAB_5G_ARRAYLENGTH;
 			agctab_5garray_table = rtl8192de_agctab_5garray;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 " ===> phy:MAC1, Rtl819XAGCTAB_5GArray\n");
 
 		}
 	}
 	phy_reg_arraylen = PHY_REG_2T_ARRAYLENGTH;
 	phy_regarray_table = rtl8192de_phy_reg_2tarray;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 " ===> phy:Rtl819XPHY_REG_Array_PG\n");
 	if (configtype == BASEBAND_CONFIG_PHY_REG) {
 		for (i = 0; i < phy_reg_arraylen; i = i + 2) {
@@ -545,7 +545,7 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 			rtl_set_bbreg(hw, phy_regarray_table[i], MASKDWORD,
 				      phy_regarray_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 				 "The phy_regarray_table[0] is %x Rtl819XPHY_REGArray[1] is %x\n",
 				 phy_regarray_table[i],
 				 phy_regarray_table[i + 1]);
@@ -559,12 +559,12 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 				/* Add 1us delay between BB/RF register
 				 * setting. */
 				udelay(1);
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 					 "The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
 					 agctab_array_table[i],
 					 agctab_array_table[i + 1]);
 			}
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "Normal Chip, MAC0, load Rtl819XAGCTAB_Array\n");
 		} else {
 			if (rtlhal->current_bandtype == BAND_ON_2_4G) {
@@ -575,12 +575,12 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 					/* Add 1us delay between BB/RF register
 					 * setting. */
 					udelay(1);
-					RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+					RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 						 "The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
 						 agctab_array_table[i],
 						 agctab_array_table[i + 1]);
 				}
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 					 "Load Rtl819XAGCTAB_2GArray\n");
 			} else {
 				for (i = 0; i < agctab_5garraylen; i = i + 2) {
@@ -591,12 +591,12 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 					/* Add 1us delay between BB/RF registeri
 					 * setting. */
 					udelay(1);
-					RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+					RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 						 "The Rtl819XAGCTAB_5GArray_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
 						 agctab_5garray_table[i],
 						 agctab_5garray_table[i + 1]);
 				}
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 					 "Load Rtl819XAGCTAB_5GArray\n");
 			}
 		}
@@ -648,7 +648,7 @@ static void _rtl92d_store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 		return;
 
 	rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index] = data;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "MCSTxPowerLevelOriginalOffset[%d][%d] = 0x%x\n",
 		 rtlphy->pwrgroup_cnt, index,
 		 rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index]);
@@ -675,7 +675,7 @@ static bool _rtl92d_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 				phy_regarray_table_pg[i + 2]);
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "configtype != BaseBand_Config_PHY_REG\n");
 	}
 	return true;
@@ -688,7 +688,7 @@ static bool _rtl92d_phy_bb_config(struct ieee80211_hw *hw)
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	bool rtstatus = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "==>\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "==>\n");
 	rtstatus = _rtl92d_phy_config_bb_with_headerfile(hw,
 		BASEBAND_CONFIG_PHY_REG);
 	if (!rtstatus) {
@@ -698,7 +698,7 @@ static bool _rtl92d_phy_bb_config(struct ieee80211_hw *hw)
 
 	/* if (rtlphy->rf_type == RF_1T2R) {
 	 *      _rtl92c_phy_bb_config_1t(hw);
-	 *     RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
+	 *     RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
 	 *} */
 
 	if (rtlefuse->autoload_failflag == false) {
@@ -777,17 +777,17 @@ bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 		radiob_arraylen = RADIOB_2T_INT_PA_ARRAYLENGTH;
 		radiob_array_table = rtl8192de_radiob_2t_int_paarray;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "PHY_ConfigRFWithHeaderFile() Radio_A:Rtl819XRadioA_1TArray\n");
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "PHY_ConfigRFWithHeaderFile() Radio_B:Rtl819XRadioB_1TArray\n");
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
 
 	/* this only happens when DMDP, mac0 start on 2.4G,
 	 * mac1 start on 5G, mac 0 has to set phy0&phy1
 	 * pathA or mac1 has to set phy0&phy1 pathA */
 	if ((content == radiob_txt) && (rfpath == RF90_PATH_A)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 " ===> althougth Path A, we load radiob.txt\n");
 		radioa_arraylen = radiob_arraylen;
 		radioa_array_table = radiob_array_table;
@@ -828,7 +828,7 @@ void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	    (u8) rtl_get_bbreg(hw, ROFDM0_XCAGCCORE1, MASKBYTE0);
 	rtlphy->default_initialgain[3] =
 	    (u8) rtl_get_bbreg(hw, ROFDM0_XDAGCCORE1, MASKBYTE0);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x\n",
 		 rtlphy->default_initialgain[0],
 		 rtlphy->default_initialgain[1],
@@ -838,7 +838,7 @@ void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 					      MASKBYTE0);
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
 					      MASKDWORD);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 		 "Default framesync (0x%x) = 0x%x\n",
 		 ROFDM0_RXDETECTOR3, rtlphy->framesync);
 }
@@ -938,12 +938,12 @@ void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if (rtlphy->set_bwmode_inprogress)
 		return;
 	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "FALSE driver sleep or unload\n");
 		return;
 	}
 	rtlphy->set_bwmode_inprogress = true;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
 		 rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
 		 "20MHz" : "40MHz");
 	reg_bw_opmode = rtl_read_byte(rtlpriv, REG_BWOPMODE);
@@ -1001,7 +1001,7 @@ void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
 	}
 	rtl92d_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 }
 
 static void _rtl92d_phy_stop_trx_before_changeband(struct ieee80211_hw *hw)
@@ -1018,7 +1018,7 @@ static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u8 value8;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
 	rtlhal->bandset = band;
 	rtlhal->current_bandtype = band;
 	if (IS_92D_SINGLEPHY(rtlhal->version))
@@ -1028,13 +1028,13 @@ static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 	/* reconfig BB/RF according to wireless mode */
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		/* BB & RF Config */
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "====>2.4G\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "====>2.4G\n");
 		if (rtlhal->interfaceindex == 1)
 			_rtl92d_phy_config_bb_with_headerfile(hw,
 				BASEBAND_CONFIG_AGC_TAB);
 	} else {
 		/* 5G band */
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "====>5G\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "====>5G\n");
 		if (rtlhal->interfaceindex == 1)
 			_rtl92d_phy_config_bb_with_headerfile(hw,
 				BASEBAND_CONFIG_AGC_TAB);
@@ -1062,7 +1062,7 @@ static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 			0 ? REG_MAC0 : REG_MAC1), value8);
 	}
 	mdelay(1);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<==Switch Band OK\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "<==Switch Band OK\n");
 }
 
 static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
@@ -1074,9 +1074,9 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 	u8 group, i;
 	unsigned long flag = 0;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>path %d\n", rfpath);
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "====>path %d\n", rfpath);
 	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
 		rtl_set_bbreg(hw, RFPGA0_RFMOD, BIT(25) | BIT(24), 0);
 		rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0xf);
 		/* fc area 0xd2c */
@@ -1097,12 +1097,12 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, RFPGA0_RFMOD, BOFDMEN, 1);
 	} else {
 		/* G band. */
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD,
 			 "Load RF IMR parameters for G band. IMR already setting %d\n",
 			 rtlpriv->rtlhal.load_imrandiqk_setting_for2g);
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
 		if (!rtlpriv->rtlhal.load_imrandiqk_setting_for2g) {
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD,
 				 "Load RF IMR parameters for G band. %d\n",
 				 rfpath);
 			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
@@ -1122,7 +1122,7 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
@@ -1132,7 +1132,7 @@ static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
 	/*----Store original RFENV control type----*/
 	switch (rfpath) {
 	case RF90_PATH_A:
@@ -1158,7 +1158,7 @@ static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
 	/*Set 0 to 12 bits for 8255 */
 	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
 	udelay(1);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
 }
 
 static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
@@ -1168,7 +1168,7 @@ static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "=====>\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "=====>\n");
 	/*----Restore RFENV control type----*/
 	switch (rfpath) {
 	case RF90_PATH_A:
@@ -1181,7 +1181,7 @@ static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
 			      *pu4_regval);
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<=====\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "<=====\n");
 }
 
 static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
@@ -1195,10 +1195,10 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 	bool need_pwr_down = false, internal_pa = false;
 	u32 u4regvalue, mask = 0x1C000, value = 0, u4tmp, u4tmp2;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "====>\n");
 	/* config path A for 5G */
 	if (rtlhal->current_bandtype == BAND_ON_5G) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
 		u4tmp = curveindex_5g[channel - 1];
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"ver 1 set RF-A, 5G, 0x28 = 0x%x !!\n", u4tmp);
@@ -1246,7 +1246,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 					      RFREG_OFFSET_MASK,
 					      rf_reg_pram_c_5g[index][i]);
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 				 "offset 0x%x value 0x%x path %d index %d readback 0x%x\n",
 				 rf_reg_for_c_cut_5g[i],
 				 rf_reg_pram_c_5g[index][i],
@@ -1285,7 +1285,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 						rf_for_c_cut_5g_internal_pa[i],
 						RFREG_OFFSET_MASK,
 						rf_pram_c_5g_int_pa[index][i]);
-					RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
+					RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD,
 						 "offset 0x%x value 0x%x path %d index %d\n",
 						 rf_for_c_cut_5g_internal_pa[i],
 						 rf_pram_c_5g_int_pa[index][i],
@@ -1297,7 +1297,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 			}
 		}
 	} else if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
 		u4tmp = curveindex_2g[channel - 1];
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n", u4tmp);
@@ -1333,7 +1333,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 					      RFREG_OFFSET_MASK,
 					      rf_reg_param_for_c_cut_2g
 					      [index][i]);
-			RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 				 "offset 0x%x value 0x%x mak 0x%x path %d index %d readback 0x%x\n",
 				 rf_reg_for_c_cut_2g[i],
 				 rf_reg_param_for_c_cut_2g[index][i],
@@ -1354,7 +1354,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 		if (rtlhal->during_mac0init_radiob)
 			rtl92d_phy_powerdown_anotherphy(hw, true);
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
@@ -2358,7 +2358,7 @@ void rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw)
 		rtlphy->iqk_matrix[indexforchannel].iqk_done =
 			true;
 
-		RT_TRACE(rtlpriv, COMP_SCAN | COMP_MLME, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SCAN | COMP_MLME, DBG_LOUD,
 			 "IQK OK indexforchannel %d\n", indexforchannel);
 	}
 }
@@ -2370,16 +2370,16 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 	struct rtl_hal *rtlhal = &(rtlpriv->rtlhal);
 	u8 indexforchannel;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "channel %d\n", channel);
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "channel %d\n", channel);
 	/*------Do IQK for normal chip and test chip 5G band------- */
 	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(channel);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "indexforchannel %d done %d\n",
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "indexforchannel %d done %d\n",
 		 indexforchannel,
 		 rtlphy->iqk_matrix[indexforchannel].iqk_done);
 	if (0 && !rtlphy->iqk_matrix[indexforchannel].iqk_done &&
 		rtlphy->need_iqk) {
 		/* Re Do IQK. */
-		RT_TRACE(rtlpriv, COMP_SCAN | COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_SCAN | COMP_INIT, DBG_LOUD,
 			 "Do IQK Matrix reg for channel:%d....\n", channel);
 		rtl92d_phy_iq_calibrate(hw);
 	} else {
@@ -2387,7 +2387,7 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 		/* 2G band just load once. */
 		if (((!rtlhal->load_imrandiqk_setting_for2g) &&
 		    indexforchannel == 0) || indexforchannel > 0) {
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_SCAN, DBG_LOUD,
 				 "Just Read IQK Matrix reg for channel:%d....\n",
 				 channel);
 			if ((rtlphy->iqk_matrix[indexforchannel].
@@ -2413,7 +2413,7 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 		}
 	}
 	rtlphy->need_iqk = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 static u32 _rtl92d_phy_get_abs(u32 val1, u32 val2)
@@ -2477,7 +2477,7 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 	u32 u4tmp = 0, u4regvalue = 0;
 	bool bneed_powerdown_radio = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "path %d\n", erfpath);
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "path %d\n", erfpath);
 	RTPRINT(rtlpriv, FINIT, INIT_IQK, "band type = %d\n",
 		rtlpriv->rtlhal.current_bandtype);
 	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "channel = %d\n", channel);
@@ -2522,7 +2522,7 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 		if (rtlpriv->rtlhal.during_mac0init_radiob)
 			rtl92d_phy_powerdown_anotherphy(hw, true);
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 static void _rtl92d_phy_lc_calibrate_sw(struct ieee80211_hw *hw, bool is2t)
@@ -2695,7 +2695,7 @@ void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u8 i;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "settings regs %d default regs %d\n",
 		 (int)(sizeof(rtlphy->iqk_matrix) /
 		       sizeof(struct iqk_matrix_regs)),
@@ -2844,7 +2844,7 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 		return 0;
 
 	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CHAN, DBG_LOUD,
 			 "sw_chnl_inprogress false driver sleep or unload\n");
 		return 0;
 	}
@@ -2886,7 +2886,7 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 		channel = 1;
 	rtlphy->sw_chnl_stage = 0;
 	rtlphy->sw_chnl_step = 0;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE,
 		 "switch to channel%d\n", rtlphy->current_channel);
 
 	do {
@@ -2904,7 +2904,7 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 	rtlphy->sw_chnl_inprogress = false;
 	return 1;
 }
@@ -2915,7 +2915,7 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
 	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
 		 rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
@@ -2935,7 +2935,7 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
 		break;
 	}
 	rtlphy->set_io_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "<---(%#x)\n",
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE, "<---(%#x)\n",
 		 rtlphy->current_io_type);
 }
 
@@ -2945,18 +2945,18 @@ bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
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
 				 "[IO CMD] Resume DM after scan\n");
 			postprocessing = true;
 			break;
 		case IO_CMD_PAUSE_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE,
 				 "[IO CMD] Pause DM before scan\n");
 			postprocessing = true;
 			break;
@@ -2973,7 +2973,7 @@ bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl92d_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "<--IO Type(%#x)\n", iotype);
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_TRACE, "<--IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -3030,7 +3030,7 @@ static void _rtl92d_phy_set_rfsleep(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Fail !!! Switch RF timeout\n");
 		return;
 	}
@@ -3065,7 +3065,7 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			u32 initializecount = 0;
 			do {
 				initializecount++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 					 "IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus && (initializecount < 10));
@@ -3073,7 +3073,7 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			RT_CLEAR_PS_LEVEL(ppsc,
 					  RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 				 "awake, sleeped:%d ms state_inap:%x\n",
 				 jiffies_to_msecs(jiffies -
 						  ppsc->last_sleep_jiffies),
@@ -3091,7 +3091,7 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		break;
 	case ERFOFF:
 		if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 				 "IPS Set eRf nic disable\n");
 			rtl_ps_disable_nic(hw);
 			RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
@@ -3116,12 +3116,12 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
 			} else if (rtlpci->pdev->current_state != PCI_D0) {
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] !=0 but lower power state!\n",
 					 i + 1, queue_id);
 				break;
 			} else {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
 					 i + 1, queue_id,
 					 skb_queue_len(&ring->queue));
@@ -3130,17 +3130,17 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			}
 
 			if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+				RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 					 "ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
 					 MAX_DOZE_WAITING_TIMES_9x, queue_id,
 					 skb_queue_len(&ring->queue));
 				break;
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 			 "Set rfsleep awaked:%d ms\n",
 			 jiffies_to_msecs(jiffies - ppsc->last_awake_jiffies));
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 			 "sleep awaked:%d ms state_inap:%x\n",
 			 jiffies_to_msecs(jiffies -
 					  ppsc->last_awake_jiffies),
@@ -3167,17 +3167,17 @@ void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
 
 	switch (rtlhal->macphymode) {
 	case DUALMAC_DUALPHY:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "MacPhyMode: DUALMAC_DUALPHY\n");
 		rtl_write_byte(rtlpriv, offset, 0xF3);
 		break;
 	case SINGLEMAC_SINGLEPHY:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "MacPhyMode: SINGLEMAC_SINGLEPHY\n");
 		rtl_write_byte(rtlpriv, offset, 0xF4);
 		break;
 	case DUALMAC_SINGLEPHY:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "MacPhyMode: DUALMAC_SINGLEPHY\n");
 		rtl_write_byte(rtlpriv, offset, 0xF1);
 		break;
@@ -3346,7 +3346,7 @@ void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	u8 rfpath, i;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
 	/* r_select_5G for path_A/B 0 for 2.4G, 1 for 5G */
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		/* r_select_5G for path_A/B,0x878 */
@@ -3494,7 +3494,7 @@ void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 				      BIT(13), 0x3);
 		} else {
 			rtl92d_phy_enable_anotherphy(hw, false);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "MAC1 use DBI to update 0x888\n");
 			/* 0x888 */
 			rtl92de_write_dword_dbi(hw, RFPGA0_ADDALLOCKEN,
@@ -3520,9 +3520,9 @@ void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 			RFREG_OFFSET_MASK);
 	}
 	for (i = 0; i < 2; i++)
-		RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "RF 0x18 = 0x%x\n",
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "RF 0x18 = 0x%x\n",
 			 rtlphy->rfreg_chnlval[i]);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<==\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "<==\n");
 
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
index 915a36f7af5e..8d5b0d953db3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
@@ -23,7 +23,7 @@ void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth)
 			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) |
 				      BIT(11), 0x01);
 
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD,
 				 "20M RF 0x18 = 0x%x\n",
 				 rtlphy->rfreg_chnlval[rfpath]);
 		}
@@ -35,7 +35,7 @@ void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth)
 			    ((rtlphy->rfreg_chnlval[rfpath] & 0xfffff3ff));
 			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) | BIT(11),
 				      0x00);
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD,
 				 "40M RF 0x18 = 0x%x\n",
 				 rtlphy->rfreg_chnlval[rfpath]);
 		}
@@ -391,11 +391,11 @@ bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 
 	rtlhal->during_mac0init_radiob = false;
 	rtlhal->during_mac1init_radioa = false;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "===>\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "===>\n");
 	/* MAC0 Need PHY1 load radio_b.txt . Driver use DBI to write. */
 	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
 	if (!(u1btmp & mac_on_bit)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "enable BB & RF\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "enable BB & RF\n");
 		/* Enable BB and RF power */
 		rtl92de_write_dword_dbi(hw, REG_SYS_ISO_CTRL,
 			rtl92de_read_dword_dbi(hw, REG_SYS_ISO_CTRL, direct) |
@@ -405,7 +405,7 @@ bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 		 * and radio_b.txt has been load. */
 		bresult = false;
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<===\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "<===\n");
 	return bresult;
 
 }
@@ -421,17 +421,17 @@ void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 
 	rtlhal->during_mac0init_radiob = false;
 	rtlhal->during_mac1init_radioa = false;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
 	/* check MAC0 enable or not again now, if
 	 * enabled, not power down radio A. */
 	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
 	if (!(u1btmp & mac_on_bit)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "power down\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "power down\n");
 		/* power down RF radio A according to YuNan's advice. */
 		rtl92de_write_dword_dbi(hw, RFPGA0_XA_LSSIPARAMETER,
 					0x00000000, direct);
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
 }
 
 bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
@@ -573,7 +573,7 @@ bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
 			break;
 		}
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 				 "Radio[%d] Fail!!\n", rfpath);
 			goto phy_rf_cfg_fail;
 		}
@@ -588,7 +588,7 @@ bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
 		rtl92d_phy_powerdown_anotherphy(hw, false);
 	else if (need_pwrdown_radiob)
 		rtl92d_phy_powerdown_anotherphy(hw, true);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
 	return rtstatus;
 
 phy_rf_cfg_fail:
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index ab5b05ef168e..6a7097356655 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -511,7 +511,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
@@ -526,7 +526,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_SEND, DBG_LOUD,
 					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
 					 ptcb_desc->empkt_num);
 				_rtl92de_insert_emcontent(ptcb_desc,
@@ -625,7 +625,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 		}
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+				RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 					 "Enable RDG function\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
@@ -652,7 +652,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_pkt_id(pdesc, 8);
 	}
 	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -671,7 +671,7 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
-- 
2.27.0

