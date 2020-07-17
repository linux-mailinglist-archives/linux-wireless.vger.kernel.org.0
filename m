Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7922230F7
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 04:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgGQCCy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 22:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGQCCn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 22:02:43 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F929C08C5E2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:30 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k4so6778542oik.2
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jul 2020 19:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PBgcHS7JM6sYoYz7EOpevBSAImT0TGSg+9CTFh+oOFY=;
        b=ODbK+azzxan+JOcEQ9wTuaPnzoIVCIC4qoq1H5y3+JlIJC3IQQI5UQCmG/ogYfPR8g
         0HRGkDa652BZGNyu9I2Kso0Mo1gs3e+GVENACdOb2NgKLz/bjZLqpUqn8QoQN4yj40/U
         x1xqtmZG/Vke2bE0O6gk//TFBUL/4R17eaP7b4lR1N8hGEm35c3GGsBq4ued2eVXPEGv
         DPAfXWZVUQ8Uvw6f3+7wIf3P+OfQbyQsZYfgjbucGMBnIOtzE2vnYbvRUKx+VXD20fNN
         kQfTYpDjg4Ig6WvftxeF1ncWkbnza5JB3qrZtvs79m9rTt53ewbOajja84GmnOSgsKBz
         bZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PBgcHS7JM6sYoYz7EOpevBSAImT0TGSg+9CTFh+oOFY=;
        b=OUty2rLsMK/0xTNNSev8GfEtEidp/Q8knsRSGLlXpurYhoGFkojdNxUjLhTGSg9odQ
         UFXAdclE2g0DpZFGtDlRcYPi0RP2zna6ylGbbGTS72vcSwt0PvX9WPYCT5YEFTTnL9UP
         pGh4qZqE1qJXOxdieDH8/oREqOK1qmUOZ/6SO34peenXppnhzReNJ9mucJIvwqQQVRVe
         UWjaJ4zE2+aSHW8CqntGlTIr/uN/EQqmDR1lFgoei97mjt0inVLQKyC0VUFbVDQ11Xc6
         4FhPskIGvefZGTgVksBkjvVL/ru6o0DyjalbpbI1QOjNq3xDFV2LySBs/gtlrCS0dlS/
         0xJA==
X-Gm-Message-State: AOAM533bqNdLcJzuTIZdk70O/Dshr6suyR30dEgU9OAwZVdBJLAATcgP
        TGXZquZX9jkpFP6P0Aq7U3w=
X-Google-Smtp-Source: ABdhPJz/h3DVvkbVD2heQt4v8eGuo6X4uwr9NqbGJG9w9+PIKx+TjuKzgB06f8YWqPkCgTy/L92A3g==
X-Received: by 2002:aca:1006:: with SMTP id 6mr5697851oiq.175.1594951349321;
        Thu, 16 Jul 2020 19:02:29 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h16sm1585985otr.10.2020.07.16.19.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 19:02:29 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 09/14] rtlwifi: rtl8192se: Rename RT_TRACE to RT_DEBUG
Date:   Thu, 16 Jul 2020 21:01:56 -0500
Message-Id: <20200717020201.18209-10-Larry.Finger@lwfinger.net>
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
rtl8192se.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192se/dm.c   | 14 +--
 .../wireless/realtek/rtlwifi/rtl8192se/fw.c   | 14 +--
 .../wireless/realtek/rtlwifi/rtl8192se/hw.c   | 80 ++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192se/led.c  |  6 +-
 .../wireless/realtek/rtlwifi/rtl8192se/phy.c  | 88 +++++++++----------
 .../wireless/realtek/rtlwifi/rtl8192se/rf.c   | 26 +++---
 .../wireless/realtek/rtlwifi/rtl8192se/sw.c   |  2 +-
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  |  6 +-
 8 files changed, 118 insertions(+), 118 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c
index a6e4384ceea1..c8d7af9d0e4c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/dm.c
@@ -144,7 +144,7 @@ static void _rtl92s_dm_txpowertracking_callback_thermalmeter(
 
 	thermalvalue = (u8)rtl_get_rfreg(hw, RF90_PATH_A, RF_T_METER, 0x1f);
 
-	RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 		 "Readback Thermal Meter = 0x%x pre thermal meter 0x%x eeprom_thermal meter 0x%x\n",
 		 thermalvalue,
 		 rtlpriv->dm.thermalvalue, rtlefuse->eeprom_thermalmeter);
@@ -158,7 +158,7 @@ static void _rtl92s_dm_txpowertracking_callback_thermalmeter(
 				 (rtlpriv->efuse.thermalmeter[0] << 8) |
 				 (thermalvalue << 16));
 
-			RT_TRACE(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
 				 "Write to FW Thermal Val = 0x%x\n", fw_cmd);
 
 			rtl_write_dword(rtlpriv, WFM5, fw_cmd);
@@ -264,7 +264,7 @@ static void _rtl92s_dm_refresh_rateadaptive_mask(struct ieee80211_hw *hw)
 		}
 
 		if (ra->pre_ratr_state != ra->ratr_state) {
-			RT_TRACE(rtlpriv, COMP_RATE, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_RATE, DBG_LOUD,
 				 "RSSI = %ld RSSI_LEVEL = %d PreState = %d, CurState = %d\n",
 				 rtlpriv->dm.undec_sm_pwdb, ra->ratr_state,
 				 ra->pre_ratr_state, ra->ratr_state);
@@ -576,7 +576,7 @@ static void _rtl92s_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_TRACE,
 			 "Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TX_HIGHPWR_LEVEL_NORMAL;
@@ -588,19 +588,19 @@ static void _rtl92s_dm_dynamic_txpower(struct ieee80211_hw *hw)
 	if (mac->link_state >= MAC80211_LINKED) {
 		if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 			undec_sm_pwdb = rtlpriv->dm.entry_min_undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "AP Client PWDB = 0x%lx\n",
 				 undec_sm_pwdb);
 		} else {
 			undec_sm_pwdb = rtlpriv->dm.undec_sm_pwdb;
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "STA Default Port PWDB = 0x%lx\n",
 				 undec_sm_pwdb);
 		}
 	} else {
 		undec_sm_pwdb = rtlpriv->dm.entry_min_undec_sm_pwdb;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "AP Ext Port PWDB = 0x%lx\n",
 			 undec_sm_pwdb);
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
index 47a5b95ca2b9..d1b9203a2c7f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
@@ -39,7 +39,7 @@ static bool _rtl92s_firmware_enable_cpu(struct ieee80211_hw *hw)
 	do {
 		cpustatus = rtl_read_byte(rtlpriv, TCR);
 		if (cpustatus & IMEM_RDY) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "IMEM Ready after CPU has refilled\n");
 			break;
 		}
@@ -195,7 +195,7 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 	short pollingcnt = 1000;
 	bool rtstatus = true;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "LoadStaus(%d)\n", loadfw_status);
 
 	firmware->fwstatus = (enum fw_status)loadfw_status;
@@ -256,7 +256,7 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 			goto status_check_fail;
 		}
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "DMEM code download success, cpustatus(%#x)\n",
 			 cpustatus);
 
@@ -270,7 +270,7 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 			udelay(40);
 		} while (pollingcnt--);
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Polling Load Firmware ready, cpustatus(%x)\n",
 			 cpustatus);
 
@@ -290,7 +290,7 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 		rtl_write_dword(rtlpriv, RCR, (tmpu4b | RCR_APPFCS |
 				RCR_APP_ICV | RCR_APP_MIC));
 
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 			 "Current RCR settings(%#x)\n", tmpu4b);
 
 		/* Set to normal mode. */
@@ -304,7 +304,7 @@ static bool _rtl92s_firmware_checkready(struct ieee80211_hw *hw,
 	}
 
 status_check_fail:
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "loadfw_status(%d), rtstatus(%x)\n",
 		 loadfw_status, rtstatus);
 	return rtstatus;
@@ -337,7 +337,7 @@ int rtl92s_download_fw(struct ieee80211_hw *hw)
 	firmware->firmwareversion =  byte(pfwheader->version, 0);
 	firmware->pfwheader->fwpriv.hci_sel = 1;/* pcie */
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "signature:%x, version:%x, size:%x, imemsize:%x, sram size:%x\n",
 		 pfwheader->signature,
 		 pfwheader->version, pfwheader->dmem_size,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
index 81313e0ca834..0623e70e9a08 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/hw.c
@@ -111,7 +111,7 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 			u8 e_aci;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "HW_VAR_SLOT_TIME %x\n", val[0]);
 
 			rtl_write_byte(rtlpriv, SLOT_TIME, val[0]);
@@ -156,7 +156,7 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 				*val = min_spacing_to_set;
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 					 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
 					 mac->min_space_cfg);
 
@@ -172,7 +172,7 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			mac->min_space_cfg = rtlpriv->rtlhal.minspace_cfg;
 			mac->min_space_cfg |= (density_to_set << 3);
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 				 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
 				 mac->min_space_cfg);
 
@@ -215,7 +215,7 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					    (factorlevel[17] << 4));
 				rtl_write_byte(rtlpriv, AGGLEN_LMT_H, regtoset);
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_MLME, DBG_LOUD,
 					 "Set HW_VAR_AMPDU_FACTOR: %#x\n",
 					 factor_toset);
 			}
@@ -253,7 +253,7 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 					acm_ctrl |= ACMHW_VOQEN;
 					break;
 				default:
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 						 "HW_VAR_ACM_CTRL acm set failed: eACI is %d\n",
 						 acm);
 					break;
@@ -276,7 +276,7 @@ void rtl92se_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 				}
 			}
 
-			RT_TRACE(rtlpriv, COMP_QOS, DBG_TRACE,
+			RT_DEBUG(rtlpriv, COMP_QOS, DBG_TRACE,
 				 "HW_VAR_ACM_CTRL Write 0x%X\n", acm_ctrl);
 			rtl_write_byte(rtlpriv, ACMHWCTRL, acm_ctrl);
 			break;
@@ -417,13 +417,13 @@ void rtl92se_enable_hw_security_config(struct ieee80211_hw *hw)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 sec_reg_value = 0x0;
 
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
@@ -435,7 +435,7 @@ void rtl92se_enable_hw_security_config(struct ieee80211_hw *hw)
 		sec_reg_value |= SCR_RXUSEDK;
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD, "The SECR-value %x\n",
+	RT_DEBUG(rtlpriv, COMP_SEC, DBG_LOUD, "The SECR-value %x\n",
 		 sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
@@ -870,10 +870,10 @@ static void _rtl92se_macconfig_after_fwdownload(struct ieee80211_hw *hw)
 
 		/* Change Program timing */
 		rtl_write_byte(rtlpriv, REG_EFUSE_CTRL + 3, 0x72);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "EFUSE CONFIG OK\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "EFUSE CONFIG OK\n");
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "OK\n");
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "OK\n");
 
 }
 
@@ -960,7 +960,7 @@ int rtl92se_hw_init(struct ieee80211_hw *hw)
 	/* 2. download firmware */
 	rtstatus = rtl92s_download_fw(hw);
 	if (!rtstatus) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "Failed to download FW. Init HW without FW now... "
 			 "Please copy FW into /lib/firmware/rtlwifi\n");
 		err = 1;
@@ -1014,7 +1014,7 @@ int rtl92se_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, RF_CTRL, 0x07);
 
 	if (!rtl92s_phy_rf_config(hw)) {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "RF Config failed\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "RF Config failed\n");
 		err = rtstatus;
 		goto exit;
 	}
@@ -1147,22 +1147,22 @@ static int _rtl92se_set_media_status(struct ieee80211_hw *hw,
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		bt_msr |= (MSR_LINK_NONE << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
 		bt_msr |= (MSR_LINK_ADHOC << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to Ad Hoc!\n");
 		break;
 	case NL80211_IFTYPE_STATION:
 		bt_msr |= (MSR_LINK_MANAGED << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to STA!\n");
 		break;
 	case NL80211_IFTYPE_AP:
 		bt_msr |= (MSR_LINK_MASTER << MSR_LINK_SHIFT);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_TRACE,
 			 "Set Network type to AP!\n");
 		break;
 	default:
@@ -1606,7 +1606,7 @@ void rtl92se_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
+	RT_DEBUG(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
 		 add_msr, rm_msr);
 
 	if (add_msr)
@@ -1671,11 +1671,11 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 
 	eeprom_id = *((u16 *)&hwinfo[0]);
 	if (eeprom_id != RTL8190_EEPROM_ID) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+		RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 			 "EEPROM ID(%#x) is invalid!!\n", eeprom_id);
 		rtlefuse->autoload_failflag = true;
 	} else {
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
+		RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Autoload OK\n");
 		rtlefuse->autoload_failflag = false;
 	}
 
@@ -1692,15 +1692,15 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 	rtlefuse->eeprom_smid = *(u16 *)&hwinfo[EEPROM_SMID];
 	rtlefuse->eeprom_version = *(u16 *)&hwinfo[EEPROM_VERSION];
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROMId = 0x%4x\n", eeprom_id);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM VID = 0x%4x\n", rtlefuse->eeprom_vid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM DID = 0x%4x\n", rtlefuse->eeprom_did);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM SVID = 0x%4x\n", rtlefuse->eeprom_svid);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "EEPROM SMID = 0x%4x\n", rtlefuse->eeprom_smid);
 
 	for (i = 0; i < 6; i += 2) {
@@ -1711,7 +1711,7 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 	for (i = 0; i < 6; i++)
 		rtl_write_byte(rtlpriv, MACIDR0 + i, rtlefuse->dev_addr[i]);
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_DMESG, "%pM\n", rtlefuse->dev_addr);
 
 	/* Get Tx Power Level by Channel */
 	/* Read Tx power of Channel 1 ~ 14 from EEPROM. */
@@ -1964,14 +1964,14 @@ static void _rtl92se_read_adapter_info(struct ieee80211_hw *hw)
 		tempval = rtl_read_byte(rtlpriv, 0x07);
 		if (!(tempval & BIT(0))) {
 			rtlefuse->b1x1_recvcombine = true;
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 				 "RF_TYPE=1T2R but only 1SS\n");
 		}
 	}
 	rtlefuse->b1ss_support = rtlefuse->b1x1_recvcombine;
 	rtlefuse->eeprom_oemid = *&hwinfo[EEPROM_CUSTOMID];
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "EEPROM Customer ID: 0x%2x\n",
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "EEPROM Customer ID: 0x%2x\n",
 		 rtlefuse->eeprom_oemid);
 
 	/* set channel paln to world wide 13 */
@@ -1987,15 +1987,15 @@ void rtl92se_read_eeprom_info(struct ieee80211_hw *hw)
 	tmp_u1b = rtl_read_byte(rtlpriv, EPROM_CMD);
 
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
 		_rtl92se_read_adapter_info(hw);
 	} else {
@@ -2101,7 +2101,7 @@ static void rtl92se_update_hal_rate_table(struct ieee80211_hw *hw,
 	else
 		rtl92s_phy_set_fw_cmd(hw, FW_CMD_RA_REFRESH_BG);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
 		 rtl_read_dword(rtlpriv, ARFR0));
 }
 
@@ -2256,7 +2256,7 @@ static void rtl92se_update_hal_rate_mask(struct ieee80211_hw *hw,
 
 	mask |= (bmulticast ? 1 : 0) << 9 | (macid & 0x1f) << 4 | (band & 0xf);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_TRACE, "mask = %x, bitmap = %x\n",
+	RT_DEBUG(rtlpriv, COMP_RATR, DBG_TRACE, "mask = %x, bitmap = %x\n",
 		 mask, ratr_bitmap);
 	rtl_write_dword(rtlpriv, 0x2c4, ratr_bitmap);
 	rtl_write_dword(rtlpriv, WFM5, (FW_RA_UPDATE_MASK | (mask << 8)));
@@ -2332,14 +2332,14 @@ bool rtl92se_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	rfpwr_toset = _rtl92se_rf_onoff_detect(hw);
 
 	if ((ppsc->hwradiooff) && (rfpwr_toset == ERFON)) {
-		RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 			 "RFKILL-HW Radio ON, RF ON\n");
 
 		rfpwr_toset = ERFON;
 		ppsc->hwradiooff = false;
 		actuallyset = true;
 	} else if ((!ppsc->hwradiooff) && (rfpwr_toset == ERFOFF)) {
-		RT_TRACE(rtlpriv, COMP_RF,
+		RT_DEBUG(rtlpriv, COMP_RF,
 			 DBG_DMESG, "RFKILL-HW Radio OFF, RF OFF\n");
 
 		rfpwr_toset = ERFOFF;
@@ -2404,7 +2404,7 @@ void rtl92se_set_key(struct ieee80211_hw *hw, u32 key_index, u8 *p_macaddr,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2463,17 +2463,17 @@ void rtl92se_set_key(struct ieee80211_hw *hw, u32 key_index, u8 *p_macaddr,
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
@@ -2481,7 +2481,7 @@ void rtl92se_set_key(struct ieee80211_hw *hw, u32 key_index, u8 *p_macaddr,
 					CAM_CONFIG_NO_USEDK,
 					rtlpriv->sec.key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_SEC, DBG_DMESG,
 					 "set group key\n");
 
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
index 2d18bc1ee480..002352b3db44 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/led.c
@@ -27,7 +27,7 @@ void rtl92se_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
 		 LEDCFG, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, LEDCFG);
@@ -57,7 +57,7 @@ void rtl92se_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	rtlpriv = rtl_priv(hw);
 	if (!rtlpriv || rtlpriv->max_fw_size)
 		return;
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
 		 LEDCFG, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, LEDCFG);
@@ -119,7 +119,7 @@ void rtl92se_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
 	    ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
+	RT_DEBUG(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n", ledaction);
 
 	_rtl92se_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
index d5c0eb462315..6a3e24298b66 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/phy.c
@@ -31,14 +31,14 @@ u32 rtl92s_phy_query_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 returnvalue = 0, originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "regaddr(%#x), bitmask(%#x)\n",
 		 regaddr, bitmask);
 
 	originalvalue = rtl_read_dword(rtlpriv, regaddr);
 	bitshift = _rtl92s_phy_calculate_bit_shift(bitmask);
 	returnvalue = (originalvalue & bitmask) >> bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "BBR MASK=0x%x Addr[0x%x]=0x%x\n",
 		 bitmask, regaddr, originalvalue);
 
 	return returnvalue;
@@ -51,7 +51,7 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 originalvalue, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 
@@ -63,7 +63,7 @@ void rtl92s_phy_set_bb_reg(struct ieee80211_hw *hw, u32 regaddr, u32 bitmask,
 
 	rtl_write_dword(rtlpriv, regaddr, data);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x)\n",
 		 regaddr, bitmask, data);
 
@@ -123,7 +123,7 @@ static u32 _rtl92s_phy_rf_serial_read(struct ieee80211_hw *hw,
 	retvalue = rtl_get_bbreg(hw, pphyreg->rf_rb,
 				 BLSSI_READBACK_DATA);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x]=0x%x\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "RFR-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf_rb, retvalue);
 
 	return retvalue;
@@ -146,7 +146,7 @@ static void _rtl92s_phy_rf_serial_write(struct ieee80211_hw *hw,
 	data_and_addr = ((newoffset << 20) | (data & 0x000fffff)) & 0x0fffffff;
 	rtl_set_bbreg(hw, pphyreg->rf3wire_offset, MASKDWORD, data_and_addr);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE, "RFW-%d Addr[0x%x]=0x%x\n",
 		 rfpath, pphyreg->rf3wire_offset, data_and_addr);
 }
 
@@ -157,7 +157,7 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u32 original_value, readback_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
 		 regaddr, rfpath, bitmask);
 
@@ -170,7 +170,7 @@ u32 rtl92s_phy_query_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
 		 regaddr, rfpath, bitmask, original_value);
 
@@ -187,7 +187,7 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 	if (!((rtlphy->rf_pathmap >> rfpath) & 0x1))
 		return;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 
@@ -204,7 +204,7 @@ void rtl92s_phy_set_rf_reg(struct ieee80211_hw *hw, enum radio_path rfpath,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
+	RT_DEBUG(rtlpriv, COMP_RF, DBG_TRACE,
 		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
 		 regaddr, bitmask, data, rfpath);
 
@@ -239,7 +239,7 @@ void rtl92s_phy_set_bw_mode(struct ieee80211_hw *hw,
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u8 reg_bw_opmode;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "Switch to %s bandwidth\n",
 		 rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20 ?
 		 "20MHz" : "40MHz");
 
@@ -296,7 +296,7 @@ void rtl92s_phy_set_bw_mode(struct ieee80211_hw *hw,
 
 	rtl92s_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 }
 
 static bool _rtl92s_phy_set_sw_chnl_cmdarray(struct swchnlcmd *cmdtable,
@@ -434,7 +434,7 @@ u8 rtl92s_phy_sw_chnl(struct ieee80211_hw *hw)
 	u32 delay;
 	bool ret;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "switch to channel%d\n",
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "switch to channel%d\n",
 		 rtlphy->current_channel);
 
 	if (rtlphy->sw_chnl_inprogress)
@@ -471,7 +471,7 @@ u8 rtl92s_phy_sw_chnl(struct ieee80211_hw *hw)
 
 	rtlphy->sw_chnl_inprogress = false;
 
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	RT_DEBUG(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 
 	return 1;
 }
@@ -530,7 +530,7 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				u32 initializecount = 0;
 				do {
 					initializecount++;
-					RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+					RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 						 "IPS Set eRf nic enable\n");
 					rtstatus = rtl_ps_enable_nic(hw);
 				} while (!rtstatus && (initializecount < 10));
@@ -538,7 +538,7 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				RT_CLEAR_PS_LEVEL(ppsc,
 						  RT_RF_OFF_LEVL_HALT_NIC);
 			} else {
-				RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 					 "awake, sleeped:%d ms state_inap:%x\n",
 					 jiffies_to_msecs(jiffies -
 							  ppsc->
@@ -560,7 +560,7 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		}
 	case ERFOFF:{
 			if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
+				RT_DEBUG(rtlpriv, COMP_RF, DBG_DMESG,
 					 "IPS Set eRf nic disable\n");
 				rtl_ps_disable_nic(hw);
 				RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
@@ -586,7 +586,7 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					queue_id++;
 					continue;
 				} else {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] = %d before doze!\n",
 						 i + 1, queue_id,
 						 skb_queue_len(&ring->queue));
@@ -596,7 +596,7 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				}
 
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
+					RT_DEBUG(rtlpriv, COMP_ERR, DBG_WARNING,
 						 "ERFOFF: %d times TcbBusyQueue[%d] = %d !\n",
 						 MAX_DOZE_WAITING_TIMES_9x,
 						 queue_id,
@@ -605,12 +605,12 @@ bool rtl92s_phy_set_rf_power_state(struct ieee80211_hw *hw,
 				}
 			}
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 				 "Set ERFSLEEP awaked:%d ms\n",
 				 jiffies_to_msecs(jiffies -
 						  ppsc->last_awake_jiffies));
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_DMESG,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_DMESG,
 				 "sleep awaked:%d ms state_inap:%x\n",
 				 jiffies_to_msecs(jiffies -
 						  ppsc->last_awake_jiffies),
@@ -968,7 +968,7 @@ u8 rtl92s_phy_config_rf(struct ieee80211_hw *hw, enum radio_path rfpath)
 		radio_b_tblen = RADIOB_ARRAYLENGTH;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD, "Radio No %x\n", rfpath);
 	rtstatus = true;
 
 	switch (rfpath) {
@@ -1088,7 +1088,7 @@ void rtl92s_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 			ROFDM0_XCAGCCORE1, MASKBYTE0);
 	rtlphy->default_initialgain[3] = rtl_get_bbreg(hw,
 			ROFDM0_XDAGCCORE1, MASKBYTE0);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "Default initial gain (c50=0x%x, c58=0x%x, c60=0x%x, c68=0x%x)\n",
 		 rtlphy->default_initialgain[0],
 		 rtlphy->default_initialgain[1],
@@ -1099,7 +1099,7 @@ void rtl92s_phy_get_hw_reg_originalvalue(struct ieee80211_hw *hw)
 	rtlphy->framesync = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR3, MASKBYTE0);
 	rtlphy->framesync_c34 = rtl_get_bbreg(hw, ROFDM0_RXDETECTOR2,
 					      MASKDWORD);
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_INIT, DBG_LOUD,
 		 "Default framesync (0x%x) = 0x%x\n",
 		 ROFDM0_RXDETECTOR3, rtlphy->framesync);
 
@@ -1163,7 +1163,7 @@ void rtl92s_phy_set_txpower(struct ieee80211_hw *hw, u8	channel)
 	_rtl92s_phy_get_txpower_index(hw, channel, &cckpowerlevel[0],
 			&ofdmpowerlevel[0]);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 		 "Channel-%d, cckPowerLevel (A / B) = 0x%x / 0x%x, ofdmPowerLevel (A / B) = 0x%x / 0x%x\n",
 		 channel, cckpowerlevel[0], cckpowerlevel[1],
 		 ofdmpowerlevel[0], ofdmpowerlevel[1]);
@@ -1224,17 +1224,17 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 skip:
 	switch (rtlhal->current_fwcmd_io) {
 	case FW_CMD_RA_RESET:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_RESET\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_RESET\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_RESET);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_ACTIVE:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_ACTIVE\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_ACTIVE\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_ACTIVE);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_N:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_REFRESH_N\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_RA_REFRESH_N\n");
 		input = FW_RA_REFRESH;
 		rtl_write_dword(rtlpriv, WFM5, input);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
@@ -1242,7 +1242,7 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_BG:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG,
 			 "FW_CMD_RA_REFRESH_BG\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_RA_REFRESH);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
@@ -1250,21 +1250,21 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_N_COMB:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG,
 			 "FW_CMD_RA_REFRESH_N_COMB\n");
 		input = FW_RA_IOT_N_COMB;
 		rtl_write_dword(rtlpriv, WFM5, input);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_RA_REFRESH_BG_COMB:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG,
 			 "FW_CMD_RA_REFRESH_BG_COMB\n");
 		input = FW_RA_IOT_BG_COMB;
 		rtl_write_dword(rtlpriv, WFM5, input);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_IQK_ENABLE:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_IQK_ENABLE\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_IQK_ENABLE\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_IQK_ENABLE);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
@@ -1299,7 +1299,7 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		rtl_set_bbreg(hw, RCCK0_CCA, MASKBYTE2, 0xcd);
 		break;
 	case FW_CMD_LPS_ENTER:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_ENTER\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_ENTER\n");
 		current_aid = rtlpriv->mac80211.assoc_id;
 		rtl_write_dword(rtlpriv, WFM5, (FW_LPS_ENTER |
 				((current_aid | 0xc000) << 8)));
@@ -1308,17 +1308,17 @@ static void _rtl92s_phy_set_fwcmd_io(struct ieee80211_hw *hw)
 		 * turbo mode until driver leave LPS */
 		break;
 	case FW_CMD_LPS_LEAVE:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_LEAVE\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_LPS_LEAVE\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_LPS_LEAVE);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_ADD_A2_ENTRY:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_ADD_A2_ENTRY\n");
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_DMESG, "FW_CMD_ADD_A2_ENTRY\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_ADD_A2_ENTRY);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
 		break;
 	case FW_CMD_CTRL_DM_BY_DRIVER:
-		RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 			 "FW_CMD_CTRL_DM_BY_DRIVER\n");
 		rtl_write_dword(rtlpriv, WFM5, FW_CTRL_DM_BY_DRIVER);
 		rtl92s_phy_chk_fwcmd_iodone(hw);
@@ -1344,7 +1344,7 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 	u16	fw_cmdmap = FW_CMD_IO_QUERY(rtlpriv);
 	bool postprocessing = false;
 
-	RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 		 "Set FW Cmd(%#x), set_fwcmd_inprogress(%d)\n",
 		 fw_cmdio, rtlhal->set_fwcmd_inprogress);
 
@@ -1383,14 +1383,14 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 		 * DM map table in the future. */
 		switch (fw_cmdio) {
 		case FW_CMD_RA_INIT:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD, "RA init!!\n");
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD, "RA init!!\n");
 			fw_cmdmap |= FW_RA_INIT_CTL;
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			/* Clear control flag to sync with FW. */
 			FW_CMD_IO_CLR(rtlpriv, FW_RA_INIT_CTL);
 			break;
 		case FW_CMD_DIG_DISABLE:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Set DIG disable!!\n");
 			fw_cmdmap &= ~FW_DIG_ENABLE_CTL;
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
@@ -1398,14 +1398,14 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 		case FW_CMD_DIG_ENABLE:
 		case FW_CMD_DIG_RESUME:
 			if (!(rtlpriv->dm.dm_flag & HAL_DM_DIG_DISABLE)) {
-				RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+				RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 					 "Set DIG enable or resume!!\n");
 				fw_cmdmap |= (FW_DIG_ENABLE_CTL | FW_SS_CTL);
 				FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			}
 			break;
 		case FW_CMD_DIG_HALT:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Set DIG halt!!\n");
 			fw_cmdmap &= ~(FW_DIG_ENABLE_CTL | FW_SS_CTL);
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
@@ -1421,7 +1421,7 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 			fw_param |= ((thermalval << 24) |
 				     (rtlefuse->thermalmeter[0] << 16));
 
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "Set TxPwr tracking!! FwCmdMap(%#x), FwParam(%#x)\n",
 				 fw_cmdmap, fw_param);
 
@@ -1443,7 +1443,7 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 			/* Clear FW parameter in terms of RA parts. */
 			fw_param &= FW_RA_PARAM_CLR;
 
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "[FW CMD] [New Version] Set RA/IOT Comb in n mode!! FwCmdMap(%#x), FwParam(%#x)\n",
 				 fw_cmdmap, fw_param);
 
@@ -1531,7 +1531,7 @@ bool rtl92s_phy_set_fw_cmd(struct ieee80211_hw *hw, enum fwcmd_iotype fw_cmdio)
 			FW_CMD_IO_SET(rtlpriv, fw_cmdmap);
 			break;
 		case FW_CMD_PAPE_CONTROL:
-			RT_TRACE(rtlpriv, COMP_CMD, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_CMD, DBG_LOUD,
 				 "[FW CMD] Set PAPE Control\n");
 			fw_cmdmap &= ~FW_PAPE_CTL_BY_SW_HW;
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
index a37855f57e76..300f962d8d24 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rf.c
@@ -95,11 +95,11 @@ static void _rtl92s_get_powerbase(struct ieee80211_hw *hw, u8 *p_pwrlevel,
 	}
 
 	if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "40MHz finalpwr_idx (A / B) = 0x%x / 0x%x\n",
 			 p_final_pwridx[0], p_final_pwridx[1]);
 	} else {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "20MHz finalpwr_idx (A / B) = 0x%x / 0x%x\n",
 			 p_final_pwridx[0], p_final_pwridx[1]);
 	}
@@ -124,7 +124,7 @@ static void _rtl92s_set_antennadiff(struct ieee80211_hw *hw,
 		if (ant_pwr_diff < -8)
 			ant_pwr_diff = -8;
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Antenna Diff from RF-B to RF-A = %d (0x%x)\n",
 			 ant_pwr_diff, ant_pwr_diff & 0xf);
 
@@ -143,7 +143,7 @@ static void _rtl92s_set_antennadiff(struct ieee80211_hw *hw,
 	rtl_set_bbreg(hw, RFPGA0_TXGAINSTAGE, (BXBTXAGC | BXCTXAGC | BXDTXAGC),
 		      u4reg_val);
 
-	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "Write BCD-Diff(0x%x) = 0x%x\n",
+	RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD, "Write BCD-Diff(0x%x) = 0x%x\n",
 		 RFPGA0_TXGAINSTAGE, u4reg_val);
 }
 
@@ -169,7 +169,7 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 		writeval = rtlphy->mcs_offset[chnlgroup][index] +
 				((index < 2) ? pwrbase0 : pwrbase1);
 
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "RTK better performance, writeval = 0x%x\n", writeval);
 		break;
 	case 1:
@@ -178,7 +178,7 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
 			writeval = ((index < 2) ? pwrbase0 : pwrbase1);
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "Realtek regulatory, 40MHz, writeval = 0x%x\n",
 				 writeval);
 		} else {
@@ -199,7 +199,7 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 					+ ((index < 2) ?
 					pwrbase0 : pwrbase1);
 
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "Realtek regulatory, 20MHz, writeval = 0x%x\n",
 				 writeval);
 		}
@@ -207,7 +207,7 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 	case 2:
 		/* Better regulatory don't increase any power diff */
 		writeval = ((index < 2) ? pwrbase0 : pwrbase1);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Better regulatory, writeval = 0x%x\n", writeval);
 		break;
 	case 3:
@@ -216,12 +216,12 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 		chnlgroup = 0;
 
 		if (rtlphy->current_chan_bw == HT_CHANNEL_WIDTH_20_40) {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "customer's limit, 40MHz = 0x%x\n",
 				 rtlefuse->pwrgroup_ht40
 				 [RF90_PATH_A][chnl - 1]);
 		} else {
-			RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+			RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 				 "customer's limit, 20MHz = 0x%x\n",
 				 rtlefuse->pwrgroup_ht20
 				 [RF90_PATH_A][chnl - 1]);
@@ -256,19 +256,19 @@ static void _rtl92s_get_txpower_writeval_byregulatory(struct ieee80211_hw *hw,
 				(pwrdiff_limit[2] << 16) |
 				(pwrdiff_limit[1] << 8) |
 				(pwrdiff_limit[0]);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Customer's limit = 0x%x\n", customer_limit);
 
 		writeval = customer_limit + ((index < 2) ?
 					     pwrbase0 : pwrbase1);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "Customer, writeval = 0x%x\n", writeval);
 		break;
 	default:
 		chnlgroup = 0;
 		writeval = rtlphy->mcs_offset[chnlgroup][index] +
 				((index < 2) ? pwrbase0 : pwrbase1);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD,
+		RT_DEBUG(rtlpriv, COMP_POWER, DBG_LOUD,
 			 "RTK better performance, writeval = 0x%x\n", writeval);
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index 7a54497b7df2..cbc52a3f20c4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -65,7 +65,7 @@ static void rtl92se_fw_cb(const struct firmware *firmware, void *context)
 	struct rt_firmware *pfirmware = NULL;
 	char *fw_name = "rtlwifi/rtl8192sefw.bin";
 
-	RT_TRACE(rtlpriv, COMP_ERR, DBG_LOUD,
+	RT_DEBUG(rtlpriv, COMP_ERR, DBG_LOUD,
 			 "Firmware callback routine entered!\n");
 	complete(&rtlpriv->firmware_loading_complete);
 	if (!firmware) {
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index 9eaa5348b556..99a5cddc1de4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -333,7 +333,7 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 	u8 bw_40 = 0;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
@@ -488,7 +488,7 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 	/* DOWRD 8 */
 	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
@@ -504,7 +504,7 @@ void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc8,
 			PCI_DMA_TODEVICE);
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
+		RT_DEBUG(rtlpriv, COMP_SEND, DBG_TRACE,
 			 "DMA mapping error\n");
 		return;
 	}
-- 
2.27.0

