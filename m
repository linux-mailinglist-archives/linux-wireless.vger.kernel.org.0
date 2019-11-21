Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE37105C63
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Nov 2019 22:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfKUVzZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Nov 2019 16:55:25 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34882 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKUVzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Nov 2019 16:55:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so4691378oig.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Nov 2019 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYWqtRoGbHBjRZ5K+zvFf6etnkW2tacTcxbYLUm5YIU=;
        b=KLULKyUiBhUOwKX6yFx0U3JUIF3p4JU+qAiiYW8JqSrJE8AKZ9vyY7Rs+vpFAq7YjO
         W9s15kghfHbWWR9vtO52kaNmKWQDJKM7m5IPj+jaT6u+xumY3cldcG4x9UDVjI3wvL2p
         cai9jqcTh4T8fHnpmGfNdtKcGtsl/UjAfs9NQptMRN7Zvcb+MG8LGnOJKXxkZgl0Dz6m
         iaxZqi2Bd9KxEsSO5ecKG5Zuw600PKmxzV98tCKtIFwA/Qml3+HZcDCNZKeCwfOQjg1v
         WIPK6o7I+n7vr/sZVBjGqpejkHdPlsSTXOxuEm6TNetMNbxKNrXroArh7HZaYkEwGf5l
         Zfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IYWqtRoGbHBjRZ5K+zvFf6etnkW2tacTcxbYLUm5YIU=;
        b=IJit0AKmPszoSDfQTZ4rxxZaetmTn2cSjUTXADpYPQ7k1pSrcCCbdEp63VTXyxlUHt
         v87wseSutB04a0AywaNhfEgqZzILnIEADEB1EuqJL2qlqt5j5tpBhYcWWse8pcISw0aT
         vU8al9fEr8uPSmBOIBsMtrwm7+jJIQqKLA4wQH/zG0BVB6BP1n9rNhFVoEcP72zhPqWp
         3Be0DGKzkG8NyrHLpwg7Xx3VOqGndQiio72O7fugl7oga+DcykGT9DFD4YlsYq/SXVRr
         J5bp9fvjXepsSfpOPTGzlR+HfnKsVapMz0YzDXO8DR0SIHslZqOS/ba3JtjsuT2bjKv1
         Z9GA==
X-Gm-Message-State: APjAAAVwGWNruQC/TcWTCFRbl67xx+a8EUR/nvLbBBTzt02bW8OGxdqF
        Vix5DzN/645tu5osX5KyM64=
X-Google-Smtp-Source: APXvYqwVMg73ALWAOFvprSvZsUl4MQj/SdxmsycxJdEMg984tSoTfyPjMGgoliaznaoDM8zQtadj1g==
X-Received: by 2002:aca:40b:: with SMTP id 11mr9950730oie.106.1574373324044;
        Thu, 21 Nov 2019 13:55:24 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id t19sm1448387otr.5.2019.11.21.13.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 13:55:23 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 6/9] rtlwifi: rtl8192ee: Remove usage of private bit manipulation macros
Date:   Thu, 21 Nov 2019 15:55:11 -0600
Message-Id: <20191121215514.5509-7-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8192ee/fw.h   | 36 +++++++++----------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/fw.h
index cbfecea232a3..b88ee5a230c8 100644
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

