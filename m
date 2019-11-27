Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF1010B0DD
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0OIs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:48 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:60528
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726320AbfK0OIr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863727;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=pqqQEhUKPOM5Jw7oTsg59BlpmuhwLI8GvuhJpHwNMxE=;
        b=YVTwBeJ3uukCNuqUjRtJfmTzKLyi8jIxIQGWhten5d45FhPI8T22w4o98OvTEqsX
        PzM6+KMqNjnDMvEH5DXJBfdmvOQEGdCf1NBQFD5VDpMe6zSgiNUiseLOXLiLxN68+em
        bC4EtSz6165G1F/TOzOlCyrZmPw8oQudxOcGRqZY=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863727;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=pqqQEhUKPOM5Jw7oTsg59BlpmuhwLI8GvuhJpHwNMxE=;
        b=TVfPk1lJrdBnJeCPLL4ngTB3vwM3sKaCI7+17oTnffaA2ba/m7SGczhTPtN54ttj
        3Tb9eAYHZpmaZ2cfvbsWedlM70P1HheaaX4njfK8cW66P3CYbiWt2GPqseXh+QdekYo
        RgPgVlUoBXJtkbgrqzOPlZ8w1fit6W1j1kOrQJlI=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCC22C447A4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 02/10] ath11k: qmi clean up ce and HTC service config update
Date:   Wed, 27 Nov 2019 14:08:47 +0000
Message-ID: <0101016ead316a3c-16e85e9d-7e5b-4724-8c32-db976acc744a-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Copy CE and htc service configs for all pipes.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 9 ++++-----
 drivers/net/wireless/ath/ath11k/qmi.h | 4 ++--
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f80173b8afc6..e7e3e64c07aa 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -635,11 +635,10 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 {
 	struct ath11k_qmi_ce_cfg *cfg = &ab->qmi.ce_cfg;
 
-	cfg->tgt_ce = (u8 *)target_ce_config_wlan;
-	cfg->tgt_ce_len = sizeof(target_ce_config_wlan);
-
-	cfg->svc_to_ce_map = (u8 *)target_service_to_ce_map_wlan;
-	cfg->svc_to_ce_map_len = sizeof(target_service_to_ce_map_wlan);
+	cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
+	cfg->tgt_ce = target_ce_config_wlan;
+	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
+	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
 }
 
 static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index df0685564e21..3f7db642d869 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -66,9 +66,9 @@ struct ath11k_qmi_driver_event {
 };
 
 struct ath11k_qmi_ce_cfg {
-	const u8 *tgt_ce;
+	const struct ce_pipe_config *tgt_ce;
 	int tgt_ce_len;
-	const u8 *svc_to_ce_map;
+	const struct service_to_pipe *svc_to_ce_map;
 	int svc_to_ce_map_len;
 	const u8 *shadow_reg;
 	int shadow_reg_len;
-- 
2.7.4

