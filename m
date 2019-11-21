Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3E5105C5F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfKUVzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:22 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46370 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbfKUVzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so4344743otr.13
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XpVskNOHPTxwsrVr34yVRyYxarI8mGVzkjpwTzwmlrM=;
        b=fZfhCxH0fbOkiNxp3tkn613TNqwCjMrlEmru9wSfusO3uvXnE6Hex44XxkTSwj3GSE
         8jr/dQHYxR5NGarbt+FEax75pxEIoDqp4HuJpPk404d8pqXSITmD6ZrPgKwdW/2pFs8v
         5u6qrV79lLN274mHSCcrNcTkbkEjaZwU11VHN230lQjCQ3RLPXJasr4Yvr3mvcBK28v4
         xZFEw/PE/B7/+J+vE95qrrj6muBmLhQq2yT7FyqrEGzGz9mYAWub4Aofe7BcYW6e2zzH
         Yd++dcQ0GRB4li0oolaxNfNKNn12RdC4N5M/HL4SFkhBiyAJ+1GCl21myHkkd70QpiA3
         42tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XpVskNOHPTxwsrVr34yVRyYxarI8mGVzkjpwTzwmlrM=;
        b=KrSPuE85ZYNBbLqUINfRXPIluU8dZubLp5CotgM5fowDz6k+a/fBhCMdgKpuByaOhA
         3Txb/rrxkwBIsOw+n9D91yXw86/U+Xa0p0UVw//+Z0dkkOfkkhc3hvimU1KJMqpy36yG
         9KFEkfVAjw3SI0gw8FpdVSnTm9cAefSyCcOLc9zK/nuHChsqXJwYl3XHX/qNvD5bGT2O
         xTwPQcLCRADyjwA9yW6IkN3XqWN95U/oqBpf1W3z3rtI2VImRezN6XVzK+zVT6lvb0Gl
         Cm2QjBZhNzn+ShkWVDnlDF/agcG3FlFWZEfTeO36lbOxsxUZzrRwnjTgxp9tPtLtEEuF
         tbkA==
X-Gm-Message-State: APjAAAWuQ42KQ23csC7JacqrZOvsd07o0SACPKt0Ml5JEV0f9MuENMvz
        aw5ZPfDU9GmdQlGYFzhiwot5igDT
X-Google-Smtp-Source: APXvYqwk3M36xrwJqYrfweL4f8/vYR1yaRz3itsO+1oBhouWTQCT5Y9h7fS8YOwGIWm49gZTCs4RHQ==
X-Received: by 2002:a9d:1295:: with SMTP id g21mr8220346otg.301.1574373320059;
        Thu, 21 Nov 2019 13:55:20 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:19 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/9] rtlwifi: rtl8192de: Remove usage of private bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:06 -0600
Message-Id: <20191121215514.5509-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
References: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Besides the previously changes macros in trx.h, there are some of these
local macros in the driver. These are replaced with standard bit
manipulations. Unused macros are deleted.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192de/fw.h   | 61 +++----------------
 1 file changed, 7 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h
index bd8ea6d66dff..7f0a17c1a9ea 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/fw.h
@@ -16,73 +16,26 @@
 		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D2 ||  \
 		(GET_FIRMWARE_HDR_SIGNATURE(_pfwhdr) & 0xFFFF) == 0x92D3)
 
-/* Define a macro that takes an le32 word, converts it to host ordering,
- * right shifts by a specified count, creates a mask of the specified
- * bit count, and extracts that number of bits.
- */
-
-#define SHIFT_AND_MASK_LE(__pdesc, __shift, __mask)		\
-	((le32_to_cpu(*(((__le32 *)(__pdesc)))) >> (__shift)) &	\
-	BIT_LEN_MASK_32(__mask))
-
 /* Firmware Header(8-byte alinment required) */
 /* --- LONG WORD 0 ---- */
 #define GET_FIRMWARE_HDR_SIGNATURE(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr, 0, 16)
-#define GET_FIRMWARE_HDR_CATEGORY(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr, 16, 8)
-#define GET_FIRMWARE_HDR_FUNCTION(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr, 24, 8)
+	le32_get_bits(*(__le32 *)__fwhdr, GENMASK(15, 0))
 #define GET_FIRMWARE_HDR_VERSION(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr + 4, 0, 16)
+	le32_get_bits(*(__le32 *)(__fwhdr + 4), GENMASK(15, 0))
 #define GET_FIRMWARE_HDR_SUB_VER(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr + 4, 16, 8)
-#define GET_FIRMWARE_HDR_RSVD1(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 4, 24, 8)
-
-/* --- LONG WORD 1 ---- */
-#define GET_FIRMWARE_HDR_MONTH(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 8, 0, 8)
-#define GET_FIRMWARE_HDR_DATE(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 8, 8, 8)
-#define GET_FIRMWARE_HDR_HOUR(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 8, 16, 8)
-#define GET_FIRMWARE_HDR_MINUTE(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr + 8, 24, 8)
-#define GET_FIRMWARE_HDR_ROMCODE_SIZE(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr + 12, 0, 16)
-#define GET_FIRMWARE_HDR_RSVD2(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 12, 16, 16)
-
-/* --- LONG WORD 2 ---- */
-#define GET_FIRMWARE_HDR_SVN_IDX(__fwhdr)		\
-	SHIFT_AND_MASK_LE(__fwhdr + 16, 0, 32)
-#define GET_FIRMWARE_HDR_RSVD3(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 20, 0, 32)
-
-/* --- LONG WORD 3 ---- */
-#define GET_FIRMWARE_HDR_RSVD4(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 24, 0, 32)
-#define GET_FIRMWARE_HDR_RSVD5(__fwhdr)			\
-	SHIFT_AND_MASK_LE(__fwhdr + 28, 0, 32)
+	le32_get_bits(*(__le32 *)(__fwhdr + 4), GENMASK(23, 16))
 
 #define pagenum_128(_len) \
 	(u32)(((_len) >> 7) + ((_len) & 0x7F ? 1 : 0))
 
-#define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
-#define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 1, 0, 8, __val)
-#define SET_H2CCMD_PWRMODE_PARM_BCN_PASS_TIME(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 2, 0, 8, __val)
 #define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val;
 
 int rtl92d_download_fw(struct ieee80211_hw *hw);
 void rtl92d_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
-- 
2.24.0

