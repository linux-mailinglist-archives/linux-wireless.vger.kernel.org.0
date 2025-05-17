Return-Path: <linux-wireless+bounces-23114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C032ABAB36
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F74A01CD
	for <lists+linux-wireless@lfdr.de>; Sat, 17 May 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8391C861D;
	Sat, 17 May 2025 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="JzQt8HLE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C062A2080C0;
	Sat, 17 May 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747500480; cv=none; b=h9E3xTT+vjF0eX3s8dcI7PZEt9v6EwtD8zQ48otqrouiNjSvxWubxmUB7HKOwn+ZaCjjBmbbWB+BkXRWOYTVDFIpmAmr2BF6ljenht2zEc7KktXs6xbbn9zfFQH4JvAhLT7eHJ/sj5UU/LWZez1+Q7qGCTwxWEfvDSb6XtKbQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747500480; c=relaxed/simple;
	bh=TUfEitpwGQtIb9FitiVNjjcJ8mpMpdDJHCUQZry/pg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YtrvY4G9DipVJA+vwuUWCgY0ipwx54EtrVEpL6SNs5ftvTdyin2X4yQZ5jkt2k7o3ql0JdJWuW1OJ1KbmaHUEXPrQAdVVdZF37mQBI2hLlACTJ2NSsib/YOTdQWrOPfKhbJIQf/CMgGPI4JSiVenyG8mGJ65hXd8tx1naSMV6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=JzQt8HLE; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id GKgEuHQFVtQ77GKgFuyFUx; Sat, 17 May 2025 18:46:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1747500397;
	bh=PBLzTSNdamBB3F6UDQpiKWrnuo7rHKSDvlmWCD3+ld8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=JzQt8HLEm6e9TjxJFJ/qOjbM9KtvJuPxh45YOQSo40ho4N8NhAsl9nI+c9S5ogVpM
	 /n1gQb3q8mcgJLlEKi+M6sAHWxqghh1WRwkC43e69OL6PUqatqOW4E1BfL7oBx+eYU
	 +Qus3Hae2PXFYm1GRXxJvq5dPaRDDAUonIH3aZSv1Bknei2EBCLNb8StO6+lieb/Eq
	 YosVptEfMBgT4vq1/QlqLNe/NVq+j2sxN9ZT7oMCHLsCwhJSldlu66931abVWrq/PJ
	 g8goM+I1eLI7L56kRogItlnZT/timhYWKoSWV60tzYomtsqKaDmou60Ynok8NEPIEU
	 Hzqcvl5kzM6mQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 17 May 2025 18:46:37 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: rtlwifi: Constify struct rtl_hal_ops and rtl_hal_cfg
Date: Sat, 17 May 2025 18:46:14 +0200
Message-ID: <2c3f3d8d8b2f7dcb8cc64cebe89e55720d1d733d.1747500351.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct rtl_hal_ops' and 'struct rtl_hal_cfg' are not modified in these
drivers.

Constifying this structure moves some data to a read-only section, so
increase overall security, especially when the structure holds some
function pointers.

Constification of rtl_hal_cfg is only needed in rtl8192cu/sw.c

On a x86_64, with allmodconfig, as an example:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  10167	   5512	    128	  15807	   3dbf	drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  10743	   4936	    128	  15807	   3dbf	drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.
---
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c | 4 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c | 2 +-
 9 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
index 2ad4523d1bef..79c6e0901e57 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/sw.c
@@ -190,7 +190,7 @@ static bool rtl88e_get_btc_status(void)
 	return false;
 }
 
-static struct rtl_hal_ops rtl8188ee_hal_ops = {
+static const struct rtl_hal_ops rtl8188ee_hal_ops = {
 	.init_sw_vars = rtl88e_init_sw_vars,
 	.deinit_sw_vars = rtl88e_deinit_sw_vars,
 	.read_eeprom_info = rtl88ee_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
index ce7c28d9c874..f06b159f975d 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/sw.c
@@ -167,7 +167,7 @@ static void rtl92c_deinit_sw_vars(struct ieee80211_hw *hw)
 	}
 }
 
-static struct rtl_hal_ops rtl8192ce_hal_ops = {
+static const struct rtl_hal_ops rtl8192ce_hal_ops = {
 	.init_sw_vars = rtl92c_init_sw_vars,
 	.deinit_sw_vars = rtl92c_deinit_sw_vars,
 	.read_eeprom_info = rtl92ce_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
index c9b9e2bc90cc..00a6778df704 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/sw.c
@@ -81,7 +81,7 @@ static bool rtl92cu_get_btc_status(void)
 	return false;
 }
 
-static struct rtl_hal_ops rtl8192cu_hal_ops = {
+static const struct rtl_hal_ops rtl8192cu_hal_ops = {
 	.init_sw_vars = rtl92cu_init_sw_vars,
 	.deinit_sw_vars = rtl92cu_deinit_sw_vars,
 	.read_chip_version = rtl92c_read_chip_version,
@@ -156,7 +156,7 @@ static struct rtl_hal_usbint_cfg rtl92cu_interface_cfg = {
 	.usb_mq_to_hwq = rtl8192cu_mq_to_hwq,
 };
 
-static struct rtl_hal_cfg rtl92cu_hal_cfg = {
+static const struct rtl_hal_cfg rtl92cu_hal_cfg = {
 	.name = "rtl92c_usb",
 	.alt_fw_name = "rtlwifi/rtl8192cufw.bin",
 	.ops = &rtl8192cu_hal_ops,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
index e36e4aeb9a95..7612c22a9842 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/sw.c
@@ -184,7 +184,7 @@ static void rtl92d_deinit_sw_vars(struct ieee80211_hw *hw)
 		skb_queue_purge(&rtlpriv->mac80211.skb_waitq[tid]);
 }
 
-static struct rtl_hal_ops rtl8192de_hal_ops = {
+static const struct rtl_hal_ops rtl8192de_hal_ops = {
 	.init_sw_vars = rtl92d_init_sw_vars,
 	.deinit_sw_vars = rtl92d_deinit_sw_vars,
 	.read_eeprom_info = rtl92d_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
index 162e734d5b08..181dd7823b26 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192ee/sw.c
@@ -176,7 +176,7 @@ static bool rtl92ee_get_btc_status(void)
 	return true;
 }
 
-static struct rtl_hal_ops rtl8192ee_hal_ops = {
+static const struct rtl_hal_ops rtl8192ee_hal_ops = {
 	.init_sw_vars = rtl92ee_init_sw_vars,
 	.deinit_sw_vars = rtl92ee_deinit_sw_vars,
 	.read_eeprom_info = rtl92ee_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
index e63c67b1861b..1cf801feb45e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/sw.c
@@ -221,7 +221,7 @@ static bool rtl92se_is_tx_desc_closed(struct ieee80211_hw *hw, u8 hw_queue,
 	return true;
 }
 
-static struct rtl_hal_ops rtl8192se_hal_ops = {
+static const struct rtl_hal_ops rtl8192se_hal_ops = {
 	.init_sw_vars = rtl92s_init_sw_vars,
 	.deinit_sw_vars = rtl92s_deinit_sw_vars,
 	.read_eeprom_info = rtl92se_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
index 048744166a92..dcd7cdb96aa4 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/sw.c
@@ -183,7 +183,7 @@ static bool is_fw_header(struct rtlwifi_firmware_header *hdr)
 	return (le16_to_cpu(hdr->signature) & 0xfff0) == 0x2300;
 }
 
-static struct rtl_hal_ops rtl8723e_hal_ops = {
+static const struct rtl_hal_ops rtl8723e_hal_ops = {
 	.init_sw_vars = rtl8723e_init_sw_vars,
 	.deinit_sw_vars = rtl8723e_deinit_sw_vars,
 	.read_eeprom_info = rtl8723e_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
index 0a92d0325098..5967df08e34e 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723be/sw.c
@@ -187,7 +187,7 @@ static bool is_fw_header(struct rtlwifi_firmware_header *hdr)
 	return (le16_to_cpu(hdr->signature) & 0xfff0) == 0x5300;
 }
 
-static struct rtl_hal_ops rtl8723be_hal_ops = {
+static const struct rtl_hal_ops rtl8723be_hal_ops = {
 	.init_sw_vars = rtl8723be_init_sw_vars,
 	.deinit_sw_vars = rtl8723be_deinit_sw_vars,
 	.read_eeprom_info = rtl8723be_read_eeprom_info,
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
index b5266e560416..1557d32efdd2 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/sw.c
@@ -229,7 +229,7 @@ static bool rtl8821ae_get_btc_status(void)
 	return true;
 }
 
-static struct rtl_hal_ops rtl8821ae_hal_ops = {
+static const struct rtl_hal_ops rtl8821ae_hal_ops = {
 	.init_sw_vars = rtl8821ae_init_sw_vars,
 	.deinit_sw_vars = rtl8821ae_deinit_sw_vars,
 	.read_eeprom_info = rtl8821ae_read_eeprom_info,
-- 
2.49.0


