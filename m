Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04CA27B735
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 02:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfGaAdR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 20:33:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34719 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfGaAdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 20:33:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id l12so49374553oil.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz78WO/PKrdDmwfvICWcQwXCxDAhE+/keJN3Htd8AaI=;
        b=boExRk71cf4I6+D2MfV0KaQEiwOVlNYp8evs/5iKcKeNWGlHe0L3okRLPvBG6PSR72
         cPoLTYXK0w57CNDr+DMUCiRyBlOLBlJZqBaIs5r1DeITuZfDJPx5vKtCSOcm+wUxebLn
         +ILZ8LNxuFx27xDk0EzoeHbipiKA3ImqAm7o7P35SrsHPSUdBpP5SLj9Lkm4v5oQV4up
         gvIbveMPoqlYUT0udsxDowO3ZtQj8tPyMozTQD+qFFQxQHf2tn8Y+3tEVuMNGUgq55hx
         1BGe/Kd+zAtjASW9YNjFX5t7mTy4jlXePadBVtoNzk48PPdIhubGTytuhFZiggKpgIlD
         8qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mz78WO/PKrdDmwfvICWcQwXCxDAhE+/keJN3Htd8AaI=;
        b=uBtqEaXuO0M6Wh54kFkn1ogVskAdMdxGvhj1f0Y68aN/M7cfNmjaxLAFUSI/6egA9y
         DgusE8y2BcQ4ThG4JSdKPsIMLRz5/ff7mO3y7Dp5FKWJdO4ZA/ff0tkpWTjKzbIxbyN7
         gs78muZItSeeceiRwZYfhEyigKzINr3ZxZXJjLzZgVr1OdJ/CQOnGSCFUKn6uNtvCHOC
         rKgcZSz9WSTDqJrnnfb7amI+eJlA04KD7K5SndX5rQ+TwTcuFupWCmFQSkKJ/VaNUiV3
         mrvLEECI1Nkpmg+XrciQCAqJGrdAXedLnaubAnS9YiFB8d0/IDoHHwvT7DaOBwTQujPJ
         ObTA==
X-Gm-Message-State: APjAAAVclZpm/c8laMA1LvMhN1Jy7dfsXHIRr205mgcT5CXHVSiqCeUa
        8uiEfoWeJoi+xQu1CRSuH3pI9Lg6
X-Google-Smtp-Source: APXvYqwwltuMjDoXpubJ7AdcwKNmr6SwifNgJu+Isv8vTPeQ+24k2kU5TDNDeEWYI96MjI6Cq8up5A==
X-Received: by 2002:a05:6808:8f0:: with SMTP id d16mr2616334oic.47.1564533195466;
        Tue, 30 Jul 2019 17:33:15 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t11sm22156016otq.13.2019.07.30.17.33.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 17:33:14 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/5] rtlwifi: rtl88188ee: Replace local bit manipulation macros
Date:   Tue, 30 Jul 2019 19:33:01 -0500
Message-Id: <20190731003304.14377-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
References: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.h  | 213 +++++++++---------
 1 file changed, 106 insertions(+), 107 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index 60efabc6f87a..8147e95a4cc6 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
@@ -15,241 +15,240 @@
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
 
 #define GET_TX_DESC_OWN(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 #define SET_TX_DESC_MACID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 6, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(5, 0))
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(12, 8))
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 4, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(19, 16))
 #define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 20, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, BIT(20))
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(23, 22))
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 26, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 4), __val, GENMASK(30, 26))
 
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 12, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(12))
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 13, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(13))
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(17))
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, GENMASK(22, 20))
 #define SET_TX_DESC_ANTSEL_A(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 24, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(24))
 #define SET_TX_DESC_ANTSEL_B(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 25, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 8), __val, BIT(25))
 
 #define SET_TX_DESC_SEQ(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 16, 12, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, GENMASK(27, 16))
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 31, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 12), __val, BIT(31))
 
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 5, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(4, 0))
 #define SET_TX_DESC_QOS(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 6, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(6))
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
 #define SET_TX_DESC_TX_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 22, 2, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, GENMASK(23, 22))
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 25, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(25))
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 26, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(26))
 #define SET_TX_DESC_RTS_BW(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 27, 1, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 16), __val, BIT(27))
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
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
 
 #define SET_TX_DESC_ANTSEL_C(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 29, 1, __val)
-
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, BIT(29))
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)     \
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
+	le32p_replace_bits((__le32 *)(__pdesc + 28), __val, GENMASK(15, 0))
 #define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 16)
+	le32_get_bits(*((__le32 *)(__pdesc + 28)), GENMASK(15, 0))
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 0, 32, __val)
+	*(__le32 *)(__pdesc + 32) = cpu_to_le32(__val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+32, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 32)))
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+40, 0, 32, __val)
+	*(__le32 *)(__pdesc + 40) = cpu_to_le32(__val)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 0, 14)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(13, 0))
 #define GET_RX_DESC_CRC32(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 14, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(14))
 #define GET_RX_DESC_ICV(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 15, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(15))
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc, 16, 4)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(19, 16))
 #define GET_RX_DESC_SECURITY(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 20, 3)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(22, 20))
 #define GET_RX_DESC_QOS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 23, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(23))
 #define GET_RX_DESC_SHIFT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 24, 2)
+	le32_get_bits(*((__le32 *)__pdesc), GENMASK(25, 24))
 #define GET_RX_DESC_PHYST(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(26))
 #define GET_RX_DESC_SWDEC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(27))
 #define GET_RX_DESC_LS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(28))
 #define GET_RX_DESC_FS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(29))
 #define GET_RX_DESC_EOR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(30))
 #define GET_RX_DESC_OWN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
+	le32_get_bits(*((__le32 *)__pdesc), BIT(31))
 
 #define SET_RX_DESC_PKT_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 14, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, GENMASK(13, 0))
 #define SET_RX_DESC_EOR(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(30))
 #define SET_RX_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
+	le32p_replace_bits((__le32 *)__pdesc, __val, BIT(31))
 
 #define GET_RX_DESC_MACID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 0, 6)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(5, 0))
 #define GET_RX_DESC_PAGGR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(14))
 #define GET_RX_DESC_FAGGR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(15))
 #define GET_RX_DESC_A1_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(19, 16))
 #define GET_RX_DESC_A2_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 4)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(23, 20))
 #define GET_RX_DESC_PAM(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 24, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(24))
 #define GET_RX_DESC_PWR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 25, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(25))
 #define GET_RX_DESC_MD(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 26, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(26))
 #define GET_RX_DESC_MF(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 27, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(27))
 #define GET_RX_DESC_TYPE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 28, 2)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), GENMASK(29, 28))
 #define GET_RX_DESC_MC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 30, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(30))
 #define GET_RX_DESC_BC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 31, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 4)), BIT(31))
 #define GET_RX_DESC_SEQ(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 0, 12)
+	le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(11, 0))
 #define GET_RX_DESC_FRAG(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 12, 4)
+	le32_get_bits(*((__le32 *)(__pdesc + 8)), GENMASK(15, 12))
 
 #define GET_RX_DESC_RXMCS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 0, 6)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(5, 0))
 #define GET_RX_DESC_RXHT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 6, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(6))
 #define GET_RX_STATUS_DESC_RX_GF(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 7, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(7))
 #define GET_RX_DESC_SPLCP(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 8, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(8))
 #define GET_RX_DESC_BW(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 9, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(9))
 #define GET_RX_DESC_HTC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 10, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(10))
 #define GET_RX_STATUS_DESC_EOSP(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 11, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(11))
 #define GET_RX_STATUS_DESC_BSSID_FIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 12, 2)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(13, 12))
 #define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 14, 2)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), GENMASK(15, 14))
 
 #define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+12, 29, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(29))
 #define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+12, 30, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(30))
 #define GET_RX_STATUS_DESC_MAGIC_MATCH(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 31, 1)
+	le32_get_bits(*((__le32 *)(__pdesc + 12)), BIT(31))
 
 #define GET_RX_DESC_IV1(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 16)))
 #define GET_RX_DESC_TSFL(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 20)))
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 24)))
 #define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 32)
+	le32_to_cpu(*((__le32 *)(__pdesc + 28)))
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
+	*(__le32 *)(__pdesc + 24) = cpu_to_le32(__val)
 #define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val) \
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 32, __val)
+	*(__le32 *)(__pdesc + 28) = cpu_to_le32(__val)
 
 /* TX report 2 format in Rx desc*/
 
 #define GET_RX_RPT2_DESC_PKT_LEN(__status)	\
-	LE_BITS_TO_4BYTE(__status, 0, 9)
+	le32_get_bits(*((__le32 *)__status), GENMASK(8, 0))
 #define GET_RX_RPT2_DESC_MACID_VALID_1(__status)	\
-	LE_BITS_TO_4BYTE(__status+16, 0, 32)
+	le32_to_cpu(*((__le32 *)(__status + 16)))
 #define GET_RX_RPT2_DESC_MACID_VALID_2(__status)	\
-	LE_BITS_TO_4BYTE(__status+20, 0, 32)
+	le32_to_cpu(*((__le32 *)(__status + 20)))
 
 #define SET_EARLYMODE_PKTNUM(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr, 0, 4, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(3, 0))
 #define SET_EARLYMODE_LEN0(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr, 4, 12, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(15, 4))
 #define SET_EARLYMODE_LEN1(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr, 16, 12, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(27, 16))
 #define SET_EARLYMODE_LEN2_1(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr, 28, 4, __value)
+	le32p_replace_bits((__le32 *)__paddr, __value, GENMASK(31, 28))
 #define SET_EARLYMODE_LEN2_2(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 0, 8, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(7, 0))
 #define SET_EARLYMODE_LEN3(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 8, 12, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(19, 8))
 #define SET_EARLYMODE_LEN4(__paddr, __value)	\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 20, 12, __value)
+	le32p_replace_bits((__le32 *)(__paddr + 4), __value, GENMASK(31, 20))
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.22.0

