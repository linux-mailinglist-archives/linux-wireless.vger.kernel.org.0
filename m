Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3BA55288
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfFYOwb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 10:52:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46758 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbfFYOwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 10:52:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B399E602F8; Tue, 25 Jun 2019 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561474349;
        bh=q7FXiTJ7x3yscVLiqv7jrqv+PnKOgoWcGZTbA55x5EI=;
        h=From:To:Subject:Date:From;
        b=FaWxr6LP3ddk/yprx+dcQXVAeIJ3ZUQTZ5zg0b0uw4ad+wtbGdiQx1HH9SePNnUEo
         hQNptAFmrCtxkVQFMqrSo7KjuOzTb+ZRsoYK9viPvY4xgW3sw8mZ9RygHHUIgt554d
         Po2P9dIqMJnKmxYoco51Mxy1PW9YATnzQGN2QiiA=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61FEE60256
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2019 14:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561474349;
        bh=q7FXiTJ7x3yscVLiqv7jrqv+PnKOgoWcGZTbA55x5EI=;
        h=From:To:Subject:Date:From;
        b=FaWxr6LP3ddk/yprx+dcQXVAeIJ3ZUQTZ5zg0b0uw4ad+wtbGdiQx1HH9SePNnUEo
         hQNptAFmrCtxkVQFMqrSo7KjuOzTb+ZRsoYK9viPvY4xgW3sw8mZ9RygHHUIgt554d
         Po2P9dIqMJnKmxYoco51Mxy1PW9YATnzQGN2QiiA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61FEE60256
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath: fix SPDX tags
Date:   Tue, 25 Jun 2019 17:52:25 +0300
Message-Id: <1561474345-1439-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Commit ec8f24b7faaf ("treewide: Add SPDX license identifier -
Makefile/Kconfig") marked various Makefiles and Kconfig files within ath
directories as GPL-2.0. But these modules and drivers are actually ISC:

* ath
* ar5523
* ath10k
* ath5k
* ath6kl
* ath9k
* wcn36xx
* wil6210

Fix SPDX tags accordingly.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/Kconfig          | 2 +-
 drivers/net/wireless/ath/Makefile         | 2 +-
 drivers/net/wireless/ath/ar5523/Kconfig   | 2 +-
 drivers/net/wireless/ath/ar5523/Makefile  | 2 +-
 drivers/net/wireless/ath/ath10k/Kconfig   | 2 +-
 drivers/net/wireless/ath/ath5k/Kconfig    | 2 +-
 drivers/net/wireless/ath/ath5k/Makefile   | 2 +-
 drivers/net/wireless/ath/ath6kl/Kconfig   | 2 +-
 drivers/net/wireless/ath/ath9k/Kconfig    | 2 +-
 drivers/net/wireless/ath/ath9k/Makefile   | 2 +-
 drivers/net/wireless/ath/wcn36xx/Kconfig  | 2 +-
 drivers/net/wireless/ath/wcn36xx/Makefile | 2 +-
 drivers/net/wireless/ath/wil6210/Makefile | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/Kconfig b/drivers/net/wireless/ath/Kconfig
index af2049e99188..d98d6ac90f3d 100644
--- a/drivers/net/wireless/ath/Kconfig
+++ b/drivers/net/wireless/ath/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config ATH_COMMON
 	tristate
 
diff --git a/drivers/net/wireless/ath/Makefile b/drivers/net/wireless/ath/Makefile
index e4e460b5498e..ee2b2431e5a3 100644
--- a/drivers/net/wireless/ath/Makefile
+++ b/drivers/net/wireless/ath/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: ISC
 obj-$(CONFIG_ATH5K)		+= ath5k/
 obj-$(CONFIG_ATH9K_HW)		+= ath9k/
 obj-$(CONFIG_CARL9170)		+= carl9170/
diff --git a/drivers/net/wireless/ath/ar5523/Kconfig b/drivers/net/wireless/ath/ar5523/Kconfig
index 75fc66983da5..41d3c9a48b08 100644
--- a/drivers/net/wireless/ath/ar5523/Kconfig
+++ b/drivers/net/wireless/ath/ar5523/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config AR5523
        tristate "Atheros AR5523 wireless driver support"
        depends on MAC80211 && USB
diff --git a/drivers/net/wireless/ath/ar5523/Makefile b/drivers/net/wireless/ath/ar5523/Makefile
index 84fc88aa109e..34efa5772096 100644
--- a/drivers/net/wireless/ath/ar5523/Makefile
+++ b/drivers/net/wireless/ath/ar5523/Makefile
@@ -1,2 +1,2 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 obj-$(CONFIG_AR5523)   := ar5523.o
diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index 3522f251fa7f..6b3ff02a373d 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config ATH10K
 	tristate "Atheros 802.11ac wireless cards support"
 	depends on MAC80211 && HAS_DMA
diff --git a/drivers/net/wireless/ath/ath5k/Kconfig b/drivers/net/wireless/ath/ath5k/Kconfig
index c587146795f6..802f8f87773a 100644
--- a/drivers/net/wireless/ath/ath5k/Kconfig
+++ b/drivers/net/wireless/ath/ath5k/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config ATH5K
 	tristate "Atheros 5xxx wireless cards support"
 	depends on (PCI || ATH25) && MAC80211
diff --git a/drivers/net/wireless/ath/ath5k/Makefile b/drivers/net/wireless/ath/ath5k/Makefile
index a8724eee21f8..78f318d49af5 100644
--- a/drivers/net/wireless/ath/ath5k/Makefile
+++ b/drivers/net/wireless/ath/ath5k/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: ISC
 ath5k-y				+= caps.o
 ath5k-y				+= initvals.o
 ath5k-y				+= eeprom.o
diff --git a/drivers/net/wireless/ath/ath6kl/Kconfig b/drivers/net/wireless/ath/ath6kl/Kconfig
index 2b27a87e74f5..dcf8ca0dcc52 100644
--- a/drivers/net/wireless/ath/ath6kl/Kconfig
+++ b/drivers/net/wireless/ath/ath6kl/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config ATH6KL
 	tristate "Atheros mobile chipsets support"
 	depends on CFG80211
diff --git a/drivers/net/wireless/ath/ath9k/Kconfig b/drivers/net/wireless/ath/ath9k/Kconfig
index a1ef8769983a..5601cfd6a293 100644
--- a/drivers/net/wireless/ath/ath9k/Kconfig
+++ b/drivers/net/wireless/ath/ath9k/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config ATH9K_HW
 	tristate
 config ATH9K_COMMON
diff --git a/drivers/net/wireless/ath/ath9k/Makefile b/drivers/net/wireless/ath/ath9k/Makefile
index f71b2ad8275c..15af0a836925 100644
--- a/drivers/net/wireless/ath/ath9k/Makefile
+++ b/drivers/net/wireless/ath/ath9k/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: ISC
 ath9k-y +=	beacon.o \
 		gpio.o \
 		init.o \
diff --git a/drivers/net/wireless/ath/wcn36xx/Kconfig b/drivers/net/wireless/ath/wcn36xx/Kconfig
index 4ab2d59ff2ca..a4b153470a2c 100644
--- a/drivers/net/wireless/ath/wcn36xx/Kconfig
+++ b/drivers/net/wireless/ath/wcn36xx/Kconfig
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0-only
+# SPDX-License-Identifier: ISC
 config WCN36XX
 	tristate "Qualcomm Atheros WCN3660/3680 support"
 	depends on MAC80211 && HAS_DMA
diff --git a/drivers/net/wireless/ath/wcn36xx/Makefile b/drivers/net/wireless/ath/wcn36xx/Makefile
index 582049f65735..27413703ad69 100644
--- a/drivers/net/wireless/ath/wcn36xx/Makefile
+++ b/drivers/net/wireless/ath/wcn36xx/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: ISC
 obj-$(CONFIG_WCN36XX) := wcn36xx.o
 wcn36xx-y +=   main.o \
                dxe.o \
diff --git a/drivers/net/wireless/ath/wil6210/Makefile b/drivers/net/wireless/ath/wil6210/Makefile
index d3d61ae459e2..53a0d995ddb0 100644
--- a/drivers/net/wireless/ath/wil6210/Makefile
+++ b/drivers/net/wireless/ath/wil6210/Makefile
@@ -1,4 +1,4 @@
-# SPDX-License-Identifier: GPL-2.0
+# SPDX-License-Identifier: ISC
 obj-$(CONFIG_WIL6210) += wil6210.o
 
 wil6210-y := main.o
-- 
2.7.4

