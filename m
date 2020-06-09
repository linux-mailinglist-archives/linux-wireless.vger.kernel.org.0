Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BF1F3CB3
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgFINdt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 09:33:49 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12102 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730150AbgFINdq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 09:33:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591709625; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ikhgoVwPSpeNysr9hjuRKKtUXK6SsktYFHiCVAXe5S4=; b=BRZ9i1Z9i8CDmoE2fXQvArPs9/wmYNiE2m3noXrkr4Dy5Fgy5+ju3K5xRgnBIZSz8kt0DPsi
 U6A2tBYIWLVteZlvcIf8hCUzwl1o5pqSekZ/mzfh7hBJPMuRR3ZsYrLbmQrLaXPsl0IkKomE
 Exm4AFpxOvLcm4QjRbJTvYnMUgQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5edf8faa6bebe35deb576bd6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 13:33:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0AC7C43395; Tue,  9 Jun 2020 13:33:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BEB51C43387;
        Tue,  9 Jun 2020 13:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BEB51C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 5/8] ath11k: define max_radios in hw_params
Date:   Tue,  9 Jun 2020 19:02:58 +0530
Message-Id: <1591709581-18039-6-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
References: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define max_radios supported in hw_params.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  | 2 ++
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 +-
 drivers/net/wireless/ath/ath11k/htc.c   | 2 +-
 drivers/net/wireless/ath/ath11k/hw.h    | 1 +
 drivers/net/wireless/ath/ath11k/reg.c   | 2 +-
 drivers/net/wireless/ath/ath11k/wmi.c   | 4 ++--
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index abe9edb56309..115db4c21e70 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -26,6 +26,7 @@ static const struct ath11k_hw_params ath11k_hw_params_list[] = {
 			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
 			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
 		},
+		.max_radios = 3,
 	},
 	{
 		.dev_id = ATH11K_HW_IPQ6018,
@@ -35,6 +36,7 @@ static const struct ath11k_hw_params ath11k_hw_params_list[] = {
 			.board_size = IPQ6018_MAX_BOARD_DATA_SZ,
 			.cal_size =  IPQ6018_MAX_CAL_DATA_SZ,
 		},
+		.max_radios = 2,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a54610d75c40..57aee0d9a124 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -3792,7 +3792,7 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
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
index e66f0e0138c4..d1a08d529988 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -112,6 +112,7 @@ enum ath11k_bus {
 struct ath11k_hw_params {
 	const char *name;
 	u16 dev_id;
+	u8 max_radios;
 	struct {
 		const char *dir;
 		size_t board_size;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 453aa9c06969..831f11d1b42e 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -695,7 +695,7 @@ void ath11k_reg_free(struct ath11k_base *ab)
 {
 	int i;
 
-	for (i = 0; i < MAX_RADIOS; i++) {
+	for (i = 0; i < ab->hw_params.max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
 	}
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a972377687..5324782c355b 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6152,7 +6152,7 @@ int ath11k_wmi_connect(struct ath11k_base *ab)
 	u8 wmi_ep_count;
 
 	wmi_ep_count = ab->htc.wmi_ep_count;
-	if (wmi_ep_count > MAX_RADIOS)
+	if (wmi_ep_count > ab->hw_params.max_radios)
 		return -1;
 
 	for (i = 0; i < wmi_ep_count; i++)
@@ -6174,7 +6174,7 @@ int ath11k_wmi_pdev_attach(struct ath11k_base *ab,
 {
 	struct ath11k_pdev_wmi *wmi_handle;
 
-	if (pdev_id >= MAX_RADIOS)
+	if (pdev_id >= ab->hw_params.max_radios)
 		return -EINVAL;
 
 	wmi_handle = &ab->wmi_ab.wmi[pdev_id];
-- 
2.7.4

