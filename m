Return-Path: <linux-wireless+bounces-27352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED1B7D5BF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C17383A46DD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8C128725B;
	Tue, 16 Sep 2025 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="lDz/mLt+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E4288AD
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061180; cv=none; b=U0Mvt/uvkaeMj0l8/3ZosLgRC9/4EgzzOBZPUPCfHXBzMEx+H/11CFT3SkAbgvdscF5OIWmJ7u5ZRfJmEk/SfwhVDBESLahV/b7NNe9xIzWosirqs0V91wdT7KOe2vsrLrq4isD+vnqVrDBJCOAQPvl73adoDDpJJIzH6VnQVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061180; c=relaxed/simple;
	bh=8/+G9E0cTtbr/12fAzkkEQlz3NBucEpWQwactby8X/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VAIWv12H0xIR92riir3WIvMikqcM0F8+IRJEker9mcyXABsxlin3B3Y93IVmH+9KDJqEkS/V1u/mqAZP57DBRYXFleAC3vHOnX8HlBbIc4r+Am++j9rb3oJbS5OKehAhbr3WNF+8MAIk0cCXY99d2HWnqFgqKXHgTwoKk9YIfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=lDz/mLt+; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061179; x=1789597179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8/+G9E0cTtbr/12fAzkkEQlz3NBucEpWQwactby8X/c=;
  b=lDz/mLt+21DTJChVOiaOKTYNxXQ1G1PsMHfL0lfkERXxYWfyPaw9apIE
   SxKasewCugdR9s8ikOwp3/MANbQArux0D5Wto9hYccFUuUU43AfUuSwhb
   fbkpWjQXTkZJ4TN9czFktmW2WjJQdChY0xCSmB4vOWTHEiweAuWtH/X9H
   A=;
X-CSE-ConnectionGUID: clGIv2TdQNe5gSeSqE4OhQ==
X-CSE-MsgGUID: dOu+d3/lT4uTDURbkNrlHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918093"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918093"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:19:36 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:19:35 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:19:33 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 05/57] wifi: inffmac: introduce a new driver directory for infineon WLAN vendor
Date: Wed, 17 Sep 2025 03:47:20 +0530
Message-ID: <20250916221821.4387-6-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE805.infineon.com (172.23.29.31) To
 MUCSE827.infineon.com (172.23.29.20)

Update the wireless driver common Kconfig and Makefile to include the
new WLAN vendor directory for Infineon(Cypress).

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/Kconfig           |  1 +
 drivers/net/wireless/Makefile          |  1 +
 drivers/net/wireless/infineon/Kconfig  | 36 ++++++++++++++++++++++++++
 drivers/net/wireless/infineon/Makefile | 12 +++++++++
 4 files changed, 50 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/Kconfig
 create mode 100644 drivers/net/wireless/infineon/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index c6599594dc99..c85c085741db 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -22,6 +22,7 @@ source "drivers/net/wireless/admtek/Kconfig"
 source "drivers/net/wireless/ath/Kconfig"
 source "drivers/net/wireless/atmel/Kconfig"
 source "drivers/net/wireless/broadcom/Kconfig"
+source "drivers/net/wireless/infineon/Kconfig"
 source "drivers/net/wireless/intel/Kconfig"
 source "drivers/net/wireless/intersil/Kconfig"
 source "drivers/net/wireless/marvell/Kconfig"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index e1c4141c6004..c934578aefe8 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_WLAN_VENDOR_ADMTEK) += admtek/
 obj-$(CONFIG_WLAN_VENDOR_ATH) += ath/
 obj-$(CONFIG_WLAN_VENDOR_ATMEL) += atmel/
 obj-$(CONFIG_WLAN_VENDOR_BROADCOM) += broadcom/
+obj-$(CONFIG_WLAN_VENDOR_INFINEON) += infineon/
 obj-$(CONFIG_WLAN_VENDOR_INTEL) += intel/
 obj-$(CONFIG_WLAN_VENDOR_INTERSIL) += intersil/
 obj-$(CONFIG_WLAN_VENDOR_MARVELL) += marvell/
diff --git a/drivers/net/wireless/infineon/Kconfig b/drivers/net/wireless/infineon/Kconfig
new file mode 100644
index 000000000000..f2d56d15a741
--- /dev/null
+++ b/drivers/net/wireless/infineon/Kconfig
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: ISC
+
+config WLAN_VENDOR_INFINEON
+       bool "Infineon devices"
+       default y
+       help
+         If you have a wireless card belonging to this class, say Y.
+
+         Note that the answer to this question doesn't directly affect the
+         kernel: saying N will just cause the configurator to skip all the
+         questions about these cards. If you say Y, you will be asked for
+         your specific card in the following questions.
+
+if WLAN_VENDOR_INFINEON
+
+source "drivers/net/wireless/infineon/inffmac/Kconfig"
+
+config INF_TRACING
+	bool "Infineon device tracing"
+	depends on INFFMAC
+	help
+	  If you say Y here, the Infineon wireless drivers will register
+	  with ftrace to dump event information into the trace ringbuffer.
+	  Tracing can be enabled at runtime to aid in debugging wireless
+	  issues. This option adds a small amount of overhead when tracing
+	  is disabled. If unsure, say Y to allow developers to better help
+	  you when wireless problems occur.
+
+config INF_DEBUG
+	bool "Infineon driver debug functions"
+	depends on INFFMAC
+	select WANT_DEV_COREDUMP
+	help
+	  Selecting this enables additional code for debug purposes.
+
+endif # WLAN_VENDOR_INFINEON
diff --git a/drivers/net/wireless/infineon/Makefile b/drivers/net/wireless/infineon/Makefile
new file mode 100644
index 000000000000..1f1872569a3c
--- /dev/null
+++ b/drivers/net/wireless/infineon/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: ISC
+#
+# Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+# All rights reserved.
+#
+# Makefile fragment for Infineon 802.11 Networking Device Driver
+#
+
+# common flags
+subdir-ccflags-$(CONFIG_INF_DEBUG)	+= -DDEBUG
+
+obj-$(CONFIG_INFFMAC)	+= inffmac/
-- 
2.25.1


