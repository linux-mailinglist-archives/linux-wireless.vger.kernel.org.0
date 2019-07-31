Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 092487B734
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 02:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbfGaAdQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 20:33:16 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34972 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbfGaAdQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 20:33:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id a127so49316733oii.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2019 17:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UAfucbx0heBc3x9FNLjh7QAn4WQuytYRC9LEVUuAodg=;
        b=lasIGT0vLBmhAeNgr6hMDakWAK+0NjX4DTNd+oU58SLffJqBe5Yxm7gov+R9I4ERqo
         C9ZPsmRubGUda4JjNser+K3ZZlnjITRBMOSt9PcSR0tTpVnb7eCTDOuqdepjzGgtDp1P
         gxDvnMa56YaGhhQ2P/jmdGITaxhg+0gICSsUuRsvxy8l9cgwodMeJvt3xfFimS2S+GIq
         L9ARlpcFURCxgtc/HcJTRe2Zjnv2hhXgFbHd5ahf0UAGBHaDPWXSUv6Fnuku2NA9C0y3
         LjBj+eYKvhlfum6MW+ogQEAByxyqT5Zd0OEiPo5KTCdyVf0kq6v2chnCNa2EQcHiCBG1
         cgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UAfucbx0heBc3x9FNLjh7QAn4WQuytYRC9LEVUuAodg=;
        b=oQksq9HAn0YdRdZxbqmMF92E8NIzHIjqjWFFoXlTTkEr40N0ZyGNR0skjQAezZXv/y
         RW6Rx6jAHxNhHzNzQ+XXtobxGZYH0nGvLiu5OCISMu7bsNpXEzelAVgHWlo9iTxWh1KU
         9E6bNcJYXQz1tb+HadXhPclW82YioBPDWgNe98sdZbKG2zzwCAUHe1DXYgSEGxRcFCqp
         gaoJWNJOJcRWfXXe4j97HvGjBuwNF6dAWdxxeV9uMO7TFIU9LKgcZHabuPzbF4w66KfS
         FtIXMiF4WvmU9HpTZb3LGIQOwrCAqj1A3f4EJycgBhPVTsDIroCUTaVRILaKXXgzoYwO
         uiqw==
X-Gm-Message-State: APjAAAUcP1webpAoytEC5DSPC3L+ju2HyzCUzdIukQ8Vl3jXaXJrMgeo
        EmYfZJqoU6jUscBRogJ20fo=
X-Google-Smtp-Source: APXvYqxzPyB1ZNqzttIIH8DoyFmf6AtBYxN2+HIAqLivbugQfWwo37azOIctztNxGEnG3malPg8Cig==
X-Received: by 2002:aca:c708:: with SMTP id x8mr57636004oif.10.1564533194563;
        Tue, 30 Jul 2019 17:33:14 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t11sm22156016otq.13.2019.07.30.17.33.13
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 17:33:14 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 1/5] rtlwifi: rtl8188ee: Remove unused GET_XXX and SET_XXX descriptor macros
Date:   Tue, 30 Jul 2019 19:33:00 -0500
Message-Id: <20190731003304.14377-2-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
References: <20190731003304.14377-1-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8188ee/trx.h  | 267 +-----------------
 1 file changed, 6 insertions(+), 261 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
index c29d9bfa5bd4..60efabc6f87a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.h
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
 
@@ -60,144 +38,39 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 0, 6, __val)
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
 #define SET_TX_DESC_NAV_USE_HDR(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 20, 1, __val)
-#define SET_TX_DESC_EN_DESC_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 21, 1, __val)
 #define SET_TX_DESC_SEC_TYPE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 22, 2, __val)
 #define SET_TX_DESC_PKT_OFFSET(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+4, 26, 5, __val)
-#define SET_TX_DESC_PADDING_LEN(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+4, 24, 8, __val)
-
-#define GET_TX_DESC_MACID(__pdesc)					\
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
-#define GET_TX_DESC_PIFS(__pdesc)					\
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
-#define SET_TX_DESC_DATA_RC(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 6, 6, __val)
+
 #define SET_TX_DESC_AGG_ENABLE(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 12, 1, __val)
 #define SET_TX_DESC_RDG_ENABLE(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 13, 1, __val)
-#define SET_TX_DESC_BAR_RTY_TH(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 14, 2, __val)
-#define SET_TX_DESC_AGG_BREAK(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 16, 1, __val)
 #define SET_TX_DESC_MORE_FRAG(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 17, 1, __val)
-#define SET_TX_DESC_RAW(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 18, 1, __val)
-#define SET_TX_DESC_CCX(__pdesc, __val)				\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 19, 1, __val)
 #define SET_TX_DESC_AMPDU_DENSITY(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 20, 3, __val)
-#define SET_TX_DESC_BT_INT(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 23, 1, __val)
 #define SET_TX_DESC_ANTSEL_A(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 24, 1, __val)
 #define SET_TX_DESC_ANTSEL_B(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+8, 25, 1, __val)
-#define SET_TX_DESC_TX_ANT_CCK(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 26, 2, __val)
-#define SET_TX_DESC_TX_ANTL(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+8, 28, 2, __val)
-#define SET_TX_DESC_TX_ANT_HT(__pdesc, __val)			\
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
-#define GET_TX_DESC_TX_ANT_CCK(__pdesc)			\
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
 #define SET_TX_DESC_SEQ(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 16, 12, __val)
-#define SET_TX_DESC_CPU_HANDLE(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 28, 1, __val)
-#define SET_TX_DESC_TAG1(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 29, 1, __val)
-#define SET_TX_DESC_TRIGGER_INT(__pdesc, __val)			\
-	SET_BITS_TO_LE_4BYTE(__pdesc+12, 30, 1, __val)
 #define SET_TX_DESC_HWSEQ_EN(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+12, 31, 1, __val)
 
-#define GET_TX_DESC_NEXT_HEAP_PAGE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+12, 0, 8)
-#define GET_TX_DESC_TAIL_PAGE(__pdesc)				\
-	LE_BITS_TO_4BYTE(__pdesc+12, 8, 8)
-#define GET_TX_DESC_SEQ(__pdesc)					\
-	LE_BITS_TO_4BYTE(__pdesc+12, 16, 12)
-
 #define SET_TX_DESC_RTS_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 0, 5, __val)
-#define SET_TX_DESC_AP_DCFE(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 5, 1, __val)
 #define SET_TX_DESC_QOS(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 6, 1, __val)
-#define SET_TX_DESC_HWSEQ_SSN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 7, 1, __val)
 #define SET_TX_DESC_USE_RATE(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 8, 1, __val)
-#define SET_TX_DESC_DISABLE_RTS_FB(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 9, 1, __val)
 #define SET_TX_DESC_DISABLE_FB(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 10, 1, __val)
 #define SET_TX_DESC_CTS2SELF(__pdesc, __val)		\
@@ -206,20 +79,10 @@
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 12, 1, __val)
 #define SET_TX_DESC_HW_RTS_ENABLE(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 13, 1, __val)
-#define SET_TX_DESC_PORT_ID(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 14, 1, __val)
-#define SET_TX_DESC_PWR_STATUS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 15, 3, __val)
-#define SET_TX_DESC_WAIT_DCTS(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 18, 1, __val)
-#define SET_TX_DESC_CTS2AP_EN(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 19, 1, __val)
 #define SET_TX_DESC_TX_SUB_CARRIER(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 20, 2, __val)
 #define SET_TX_DESC_TX_STBC(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 22, 2, __val)
-#define SET_TX_DESC_DATA_SHORT(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+16, 24, 1, __val)
 #define SET_TX_DESC_DATA_BW(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 25, 1, __val)
 #define SET_TX_DESC_RTS_SHORT(__pdesc, __val)		\
@@ -231,152 +94,34 @@
 #define SET_TX_DESC_RTS_STBC(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+16, 30, 2, __val)
 
-#define GET_TX_DESC_RTS_RATE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 0, 5)
-#define GET_TX_DESC_AP_DCFE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 5, 1)
-#define GET_TX_DESC_QOS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 6, 1)
-#define GET_TX_DESC_HWSEQ_EN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 7, 1)
-#define GET_TX_DESC_USE_RATE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 8, 1)
-#define GET_TX_DESC_DISABLE_RTS_FB(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 9, 1)
-#define GET_TX_DESC_DISABLE_FB(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 10, 1)
-#define GET_TX_DESC_CTS2SELF(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 11, 1)
-#define GET_TX_DESC_RTS_ENABLE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 12, 1)
-#define GET_TX_DESC_HW_RTS_ENABLE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 13, 1)
-#define GET_TX_DESC_PORT_ID(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 14, 1)
-#define GET_TX_DESC_WAIT_DCTS(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 18, 1)
-#define GET_TX_DESC_CTS2AP_EN(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 19, 1)
-#define GET_TX_DESC_TX_SUB_CARRIER(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+16, 20, 2)
-#define GET_TX_DESC_TX_STBC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 22, 2)
-#define GET_TX_DESC_DATA_SHORT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 24, 1)
-#define GET_TX_DESC_DATA_BW(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 25, 1)
-#define GET_TX_DESC_RTS_SHORT(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 26, 1)
-#define GET_TX_DESC_RTS_BW(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 27, 1)
-#define GET_TX_DESC_RTS_SC(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+16, 28, 2)
-#define GET_TX_DESC_RTS_STBC(__pdesc)			\
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
-#define GET_TX_DESC_TX_RATE(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 0, 6)
-#define GET_TX_DESC_DATA_SHORTGI(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 6, 1)
-#define GET_TX_DESC_CCX_TAG(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+20, 7, 1)
-#define GET_TX_DESC_DATA_RATE_FB_LIMIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 8, 5)
-#define GET_TX_DESC_RTS_RATE_FB_LIMIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 13, 4)
-#define GET_TX_DESC_RETRY_LIMIT_ENABLE(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 17, 1)
-#define GET_TX_DESC_DATA_RETRY_LIMIT(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+20, 18, 6)
-#define GET_TX_DESC_USB_TXAGG_NUM(__pdesc)		\
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
-#define SET_TX_DESC_MCS7_SGI_MAX_LEN(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+24, 28, 4, __val)
-
-#define GET_TX_DESC_TXAGC_A(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 0, 5)
-#define GET_TX_DESC_TXAGC_B(__pdesc)			\
-	LE_BITS_TO_4BYTE(__pdesc+24, 5, 5)
-#define GET_TX_DESC_USE_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 10, 1)
-#define GET_TX_DESC_MAX_AGG_NUM(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 11, 5)
-#define GET_TX_DESC_MCSG1_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 16, 4)
-#define GET_TX_DESC_MCSG2_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 20, 4)
-#define GET_TX_DESC_MCSG3_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 24, 4)
-#define GET_TX_DESC_MCS7_SGI_MAX_LEN(__pdesc)		\
-	LE_BITS_TO_4BYTE(__pdesc+24, 28, 4)
-
-#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)	\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
-#define SET_TX_DESC_SW_OFFSET30(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 16, 8, __val)
-#define SET_TX_DESC_SW_OFFSET31(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 24, 4, __val)
+
 #define SET_TX_DESC_ANTSEL_C(__pdesc, __val)		\
 	SET_BITS_TO_LE_4BYTE(__pdesc+28, 29, 1, __val)
-#define SET_TX_DESC_NULL_0(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 30, 1, __val)
-#define SET_TX_DESC_NULL_1(__pdesc, __val)		\
-	SET_BITS_TO_LE_4BYTE(__pdesc+28, 30, 1, __val)
 
+#define SET_TX_DESC_TX_BUFFER_SIZE(__pdesc, __val)     \
+	SET_BITS_TO_LE_4BYTE(__pdesc+28, 0, 16, __val)
 #define GET_TX_DESC_TX_BUFFER_SIZE(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc+28, 0, 16)
 
 #define SET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc, __val)	\
 	SET_BITS_TO_LE_4BYTE(__pdesc+32, 0, 32, __val)
-#define SET_TX_DESC_TX_BUFFER_ADDRESS64(__pdesc, __val) \
-	SET_BITS_TO_LE_4BYTE(__pdesc+36, 0, 32, __val)
 
 #define GET_TX_DESC_TX_BUFFER_ADDRESS(__pdesc)		\
 	LE_BITS_TO_4BYTE(__pdesc+32, 0, 32)
-#define GET_TX_DESC_TX_BUFFER_ADDRESS64(__pdesc)	\
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
-- 
2.22.0

