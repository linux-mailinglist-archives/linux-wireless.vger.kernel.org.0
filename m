Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C79222B7FA
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGWUm6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGWUm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:57 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B97C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w17so6205649oie.6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GcVxsJDspO9hevIBjU54Q+h/rP9Pcp4E4VMYVxEWMwQ=;
        b=ZYfthy0Swp+lT/FeyCPABk0voW5ufZ2NY9i2qUJ5fHbUYIQ3HKkqp/Y/mHYkPXN/aM
         WuGE/B8OjGh191tBos1xgFIiuy2eCTfUtW4cW/wRatcEZw8w0MNW2E3n2tJZVkamLk7d
         CbJmV9lgNA6oyNJWDZw7iKAUL8XWXWtfwR+TYXeZ3ctpJoeshsa0F25UzxuEvneIeseU
         Sn6FupzGISNZ+VtNNZPP/omNgH8lAvgt+VNHLSiuFJZAdyAX1OZVOdmhE8qRa5LKrjEC
         MwZ2d1EbMl+nt57GL7GpsreQbhPaBYifUzWjpALaJr3WteRctx0DFzOVJJMV6GkXniOl
         UXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GcVxsJDspO9hevIBjU54Q+h/rP9Pcp4E4VMYVxEWMwQ=;
        b=DyiAEAEH7dzEzqDm7TA7u4JmUsadWc5UbhBvAkSka6j5VlZidjGVGCVVBjBwpoawsm
         OiGgUGhJ6h+Jlxp402bmUNwCyeQ54I9G37YH2yMq1Ev9gmKrCFoxrrfT2wUuvvnRqDwH
         IvFkgXRrgvSr1Kw0MXjH6euIemJptbgVpwuB2fID0LjeEUlVV/htNsPZbh0TMyQwAZGI
         jchAcDFuEpbDu5hkgL+N88cmJ9TMY2ayP+kS3I5TuMPmfZhu5U2940BwFgqAc3dZVk/3
         4ZZGgx6V3cZfr5GV5nUXLwH9U/DyiH4eMJBo4AAW4jgxICtbhPLhkpcggQNYEl460lf6
         Mk/g==
X-Gm-Message-State: AOAM531hhGbHQIKDK+juWDVqGBXfxi2h6OG8Vt2XxTHCTRvh1S8nWMIz
        LqkbIcQ79/XntDdzBrej1hM=
X-Google-Smtp-Source: ABdhPJzEZOxLAwk42eJPWvQPyM9Epl9SnpL37O3CmkaRYSuFmH7rIIW0d5F21BD9qSnI+IyIHvNcvQ==
X-Received: by 2002:aca:d497:: with SMTP id l145mr5311301oig.146.1595536975514;
        Thu, 23 Jul 2020 13:42:55 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:55 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 08/15] rtlwifi: rtl8192de: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:37 -0500
Message-Id: <20200723204244.24457-9-Larry.Finger@lwfinger.net>
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
rtl8192de. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 312 ++++++-------
 .../wireless/realtek/rtlwifi/rtl8192de/fw.c   | 116 ++---
 .../wireless/realtek/rtlwifi/rtl8192de/hw.c   | 206 ++++-----
 .../wireless/realtek/rtlwifi/rtl8192de/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192de/phy.c  | 414 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192de/rf.c   |  30 +-
 .../wireless/realtek/rtlwifi/rtl8192de/trx.c  |  20 +-
 7 files changed, 554 insertions(+), 554 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
index 71f3b6b5d7bd..b3f25a228532 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/dm.c
@@ -194,21 +194,21 @@ static void rtl92d_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_FALSEALARMREPORT, 0x0000c000, 2);
 		rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "Cnt_Fast_Fsync_fail = %x, Cnt_SB_Search_fail = %x\n",
-		 falsealm_cnt->cnt_fast_fsync_fail,
-		 falsealm_cnt->cnt_sb_search_fail);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "Cnt_Parity_Fail = %x, Cnt_Rate_Illegal = %x, Cnt_Crc8_fail = %x, Cnt_Mcs_fail = %x\n",
-		 falsealm_cnt->cnt_parity_fail,
-		 falsealm_cnt->cnt_rate_illegal,
-		 falsealm_cnt->cnt_crc8_fail,
-		 falsealm_cnt->cnt_mcs_fail);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "Cnt_Ofdm_fail = %x, Cnt_Cck_fail = %x, Cnt_all = %x\n",
-		 falsealm_cnt->cnt_ofdm_fail,
-		 falsealm_cnt->cnt_cck_fail,
-		 falsealm_cnt->cnt_all);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"Cnt_Fast_Fsync_fail = %x, Cnt_SB_Search_fail = %x\n",
+		falsealm_cnt->cnt_fast_fsync_fail,
+		falsealm_cnt->cnt_sb_search_fail);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"Cnt_Parity_Fail = %x, Cnt_Rate_Illegal = %x, Cnt_Crc8_fail = %x, Cnt_Mcs_fail = %x\n",
+		falsealm_cnt->cnt_parity_fail,
+		falsealm_cnt->cnt_rate_illegal,
+		falsealm_cnt->cnt_crc8_fail,
+		falsealm_cnt->cnt_mcs_fail);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"Cnt_Ofdm_fail = %x, Cnt_Cck_fail = %x, Cnt_all = %x\n",
+		falsealm_cnt->cnt_ofdm_fail,
+		falsealm_cnt->cnt_cck_fail,
+		falsealm_cnt->cnt_all);
 }
 
 static void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
@@ -221,33 +221,33 @@ static void rtl92d_dm_find_minimum_rssi(struct ieee80211_hw *hw)
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.UNDEC_SM_PWDB == 0)) {
 		de_digtable->min_undec_pwdb_for_dm = 0;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"Not connected to any\n");
 	}
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_AP ||
 		    mac->opmode == NL80211_IFTYPE_ADHOC) {
 			de_digtable->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.UNDEC_SM_PWDB;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				 "AP Client PWDB = 0x%lx\n",
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"AP Client PWDB = 0x%lx\n",
 				 rtlpriv->dm.UNDEC_SM_PWDB);
 		} else {
 			de_digtable->min_undec_pwdb_for_dm =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%x\n",
-				 de_digtable->min_undec_pwdb_for_dm);
+			rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+				"STA Default Port PWDB = 0x%x\n",
+				de_digtable->min_undec_pwdb_for_dm);
 		}
 	} else {
 		de_digtable->min_undec_pwdb_for_dm = rtlpriv->dm.UNDEC_SM_PWDB;
-		RT_TRACE(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
-			 "AP Ext Port or disconnect PWDB = 0x%x\n",
-			 de_digtable->min_undec_pwdb_for_dm);
+		rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_LOUD,
+			"AP Ext Port or disconnect PWDB = 0x%x\n",
+			de_digtable->min_undec_pwdb_for_dm);
 	}
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
-		 de_digtable->min_undec_pwdb_for_dm);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "MinUndecoratedPWDBForDM =%d\n",
+		de_digtable->min_undec_pwdb_for_dm);
 }
 
 static void rtl92d_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
@@ -287,14 +287,14 @@ static void rtl92d_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
 		}
 		de_digtable->pre_cck_pd_state = de_digtable->cur_cck_pd_state;
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "CurSTAConnectState=%s\n",
-		 de_digtable->cursta_cstate == DIG_STA_CONNECT ?
-		 "DIG_STA_CONNECT " : "DIG_STA_DISCONNECT");
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "CCKPDStage=%s\n",
-		 de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI ?
-		 "Low RSSI " : "High RSSI ");
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "is92d single phy =%x\n",
-		 IS_92D_SINGLEPHY(rtlpriv->rtlhal.version));
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "CurSTAConnectState=%s\n",
+		de_digtable->cursta_cstate == DIG_STA_CONNECT ?
+		"DIG_STA_CONNECT " : "DIG_STA_DISCONNECT");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "CCKPDStage=%s\n",
+		de_digtable->cur_cck_pd_state == CCK_PD_STAGE_LOWRSSI ?
+		"Low RSSI " : "High RSSI ");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "is92d single phy =%x\n",
+		IS_92D_SINGLEPHY(rtlpriv->rtlhal.version));
 
 }
 
@@ -303,12 +303,12 @@ void rtl92d_dm_write_dig(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
-		 de_digtable->cur_igvalue, de_digtable->pre_igvalue,
-		 de_digtable->back_val);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"cur_igvalue = 0x%x, pre_igvalue = 0x%x, back_val = %d\n",
+		de_digtable->cur_igvalue, de_digtable->pre_igvalue,
+		de_digtable->back_val);
 	if (de_digtable->dig_enable_flag == false) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "DIG is disabled\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "DIG is disabled\n");
 		de_digtable->pre_igvalue = 0x17;
 		return;
 	}
@@ -327,21 +327,21 @@ static void rtl92d_early_mode_enabled(struct rtl_priv *rtlpriv)
 
 	if ((rtlpriv->mac80211.link_state >= MAC80211_LINKED) &&
 	    (rtlpriv->mac80211.vendor == PEER_CISCO)) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "IOT_PEER = CISCO\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "IOT_PEER = CISCO\n");
 		if (de_digtable->last_min_undec_pwdb_for_dm >= 50
 		    && de_digtable->min_undec_pwdb_for_dm < 50) {
 			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x00);
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "Early Mode Off\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"Early Mode Off\n");
 		} else if (de_digtable->last_min_undec_pwdb_for_dm <= 55 &&
 			   de_digtable->min_undec_pwdb_for_dm > 55) {
 			rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
-			RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-				 "Early Mode On\n");
+			rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+				"Early Mode On\n");
 		}
 	} else if (!(rtl_read_byte(rtlpriv, REG_EARLY_MODE_CONTROL) & 0xf)) {
 		rtl_write_byte(rtlpriv, REG_EARLY_MODE_CONTROL, 0x0f);
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "Early Mode On\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "Early Mode On\n");
 	}
 }
 
@@ -352,7 +352,7 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 	u8 value_igi = de_digtable->cur_igvalue;
 	struct false_alarm_statistics *falsealm_cnt = &(rtlpriv->falsealm_cnt);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "==>\n");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "==>\n");
 	if (rtlpriv->rtlhal.earlymode_enable) {
 		rtl92d_early_mode_enabled(rtlpriv);
 		de_digtable->last_min_undec_pwdb_for_dm =
@@ -371,7 +371,7 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 	/* Not STA mode return tmp */
 	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
 		return;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "progress\n");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "progress\n");
 	/* Decide the current status and if modify initial gain or not */
 	if (rtlpriv->mac80211.link_state >= MAC80211_LINKED)
 		de_digtable->cursta_cstate = DIG_STA_CONNECT;
@@ -387,17 +387,17 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 		value_igi++;
 	else if (falsealm_cnt->cnt_all >= DM_DIG_FA_TH2)
 		value_igi += 2;
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "dm_DIG() Before: large_fa_hit=%d, forbidden_igi=%x\n",
-		 de_digtable->large_fa_hit, de_digtable->forbidden_igi);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "dm_DIG() Before: Recover_cnt=%d, rx_gain_min=%x\n",
-		 de_digtable->recover_cnt, de_digtable->rx_gain_min);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() Before: large_fa_hit=%d, forbidden_igi=%x\n",
+		de_digtable->large_fa_hit, de_digtable->forbidden_igi);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() Before: Recover_cnt=%d, rx_gain_min=%x\n",
+		de_digtable->recover_cnt, de_digtable->rx_gain_min);
 
 	/* deal with abnormally large false alarm */
 	if (falsealm_cnt->cnt_all > 10000) {
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-			 "dm_DIG(): Abnormally false alarm case\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+			"dm_DIG(): Abnormally false alarm case\n");
 
 		de_digtable->large_fa_hit++;
 		if (de_digtable->forbidden_igi < de_digtable->cur_igvalue) {
@@ -435,12 +435,12 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 			}
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "dm_DIG() After: large_fa_hit=%d, forbidden_igi=%x\n",
-		 de_digtable->large_fa_hit, de_digtable->forbidden_igi);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD,
-		 "dm_DIG() After: recover_cnt=%d, rx_gain_min=%x\n",
-		 de_digtable->recover_cnt, de_digtable->rx_gain_min);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() After: large_fa_hit=%d, forbidden_igi=%x\n",
+		de_digtable->large_fa_hit, de_digtable->forbidden_igi);
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD,
+		"dm_DIG() After: recover_cnt=%d, rx_gain_min=%x\n",
+		de_digtable->recover_cnt, de_digtable->rx_gain_min);
 
 	if (value_igi > DM_DIG_MAX)
 		value_igi = DM_DIG_MAX;
@@ -450,7 +450,7 @@ static void rtl92d_dm_dig(struct ieee80211_hw *hw)
 	rtl92d_dm_write_dig(hw);
 	if (rtlpriv->rtlhal.current_bandtype != BAND_ON_5G)
 		rtl92d_dm_cck_packet_detection_thresh(hw);
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "<<==\n");
+	rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "<<==\n");
 }
 
 static void rtl92d_dm_init_dynamic_txpower(struct ieee80211_hw *hw)
@@ -477,8 +477,8 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 	}
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.UNDEC_SM_PWDB == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 		rtlpriv->dm.last_dtp_lvl = TXHIGHPWRLEVEL_NORMAL;
 		return;
@@ -487,49 +487,49 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb =
 			    rtlpriv->dm.UNDEC_SM_PWDB;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "IBSS Client PWDB = 0x%lx\n",
-				 undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"IBSS Client PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb =
 			    rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "STA Default Port PWDB = 0x%lx\n",
-				 undec_sm_pwdb);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"STA Default Port PWDB = 0x%lx\n",
+				undec_sm_pwdb);
 		}
 	} else {
 		undec_sm_pwdb =
 		    rtlpriv->dm.UNDEC_SM_PWDB;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "AP Ext Port PWDB = 0x%lx\n",
-			 undec_sm_pwdb);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"AP Ext Port PWDB = 0x%lx\n",
+			undec_sm_pwdb);
 	}
 	if (rtlhal->current_bandtype == BAND_ON_5G) {
 		if (undec_sm_pwdb >= 0x33) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL2;
-			RT_TRACE(rtlpriv, COMP_HIPWR, DBG_LOUD,
-				 "5G:TxHighPwrLevel_Level2 (TxPwr=0x0)\n");
+			rtl_dbg(rtlpriv, COMP_HIPWR, DBG_LOUD,
+				"5G:TxHighPwrLevel_Level2 (TxPwr=0x0)\n");
 		} else if ((undec_sm_pwdb < 0x33)
 			   && (undec_sm_pwdb >= 0x2b)) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL1;
-			RT_TRACE(rtlpriv, COMP_HIPWR, DBG_LOUD,
-				 "5G:TxHighPwrLevel_Level1 (TxPwr=0x10)\n");
+			rtl_dbg(rtlpriv, COMP_HIPWR, DBG_LOUD,
+				"5G:TxHighPwrLevel_Level1 (TxPwr=0x10)\n");
 		} else if (undec_sm_pwdb < 0x2b) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_NORMAL;
-			RT_TRACE(rtlpriv, COMP_HIPWR, DBG_LOUD,
-				 "5G:TxHighPwrLevel_Normal\n");
+			rtl_dbg(rtlpriv, COMP_HIPWR, DBG_LOUD,
+				"5G:TxHighPwrLevel_Normal\n");
 		}
 	} else {
 		if (undec_sm_pwdb >=
 		    TX_POWER_NEAR_FIELD_THRESH_LVL2) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL2;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x0)\n");
 		} else
 		    if ((undec_sm_pwdb <
 			 (TX_POWER_NEAR_FIELD_THRESH_LVL2 - 3))
@@ -538,20 +538,20 @@ static void rtl92d_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_LEVEL1;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"TXHIGHPWRLEVEL_LEVEL1 (TxPwr=0x10)\n");
 		} else if (undec_sm_pwdb <
 			   (TX_POWER_NEAR_FIELD_THRESH_LVL1 - 5)) {
 			rtlpriv->dm.dynamic_txhighpower_lvl =
 						 TXHIGHPWRLEVEL_NORMAL;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "TXHIGHPWRLEVEL_NORMAL\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"TXHIGHPWRLEVEL_NORMAL\n");
 		}
 	}
 	if ((rtlpriv->dm.dynamic_txhighpower_lvl != rtlpriv->dm.last_dtp_lvl)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "PHY_SetTxPowerLevel8192S() Channel = %d\n",
-			 rtlphy->current_channel);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"PHY_SetTxPowerLevel8192S() Channel = %d\n",
+			rtlphy->current_channel);
 		rtl92d_phy_set_txpower_level(hw, rtlphy->current_channel);
 	}
 	rtlpriv->dm.last_dtp_lvl = rtlpriv->dm.dynamic_txhighpower_lvl;
@@ -666,8 +666,8 @@ static void rtl92d_dm_rxgain_tracking_thermalmeter(struct ieee80211_hw *hw)
 
 	u4tmp = (index_mapping[(rtlpriv->efuse.eeprom_thermalmeter -
 				rtlpriv->dm.thermalvalue_rxgain)]) << 12;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "===> Rx Gain %x\n", u4tmp);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"===> Rx Gain %x\n", u4tmp);
 	for (i = RF90_PATH_A; i < rtlpriv->phy.num_total_rfpath; i++)
 		rtl_set_rfreg(hw, i, 0x3C, RFREG_OFFSET_MASK,
 			      (rtlpriv->phy.reg_rf3c[i] & (~(0xF000))) | u4tmp);
@@ -695,11 +695,11 @@ static void rtl92d_bandtype_2_4G(struct ieee80211_hw *hw, long *temp_cckg,
 
 		if (temp_cck == le32_to_cpu(*((__le32 *)cckswing))) {
 			*cck_index_old = (u8)i;
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
-				 RCCK0_TXFILTER2, temp_cck,
-				 *cck_index_old,
-				 rtlpriv->dm.cck_inch14);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Initial reg0x%x = 0x%lx, cck_index = 0x%x, ch14 %d\n",
+				RCCK0_TXFILTER2, temp_cck,
+				*cck_index_old,
+				rtlpriv->dm.cck_inch14);
 			break;
 		}
 	}
@@ -821,12 +821,12 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 	};
 
 	rtlpriv->dm.txpower_trackinginit = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "\n");
 	thermalvalue = (u8) rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0xf800);
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
-		 thermalvalue,
-		 rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermalmeter 0x%x\n",
+		thermalvalue,
+		rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
 	rtl92d_phy_ap_calibrate(hw, (thermalvalue -
 				     rtlefuse->eeprom_thermalmeter));
 
@@ -846,10 +846,10 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		if (ele_d == (ofdmswing_table[i] & MASKOFDM_D)) {
 			ofdm_index_old[0] = (u8)i;
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-				 "Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
-				 ROFDM0_XATXIQIMBALANCE,
-				 ele_d, ofdm_index_old[0]);
+			rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+				"Initial pathA ele_d reg0x%x = 0x%lx, ofdm_index=0x%x\n",
+				ROFDM0_XATXIQIMBALANCE,
+				ele_d, ofdm_index_old[0]);
 			break;
 		}
 	}
@@ -860,11 +860,11 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			if (ele_d ==
 			    (ofdmswing_table[i] & MASKOFDM_D)) {
 				ofdm_index_old[1] = (u8)i;
-				RT_TRACE(rtlpriv, COMP_POWER_TRACKING,
-					 DBG_LOUD,
-					 "Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
-					 ROFDM0_XBTXIQIMBALANCE, ele_d,
-					 ofdm_index_old[1]);
+				rtl_dbg(rtlpriv, COMP_POWER_TRACKING,
+					DBG_LOUD,
+					"Initial pathB ele_d reg 0x%x = 0x%lx, ofdm_index = 0x%x\n",
+					ROFDM0_XBTXIQIMBALANCE, ele_d,
+					ofdm_index_old[1]);
 				break;
 			}
 		}
@@ -889,8 +889,8 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		for (i = 0; i < rf; i++)
 			rtlpriv->dm.ofdm_index[i] = ofdm_index_old[i];
 		rtlpriv->dm.cck_index = cck_index_old;
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "reload ofdm index for band switch\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"reload ofdm index for band switch\n");
 	}
 old_index_done:
 	for (i = 0; i < rf; i++)
@@ -934,11 +934,11 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		(thermalvalue > rtlpriv->dm.thermalvalue_rxgain) ?
 		(thermalvalue - rtlpriv->dm.thermalvalue_rxgain) :
 		(rtlpriv->dm.thermalvalue_rxgain - thermalvalue);
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
 	if (delta_lck > rtlefuse->delta_lck && rtlefuse->delta_lck != 0) {
 		rtlpriv->dm.thermalvalue_lck = thermalvalue;
 		rtl92d_phy_lc_calibrate(hw);
@@ -974,16 +974,16 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 				   index_mapping_internal_pa);
 	}
 	if (is2t) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
-			 rtlpriv->dm.ofdm_index[0],
-			 rtlpriv->dm.ofdm_index[1],
-			 rtlpriv->dm.cck_index);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"temp OFDM_A_index=0x%x, OFDM_B_index = 0x%x,cck_index=0x%x\n",
+			rtlpriv->dm.ofdm_index[0],
+			rtlpriv->dm.ofdm_index[1],
+			rtlpriv->dm.cck_index);
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
-			 rtlpriv->dm.ofdm_index[0],
-			 rtlpriv->dm.cck_index);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"temp OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			rtlpriv->dm.ofdm_index[0],
+			rtlpriv->dm.cck_index);
 	}
 	for (i = 0; i < rf; i++) {
 		if (ofdm_index[i] > OFDM_TABLE_SIZE_92D - 1)
@@ -1003,14 +1003,14 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		}
 	}
 	if (is2t) {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
-			 ofdm_index[0], ofdm_index[1],
-			 cck_index);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"new OFDM_A_index=0x%x, OFDM_B_index = 0x%x, cck_index=0x%x\n",
+			ofdm_index[0], ofdm_index[1],
+			cck_index);
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "new OFDM_A_index=0x%x,cck_index = 0x%x\n",
-			 ofdm_index[0], cck_index);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"new OFDM_A_index=0x%x,cck_index = 0x%x\n",
+			ofdm_index[0], cck_index);
 	}
 	ele_d = (ofdmswing_table[ofdm_index[0]] & 0xFFC00000) >> 22;
 	val_x = rtlphy->iqk_matrix[indexforchannel].value[0][0];
@@ -1050,11 +1050,11 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			      BIT(24), 0x00);
 	}
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
-		 rtlhal->interfaceindex,
-		 val_x, val_y, ele_a, ele_c, ele_d,
-		 val_x, val_y);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxPwrTracking for interface %d path A: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xe94 = 0x%lx 0xe9c = 0x%lx\n",
+		rtlhal->interfaceindex,
+		val_x, val_y, ele_a, ele_c, ele_d,
+		val_x, val_y);
 
 	if (cck_index >= CCK_TABLE_SIZE)
 		cck_index = CCK_TABLE_SIZE - 1;
@@ -1134,17 +1134,17 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 			rtl_set_bbreg(hw, ROFDM0_ECCATHRESHOLD,
 				      BIT(28), 0x00);
 		}
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-			 "TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
-			 val_x, val_y, ele_a, ele_c,
-			 ele_d, val_x, val_y);
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			"TxPwrTracking path B: X = 0x%lx, Y = 0x%lx ele_A = 0x%lx ele_C = 0x%lx ele_D = 0x%lx 0xeb4 = 0x%lx 0xebc = 0x%lx\n",
+			val_x, val_y, ele_a, ele_c,
+			ele_d, val_x, val_y);
 	}
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
-		 rtl_get_bbreg(hw, 0xc80, MASKDWORD),
-		 rtl_get_bbreg(hw, 0xc94, MASKDWORD),
-		 rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
-			       RFREG_OFFSET_MASK));
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"TxPwrTracking 0xc80 = 0x%x, 0xc94 = 0x%x RF 0x24 = 0x%x\n",
+		rtl_get_bbreg(hw, 0xc80, MASKDWORD),
+		rtl_get_bbreg(hw, 0xc94, MASKDWORD),
+		rtl_get_rfreg(hw, RF90_PATH_A, 0x24,
+			      RFREG_OFFSET_MASK));
 
 check_delta:
 	if (delta_iqk > rtlefuse->delta_iqk && rtlefuse->delta_iqk != 0) {
@@ -1161,7 +1161,7 @@ static void rtl92d_dm_txpower_tracking_callback_thermalmeter(
 		rtlpriv->dm.thermalvalue = thermalvalue;
 
 exit:
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD, "<===\n");
 }
 
 static void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
@@ -1171,9 +1171,9 @@ static void rtl92d_dm_initialize_txpower_tracking(struct ieee80211_hw *hw)
 	rtlpriv->dm.txpower_tracking = true;
 	rtlpriv->dm.txpower_trackinginit = false;
 	rtlpriv->dm.txpower_track_control = true;
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
-		 "pMgntInfo->txpower_tracking = %d\n",
-		 rtlpriv->dm.txpower_tracking);
+	rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+		"pMgntInfo->txpower_tracking = %d\n",
+		rtlpriv->dm.txpower_tracking);
 }
 
 void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
@@ -1186,13 +1186,13 @@ void rtl92d_dm_check_txpower_tracking_thermal_meter(struct ieee80211_hw *hw)
 	if (!rtlpriv->dm.tm_trigger) {
 		rtl_set_rfreg(hw, RF90_PATH_A, RF_T_METER, BIT(17) |
 			      BIT(16), 0x03);
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
 		rtl92d_dm_txpower_tracking_callback_thermalmeter(hw);
 		rtlpriv->dm.tm_trigger = 0;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
index 2064813f9381..9ddb8478784b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.c
@@ -47,7 +47,7 @@ static void _rtl92d_write_fw(struct ieee80211_hw *hw,
 	u32 pagenums, remainsize;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_TRACE, "FW size is %d bytes,\n", size);
 	if (rtlhal->hw_type == HARDWARE_TYPE_RTL8192DE)
 		rtl_fill_dummy(bufferptr, &size);
 	pagenums = size / FW_8192D_PAGE_SIZE;
@@ -104,8 +104,8 @@ void rtl92d_firmware_selfreset(struct ieee80211_hw *hw)
 		u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	}
 	WARN_ONCE((delay <= 0), "rtl8192de: 8051 reset failed!\n");
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "=====> 8051 reset success (%d)\n", delay);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"=====> 8051 reset success (%d)\n", delay);
 }
 
 static int _rtl92d_fw_init(struct ieee80211_hw *hw)
@@ -114,27 +114,27 @@ static int _rtl92d_fw_init(struct ieee80211_hw *hw)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u32 counter;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG, "FW already have download\n");
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG, "FW already have download\n");
 	/* polling for FW ready */
 	counter = 0;
 	do {
 		if (rtlhal->interfaceindex == 0) {
 			if (rtl_read_byte(rtlpriv, FW_MAC0_READY) &
 			    MAC0_READY) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-					 "Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
-					 rtl_read_byte(rtlpriv,
-						       FW_MAC0_READY));
+				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+					"Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
+					rtl_read_byte(rtlpriv,
+						      FW_MAC0_READY));
 				return 0;
 			}
 			udelay(5);
 		} else {
 			if (rtl_read_byte(rtlpriv, FW_MAC1_READY) &
 			    MAC1_READY) {
-				RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-					 "Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
-					 rtl_read_byte(rtlpriv,
-						       FW_MAC1_READY));
+				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+					"Polling FW ready success!! REG_MCUFWDL: 0x%x\n",
+					rtl_read_byte(rtlpriv,
+						      FW_MAC1_READY));
 				return 0;
 			}
 			udelay(5);
@@ -142,17 +142,17 @@ static int _rtl92d_fw_init(struct ieee80211_hw *hw)
 	} while (counter++ < POLLING_READY_TIMEOUT_COUNT);
 
 	if (rtlhal->interfaceindex == 0) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Polling FW ready fail!! MAC0 FW init not ready: 0x%x\n",
-			 rtl_read_byte(rtlpriv, FW_MAC0_READY));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Polling FW ready fail!! MAC0 FW init not ready: 0x%x\n",
+			rtl_read_byte(rtlpriv, FW_MAC0_READY));
 	} else {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Polling FW ready fail!! MAC1 FW init not ready: 0x%x\n",
-			 rtl_read_byte(rtlpriv, FW_MAC1_READY));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Polling FW ready fail!! MAC1 FW init not ready: 0x%x\n",
+			rtl_read_byte(rtlpriv, FW_MAC1_READY));
 	}
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "Polling FW ready fail!! REG_MCUFWDL:0x%08x\n",
-		 rtl_read_dword(rtlpriv, REG_MCUFWDL));
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"Polling FW ready fail!! REG_MCUFWDL:0x%08x\n",
+		rtl_read_dword(rtlpriv, REG_MCUFWDL));
 	return -1;
 }
 
@@ -177,13 +177,13 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 	pfwdata = rtlhal->pfirmware;
 	rtlhal->fw_version = (u16) GET_FIRMWARE_HDR_VERSION(pfwheader);
 	rtlhal->fw_subversion = (u16) GET_FIRMWARE_HDR_SUB_VER(pfwheader);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "FirmwareVersion(%d), FirmwareSubVersion(%d), Signature(%#x)\n",
-		 rtlhal->fw_version, rtlhal->fw_subversion,
-		 GET_FIRMWARE_HDR_SIGNATURE(pfwheader));
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"FirmwareVersion(%d), FirmwareSubVersion(%d), Signature(%#x)\n",
+		rtlhal->fw_version, rtlhal->fw_subversion,
+		GET_FIRMWARE_HDR_SIGNATURE(pfwheader));
 	if (IS_FW_HEADER_EXIST(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Shift 32 bytes for FW header!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Shift 32 bytes for FW header!!\n");
 		pfwdata = pfwdata + 32;
 		fwsize = fwsize - 32;
 	}
@@ -214,8 +214,8 @@ int rtl92d_download_fw(struct ieee80211_hw *hw)
 			else if (!fwdl_in_process)
 				break;
 			else
-				RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-					 "Wait for another mac download fw\n");
+				rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+					"Wait for another mac download fw\n");
 		}
 		spin_lock_irqsave(&globalmutex_for_fwdownload, flags);
 		value = rtl_read_byte(rtlpriv, 0x1f);
@@ -286,25 +286,25 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 	u8 idx;
 
 	if (ppsc->rfpwr_state == ERFOFF || ppsc->inactive_pwrstate == ERFOFF) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-			 "Return as RF is off!!!\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Return as RF is off!!!\n");
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
 	while (true) {
 		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 		if (rtlhal->h2c_setinprogress) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-				 "H2C set in progress! Wait to set..element_id(%d)\n",
-				 element_id);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"H2C set in progress! Wait to set..element_id(%d)\n",
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
@@ -353,30 +353,30 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
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
 			udelay(10);
 			isfw_read = _rtl92d_check_fw_read_last_h2c(hw, boxnum);
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
-			 box_reg, element_id);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Write element_id box_reg(%4x) = %2x\n",
+			box_reg, element_id);
 		switch (cmd_len) {
 		case 1:
 			boxcontent[0] &= ~(BIT(7));
@@ -430,14 +430,14 @@ static void _rtl92d_fill_h2c_command(struct ieee80211_hw *hw,
 		rtlhal->last_hmeboxnum = boxnum + 1;
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
-			 "pHalData->last_hmeboxnum  = %d\n",
-			 rtlhal->last_hmeboxnum);
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
 
 void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -653,15 +653,15 @@ void rtl92d_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool dl_finished)
 			dlok = true;
 	}
 	if (dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Set RSVD page location to Fw\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 			      "H2C_RSVDPAGE", u1rsvdpageloc, 3);
 		rtl92d_fill_h2c_cmd(hw, H2C_RSVDPAGE,
 			sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!\n");
 }
 
 void rtl92d_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw, u8 mstatus)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
index 146fe144f5f5..2deadc7339ce 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/hw.c
@@ -204,8 +204,8 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME: {
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "HW_VAR_SLOT_TIME %x\n", val[0]);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"HW_VAR_SLOT_TIME %x\n", val[0]);
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 		for (e_aci = 0; e_aci < AC_MAX; e_aci++)
 			rtlpriv->cfg->ops->set_hw_reg(hw,
@@ -235,9 +235,9 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			mac->min_space_cfg = ((mac->min_space_cfg & 0xf8) |
 					      min_spacing_to_set);
 			*val = min_spacing_to_set;
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-				 mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+				mac->min_space_cfg);
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
 		}
@@ -249,9 +249,9 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		density_to_set = *val;
 		mac->min_space_cfg = rtlpriv->rtlhal.minspace_cfg;
 		mac->min_space_cfg |= (density_to_set << 3);
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-			 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-			 mac->min_space_cfg);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+			"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+			mac->min_space_cfg);
 		rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 			       mac->min_space_cfg);
 		break;
@@ -284,9 +284,9 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 						     | (factor_toset);
 			}
 			rtl_write_dword(rtlpriv, REG_AGGLEN_LMT, regtoset);
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
-				 factor_toset);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+				factor_toset);
 		}
 		break;
 	}
@@ -318,9 +318,9 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -340,9 +340,9 @@ void rtl92de_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
 		break;
 	}
@@ -851,13 +851,13 @@ void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "PairwiseEncAlgorithm = %d GroupEncAlgorithm = %d\n",
-		 rtlpriv->sec.pairwise_enc_algorithm,
-		 rtlpriv->sec.group_enc_algorithm);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
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
 	sec_reg_value = SCR_TXENCENABLE | SCR_RXENCENABLE;
@@ -867,8 +867,8 @@ void rtl92de_enable_hw_security_config(struct ieee80211_hw *hw)
 	}
 	sec_reg_value |= (SCR_RXBCUSEDK | SCR_TXBCUSEDK);
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+		"The SECR-value %x\n", sec_reg_value);
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
 
@@ -902,8 +902,8 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 	err = rtl92d_download_fw(hw);
 	spin_unlock_irqrestore(&globalmutex_for_power_and_efuse, flags);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW..\n");
 		return 1;
 	}
 	rtlhal->last_hmeboxnum = 0;
@@ -914,8 +914,8 @@ int rtl92de_hw_init(struct ieee80211_hw *hw)
 	rtl_write_byte(rtlpriv, 0x605, tmp_u1b);
 
 	if (rtlhal->earlymode_enable) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "EarlyMode Enabled!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"EarlyMode Enabled!!!\n");
 
 		tmp_u1b = rtl_read_byte(rtlpriv, 0x4d0);
 		tmp_u1b = tmp_u1b | 0x1f;
@@ -1033,10 +1033,10 @@ static enum version_8192d _rtl92de_read_chip_version(struct ieee80211_hw *hw)
 	value32 = rtl_read_dword(rtlpriv, REG_SYS_CFG);
 	if (!(value32 & 0x000f0000)) {
 		version = VERSION_TEST_CHIP_92D_SINGLEPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "TEST CHIP!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "TEST CHIP!!!\n");
 	} else {
 		version = VERSION_NORMAL_CHIP_92D_SINGLEPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Normal CHIP!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Normal CHIP!!!\n");
 	}
 	return version;
 }
@@ -1060,9 +1060,9 @@ static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 		_rtl92de_resume_tx_beacon(hw);
 		_rtl92de_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x)\n",
-			 type);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x)\n",
+			type);
 	}
 	bcnfunc_enable = rtl_read_byte(rtlpriv, REG_BCN_CTRL);
 	switch (type) {
@@ -1070,27 +1070,27 @@ static int _rtl92de_set_media_status(struct ieee80211_hw *hw,
 		bt_msr |= MSR_NOLINK;
 		ledaction = LED_CTL_LINK;
 		bcnfunc_enable &= 0xF7;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to NO LINK!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		bt_msr |= MSR_ADHOC;
 		bcnfunc_enable |= 0x08;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to Ad Hoc!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		bt_msr |= MSR_INFRA;
 		ledaction = LED_CTL_LINK;
 		bcnfunc_enable &= 0xF7;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to STA!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		bt_msr |= MSR_AP;
 		bcnfunc_enable |= 0x08;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to AP!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to AP!\n");
 		break;
 	default:
 		pr_err("Network type %d not supported!\n", type);
@@ -1156,8 +1156,8 @@ void rtl92d_linked_set_reg(struct ieee80211_hw *hw)
 
 	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(channel);
 	if (!rtlphy->iqk_matrix[indexforchannel].iqk_done) {
-		RT_TRACE(rtlpriv, COMP_SCAN | COMP_INIT, DBG_DMESG,
-			 "Do IQK for channel:%d\n", channel);
+		rtl_dbg(rtlpriv, COMP_SCAN | COMP_INIT, DBG_DMESG,
+			"Do IQK for channel:%d\n", channel);
 		rtl92d_phy_iq_calibrate(hw);
 	}
 }
@@ -1255,9 +1255,9 @@ static void _rtl92de_poweroff_adapter(struct ieee80211_hw *hw)
 	/* is set as 0x18, they had ever met auto load fail problem. */
 	rtl_write_byte(rtlpriv, REG_APS_FSMCO + 1, 0x10);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "In PowerOff,reg0x%x=%X\n",
-		 REG_SPS0_CTRL, rtl_read_byte(rtlpriv, REG_SPS0_CTRL));
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"In PowerOff,reg0x%x=%X\n",
+		REG_SPS0_CTRL, rtl_read_byte(rtlpriv, REG_SPS0_CTRL));
 	/* r.   Note: for PCIe interface, PON will not turn */
 	/* off m-bias and BandGap in PCIe suspend mode.  */
 
@@ -1270,7 +1270,7 @@ static void _rtl92de_poweroff_adapter(struct ieee80211_hw *hw)
 		spin_unlock_irqrestore(&globalmutex_power, flags);
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<=======\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<=======\n");
 }
 
 void rtl92de_card_disable(struct ieee80211_hw *hw)
@@ -1328,7 +1328,7 @@ void rtl92de_card_disable(struct ieee80211_hw *hw)
 	rtl_write_byte(rtlpriv, REG_PCIE_CTRL_REG + 1, 0xff);
 	udelay(50);
 	rtl_write_byte(rtlpriv, REG_CR, 0x0);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "==> Do power off.......\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "==> Do power off.......\n");
 	if (rtl92d_phy_check_poweroff(hw))
 		_rtl92de_poweroff_adapter(hw);
 	return;
@@ -1370,8 +1370,8 @@ void rtl92de_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	rtl92de_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	rtl92de_enable_interrupt(hw);
@@ -1383,8 +1383,8 @@ void rtl92de_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
-		 add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
+		add_msr, rm_msr);
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
 	if (rm_msr)
@@ -1560,10 +1560,10 @@ static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
 				!((hwinfo[EEPROM_TSSI_A_5G] & BIT(6)) >> 6);
 			rtlefuse->internal_pa_5g[1] =
 				!((hwinfo[EEPROM_TSSI_B_5G] & BIT(6)) >> 6);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "Is D cut,Internal PA0 %d Internal PA1 %d\n",
-				 rtlefuse->internal_pa_5g[0],
-				 rtlefuse->internal_pa_5g[1]);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"Is D cut,Internal PA0 %d Internal PA1 %d\n",
+				rtlefuse->internal_pa_5g[0],
+				rtlefuse->internal_pa_5g[1]);
 		}
 		rtlefuse->eeprom_c9 = hwinfo[EEPROM_RF_OPT6];
 		rtlefuse->eeprom_cc = hwinfo[EEPROM_RF_OPT7];
@@ -1612,15 +1612,15 @@ static void _rtl92de_read_txpower_info(struct ieee80211_hw *hw,
 		rtlefuse->delta_lck = tempval[1] - 1;
 	if (rtlefuse->eeprom_c9 == 0xFF)
 		rtlefuse->eeprom_c9 = 0x00;
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "EEPROMRegulatory = 0x%x\n", rtlefuse->eeprom_regulatory);
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "ThermalMeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "CrystalCap = 0x%x\n", rtlefuse->crystalcap);
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "Delta_IQK = 0x%x Delta_LCK = 0x%x\n",
-		 rtlefuse->delta_iqk, rtlefuse->delta_lck);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"EEPROMRegulatory = 0x%x\n", rtlefuse->eeprom_regulatory);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"ThermalMeter = 0x%x\n", rtlefuse->eeprom_thermalmeter);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"CrystalCap = 0x%x\n", rtlefuse->crystalcap);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"Delta_IQK = 0x%x Delta_LCK = 0x%x\n",
+		rtlefuse->delta_iqk, rtlefuse->delta_lck);
 
 	for (rfpath = 0; rfpath < RF6052_MAX_PATH; rfpath++) {
 		for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
@@ -1655,12 +1655,12 @@ static void _rtl92de_read_macphymode_from_prom(struct ieee80211_hw *hw,
 
 	if (macphy_crvalue & BIT(3)) {
 		rtlhal->macphymode = SINGLEMAC_SINGLEPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "MacPhyMode SINGLEMAC_SINGLEPHY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode SINGLEMAC_SINGLEPHY\n");
 	} else {
 		rtlhal->macphymode = DUALMAC_DUALPHY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "MacPhyMode DUALMAC_DUALPHY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode DUALMAC_DUALPHY\n");
 	}
 }
 
@@ -1687,15 +1687,15 @@ static void _rtl92de_efuse_update_chip_version(struct ieee80211_hw *hw)
 	switch (chipvalue) {
 	case 0xAA55:
 		chipver |= CHIP_92D_C_CUT;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "C-CUT!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "C-CUT!!!\n");
 		break;
 	case 0x9966:
 		chipver |= CHIP_92D_D_CUT;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "D-CUT!!!\n");
 		break;
 	case 0xCC33:
 		chipver |= CHIP_92D_E_CUT;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "E-CUT!!!\n");
 		break;
 	default:
 		chipver |= CHIP_92D_D_CUT;
@@ -1737,7 +1737,7 @@ static void _rtl92de_read_adapter_info(struct ieee80211_hw *hw)
 	}
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_ETHER_ADDR,
 				      rtlefuse->dev_addr);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
 	_rtl92de_read_txpower_info(hw, rtlefuse->autoload_failflag, hwinfo);
 
 	/* Read Channel Plan */
@@ -1771,14 +1771,14 @@ void rtl92de_read_eeprom_info(struct ieee80211_hw *hw)
 	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
 	rtlefuse->autoload_status = tmp_u1b;
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
 		_rtl92de_read_adapter_info(hw);
@@ -1866,8 +1866,8 @@ static void rtl92de_update_hal_rate_table(struct ieee80211_hw *hw,
 		    (shortgi_rate << 4) | (shortgi_rate);
 	}
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
-		 rtl_read_dword(rtlpriv, REG_ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+		rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
 static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
@@ -1998,9 +1998,9 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
 
 	value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
 	value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "ratr_bitmap :%x value0:%x value1:%x\n",
-		 ratr_bitmap, value[0], value[1]);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"ratr_bitmap :%x value0:%x value1:%x\n",
+		ratr_bitmap, value[0], value[1]);
 	rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *) value);
 	if (macid != 0)
 		sta_entry->ratr_index = ratr_index;
@@ -2059,14 +2059,14 @@ bool rtl92de_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	u1tmp = rtl_read_byte(rtlpriv, REG_GPIO_IO_SEL);
 	e_rfpowerstate_toset = (u1tmp & BIT(3)) ? ERFON : ERFOFF;
 	if (ppsc->hwradiooff && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio ON, RF ON\n");
 		e_rfpowerstate_toset = ERFON;
 		ppsc->hwradiooff = false;
 		actuallyset = true;
 	} else if (!ppsc->hwradiooff && (e_rfpowerstate_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "GPIOChangeRF  - HW Radio OFF, RF OFF\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"GPIOChangeRF  - HW Radio OFF, RF OFF\n");
 		e_rfpowerstate_toset = ERFOFF;
 		ppsc->hwradiooff = true;
 		actuallyset = true;
@@ -2110,7 +2110,7 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 idx;
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
 			rtl_cam_empty_entry(hw, cam_offset + idx);
@@ -2164,38 +2164,38 @@ void rtl92de_set_key(struct ieee80211_hw *hw, u32 key_index,
 			}
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
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "The insert KEY length is %d\n",
-				 rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "The insert KEY is %x %x\n",
-				 rtlpriv->sec.key_buf[0][0],
-				 rtlpriv->sec.key_buf[0][1]);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "add one entry\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"The insert KEY length is %d\n",
+				rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"The insert KEY is %x %x\n",
+				rtlpriv->sec.key_buf[0][0],
+				rtlpriv->sec.key_buf[0][1]);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"add one entry\n");
 			if (is_pairwise) {
 				RT_PRINT_DATA(rtlpriv, COMP_SEC, DBG_LOUD,
 					      "Pairwise Key content",
 					      rtlpriv->sec.pairwise_key,
 					      rtlpriv->
 					      sec.key_len[PAIRWISE_KEYIDX]);
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set Pairwise key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set Pairwise key\n");
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
 						      entry_id, enc_algo,
 						      CAM_CONFIG_NO_USEDK,
 						      rtlpriv->
 						      sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set group key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set group key\n");
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 					rtl_cam_add_one_entry(hw,
 						rtlefuse->dev_addr,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
index 2b76a025deb8..93d1c6a610c3 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/led.c
@@ -19,8 +19,8 @@ void rtl92de_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -56,8 +56,8 @@ void rtl92de_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
@@ -128,7 +128,7 @@ void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n", ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d,\n", ledaction);
 
 	_rtl92ce_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
index 4b672199c81d..87804325928a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/phy.c
@@ -178,8 +178,8 @@ u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
-		 regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
+		regaddr, bitmask);
 	if (rtlhal->during_mac1init_radioa || rtlhal->during_mac0init_radiob) {
 		u8 dbi_direct = 0;
 
@@ -196,9 +196,9 @@ u32 rtl92d_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	}
 	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
-		 bitmask, regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+		bitmask, regaddr, originalvalue);
 	return returnvalue;
 }
 
@@ -210,9 +210,9 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 	u8 dbi_direct = 0;
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 	if (rtlhal->during_mac1init_radioa)
 		dbi_direct = BIT(3);
 	else if (rtlhal->during_mac0init_radiob)
@@ -233,9 +233,9 @@ void rtl92d_phy_set_bb_reg(struct ieee80211_hw *hw,
 		rtl92de_write_dword_dbi(hw, (u16) regaddr, data, dbi_direct);
 	else
 		rtl_write_dword(rtlpriv, regaddr, data);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		 regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 }
 
 static u32 _rtl92d_phy_rf_serial_read(struct ieee80211_hw *hw,
@@ -279,8 +279,8 @@ static u32 _rtl92d_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 			BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x] = 0x%x\n",
-		 rfpath, pphyreg->rf_rb, retvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x] = 0x%x\n",
+		rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
 }
 
@@ -298,8 +298,8 @@ static void _rtl92d_phy_rf_serial_write(struct ieee80211_hw *hw,
 	/* T65 RF */
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
-		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
 u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
@@ -308,17 +308,17 @@ u32 rtl92d_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		 regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 	spin_lock(&rtlpriv->locks.rf_lock);
 	original_value = _rtl92d_phy_rf_serial_read(hw, rfpath, regaddr);
 	bitshift = _rtl92d_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
 	spin_unlock(&rtlpriv->locks.rf_lock);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		 regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 	return readback_value;
 }
 
@@ -329,9 +329,9 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 	if (bitmask == 0)
 		return;
 	spin_lock(&rtlpriv->locks.rf_lock);
@@ -346,9 +346,9 @@ void rtl92d_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 		_rtl92d_phy_rf_serial_write(hw, rfpath, regaddr, data);
 	}
 	spin_unlock(&rtlpriv->locks.rf_lock);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 }
 
 bool rtl92d_phy_mac_config(struct ieee80211_hw *hw)
@@ -358,10 +358,10 @@ bool rtl92d_phy_mac_config(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
 	arraylength = MAC_2T_ARRAYLENGTH;
 	ptrarray = rtl8192de_mac_2tarray;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Img:Rtl819XMAC_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Img:Rtl819XMAC_Array\n");
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8) ptrarray[i + 1]);
 	if (rtlpriv->rtlhal.macphymode == SINGLEMAC_SINGLEPHY) {
@@ -519,36 +519,36 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 	if (rtlhal->interfaceindex == 0) {
 		agctab_arraylen = AGCTAB_ARRAYLENGTH;
 		agctab_array_table = rtl8192de_agctab_array;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 " ===> phy:MAC0, Rtl819XAGCTAB_Array\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			" ===> phy:MAC0, Rtl819XAGCTAB_Array\n");
 	} else {
 		if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 			agctab_arraylen = AGCTAB_2G_ARRAYLENGTH;
 			agctab_array_table = rtl8192de_agctab_2garray;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 " ===> phy:MAC1, Rtl819XAGCTAB_2GArray\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				" ===> phy:MAC1, Rtl819XAGCTAB_2GArray\n");
 		} else {
 			agctab_5garraylen = AGCTAB_5G_ARRAYLENGTH;
 			agctab_5garray_table = rtl8192de_agctab_5garray;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 " ===> phy:MAC1, Rtl819XAGCTAB_5GArray\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				" ===> phy:MAC1, Rtl819XAGCTAB_5GArray\n");
 
 		}
 	}
 	phy_reg_arraylen = PHY_REG_2T_ARRAYLENGTH;
 	phy_regarray_table = rtl8192de_phy_reg_2tarray;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 " ===> phy:Rtl819XPHY_REG_Array_PG\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		" ===> phy:Rtl819XPHY_REG_Array_PG\n");
 	if (configtype == BASEBAND_CONFIG_PHY_REG) {
 		for (i = 0; i < phy_reg_arraylen; i = i + 2) {
 			rtl_addr_delay(phy_regarray_table[i]);
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
 		if (rtlhal->interfaceindex == 0) {
@@ -559,13 +559,13 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 				/* Add 1us delay between BB/RF register
 				 * setting. */
 				udelay(1);
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-					 "The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
-					 agctab_array_table[i],
-					 agctab_array_table[i + 1]);
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+					"The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
+					agctab_array_table[i],
+					agctab_array_table[i + 1]);
 			}
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Normal Chip, MAC0, load Rtl819XAGCTAB_Array\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Normal Chip, MAC0, load Rtl819XAGCTAB_Array\n");
 		} else {
 			if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 				for (i = 0; i < agctab_arraylen; i = i + 2) {
@@ -575,13 +575,13 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 					/* Add 1us delay between BB/RF register
 					 * setting. */
 					udelay(1);
-					RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-						 "The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
-						 agctab_array_table[i],
-						 agctab_array_table[i + 1]);
+					rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+						"The Rtl819XAGCTAB_Array_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
+						agctab_array_table[i],
+						agctab_array_table[i + 1]);
 				}
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "Load Rtl819XAGCTAB_2GArray\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Load Rtl819XAGCTAB_2GArray\n");
 			} else {
 				for (i = 0; i < agctab_5garraylen; i = i + 2) {
 					rtl_set_bbreg(hw,
@@ -591,13 +591,13 @@ static bool _rtl92d_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 					/* Add 1us delay between BB/RF registeri
 					 * setting. */
 					udelay(1);
-					RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-						 "The Rtl819XAGCTAB_5GArray_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
-						 agctab_5garray_table[i],
-						 agctab_5garray_table[i + 1]);
+					rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+						"The Rtl819XAGCTAB_5GArray_Table[0] is %u Rtl819XPHY_REGArray[1] is %u\n",
+						agctab_5garray_table[i],
+						agctab_5garray_table[i + 1]);
 				}
-				RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-					 "Load Rtl819XAGCTAB_5GArray\n");
+				rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+					"Load Rtl819XAGCTAB_5GArray\n");
 			}
 		}
 	}
@@ -648,10 +648,10 @@ static void _rtl92d_store_pwrindex_diffrate_offset(struct ieee80211_hw *hw,
 		return;
 
 	rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index] = data;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "MCSTxPowerLevelOriginalOffset[%d][%d] = 0x%x\n",
-		 rtlphy->pwrgroup_cnt, index,
-		 rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"MCSTxPowerLevelOriginalOffset[%d][%d] = 0x%x\n",
+		rtlphy->pwrgroup_cnt, index,
+		rtlphy->mcs_offset[rtlphy->pwrgroup_cnt][index]);
 	if (index == 13)
 		rtlphy->pwrgroup_cnt++;
 }
@@ -675,8 +675,8 @@ static bool _rtl92d_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
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
@@ -688,7 +688,7 @@ static bool _rtl92d_phy_bb_config(struct ieee80211_hw *hw)
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	bool rtstatus = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "==>\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "==>\n");
 	rtstatus = _rtl92d_phy_config_bb_with_headerfile(hw,
 		BASEBAND_CONFIG_PHY_REG);
 	if (!rtstatus) {
@@ -698,7 +698,7 @@ static bool _rtl92d_phy_bb_config(struct ieee80211_hw *hw)
 
 	/* if (rtlphy->rf_type == RF_1T2R) {
 	 *      _rtl92c_phy_bb_config_1t(hw);
-	 *     RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
+	 *     rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Config to 1T!!\n");
 	 *} */
 
 	if (rtlefuse->autoload_failflag == false) {
@@ -777,18 +777,18 @@ bool rtl92d_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 		radiob_arraylen = RADIOB_2T_INT_PA_ARRAYLENGTH;
 		radiob_array_table = rtl8192de_radiob_2t_int_paarray;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "PHY_ConfigRFWithHeaderFile() Radio_A:Rtl819XRadioA_1TArray\n");
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "PHY_ConfigRFWithHeaderFile() Radio_B:Rtl819XRadioB_1TArray\n");
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PHY_ConfigRFWithHeaderFile() Radio_A:Rtl819XRadioA_1TArray\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"PHY_ConfigRFWithHeaderFile() Radio_B:Rtl819XRadioB_1TArray\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
 
 	/* this only happens when DMDP, mac0 start on 2.4G,
 	 * mac1 start on 5G, mac 0 has to set phy0&phy1
 	 * pathA or mac1 has to set phy0&phy1 pathA */
 	if ((content == radiob_txt) && (rfpath == RF90_PATH_A)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 " ===> althougth Path A, we load radiob.txt\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			" ===> althougth Path A, we load radiob.txt\n");
 		radioa_arraylen = radiob_arraylen;
 		radioa_array_table = radiob_array_table;
 	}
@@ -828,19 +828,19 @@ void rtl92d_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	    (u8) rtl_get_bbreg(hw, ROFDM0_XCAGCCORE1, MASKBYTE0);
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
 
 static void _rtl92d_get_txpower_index(struct ieee80211_hw *hw, u8 channel,
@@ -938,14 +938,14 @@ void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if (rtlphy->set_bwmode_inprogress)
 		return;
 	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "FALSE driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"FALSE driver sleep or unload\n");
 		return;
 	}
 	rtlphy->set_bwmode_inprogress = true;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
-		 rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
-		 "20MHz" : "40MHz");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
+		rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
+		"20MHz" : "40MHz");
 	reg_bw_opmode = rtl_read_byte(rtlpriv, REG_BWOPMODE);
 	reg_prsr_rsc = rtl_read_byte(rtlpriv, REG_RRSR + 2);
 	switch (rtlphy->current_chan_bw) {
@@ -1001,7 +1001,7 @@ void rtl92d_phy_set_bw_mode(struct ieee80211_hw *hw,
 	}
 	rtl92d_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 }
 
 static void _rtl92d_phy_stop_trx_before_changeband(struct ieee80211_hw *hw)
@@ -1018,7 +1018,7 @@ static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	u8 value8;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
 	rtlhal->bandset = band;
 	rtlhal->current_bandtype = band;
 	if (IS_92D_SINGLEPHY(rtlhal->version))
@@ -1028,13 +1028,13 @@ static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 	/* reconfig BB/RF according to wireless mode */
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		/* BB & RF Config */
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "====>2.4G\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "====>2.4G\n");
 		if (rtlhal->interfaceindex == 1)
 			_rtl92d_phy_config_bb_with_headerfile(hw,
 				BASEBAND_CONFIG_AGC_TAB);
 	} else {
 		/* 5G band */
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "====>5G\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_DMESG, "====>5G\n");
 		if (rtlhal->interfaceindex == 1)
 			_rtl92d_phy_config_bb_with_headerfile(hw,
 				BASEBAND_CONFIG_AGC_TAB);
@@ -1062,7 +1062,7 @@ static void rtl92d_phy_switch_wirelessband(struct ieee80211_hw *hw, u8 band)
 			0 ? REG_MAC0 : REG_MAC1), value8);
 	}
 	mdelay(1);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<==Switch Band OK\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<==Switch Band OK\n");
 }
 
 static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
@@ -1074,9 +1074,9 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 	u8 group, i;
 	unsigned long flag = 0;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>path %d\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>path %d\n", rfpath);
 	if (rtlpriv->rtlhal.current_bandtype == BAND_ON_5G) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
 		rtl_set_bbreg(hw, RFPGA0_RFMOD, BIT(25) | BIT(24), 0);
 		rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4, 0x00f00000, 0xf);
 		/* fc area 0xd2c */
@@ -1097,14 +1097,14 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 		rtl_set_bbreg(hw, RFPGA0_RFMOD, BOFDMEN, 1);
 	} else {
 		/* G band. */
-		RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-			 "Load RF IMR parameters for G band. IMR already setting %d\n",
-			 rtlpriv->rtlhal.load_imrandiqk_setting_for2g);
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
+		rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+			"Load RF IMR parameters for G band. IMR already setting %d\n",
+			rtlpriv->rtlhal.load_imrandiqk_setting_for2g);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
 		if (!rtlpriv->rtlhal.load_imrandiqk_setting_for2g) {
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-				 "Load RF IMR parameters for G band. %d\n",
-				 rfpath);
+			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+				"Load RF IMR parameters for G band. %d\n",
+				rfpath);
 			rtl92d_acquire_cckandrw_pagea_ctl(hw, &flag);
 			rtl_set_bbreg(hw, RFPGA0_RFMOD, BIT(25) | BIT(24), 0);
 			rtl_set_bbreg(hw, RFPGA0_ANALOGPARAMETER4,
@@ -1122,7 +1122,7 @@ static void _rtl92d_phy_reload_imr_setting(struct ieee80211_hw *hw,
 			rtl92d_release_cckandrw_pagea_ctl(hw, &flag);
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
@@ -1132,7 +1132,7 @@ static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
 	/*----Store original RFENV control type----*/
 	switch (rfpath) {
 	case RF90_PATH_A:
@@ -1158,7 +1158,7 @@ static void _rtl92d_phy_enable_rf_env(struct ieee80211_hw *hw,
 	/*Set 0 to 12 bits for 8255 */
 	rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
 	udelay(1);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
 }
 
 static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
@@ -1168,7 +1168,7 @@ static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	struct bb_reg_def *pphyreg = &rtlphy->phyreg_def[rfpath];
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "=====>\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "=====>\n");
 	/*----Restore RFENV control type----*/
 	switch (rfpath) {
 	case RF90_PATH_A:
@@ -1181,7 +1181,7 @@ static void _rtl92d_phy_restore_rf_env(struct ieee80211_hw *hw, u8 rfpath,
 			      *pu4_regval);
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<=====\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<=====\n");
 }
 
 static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
@@ -1195,10 +1195,10 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 	bool need_pwr_down = false, internal_pa = false;
 	u32 u4regvalue, mask = 0x1C000, value = 0, u4tmp, u4tmp2;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>\n");
 	/* config path A for 5G */
 	if (rtlhal->current_bandtype == BAND_ON_5G) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>5G\n");
 		u4tmp = curveindex_5g[channel - 1];
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"ver 1 set RF-A, 5G, 0x28 = 0x%x !!\n", u4tmp);
@@ -1246,14 +1246,14 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 					      RFREG_OFFSET_MASK,
 					      rf_reg_pram_c_5g[index][i]);
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-				 "offset 0x%x value 0x%x path %d index %d readback 0x%x\n",
-				 rf_reg_for_c_cut_5g[i],
-				 rf_reg_pram_c_5g[index][i],
-				 path, index,
-				 rtl_get_rfreg(hw, (enum radio_path)path,
-					       rf_reg_for_c_cut_5g[i],
-					       RFREG_OFFSET_MASK));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+				"offset 0x%x value 0x%x path %d index %d readback 0x%x\n",
+				rf_reg_for_c_cut_5g[i],
+				rf_reg_pram_c_5g[index][i],
+				path, index,
+				rtl_get_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_5g[i],
+					      RFREG_OFFSET_MASK));
 		}
 		if (need_pwr_down)
 			_rtl92d_phy_restore_rf_env(hw, path, &u4regvalue);
@@ -1285,11 +1285,11 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 						rf_for_c_cut_5g_internal_pa[i],
 						RFREG_OFFSET_MASK,
 						rf_pram_c_5g_int_pa[index][i]);
-					RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-						 "offset 0x%x value 0x%x path %d index %d\n",
-						 rf_for_c_cut_5g_internal_pa[i],
-						 rf_pram_c_5g_int_pa[index][i],
-						 rfpath, index);
+					rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+						"offset 0x%x value 0x%x path %d index %d\n",
+						rf_for_c_cut_5g_internal_pa[i],
+						rf_pram_c_5g_int_pa[index][i],
+						rfpath, index);
 				}
 			} else {
 				rtl_set_rfreg(hw, (enum radio_path)rfpath, 0x0B,
@@ -1297,7 +1297,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 			}
 		}
 	} else if (rtlhal->current_bandtype == BAND_ON_2_4G) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "====>2.4G\n");
 		u4tmp = curveindex_2g[channel - 1];
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n", u4tmp);
@@ -1333,14 +1333,14 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 					      RFREG_OFFSET_MASK,
 					      rf_reg_param_for_c_cut_2g
 					      [index][i]);
-			RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-				 "offset 0x%x value 0x%x mak 0x%x path %d index %d readback 0x%x\n",
-				 rf_reg_for_c_cut_2g[i],
-				 rf_reg_param_for_c_cut_2g[index][i],
-				 rf_reg_mask_for_c_cut_2g[i], path, index,
-				 rtl_get_rfreg(hw, (enum radio_path)path,
-					       rf_reg_for_c_cut_2g[i],
-					       RFREG_OFFSET_MASK));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+				"offset 0x%x value 0x%x mak 0x%x path %d index %d readback 0x%x\n",
+				rf_reg_for_c_cut_2g[i],
+				rf_reg_param_for_c_cut_2g[index][i],
+				rf_reg_mask_for_c_cut_2g[i], path, index,
+				rtl_get_rfreg(hw, (enum radio_path)path,
+					      rf_reg_for_c_cut_2g[i],
+					      RFREG_OFFSET_MASK));
 		}
 		RTPRINT(rtlpriv, FINIT, INIT_IQK,
 			"cosa ver 3 set RF-B, 2G, 0x28 = 0x%x !!\n",
@@ -1354,7 +1354,7 @@ static void _rtl92d_phy_switch_rf_setting(struct ieee80211_hw *hw, u8 channel)
 		if (rtlhal->during_mac0init_radiob)
 			rtl92d_phy_powerdown_anotherphy(hw, true);
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 u8 rtl92d_get_rightchnlplace_for_iqk(u8 chnl)
@@ -2358,8 +2358,8 @@ void rtl92d_phy_iq_calibrate(struct ieee80211_hw *hw)
 		rtlphy->iqk_matrix[indexforchannel].iqk_done =
 			true;
 
-		RT_TRACE(rtlpriv, COMP_SCAN | COMP_MLME, DBG_LOUD,
-			 "IQK OK indexforchannel %d\n", indexforchannel);
+		rtl_dbg(rtlpriv, COMP_SCAN | COMP_MLME, DBG_LOUD,
+			"IQK OK indexforchannel %d\n", indexforchannel);
 	}
 }
 
@@ -2370,26 +2370,26 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 	struct rtl_hal *rtlhal = &(rtlpriv->rtlhal);
 	u8 indexforchannel;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "channel %d\n", channel);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "channel %d\n", channel);
 	/*------Do IQK for normal chip and test chip 5G band------- */
 	indexforchannel = rtl92d_get_rightchnlplace_for_iqk(channel);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "indexforchannel %d done %d\n",
-		 indexforchannel,
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "indexforchannel %d done %d\n",
+		indexforchannel,
 		 rtlphy->iqk_matrix[indexforchannel].iqk_done);
 	if (0 && !rtlphy->iqk_matrix[indexforchannel].iqk_done &&
 		rtlphy->need_iqk) {
 		/* Re Do IQK. */
-		RT_TRACE(rtlpriv, COMP_SCAN | COMP_INIT, DBG_LOUD,
-			 "Do IQK Matrix reg for channel:%d....\n", channel);
+		rtl_dbg(rtlpriv, COMP_SCAN | COMP_INIT, DBG_LOUD,
+			"Do IQK Matrix reg for channel:%d....\n", channel);
 		rtl92d_phy_iq_calibrate(hw);
 	} else {
 		/* Just load the value. */
 		/* 2G band just load once. */
 		if (((!rtlhal->load_imrandiqk_setting_for2g) &&
 		    indexforchannel == 0) || indexforchannel > 0) {
-			RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD,
-				 "Just Read IQK Matrix reg for channel:%d....\n",
-				 channel);
+			rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD,
+				"Just Read IQK Matrix reg for channel:%d....\n",
+				channel);
 			if ((rtlphy->iqk_matrix[indexforchannel].
 			     value[0] != NULL)
 				/*&&(regea4 != 0) */)
@@ -2413,7 +2413,7 @@ void rtl92d_phy_reload_iqk_setting(struct ieee80211_hw *hw, u8 channel)
 		}
 	}
 	rtlphy->need_iqk = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 static u32 _rtl92d_phy_get_abs(u32 val1, u32 val2)
@@ -2477,7 +2477,7 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 	u32 u4tmp = 0, u4regvalue = 0;
 	bool bneed_powerdown_radio = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "path %d\n", erfpath);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "path %d\n", erfpath);
 	RTPRINT(rtlpriv, FINIT, INIT_IQK, "band type = %d\n",
 		rtlpriv->rtlhal.current_bandtype);
 	RTPRINT(rtlpriv, FINIT, INIT_IQK,  "channel = %d\n", channel);
@@ -2522,7 +2522,7 @@ static void _rtl92d_phy_reload_lck_setting(struct ieee80211_hw *hw,
 		if (rtlpriv->rtlhal.during_mac0init_radiob)
 			rtl92d_phy_powerdown_anotherphy(hw, true);
 	}
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "<====\n");
 }
 
 static void _rtl92d_phy_lc_calibrate_sw(struct ieee80211_hw *hw, bool is2t)
@@ -2695,11 +2695,11 @@ void rtl92d_phy_reset_iqk_result(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u8 i;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "settings regs %d default regs %d\n",
-		 (int)(sizeof(rtlphy->iqk_matrix) /
-		       sizeof(struct iqk_matrix_regs)),
-		 IQK_MATRIX_REG_NUM);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"settings regs %d default regs %d\n",
+		(int)(sizeof(rtlphy->iqk_matrix) /
+		      sizeof(struct iqk_matrix_regs)),
+		IQK_MATRIX_REG_NUM);
 	/* 0xe94, 0xe9c, 0xea4, 0xeac, 0xeb4, 0xebc, 0xec4, 0xecc */
 	for (i = 0; i < IQK_MATRIX_SETTINGS_NUM; i++) {
 		rtlphy->iqk_matrix[i].value[0][0] = 0x100;
@@ -2844,8 +2844,8 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 		return 0;
 
 	if ((is_hal_stop(rtlhal)) || (RT_CANNOT_IO(hw))) {
-		RT_TRACE(rtlpriv, COMP_CHAN, DBG_LOUD,
-			 "sw_chnl_inprogress false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_CHAN, DBG_LOUD,
+			"sw_chnl_inprogress false driver sleep or unload\n");
 		return 0;
 	}
 	while (rtlphy->lck_inprogress && timecount < timeout) {
@@ -2886,8 +2886,8 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 		channel = 1;
 	rtlphy->sw_chnl_stage = 0;
 	rtlphy->sw_chnl_step = 0;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 
 	do {
 		if (!rtlphy->sw_chnl_inprogress)
@@ -2904,7 +2904,7 @@ u8 rtl92d_phy_sw_chnl(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 	rtlphy->sw_chnl_inprogress = false;
 	return 1;
 }
@@ -2915,9 +2915,9 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
 	struct dig_t *de_digtable = &rtlpriv->dm_digtable;
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
-		 rtlphy->current_io_type, rtlphy->set_io_inprogress);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"--->Cmd(%#x), set_io_inprogress(%d)\n",
+		rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
 	case IO_CMD_RESUME_DM_BY_SCAN:
 		de_digtable->cur_igvalue = rtlphy->initgain_backup.xaagccore1;
@@ -2935,8 +2935,8 @@ static void rtl92d_phy_set_io(struct ieee80211_hw *hw)
 		break;
 	}
 	rtlphy->set_io_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "<---(%#x)\n",
-		 rtlphy->current_io_type);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "<---(%#x)\n",
+		rtlphy->current_io_type);
 }
 
 bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
@@ -2945,19 +2945,19 @@ bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	bool postprocessing = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "-->IO Cmd(%#x), set_io_inprogress(%d)\n",
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"-->IO Cmd(%#x), set_io_inprogress(%d)\n",
 		 iotype, rtlphy->set_io_inprogress);
 	do {
 		switch (iotype) {
 		case IO_CMD_RESUME_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-				 "[IO CMD] Resume DM after scan\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Resume DM after scan\n");
 			postprocessing = true;
 			break;
 		case IO_CMD_PAUSE_DM_BY_SCAN:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-				 "[IO CMD] Pause DM before scan\n");
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+				"[IO CMD] Pause DM before scan\n");
 			postprocessing = true;
 			break;
 		default:
@@ -2973,7 +2973,7 @@ bool rtl92d_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl92d_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "<--IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "<--IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -3030,8 +3030,8 @@ static void _rtl92d_phy_set_rfsleep(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "Fail !!! Switch RF timeout\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Fail !!! Switch RF timeout\n");
 		return;
 	}
 	/* e.   For PCIE: SYS_FUNC_EN 0x02[7:0] = 0xE2 reset BB TRX function */
@@ -3065,18 +3065,18 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 			u32 initializecount = 0;
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
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-				 "awake, sleeped:%d ms state_inap:%x\n",
-				 jiffies_to_msecs(jiffies -
-						  ppsc->last_sleep_jiffies),
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+				"awake, slept:%d ms state_inap:%x\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies),
 				 rtlpriv->psc.state_inap);
 			ppsc->last_awake_jiffies = jiffies;
 			_rtl92d_phy_set_rfon(hw);
@@ -3091,8 +3091,8 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
@@ -3116,35 +3116,35 @@ bool rtl92d_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
 			} else if (rtlpci->pdev->current_state != PCI_D0) {
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] !=0 but lower power state!\n",
-					 i + 1, queue_id);
+				rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+					"eRf Off/Sleep: %d times TcbBusyQueue[%d] !=0 but lower power state!\n",
+					i + 1, queue_id);
 				break;
 			} else {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
-					 i + 1, queue_id,
-					 skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
+					i + 1, queue_id,
+					skb_queue_len(&ring->queue));
 				udelay(10);
 				i++;
 			}
 
 			if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
-					 MAX_DOZE_WAITING_TIMES_9x, queue_id,
-					 skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
+					MAX_DOZE_WAITING_TIMES_9x, queue_id,
+					skb_queue_len(&ring->queue));
 				break;
 			}
 		}
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "Set rfsleep awaked:%d ms\n",
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"Set rfsleep awakened:%d ms\n",
 			 jiffies_to_msecs(jiffies - ppsc->last_awake_jiffies));
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-			 "sleep awaked:%d ms state_inap:%x\n",
-			 jiffies_to_msecs(jiffies -
-					  ppsc->last_awake_jiffies),
-			 rtlpriv->psc.state_inap);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+			"sleep awakened:%d ms state_inap:%x\n",
+			jiffies_to_msecs(jiffies -
+					 ppsc->last_awake_jiffies),
+			rtlpriv->psc.state_inap);
 		ppsc->last_sleep_jiffies = jiffies;
 		_rtl92d_phy_set_rfsleep(hw);
 		break;
@@ -3167,18 +3167,18 @@ void rtl92d_phy_config_macphymode(struct ieee80211_hw *hw)
 
 	switch (rtlhal->macphymode) {
 	case DUALMAC_DUALPHY:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "MacPhyMode: DUALMAC_DUALPHY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode: DUALMAC_DUALPHY\n");
 		rtl_write_byte(rtlpriv, offset, 0xF3);
 		break;
 	case SINGLEMAC_SINGLEPHY:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "MacPhyMode: SINGLEMAC_SINGLEPHY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode: SINGLEMAC_SINGLEPHY\n");
 		rtl_write_byte(rtlpriv, offset, 0xF4);
 		break;
 	case DUALMAC_SINGLEPHY:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "MacPhyMode: DUALMAC_SINGLEPHY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"MacPhyMode: DUALMAC_SINGLEPHY\n");
 		rtl_write_byte(rtlpriv, offset, 0xF1);
 		break;
 	}
@@ -3346,7 +3346,7 @@ void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 	u8 rfpath, i;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "==>\n");
 	/* r_select_5G for path_A/B 0 for 2.4G, 1 for 5G */
 	if (rtlhal->current_bandtype == BAND_ON_2_4G) {
 		/* r_select_5G for path_A/B,0x878 */
@@ -3494,8 +3494,8 @@ void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 				      BIT(13), 0x3);
 		} else {
 			rtl92d_phy_enable_anotherphy(hw, false);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "MAC1 use DBI to update 0x888\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"MAC1 use DBI to update 0x888\n");
 			/* 0x888 */
 			rtl92de_write_dword_dbi(hw, RFPGA0_ADDALLOCKEN,
 						rtl92de_read_dword_dbi(hw,
@@ -3520,9 +3520,9 @@ void rtl92d_update_bbrf_configuration(struct ieee80211_hw *hw)
 			RFREG_OFFSET_MASK);
 	}
 	for (i = 0; i < 2; i++)
-		RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "RF 0x18 = 0x%x\n",
-			 rtlphy->rfreg_chnlval[i]);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "<==\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "RF 0x18 = 0x%x\n",
+			rtlphy->rfreg_chnlval[i]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "<==\n");
 
 }
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
index 915a36f7af5e..83787fd293de 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rf.c
@@ -23,9 +23,9 @@ void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth)
 			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) |
 				      BIT(11), 0x01);
 
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "20M RF 0x18 = 0x%x\n",
-				 rtlphy->rfreg_chnlval[rfpath]);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"20M RF 0x18 = 0x%x\n",
+				rtlphy->rfreg_chnlval[rfpath]);
 		}
 
 		break;
@@ -35,9 +35,9 @@ void rtl92d_phy_rf6052_set_bandwidth(struct ieee80211_hw *hw, u8 bandwidth)
 			    ((rtlphy->rfreg_chnlval[rfpath] & 0xfffff3ff));
 			rtl_set_rfreg(hw, rfpath, RF_CHNLBW, BIT(10) | BIT(11),
 				      0x00);
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "40M RF 0x18 = 0x%x\n",
-				 rtlphy->rfreg_chnlval[rfpath]);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"40M RF 0x18 = 0x%x\n",
+				rtlphy->rfreg_chnlval[rfpath]);
 		}
 		break;
 	default:
@@ -391,11 +391,11 @@ bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 
 	rtlhal->during_mac0init_radiob = false;
 	rtlhal->during_mac1init_radioa = false;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "===>\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "===>\n");
 	/* MAC0 Need PHY1 load radio_b.txt . Driver use DBI to write. */
 	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
 	if (!(u1btmp & mac_on_bit)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "enable BB & RF\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "enable BB & RF\n");
 		/* Enable BB and RF power */
 		rtl92de_write_dword_dbi(hw, REG_SYS_ISO_CTRL,
 			rtl92de_read_dword_dbi(hw, REG_SYS_ISO_CTRL, direct) |
@@ -405,7 +405,7 @@ bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 		 * and radio_b.txt has been load. */
 		bresult = false;
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<===\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<===\n");
 	return bresult;
 
 }
@@ -421,17 +421,17 @@ void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0)
 
 	rtlhal->during_mac0init_radiob = false;
 	rtlhal->during_mac1init_radioa = false;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
 	/* check MAC0 enable or not again now, if
 	 * enabled, not power down radio A. */
 	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
 	if (!(u1btmp & mac_on_bit)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "power down\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "power down\n");
 		/* power down RF radio A according to YuNan's advice. */
 		rtl92de_write_dword_dbi(hw, RFPGA0_XA_LSSIPARAMETER,
 					0x00000000, direct);
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
 }
 
 bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
@@ -573,8 +573,8 @@ bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
 			break;
 		}
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "Radio[%d] Fail!!\n", rfpath);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
 			goto phy_rf_cfg_fail;
 		}
 
@@ -588,7 +588,7 @@ bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
 		rtl92d_phy_powerdown_anotherphy(hw, false);
 	else if (need_pwrdown_radiob)
 		rtl92d_phy_powerdown_anotherphy(hw, true);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
 	return rtstatus;
 
 phy_rf_cfg_fail:
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index ab5b05ef168e..7fd546963bf2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -511,8 +511,8 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, sizeof(struct tx_desc_92d));
@@ -526,9 +526,9 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc, USB_HWDESC_HEADER_LEN +
 					   EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_LOUD,
-					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
-					 ptcb_desc->empkt_num);
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_LOUD,
+					"Insert 8 byte.pTcb->EMPktNum:%d\n",
+					ptcb_desc->empkt_num);
 				_rtl92de_insert_emcontent(ptcb_desc,
 							  (u8 *)(skb->data));
 			}
@@ -625,8 +625,8 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 		}
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Enable RDG function\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Enable RDG function\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
 			}
@@ -652,7 +652,7 @@ void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_pkt_id(pdesc, 8);
 	}
 	set_tx_desc_more_frag(pdesc, (lastseg ? 0 : 1));
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -671,8 +671,8 @@ void rtl92de_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le32 *pdesc = (__le32 *)pdesc8;
 
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

