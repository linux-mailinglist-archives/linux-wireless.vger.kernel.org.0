Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 112E9AD1C1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 04:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732726AbfIICAL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 22:00:11 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:39488 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732716AbfIICAK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 22:00:10 -0400
Received: by mail-oi1-f178.google.com with SMTP id w144so9282161oia.6
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2019 19:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZktn4q3v9jQUfx5eLGhVxb0QZXkgVVglvUaLTumkUM=;
        b=rA6n/Mi8CO2n05R3N6Wtc6O7s6ad9Yg/vRP3qII5RcqY3cGBJsj2UkO6yvNz6UfjJo
         k1TJDqxNKYGje3MoELorWwoWfybaIlsdgxG9ZO8sOLEnvCS692uDhRhdo2g31p9PM+w/
         ukK+9d8tKJ72njc6Jf2SeoSeSXGDfPD2ifONmMAO7OKWw4Xf7bPUGisuvHu4HhFiXoot
         BX7Krnor8gIKE9csO1WGbWTOqjJra0awL7zgOmUBuQFEUIeAFONZEQqPSTjvC6jBDbYZ
         ZJPMXUgJ+BPku9VMpDhhOLxY4obecb5JSfGMSqpsV9wlBHkej/Eofw8B9QoKb2rY0ITP
         3yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RZktn4q3v9jQUfx5eLGhVxb0QZXkgVVglvUaLTumkUM=;
        b=AL0A7hg2IIs9rV8MigM+oJE9lQ3peR57g22/UPga5YF3AtTzoHenMQTK23z8TbFdrx
         u6d4zqNQnMFGskyFt0nP/fgXrYZ1IqnCHjODnsdTyZwRXPXMEc+H9J1nfV/0hjY9cjb/
         kpz+F20R8Ira1I5uk8EIj0BEaE0kfTs37UIWXrkacRqxKX1MCgLV9zMj64NiJmsS17et
         4FQK6aeR54EHCIMo5GCw2cHpx41Z9spGXpIgqiawMePjGCCtXjvjsiWIlGoFgRJ5Z4z5
         cflwVA4TQGLqLoZAD/tsLeUvQqiIH2QWAYrFe/eweIhCYvmSegiHdT2Yizh85DwEYob9
         TzOQ==
X-Gm-Message-State: APjAAAX2ycmji/j9JKKFHpw4xc13giTzL83fLvwD6+/0hRBqpmvz3QAz
        Bcwjh4zokQrt29ppLXsufhk=
X-Google-Smtp-Source: APXvYqzYnKKWLV8N1OupgHASR0KSQhE+IMt9VQyAOVBlwWy88LenNlxnVia7DhUXaxeFZu8Jf3q/6g==
X-Received: by 2002:aca:2402:: with SMTP id n2mr11196867oic.32.1567994409223;
        Sun, 08 Sep 2019 19:00:09 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id k10sm1468420oij.16.2019.09.08.19.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 19:00:08 -0700 (PDT)
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, pkshih@realtek.com,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH v2 9/9] rtlwifi: rtl8188ee: rtl8192ce: rtl8192de: rtl8723ae: rtl8821ae: Remove some unused bit manipulation macros
Date:   Sun,  8 Sep 2019 20:59:58 -0500
Message-Id: <20190909015958.29834-10-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
References: <20190909015958.29834-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Each of these drivers defines some device to host macros that are never
used, thus they can be removed.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
v2 - no changes
---
 drivers/net/wireless/realtek/rtlwifi/base.h   | 27 ---------------
 .../wireless/realtek/rtlwifi/rtl8188ee/def.h  | 29 ----------------
 .../wireless/realtek/rtlwifi/rtl8192ce/def.h  | 33 -------------------
 .../wireless/realtek/rtlwifi/rtl8192de/def.h  | 31 -----------------
 .../wireless/realtek/rtlwifi/rtl8723ae/def.h  | 31 -----------------
 .../wireless/realtek/rtlwifi/rtl8821ae/def.h  | 31 -----------------
 6 files changed, 182 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/base.h b/drivers/net/wireless/realtek/rtlwifi/base.h
index 99565ad09cdc..e4a7e074ae3f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/base.h
+++ b/drivers/net/wireless/realtek/rtlwifi/base.h
@@ -46,15 +46,6 @@ enum ap_peer {
 #define MAX_LISTEN_INTERVAL		10
 #define MAX_RATE_TRIES			4
 
-#define SET_80211_HDR_FRAME_CONTROL(_hdr, _val)		\
-	WRITEEF2BYTE(_hdr, _val)
-#define SET_80211_HDR_TYPE_AND_SUBTYPE(_hdr, _val)	\
-	WRITEEF1BYTE(_hdr, _val)
-#define SET_80211_HDR_PWR_MGNT(_hdr, _val)		\
-	SET_BITS_TO_LE_2BYTE(_hdr, 12, 1, _val)
-#define SET_80211_HDR_TO_DS(_hdr, _val)			\
-	SET_BITS_TO_LE_2BYTE(_hdr, 8, 1, _val)
-
 #define SET_80211_PS_POLL_AID(_hdr, _val)		\
 	(*(u16 *)((u8 *)(_hdr) + 2) = _val)
 #define SET_80211_PS_POLL_BSSID(_hdr, _val)		\
@@ -62,30 +53,12 @@ enum ap_peer {
 #define SET_80211_PS_POLL_TA(_hdr, _val)		\
 	ether_addr_copy(((u8 *)(_hdr))+10, (u8 *)(_val))
 
-#define SET_80211_HDR_DURATION(_hdr, _val)	\
-	(*(u16 *)((u8 *)(_hdr) + FRAME_OFFSET_DURATION) = le16_to_cpu(_val))
 #define SET_80211_HDR_ADDRESS1(_hdr, _val)	\
 	CP_MACADDR((u8 *)(_hdr)+FRAME_OFFSET_ADDRESS1, (u8 *)(_val))
 #define SET_80211_HDR_ADDRESS2(_hdr, _val)	\
 	CP_MACADDR((u8 *)(_hdr)+FRAME_OFFSET_ADDRESS2, (u8 *)(_val))
 #define SET_80211_HDR_ADDRESS3(_hdr, _val)	\
 	CP_MACADDR((u8 *)(_hdr)+FRAME_OFFSET_ADDRESS3, (u8 *)(_val))
-#define SET_80211_HDR_FRAGMENT_SEQUENCE(_hdr, _val)  \
-	WRITEEF2BYTE((u8 *)(_hdr)+FRAME_OFFSET_SEQUENCE, _val)
-
-#define SET_BEACON_PROBE_RSP_TIME_STAMP_LOW(__phdr, __val)	\
-	WRITEEF4BYTE(((u8 *)(__phdr)) + 24, __val)
-#define SET_BEACON_PROBE_RSP_TIME_STAMP_HIGH(__phdr, __val) \
-	WRITEEF4BYTE(((u8 *)(__phdr)) + 28, __val)
-#define SET_BEACON_PROBE_RSP_BEACON_INTERVAL(__phdr, __val) \
-	WRITEEF2BYTE(((u8 *)(__phdr)) + 32, __val)
-#define GET_BEACON_PROBE_RSP_CAPABILITY_INFO(__phdr)		\
-	READEF2BYTE(((u8 *)(__phdr)) + 34)
-#define SET_BEACON_PROBE_RSP_CAPABILITY_INFO(__phdr, __val) \
-	WRITEEF2BYTE(((u8 *)(__phdr)) + 34, __val)
-#define MASK_BEACON_PROBE_RSP_CAPABILITY_INFO(__phdr, __val) \
-	SET_BEACON_PROBE_RSP_CAPABILITY_INFO(__phdr, \
-	(GET_BEACON_PROBE_RSP_CAPABILITY_INFO(__phdr) & (~(__val))))
 
 #define SET_TX_DESC_SPE_RPT(__pdesc, __val)			\
 	SET_BITS_TO_LE_4BYTE((__pdesc) + 8, 19, 1, __val)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/def.h
index fa2e1b063f68..edcca42c7464 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/def.h
@@ -12,35 +12,6 @@
 #define RX_CMD_QUEUE					1
 
 #define	C2H_RX_CMD_HDR_LEN				8
-#define	GET_C2H_CMD_CMD_LEN(__prxhdr)			\
-	LE_BITS_TO_4BYTE((__prxhdr), 0, 16)
-#define	GET_C2H_CMD_ELEMENT_ID(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 16, 8)
-#define	GET_C2H_CMD_CMD_SEQ(__prxhdr)			\
-	LE_BITS_TO_4BYTE((__prxhdr), 24, 7)
-#define	GET_C2H_CMD_CONTINUE(__prxhdr)			\
-	LE_BITS_TO_4BYTE((__prxhdr), 31, 1)
-#define	GET_C2H_CMD_CONTENT(__prxhdr)			\
-	((u8 *)(__prxhdr) + C2H_RX_CMD_HDR_LEN)
-
-#define	GET_C2H_CMD_FEEDBACK_ELEMENT_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 0, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_LEN(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 8, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_CMD_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 16, 16)
-#define	GET_C2H_CMD_FEEDBACK_CCX_MAC_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 0, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_VALID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 7, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_RETRY_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 8, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_TOK(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 15, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_QSEL(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 16, 4)
-#define	GET_C2H_CMD_FEEDBACK_CCX_SEQ(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 20, 12)
 
 #define CHIP_BONDING_IDENTIFIER(_value)	(((_value)>>22)&0x3)
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/def.h
index 147bf2407f8f..34486bd3e109 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/def.h
@@ -17,39 +17,6 @@
 #define RX_MPDU_QUEUE					0
 #define RX_CMD_QUEUE					1
 
-#define	C2H_RX_CMD_HDR_LEN				8
-#define	GET_C2H_CMD_CMD_LEN(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 0, 16)
-#define	GET_C2H_CMD_ELEMENT_ID(__prxhdr)	\
-	LE_BITS_TO_4BYTE((__prxhdr), 16, 8)
-#define	GET_C2H_CMD_CMD_SEQ(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 24, 7)
-#define	GET_C2H_CMD_CONTINUE(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 31, 1)
-#define	GET_C2H_CMD_CONTENT(__prxhdr)		\
-	((u8 *)(__prxhdr) + C2H_RX_CMD_HDR_LEN)
-
-#define	GET_C2H_CMD_FEEDBACK_ELEMENT_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 0, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_LEN(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 8, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_CMD_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 16, 16)
-#define	GET_C2H_CMD_FEEDBACK_CCX_MAC_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 0, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_VALID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 7, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_RETRY_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 8, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_TOK(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 15, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_QSEL(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 16, 4)
-#define	GET_C2H_CMD_FEEDBACK_CCX_SEQ(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 20, 12)
-#define GET_RX_STATUS_DESC_BUFF_ADDR(__pdesc)			\
-	SHIFT_AND_MASK_LE(__pdesc + 24, 0, 32)
-
 #define CHIP_VER_B			BIT(4)
 #define CHIP_BONDING_IDENTIFIER(_value) (((_value) >> 22) & 0x3)
 #define CHIP_BONDING_92C_1T2R		0x1
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/def.h
index fa33b05db052..21726d9b4aef 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/def.h
@@ -26,37 +26,6 @@
 #define RX_MPDU_QUEUE					0
 #define RX_CMD_QUEUE					1
 
-#define	C2H_RX_CMD_HDR_LEN				8
-#define	GET_C2H_CMD_CMD_LEN(__prxhdr)			\
-	LE_BITS_TO_4BYTE((__prxhdr), 0, 16)
-#define	GET_C2H_CMD_ELEMENT_ID(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 16, 8)
-#define	GET_C2H_CMD_CMD_SEQ(__prxhdr)			\
-	LE_BITS_TO_4BYTE((__prxhdr), 24, 7)
-#define	GET_C2H_CMD_CONTINUE(__prxhdr)			\
-	LE_BITS_TO_4BYTE((__prxhdr), 31, 1)
-#define	GET_C2H_CMD_CONTENT(__prxhdr)			\
-	((u8 *)(__prxhdr) + C2H_RX_CMD_HDR_LEN)
-
-#define	GET_C2H_CMD_FEEDBACK_ELEMENT_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 0, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_LEN(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 8, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_CMD_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 16, 16)
-#define	GET_C2H_CMD_FEEDBACK_CCX_MAC_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 0, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_VALID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 7, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_RETRY_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 8, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_TOK(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 15, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_QSEL(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 16, 4)
-#define	GET_C2H_CMD_FEEDBACK_CCX_SEQ(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 20, 12)
-
 enum version_8192d {
 	VERSION_TEST_CHIP_88C = 0x0000,
 	VERSION_TEST_CHIP_92C = 0x0020,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/def.h
index 42958df6b5d4..84505a8500c0 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/def.h
@@ -11,37 +11,6 @@
 #define RX_MPDU_QUEUE						0
 #define RX_CMD_QUEUE						1
 
-#define	C2H_RX_CMD_HDR_LEN					8
-#define	GET_C2H_CMD_CMD_LEN(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 0, 16)
-#define	GET_C2H_CMD_ELEMENT_ID(__prxhdr)	\
-	LE_BITS_TO_4BYTE((__prxhdr), 16, 8)
-#define	GET_C2H_CMD_CMD_SEQ(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 24, 7)
-#define	GET_C2H_CMD_CONTINUE(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 31, 1)
-#define	GET_C2H_CMD_CONTENT(__prxhdr)		\
-	((u8 *)(__prxhdr) + C2H_RX_CMD_HDR_LEN)
-
-#define	GET_C2H_CMD_FEEDBACK_ELEMENT_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 0, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_LEN(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 8, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_CMD_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 16, 16)
-#define	GET_C2H_CMD_FEEDBACK_CCX_MAC_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 0, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_VALID(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 7, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_RETRY_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 8, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_TOK(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 15, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_QSEL(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 16, 4)
-#define	GET_C2H_CMD_FEEDBACK_CCX_SEQ(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 20, 12)
-
 #define CHIP_BONDING_IDENTIFIER(_value)	(((_value)>>22)&0x3)
 #define	CHIP_BONDING_92C_1T2R		0x1
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/def.h b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/def.h
index 827bc5f35d2a..235a7965675c 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/def.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/def.h
@@ -107,37 +107,6 @@
 
 #define MAX_RX_DMA_BUFFER_SIZE_8812	0x3E80
 
-#define	C2H_RX_CMD_HDR_LEN					8
-#define	GET_C2H_CMD_CMD_LEN(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 0, 16)
-#define	GET_C2H_CMD_ELEMENT_ID(__prxhdr)	\
-	LE_BITS_TO_4BYTE((__prxhdr), 16, 8)
-#define	GET_C2H_CMD_CMD_SEQ(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 24, 7)
-#define	GET_C2H_CMD_CONTINUE(__prxhdr)		\
-	LE_BITS_TO_4BYTE((__prxhdr), 31, 1)
-#define	GET_C2H_CMD_CONTENT(__prxhdr)		\
-	((u8 *)(__prxhdr) + C2H_RX_CMD_HDR_LEN)
-
-#define	GET_C2H_CMD_FEEDBACK_ELEMENT_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 0, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_LEN(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 8, 8)
-#define	GET_C2H_CMD_FEEDBACK_CCX_CMD_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE((__pcmdfbhdr), 16, 16)
-#define	GET_C2H_CMD_FEEDBACK_CCX_MAC_ID(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 0, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_VALID(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 7, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_RETRY_CNT(__pcmdfbhdr)	\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 8, 5)
-#define	GET_C2H_CMD_FEEDBACK_CCX_TOK(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 15, 1)
-#define	GET_C2H_CMD_FEEDBACK_CCX_QSEL(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 16, 4)
-#define	GET_C2H_CMD_FEEDBACK_CCX_SEQ(__pcmdfbhdr)		\
-	LE_BITS_TO_4BYTE(((__pcmdfbhdr) + 4), 20, 12)
-
 #define CHIP_BONDING_IDENTIFIER(_value)	(((_value)>>22)&0x3)
 
 #define CHIP_8812				BIT(2)
-- 
2.23.0

