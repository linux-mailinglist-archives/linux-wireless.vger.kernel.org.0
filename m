Return-Path: <linux-wireless+bounces-6957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA088B4F84
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 04:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0221F20978
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 02:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2179F5;
	Mon, 29 Apr 2024 02:47:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DFAC147
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714358857; cv=none; b=UldgyAccs2AtBDPDrrhWHEDG0q1Rxq/tWI0UFPf8nKySUAW9jASFAosj/SHv5hfIqm3i/NgbdTb0IxANZdDl5ze42EG4f/Sl3gEgVKnGh4/medqXRYb9q6bpVdY+7BXagULu7QzyjwvssrWMKOZdLrPeW7PyHcCZdOM3u5GA5jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714358857; c=relaxed/simple;
	bh=5xlFTz3JGd4LQyG9sG3EK0OWsVd6Mf8Q22RkQMjIa2Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SrYkgZTEE7EYHKBL6+SAnqrAbIkkt3dfB2YhXKwskR+Ds/juVU2qrpXVh360YmFnDLJd74t19Z/QhGHwKrrwbzszWO0gY011IKOw2Tms0DK8qNo51Jw5ufb1psMGpIfjBo+n+GPcp+wiww8O/Yh9M83NSgJizJjqdln+N/VXfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43T2lP5w92980175, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43T2lP5w92980175
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 10:47:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 10:47:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 29 Apr
 2024 10:47:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <Jes.Sorensen@gmail.com>, <linux-wireless@vger.kernel.org>
CC: <kvalo@kernel.org>
Subject: [PATCH] wifi: rtl8xxxu: cleanup includes
Date: Mon, 29 Apr 2024 10:47:11 +0800
Message-ID: <20240429024711.30992-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Remove unnecessary includes from driver. The first step is to add
necessary includes to driver's header files to make them can be included
individually. Then, driver's C files include driver's header files first,
and check if still missed header files of kernel.

The results show that most C files only include driver's header files.
Only core.c needs to include additional linux/firmware.h.

Also sort includes in alphabetic order.

Compile tested only.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c    | 14 +-------------
 drivers/net/wireless/realtek/rtl8xxxu/core.c     | 13 +------------
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h |  3 ++-
 10 files changed, 11 insertions(+), 117 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
index 60fb0bffd4ed..3d04df0f5bf4 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188e.c
@@ -13,20 +13,8 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static const struct rtl8xxxu_reg8val rtl8188e_mac_init_table[] = {
 	{0x026, 0x41}, {0x027, 0x35}, {0x040, 0x00}, {0x421, 0x0f},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
index 296370414134..bd5a0603b4a2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8188f.c
@@ -11,20 +11,8 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static const struct rtl8xxxu_reg8val rtl8188f_mac_init_table[] = {
 	{0x024, 0xDF}, {0x025, 0x07}, {0x02B, 0x1C}, {0x283, 0x20},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
index b1c5a9971617..0abb1b092bc2 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192c.c
@@ -13,20 +13,8 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 #ifdef CONFIG_RTL8XXXU_UNTESTED
 static struct rtl8xxxu_power_base rtl8192c_power_base = {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
index 562173176c60..8e123bbfc665 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192e.c
@@ -13,20 +13,8 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static const struct rtl8xxxu_reg8val rtl8192e_mac_init_table[] = {
 	{0x011, 0xeb}, {0x012, 0x07}, {0x014, 0x75}, {0x303, 0xa7},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
index 843ff0269b39..cd2156b7a57a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8192f.c
@@ -11,20 +11,8 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static const struct rtl8xxxu_reg8val rtl8192f_mac_init_table[] = {
 	{0x420, 0x00},	{0x422, 0x78},	{0x428, 0x0a},	{0x429, 0x10},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
index ea1cb0d8554e..11c63c320eae 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8710b.c
@@ -11,20 +11,8 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static const struct rtl8xxxu_reg8val rtl8710b_mac_init_table[] = {
 	{0x421, 0x0F}, {0x428, 0x0A}, {0x429, 0x10}, {0x430, 0x00},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
index 9f03bf163c97..ecbc324e4609 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723a.c
@@ -13,20 +13,8 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static struct rtl8xxxu_power_base rtl8723a_power_base = {
 	.reg_0e00 = 0x0a0c0c0c,
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
index 0880049373b0..cc2e60b06f64 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/8723b.c
@@ -13,20 +13,8 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 static const struct rtl8xxxu_reg8val rtl8723b_mac_init_table[] = {
 	{0x02f, 0x30}, {0x035, 0x00}, {0x039, 0x08}, {0x04e, 0xe0},
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c b/drivers/net/wireless/realtek/rtl8xxxu/core.c
index cda05a6e4772..89a841b4e8d5 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
@@ -13,20 +13,9 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <linux/list.h>
-#include <linux/usb.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
 #include <linux/firmware.h>
-#include <linux/moduleparam.h>
-#include <net/mac80211.h>
-#include "rtl8xxxu.h"
 #include "regs.h"
+#include "rtl8xxxu.h"
 
 #define DRIVER_NAME "rtl8xxxu"
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index c28ff9dde625..f42463e595cc 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -5,8 +5,9 @@
  * Register definitions taken from original Realtek rtl8723au driver
  */
 
-#include <asm/byteorder.h>
 #include <linux/average.h>
+#include <linux/usb.h>
+#include <net/mac80211.h>
 
 #define RTL8XXXU_DEBUG_REG_WRITE	0x01
 #define RTL8XXXU_DEBUG_REG_READ		0x02
-- 
2.25.1


