Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB0E10C4E2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2019 09:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfK1IVv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Nov 2019 03:21:51 -0500
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:41290
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727234AbfK1IVu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Nov 2019 03:21:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574929310;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=L/0Xv8IPDrrhX6sor/2ApevdfjypRx0hQPc9cSJK/yE=;
        b=HwB3yQbxNtrx3iw7tNyUzQUdQ7nmdDgTiADyZlMHNP8iVoYcwg5mmxcvFwpO2fc+
        0Gs2UJ8EWGt6cbmPQjYa8PN8/T4AZrgIGXPGxBPDcQEln607Bx5FnUkDx0+vSwHR9Z0
        8ArI4J5h8jrUYkGnqk4VUniffrVkG69RMPqBMFS4=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574929310;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=L/0Xv8IPDrrhX6sor/2ApevdfjypRx0hQPc9cSJK/yE=;
        b=YFDBFDs8yzmfUbsIvh6h3r5iHt1YOuYiY8zeYh4PJ5qzsbuQVxX7zHLiOYMBu0J9
        Ne0UcuDsmYeTTm3FZBTAvSL0rYxgePneA+rfWP8PFwpDoGYWS1CdhayCd6bCsqLv/Hl
        s/KB5b4o06nRmTGoqzccenbqQfXkUDwpaOOM8m/Q=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 74F66C447B4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 4/9] ath11k: fix vht guard interval mapping
Date:   Thu, 28 Nov 2019 08:21:50 +0000
Message-ID: <0101016eb11a212a-91838b15-bf0c-41df-ae5d-7fa19bf5d263-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
References: <1574929300-31782-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.28-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Manikanta Pubbisetty <mpubbise@codeaurora.org>

Guard interval value which comes from VHT_SIG_A TLV has a mapping
where value 0 corresponds to LGI, 1 and 3 corresponds to SGI.

Value 3 which is SGI(0.4us) in VHT was incorrectly mapped to a GI
of 3.2us(only applicable in HE) resulting in incorrect rx GI stats.
Fixing the mapping.

Signed-off-by: Manikanta Pubbisetty <mpubbise@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal_rx.c | 16 +++++++++++++---
 drivers/net/wireless/ath/ath11k/hal_rx.h |  6 ++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 6168a4eb0c0b..9e0f8064e427 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -920,6 +920,7 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 			(struct hal_rx_vht_sig_a_info *)tlv_data;
 		u32 nsts;
 		u32 group_id;
+		u8 gi_setting;
 
 		info0 = __le32_to_cpu(vht_sig->info0);
 		info1 = __le32_to_cpu(vht_sig->info1);
@@ -928,9 +929,18 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 					    info0);
 		ppdu_info->mcs = FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_MCS,
 					   info1);
-		ppdu_info->gi =
-			FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_GI_SETTING,
-				  info1);
+		gi_setting = FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO1_GI_SETTING,
+				       info1);
+		switch (gi_setting) {
+		case HAL_RX_VHT_SIG_A_NORMAL_GI:
+			ppdu_info->gi = HAL_RX_GI_0_8_US;
+			break;
+		case HAL_RX_VHT_SIG_A_SHORT_GI:
+		case HAL_RX_VHT_SIG_A_SHORT_GI_AMBIGUITY:
+			ppdu_info->gi = HAL_RX_GI_0_4_US;
+			break;
+		}
+
 		ppdu_info->is_stbc = info0 & HAL_RX_VHT_SIG_A_INFO_INFO0_STBC;
 		nsts = FIELD_GET(HAL_RX_VHT_SIG_A_INFO_INFO0_NSTS, info0);
 		if (ppdu_info->is_stbc && nsts > 0)
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 2271bf56183b..bb022c781c48 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -189,6 +189,12 @@ struct hal_rx_vht_sig_a_info {
 	__le32 info1;
 } __packed;
 
+enum hal_rx_vht_sig_a_gi_setting {
+	HAL_RX_VHT_SIG_A_NORMAL_GI = 0,
+	HAL_RX_VHT_SIG_A_SHORT_GI = 1,
+	HAL_RX_VHT_SIG_A_SHORT_GI_AMBIGUITY = 3,
+};
+
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_MCS	GENMASK(6, 3)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_DCM		BIT(7)
 #define HAL_RX_HE_SIG_A_SU_INFO_INFO0_TRANSMIT_BW	GENMASK(20, 19)
-- 
2.7.4

