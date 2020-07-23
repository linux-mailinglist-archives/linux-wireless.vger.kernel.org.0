Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50C122B7F9
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgGWUm4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 16:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgGWUmy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 16:42:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B59AC0619E3
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l63so6171558oih.13
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jul 2020 13:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIgKsqJpO3bccFr06heOx14f8XzFvp1NM7oU54oo86c=;
        b=M8mlXitbPfvOGqg6108qpVdp0D0yYKVhN+JbvZr5/tRZ7EhVEHPEJDQHXYXEl1BcJp
         YyoWQ2uQRajAUWjpkTkMMz0lE8Dws2MoFLWgaycOopZyHREtcNRZSvT6Mm3MrNBXravS
         UrYwFO+hpaOjavgi8E8NjEfPNLVH/yQr1Yg9EFyUG5KSR4ugenyq2ifioA3Sc/iZc1lz
         F/mBofX1a4LR47yEQB1BqFZ9Rl/vkC8TRTXmLVuqXa7wkCdPFVVu/igw7MFi9a2eozDY
         dVSt0HrAu4ccoZ16MYit7gVh0qH3MqqgYlfMRoldBh0PcuBMs2PWsLM+G60RHhpYateV
         X/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jIgKsqJpO3bccFr06heOx14f8XzFvp1NM7oU54oo86c=;
        b=uIYE0rRcj/VDE4ELldXdygx6m44TsN87q2kiB+rHfg/ZibH2OSPNeF0xqcmf07UrPv
         5ZEo1uBResvmEIqGPY/5Lyg2+9xPoQXC0PZBKbKMexkVG/mUmlYo65zEUO/qTHygIDkM
         a+BzMB4H+qWyXNep+/GW+f2vY0/rPFDL80MuWV9Y1oA/mD5VKYxcK28seFiZ+n/vLBPu
         Z0GEA7Bsc7PSn+5l538ExLq4cVtom2UilzVhYevU197avjf6Z4hLrHRZuRQYUcfJWwhC
         IkF25syUy/ltglnPOIk3dp4LO8HmCr75RFkRHegIQdhVZUWg5Y2wDmw+2HUEGr6SL/Y/
         uLeg==
X-Gm-Message-State: AOAM530Q28YeldlI+Ne+7QCOOEXar9aqUhRhZnjrKj29jTAwrh8bmkvH
        GutfjgDhLXDAr+HVaJIRRTYRjVez
X-Google-Smtp-Source: ABdhPJzDaRAI4DE4H8WxeFzwj2wZmcfVuzgQBJDkCs7n1pOnW4cS+4GJRcAr0QcxoZyK+IRrfzKPhA==
X-Received: by 2002:a54:4e9a:: with SMTP id c26mr5179926oiy.108.1595536973413;
        Thu, 23 Jul 2020 13:42:53 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x9sm857498ota.9.2020.07.23.13.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:42:53 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 06/15] rtlwifi: rtl8192ce: Rename RT_TRACE to rtl_dbg
Date:   Thu, 23 Jul 2020 15:42:35 -0500
Message-Id: <20200723204244.24457-7-Larry.Finger@lwfinger.net>
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
rtl8192ce. Changes suggested by ckeckpatch.pl have been made.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - rtl_dbg is used rather than RTL_DEBUG
---
 .../wireless/realtek/rtlwifi/rtl8192ce/dm.c   |  40 ++--
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 176 +++++++++---------
 .../wireless/realtek/rtlwifi/rtl8192ce/led.c  |  12 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/phy.c  | 121 ++++++------
 .../wireless/realtek/rtlwifi/rtl8192ce/rf.c   |   6 +-
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.c  |  14 +-
 6 files changed, 184 insertions(+), 185 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/dm.c
index a3e2c8a60967..34a730a0d81e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/dm.c
@@ -28,8 +28,8 @@ void rtl92ce_dm_dynamic_txpower(struct ieee80211_hw *hw)
 
 	if ((mac->link_state < MAC80211_LINKED) &&
 	    (rtlpriv->dm.entry_min_undec_sm_pwdb == 0)) {
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Not connected to any\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Not connected to any\n");
 
 		rtlpriv->dm.dynamic_txhighpower_lvl = TXHIGHPWRLEVEL_NORMAL;
 
@@ -40,43 +40,43 @@ void rtl92ce_dm_dynamic_txpower(struct ieee80211_hw *hw)
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
-			 rtlphy->current_channel);
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_LOUD,
+			"PHY_SetTxPowerLevel8192S() Channel = %d\n",
+			rtlphy->current_channel);
 		rtl92c_phy_set_txpower_level(hw, rtlphy->current_channel);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index 6402a9e09be7..d4cd186036fd 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -183,8 +183,8 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 	case HW_VAR_SLOT_TIME:{
 			u8 e_aci;
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "HW_VAR_SLOT_TIME %x\n", val[0]);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"HW_VAR_SLOT_TIME %x\n", val[0]);
 
 			rtl_write_byte(rtlpriv, REG_SLOT, val[0]);
 
@@ -223,9 +223,9 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
 				*val = min_spacing_to_set;
 
-				RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-					 "Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
-					 mac->min_space_cfg);
+				rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+					"Set HW_VAR_AMPDU_MIN_SPACE: %#x\n",
+					mac->min_space_cfg);
 
 				rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 					       mac->min_space_cfg);
@@ -238,9 +238,9 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 			density_to_set = *val;
 			mac->min_space_cfg |= (density_to_set << 3);
 
-			RT_TRACE(rtlpriv, COMP_MLME, DBG_LOUD,
-				 "Set HW_VAR_SHORTGI_DENSITY: %#x\n",
-				 mac->min_space_cfg);
+			rtl_dbg(rtlpriv, COMP_MLME, DBG_LOUD,
+				"Set HW_VAR_SHORTGI_DENSITY: %#x\n",
+				mac->min_space_cfg);
 
 			rtl_write_byte(rtlpriv, REG_AMPDU_MIN_SPACE,
 				       mac->min_space_cfg);
@@ -287,9 +287,9 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
 
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
@@ -326,9 +326,9 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -349,9 +349,9 @@ void rtl92ce_set_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
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
@@ -690,15 +690,15 @@ static bool _rtl92ce_init_mac(struct ieee80211_hw *hw)
 	udelay(2);
 
 	retry = 0;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "reg0xec:%x:%x\n",
-		 rtl_read_dword(rtlpriv, 0xEC), bytetmp);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "reg0xec:%x:%x\n",
+		rtl_read_dword(rtlpriv, 0xEC), bytetmp);
 
 	while ((bytetmp & BIT(0)) && retry < 1000) {
 		retry++;
 		udelay(50);
 		bytetmp = rtl_read_byte(rtlpriv, REG_APS_FSMCO + 1);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "reg0xec:%x:%x\n",
-			 rtl_read_dword(rtlpriv, 0xEC), bytetmp);
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "reg0xec:%x:%x\n",
+			rtl_read_dword(rtlpriv, 0xEC), bytetmp);
 		udelay(50);
 	}
 
@@ -880,14 +880,14 @@ void rtl92ce_enable_hw_security_config(struct ieee80211_hw *hw)
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
 
@@ -902,8 +902,8 @@ void rtl92ce_enable_hw_security_config(struct ieee80211_hw *hw)
 
 	rtl_write_byte(rtlpriv, REG_CR + 1, 0x02);
 
-	RT_TRACE(rtlpriv, COMP_SEC, DBG_LOUD,
-		 "The SECR-value %x\n", sec_reg_value);
+	rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+		"The SECR-value %x\n", sec_reg_value);
 
 	rtlpriv->cfg->ops->set_hw_reg(hw, HW_VAR_WPA_CONFIG, &sec_reg_value);
 
@@ -946,8 +946,8 @@ int rtl92ce_hw_init(struct ieee80211_hw *hw)
 
 	err = rtl92c_download_fw(hw);
 	if (err) {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Failed to download FW. Init HW without FW now..\n");
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Failed to download FW. Init HW without FW now..\n");
 		err = 1;
 		goto exit;
 	}
@@ -1013,12 +1013,12 @@ int rtl92ce_hw_init(struct ieee80211_hw *hw)
 	tmp_u1b = efuse_read_1byte(hw, 0x1FA);
 	if (!(tmp_u1b & BIT(0))) {
 		rtl_set_rfreg(hw, RF90_PATH_A, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path A\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path A\n");
 	}
 
 	if (!(tmp_u1b & BIT(1)) && is92c) {
 		rtl_set_rfreg(hw, RF90_PATH_B, 0x15, 0x0F, 0x05);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path B\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "PA BIAS path B\n");
 	}
 
 	if (!(tmp_u1b & BIT(4))) {
@@ -1027,7 +1027,7 @@ int rtl92ce_hw_init(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x80);
 		udelay(10);
 		rtl_write_byte(rtlpriv, 0x16, tmp_u1b | 0x90);
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "under 1.5V\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "under 1.5V\n");
 	}
 	rtl92c_dm_init(hw);
 exit:
@@ -1122,8 +1122,8 @@ static enum version_8192c _rtl92ce_read_chip_version(struct ieee80211_hw *hw)
 		break;
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_LOUD, "Chip RF Type: %s\n",
-		 rtlphy->rf_type == RF_2T2R ? "RF_2T2R" : "RF_1T1R");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "Chip RF Type: %s\n",
+		rtlphy->rf_type == RF_2T2R ? "RF_2T2R" : "RF_1T1R");
 
 	return version;
 }
@@ -1141,30 +1141,30 @@ static int _rtl92ce_set_media_status(struct ieee80211_hw *hw,
 	switch (type) {
 	case NL80211_IFTYPE_UNSPECIFIED:
 		mode = MSR_NOLINK;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to NO LINK!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to NO LINK!\n");
 		break;
 	case NL80211_IFTYPE_ADHOC:
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
 	case NL80211_IFTYPE_MESH_POINT:
 		mode = MSR_ADHOC;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Set Network type to Mesh Point!\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Set Network type to Mesh Point!\n");
 		break;
 	default:
 		pr_err("Network type %d not supported!\n", type);
@@ -1190,9 +1190,9 @@ static int _rtl92ce_set_media_status(struct ieee80211_hw *hw,
 		_rtl92ce_resume_tx_beacon(hw);
 		_rtl92ce_disable_bcn_sub_func(hw);
 	} else {
-		RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-			 "Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
-			 mode);
+		rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+			"Set HW_VAR_MEDIA_STATUS: No such media status(%x).\n",
+			mode);
 	}
 	rtl_write_byte(rtlpriv, MSR, bt_msr | mode);
 
@@ -1393,8 +1393,8 @@ void rtl92ce_set_beacon_interval(struct ieee80211_hw *hw)
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
 	u16 bcn_interval = mac->beacon_interval;
 
-	RT_TRACE(rtlpriv, COMP_BEACON, DBG_DMESG,
-		 "beacon_interval:%d\n", bcn_interval);
+	rtl_dbg(rtlpriv, COMP_BEACON, DBG_DMESG,
+		"beacon_interval:%d\n", bcn_interval);
 	rtl92ce_disable_interrupt(hw);
 	rtl_write_word(rtlpriv, REG_BCN_INTERVAL, bcn_interval);
 	rtl92ce_enable_interrupt(hw);
@@ -1406,8 +1406,8 @@ void rtl92ce_update_interrupt_mask(struct ieee80211_hw *hw,
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	struct rtl_pci *rtlpci = rtl_pcidev(rtl_pcipriv(hw));
 
-	RT_TRACE(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
-		 add_msr, rm_msr);
+	rtl_dbg(rtlpriv, COMP_INTR, DBG_LOUD, "add_msr:%x, rm_msr:%x\n",
+		add_msr, rm_msr);
 
 	if (add_msr)
 		rtlpci->irq_mask[0] |= add_msr;
@@ -1714,8 +1714,8 @@ static void _rtl92ce_hal_customized_behavior(struct ieee80211_hw *hw)
 	default:
 		break;
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_DMESG,
-		 "RT Customized ID: 0x%02X\n", rtlhal->oem_id);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_DMESG,
+		"RT Customized ID: 0x%02X\n", rtlhal->oem_id);
 }
 
 void rtl92ce_read_eeprom_info(struct ieee80211_hw *hw)
@@ -1732,18 +1732,18 @@ void rtl92ce_read_eeprom_info(struct ieee80211_hw *hw)
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
 		_rtl92ce_read_adapter_info(hw);
 	} else {
@@ -1839,8 +1839,8 @@ static void rtl92ce_update_hal_rate_table(struct ieee80211_hw *hw,
 
 	rtl_write_dword(rtlpriv, REG_ARFR0 + ratr_index * 4, ratr_value);
 
-	RT_TRACE(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
-		 rtl_read_dword(rtlpriv, REG_ARFR0));
+	rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG, "%x\n",
+		rtl_read_dword(rtlpriv, REG_ARFR0));
 }
 
 static void rtl92ce_update_hal_rate_mask(struct ieee80211_hw *hw,
@@ -1962,14 +1962,14 @@ static void rtl92ce_update_hal_rate_mask(struct ieee80211_hw *hw,
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
 	rtl92c_fill_h2c_cmd(hw, H2C_RA_MASK, 5, rate_mask);
 }
 
@@ -2031,15 +2031,15 @@ bool rtl92ce_gpio_radio_on_off_checking(struct ieee80211_hw *hw, u8 *valid)
 	e_rfpowerstate_toset = (u1tmp & BIT(3)) ? ERFON : ERFOFF;
 
 	if ((ppsc->hwradiooff) && (e_rfpowerstate_toset == ERFON)) {
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
@@ -2090,7 +2090,7 @@ void rtl92ce_set_key(struct ieee80211_hw *hw, u32 key_index,
 		u8 cam_offset = 0;
 		u8 clear_number = 5;
 
-		RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
+		rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG, "clear_all\n");
 
 		for (idx = 0; idx < clear_number; idx++) {
 			rtl_cam_mark_invalid(hw, cam_offset + idx);
@@ -2150,24 +2150,24 @@ void rtl92ce_set_key(struct ieee80211_hw *hw, u32 key_index,
 		}
 
 		if (rtlpriv->sec.key_len[key_index] == 0) {
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "delete one entry, entry_id is %d\n",
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"delete one entry, entry_id is %d\n",
 				 entry_id);
 			if (mac->opmode == NL80211_IFTYPE_AP ||
 			    mac->opmode == NL80211_IFTYPE_MESH_POINT)
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
-
-			RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-				 "add one entry\n");
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"The insert KEY length is %d\n",
+				rtlpriv->sec.key_len[PAIRWISE_KEYIDX]);
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_LOUD,
+				"The insert KEY is %x %x\n",
+				rtlpriv->sec.key_buf[0][0],
+				rtlpriv->sec.key_buf[0][1]);
+
+			rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+				"add one entry\n");
 			if (is_pairwise) {
 				RT_PRINT_DATA(rtlpriv, COMP_SEC, DBG_LOUD,
 					      "Pairwise Key content",
@@ -2175,8 +2175,8 @@ void rtl92ce_set_key(struct ieee80211_hw *hw, u32 key_index,
 					      rtlpriv->sec.
 					      key_len[PAIRWISE_KEYIDX]);
 
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set Pairwise key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set Pairwise key\n");
 
 				rtl_cam_add_one_entry(hw, macaddr, key_index,
 						      entry_id, enc_algo,
@@ -2184,8 +2184,8 @@ void rtl92ce_set_key(struct ieee80211_hw *hw, u32 key_index,
 						      rtlpriv->sec.
 						      key_buf[key_index]);
 			} else {
-				RT_TRACE(rtlpriv, COMP_SEC, DBG_DMESG,
-					 "set group key\n");
+				rtl_dbg(rtlpriv, COMP_SEC, DBG_DMESG,
+					"set group key\n");
 
 				if (mac->opmode == NL80211_IFTYPE_ADHOC) {
 					rtl_cam_add_one_entry(hw,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c
index d6933d36ada2..57132278eb5c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/led.c
@@ -19,8 +19,8 @@ void rtl92ce_sw_led_on(struct ieee80211_hw *hw, struct rtl_led *pled)
 	u8 ledcfg;
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
@@ -47,8 +47,8 @@ void rtl92ce_sw_led_off(struct ieee80211_hw *hw, struct rtl_led *pled)
 	struct rtl_priv *rtlpriv = rtl_priv(hw);
 	u8 ledcfg;
 
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
-		 REG_LEDCFG2, pled->ledpin);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "LedAddr:%X ledpin=%d\n",
+		REG_LEDCFG2, pled->ledpin);
 
 	ledcfg = rtl_read_byte(rtlpriv, REG_LEDCFG2);
 
@@ -119,7 +119,7 @@ void rtl92ce_led_control(struct ieee80211_hw *hw,
 	     ledaction == LED_CTL_POWER_ON)) {
 		return;
 	}
-	RT_TRACE(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n",
-		 ledaction);
+	rtl_dbg(rtlpriv, COMP_LED, DBG_LOUD, "ledaction %d\n",
+		ledaction);
 	_rtl92ce_sw_led_control(hw, ledaction);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c
index f6574f31fa3b..04735da11168 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/phy.c
@@ -25,9 +25,9 @@ u32 rtl92c_phy_query_rf_reg(struct ieee80211_hw *hw,
 	u32 original_value, readback_value, bitshift;
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
-		 regaddr, rfpath, bitmask);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x)\n",
+		regaddr, rfpath, bitmask);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -44,9 +44,9 @@ u32 rtl92c_phy_query_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
-		 regaddr, rfpath, bitmask, original_value);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), rfpath(%#x), bitmask(%#x), original_value(%#x)\n",
+		regaddr, rfpath, bitmask, original_value);
 
 	return readback_value;
 }
@@ -99,9 +99,9 @@ void rtl92ce_phy_set_rf_reg(struct ieee80211_hw *hw,
 	struct rtl_phy *rtlphy = &(rtlpriv->phy);
 	u32 original_value, bitshift;
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 
 	spin_lock(&rtlpriv->locks.rf_lock);
 
@@ -132,9 +132,9 @@ void rtl92ce_phy_set_rf_reg(struct ieee80211_hw *hw,
 
 	spin_unlock(&rtlpriv->locks.rf_lock);
 
-	RT_TRACE(rtlpriv, COMP_RF, DBG_TRACE,
-		 "regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
-		 regaddr, bitmask, data, rfpath);
+	rtl_dbg(rtlpriv, COMP_RF, DBG_TRACE,
+		"regaddr(%#x), bitmask(%#x), data(%#x), rfpath(%#x)\n",
+		regaddr, bitmask, data, rfpath);
 }
 
 static bool _rtl92c_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
@@ -144,10 +144,10 @@ static bool _rtl92c_phy_config_mac_with_headerfile(struct ieee80211_hw *hw)
 	u32 arraylength;
 	u32 *ptrarray;
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Read Rtl819XMACPHY_Array\n");
 	arraylength = MAC_2T_ARRAYLENGTH;
 	ptrarray = RTL8192CEMAC_2T_ARRAY;
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Img:RTL8192CEMAC_2T_ARRAY\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Img:RTL8192CEMAC_2T_ARRAY\n");
 	for (i = 0; i < arraylength; i = i + 2)
 		rtl_write_byte(rtlpriv, ptrarray[i], (u8) ptrarray[i + 1]);
 	return true;
@@ -180,20 +180,20 @@ bool _rtl92ce_phy_config_bb_with_headerfile(struct ieee80211_hw *hw,
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
@@ -221,8 +221,8 @@ bool _rtl92ce_phy_config_bb_with_pgheaderfile(struct ieee80211_hw *hw,
 		}
 	} else {
 
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "configtype != BaseBand_Config_PHY_REG\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"configtype != BaseBand_Config_PHY_REG\n");
 	}
 	return true;
 }
@@ -243,21 +243,21 @@ bool rtl92c_phy_config_rf_with_headerfile(struct ieee80211_hw *hw,
 		radioa_array_table = RTL8192CERADIOA_2TARRAY;
 		radiob_arraylen = RADIOB_2TARRAYLENGTH;
 		radiob_array_table = RTL8192CE_RADIOB_2TARRAY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_A:RTL8192CERADIOA_2TARRAY\n");
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_B:RTL8192CE_RADIOB_2TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_A:RTL8192CERADIOA_2TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_B:RTL8192CE_RADIOB_2TARRAY\n");
 	} else {
 		radioa_arraylen = RADIOA_1TARRAYLENGTH;
 		radioa_array_table = RTL8192CE_RADIOA_1TARRAY;
 		radiob_arraylen = RADIOB_1TARRAYLENGTH;
 		radiob_array_table = RTL8192CE_RADIOB_1TARRAY;
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_A:RTL8192CE_RADIOA_1TARRAY\n");
-		RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-			 "Radio_B:RTL8192CE_RADIOB_1TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_A:RTL8192CE_RADIOA_1TARRAY\n");
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+			"Radio_B:RTL8192CE_RADIOB_1TARRAY\n");
 	}
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "Radio No %x\n", rfpath);
 	switch (rfpath) {
 	case RF90_PATH_A:
 		for (i = 0; i < radioa_arraylen; i = i + 2) {
@@ -293,9 +293,9 @@ void rtl92ce_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
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
@@ -348,7 +348,7 @@ void rtl92ce_phy_set_bw_mode_callback(struct ieee80211_hw *hw)
 	}
 	rtl92ce_phy_rf6052_set_bandwidth(hw, rtlphy->current_chan_bw);
 	rtlphy->set_bwmode_inprogress = false;
-	RT_TRACE(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
+	rtl_dbg(rtlpriv, COMP_SCAN, DBG_TRACE, "<==\n");
 }
 
 void _rtl92ce_phy_lc_calibrate(struct ieee80211_hw *hw, bool is2t)
@@ -418,8 +418,8 @@ static void _rtl92ce_phy_set_rf_sleep(struct ieee80211_hw *hw)
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
 		rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE3);
 		rtl_write_byte(rtlpriv, REG_TXPAUSE, 0x00);
-		RT_TRACE(rtlpriv, COMP_POWER, DBG_TRACE,
-			 "Switch RF timeout !!!\n");
+		rtl_dbg(rtlpriv, COMP_POWER, DBG_TRACE,
+			"Switch RF timeout !!!\n");
 		return;
 	}
 	rtl_write_byte(rtlpriv, REG_SYS_FUNC_EN, 0xE2);
@@ -446,18 +446,17 @@ static bool _rtl92ce_phy_set_rf_power_state(struct ieee80211_hw *hw,
 
 				do {
 					initializecount++;
-					RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-						 "IPS Set eRf nic enable\n");
+					rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+						"IPS Set eRf nic enable\n");
 					rtstatus = rtl_ps_enable_nic(hw);
 				} while (!rtstatus && (initializecount < 10));
 				RT_CLEAR_PS_LEVEL(ppsc,
 						  RT_RF_OFF_LEVL_HALT_NIC);
 			} else {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "Set ERFON sleeped:%d ms\n",
-					 jiffies_to_msecs(jiffies -
-							  ppsc->
-							  last_sleep_jiffies));
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"Set ERFON slept:%d ms\n",
+					jiffies_to_msecs(jiffies -
+						 ppsc->last_sleep_jiffies));
 				ppsc->last_awake_jiffies = jiffies;
 				rtl92ce_phy_set_rf_on(hw);
 			}
@@ -472,8 +471,8 @@ static bool _rtl92ce_phy_set_rf_power_state(struct ieee80211_hw *hw,
 		}
 	case ERFOFF:{
 			if (ppsc->reg_rfps_level & RT_RF_OFF_LEVL_HALT_NIC) {
-				RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-					 "IPS Set eRf nic disable\n");
+				rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+					"IPS Set eRf nic disable\n");
 				rtl_ps_disable_nic(hw);
 				RT_SET_PS_LEVEL(ppsc, RT_RF_OFF_LEVL_HALT_NIC);
 			} else {
@@ -498,27 +497,27 @@ static bool _rtl92ce_phy_set_rf_power_state(struct ieee80211_hw *hw,
 					queue_id++;
 					continue;
 				} else {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
-						 i + 1, queue_id,
-						 skb_queue_len(&ring->queue));
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"eRf Off/Sleep: %d times TcbBusyQueue[%d] =%d before doze!\n",
+						i + 1, queue_id,
+						skb_queue_len(&ring->queue));
 
 					udelay(10);
 					i++;
 				}
 				if (i >= MAX_DOZE_WAITING_TIMES_9x) {
-					RT_TRACE(rtlpriv, COMP_ERR, DBG_WARNING,
-						 "ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
-						 MAX_DOZE_WAITING_TIMES_9x,
-						 queue_id,
-						 skb_queue_len(&ring->queue));
+					rtl_dbg(rtlpriv, COMP_ERR, DBG_WARNING,
+						"ERFSLEEP: %d times TcbBusyQueue[%d] = %d !\n",
+						MAX_DOZE_WAITING_TIMES_9x,
+						queue_id,
+						skb_queue_len(&ring->queue));
 					break;
 				}
 			}
-			RT_TRACE(rtlpriv, COMP_RF, DBG_DMESG,
-				 "Set ERFSLEEP awaked:%d ms\n",
-				 jiffies_to_msecs(jiffies -
-						  ppsc->last_awake_jiffies));
+			rtl_dbg(rtlpriv, COMP_RF, DBG_DMESG,
+				"Set ERFSLEEP awaked:%d ms\n",
+				jiffies_to_msecs(jiffies -
+						 ppsc->last_awake_jiffies));
 			ppsc->last_sleep_jiffies = jiffies;
 			_rtl92ce_phy_set_rf_sleep(hw);
 			break;
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rf.c
index 713859488744..8508a711d46a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rf.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rf.c
@@ -470,13 +470,13 @@ static bool _rtl92ce_phy_rf6052_config_parafile(struct ieee80211_hw *hw)
 		}
 
 		if (!rtstatus) {
-			RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE,
-				 "Radio[%d] Fail!!\n", rfpath);
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
 			return false;
 		}
 
 	}
 
-	RT_TRACE(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
 	return rtstatus;
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
index 8fc3cb824066..29dd76e40887 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.c
@@ -368,8 +368,8 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 	u8 bw_40 = 0;
 
 	if (pci_dma_mapping_error(rtlpci->pdev, mapping)) {
-		RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-			 "DMA mapping error\n");
+		rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+			"DMA mapping error\n");
 		return;
 	}
 	rcu_read_lock();
@@ -477,8 +477,8 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 
 		if (ieee80211_is_data_qos(fc)) {
 			if (mac->rdg_en) {
-				RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE,
-					 "Enable RDG function\n");
+				rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE,
+					"Enable RDG function\n");
 				set_tx_desc_rdg_enable(pdesc, 1);
 				set_tx_desc_htc(pdesc, 1);
 			}
@@ -516,7 +516,7 @@ void rtl92ce_tx_fill_desc(struct ieee80211_hw *hw,
 		set_tx_desc_bmc(pdesc, 1);
 	}
 
-	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
+	rtl_dbg(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
 
 void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
@@ -536,8 +536,8 @@ void rtl92ce_tx_fill_cmddesc(struct ieee80211_hw *hw,
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

