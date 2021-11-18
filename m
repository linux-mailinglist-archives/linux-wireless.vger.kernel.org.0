Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D899F455F99
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 16:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhKRPfw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 10:35:52 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:23752 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232226AbhKRPfv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 10:35:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637249571; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=NgvtXY9KWVGF6KT9hm449US8KRw0C+HqpFgweiRfv2s=; b=MaGDI9i8reEvH9s+JymOrC0L5QE9w/E5jNfmThVJgOoRBfRi+hGGmE/WvXzKrFnTFD5kzdkM
 I3aayRpFAA+6ovEy7q5fLpzzdLhhWk17IZ3i2JNFaX8LWC1CbBWjW+kclJDfj41PUZT52Ty3
 ucHHd61JaljR0ZP5qcW98XV5YFY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61967222638a2f4d61428a62 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Nov 2021 15:32:50
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7662AC4360C; Thu, 18 Nov 2021 15:32:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA322C4338F;
        Thu, 18 Nov 2021 15:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BA322C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH] ath11k: Use host CE parameters for CE interrupts configuration
Date:   Thu, 18 Nov 2021 21:02:38 +0530
Message-Id: <1637249558-12793-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

CE interrupt configuration uses host ce parameters to assign/free
interrupts. Use host ce parameters to enable/disable interrupts.
This patch fixes below BUG,

BUG: KASAN: global-out-of-bounds in 0xffffffbffdfb035c at addr
ffffffbffde6eeac
 Read of size 4 by task kworker/u8:2/132
 Address belongs to variable ath11k_core_qmi_firmware_ready+0x1b0/0x5bc [ath11k]

OOB is due to ath11k_ahb_ce_irqs_enable() iterates ce_count(which is 12)
times and accessing 12th element in target_ce_config
(which has only 11 elements) from ath11k_ahb_ce_irq_enable().

With this change host ce configs are used to enable/disable interrupts.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00471-QCAHKSWPL_SILICONZ-1

Fixes: 967c1d1131fa ("ath11k: move target ce configs to hw_params")

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 8c9c781afc3e..096c502cce38 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -206,13 +206,13 @@ static void ath11k_ahb_clearbit32(struct ath11k_base *ab, u8 bit, u32 offset)
 
 static void ath11k_ahb_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 {
-	const struct ce_pipe_config *ce_config;
+	const struct ce_attr *ce_attr;
 
-	ce_config = &ab->hw_params.target_ce_config[ce_id];
-	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_OUT)
+	ce_attr = &ab->hw_params.host_ce_config[ce_id];
+	if (ce_attr->src_nentries)
 		ath11k_ahb_setbit32(ab, ce_id, CE_HOST_IE_ADDRESS);
 
-	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_IN) {
+	if (ce_attr->dest_nentries) {
 		ath11k_ahb_setbit32(ab, ce_id, CE_HOST_IE_2_ADDRESS);
 		ath11k_ahb_setbit32(ab, ce_id + CE_HOST_IE_3_SHIFT,
 				    CE_HOST_IE_3_ADDRESS);
@@ -221,13 +221,13 @@ static void ath11k_ahb_ce_irq_enable(struct ath11k_base *ab, u16 ce_id)
 
 static void ath11k_ahb_ce_irq_disable(struct ath11k_base *ab, u16 ce_id)
 {
-	const struct ce_pipe_config *ce_config;
+	const struct ce_attr *ce_attr;
 
-	ce_config = &ab->hw_params.target_ce_config[ce_id];
-	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_OUT)
+	ce_attr = &ab->hw_params.host_ce_config[ce_id];
+	if (ce_attr->src_nentries)
 		ath11k_ahb_clearbit32(ab, ce_id, CE_HOST_IE_ADDRESS);
 
-	if (__le32_to_cpu(ce_config->pipedir) & PIPEDIR_IN) {
+	if (ce_attr->dest_nentries) {
 		ath11k_ahb_clearbit32(ab, ce_id, CE_HOST_IE_2_ADDRESS);
 		ath11k_ahb_clearbit32(ab, ce_id + CE_HOST_IE_3_SHIFT,
 				      CE_HOST_IE_3_ADDRESS);
-- 
2.7.4

