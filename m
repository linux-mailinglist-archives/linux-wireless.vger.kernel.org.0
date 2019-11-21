Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76744105C64
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKUVz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:27 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41273 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKUVz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:26 -0500
Received: by mail-oi1-f194.google.com with SMTP id e9so4651524oif.8
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZdBH+ZuiTxY/YOVmDlMrY4wEmt29/BFi8I978FZWDM=;
        b=hw84xO2Kuhy5mgtrv0Y5ZgpeGic0ReIy2XlGUYEHFkAk/H50gYoPV30nVL8LUSV0sm
         x0FSppyBluZN8DwxpuhiOVgFyQwGQsTNBmyBvl1xgsYEL8xGwYaovE2VaF9FwOYkUtGd
         P6Sbgv0GL5Mr/K0zNCQTd3Z3luF9O9IKWef/OlQBjQvIYqffn0EjqbwzAvJkU6vo0DNN
         0E6tz3HdGV4x+3/j58GJ/6TcwlTwzn9stNrnbcQOa/kBRkFpM5oavla0pS8/DiFKugMC
         N2hXeYnAgqwVxCrmnAFJhmP9LRVL7n6oOl5fZuzAN7eNgJYvScFyKFsVYujdINmZ3p7h
         pidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kZdBH+ZuiTxY/YOVmDlMrY4wEmt29/BFi8I978FZWDM=;
        b=coi9ojSkjK+Yn54DljpO0HIfM/4egdryHPpCqnwmkTIItqvqxSC9Bm/wkvXeFr1kAV
         OR55IFnH1dOXYS/afANnVQE+1Jog54yhExOP/0TRYVoZQ75svN/KvPz5GOs631fVrsiL
         5rIuku6rloEOifoq43CJD5HXXRhOBUVC6z6pwSRjP1Blk1dwg4bY+8fkrxJGC+Z8KfAc
         7jnPzFAKdWM8QFJEUqSMcVPo5WXLJ7VLXnmKlZjPIRDtiF5C7U35Vcz11CbZYHD/8SiI
         0uxpaBOWXtvV0CXtTsr64gsR0sgSxh5GMs4zuiLEu+63MDmozXfdhszOjfebwWxV1fsu
         itdA==
X-Gm-Message-State: APjAAAU9q8vdYr+R7P4KKDthDikq2EFzGMGYolhmmU4tz/SJkfef6SGp
        zd+g08bpfinxSKsQXS/vbL8=
X-Google-Smtp-Source: APXvYqw0v2yayIVJI9Jp5YMI81ZgbK+bbJkOTAVy2b/F7Nlogkvn8q6Ax1M1Lh7PSqd//7/hJI5kiw==
X-Received: by 2002:aca:c4d3:: with SMTP id u202mr9679176oif.59.1574373325453;
        Thu, 21 Nov 2019 13:55:25 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:25 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 8/9] rtlwifi: rtl8723be: Remove usage of private bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:13 -0600
Message-Id: <20191121215514.5509-9-Larry.Finger@lwfinger.net>
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

