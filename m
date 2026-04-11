Return-Path: <linux-wireless+bounces-34646-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nqzHECv32WncxQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34646-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:24:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEE3DEA96
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 09:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED08B30091D8
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Apr 2026 07:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A93264F5;
	Sat, 11 Apr 2026 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Cr+dIuNM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECC32BF5D
	for <linux-wireless@vger.kernel.org>; Sat, 11 Apr 2026 07:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775892259; cv=none; b=N7zVVphhvlS87qzRY8YJ492PzoHyz00ovfzeM3Md5lo/mJ6887yiStV504A33/gdxJXWV3wocKraBeb10YeOVyIM4Eh2hWloBiBTttyan9WbMZXdYV69SkMH2dCBnxX8quhTo5AvnsdUEQmrbLzGt7Vz85PBWQRA7ZXncWTth8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775892259; c=relaxed/simple;
	bh=+1+yWd1w1iE6BVAqI0K+5H79DdsMtJItzAUysC5lLxc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlsMrpGVMDjxtO8n/5lXWn5g7Q/LMxZg54AysGLmkA0ks45nRikOY/QDZCJqFlNK1T8O4mMLn5RVYhI+lE/730qBem2CHL7LY64TZHbBA9MyeWbWz0W2x6TQAyliQJK6SL0B2arL/McP3DxgSMKmrcS7b1EO+fnsM0YC63LOOlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Cr+dIuNM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 63B7OD6e8164276, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775892253; bh=qhDC4UR17/iWHWRJ3JMBvpZcjm92o1tsWfhBbjzEQ+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Cr+dIuNM09mHfIHPra170cFD66n8jdgufRM2o0S2+ZprwTriYx0aofnXnfQCFmU9i
	 ghjiyDgIOn04qsISjSnSFcK3PW0tIz/e2htmIuzKGqclZkaZ0SfHSFg5MsiU0/oTkS
	 hv4cFUWk5yPZo0BTz0ekWM/h2ShfqNVSn+WcYNpbdyEs/OPM/f3ztfa1Hr0Zd4huzv
	 xO4HKyepTO+W1vLeOhTDWRT/ReyWKXdbesdiDpEAFT2i3zysB1nKiNPUFupoCC3nBy
	 5bmfv7hUbpRMsYUTglT1BhjwF2zYOP2XlCnJVXnUl+Z3GxmCJrF7scb+6kAu3d1FdM
	 W5oh8l9Gy1WNA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 63B7OD6e8164276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 11 Apr 2026 15:24:13 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 11 Apr 2026 15:24:13 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 11 Apr 2026 15:24:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <rtl8821cerfe2@gmail.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw88: add __packed to efuse map and do assertion
Date: Sat, 11 Apr 2026 15:24:12 +0800
Message-ID: <20260411072413.1556575-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34646-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DAEE3DEA96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As arm-linux-gnueabi-gcc compiler align struct field is not always like
gcc on x86 target, the efuse map layout might not be expected. Add __packed
and do assertion to ensure it is expected.

Complied test only with arm-linux-gnueabi-gcc and x86 gcc.

Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8703b.h | 2 ++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 4 +++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h | 4 +++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h | 4 +++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 4 +++-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h | 2 +-
 6 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
index 3e2da2e6739d..e3d709635902 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
@@ -70,6 +70,8 @@ struct phy_status_8703b {
 #endif
 } __packed;
 
+static_assert(sizeof(struct phy_status_8703b) == 28);
+
 /* Baseband registers */
 #define REG_BB_PWR_SAV5_11N 0x0818
 /* BIT(11) should be 1 for 8703B *and* 8723D, which means LNA uses 4
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
index 0fc70dfdfc8b..da674ab7cb78 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -95,9 +95,11 @@ struct rtw8723x_efuse {
 		struct rtw8723xe_efuse e;
 		struct rtw8723xu_efuse u;
 		struct rtw8723xs_efuse s;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8723x_efuse) == 0x120);
+
 #define RTW8723X_IQK_ADDA_REG_NUM	16
 #define RTW8723X_IQK_MAC8_REG_NUM	3
 #define RTW8723X_IQK_MAC32_REG_NUM	1
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index 954e93c8020d..ac9773b6dee5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -101,9 +101,11 @@ struct rtw8821c_efuse {
 		struct rtw8821ce_efuse e;
 		struct rtw8821cu_efuse u;
 		struct rtw8821cs_efuse s;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8821c_efuse) == 0x200);
+
 static inline void
 _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 9fca9ba67c90..656f8830a394 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -103,9 +103,11 @@ struct rtw8822b_efuse {
 		struct rtw8822be_efuse e;
 		struct rtw8822bu_efuse u;
 		struct rtw8822bs_efuse s;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8822b_efuse) == 0x200);
+
 static inline void
 _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index fc62b67a15f2..e1423448c453 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -102,9 +102,11 @@ struct rtw8822c_efuse {
 		struct rtw8822ce_efuse e;
 		struct rtw8822cu_efuse u;
 		struct rtw8822cs_efuse s;
-	};
+	} __packed;
 } __packed;
 
+static_assert(sizeof(struct rtw8822c_efuse) == 0x19a);
+
 enum rtw8822c_dpk_agc_phase {
 	RTW_DPK_GAIN_CHECK,
 	RTW_DPK_GAIN_LARGE,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw88xxa.h b/drivers/net/wireless/realtek/rtw88/rtw88xxa.h
index 09a45c1a4129..1b5297c942d8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw88xxa.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw88xxa.h
@@ -58,7 +58,7 @@ struct rtw88xxa_efuse {
 	union {
 		struct rtw8821au_efuse rtw8821au;
 		struct rtw8812au_efuse rtw8812au;
-	};
+	} __packed;
 } __packed;
 
 static_assert(sizeof(struct rtw88xxa_efuse) == 512);
-- 
2.25.1


