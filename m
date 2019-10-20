Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C45DDD8D
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfJTKEO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfJTKEO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3669660D70; Sun, 20 Oct 2019 10:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565854;
        bh=ZMOWSF4f8JcMYQEH4XdbuD4zQR3FaxHdXFkkr5fqeE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bHPjieRa6nxrmTvfUqvvPEUAq2nNHyBDX4wihrzmpr//dClFPzXBxG3ZRDi7QJJcy
         cvlHx0nDazOmTDRYwpBt9PtIiypOB0fbOsVknGoBGLQvziHsits2U24ijkyC51WVn3
         WfHiqL5vEz6cUfZrLWirX4jnI7f12isEUJac8p4k=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4B7060BE6;
        Sun, 20 Oct 2019 10:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565853;
        bh=ZMOWSF4f8JcMYQEH4XdbuD4zQR3FaxHdXFkkr5fqeE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PJyRVSlCahJ0HBeXW/CU/t5QD48FCSkIvj/HCPHvrEu8QQpE6cEKsxKDzNem65FUz
         XL1opdM+JTbBPwul0LP4HYADGJL9doJ2MBZm73NPPJGg5zSAQIxVWi//93dUyncGLM
         tIWHrDEyUke1QO5oztkl47WB5UDINgvLZJMr2GZU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4B7060BE6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 02/49] ath11k: add Kconfig
Date:   Sun, 20 Oct 2019 13:03:20 +0300
Message-Id: <1571565847-10338-3-git-send-email-kvalo@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/Kconfig | 35 +++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/Kconfig b/drivers/net/wireless/ath/ath11k/Kconfig
new file mode 100644
index 000000000000..1a73a1bf08f0
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
+	  Select this to ath11k use tracing infrastructure.

