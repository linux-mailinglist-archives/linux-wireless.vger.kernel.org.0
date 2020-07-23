Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA622B7FC
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgGWUnA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGWUm5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:57 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A666C0619DC
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:57 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id w17so6205666oie.6
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwXO4Tr5+TuDFBcMgBLB9ZSSbWJ600Swuky5Aqn1Xyo=;
        b=Ks0lJIwnvmxKnbGGkvVQ4T6FPx0Kb0n61WnvqxHd2ARORpRpYjv9ePFqe90pS+6E6Q
         +GmTkdLDH/qnXjjmzIT1idatrNLvxX1PUHS1neOET9rIhlkxW/+7PB7gUTZrzn3kgzjX
         CmntGhIcn+GgV9dL5R6m/mgIBoZaMnxrWDRzsW+LgOJFIR7VCLP+kp8d4zo0/BsOUjTk
         oTFSPGC3GP/Xz02FM5qDLVdeKxS8dfFQr/w+ZiOkMCCQ5ylRXdpvismCWj+hN856fdZz
         NoqjsZ6LRA/gc2QdXad/7UV03WDiwyUvbDzDFrfQl8/INNEiJIL+QlRKZ/nf+7FT8s/A
         h7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NwXO4Tr5+TuDFBcMgBLB9ZSSbWJ600Swuky5Aqn1Xyo=;
        b=E8Cc/8Xxs4rlP8ez8NLcXnAAuK/6b0SWxcXiPY3WnzCfsfDhiCqi71eMUXlfmi4gkB
         1+62dRsdSYi6BUkJIT7euVz4hi6Dt3TwiDLL0Qo4l5ryOLkrszgZasA4Ycm9q8BpWvre
         Oz7bR2Yie/itAamHKPEoJf6/MnqkCxskvlgZ371fqf19TrTAA3x3+jJWG0SquvKYLnuy
         FmJ73aexwOb2c+6nV3c0hqDcZmQzVMne3WxSK8R1D1NDEa4/Fx5U56zsrIVWzl7xeZFT
         KeFuiU68VCS1VGHU7qF/yVtyZLSBS4NoBCfZEmN3MG40l6GLUk9lAcq0kigxA53a5YGl
         Ooqw==
X-Gm-Message-State: AOAM5307UlgKAXI20HiUTd0mZLo9N7AP3SXXAcW4ui4CACmaR+O6S7b2
        RiecIe3A4dgUpD126A1c5Mo=
X-Google-Smtp-Source: ABdhPJzp6DoruxX3mWrow6i3vuWiTJXRlORB6/kuletWOFh7dMZmPIm1LbE8586UiVVIEWhh4Kx+dQ==
X-Received: by 2002:aca:2312:: with SMTP id e18mr5199131oie.135.1595536976297;
        Thu, 23 Jul 2020 13:42:56 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:55 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 09/15] rtlwifi: rtl8192ee: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:38 -0500
Message-Id: <20200723204244.24457-10-Larry.Finger@lwfinger.net>
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
rtl8192ee. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8192ee/dm.c   |  66 ++--
 .../wireless/realtek/rtlwifi/rtl8192ee/fw.c   | 102 ++---
 .../wireless/realtek/rtlwifi/rtl8192ee/hw.c   | 208 +++++-----
 .../wireless/realtek/rtlwifi/rtl8192ee/led.c  |  18 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/phy.c  | 358 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192ee/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192ee/trx.c  |  32 +-
 7 files changed, 395 insertions(+), 395 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
index 551aa86825ed..140f33089c4d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/dm.c
@@ -86,16 +86,16 @@ static void rtl92ee_dm_false_alarm_counter_statistics(struct ieee80211_hw *hw)
 	rtl_set_bbreg(hw, DM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 0);
 	rtl_set_bbreg(hw, DM_REG_CCK_FA_RST_11N, BIT(15) | BIT(14), 2);
 
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "cnt_parity_fail = %d, cnt_rate_illegal = %d, cnt_crc8_fail = %d, cnt_mcs_fail = %d\n",
-		  falsealm_cnt->cnt_parity_fail,
-		  falsealm_cnt->cnt_rate_illegal,
-		  falsealm_cnt->cnt_crc8_fail, falsealm_cnt->cnt_mcs_fail);
-
-	RT_TRACE(rtlpriv, COMP_DIG, DBG_TRACE,
-		 "cnt_ofdm_fail = %x, cnt_cck_fail = %x, cnt_all = %x\n",
-		  falsealm_cnt->cnt_ofdm_fail,
-		  falsealm_cnt->cnt_cck_fail, falsealm_cnt->cnt_all);
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
 
 static void rtl92ee_dm_cck_packet_detection_thresh(struct ieee80211_hw *hw)
@@ -174,7 +174,7 @@ static void rtl92ee_dm_dig(struct ieee80211_hw *hw)
 	} else {
 		dm_dig->rx_gain_max = dm_dig_max;
 		dig_min_0 = dm_dig_min;
-		RT_TRACE(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
+		rtl_dbg(rtlpriv, COMP_DIG, DBG_LOUD, "no link\n");
 	}
 
 	if (rtlpriv->falsealm_cnt.cnt_all > 10000) {
@@ -334,34 +334,34 @@ static void rtl92ee_dm_find_minimum_rssi(struct ieee80211_hw *hw)
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
 
 static void rtl92ee_dm_check_rssi_monitor(struct ieee80211_hw *hw)
@@ -687,8 +687,8 @@ static void rtl92ee_dm_dynamic_atc_switch(struct ieee80211_hw *hw)
 		if (rtlpriv->cfg->ops->get_btc_status()) {
 			if (!rtlpriv->btcoexist.btc_ops->
 			    btc_is_bt_disabled(rtlpriv)) {
-				RT_TRACE(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
-					 "odm_DynamicATCSwitch(): Disable CFO tracking for BT!!\n");
+				rtl_dbg(rtlpriv, COMP_BT_COEXIST, DBG_LOUD,
+					"odm_DynamicATCSwitch(): Disable CFO tracking for BT!!\n");
 				return;
 			}
 		}
@@ -842,8 +842,8 @@ static bool _rtl92ee_dm_ra_state_check(struct ieee80211_hw *hw,
 		low_rssithresh_for_ra += go_up_gap;
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-			 "wrong rssi level setting %d !\n", *ratr_state);
+		rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+			"wrong rssi level setting %d !\n", *ratr_state);
 		break;
 	}
 
@@ -872,14 +872,14 @@ static void rtl92ee_dm_refresh_rate_adaptive_mask(struct ieee80211_hw *hw)
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
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c
index 05462422d247..88b7a715f4c5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.c
@@ -36,7 +36,7 @@ static void _rtl92ee_write_fw(struct ieee80211_hw *hw,
 	u32 pagenums, remainsize;
 	u32 page, offset;
 
-	RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD , "FW size is %d bytes,\n", size);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "FW size is %d bytes,\n", size);
 
 	rtl_fill_dummy(bufferptr, &size);
 
@@ -118,21 +118,21 @@ int rtl92ee_download_fw(struct ieee80211_hw *hw, bool buse_wake_on_wlan_fw)
 	rtlhal->fw_subversion = pfwheader->subversion;
 	pfwdata = (u8 *)rtlhal->pfirmware;
 	fwsize = rtlhal->fwsize;
-	RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-		 "normal Firmware SIZE %d\n" , fwsize);
+	rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+		"normal Firmware SIZE %d\n", fwsize);
 
 	if (IS_FW_HEADER_EXIST(pfwheader)) {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Firmware Version(%d), Signature(%#x),Size(%d)\n",
-			  pfwheader->version, pfwheader->signature,
-			  (int)sizeof(struct rtlwifi_firmware_header));
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Firmware Version(%d), Signature(%#x),Size(%d)\n",
+			pfwheader->version, pfwheader->signature,
+			(int)sizeof(struct rtlwifi_firmware_header));
 
 		pfwdata = pfwdata + sizeof(struct rtlwifi_firmware_header);
 		fwsize = fwsize - sizeof(struct rtlwifi_firmware_header);
 	} else {
-		RT_TRACE(rtlpriv, COMP_FW, DBG_DMESG,
-			 "Firmware no Header, Signature(%#x)\n",
-			  pfwheader->signature);
+		rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+			"Firmware no Header, Signature(%#x)\n",
+			pfwheader->signature);
 	}
 
 	if (rtlhal->mac_func_enable) {
@@ -180,12 +180,12 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 
 	if (ppsc->dot11_psmode != EACTIVE ||
 	    ppsc->inactive_pwrstate == ERFOFF) {
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-			 "FillH2CCommand8192E(): Return because RF is off!!!\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"FillH2CCommand8192E(): Return because RF is off!!!\n");
 		return;
 	}
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD , "come in\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "come in\n");
 
 	/* 1. Prevent race condition in setting H2C cmd.
 	 * (copy from MgntActSet_RF_State().)
@@ -193,17 +193,17 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 	while (true) {
 		spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 		if (rtlhal->h2c_setinprogress) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-				 "H2C set in progress! Wait to set..element_id(%d).\n",
-				  element_id);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"H2C set in progress! Wait to set..element_id(%d).\n",
+				element_id);
 
 			while (rtlhal->h2c_setinprogress) {
 				spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock,
 						       flag);
 				h2c_waitcounter++;
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-					 "Wait 100 us (%d times)...\n",
-					  h2c_waitcounter);
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Wait 100 us (%d times)...\n",
+					h2c_waitcounter);
 				udelay(100);
 
 				if (h2c_waitcounter > 1000)
@@ -240,8 +240,8 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 			box_extreg = REG_HMEBOX_EXT_3;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", boxnum);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", boxnum);
 			break;
 		}
 
@@ -263,18 +263,18 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 			while (!isfw_read) {
 				wait_h2c_limmit--;
 				if (wait_h2c_limmit == 0) {
-					RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-						 "Waiting too long for FW read clear HMEBox(%d)!!!\n",
-						 boxnum);
+					rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+						"Waiting too long for FW read clear HMEBox(%d)!!!\n",
+						boxnum);
 					break;
 				}
 				udelay(10);
 				isfw_read =
 				  _rtl92ee_check_fw_read_last_h2c(hw, boxnum);
 				u1b_tmp = rtl_read_byte(rtlpriv, 0x130);
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-					 "Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
-					 boxnum, u1b_tmp);
+				rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+					"Waiting for FW read clear HMEBox(%d)!!! 0x130 = %2x\n",
+					boxnum, u1b_tmp);
 			}
 		}
 
@@ -282,18 +282,18 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 		 * H2C cmd, break and give up this H2C.
 		 */
 		if (!isfw_read) {
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-				 "Write H2C reg BOX[%d] fail,Fw don't read.\n",
-				 boxnum);
+			rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+				"Write H2C reg BOX[%d] fail,Fw don't read.\n",
+				boxnum);
 			break;
 		}
 		/* 4. Fill the H2C cmd into box */
 		memset(boxcontent, 0, sizeof(boxcontent));
 		memset(boxextcontent, 0, sizeof(boxextcontent));
 		boxcontent[0] = element_id;
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-			 "Write element_id box_reg(%4x) = %2x\n",
-			  box_reg, element_id);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"Write element_id box_reg(%4x) = %2x\n",
+			box_reg, element_id);
 
 		switch (cmd_len) {
 		case 1:
@@ -329,8 +329,8 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 			}
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-				 "switch case %#x not processed\n", cmd_len);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+				"switch case %#x not processed\n", cmd_len);
 			break;
 		}
 
@@ -340,16 +340,16 @@ static void _rtl92ee_fill_h2c_command(struct ieee80211_hw *hw, u8 element_id,
 		if (rtlhal->last_hmeboxnum == 4)
 			rtlhal->last_hmeboxnum = 0;
 
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD ,
-			 "pHalData->last_hmeboxnum  = %d\n",
-			  rtlhal->last_hmeboxnum);
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD,
+			"pHalData->last_hmeboxnum  = %d\n",
+			rtlhal->last_hmeboxnum);
 	}
 
 	spin_lock_irqsave(&rtlpriv->locks.h2c_lock, flag);
 	rtlhal->h2c_setinprogress = false;
 	spin_unlock_irqrestore(&rtlpriv->locks.h2c_lock, flag);
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD , "go out\n");
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_LOUD, "go out\n");
 }
 
 void rtl92ee_fill_h2c_cmd(struct ieee80211_hw *hw,
@@ -388,8 +388,8 @@ void rtl92ee_firmware_selfreset(struct ieee80211_hw *hw)
 	u1b_tmp = rtl_read_byte(rtlpriv, REG_SYS_FUNC_EN + 1);
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN + 1, (u1b_tmp | BIT(2)));
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD ,
-		 "  _8051Reset92E(): 8051 reset success .\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"  _8051Reset92E(): 8051 reset success .\n");
 }
 
 void rtl92ee_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
@@ -408,8 +408,8 @@ void rtl92ee_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	if (bt_ctrl_lps)
 		mode = (bt_lps_on ? FW_PS_MIN_MODE : FW_PS_ACTIVE_MODE);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG, "FW LPS mode = %d (coex:%d)\n",
-		 mode, bt_ctrl_lps);
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG, "FW LPS mode = %d (coex:%d)\n",
+		mode, bt_ctrl_lps);
 
 	switch (mode) {
 	case FW_PS_MIN_MODE:
@@ -750,15 +750,15 @@ void rtl92ee_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		b_dlok = true;
 
 	if (b_dlok) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD ,
-			 "Set RSVD page location to Fw.\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"Set RSVD page location to Fw.\n");
 		RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_LOUD ,
 			      "H2C_RSVDPAGE:\n", u1rsvdpageloc, 3);
 		rtl92ee_fill_h2c_cmd(hw, H2C_92E_RSVDPAGE,
 				     sizeof(u1rsvdpageloc), u1rsvdpageloc);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set RSVD page location to Fw FAIL!!!!!!.\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set RSVD page location to Fw FAIL!!!!!!.\n");
 	}
 }
 
@@ -783,11 +783,11 @@ void rtl92ee_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 
 	switch (p2p_ps_state) {
 	case P2P_PS_DISABLE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD , "P2P_PS_DISABLE\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_DISABLE\n");
 		memset(p2p_ps_offload, 0, sizeof(*p2p_ps_offload));
 		break;
 	case P2P_PS_ENABLE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD , "P2P_PS_ENABLE\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_ENABLE\n");
 		/* update CTWindow value. */
 		if (p2pinfo->ctwindow > 0) {
 			p2p_ps_offload->ctwindow_en = 1;
@@ -838,11 +838,11 @@ void rtl92ee_set_p2p_ps_offload_cmd(struct ieee80211_hw *hw, u8 p2p_ps_state)
 		}
 		break;
 	case P2P_PS_SCAN:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD , "P2P_PS_SCAN\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN\n");
 		p2p_ps_offload->discovery = 1;
 		break;
 	case P2P_PS_SCAN_DONE:
-		RT_TRACE(rtlpriv, COMP_FW, DBG_LOUD , "P2P_PS_SCAN_DONE\n");
+		rtl_dbg(rtlpriv, COMP_FW, DBG_LOUD, "P2P_PS_SCAN_DONE\n");
 		p2p_ps_offload->discovery = 0;
 		p2pinfo->p2p_ps_state = P2P_PS_ENABLE;
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
index 53011c2a44f5..473296e808ba 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/hw.c
@@ -119,9 +119,9 @@ static void _rtl92ee_set_fw_clock_on(struct ieee80211_hw *hw,
 			if (content & IMR_CPWM) {
 				rtl_write_word(rtlpriv, isr_regaddr, 0x0100);
 				rtlhal->fw_ps_state = FW_PS_STATE_RF_ON_92E;
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-					 "Receive CPWM INT!!! PSState = %X\n",
-					 rtlhal->fw_ps_state);
+				rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+					"Receive CPWM INT!!! PSState = %X\n",
+					rtlhal->fw_ps_state);
 			}
 		}
 
@@ -319,8 +319,8 @@ void rtl92ee_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HAL_DEF_WOWLAN:
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -390,8 +390,8 @@ static void _rtl92ee_download_rsvd_page(struct ieee80211_hw *hw)
 	} while (!(bcnvalid_reg & BIT(0)) && dlbcn_count < 5);
 
 	if (!(bcnvalid_reg & BIT(0)))
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Download RSVD page failed!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Download RSVD page failed!\n");
 
 	/* Enable Bcn */
 	_rtl92ee_set_bcn_ctrl_reg(hw, BIT(3), 0);
@@ -447,8 +447,8 @@ void rtl92ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 		u8 e_aci;
 
-		RT_TRACE(rtlpriv, COMP_MLME, DBG_TRACE,
-			 "HW_VAR_SLOT_TIME %x\n", val[0]);
+		rtl_dbg(rtlpriv, COMP_MLME, DBG_TRACE,
+			"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 		rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 
@@ -494,8 +494,8 @@ void rtl92ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					       (REG_AGGLEN_LMT + i),
 					       reg[i]);
 			}
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_AMPDU_FACTOR:%#x\n", fac);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_AMPDU_FACTOR:%#x\n", fac);
 		}
 		}
 		break;
@@ -528,9 +528,9 @@ void rtl92ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -545,16 +545,16 @@ void rtl92ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				acm_ctrl &= (~ACMHW_VOQEN);
 				break;
 			default:
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-					 "switch case %#x not processed\n",
-					 e_aci);
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+					"switch case %#x not processed\n",
+					e_aci);
 				break;
 			}
 		}
 
-		RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
-			 "SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
-			  acm_ctrl);
+		rtl_dbg(rtlpriv, COMP_QOS, DBG_TRACE,
+			"SetHwReg8190pci(): [HW_VAR_ACM_CTRL] Write 0x%X\n",
+			acm_ctrl);
 		rtl_write_byte(rtlpriv, REG_ACMHWCTRL, acm_ctrl);
 		}
 		break;
@@ -665,8 +665,8 @@ void rtl92ee_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 		}
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-			 "switch case %#x not processed\n", variable);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+			"switch case %#x not processed\n", variable);
 		break;
 	}
 }
@@ -771,8 +771,8 @@ static bool _rtl92ee_init_mac(struct ieee80211_hw *hw)
 	if (!rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK,
 				      PWR_INTF_PCI_MSK,
 				      RTL8192E_NIC_ENABLE_FLOW)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "init MAC Fail as rtl_hal_pwrseqcmdparsing\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"init MAC Fail as rtl_hal_pwrseqcmdparsing\n");
 		return false;
 	}
 
@@ -795,8 +795,8 @@ static bool _rtl92ee_init_mac(struct ieee80211_hw *hw)
 
 	if (!rtlhal->mac_func_enable) {
 		if (_rtl92ee_llt_table_init(hw) == false) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "LLT table init fail\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"LLT table init fail\n");
 			return false;
 		}
 	}
@@ -1107,14 +1107,14 @@ void rtl92ee_enable_hw_security_config(struct ieee80211_hw *hw)
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
 
@@ -1130,8 +1130,8 @@ void rtl92ee_enable_hw_security_config(struct ieee80211_hw *hw)
 	tmp = rtl_read_byte(rtlpriv, REG_CR + 1);
 	rtl_write_byte(rtlpriv, REG_CR + 1, tmp | BIT(1));
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+		"The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
@@ -1153,8 +1153,8 @@ static bool _rtl8192ee_check_pcie_dma_hang(struct rtl_priv *rtlpriv)
 	 */
 	tmp = rtl_read_byte(rtlpriv, REG_BACKDOOR_DBI_DATA + 3);
 	if ((tmp & BIT(0)) || (tmp & BIT(1))) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "CheckPcieDMAHang8192EE(): true!!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"CheckPcieDMAHang8192EE(): true!!\n");
 		return true;
 	}
 	return false;
@@ -1167,8 +1167,8 @@ static void _rtl8192ee_reset_pcie_interface_dma(struct rtl_priv *rtlpriv,
 	bool release_mac_rx_pause;
 	u8 backup_pcie_dma_pause;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "ResetPcieInterfaceDMA8192EE()\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"ResetPcieInterfaceDMA8192EE()\n");
 
 	/* Revise Note: Follow the document "PCIe RX DMA Hang Reset Flow_v03"
 	 * released by SD1 Alan.
@@ -1281,7 +1281,7 @@ int rtl92ee_hw_init(struct ieee80211_hw *hw)
 	u8 tmp_u1b, u1byte;
 	u32 tmp_u4b;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, " Rtl8192EE hw init\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, " Rtl8192EE hw init\n");
 	rtlpriv->rtlhal.being_init_adapter = true;
 	rtlpriv->intf_ops->disable_aspm(hw);
 
@@ -1295,7 +1295,7 @@ int rtl92ee_hw_init(struct ieee80211_hw *hw)
 	}
 
 	if (_rtl8192ee_check_pcie_dma_hang(rtlpriv)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "92ee dma hang!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "92ee dma hang!\n");
 		_rtl8192ee_reset_pcie_interface_dma(rtlpriv,
 						    rtlhal->mac_func_enable);
 		rtlhal->mac_func_enable = false;
@@ -1324,8 +1324,8 @@ int rtl92ee_hw_init(struct ieee80211_hw *hw)
 	rtl_write_word(rtlpriv, REG_PCIE_CTRL_REG, 0x8000);
 	err = rtl92ee_download_fw(hw, false);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		rtlhal->fw_ready = false;
 		return err;
@@ -1401,12 +1401,12 @@ int rtl92ee_hw_init(struct ieee80211_hw *hw)
 	efuse_one_byte_read(hw, 0x1FA, &tmp_u1b);
 	if (!(tmp_u1b & BIT(0))) {
 		rtl_set_rfreg(hw, RF90_PATH_A, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path A\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path A\n");
 	}
 
 	if ((!(tmp_u1b & BIT(1))) && (rtlphy->rf_type == RF_2T2R)) {
 		rtl_set_rfreg(hw, RF90_PATH_B, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path B\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "PA BIAS path B\n");
 	}
 
 	rtl_write_byte(rtlpriv, REG_NAV_UPPER, ((30000 + 127) / 128));
@@ -1421,8 +1421,8 @@ int rtl92ee_hw_init(struct ieee80211_hw *hw)
 
 	rtl_write_dword(rtlpriv, 0x4fc, 0);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "end of Rtl8192EE hw init %x\n", err);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"end of Rtl8192EE hw init %x\n", err);
 	return 0;
 }
 
@@ -1441,9 +1441,9 @@ static enum version_8192e _rtl92ee_read_chip_version(struct ieee80211_hw *hw)
 	else
 		version = (enum version_8192e)VERSION_NORMAL_CHIP_2T2R_8192E;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
-		  "RF_2T2R" : "RF_1T1R");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Chip RF Type: %s\n", (rtlphy->rf_type == RF_2T2R) ?
+		"RF_2T2R" : "RF_1T1R");
 
 	return version;
 }
@@ -1459,26 +1459,26 @@ static int _rtl92ee_set_media_status(struct ieee80211_hw *hw,
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
@@ -1503,9 +1503,9 @@ static int _rtl92ee_set_media_status(struct ieee80211_hw *hw,
 		_rtl92ee_resume_tx_beacon(hw);
 		_rtl92ee_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
-			 mode);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
+			mode);
 	}
 
 	rtl_write_byte(rtlpriv, MSR, bt_msr | mode);
@@ -1611,7 +1611,7 @@ static void _rtl92ee_poweroff_adapter(struct ieee80211_hw *hw)
 
 	rtlhal->mac_func_enable = false;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "POWER OFF adapter\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "POWER OFF adapter\n");
 
 	/* Run LPS WL RFOFF flow */
 	rtl_hal_pwrseqcmdparsing(rtlpriv, PWR_CUT_ALL_MSK, PWR_FAB_ALL_MSK,
@@ -1651,7 +1651,7 @@ void rtl92ee_card_disable(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	enum nl80211_iftype opmode;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "RTL8192ee card disable\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "RTL8192ee card disable\n");
 
 	RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
 
@@ -1710,8 +1710,8 @@ void rtl92ee_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 }
 
@@ -1721,8 +1721,8 @@ void rtl92ee_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD,
-		 "add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD,
+		"add_msr:%x, rm_msr:%x\n", add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1788,15 +1788,15 @@ static void _rtl8192ee_read_power_value_fromprom(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 rf, addr = EEPROM_TX_PWR_INX, group, i = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "hal_ReadPowerValueFromPROM92E(): PROMContent[0x%x]=0x%x\n",
-		 (addr + 1), hwinfo[addr + 1]);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"hal_ReadPowerValueFromPROM92E(): PROMContent[0x%x]=0x%x\n",
+		(addr + 1), hwinfo[addr + 1]);
 	if (0xFF == hwinfo[addr+1])  /*YJ,add,120316*/
 		autoload_fail = true;
 
 	if (autoload_fail) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "auto load fail : Use Default value!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"auto load fail : Use Default value!\n");
 		for (rf = 0 ; rf < MAX_RF_PATH ; rf++) {
 			/* 2.4G default value */
 			for (group = 0 ; group < MAX_CHNL_GROUP_24G; group++) {
@@ -2113,8 +2113,8 @@ static void _rtl92ee_read_adapter_info(struct ieee80211_hw *hw)
 	if (rtlefuse->eeprom_oemid == 0xFF)
 		rtlefuse->eeprom_oemid = 0;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"EEPROM Customer ID: 0x%2x\n", rtlefuse->eeprom_oemid);
 	/* set channel plan from efuse */
 	rtlefuse->channel_plan = rtlefuse->eeprom_channelplan;
 	/*tx power*/
@@ -2134,8 +2134,8 @@ static void _rtl92ee_read_adapter_info(struct ieee80211_hw *hw)
 		rtlefuse->board_type |= BIT(2); /* ODM_BOARD_BT */
 
 	rtlhal->board_type = rtlefuse->board_type;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "board_type = 0x%x\n", rtlefuse->board_type);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"board_type = 0x%x\n", rtlefuse->board_type);
 	/*parse xtal*/
 	rtlefuse->crystalcap = hwinfo[EEPROM_XTAL_92E];
 	if (hwinfo[EEPROM_XTAL_92E] == 0xFF)
@@ -2172,8 +2172,8 @@ static void _rtl92ee_hal_customized_behavior(struct ieee80211_hw *hw)
 
 	rtlpriv->ledctl.led_opendrain = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
 void rtl92ee_read_eeprom_info(struct ieee80211_hw *hw)
@@ -2191,18 +2191,18 @@ void rtl92ee_read_eeprom_info(struct ieee80211_hw *hw)
 		rtlpriv->dm.rfpath_rxenable[0] = true;
 		rtlpriv->dm.rfpath_rxenable[1] = true;
 	}
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
 		_rtl92ee_read_adapter_info(hw);
 	} else {
@@ -2361,8 +2361,8 @@ static void rtl92ee_update_hal_rate_mask(struct ieee80211_hw *hw,
 	ratr_index = _rtl92ee_mrate_idx_to_arfr_id(hw, ratr_index);
 	sta_entry->ratr_index = ratr_index;
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "ratr_bitmap :%x\n", ratr_bitmap);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"ratr_bitmap :%x\n", ratr_bitmap);
 	*(u32 *)&rate_mask = (ratr_bitmap & 0x0fffffff) |
 				       (ratr_index << 28);
 	rate_mask[0] = macid;
@@ -2372,11 +2372,11 @@ static void rtl92ee_update_hal_rate_mask(struct ieee80211_hw *hw,
 	rate_mask[4] = (u8)((ratr_bitmap & 0x0000ff00) >> 8);
 	rate_mask[5] = (u8)((ratr_bitmap & 0x00ff0000) >> 16);
 	rate_mask[6] = (u8)((ratr_bitmap & 0xff000000) >> 24);
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG,
-		 "Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x:%x:%x\n",
-		  ratr_index, ratr_bitmap, rate_mask[0], rate_mask[1],
-		  rate_mask[2], rate_mask[3], rate_mask[4],
-		  rate_mask[5], rate_mask[6]);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"Rate_index:%x, ratr_val:%x, %x:%x:%x:%x:%x:%x:%x\n",
+		ratr_index, ratr_bitmap, rate_mask[0], rate_mask[1],
+		rate_mask[2], rate_mask[3], rate_mask[4],
+		rate_mask[5], rate_mask[6]);
 	rtl92ee_fill_h2c_cmd(hw, H2C_92E_RA_MASK, 7, rate_mask);
 	_rtl92ee_set_bcn_ctrl_reg(hw, BIT(3), 0);
 }
@@ -2438,7 +2438,7 @@ void rtl92ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2466,8 +2466,8 @@ void rtl92ee_set_key(struct ieee80211_hw *hw, u32 key_index,
 			enc_algo = CAM_AES;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_ERR, DBG_DMESG,
-				 "switch case %#x not processed\n", enc_algo);
+			rtl_dbg(rtlpriv, COMP_ERR, DBG_DMESG,
+				"switch case %#x not processed\n", enc_algo);
 			enc_algo = CAM_TKIP;
 			break;
 		}
@@ -2498,27 +2498,27 @@ void rtl92ee_set_key(struct ieee80211_hw *hw, u32 key_index,
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
@@ -2603,7 +2603,7 @@ void rtl92ee_allow_all_destaddr(struct ieee80211_hw *hw,
 	if (write_into_reg)
 		rtl_write_dword(rtlpriv, REG_RCR, rtlpci->receive_config);
 
-	RT_TRACE(rtlpriv, COMP_TURBO | COMP_INIT, DBG_LOUD,
-		 "receive_config=0x%08X, write_into_reg=%d\n",
-		  rtlpci->receive_config, write_into_reg);
+	rtl_dbg(rtlpriv, COMP_TURBO | COMP_INIT, DBG_LOUD,
+		"receive_config=0x%08X, write_into_reg=%d\n",
+		rtlpci->receive_config, write_into_reg);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c
index 78202ad4036e..fb4ea3a8481f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/led.c
@@ -19,8 +19,8 @@ void rtl92ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u32 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -38,8 +38,8 @@ void rtl92ee_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
 	pled->ledon = true;
@@ -50,8 +50,8 @@ void rtl92ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD,
-		 "LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD,
+		"LedAddr:%X ledpin=%d\n", REG_LEDCFG2, pled->ledpin);
 
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -68,8 +68,8 @@ void rtl92ee_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", pled->ledpin);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", pled->ledpin);
 		break;
 	}
 	pled->ledon = false;
@@ -118,6 +118,6 @@ void rtl92ee_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_TRACE, "ledaction %d,\n", ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_TRACE, "ledaction %d,\n", ledaction);
 	_rtl92ee_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
index bb291b951f4d..f107a30a96f0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c
@@ -43,15 +43,15 @@ u32 rtl92ee_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x)\n", regaddr, bitmask);
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl92ee_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
-		  bitmask, regaddr, originalvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+		bitmask, regaddr, originalvalue);
 
 	return returnvalue;
 }
@@ -62,9 +62,9 @@ void rtl92ee_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		  regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 
 	if (bitmask != MASKDWORD) {
 		originalvalue = rtl_read_dword(rtlpriv, regaddr);
@@ -74,9 +74,9 @@ void rtl92ee_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
-		  regaddr, bitmask, data);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x)\n",
+		regaddr, bitmask, data);
 }
 
 u32 rtl92ee_phy_query_rf_reg(struct ieee80211_hw *hw,
@@ -85,9 +85,9 @@ u32 rtl92ee_phy_query_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		  regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -97,9 +97,9 @@ u32 rtl92ee_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x),rfpath(%#x),bitmask(%#x),original_value(%#x)\n",
-		  regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x),rfpath(%#x),bitmask(%#x),original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 
 	return readback_value;
 }
@@ -111,9 +111,9 @@ void rtl92ee_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  addr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		addr, bitmask, data, rfpath);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -127,9 +127,9 @@ void rtl92ee_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		  addr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		addr, bitmask, data, rfpath);
 }
 
 static u32 _rtl92ee_phy_rf_serial_read(struct ieee80211_hw *hw,
@@ -172,9 +172,9 @@ static u32 _rtl92ee_phy_rf_serial_read(struct ieee80211_hw *hw,
 	else
 		retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 					 BLSSIREADBACKDATA);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFR-%d Addr[0x%x]=0x%x\n",
-		  rfpath, pphyreg->rf_rb, retvalue);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFR-%d Addr[0x%x]=0x%x\n",
+		rfpath, pphyreg->rf_rb, retvalue);
 	return retvalue;
 }
 
@@ -196,9 +196,9 @@ static void _rtl92ee_phy_rf_serial_write(struct ieee80211_hw *hw,
 	newoffset = offset;
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "RFW-%d Addr[0x%x]=0x%x\n", rfpath,
-		 pphyreg->rf3wire_offset, data_and_addr);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"RFW-%d Addr[0x%x]=0x%x\n", rfpath,
+		pphyreg->rf3wire_offset, data_and_addr);
 }
 
 static u32 _rtl92ee_phy_calculate_bit_shift(u32 bitmask)
@@ -400,8 +400,8 @@ static void _rtl92ee_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 
 	if (path > RF90_PATH_D) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Rf Path %d\n", path);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Rf Path %d\n", path);
 		return;
 	}
 
@@ -420,14 +420,14 @@ static void _rtl92ee_phy_set_txpower_by_rate_base(struct ieee80211_hw *hw,
 			rtlphy->txpwr_by_rate_base_24g[path][txnum][3] = value;
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Invalid RateSection %d in 2.4G,Rf %d,%dTx\n",
-				  rate_section, path, txnum);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Invalid RateSection %d in 2.4G,Rf %d,%dTx\n",
+				rate_section, path, txnum);
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Band %d\n", band);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Band %d\n", band);
 	}
 }
 
@@ -440,8 +440,8 @@ static u8 _rtl92ee_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 	u8 value = 0;
 
 	if (path > RF90_PATH_D) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Rf Path %d\n", path);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Rf Path %d\n", path);
 		return 0;
 	}
 
@@ -460,14 +460,14 @@ static u8 _rtl92ee_phy_get_txpower_by_rate_base(struct ieee80211_hw *hw,
 			value = rtlphy->txpwr_by_rate_base_24g[path][txnum][3];
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-				 "Invalid RateSection %d in 2.4G,Rf %d,%dTx\n",
-				  rate_section, path, txnum);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+				"Invalid RateSection %d in 2.4G,Rf %d,%dTx\n",
+				rate_section, path, txnum);
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Invalid Band %d()\n", band);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Invalid Band %d()\n", band);
 	}
 	return value;
 }
@@ -606,8 +606,8 @@ static void phy_convert_txpwr_dbm_to_rel_val(struct ieee80211_hw *hw)
 			0, 3, base);
 	}
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-		 "<==phy_convert_txpwr_dbm_to_rel_val()\n");
+	rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+		"<==%s\n", __func__);
 }
 
 static void _rtl92ee_phy_txpower_by_rate_configuration(struct ieee80211_hw *hw)
@@ -659,11 +659,11 @@ static bool _rtl92ee_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl8192EMACPHY_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl8192EMACPHY_Array\n");
 	arraylength = RTL8192EE_MAC_ARRAY_LEN;
 	ptrarray = RTL8192EE_MAC_ARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Img:RTL8192EE_MAC_ARRAY LEN %d\n" , arraylength);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Img:RTL8192EE_MAC_ARRAY LEN %d\n", arraylength);
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8)ptrarray[i + 1]);
 	return true;
@@ -776,10 +776,10 @@ static bool phy_config_bb_with_hdr_file(struct ieee80211_hw *hw,
 					}
 				}
 			}
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "The agctab_array_table[0] is %x Rtl818EEPHY_REGArray[1] is %x\n",
-				 array[i],
-				 array[i + 1]);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"The agctab_array_table[0] is %x Rtl818EEPHY_REGArray[1] is %x\n",
+				array[i],
+				array[i + 1]);
 		}
 	}
 	return true;
@@ -843,17 +843,17 @@ static void _rtl92ee_store_tx_power_by_rate(struct ieee80211_hw *hw,
 	u8 section = _rtl92ee_get_rate_section_index(regaddr);
 
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
 
@@ -888,8 +888,8 @@ static bool phy_config_bb_with_pghdrfile(struct ieee80211_hw *hw,
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
@@ -914,9 +914,9 @@ bool rtl92ee_phy_config_rf_with_headerfile(struct ieee80211_hw  *hw,
 	case RF90_PATH_A:
 		len = RTL8192EE_RADIOA_ARRAY_LEN;
 		array = RTL8192EE_RADIOA_ARRAY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Radio_A:RTL8192EE_RADIOA_ARRAY %d\n" , len);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Radio_A:RTL8192EE_RADIOA_ARRAY %d\n", len);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 		for (i = 0; i < len; i = i + 2) {
 			v1 = array[i];
 			v2 = array[i+1];
@@ -961,9 +961,9 @@ bool rtl92ee_phy_config_rf_with_headerfile(struct ieee80211_hw  *hw,
 	case RF90_PATH_B:
 		len = RTL8192EE_RADIOB_ARRAY_LEN;
 		array = RTL8192EE_RADIOB_ARRAY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-			 "Radio_A:RTL8192EE_RADIOB_ARRAY %d\n" , len);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Radio_A:RTL8192EE_RADIOB_ARRAY %d\n", len);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 		for (i = 0; i < len; i = i + 2) {
 			v1 = array[i];
 			v2 = array[i+1];
@@ -1025,21 +1025,21 @@ void rtl92ee_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
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
 
 static void phy_init_bb_rf_register_def(struct ieee80211_hw *hw)
@@ -1236,8 +1236,8 @@ static u8 _rtl92ee_get_txpower_index(struct ieee80211_hw *hw,
 
 	if (channel < 1 || channel > 14) {
 		index = 0;
-		RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_DMESG,
-			 "Illegal channel!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_DMESG,
+			"Illegal channel!!\n");
 	}
 
 	if (IS_CCK_RATE((s8)rate))
@@ -1395,8 +1395,8 @@ static void _rtl92ee_set_txpower_index(struct ieee80211_hw *hw, u8 pwr_idx,
 				      pwr_idx);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "Invalid Rate!!\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"Invalid Rate!!\n");
 			break;
 		}
 	} else if (rfpath == RF90_PATH_B) {
@@ -1514,12 +1514,12 @@ static void _rtl92ee_set_txpower_index(struct ieee80211_hw *hw, u8 pwr_idx,
 				      pwr_idx);
 			break;
 		default:
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-				 "Invalid Rate!!\n");
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+				"Invalid Rate!!\n");
 			break;
 		}
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid RFPath!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "Invalid RFPath!!\n");
 	}
 }
 
@@ -1578,8 +1578,8 @@ static void phy_set_txpower_index_by_rate_section(struct ieee80211_hw *hw,
 						    rtlphy->current_chan_bw,
 						    channel, ht_rates2t, 8);
 	} else
-		RT_TRACE(rtlpriv, FPHY, PHY_TXPWR,
-			 "Invalid RateSection %d\n", section);
+		rtl_dbg(rtlpriv, FPHY, PHY_TXPWR,
+			"Invalid RateSection %d\n", section);
 }
 
 void rtl92ee_phy_set_txpower_level(struct ieee80211_hw *hw, u8 channel)
@@ -1665,10 +1665,10 @@ void rtl92ee_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
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
@@ -1722,7 +1722,7 @@ void rtl92ee_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl92ee_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_LOUD, "\n");
 }
 
 void rtl92ee_phy_set_bw_mode(struct ieee80211_hw *hw,
@@ -1739,8 +1739,8 @@ void rtl92ee_phy_set_bw_mode(struct ieee80211_hw *hw,
 	if ((!is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl92ee_phy_set_bw_mode_callback(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "false driver sleep or unload\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"false driver sleep or unload\n");
 		rtlphy->set_bwmode_inprogress = false;
 		rtlphy->current_chan_bw = tmp_bw;
 	}
@@ -1753,8 +1753,8 @@ void rtl92ee_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	u32 delay;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE,
-		 "switch to channel%d\n", rtlphy->current_channel);
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE,
+		"switch to channel%d\n", rtlphy->current_channel);
 	if (is_hal_stop(rtlhal))
 		return;
 	do {
@@ -1772,7 +1772,7 @@ void rtl92ee_phy_sw_chnl_callback(struct ieee80211_hw *hw)
 		}
 		break;
 	} while (true);
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "\n");
 }
 
 u8 rtl92ee_phy_sw_chnl(struct ieee80211_hw *hw)
@@ -1792,13 +1792,13 @@ u8 rtl92ee_phy_sw_chnl(struct ieee80211_hw *hw)
 	rtlphy->sw_chnl_step = 0;
 	if (!(is_hal_stop(rtlhal)) && !(RT_CANNOT_IO(hw))) {
 		rtl92ee_phy_sw_chnl_callback(hw);
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
@@ -1900,9 +1900,9 @@ static bool _rtl92ee_phy_sw_chnl_step_by_step(struct ieee80211_hw *hw,
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
 
@@ -2248,7 +2248,7 @@ static u8 _rtl92ee_phy_path_b_rx_iqk(struct ieee80211_hw *hw, bool config_pathb)
 	    (((reg_ecc & 0x03FF0000) >> 16) != 0x36))
 		result |= 0x02;
 	else
-		RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD, "Path B Rx IQK fail!!\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "Path B Rx IQK fail!!\n");
 
 	return result;
 }
@@ -2545,8 +2545,8 @@ static void _rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw,
 		patha_ok = _rtl92ee_phy_path_a_iqk(hw, is2t);
 
 		if (patha_ok == 0x01) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "Path A Tx IQK Success!!\n");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"Path A Tx IQK Success!!\n");
 			result[t][0] = (rtl_get_bbreg(hw,
 						      RTX_POWER_BEFORE_IQK_A,
 						      MASKDWORD) & 0x3FF0000)
@@ -2556,17 +2556,17 @@ static void _rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw,
 						      >> 16;
 			break;
 		}
-		RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-			 "Path A Tx IQK Fail!!, ret = 0x%x\n",
-			 patha_ok);
+		rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+			"Path A Tx IQK Fail!!, ret = 0x%x\n",
+			patha_ok);
 	}
 
 	for (i = 0 ; i < retrycount ; i++) {
 		patha_ok = _rtl92ee_phy_path_a_rx_iqk(hw, is2t);
 
 		if (patha_ok == 0x03) {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "Path A Rx IQK Success!!\n");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"Path A Rx IQK Success!!\n");
 			result[t][2] = (rtl_get_bbreg(hw,
 						      RRX_POWER_BEFORE_IQK_A_2,
 						      MASKDWORD) & 0x3FF0000)
@@ -2577,14 +2577,14 @@ static void _rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw,
 						      >> 16;
 			break;
 		}
-		RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-			 "Path A Rx IQK Fail!!, ret = 0x%x\n",
-			  patha_ok);
+		rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+			"Path A Rx IQK Fail!!, ret = 0x%x\n",
+			patha_ok);
 	}
 
 	if (0x00 == patha_ok)
-		RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-			 "Path A IQK failed!!, ret = 0\n");
+		rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+			"Path A IQK failed!!, ret = 0\n");
 	if (is2t) {
 		_rtl92ee_phy_path_a_standby(hw);
 		/* Turn Path B ADDA on */
@@ -2598,8 +2598,8 @@ static void _rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw,
 		for (i = 0 ; i < retrycount ; i++) {
 			pathb_ok = _rtl92ee_phy_path_b_iqk(hw);
 			if (pathb_ok == 0x01) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-					 "Path B Tx IQK Success!!\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+					"Path B Tx IQK Success!!\n");
 				result[t][4] = (rtl_get_bbreg(hw,
 							RTX_POWER_BEFORE_IQK_B,
 							MASKDWORD) & 0x3FF0000)
@@ -2610,16 +2610,16 @@ static void _rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw,
 							>> 16;
 				break;
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "Path B Tx IQK Fail!!, ret = 0x%x\n",
-				 pathb_ok);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"Path B Tx IQK Fail!!, ret = 0x%x\n",
+				pathb_ok);
 		}
 
 		for (i = 0 ; i < retrycount ; i++) {
 			pathb_ok = _rtl92ee_phy_path_b_rx_iqk(hw, is2t);
 			if (pathb_ok == 0x03) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-					 "Path B Rx IQK Success!!\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+					"Path B Rx IQK Success!!\n");
 				result[t][6] = (rtl_get_bbreg(hw,
 						       RRX_POWER_BEFORE_IQK_B_2,
 						       MASKDWORD) & 0x3FF0000)
@@ -2630,18 +2630,18 @@ static void _rtl92ee_phy_iq_calibrate(struct ieee80211_hw *hw,
 						       >> 16;
 				break;
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "Path B Rx IQK Fail!!, ret = 0x%x\n",
-				 pathb_ok);
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"Path B Rx IQK Fail!!, ret = 0x%x\n",
+				pathb_ok);
 		}
 
 		if (0x00 == pathb_ok)
-			RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-				 "Path B IQK failed!!, ret = 0\n");
+			rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+				"Path B IQK failed!!, ret = 0\n");
 	}
 	/* Back to BB mode, load original value */
-	RT_TRACE(rtlpriv, COMP_RF, DBG_LOUD,
-		 "IQK:Back to BB mode, load original value!\n");
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD,
+		"IQK:Back to BB mode, load original value!\n");
 	rtl_set_bbreg(hw, RFPGA0_IQK, MASKDWORD, 0);
 
 	if (t != 0) {
@@ -2724,7 +2724,7 @@ static void _rtl92ee_phy_set_rfpath_switch(struct ieee80211_hw *hw,
 	struct rtl_hal *rtlhal = rtl_hal(rtl_priv(hw));
 	struct rtl_efuse *rtlefuse = rtl_efuse(rtl_priv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INIT , DBG_LOUD , "\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "\n");
 
 	if (is_hal_stop(rtlhal)) {
 		u8 u1btmp;
@@ -2953,24 +2953,24 @@ bool rtl92ee_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
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
@@ -2981,7 +2981,7 @@ bool rtl92ee_phy_set_io_cmd(struct ieee80211_hw *hw, enum io_type iotype)
 		return false;
 	}
 	rtl92ee_phy_set_io(hw);
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "IO Type(%#x)\n", iotype);
 	return true;
 }
 
@@ -2991,14 +2991,14 @@ static void rtl92ee_phy_set_io(struct ieee80211_hw *hw)
 	struct rtl_phy *rtlphy = &rtlpriv->phy;
 	struct dig_t *dm_dig = &rtlpriv->dm_digtable;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE,
-		 "--->Cmd(%#x), set_io_inprogress(%d)\n",
-		  rtlphy->current_io_type, rtlphy->set_io_inprogress);
+	rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE,
+		"--->Cmd(%#x), set_io_inprogress(%d)\n",
+		rtlphy->current_io_type, rtlphy->set_io_inprogress);
 	switch (rtlphy->current_io_type) {
 	case IO_CMD_RESUME_DM_BY_SCAN:
 		rtl92ee_dm_write_dig(hw, rtlphy->initgain_backup.xaagccore1);
 		rtl92ee_dm_write_cck_cca_thres(hw, rtlphy->initgain_backup.cca);
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_TRACE , "no set txpower\n");
+		rtl_dbg(rtlpriv, COMP_CMD, DBG_TRACE, "no set txpower\n");
 		rtl92ee_phy_set_txpower_level(hw, rtlphy->current_channel);
 		break;
 	case IO_CMD_PAUSE_BAND0_DM_BY_SCAN:
@@ -3009,14 +3009,14 @@ static void rtl92ee_phy_set_io(struct ieee80211_hw *hw)
 		rtl92ee_dm_write_cck_cca_thres(hw, 0x40);
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
 
 static void rtl92ee_phy_set_rf_on(struct ieee80211_hw *hw)
@@ -3062,16 +3062,16 @@ static bool _rtl92ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
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
-				 "Set ERFON sleeping:%d ms\n",
-				  jiffies_to_msecs(jiffies -
-						   ppsc->last_sleep_jiffies));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"Set ERFON sleeping:%d ms\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies));
 			ppsc->last_awake_jiffies = jiffies;
 			rtl92ee_phy_set_rf_on(hw);
 		}
@@ -3089,27 +3089,27 @@ static bool _rtl92ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
@@ -3132,32 +3132,32 @@ static bool _rtl92ee_phy_set_rf_power_state(struct ieee80211_hw *hw,
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
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-			 "Set ERFSLEEP awaked:%d ms\n",
-			  jiffies_to_msecs(jiffies -
-					   ppsc->last_awake_jiffies));
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"Set ERFSLEEP awaked:%d ms\n",
+			jiffies_to_msecs(jiffies -
+					 ppsc->last_awake_jiffies));
 		ppsc->last_sleep_jiffies = jiffies;
 		_rtl92ee_phy_set_rf_sleep(hw);
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
-			 "switch case %#x not processed\n", rfpwr_state);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_LOUD,
+			"switch case %#x not processed\n", rfpwr_state);
 		bresult = false;
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rf.c
index 6b8ef680dc57..bbe632d56b19 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/rf.c
@@ -118,12 +118,12 @@ static bool _rtl92ee_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
index dc7b515bdc85..f350c2294c36 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.c
@@ -363,9 +363,9 @@ bool rtl92ee_rx_query_desc(struct ieee80211_hw *hw,
 	else
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
 
@@ -468,9 +468,9 @@ u16 rtl92ee_rx_desc_buff_remained_cnt(struct ieee80211_hw *hw, u8 queue_index)
 	write_point = (u16)(tmp_4byte & 0x7ff);
 
 	if (write_point != rtlpci->rx_ring[queue_index].next_rx_rp) {
-		RT_TRACE(rtlpriv, COMP_RXDESC, DBG_DMESG,
-			 "!!!write point is 0x%x, reg 0x3B4 value is 0x%x\n",
-			  write_point, tmp_4byte);
+		rtl_dbg(rtlpriv, COMP_RXDESC, DBG_DMESG,
+			"!!!write point is 0x%x, reg 0x3B4 value is 0x%x\n",
+			write_point, tmp_4byte);
 		tmp_4byte = rtl_read_dword(rtlpriv, REG_RXQ_TXBD_IDX);
 		read_point = (u16)((tmp_4byte>>16) & 0x7ff);
 		write_point = (u16)(tmp_4byte & 0x7ff);
@@ -678,8 +678,8 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	mapping = pci_map_single(rtlpci->pdev, skb->data, skb->len,
 				 PCI_DMA_TODEVICE);
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 
@@ -697,9 +697,9 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 			set_tx_desc_offset(pdesc,
 					   USB_HWDESC_HEADER_LEN + EM_HDR_LEN);
 			if (ptcb_desc->empkt_num) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Insert 8 byte.pTcb->EMPktNum:%d\n",
-					  ptcb_desc->empkt_num);
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Insert 8 byte.pTcb->EMPktNum:%d\n",
+					ptcb_desc->empkt_num);
 				_rtl92ee_insert_emcontent(ptcb_desc,
 							  (u8 *)(skb->data));
 			}
@@ -798,8 +798,8 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 		}
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Enable RDG function.\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Enable RDG function.\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
 			}
@@ -824,7 +824,7 @@ void rtl92ee_tx_fill_desc(struct ieee80211_hw *hw,
 	    is_broadcast_ether_addr(ieee80211_get_DA(hdr))) {
 		set_tx_desc_bmc(pdesc, 1);
 	}
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -841,8 +841,8 @@ void rtl92ee_tx_fill_cmddesc(struct ieee80211_hw *hw,
 	__le32 *pdesc = (__le32 *)pdesc8;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	clear_pci_tx_desc_content(pdesc, txdesc_len);
-- 
2.27.0

