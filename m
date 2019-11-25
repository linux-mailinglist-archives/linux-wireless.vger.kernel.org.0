Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD8B10956D
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKYWJr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33178 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbfKYWJq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id q23so8246847otn.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PpCknpIvZotVkQLS0sAV5sGPPaP2TGmhc2HgGAauUOc=;
        b=Vo5WkCV+5B/e+KUwTkjfjBLE7rq54Yf3IMVfs3KQm4zkHXuq5o2sIaVD4EOT8jmdjS
         g8NDMRzMOWmQKvnNcE+k3EM7ybEyuw+w/5+aFCUhQ8V31sEUPgJefOhPbHZkP86xOmma
         VCtfJONJ1EuSak2Xjiubrn/OF9IH57qpXkszkSZtO6sOrtrt6HoFiMk+hTiJL3R0yIzX
         Q/ZSdHmsrQH69WXXIRcaM8Bg27ZzBhfmo+TpK5WtQuUjIJBS1RfbvhEwVQl/AoYwXCr7
         ylWeWS+MpnICPSnkXuxS9U+CVELiVuX0xko3Moanl9ATN41SbDUN5n9S9wbovmwsOgJE
         BxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=PpCknpIvZotVkQLS0sAV5sGPPaP2TGmhc2HgGAauUOc=;
        b=BBfwYvLTvSH1Obk6bePKLkK8FkRH7irk0nWeBWwjBpMym9QtCYUeJD4itWDB2rPjYv
         oocmT46TcQe0GVSyjbHsb5r2Hl/1HK5qgcf3rg1Y1ZAcgQ2ggxEV0H3/39j27TA/cXXy
         PF8/WmPEBZ+rYsPTonwnveofbYa2dshce/e1Hr5Dgo7HgsSEwZMuIsou1EicPyKkwEbg
         2NWMpmFyHRdu5V0czFvAtoWklhmvCJyCtuKCZpr/6VNU0W8yfvC5Ge2fn9xbubB9qv93
         x0IHSQkw0JXSaRmcL6FBNMRi2s1LSDg6y3PBtigGANwt7ATwzXfhjATd3+nywWdcr809
         rsZQ==
X-Gm-Message-State: APjAAAWieHgV9DnysZ9Gx2fmiAHSe4Qyy+oRefxkx+PlwOpSI9jnwteE
        5uPj/QYU8Qv8LINqVwlabl7wqPSC
X-Google-Smtp-Source: APXvYqx6hC1wCi+r/cDfqiou+A94QSwbY4YOJvjAKpofuF06ks7zqN/B3l2k42bm0f6dhKcIY0rKIg==
X-Received: by 2002:a9d:413:: with SMTP id 19mr34459otc.11.1574719784701;
        Mon, 25 Nov 2019 14:09:44 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:44 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 8/9] rtlwifi: rtl8723be: Remove usage of private bit manipulation macros
Date:   Mon, 25 Nov 2019 16:09:33 -0600
Message-Id: <20191125220934.32693-9-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
References: <20191125220934.32693-1-Larry.Finger@lwfinger.net>
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
v2 - no changes
---
 .../wireless/realtek/rtlwifi/rtl8723be/fw.h   | 30 +++++++++----------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.h
index 97ea77464139..7c5e5e916274 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/fw.h
@@ -83,37 +83,35 @@ enum rtl8723b_h2c_cmd {
 
 
 #define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_PWRMODE_PARM_RLBM(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 4, __val)
+	u8p_replace_bits(__ph2ccmd + 1, __val, GENMASK(3, 0))
 #define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 4, 4, __val)
+	u8p_replace_bits(__ph2ccmd + 1, __val, GENMASK(7, 4))
 #define SET_H2CCMD_PWRMODE_PARM_AWAKE_INTERVAL(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 #define SET_H2CCMD_PWRMODE_PARM_ALL_QUEUE_UAPSD(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+3, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 3) = __val
 #define SET_H2CCMD_PWRMODE_PARM_PWR_STATE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+4, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 4) = __val
 #define SET_H2CCMD_PWRMODE_PARM_BYTE5(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 5, 0, 8, __val)
-#define GET_88E_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd)			\
-	LE_BITS_TO_1BYTE(__ph2ccmd, 0, 8)
+	*(u8 *)(__ph2ccmd + 5) = __val
 
 #define SET_H2CCMD_MSRRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 1, __val)
+	u8p_replace_bits(__ph2ccmd, __val, BIT(0))
 #define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 1, 1, __val)
+	u8p_replace_bits(__ph2ccmd, __val, BIT(1))
 
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)(__ph2ccmd) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_QOS_NULL_DATA(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 3, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 3) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_BT_QOS_NULL_DATA(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 4, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 4) = __val
 
 
 void rtl8723be_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
-- 
2.24.0

