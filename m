Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE04105C67
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKUVz3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37060 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKUVz2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id y194so4677969oie.4
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yo8BxKN5HiE+QmtUj++/9ZBjQBCT+cBaSBsUig/9mb8=;
        b=t9T08uwKajSgducG8fbWb4isAmL1B6//JsB3t2IdkhOAQWLEk/A5yFLJRlt6fNkXzd
         gAC4Cycj29hiMuUvwZDBKB84+J6EnsNjgpz4aKn0mVUSroBYhSTZYnO2x2dTSDb3gRoI
         utAikeMdMwsHcp+eKY3DpM9sejDZGv6MAPBnM6GBvBWaH2snv+vRY02iQa9+/Sn65bAK
         JV8e7KHCGXoN4kK6XXnZ7dEQoq8EV9Hotoco9vImncUfu+ilqwTVcMQNMqur5h1P0O7l
         1QEy+uso+/4nm3IAQSVoKWouaE2qFV2U/gCG8H8V5edNKpTw29u5eYNlBoYsEOu9Wnom
         p31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Yo8BxKN5HiE+QmtUj++/9ZBjQBCT+cBaSBsUig/9mb8=;
        b=ZGy8dtm1T9xPbSVq+3y10Vsfa+KJrYanRIOfqOmDuCQc1w2XneveFsXoAAjk+xpGPU
         khqOlYX5i20RiP5Fz6WWisauzAK+jp0kg80azNFzdEUIViUR+CmIua/AOZfpsyFKyI6/
         oe+4naK7RlprkCm2EvoOM3FeKtEG/acXpahTcYq5N8itK4YZfEtSpk6ICK7xt97w+TKB
         B7oJaQefj5pgkUITMkNuMEZ/NWeRoNu3GubdC1Q8HgCnjy8IodbGyD0/qxO8JvVLA7tl
         36oWICYDzxekvKJV2RlfUK/+gFbhXBynMFCQBa7U3vcToOutX2K8VVxbazumHQKr0g8H
         fapQ==
X-Gm-Message-State: APjAAAUGSLELZL5ej2WZMAOI3u4191sM4tFvdP461sqExilZJMLYYSW1
        mBe6ouzGV81vnauEvNV52IU=
X-Google-Smtp-Source: APXvYqzqFaLcNqZPkrcC+aeHII507FhPt2v5jGXj8ah6JCB54L4uALYcKWaDZ/IpkMED0NOSdGP+ZQ==
X-Received: by 2002:a05:6808:5d9:: with SMTP id d25mr9587638oij.54.1574373326224;
        Thu, 21 Nov 2019 13:55:26 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:25 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 9/9] rtlwifi: Remove last definitions of local bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:14 -0600
Message-Id: <20191121215514.5509-10-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
References: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

All usage of the local macros have been removed, thus the remaining
definitions are deleted.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/net/wireless/realtek/rtlwifi/wifi.h | 115 --------------------
 1 file changed, 115 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/wifi.h b/drivers/net/wireless/realtek/rtlwifi/wifi.h
index 3bdda1c98339..1cff9f07c9e9 100644
--- a/drivers/net/wireless/realtek/rtlwifi/wifi.h
+++ b/drivers/net/wireless/realtek/rtlwifi/wifi.h
@@ -2898,121 +2898,6 @@ enum bt_radio_shared {
  *	2. Before write integer to IO.
  *	3. After read integer from IO.
  ****************************************/
-/* Convert little data endian to host ordering */
-#define EF1BYTE(_val)		\
-	((u8)(_val))
-#define EF2BYTE(_val)		\
-	(le16_to_cpu(_val))
-#define EF4BYTE(_val)		\
-	(le32_to_cpu(_val))
-
-/* Read data from memory */
-#define READEF1BYTE(_ptr)      \
-	EF1BYTE(*((u8 *)(_ptr)))
-/* Read le16 data from memory and convert to host ordering */
-#define READEF2BYTE(_ptr)      \
-	EF2BYTE(*(_ptr))
-#define READEF4BYTE(_ptr)      \
-	EF4BYTE(*(_ptr))
-
-/* Create a bit mask
- * Examples:
- * BIT_LEN_MASK_32(0) => 0x00000000
- * BIT_LEN_MASK_32(1) => 0x00000001
- * BIT_LEN_MASK_32(2) => 0x00000003
- * BIT_LEN_MASK_32(32) => 0xFFFFFFFF
- */
-#define BIT_LEN_MASK_32(__bitlen)	 \
-	(0xFFFFFFFF >> (32 - (__bitlen)))
-#define BIT_LEN_MASK_16(__bitlen)	 \
-	(0xFFFF >> (16 - (__bitlen)))
-#define BIT_LEN_MASK_8(__bitlen) \
-	(0xFF >> (8 - (__bitlen)))
-
-/* Create an offset bit mask
- * Examples:
- * BIT_OFFSET_LEN_MASK_32(0, 2) => 0x00000003
- * BIT_OFFSET_LEN_MASK_32(16, 2) => 0x00030000
- */
-#define BIT_OFFSET_LEN_MASK_32(__bitoffset, __bitlen) \
-	(BIT_LEN_MASK_32(__bitlen) << (__bitoffset))
-#define BIT_OFFSET_LEN_MASK_16(__bitoffset, __bitlen) \
-	(BIT_LEN_MASK_16(__bitlen) << (__bitoffset))
-#define BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen) \
-	(BIT_LEN_MASK_8(__bitlen) << (__bitoffset))
-
-/*Description:
- * Return 4-byte value in host byte ordering from
- * 4-byte pointer in little-endian system.
- */
-#define LE_P4BYTE_TO_HOST_4BYTE(__pstart) \
-	(EF4BYTE(*((__le32 *)(__pstart))))
-#define LE_P2BYTE_TO_HOST_2BYTE(__pstart) \
-	(EF2BYTE(*((__le16 *)(__pstart))))
-#define LE_P1BYTE_TO_HOST_1BYTE(__pstart) \
-	(EF1BYTE(*((u8 *)(__pstart))))
-
-/*Description:
- * Translate subfield (continuous bits in little-endian) of 4-byte
- * value to host byte ordering.
- */
-#define LE_BITS_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		(LE_P4BYTE_TO_HOST_4BYTE(__pstart) >> (__bitoffset))  & \
-		BIT_LEN_MASK_32(__bitlen) \
-	)
-#define LE_BITS_TO_2BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		(LE_P2BYTE_TO_HOST_2BYTE(__pstart) >> (__bitoffset)) & \
-		BIT_LEN_MASK_16(__bitlen) \
-	)
-#define LE_BITS_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		(LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
-		BIT_LEN_MASK_8(__bitlen) \
-	)
-
-/* Description:
- * Mask subfield (continuous bits in little-endian) of 4-byte value
- * and return the result in 4-byte value in host byte ordering.
- */
-#define LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		LE_P4BYTE_TO_HOST_4BYTE(__pstart)  & \
-		(~BIT_OFFSET_LEN_MASK_32(__bitoffset, __bitlen)) \
-	)
-#define LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		LE_P2BYTE_TO_HOST_2BYTE(__pstart) & \
-		(~BIT_OFFSET_LEN_MASK_16(__bitoffset, __bitlen)) \
-	)
-#define LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) \
-	( \
-		LE_P1BYTE_TO_HOST_1BYTE(__pstart) & \
-		(~BIT_OFFSET_LEN_MASK_8(__bitoffset, __bitlen)) \
-	)
-
-/* Description:
- * Set subfield of little-endian 4-byte value to specified value.
- */
-#define SET_BITS_TO_LE_4BYTE(__pstart, __bitoffset, __bitlen, __val) \
-	*((__le32 *)(__pstart)) = \
-	cpu_to_le32( \
-		LE_BITS_CLEARED_TO_4BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u32)__val) & BIT_LEN_MASK_32(__bitlen)) << (__bitoffset)) \
-	)
-#define SET_BITS_TO_LE_2BYTE(__pstart, __bitoffset, __bitlen, __val) \
-	*((__le16 *)(__pstart)) = \
-	cpu_to_le16( \
-		LE_BITS_CLEARED_TO_2BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u16)__val) & BIT_LEN_MASK_16(__bitlen)) << (__bitoffset)) \
-	)
-#define SET_BITS_TO_LE_1BYTE(__pstart, __bitoffset, __bitlen, __val) \
-	*((u8 *)(__pstart)) = EF1BYTE \
-	( \
-		LE_BITS_CLEARED_TO_1BYTE(__pstart, __bitoffset, __bitlen) | \
-		((((u8)__val) & BIT_LEN_MASK_8(__bitlen)) << (__bitoffset)) \
-	)
 
 #define	N_BYTE_ALIGMENT(__value, __aligment) ((__aligment == 1) ? \
 	(__value) : (((__value + __aligment - 1) / __aligment) * __aligment))
-- 
2.24.0

