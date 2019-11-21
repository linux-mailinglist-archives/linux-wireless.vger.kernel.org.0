Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03883105C66
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKUVz2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40030 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfKUVz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id m15so4383893otq.7
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWXYiOuAM5mD3LS1KWOgZe5dbgB7Jp+QuUey1JKNuA0=;
        b=AB71iIUWrUIvyGwnr/iqt+cVDXCag0E/VJ09LNT4edsJSLNtu3PTsQIV674mbMSx10
         w8kDLSFU8R5BCAWJ0idnrOp4lqxgpOz4In4eGyQ7d2/fa0OBB1bEOo2rEebgbvOkFIDB
         DVzd4En4lU1qt4+y9QL8YV/LeGBzMSvWkNILzAuAl+v+ulbZ7vbFOemEzGR3a07omozc
         RZhSZbHie4UYvjJvgxe8Z+X/Tb46brFj+GoGOfY+WYtNGN6gorL90+5byL7NBWJVUinj
         YkXWalUhe/xhzM3fVw2A/m68etC55tBxEqAd5QAzU/q2iXFbqJRex9DIf5KSjebZJxEx
         9sKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gWXYiOuAM5mD3LS1KWOgZe5dbgB7Jp+QuUey1JKNuA0=;
        b=qg4euVev7Au1Y7djclVSpXRmW3CzKeNw82YdWPWcJRhXIiJTZe3IPZkEfjYcCVdcrC
         S7Y635+ArhP8+tVoTil1zA1E1T6ZlV7Xsscdm0yfabrk994Dct8cHKILPDp3RW15/KZv
         ktAT2JEYsVaZE3JwdpL6YE5Bve/e+pROBrM49wv5ZHBT/KhJwxIaJr9e3HjVVnpypAV5
         iyLy1i/N0VNt60joBCsMc4vpA3U0hFw0qVxB8AmQiK1w/+YEUrPrOtQgfRFrdYCCDuZJ
         +KVUi5TPNlTCdogoq7MWUAqRf5BTI1yD+aMIfTjODsE0JtSx0LSz4yXwu9svIp6alK9T
         voxg==
X-Gm-Message-State: APjAAAVF1OmWPv3rDAsIXj8+bEWq3r2xgp5KUZT9vU6YGP5Oz2kmYwCi
        m678E50pKfUTwSZsSTgR7Ms=
X-Google-Smtp-Source: APXvYqx4oLJV3E/zNjnkj4DswYKUve3Qdxo/uG0pJHTrk+SxAv7WSwj/A+xyfS4ioKnfpYv87qjrkQ==
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr8432258otg.363.1574373324764;
        Thu, 21 Nov 2019 13:55:24 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:24 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 7/9] rtlwifi: rtl8723ae: Remove usage of private bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:12 -0600
Message-Id: <20191121215514.5509-8-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
References: <20191121215514.5509-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Besides the previously changed macros for the RX and TX descriptors.
the local macros are used in other places. These are replaced with
standard bit manipulation macros.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 .../net/wireless/realtek/rtlwifi/rtl8723ae/fw.h    | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h
index 5c843736de8d..d5314d8463c5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/fw.h
@@ -18,19 +18,19 @@
 #define pagenum_128(_len)	(u32)(((_len)>>7) + ((_len)&0x7F ? 1 : 0))
 
 #define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_PWRMODE_PARM_BCN_PASS_TIME(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 #define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 
 void rtl8723e_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
 			   u32 cmd_len, u8 *p_cmdbuffer);
-- 
2.24.0

