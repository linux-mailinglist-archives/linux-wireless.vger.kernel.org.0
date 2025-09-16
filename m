Return-Path: <linux-wireless+bounces-27364-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B56B7DA24
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EB5188D953
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8F12877C1;
	Tue, 16 Sep 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Ga1nqzZC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2102BEC43
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061302; cv=none; b=g17qkgKVteXXptjSvyThvSIhN+PptNz2kRt+UiDVwCYakb85LZESGVdb58dw/m/PfcGxqkZGBMJKub5wR9HqD+5qYySvljxb+zJU1bqyDXYDl4WXsm7aDlYKdoBbeVBwpG2J+qlT/hVpV5h2LrrGrTrankb5JPUMI175qnH65KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061302; c=relaxed/simple;
	bh=/BRZ0y83xz6bEwVY9ReuIPL6SBnld9Rr/JsGLwaW+h0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3k5l1BmsdTc3jRaOJt8jsYyDDJtf7ZUytagXEZJ/FEmgvd5ILzsqPa+P0tu26Yyd+7Lybx8VGccja+nVCX7quaKDRGSeuTnv9dIzAzzO68X4MyyKOPKiH5DiSdBXZWZydDWXNIT8lpuaqebJbr0a02kCMyMoGdLcxhxLZG5wb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Ga1nqzZC; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061301; x=1789597301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/BRZ0y83xz6bEwVY9ReuIPL6SBnld9Rr/JsGLwaW+h0=;
  b=Ga1nqzZC8XyEYq/4vQ83/Ni5OMOl1vVrMQ76a84G0XqAtkFthjo549Yw
   cKQsh6sndXZJbJznP6vIkyO/tFNx0FyDLxNBowy+j/DSDbIlS9CBQUnTR
   x6ywz6kq74MoC8FSplJReFRDaawH0XtUk8eKHxzFGTpA/jMryMWTNc4hz
   o=;
X-CSE-ConnectionGUID: MMxQIbI7QA6IGpOk1Fj4Fw==
X-CSE-MsgGUID: qMPCvjsPQ4KJ3BhSvbly0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99293790"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99293790"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:21:39 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:21:38 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:21:36 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 15/57] wifi: inffmac: add chip_43022.c/h
Date: Wed, 17 Sep 2025 03:47:30 +0530
Message-ID: <20250916221821.4387-16-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
 MUCSE827.infineon.com (172.23.29.20)

The Chip family specific initialization for Infineon's CYW43022 chipset.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/chip_43022.c    | 30 +++++++++++++++++++
 .../wireless/infineon/inffmac/chip_43022.h    | 29 ++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_43022.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip_43022.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip_43022.c b/drivers/net/wireless/infineon/inffmac/chip_43022.c
new file mode 100644
index 000000000000..a03328d1e75c
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_43022.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
index 000000000000..00715980653f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip_43022.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2024-2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
+void inff_chip_43022_init(struct inff_chip *chip);
-- 
2.25.1


