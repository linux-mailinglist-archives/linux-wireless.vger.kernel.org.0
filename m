Return-Path: <linux-wireless+bounces-38743-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JOEqAH/FTGrspQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38743-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:23:11 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D40719B27
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 11:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=PgFJVTFu;
	dmarc=pass (policy=none) header.from=realtek.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38743-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38743-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46F8A31B550E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 09:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A102A330675;
	Tue,  7 Jul 2026 09:13:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753E2F8EA5
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 09:13:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415595; cv=none; b=JWd1TeATCAGHFnq7eNjgfrkIZDUUVZWf+hc1XUtI5C316p1ww++O20mkLM+OgmlQ9cDDa4LPEv5s6iTOIPdr3udnHrvwzGwKMcYb4eadaF648pFM67KzgOQOvHw7p2MU1nr+0sP5WhHR6cRyP1zYtLavmhptrK7GMGKZq8PrJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415595; c=relaxed/simple;
	bh=0bgoam3F2uYNpvxMVe86f1iBTgwYBWGNc5tG3BAR9o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caarge4jE7wKIDoFbBaXD3aeNqK5AVF5jOtGZRe6NAadLsAyZzSlqUYJydusdA5TNAZEb1Ka95rmmP40pSm/NRB3yftauzRT64A9kNURo/VrRfHSwb/qPJCzCEj8wrTilY9rjFnhvhIEyhd6tkDR8B4eWGuCdQ/vXVkQKmihmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PgFJVTFu; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6679DBPC01359887, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1783415592; bh=hU+/8tt6+DaPNYFL8rji6h/7FsITMZF7uRatisSnnFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PgFJVTFuaE/qUTZkHJsjhjOJfP2JD/tvBGl2UylbR9t4kAiKGeojioEhZqCCf3D+W
	 HqrzH0PbA5ZQErew4nbuF6y0Iu0yBFK1a/NOP9/HPVu7WUMzreFXNAu9Uya/LGn447
	 Xda3T155ngh4PgQJRCXUgImco85T/QNZh1xJqUWY9Jc5dhP8EEOvlcaELHKFRIMbLC
	 FX6XxlwEGd4mamFumt2gjZzEKZEgxb+WR0sAM6jWTR4li3rSUIiKOFvalr9UV/TRxO
	 tQRx5f0zYHYY6spC18ym6JGG+hE2RGWURah15IEuY9ncIzpqSnyBLlT6t9JWG7dqEW
	 ue+luD8ehsynQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6679DBPC01359887
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Tue, 7 Jul 2026 17:13:12 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:13:12 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 7 Jul 2026 17:13:11 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Jul 2026 17:13:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>
Subject: [PATCH rtw-next 15/15] wifi: rtw89: set needed firmware elements for early chips transition
Date: Tue, 7 Jul 2026 17:10:56 +0800
Message-ID: <20260707091056.42771-16-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260707091056.42771-1-pkshih@realtek.com>
References: <20260707091056.42771-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38743-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:gary.chang@realtek.com,m:echuang@realtek.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[realtek.com:from_mime,realtek.com:email,realtek.com:mid,realtek.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gitlab.com:url];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50D40719B27

The early chips including RTL8852A, RTL8851B, RTL8852B and RTL8852C have
driver built-in tables, which are not preferred. New firmware is prepared
with corresponding tables in firmware elements, so we can start to
transition. After this patch, old firmware is still usable, but add a
prompt text for users to update firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 10 +++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 27 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  3 ++-
 6 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9d98805835d6..6b293611d5a8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1562,6 +1562,7 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 	u32 unrecognized_elements = chip->needed_fw_elms;
 	const struct rtw89_fw_element_handler *handler;
 	const struct rtw89_fw_element_hdr *hdr;
+	bool transition;
 	u32 elm_size;
 	u32 elem_id;
 	u32 offset;
@@ -1569,6 +1570,9 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 
 	BUILD_BUG_ON(sizeof(chip->needed_fw_elms) * 8 < RTW89_FW_ELEMENT_ID_NUM);
 
+	transition = !!((chip->needed_fw_elms & BIT(__RTW89_FW_ELEMENT_ID_INTL_TRANSITION)));
+	unrecognized_elements &= ~BIT(__RTW89_FW_ELEMENT_ID_INTL_TRANSITION);
+
 	offset = rtw89_mfw_get_size(rtwdev);
 	offset = ALIGN(offset, RTW89_FW_ELEMENT_ALIGN);
 	if (offset == 0)
@@ -1608,6 +1612,12 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev)
 	}
 
 	if (unrecognized_elements) {
+		if (transition) {
+			rtw89_info(rtwdev, "NOTE: This firmware is going to be obsolete!\n"
+				   "Please download the latest firmware from https://gitlab.com/kernel-firmware/linux-firmware.git\n");
+			return 0;
+		}
+
 		rtw89_err(rtwdev, "Firmware elements 0x%08x are unrecognized\n",
 			  unrecognized_elements);
 		return -ENOENT;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 71e8554a7af7..e4c81b893780 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4346,31 +4346,50 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_DIAG_MAC = 28,
 	RTW89_FW_ELEMENT_ID_TX_COMP = 29,
 
+	__RTW89_FW_ELEMENT_ID_INTL_TRANSITION,
 	RTW89_FW_ELEMENT_ID_NUM,
 };
 
+#define BITS_OF_RTW89_TXPWR_FW_ELEMENTS_TX_SHAPE \
+	(BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU))
+
 #define BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ \
 	(BIT(RTW89_FW_ELEMENT_ID_TXPWR_BYRATE) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_2GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_5GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_5GHZ) | \
-	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT) | \
-	 BIT(RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT_RU))
+	 BITS_OF_RTW89_TXPWR_FW_ELEMENTS_TX_SHAPE)
 
 #define BITS_OF_RTW89_TXPWR_FW_ELEMENTS \
 	(BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_6GHZ) | \
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_6GHZ))
 
-#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ \
+#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_BASE \
 	(BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
 	 BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
 	 BIT(RTW89_FW_ELEMENT_ID_RADIO_B) | \
 	 BIT(RTW89_FW_ELEMENT_ID_RF_NCTL) | \
-	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK))
+
+#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ \
+	(RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_BASE | \
 	 BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ)
 
+#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS \
+	(RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_BASE | \
+	 BITS_OF_RTW89_TXPWR_FW_ELEMENTS)
+
+#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_RTL8852A \
+	(RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ & \
+	 ~BITS_OF_RTW89_TXPWR_FW_ELEMENTS_TX_SHAPE)
+
+#define RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_RTL8851B \
+	(RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ & \
+	 ~BIT(RTW89_FW_ELEMENT_ID_RADIO_B))
+
 #define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS_BASE \
 	(BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
 	 BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d0c262c3dffe..818cf82861d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2637,7 +2637,8 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
-	.needed_fw_elms		= 0,
+	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_RTL8851B |
+				  BIT(__RTW89_FW_ELEMENT_ID_INTL_TRANSITION),
 	.fw_blacklist		= NULL,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 61b6b76c5bdb..08821af48f02 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2374,7 +2374,8 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
-	.needed_fw_elms		= 0,
+	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_RTL8852A |
+				  BIT(__RTW89_FW_ELEMENT_ID_INTL_TRANSITION),
 	.fw_blacklist		= NULL,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index a8638024b54a..5904127cc836 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -968,7 +968,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
-	.needed_fw_elms		= 0,
+	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ |
+				  BIT(__RTW89_FW_ELEMENT_ID_INTL_TRANSITION),
 	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 52986b982ecd..35cbb59b3e56 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3173,7 +3173,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
-	.needed_fw_elms		= 0,
+	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS |
+				  BIT(__RTW89_FW_ELEMENT_ID_INTL_TRANSITION),
 	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
-- 
2.25.1


