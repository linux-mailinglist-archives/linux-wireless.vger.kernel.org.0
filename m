Return-Path: <linux-wireless+bounces-27366-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D9B7D8E4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDA9580763
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F942BEC43;
	Tue, 16 Sep 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="O8plCMhj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019452248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061325; cv=none; b=lWJYde3Hbb+YtYbJwtBP1NTCy5QNOr8ddKns/JK7OiLGyYypcSdirTxzPmSOzxtgESof9ZEritPk0sri27NdrJ6OLrzic5mP8ZQiHJZh6qll9RjMh9Mt2g9FviwDhqE+kF2Ff4I0VRtd+YOWySBEB10iijqvW8It0GrWwynDM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061325; c=relaxed/simple;
	bh=8sFmhdMQOIvTZzuukCZoxWhkwM7wmXtGw4vQ983gh/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeYeh769mFm2q4NAaPFEx+ZKJBfZoJQ+Kma6nUYobHETQBP6iYeVBFAwNUZuqfoue6GErHIBw9bMydL2onj+7sHpY0neIatgwYSJ8mTjp5wY//5ETTg4d5xSrYajnJIb3DH8bxsHq2CMIZsv85P7zoRNNXKrpCqBhMo5eb6PISc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=O8plCMhj; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061325; x=1789597325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8sFmhdMQOIvTZzuukCZoxWhkwM7wmXtGw4vQ983gh/Y=;
  b=O8plCMhjIYiIrZfaqQojuBlW+ZMDTU7qjVVIe7s2UdjKlRvcVbmrxITW
   JO4WG4iHDpkBRRmHof+ji/p4DOA2+U0Jiejs2kSY9X+YvjZYDFUw3Y3mo
   Kk5tT2fbu8SxbZVDXTmU3oigL+eyFOIwaxkrRLde55vBrUIm/twe3GxPA
   c=;
X-CSE-ConnectionGUID: VlcTmeZdTGOFtUbyJTwr2Q==
X-CSE-MsgGUID: QHKA/JHoQdSeEfnbgkY+jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783448"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783448"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:22:03 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:22:01 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:21:59 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 17/57] wifi: inffmac: add chip_5551x.c/h
Date: Wed, 17 Sep 2025 03:47:32 +0530
Message-ID: <20250916221821.4387-18-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE816.infineon.com (172.23.29.42) To
 MUCSE827.infineon.com (172.23.29.20)

The Chip family specific initialization for Infineon's CYW5551x chipsets.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/chip_5551x.c    | 37 +++++++++++++++++++
 .../wireless/infineon/inffmac/chip_5551x.h    | 24 ++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5551x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5551x.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip_5551x.c b/drivers/net/wireless/infineon/inffmac/chip_5551x.c
new file mode 100644
index 000000000000..38ae4b823b05
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5551x.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip_5551x.h"
+
+void inff_chip_5551x_init(struct inff_chip *chip)
+{
+	struct inff_chip_specific *chip_spec = &chip->chip_spec;
+	struct inff_fw_dataset *fw_data = &chip_spec->fwdata[0];
+
+	chip_spec->hw_caps_replaycnts = INFF_CHIP_COMMON_HW_CAPS_REPLAYCNTS;
+
+	if (chip->chiprev == 0) {
+		chip_spec->hw_chip_tcam_size = INF55500_TCAM_SIZE;
+		chip_spec->hw_chip_trxhdr_size = INF55500_TRXHDR_SIZE;
+		chip_spec->hw_chip_rambase = INF55500_RAM_BASE;
+	} else {
+		chip_spec->hw_chip_tcam_size = INF55500_A1_TCAM_SIZE;
+		chip_spec->hw_chip_trxhdr_size = INF55500_A1_TRXHDR_SIZE;
+		chip_spec->hw_chip_rambase = INF55500_A1_RAM_BASE;
+	}
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
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5551x.h b/drivers/net/wireless/infineon/inffmac/chip_5551x.h
new file mode 100644
index 000000000000..abf9d60a0b74
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5551x.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip.h"
+
+/* 55500-A0, Dedicated sapce for TCAM_PATCH and TRX HDR area at RAMSTART */
+#define INF55500_RAM_START	(0x3a0000)
+#define INF55500_TCAM_SIZE	(0x800)
+#define INF55500_TRXHDR_SIZE	(0x2b4)
+
+#define INF55500_RAM_BASE	(INF55500_RAM_START + INF55500_TCAM_SIZE + \
+				 INF55500_TRXHDR_SIZE)
+
+/* 55500-A1, Dedicated sapce for TCAM_PATCH and TRX HDR area at RAMSTART */
+#define INF55500_A1_TCAM_SIZE	(0x1000)
+#define INF55500_A1_TRXHDR_SIZE	(0x20)
+
+#define INF55500_A1_RAM_BASE	(INF55500_RAM_START + INF55500_A1_TCAM_SIZE + \
+				 INF55500_A1_TRXHDR_SIZE)
+
+void inff_chip_5551x_init(struct inff_chip *chip);
-- 
2.25.1


