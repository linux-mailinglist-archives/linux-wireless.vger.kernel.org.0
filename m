Return-Path: <linux-wireless+bounces-30761-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59591D1B3AE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6709130057F2
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524802BCF6C;
	Tue, 13 Jan 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="d/7gDal1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0D72772D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336560; cv=none; b=EtupfU2wZ0net4RiZrxCTCuXCcG9/Iyk/zu7HVrDwF1Xn0T5Yaqj8eqgNyw4neOGzzj6jJKvyeWK7m2vSuj9OLW3sdcluD5Q2/0s+ez7D4UTH3lbyR9aN7rf3MJDuOjhUJbw0wzciuJmJ2fDQZo75cnoOZpg2OtmjeqZhbLZXlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336560; c=relaxed/simple;
	bh=sHPMlb3ehpN4Gpj/r7DZehLlFrUPiaaTCOM15AiqEcI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cLaJK6afwVz2vOpe1nA8quG/fE9R1DEN37icDWhbZv2B/HhQEj2/M2/YhkL1ToL+V5c38Eo03JoXSHHx+C5I/H48+LXbY5mHxJL1MfNFlYMkR8ECEfTHj409N2Doxwc89ffCzxrrb/l2DQASb5FCTo0NdpYFYspptqo/fRJuLPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=d/7gDal1; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336559; x=1799872559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sHPMlb3ehpN4Gpj/r7DZehLlFrUPiaaTCOM15AiqEcI=;
  b=d/7gDal1CQg+jEyr/x5FSfNX9tpI32CpgKzRKQyoUq//+g1SnQfsXJ0l
   RZp7CKN4L0QpfDfHLBvAQuz7pxbnv40XVtbU1FNG3nbpGDpXhJ3dfnW9J
   zSUCe0hiVFfz0erRpTznBSbzY91Yj0YC4fX1QRMV4sdpMKtELgsCUiLr7
   g=;
X-CSE-ConnectionGUID: IoWQzVWwQY66gGzhB707Ug==
X-CSE-MsgGUID: 8toBG1RWQYWiruz8+9qbuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568277"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568277"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:35:56 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:35:56 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:35:54 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 07/34] wifi: inffmac: add chip_{5591x/5551x/5557x/43022}.c/h
Date: Wed, 14 Jan 2026 02:03:20 +0530
Message-ID: <20260113203350.16734-8-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE827.infineon.com (172.23.29.20)

Chip family specific initialization and definitions for Infineon's new
generation secure chipsets CYW5591x, CYW5551x, CYW5557x and CYW43022.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/chip_43022.c    | 30 +++++++++++++++
 .../wireless/infineon/inffmac/chip_43022.h    | 31 ++++++++++++++++
 .../wireless/infineon/inffmac/chip_5551x.c    | 37 +++++++++++++++++++
 .../wireless/infineon/inffmac/chip_5551x.h    | 24 ++++++++++++
 .../wireless/infineon/inffmac/chip_5557x.c    | 31 ++++++++++++++++
 .../wireless/infineon/inffmac/chip_5557x.h    | 24 ++++++++++++
 .../wireless/infineon/inffmac/chip_5591x.c    | 33 +++++++++++++++++
 .../wireless/infineon/inffmac/chip_5591x.h    | 37 +++++++++++++++++++
 8 files changed, 247 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_43022.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_43022.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5551x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5551x.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5557x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5557x.h
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5591x.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_5591x.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip_43022.c b/drivers/net/wireless/infineon/inffmac/chip_43022.c
new file mode 100644
index 000000000000..b32a5da06a59
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_43022.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip_43022.h"
+
+void inff_chip_43022_init(struct inff_chip *chip)
+{
+	struct inff_chip_specific *chip_spec = &chip->chip_spec;
+	struct inff_fw_dataset *fw_data = &chip_spec->fwdata[0];
+
+	chip_spec->hw_caps_replaycnts = INF43022_HW_CAPS_REPLAYCNTS;
+	chip_spec->hw_reg_pmu_status_msk = INF43022_PMU_STATUS_MASK;
+	chip_spec->hw_reg_pmu_ctrl_ext_msk = INF43022_PMU_CONTROL_EXT_MASK;
+	chip_spec->hw_chip_ramsize = INF43022_CHIP_RAMSIZE;
+
+	fw_data[INFF_FW_CODE].fwnames.extension = ".trxs";
+	fw_data[INFF_FW_CODE].fwnames.path = chip_spec->fw_name;
+	fw_data[INFF_FW_CODE].type = INFF_FW_TYPE_TRXS;
+
+	fw_data[INFF_FW_NVRAM].fwnames.extension = ".txt";
+	fw_data[INFF_FW_NVRAM].fwnames.path = chip_spec->nvram_name;
+	fw_data[INFF_FW_NVRAM].type = INFF_FW_TYPE_NVRAM;
+
+	fw_data[INFF_FW_CLM].fwnames.extension = ".clm_blob";
+	fw_data[INFF_FW_CLM].fwnames.path = chip_spec->clm_name;
+	fw_data[INFF_FW_CLM].type = INFF_FW_TYPE_CLM;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/chip_43022.h b/drivers/net/wireless/infineon/inffmac/chip_43022.h
new file mode 100644
index 000000000000..3165b9655967
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_43022.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip.h"
+
+/* PMU STATUS mask for 43022 */
+#define INF43022_PMU_STATUS_MASK        0x1AC
+
+/* PMU CONTROL EXT mask for 43002 */
+#define INF43022_PMU_CONTROL_EXT_MASK   0x11
+
+/* Minimum PMU resource mask for 43022 */
+#define INF43022_PMU_MIN_RES_MASK       0xF8BFE77
+
+#define INF43022_CHIP_RAMSIZE          0xA0000
+
+/* chip specific settings */
+#define INF43022_HW_CAPS_REPLAYCNTS    4
+
+/* INF43022 watermark expressed in number of words */
+#define INF43022_F2_WATERMARK   0x60
+#define INF43022_MES_WATERMARK  0x50
+#define INF43022_MESBUSYCTRL    (INF43022_MES_WATERMARK | \
+				 SBSDIO_MESBUSYCTRL_ENAB)
+
+#define INF43022_DEFAULT_MIN_RES_MASK 0x0f8bfe77
+
+void inff_chip_43022_init(struct inff_chip *chip);
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5551x.c b/drivers/net/wireless/infineon/inffmac/chip_5551x.c
new file mode 100644
index 000000000000..ccd9ce875d87
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5551x.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
index 000000000000..bd69eb4aa603
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5551x.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5557x.c b/drivers/net/wireless/infineon/inffmac/chip_5557x.c
new file mode 100644
index 000000000000..a0a1ed64d21b
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5557x.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
index 000000000000..76e2d421ceca
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5557x.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5591x.c b/drivers/net/wireless/infineon/inffmac/chip_5591x.c
new file mode 100644
index 000000000000..ee12c4e10566
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5591x.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "chip_5591x.h"
+
+void inff_chip_5591x_init(struct inff_chip *chip)
+{
+	struct inff_chip_specific *chip_spec = &chip->chip_spec;
+	struct inff_fw_dataset *fw_data = &chip_spec->fwdata[0];
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
+
+	fw_data[INFF_FW_CP].fwnames.extension = ".hex";
+	fw_data[INFF_FW_CP].fwnames.path = chip_spec->fw_name;
+	fw_data[INFF_FW_CP].type = INFF_FW_TYPE_HEX;
+
+	fw_data[INFF_FW_BOOT].fwnames.extension = ".hex";
+	fw_data[INFF_FW_BOOT].fwnames.path = chip_spec->boot_fw_name;
+	fw_data[INFF_FW_BOOT].type = INFF_FW_TYPE_HEX;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/chip_5591x.h b/drivers/net/wireless/infineon/inffmac/chip_5591x.h
new file mode 100644
index 000000000000..0f0831cf334d
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_5591x.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
+#define CYW5591x_BOOTFW_RAM_LD_ADDR         0x80420000
+#define CYW5591x_FWDWNLD_RAM_WR_ADDR        0x80470000
+#define CYW5591x_IMAGE_LAUNCH_ADDR          0xffffffff
+
+void inff_chip_5591x_init(struct inff_chip *chip);
-- 
2.25.1


