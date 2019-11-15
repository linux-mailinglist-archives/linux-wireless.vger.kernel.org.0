Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDF4FD8EC
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKOJ3Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:29:24 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50234 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOJ3X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:29:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2DA82611AB; Fri, 15 Nov 2019 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810163;
        bh=CsOrm1cqkr7ofAT/l4JgsLzhRcmV0SXka+k1tc8kjw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a+5Z2A79TNptIJ8Rem8WUaFLdA3sbpjYom9xx6v/8r9BAqg9cQl7is2yc1/OegBnU
         MNx1jKa7cYCXRTxtAQk4HfyzPdZC21ad/7xzcQy/FRwA2WPvBEYhKE3nE/5Rnlwlsl
         iCgBIVtL2d8mUAFJI/FGM22LgsIQv9OuhCPML+vo=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60D7D61178;
        Fri, 15 Nov 2019 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810162;
        bh=CsOrm1cqkr7ofAT/l4JgsLzhRcmV0SXka+k1tc8kjw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V4I1MwFFOLU8EX7BxPU77nw2qiGTYMl/UIqxBnN7VL4NsbicFEBM//TMG0d1ZSkHL
         JA+HJHmStCdtwMl+T2EOhP0KlAMqmwijU4aMyOD1KQDcbLju6xTvd0fLEHVsC3H6Jo
         34Cs8xGjVLiydZjnUp1kgDgAduBKz19ykKvqORaU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60D7D61178
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 03/49] ath11k: add Makefile
Date:   Fri, 15 Nov 2019 11:28:27 +0200
Message-Id: <1573810153-29623-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/Makefile | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
new file mode 100644
index 000000000000..a91d75c1cfeb
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+obj-$(CONFIG_ATH11K) += ath11k.o
+ath11k-y += core.o \
+	    hal.o \
+	    hal_tx.o \
+	    hal_rx.o \
+	    ahb.o \
+	    wmi.o \
+	    mac.o \
+	    reg.o \
+	    htc.o \
+	    qmi.o \
+	    dp.o  \
+	    dp_tx.o \
+	    dp_rx.o \
+	    debug.o \
+	    ce.o \
+	    peer.o
+
+ath11k-$(CONFIG_ATH11K_DEBUGFS) += debug_htt_stats.o
+ath11k-$(CONFIG_MAC80211_DEBUGFS) += debugfs_sta.o
+ath11k-$(CONFIG_NL80211_TESTMODE) += testmode.o
+ath11k-$(CONFIG_ATH11K_TRACING) += trace.o
+
+# for tracing framework to find trace.h
+CFLAGS_trace.o := -I$(src)

