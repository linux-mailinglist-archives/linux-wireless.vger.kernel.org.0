Return-Path: <linux-wireless+bounces-22325-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75EAA70DD
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 13:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCCE17849D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3381D15C140;
	Fri,  2 May 2025 11:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6Nsxeq9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB0E3D76
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746186581; cv=none; b=iGvag+JaWKwOAOl7+QASmEFqy6gPOVYmUlvBzif9VhHXEEiPCdYSiTtsMzomAsSNialTK84xKtkgbIXTkrt+Cag/zlvMGbjULZlbwsj1Q/ZZkZGYUw+1uT3Y0ybFjzzCb6SjvbzKSE5bNIy6Mz0s6jiGJl2Fjn0yjcHeVn+lJxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746186581; c=relaxed/simple;
	bh=lWeHKGjbx0dl18Rm1pdQxt6/FTjsTOthznB/Oguh9gk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jrq0jK04buAewezOMaaCilzjJPcHCF17J8tYgpvHHuiXzbWgVIa/jzbR3W8NL23sgT+F2tkPZ9ExPQreBG03mlQQ8Oo2TcccA1dicS8PY7kyQ7ByFbqG4I4RL2gNuhT4sGgfvAfEeUJaXJtq9p91LXHpCsrpaqKvtSsyjKLcM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6Nsxeq9; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so2881230a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 02 May 2025 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746186577; x=1746791377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wps79G+1SXv8e6i5kI3fklzLKMUJdykiFW3v72ktH3M=;
        b=C6Nsxeq9g9D43djE/cMRtLXECWMm05X1F5vC8OFhRXNHesMh9tufaFX976vw+h2NEw
         IWxUDjHtBOk9MQKHJ6HzNqJmQiYN+pvOyJTZl6VcnNPZZhxQ0Kclf5lrUvHqm+EDmWcm
         wP+RxWxPMmlI4rBcIBoGbUqQsbeV7xkRhhiSQzk20yA7aFyxL3dj9xzPnJKWMnrEAI2B
         Wm4vivJP5fZBbEa+WRzE0dAghbTwlOTLlQlp85F/VsI7l+82h7rcQo6+IlyQgenb/l6g
         SJDF1rdgKnb15UmQUU7I3blHWZxYjtvoX1woMaZOcHYm3Jit8omvneyiWSIib5tRQzri
         1mEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746186577; x=1746791377;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wps79G+1SXv8e6i5kI3fklzLKMUJdykiFW3v72ktH3M=;
        b=VvpMoDw0A2/9vy+wf1uSWGQ/hDCb5powd+J1qma7suH6V7BGchqjhNDBw3Fl9Wh3Kv
         OSWEJTkrfi9KGrk2JuEHY6pHOVIlnNmwkb+5umTEj5DpUK5xttMOuyk4dWEX/qPq1ga2
         N9goT3Sv3bwrqbXOv44vxHG3FliFAvckjK0ao/foEJ36pBnYq3bD5ZEvXoRrfyj7ziO3
         6vV3Ac6wwsfkSf6PZca3oKsqQoNEk5zXPi3x5B9a9SvEa2vDm+ib2r8+HzBhVruYA2W4
         6krPhURDqmm+5BoEiWTlPpeooUTR6GPfRZNzxXybWh88/Qt2RWIdk4R/6fxTBqZ08pLr
         ptFQ==
X-Gm-Message-State: AOJu0YydV6VTda7CR5DBSS2Fk9Gxt6mfZZFB8rRBcDKn/X27ypADJX5A
	/Vd2BPScTCfrlzPZnsDRJ17E+vtrSPglBtGvBvnrid8XSU5/UZ18nk6sWQ==
X-Gm-Gg: ASbGncsiRK3RagC6JYXucZRhwUQ0jq32iK6L8cwr8we6VybTTqC9Kr3rni/B9LzzVgI
	RIIEMJt2zeysL2W70Py7Xnz2MKLOoRaix8t64TPrLNvkGagSFtqD5ZUfqCCz9o70Fec0nCyc7za
	iUgmscJiciAYXMv/1RfNjvFk+6Tb2g4U4BEl+Dpv/g0OGTVuOSTrRWyjHdIEfsXnHl6Fl01tsKy
	/TcHtU5IenJTWfP4RO1vSjRDGZdvPFcdklTPsjnNqO2bm2d88e9roP9t+mZ0JgN4hUZMDzWhIXm
	Er9WB/Od0U7dYI4m6tIQ6OJB2ey4IaJy5Nv1opEaF6evtEPwwQ==
X-Google-Smtp-Source: AGHT+IHtpqXL5N61PTjDNpi5tgqz68AwEZGcbPz+PLziN6PXk1y7boJw1VxJYmtkX1xjA/6DU83whQ==
X-Received: by 2002:a05:6402:24c4:b0:5fa:964f:b8b4 with SMTP id 4fb4d7f45d1cf-5fa964fbbddmr488942a12.23.1746186577118;
        Fri, 02 May 2025 04:49:37 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.209])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77816ffbsm1090521a12.34.2025.05.02.04.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 04:49:36 -0700 (PDT)
Message-ID: <5734afe7-0870-40b2-acd4-5657a02d7c56@gmail.com>
Date: Fri, 2 May 2025 14:49:34 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 2/2] wifi: rtw88: Handle RTL8723D(S) with blank
 efuse
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
Content-Language: en-US
In-Reply-To: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
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
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - Add Acked-by.
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


