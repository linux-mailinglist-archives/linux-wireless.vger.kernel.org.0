Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF85D16EA
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 19:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731938AbfJIRhe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 13:37:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41485 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731918AbfJIRhd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 13:37:33 -0400
Received: by mail-ot1-f68.google.com with SMTP id g13so2439330otp.8
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHpdeWIQ6/gu8o3u3TNqOEnCU5alMNucamM0jBLGB4o=;
        b=WBqMLp6aNpDb5rahf41pXfHdXXHtgsVezj1fxC1iw/uQdJUTKp3iavw46TAgDCh7Nw
         Pv1l4APV8kYh5pAnUCvyrS1IlYluXBUcK/sFDbXjjPl11xibTV8f+QqpgTgUEu2JrxiP
         /kPC3Oj99UporPTyZt6VmyYqgl86YvX6F2mINQKvg8WrhoeMw1ZtfI1TcN1DRfm8hgoW
         NKI65WuDKfv8UV3H9lNHYR9LrjPXl4tvaCDQYdJQUufMfegaf+phTm7U5GOzJ76TXumh
         c0AkESpdLVaMhHupeU3bWZ0DPJflHXxsytcZkEW3o9rXV3fJ123HqHjYVHBTXTCoV3Yi
         SJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IHpdeWIQ6/gu8o3u3TNqOEnCU5alMNucamM0jBLGB4o=;
        b=sq8N0Iz+f5dFNwkYBpSJagn1NEuFdS0lu9XwkxYYjO8Dwr+EyK73BEpTDuCPPv46BH
         WUPKmzZPmJptYaFsR4Y2OdNuHaxCidFV0a/rxnPM7Pza7iR6nJsKeCTVPmKGXUAi7lJ9
         4TrZ7xy1NeFm1xbKSgbOc5p8cLS3xaOa+1SMraA/6ht3IiYHhb0yfeujOvP8wQ7EEx/z
         umMTjE0nIXTMOJl4l636admfoohGlUTuKwTXDy/dKlRW+PWrsqJkohn6J9PVEl5TLOD/
         OuoL/3ypQgLulJmJT5cEsJjq6KAORt6b1O0yLl+c78hIw+ziTFY6Gpb6woqktwWzTKu5
         2XXg==
X-Gm-Message-State: APjAAAV4Ukk/azSzJMTLtZQCK0DQpLUYdPxMyyGBxxfIe+DLdU8/S4OU
        tF7OY8ny8p+knLsAqyyH2b8=
X-Google-Smtp-Source: APXvYqywF/FFDS1FAVvR+Mo1mpXwL8q5noUfMWT9/34ad3W3JPqnlrtvG6tj2PS4l5A1cmKaUoj/5g==
X-Received: by 2002:a9d:6858:: with SMTP id c24mr3820194oto.124.1570642650131;
        Wed, 09 Oct 2019 10:37:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s66sm848199otb.65.2019.10.09.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:37:29 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 3/4] rtlwifi: rtl8192se: Convert macros that set descriptor
Date:   Wed,  9 Oct 2019 12:37:10 -0500
Message-Id: <20191009173711.20348-4-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
References: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As a first step in the conversion, the macros that set the RX and TX
descriptors are converted to static inline routines, and the names are
changed from upper to lower case. To minimize the changes in a given
step, the input descriptor information is left as as a byte array
(u8 *), even though it should be a little-endian word array (__le32 *).
That will be changed in the next patch.

Several places where checkpatch.pl complains about a space after a cast
and other warnings are fixed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8192se/def.h  | 374 ++++++++++++------
 .../wireless/realtek/rtlwifi/rtl8192se/trx.c  | 161 ++++----
 2 files changed, 341 insertions(+), 194 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
index 19db124fbdda..09baa74709ea 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
@@ -27,91 +27,183 @@
 /* macros to read/write various fields in RX or TX descriptors */
 
 /* Dword 0 */
-#define SET_TX_DESC_PKT_SIZE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16))
-#define SET_TX_DESC_LAST_SEG(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26))
-#define SET_TX_DESC_FIRST_SEG(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27))
-#define SET_TX_DESC_LINIP(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28))
-#define SET_TX_DESC_OWN(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_TX_DESC_OWN(__pdesc)				\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
+static inline void set_tx_desc_pkt_size(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(15, 0));
+}
+
+static inline void set_tx_desc_offset(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(23, 16));
+}
+
+static inline void set_tx_desc_last_seg(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(26));
+}
+
+static inline void set_tx_desc_first_seg(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(27));
+}
+
+static inline void set_tx_desc_linip(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(28));
+}
+
+static inline void set_tx_desc_own(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
+
+static inline u32 get_tx_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+}
 
 /* Dword 1 */
-#define SET_TX_DESC_MACID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0))
-#define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
-#define SET_TX_DESC_NON_QOS(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(16))
-#define SET_TX_DESC_SEC_TYPE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
+static inline void set_tx_desc_macid(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(4, 0));
+}
+
+static inline void set_tx_desc_queue_sel(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8));
+}
+
+static inline void set_tx_desc_non_qos(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(16));
+}
+
+static inline void set_tx_desc_sec_type(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22));
+}
 
 /* Dword 2 */
-#define	SET_TX_DESC_RSVD_MACID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(28, 24))
-#define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(29))
+static inline void	set_tx_desc_rsvd_macid(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(28, 24));
+}
+
+static inline void set_tx_desc_agg_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(29));
+}
 
 /* Dword 3 */
-#define SET_TX_DESC_SEQ(__pdesc, __val)				\
-	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
+static inline void set_tx_desc_seq(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16));
+}
 
 /* Dword 4 */
-#define SET_TX_DESC_RTS_RATE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(5, 0))
-#define SET_TX_DESC_CTS_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11))
-#define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12))
-#define SET_TX_DESC_RA_BRSR_ID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(15, 13))
-#define SET_TX_DESC_TXHT(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(16))
-#define SET_TX_DESC_TX_SHORT(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(17))
-#define SET_TX_DESC_TX_BANDWIDTH(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(18))
-#define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(20, 19))
-#define SET_TX_DESC_RTS_SHORT(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25))
-#define SET_TX_DESC_RTS_BANDWIDTH(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26))
-#define SET_TX_DESC_RTS_SUB_CARRIER(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 27))
-#define SET_TX_DESC_RTS_STBC(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(30, 29))
-#define SET_TX_DESC_USER_RATE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(31))
+static inline void set_tx_desc_rts_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(5, 0));
+}
+
+static inline void set_tx_desc_cts_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(11));
+}
+
+static inline void set_tx_desc_rts_enable(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(12));
+}
+
+static inline void set_tx_desc_ra_brsr_id(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(15, 13));
+}
+
+static inline void set_tx_desc_txht(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(16));
+}
+
+static inline void set_tx_desc_tx_short(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(17));
+}
+
+static inline void set_tx_desc_tx_bandwidth(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(18));
+}
+
+static inline void set_tx_desc_tx_sub_carrier(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(20, 19));
+}
+
+static inline void set_tx_desc_rts_short(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25));
+}
+
+static inline void set_tx_desc_rts_bandwidth(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26));
+}
+
+static inline void set_tx_desc_rts_sub_carrier(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(28, 27));
+}
+
+static inline void set_tx_desc_rts_stbc(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(30, 29));
+}
+
+static inline void set_tx_desc_user_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(31));
+}
 
 /* Dword 5 */
-#define SET_TX_DESC_PACKET_ID(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(8, 0))
-#define SET_TX_DESC_TX_RATE(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(14, 9))
-#define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(20, 16))
+static inline void set_tx_desc_packet_id(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(8, 0));
+}
+
+static inline void set_tx_desc_tx_rate(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(14, 9));
+}
+
+static inline void set_tx_desc_data_rate_fb_limit(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(20, 16));
+}
 
 /* Dword 7 */
-#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
+static inline void set_tx_desc_tx_buffer_size(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0));
+}
 
 /* Dword 8 */
-#define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)		\
-	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
-#define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 32)))
+static inline void set_tx_desc_tx_buffer_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val);
+}
+
+static inline u32 get_tx_desc_tx_buffer_address(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 32)));
+}
 
 /* Dword 9 */
-#define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)		\
-	*(__le32 *)(__pdesc + 36) = cpu_to_le32(__val)
+static inline void set_tx_desc_next_desc_address(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 36) = cpu_to_le32(__val);
+}
 
 /* Because the PCI Tx descriptors are chaied at the
  * initialization and all the NextDescAddresses in
@@ -128,61 +220,115 @@
 #define RX_DRV_INFO_SIZE_UNIT				8
 
 /* DWORD 0 */
-#define SET_RX_STATUS_DESC_PKT_LEN(__pdesc, __val)		\
-	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
-#define SET_RX_STATUS_DESC_EOR(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
-#define SET_RX_STATUS_DESC_OWN(__pdesc, __val)			\
-	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
-
-#define GET_RX_STATUS_DESC_PKT_LEN(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0))
-#define GET_RX_STATUS_DESC_CRC32(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(14))
-#define GET_RX_STATUS_DESC_ICV(__pdesc)				\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(15))
-#define GET_RX_STATUS_DESC_DRVINFO_SIZE(__pdesc)		\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16))
-#define GET_RX_STATUS_DESC_SHIFT(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24))
-#define GET_RX_STATUS_DESC_PHY_STATUS(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(26))
-#define GET_RX_STATUS_DESC_SWDEC(__pdesc)			\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(27))
-#define GET_RX_STATUS_DESC_OWN(__pdesc)				\
-	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
+static inline void set_rx_status_desc_pkt_len(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0));
+}
+
+static inline void set_rx_status_desc_eor(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30));
+}
+
+static inline void set_rx_status_desc_own(u8 *__pdesc, u32 __val)
+{
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31));
+}
+
+static inline u32 get_rx_status_desc_pkt_len(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0));
+}
+
+static inline u32 get_rx_status_desc_crc32(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(14));
+}
+
+static inline u32 get_rx_status_desc_icv(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(15));
+}
+
+static inline u32 get_rx_status_desc_drvinfo_size(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16));
+}
+
+static inline u32 get_rx_status_desc_shift(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24));
+}
+
+static inline u32 get_rx_status_desc_phy_status(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(26));
+}
+
+static inline u32 get_rx_status_desc_swdec(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(27));
+}
+
+static inline u32 get_rx_status_desc_own(u8 *__pdesc)
+{
+	return le32_get_bits(*((__le32 *)__pdesc), BIT(31));
+}
 
 /* DWORD 1 */
-#define GET_RX_STATUS_DESC_PAGGR(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14))
-#define GET_RX_STATUS_DESC_FAGGR(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15))
+static inline u32 get_rx_status_desc_paggr(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(14));
+}
+
+static inline u32 get_rx_status_desc_faggr(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 4), BIT(15));
+}
 
 /* DWORD 3 */
-#define GET_RX_STATUS_DESC_RX_MCS(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0))
-#define GET_RX_STATUS_DESC_RX_HT(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6))
-#define GET_RX_STATUS_DESC_SPLCP(__pdesc)			\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8))
-#define GET_RX_STATUS_DESC_BW(__pdesc)				\
-	le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9))
+static inline u32 get_rx_status_desc_rx_mcs(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), GENMASK(5, 0));
+}
+
+static inline u32 get_rx_status_desc_rx_ht(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(6));
+}
+
+static inline u32 get_rx_status_desc_splcp(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(8));
+}
+
+static inline u32 get_rx_status_desc_bw(u8 *__pdesc)
+{
+	return le32_get_bits(*(__le32 *)(__pdesc + 12), BIT(9));
+}
 
 /* DWORD 5 */
-#define GET_RX_STATUS_DESC_TSFL(__pdesc)			\
-	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
+static inline u32 get_rx_status_desc_tsfl(u8 *__pdesc)
+{
+	return le32_to_cpu(*((__le32 *)(__pdesc + 20)));
+}
 
 /* DWORD 6 */
-#define SET_RX_STATUS__DESC_BUFF_ADDR(__pdesc, __val)	\
-	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
-#define GET_RX_STATUS_DESC_BUFF_ADDR(__pdesc)			\
-	le32_to_cpu(*(__le32 *)(__pdesc + 24))
+static inline void set_rx_status__desc_buff_addr(u8 *__pdesc, u32 __val)
+{
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val);
+}
+
+static inline u32 get_rx_status_desc_buff_addr(u8 *__pdesc)
+{
+	return le32_to_cpu(*(__le32 *)(__pdesc + 24));
+}
 
 #define SE_RX_HAL_IS_CCK_RATE(_pdesc)\
-	(GET_RX_STATUS_DESC_RX_MCS(_pdesc) == DESC_RATE1M ||	\
-	 GET_RX_STATUS_DESC_RX_MCS(_pdesc) == DESC_RATE2M ||	\
-	 GET_RX_STATUS_DESC_RX_MCS(_pdesc) == DESC_RATE5_5M ||\
-	 GET_RX_STATUS_DESC_RX_MCS(_pdesc) == DESC_RATE11M)
+	(get_rx_status_desc_rx_mcs(_pdesc) == DESC_RATE1M ||	\
+	 get_rx_status_desc_rx_mcs(_pdesc) == DESC_RATE2M ||	\
+	 get_rx_status_desc_rx_mcs(_pdesc) == DESC_RATE5_5M ||\
+	 get_rx_status_desc_rx_mcs(_pdesc) == DESC_RATE11M)
 
 enum rf_optype {
 	RF_OP_BY_SW_3WIRE = 0,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index 2cab31334a6a..911bca8233e6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -236,25 +236,25 @@ bool rtl92se_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
 			   struct sk_buff *skb)
 {
 	struct rx_fwinfo *p_drvinfo;
-	u32 phystatus = (u32)GET_RX_STATUS_DESC_PHY_STATUS(pdesc);
+	u32 phystatus = (u32)get_rx_status_desc_phy_status(pdesc);
 	struct ieee80211_hdr *hdr;
 
-	stats->length = (u16)GET_RX_STATUS_DESC_PKT_LEN(pdesc);
-	stats->rx_drvinfo_size = (u8)GET_RX_STATUS_DESC_DRVINFO_SIZE(pdesc) * 8;
-	stats->rx_bufshift = (u8)(GET_RX_STATUS_DESC_SHIFT(pdesc) & 0x03);
-	stats->icv = (u16)GET_RX_STATUS_DESC_ICV(pdesc);
-	stats->crc = (u16)GET_RX_STATUS_DESC_CRC32(pdesc);
+	stats->length = (u16)get_rx_status_desc_pkt_len(pdesc);
+	stats->rx_drvinfo_size = (u8)get_rx_status_desc_drvinfo_size(pdesc) * 8;
+	stats->rx_bufshift = (u8)(get_rx_status_desc_shift(pdesc) & 0x03);
+	stats->icv = (u16)get_rx_status_desc_icv(pdesc);
+	stats->crc = (u16)get_rx_status_desc_crc32(pdesc);
 	stats->hwerror = (u16)(stats->crc | stats->icv);
-	stats->decrypted = !GET_RX_STATUS_DESC_SWDEC(pdesc);
-
-	stats->rate = (u8)GET_RX_STATUS_DESC_RX_MCS(pdesc);
-	stats->shortpreamble = (u16)GET_RX_STATUS_DESC_SPLCP(pdesc);
-	stats->isampdu = (bool)(GET_RX_STATUS_DESC_PAGGR(pdesc) == 1);
-	stats->isfirst_ampdu = (bool) ((GET_RX_STATUS_DESC_PAGGR(pdesc) == 1)
-			       && (GET_RX_STATUS_DESC_FAGGR(pdesc) == 1));
-	stats->timestamp_low = GET_RX_STATUS_DESC_TSFL(pdesc);
-	stats->rx_is40mhzpacket = (bool)GET_RX_STATUS_DESC_BW(pdesc);
-	stats->is_ht = (bool)GET_RX_STATUS_DESC_RX_HT(pdesc);
+	stats->decrypted = !get_rx_status_desc_swdec(pdesc);
+
+	stats->rate = (u8)get_rx_status_desc_rx_mcs(pdesc);
+	stats->shortpreamble = (u16)get_rx_status_desc_splcp(pdesc);
+	stats->isampdu = (bool)(get_rx_status_desc_paggr(pdesc) == 1);
+	stats->isfirst_ampdu = (bool)((get_rx_status_desc_paggr(pdesc) == 1) &&
+				      (get_rx_status_desc_faggr(pdesc) == 1));
+	stats->timestamp_low = get_rx_status_desc_tsfl(pdesc);
+	stats->rx_is40mhzpacket = (bool)get_rx_status_desc_bw(pdesc);
+	stats->is_ht = (bool)get_rx_status_desc_rx_ht(pdesc);
 	stats->is_cck = SE_RX_HAL_IS_CCK_RATE(pdesc);
 
 	if (stats->hwerror)
@@ -360,13 +360,13 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 		if (rtlpriv->dm.useramask) {
 			/* set txdesc macId */
 			if (ptcb_desc->mac_id < 32) {
-				SET_TX_DESC_MACID(pdesc, ptcb_desc->mac_id);
+				set_tx_desc_macid(pdesc, ptcb_desc->mac_id);
 				reserved_macid |= ptcb_desc->mac_id;
 			}
 		}
-		SET_TX_DESC_RSVD_MACID(pdesc, reserved_macid);
+		set_tx_desc_rsvd_macid(pdesc, reserved_macid);
 
-		SET_TX_DESC_TXHT(pdesc, ((ptcb_desc->hw_rate >=
+		set_tx_desc_txht(pdesc, ((ptcb_desc->hw_rate >=
 				 DESC_RATEMCS0) ? 1 : 0));
 
 		if (rtlhal->version == VERSION_8192S_ACUT) {
@@ -378,31 +378,32 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 			}
 		}
 
-		SET_TX_DESC_TX_RATE(pdesc, ptcb_desc->hw_rate);
+		set_tx_desc_tx_rate(pdesc, ptcb_desc->hw_rate);
 
 		if (ptcb_desc->use_shortgi || ptcb_desc->use_shortpreamble)
-			SET_TX_DESC_TX_SHORT(pdesc, 0);
+			set_tx_desc_tx_short(pdesc, 0);
 
 		/* Aggregation related */
 		if (info->flags & IEEE80211_TX_CTL_AMPDU)
-			SET_TX_DESC_AGG_ENABLE(pdesc, 1);
+			set_tx_desc_agg_enable(pdesc, 1);
 
 		/* For AMPDU, we must insert SSN into TX_DESC */
-		SET_TX_DESC_SEQ(pdesc, seq_number);
+		set_tx_desc_seq(pdesc, seq_number);
 
 		/* Protection mode related */
 		/* For 92S, if RTS/CTS are set, HW will execute RTS. */
 		/* We choose only one protection mode to execute */
-		SET_TX_DESC_RTS_ENABLE(pdesc, ((ptcb_desc->rts_enable &&
-				!ptcb_desc->cts_enable) ? 1 : 0));
-		SET_TX_DESC_CTS_ENABLE(pdesc, ((ptcb_desc->cts_enable) ?
+		set_tx_desc_rts_enable(pdesc, ((ptcb_desc->rts_enable &&
+						!ptcb_desc->cts_enable) ?
+					       1 : 0));
+		set_tx_desc_cts_enable(pdesc, ((ptcb_desc->cts_enable) ?
 				       1 : 0));
-		SET_TX_DESC_RTS_STBC(pdesc, ((ptcb_desc->rts_stbc) ? 1 : 0));
+		set_tx_desc_rts_stbc(pdesc, ((ptcb_desc->rts_stbc) ? 1 : 0));
 
-		SET_TX_DESC_RTS_RATE(pdesc, ptcb_desc->rts_rate);
-		SET_TX_DESC_RTS_BANDWIDTH(pdesc, 0);
-		SET_TX_DESC_RTS_SUB_CARRIER(pdesc, ptcb_desc->rts_sc);
-		SET_TX_DESC_RTS_SHORT(pdesc, ((ptcb_desc->rts_rate <=
+		set_tx_desc_rts_rate(pdesc, ptcb_desc->rts_rate);
+		set_tx_desc_rts_bandwidth(pdesc, 0);
+		set_tx_desc_rts_sub_carrier(pdesc, ptcb_desc->rts_sc);
+		set_tx_desc_rts_short(pdesc, ((ptcb_desc->rts_rate <=
 		       DESC_RATE54M) ?
 		       (ptcb_desc->rts_use_shortpreamble ? 1 : 0)
 		       : (ptcb_desc->rts_use_shortgi ? 1 : 0)));
@@ -411,27 +412,27 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 		/* Set Bandwidth and sub-channel settings. */
 		if (bw_40) {
 			if (ptcb_desc->packet_bw) {
-				SET_TX_DESC_TX_BANDWIDTH(pdesc, 1);
+				set_tx_desc_tx_bandwidth(pdesc, 1);
 				/* use duplicated mode */
-				SET_TX_DESC_TX_SUB_CARRIER(pdesc, 0);
+				set_tx_desc_tx_sub_carrier(pdesc, 0);
 			} else {
-				SET_TX_DESC_TX_BANDWIDTH(pdesc, 0);
-				SET_TX_DESC_TX_SUB_CARRIER(pdesc,
+				set_tx_desc_tx_bandwidth(pdesc, 0);
+				set_tx_desc_tx_sub_carrier(pdesc,
 						   mac->cur_40_prime_sc);
 			}
 		} else {
-			SET_TX_DESC_TX_BANDWIDTH(pdesc, 0);
-			SET_TX_DESC_TX_SUB_CARRIER(pdesc, 0);
+			set_tx_desc_tx_bandwidth(pdesc, 0);
+			set_tx_desc_tx_sub_carrier(pdesc, 0);
 		}
 
 		/* 3 Fill necessary field in First Descriptor */
 		/*DWORD 0*/
-		SET_TX_DESC_LINIP(pdesc, 0);
-		SET_TX_DESC_OFFSET(pdesc, 32);
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16) skb->len);
+		set_tx_desc_linip(pdesc, 0);
+		set_tx_desc_offset(pdesc, 32);
+		set_tx_desc_pkt_size(pdesc, (u16)skb->len);
 
 		/*DWORD 1*/
-		SET_TX_DESC_RA_BRSR_ID(pdesc, ptcb_desc->ratr_index);
+		set_tx_desc_ra_brsr_id(pdesc, ptcb_desc->ratr_index);
 
 		/* Fill security related */
 		if (info->control.hw_key) {
@@ -441,51 +442,51 @@ void rtl92se_tx_fill_desc(struct ieee80211_hw *hw,
 			switch (keyconf->cipher) {
 			case WLAN_CIPHER_SUITE_WEP40:
 			case WLAN_CIPHER_SUITE_WEP104:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x1);
+				set_tx_desc_sec_type(pdesc, 0x1);
 				break;
 			case WLAN_CIPHER_SUITE_TKIP:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x2);
+				set_tx_desc_sec_type(pdesc, 0x2);
 				break;
 			case WLAN_CIPHER_SUITE_CCMP:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x3);
+				set_tx_desc_sec_type(pdesc, 0x3);
 				break;
 			default:
-				SET_TX_DESC_SEC_TYPE(pdesc, 0x0);
+				set_tx_desc_sec_type(pdesc, 0x0);
 				break;
 
 			}
 		}
 
 		/* Set Packet ID */
-		SET_TX_DESC_PACKET_ID(pdesc, 0);
+		set_tx_desc_packet_id(pdesc, 0);
 
 		/* We will assign magement queue to BK. */
-		SET_TX_DESC_QUEUE_SEL(pdesc, fw_qsel);
+		set_tx_desc_queue_sel(pdesc, fw_qsel);
 
 		/* Alwasy enable all rate fallback range */
-		SET_TX_DESC_DATA_RATE_FB_LIMIT(pdesc, 0x1F);
+		set_tx_desc_data_rate_fb_limit(pdesc, 0x1F);
 
 		/* Fix: I don't kown why hw use 6.5M to tx when set it */
-		SET_TX_DESC_USER_RATE(pdesc,
+		set_tx_desc_user_rate(pdesc,
 				      ptcb_desc->use_driver_rate ? 1 : 0);
 
 		/* Set NON_QOS bit. */
 		if (!ieee80211_is_data_qos(fc))
-			SET_TX_DESC_NON_QOS(pdesc, 1);
+			set_tx_desc_non_qos(pdesc, 1);
 
 	}
 
 	/* Fill fields that are required to be initialized
 	 * in all of the descriptors */
 	/*DWORD 0 */
-	SET_TX_DESC_FIRST_SEG(pdesc, (firstseg ? 1 : 0));
-	SET_TX_DESC_LAST_SEG(pdesc, (lastseg ? 1 : 0));
+	set_tx_desc_first_seg(pdesc, (firstseg ? 1 : 0));
+	set_tx_desc_last_seg(pdesc, (lastseg ? 1 : 0));
 
 	/* DWORD 7 */
-	SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16) skb->len);
+	set_tx_desc_tx_buffer_size(pdesc, (u16)skb->len);
 
 	/* DOWRD 8 */
-	SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+	set_tx_desc_tx_buffer_address(pdesc, mapping);
 
 	RT_TRACE(rtlpriv, COMP_SEND, DBG_TRACE, "\n");
 }
@@ -512,38 +513,38 @@ void rtl92se_tx_fill_cmddesc(struct ieee80211_hw *hw, u8 *pdesc,
 	/* This bit indicate this packet is used for FW download. */
 	if (tcb_desc->cmd_or_init == DESC_PACKET_TYPE_INIT) {
 		/* For firmware downlaod we only need to set LINIP */
-		SET_TX_DESC_LINIP(pdesc, tcb_desc->last_inipkt);
+		set_tx_desc_linip(pdesc, tcb_desc->last_inipkt);
 
 		/* 92SE must set as 1 for firmware download HW DMA error */
-		SET_TX_DESC_FIRST_SEG(pdesc, 1);
-		SET_TX_DESC_LAST_SEG(pdesc, 1);
+		set_tx_desc_first_seg(pdesc, 1);
+		set_tx_desc_last_seg(pdesc, 1);
 
 		/* 92SE need not to set TX packet size when firmware download */
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16)(skb->len));
-		SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)(skb->len));
-		SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+		set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
+		set_tx_desc_tx_buffer_size(pdesc, (u16)(skb->len));
+		set_tx_desc_tx_buffer_address(pdesc, mapping);
 
 		wmb();
-		SET_TX_DESC_OWN(pdesc, 1);
+		set_tx_desc_own(pdesc, 1);
 	} else { /* H2C Command Desc format (Host TXCMD) */
 		/* 92SE must set as 1 for firmware download HW DMA error */
-		SET_TX_DESC_FIRST_SEG(pdesc, 1);
-		SET_TX_DESC_LAST_SEG(pdesc, 1);
+		set_tx_desc_first_seg(pdesc, 1);
+		set_tx_desc_last_seg(pdesc, 1);
 
-		SET_TX_DESC_OFFSET(pdesc, 0x20);
+		set_tx_desc_offset(pdesc, 0x20);
 
 		/* Buffer size + command header */
-		SET_TX_DESC_PKT_SIZE(pdesc, (u16)(skb->len));
+		set_tx_desc_pkt_size(pdesc, (u16)(skb->len));
 		/* Fixed queue of H2C command */
-		SET_TX_DESC_QUEUE_SEL(pdesc, 0x13);
+		set_tx_desc_queue_sel(pdesc, 0x13);
 
 		le32p_replace_bits((__le32 *)skb->data, rtlhal->h2c_txcmd_seq,
 				   GENMASK(30, 24));
-		SET_TX_DESC_TX_BUFFER_SIZE(pdesc, (u16)(skb->len));
-		SET_TX_DESC_TX_BUFFER_ADDRESS(pdesc, mapping);
+		set_tx_desc_tx_buffer_size(pdesc, (u16)(skb->len));
+		set_tx_desc_tx_buffer_address(pdesc, mapping);
 
 		wmb();
-		SET_TX_DESC_OWN(pdesc, 1);
+		set_tx_desc_own(pdesc, 1);
 
 	}
 }
@@ -555,10 +556,10 @@ void rtl92se_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 		switch (desc_name) {
 		case HW_DESC_OWN:
 			wmb();
-			SET_TX_DESC_OWN(pdesc, 1);
+			set_tx_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_TX_NEXTDESC_ADDR:
-			SET_TX_DESC_NEXT_DESC_ADDRESS(pdesc, *(u32 *) val);
+			set_tx_desc_next_desc_address(pdesc, *(u32 *)val);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192se: ERR txdesc :%d not processed\n",
@@ -569,16 +570,16 @@ void rtl92se_set_desc(struct ieee80211_hw *hw, u8 *pdesc, bool istx,
 		switch (desc_name) {
 		case HW_DESC_RXOWN:
 			wmb();
-			SET_RX_STATUS_DESC_OWN(pdesc, 1);
+			set_rx_status_desc_own(pdesc, 1);
 			break;
 		case HW_DESC_RXBUFF_ADDR:
-			SET_RX_STATUS__DESC_BUFF_ADDR(pdesc, *(u32 *) val);
+			set_rx_status__desc_buff_addr(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			SET_RX_STATUS_DESC_PKT_LEN(pdesc, *(u32 *) val);
+			set_rx_status_desc_pkt_len(pdesc, *(u32 *)val);
 			break;
 		case HW_DESC_RXERO:
-			SET_RX_STATUS_DESC_EOR(pdesc, 1);
+			set_rx_status_desc_eor(pdesc, 1);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192se: ERR rxdesc :%d not processed\n",
@@ -596,10 +597,10 @@ u64 rtl92se_get_desc(struct ieee80211_hw *hw,
 	if (istx) {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_TX_DESC_OWN(desc);
+			ret = get_tx_desc_own(desc);
 			break;
 		case HW_DESC_TXBUFF_ADDR:
-			ret = GET_TX_DESC_TX_BUFFER_ADDRESS(desc);
+			ret = get_tx_desc_tx_buffer_address(desc);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192se: ERR txdesc :%d not processed\n",
@@ -609,13 +610,13 @@ u64 rtl92se_get_desc(struct ieee80211_hw *hw,
 	} else {
 		switch (desc_name) {
 		case HW_DESC_OWN:
-			ret = GET_RX_STATUS_DESC_OWN(desc);
+			ret = get_rx_status_desc_own(desc);
 			break;
 		case HW_DESC_RXPKT_LEN:
-			ret = GET_RX_STATUS_DESC_PKT_LEN(desc);
+			ret = get_rx_status_desc_pkt_len(desc);
 			break;
 		case HW_DESC_RXBUFF_ADDR:
-			ret = GET_RX_STATUS_DESC_BUFF_ADDR(desc);
+			ret = get_rx_status_desc_buff_addr(desc);
 			break;
 		default:
 			WARN_ONCE(true, "rtl8192se: ERR rxdesc :%d not processed\n",
-- 
2.23.0

