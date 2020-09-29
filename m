Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A809F27D43D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Sep 2020 19:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgI2RPv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 13:15:51 -0400
Received: from z5.mailgun.us ([104.130.96.5]:48740 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbgI2RPv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 13:15:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601399750; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=qlD4ldMryIjboApDMiIQrLFC4KqS9FTIjJN2qfziPOA=; b=ib1pc7O6K265wz4VV2fkHVMjGHfZi5PXvkhi+XgnFBI1s6fuKhIKABiYwA8Qwzu9tXwOvo2J
 n0Vz64UjYEw1RBwj+RLxOIZmPL/yOsfaS26Ho0k3G4ocSXZsJepuqvd2uf1aiqaUXXYAtp0G
 vA17rj/HVBat07aHxWB+VXdRfOQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f736bbef38f205ebc8f7e41 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 29 Sep 2020 17:15:42
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22830C433C8; Tue, 29 Sep 2020 17:15:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D2A74C433FF;
        Tue, 29 Sep 2020 17:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2A74C433FF
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/8] ath11k: support loading ELF board files
Date:   Tue, 29 Sep 2020 20:15:29 +0300
Message-Id: <1601399736-3210-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
References: <1601399736-3210-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The QCA6390 board I have, model 8291M-PR comes with an ELF board file.  To get
this to at least somewhat work, I renamed bdwlan.e04 to 'board.bin' and then
added this patch to check for ELF magic string in the beginning of the file.
If that is found, use type ELF.  After this the driver loads.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Ben Greear <greearb@candelatech.com>
[kvalo@codeaurora.org: use elf.h, minor cleanup]
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index b906b50ee57e..9144f28b37d1 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -3,6 +3,8 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/elf.h>
+
 #include "qmi.h"
 #include "core.h"
 #include "debug.h"
@@ -1990,6 +1992,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 	struct qmi_txn txn = {};
 	int ret;
 	const u8 *temp;
+	int bdf_type;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
@@ -2006,6 +2009,13 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 	temp = bd.data;
 	remaining = bd.len;
 
+	if (bd.len >= SELFMAG && memcmp(bd.data, ELFMAG, SELFMAG) == 0)
+		bdf_type = ATH11K_QMI_BDF_TYPE_ELF;
+	else
+		bdf_type = ATH11K_QMI_BDF_TYPE_BIN;
+
+	ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi bdf_type %d\n", bdf_type);
+
 	while (remaining) {
 		req->valid = 1;
 		req->file_id_valid = 1;
@@ -2015,7 +2025,7 @@ static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
 		req->seg_id_valid = 1;
 		req->data_valid = 1;
 		req->data_len = ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE;
-		req->bdf_type = ATH11K_QMI_BDF_TYPE_BIN;
+		req->bdf_type = bdf_type;
 		req->bdf_type_valid = 1;
 		req->end_valid = 1;
 		req->end = 0;
-- 
2.7.4

