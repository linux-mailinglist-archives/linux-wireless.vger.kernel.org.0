Return-Path: <linux-wireless+bounces-27407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF340B7DF87
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86D017B81B4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D6299AAF;
	Tue, 16 Sep 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="NG4LjjqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD628466C
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061825; cv=none; b=m1oUnjbd9KGPWfHchlkOQyOZxQPAeH9/neqU5gh3CAwrioNqa/aXMU22/sNMgJMoGfFpsS27iGfyDl6XHN4F1NVAiIPm8j2/Jvokhb37gSphr3woZ7E0Iw7cQkDmdn99GY6taOHswGK6e6gR5p9GgxnXy++c/BMSECEte6yIzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061825; c=relaxed/simple;
	bh=aE8PrWMpBUYIGs+RtP7PKUKLojU+LgcLtw0HpT6wIqE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEZt4XKVfzNrwA0PJxjDSaPVsZOZxkIpaA91ZNGcH7w1DRgSEsZmA6Wfd8Q+5jlCl9s1CAjy71TgM0/bqT4+lvXrYl2JDueILiXlLV22K1aRMj18J5ZwGxesFWxdvI2LhUHs/bVxFX2wXGjQTJqzgZ6DUlJTkLRbTfPExjj38RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=NG4LjjqM; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061824; x=1789597824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aE8PrWMpBUYIGs+RtP7PKUKLojU+LgcLtw0HpT6wIqE=;
  b=NG4LjjqMqz6810PUoeOSglrOTDWU1Hwt+KbQFSxaxfCcEAyxWZ+jkUq+
   WQjlHcRNrmtreGqyJZM4gu+UfgBmyIzVc8QQg0rAoHVcMafs02F8WqIyP
   zjYH+nLs+5SrJlj0eRnsAsP9HqAxwyfyvsZyVzkRjBHHInMHUFmpKKctn
   o=;
X-CSE-ConnectionGUID: cDO9BFKhSuC61z/ZFl3waA==
X-CSE-MsgGUID: dFF2K/LzTXa/7m/itZBsyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294352"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294352"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:30:22 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:30:21 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:30:19 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 52/57] wifi: inffmac: add hw_ids.h
Date: Wed, 17 Sep 2025 03:48:12 +0530
Message-ID: <20250916221821.4387-58-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

Infineon Device specific definitions.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/hw_ids.h    | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/hw_ids.h

diff --git a/drivers/net/wireless/infineon/inffmac/hw_ids.h b/drivers/net/wireless/infineon/inffmac/hw_ids.h
new file mode 100644
index 000000000000..25271fcf6c37
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/hw_ids.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_HW_IDS_H
+#define	INFF_HW_IDS_H
+
+#include <linux/pci_ids.h>
+#include <linux/mmc/sdio_ids.h>
+
+#define INF_PCIE_VENDOR_ID_CYPRESS	0x12be
+
+/* Chipcommon Core Chip IDs */
+#define INF_CC_5557X_CHIP_ID		0xd908
+#define INF_CC_5551X_CHIP_ID		0xD8CC
+#define INF_CC_5591X_CHIP_ID		0xDA5C
+#define INF_CC_43022_CHIP_ID		43022
+
+/* PCIE Device IDs */
+#define INF_PCIE_5557X_DEVICE_ID	0xbd31
+
+#endif /* INFF_HW_IDS_H */
-- 
2.25.1


