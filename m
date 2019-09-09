Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A188AD1BE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 04:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbfIICAJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 22:00:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46690 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732695AbfIICAI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 22:00:08 -0400
Received: by mail-ot1-f66.google.com with SMTP id g19so10919879otg.13
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 19:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktHqRIvVThv49Ouu5ZkBTN1rAYWt5Ek4aBS6WuNlUgc=;
        b=skf/Ptqy4u5wJaEWQSYDUbysb9rEFJ27qQM0nyn4c84mI3xCfDQg7yiWzKiGOJLqSX
         tsPZuRyVq/g4LC/ftwJtyu+v1cRnTuoMzJcmAnmKxI020U3uVzon+RS2GcXExOkoExaM
         /3AYGGh7QfEWyUyETztg13QxKxzpwZlF5bVOGcAgHdAaZnkQfgrAbjhXs35DY62PYetN
         3qOIzDtORybjlSR/N6kVD4fG8MxTWicFvyAfBptLSGGeZ02D0ZYmgMgvkyfRkUPHBY30
         veZ+yrLq7oQAlq+QfxN8b9OT/vnpAj6SfbqYGzXiZsXs/0KE/geGJ4j3j7yA3ja9cvub
         MzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ktHqRIvVThv49Ouu5ZkBTN1rAYWt5Ek4aBS6WuNlUgc=;
        b=tfgO9FSU2zGSxVrz42jIgLxeqsBiO2TMEmpeGwPXCw6g/v/l/KWreuxWbkqYdZJvxE
         gAoqPxcUd6yZm6C1xPz/mCJ3pLZwvYy1RjkBgdeKET0t2aBTBFR0y0LEOV4xagZRH2ha
         IIk9QEhrUuzaock+YlT0JNTa6mlWWEq6YI3CBvplOLH6ReHIIQ3e3XHV2qSfUHhqqC5V
         L1mLEzA0OfNVWVGvcqJMPu25E4cqQkKuEr36RXLUbCuwzOGvD2D9UzawVZ2/ZWJaJPvP
         oYX5jcYBI/Ktw7LBiIWk/KW5rlA8mHBAgjIL6nFXjLbu1z5tqZwEZ10HGb+Kr/KFgsAL
         NRzA==
X-Gm-Message-State: APjAAAXzICjP+9ALRiPt231VThK4PwYvmsIUvRK6f3v8B18qbrHiLcAx
        p0xJIacFJCIynrDN9qMiHXA=
X-Google-Smtp-Source: APXvYqyz6T/RTcxVz+qyAnEdSmTOty4b5C9fRLgGdY7uQBYuXaS8i77ghc5WenbFX5ylM3qrlgx5Zg==
X-Received: by 2002:a05:6830:1196:: with SMTP id u22mr17914706otq.39.1567994406952;
        Sun, 08 Sep 2019 19:00:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm1468420oij.16.2019.09.08.19.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 19:00:06 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 6/9] rtlwifi: rtl8723be: Replace local bit manipulation macros
Date:   Sun,  8 Sep 2019 20:59:55 -0500
Message-Id: <20190909015958.29834-7-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
References: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This driver uses a set of local macros to manipulate the RX and TX
descriptors, which are all little-endian quantities. These macros
are replaced by the bitfield macros le32p_replace_bits() and
le32_get_bits(). In several places, the macros operated on an entire
32-bit word. In these cases, a direct read or replacement is used.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 .../wireless/realtek/rtlwifi/rtl8723be/trx.h  | 149 +++++++++---------
 1 file changed, 74 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
index 89447b93c439..f0fc4f7d4815 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
@@ -15,179 +15,178 @@
 #define CRCLENGTH				4
 
 #define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 16, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
 #define SET_TX_DESC_OFFSET(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 16, 8, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
 #define SET_TX_DESC_BMC(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 24, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24))
 #define SET_TX_DESC_HTC(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 25, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25))
 #define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 26, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
 #define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 27, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
 #define SET_TX_DESC_LINIP(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 28, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
 #define SET_TX_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_TX_DESC_OWN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
 
 #define SET_TX_DESC_MACID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 7, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(6, 0))
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(20, 16))
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 24, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(28, 24))
 
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12))
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 13, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13))
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
 
 #define SET_TX_DESC_HWSEQ_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 6, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(7, 6))
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 8, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(8))
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 10, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(10))
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 11, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(11))
 #define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(12))
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 13, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(13))
 #define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 15, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(15))
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 17, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(21, 17))
 
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 7, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(6, 0))
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(16, 13))
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 24, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 24))
 
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 0, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0))
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 4, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(4))
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 5, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5))
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12))
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
 
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
 
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 15, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 32), __val, BIT(15))
 
 #define SET_TX_DESC_SEQ(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 12, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12))
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+40, 0, 32, __val)
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+40, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 40)))
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+48, 0, 32, __val)
+	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 0, 14)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0))
 #define GET_RX_DESC_CRC32(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 14, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(14))
 #define GET_RX_DESC_ICV(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 15, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(15))
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc, 16, 4)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16))
 #define GET_RX_DESC_SHIFT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 24, 2)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24))
 #define GET_RX_DESC_PHYST(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(26))
 #define GET_RX_DESC_SWDEC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(27))
 #define GET_RX_DESC_OWN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
 
 #define SET_RX_DESC_PKT_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
 #define SET_RX_DESC_EOR(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
 #define SET_RX_DESC_OWN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_RX_DESC_MACID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 0, 7)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), GENMASK(6, 0))
 #define GET_RX_DESC_PAGGR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
 
 #define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+8, 28, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 8), BIT(28))
 
 #define GET_RX_DESC_RXMCS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 0, 7)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(6, 0))
 #define GET_RX_DESC_RXHT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 6, 1)
-
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
 #define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+12, 29, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(29))
 #define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+12, 30, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(30))
 #define GET_RX_STATUS_DESC_MAGIC_MATCH(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 31, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(31))
 
 #define GET_RX_DESC_SPLCP(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 0, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 16), BIT(0))
 #define GET_RX_DESC_BW(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 4, 2)
+	le32_get_bits(*(__le32 *)(__pdesc + 16), GENMASK(5, 4))
 
 #define GET_RX_DESC_TSFL(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
 
 /* TX report 2 format in Rx desc*/
 
 #define GET_RX_RPT2_DESC_MACID_VALID_1(__rxstatusdesc)	\
-	LE_BITS_TO_4BYTE(__rxstatusdesc+16, 0, 32)
+	le32_to_cpu(*((__le32 *)(__rxstatusdesc + 16)))
 #define GET_RX_RPT2_DESC_MACID_VALID_2(__rxstatusdesc)	\
-	LE_BITS_TO_4BYTE(__rxstatusdesc+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__rxstatusdesc + 20)))
 
 #define SET_EARLYMODE_PKTNUM(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 0, 4, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(3, 0))
 #define SET_EARLYMODE_LEN0(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 4, 12, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4))
 #define SET_EARLYMODE_LEN1(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 16, 12, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16))
 #define SET_EARLYMODE_LEN2_1(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 28, 4, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28))
 #define SET_EARLYMODE_LEN2_2(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 0, 8, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0))
 #define SET_EARLYMODE_LEN3(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 8, 12, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
 #define SET_EARLYMODE_LEN4(__paddr, __value)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 20, 12, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.23.0

