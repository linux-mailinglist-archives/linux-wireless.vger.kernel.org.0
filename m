Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 359939651A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbfHTPs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:48:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730141AbfHTPs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:48:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 21D5761214; Tue, 20 Aug 2019 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316106;
        bh=rBng7+qAi4GndIPkSSiKr0FyeZ+i27cFBw5PU3cor8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zgw3v0thlUCqH4PgiPCuYdklhj+5R5rlNaXVbF/SyTHq6kflyBHMmdGjCGcfslLYE
         HguFVj5A5MaVm6IGEpILMAr5Kb1vhzHjEiHZdHABU0PYffWaeFrVthJwXCoDzIN7Vn
         u5+f6K7kYDFe0VUxarmhXev+grZXoAj9tNrYHsr0=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9F6A619F6;
        Tue, 20 Aug 2019 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316105;
        bh=rBng7+qAi4GndIPkSSiKr0FyeZ+i27cFBw5PU3cor8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6yXhWT/QbdhCBpRtKNhNySTP6545a7ABoHMcDC7SjslLY/iyWWWyS6vbYRotkbGe
         1xAQS1PZd81CjVeqcVcgNpDVG1tbJz6asInuJj9Vypyh75Lyj1a9tiNz19fCjLVL8R
         3enXR0OrNT1JU3W33e4YsO/klXgp6lCQYBxzNQkA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9F6A619F6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 03/49] ath11k: add Makefile
Date:   Tue, 20 Aug 2019 18:47:29 +0300
Message-Id: <1566316095-27507-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/Makefile | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/Makefile b/drivers/net/wireless/ath/ath11k/Makefile
new file mode 100644
index 000000000000..6b4a5b5a2aa3
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/Makefile
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: ISC
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

