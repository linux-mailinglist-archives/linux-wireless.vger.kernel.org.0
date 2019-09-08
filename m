Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4876ACA87
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 06:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfIHEDn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 00:03:43 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33300 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbfIHEDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 00:03:42 -0400
Received: by mail-oi1-f196.google.com with SMTP id e12so7837908oie.0
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xv0wh/BK7fvZnotYNriFk6lUkpeQq7Ec0PY860ts90c=;
        b=Tyno8IOuO8+hlDarhfgQl+XkFlmVD7KcRDuyykNAcnRHW6DoSyRQByNZkEOy6Goe3h
         u+RiNgm3fDn/0/lbdd9QBrgoG+E26xSGohPc5qPhItZ+EIW+JCH77iQuZoU8YyAydc/5
         VC+2YtaDaUXflkrhuUc5UlMDnfrCg3xQMLPqLnelFeMaBlh2W7cBcENbmARkOxl5OYbR
         qwBRM3dj+nokSS9j+cO02JoykTWpZPmU/esBzEt1Pre7hL1y99Z9rAy3oyPljmmN9B5L
         X0Tv8LREh9WM374tXdjSkPlAh7mBW5u1kbk70+VjewOZ6KJjt/dBKVS6iYrZTQCv3DtH
         7acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xv0wh/BK7fvZnotYNriFk6lUkpeQq7Ec0PY860ts90c=;
        b=NP00D6jj3O3+WZKGGhCnntVXmOjSi5FSB8wA5Ln1I0KUZaRRa9GcRf9pP4mgOjJimM
         vpZNxG1hCggRU9LsyIER1XK2Vj/c4RWw8fONr59hcCJjmxGvlexJVSN7VEZmjRBMVSx7
         KrGOaSOuQKVS7nOj+bZeDuJHulcjclKbSt4p76ZS2kx4TgsCeYUw0WZZpNR0fcklrX9/
         mcPWAWSHhYQ/E6Phx3aMHQSYvTDEdQk7ADiOKiWRilxPUP8nRxI1WCSMRM+w1QJ0M4yD
         T3OHW4qOSonQhuMNmwE00fqH2bZD1ZIlsZWzJyOlHwhbgP7zUmG7Ibe18/r5WTIKWjQs
         CirQ==
X-Gm-Message-State: APjAAAWvcXDRHUuRrqotw2UD3XIwaZ/GoJYvlLMKkPdqiQE+862qYS4u
        xg4i0g7eNqX5VoHchSIUuno=
X-Google-Smtp-Source: APXvYqxOtJJjvT4K5MVvsx0bnPjUlohDtVQkn2nUAimOwQUlfT9r8QTs3DzFVYZdmnKJBYjhAFxRGg==
X-Received: by 2002:aca:f50b:: with SMTP id t11mr12632555oih.1.1567915421317;
        Sat, 07 Sep 2019 21:03:41 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x80sm1419178oia.37.2019.09.07.21.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 21:03:41 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/9] rtlwifi: rtl8723ae: Replace local bit manipulation macros
Date:   Sat,  7 Sep 2019 23:03:28 -0500
Message-Id: <20190908040335.19838-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
References: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.h  | 124 +++++++++---------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
index e0cc45ad34b4..b116181366b6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
@@ -15,149 +15,149 @@
 #define CRCLENGTH						4
 
 #define SET_TX_DESC_PKT_SIZE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 16, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
 #define SET_TX_DESC_OFFSET(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 16, 8, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
 #define SET_TX_DESC_BMC(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 24, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(24))
 #define SET_TX_DESC_HTC(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 25, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(25))
 #define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 26, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
 #define SET_TX_DESC_FIRST_SEG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 27, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
 #define SET_TX_DESC_LINIP(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 28, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
 #define SET_TX_DESC_OWN(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_TX_DESC_OWN(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
 
 #define SET_TX_DESC_MACID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
 #define SET_TX_DESC_AGG_BREAK(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 5, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(5))
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 7, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(7))
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16))
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
 
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
 
 #define SET_TX_DESC_SEQ(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 16, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
 #define SET_TX_DESC_PKT_ID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 28, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(31, 28))
 
 /* For RTL8723 */
 #define SET_TX_DESC_HWSEQ_EN_8723(__pdesc, __val)   \
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 31, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31))
 #define SET_TX_DESC_HWSEQ_SEL_8723(__txdesc, __value) \
-	SET_BITS_TO_LE_4BYTE(__txdesc+16, 6, 2, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(7, 6))
 
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0))
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(8))
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 10, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(10))
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 11, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11))
 #define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12))
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(13))
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 20, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(21, 20))
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 25, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25))
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 26, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26))
 #define SET_TX_DESC_RTS_BW(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 27, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27))
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 28, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(29, 28))
 #define SET_TX_DESC_RTS_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 30, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(31, 30))
 
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 0, 6, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0))
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 6, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6))
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
 
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 11, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 24), __val, GENMASK(15, 11))
 
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 0, 32, __val)
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+32, 0, 32)
+	le32_to_cpu(*(__le32 *)(__pdesc + 32))
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+40, 0, 32, __val)
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 0, 14)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(13, 0))
 #define GET_RX_DESC_CRC32(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 14, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(14))
 #define GET_RX_DESC_ICV(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 15, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(15))
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc, 16, 4)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(19, 16))
 #define GET_RX_DESC_SHIFT(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 24, 2)
+	le32_get_bits(*(__le32 *)__pdesc, GENMASK(25, 24))
 #define GET_RX_DESC_PHYST(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(26))
 #define GET_RX_DESC_SWDEC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(27))
 #define GET_RX_DESC_OWN(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+	le32_get_bits(*(__le32 *)__pdesc, BIT(31))
 
 #define SET_RX_DESC_PKT_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
 #define SET_RX_DESC_EOR(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
 #define SET_RX_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_RX_DESC_PAGGR(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14))
 #define GET_RX_DESC_FAGGR(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
 
 #define GET_RX_DESC_RXMCS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 0, 6)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0))
 #define GET_RX_DESC_RXHT(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 6, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
 #define GET_RX_DESC_SPLCP(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 8, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8))
 #define GET_RX_DESC_BW(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc+12, 9, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9))
 
 #define GET_RX_DESC_TSFL(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+20, 0, 32)
+	le32_to_cpu(*(__le32 *)(__pdesc + 20))
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
+	le32_to_cpu(*(__le32 *)(__pdesc + 24))
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.23.0

