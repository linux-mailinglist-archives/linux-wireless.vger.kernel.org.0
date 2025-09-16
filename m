Return-Path: <linux-wireless+bounces-27411-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CACB7F06F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0DA7B88E5
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8330345C14;
	Tue, 16 Sep 2025 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="AXZIbAqO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265127713
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061874; cv=none; b=eshUIZCAt2TWg0iJ5ty9IyLpdboMsRVXeMOt+hFc9rZMUhUKfb2DF17AzsTaDHKdP+NT7uyIalt6DOzh1znSiD1ESHMxsCcVFRUxGc6GjDCGYYUXEwF8m4Ye41s42AGbQ1DWyCLzsCzbOOgxyYUKzMzwrY7AiTl0ZG8NQR0aQFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061874; c=relaxed/simple;
	bh=thx+3jRE5aMeKI65dLUNpXgs5Od+8YChTdEOGPa6bIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BZ2YZagxANb1pwLnBSYlXVf8qZhXVED652CipYVFffgcQpD3KWNpcH/iq6W/6JZU6SejCfQLHQhT58eCVYblZqeMMxpPvSxSD7alny8gtdqooS6nUxMXhJ8YNbm7JvkH0VNpVKC8YWOTp9e9CMUMpGuQDj9fWnLVzf5HddcGC/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=AXZIbAqO; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061872; x=1789597872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=thx+3jRE5aMeKI65dLUNpXgs5Od+8YChTdEOGPa6bIs=;
  b=AXZIbAqOKozEcdn5IvFEwIXTaAvduJBSgwmVTXumDZoUyT4t8eHzzT2m
   YvpYSWCXSYasSjrUrUERClBPK5sChY8q6/sh6tg3LmQf0v/TIJi6IqfIS
   Q64oul+gGM0Gr1rqw2ZNTnMkb0UQ0pDBBD9XuQCGvp9z8JPMl7Refq7GP
   U=;
X-CSE-ConnectionGUID: Ax6AembXQE+nNJ2qL00HEw==
X-CSE-MsgGUID: 3+S64/34R6G5Dy5MrbUEtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093951"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093951"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:31:09 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:31:09 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:31:07 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 56/57] wifi: inffmac: add defs.h
Date: Wed, 17 Sep 2025 03:48:16 +0530
Message-ID: <20250916221821.4387-62-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE827.infineon.com (172.23.29.20)

file to define some generic definitions

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/defs.h | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/defs.h

diff --git a/drivers/net/wireless/infineon/inffmac/defs.h b/drivers/net/wireless/infineon/inffmac/defs.h
new file mode 100644
index 000000000000..a9550e578b01
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/defs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_DEFS_H
+#define	INFF_DEFS_H
+
+#include <linux/types.h>
+
+/* cpp contortions to concatenate w/arg prescan */
+#ifndef PAD
+#define _PADLINE(line)	pad ## line
+#define _XSTR(line)	_PADLINE(line)
+#define PAD	_XSTR(__LINE__)
+#endif
+
+#endif /* INFF_DEFS_H */
-- 
2.25.1


