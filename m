Return-Path: <linux-wireless+bounces-6931-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F78B399F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 16:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF431C22EC0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 14:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF011487DF;
	Fri, 26 Apr 2024 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ms9yoBnE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0F42A99
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141183; cv=none; b=nLOrzyZAc2yztdTKMu4xzkgiBM6XNKIQ7GFYMQDncZWz0CxsZo2n+4YFJhGOrgHBxLm1n7fe7b6DwCnq8fd9VJBxh5uU7OJKKdtpdhlwYUjR0ubOD2Ha9gQz3LilmV4ft6ZC9ha+IV1S3kFKa9anfOm1i5hPmdIhaIvGJKU98qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141183; c=relaxed/simple;
	bh=U1yctsxw+RuNXfjL+hS5+IFs4tZTl/e1WrfQdKuPb0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y/hF2Er3naA4aFRN27ekw9uHw3n3rkowK6sdJFypaGX2L0N5dphnxP2b+ykTzPB59P7PBZPP7kl8iXbXLKHfFZXQfAVEVaBDYLf8Ztq5VxVunm73T66mDtqJlIXIFshiyQ1ooaLixseOHM86ZYV+T9nVgMITur18POvhZQhOzvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ms9yoBnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C010AC113CD;
	Fri, 26 Apr 2024 14:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141182;
	bh=U1yctsxw+RuNXfjL+hS5+IFs4tZTl/e1WrfQdKuPb0o=;
	h=From:To:Cc:Subject:Date:From;
	b=ms9yoBnEtqD8yqBN40QdRZFOzOcoshDDEfnRw5iuRO0VznhCllcfpNImRHc+sZ2Hk
	 aDpqvjM9ad4LLp9EGjiZuOrWt6i1NPyB1gA+Ac+PTSisIzMFKAoEUTupRjF9gNkjiv
	 WXul0YlYgCiptobqNsAidxCgmqkf+7mGHSNGbQ9dhE9ofxNpG82BafNmaMQQ8ZOs/6
	 ErXt86zRduRq6fVbi9RCi98HAnSpXW9hy9FX1eoI91H2mpr3ad8URAyXDiodDyLO/O
	 WZn0FrFJ/35nq8gEHGvbqm0/yLGgjieSclddUuC09vlLPKJC+2BELmONYemrcTdPWI
	 918+YyCXxeUTg==
From: Kalle Valo <kvalo@kernel.org>
To: pkshih@realtek.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] wifi: rtl8xxxu: remove some unused includes
Date: Fri, 26 Apr 2024 17:19:38 +0300
Message-Id: <20240426141939.3881678-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed by random that rtl8xxxu includes linux/wireless.h even though it
doesn't need it. While investigating a bit more I found even more unused
include files:

#include <linux/init.h>
#include <linux/sched.h>
#include <linux/ethtool.h>

It looks like that the includes are just copied to every file without checking
if the file really needs the include. So more includes could be removed but
that would need more careful analysis per each file.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c | 4 ----
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 4 ----
 9 files changed, 36 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
index afe9cc1b49dc..43735ca70b7c 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188e.c
@@ -13,9 +13,7 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
index 464216d007ce..9043e548518f 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c
@@ -11,9 +11,7 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -22,8 +20,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
index ddf2d9707338..49eb1d0a6019 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192c.c
@@ -13,9 +13,7 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
index 63b73ace27ec..26132b6b9331 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192e.c
@@ -13,9 +13,7 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
index 21e4204769d0..9f1d4a6ee210 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8192f.c
@@ -11,9 +11,7 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -22,8 +20,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
index 46d57510e9fc..aa27ac4f828b 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8710b.c
@@ -11,9 +11,7 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -22,8 +20,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
index bf8c34af781f..965c8c3662a6 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723a.c
@@ -13,9 +13,7 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
index 6653f43973cf..3355d8e97870 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8723b.c
@@ -13,9 +13,7 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index e72f35a40ab3..54f955b01475 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -13,9 +13,7 @@
  * additional 8xxx chips like the 8192cu, 8188cus, etc.
  */
 
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -24,8 +22,6 @@
 #include <linux/usb.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
-#include <linux/ethtool.h>
-#include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
 #include <net/mac80211.h>

base-commit: 4ea11e4db3550ee655b411b43498552e8c6ead01
-- 
2.39.2


