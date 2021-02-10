Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1373931615D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbhBJIrD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:03 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:58058 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230196AbhBJInf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946584; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=p9ct0e2K+fGsSZ5H5jmyA1gY6fdoFbdvJP63mSfFcEE=; b=iqulUxaeXnlgZrjQjIbc8bJl8aixWKsRn6NwC56g01vDJZGG8az5QKj1g8Mp2Z5yofExieI7
 2ZKQA8Qht2ZjqmMYj4B2qal3I59yC3aHJQ4cBj4hkk9Q5kwzm8XXBxzR2kOWIwbppsG5A7v2
 IMMWP71+8GDTlwICzTGme6DlJ/w=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60239c72e3df861f4b3d212a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:26
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56505C43461; Wed, 10 Feb 2021 08:42:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F5EFC433C6;
        Wed, 10 Feb 2021 08:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F5EFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 01/11] ath11k: Refactor ath11k_msi_config
Date:   Wed, 10 Feb 2021 14:12:00 +0530
Message-Id: <1612946530-28504-2-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move ath11k_msi_config to array of structures to add multiple
pci devices support. No functional changes.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/pci.c | 39 ++++++++++++++++++++---------------
 drivers/net/wireless/ath/ath11k/pci.h |  1 +
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 78478b2b3ba5..0c6a6e7ef252 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -50,14 +50,16 @@ static const struct ath11k_bus_params ath11k_pci_bus_params = {
 	.fixed_mem_region = false,
 };
 
-static const struct ath11k_msi_config msi_config = {
-	.total_vectors = 32,
-	.total_users = 4,
-	.users = (struct ath11k_msi_user[]) {
-		{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
-		{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
-		{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
-		{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+static const struct ath11k_msi_config ath11k_msi_config[] = {
+	{
+		.total_vectors = 32,
+		.total_users = 4,
+		.users = (struct ath11k_msi_user[]) {
+			{ .name = "MHI", .num_vectors = 3, .base_vector = 0 },
+			{ .name = "CE", .num_vectors = 10, .base_vector = 3 },
+			{ .name = "WAKE", .num_vectors = 1, .base_vector = 13 },
+			{ .name = "DP", .num_vectors = 18, .base_vector = 14 },
+		},
 	},
 };
 
@@ -406,14 +408,15 @@ int ath11k_pci_get_user_msi_assignment(struct ath11k_pci *ab_pci, char *user_nam
 				       u32 *base_vector)
 {
 	struct ath11k_base *ab = ab_pci->ab;
+	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
 	int idx;
 
-	for (idx = 0; idx < msi_config.total_users; idx++) {
-		if (strcmp(user_name, msi_config.users[idx].name) == 0) {
-			*num_vectors = msi_config.users[idx].num_vectors;
-			*user_base_data = msi_config.users[idx].base_vector
+	for (idx = 0; idx < msi_config->total_users; idx++) {
+		if (strcmp(user_name, msi_config->users[idx].name) == 0) {
+			*num_vectors = msi_config->users[idx].num_vectors;
+			*user_base_data = msi_config->users[idx].base_vector
 				+ ab_pci->msi_ep_base_data;
-			*base_vector = msi_config.users[idx].base_vector;
+			*base_vector = msi_config->users[idx].base_vector;
 
 			ath11k_dbg(ab, ATH11K_DBG_PCI, "Assign MSI to user: %s, num_vectors: %d, user_base_data: %u, base_vector: %u\n",
 				   user_name, *num_vectors, *user_base_data,
@@ -760,17 +763,18 @@ static void ath11k_pci_ce_irqs_enable(struct ath11k_base *ab)
 static int ath11k_pci_enable_msi(struct ath11k_pci *ab_pci)
 {
 	struct ath11k_base *ab = ab_pci->ab;
+	const struct ath11k_msi_config *msi_config = ab_pci->msi_config;
 	struct msi_desc *msi_desc;
 	int num_vectors;
 	int ret;
 
 	num_vectors = pci_alloc_irq_vectors(ab_pci->pdev,
-					    msi_config.total_vectors,
-					    msi_config.total_vectors,
+					    msi_config->total_vectors,
+					    msi_config->total_vectors,
 					    PCI_IRQ_MSI);
-	if (num_vectors != msi_config.total_vectors) {
+	if (num_vectors != msi_config->total_vectors) {
 		ath11k_err(ab, "failed to get %d MSI vectors, only %d available",
-			   msi_config.total_vectors, num_vectors);
+			   msi_config->total_vectors, num_vectors);
 
 		if (num_vectors >= 0)
 			return -EINVAL;
@@ -1140,6 +1144,7 @@ static int ath11k_pci_probe(struct pci_dev *pdev,
 		goto err_pci_free_region;
 	}
 
+	ab_pci->msi_config = &ath11k_msi_config[0];
 	ret = ath11k_pci_enable_msi(ab_pci);
 	if (ret) {
 		ath11k_err(ab, "failed to enable msi: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/pci.h b/drivers/net/wireless/ath/ath11k/pci.h
index fe44d0dfce19..92eeb7c30546 100644
--- a/drivers/net/wireless/ath/ath11k/pci.h
+++ b/drivers/net/wireless/ath/ath11k/pci.h
@@ -73,6 +73,7 @@ struct ath11k_pci {
 	char amss_path[100];
 	u32 msi_ep_base_data;
 	struct mhi_controller *mhi_ctrl;
+	const struct ath11k_msi_config *msi_config;
 	unsigned long mhi_state;
 	u32 register_window;
 
-- 
2.7.4

