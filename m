Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87F409B39
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Sep 2021 19:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239261AbhIMRwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Sep 2021 13:52:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:11760 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239220AbhIMRwc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Sep 2021 13:52:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631555476; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=olKk6Vk9H6023FzC/tK7LvtFJsnhR6WnXnQz/7wxwxQ=; b=s/EqHWoF4QbgeJ4hBsNnlVHDynSZG8q6bBiHnN6hE6gjhrC8aV2ltaNru5X3MG9CDE1L6p09
 bfmvzKWM3PnFvLRCkSwdTAsNiGbHk+u4rg1nySzyiwdwSVzAX4AjBlvtDuCIQpQLAiDXKhbf
 WdmIHODIrfBcX5GeeJRzgFNRn04=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 613f8f81e0f78151d6babd47 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 13 Sep 2021 17:50:57
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 96C86C43617; Mon, 13 Sep 2021 17:50:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-72-211-nat.elisa-mobile.fi [85.76.72.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 66B67C4338F;
        Mon, 13 Sep 2021 17:50:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 66B67C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Abinaya Kalaiselvan <akalaise@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] ath10k: Fix device boot error
Date:   Mon, 13 Sep 2021 20:50:48 +0300
Message-Id: <20210913175048.192812-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Abinaya Kalaiselvan <akalaise@codeaurora.org>

mask value ATH10K_FW_CRASH_DUMP_RAM_DATA is not mandatory to get iram
mem layout. So introduced ath10k_coredump_get_hw_mem_layout to copy
hardware memory layout.

This fixes the below boot error:
[   17.468882] ath10k_pci 0000:06:00.0: failed to copy target iram contents: -12
[   17.513925] ath10k_pci 0000:06:00.0: could not init core (-12)
[   17.517635] ath10k_pci 0000:06:00.0: could not probe fw (-12)

Tested-on: QCA9984 X86 10.4-3.9.0.2-00139

Fixes: 9af7c32ceca8 ("ath10k: add target IRAM recovery feature support")
Signed-off-by: Abinaya Kalaiselvan <akalaise@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c     |  2 +-
 drivers/net/wireless/ath/ath10k/coredump.c | 11 ++++++++---
 drivers/net/wireless/ath/ath10k/coredump.h |  1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 2f9be182fbfb..cbcf3aa3e92c 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2690,7 +2690,7 @@ static int ath10k_core_copy_target_iram(struct ath10k *ar)
 	int i, ret;
 	u32 len, remaining_len;
 
-	hw_mem = ath10k_coredump_get_mem_layout(ar);
+	hw_mem = ath10k_coredump_get_hw_mem_layout(ar);
 	if (!hw_mem)
 		return -ENOMEM;
 
diff --git a/drivers/net/wireless/ath/ath10k/coredump.c b/drivers/net/wireless/ath/ath10k/coredump.c
index 7eb72290a925..f8419a707b89 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.c
+++ b/drivers/net/wireless/ath/ath10k/coredump.c
@@ -1447,11 +1447,17 @@ static u32 ath10k_coredump_get_ramdump_size(struct ath10k *ar)
 
 const struct ath10k_hw_mem_layout *ath10k_coredump_get_mem_layout(struct ath10k *ar)
 {
-	int i;
-
 	if (!test_bit(ATH10K_FW_CRASH_DUMP_RAM_DATA, &ath10k_coredump_mask))
 		return NULL;
 
+	return ath10k_coredump_get_hw_mem_layout(ar);
+}
+EXPORT_SYMBOL(ath10k_coredump_get_mem_layout);
+
+const struct ath10k_hw_mem_layout *ath10k_coredump_get_hw_mem_layout(struct ath10k *ar)
+{
+	int i;
+
 	if (WARN_ON(ar->target_version == 0))
 		return NULL;
 
@@ -1464,7 +1470,6 @@ const struct ath10k_hw_mem_layout *ath10k_coredump_get_mem_layout(struct ath10k
 
 	return NULL;
 }
-EXPORT_SYMBOL(ath10k_coredump_get_mem_layout);
 
 struct ath10k_fw_crash_data *ath10k_coredump_new(struct ath10k *ar)
 {
diff --git a/drivers/net/wireless/ath/ath10k/coredump.h b/drivers/net/wireless/ath/ath10k/coredump.h
index 42404e246e0e..7f4849c69ce8 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.h
+++ b/drivers/net/wireless/ath/ath10k/coredump.h
@@ -177,6 +177,7 @@ void ath10k_coredump_unregister(struct ath10k *ar);
 void ath10k_coredump_destroy(struct ath10k *ar);
 
 const struct ath10k_hw_mem_layout *ath10k_coredump_get_mem_layout(struct ath10k *ar);
+const struct ath10k_hw_mem_layout *ath10k_coredump_get_hw_mem_layout(struct ath10k *ar);
 
 #else /* CONFIG_DEV_COREDUMP */
 
-- 
2.25.1

