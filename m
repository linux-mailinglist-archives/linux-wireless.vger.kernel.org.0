Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAAB67E76E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 03:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731000AbfHBBVK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 21:21:10 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46340 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730806AbfHBBVJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 21:21:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id z23so48072789ote.13
        for <linux-wireless@vger.kernel.org>; Thu, 01 Aug 2019 18:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6/Xiy/eXCGy4mDGjBUFxAKDAiciCOICJ1kLtNw5cAX0=;
        b=RBPFD4NhbzUce1RqPrM5A5u7iv4GrAXu95YqBp4oZ9c0slgWtfE92MiTU+Hm3rXOpB
         ylRA++Ab4BKVXqZ0CG5Q3ksZrfiXnztC7e8kEskzFW2WJBY+HD6BXfR3tQ6uXBlojNhz
         HE16TkHNspXflvX7cpgXoeXDKLHvmowp9tHboTX9dMxV/p4J70byQ1aqzT2vy4zZk4/Q
         xDLP9+5HrrfWenCmRhEIpo8OTqqWccUz3SH/44x4UIim/kIhnlUB1nRBuYzhadS79msj
         GqMD4j7rnotFIk/HdhkjwXLIJ8GenC8Gt1pVQJkJYxF0SB3rCsqrfZ+02aa61EPPYPXM
         Hiig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6/Xiy/eXCGy4mDGjBUFxAKDAiciCOICJ1kLtNw5cAX0=;
        b=fcjLn6t2ynY/8ZmCDYNBz3QmjZR3LG1NnliRZjRzeFzwTjo4Qi2HBNCuIODbKhZ9rO
         qVOGi2aBlHD+RMioxO7h8heQP3Almg2iELx+VW73n1snmIDSZyslCnTLaEKd9Z+Svero
         ypxBm2jOMpbKBzw8bqHUnnUvnfECfH6ZK3DhlndgPYuaJvkYC1FdSExpK0nH9FaOdp7/
         pM2nmDSPT0ZcL3/ehMM2tGC9TpNaALPoFGmyR2/d84/OycEQxrRN0wx7x8kbjTwkleJh
         XBZtFvyv9LbLA/Yk5pFDYCnacs7sv+Ea/VDNFzL++qxHELuoCoskESbiM7/adjT/JsxU
         Tjug==
X-Gm-Message-State: APjAAAWSCpdOhk4Sf+nHKjelNAk5ihbEaM6Ukd4UjSxcJfFCHH4xMfsL
        fk3DCD4n3XE4CAcq7YUPSH9gC/wJ
X-Google-Smtp-Source: APXvYqwEYSa2A4kjAYmoR3wGqyLGlsrJ2/19+zE5+oI/Xef5sLB6+f2KBpkAyVpFgKrEsjwN9GT+1A==
X-Received: by 2002:a9d:4546:: with SMTP id p6mr34091348oti.34.1564708868636;
        Thu, 01 Aug 2019 18:21:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c64sm28112162otb.79.2019.08.01.18.21.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 18:21:08 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/4] rtlwifi: rtl8192ce: Replace local bit manipulation macros
Date:   Thu,  1 Aug 2019 20:21:00 -0500
Message-Id: <20190802012102.7945-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
References: <20190802012102.7945-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192ce/trx.h  | 146 ++++++++----------
 1 file changed, 62 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
index 37e40f44c347..f4dbeeda062f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/trx.h
@@ -14,172 +14,150 @@
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH				4
 
-/* Define a macro that takes a le32 word, converts it to host ordering,
- * right shifts by a specified count, creates a mask of the specified
- * bit count, and extracts that number of bits.
- */
-
-#define SHIFT_AND_MASK_LE(__pdesc, __shift, __mask)		\
-	((le32_to_cpu(*(((__le32 *)(__pdesc)))) >> (__shift)) &	\
-	BIT_LEN_MASK_32(__mask))
-
-/* Define a macro that clears a bit field in an le32 word and
- * sets the specified value into that bit field. The resulting
- * value remains in le32 ordering; however, it is properly converted
- * to host ordering for the clear and set operations before conversion
- * back to le32.
- */
-
-#define SET_BITS_OFFSET_LE(__pdesc, __shift, __len, __val)	\
-	(*(__le32 *)(__pdesc) = 				\
-	(cpu_to_le32((le32_to_cpu(*((__le32 *)(__pdesc))) &	\
-	(~(BIT_OFFSET_LEN_MASK_32((__shift), __len)))) |		\
-	(((u32)(__val) & BIT_LEN_MASK_32(__len)) << (__shift)))));
-
 /* macros to read/write various fields in RX or TX descriptors */
 
 #define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 0, 16, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
 #define SET_TX_DESC_OFFSET(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 16, 8, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
 #define SET_TX_DESC_BMC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 24, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24))
 #define SET_TX_DESC_HTC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 25, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25))
 #define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 26, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
 #define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 27, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
 #define SET_TX_DESC_LINIP(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 28, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
 #define SET_TX_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_TX_DESC_OWN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 #define SET_TX_DESC_MACID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
 #define SET_TX_DESC_AGG_BREAK(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 5, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5))
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 7, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7))
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 16, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16))
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 22, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
 
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 17, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+8, 20, 3, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
 
 #define SET_TX_DESC_SEQ(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc+12, 16, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
 #define SET_TX_DESC_PKT_ID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+12, 28, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28))
 
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0))
 #define SET_TX_DESC_QOS(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc+16, 6, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6))
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 7, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(7))
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 8, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8))
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 10, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10))
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 11, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11))
 #define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12))
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+16, 13, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13))
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+16, 20, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20))
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 25, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25))
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 26, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26))
 #define SET_TX_DESC_RTS_BW(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 27, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27))
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 28, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28))
 #define SET_TX_DESC_RTS_STBC(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 30, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30))
 
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+20, 0, 6, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0))
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+20, 6, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6))
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+20, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+20, 13, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
 
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+24, 11, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11))
 
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+28, 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+32, 0, 32, __val)
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+32, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 32)))
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+40, 0, 32, __val)
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 0, 14)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0))
 #define GET_RX_DESC_CRC32(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 14, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(14))
 #define GET_RX_DESC_ICV(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 15, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(15))
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc, 16, 4)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16))
 #define GET_RX_DESC_SHIFT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 24, 2)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24))
 #define GET_RX_DESC_PHYST(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 26, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(26))
 #define GET_RX_DESC_SWDEC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 27, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(27))
 #define GET_RX_DESC_OWN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 #define SET_RX_DESC_PKT_LEN(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
 #define SET_RX_DESC_EOR(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 30, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
 #define SET_RX_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_RX_DESC_PAGGR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 14, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14))
 #define GET_RX_DESC_FAGGR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 15, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15))
 
 #define GET_RX_DESC_RXMCS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 0, 6)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0))
 #define GET_RX_DESC_RXHT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 6, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6))
 #define GET_RX_DESC_SPLCP(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 8, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8))
 #define GET_RX_DESC_BW(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc+12, 9, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9))
 
 #define GET_RX_DESC_TSFL(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+24, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+24, 0, 32, __val)
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
 	memset(__pdesc, 0, min_t(size_t, _size, TX_DESC_NEXT_DESC_OFFSET))
-- 
2.22.0

