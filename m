Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC09FD8EA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfKOJ3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:29:22 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50146 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfKOJ3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:29:21 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7FA7861189; Fri, 15 Nov 2019 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810161;
        bh=N7SmkR08As1775KdsdCtRSUs5xBe0ZoOg4Zqaa5eZF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nfMmw25n25bHaReMThlM2F3RBZQ53d34y3hDjygv0k0LyGCbdWETLtWTJnSTY+C9W
         e4PrVnSplJzeHqY5+20vhna1Rcgfc0dzLWTyYX7ahbCS5NuG2plI4WXdLDki/eIJo9
         Gy1RJTHC5yqb+xYIlJDpU5b0et2xdtfe8pnYAzYE=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D59E0602F7;
        Fri, 15 Nov 2019 09:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810160;
        bh=N7SmkR08As1775KdsdCtRSUs5xBe0ZoOg4Zqaa5eZF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hsbqn9+wrwUkz7Wxp6VtwpQz2z84y0qItShovDeFgPFxNmzIjyyVMLDUQ4pwulP4K
         1HT7jDr+S0dDenTiJgvQdVOBXZCkd5OlFtDfByq1G9Ed0KxylQu3szmwgcf1bwAvcJ
         RFRK/OoQq/+hDHvf2FTSIjT0kAi/iDU6eW6+V9/w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D59E0602F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 02/49] ath11k: add Kconfig
Date:   Fri, 15 Nov 2019 11:28:26 +0200
Message-Id: <1573810153-29623-3-git-send-email-kvalo@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/Kconfig | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
new file mode 100644
index 000000000000..cfab4fb86aef
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/Kconfig
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: BSD-3-Clause-Clear
+config ATH11K
+	tristate "Qualcomm Technologies 802.11ax chipset support"
+	depends on MAC80211 && HAS_DMA
+	depends on REMOTEPROC
+	depends on ARCH_QCOM || COMPILE_TEST
+	select ATH_COMMON
+	select QCOM_QMI_HELPERS
+	---help---
+	  This module adds support for Qualcomm Technologies 802.11ax family of
+	  chipsets.
+
+	  If you choose to build a module, it'll be called ath11k.
+
+config ATH11K_DEBUG
+	bool "QCA ath11k debugging"
+	depends on ATH11K
+	---help---
+	  Enables debug support
+
+	  If unsure, say Y to make it easier to debug problems.
+
+config ATH11K_DEBUGFS
+	bool "QCA ath11k debugfs support"
+	depends on ATH11K && DEBUG_FS
+	---help---
+	  Enable ath11k debugfs support
+
+	  If unsure, say Y to make it easier to debug problems.
+
+config ATH11K_TRACING
+	bool "ath11k tracing support"
+	depends on ATH11K && EVENT_TRACING
+	---help---
+	  Select this to use ath11k tracing infrastructure.

