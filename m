Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFBA4A1D
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2019 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbfIAPrM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Sep 2019 11:47:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34284 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbfIAPrM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Sep 2019 11:47:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id c7so11485898otp.1
        for <linux-wireless@vger.kernel.org>; Sun, 01 Sep 2019 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5o350+aR3TZqQCsSzTSyCAFIUXU4nabJdh7kMaYN2aE=;
        b=dSgVRLz8q90y/U4Xe6CTOU5KFTWTLSwsrKobwPO149n6l9ZWERPlcqRCQaQSoxQAmQ
         Bif0OgvjNxeDMQ9IyxjfqzKC2YeXbtz+col0LMz6gBMd51hl1f8rHZ4APyvm/ZYHlnRM
         8HclczZThMPfM+s2can/YFUVDXKfTu8cHcGINAB2Gp6FnAKEvIrsGg3eJCPZDUkLl61b
         FRvNES+GrX71T1Fp9Rz++4AECnke9g/KbMHounT4kA4LAujzpgEc/I/xHs3JpeKp0mvg
         eHRg4KQwG8C0PIG33scBVwxMx7k7f4qS/o7uctxAXBRFfjs/2EbUddajvjm76vX9aXjT
         i9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5o350+aR3TZqQCsSzTSyCAFIUXU4nabJdh7kMaYN2aE=;
        b=nd3Jvs02eEQMrEqKoKnlTNrUB7eB9xaTQzBY4Zkfj0qLn2zLjlDmOZB6c4000jdCw8
         btRwZMXfKoVxni4cKRXu1HqmhpFS7DOhWINxGzaSVE/nZcVHaSfRpsmMkwPWAJLFSTLh
         raxmnZAHdBqJim/pZRB4AC5Pp+ft3qG7eINAmxQ6Mvm6f0L/+5/cvCLwNrma2M+o9YYh
         KLz8tC7l8FLxO9Sh26uAvI8BA6ZhBgNAShbILlCTw7fqJJyRyjzpqOvSnfIjMCEztGts
         3XHj2FwARVFaaI2pFa7kYvik8iQjjC/Tczi1UVbb6zzgv7eIHaBmghOrZgAtMIOWlHoV
         u8xw==
X-Gm-Message-State: APjAAAWQZC66VocHoVsWTAsZdeqPy9OvJZeLep7vDSkl7dJpLUu1h6yO
        sg5weM190y/IWWdBmC0s+TwUONg/
X-Google-Smtp-Source: APXvYqy2rKXpcrOMB4dnaN5RLRGPgw7+zojLZDhDKtxZNYTI8hHRb+EegEOXKWN+IAG95yM9+4n/Lg==
X-Received: by 2002:a05:6830:1f04:: with SMTP id u4mr11876485otg.340.1567352830782;
        Sun, 01 Sep 2019 08:47:10 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id b19sm3186440oie.34.2019.09.01.08.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Sep 2019 08:47:10 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/4] rtlwifi: rtl8192cu: Remove unused GET_XXX and SET_XXX
Date:   Sun,  1 Sep 2019 10:47:03 -0500
Message-Id: <20190901154706.24193-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
References: <20190901154706.24193-1-Larry.Finger@lwfinger.net>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As the first step in converting from macros that get/set information
in the RX and TX descriptors, unused macros are being removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   | 150 +--------------------
 1 file changed, 3 insertions(+), 147 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
index ae2e8aa212de..15627a7d42f5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/trx.h
@@ -81,92 +81,28 @@ struct rx_drv_info_92c {
 	LE_BITS_TO_4BYTE(__rxdesc, 15, 1)
 #define GET_RX_DESC_DRVINFO_SIZE(__rxdesc)	\
 	LE_BITS_TO_4BYTE(__rxdesc, 16, 4)
-#define GET_RX_DESC_SECURITY(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 20, 3)
-#define GET_RX_DESC_QOS(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 23, 1)
 #define GET_RX_DESC_SHIFT(__rxdesc)		\
 	LE_BITS_TO_4BYTE(__rxdesc, 24, 2)
 #define GET_RX_DESC_PHY_STATUS(__rxdesc)	\
 	LE_BITS_TO_4BYTE(__rxdesc, 26, 1)
 #define GET_RX_DESC_SWDEC(__rxdesc)		\
 	LE_BITS_TO_4BYTE(__rxdesc, 27, 1)
-#define GET_RX_DESC_LAST_SEG(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 28, 1)
-#define GET_RX_DESC_FIRST_SEG(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 29, 1)
-#define GET_RX_DESC_EOR(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 30, 1)
-#define GET_RX_DESC_OWN(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc, 31, 1)
 
 /* DWORD 1 */
-#define GET_RX_DESC_MACID(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 0, 5)
-#define GET_RX_DESC_TID(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 5, 4)
 #define GET_RX_DESC_PAGGR(__rxdesc)		\
 	LE_BITS_TO_4BYTE(__rxdesc + 4, 14, 1)
 #define GET_RX_DESC_FAGGR(__rxdesc)		\
 	LE_BITS_TO_4BYTE(__rxdesc + 4, 15, 1)
-#define GET_RX_DESC_A1_FIT(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 16, 4)
-#define GET_RX_DESC_A2_FIT(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 20, 4)
-#define GET_RX_DESC_PAM(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 24, 1)
-#define GET_RX_DESC_PWR(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 25, 1)
-#define GET_RX_DESC_MORE_DATA(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 26, 1)
-#define GET_RX_DESC_MORE_FRAG(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 27, 1)
-#define GET_RX_DESC_TYPE(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 28, 2)
-#define GET_RX_DESC_MC(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 30, 1)
-#define GET_RX_DESC_BC(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 4, 31, 1)
-
-/* DWORD 2 */
-#define GET_RX_DESC_SEQ(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 8, 0, 12)
-#define GET_RX_DESC_FRAG(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 8, 12, 4)
-#define GET_RX_DESC_USB_AGG_PKTNUM(__rxdesc)	\
-	LE_BITS_TO_4BYTE(__rxdesc + 8, 16, 8)
-#define GET_RX_DESC_NEXT_IND(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 8, 30, 1)
 
 /* DWORD 3 */
 #define GET_RX_DESC_RX_MCS(__rxdesc)		\
 	LE_BITS_TO_4BYTE(__rxdesc + 12, 0, 6)
-#define GET_RX_DESC_RX_HT(__rxdesc)		\
+#define GET_RX_DESC_RX_HT(__rxdesc)            \
 	LE_BITS_TO_4BYTE(__rxdesc + 12, 6, 1)
-#define GET_RX_DESC_AMSDU(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 7, 1)
-#define GET_RX_DESC_SPLCP(__rxdesc)		\
+#define GET_RX_DESC_SPLCP(__rxdesc)            \
 	LE_BITS_TO_4BYTE(__rxdesc + 12, 8, 1)
-#define GET_RX_DESC_BW(__rxdesc)		\
+#define GET_RX_DESC_BW(__rxdesc)               \
 	LE_BITS_TO_4BYTE(__rxdesc + 12, 9, 1)
-#define GET_RX_DESC_HTC(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 10, 1)
-#define GET_RX_DESC_TCP_CHK_RPT(__rxdesc)	\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 11, 1)
-#define GET_RX_DESC_IP_CHK_RPT(__rxdesc)	\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 12, 1)
-#define GET_RX_DESC_TCP_CHK_VALID(__rxdesc)	\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 13, 1)
-#define GET_RX_DESC_HWPC_ERR(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 14, 1)
-#define GET_RX_DESC_HWPC_IND(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 15, 1)
-#define GET_RX_DESC_IV0(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 12, 16, 16)
-
-/* DWORD 4 */
-#define GET_RX_DESC_IV1(__rxdesc)		\
-	LE_BITS_TO_4BYTE(__rxdesc + 16, 0, 32)
 
 /* DWORD 5 */
 #define GET_RX_DESC_TSFL(__rxdesc)		\
@@ -191,10 +127,6 @@ struct rx_drv_info_92c {
 	 SET_BITS_TO_LE_4BYTE(__txdesc, 27, 1, __value)
 #define SET_TX_DESC_LINIP(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc, 28, 1, __value)
-#define SET_TX_DESC_NO_ACM(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 29, 1, __value)
-#define SET_TX_DESC_GF(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc, 30, 1, __value)
 #define SET_TX_DESC_OWN(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc, 31, 1, __value)
 
@@ -209,56 +141,22 @@ struct rx_drv_info_92c {
 	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 7, 1, __value)
 #define SET_TX_DESC_QUEUE_SEL(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 8, 5, __value)
-#define SET_TX_DESC_RDG_NAV_EXT(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 13, 1, __value)
-#define SET_TX_DESC_LSIG_TXOP_EN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 14, 1, __value)
-#define SET_TX_DESC_PIFS(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 15, 1, __value)
 #define SET_TX_DESC_RATE_ID(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 16, 4, __value)
-#define SET_TX_DESC_RA_BRSR_ID(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 16, 4, __value)
 #define SET_TX_DESC_NAV_USE_HDR(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 20, 1, __value)
-#define SET_TX_DESC_EN_DESC_ID(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 21, 1, __value)
 #define SET_TX_DESC_SEC_TYPE(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 22, 2, __value)
 #define SET_TX_DESC_PKT_OFFSET(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 4, 26, 5, __value)
 
 /* Dword 2 */
-#define SET_TX_DESC_RTS_RC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 0, 6, __value)
-#define SET_TX_DESC_DATA_RC(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 6, 6, __value)
-#define SET_TX_DESC_BAR_RTY_TH(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 14, 2, __value)
 #define SET_TX_DESC_MORE_FRAG(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 17, 1, __value)
-#define SET_TX_DESC_RAW(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 18, 1, __value)
-#define SET_TX_DESC_CCX(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 19, 1, __value)
 #define SET_TX_DESC_AMPDU_DENSITY(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 20, 3, __value)
-#define SET_TX_DESC_ANTSEL_A(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 24, 1, __value)
-#define SET_TX_DESC_ANTSEL_B(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 25, 1, __value)
-#define SET_TX_DESC_TX_ANT_CCK(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 26, 2, __value)
-#define SET_TX_DESC_TX_ANTL(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 28, 2, __value)
-#define SET_TX_DESC_TX_ANT_HT(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 8, 30, 2, __value)
 
 /* Dword 3 */
-#define SET_TX_DESC_NEXT_HEAP_PAGE(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 12, 0, 8, __value)
-#define SET_TX_DESC_TAIL_PAGE(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 12, 8, 8, __value)
 #define SET_TX_DESC_SEQ(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 12, 16, 12, __value)
 #define SET_TX_DESC_PKT_ID(__txdesc, __value)		\
@@ -267,16 +165,12 @@ struct rx_drv_info_92c {
 /* Dword 4 */
 #define SET_TX_DESC_RTS_RATE(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 0, 5, __value)
-#define SET_TX_DESC_AP_DCFE(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 5, 1, __value)
 #define SET_TX_DESC_QOS(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 6, 1, __value)
 #define SET_TX_DESC_HWSEQ_EN(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 7, 1, __value)
 #define SET_TX_DESC_USE_RATE(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 8, 1, __value)
-#define SET_TX_DESC_DISABLE_RTS_FB(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 9, 1, __value)
 #define SET_TX_DESC_DISABLE_FB(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 10, 1, __value)
 #define SET_TX_DESC_CTS2SELF(__txdesc, __value)		\
@@ -285,16 +179,8 @@ struct rx_drv_info_92c {
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 12, 1, __value)
 #define SET_TX_DESC_HW_RTS_ENABLE(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 13, 1, __value)
-#define SET_TX_DESC_WAIT_DCTS(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 18, 1, __value)
-#define SET_TX_DESC_CTS2AP_EN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 19, 1, __value)
 #define SET_TX_DESC_DATA_SC(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 20, 2, __value)
-#define SET_TX_DESC_DATA_STBC(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 22, 2, __value)
-#define SET_TX_DESC_DATA_SHORT(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 24, 1, __value)
 #define SET_TX_DESC_DATA_BW(__txdesc, __value)		\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 16, 25, 1, __value)
 #define SET_TX_DESC_RTS_SHORT(__txdesc, __value)	\
@@ -311,48 +197,18 @@ struct rx_drv_info_92c {
 	SET_BITS_TO_LE_4BYTE(__pdesc + 20, 0, 6, __val)
 #define SET_TX_DESC_DATA_SHORTGI(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc + 20, 6, 1, __val)
-#define SET_TX_DESC_CCX_TAG(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc + 20, 7, 1, __val)
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__txdesc, __value) \
 	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 8, 5, __value)
 #define SET_TX_DESC_RTS_RATE_FB_LIMIT(__txdesc, __value) \
 	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 13, 4, __value)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__txdesc, __value) \
-	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 17, 1, __value)
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 18, 6, __value)
-#define SET_TX_DESC_USB_TXAGG_NUM(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 20, 24, 8, __value)
 
 /* Dword 6 */
-#define SET_TX_DESC_TXAGC_A(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 0, 5, __value)
-#define SET_TX_DESC_TXAGC_B(__txdesc, __value)		\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 5, 5, __value)
-#define SET_TX_DESC_USB_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 10, 1, __value)
 #define SET_TX_DESC_MAX_AGG_NUM(__txdesc, __value)	\
 	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 11, 5, __value)
-#define SET_TX_DESC_MCSG1_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 16, 4, __value)
-#define SET_TX_DESC_MCSG2_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 20, 4, __value)
-#define SET_TX_DESC_MCSG3_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 24, 4, __value)
-#define SET_TX_DESC_MCSG7_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 24, 28, 4, __value)
 
 /* Dword 7 */
 #define SET_TX_DESC_TX_DESC_CHECKSUM(__txdesc, __value) \
 	SET_BITS_TO_LE_4BYTE(__txdesc + 28, 0, 16, __value)
-#define SET_TX_DESC_MCSG4_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 28, 16, 4, __value)
-#define SET_TX_DESC_MCSG5_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 28, 20, 4, __value)
-#define SET_TX_DESC_MCSG6_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 28, 24, 4, __value)
-#define SET_TX_DESC_MCSG15_MAX_LEN(__txdesc, __value)	\
-	SET_BITS_TO_LE_4BYTE(__txdesc + 28, 28, 4, __value)
 
 int  rtl8192cu_endpoint_mapping(struct ieee80211_hw *hw);
 u16 rtl8192cu_mq_to_hwq(__le16 fc, u16 mac80211_queue_index);
-- 
2.16.4

