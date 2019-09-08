Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1ACCACA86
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 06:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfIHEDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 00:03:42 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35471 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfIHEDm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 00:03:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so8118014oii.2
        for <linux-wireless@vger.kernel.org>; Sat, 07 Sep 2019 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrE8dUyHn1OxlyL9EQqPsw03XMAKFLebgZb7nC3QMgA=;
        b=UsZdDwrhy1eXvJJCyeWFWZc7W2zyGh2v0hEw4lpHswkbOxCpj8J9Ps8idUjcjI7nEQ
         VllYggaEaGGwdx9c5wPwNSahk7ki8OTB6Tt03AYO9pWawAIS97HUNOCXCtYrRG3qdOvU
         4mvuvNa7vGlzSe6vm3QrlQKcWsje/QOVN0AUy20kbyTQO4fFnGhbt947vmtPInKVMDGF
         f3uIrm2U8gvRZp31d0cavwCl67TUMjq4PpPiSA1JihFpxspluKB7W2vLRPjuRvlr4IkI
         LNJXYjs2R3puKqw62Th09jlmI5K7Z4195dEpde+nQP9m51jTZW7TBCkhq8lsNkTkjxK+
         lHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JrE8dUyHn1OxlyL9EQqPsw03XMAKFLebgZb7nC3QMgA=;
        b=cUQtlz/EpyONitVm22mxy28umWEK4cQMNaBDm2KRRBbuG0nzcfUb5ZcSXL6tPbqreL
         1gC3FRPtiOLlJ8Q4Q9kfn5HqzpUm1Qzlvk3bsxabYfDjkAXRlOFYWHtCKyBcD/A4ouSo
         x2+tprf0tiai27jpTlOXQF/Z9UeQYroxRAdj3Ev7m0lDcxiVYso5hln1Vgi0ZY9dCmEk
         kOD9WeGAH5nZa3gCIYUu+bIAwHXITz3bv8K+VxZ1FWSx6C4r75QNQ6aDBeo+0bEw9pbo
         ehmQOJR6Ctm/VV0oHjkKOlPKbX87PkUqffZnetsuQ+Jw2zj9GRlBLqcfSXRLR1OU0DDc
         DYpA==
X-Gm-Message-State: APjAAAUybSnjDSG8pdZDjd0WYFF3PwpJQNLzgx20kpnUK8rl+uU+2ctm
        9A6SPNn1j4JkewQeMVufvd1cax0Q
X-Google-Smtp-Source: APXvYqxFU5KSJy1QbH77c8nVeINAS41GD/fLJtBxp9fkpnUsGBI0ZkJd+debTPVOLtsm8Ydgc/4zqA==
X-Received: by 2002:a05:6808:a87:: with SMTP id q7mr12727578oij.40.1567915420518;
        Sat, 07 Sep 2019 21:03:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x80sm1419178oia.37.2019.09.07.21.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 21:03:40 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/9] rtlwifi: rtl8723ae: Remove unused GET_XXX and SET_XXX macros
Date:   Sat,  7 Sep 2019 23:03:27 -0500
Message-Id: <20190908040335.19838-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
References: <20190908040335.19838-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8723ae/trx.h  | 336 +-----------------
 1 file changed, 4 insertions(+), 332 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
index 4a19ea76b290..e0cc45ad34b4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.h
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
-#define GET_TX_DESC_OFFSET(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 16, 8)
-#define GET_TX_DESC_BMC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 24, 1)
-#define GET_TX_DESC_HTC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 25, 1)
-#define GET_TX_DESC_LAST_SEG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 26, 1)
-#define GET_TX_DESC_FIRST_SEG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 27, 1)
-#define GET_TX_DESC_LINIP(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 28, 1)
-#define GET_TX_DESC_NO_ACM(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc, 29, 1)
-#define GET_TX_DESC_GF(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc, 30, 1)
 #define GET_TX_DESC_OWN(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc, 31, 1)
 
@@ -60,127 +38,26 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 5, __val)
 #define SET_TX_DESC_AGG_BREAK(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 5, 1, __val)
-#define SET_TX_DESC_BK(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 6, 1, __val)
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 7, 1, __val)
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 8, 5, __val)
-#define SET_TX_DESC_RDG_NAV_EXT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 13, 1, __val)
-#define SET_TX_DESC_LSIG_TXOP_EN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 14, 1, __val)
-#define SET_TX_DESC_PIFS(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 15, 1, __val)
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 16, 4, __val)
-#define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 20, 1, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
-#define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 24, 8, __val)
-
-#define GET_TX_DESC_MACID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 0, 5)
-#define GET_TX_DESC_AGG_ENABLE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 5, 1)
-#define GET_TX_DESC_AGG_BREAK(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 6, 1)
-#define GET_TX_DESC_RDG_ENABLE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 7, 1)
-#define GET_TX_DESC_QUEUE_SEL(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 8, 5)
-#define GET_TX_DESC_RDG_NAV_EXT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 13, 1)
-#define GET_TX_DESC_LSIG_TXOP_EN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
-#define GET_TX_DESC_PIFS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
-#define GET_TX_DESC_RATE_ID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
-#define GET_TX_DESC_NAV_USE_HDR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 1)
-#define GET_TX_DESC_EN_DESC_ID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 21, 1)
-#define GET_TX_DESC_SEC_TYPE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 22, 2)
-#define GET_TX_DESC_PKT_OFFSET(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 24, 8)
-
-#define SET_TX_DESC_RTS_RC(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 0, 6, __val)
-#define SET_TX_DESC_DATA_RC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 6, 6, __val)
-#define SET_TX_DESC_BAR_RTY_TH(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 14, 2, __val)
+
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
-#define SET_TX_DESC_RAW(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 18, 1, __val)
-#define SET_TX_DESC_CCX(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 19, 1, __val)
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
-#define SET_TX_DESC_ANTSEL_A(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 24, 1, __val)
-#define SET_TX_DESC_ANTSEL_B(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 25, 1, __val)
-#define SET_TX_DESC_TX_ANT_CCK(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 26, 2, __val)
-#define SET_TX_DESC_TX_ANTL(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 28, 2, __val)
-#define SET_TX_DESC_TX_ANT_HT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 30, 2, __val)
-
-#define GET_TX_DESC_RTS_RC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 0, 6)
-#define GET_TX_DESC_DATA_RC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 6, 6)
-#define GET_TX_DESC_BAR_RTY_TH(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 14, 2)
-#define GET_TX_DESC_MORE_FRAG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 17, 1)
-#define GET_TX_DESC_RAW(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 18, 1)
-#define GET_TX_DESC_CCX(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 19, 1)
-#define GET_TX_DESC_AMPDU_DENSITY(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 20, 3)
-#define GET_TX_DESC_ANTSEL_A(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 24, 1)
-#define GET_TX_DESC_ANTSEL_B(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 25, 1)
-#define GET_TX_DESC_TX_ANT_CCK(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 26, 2)
-#define GET_TX_DESC_TX_ANTL(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 28, 2)
-#define GET_TX_DESC_TX_ANT_HT(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 30, 2)
-
-#define SET_TX_DESC_NEXT_HEAP_PAGE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 0, 8, __val)
-#define SET_TX_DESC_TAIL_PAGE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 8, 8, __val)
+
 #define SET_TX_DESC_SEQ(__pdesc, __val)				\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 16, 12, __val)
 #define SET_TX_DESC_PKT_ID(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 28, 4, __val)
 
-#define GET_TX_DESC_NEXT_HEAP_PAGE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 0, 8)
-#define GET_TX_DESC_TAIL_PAGE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 8, 8)
-#define GET_TX_DESC_SEQ(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 16, 12)
-#define GET_TX_DESC_PKT_ID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 28, 4)
-
 /* For RTL8723 */
-#define SET_TX_DESC_TRIGGER_INT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 30, 1, __val)
 #define SET_TX_DESC_HWSEQ_EN_8723(__pdesc, __val)   \
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 31, 1, __val)
 #define SET_TX_DESC_HWSEQ_SEL_8723(__txdesc, __value) \
@@ -188,16 +65,8 @@
 
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 5, __val)
-#define SET_TX_DESC_AP_DCFE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 5, 1, __val)
-#define SET_TX_DESC_QOS(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 6, 1, __val)
-#define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 7, 1, __val)
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 1, __val)
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 9, 1, __val)
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 10, 1, __val)
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
@@ -206,18 +75,8 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 12, 1, __val)
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 1, __val)
-#define SET_TX_DESC_PORT_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 14, 1, __val)
-#define SET_TX_DESC_WAIT_DCTS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 18, 1, __val)
-#define SET_TX_DESC_CTS2AP_EN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 19, 1, __val)
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 20, 2, __val)
-#define SET_TX_DESC_TX_STBC(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 22, 2, __val)
-#define SET_TX_DESC_DATA_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 24, 1, __val)
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 25, 1, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
@@ -229,158 +88,29 @@
 #define SET_TX_DESC_RTS_STBC(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 30, 2, __val)
 
-#define GET_TX_DESC_RTS_RATE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 0, 5)
-#define GET_TX_DESC_AP_DCFE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 5, 1)
-#define GET_TX_DESC_QOS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 6, 1)
-#define GET_TX_DESC_HWSEQ_EN(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 7, 1)
-#define GET_TX_DESC_USE_RATE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 8, 1)
-#define GET_TX_DESC_DISABLE_RTS_FB(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 9, 1)
-#define GET_TX_DESC_DISABLE_FB(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 10, 1)
-#define GET_TX_DESC_CTS2SELF(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 11, 1)
-#define GET_TX_DESC_RTS_ENABLE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 12, 1)
-#define GET_TX_DESC_HW_RTS_ENABLE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 13, 1)
-#define GET_TX_DESC_PORT_ID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 14, 1)
-#define GET_TX_DESC_WAIT_DCTS(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 18, 1)
-#define GET_TX_DESC_CTS2AP_EN(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 19, 1)
-#define GET_TX_DESC_TX_SUB_CARRIER(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 20, 2)
-#define GET_TX_DESC_TX_STBC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 22, 2)
-#define GET_TX_DESC_DATA_SHORT(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 24, 1)
-#define GET_TX_DESC_DATA_BW(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 25, 1)
-#define GET_TX_DESC_RTS_SHORT(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 26, 1)
-#define GET_TX_DESC_RTS_BW(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 27, 1)
-#define GET_TX_DESC_RTS_SC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 28, 2)
-#define GET_TX_DESC_RTS_STBC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 30, 2)
-
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 0, 6, __val)
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 6, 1, __val)
-#define SET_TX_DESC_CCX_TAG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 7, 1, __val)
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 8, 5, __val)
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+20, 13, 4, __val)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 17, 1, __val)
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 18, 6, __val)
-#define SET_TX_DESC_USB_TXAGG_NUM(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+20, 24, 8, __val)
-
-#define GET_TX_DESC_TX_RATE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+20, 0, 6)
-#define GET_TX_DESC_DATA_SHORTGI(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 6, 1)
-#define GET_TX_DESC_CCX_TAG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+20, 7, 1)
-#define GET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 8, 5)
-#define GET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 13, 4)
-#define GET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 17, 1)
-#define GET_TX_DESC_DATA_RETRY_LIMIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 18, 6)
-#define GET_TX_DESC_USB_TXAGG_NUM(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 24, 8)
-
-#define SET_TX_DESC_TXAGC_A(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 5, __val)
-#define SET_TX_DESC_TXAGC_B(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 5, 5, __val)
-#define SET_TX_DESC_USE_MAX_LEN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 10, 1, __val)
+
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+24, 11, 5, __val)
-#define SET_TX_DESC_MCSG1_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 16, 4, __val)
-#define SET_TX_DESC_MCSG2_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 20, 4, __val)
-#define SET_TX_DESC_MCSG3_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 24, 4, __val)
-#define SET_TX_DESC_MCS7_SGI_MAX_LEN(__pdesc, __val)\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 28, 4, __val)
-
-#define GET_TX_DESC_TXAGC_A(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+24, 0, 5)
-#define GET_TX_DESC_TXAGC_B(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+24, 5, 5)
-#define GET_TX_DESC_USE_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 10, 1)
-#define GET_TX_DESC_MAX_AGG_NUM(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 11, 5)
-#define GET_TX_DESC_MCSG1_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 16, 4)
-#define GET_TX_DESC_MCSG2_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 20, 4)
-#define GET_TX_DESC_MCSG3_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 24, 4)
-#define GET_TX_DESC_MCS7_SGI_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 28, 4)
 
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
-#define SET_TX_DESC_MCSG4_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 16, 4, __val)
-#define SET_TX_DESC_MCSG5_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 20, 4, __val)
-#define SET_TX_DESC_MCSG6_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 24, 4, __val)
-#define SET_TX_DESC_MCS15_SGI_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 28, 4, __val)
-
-#define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 16)
-#define GET_TX_DESC_MCSG4_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+28, 16, 4)
-#define GET_TX_DESC_MCSG5_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+28, 20, 4)
-#define GET_TX_DESC_MCSG6_MAX_LEN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+28, 24, 4)
-#define GET_TX_DESC_MCS15_SGI_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 28, 4)
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+32, 0, 32, __val)
-#define SET_TX_DESC_TX_BUFFER_ADDRESS64(__pdesc, __val) \
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 0, 32, __val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc+32, 0, 32)
-#define GET_TX_DESC_TX_BUFFER_ADDRESS64(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+36, 0, 32)
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+40, 0, 32, __val)
-#define SET_TX_DESC_NEXT_DESC_ADDRESS64(__pdesc, __val) \
-	SET_BITS_TO_LE_4BYTE(__pdesc+44, 0, 32, __val)
-
-#define GET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+40, 0, 32)
-#define GET_TX_DESC_NEXT_DESC_ADDRESS64(__pdesc)	\
-	LE_BITS_TO_4BYTE(__pdesc+44, 0, 32)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc, 0, 14)
@@ -390,22 +120,12 @@
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
 
@@ -416,44 +136,10 @@
 #define SET_RX_DESC_OWN(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc, 31, 1, __val)
 
-#define GET_RX_DESC_MACID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 0, 5)
-#define GET_RX_DESC_TID(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+4, 5, 4)
-#define GET_RX_DESC_HWRSVD(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 9, 5)
 #define GET_RX_DESC_PAGGR(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+4, 14, 1)
 #define GET_RX_DESC_FAGGR(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+4, 15, 1)
-#define GET_RX_DESC_A1_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 16, 4)
-#define GET_RX_DESC_A2_FIT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+4, 20, 4)
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
-#define GET_RX_DESC_SEQ(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 0, 12)
-#define GET_RX_DESC_FRAG(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 12, 4)
-#define GET_RX_DESC_NEXT_PKT_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+8, 16, 14)
-#define GET_RX_DESC_NEXT_IND(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+8, 30, 1)
-#define GET_RX_DESC_RSVD(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+8, 31, 1)
 
 #define GET_RX_DESC_RXMCS(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+12, 0, 6)
@@ -463,29 +149,15 @@
 	LE_BITS_TO_4BYTE(__pdesc+12, 8, 1)
 #define GET_RX_DESC_BW(__pdesc)					\
 	LE_BITS_TO_4BYTE(__pdesc+12, 9, 1)
-#define GET_RX_DESC_HTC(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 10, 1)
-#define GET_RX_DESC_HWPC_ERR(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 14, 1)
-#define GET_RX_DESC_HWPC_IND(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+12, 15, 1)
-#define GET_RX_DESC_IV0(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 16, 16)
-
-#define GET_RX_DESC_IV1(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+16, 0, 32)
+
 #define GET_RX_DESC_TSFL(__pdesc)				\
 	LE_BITS_TO_4BYTE(__pdesc+20, 0, 32)
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
 	LE_BITS_TO_4BYTE(__pdesc+24, 0, 32)
-#define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+28, 0, 32)
 
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+24, 0, 32, __val)
-#define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val) \
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 32, __val)
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)		\
 do {								\
-- 
2.23.0

