Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73641FB341
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgFPOBn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:43 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44251 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729239AbgFPOBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316099; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=PUqS84rDgrBE85Qc1ahBL7sfRN3l9bmbBg537ZjDNOc=; b=HywVPMtKBliKBq+hHdpLaDQb6FxCIGvEYpYX/qL+2W60ZaZkxbu68cL2j1e0WAHgTGj7RaDy
 PQlJRqQa34qESUVSjfO2fsk86PXcaAyQvcqLQxeURUXnHIhOMfQ7DFDik3IzXCsipQRNGrEu
 5eaZWC3ZByq0SH3fUiELcjzzcIw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ee8d0a44c9690533aa3ac3b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:08
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 762C6C433CA; Tue, 16 Jun 2020 14:01:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B59BC433C8;
        Tue, 16 Jun 2020 14:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B59BC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/12] ath11k: define max_radios in hw_params
Date:   Tue, 16 Jun 2020 17:00:46 +0300
Message-Id: <1592316055-24958-4-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

IPQ6018 needs different value for max_radios so make it configurable via hw_params.

No functional changes. Compile tested only.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  | 1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 drivers/net/wireless/ath/ath11k/htc.c   | 2 +-
 drivers/net/wireless/ath/ath11k/hw.h    | 1 +
 drivers/net/wireless/ath/ath11k/reg.c   | 2 +-
 drivers/net/wireless/ath/ath11k/wmi.c   | 4 ++--
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 92d7925ad0f4..67822508327c 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -26,6 +26,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
 			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
 		},
+		.max_radios = 3,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 791d971784ce..5680b99a4f5c 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3820,7 +3820,7 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
 	int total_num_buffs_reaped = 0;
 	int ret, i;
 
-	for (i = 0; i < MAX_RADIOS; i++)
+	for (i = 0; i < ab->num_radios; i++)
 		__skb_queue_head_init(&msdu_list[i]);
 
 	srng = &ab->hal.srng_list[dp->rx_rel_ring.ring_id];
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index ad13c648b679..bc0026c1e4a6 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -748,7 +748,7 @@ int ath11k_htc_init(struct ath11k_base *ab)
 		htc->wmi_ep_count = 3;
 		break;
 	default:
-		htc->wmi_ep_count = 3;
+		htc->wmi_ep_count = ab->hw_params.max_radios;
 		break;
 	}
 
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f95ad31d3d6c..ba897d186cf5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -107,6 +107,7 @@ enum ath11k_bus {
 struct ath11k_hw_params {
 	const char *name;
 	u16 hw_rev;
+	u8 max_radios;
 	struct {
 		const char *dir;
 		size_t board_size;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 7c9dc91cc48a..0ba80e6f3979 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -699,7 +699,7 @@ void ath11k_reg_free(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < MAX_RADIOS; i++) {
+	for (i = 0; i < ab->hw_params.max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8e3437a65673..cd1bdb2a75c9 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6682,7 +6682,7 @@ int ath11k_wmi_connect(struct ath11k_base *ab)
 	u8 wmi_ep_count;
 
 	wmi_ep_count = ab->htc.wmi_ep_count;
-	if (wmi_ep_count > MAX_RADIOS)
+	if (wmi_ep_count > ab->hw_params.max_radios)
 		return -1;
 
 	for (i = 0; i < wmi_ep_count; i++)
@@ -6704,7 +6704,7 @@ int ath11k_wmi_pdev_attach(struct ath11k_base *ab,
 {
 	struct ath11k_pdev_wmi *wmi_handle;
 
-	if (pdev_id >= MAX_RADIOS)
+	if (pdev_id >= ab->hw_params.max_radios)
 		return -EINVAL;
 
 	wmi_handle = &ab->wmi_ab.wmi[pdev_id];
-- 
2.7.4

