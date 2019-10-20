Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD2FDDDE0
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbfJTKF6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:05:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50296 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfJTKF6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:05:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6E284613BF; Sun, 20 Oct 2019 10:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565957;
        bh=kyoQzIqk/N0biphIO3T0zVmlSOFk/cboG6nBTmAQ75k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bo6LasWb9GaeN0ndyMbaQ9xm5ThR4teSb+IWC/+cTtGgV0n5SXbUR9nRuiYKgpHBy
         mbK2Qy5oTzy0EF/u6BE2hzfpgSYGw5f1V5Y+VMxDthOSZ1agMQrL8LLU+70vklZCWu
         nALF+FdNk7DLVzwt9YXnsrBLA4z56Djx2Zxow60Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B859F613BB;
        Sun, 20 Oct 2019 10:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565950;
        bh=kyoQzIqk/N0biphIO3T0zVmlSOFk/cboG6nBTmAQ75k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZeZb1lMUBwoEkess5JGz6Feah2+NjImTg8i3v3HyGnDs/eLWL9TdAyUTO688pgERS
         IEqulLPpZ8OarAUQHBp2G1G+rCcUL92a8Tz4ElYiPKAnkGmb4RGQKgu6fJO5Iiai6X
         3aT9uhD27lo1KJsnZYQH6RTZJ3guH9MhnmRrbbHQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B859F613BB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 43/49] ath11k: add trace.c
Date:   Sun, 20 Oct 2019 13:04:01 +0300
Message-Id: <1571565847-10338-44-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/trace.c b/drivers/net/wireless/ath/ath11k/trace.c
new file mode 100644
index 000000000000..f0cc49ba0387
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/trace.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/module.h>
+
+#define CREATE_TRACE_POINTS
+#include "trace.h"

