Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97ABD23E61
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392875AbfETRYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 13:24:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36827 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392870AbfETRYW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 13:24:22 -0400
Received: by mail-oi1-f196.google.com with SMTP id y124so6280404oiy.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 May 2019 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YXkFAADaOSS/O7oF2W98jK0rlOfnO5q0V+i8kzw01Wg=;
        b=UFkClbpJGJOO+V9Zw3VJii6h1OIcvLTzO8FN68iCGD1y9fLA0hnJnNviSzXWpYuPiB
         j9k9NjmsS5uWv8LTY7/FQS7g5keK9+rCPJgQhuNJhyrtV6NIodPAceNgf9Jc4Zi11wu9
         w9ZdzxRktJkXWIpe+8jQVAoGnzbcgsiGewy/kUrb2/Muq6R3haXscIDxkwmyai97FGey
         x2u2UHbbPBx1MovCqRWaCS7tpo+8MLzBt8uAyyYBdo6FBWV1N13rjMAfez1j3ygAls31
         3+/JDI0GLr1LLEhy1sURnz69dP67D8eZ+IWWSr6sd30SMVOGBBgCi7l3l6PlrqSkvQdV
         jEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YXkFAADaOSS/O7oF2W98jK0rlOfnO5q0V+i8kzw01Wg=;
        b=XlaNljxJRIsMGeBSVNXPXWR0dMblRc89fZqTifXwSp3met0c8xdXqs13aIusb9Kot9
         P4EBMnlb6nLes7Sh4VEBqHHxrus9fm3rxSBNaMiXVxxUvjW0BBf0QA12NqD2UtcnkKuJ
         DzuLzi2qINZ4SKN8CGH34DuHsXZExS+iLfwy8FVeqk/9ti4IMbqoBflsILuFCazP7bon
         YbMk3btOTikUhAr3oOruAt3Zcwcs93Yh6Vmsc5+zAC8qU1Ly8VCol5XbIC+nsnfLH3EE
         Vaf1Htd8OFWMZIZQpJVfyfCNKak5KwIz70igsqr5UIu4Jf0mtR8o7mrnPv9DVWbLrQ5/
         MbVQ==
X-Gm-Message-State: APjAAAWgRhFknr939dIsnyRuoLfma6xP/+zFTYG55tMI5myaUD8S1Sew
        CA73fMH3C8ay+NA7uVHsVQM=
X-Google-Smtp-Source: APXvYqzsfdgF6B1efpBnQiybqXiVAI3Fm59BCkf0jAB35A6kQuPH0LMzpGiCt8aVWLkiYvtNH14l+w==
X-Received: by 2002:aca:abc9:: with SMTP id u192mr205462oie.84.1558373061080;
        Mon, 20 May 2019 10:24:21 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id z190sm6556865oia.21.2019.05.20.10.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 10:24:20 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/4] rtlwifi: rtl8821ae: Remove unused GET_XXX and SET_XXX descriptor macros
Date:   Mon, 20 May 2019 12:23:56 -0500
Message-Id: <20190520172359.9993-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
References: <20190520172359.9993-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As the first step in converting from macros that get/set information
in the RX and TX descriptors, unused macros are being removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../wireless/realtek/rtlwifi/rtl8821ae/trx.h  | 157 +-----------------
 1 file changed, 2 insertions(+), 155 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
index a3feecad645d..861d78a24d05 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/trx.h
@@ -28,31 +28,9 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc, 27, 1, __val)
 #define SET_TX_DESC_LINIP(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc, 28, 1, __val)
-#define SET_TX_DESC_NO_ACM(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 29, 1, __val)
-#define SET_TX_DESC_GF(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc, 30, 1, __val)
 #define SET_TX_DESC_OWN(__pdesc, __val)				\
 	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
 
-#define GET_TX_DESC_PKT_SIZE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 0, 16)
-#define GET_TX_DESC_OFFSET(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 16, 8)
-#define GET_TX_DESC_BMC(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 24, 1)
-#define GET_TX_DESC_HTC(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 25, 1)
-#define GET_TX_DESC_LAST_SEG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
-#define GET_TX_DESC_FIRST_SEG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
-#define GET_TX_DESC_LINIP(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
-#define GET_TX_DESC_NO_ACM(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
-#define GET_TX_DESC_GF(__pdesc)						\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
 #define GET_TX_DESC_OWN(__pdesc)					\
 	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
 
@@ -60,58 +38,26 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 7, __val)
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
-#define SET_TX_DESC_RDG_NAV_EXT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 13, 1, __val)
-#define SET_TX_DESC_LSIG_TXOP_EN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 14, 1, __val)
-#define SET_TX_DESC_PIFS(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 15, 1, __val)
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 5, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 24, 5, __val)
 
-#define SET_TX_DESC_PAID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 0, 9, __val)
-#define SET_TX_DESC_CCA_RTS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 10, 2, __val)
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 12, 1, __val)
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 13, 1, __val)
-#define SET_TX_DESC_BAR_RTY_TH(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 14, 2, __val)
-#define SET_TX_DESC_AGG_BREAK(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 16, 1, __val)
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
-#define SET_TX_DESC_RAW(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 18, 1, __val)
-#define SET_TX_DESC_SPE_RPT(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 19, 1, __val)
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
-#define SET_TX_DESC_BT_INT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 23, 1, __val)
-#define SET_TX_DESC_GID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 24, 6, __val)
-
-#define SET_TX_DESC_WHEADER_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 0, 4, __val)
-#define SET_TX_DESC_CHK_EN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 4, 1, __val)
-#define SET_TX_DESC_EARLY_MODE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 5, 1, __val)
+
 #define SET_TX_DESC_HWSEQ_SEL(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 6, 2, __val)
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 8, 1, __val)
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 9, 1, __val)
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 10, 1, __val)
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
@@ -122,14 +68,8 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 13, 1, __val)
 #define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 15, 1, __val)
-#define SET_TX_DESC_USE_MAX_LEN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 16, 1, __val)
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 17, 5, __val)
-#define SET_TX_DESC_NDPA(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 22, 2, __val)
-#define SET_TX_DESC_AMPDU_MAX_TIME(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 24, 8, __val)
 #define SET_TX_DESC_TX_ANT(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 24, 4, __val)
 
@@ -139,10 +79,6 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 5, __val)
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 4, __val)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 17, 1, __val)
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 18, 6, __val)
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 24, 5, __val)
 
@@ -152,36 +88,14 @@
 	SET_BITS_TO_LE_1BYTE(__pdesc+20, 4, 1, __val)
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 5, 2, __val)
-#define SET_TX_DESC_DATA_LDPC(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 7, 1, __val)
-#define SET_TX_DESC_DATA_STBC(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 8, 2, __val)
-#define SET_TX_DESC_CTROL_STBC(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 10, 2, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 12, 1, __val)
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
 
-#define SET_TX_DESC_SW_DEFINE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 0, 12, __val)
-#define SET_TX_DESC_ANTSEL_A(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 16, 3, __val)
-#define SET_TX_DESC_ANTSEL_B(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 19, 3, __val)
-#define SET_TX_DESC_ANTSEL_C(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 22, 3, __val)
-#define SET_TX_DESC_ANTSEL_D(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 25, 3, __val)
-#define SET_TX_DESC_MBSSID(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(i(__pdesc) + 24, 12, 4, __val)
-
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE((__pdesc) + 28, 0, 16, __val)
 
-#define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 16)
-
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+32, 15, 1, __val)
 
@@ -197,9 +111,6 @@
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+48, 0, 32, __val)
 
-#define GET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+48, 0, 32)
-
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 0, 14)
 #define GET_RX_DESC_CRC32(__pdesc)				\
@@ -208,22 +119,12 @@
 	LE_BITS_TO_4BYTE(__pdesc, 15, 1)
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc, 16, 4)
-#define GET_RX_DESC_SECURITY(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 20, 3)
-#define GET_RX_DESC_QOS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 23, 1)
 #define GET_RX_DESC_SHIFT(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc, 24, 2)
 #define GET_RX_DESC_PHYST(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
 #define GET_RX_DESC_SWDEC(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
-#define GET_RX_DESC_LS(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
-#define GET_RX_DESC_FS(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
-#define GET_RX_DESC_EOR(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
 #define GET_RX_DESC_OWN(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
 
@@ -236,58 +137,14 @@
 
 #define GET_RX_DESC_MACID(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+4, 0, 7)
-#define GET_RX_DESC_TID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 8, 4)
-#define GET_RX_DESC_AMSDU(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 13, 1)
-#define GET_RX_STATUS_DESC_RXID_MATCH(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
 #define GET_RX_DESC_PAGGR(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
-#define GET_RX_DESC_A1_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
-#define GET_RX_DESC_CHKERR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 1)
-#define GET_RX_DESC_IPVER(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 21, 1)
-#define GET_RX_STATUS_DESC_IS_TCPUDP(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 22, 1)
-#define GET_RX_STATUS_DESC_CHK_VLD(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 23, 1)
-#define GET_RX_DESC_PAM(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 24, 1)
-#define GET_RX_DESC_PWR(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 25, 1)
-#define GET_RX_DESC_MD(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc+4, 26, 1)
-#define GET_RX_DESC_MF(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc+4, 27, 1)
-#define GET_RX_DESC_TYPE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 28, 2)
-#define GET_RX_DESC_MC(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc+4, 30, 1)
-#define GET_RX_DESC_BC(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc+4, 31, 1)
-
-#define GET_RX_DESC_SEQ(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 0, 12)
-#define GET_RX_DESC_FRAG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 12, 4)
-#define GET_RX_STATUS_DESC_RX_IS_QOS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 16, 1)
-#define GET_RX_STATUS_DESC_WLANHD_IV_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+8, 18, 6)
+
 #define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+8, 28, 1)
 
 #define GET_RX_DESC_RXMCS(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+12, 0, 7)
-#define GET_RX_DESC_HTC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 10, 1)
-#define GET_RX_STATUS_DESC_EOSP(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 11, 1)
-#define GET_RX_STATUS_DESC_BSSID_FIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 12, 2)
 
 #define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
 	LE_BITS_TO_4BYTE(__pdesc+12, 29, 1)
@@ -298,10 +155,6 @@
 
 #define GET_RX_DESC_SPLCP(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+16, 0, 1)
-#define GET_RX_STATUS_DESC_LDPC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 1, 1)
-#define GET_RX_STATUS_DESC_STBC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 2, 1)
 #define GET_RX_DESC_BW(__pdesc)					\
 	LE_BITS_TO_4BYTE(__pdesc+16, 4, 2)
 
@@ -310,18 +163,12 @@
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
-#define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 32)
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
-#define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val) \
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 32, __val)
 
 /* TX report 2 format in Rx desc*/
 
-#define GET_RX_RPT2_DESC_PKT_LEN(__status)	\
-	LE_BITS_TO_4BYTE(__status, 0, 9)
 #define GET_RX_RPT2_DESC_MACID_VALID_1(__status)	\
 	LE_BITS_TO_4BYTE(__status+16, 0, 32)
 #define GET_RX_RPT2_DESC_MACID_VALID_2(__status)	\
-- 
2.21.0

