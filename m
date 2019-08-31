Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027B1A45B7
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 20:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfHaSHC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 14:07:02 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44942 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728477AbfHaSHB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 14:07:01 -0400
Received: by mail-ot1-f65.google.com with SMTP id 21so2564070otj.11
        for <linux-wireless@vger.kernel.org>; Sat, 31 Aug 2019 11:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SF6+s1mMEwMbP6BDHjgKizGndN1G1JPnKN6qRjeAvaQ=;
        b=tqZuMZXWOK0khH8sDKIE1bXk9YIpZVNTpRGqWUXddnLPF3bl19VDYOSo5CPECMme+9
         7rwMvhyZFFaRGZLiIXrsLe1G1pTMheYJdfAsJvPnThY4OwXwKlkVAFGw+l6T+SU+hckV
         Hgb+6qbLOu9VePeqtSOYkfuoA7gCOVhsfhXsFvPtS7PGXkBQT0s4jJTfMj4tUt2PlN5b
         QRvD/j1SFxMby1SAXMH/MpL7ITIfjfvkxGVh8UF53F0IL53bDFJkL3JIDoSvnEYp22w3
         b/Omp7ObJoc86QaFlhYKlgGILrFByt/aWWWdRieadCWCxOVv9xF17aY4L2VHPvHJ4aUl
         8xEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=SF6+s1mMEwMbP6BDHjgKizGndN1G1JPnKN6qRjeAvaQ=;
        b=aCwwdd+Of70Hps8+gac1SbL+xjYvXz5iw21QVyJmNlKiijp5tKwtI6zXp3Lh/1uuVa
         9cvXkkH0+YDY8tIXl7Qww0qSd2fFYri2cM524PM9OiMzhiLV4dthcgwusbiAWGXgzEZL
         qBkX7kzDpXSuWbQbig7lNFP3Pp04di3AYJi1+XcQ3+zE7X079y/VtoBZO3IRJ5puZ6ic
         HYHotgD/TxHr9GGnugtKpD+5zRoBPb3BwYmJeF0IMlFKGH+Jk5H5kwwsok1tJOSMcIBW
         np8AvYA071T1jK8Gab0ZZBApUpgd424WPHAlwnz/KzYEbbF9emhd37iUMgLgQubWavwF
         7lJQ==
X-Gm-Message-State: APjAAAWeDrTYdfrTmxxcWV8Cu/evZdy58LOX0Gn1x5CfeYhtT7SN+bXS
        lneRCiwUxTodcMQ5cyW0ums=
X-Google-Smtp-Source: APXvYqz0TEfy3dYXeTLOAr3VomZxAkcQfxJyfkVIQPovRRWcLfDvzhfCKxeBPEKccUhBajbkCGup0A==
X-Received: by 2002:a9d:7d16:: with SMTP id v22mr16682715otn.70.1567274820160;
        Sat, 31 Aug 2019 11:07:00 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c11sm3222346otr.54.2019.08.31.11.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 31 Aug 2019 11:06:59 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/5] rtlwifi: rtl8192ee: Remove unused GET_XXX and SET_XXX
Date:   Sat, 31 Aug 2019 13:06:40 -0500
Message-Id: <20190831180644.7937-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
References: <20190831180644.7937-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As the first step in converting from macros that get/set information
in the RX and TX descriptors, unused macros are being removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8192ee/trx.h   | 243 +--------------------
 1 file changed, 2 insertions(+), 241 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
index a9e5e620a653..9a68edd3ea0a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/trx.h
@@ -28,125 +28,34 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc, 27, 1, __val)
 #define SET_TX_DESC_LINIP(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc, 28, 1, __val)
-#define SET_TX_DESC_NO_ACM(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 29, 1, __val)
-#define SET_TX_DESC_GF(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
 #define SET_TX_DESC_OWN(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
 
-#define GET_TX_DESC_PKT_SIZE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 0, 16)
-#define GET_TX_DESC_OFFSET(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 16, 8)
-#define GET_TX_DESC_BMC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 24, 1)
-#define GET_TX_DESC_HTC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 25, 1)
-#define GET_TX_DESC_LAST_SEG(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
-#define GET_TX_DESC_FIRST_SEG(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
-#define GET_TX_DESC_LINIP(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
-#define GET_TX_DESC_NO_ACM(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
-#define GET_TX_DESC_GF(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
 #define GET_TX_DESC_OWN(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
 
 #define SET_TX_DESC_MACID(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 7, __val)
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
-#define SET_TX_DESC_RDG_NAV_EXT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 13, 1, __val)
-#define SET_TX_DESC_LSIG_TXOP_EN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 14, 1, __val)
-#define SET_TX_DESC_PIFS(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 15, 1, __val)
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 5, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 24, 5, __val)
-#define SET_TX_DESC_MORE_DATA(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 29, 1, __val)
-#define SET_TX_DESC_TXOP_PS_CAP(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 30, 1, __val)
-#define SET_TX_DESC_TXOP_PS_MODE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 31, 1, __val)
-
-#define GET_TX_DESC_MACID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 0, 5)
-#define GET_TX_DESC_AGG_ENABLE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 5, 1)
-#define GET_TX_DESC_AGG_BREAK(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 6, 1)
-#define GET_TX_DESC_RDG_ENABLE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 7, 1)
-#define GET_TX_DESC_QUEUE_SEL(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 8, 5)
-#define GET_TX_DESC_RDG_NAV_EXT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 13, 1)
-#define GET_TX_DESC_LSIG_TXOP_EN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
-#define GET_TX_DESC_PIFS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
-#define GET_TX_DESC_RATE_ID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
-#define GET_TX_DESC_NAV_USE_HDR(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 1)
-#define GET_TX_DESC_EN_DESC_ID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 21, 1)
-#define GET_TX_DESC_SEC_TYPE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 22, 2)
-#define GET_TX_DESC_PKT_OFFSET(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 24, 5)
-
-#define SET_TX_DESC_PAID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 0, 9, __val)
-#define SET_TX_DESC_CCA_RTS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 10, 2, __val)
+
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 12, 1, __val)
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 13, 1, __val)
-#define SET_TX_DESC_NULL_0(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 14, 1, __val)
-#define SET_TX_DESC_NULL_1(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 15, 1, __val)
-#define SET_TX_DESC_BK(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 16, 1, __val)
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
-#define SET_TX_DESC_RAW(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 18, 1, __val)
-#define SET_TX_DESC_SPE_RPT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 19, 1, __val)
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
-#define SET_TX_DESC_BT_NULL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 23, 1, __val)
-#define SET_TX_DESC_GID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 24, 6, __val)
-
-#define SET_TX_DESC_WHEADER_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 0, 4, __val)
-#define SET_TX_DESC_CHK_EN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 4, 1, __val)
-#define SET_TX_DESC_EARLY_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 5, 1, __val)
-#define SET_TX_DESC_HWSEQ_SEL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 6, 2, __val)
+
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 8, 1, __val)
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 9, 1, __val)
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 10, 1, __val)
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
@@ -155,102 +64,38 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 12, 1, __val)
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 13, 1, __val)
-#define SET_TX_DESC_HW_PORT_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 14, 1, __val)
 #define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 15, 1, __val)
-#define SET_TX_DESC_USE_MAX_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 16, 1, __val)
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 17, 5, __val)
-#define SET_TX_DESC_NDPA(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 22, 2, __val)
-#define SET_TX_DESC_AMPDU_MAX_TIME(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 24, 8, __val)
 
 /* Dword 4 */
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 7, __val)
-#define SET_TX_DESC_TRY_RATE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 7, 1, __val)
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 5, __val)
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 4, __val)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 17, 1, __val)
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 18, 6, __val)
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 24, 5, __val)
-#define SET_TX_DESC_PCTS_ENABLE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 29, 1, __val)
-#define SET_TX_DESC_PCTS_MASK_IDX(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 30, 2, __val)
 
 /* Dword 5 */
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 0, 4, __val)
-#define SET_TX_DESC_DATA_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 4, 1, __val)
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 5, 2, __val)
-#define SET_TX_DESC_DATA_LDPC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 7, 1, __val)
-#define SET_TX_DESC_DATA_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 8, 2, __val)
-#define SET_TX_DESC_VCS_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 10, 2, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 12, 1, __val)
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
-#define SET_TX_DESC_TX_ANT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 24, 4, __val)
-#define SET_TX_DESC_TX_POWER_0_PSET(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 28, 3, __val)
-
-/* Dword 6 */
-#define SET_TX_DESC_SW_DEFINE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 0, 12, __val)
-#define SET_TX_DESC_ANTSEL_A(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 16, 3, __val)
-#define SET_TX_DESC_ANTSEL_B(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 19, 3, __val)
-#define SET_TX_DESC_ANTSEL_C(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 22, 3, __val)
-#define SET_TX_DESC_ANTSEL_D(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 25, 3, __val)
 
 /* Dword 7 */
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
-#define SET_TX_DESC_USB_TXAGG_NUM(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 24, 8, __val)
-
-/* Dword 8 */
-#define SET_TX_DESC_RTS_RC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 0, 6, __val)
-#define SET_TX_DESC_BAR_RTY_TH(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 6, 2, __val)
-#define SET_TX_DESC_DATA_RC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 8, 6, __val)
-#define SET_TX_DESC_ENABLE_HW_SELECT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 15, 1, __val)
-#define SET_TX_DESC_NEXT_HEAD_PAGE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 16, 8, __val)
-#define SET_TX_DESC_TAIL_PAGE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+32, 24, 8, __val)
 
 /* Dword 9 */
-#define SET_TX_DESC_PADDING_LENGTH(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 0, 11, __val)
-#define SET_TX_DESC_TXBF_PATH(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 11, 1, __val)
 #define SET_TX_DESC_SEQ(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+36, 12, 12, __val)
-#define SET_TX_DESC_FINAL_DATA_RATE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 24, 8, __val)
 
 /* Dword 10 */
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
@@ -266,12 +111,6 @@
 	SET_BITS_TO_LE_4BYTE(__paddr, 4, 15, __val)
 #define SET_EARLYMODE_LEN1(__paddr, __val)		\
 	SET_BITS_TO_LE_4BYTE(__paddr, 16, 2, __val)
-#define SET_EARLYMODE_LEN1_1(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr, 19, 13, __val)
-#define SET_EARLYMODE_LEN1_2(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 0, 2, __val)
-#define SET_EARLYMODE_LEN2(__paddr, __val)		\
-	SET_BITS_TO_LE_4BYTE(__paddr+4, 2, 15,  __val)
 #define SET_EARLYMODE_LEN2_1(__paddr, __val)		\
 	SET_BITS_TO_LE_4BYTE(__paddr, 2, 4,  __val)
 #define SET_EARLYMODE_LEN2_2(__paddr, __val)		\
@@ -283,13 +122,6 @@
 
 /* TX/RX buffer descriptor */
 
-#define SET_TX_EXTBUFF_DESC_LEN(__pdesc, __val, __set)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+(__set*16), 0, 16, __val)
-#define SET_TX_EXTBUFF_DESC_ADDR_LOW(__pdesc, __val, __set)\
-	SET_BITS_TO_LE_4BYTE(__pdesc+(__set*16)+4, 0, 32, __val)
-#define SET_TX_EXTBUFF_DESC_ADDR_HIGH(__pdesc, __val, __set)\
-	SET_BITS_TO_LE_4BYTE(__pdesc+(__set*16)+8, 0, 32, __val)
-
 /* for Txfilldescroptor92ee, fill the desc content. */
 #define SET_TXBUFFER_DESC_LEN_WITH_OFFSET(__pdesc, __offset, __val)            \
 	SET_BITS_TO_LE_4BYTE((__pdesc) + ((__offset) * 16), 0, 16, __val)
@@ -332,8 +164,6 @@
 #define SET_RX_BUFFER_DESC_TOTAL_LENGTH(__status, __val)	\
 	SET_BITS_TO_LE_4BYTE(__status, 16, 15, __val)
 
-#define GET_RX_BUFFER_DESC_OWN(__status)			\
-	LE_BITS_TO_4BYTE(__status, 31, 1)
 #define GET_RX_BUFFER_DESC_LS(__status)			\
 	LE_BITS_TO_4BYTE(__status, 15, 1)
 #define GET_RX_BUFFER_DESC_FS(__status)			\
@@ -357,87 +187,27 @@
 	LE_BITS_TO_4BYTE(__pdesc, 15, 1)
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc, 16, 4)
-#define GET_RX_DESC_SECURITY(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 20, 3)
-#define GET_RX_DESC_QOS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 23, 1)
 #define GET_RX_DESC_SHIFT(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 24, 2)
 #define GET_RX_DESC_PHYST(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
 #define GET_RX_DESC_SWDEC(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
-#define GET_RX_DESC_LS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
-#define GET_RX_DESC_FS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
-#define GET_RX_DESC_EOR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
 #define GET_RX_DESC_OWN(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
 
-#define SET_RX_DESC_PKT_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 0, 14, __val)
 #define SET_RX_DESC_EOR(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
-#define SET_RX_DESC_OWN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
 
 #define GET_RX_DESC_MACID(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+4, 0, 7)
-#define GET_RX_DESC_TID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 8, 4)
-#define GET_RX_DESC_MACID_VLD(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 12, 1)
-#define GET_RX_DESC_AMSDU(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 13, 1)
-#define GET_RX_DESC_RXID_MATCH(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
 #define GET_RX_DESC_PAGGR(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
-#define GET_RX_DESC_A1_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
-#define GET_RX_DESC_TCPOFFLOAD_CHKERR(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 1)
-#define GET_RX_DESC_TCPOFFLOAD_IPVER(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 21, 1)
-#define GET_RX_DESC_TCPOFFLOAD_IS_TCPUDP(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+4, 22, 1)
-#define GET_RX_DESC_TCPOFFLOAD_CHK_VLD(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 23, 1)
-#define GET_RX_DESC_PAM(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 24, 1)
-#define GET_RX_DESC_PWR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 25, 1)
-#define GET_RX_DESC_MD(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 26, 1)
-#define GET_RX_DESC_MF(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 27, 1)
-#define GET_RX_DESC_TYPE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 28, 2)
-#define GET_RX_DESC_MC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 30, 1)
-#define GET_RX_DESC_BC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 31, 1)
-#define GET_RX_DESC_SEQ(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 0, 12)
-#define GET_RX_DESC_FRAG(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 12, 4)
-#define GET_RX_DESC_RX_IS_QOS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 16, 1)
 #define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc+8, 28, 1)
 
 #define GET_RX_DESC_RXMCS(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+12, 0, 7)
-#define GET_RX_DESC_HTC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 10, 1)
-#define GET_RX_STATUS_DESC_EOSP(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 11, 1)
-#define GET_RX_STATUS_DESC_BSSID_FIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 12, 2)
-#define GET_RX_STATUS_DESC_DMA_AGG_NUM(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 16, 8)
 #define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
 	LE_BITS_TO_4BYTE(__pdesc+12, 29, 1)
 #define GET_RX_STATUS_DESC_UNICAST_MATCH(__pdesc)	\
@@ -450,18 +220,9 @@
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
-#define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 32)
-
-#define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
-#define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 32, __val)
 
 /* TX report 2 format in Rx desc*/
 
-#define GET_RX_RPT2_DESC_PKT_LEN(__status)	\
-	LE_BITS_TO_4BYTE(__status, 0, 9)
 #define GET_RX_RPT2_DESC_MACID_VALID_1(__status)	\
 	LE_BITS_TO_4BYTE(__status+16, 0, 32)
 #define GET_RX_RPT2_DESC_MACID_VALID_2(__status)	\
-- 
2.16.4

