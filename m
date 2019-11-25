Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A925109569
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 23:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKYWJo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 17:09:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42157 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfKYWJn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 17:09:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id o12so14655239oic.9
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2019 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=daGE8bq8jlP1FfoE3ZQ5QAEQbjhp0zNJ5M2pPqRAbvY=;
        b=dlmKdUB2fWWtCyHJXdwziUn3lEVj5jQrg6gWIdfI0+bvA4P3xzswLgh+qkoZcpZwWT
         ZGfy2yyqKvid1JH3K5zfm6cJfUZbybtGN1XRaAVn/e4Z178spMJnknuaHgrWGxsdODc0
         mcVXaFd6zZx3PZdc9DvxXKhgcJGIaUxbg47YMFkvgiA1uof14u7cbYcck/kRQG48dvos
         0bLaV8iVh4e0ZWcsSQnz9eE4FdU+XyqzO3ACczc4+K/QC7ULtkyV/zwLxK4ObdUiFS9m
         UnX16tJxn77PjYvP/x0dR4s1s3uDN/Aw2aYAr5L/EZgiHNsQKVHuVzu9mCiwuKMQJscR
         4Qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=daGE8bq8jlP1FfoE3ZQ5QAEQbjhp0zNJ5M2pPqRAbvY=;
        b=Epy6nMSe0Nu8aZwD4SnrCVergkfVMFNorqGre9SNw+2hF3o0qc+KwqclfYXZedVet6
         5CgY7/busaCfRRJjQhDIOmdsSI28yb+TW9dnwXx9eVJu94WrbM0Bev6DFDO5ulEZvLTa
         AcBisIvWDZztzaQMIucyKZ5QmQ7Yk8tsb1GytlY576102+3iNXzPxFFLpDCn1vm8+Ak3
         4Hl43RErYXuwDIKbWJdedVdIQVYGYwO8aN8pi5OGscyGOphGG865i0TecRT/2XkRfqOe
         s79L0Zp1AIeNFRV5AtZqylsbJkvS5S83OrqY3znCnBq1Qop8CjS2e8ClGtEITvdqzNl1
         306Q==
X-Gm-Message-State: APjAAAWX35ii6cf0CvocWPSzI4MRLO9zAKK5Cpg9OL6h0P3HCglaDHey
        d0VxKLIDEtQSKMJXnVpJncM=
X-Google-Smtp-Source: APXvYqzFRHkqy9MUtSFIru10jt9ml911aJLzhmLPF5Y5zy+3FMPjinkE1qwV6kqZLawIQ2Z2cNtpNA==
X-Received: by 2002:aca:f0c1:: with SMTP id o184mr975144oih.2.1574719782227;
        Mon, 25 Nov 2019 14:09:42 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id 94sm2882537otx.3.2019.11.25.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 14:09:41 -0800 (PST)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 5/9] rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros
Date:   Mon, 25 Nov 2019 16:09:30 -0600
Message-Id: <20191125220934.32693-6-Larry.Finger@lwfinger.net>
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
 .../wireless/realtek/rtlwifi/rtl8821ae/fw.h   | 102 ++++++++----------
 1 file changed, 47 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
index e11e496b7277..c269942b3f4a 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/fw.h
@@ -151,123 +151,115 @@ enum rtl8821a_h2c_cmd {
 #define pagenum_128(_len)	(u32)(((_len)>>7) + ((_len)&0x7F ? 1 : 0))
 
 #define SET_8812_H2CCMD_WOWLAN_FUNC_ENABLE(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_8812_H2CCMD_WOWLAN_PATTERN_MATCH_ENABLE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(1))
 #define SET_8812_H2CCMD_WOWLAN_MAGIC_PKT_ENABLE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 2, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(2))
 #define SET_8812_H2CCMD_WOWLAN_UNICAST_PKT_ENABLE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 3, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(3))
 #define SET_8812_H2CCMD_WOWLAN_ALL_PKT_DROP(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 4, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(4))
 #define SET_8812_H2CCMD_WOWLAN_GPIO_ACTIVE(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE(__cmd, 5, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(5))
 #define SET_8812_H2CCMD_WOWLAN_REKEY_WAKE_UP(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 6, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(6))
 #define SET_8812_H2CCMD_WOWLAN_DISCONNECT_WAKE_UP(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 7, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(7))
 #define SET_8812_H2CCMD_WOWLAN_GPIONUM(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd) + 1, 0, 8, __value)
+	*(u8 *)(__cmd + 1) = __value
 #define SET_8812_H2CCMD_WOWLAN_GPIO_DURATION(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd) + 2, 0, 8, __value)
+	*(u8 *)(__cmd + 2) = __value
 
 #define SET_H2CCMD_PWRMODE_PARM_MODE(__ph2ccmd, __val)			\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
+	*(u8 *)__ph2ccmd = __val
 #define SET_H2CCMD_PWRMODE_PARM_RLBM(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 4, __value)
+	u8p_replace_bits(__cmd + 1, __value, GENMASK(3, 0))
 #define SET_H2CCMD_PWRMODE_PARM_SMART_PS(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 4, 4, __value)
+	u8p_replace_bits(__cmd + 1, __value, GENMASK(7, 4))
 #define SET_H2CCMD_PWRMODE_PARM_AWAKE_INTERVAL(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
+	*(u8 *)(__cmd + 2) = __value
 #define SET_H2CCMD_PWRMODE_PARM_ALL_QUEUE_UAPSD(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __value)
+	*(u8 *)(__cmd + 3) = __value
 #define SET_H2CCMD_PWRMODE_PARM_PWR_STATE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+4, 0, 8, __value)
+	*(u8 *)(__cmd + 4) = __value
 #define SET_H2CCMD_PWRMODE_PARM_BYTE5(__cmd, __value)		\
-	SET_BITS_TO_LE_1BYTE((__cmd) + 5, 0, 8, __value)
-#define GET_8821AE_H2CCMD_PWRMODE_PARM_MODE(__cmd)		\
-	LE_BITS_TO_1BYTE(__cmd, 0, 8)
+	*(u8 *)(__cmd + 5) = __value
 
-#define SET_H2CCMD_JOINBSSRPT_PARM_OPMODE(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE(__ph2ccmd, 0, 8, __val)
 #define SET_H2CCMD_RSVDPAGE_LOC_PSPOLL(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+1, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 1) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+2, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 2) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_QOS_NULL_DATA(__ph2ccmd, __val)		\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd)+3, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 3) = __val
 #define SET_H2CCMD_RSVDPAGE_LOC_BT_QOS_NULL_DATA(__ph2ccmd, __val)	\
-	SET_BITS_TO_LE_1BYTE((__ph2ccmd) + 4, 0, 8, __val)
+	*(u8 *)(__ph2ccmd + 4) = __val
 
 /* _MEDIA_STATUS_RPT_PARM_CMD1 */
 #define SET_H2CCMD_MSRRPT_PARM_OPMODE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
+	u8p_replace_bits(__cmd + 1, __value, BIT(0))
 #define SET_H2CCMD_MSRRPT_PARM_MACID_IND(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
-#define SET_H2CCMD_MSRRPT_PARM_MACID(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd+1, 0, 8, __value)
-#define SET_H2CCMD_MSRRPT_PARM_MACID_END(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd+2, 0, 8, __value)
+	u8p_replace_bits(__cmd + 1, __value, BIT(1))
 
 /* AP_OFFLOAD */
 #define SET_H2CCMD_AP_OFFLOAD_ON(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 8, __value)
+	*(u8 *)__cmd = __value
 #define SET_H2CCMD_AP_OFFLOAD_HIDDEN(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
+	*(u8 *)(__cmd + 1) = __value
 #define SET_H2CCMD_AP_OFFLOAD_DENYANY(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
+	*(u8 *)(__cmd + 2) = __value
 #define SET_H2CCMD_AP_OFFLOAD_WAKEUP_EVT_RPT(__cmd, __value) \
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __value)
+	*(u8 *)(__cmd + 3) = __value
 
 /* Keep Alive Control*/
 #define SET_8812_H2CCMD_KEEP_ALIVE_ENABLE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_8812_H2CCMD_KEEP_ALIVE_ACCPEPT_USER_DEFINED(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(1))
 #define SET_8812_H2CCMD_KEEP_ALIVE_PERIOD(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
+	*(u8 *)(__cmd + 1) = __value
 
 /*REMOTE_WAKE_CTRL */
 #define SET_8812_H2CCMD_REMOTE_WAKECTRL_ENABLE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_8812_H2CCMD_REMOTE_WAKE_CTRL_ARP_OFFLOAD_EN(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(1))
 #define SET_8812_H2CCMD_REMOTE_WAKE_CTRL_NDP_OFFLOAD_EN(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE(__cmd, 2, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(2))
 #define SET_8812_H2CCMD_REMOTE_WAKE_CTRL_GTK_OFFLOAD_EN(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE(__cmd, 3, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(3))
 #define SET_8812_H2CCMD_REMOTE_WAKE_CTRL_REALWOWV2_EN(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE(__cmd, 6, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(6))
 
 /* GTK_OFFLOAD */
 #define SET_8812_H2CCMD_AOAC_GLOBAL_INFO_PAIRWISE_ENC_ALG(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 8, __value)
+	*(u8 *)__cmd = __value
 #define SET_8812_H2CCMD_AOAC_GLOBAL_INFO_GROUP_ENC_ALG(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
+	*(u8 *)(__cmd + 1) = __value
 
 /* AOAC_RSVDPAGE_LOC */
 #define SET_8821AE_H2CCMD_AOAC_RSVDPAGE_LOC_REMOTE_WAKE_CTRL_INFO(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd), 0, 8, __value)
+	*(u8 *)__cmd = __value
 #define SET_8821AE_H2CCMD_AOAC_RSVDPAGE_LOC_ARP_RSP(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value)
+	*(u8 *)(__cmd + 1) = __value
 #define SET_8821AE_H2CCMD_AOAC_RSVDPAGE_LOC_NEIGHBOR_ADV(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
+	*(u8 *)(__cmd + 2) = __value
 #define SET_8821AE_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_RSP(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+3, 0, 8, __value)
+	*(u8 *)(__cmd + 3) = __value
 #define SET_8821AE_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_INFO(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+4, 0, 8, __value)
+	*(u8 *)(__cmd + 4) = __value
 #define SET_8821AE_H2CCMD_AOAC_RSVDPAGE_LOC_GTK_EXT_MEM(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE((__cmd)+5, 0, 8, __value)
+	*(u8 *)(__cmd + 5) = __value
 
 /* Disconnect_Decision_Control */
 #define SET_8812_H2CCMD_DISCONNECT_DECISION_CTRL_ENABLE(__cmd, __value)	\
-	SET_BITS_TO_LE_1BYTE(__cmd, 0, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(0))
 #define SET_8812_H2CCMD_DISCONNECT_DECISION_CTRL_USER_SETTING(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE(__cmd, 1, 1, __value)
+	u8p_replace_bits(__cmd, __value, BIT(1))
 #define SET_8812_H2CCMD_DISCONNECT_DECISION_CTRL_CHECK_PERIOD(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE((__cmd)+1, 0, 8, __value) /* unit: beacon period */
+	*(u8 *)(__cmd + 1) = __value
 #define SET_8812_H2CCMD_DISCONNECT_DECISION_CTRL_TRYPKT_NUM(__cmd, __value)\
-	SET_BITS_TO_LE_1BYTE((__cmd)+2, 0, 8, __value)
+	*(u8 *)(__cmd + 2) = __value
 
 int rtl8821ae_download_fw(struct ieee80211_hw *hw, bool buse_wake_on_wlan_fw);
 #if (USE_SPECIFIC_FW_TO_SUPPORT_WOWLAN == 1)
-- 
2.24.0

