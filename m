Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D391C6D6A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgEFJoY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:44:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55629 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729173AbgEFJoY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:44:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588758264; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ldGxFyeS8w2TxAd5to1VMFoDolf6LaZy8kG99UHxfhA=; b=FFjSq6dyJV2D4YHbrsCSFpHBG2QA9ziYZ8T28X5Owe4HLSWO5lo7zyE0FNYQHfBXn3WJC6vn
 FZo4xlpeM07j/ELzcK9MsliAIa7b76LsukSECtost6iER2KzPNAu/bCm2cwUJ9f4U4dKvKtv
 HSsDz/oDMXBNnWb8clawVLDvGtk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb286eb.7f1e19778298-smtp-out-n04;
 Wed, 06 May 2020 09:44:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEC6CC432C2; Wed,  6 May 2020 09:44:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 09B8FC433F2;
        Wed,  6 May 2020 09:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 09B8FC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 2/3] ath11k: Add drv private for bus opaque struct
Date:   Wed,  6 May 2020 15:13:59 +0530
Message-Id: <20200506094400.4740-3-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200506094400.4740-1-govinds@codeaurora.org>
References: <20200506094400.4740-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add drv private opaque structure to have bus level
structure for multibus support.

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  | 2 +-
 drivers/net/wireless/ath/ath11k/core.c | 5 +++--
 drivers/net/wireless/ath/ath11k/core.h | 6 +++++-
 drivers/net/wireless/ath/ath11k/hw.h   | 5 +++++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index b625b7c3ad32..19cda6bfe9b7 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -932,7 +932,7 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ab = ath11k_core_alloc(&pdev->dev);
+	ab = ath11k_core_alloc(&pdev->dev, 0, ATH11K_BUS_AHB);
 	if (!ab) {
 		dev_err(&pdev->dev, "failed to allocate ath11k base\n");
 		return -ENOMEM;
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 985ea3bcadb9..a91eae6a4e57 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -756,11 +756,12 @@ void ath11k_core_free(struct ath11k_base *ab)
 	kfree(ab);
 }
 
-struct ath11k_base *ath11k_core_alloc(struct device *dev)
+struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
+				      enum ath11k_bus bus)
 {
 	struct ath11k_base *ab;
 
-	ab = kzalloc(sizeof(*ab), GFP_KERNEL);
+	ab = kzalloc(sizeof(*ab) + priv_size, GFP_KERNEL);
 	if (!ab)
 		return NULL;
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index fdc09995609b..b3b210a22b25 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -662,6 +662,9 @@ struct ath11k_base {
 
 	/* Round robbin based TCL ring selector */
 	atomic_t tcl_ring_selector;
+
+	/* must be last */
+	u8 drv_priv[0] __aligned(sizeof(void *));
 };
 
 struct ath11k_fw_stats_pdev {
@@ -798,7 +801,8 @@ struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab, int peer_id);
 int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab);
 int ath11k_core_init(struct ath11k_base *ath11k);
 void ath11k_core_deinit(struct ath11k_base *ath11k);
-struct ath11k_base *ath11k_core_alloc(struct device *dev);
+struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
+				      enum ath11k_bus bus);
 void ath11k_core_free(struct ath11k_base *ath11k);
 int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
 			  struct ath11k_board_data *bd);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 9973477ae373..e9a577f561f7 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -99,6 +99,11 @@ enum ath11k_hw_rate_ofdm {
 	ATH11K_HW_RATE_OFDM_9M,
 };
 
+enum ath11k_bus {
+	ATH11K_BUS_AHB,
+	ATH11K_BUS_PCI,
+};
+
 struct ath11k_hw_params {
 	const char *name;
 	struct {
-- 
2.22.0
