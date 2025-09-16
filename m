Return-Path: <linux-wireless+bounces-27365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B3DB7D8ED
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF1B528417
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE162BEC43;
	Tue, 16 Sep 2025 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="gdI0CbuS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11A2248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061314; cv=none; b=gDvJHishFULOELSSNR8HDH/eQa4mCjXZp2DKhAo24BWswGVud6JTpw4d/bjoMm1HtwGQpwkgV0Nl7pIhthQw6pESmb2AA7QMN09L3uX9FscA97Pa700CMrYWmlTw4Yi8IE7h+LS/h9EQqgyW7LPOY+NJBSvu2tv7JDdYXg+IbaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061314; c=relaxed/simple;
	bh=MPdjHGeBEzcsphoAC5ppnFHVcrgzFtZAoPFullSXQsM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wf9y6a5gT+mGrb1CJhwbKP5DEgp3sHWJkcPHFYG3KQfuFQjliAgOqQpiJ+LheI42t0yZXz4rV1KvpmGzUcvvXcmRV7zU1fI+6HxSsl3TBzSg+gSct3UwmmRzBeOkqBAGY+JpjXdOcsOS7ZO5W0zwPgEil//SwbDRww7xv85uYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=gdI0CbuS; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061313; x=1789597313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPdjHGeBEzcsphoAC5ppnFHVcrgzFtZAoPFullSXQsM=;
  b=gdI0CbuSHLkQam/KGJX1+1iKvph3E/086j5xt5ggHys5AePX1WbdhqdO
   RZbC/G899LUEDfbfC/O7d7FgHWi0iw3sHXWIBAMNGAZ7QCQueGz0Fxlgm
   NOM/Qpv4pC6OALOmKA8/l4AxPlNVvj/VqerpKBWJ1g/cLXWPvIwUs+QA4
   o=;
X-CSE-ConnectionGUID: qbCB8dSsT2ahjfcP4EJcig==
X-CSE-MsgGUID: MP+gvPC8RAyBOlDCaoX/2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783409"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783409"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:21:51 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:21:50 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:21:47 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 16/57] wifi: inffmac: add chip_5557x.c/h
Date: Wed, 17 Sep 2025 03:47:31 +0530
Message-ID: <20250916221821.4387-17-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

The Chip family specific initialization for Infineon's CYW5557x chipsets
which has varying spatial stream (1x1/2x2) and bandwidth (20/40/80 MHz)
capabilities.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/chip_5557x.c    | 31 +++++++++++++++++++
 .../wireless/infineon/inffmac/chip_5557x.h    | 24 ++++++++++++++
 2 files changed, 55 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5557x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5557x.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip_5557x.c b/drivers/net/wireless/infineon/inffmac/chip_5557x.c
new file mode 100644
index 000000000000..b6c9edf31c40
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5557x.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip_5557x.h"
+
+void inff_chip_5557x_init(struct inff_chip *chip)
+{
+	struct inff_chip_specific *chip_spec = &chip->chip_spec;
+	struct inff_fw_dataset *fw_data = &chip_spec->fwdata[0];
+
+	chip_spec->hw_caps_replaycnts = INFF_CHIP_COMMON_HW_CAPS_REPLAYCNTS;
+
+	chip_spec->hw_chip_rambase = INF55572_RAM_BASE;
+	chip_spec->hw_chip_tcam_size = INF55572_TCAM_SIZE;
+	chip_spec->hw_chip_trxhdr_size = INF55572_TRXHDR_SIZE;
+
+	fw_data[INFF_FW_CODE].fwnames.extension = ".trxse";
+	fw_data[INFF_FW_CODE].fwnames.path = chip_spec->fw_name;
+	fw_data[INFF_FW_CODE].type = INFF_FW_TYPE_TRXSE;
+
+	fw_data[INFF_FW_NVRAM].fwnames.extension = ".txt";
+	fw_data[INFF_FW_NVRAM].fwnames.path = chip_spec->nvram_name;
+	fw_data[INFF_FW_NVRAM].type = INFF_FW_TYPE_NVRAM;
+
+	fw_data[INFF_FW_CLM].fwnames.extension = ".clm_blob";
+	fw_data[INFF_FW_CLM].fwnames.path = chip_spec->clm_name;
+	fw_data[INFF_FW_CLM].type = INFF_FW_TYPE_CLM;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5557x.h b/drivers/net/wireless/infineon/inffmac/chip_5557x.h
new file mode 100644
index 000000000000..644e81bd1c9c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5557x.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip.h"
+
+/* INF55572 dedicated space and RAM base */
+#define INF55572_TCAM_SIZE	0x800
+#define INF55572_TRXHDR_SIZE	0x2b4
+#define INF55572_RAM_BASE	(0x370000 + \
+				 INF55572_TCAM_SIZE + INF55572_TRXHDR_SIZE)
+
+/* INF55572 SDIO func2 block size */
+#define SDIO_INF55572_FUNC2_BLOCKSIZE	256
+
+/* INF55572 watermark expressed in number of words */
+#define INF55572_F2_WATERMARK	0x40
+#define INF55572_MES_WATERMARK	0x40
+#define INF55572_F1_MESBUSYCTRL	(INF55572_MES_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
+
+void inff_chip_5557x_init(struct inff_chip *chip);
-- 
2.25.1


