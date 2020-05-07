Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD561C81E1
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 07:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgEGFxc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 01:53:32 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:61617 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgEGFxc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 01:53:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588830811; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=PH/1SM3VfOcjwxZHWjLJ4XuFcgxUfiT6neS3TaZZk98=; b=qIvgkJwKIPymTRqJJLqJMm/DUWWNHNtRqEC8qPenaf2mr8sOsQVCmTRz5gJwW9QoDRAoPt2v
 8qHAAvVEEeOFZJCPHoGNzhme16QDUi48a9fruA58e00p+lrswaIWCV8+g0zXFllHJhp7lYQs
 872S6YvwfP9sy5MwuL1O+5jl5jg=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3a25a.7f82d4100a08-smtp-out-n05;
 Thu, 07 May 2020 05:53:30 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CF9DCC433F2; Thu,  7 May 2020 05:53:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42F10C433BA;
        Thu,  7 May 2020 05:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42F10C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH] ath10k: Remove experimental tag from ath10k Kconfig
Date:   Thu,  7 May 2020 11:23:24 +0530
Message-Id: <20200507055324.15564-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath10k(sdio/snoc) is no longer experimental.
Remove experimental tag for SDIO/SNOC from ath10k Kconfig.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/Kconfig | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index 6b3ff02a373d..b99fd0eff994 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -28,11 +28,10 @@ config ATH10K_AHB
 	  This module adds support for AHB bus
 
 config ATH10K_SDIO
-	tristate "Atheros ath10k SDIO support (EXPERIMENTAL)"
+	tristate "Atheros ath10k SDIO support"
 	depends on ATH10K && MMC
 	---help---
-	  This module adds experimental support for SDIO/MMC bus. Currently
-	  work in progress and will not fully work.
+	  This module adds support for SDIO/MMC bus.
 
 config ATH10K_USB
 	tristate "Atheros ath10k USB support (EXPERIMENTAL)"
@@ -42,7 +41,7 @@ config ATH10K_USB
 	  work in progress and will not fully work.
 
 config ATH10K_SNOC
-	tristate "Qualcomm ath10k SNOC support (EXPERIMENTAL)"
+	tristate "Qualcomm ath10k SNOC support"
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
 	select QCOM_QMI_HELPERS
-- 
2.22.0
