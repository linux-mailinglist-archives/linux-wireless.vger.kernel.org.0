Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF4B105C60
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfKUVzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45161 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUVzX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:23 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so4349160otk.12
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nnw1q8sJZyw0KajZOwPztV0UUuhBRaPHcEBkHBRFl1k=;
        b=fSUTuf+Gm6o5QEXdK5RJb49Zrne9vd/HDHEM0TswwkKzcOr6Nu+wh1NjDUe2XGkfaK
         R0JTadA4blKdXwDKlYVKNLrgQ8G9pg2mS9NTf1i/Vg8RUuNlBD+YpOWi47UaOWKyq3zD
         64qzusJVQkie9H4kPN4ReuoXerbPKGwKPcEeGfDjhyfS+wqNq7tHLgbEJ6WZog7Qkhd6
         4EkRCYrwocTorTv80xIzOW/9XNKFVdThESGvKdHBaueb+2QXxlvC9KqjO6JF2VcimtPh
         Ieb5e32XKEX1qQQBFBbkKAqlcHSCnq1/YnwDLffExwxpepfQyUR1D3dHUXwREJGuJeY9
         mCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Nnw1q8sJZyw0KajZOwPztV0UUuhBRaPHcEBkHBRFl1k=;
        b=E6Ws+nAE4/PZT3mR/zzqpobrZkDfu2YYngnVqW+hf4/fF01XYBYfKvQjsoX7axip/S
         T2grNuXvlxvCDJ6jpFSFRP4yGNg7efr/n7SLF49w7+CtKadvGpEPjqmVHPJBxIfHvNmm
         6JXl7Q9B68r/sfpcrc3u3kuY1PXXX/lUj7XwZCXwGLlHjtMM+Vn09fukYQiDEgO3KLYz
         1F/46I/1XxwiMwvP30u/gb+HWcsfNbX4YC9JGLvYkQrv8MvpVxEvZkvlEbeqPk5CgESB
         bk7KSdI13e9doVBaulodzRhPw1Tpae3F/bcw0PrMB5l4tzenSRga/01oghX2fHD/qkm4
         +xXw==
X-Gm-Message-State: APjAAAWCzP+yY1cc7GwRtARsfGiWIrWdr6CSSoXySwCZmaWUy57DVBo0
        Sse1/HxUk48p0a6WDtUX72mkNup5
X-Google-Smtp-Source: APXvYqydBjaGjlcZeOd3MlFR+XVV3JvsvCzSHL5thSZNTI7Y1toa7Jmtci3xUzNIw6gpInI+Zxq7xw==
X-Received: by 2002:a05:6830:4c5:: with SMTP id s5mr8305548otd.140.1574373321685;
        Thu, 21 Nov 2019 13:55:21 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:21 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/9] rtlwifi: rtl8192ce: rtl8192c_com: Remove usage of private bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:08 -0600
Message-Id: <20191121215514.5509-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
References: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
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
 .../realtek/rtlwifi/rtl8192c/dm_common.c      | 19 +++++++++----------
 .../realtek/rtlwifi/rtl8192c/fw_common.h      | 14 +++++++-------
 .../wireless/realtek/rtlwifi/rtl8192ce/hw.c   | 11 +++++------
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index 4bef237f488d..06fc9b5cdd8f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -8,11 +8,11 @@
 #include "../base.h"
 #include "../core.h"
 
-#define BT_RSSI_STATE_NORMAL_POWER	BIT_OFFSET_LEN_MASK_32(0, 1)
-#define BT_RSSI_STATE_AMDPU_OFF		BIT_OFFSET_LEN_MASK_32(1, 1)
-#define BT_RSSI_STATE_SPECIAL_LOW	BIT_OFFSET_LEN_MASK_32(2, 1)
-#define BT_RSSI_STATE_BG_EDCA_LOW	BIT_OFFSET_LEN_MASK_32(3, 1)
-#define BT_RSSI_STATE_TXPOWER_LOW	BIT_OFFSET_LEN_MASK_32(4, 1)
+#define BT_RSSI_STATE_NORMAL_POWER	BIT(0)
+#define BT_RSSI_STATE_AMDPU_OFF		BIT(1)
+#define BT_RSSI_STATE_SPECIAL_LOW	BIT(2)
+#define BT_RSSI_STATE_BG_EDCA_LOW	BIT(3)
+#define BT_RSSI_STATE_TXPOWER_LOW	BIT(4)
 #define BT_MASK				0x00ffffff
 
 #define RTLPRIV			(struct rtl_priv *)
@@ -1515,7 +1515,7 @@ static bool rtl92c_bt_state_change(struct ieee80211_hw *hw)
 	    polling == 0xffffffff && bt_state == 0xff)
 		return false;
 
-	bt_state &= BIT_OFFSET_LEN_MASK_32(0, 1);
+	bt_state &= BIT(0);
 	if (bt_state != rtlpriv->btcoexist.bt_cur_state) {
 		rtlpriv->btcoexist.bt_cur_state = bt_state;
 
@@ -1524,8 +1524,7 @@ static bool rtl92c_bt_state_change(struct ieee80211_hw *hw)
 
 			bt_state = bt_state |
 			  ((rtlpriv->btcoexist.bt_ant_isolation == 1) ?
-			  0 : BIT_OFFSET_LEN_MASK_32(1, 1)) |
-			  BIT_OFFSET_LEN_MASK_32(2, 1);
+			  0 : BIT(1)) | BIT(2);
 			rtl_write_byte(rtlpriv, 0x4fd, bt_state);
 		}
 		return true;
@@ -1555,9 +1554,9 @@ static bool rtl92c_bt_state_change(struct ieee80211_hw *hw)
 			rtlpriv->btcoexist.bt_service = cur_service_type;
 			bt_state = bt_state |
 			   ((rtlpriv->btcoexist.bt_ant_isolation == 1) ?
-			   0 : BIT_OFFSET_LEN_MASK_32(1, 1)) |
+			   0 : BIT(1)) |
 			   ((rtlpriv->btcoexist.bt_service != BT_IDLE) ?
-			   0 : BIT_OFFSET_LEN_MASK_32(2, 1));
+			   0 : BIT(2));
 
 			/* Add interrupt migration when bt is not ini
 			 * idle state (no traffic). */
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.h
index 888d9fc94bc2..706fc753dfe6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/fw_common.h
@@ -46,19 +46,19 @@
 #define pagenum_128(_len)	(u32)(((_len)>>7) + ((_len)&0x7F ? 1 : 0))
 
 #define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)(__ph2ccmd) = __val
 #define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_PWRMODE_PARM_BCN_PASS_TIME(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 #define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)(__ph2ccmd) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)(__ph2ccmd) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 
 int rtl92c_download_fw(struct ieee80211_hw *hw);
 void rtl92c_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
index a52dd64d528d..6402a9e09be7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/hw.c
@@ -2299,13 +2299,12 @@ void rtl8192ce_bt_hw_init(struct ieee80211_hw *hw)
 		if (rtlpriv->btcoexist.bt_ant_isolation)
 			rtl_write_byte(rtlpriv, REG_GPIO_MUXCFG, 0xa0);
 
-		u1_tmp = rtl_read_byte(rtlpriv, 0x4fd) &
-			 BIT_OFFSET_LEN_MASK_32(0, 1);
+		u1_tmp = rtl_read_byte(rtlpriv, 0x4fd) & BIT(0);
 		u1_tmp = u1_tmp |
 			 ((rtlpriv->btcoexist.bt_ant_isolation == 1) ?
-			 0 : BIT_OFFSET_LEN_MASK_32(1, 1)) |
+			 0 : BIT(1)) |
 			 ((rtlpriv->btcoexist.bt_service == BT_SCO) ?
-			 0 : BIT_OFFSET_LEN_MASK_32(2, 1));
+			 0 : BIT(2));
 		rtl_write_byte(rtlpriv, 0x4fd, u1_tmp);
 
 		rtl_write_dword(rtlpriv, REG_BT_COEX_TABLE+4, 0xaaaa9aaa);
@@ -2315,11 +2314,11 @@ void rtl8192ce_bt_hw_init(struct ieee80211_hw *hw)
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

