Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9B722B7F8
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGWUm5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgGWUmz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:55 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB39C0619D3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:55 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l63so6171609oih.13
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AP+ok1tBJ6+SfngWW95h+nxoQks5MF1gOEt5Icsk1Pg=;
        b=i3jyXf0tj5iGCbqCshfjLIHw0HTr1eKpxAb2hwnPa4Q/DKQGGpRYu8OCUK1be7M1DK
         l2A4eaEj6YT64Qy6NvtIgMnrJv6ZRG3vBTJvwBwIlSfA3kfdwfwUmgbsbfdCfeJmrhyG
         kFbrTOwgy/OSHXaKO2s9gdVYAXnm6Ypupp54f69UvH861rbN7zfYb+VmEzPNtu8wPKeB
         /SCdaPFTfBKWNLiZzgz+PU+KNa9Ynwt/W2pmJY9dvH92zybr9TZddqWprcFaYiiQFI4m
         ZKrkACNJGSF4Jzn5OYvIxHeGMtpVgZ7t+8S2yolASICvGqKnOPZC5+ohku/1JZT5sJmO
         rfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AP+ok1tBJ6+SfngWW95h+nxoQks5MF1gOEt5Icsk1Pg=;
        b=LVfQ99YvdpGpWeWWWEqZ1/owemc6qmG5YFzDZpT/KCPLJk9iII1qvGHM5PnCY3qIIR
         gAkrAvhT2r7FwFzVKmkRqv55zdLqOFFb9iwbpbFLQKctfj11084T76OGXMlSzJ1wUaex
         MW0soH8FPIMaJOKhbdFX4NL1VAuSLnmJgrthGr7waRqI55q9vK6KHwRJG9qhmo7xNaIB
         vkeFQm7dQ0K3kA+4AZ2PPGlohN/07VLzA/ejUu9j5L0/jcGOm16Gbp89tOaTp+YN1DXj
         RlwJcdad6oMLlpQSH5H8GoT/+snUSLGniKsNEzQN4u7FXefqQs7s9wRPLaAx6JroTEIt
         CdiQ==
X-Gm-Message-State: AOAM532vrxeUf9bP+ocqT0QI6BANbZfo1oaUNhbeAsTys1lCnxGb6v4S
        37WkL8kBWs3/D57OqjFsZBI=
X-Google-Smtp-Source: ABdhPJxTRp4iqga8P3S3SIaud3yQufZkv/KauCtMVtEaZMvw9sJMnapntJuZcTuSEBH617my+MMSQQ==
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr5306919oif.51.1595536974329;
        Thu, 23 Jul 2020 13:42:54 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:53 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 07/15] rtlwifi: rtl8192cu: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:36 -0500
Message-Id: <20200723204244.24457-8-Larry.Finger@lwfinger.net>
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
rtl8192cu. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8192cu/dm.c   |  38 ++---
 .../wireless/realtek/rtlwifi/rtl8192cu/hw.c   | 152 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192cu/led.c  |  10 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/mac.c  |  64 ++++----
 .../wireless/realtek/rtlwifi/rtl8192cu/phy.c  | 134 +++++++--------
 .../wireless/realtek/rtlwifi/rtl8192cu/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192cu/trx.c  |  58 +++----
 7 files changed, 231 insertions(+), 231 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/dm.c
index 9d1167ff3b50..9823872692b1 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/dm.c
@@ -25,8 +25,8 @@ void rtl92cu_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 
@@ -37,42 +37,42 @@ void rtl92cu_dm_dynamic_txpower(struct ieee80211_hw *hw)
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
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_LEVEL1;
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
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
index 5b071b70bc08..fdcd0ab1309f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c
@@ -386,8 +386,8 @@ static void _rtl92cu_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "RT Customized ID: 0x%02X\n",
-		 rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "RT Customized ID: 0x%02X\n",
+		rtlhal->oem_id);
 }
 
 void rtl92cu_read_eeprom_info(struct ieee80211_hw *hw)
@@ -403,11 +403,11 @@ void rtl92cu_read_eeprom_info(struct ieee80211_hw *hw)
 	tmp_u1b = rtl_read_byte(rtlpriv, REG_9346CR);
 	rtlefuse->epromtype = (tmp_u1b & BOOT_FROM_EEPROM) ?
 			       EEPROM_93C46 : EEPROM_BOOT_EFUSE;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from %s\n",
-		 tmp_u1b & BOOT_FROM_EEPROM ? "EERROM" : "EFUSE");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Boot from %s\n",
+		tmp_u1b & BOOT_FROM_EEPROM ? "EERROM" : "EFUSE");
 	rtlefuse->autoload_failflag = (tmp_u1b & EEPROM_EN) ? false : true;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload %s\n",
-		 tmp_u1b & EEPROM_EN ? "OK!!" : "ERR!!");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload %s\n",
+		tmp_u1b & EEPROM_EN ? "OK!!" : "ERR!!");
 	_rtl92cu_read_adapter_info(hw);
 	_rtl92cu_hal_customized_behavior(hw);
 	return;
@@ -424,8 +424,8 @@ static int _rtl92cu_init_power_on(struct ieee80211_hw *hw)
 
 	do {
 		if (rtl_read_byte(rtlpriv, REG_APS_FSMCO) & PFM_ALDN) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-				 "Autoload Done!\n");
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+				"Autoload Done!\n");
 			break;
 		}
 		if (pollingcount++ > 100) {
@@ -443,9 +443,9 @@ static int _rtl92cu_init_power_on(struct ieee80211_hw *hw)
 	if (0 == (value8 & LDV12_EN)) {
 		value8 |= LDV12_EN;
 		rtl_write_byte(rtlpriv, REG_LDOV12D_CTRL, value8);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 " power-on :REG_LDOV12D_CTRL Reg0x21:0x%02x\n",
-			 value8);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			" power-on :REG_LDOV12D_CTRL Reg0x21:0x%02x\n",
+			value8);
 		udelay(100);
 		value8 = rtl_read_byte(rtlpriv, REG_SYS_ISO_CTRL);
 		value8 &= ~ISO_MD2PP;
@@ -860,13 +860,13 @@ void rtl92cu_enable_hw_security_config(struct ieee80211_hw *hw)
 	u8 sec_reg_value = 0x0;
 	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
 
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
-			 "not open sw encryption\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+			"not open sw encryption\n");
 		return;
 	}
 	sec_reg_value = SCR_TXENCENABLE | SCR_RXDECENABLE;
@@ -877,8 +877,8 @@ void rtl92cu_enable_hw_security_config(struct ieee80211_hw *hw)
 	if (IS_NORMAL_CHIP(rtlhal->version))
 		sec_reg_value |= (SCR_RXBCUSEDK | SCR_TXBCUSEDK);
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD, "The SECR-value %x\n",
-		 sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD, "The SECR-value %x\n",
+		sec_reg_value);
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 }
 
@@ -958,8 +958,8 @@ int rtl92cu_hw_init(struct ieee80211_hw *hw)
 	}
 	err = rtl92c_download_fw(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
 	}
@@ -1280,32 +1280,32 @@ static int _rtl92cu_set_media_status(struct ieee80211_hw *hw,
 		_rtl92cu_resume_tx_beacon(hw);
 		_rtl92cu_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS:No such media status(%x)\n",
-			 type);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS:No such media status(%x)\n",
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
 		pr_err("Network type %d not supported!\n", type);
@@ -1438,9 +1438,9 @@ void rtl92cu_set_beacon_related_registers(struct ieee80211_hw *hw)
 	rtl_write_dword(rtlpriv, REG_TCR, value32);
 	value32 |= TSFRST;
 	rtl_write_dword(rtlpriv, REG_TCR, value32);
-	RT_TRACE(rtlpriv, COMP_INIT|COMP_BEACON, DBG_LOUD,
-		 "SetBeaconRelatedRegisters8192CUsb(): Set TCR(%x)\n",
-		 value32);
+	rtl_dbg(rtlpriv, COMP_INIT | COMP_BEACON, DBG_LOUD,
+		"SetBeaconRelatedRegisters8192CUsb(): Set TCR(%x)\n",
+		value32);
 	/* TODO: Modify later (Find the right parameters)
 	 * NOTE: Fix test chip's bug (about contention windows's randomness) */
 	if ((mac->opmode == NL80211_IFTYPE_ADHOC) ||
@@ -1458,8 +1458,8 @@ void rtl92cu_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG, "beacon_interval:%d\n",
-		 bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG, "beacon_interval:%d\n",
+		bcn_interval);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 }
 
@@ -1599,7 +1599,7 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			rtl_write_byte(rtlpriv, REG_MAC_SPEC_SIFS + 1, val[0]);
 			rtl_write_byte(rtlpriv, REG_R2T_SIFS+1, val[0]);
 			rtl_write_byte(rtlpriv, REG_T2T_SIFS+1, val[0]);
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD, "HW_VAR_SIFS\n");
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD, "HW_VAR_SIFS\n");
 			break;
 		}
 	case HW_VAR_SLOT_TIME:{
@@ -1607,8 +1607,8 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			u8 QOS_MODE = 1;
 
 			rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "HW_VAR_SLOT_TIME %x\n", val[0]);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"HW_VAR_SLOT_TIME %x\n", val[0]);
 			if (QOS_MODE) {
 				for (e_aci = 0; e_aci < AC_MAX; e_aci++)
 					rtlpriv->cfg->ops->set_hw_reg(hw,
@@ -1672,9 +1672,9 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 						     0xf8) |
 						     min_spacing_to_set);
 				*val = min_spacing_to_set;
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-					 mac->min_space_cfg);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+					mac->min_space_cfg);
 				rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 					       mac->min_space_cfg);
 			}
@@ -1687,9 +1687,9 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			density_to_set &= 0x1f;
 			mac->min_space_cfg &= 0x07;
 			mac->min_space_cfg |= (density_to_set << 3);
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-				 mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+				mac->min_space_cfg);
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
 			break;
@@ -1721,9 +1721,9 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 						       (REG_AGGLEN_LMT + index),
 						       p_regtoset[index]);
 				}
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
-					 factor_toset);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_FACTOR: %#x\n",
+					factor_toset);
 			}
 			break;
 		}
@@ -1740,9 +1740,9 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			u4b_ac_param |= (u32) ((cw_max & 0xF) <<
 					 AC_PARAM_ECW_MAX_OFFSET);
 			u4b_ac_param |= (u32) tx_op << AC_PARAM_TXOP_OFFSET;
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "queue:%x, ac_param:%x\n",
-				 e_aci, u4b_ac_param);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"queue:%x, ac_param:%x\n",
+				e_aci, u4b_ac_param);
 			switch (e_aci) {
 			case AC1_BK:
 				rtl_write_dword(rtlpriv, REG_EDCA_BK_PARAM,
@@ -1770,8 +1770,8 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_RCR:{
 			rtl_write_dword(rtlpriv, REG_RCR, ((u32 *) (val))[0]);
 			mac->rx_conf = ((u32 *) (val))[0];
-			RT_TRACE(rtlpriv, COMP_RECV, DBG_DMESG,
-				 "### Set RCR(0x%08x) ###\n", mac->rx_conf);
+			rtl_dbg(rtlpriv, COMP_RECV, DBG_DMESG,
+				"### Set RCR(0x%08x) ###\n", mac->rx_conf);
 			break;
 		}
 	case HW_VAR_RETRY_LIMIT:{
@@ -1780,9 +1780,9 @@ void rtl92cu_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			rtl_write_word(rtlpriv, REG_RL,
 				       retry_limit << RETRY_LIMIT_SHORT_SHIFT |
 				       retry_limit << RETRY_LIMIT_LONG_SHIFT);
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_DMESG,
-				 "Set HW_VAR_RETRY_LIMIT(0x%08x)\n",
-				 retry_limit);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_DMESG,
+				"Set HW_VAR_RETRY_LIMIT(0x%08x)\n",
+				retry_limit);
 			break;
 		}
 	case HW_VAR_DUAL_TSF_RST:
@@ -1987,8 +1987,8 @@ static void rtl92cu_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
-		 rtl_read_dword(rtlpriv, REG_ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+		rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
 static void rtl92cu_update_hal_rate_mask(struct ieee80211_hw *hw,
@@ -2121,14 +2121,14 @@ static void rtl92cu_update_hal_rate_mask(struct ieee80211_hw *hw,
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
-		 "Rate_index:%x, ratr_val:%x, %5phC\n",
-		 ratr_index, ratr_bitmap, rate_mask);
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
+		"Rate_index:%x, ratr_val:%x, %5phC\n",
+		ratr_index, ratr_bitmap, rate_mask);
 	memcpy(rtlpriv->rate_mask, rate_mask, 5);
 	/* rtl92c_fill_h2c_cmd() does USB I/O and will result in a
 	 * "scheduled while atomic" if called directly */
@@ -2194,8 +2194,8 @@ bool rtl92cu_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 * valid)
 			u1tmp = rtl_read_byte(rtlpriv, REG_HSISR);
 			e_rfpowerstate_toset = (u1tmp & BIT(7)) ?
 					       ERFOFF : ERFON;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-				 "pwrdown, 0x5c(BIT7)=%02x\n", u1tmp);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+				"pwrdown, 0x5c(BIT7)=%02x\n", u1tmp);
 		} else {
 			rtl_write_byte(rtlpriv, REG_MAC_PINMUX_CFG,
 				       rtl_read_byte(rtlpriv,
@@ -2203,26 +2203,26 @@ bool rtl92cu_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 * valid)
 			u1tmp = rtl_read_byte(rtlpriv, REG_GPIO_IO_SEL);
 			e_rfpowerstate_toset  = (u1tmp & BIT(3)) ?
 						 ERFON : ERFOFF;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
-				 "GPIO_IN=%02x\n", u1tmp);
+			rtl_dbg(rtlpriv, COMP_POWER, DBG_DMESG,
+				"GPIO_IN=%02x\n", u1tmp);
 		}
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "N-SS RF =%x\n",
-			 e_rfpowerstate_toset);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD, "N-SS RF =%x\n",
+			e_rfpowerstate_toset);
 	}
 	if ((ppsc->hwradiooff) && (e_rfpowerstate_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "GPIOChangeRF  - HW Radio ON, RF ON\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"GPIOChangeRF  - HW Radio ON, RF ON\n");
 		ppsc->hwradiooff = false;
 		actuallyset = true;
 	} else if ((!ppsc->hwradiooff) && (e_rfpowerstate_toset  ==
 		    ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "GPIOChangeRF  - HW Radio OFF\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"GPIOChangeRF  - HW Radio OFF\n");
 		ppsc->hwradiooff = true;
 		actuallyset = true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
-			 "pHalData->bHwRadioOff and eRfPowerStateToSet do not match: pHalData->bHwRadioOff %x, eRfPowerStateToSet %x\n",
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"pHalData->bHwRadioOff and eRfPowerStateToSet do not match: pHalData->bHwRadioOff %x, eRfPowerStateToSet %x\n",
 			 ppsc->hwradiooff, e_rfpowerstate_toset);
 	}
 	if (actuallyset) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c
index cc13a4a8f856..1488f52a2d2f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/led.c
@@ -23,8 +23,8 @@ void rtl92cu_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		REG_LEDCFG2, pled->ledpin);
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -49,8 +49,8 @@ void rtl92cu_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		REG_LEDCFG2, pled->ledpin);
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 	switch (pled->ledpin) {
 	case LED_PIN_GPIO0:
@@ -113,6 +113,6 @@ void rtl92cu_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
 	_rtl92cu_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
index b4b67341dc83..d7afb6a186df 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c
@@ -91,24 +91,24 @@ void rtl92c_read_chip_version(struct ieee80211_hw *hw)
 		versionid = "UNKNOWN";
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-		 "Chip Version ID: %s\n", versionid);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+		"Chip Version ID: %s\n", versionid);
 
 	if (IS_92C_SERIAL(rtlhal->version))
 		rtlphy->rf_type =
 			 (IS_92C_1T2R(rtlhal->version)) ? RF_1T2R : RF_2T2R;
 	else
 		rtlphy->rf_type = RF_1T1R;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
-		 "Chip RF Type: %s\n",
-		 rtlphy->rf_type == RF_2T2R ? "RF_2T2R" : "RF_1T1R");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"Chip RF Type: %s\n",
+		rtlphy->rf_type == RF_2T2R ? "RF_2T2R" : "RF_1T1R");
 	if (get_rf_type(rtlphy) == RF_1T1R)
 		rtlpriv->dm.rfpath_rxenable[0] = true;
 	else
 		rtlpriv->dm.rfpath_rxenable[0] =
 		    rtlpriv->dm.rfpath_rxenable[1] = true;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
-		 rtlhal->version);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "VersionID = 0x%4x\n",
+		rtlhal->version);
 }
 
 /**
@@ -215,7 +215,7 @@ void rtl92c_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
 			rtl_cam_empty_entry(hw, cam_offset + idx);
@@ -269,30 +269,30 @@ void rtl92c_set_key(struct ieee80211_hw *hw, u32 key_index,
 			}
 		}
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "delete one entry\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"delete one entry\n");
 			if (mac->opmode == NL80211_IFTYPE_AP ||
 			    mac->opmode == NL80211_IFTYPE_MESH_POINT)
 				rtl_cam_del_entry(hw, p_macaddr);
 			rtl_cam_delete_one_entry(hw, p_macaddr, entry_id);
 		} else {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "The insert KEY length is %d\n",
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"The insert KEY length is %d\n",
 				 rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-				 "The insert KEY is %x %x\n",
-				 rtlpriv->sec.key_buf[0][0],
-				 rtlpriv->sec.key_buf[0][1]);
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "add one entry\n");
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
 					      rtlpriv->sec.
 					      key_len[PAIRWISE_KEYIDX]);
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set Pairwise key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set Pairwise key\n");
 
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
 						entry_id, enc_algo,
@@ -300,8 +300,8 @@ void rtl92c_set_key(struct ieee80211_hw *hw, u32 key_index,
 						rtlpriv->sec.
 						key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set group key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set group key\n");
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 					rtl_cam_add_one_entry(hw,
 						rtlefuse->dev_addr,
@@ -383,27 +383,27 @@ int rtl92c_set_network_type(struct ieee80211_hw *hw, enum nl80211_iftype type)
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		value = NT_NO_LINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Set Network type to NO LINK!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		value = NT_LINK_AD_HOC;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Set Network type to Ad Hoc!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		value = NT_LINK_AP;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Set Network type to STA!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		value = NT_AS_AP;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Set Network type to AP!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Set Network type to AP!\n");
 		break;
 	default:
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Network type %d not supported!\n", type);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Network type %d not supported!\n", type);
 		return -EOPNOTSUPP;
 	}
 	rtl_write_byte(rtlpriv, MSR, value);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c
index 9cd028cb2239..a8d9fe269f31 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/phy.c
@@ -22,9 +22,9 @@ u32 rtl92cu_phy_query_rf_reg(struct ieee80211_hw *hw,
 	u32 original_value, readback_value, bitshift;
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		 regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		original_value = _rtl92c_phy_rf_serial_read(hw,
 							    rfpath, regaddr);
@@ -34,9 +34,9 @@ u32 rtl92cu_phy_query_rf_reg(struct ieee80211_hw *hw,
 	}
 	bitshift = _rtl92c_phy_calculate_bit_shift(bitmask);
 	readback_value = (original_value & bitmask) >> bitshift;
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		 regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 	return readback_value;
 }
 
@@ -48,9 +48,9 @@ void rtl92cu_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 	if (rtlphy->rf_mode != RF_OP_BY_FW) {
 		if (bitmask != RFREG_OFFSET_MASK) {
 			original_value = _rtl92c_phy_rf_serial_read(hw,
@@ -74,9 +74,9 @@ void rtl92cu_phy_set_rf_reg(struct ieee80211_hw *hw,
 		}
 		_rtl92c_phy_fw_rf_serial_write(hw, rfpath, regaddr, data);
 	}
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 }
 
 bool rtl92cu_phy_mac_config(struct ieee80211_hw *hw)
@@ -121,10 +121,10 @@ bool _rtl92cu_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_ARRAY\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_ARRAY\n");
 	arraylength =  rtlphy->hwparam_tables[MAC_REG].length ;
 	ptrarray = rtlphy->hwparam_tables[MAC_REG].pdata;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Img:RTL8192CUMAC_2T_ARRAY\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Img:RTL8192CUMAC_2T_ARRAY\n");
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8) ptrarray[i + 1]);
 	return true;
@@ -158,20 +158,20 @@ bool _rtl92cu_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
 			rtl_set_bbreg(hw, phy_regarray_table[i], MASKDWORD,
 				      phy_regarray_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "The phy_regarray_table[0] is %x Rtl819XPHY_REGARRAY[1] is %x\n",
-				 phy_regarray_table[i],
-				 phy_regarray_table[i + 1]);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"The phy_regarray_table[0] is %x Rtl819XPHY_REGARRAY[1] is %x\n",
+				phy_regarray_table[i],
+				phy_regarray_table[i + 1]);
 		}
 	} else if (configtype == BASEBAND_CONFIG_AGC_TAB) {
 		for (i = 0; i < agctab_arraylen; i = i + 2) {
 			rtl_set_bbreg(hw, agctab_array_table[i], MASKDWORD,
 				      agctab_array_table[i + 1]);
 			udelay(1);
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "The agctab_array_table[0] is %x Rtl819XPHY_REGARRAY[1] is %x\n",
-				 agctab_array_table[i],
-				 agctab_array_table[i + 1]);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"The agctab_array_table[0] is %x Rtl819XPHY_REGARRAY[1] is %x\n",
+				agctab_array_table[i],
+				agctab_array_table[i + 1]);
 		}
 	}
 	return true;
@@ -198,8 +198,8 @@ bool _rtl92cu_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
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
@@ -220,21 +220,21 @@ bool rtl92cu_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 		radioa_array_table = rtlphy->hwparam_tables[RADIOA_2T].pdata;
 		radiob_arraylen = rtlphy->hwparam_tables[RADIOB_2T].length;
 		radiob_array_table = rtlphy->hwparam_tables[RADIOB_2T].pdata;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_A:RTL8192CURADIOA_2TARRAY\n");
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_B:RTL8192CU_RADIOB_2TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_A:RTL8192CURADIOA_2TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_B:RTL8192CU_RADIOB_2TARRAY\n");
 	} else {
 		radioa_arraylen = rtlphy->hwparam_tables[RADIOA_1T].length;
 		radioa_array_table = rtlphy->hwparam_tables[RADIOA_1T].pdata;
 		radiob_arraylen = rtlphy->hwparam_tables[RADIOB_1T].length;
 		radiob_array_table = rtlphy->hwparam_tables[RADIOB_1T].pdata;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_A:RTL8192CU_RADIOA_1TARRAY\n");
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_B:RTL8192CU_RADIOB_1TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_A:RTL8192CU_RADIOA_1TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_B:RTL8192CU_RADIOB_1TARRAY\n");
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		for (i = 0; i < radioa_arraylen; i = i + 2) {
@@ -269,9 +269,9 @@ void rtl92cu_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	u8 reg_bw_opmode;
 	u8 reg_prsr_rsc;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
-		 rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
-		 "20MHz" : "40MHz");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
+		rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
+		"20MHz" : "40MHz");
 	if (is_hal_stop(rtlhal)) {
 		rtlphy->set_bwmode_inprogress = false;
 		return;
@@ -319,7 +319,7 @@ void rtl92cu_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl92cu_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 }
 
 void rtl92cu_bb_block_on(struct ieee80211_hw *hw)
@@ -390,17 +390,17 @@ static bool _rtl92cu_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
 			do {
 				init_count++;
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "IPS Set eRf nic enable\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic enable\n");
 				rtstatus = rtl_ps_enable_nic(hw);
 			} while (!rtstatus && (init_count < 10));
 			RT_CLEAR_PS_LEVEL(ppsc,
 					  RT_RF_OFF_LEVL_HALT_NIC);
 		} else {
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "Set ERFON sleeped:%d ms\n",
-				 jiffies_to_msecs(jiffies -
-						  ppsc->last_sleep_jiffies));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"Set ERFON slept:%d ms\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies));
 			ppsc->last_awake_jiffies = jiffies;
 			rtl92ce_phy_set_rf_on(hw);
 		}
@@ -421,26 +421,26 @@ static bool _rtl92cu_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
 			} else {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
-					 i + 1,
-					 queue_id,
-					 skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
+					i + 1,
+					queue_id,
+					skb_queue_len(&ring->queue));
 				udelay(10);
 				i++;
 			}
 			if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-				RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-					 "ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
-					 MAX_DOZE_WAITING_TIMES_9x,
-					 queue_id,
-					 skb_queue_len(&ring->queue));
+				rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+					"ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
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
@@ -463,25 +463,25 @@ static bool _rtl92cu_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				queue_id++;
 				continue;
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
-			 jiffies_to_msecs(jiffies - ppsc->last_awake_jiffies));
+		rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+			"Set ERFSLEEP awaked:%d ms\n",
+			jiffies_to_msecs(jiffies - ppsc->last_awake_jiffies));
 		ppsc->last_sleep_jiffies = jiffies;
 		_rtl92c_phy_set_rf_sleep(hw);
 		break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
index d259794a308b..288033f02266 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c
@@ -431,12 +431,12 @@ static bool _rtl92c_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 			break;
 		}
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "Radio[%d] Fail!!\n", rfpath);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
 			goto phy_rf_cfg_fail;
 		}
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
 phy_rf_cfg_fail:
 	return rtstatus;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
index fc526477740f..1ad0cf37f60b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.c
@@ -82,8 +82,8 @@ static void twooutepmapping(struct ieee80211_hw *hw, bool is_chip8,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (bwificfg) { /* for WMM */
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "USB Chip-B & WMM Setting.....\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"USB Chip-B & WMM Setting.....\n");
 		ep_map->ep_mapping[RTL_TXQ_BE]	= 2;
 		ep_map->ep_mapping[RTL_TXQ_BK]	= 3;
 		ep_map->ep_mapping[RTL_TXQ_VI]	= 3;
@@ -92,8 +92,8 @@ static void twooutepmapping(struct ieee80211_hw *hw, bool is_chip8,
 		ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
 		ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
 	} else { /* typical setting */
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "USB typical Setting.....\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"USB typical Setting.....\n");
 		ep_map->ep_mapping[RTL_TXQ_BE]	= 3;
 		ep_map->ep_mapping[RTL_TXQ_BK]	= 3;
 		ep_map->ep_mapping[RTL_TXQ_VI]	= 2;
@@ -110,8 +110,8 @@ static void threeoutepmapping(struct ieee80211_hw *hw, bool  bwificfg,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
 	if (bwificfg) { /* for WMM */
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "USB 3EP Setting for WMM.....\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"USB 3EP Setting for WMM.....\n");
 		ep_map->ep_mapping[RTL_TXQ_BE]	= 5;
 		ep_map->ep_mapping[RTL_TXQ_BK]	= 3;
 		ep_map->ep_mapping[RTL_TXQ_VI]	= 3;
@@ -120,8 +120,8 @@ static void threeoutepmapping(struct ieee80211_hw *hw, bool  bwificfg,
 		ep_map->ep_mapping[RTL_TXQ_BCN] = 2;
 		ep_map->ep_mapping[RTL_TXQ_HI]	= 2;
 	} else { /* typical setting */
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "USB 3EP Setting for typical.....\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"USB 3EP Setting for typical.....\n");
 		ep_map->ep_mapping[RTL_TXQ_BE]	= 5;
 		ep_map->ep_mapping[RTL_TXQ_BK]	= 5;
 		ep_map->ep_mapping[RTL_TXQ_VI]	= 3;
@@ -248,24 +248,24 @@ static enum rtl_desc_qsel _rtl8192cu_mq_to_descq(struct ieee80211_hw *hw,
 	switch (mac80211_queue_index) {
 	case 0:	/* VO */
 		qsel = QSLT_VO;
-		RT_TRACE(rtlpriv, COMP_USB, DBG_DMESG,
-			 "VO queue, set qsel = 0x%x\n", QSLT_VO);
+		rtl_dbg(rtlpriv, COMP_USB, DBG_DMESG,
+			"VO queue, set qsel = 0x%x\n", QSLT_VO);
 		break;
 	case 1:	/* VI */
 		qsel = QSLT_VI;
-		RT_TRACE(rtlpriv, COMP_USB, DBG_DMESG,
-			 "VI queue, set qsel = 0x%x\n", QSLT_VI);
+		rtl_dbg(rtlpriv, COMP_USB, DBG_DMESG,
+			"VI queue, set qsel = 0x%x\n", QSLT_VI);
 		break;
 	case 3:	/* BK */
 		qsel = QSLT_BK;
-		RT_TRACE(rtlpriv, COMP_USB, DBG_DMESG,
-			 "BK queue, set qsel = 0x%x\n", QSLT_BK);
+		rtl_dbg(rtlpriv, COMP_USB, DBG_DMESG,
+			"BK queue, set qsel = 0x%x\n", QSLT_BK);
 		break;
 	case 2:	/* BE */
 	default:
 		qsel = QSLT_BE;
-		RT_TRACE(rtlpriv, COMP_USB, DBG_DMESG,
-			 "BE queue, set qsel = 0x%x\n", QSLT_BE);
+		rtl_dbg(rtlpriv, COMP_USB, DBG_DMESG,
+			"BE queue, set qsel = 0x%x\n", QSLT_BE);
 		break;
 	}
 out:
@@ -398,18 +398,18 @@ static void _rtl_rx_process(struct ieee80211_hw *hw, struct sk_buff *skb)
 	fc = hdr->frame_control;
 	bv = ieee80211_is_probe_resp(fc);
 	if (bv)
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-			 "Got probe response frame\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+			"Got probe response frame\n");
 	if (ieee80211_is_beacon(fc))
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Got beacon frame\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Got beacon frame\n");
 	if (ieee80211_is_data(fc))
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "Got data frame\n");
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "Fram: fc = 0x%X addr1 = 0x%02X:0x%02X:0x%02X:0x%02X:0x%02X:0x%02X\n",
-		 fc,
-		 (u32)hdr->addr1[0], (u32)hdr->addr1[1],
-		 (u32)hdr->addr1[2], (u32)hdr->addr1[3],
-		 (u32)hdr->addr1[4], (u32)hdr->addr1[5]);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG, "Got data frame\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"Fram: fc = 0x%X addr1 = 0x%02X:0x%02X:0x%02X:0x%02X:0x%02X:0x%02X\n",
+		fc,
+		(u32)hdr->addr1[0], (u32)hdr->addr1[1],
+		(u32)hdr->addr1[2], (u32)hdr->addr1[3],
+		(u32)hdr->addr1[4], (u32)hdr->addr1[5]);
 	ieee80211_rx(hw, skb);
 }
 
@@ -570,8 +570,8 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 	set_tx_desc_use_rate(txdesc, tcb_desc->use_driver_rate ? 1 : 0);
 	if (ieee80211_is_data_qos(fc)) {
 		if (mac->rdg_en) {
-			RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-				 "Enable RDG function\n");
+			rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+				"Enable RDG function\n");
 			set_tx_desc_rdg_enable(txdesc, 1);
 			set_tx_desc_htc(txdesc, 1);
 		}
@@ -597,7 +597,7 @@ void rtl92cu_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(txdesc, 1);
 	_rtl_fill_usb_tx_desc(txdesc);
 	_rtl_tx_desc_checksum(txdesc);
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "==>\n");
 }
 
 void rtl92cu_fill_fake_txdesc(struct ieee80211_hw *hw, u8 *pdesc8,
-- 
2.27.0

