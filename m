Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D48FCA45B8
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 20:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbfHaSHD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 14:07:03 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45113 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfHaSHC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 14:07:02 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so9979550otp.12
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2019 11:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p4OjUwuRl59WlUGstgY0rrpth8qfhHkKxY5XVhXp0kA=;
        b=VI5APHEirWqa3W5eM9KuQPdntog9B5PgTFwRUCmiN42v43xsUeu0A5Qr19LcqK2H8S
         gMC+50rlVm2TVDEd0/A/7pjjEcojYEGqsjlWkXO+jPR13g/JjHhtdLgty5Ea8EPgJv5T
         xvo+lWDHSr1Cus77NBz8/kKazbDRrF6Vup5312mDf4NzfZtv4Wijkwj79+8VRK4qwscj
         ASAuJQwNniaRA7Ohc9JLOjOl9aTHEUaZeD6TWz4hcytxZj0ysjjnDQ1eThd61XcQ0Dx5
         /JdeRgFP8xel+EKmxFcgQeG0ELLApsFZokiLgtDP3LJhbnOr8U3Vav0RDREdzqX48sd0
         Gcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=p4OjUwuRl59WlUGstgY0rrpth8qfhHkKxY5XVhXp0kA=;
        b=dJ28AN0daZOciV5rGuhteMyLvpPodjgwPjPNNdUNrwb+6L+N3ejB21mymuB6z1W9PN
         GMIgTKOW1uYYNsWFMdcPgerh/F7hlXAOGU1Cd9xB6lk6PeiR/RMKzZ/26quZ3jaZBqOW
         oDqjb8udQ/RZBSm1DAzcfC247Okhf56n8MzL/lYGNtv+kPTDXvMooNVdquffbhceJ8AS
         OXoZpLNL/sVv4grLxBF6l0Rh99VZBoCrzN/uiAFErGF3wS3lkz1OhgQlE6llTKxxJKxH
         JTbHGaCsBUxONoob0AzsNA1I/ZVvya65RRBWrquPpflsCxkMAQMpzPB4n9f7y9wiy3/p
         /eSg==
X-Gm-Message-State: APjAAAWoDnejetNJT+tA7gs16JD65wO3L1wiKFI3NUguNb+FHeb/jMMG
        iAFCwQeqmnNsDg/PPSTv0Ok=
X-Google-Smtp-Source: APXvYqwA2TymP75d8N9tR0J/UN2CoIvsPEFjZXDe5gZpicYN7vZVI6CXFI5QkYRcasTIbjkVQcN+YA==
X-Received: by 2002:a05:6830:2056:: with SMTP id f22mr16020467otp.177.1567274820958;
        Sat, 31 Aug 2019 11:07:00 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c11sm3222346otr.54.2019.08.31.11.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 11:07:00 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/5] rtlwifi: rtl8192ee: Replace local bit manipulation macros
Date:   Sat, 31 Aug 2019 13:06:41 -0500
Message-Id: <20190831180644.7937-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
References: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
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
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   | 168 ++++++++++-----------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
index 9a68edd3ea0a..3b00072ba5d2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
@@ -15,218 +15,218 @@
 #define MAX_RECEIVE_BUFFER_SIZE				8192
 
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
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 #define SET_TX_DESC_MACID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 7, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(6, 0))
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 15, 1, __val)
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
 
 /* Dword 4 */
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
 
 /* Dword 5 */
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 0, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(3, 0))
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 5, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(6, 5))
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(12))
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(16, 13))
 
 /* Dword 7 */
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
 
 /* Dword 9 */
 #define SET_TX_DESC_SEQ(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 12, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 36), __val, GENMASK(23, 12))
 
 /* Dword 10 */
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+40, 0, 32, __val)
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
 
 /* Dword 11*/
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+48, 0, 32, __val)
+	*(__le32 *)(__pdesc + 48) = cpu_to_le32(__val)
 
 #define SET_EARLYMODE_PKTNUM(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 0, 4, __val)
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(3, 0))
 #define SET_EARLYMODE_LEN0(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 4, 15, __val)
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(18, 4))
 #define SET_EARLYMODE_LEN1(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 16, 2, __val)
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(17, 16))
 #define SET_EARLYMODE_LEN2_1(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 2, 4,  __val)
+	le32p_replace_bits((__le32 *)__paddr, __val, GENMASK(5, 2))
 #define SET_EARLYMODE_LEN2_2(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 0, 8,  __val)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(7, 0))
 #define SET_EARLYMODE_LEN3(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 17, 15, __val)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 17))
 #define SET_EARLYMODE_LEN4(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 20, 12, __val)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __val, GENMASK(31, 20))
 
 /* TX/RX buffer descriptor */
 
 /* for Txfilldescroptor92ee, fill the desc content. */
 #define SET_TXBUFFER_DESC_LEN_WITH_OFFSET(__pdesc, __offset, __val)            \
-	SET_BITS_TO_LE_4BYTE((__pdesc) + ((__offset) * 16), 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val,	\
+			   GENMASK(15, 0))
 #define SET_TXBUFFER_DESC_AMSDU_WITH_OFFSET(__pdesc, __offset, __val)          \
-	SET_BITS_TO_LE_4BYTE((__pdesc) + ((__offset) * 16), 31, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16 * __offset), __val, BIT(31))
 #define SET_TXBUFFER_DESC_ADD_LOW_WITH_OFFSET(__pdesc, __offset, __val)        \
-	SET_BITS_TO_LE_4BYTE((__pdesc) + ((__offset) * 16) + 4, 0, 32, __val)
+	*(__le32 *)(__pdesc + 16 * __offset + 4) = cpu_to_le32(__val)
 #define SET_TXBUFFER_DESC_ADD_HIGH_WITH_OFFSET(pbd, off, val, dma64)	       \
-	(dma64 ? SET_BITS_TO_LE_4BYTE((pbd) + ((off) * 16) + 8, 0, 32, val) : 0)
+	 *(__le32 *)(pbd + 16 * off + 8) = dma64 ? cpu_to_le32(val) : 0
 #define GET_TXBUFFER_DESC_ADDR_LOW(__pdesc, __offset)                          \
-	LE_BITS_TO_4BYTE((__pdesc) + ((__offset) * 16) + 4, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 16 * __offset + 4)))
 #define GET_TXBUFFER_DESC_ADDR_HIGH(pbd, off, dma64)			       \
-	(dma64 ? LE_BITS_TO_4BYTE((pbd) + ((off) * 16) + 8, 0, 32) : 0)
+	(dma64 ? le32_to_cpu(*((__le32 *)(pbd + 16 * off + 8))) : 0)
 
 /* Dword 0 */
 #define SET_TX_BUFF_DESC_LEN_0(__pdesc, __val)                                 \
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
 #define SET_TX_BUFF_DESC_PSB(__pdesc, __val)                                   \
-	SET_BITS_TO_LE_4BYTE(__pdesc, 16, 15, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(30, 16))
 #define SET_TX_BUFF_DESC_OWN(__pdesc, __val)                                   \
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 /* Dword 1 */
 #define SET_TX_BUFF_DESC_ADDR_LOW_0(__pdesc, __val)                            \
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 4, 0, 32, __val)
+	*(__le32 *)(__pdesc + 4) = cpu_to_le32(__val)
 /* Dword 2 */
 #define SET_TX_BUFF_DESC_ADDR_HIGH_0(bdesc, val, dma64)			       \
 	SET_TXBUFFER_DESC_ADD_HIGH_WITH_OFFSET(bdesc, 0, val, dma64)
-/* Dword 3 / RESERVED 0 */
 
 /* RX buffer  */
 
 /* DWORD 0 */
 #define SET_RX_BUFFER_DESC_DATA_LENGTH(__status, __val)	\
-	SET_BITS_TO_LE_4BYTE(__status, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__status, __val, GENMASK(13, 0))
 #define SET_RX_BUFFER_DESC_LS(__status, __val)		\
-	SET_BITS_TO_LE_4BYTE(__status, 15, 1, __val)
+	le32p_replace_bits((__le32 *)__status, __val, BIT(15))
 #define SET_RX_BUFFER_DESC_FS(__status, __val)		\
-	SET_BITS_TO_LE_4BYTE(__status, 16, 1, __val)
+	le32p_replace_bits((__le32 *)__status, __val, BIT(16))
 #define SET_RX_BUFFER_DESC_TOTAL_LENGTH(__status, __val)	\
-	SET_BITS_TO_LE_4BYTE(__status, 16, 15, __val)
+	le32p_replace_bits((__le32 *)__status, __val, GENMASK(30, 16))
 
 #define GET_RX_BUFFER_DESC_LS(__status)			\
-	LE_BITS_TO_4BYTE(__status, 15, 1)
+	le32_get_bits(*((__le32 *)__status), BIT(15))
 #define GET_RX_BUFFER_DESC_FS(__status)			\
-	LE_BITS_TO_4BYTE(__status, 16, 1)
+	le32_get_bits(*((__le32 *)__status), BIT(16))
 #define GET_RX_BUFFER_DESC_TOTAL_LENGTH(__status)	\
-	LE_BITS_TO_4BYTE(__status, 16, 15)
+	le32_get_bits(*((__le32 *)__status), GENMASK(30, 16))
 
 /* DWORD 1 */
 #define SET_RX_BUFFER_PHYSICAL_LOW(__status, __val)	\
-	SET_BITS_TO_LE_4BYTE(__status+4, 0, 32, __val)
+	*(__le32 *)(__status + 4) = cpu_to_le32(__val)
 
 /* DWORD 2 */
 #define SET_RX_BUFFER_PHYSICAL_HIGH(__rx_status_desc, __val, dma64)            \
-	(dma64 ? SET_BITS_TO_LE_4BYTE((__rx_status_desc) + 8, 0, 32, __val) : 0)
+	*(__le32 *)(__rx_status_desc + 8) = (dma64 ? cpu_to_le32(__val) : 0)
 
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
 
 #define SET_RX_DESC_EOR(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
 
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
 #define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+12, 29, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(29))
 #define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+12, 30, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(30))
 #define GET_RX_STATUS_DESC_MAGIC_MATCH(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 31, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(31))
 
 #define GET_RX_DESC_TSFL(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
 
 /* TX report 2 format in Rx desc*/
 
 #define GET_RX_RPT2_DESC_MACID_VALID_1(__status)	\
-	LE_BITS_TO_4BYTE(__status+16, 0, 32)
+	le32_to_cpu(*((__le32 *)(__status + 16)))
 #define GET_RX_RPT2_DESC_MACID_VALID_2(__status)	\
-	LE_BITS_TO_4BYTE(__status+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__status + 20)))
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.16.4

