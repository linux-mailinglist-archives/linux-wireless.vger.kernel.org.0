Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A1AD1BD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 04:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732700AbfIICAH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 22:00:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44106 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732648AbfIICAH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 22:00:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id 21so10925722otj.11
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 19:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ijn7Ch9WzzVAKKTcvihivQUdaaROyA7Yzxeme4MXIqU=;
        b=i1ScO8KwZfsbw2KxYBBflOgxPBnuysRAl9Vqwse74NqgXiOg79T0zB+FW8mXbYAlfV
         hkB8BDgMtj3ml8Y1FWMG7tnmegHEZnWFD/3UZ6F89S2vYvebuEuJD/6uuts9im0n1nmj
         SP1USStzWCSEAq4WPf17RTJUnV3Lv797+j133pWjt9r7FBKIs6vpSlMpNysJGxHR8E8Z
         2ktzyEW2h/EFfvmpOUzFwtnyXiFWC4HtPgQmcBJhyAEk5p1VK+pmvpUdQiCXnsjgTp4B
         5W4k5B98SdSyjmuFCglgWHQwX5dskAg4DbZ7HfQY+b5QmwGgL502uCQJ4Da5XuqJWvVn
         xKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ijn7Ch9WzzVAKKTcvihivQUdaaROyA7Yzxeme4MXIqU=;
        b=n3z8DpCwnjjAEcDM2SSFW4RYTOQxK9n5R5by4tSJzC9TVX0DcH32OytJ4gDaQUx/Ym
         YPXhx/uR+59yL6OIIpimOD2ekXXKuytPx8ANAQC6dATCI7w9xxru9LOBYYuahnlUXc8t
         3rGajD6hCRuCBh9e51bu6VxzQ+t6f/FrKfJZ6/wjafsryCYPV80FNHGsSOwKn+6+v9Pm
         Wxjx9RfwlmTlfShVlK8jKwdP8FrfcJjZnQ0sARLUmgzfR/f2jhCgl+jkFJnNvOdRhcTO
         sIvjgT2GUrYGKQHKkS9tZAa93RW6TVZ8ZXCgdRXv5NOLxhU7D1pcyZ/6Sfyk1DcR5tEx
         6rRg==
X-Gm-Message-State: APjAAAVxfsxHOcvfIAxIb/AXO308nGcWgQEBo6rMoN6CD4te6eRvcGL9
        Zug4WSKgniyBmyYBpxOuWSY=
X-Google-Smtp-Source: APXvYqybmL3sTV0kjsvrpA+M/Ulbv0il+P5UiZSX9Y/3D6wtDCRtlREtIB7tgbCCPjwFi22zNORT4g==
X-Received: by 2002:a9d:7207:: with SMTP id u7mr17443838otj.59.1567994406116;
        Sun, 08 Sep 2019 19:00:06 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm1468420oij.16.2019.09.08.19.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 19:00:05 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 5/9] rtlwifi: rtl8723be: Remove unused SET_XXX and GET_XXX macros
Date:   Sun,  8 Sep 2019 20:59:54 -0500
Message-Id: <20190909015958.29834-6-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
References: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

iAs the first step in converting from macros that get/set information
in the RX and TX descriptors, unused macros are being removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 .../wireless/realtek/rtlwifi/rtl8723be/trx.h  | 167 +-----------------
 1 file changed, 2 insertions(+), 165 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
index 11e75a4e68bd..89447b93c439 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/trx.h
@@ -28,31 +28,9 @@
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
 
@@ -60,60 +38,26 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 7, __val)
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
-#define SET_TX_DESC_RDG_NAV_EXT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 13, 1, __val)
-#define SET_TX_DESC_LSIG_TXOP_EN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 14, 1, __val)
-#define SET_TX_DESC_PIFS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 15, 1, __val)
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 5, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 24, 5, __val)
 
-
-#define SET_TX_DESC_PAID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 0, 9, __val)
-#define SET_TX_DESC_CCA_RTS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 10, 2, __val)
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 12, 1, __val)
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 13, 1, __val)
-#define SET_TX_DESC_BAR_RTY_TH(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 14, 2, __val)
-#define SET_TX_DESC_AGG_BREAK(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 16, 1, __val)
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
-#define SET_TX_DESC_RAW(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 18, 1, __val)
-#define SET_TX_DESC_SPE_RPT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 19, 1, __val)
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
-#define SET_TX_DESC_BT_INT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 23, 1, __val)
-#define SET_TX_DESC_GID(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 24, 6, __val)
-
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
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 9, 1, __val)
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 10, 1, __val)
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
@@ -124,15 +68,8 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 13, 1, __val)
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
-
 
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 7, __val)
@@ -140,50 +77,23 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 5, __val)
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 4, __val)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 17, 1, __val)
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 18, 6, __val)
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 24, 5, __val)
 
-
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 0, 4, __val)
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 4, 1, __val)
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 5, 2, __val)
-#define SET_TX_DESC_DATA_LDPC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 7, 1, __val)
-#define SET_TX_DESC_DATA_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 8, 2, __val)
-#define SET_TX_DESC_CTROL_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 10, 2, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 12, 1, __val)
 #define SET_TX_DESC_RTS_SC(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
 
-#define SET_TX_DESC_SW_DEFINE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 0, 12, __val)
-#define SET_TX_DESC_MBSSID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 12, 4, __val)
-#define SET_TX_DESC_ANTSEL_A(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 16, 3, __val)
-#define SET_TX_DESC_ANTSEL_B(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 19, 3, __val)
-#define SET_TX_DESC_ANTSEL_C(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 22, 3, __val)
-#define SET_TX_DESC_ANTSEL_D(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE((__pdesc) + 24, 25, 3, __val)
-
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
 
-#define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 16)
-
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+32, 15, 1, __val)
 
@@ -196,13 +106,9 @@
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc+40, 0, 32)
 
-
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+48, 0, 32, __val)
 
-#define GET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+48, 0, 32)
-
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 0, 14)
 #define GET_RX_DESC_CRC32(__pdesc)			\
@@ -211,22 +117,12 @@
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
-#define GET_RX_DESC_LS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
-#define GET_RX_DESC_FS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
-#define GET_RX_DESC_EOR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
 #define GET_RX_DESC_OWN(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
 
@@ -239,64 +135,16 @@
 
 #define GET_RX_DESC_MACID(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+4, 0, 7)
-#define GET_RX_DESC_TID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 8, 4)
-#define GET_RX_DESC_AMSDU(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 13, 1)
-#define GET_RX_STATUS_DESC_RXID_MATCH(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
 #define GET_RX_DESC_PAGGR(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
-#define GET_RX_DESC_A1_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
-#define GET_RX_DESC_CHKERR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 1)
-#define GET_RX_DESC_IPVER(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 21, 1)
-#define GET_RX_STATUS_DESC_IS_TCPUDP(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 22, 1)
-#define GET_RX_STATUS_DESC_CHK_VLD(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+4, 23, 1)
-#define GET_RX_DESC_PAM(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 24, 1)
-#define GET_RX_DESC_PWR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 25, 1)
-#define GET_RX_DESC_MD(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 26, 1)
-#define GET_RX_DESC_MF(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 27, 1)
-#define GET_RX_DESC_TYPE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 28, 2)
-#define GET_RX_DESC_MC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 30, 1)
-#define GET_RX_DESC_BC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 31, 1)
-
-
-#define GET_RX_DESC_SEQ(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 0, 12)
-#define GET_RX_DESC_FRAG(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 12, 4)
-#define GET_RX_STATUS_DESC_RX_IS_QOS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+8, 16, 1)
-#define GET_RX_STATUS_DESC_WLANHD_IV_LEN(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+8, 18, 6)
+
 #define GET_RX_STATUS_DESC_RPT_SEL(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc+8, 28, 1)
 
-
 #define GET_RX_DESC_RXMCS(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+12, 0, 7)
 #define GET_RX_DESC_RXHT(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+12, 6, 1)
-#define GET_RX_STATUS_DESC_RX_GF(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 7, 1)
-#define GET_RX_DESC_HTC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 10, 1)
-#define GET_RX_STATUS_DESC_EOSP(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 11, 1)
-#define GET_RX_STATUS_DESC_BSSID_FIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 12, 2)
 
 #define GET_RX_STATUS_DESC_PATTERN_MATCH(__pdesc)	\
 	LE_BITS_TO_4BYTE(__pdesc+12, 29, 1)
@@ -307,10 +155,6 @@
 
 #define GET_RX_DESC_SPLCP(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+16, 0, 1)
-#define GET_RX_STATUS_DESC_LDPC(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 1, 1)
-#define GET_RX_STATUS_DESC_STBC(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 2, 1)
 #define GET_RX_DESC_BW(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+16, 4, 2)
 
@@ -319,19 +163,12 @@
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
-#define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 32)
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
-#define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 32, __val)
-
 
 /* TX report 2 format in Rx desc*/
 
-#define GET_RX_RPT2_DESC_PKT_LEN(__rxstatusdesc)	\
-	LE_BITS_TO_4BYTE(__rxstatusdesc, 0, 9)
 #define GET_RX_RPT2_DESC_MACID_VALID_1(__rxstatusdesc)	\
 	LE_BITS_TO_4BYTE(__rxstatusdesc+16, 0, 32)
 #define GET_RX_RPT2_DESC_MACID_VALID_2(__rxstatusdesc)	\
-- 
2.23.0

