Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B62DDAD1BA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 04:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbfIICAF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 22:00:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46684 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbfIICAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 22:00:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id g19so10919775otg.13
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 19:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vnDlIpKTYetT19yoihz3GyFWqqwWLxsUZ14pSc5h6EY=;
        b=P69mxur0jOT+oA01RTycKfhl2G3fgY5Hmc/yfwF1p0EYZd1M3nMqcjTywo0fCdz3Kf
         rVK6fPcd62C3CVG8xRbTLdeHu0uQZGdeHWtmi/M6Bb6umWhKyPioMshPG5HJ/LWbMROw
         Z5iWEAP/EWgVS62ARCeJXLxIJuYufNIzxNfjey2zOwDl3czo/TGmvCoGPL7T/Aro7NQw
         EkBlHO3Rfdo6HdBQ/fm1E1+b3yPJQ7GFMkJ9YcvgZZY/g8k8DdWr0XGJ3AhTHhoqTbxH
         wjOfbrqv1WxAuudi7liCLh5k7Y6jelk1vbukTgAUVBtoeSCsj4iYPmA8uZ5Zl5s4Vnn/
         kmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vnDlIpKTYetT19yoihz3GyFWqqwWLxsUZ14pSc5h6EY=;
        b=b/W0vCqNpDL6Eqz+nLjfPY80pYjG0yK7gcY8fU8t5q082DEUwm8UEN/k9duwlXDSD3
         lDDXxtx5rO2IlzaZ2thUHltKKiWR0wPz5uZRXZNMCFFEWgzB7bN9kNNHR8j4wK8//unr
         p/suCAsNIXaPDoTpjvcBjCj8NziqCi5pqWod25eLObleXg+TPScMYxXtOeH4LiiDffCx
         Pvr6zi9s4/qCH5i2Q0DpIcbJh1Djo19S84U/519Q1Hm3E1d0S1rqvVbp/IXGZJl3FGZh
         bRg3pwbRVla+wv/g2f8HWDKI/lSzVOdJyZYjUHBWptReclTXXlnaxswjtwDVaQ3kpdSV
         dymA==
X-Gm-Message-State: APjAAAUQV0hL0CG6ASXMtrMF3csZytYTalVMWsH+z4P0V+jMHQn5gxSE
        6jL3KHIKv7YjZBGKvZTqqM4=
X-Google-Smtp-Source: APXvYqxfxBmXuxsMOmIZy36/G/+2lxu6vpAoSCmcvZcjSN/VGHLa5wTBQL26nhYhKJF7xpXUNnxpyA==
X-Received: by 2002:a9d:17d0:: with SMTP id j74mr17306531otj.259.1567994403729;
        Sun, 08 Sep 2019 19:00:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm1468420oij.16.2019.09.08.19.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 19:00:02 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 2/9] rtlwifi: rtl8723ae: Replace local bit manipulation macros
Date:   Sun,  8 Sep 2019 20:59:51 -0500
Message-Id: <20190909015958.29834-3-Larry.Finger@lwfinger.net>
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

