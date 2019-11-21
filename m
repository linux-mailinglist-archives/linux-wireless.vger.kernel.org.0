Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5A105C30
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKUVo0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:44:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45327 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfKUVoZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:44:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id r24so4323561otk.12
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UauNR8xWixEkWPrqJnX3toknjEptaFQ9yfGVzgeqdSc=;
        b=LRjvdp9TXjZvgpctmsqN/6rJI1kCoKCfZedVyLuSfA3UNTStAZ6VtPaImWPTimrDh/
         4dXgoTCJKs7qX8lQmb24wBM541Dk3yrbkxsjulbSDejK4Bh+oyse1UaQzlwTHppNonE7
         1np0Bs/Gj7ezWHcuNlw/4BcAgNeV+sFmxeFPNEI6fRgHBPbgXKNm6gFNkf2f9k2fpBif
         ZUu4g1deLgn76DacUb9KcphBgFI9Lc6t/tKFpy8ezut+H5svDX2cka4aPI4CtEp9OK1I
         AEk4MhYK2ruj1aMdOWy2mnITBD5MVX7Rs43xvkU+/mcFO0FUkKp/DyOF0EKazSVQD1IC
         Whuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UauNR8xWixEkWPrqJnX3toknjEptaFQ9yfGVzgeqdSc=;
        b=awVKJpq7XNRyVT5QJ+pEai/ckM06OHHVda9kQJVidaeW10B1qmCgAKKHYzGfGQPpQJ
         a+gNt1Z/H/Jh2A9lxzgw6BELquoDY7AUEdKIGdFc9zRvC37I1+0roqHf5n8w4nVjVLVo
         v00lCuNHY6I2dHyiay9e86LJU0w+/t59iT2tikoii2Ifl5peegDXdrFWpLBiT9LXDLwv
         j5hOVNejJONRxSI107qoobpKst8DmtocFJwuPR55w1Oq9+qxL8Kx2J45OsSr5W8m1bAY
         PPuVsSWEA0YVc10mvT1aMYIa4J2q1uq2D45AVCW2TYSmwv5bE485Iip/OFMRll3nTvZ0
         xpOg==
X-Gm-Message-State: APjAAAWtIgyry8QhHuhSrvYxu/eiUZ0FG9d34fsfrzba7a7hj2CVBACg
        XgLezS2BohvaNL7eHo2ZyYY=
X-Google-Smtp-Source: APXvYqwpQBG1qCTqH9rjBPQTCqUxiW3Y3QHFbNno8kCuEszNS1rsjD+tlYJ25dIuH63Ri4BGhdQZFQ==
X-Received: by 2002:a9d:854:: with SMTP id 78mr8188464oty.284.1574372662564;
        Thu, 21 Nov 2019 13:44:22 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x82sm1333854oix.29.2019.11.21.13.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:44:22 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/4] rtlwifi: rtl8192de: Replace local bit manipulation macros
Date:   Thu, 21 Nov 2019 15:44:15 -0600
Message-Id: <20191121214417.29676-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
References: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  | 160 ++++++++----------
 1 file changed, 69 insertions(+), 91 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index 40746125f1ae..5ff1000b2400 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -14,171 +14,149 @@
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
-	(*(__le32 *)(__pdesc) =					\
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
+	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
 
 #define SET_TX_DESC_MACID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
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
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 26, 8, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26))
 
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
+	le32_to_cpu(*(__le32 *)(__pdesc + 32))
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+40, 0, 32, __val)
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 0, 14)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0))
 #define GET_RX_DESC_CRC32(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 14, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(14))
 #define GET_RX_DESC_ICV(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 15, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(15))
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc, 16, 4)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16))
 #define GET_RX_DESC_SHIFT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 24, 2)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24))
 #define GET_RX_DESC_PHYST(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 26, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(26))
 #define GET_RX_DESC_SWDEC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 27, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(27))
 #define GET_RX_DESC_OWN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
 
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
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14))
 #define GET_RX_DESC_FAGGR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 15, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
 
 #define GET_RX_DESC_RXMCS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 0, 6)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0))
 #define GET_RX_DESC_RXHT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 6, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
 #define GET_RX_DESC_SPLCP(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 8, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8))
 #define GET_RX_DESC_BW(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc+12, 9, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9))
 
 #define GET_RX_DESC_TSFL(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+20, 0, 32)
+	le32_to_cpu(*(__le32 *)(__pdesc + 20))
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+24, 0, 32)
+	le32_to_cpu(*(__le32 *)(__pdesc + 24))
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+24, 0, 32, __val)
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
 	memset((void *)__pdesc, 0,			\
@@ -186,19 +164,19 @@
 
 /* For 92D early mode */
 #define SET_EARLYMODE_PKTNUM(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr, 0, 3, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(2, 0))
 #define SET_EARLYMODE_LEN0(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr, 4, 12, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4))
 #define SET_EARLYMODE_LEN1(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr, 16, 12, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16))
 #define SET_EARLYMODE_LEN2_1(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr, 28, 4, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28))
 #define SET_EARLYMODE_LEN2_2(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr+4, 0, 8, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0))
 #define SET_EARLYMODE_LEN3(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr+4, 8, 12, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
 #define SET_EARLYMODE_LEN4(__paddr, __value)		\
-	SET_BITS_OFFSET_LE(__paddr+4, 20, 12, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
 
 struct rx_fwinfo_92d {
 	u8 gain_trsw[4];
-- 
2.23.0

