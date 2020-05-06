Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E08E1C6D6C
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgEFJoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:44:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57770 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729173AbgEFJo3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:44:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588758269; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FbK27ARYToFqXc7p3XnUI+PL9RhIUciTrgQKW/FbKiA=; b=payNWQalEEfWscc6BRqISeUvPIklrbCNoDWMWHCVfUZdKf5A+dzeaOdxPfr9WXrZq/NXsvi3
 ZScaxi7OHp2m+P5rhwOpb5dz5L1wqv5FgULuoyYGX/jlj55zaHaweoZ5BVT9kTpoxb80jsws
 ZaKKsLL00YBVJ5Yll0FSPaxFhuc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb286ef.7f2fa15d3960-smtp-out-n02;
 Wed, 06 May 2020 09:44:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2A4D2C433D2; Wed,  6 May 2020 09:44:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 065D2C433BA;
        Wed,  6 May 2020 09:44:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 065D2C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 3/3] ath11k: Remove bus layer includes from upper layer
Date:   Wed,  6 May 2020 15:14:00 +0530
Message-Id: <20200506094400.4740-4-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200506094400.4740-1-govinds@codeaurora.org>
References: <20200506094400.4740-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bus level header files needs to be abstracted by upper
layer. Remove bus layer includes by adding appropriate header
files.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c     | 1 -
 drivers/net/wireless/ath/ath11k/hal.c      | 1 -
 drivers/net/wireless/ath/ath11k/hal_desc.h | 2 ++
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 1 -
 drivers/net/wireless/ath/ath11k/hal_tx.c   | 2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h   | 1 +
 drivers/net/wireless/ath/ath11k/htc.c      | 1 -
 7 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index a91eae6a4e57..02501cc154fe 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -7,7 +7,6 @@
 #include <linux/slab.h>
 #include <linux/remoteproc.h>
 #include <linux/firmware.h>
-#include "ahb.h"
 #include "core.h"
 #include "dp_tx.h"
 #include "dp_rx.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index 6d937674215e..d63785178afa 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
 #include <linux/dma-mapping.h>
-#include "ahb.h"
 #include "hal_tx.h"
 #include "debug.h"
 #include "hal_desc.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 5e200380cca4..ab73c813fb45 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
+#include "core.h"
+
 #ifndef ATH11K_HAL_DESC_H
 #define ATH11K_HAL_DESC_H
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 69b0248a7baf..129c9e1efeb9 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
 
-#include "ahb.h"
 #include "debug.h"
 #include "hal.h"
 #include "hal_tx.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index b364c077c1f7..81937c29ffca 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
  */
 
-#include "ahb.h"
+#include "hal_desc.h"
 #include "hal.h"
 #include "hal_tx.h"
 #include "hif.h"
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index ce48a61bfb66..d4760a20fdac 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -7,6 +7,7 @@
 #define ATH11K_HAL_TX_H
 
 #include "hal_desc.h"
+#include "core.h"
 
 #define HAL_TX_ADDRX_EN			1
 #define HAL_TX_ADDRY_EN			2
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 1909fc3287ba..ad13c648b679 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -5,7 +5,6 @@
 #include <linux/skbuff.h>
 #include <linux/ctype.h>
 
-#include "ahb.h"
 #include "debug.h"
 #include "hif.h"
 
-- 
2.22.0
