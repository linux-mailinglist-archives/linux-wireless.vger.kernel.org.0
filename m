Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D50BCA4A1E
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfIAPrN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 11:47:13 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44564 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729152AbfIAPrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 11:47:12 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so4007280otj.11
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYf2hfMtg0Kfi690obi/FqMgBzF13cavN2XEHAgilEg=;
        b=hAxIhGQLlKBhXrv4fCo1x1YZEVgethjsPW6hu+tMON0/ZM2gCRqqdxVXZBRxIe4lnh
         J1S0Jdxhc2uFbUN3DgITJmn7iVt7JoHa3K98UqckHvz3CgDyMgTwopavyjn/EilNoqMI
         qwtXjm5pWpA2uMI2VxGE3Jxr3bW/uXzhmKvcixAwhnztX6FFCQrxLlCBl1sL4yD0Agam
         MVKc6xtUx6xR2tpEuKKzVGaaatW0e3ZnJunWzsPUMmA1W/kgI6NCWz9D4ZAqV96iv+9X
         pXvinaWH4e1YO/DbBbfeYdwig9NiRX8s7u7BWWww54T4cGxo7TqosXtrYbO+IMs9VJTE
         HVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=MYf2hfMtg0Kfi690obi/FqMgBzF13cavN2XEHAgilEg=;
        b=bwhHW5FaL9wzBV/lxlD7KfMYFqLTvIBOXT7+VxUZtqQPu38pQGRbEF5ojerV9ixGXB
         B3bbdkxT99pjm3t4wpoOaOkp2xkkvs986iQ6o0AKEk3FCm7C9Z+g+xjOU1pNX66UQdZn
         xQtHGFNcHXydBHPrbhQGuWM0MLzRvF4qpXhGET/E/pYvOXUSrqPEz3Q4omV7UBUwX4f+
         eWDxTFHVMc9vkG011E8xEOPCoY7GaPN3aKAxDSdni7mlW+u1951XtVQNJKIoJEqORZz0
         xtQYTg7GO8LHk+2wxqAwSXO3PB7GgwX9fD7gEmVBUTNLDyS2ANyG/kOUU5n3EjMFZWfS
         4ZPQ==
X-Gm-Message-State: APjAAAW0lt4FlSExLlzWJy1lQBYUrBBvXl+BgBlNGdeq+/7WmMvUstYU
        El/mL7UHFNRZatKUb3mRfH0=
X-Google-Smtp-Source: APXvYqxoJInA+J6cm74ExUTulxr/lQGiIjWeHdl+JNjA55QhMabcpnZzYxkb7+yq0sqmJ5zVvdmOvQ==
X-Received: by 2002:a05:6830:1018:: with SMTP id a24mr6990794otp.191.1567352831442;
        Sun, 01 Sep 2019 08:47:11 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b19sm3186440oie.34.2019.09.01.08.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 08:47:11 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/4] rtlwifi: rtl8192cu: Replace local bit manipulation macros
Date:   Sun,  1 Sep 2019 10:47:04 -0500
Message-Id: <20190901154706.24193-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
References: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This driver uses a set of local macros to manipulate the TX and RX
descriptors, which are all little-endian quantities. These macros
are replaced by the bitfield macros le32p_replace_bits() and
le32_get_bits(). In several places, the macros operated on an entire
32-bit word. In these cases, a direct read or replacement is used.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   | 110 ++++++++++-----------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index 15627a7d42f5..916fa0e98123 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -74,39 +74,39 @@ struct rx_drv_info_92c {
 
 /* DWORD 0 */
 #define GET_RX_DESC_PKT_LEN(__rxdesc)		\
-	LE_BITS_TO_4BYTE((__rxdesc), 0, 14)
+	le32_get_bits(*(__le32 *)__rxdesc, GENMASK(13, 0))
 #define GET_RX_DESC_CRC32(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 14, 1)
+	le32_get_bits(*(__le32 *)__rxdesc, BIT(14))
 #define GET_RX_DESC_ICV(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 15, 1)
+	le32_get_bits(*(__le32 *)__rxdesc, BIT(15))
 #define GET_RX_DESC_DRVINFO_SIZE(__rxdesc)	\
-	LE_BITS_TO_4BYTE(__rxdesc, 16, 4)
+	le32_get_bits(*(__le32 *)__rxdesc, GENMASK(19, 16))
 #define GET_RX_DESC_SHIFT(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 24, 2)
+	le32_get_bits(*(__le32 *)__rxdesc, GENMASK(25, 24))
 #define GET_RX_DESC_PHY_STATUS(__rxdesc)	\
-	LE_BITS_TO_4BYTE(__rxdesc, 26, 1)
+	le32_get_bits(*(__le32 *)__rxdesc, BIT(26))
 #define GET_RX_DESC_SWDEC(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 27, 1)
+	le32_get_bits(*(__le32 *)__rxdesc, BIT(27))
 
 /* DWORD 1 */
 #define GET_RX_DESC_PAGGR(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 14, 1)
+	le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(14))
 #define GET_RX_DESC_FAGGR(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 15, 1)
+	le32_get_bits(*(__le32 *)(__rxdesc + 4), BIT(15))
 
 /* DWORD 3 */
 #define GET_RX_DESC_RX_MCS(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 0, 6)
+	le32_get_bits(*(__le32 *)(__rxdesc + 12), GENMASK(5, 0))
 #define GET_RX_DESC_RX_HT(__rxdesc)            \
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 6, 1)
+	le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(6))
 #define GET_RX_DESC_SPLCP(__rxdesc)            \
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 8, 1)
+	le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(8))
 #define GET_RX_DESC_BW(__rxdesc)               \
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 9, 1)
+	le32_get_bits(*(__le32 *)(__rxdesc + 12), BIT(9))
 
 /* DWORD 5 */
 #define GET_RX_DESC_TSFL(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__rxdesc + 20)))
 
 /*======================= tx desc ============================================*/
 
@@ -114,101 +114,101 @@ struct rx_drv_info_92c {
 
 /* Dword 0 */
 #define SET_TX_DESC_PKT_SIZE(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 0, 16, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(15, 0))
 #define SET_TX_DESC_OFFSET(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 16, 8, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, GENMASK(23, 16))
 #define SET_TX_DESC_BMC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 24, 1, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(24))
 #define SET_TX_DESC_HTC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 25, 1, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(25))
 #define SET_TX_DESC_LAST_SEG(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 26, 1, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(26))
 #define SET_TX_DESC_FIRST_SEG(__txdesc, __value)	\
-	 SET_BITS_TO_LE_4BYTE(__txdesc, 27, 1, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(27))
 #define SET_TX_DESC_LINIP(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 28, 1, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(28))
 #define SET_TX_DESC_OWN(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 31, 1, __value)
+	le32p_replace_bits((__le32 *)__txdesc, __value, BIT(31))
 
 /* Dword 1 */
 #define SET_TX_DESC_MACID(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 0, 5, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(4, 0))
 #define SET_TX_DESC_AGG_ENABLE(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 5, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(5))
 #define SET_TX_DESC_AGG_BREAK(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 6, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(6))
 #define SET_TX_DESC_RDG_ENABLE(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 7, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(7))
 #define SET_TX_DESC_QUEUE_SEL(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 8, 5, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(12, 8))
 #define SET_TX_DESC_RATE_ID(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 16, 4, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(19, 16))
 #define SET_TX_DESC_NAV_USE_HDR(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 20, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, BIT(20))
 #define SET_TX_DESC_SEC_TYPE(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 22, 2, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(23, 22))
 #define SET_TX_DESC_PKT_OFFSET(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 26, 5, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 4), __value, GENMASK(30, 26))
 
 /* Dword 2 */
 #define SET_TX_DESC_MORE_FRAG(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 17, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, BIT(17))
 #define SET_TX_DESC_AMPDU_DENSITY(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 20, 3, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 8), __value, GENMASK(22, 20))
 
 /* Dword 3 */
 #define SET_TX_DESC_SEQ(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 12, 16, 12, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(27, 16))
 #define SET_TX_DESC_PKT_ID(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 12, 28, 4, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 12), __value, GENMASK(31, 28))
 
 /* Dword 4 */
 #define SET_TX_DESC_RTS_RATE(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 0, 5, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(4, 0))
 #define SET_TX_DESC_QOS(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 6, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(6))
 #define SET_TX_DESC_HWSEQ_EN(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 7, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(7))
 #define SET_TX_DESC_USE_RATE(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 8, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(8))
 #define SET_TX_DESC_DISABLE_FB(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 10, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(10))
 #define SET_TX_DESC_CTS2SELF(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 11, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(11))
 #define SET_TX_DESC_RTS_ENABLE(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 12, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(12))
 #define SET_TX_DESC_HW_RTS_ENABLE(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 13, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(13))
 #define SET_TX_DESC_DATA_SC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 20, 2, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(21, 20))
 #define SET_TX_DESC_DATA_BW(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 25, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(25))
 #define SET_TX_DESC_RTS_SHORT(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 26, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(26))
 #define SET_TX_DESC_RTS_BW(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 27, 1, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, BIT(27))
 #define SET_TX_DESC_RTS_SC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 28, 2, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(29, 28))
 #define SET_TX_DESC_RTS_STBC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 30, 2, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 16), __value, GENMASK(31, 30))
 
 /* Dword 5 */
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc + 20, 0, 6, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, GENMASK(5, 0))
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc + 20, 6, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 20), __val, BIT(6))
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__txdesc, __value) \
-	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 8, 5, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(12, 8))
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__txdesc, __value) \
-	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 13, 4, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 20), __value, GENMASK(16, 13))
 
 /* Dword 6 */
 #define SET_TX_DESC_MAX_AGG_NUM(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 11, 5, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 24), __value, GENMASK(15, 11))
 
 /* Dword 7 */
 #define SET_TX_DESC_TX_DESC_CHECKSUM(__txdesc, __value) \
-	SET_BITS_TO_LE_4BYTE(__txdesc + 28, 0, 16, __value)
+	le32p_replace_bits((__le32 *)(__txdesc + 28), __value, GENMASK(15, 0))
 
 int  rtl8192cu_endpoint_mapping(struct ieee80211_hw *hw);
 u16 rtl8192cu_mq_to_hwq(__le16 fc, u16 mac80211_queue_index);
-- 
2.16.4

