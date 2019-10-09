Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF440D16E8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfJIRhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 13:37:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:32834 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731751AbfJIRha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 13:37:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id 60so2456656otu.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZhzEkp5nxoQaYKT2SxKNQ+hIEZkZz+DMqQAIR3dN2Jk=;
        b=lfU8tEVPSmTogMBQx5Qb2LE68Vu4fPFhzBUjbNr4DXZqPmBCMeYlS/t79nqK8k3+wY
         ctIGk+3C0eU7GyB6xcqQT4jKPZjqdYI5SCLbk9cyaXEXZYKOWR6T0ejPVdR74Ji0/U7d
         AeL0iQDmGQLeTFSk8+NLY1dyFcz3fuyAKkEGzDdGHp6gtZyhDbolTVUt/1chMlMYBBGq
         967FqKfM5g8/6NrV7eWnfzdtRjGezNqLYHfZK0yiJ1cJpkxnZuRHcPzG6CBf2On2iD8p
         M6bIt/WwQRGSr/mUNFFbpGRF7CLfZHn+izaVUfEKIkavE9Tj4mVuP9rnhsz5qM8Ike9H
         NrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZhzEkp5nxoQaYKT2SxKNQ+hIEZkZz+DMqQAIR3dN2Jk=;
        b=osPyj6vSvPb37aJkTTNpGwI1odSyfN8a7BJGcnhDARuG9QFw250Syozs4IfqeUISAg
         jUO3gBLko4HEuk3obmePuQzxgPyfGRmEqrqp2kuD4faAUBfb/hYKP7yJVwVszrQp4Q0r
         vBnJd4XvKvJghpbZ/SYXzsPMbQjhBj+Ig2Pb/cbYcnOaS2dgjLiWK/CpwDC7EfJ54kOy
         p21b9XY+LNJalZwz/tf+v3/lWabqkOtbYNAZnhrd/ICXh7D3ABCfiXA1pQEzX4FDTrJp
         OKRmC/7vMvc8T5ShTNCz6NQyY6EdimhPZe0jUX0O7xgSCGjxxGmexhPKA0it1Cb6AYmX
         2Hyg==
X-Gm-Message-State: APjAAAWLoEYjtaol1h/bZ/CB8d0yHYyiX1D6ynnR+n+upLzryDj0j1E1
        qYJzQkTYxwS9Os0qyTl8JH4=
X-Google-Smtp-Source: APXvYqykp6rOhyCDAC94V0YVljfdZrPDUnfLtRmTPYf1jIehOD4K2LppVIqaTIR0YEjiHS8/MFDokA==
X-Received: by 2002:a9d:4813:: with SMTP id c19mr3993276otf.114.1570642648739;
        Wed, 09 Oct 2019 10:37:28 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s66sm848199otb.65.2019.10.09.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:37:28 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/4] rtlwifi: rtl8192se: Replace local bit manipulation macros
Date:   Wed,  9 Oct 2019 12:37:09 -0500
Message-Id: <20191009173711.20348-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
References: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192se/def.h  | 130 ++++++++----------
 .../wireless/realtek/rtlwifi/rtl8192se/fw.c   |  31 +++--
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  |   4 +-
 3 files changed, 74 insertions(+), 91 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
index 44b2b4e3c151..19db124fbdda 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
@@ -24,116 +24,94 @@
 #define TX_DESC_SIZE_RTL8192S			(16 * 4)
 #define TX_CMDDESC_SIZE_RTL8192S		(16 * 4)
 
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
-	(~(BIT_OFFSET_LEN_MASK_32((__shift), __len)))) |	\
-	(((u32)(__val) & BIT_LEN_MASK_32(__len)) << (__shift)))));
-
 /* macros to read/write various fields in RX or TX descriptors */
 
 /* Dword 0 */
 #define SET_TX_DESC_PKT_SIZE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 0, 16, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
 #define SET_TX_DESC_OFFSET(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 16, 8, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
 #define SET_TX_DESC_LAST_SEG(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 26, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
 #define SET_TX_DESC_FIRST_SEG(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 27, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
 #define SET_TX_DESC_LINIP(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 28, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
 #define SET_TX_DESC_OWN(__pdesc, __val)				\
-	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_TX_DESC_OWN(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 /* Dword 1 */
 #define SET_TX_DESC_MACID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
 #define SET_TX_DESC_NON_QOS(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 16, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(16))
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 22, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
 
 /* Dword 2 */
 #define	SET_TX_DESC_RSVD_MACID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(((__pdesc) + 8), 24, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(28, 24))
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 29, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(29))
 
 /* Dword 3 */
 #define SET_TX_DESC_SEQ(__pdesc, __val)				\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 16, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
 
 /* Dword 4 */
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 0, 6, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(5, 0))
 #define SET_TX_DESC_CTS_ENABLE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 11, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11))
 #define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12))
 #define SET_TX_DESC_RA_BRSR_ID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 13, 3, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(15, 13))
 #define SET_TX_DESC_TXHT(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 16, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(16))
 #define SET_TX_DESC_TX_SHORT(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 17, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(17))
 #define SET_TX_DESC_TX_BANDWIDTH(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 18, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(18))
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 19, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(20, 19))
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 25, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25))
 #define SET_TX_DESC_RTS_BANDWIDTH(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 26, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26))
 #define SET_TX_DESC_RTS_SUB_CARRIER(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 27, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 27))
 #define SET_TX_DESC_RTS_STBC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 29, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(30, 29))
 #define SET_TX_DESC_USER_RATE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 31, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(31))
 
 /* Dword 5 */
 #define SET_TX_DESC_PACKET_ID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 20, 0, 9, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(8, 0))
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 20, 9, 6, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(14, 9))
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 20, 16, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(20, 16))
 
 /* Dword 7 */
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 28, 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
 
 /* Dword 8 */
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 32, 0, 32, __val)
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 32, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 32)))
 
 /* Dword 9 */
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 36, 0, 32, __val)
+	*(__le32 *)(__pdesc + 36) = cpu_to_le32(__val)
 
 /* Because the PCI Tx descriptors are chaied at the
  * initialization and all the NextDescAddresses in
@@ -151,54 +129,54 @@
 
 /* DWORD 0 */
 #define SET_RX_STATUS_DESC_PKT_LEN(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
 #define SET_RX_STATUS_DESC_EOR(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 30, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
 #define SET_RX_STATUS_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_RX_STATUS_DESC_PKT_LEN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 0, 14)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0))
 #define GET_RX_STATUS_DESC_CRC32(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 14, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(14))
 #define GET_RX_STATUS_DESC_ICV(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 15, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(15))
 #define GET_RX_STATUS_DESC_DRVINFO_SIZE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc, 16, 4)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16))
 #define GET_RX_STATUS_DESC_SHIFT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 24, 2)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24))
 #define GET_RX_STATUS_DESC_PHY_STATUS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 26, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(26))
 #define GET_RX_STATUS_DESC_SWDEC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 27, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(27))
 #define GET_RX_STATUS_DESC_OWN(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 /* DWORD 1 */
 #define GET_RX_STATUS_DESC_PAGGR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 14, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14))
 #define GET_RX_STATUS_DESC_FAGGR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 15, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
 
 /* DWORD 3 */
 #define GET_RX_STATUS_DESC_RX_MCS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 0, 6)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0))
 #define GET_RX_STATUS_DESC_RX_HT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 6, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
 #define GET_RX_STATUS_DESC_SPLCP(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 8, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8))
 #define GET_RX_STATUS_DESC_BW(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 9, 1)
+	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9))
 
 /* DWORD 5 */
 #define GET_RX_STATUS_DESC_TSFL(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
 
 /* DWORD 6 */
 #define SET_RX_STATUS__DESC_BUFF_ADDR(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc + 24, 0, 32, __val)
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
 #define GET_RX_STATUS_DESC_BUFF_ADDR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 24, 0, 32)
+	le32_to_cpu(*(__le32 *)(__pdesc + 24))
 
 #define SE_RX_HAL_IS_CCK_RATE(_pdesc)\
 	(GET_RX_STATUS_DESC_RX_MCS(_pdesc) == DESC_RATE1M ||	\
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
index 541b7881735e..47a5b95ca2b9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/fw.c
@@ -442,17 +442,20 @@ static u32 _rtl92s_fill_h2c_cmd(struct sk_buff *skb, u32 h2cbufferlen,
 		memset((ph2c_buffer + totallen + tx_desclen), 0, len);
 
 		/* CMD len */
-		SET_BITS_TO_LE_4BYTE((ph2c_buffer + totallen + tx_desclen),
-				      0, 16, pcmd_len[i]);
+		le32p_replace_bits((__le32 *)(ph2c_buffer + totallen +
+					      tx_desclen), pcmd_len[i],
+				   GENMASK(15, 0));
 
 		/* CMD ID */
-		SET_BITS_TO_LE_4BYTE((ph2c_buffer + totallen + tx_desclen),
-				      16, 8, pelement_id[i]);
+		le32p_replace_bits((__le32 *)(ph2c_buffer + totallen +
+					      tx_desclen), pelement_id[i],
+				   GENMASK(23, 16));
 
 		/* CMD Sequence */
 		*cmd_start_seq = *cmd_start_seq % 0x80;
-		SET_BITS_TO_LE_4BYTE((ph2c_buffer + totallen + tx_desclen),
-				      24, 7, *cmd_start_seq);
+		le32p_replace_bits((__le32 *)(ph2c_buffer + totallen +
+					      tx_desclen), *cmd_start_seq,
+				   GENMASK(30, 24));
 		++*cmd_start_seq;
 
 		/* Copy memory */
@@ -462,8 +465,9 @@ static u32 _rtl92s_fill_h2c_cmd(struct sk_buff *skb, u32 h2cbufferlen,
 		/* CMD continue */
 		/* set the continue in prevoius cmd. */
 		if (i < cmd_num - 1)
-			SET_BITS_TO_LE_4BYTE((ph2c_buffer + pre_continueoffset),
-					      31, 1, 1);
+			le32p_replace_bits((__le32 *)(ph2c_buffer +
+						      pre_continueoffset),
+					   1, BIT(31));
 
 		pre_continueoffset = totallen;
 
@@ -559,8 +563,8 @@ void rtl92s_set_fw_pwrmode_cmd(struct ieee80211_hw *hw, u8 mode)
 	pwrmode.flag_dps_en = 0;
 	pwrmode.bcn_rx_en = 0;
 	pwrmode.bcn_to = 0;
-	SET_BITS_TO_LE_2BYTE((u8 *)(&pwrmode) + 8, 0, 16,
-			mac->vif->bss_conf.beacon_int);
+	le16p_replace_bits((__le16 *)(((u8 *)(&pwrmode) + 8)),
+			   mac->vif->bss_conf.beacon_int, GENMASK(15, 0));
 	pwrmode.app_itv = 0;
 	pwrmode.awake_bcn_itvl = ppsc->reg_max_lps_awakeintvl;
 	pwrmode.smart_ps = 1;
@@ -602,9 +606,10 @@ void rtl92s_set_fw_joinbss_report_cmd(struct ieee80211_hw *hw,
 	joinbss_rpt.bssid[3] = mac->bssid[3];
 	joinbss_rpt.bssid[4] = mac->bssid[4];
 	joinbss_rpt.bssid[5] = mac->bssid[5];
-	SET_BITS_TO_LE_2BYTE((u8 *)(&joinbss_rpt) + 8, 0, 16,
-			mac->vif->bss_conf.beacon_int);
-	SET_BITS_TO_LE_2BYTE((u8 *)(&joinbss_rpt) + 10, 0, 16, mac->assoc_id);
+	le16p_replace_bits((__le16 *)(((u8 *)(&joinbss_rpt) + 8)),
+			   mac->vif->bss_conf.beacon_int, GENMASK(15, 0));
+	le16p_replace_bits((__le16 *)(((u8 *)(&joinbss_rpt) + 10)),
+			   mac->assoc_id, GENMASK(15, 0));
 
 	_rtl92s_firmware_set_h2c_cmd(hw, FW_H2C_JOINBSSRPT, (u8 *)&joinbss_rpt);
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index efb432c6d785..2cab31334a6a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -537,8 +537,8 @@ void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 		/* Fixed queue of H2C command */
 		SET_TX_DESC_QUEUE_SEL(pdesc, 0x13);
 
-		SET_BITS_TO_LE_4BYTE(skb->data, 24, 7, rtlhal->h2c_txcmd_seq);
-
+		le32p_replace_bits((__le32 *)skb->data, rtlhal->h2c_txcmd_seq,
+				   GENMASK(30, 24));
 		SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)(skb->len));
 		SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
 
-- 
2.23.0

