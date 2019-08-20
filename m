Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABB9656D
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbfHTPuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46904 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHTPub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CBB5F61C36; Tue, 20 Aug 2019 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316230;
        bh=FNeu0Qsuh0K3yrgBz0RHKkyd8K2GwUAHDQV0j2Qj9CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUe5hhVLj39AvOPeIbg6lYZeyXrWeggSYWDFuVno7Co857YxXimx71fJqx0Jw2mwv
         ecdd2kR651uqvVEkv7P6CVGfOKW9BJmqltLwfHaElXfw5pBntO9W5NDCEOhfwc046x
         i7DTorGSxo0TApon9OooYqIy9ZRco/a7a92tiaz0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 72DA461C03;
        Tue, 20 Aug 2019 15:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316213;
        bh=FNeu0Qsuh0K3yrgBz0RHKkyd8K2GwUAHDQV0j2Qj9CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d8ZlNeMD9TpcxfR3uG0Nu8SILMk4Wqbuwo93+iyQwObNj3SppvWyQ8nnd7Ee6Jv/Q
         Gt8htHdsFqqa/t6YrVBgPFCD/ppCtznKkNWF+7Wf+FQYMBEg+TRybvT1PyRSDKdJ3n
         CbcufkneroqCow3vS8B1ZGeoP5NLpTXALh0YtU6k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 72DA461C03
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 43/49] ath11k: add trace.c
Date:   Tue, 20 Aug 2019 18:48:09 +0300
Message-Id: <1566316095-27507-44-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/trace.c b/drivers/net/wireless/ath/ath11k/trace.c
new file mode 100644
index 000000000000..df56457b7cbf
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"

