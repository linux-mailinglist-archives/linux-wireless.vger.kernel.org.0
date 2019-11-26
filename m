Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637D3109CBC
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 12:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfKZLE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 06:04:59 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:51680
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727942AbfKZLE6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 06:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574766298;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=+zPUWAW8TqcLVPNAwwfq0f5YT8e5SBbgec/XOTI4xPU=;
        b=X2PQCRR8M89LliQKp7VwPPqFjyFMDV50g1PDaeuOLi6GXBHzx93q5aG9a0lgscT3
        +UgJjCQEwZwthT9Lo8FP4KJfq4YspT9uDNM8E1+ouNsxry7/HnT7HO598y6d1FPaBMf
        jyRStdrgP+8d0M0zDGDiQRMI/SBLz5wJAMaIO7ig=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574766298;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=+zPUWAW8TqcLVPNAwwfq0f5YT8e5SBbgec/XOTI4xPU=;
        b=WC15bSDLi4dTQdqJw0Iv8doGhHkgsxUK6LsGmL6pdZeenMMsg/9wKqMSIg07YWST
        bbo2UqhGwDJd88zzcVV6+d4c3YFF0r1yZPDNIfVlj7jFniVk+gTZUByTxY2hueW/Tya
        aIziv8nSmEOemEjioKQFbMNSORasi8jgKxRyp0JM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F39FC48B39
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 09/10] ath11k: Fixing TLV length issue in peer pktlog WMI command
Date:   Tue, 26 Nov 2019 11:04:58 +0000
Message-ID: <0101016ea762c38b-7904f80e-329c-4243-91cd-36e6f821dcd4-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
References: <1574766279-13105-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.26-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Vikas Patel <vikpatel@codeaurora.org>

TLV length was 0 for TLV tag 'WMI_TAG_ARRAY_STRUCT' causing
Q6 to crash when trying to configure pktlog filter via debugfs.

Signed-off-by: Vikas Patel <vikpatel@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index ccebf7ce420a..aae6e76330da 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2329,7 +2329,7 @@ int ath11k_wmi_pdev_peer_pktlog_filter(struct ath11k *ar, u8 *addr, u8 enable)
 
 	tlv = ptr;
 	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_STRUCT) |
-		      FIELD_PREP(WMI_TLV_LEN, 0);
+		      FIELD_PREP(WMI_TLV_LEN, sizeof(*info));
 
 	ptr += TLV_HDR_SIZE;
 	info = ptr;
-- 
2.7.4

