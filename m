Return-Path: <linux-wireless+bounces-34647-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNaWGkf32WncxQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34647-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:24:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0632A3DEAB3
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AA7F305832E
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 07:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A532ED32;
	Sat, 11 Apr 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qL1HbMvf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7132F764
	for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 07:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892264; cv=none; b=jRdfXIo4tqHQXz2HmLqbFaFG6XvkRkeqjqC1DQbynLDuzQMmDt9A/SQq78Po7lxpHg4+uZPQLj8ahB3I1VlrN8ttbYEtxs+yV7C8IvtW/uU17+tOx4qb7Ewi7afYZ4knd7ArAp70d1Bi3hQN4yQsbtJVXJGP1wa9Hxm6P1LDxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892264; c=relaxed/simple;
	bh=MBlHBqbtZouB0PH8djcVHVKP9rKdRNJFvEp+KWI2ONc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVU1bErJta/+xL7X2SERtJ2lf6O5wR+nF6gsldokYjSSW2Pqvl+Hem42spKK0LGhlnx7VpDljsa8lQKvWdWZn7al0YW6GBSznaoclM32Dd7a0scG+hCGB/jIw4B04lkzQYJbY8v86KDCSp1KQC8H6zXY9QcRw+95z4wUUzX5lwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qL1HbMvf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63B7OIIl8164280, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775892258; bh=2PCBgPT5pqo4rWgqoSfeAkTy10z4P945UkI9MSHdG08=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qL1HbMvfilkQm1GqjJb6QGJmIdydRMnEd83pQ/4yLus9r5rwP13VctcNrpmT175SN
	 yU8MdEFs736Cdj/Gs2R7tVkLzdu4JE68LxkPbpSkCw6vPaG7mIeSczj0iOMSLuodj0
	 RygEzvhCtf6lOMljzmOzrUUHR4a2l3pxncfBG9g5VhOnDwPmateU1bD8+F0ADkAFjG
	 7fowZ4ymj5zmNQwgRuqUbXdnvg29bXNkpsGhGSFbUr/Tk9HkJkJPSxYixSmGz4L/6V
	 Ci5DhGO85w1gcFC1qIHxf64InOWqMb4Ldc7w5HT21fhzrvXTvAySalaqDXTXQnWYo3
	 Vh/0guh8MVTWQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63B7OIIl8164280
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 15:24:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 11 Apr 2026 15:24:19 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 11 Apr 2026 15:24:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 2/2] wifi: rtw89: add __packed to efuse map and do assertion
Date: Sat, 11 Apr 2026 15:24:13 +0800
Message-ID: <20260411072413.1556575-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260411072413.1556575-1-pkshih@realtek.com>
References: <20260411072413.1556575-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34647-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0632A3DEAB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As arm-linux-gnueabi-gcc compiler align struct field is not always like
gcc on x86 target, the efuse map layout might not be expected. Add __packed
and do assertion to ensure it is expected.

Complied test only with arm-linux-gnueabi-gcc and x86 gcc.

Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.h        | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.h        | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852b_common.h | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.h        | 8 +++++---
 drivers/net/wireless/realtek/rtw89/rtw8922a.h        | 2 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h        | 2 ++
 6 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.h b/drivers/net/wireless/realtek/rtw89/rtw8851b.h
index 1a5c52654d8a..5c2e26c04cd9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.h
@@ -13,11 +13,11 @@
 struct rtw8851bu_efuse {
 	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8851be_efuse {
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8851b_tssi_offset {
 	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
@@ -68,9 +68,11 @@ struct rtw8851b_efuse {
 	union {
 		struct rtw8851bu_efuse u;
 		struct rtw8851be_efuse e;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8851b_efuse) == 0x48e);
+
 extern const struct rtw89_chip_info rtw8851b_chip_info;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.h b/drivers/net/wireless/realtek/rtw89/rtw8852a.h
index d6c1acd09238..0d381f6fd182 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.h
@@ -19,11 +19,11 @@ enum rtw8852a_pmac_mode {
 struct rtw8852au_efuse {
 	u8 rsvd[0x38];
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8852ae_efuse {
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8852a_tssi_offset {
 	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
@@ -78,9 +78,11 @@ struct rtw8852a_efuse {
 	union {
 		struct rtw8852au_efuse u;
 		struct rtw8852ae_efuse e;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8852a_efuse) == 0x43e);
+
 struct rtw8852a_bb_pmac_info {
 	u8 en_pmac_tx:1;
 	u8 is_cck:1;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
index 3dce5422f41e..89e936e4b211 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
@@ -20,11 +20,11 @@ enum rtw8852bx_pmac_mode {
 struct rtw8852bx_u_efuse {
 	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8852bx_e_efuse {
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8852bx_tssi_offset {
 	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
@@ -89,9 +89,11 @@ struct rtw8852bx_efuse {
 	union {
 		struct rtw8852bx_u_efuse u;
 		struct rtw8852bx_e_efuse e;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8852bx_efuse) == 0x48e);
+
 struct rtw8852bx_bb_pmac_info {
 	u8 en_pmac_tx:1;
 	u8 is_cck:1;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 8585921ac6c4..49cb6b4b3b7c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -13,11 +13,11 @@
 struct rtw8852c_u_efuse {
 	u8 rsvd[0x88];
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8852c_e_efuse {
 	u8 mac_addr[ETH_ALEN];
-};
+} __packed;
 
 struct rtw8852c_tssi_offset {
 	u8 cck_tssi[TSSI_CCK_CH_GROUP_NUM];
@@ -95,9 +95,11 @@ struct rtw8852c_efuse {
 	union {
 		struct rtw8852c_u_efuse u;
 		struct rtw8852c_e_efuse e;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8852c_efuse) == 0x48e);
+
 extern const struct rtw89_chip_info rtw8852c_chip_info;
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.h b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
index a29cfa5b4291..33c87bcc403c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
@@ -68,6 +68,8 @@ struct rtw8922a_efuse {
 	struct rtw8922a_rx_gain_6g rx_gain_6g_b;
 } __packed;
 
+static_assert(sizeof(struct rtw8922a_efuse) == 0x1b8);
+
 extern const struct rtw89_chip_info rtw8922a_chip_info;
 extern const struct rtw89_chip_variant rtw8922ae_vs_variant;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.h b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
index 22a7d1cc244f..6d0fb01c1216 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
@@ -77,6 +77,8 @@ struct rtw8922d_efuse {
 	struct rtw8922d_rx_gain_6g rx_gain_6g_b_2;
 } __packed;
 
+static_assert(sizeof(struct rtw8922d_efuse) == 0x222);
+
 extern const struct rtw89_chip_info rtw8922d_chip_info;
 extern const struct rtw89_chip_variant rtw8922de_vs_variant;
 
-- 
2.25.1


