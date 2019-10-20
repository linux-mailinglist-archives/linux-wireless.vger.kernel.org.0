Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501B7DDD93
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbfJTKEQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41106 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfJTKEQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 97E9960D39; Sun, 20 Oct 2019 10:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565855;
        bh=CsOrm1cqkr7ofAT/l4JgsLzhRcmV0SXka+k1tc8kjw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JayWUQjsW4nCUfoy6TtCOk2rECcOpKXbeBMlvGL6e5ehjqdfZBD65GoRynuK1MAN1
         cROgK3CgEPKjiNSCCMjwlBpG8iH8tr0uO2YN+jecbwG7NGvKS+HqXLffXOVxXkI3Lb
         SjD9js9VR2kewnIDIbAghlvxLQNmLICyFNkh3cU4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1ADC160D39;
        Sun, 20 Oct 2019 10:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565855;
        bh=CsOrm1cqkr7ofAT/l4JgsLzhRcmV0SXka+k1tc8kjw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JayWUQjsW4nCUfoy6TtCOk2rECcOpKXbeBMlvGL6e5ehjqdfZBD65GoRynuK1MAN1
         cROgK3CgEPKjiNSCCMjwlBpG8iH8tr0uO2YN+jecbwG7NGvKS+HqXLffXOVxXkI3Lb
         SjD9js9VR2kewnIDIbAghlvxLQNmLICyFNkh3cU4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ADC160D39
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 03/49] ath11k: add Makefile
Date:   Sun, 20 Oct 2019 13:03:21 +0300
Message-Id: <1571565847-10338-4-git-send-email-kvalo@codeaurora.org>
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

