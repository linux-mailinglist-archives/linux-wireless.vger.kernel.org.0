Return-Path: <linux-wireless+bounces-22157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F851A9FC2F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 23:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A6B87A939E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B453513D893;
	Mon, 28 Apr 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml7vGUlk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AEA94A
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745875682; cv=none; b=FYXxFVgctECYsGn+GJsj4HU4hybNcsSc5pfvS5UjfU4oqvY8n/n29wPuZKNhHkqhCMO8FkyIVS1iTLLRXc/7+EeiyKPU8dPM6iBvxneLSsfjD+4vvSe+wHc2E1XMAGQX7mIve2xKGGsBa8TwcQeIP5lwr+jhhitmFiKocTZbVOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745875682; c=relaxed/simple;
	bh=imPXhxSEPRuS+vfJ+y6uKg2ULBWLUVhpLbhj1YkNnwU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jgp82ZW+NDfZgC0L2UaoNFJef1918UzWXU9sJ/szS0Oha5S4rIeV/C6lYsIwGui69wbxLIjnDL2o/H+A+UyuyOkDtP3LLJGoCjNJGcY6ZgUmH52xi7Oc97y8UN63qsV4luOZKzcolD3iZ1kVJWHshZcPnhJgfr1gV+xMYuDL9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ml7vGUlk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-acacb8743a7so890285166b.1
        for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745875679; x=1746480479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jVkCMv1eD7FVeryh1IIo8oZx1E/4TyaJzTTCFXtCCkU=;
        b=ml7vGUlkjXTHKQzzo5FR4Ki17Es7ONfMA3PGB3h12nwZIa5bn13CMLE0I+t36RnMKT
         abzOgu7pizKuwPwZlGaDErrtlPS9JBTrpmjcmmkJ+isu2tgFufev4+U8PKYakbzDHt0e
         ayxB4IstWP6zutiGwx6iQoiBS8lC1NevS/vIjDnCXn2xPuzyf1uQKtWLph6oeT4ycI89
         7aJzNXQuN72bobcLclL7BeMWjesTmph1asA9NU9fYM1lEPMHwnaHunDQxu8qzC/O4u+2
         8id13OIZ+RVIOZdODHq8jlwc/R5OMw+OqWTox3/kIfnjpVFN/o1pbjxcLKM1eYmPqAsF
         mPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745875679; x=1746480479;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jVkCMv1eD7FVeryh1IIo8oZx1E/4TyaJzTTCFXtCCkU=;
        b=paHz2cJTRQ6ehNLBZI9gj4JEGKeBag2Mw8XLLgPh/g3kAeEs52pjstpurO4/rawgC6
         32/oYsn1bmUC+yugXUPFHTsu5P4C93bZtvpsdw2EWkcqFNnlIxior7VEOdpMwmLCyxy3
         WtEgek0ndeGBZfTaDrRUarVQ3PUAypGIiOU9TwARfaH7agOnAtt/OK8c/+XCif4lpHXc
         ZfzoJPE69Y4ZCChBsPYCtRY36FEdTCPWzhMVUXn5GSCWuXG0xRBsmevuzzwmdHg2BbDN
         f7kJmQAPFlDEerdWHwWPF9GpeX9/mbuighQqoNWJwiE8rDaPQeMvF3+ZoSfYViGdlM4b
         Ic5A==
X-Gm-Message-State: AOJu0Yx69UmVxZAdu3BMdoy3uJHfqyEEtsbBHV9Aj7X4sspJfu6shJtN
	zTjMCPkwuZ1zg4c/7vlVJANz/KiNJBaRSb0iqyr9ac+KYmuyc9soXDZfJA==
X-Gm-Gg: ASbGncvzVePI4ok+Z2s7/Beyyk5BkdUpyoM6EiZK8L+OtjmXxW9s2S+j0RxCChBbmHF
	0BppjeoKtn/FZ4Fv9cyJIplvdUugBWzwj+dyyK42zl/y4/33M15J84cfSjLsde2ABUSgK6LXAKN
	ldCwF3olXnGf9R3x0vlSVpXkLkJCH2FruTwgDWuee90nBWnlCEx32o3Zq8yYx0x7jLEzKMUc3rC
	mAC1XUhQWtR9vi/yLTV33g8CNBeI/LUuDkR8utFSzdSWqLE7g8IRK7yq9zaK5caqXiuhRku4DPm
	xbCXIv6kjjuY5m3q0iyO9MGSvYV4DmxWsIpRDi9EfgE5hpYIyw==
X-Google-Smtp-Source: AGHT+IF9IIkqrpmJbD3963S6nBzSyoQYDV7DbzpsdgBry9PtGbpugZPefFSekhPYeFvmunic4ZmP/Q==
X-Received: by 2002:a17:907:9713:b0:ac7:3929:25f9 with SMTP id a640c23a62f3a-acec6cb5241mr51867766b.29.1745875678637;
        Mon, 28 Apr 2025 14:27:58 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e587093sm679036366b.80.2025.04.28.14.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 14:27:58 -0700 (PDT)
Message-ID: <43cedb70-64ae-4126-820d-a55b038e3ab2@gmail.com>
Date: Tue, 29 Apr 2025 00:27:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next 2/2] wifi: rtw88: Handle RTL8723D(S) with blank efuse
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
Content-Language: en-US
In-Reply-To: <24dacc36-cfc2-475a-8bc5-aad04cd97aa3@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Some users have RTL8723DS chips with nearly blank efuse. Currently these
chips cannot connect when using rtw88, but they do work using the old
out-of-tree driver.

Use reasonable default values for TX power, antenna configuration, and
crystal cap if the chip's efuse is missing these things.

RTL8723D can use the same default values as RTL8703B, so simply move
the code from rtl8703b_read_efuse() to the shared function
__rtl8723x_read_efuse().

Link: https://github.com/lwfinger/rtw88/issues/157
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 60 -------------------
 drivers/net/wireless/realtek/rtw88/rtw8723x.c | 59 ++++++++++++++++++
 2 files changed, 59 insertions(+), 60 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index 5e59cfe4dfdf..9e6700c43a63 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -519,15 +519,6 @@ static const struct rtw_rqpn rqpn_table_8703b[] = {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };
 
-/* Default power index table for RTL8703B, used if EFUSE does not
- * contain valid data. Replaces EFUSE data from offset 0x10 (start of
- * txpwr_idx_table).
- */
-static const u8 rtw8703b_txpwr_idx_table[] = {
-	0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D,
-	0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x02
-};
-
 static void try_mac_from_devicetree(struct rtw_dev *rtwdev)
 {
 	struct device_node *node = rtwdev->dev->of_node;
@@ -544,15 +535,9 @@ static void try_mac_from_devicetree(struct rtw_dev *rtwdev)
 	}
 }
 
-#define DBG_EFUSE_FIX(rtwdev, name)					\
-	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "Fixed invalid EFUSE value: "	\
-		# name "=0x%x\n", rtwdev->efuse.name)
-
 static int rtw8703b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
-	u8 *pwr = (u8 *)efuse->txpwr_idx_table;
-	bool valid = false;
 	int ret;
 
 	ret = rtw8723x_read_efuse(rtwdev, log_map);
@@ -562,51 +547,6 @@ static int rtw8703b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 	if (!is_valid_ether_addr(efuse->addr))
 		try_mac_from_devicetree(rtwdev);
 
-	/* If TX power index table in EFUSE is invalid, fall back to
-	 * built-in table.
-	 */
-	for (int i = 0; i < ARRAY_SIZE(rtw8703b_txpwr_idx_table); i++)
-		if (pwr[i] != 0xff) {
-			valid = true;
-			break;
-		}
-	if (!valid) {
-		for (int i = 0; i < ARRAY_SIZE(rtw8703b_txpwr_idx_table); i++)
-			pwr[i] = rtw8703b_txpwr_idx_table[i];
-		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
-			"Replaced invalid EFUSE TX power index table.");
-		rtw8723x_debug_txpwr_limit(rtwdev,
-					   efuse->txpwr_idx_table, 2);
-	}
-
-	/* Override invalid antenna settings. */
-	if (efuse->bt_setting == 0xff) {
-		/* shared antenna */
-		efuse->bt_setting |= BIT(0);
-		/* RF path A */
-		efuse->bt_setting &= ~BIT(6);
-		DBG_EFUSE_FIX(rtwdev, bt_setting);
-	}
-
-	/* Override invalid board options: The coex code incorrectly
-	 * assumes that if bits 6 & 7 are set the board doesn't
-	 * support coex. Regd is also derived from rf_board_option and
-	 * should be 0 if there's no valid data.
-	 */
-	if (efuse->rf_board_option == 0xff) {
-		efuse->regd = 0;
-		efuse->rf_board_option &= GENMASK(5, 0);
-		DBG_EFUSE_FIX(rtwdev, rf_board_option);
-	}
-
-	/* Override invalid crystal cap setting, default comes from
-	 * vendor driver. Chip specific.
-	 */
-	if (efuse->crystal_cap == 0xff) {
-		efuse->crystal_cap = 0x20;
-		DBG_EFUSE_FIX(rtwdev, crystal_cap);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
index 69f73cb5b4cd..4c77963fdd37 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -69,6 +69,9 @@ static void __rtw8723x_lck(struct rtw_dev *rtwdev)
 #define DBG_EFUSE_2BYTE(rtwdev, map, name)			\
 	rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=0x%02x%02x\n",	\
 		(map)->name[0], (map)->name[1])
+#define DBG_EFUSE_FIX(rtwdev, name)					\
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "Fixed invalid EFUSE value: "	\
+		# name "=0x%x\n", rtwdev->efuse.name)
 
 static void rtw8723xe_efuse_debug(struct rtw_dev *rtwdev,
 				  struct rtw8723x_efuse *map)
@@ -238,10 +241,21 @@ static void rtw8723xs_efuse_parsing(struct rtw_efuse *efuse,
 	ether_addr_copy(efuse->addr, map->s.mac_addr);
 }
 
+/* Default power index table for RTL8703B/RTL8723D, used if EFUSE does
+ * not contain valid data. Replaces EFUSE data from offset 0x10 (start
+ * of txpwr_idx_table).
+ */
+static const u8 rtw8723x_txpwr_idx_table[] = {
+	0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D,
+	0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x02
+};
+
 static int __rtw8723x_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 {
 	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 *pwr = (u8 *)efuse->txpwr_idx_table;
 	struct rtw8723x_efuse *map;
+	bool valid = false;
 	int i;
 
 	map = (struct rtw8723x_efuse *)log_map;
@@ -279,6 +293,51 @@ static int __rtw8723x_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 		return -EOPNOTSUPP;
 	}
 
+	/* If TX power index table in EFUSE is invalid, fall back to
+	 * built-in table.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rtw8723x_txpwr_idx_table); i++)
+		if (pwr[i] != 0xff) {
+			valid = true;
+			break;
+		}
+	if (!valid) {
+		for (i = 0; i < ARRAY_SIZE(rtw8723x_txpwr_idx_table); i++)
+			pwr[i] = rtw8723x_txpwr_idx_table[i];
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"Replaced invalid EFUSE TX power index table.");
+		rtw8723x_debug_txpwr_limit(rtwdev,
+					   efuse->txpwr_idx_table, 2);
+	}
+
+	/* Override invalid antenna settings. */
+	if (efuse->bt_setting == 0xff) {
+		/* shared antenna */
+		efuse->bt_setting |= BIT(0);
+		/* RF path A */
+		efuse->bt_setting &= ~BIT(6);
+		DBG_EFUSE_FIX(rtwdev, bt_setting);
+	}
+
+	/* Override invalid board options: The coex code incorrectly
+	 * assumes that if bits 6 & 7 are set the board doesn't
+	 * support coex. Regd is also derived from rf_board_option and
+	 * should be 0 if there's no valid data.
+	 */
+	if (efuse->rf_board_option == 0xff) {
+		efuse->regd = 0;
+		efuse->rf_board_option &= GENMASK(5, 0);
+		DBG_EFUSE_FIX(rtwdev, rf_board_option);
+	}
+
+	/* Override invalid crystal cap setting, default comes from
+	 * vendor driver. Chip specific.
+	 */
+	if (efuse->crystal_cap == 0xff) {
+		efuse->crystal_cap = 0x20;
+		DBG_EFUSE_FIX(rtwdev, crystal_cap);
+	}
+
 	return 0;
 }
 
-- 
2.49.0


