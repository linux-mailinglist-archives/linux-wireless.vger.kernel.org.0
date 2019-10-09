Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0286CD16E7
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 19:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbfJIRh3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 13:37:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34640 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730256AbfJIRh3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 13:37:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id 83so2499196oii.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Oct 2019 10:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZpyBNxRaUpipZMxqBxQ1E8/lo3HNDmzmAgmQt+TZU4E=;
        b=LzSUMZnHkPCdoz380KKPcr/KeQY50R8OUNaU0+Ol5SSpxP6sQprbGLVzM84w82GR7o
         p1oBnImhhQDf3Mc4YyLA2ULiZ6cIV7n/8GF1jrXZSg9M8tqOYwmfOia0Xu8ct64Y+337
         qrHf/p00lEj4g2BTrBQoxo5pyemX8OOn7soG6uFU1x2rY49NHl+V341CIX2J2/LNCFPR
         ynm4hl1msx7Wf3yHfaJmonWDGRKD39OHF6tYS/6xMuSAtHieNcsW2/M8qD7I5hqcmiXw
         lIqxDEaI1Kqoue1Ic2mAY6Tl78TVxADvJ7Z3S06Ykz7YmRZ0+r5fcPiww028HMLrk5UF
         +iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ZpyBNxRaUpipZMxqBxQ1E8/lo3HNDmzmAgmQt+TZU4E=;
        b=bs/7YAwwT6tvURvQaBJ8i1Vr1RVuoq3csNOUyHY+pHS0o0+xWqTrBF4dagYXS1OWtN
         zuuox1EqsH9J4CdaGgUQMbWvgluQKGYeI3r22bysNXTkfjtq+0aEnhoW3QMAv66FN3Zq
         iF4QiVNwaM8dxwXXHNxUEVghb883UKSbEAkRl22+60hAWNygRjtXqtGHxFRl8DKnVi1w
         azwkliEapuDb1q7BjTOy+nrAH/gcY69rYKfUcypikK2frrqJB1cx4mRZpv4a8gBiDMP7
         4VS37PTV293Nuwk5DPP5IzXyMS3vz7KNOivL7BT7JHEy1yN7u6LeCqzZhvXb2Z8ji/Ls
         FJ9A==
X-Gm-Message-State: APjAAAVDaDYUx14P46fDJDuDhYApM2iaCCHhrzvmiWY1FWEDPXQXXgZT
        r4tCDycDwS7HHLkHj+pELeXLwhpY
X-Google-Smtp-Source: APXvYqyIPL10VLSN3VTEqqAY9i+H0nPNvEhZQRH6MjUeiG1HtaRNsKth165zkQO0x65aJQSgaWSIsA==
X-Received: by 2002:a05:6808:65a:: with SMTP id z26mr3365086oih.2.1570642647702;
        Wed, 09 Oct 2019 10:37:27 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id s66sm848199otb.65.2019.10.09.10.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 10:37:27 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/4] rtlwifi: rtl8192se: Remove unused GET_XXX and SET_XXX
Date:   Wed,  9 Oct 2019 12:37:08 -0500
Message-Id: <20191009173711.20348-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
References: <20191009173711.20348-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192se/def.h  | 223 ------------------
 1 file changed, 223 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
index bb6b60814762..44b2b4e3c151 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/def.h
@@ -53,18 +53,12 @@
 	SET_BITS_OFFSET_LE(__pdesc, 0, 16, __val)
 #define SET_TX_DESC_OFFSET(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 16, 8, __val)
-#define SET_TX_DESC_TYPE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 24, 2, __val)
 #define SET_TX_DESC_LAST_SEG(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 26, 1, __val)
 #define SET_TX_DESC_FIRST_SEG(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 27, 1, __val)
 #define SET_TX_DESC_LINIP(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 28, 1, __val)
-#define SET_TX_DESC_AMSDU(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 29, 1, __val)
-#define SET_TX_DESC_GREEN_FIELD(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 30, 1, __val)
 #define SET_TX_DESC_OWN(__pdesc, __val)				\
 	SET_BITS_OFFSET_LE(__pdesc, 31, 1, __val)
 
@@ -74,76 +68,26 @@
 /* Dword 1 */
 #define SET_TX_DESC_MACID(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 4, 0, 5, __val)
-#define SET_TX_DESC_MORE_DATA(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 5, 1, __val)
-#define SET_TX_DESC_MORE_FRAG(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 6, 1, __val)
-#define SET_TX_DESC_PIFS(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 7, 1, __val)
 #define SET_TX_DESC_QUEUE_SEL(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 4, 8, 5, __val)
-#define SET_TX_DESC_ACK_POLICY(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 13, 2, __val)
-#define SET_TX_DESC_NO_ACM(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 15, 1, __val)
 #define SET_TX_DESC_NON_QOS(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 4, 16, 1, __val)
-#define SET_TX_DESC_KEY_ID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 17, 2, __val)
-#define SET_TX_DESC_OUI(__pdesc, __val)				\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 19, 1, __val)
-#define SET_TX_DESC_PKT_TYPE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 20, 1, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 4, 22, 2, __val)
-#define SET_TX_DESC_WDS(__pdesc, __val)				\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 24, 1, __val)
-#define SET_TX_DESC_HTC(__pdesc, __val)				\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 25, 1, __val)
-#define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 26, 5, __val)
-#define SET_TX_DESC_HWPC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 27, 1, __val)
 
 /* Dword 2 */
-#define SET_TX_DESC_DATA_RETRY_LIMIT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 0, 6, __val)
-#define SET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 6, 1, __val)
-#define SET_TX_DESC_TSFL(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 7, 5, __val)
-#define SET_TX_DESC_RTS_RETRY_COUNT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 12, 6, __val)
-#define SET_TX_DESC_DATA_RETRY_COUNT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 18, 6, __val)
 #define	SET_TX_DESC_RSVD_MACID(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(((__pdesc) + 8), 24, 5, __val)
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 8, 29, 1, __val)
-#define SET_TX_DESC_AGG_BREAK(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 30, 1, __val)
-#define SET_TX_DESC_OWN_MAC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 31, 1, __val)
 
 /* Dword 3 */
-#define SET_TX_DESC_NEXT_HEAP_PAGE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 0, 8, __val)
-#define SET_TX_DESC_TAIL_PAGE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 8, 8, __val)
 #define SET_TX_DESC_SEQ(__pdesc, __val)				\
 	SET_BITS_OFFSET_LE(__pdesc + 12, 16, 12, __val)
-#define SET_TX_DESC_FRAG(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 28, 4, __val)
 
 /* Dword 4 */
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 16, 0, 6, __val)
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 6, 1, __val)
-#define SET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 7, 4, __val)
 #define SET_TX_DESC_CTS_ENABLE(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 16, 11, 1, __val)
 #define SET_TX_DESC_RTS_ENABLE(__pdesc, __val)			\
@@ -158,12 +102,6 @@
 	SET_BITS_OFFSET_LE(__pdesc + 16, 18, 1, __val)
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc + 16, 19, 2, __val)
-#define SET_TX_DESC_TX_STBC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 21, 2, __val)
-#define SET_TX_DESC_TX_REVERSE_DIRECTION(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 23, 1, __val)
-#define SET_TX_DESC_RTS_HT(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 24, 1, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 16, 25, 1, __val)
 #define SET_TX_DESC_RTS_BANDWIDTH(__pdesc, __val)		\
@@ -180,26 +118,12 @@
 	SET_BITS_OFFSET_LE(__pdesc + 20, 0, 9, __val)
 #define SET_TX_DESC_TX_RATE(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc + 20, 9, 6, __val)
-#define SET_TX_DESC_DISABLE_FB(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 20, 15, 1, __val)
 #define SET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc + 20, 16, 5, __val)
-#define SET_TX_DESC_TX_AGC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 20, 21, 11, __val)
-
-/* Dword 6 */
-#define SET_TX_DESC_IP_CHECK_SUM(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 24, 0, 16, __val)
-#define SET_TX_DESC_TCP_CHECK_SUM(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 24, 16, 16, __val)
 
 /* Dword 7 */
 #define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc + 28, 0, 16, __val)
-#define SET_TX_DESC_IP_HEADER_OFFSET(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 28, 16, 8, __val)
-#define SET_TX_DESC_TCP_ENABLE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 28, 31, 1, __val)
 
 /* Dword 8 */
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)		\
@@ -228,26 +152,6 @@
 /* DWORD 0 */
 #define SET_RX_STATUS_DESC_PKT_LEN(__pdesc, __val)		\
 	SET_BITS_OFFSET_LE(__pdesc, 0, 14, __val)
-#define SET_RX_STATUS_DESC_CRC32(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 14, 1, __val)
-#define SET_RX_STATUS_DESC_ICV(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 15, 1, __val)
-#define SET_RX_STATUS_DESC_DRVINFO_SIZE(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 16, 4, __val)
-#define SET_RX_STATUS_DESC_SECURITY(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 20, 3, __val)
-#define SET_RX_STATUS_DESC_QOS(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc, 23, 1, __val)
-#define SET_RX_STATUS_DESC_SHIFT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 24, 2, __val)
-#define SET_RX_STATUS_DESC_PHY_STATUS(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 26, 1, __val)
-#define SET_RX_STATUS_DESC_SWDEC(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 27, 1, __val)
-#define SET_RX_STATUS_DESC_LAST_SEG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 28, 1, __val)
-#define SET_RX_STATUS_DESC_FIRST_SEG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc, 29, 1, __val)
 #define SET_RX_STATUS_DESC_EOR(__pdesc, __val)			\
 	SET_BITS_OFFSET_LE(__pdesc, 30, 1, __val)
 #define SET_RX_STATUS_DESC_OWN(__pdesc, __val)			\
@@ -261,159 +165,32 @@
 	SHIFT_AND_MASK_LE(__pdesc, 15, 1)
 #define GET_RX_STATUS_DESC_DRVINFO_SIZE(__pdesc)		\
 	SHIFT_AND_MASK_LE(__pdesc, 16, 4)
-#define GET_RX_STATUS_DESC_SECURITY(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 20, 3)
-#define GET_RX_STATUS_DESC_QOS(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 23, 1)
 #define GET_RX_STATUS_DESC_SHIFT(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 24, 2)
 #define GET_RX_STATUS_DESC_PHY_STATUS(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 26, 1)
 #define GET_RX_STATUS_DESC_SWDEC(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc, 27, 1)
-#define GET_RX_STATUS_DESC_LAST_SEG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 28, 1)
-#define GET_RX_STATUS_DESC_FIRST_SEG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc, 29, 1)
-#define GET_RX_STATUS_DESC_EOR(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc, 30, 1)
 #define GET_RX_STATUS_DESC_OWN(__pdesc)				\
 	SHIFT_AND_MASK_LE(__pdesc, 31, 1)
 
 /* DWORD 1 */
-#define SET_RX_STATUS_DESC_MACID(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 0, 5, __val)
-#define SET_RX_STATUS_DESC_TID(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 5, 4, __val)
-#define SET_RX_STATUS_DESC_PAGGR(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 14, 1, __val)
-#define SET_RX_STATUS_DESC_FAGGR(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 15, 1, __val)
-#define SET_RX_STATUS_DESC_A1_FIT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 16, 4, __val)
-#define SET_RX_STATUS_DESC_A2_FIT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 20, 4, __val)
-#define SET_RX_STATUS_DESC_PAM(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 24, 1, __val)
-#define SET_RX_STATUS_DESC_PWR(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 25, 1, __val)
-#define SET_RX_STATUS_DESC_MOREDATA(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 26, 1, __val)
-#define SET_RX_STATUS_DESC_MOREFRAG(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 27, 1, __val)
-#define SET_RX_STATUS_DESC_TYPE(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 28, 2, __val)
-#define SET_RX_STATUS_DESC_MC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 30, 1, __val)
-#define SET_RX_STATUS_DESC_BC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 4, 31, 1, __val)
-
-#define GET_RX_STATUS_DEC_MACID(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 0, 5)
-#define GET_RX_STATUS_DESC_TID(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 5, 4)
 #define GET_RX_STATUS_DESC_PAGGR(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc + 4, 14, 1)
 #define GET_RX_STATUS_DESC_FAGGR(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc + 4, 15, 1)
-#define GET_RX_STATUS_DESC_A1_FIT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 16, 4)
-#define GET_RX_STATUS_DESC_A2_FIT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 20, 4)
-#define GET_RX_STATUS_DESC_PAM(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 24, 1)
-#define GET_RX_STATUS_DESC_PWR(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 25, 1)
-#define GET_RX_STATUS_DESC_MORE_DATA(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 26, 1)
-#define GET_RX_STATUS_DESC_MORE_FRAG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 27, 1)
-#define GET_RX_STATUS_DESC_TYPE(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 28, 2)
-#define GET_RX_STATUS_DESC_MC(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 30, 1)
-#define GET_RX_STATUS_DESC_BC(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 4, 31, 1)
-
-/* DWORD 2 */
-#define SET_RX_STATUS_DESC_SEQ(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 0, 12, __val)
-#define SET_RX_STATUS_DESC_FRAG(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 12, 4, __val)
-#define SET_RX_STATUS_DESC_NEXT_PKTLEN(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 16, 8, __val)
-#define SET_RX_STATUS_DESC_NEXT_IND(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 8, 30, 1, __val)
-
-#define GET_RX_STATUS_DESC_SEQ(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 8, 0, 12)
-#define GET_RX_STATUS_DESC_FRAG(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 8, 12, 4)
-#define GET_RX_STATUS_DESC_NEXT_PKTLEN(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 8, 16, 8)
-#define GET_RX_STATUS_DESC_NEXT_IND(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 8, 30, 1)
 
 /* DWORD 3 */
-#define SET_RX_STATUS_DESC_RX_MCS(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 0, 6, __val)
-#define SET_RX_STATUS_DESC_RX_HT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 6, 1, __val)
-#define SET_RX_STATUS_DESC_AMSDU(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 7, 1, __val)
-#define SET_RX_STATUS_DESC_SPLCP(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 8, 1, __val)
-#define SET_RX_STATUS_DESC_BW(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 9, 1, __val)
-#define SET_RX_STATUS_DESC_HTC(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 10, 1, __val)
-#define SET_RX_STATUS_DESC_TCP_CHK_RPT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 11, 1, __val)
-#define SET_RX_STATUS_DESC_IP_CHK_RPT(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 12, 1, __val)
-#define SET_RX_STATUS_DESC_TCP_CHK_VALID(__pdesc, __val)	\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 13, 1, __val)
-#define SET_RX_STATUS_DESC_HWPC_ERR(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 14, 1, __val)
-#define SET_RX_STATUS_DESC_HWPC_IND(__pdesc, __val)		\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 15, 1, __val)
-#define SET_RX_STATUS_DESC_IV0(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 12, 16, 16, __val)
-
 #define GET_RX_STATUS_DESC_RX_MCS(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc + 12, 0, 6)
 #define GET_RX_STATUS_DESC_RX_HT(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc + 12, 6, 1)
-#define GET_RX_STATUS_DESC_AMSDU(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 7, 1)
 #define GET_RX_STATUS_DESC_SPLCP(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc + 12, 8, 1)
 #define GET_RX_STATUS_DESC_BW(__pdesc)				\
 	SHIFT_AND_MASK_LE(__pdesc + 12, 9, 1)
-#define GET_RX_STATUS_DESC_HTC(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 10, 1)
-#define GET_RX_STATUS_DESC_TCP_CHK_RPT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 11, 1)
-#define GET_RX_STATUS_DESC_IP_CHK_RPT(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 12, 1)
-#define GET_RX_STATUS_DESC_TCP_CHK_VALID(__pdesc)		\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 13, 1)
-#define GET_RX_STATUS_DESC_HWPC_ERR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 14, 1)
-#define GET_RX_STATUS_DESC_HWPC_IND(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 15, 1)
-#define GET_RX_STATUS_DESC_IV0(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 12, 16, 16)
-
-/* DWORD 4 */
-#define SET_RX_STATUS_DESC_IV1(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 16, 0, 32, __val)
-#define GET_RX_STATUS_DESC_IV1(__pdesc)				\
-	SHIFT_AND_MASK_LE(__pdesc + 16, 0, 32)
 
 /* DWORD 5 */
-#define SET_RX_STATUS_DESC_TSFL(__pdesc, __val)			\
-	SET_BITS_OFFSET_LE(__pdesc + 20, 0, 32, __val)
 #define GET_RX_STATUS_DESC_TSFL(__pdesc)			\
 	SHIFT_AND_MASK_LE(__pdesc + 20, 0, 32)
 
-- 
2.23.0

