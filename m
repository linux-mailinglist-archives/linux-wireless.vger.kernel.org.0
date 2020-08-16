Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C2D245752
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgHPL3X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:29:23 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:28233 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728998AbgHPL2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:28:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577307; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=z+4ZeSFdeEq/I2FOc+HIimVs3drIEq9D/Wv+A6gI5Ag=; b=at1OXBR+yJae7qwC6xNjd4zAG2oBeO0I21m+q5Vss7l7NqHCt9QI5R/i2Iv7ITCTKRc5r+OW
 JBP3EjwjT410zXVJTFLTv+GEqPVQ035W53nqSOTbBWGQRxk7zZVrQeSHjtyD3VcgIbpZdTD3
 ZG54ZyuA6EzMbdOq98ycWwwi4po=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3915a22889723bf8f969a8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:16:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B6C90C433CA; Sun, 16 Aug 2020 11:16:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C73DC43387;
        Sun, 16 Aug 2020 11:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C73DC43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 04/12] ath11k: ce: remove host_ce_config_wlan macro
Date:   Sun, 16 Aug 2020 14:16:31 +0300
Message-Id: <1597576599-8857-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This macro is evil as it's accesses ab variable in a hidden way. It's better
for readibility to access ab->hw_params.host_ce_config directly.

This is done in a separate patch to keep the patches simple. No functional changes.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index a588e5d0e5e0..c75007e92830 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -7,8 +7,6 @@
 #include "debug.h"
 #include "hif.h"
 
-#define host_ce_config_wlan ab->hw_params.host_ce_config
-
 const struct ce_attr ath11k_host_ce_config_ipq8074[] = {
 	/* CE0: host->target HTC control and raw streams */
 	{
@@ -471,19 +469,19 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 
 	switch (type) {
 	case HAL_CE_SRC:
-		if (!(CE_ATTR_DIS_INTR & host_ce_config_wlan[ce_id].flags))
+		if (!(CE_ATTR_DIS_INTR & ab->hw_params.host_ce_config[ce_id].flags))
 			params.intr_batch_cntr_thres_entries = 1;
 		break;
 	case HAL_CE_DST:
-		params.max_buffer_len = host_ce_config_wlan[ce_id].src_sz_max;
-		if (!(host_ce_config_wlan[ce_id].flags & CE_ATTR_DIS_INTR)) {
+		params.max_buffer_len = ab->hw_params.host_ce_config[ce_id].src_sz_max;
+		if (!(ab->hw_params.host_ce_config[ce_id].flags & CE_ATTR_DIS_INTR)) {
 			params.intr_timer_thres_us = 1024;
 			params.flags |= HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN;
 			params.low_threshold = ce_ring->nentries - 3;
 		}
 		break;
 	case HAL_CE_DST_STATUS:
-		if (!(host_ce_config_wlan[ce_id].flags & CE_ATTR_DIS_INTR)) {
+		if (!(ab->hw_params.host_ce_config[ce_id].flags & CE_ATTR_DIS_INTR)) {
 			params.intr_batch_cntr_thres_entries = 1;
 			params.intr_timer_thres_us = 0x1000;
 		}
@@ -502,7 +500,7 @@ static int ath11k_ce_init_ring(struct ath11k_base *ab,
 		return ret;
 	}
 
-	if (!(CE_ATTR_DIS_INTR & host_ce_config_wlan[ce_id].flags))
+	if (!(CE_ATTR_DIS_INTR & ab->hw_params.host_ce_config[ce_id].flags))
 		ath11k_ce_srng_msi_ring_params_setup(ab, ce_id, &params);
 
 	ce_ring->hal_ring_id = ret;
@@ -550,7 +548,7 @@ ath11k_ce_alloc_ring(struct ath11k_base *ab, int nentries, int desc_sz)
 static int ath11k_ce_alloc_pipe(struct ath11k_base *ab, int ce_id)
 {
 	struct ath11k_ce_pipe *pipe = &ab->ce.ce_pipe[ce_id];
-	const struct ce_attr *attr = &host_ce_config_wlan[ce_id];
+	const struct ce_attr *attr = &ab->hw_params.host_ce_config[ce_id];
 	struct ath11k_ce_ring *ring;
 	int nentries;
 	int desc_sz;
@@ -877,7 +875,7 @@ int ath11k_ce_alloc_pipes(struct ath11k_base *ab)
 	spin_lock_init(&ab->ce.ce_lock);
 
 	for (i = 0; i < CE_COUNT; i++) {
-		attr = &host_ce_config_wlan[i];
+		attr = &ab->hw_params.host_ce_config[i];
 		pipe = &ab->ce.ce_pipe[i];
 		pipe->pipe_num = i;
 		pipe->ab = ab;
@@ -919,6 +917,6 @@ int ath11k_ce_get_attr_flags(struct ath11k_base *ab, int ce_id)
 	if (ce_id >= CE_COUNT)
 		return -EINVAL;
 
-	return host_ce_config_wlan[ce_id].flags;
+	return ab->hw_params.host_ce_config[ce_id].flags;
 }
 EXPORT_SYMBOL(ath11k_ce_get_attr_flags);
-- 
2.7.4

