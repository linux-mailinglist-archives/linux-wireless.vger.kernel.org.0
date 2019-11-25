Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C97C10956E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKYWJq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:46 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33173 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfKYWJn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:43 -0500
Received: by mail-ot1-f65.google.com with SMTP id q23so8246771otn.0
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibaGTZObojD65qD0yRXFbym4byo5JaeaY1/fpUA9S5c=;
        b=u5TwmpR1/uUXWGJjftRmyfDUkqUOyRxUZi4x1vtGElA/zpt3TVLm9udL4R1O/iylfH
         RD+Zh4Yiz3PUbNiuTW+CzwS7rOHOlz07s5tSx/ii6WH/ot2yIAwPUvcBujsTfeWdBGU/
         yRELyQ+4L7QVkUmSvuhpECvg9L++VYlRH6Y3uqSTs427QPr/WnT26zaLErvX2Y2fCdhc
         BTpt26T/Cpyr5XeFnx/F5Eoo5B2vZNywFporZU9Mt3x2ZPgmNRFPZ/DUXslXTHp5IIgE
         hmVUwYCjMVr3VhN6ALRD5d5sedBhSw/5KWxWK6gze1mQjFhGn6L7k6+aE5zgLkXRmteh
         4skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ibaGTZObojD65qD0yRXFbym4byo5JaeaY1/fpUA9S5c=;
        b=T+O7Qv+sH2U2fZL7sqRE84YplPjzv3j1caz1CUxUx7dWbwAEfUvB6zsQSTrUuBEmDG
         6DyJI9A27Zi50XVE9YWmngiL1jP6HNHiWnHayhbFBnz3UA5BAdhs1iovpXY1QI2WTWLm
         ZqAhEPOtK9hPE1WgyzcShGs27hUu/r/ACLiNGhbjSqkNfGk1nHFwfMBy6nWaia2jYwHa
         sQ3opT2/fVjFe8ej+yNRTD8Cua54EPAgOVdjd09zBQc5/VINMUY00td5qKQzzxrQfiw3
         JQbum2+UEUWWvy76BKe8LwYMaNwXY9OhE+jyhaFsYkXWTbC8xon9MeHI6x/ZhySJ7OcF
         ahTA==
X-Gm-Message-State: APjAAAUYpxNQf6okYwksLQ4/p9wlGjLYf9Jyhr5mYfPwC39pImR5y5P1
        m9zTeIxam0qWg6/lTPm9+IIvBNGf
X-Google-Smtp-Source: APXvYqyyxAHKcpo2sxD/E8CJtCMau9ILGMd+UKtBDmwPS89iL1f3Zu0uwGeWzfQVueRt3x1sNFpJJA==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr4763633ote.100.1574719782990;
        Mon, 25 Nov 2019 14:09:42 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:42 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 6/9] rtlwifi: rtl8192ee: Remove usage of private bit manipulation macros
Date:   Mon, 25 Nov 2019 16:09:31 -0600
Message-Id: <20191125220934.32693-7-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192ee/fw.h   | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.h
index cbfecea232a3..27ac4f8b9a9b 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.h
@@ -111,44 +111,40 @@ enum rtl8192e_h2c_cmd {
 	(u32)(((_len) >> 7) + ((_len) & 0x7F ? 1 : 0))
 
 #define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val;
 #define SET_H2CCMD_PWRMODE_PARM_RLBM(__cmd, __val)			\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 4, __val)
+	u8p_replace_bits(__cmd + 1, __val, GENMASK(3, 0))
 #define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 4, 4, __val)
+	u8p_replace_bits(__cmd + 1, __val, GENMASK(7, 4))
 #define SET_H2CCMD_PWRMODE_PARM_AWAKE_INTERVAL(__cmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __val)
+	*(u8 *)(__cmd + 2) = __val;
 #define SET_H2CCMD_PWRMODE_PARM_ALL_QUEUE_UAPSD(__cmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __val)
+	*(u8 *)(__cmd + 3) = __val;
 #define SET_H2CCMD_PWRMODE_PARM_PWR_STATE(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+4, 0, 8, __val)
+	*(u8 *)(__cmd + 4) = __val;
 #define SET_H2CCMD_PWRMODE_PARM_BYTE5(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__cmd) + 5, 0, 8, __val)
-#define GET_92E_H2CCMD_PWRMODE_PARM_MODE(__cmd)			\
-	LE_BITS_TO_1BYTE(__cmd, 0, 8)
+	*(u8 *)(__cmd + 5) = __val;
 
-#define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
 #define SET_H2CCMD_RSVDPAGE_LOC_PROBE_RSP(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_QOS_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 3, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 3) = __val;
 #define SET_H2CCMD_RSVDPAGE_LOC_BT_QOS_NULL_DATA(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 4, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 4) = __val;
 
 /* _MEDIA_STATUS_RPT_PARM_CMD1 */
 #define SET_H2CCMD_MSRRPT_PARM_OPMODE(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __val)
+	u8p_replace_bits(__cmd, __val, BIT(0))
 #define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __val)
+	u8p_replace_bits(__cmd, __val, BIT(1))
 #define SET_H2CCMD_MSRRPT_PARM_MACID(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__cmd+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val;
 #define SET_H2CCMD_MSRRPT_PARM_MACID_END(__cmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__cmd+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val;
 
 int rtl92ee_download_fw(struct ieee80211_hw *hw, bool buse_wake_on_wlan_fw);
 void rtl92ee_fill_h2c_cmd(struct ieee80211_hw *hw, u8 element_id,
-- 
2.24.0

