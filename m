Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A91410956C
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfKYWJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:46 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37455 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfKYWJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:46 -0500
Received: by mail-oi1-f196.google.com with SMTP id 128so6628023oih.4
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zndmngqvKcQAJ7LKuNeyPMwsUvc1m5O+/Q/pAcxAWw8=;
        b=YG2TJ6UpwnkaI0TXhxu0lzfDMTdwe+rhNw43IfkFMCgiTEhJWtDden4MSecYDtGfkv
         3sDGecI6X5zGhxVbIMAof8fQYBgg2f2YidyjTVRNVFnfguyV7MvXBdGfHqj6OlO3r2RM
         Lvsy5sWIPN7tQLyN53GolHU5efRcg8U3o9gCcMb+GUddUgCsq0tjIRprJ2Wty6fFikc4
         CdybnfhYFL/BSIMMeh0GPVh5IxRI4ENRDl95a/TV5AZHfdLHV+8x/vtbqCeqrrX4Aglt
         Ud/wI1ltnKmYvA8e/vm5ktnAd4jZjKCbnWWmZqylrqSmxOrH12VNmVZsv9O1uQiUmpuz
         npkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zndmngqvKcQAJ7LKuNeyPMwsUvc1m5O+/Q/pAcxAWw8=;
        b=amw9E2Ad7tIKdKFODSUbzQKHq7KQXtvaLetot/woEBTpJkS8/iqHufsceh2ynFQtZl
         FmvPA9SThzEcGDdSrpTj/U5V0BpeUTLYXhj0ncNBksb1evgepg4RvLxg2fwlZ7gAKYhd
         AFHNKnzBaH8p0w6VrqNambrwW4XqtV4x5x1lGPvMmDq6b9xfHGOMvQjqB5qRHqPq+54i
         mbGVF478ZvfoQq2OrFwBlsvoVtH3Pw5CMLN30h++f6qOSAzQqNDs9aBKfh8lTJVYGWGD
         XVluJbuOSs0+zH8J3QxDe1C0ooQim0v3EqJlz3mKI/kVRoqR13aAt4p7oYz1uh9auX0W
         CTQA==
X-Gm-Message-State: APjAAAVLBgDEEyBsaCk/MqiKuqnhprcJCIRxl1M8SuuVq4l1Rs/FfPZ5
        AZeDsk+pFe9kkBfTASbSZUU=
X-Google-Smtp-Source: APXvYqwzjssCf4NTdgSmnJchzdM+mbEO6FNAww0SoG7r+kpSGwwCBeUBYK3EQL6TaCNWvHj3KvgdmA==
X-Received: by 2002:a05:6808:b2d:: with SMTP id t13mr892351oij.83.1574719785399;
        Mon, 25 Nov 2019 14:09:45 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:45 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 9/9] rtlwifi: Remove last definitions of local bit manipulation macros
Date:   Mon, 25 Nov 2019 16:09:34 -0600
Message-Id: <20191125220934.32693-10-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
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
v2 - no changes
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

