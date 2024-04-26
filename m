Return-Path: <linux-wireless+bounces-6932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2A8B39A0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D9A1F22AFB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7BD148841;
	Fri, 26 Apr 2024 14:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyfbHN5q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F073914883D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141184; cv=none; b=FiM62C3SuP+Yy+mx2H6jUSEJhX3tIcDjMnZBGySjhGmKi1DIa/NESdDtUTXF8ZXbq2gOd++zntSU6gLtQ7Ch2XMYVVtqX4mZlfwmtnqtpaS7QmcsFcz8Q1ZgbUxzGNIGiATA/Yf4Q4AYLCgAkqOVQyVcLWx5NayH+UoGOjjfIoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141184; c=relaxed/simple;
	bh=E7TBgb6ue82VILbNkgNwb9i+LvaUwjT2HIEcgBsHIiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C896e7DPd0rJv+TNMshM3rOAy1T/O5NbfMJXFTfhdMKY61MbOWResBDL6zufT9HG++49QEVJDDEG05GKQ0hoW7L6XB+/qwMgsqcL1+F1CFMu9gvLPoSTdLry31KlyF+fpVxWhcJQB/7sr6ZRnS68yk39dS2gaYM55StGob1rEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyfbHN5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3DCC116B1;
	Fri, 26 Apr 2024 14:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141183;
	bh=E7TBgb6ue82VILbNkgNwb9i+LvaUwjT2HIEcgBsHIiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyfbHN5q1ATeQW8HXTFk1IuUIB5G/4BVO1999xl8fT8qNO13LGH5cqwyfLDKwLdxw
	 ygzCOvssz/30qgQIsuSk6ZWA2uIW0c2bWY8ikqim6cxi2SxrKp0dV93w8V+U6JLPKw
	 HM1peor5d1AHaaK+S6xeulOuSBv3zkH+S/+RuMCgpDp52zRVTkmY9/U+NaBHdZmRDF
	 vyc4MqINpMRQtst7xxDuciRnpIdnIc+L79b1qgxG9bMeVlhe0vMQUgxcgQK373skNH
	 JtVu7we5nA9jZvO+dB6NBBsPUTqPyMBJG/fyykU3WqyJvcSKWFPUiEQwFh8mnXCmmi
	 my1Mlq0jmgphQ==
From: Kalle Valo <kvalo@kernel.org>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] wifi: rtl8xxxu: remove rtl8xxxu_ prefix from filenames
Date: Fri, 26 Apr 2024 17:19:39 +0300
Message-Id: <20240426141939.3881678-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240426141939.3881678-1-kvalo@kernel.org>
References: <20240426141939.3881678-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver is already in a directory named rtl8xxxu, there's no need to
duplicate that in the filename as well. Now file listing looks a lot more
reasonable:

8188e.c  8192c.c  8192f.c  8723a.c  core.c   Makefile  rtl8xxxu.h
8188f.c  8192e.c  8710b.c  8723b.c  Kconfig  regs.h

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} | 2 +-
 drivers/net/wireless/realtek/rtl8xxxu/Makefile              | 6 +++---
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c}   | 2 +-
 .../wireless/realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h}   | 0
 11 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h} (100%)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8188e.c
index 43735ca70b7c..60fb0bffd4ed 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static const struct rtl8xxxu_reg8val rtl8188e_mac_init_table[] = {
 	{0x026, 0x41}, {0x027, 0x35}, {0x040, 0x00}, {0x421, 0x0f},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8188f.c
index 9043e548518f..296370414134 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
@@ -24,7 +24,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static const struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
 	{0x024, 0xDF}, {0x025, 0x07}, {0x02B, 0x1C}, {0x283, 0x20},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index 49eb1d0a6019..b1c5a9971617 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 static struct rtl8xxxu_power_base rtl8192c_power_base = {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8192e.c
index 26132b6b9331..562173176c60 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static const struct rtl8xxxu_reg8val rtl8192e_mac_init_table[] = {
 	{0x011, 0xeb}, {0x012, 0x07}, {0x014, 0x75}, {0x303, 0xa7},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8192f.c
index 9f1d4a6ee210..843ff0269b39 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
@@ -24,7 +24,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static const struct rtl8xxxu_reg8val rtl8192f_mac_init_table[] = {
 	{0x420, 0x00},	{0x422, 0x78},	{0x428, 0x0a},	{0x429, 0x10},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8710b.c
index aa27ac4f828b..ea1cb0d8554e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
@@ -24,7 +24,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static const struct rtl8xxxu_reg8val rtl8710b_mac_init_table[] = {
 	{0x421, 0x0F}, {0x428, 0x0A}, {0x429, 0x10}, {0x430, 0x00},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8723a.c
index 965c8c3662a6..9f03bf163c97 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static struct rtl8xxxu_power_base rtl8723a_power_base = {
 	.reg_0e00 = 0x0a0c0c0c,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
rename to drivers/net/wireless/realtek/rtl8xxxu/8723b.c
index 3355d8e97870..0880049373b0 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 static const struct rtl8xxxu_reg8val rtl8723b_mac_init_table[] = {
 	{0x02f, 0x30}, {0x035, 0x00}, {0x039, 0x08}, {0x04e, 0xe0},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/Makefile b/drivers/net/wireless/realtek/rtl8xxxu/Makefile
index fa466589eccb..580a2fa675ee 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/Makefile
+++ b/drivers/net/wireless/realtek/rtl8xxxu/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_RTL8XXXU)	+= rtl8xxxu.o
 
-rtl8xxxu-y	:= rtl8xxxu_core.o rtl8xxxu_8192e.o rtl8xxxu_8723b.o \
-		   rtl8xxxu_8723a.o rtl8xxxu_8192c.o rtl8xxxu_8188f.o \
-		   rtl8xxxu_8188e.o rtl8xxxu_8710b.o rtl8xxxu_8192f.o
+rtl8xxxu-y	:= core.o 8192e.o 8723b.o \
+		   8723a.o 8192c.o 8188f.o \
+		   8188e.o 8710b.o 8192f.o
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
similarity index 99%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
rename to drivers/net/wireless/realtek/rtl8xxxu/core.c
index 54f955b01475..cda05a6e4772 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -26,7 +26,7 @@
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
-#include "rtl8xxxu_regs.h"
+#include "regs.h"
 
 #define DRIVER_NAME "rtl8xxxu"
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h b/drivers/net/wireless/realtek/rtl8xxxu/regs.h
similarity index 100%
rename from drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_regs.h
rename to drivers/net/wireless/realtek/rtl8xxxu/regs.h
-- 
2.39.2


