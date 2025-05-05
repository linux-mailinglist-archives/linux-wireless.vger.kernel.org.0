Return-Path: <linux-wireless+bounces-22603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B7AAB103
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE771A87686
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 03:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFED28F504;
	Tue,  6 May 2025 00:11:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDAF306CA0
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 23:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746488185; cv=none; b=oyoX71fsXFDiDIhKuKmgrM8siq7I1DS7i407+VHQ4xjtwyKeIt2iiTiCQBdMe8c3dQH7VPaGhma9rjbuD3EQVK2pJWUS3qw3edsgiuTpi4e1ph+OSus5JV6i96uAnTy+xzWv8XFhxLRr7SrgGh/rzhhkCngzc5YI/2T6YJhIt1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746488185; c=relaxed/simple;
	bh=0Nroq+JCc96Fao+23fbORDm97cgjxl4erH3YdVtMC/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7R/0x/r+mAKrwu63v6kXERrzb0KCWGe6IzsuBl/GWZxFWyek5azscKklqwYaKeD9QtfyVQd9zr9JOZXges/8L4J4RN+xMMVfUJDCVRdOeGZPPdR+3WGGyijacMYlzlUle7h/yWEvuKld2PjC46/2XVE3dnvg0+I/t5NYzfXk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4033c89f2aaso2915688b6e.0
        for <linux-wireless@vger.kernel.org>; Mon, 05 May 2025 16:36:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746488182; x=1747092982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3InXEk3eeMPg88Bbl7ExC6WZ6duJi1MWLlEMwziyOo=;
        b=O0CyAJOPgJ8Sp8b9XYjx0CSJzvY1zQMieOB0axQIaP05kc78lrgcvoppqZJzfMwN5j
         WvJVJ/ONUz9CEBTD/H1NBIMigcqq0YxRUvLwgIbo6Tnn9pm+Q+uNQXgJKUUsGUSguF2a
         AUd4oI3wfBwbOXo1LswzXJRF2jCUBbpCmuc7ATq9qfnsxe9orM3zjUjF2Id7jE2Dz2p2
         WHSr8bpsQnrdK4yw+zYUKIWv4tFfyNL+8IxMKxDstFEPQi+RuBw4tEU/BI+yoW79t2el
         PbXtmNVeRiU87oRtlS9AGcu06Ln1dIDQ008o//cooVxcifemS0vcqVFLBu0HCIJcvEMF
         YD2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRz2mz0bJpFwVJ9GFxH8QIo/zjX6VoVsyEEhcuFWt5B3qgHapjMJ04PqoograsTTAtkvkIxe7jQwPc63SCQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YysNyN5/AcLqj1zKPMRAREIqUn/cmwE6ujQhLsllF0bzRvfsOty
	+DUbbvNsV5KfQBLgeNXlokX/OTk3r9CDzvsv8Fl5ObYTfeLx0brDQQEthZXf
X-Gm-Gg: ASbGncuS7txqZfcCmmuV8TQ0K4YMrUx0UydjdomGj6JA4ouqJiHztj0s6VxFpAbH7iN
	Fxszs/nWeE1bfdv/XquFaaAOES3EqMfIjdMA0ZwC9mb9uFyP9CwWVJ6WmkWAEjLN34LAuFO7+MI
	3j29m8CcFBsKxcL7Ca2BoGhdvaF+Rcsh2/9v//Sjmu6rbtjdG1RbM84m3wL9/9fdnlKalolnDcX
	+DscEJ1P0KDDy2ekoSbn7vckATV/Ffm1Cu7AbxNYzyIwHsBNrbCyxFU6AEuOdi29mDcdfH40BuO
	sy2Lws2OO0Sl5nX2Y8xGPI9qrE3YwsmA5+V6QIhpCHKslDx7XWOAnNV0uw==
X-Google-Smtp-Source: AGHT+IF8PocL0oUQHtGFXCQvytLe0iLxExx/tdYg9SuEchZO1ZNOhs9sP6b0x2iq0mY6pE5lKcpEtw==
X-Received: by 2002:a05:6808:3448:b0:403:50e7:83e1 with SMTP id 5614622812f47-40350e78733mr7927204b6e.11.1746488181776;
        Mon, 05 May 2025 16:36:21 -0700 (PDT)
Received: from sean-ThinkPad-T450s.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4033dc83025sm2157543b6e.43.2025.05.05.16.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 16:36:21 -0700 (PDT)
From: sean.wang@kernel.org
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	deren.wu@mediatek.com,
	mingyen.hsieh@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Michael Lo <michael.lo@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7925: extend MCU support for testmode
Date: Mon,  5 May 2025 16:36:17 -0700
Message-Id: <20250505233618.1951021-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Lo <michael.lo@mediatek.com>

Add MCU command and its handling needed for testmode support on
MT7925. This enables low-level chip testing features such as
continuous TX/RX..

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Michael Lo <michael.lo@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  7 +++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  8 ++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 48 ++++++++++++++++---
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 478cd1886736..f93f58eb9bcf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1183,6 +1183,11 @@ enum {
 #define MCU_UNI_CMD(_t)				(__MCU_CMD_FIELD_UNI |			\
 						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							    MCU_UNI_CMD_##_t))
+
+#define MCU_UNI_QUERY(_t)			(__MCU_CMD_FIELD_UNI | __MCU_CMD_FIELD_QUERY | \
+						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
+							    MCU_UNI_CMD_##_t))
+
 #define MCU_CE_CMD(_t)				(__MCU_CMD_FIELD_CE |			\
 						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							   MCU_CE_CMD_##_t))
@@ -1288,11 +1293,13 @@ enum {
 	MCU_UNI_CMD_EFUSE_CTRL = 0x2d,
 	MCU_UNI_CMD_RA = 0x2f,
 	MCU_UNI_CMD_MURU = 0x31,
+	MCU_UNI_CMD_TESTMODE_RX_STAT = 0x32,
 	MCU_UNI_CMD_BF = 0x33,
 	MCU_UNI_CMD_CHANNEL_SWITCH = 0x34,
 	MCU_UNI_CMD_THERMAL = 0x35,
 	MCU_UNI_CMD_VOW = 0x37,
 	MCU_UNI_CMD_FIXED_RATE_TABLE = 0x40,
+	MCU_UNI_CMD_TESTMODE_CTRL = 0x46,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
 	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 286f602623c0..df38009e0036 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3342,6 +3342,14 @@ int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 		if (cmd == MCU_UNI_CMD(HIF_CTRL))
 			uni_txd->option &= ~MCU_CMD_ACK;
 
+		if (mcu_cmd == MCU_UNI_CMD_TESTMODE_CTRL ||
+		    mcu_cmd == MCU_UNI_CMD_TESTMODE_RX_STAT) {
+			if (cmd & __MCU_CMD_FIELD_QUERY)
+				uni_txd->option = 0x2;
+			else
+				uni_txd->option = 0x6;
+		}
+
 		goto exit;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index d55ea59bda7d..aed2a1eceac9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -104,13 +104,6 @@ enum {
 	MT7925_TM_WIFISPECTRUM,
 };
 
-struct mt7925_rftest_cmd {
-	u8 action;
-	u8 rsv[3];
-	__le32 param0;
-	__le32 param1;
-} __packed;
-
 struct mt7925_rftest_evt {
 	__le32 param0;
 	__le32 param1;
@@ -602,6 +595,47 @@ struct roc_acquire_tlv {
 	u8 rsv[3];
 } __packed;
 
+enum ENUM_CMD_TEST_CTRL_ACT {
+	CMD_TEST_CTRL_ACT_SWITCH_MODE = 0,
+	CMD_TEST_CTRL_ACT_SET_AT = 1,
+	CMD_TEST_CTRL_ACT_GET_AT = 2,
+	CMD_TEST_CTRL_ACT_SET_AT_ENG = 3,
+	CMD_TEST_CTRL_ACT_GET_AT_ENG = 4,
+	CMD_TEST_CTRL_ACT_NUM
+};
+
+enum ENUM_CMD_TEST_CTRL_ACT_SWITCH_MODE_OP {
+	CMD_TEST_CTRL_ACT_SWITCH_MODE_NORMAL = 0,
+	CMD_TEST_CTRL_ACT_SWITCH_MODE_RF_TEST = 1,
+	CMD_TEST_CTRL_ACT_SWITCH_MODE_ICAP = 2,
+	CMD_TEST_CTRL_ACT_SWITCH_MODE_NUM
+};
+
+union testmode_data {
+	__le32 op_mode;
+	__le32 channel_freq;
+	u8 rf_at_info[84];
+};
+
+union testmode_evt {
+	__le32 op_mode;
+	__le32 channel_freq;
+	u8 rf_at_info[1024];
+};
+
+struct uni_cmd_testmode_ctrl {
+	u16 tag;
+	u16 length;
+	u8 action;
+	u8 reserved[3];
+	union testmode_data data;
+} __packed;
+
+struct mt7925_rftest_cmd {
+	u8 padding[4];
+	struct uni_cmd_testmode_ctrl ctrl;
+} __packed;
+
 static inline enum connac3_mcu_cipher_type
 mt7925_mcu_get_cipher(int cipher)
 {
-- 
2.25.1


