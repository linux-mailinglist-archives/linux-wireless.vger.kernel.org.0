Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7B10B0E3
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfK0OI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:58 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:45904
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbfK0OI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863738;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=NfS6fw99VfKszYydCWk9SXcQTG9/YvMzDDaQzNXQabQ=;
        b=VGksI8XOOduic8HzUIZzsIftXM1VfNQd8kiKPKvg6U48B/8zi0bWmyMQh3cSB7Ln
        bnQArR5MTjuuemf6BPJXW2fIGKkBT0m0TNCks52VfPwaCyA8lEAsACrD+/gNXBElynm
        OimjpgBt+sumONMFzujoSUAODwKqFZpMmRizhz9g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863738;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=NfS6fw99VfKszYydCWk9SXcQTG9/YvMzDDaQzNXQabQ=;
        b=hVUYQgujBmUzJm+ACwUg/1Y7gtAMlkLWvhkpNrDjYrUH5Pgknwx3lJDwM6gTtmue
        pkZiOQ6zyQ+KQcaYx2e1kqCw7ZKreCFZjX9MlomZxD6KSqZzcpe4CQSdaFdlhKGw5VL
        6MPdS4+hMm068TrVsMgOwLAURZ1oIU1vcssH0msc=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A84E5C36E81
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 09/10] ath11k: unlock mutex during failure in qmi fw ready
Date:   Wed, 27 Nov 2019 14:08:58 +0000
Message-ID: <0101016ead319429-0b39c949-18fb-40c8-8898-ec92d6a61ff7-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govindaraj Saminathan <gsamin@codeaurora.org>

qmi firmware ready event start to initialize the core modules and
the sequence executed with mutex lock. In case of any failure
mutex should be unlocked otherwise it will hang during the recovery.

Signed-off-by: Govindaraj Saminathan <gsamin@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index b0c71b5879b1..37d4ecb458db 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -539,6 +539,7 @@ int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab)
 	ath11k_core_stop(ab);
 err_dp_free:
 	ath11k_dp_free(ab);
+	mutex_unlock(&ab->core_lock);
 	return ret;
 }
 
-- 
2.7.4

