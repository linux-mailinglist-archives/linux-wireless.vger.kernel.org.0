Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396A9109566
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKYWJk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40263 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWJk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so14077501otq.7
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/JgyaFd2kJ4ze95lX2f4ERjek5rdMiHUnchu0ZXMe1o=;
        b=c6B9ckk8pSN9mByAk89S/7vDjUrCLeyKcJZzg8ZDZPT8vWgkLGFQzATmjzGKxJUk1z
         p+qk3TQ5wtT27G5BxPFW15GawpI+H2oQ4ctPKbKQWCT7QIXoWx7Dm0BL3rLZQxymIPkG
         IIJlYFNaRa27NyU/J4schEaVh6eQx9TDj9h36XM8AbzPtemR3dQsSMYVm3z1stVjnDRT
         DMF7dBXlKlR4zPr4phKQAGEsyaevO2MgQNqUtl7mokLWIYqXn/B4sN6CVVMCYVuR/99S
         exYTSUrPSojcHYiWGQru8ohEySHSzK2Og5kNqreCrdRzADVswYRcUOdxOYrYl8odadiU
         M4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/JgyaFd2kJ4ze95lX2f4ERjek5rdMiHUnchu0ZXMe1o=;
        b=ACwZS03zDE3Ao11uyZq4fpK49a5GXV7N4YEWPCwKcA/Q771HzjaS2twxIPptd9C8hP
         y/kg3IFd6Sf6hWukHdUFWOyrIuA1mjAzGh8SmQ3my5lGuugV0feeqWYNTC+quEOABUB5
         HJqQRndLCz/d4232S353V85luxCpTQ1F2z092HfE+9S5UoC4jRTsmuZNXVYjncRZH58X
         ekQQZXQIh0uJH71MoNBqDCGf4LpYzALQNve6z4gNSItv9a7Owb+tH9BBlFUW9xxwLGX2
         PakwTjMknxdAlDFJv2WSJeLvckcMYBU5G0AnjTfwao3mKe2XjD8ACaKW/+Osq0aUVCe7
         mAfw==
X-Gm-Message-State: APjAAAUu8STHjoOzs4+ehx9mbPdSS9ykS9QvJOvlN/MR+zF7GRn1DAaA
        q1KhXI+hkO21+CKHwicCyRPyRK2x
X-Google-Smtp-Source: APXvYqwwACgPkgczKotAGdJ5R71yU0c4syxKQWDM6WYpzM9MMSb4wTkE/IkDA3sVIU82hwkPpjE9RA==
X-Received: by 2002:a05:6830:1e16:: with SMTP id s22mr34363otr.364.1574719778896;
        Mon, 25 Nov 2019 14:09:38 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:38 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 1/9] rtlwifi: rtl8192de: Remove usage of private bit manipulation macros
Date:   Mon, 25 Nov 2019 16:09:26 -0600
Message-Id: <20191125220934.32693-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
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
v2 - no changes
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

