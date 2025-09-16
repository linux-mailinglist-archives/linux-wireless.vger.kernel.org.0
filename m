Return-Path: <linux-wireless+bounces-27367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8A3B7DA58
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC11189500B
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FBC2E0415;
	Tue, 16 Sep 2025 22:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="cCu0+RIf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E302248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061343; cv=none; b=FqUJ4dcwkRWczSJl69+EmqPQV5DTduYo35CuWN+n65HWzcCcg9NiEmUyQ826b51MuRS3x9kNHHeq1cYr2k9REdQmu5Py51Izx2/p5itjr6C4b7+/5gksOyCKraMEMPBhqlLGP2oSgfucO8Fx4+mNiSeNbAOPTYykdEDn8ULuhmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061343; c=relaxed/simple;
	bh=CnV9r98aMzt2AvC8FrklaC0Odj+mzQJv0Imv70ynwMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDy+99AYN0KGHkzCwRjlVJkqaNd3yRgaYlHz+n2AR2cbCt0RSqx7G2VfICHarfyPbFOSuPj7kYQ5ol5/dxwMxfX1mTjaU28vO9wE4wZiAitBqdWjk3ioW1Vu3J0XHA5vfhqbZ2uPPhCJd3TkX5XB6AUfCNc1Bil2T/Z9mCQMTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=cCu0+RIf; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061338; x=1789597338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CnV9r98aMzt2AvC8FrklaC0Odj+mzQJv0Imv70ynwMo=;
  b=cCu0+RIf252Dj24CRs3GaBXXGTFJM4s7F0fVUGvznjZIfVXjUSz6KE+d
   kn71O1QS/h0SA5HvTddBtwewRFEDkOq2abWvCpWmDcEvApAXdXFXemaBh
   1fkwCxeYOt1UxiThgHyc/aO4pVjhBDqs7aklBCoi5GofgWGeJX9vwpyiJ
   4=;
X-CSE-ConnectionGUID: RFY3oRXzR921bzwlEA+RQw==
X-CSE-MsgGUID: j78IBIdHShqvMUsvyGN/EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783453"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783453"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE822.infineon.com) ([172.23.29.53])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:22:14 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:22:13 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:22:11 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 18/57] wifi: inffmac: add chip_5591x.c/h
Date: Wed, 17 Sep 2025 03:47:33 +0530
Message-ID: <20250916221821.4387-19-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE824.infineon.com (172.23.29.55) To
 MUCSE827.infineon.com (172.23.29.20)

The Chip family specific initialization for Infineon's CYW5591x chipsets.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/chip_5591x.c    | 24 ++++++++++++++
 .../wireless/infineon/inffmac/chip_5591x.h    | 33 +++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5591x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5591x.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip_5591x.c b/drivers/net/wireless/infineon/inffmac/chip_5591x.c
new file mode 100644
index 000000000000..8901ede943cf
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5591x.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip_5591x.h"
+
+void inff_chip_5591x_init(struct inff_chip *chip)
+{
+	struct inff_chip_specific *chip_spec = &chip->chip_spec;
+
+	chip_spec->hw_caps_replaycnts = INFF_CHIP_COMMON_HW_CAPS_REPLAYCNTS;
+
+	if (chip->chiprev == 0) {
+		chip_spec->hw_chip_tcam_size = INF55900_TCAM_SIZE;
+		chip_spec->hw_chip_trxhdr_size = INF55900_TRXHDR_SIZE;
+		chip_spec->hw_chip_rambase = INF55900_RAM_BASE;
+	} else {
+		chip_spec->hw_chip_tcam_size = INF55900_A1_TCAM_SIZE;
+		chip_spec->hw_chip_trxhdr_size = INF55900_A1_TRXHDR_SIZE;
+		chip_spec->hw_chip_rambase = INF55900_A1_RAM_BASE;
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5591x.h b/drivers/net/wireless/infineon/inffmac/chip_5591x.h
new file mode 100644
index 000000000000..c1ca76788004
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5591x.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip.h"
+
+/* 55900-A0, Dedicated sapce for TCAM_PATCH and TRX HDR area at RAMSTART */
+#define INF55900_RAM_START	(0x3a0000)
+#define INF55900_TCAM_SIZE	(0x800)
+#define INF55900_TRXHDR_SIZE	(0x2b4)
+
+#define INF55900_RAM_BASE	(INF55900_RAM_START + INF55900_TCAM_SIZE + \
+				 INF55900_TRXHDR_SIZE)
+
+/* 55900-A1, Dedicated sapce for TCAM_PATCH and TRX HDR area at RAMSTART */
+#define INF55900_A1_TCAM_SIZE	(0x1000)
+#define INF55900_A1_TRXHDR_SIZE	(0x20)
+
+#define INF55900_A1_RAM_BASE	(INF55900_RAM_START + INF55900_A1_TCAM_SIZE + \
+				 INF55900_A1_TRXHDR_SIZE)
+
+/* INF55900 SDIO func2 block size */
+#define SDIO_INF55900_FUNC2_BLOCKSIZE	256
+
+/* INF55900 watermark expressed in number of words */
+#define INF55900_F2_WATERMARK	0x40
+#define INF55900_MES_WATERMARK	0x40
+#define INF55900_F1_MESBUSYCTRL	(INF55900_MES_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
+
+void inff_chip_5591x_init(struct inff_chip *chip);
-- 
2.25.1


