Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1901105C2F
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKUVoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:44:25 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40806 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfKUVoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:44:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id d22so4637296oic.7
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uGom+vThP94E7pivlBjQtrnEUbvC1pLdptV3Qa7NPoA=;
        b=dpqG+vdDJOaPSMSW5Tl/cHXzYnu7IN1hnvGTBa+Qzwhyi/aRdn64mjl1VfPm9k1gXg
         1vS4NERRBrF0Oq9rIUlcUtFJ3TZlZ1fXbSBWy3zMWJXikIskCBWqRZuM77jLnqBsuSZu
         +8NtIw5IfB0B4XtJoqgnn19F3b96HfqCnB8TGNDsHCkafBYHbBCVAy8m9t8QdqE8X+mp
         /7GQ07XNEWrD3i7aYFNHMnK+fiyxDg4KYmP0yl4RnnXKbV+1iVmzWFJRFS7FbhnbCWNG
         AATWjNEKyYboRCPQGbUDzXZUdregRzUIr8bqboebuau3czTB+MywfA8hvZMdEzgQ/BJe
         +mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uGom+vThP94E7pivlBjQtrnEUbvC1pLdptV3Qa7NPoA=;
        b=OGLo0Tlr4837I6rHEL/ekfUFktt2DQSpfilGozKCzzzcgogV4zHsYCjnOI/TVTYDSn
         nkwyLrCL3cjTZKiOCQ8Wwqxd2tj/AnKIxkBPmzu4dx2ZW5snXUBCijlNMkYKKaYwOU0K
         7XN5ayzvpWLkGJzxCouM2adD8GwxKyUmsVvvTlhhRxFK9Bdu1aW2TIxEocWJ7/Az18O0
         LhyW+1g/BeiXalmVt3IA+h+y36ak0HQ7LDE5FxY7xi02c6poOn4+aQpyFps5MCGy8avp
         IP+vSjN+r3EMEAF4mPnTwnpNXaAcPM1ZD8ZIE44Ts7LPcitgGM8ApF4+dbmV76zT4tuh
         IrZw==
X-Gm-Message-State: APjAAAVcP9zJ69RdqkIp4Ya8m2speItMZ2iQs2voA4D2FXy5O5bGnFYY
        n5uETl08pR638q8mDUdkGWsne2SF
X-Google-Smtp-Source: APXvYqzlyFSO1O0VU0XAJvuQn/wukEL1/UqqWdtNnXgLpPMaSOZIXKSGs9QX1I9c3GU68T92HBD31A==
X-Received: by 2002:aca:fdc3:: with SMTP id b186mr9962769oii.92.1574372661889;
        Thu, 21 Nov 2019 13:44:21 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id x82sm1333854oix.29.2019.11.21.13.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:44:21 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/4] rtlwifi: rtl8192de: Remove unused GET_XXX and SET_XXX macros
Date:   Thu, 21 Nov 2019 15:44:14 -0600
Message-Id: <20191121214417.29676-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
References: <20191121214417.29676-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192de/trx.h  | 329 +-----------------
 1 file changed, 3 insertions(+), 326 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index 635989e15282..40746125f1ae 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -42,8 +42,6 @@
 	SET_BITS_OFFSET_LE(__pdesc, 0, 16, __val)
 #define SET_TX_DESC_OFFSET(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc, 16, 8, __val)
-#define SET_TX_DESC_BMC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 24, 1, __val)
 #define SET_TX_DESC_HTC(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 25, 1, __val)
 #define SET_TX_DESC_LAST_SEG(__pdesc, __val)		\
@@ -52,31 +50,9 @@
 	SET_BITS_OFFSET_LE(__pdesc, 27, 1, __val)
 #define SET_TX_DESC_LINIP(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc, 28, 1, __val)
-#define SET_TX_DESC_NO_ACM(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 29, 1, __val)
-#define SET_TX_DESC_GF(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 30, 1, __val)
 #define SET_TX_DESC_OWN(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
 
-#define GET_TX_DESC_PKT_SIZE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 0, 16)
-#define GET_TX_DESC_OFFSET(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 16, 8)
-#define GET_TX_DESC_BMC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 24, 1)
-#define GET_TX_DESC_HTC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 25, 1)
-#define GET_TX_DESC_LAST_SEG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 26, 1)
-#define GET_TX_DESC_FIRST_SEG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 27, 1)
-#define GET_TX_DESC_LINIP(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 28, 1)
-#define GET_TX_DESC_NO_ACM(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 29, 1)
-#define GET_TX_DESC_GF(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 30, 1)
 #define GET_TX_DESC_OWN(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
 
@@ -84,136 +60,35 @@
 	SET_BITS_OFFSET_LE(__pdesc+4, 0, 5, __val)
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+4, 5, 1, __val)
-#define SET_TX_DESC_BK(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc+4, 6, 1, __val)
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+4, 7, 1, __val)
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+4, 8, 5, __val)
-#define SET_TX_DESC_RDG_NAV_EXT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 13, 1, __val)
-#define SET_TX_DESC_LSIG_TXOP_EN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+4, 14, 1, __val)
-#define SET_TX_DESC_PIFS(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 15, 1, __val)
 #define SET_TX_DESC_RATE_ID(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+4, 16, 4, __val)
-#define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 20, 1, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+4, 22, 2, __val)
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+4, 26, 8, __val)
 
-#define GET_TX_DESC_MACID(__pdesc)					\
-	SHIFT_AND_MASK_LE(__pdesc+4, 0, 5)
-#define GET_TX_DESC_AGG_ENABLE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 5, 1)
-#define GET_TX_DESC_AGG_BREAK(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 6, 1)
-#define GET_TX_DESC_RDG_ENABLE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 7, 1)
-#define GET_TX_DESC_QUEUE_SEL(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 8, 5)
-#define GET_TX_DESC_RDG_NAV_EXT(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+4, 13, 1)
-#define GET_TX_DESC_LSIG_TXOP_EN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+4, 14, 1)
-#define GET_TX_DESC_PIFS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 15, 1)
-#define GET_TX_DESC_RATE_ID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 16, 4)
-#define GET_TX_DESC_NAV_USE_HDR(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+4, 20, 1)
-#define GET_TX_DESC_EN_DESC_ID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 21, 1)
-#define GET_TX_DESC_SEC_TYPE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 22, 2)
-#define GET_TX_DESC_PKT_OFFSET(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 24, 8)
-
-#define SET_TX_DESC_RTS_RC(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 0, 6, __val)
-#define SET_TX_DESC_DATA_RC(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 6, 6, __val)
-#define SET_TX_DESC_BAR_RTY_TH(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 14, 2, __val)
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+8, 17, 1, __val)
-#define SET_TX_DESC_RAW(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc+8, 18, 1, __val)
-#define SET_TX_DESC_CCX(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc+8, 19, 1, __val)
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+8, 20, 3, __val)
-#define SET_TX_DESC_ANTSEL_A(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 24, 1, __val)
-#define SET_TX_DESC_ANTSEL_B(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 25, 1, __val)
-#define SET_TX_DESC_TX_ANT_CCK(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 26, 2, __val)
-#define SET_TX_DESC_TX_ANTL(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 28, 2, __val)
-#define SET_TX_DESC_TX_ANT_HT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+8, 30, 2, __val)
-
-#define GET_TX_DESC_RTS_RC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 0, 6)
-#define GET_TX_DESC_DATA_RC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 6, 6)
-#define GET_TX_DESC_BAR_RTY_TH(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 14, 2)
-#define GET_TX_DESC_MORE_FRAG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 17, 1)
-#define GET_TX_DESC_RAW(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 18, 1)
-#define GET_TX_DESC_CCX(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 19, 1)
-#define GET_TX_DESC_AMPDU_DENSITY(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+8, 20, 3)
-#define GET_TX_DESC_ANTSEL_A(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 24, 1)
-#define GET_TX_DESC_ANTSEL_B(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 25, 1)
-#define GET_TX_DESC_TX_ANT_CCK(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 26, 2)
-#define GET_TX_DESC_TX_ANTL(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 28, 2)
-#define GET_TX_DESC_TX_ANT_HT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 30, 2)
-
-#define SET_TX_DESC_NEXT_HEAP_PAGE(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+12, 0, 8, __val)
-#define SET_TX_DESC_TAIL_PAGE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+12, 8, 8, __val)
+
 #define SET_TX_DESC_SEQ(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc+12, 16, 12, __val)
 #define SET_TX_DESC_PKT_ID(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+12, 28, 4, __val)
 
-#define GET_TX_DESC_NEXT_HEAP_PAGE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+12, 0, 8)
-#define GET_TX_DESC_TAIL_PAGE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 8, 8)
-#define GET_TX_DESC_SEQ(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 16, 12)
-#define GET_TX_DESC_PKT_ID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 28, 4)
-
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+16, 0, 5, __val)
-#define SET_TX_DESC_AP_DCFE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 5, 1, __val)
 #define SET_TX_DESC_QOS(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc+16, 6, 1, __val)
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+16, 7, 1, __val)
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+16, 8, 1, __val)
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+16, 9, 1, __val)
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+16, 10, 1, __val)
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
@@ -222,18 +97,8 @@
 	SET_BITS_OFFSET_LE(__pdesc+16, 12, 1, __val)
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+16, 13, 1, __val)
-#define SET_TX_DESC_PORT_ID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 14, 1, __val)
-#define SET_TX_DESC_WAIT_DCTS(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 18, 1, __val)
-#define SET_TX_DESC_CTS2AP_EN(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 19, 1, __val)
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+16, 20, 2, __val)
-#define SET_TX_DESC_TX_STBC(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 22, 2, __val)
-#define SET_TX_DESC_DATA_SHORT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+16, 24, 1, __val)
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+16, 25, 1, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
@@ -245,158 +110,29 @@
 #define SET_TX_DESC_RTS_STBC(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+16, 30, 2, __val)
 
-#define GET_TX_DESC_RTS_RATE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 0, 5)
-#define GET_TX_DESC_AP_DCFE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 5, 1)
-#define GET_TX_DESC_QOS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 6, 1)
-#define GET_TX_DESC_HWSEQ_EN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 7, 1)
-#define GET_TX_DESC_USE_RATE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 8, 1)
-#define GET_TX_DESC_DISABLE_RTS_FB(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+16, 9, 1)
-#define GET_TX_DESC_DISABLE_FB(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 10, 1)
-#define GET_TX_DESC_CTS2SELF(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 11, 1)
-#define GET_TX_DESC_RTS_ENABLE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 12, 1)
-#define GET_TX_DESC_HW_RTS_ENABLE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+16, 13, 1)
-#define GET_TX_DESC_PORT_ID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 14, 1)
-#define GET_TX_DESC_WAIT_DCTS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 18, 1)
-#define GET_TX_DESC_CTS2AP_EN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 19, 1)
-#define GET_TX_DESC_TX_SUB_CARRIER(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+16, 20, 2)
-#define GET_TX_DESC_TX_STBC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 22, 2)
-#define GET_TX_DESC_DATA_SHORT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 24, 1)
-#define GET_TX_DESC_DATA_BW(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 25, 1)
-#define GET_TX_DESC_RTS_SHORT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 26, 1)
-#define GET_TX_DESC_RTS_BW(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 27, 1)
-#define GET_TX_DESC_RTS_SC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 28, 2)
-#define GET_TX_DESC_RTS_STBC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 30, 2)
-
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+20, 0, 6, __val)
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+20, 6, 1, __val)
-#define SET_TX_DESC_CCX_TAG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+20, 7, 1, __val)
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+20, 8, 5, __val)
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+20, 13, 4, __val)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+20, 17, 1, __val)
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+20, 18, 6, __val)
-#define SET_TX_DESC_USB_TXAGG_NUM(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+20, 24, 8, __val)
-
-#define GET_TX_DESC_TX_RATE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+20, 0, 6)
-#define GET_TX_DESC_DATA_SHORTGI(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+20, 6, 1)
-#define GET_TX_DESC_CCX_TAG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+20, 7, 1)
-#define GET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+20, 8, 5)
-#define GET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+20, 13, 4)
-#define GET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+20, 17, 1)
-#define GET_TX_DESC_DATA_RETRY_LIMIT(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+20, 18, 6)
-#define GET_TX_DESC_USB_TXAGG_NUM(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+20, 24, 8)
-
-#define SET_TX_DESC_TXAGC_A(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+24, 0, 5, __val)
-#define SET_TX_DESC_TXAGC_B(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+24, 5, 5, __val)
-#define SET_TX_DESC_USE_MAX_LEN(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+24, 10, 1, __val)
+
 #define SET_TX_DESC_MAX_AGG_NUM(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+24, 11, 5, __val)
-#define SET_TX_DESC_MCSG1_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+24, 16, 4, __val)
-#define SET_TX_DESC_MCSG2_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+24, 20, 4, __val)
-#define SET_TX_DESC_MCSG3_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+24, 24, 4, __val)
-#define SET_TX_DESC_MCS7_SGI_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+24, 28, 4, __val)
-
-#define GET_TX_DESC_TXAGC_A(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+24, 0, 5)
-#define GET_TX_DESC_TXAGC_B(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+24, 5, 5)
-#define GET_TX_DESC_USE_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+24, 10, 1)
-#define GET_TX_DESC_MAX_AGG_NUM(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+24, 11, 5)
-#define GET_TX_DESC_MCSG1_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+24, 16, 4)
-#define GET_TX_DESC_MCSG2_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+24, 20, 4)
-#define GET_TX_DESC_MCSG3_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+24, 24, 4)
-#define GET_TX_DESC_MCS7_SGI_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+24, 28, 4)
 
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+28, 0, 16, __val)
-#define SET_TX_DESC_MCSG4_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+28, 16, 4, __val)
-#define SET_TX_DESC_MCSG5_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+28, 20, 4, __val)
-#define SET_TX_DESC_MCSG6_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+28, 24, 4, __val)
-#define SET_TX_DESC_MCS15_SGI_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc+28, 28, 4, __val)
-
-#define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+28, 0, 16)
-#define GET_TX_DESC_MCSG4_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+28, 16, 4)
-#define GET_TX_DESC_MCSG5_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+28, 20, 4)
-#define GET_TX_DESC_MCSG6_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+28, 24, 4)
-#define GET_TX_DESC_MCS15_SGI_MAX_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+28, 28, 4)
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+32, 0, 32, __val)
-#define SET_TX_DESC_TX_BUFFER_ADDRESS64(__pdesc, __val) \
-	SET_BITS_OFFSET_LE(__pdesc+36, 0, 32, __val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
 	SHIFT_AND_MASK_LE(__pdesc+32, 0, 32)
-#define GET_TX_DESC_TX_BUFFER_ADDRESS64(__pdesc)	\
-	SHIFT_AND_MASK_LE(__pdesc+36, 0, 32)
 
 #define SET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc, __val)	\
 	SET_BITS_OFFSET_LE(__pdesc+40, 0, 32, __val)
-#define SET_TX_DESC_NEXT_DESC_ADDRESS64(__pdesc, __val) \
-	SET_BITS_OFFSET_LE(__pdesc+44, 0, 32, __val)
-
-#define GET_TX_DESC_NEXT_DESC_ADDRESS(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+40, 0, 32)
-#define GET_TX_DESC_NEXT_DESC_ADDRESS64(__pdesc)	\
-	SHIFT_AND_MASK_LE(__pdesc+44, 0, 32)
 
 #define GET_RX_DESC_PKT_LEN(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 0, 14)
@@ -406,22 +142,12 @@
 	SHIFT_AND_MASK_LE(__pdesc, 15, 1)
 #define GET_RX_DESC_DRV_INFO_SIZE(__pdesc)		\
 	SHIFT_AND_MASK_LE(__pdesc, 16, 4)
-#define GET_RX_DESC_SECURITY(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 20, 3)
-#define GET_RX_DESC_QOS(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 23, 1)
 #define GET_RX_DESC_SHIFT(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 24, 2)
 #define GET_RX_DESC_PHYST(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 26, 1)
 #define GET_RX_DESC_SWDEC(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 27, 1)
-#define GET_RX_DESC_LS(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 28, 1)
-#define GET_RX_DESC_FS(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 29, 1)
-#define GET_RX_DESC_EOR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 30, 1)
 #define GET_RX_DESC_OWN(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
 
@@ -432,44 +158,10 @@
 #define SET_RX_DESC_OWN(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
 
-#define GET_RX_DESC_MACID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 0, 5)
-#define GET_RX_DESC_TID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 5, 4)
-#define GET_RX_DESC_HWRSVD(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 9, 5)
 #define GET_RX_DESC_PAGGR(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc+4, 14, 1)
 #define GET_RX_DESC_FAGGR(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc+4, 15, 1)
-#define GET_RX_DESC_A1_FIT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 16, 4)
-#define GET_RX_DESC_A2_FIT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 20, 4)
-#define GET_RX_DESC_PAM(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 24, 1)
-#define GET_RX_DESC_PWR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 25, 1)
-#define GET_RX_DESC_MD(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc+4, 26, 1)
-#define GET_RX_DESC_MF(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc+4, 27, 1)
-#define GET_RX_DESC_TYPE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+4, 28, 2)
-#define GET_RX_DESC_MC(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc+4, 30, 1)
-#define GET_RX_DESC_BC(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc+4, 31, 1)
-#define GET_RX_DESC_SEQ(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 0, 12)
-#define GET_RX_DESC_FRAG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 12, 4)
-#define GET_RX_DESC_NEXT_PKT_LEN(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+8, 16, 14)
-#define GET_RX_DESC_NEXT_IND(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 30, 1)
-#define GET_RX_DESC_RSVD(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+8, 31, 1)
 
 #define GET_RX_DESC_RXMCS(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc+12, 0, 6)
@@ -479,29 +171,14 @@
 	SHIFT_AND_MASK_LE(__pdesc+12, 8, 1)
 #define GET_RX_DESC_BW(__pdesc)				\
 	SHIFT_AND_MASK_LE(__pdesc+12, 9, 1)
-#define GET_RX_DESC_HTC(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 10, 1)
-#define GET_RX_DESC_HWPC_ERR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 14, 1)
-#define GET_RX_DESC_HWPC_IND(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 15, 1)
-#define GET_RX_DESC_IV0(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+12, 16, 16)
-
-#define GET_RX_DESC_IV1(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc+16, 0, 32)
+
 #define GET_RX_DESC_TSFL(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc+20, 0, 32)
 
 #define GET_RX_DESC_BUFF_ADDR(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc+24, 0, 32)
-#define GET_RX_DESC_BUFF_ADDR64(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc+28, 0, 32)
-
 #define SET_RX_DESC_BUFF_ADDR(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc+24, 0, 32, __val)
-#define SET_RX_DESC_BUFF_ADDR64(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc+28, 0, 32, __val)
 
 #define CLEAR_PCI_TX_DESC_CONTENT(__pdesc, _size)	\
 	memset((void *)__pdesc, 0,			\
-- 
2.23.0

