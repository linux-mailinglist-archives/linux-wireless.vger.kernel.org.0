Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF23109567
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKYWJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:41 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40264 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKYWJl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:41 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so14077525otq.7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BT0bjR5BCUAX0zkJG0trnhNTEAUZ8FBH7uK07FJ4G2M=;
        b=r+VedVWtxCuUBmHO2XzxQgKcZgy1e/43Xqvlm/R60YBnfIZGtulSYOghDG68XZWchR
         Qzd2ra8eDyWdeMroWnRF4+aTr99ZflwRq3IVlGccrWlZ3xk2Zix+WJGPzNEAIVxmwgcB
         M+4OCOEn4NXp4rwBCfrAymyypRVGnUpcMGMxBgECLVzlBpHW/rVQZmahU1bZs04oQPcw
         zfbOHhAmyveRzLBsZtlcQfIcfUJDKoM/HZYISeM/OycwhJOa6nGQsT/J63MP0Pc8DpMH
         Rpaw97+OMoDkslFMSirjKw2jYz2NWyp7GzkzWjR2JxBXv9L6A/SMiNgJ0t0WPTSvA0k5
         pXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BT0bjR5BCUAX0zkJG0trnhNTEAUZ8FBH7uK07FJ4G2M=;
        b=GF4uhno2yY91D1pBTAm/9Nq/tNhbHyDOqj8T+GJvtVSeIA/AtULBso+r2envZewuiJ
         Tue95iJlIxKN7g7Ffg5yIqnlpFVT0CZrOrdbmteCduKvHmo/dR84ZPd8ZCubG2PYUJN5
         Cq4lZJVEhNUagxe4pX/A64665+Fz/zQRNv7KSHsR2Dexro9eXAOP4H7vTsQAxqgqBbk4
         yztfCXPhZfO9HfmuV5S7WEn1fMRGmJt+4Je2mDVqMYObnhlr/maL1OMxNfbmfQibjh7+
         Y8AeiLcdRl6W5eAxkjnd7+kmzuapUPv25/oRgfHEbArlOG3vYzLSHsczMSLcaNxwQjRV
         iG5g==
X-Gm-Message-State: APjAAAV2LNz3uL5P4/E3KH9MrJRaA4V6cW76kVLtPELdhilaqxfEKUkz
        dhrCVbnBM9bn09j+kaNkYdI=
X-Google-Smtp-Source: APXvYqyRHjqT91IPpQtfdQSMXu/HuDS5w3NvOoY8A4q1mkmPx71PACzcrUEA9dyyPVTLafbFGc1zfA==
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr14071oto.273.1574719779626;
        Mon, 25 Nov 2019 14:09:39 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:39 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 2/9] rtlwifi: rtl8188ee: Remove usage of private bit manipulation
Date:   Mon, 25 Nov 2019 16:09:27 -0600
Message-Id: <20191125220934.32693-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Besides the previously changes macros for the RX and TX descriptors.
the local macros are used in other places. These are replaced with
standard bit manipulation macros.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.c   |  12 +-
 .../wireless/realtek/rtlwifi/rtl8188ee/fw.h   | 103 +++++++-----------
 .../wireless/realtek/rtlwifi/rtl8188ee/hw.c   |  11 +-
 3 files changed, 49 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
index e2e0bfbc24fe..fc7b9ad7e5d0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.c
@@ -372,20 +372,20 @@ void rtl88e_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	u8 rlbm, power_state = 0;
 	RT_TRACE(rtlpriv, COMP_POWER, DBG_LOUD, "FW LPS mode = %d\n", mode);
 
-	SET_H2CCMD_PWRMODE_PARM_MODE(u1_h2c_set_pwrmode, ((mode) ? 1 : 0));
+	set_h2ccmd_pwrmode_parm_mode(u1_h2c_set_pwrmode, ((mode) ? 1 : 0));
 	rlbm = 0;/*YJ, temp, 120316. FW now not support RLBM=2.*/
-	SET_H2CCMD_PWRMODE_PARM_RLBM(u1_h2c_set_pwrmode, rlbm);
-	SET_H2CCMD_PWRMODE_PARM_SMART_PS(u1_h2c_set_pwrmode,
+	set_h2ccmd_pwrmode_parm_rlbm(u1_h2c_set_pwrmode, rlbm);
+	set_h2ccmd_pwrmode_parm_smart_ps(u1_h2c_set_pwrmode,
 		(rtlpriv->mac80211.p2p) ? ppsc->smart_ps : 1);
-	SET_H2CCMD_PWRMODE_PARM_AWAKE_INTERVAL(u1_h2c_set_pwrmode,
+	set_h2ccmd_pwrmode_parm_awake_interval(u1_h2c_set_pwrmode,
 		ppsc->reg_max_lps_awakeintvl);
-	SET_H2CCMD_PWRMODE_PARM_ALL_QUEUE_UAPSD(u1_h2c_set_pwrmode, 0);
+	set_h2ccmd_pwrmode_parm_all_queue_uapsd(u1_h2c_set_pwrmode, 0);
 	if (mode == FW_PS_ACTIVE_MODE)
 		power_state |= FW_PWR_STATE_ACTIVE;
 	else
 		power_state |= FW_PWR_STATE_RF_OFF;
 
-	SET_H2CCMD_PWRMODE_PARM_PWR_STATE(u1_h2c_set_pwrmode, power_state);
+	set_h2ccmd_pwrmode_parm_pwr_state(u1_h2c_set_pwrmode, power_state);
 
 	RT_PRINT_DATA(rtlpriv, COMP_CMD, DBG_DMESG,
 		      "rtl92c_set_fw_pwrmode(): u1_h2c_set_pwrmode\n",
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.h
index 39ddb7afea9d..79f095e47d71 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/fw.h
@@ -169,82 +169,55 @@ enum rtl8188e_h2c_cmd {
 	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
 
 
-#define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
-#define SET_H2CCMD_PWRMODE_PARM_RLBM(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 4, __value)
-#define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 4, 4, __value)
-#define SET_H2CCMD_PWRMODE_PARM_AWAKE_INTERVAL(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
-#define SET_H2CCMD_PWRMODE_PARM_ALL_QUEUE_UAPSD(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __value)
-#define SET_H2CCMD_PWRMODE_PARM_PWR_STATE(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+4, 0, 8, __value)
-#define GET_88E_H2CCMD_PWRMODE_PARM_MODE(__cmd)			\
-	LE_BITS_TO_1BYTE(__cmd, 0, 8)
+static inline void set_h2ccmd_pwrmode_parm_mode(u8 *__ph2ccmd, u8 __val)
+{
+	*(u8 *)(__ph2ccmd) = __val;
+}
+
+static inline void set_h2ccmd_pwrmode_parm_rlbm(u8 *__cmd, u8 __value)
+{
+	u8p_replace_bits(__cmd + 1, __value, GENMASK(3, 0));
+}
+
+static inline void set_h2ccmd_pwrmode_parm_smart_ps(u8 *__cmd, u8 __value)
+{
+	u8p_replace_bits(__cmd + 1, __value, GENMASK(7, 4));
+}
+
+static inline void set_h2ccmd_pwrmode_parm_awake_interval(u8 *__cmd, u8 __value)
+{
+	*(u8 *)(__cmd + 2) = __value;
+}
+
+static inline void set_h2ccmd_pwrmode_parm_all_queue_uapsd(u8 *__cmd,
+							   u8 __value)
+{
+	*(u8 *)(__cmd + 3) = __value;
+}
+
+static inline void set_h2ccmd_pwrmode_parm_pwr_state(u8 *__cmd, u8 __value)
+{
+	*(u8 *)(__cmd + 4) = __value;
+}
 
 #define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)(__ph2ccmd) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)(__ph2ccmd) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val;
 
 /* AP_OFFLOAD */
 #define SET_H2CCMD_AP_OFFLOAD_ON(__cmd, __value)			\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 8, __value)
+	*(u8 *)__cmd = __value;
 #define SET_H2CCMD_AP_OFFLOAD_HIDDEN(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
+	*(u8 *)(__cmd + 1) = __value;
 #define SET_H2CCMD_AP_OFFLOAD_DENYANY(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
+	*(u8 *)(__cmd + 2) = __value;
 #define SET_H2CCMD_AP_OFFLOAD_WAKEUP_EVT_RPT(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __value)
-
-/* Keep Alive Control*/
-#define SET_88E_H2CCMD_KEEP_ALIVE_ENABLE(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
-#define SET_88E_H2CCMD_KEEP_ALIVE_ACCPEPT_USER_DEFINED(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
-#define SET_88E_H2CCMD_KEEP_ALIVE_PERIOD(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
-
-/*REMOTE_WAKE_CTRL */
-#define SET_88E_H2CCMD_REMOTE_WAKE_CTRL_EN(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
-#if (USE_OLD_WOWLAN_DEBUG_FW == 0)
-#define SET_88E_H2CCMD_REMOTE_WAKE_CTRL_ARP_OFFLOAD_EN(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
-#define SET_88E_H2CCMD_REMOTE_WAKE_CTRL_NDP_OFFLOAD_EN(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE(__cmd, 2, 1, __value)
-#define SET_88E_H2CCMD_REMOTE_WAKE_CTRL_GTK_OFFLOAD_EN(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE(__cmd, 3, 1, __value)
-#else
-#define SET_88E_H2_REM_WAKE_ENC_ALG(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
-#define SET_88E_H2CCMD_REMOTE_WAKE_CTRL_GROUP_ENC_ALG(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
-#endif
-
-/* GTK_OFFLOAD */
-#define SET_88E_H2CCMD_AOAC_GLOBAL_INFO_PAIRWISE_ENC_ALG(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 8, __value)
-#define SET_88E_H2CCMD_AOAC_GLOBAL_INFO_GROUP_ENC_ALG(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
-
-/* AOAC_RSVDPAGE_LOC */
-#define SET_88E_H2CCMD_AOAC_RSVD_LOC_REM_WAKE_CTRL_INFO(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE((__cmd), 0, 8, __value)
-#define SET_88E_H2CCMD_AOAC_RSVDPAGE_LOC_ARP_RSP(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
-#define SET_88E_H2CCMD_AOAC_RSVDPAGE_LOC_NEIGHBOR_ADV(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
-#define SET_88E_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_RSP(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __value)
-#define SET_88E_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_INFO(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+4, 0, 8, __value)
+	*(u8 *)(__cmd + 3) = __value;
 
 int rtl88e_download_fw(struct ieee80211_hw *hw,
 		       bool buse_wake_on_wlan_fw);
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
index f92e95f5494f..70716631de85 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c
@@ -2486,13 +2486,12 @@ void rtl8188ee_bt_hw_init(struct ieee80211_hw *hw)
 		if (rtlpriv->btcoexist.bt_ant_isolation)
 			rtl_write_byte(rtlpriv, REG_GPIO_MUXCFG, 0xa0);
 
-		u1_tmp = rtl_read_byte(rtlpriv, 0x4fd) &
-			 BIT_OFFSET_LEN_MASK_32(0, 1);
+		u1_tmp = rtl_read_byte(rtlpriv, 0x4fd) & BIT(0);
 		u1_tmp = u1_tmp |
 			 ((rtlpriv->btcoexist.bt_ant_isolation == 1) ?
-			 0 : BIT_OFFSET_LEN_MASK_32(1, 1)) |
+			 0 : BIT((1)) |
 			 ((rtlpriv->btcoexist.bt_service == BT_SCO) ?
-			 0 : BIT_OFFSET_LEN_MASK_32(2, 1));
+			 0 : BIT(2)));
 		rtl_write_byte(rtlpriv, 0x4fd, u1_tmp);
 
 		rtl_write_dword(rtlpriv, REG_BT_COEX_TABLE+4, 0xaaaa9aaa);
@@ -2502,11 +2501,11 @@ void rtl8188ee_bt_hw_init(struct ieee80211_hw *hw)
 		/* Config to 1T1R. */
 		if (rtlphy->rf_type == RF_1T1R) {
 			u1_tmp = rtl_read_byte(rtlpriv, ROFDM0_TRXPATHENABLE);
-			u1_tmp &= ~(BIT_OFFSET_LEN_MASK_32(1, 1));
+			u1_tmp &= ~(BIT(1));
 			rtl_write_byte(rtlpriv, ROFDM0_TRXPATHENABLE, u1_tmp);
 
 			u1_tmp = rtl_read_byte(rtlpriv, ROFDM1_TRXPATHENABLE);
-			u1_tmp &= ~(BIT_OFFSET_LEN_MASK_32(1, 1));
+			u1_tmp &= ~(BIT(1));
 			rtl_write_byte(rtlpriv, ROFDM1_TRXPATHENABLE, u1_tmp);
 		}
 	}
-- 
2.24.0

