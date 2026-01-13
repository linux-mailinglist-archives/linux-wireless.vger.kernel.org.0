Return-Path: <linux-wireless+bounces-30760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFECD1B3CF
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEE493082D03
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376B42C21C2;
	Tue, 13 Jan 2026 20:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="NNYVD4yQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175C2BCF6C
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336540; cv=none; b=D1labQk75DlRaeZvXIi0oJumGbaQC6wGDmZDpwzGB8uSrRLU3voKhnZ964VwyobyuW3zJOCwSWN/78QTdakBpMAaBYT3WB6ZD9CZNYMlwNhrGY11PN4TvijEQt3MDNtoz9xoMDj2gR1t5vtg6TUZ5ihe9QPe0d3AwiPEugrBFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336540; c=relaxed/simple;
	bh=VW/Uc49/j8Afj5Otqcb2rpxzzRoXGJXWu46RBweLhf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4c2V7H+LD6FHNexNfWoxQtg2uRQ5AbTq5nMfExWFvrTKOuUrZtthNDXoco3RLHNVKt5TJsJhhkfrubhyXlhyNEcmyqgMf60mzJ8MjBq1+h6zSGg1p8lf1boX5Tx1tkDlEK8PKRF5uqrFnqdnKtaIbJm7erHWpChzi+7ZFQoHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=NNYVD4yQ; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336538; x=1799872538;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VW/Uc49/j8Afj5Otqcb2rpxzzRoXGJXWu46RBweLhf8=;
  b=NNYVD4yQ4gf6k/orNaVhzxU5Ie0rmc6igTn0zezrwu/yrfkXCo2yURyj
   EyMfSByPDQqSjJz+78XxsRk5oi2ovbYr1kqhUB8yeVpNi7XNgk4Tzt9uQ
   0/riwQHDHBqIVcKSpBBEUvt9Fo93iHY2c+QhRFTttX4nMxlXjHX5Rxzjj
   Q=;
X-CSE-ConnectionGUID: WDyzN3hdR7SQbmvPal++9A==
X-CSE-MsgGUID: F+6s5bZ8QlerxBV0P+PgCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="113628130"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="113628130"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:34:29 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:34:29 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:34:27 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 01/34] wifi: inffmac: add a new driver directory for infineon WLAN vendor
Date: Wed, 14 Jan 2026 02:03:14 +0530
Message-ID: <20260113203350.16734-2-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

Update the wireless driver common Kconfig and Makefile to include the
new WLAN vendor directory for Infineon(Cypress).

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/Kconfig           |  1 +
 drivers/net/wireless/Makefile          |  1 +
 drivers/net/wireless/infineon/Kconfig  | 25 +++++++++++++++++++++++++
 drivers/net/wireless/infineon/Makefile | 12 ++++++++++++
 4 files changed, 39 insertions(+)
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
index 000000000000..7eeeb5935361
--- /dev/null
+++ b/drivers/net/wireless/infineon/Kconfig
@@ -0,0 +1,25 @@
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
index 000000000000..25c8d9b701b0
--- /dev/null
+++ b/drivers/net/wireless/infineon/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: ISC
+#
+# Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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


