Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75935DDDB3
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfJTKE7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45458 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJTKE7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:59 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 904C561178; Sun, 20 Oct 2019 10:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565898;
        bh=0EMYFctPcFVwlejoMa6dEfJWqn5trTXRa5AkVNLhZL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ujur2RcTyH7aW/hdFcs2hCFX6Z5Epy+9IXBOq7UKgECn18ZWtmcNb+vnTkljV4lyG
         OgPPnYO22S9i4AqpUoCjkoizpZUk4HOlbfp9XdvMgcepYUIXs3hELnbJ1bq484or3B
         3pA3xWXBGkDoRKW/lZpIIaMX4AFL1Nx/QTylPZgs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from x230.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BC37A611D1;
        Sun, 20 Oct 2019 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565897;
        bh=0EMYFctPcFVwlejoMa6dEfJWqn5trTXRa5AkVNLhZL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UmUKkYhypqEbuqd3LLuSBuFK5KFk8RykB2o15SvhR5yAc2+mpEXm8odzSAWJXVkF4
         Glz8TVJuUjtHNBrzzTSuHeIeWkOpK6kep8tFxgnlWpRWuBhegI9MilvCUrjXFXQL6j
         7AAGNKjZZZ/9syTe1/srMbbgtMtJgfO8onZoCLvM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BC37A611D1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 20/49] ath11k: add dp_tx.h
Date:   Sun, 20 Oct 2019 13:03:38 +0300
Message-Id: <1571565847-10338-21-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
References: <1571565847-10338-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(patches split for easier review, see the cover letter for more)

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_tx.h | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
new file mode 100644
index 000000000000..f8a9f9c8e444
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_DP_TX_H
+#define ATH11K_DP_TX_H
+
+#include "core.h"
+#include "hal_tx.h"
+
+struct ath11k_dp_htt_wbm_tx_status {
+	u32 msdu_id;
+	bool acked;
+	int ack_rssi;
+};
+
+int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab);
+int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
+		 struct sk_buff *skb);
+void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id);
+int ath11k_dp_tx_send_reo_cmd(struct ath11k_base *ab, struct dp_rx_tid *rx_tid,
+			      enum hal_reo_cmd_type type,
+			      struct ath11k_hal_reo_cmd *cmd,
+			      void (*func)(struct ath11k_dp *, void *,
+					   enum hal_reo_cmd_status));
+
+int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct ath11k *ar, u32 mask);
+int
+ath11k_dp_tx_htt_h2t_ext_stats_req(struct ath11k *ar, u8 type,
+				   struct htt_ext_stats_cfg_params *cfg_params,
+				   u64 cookie);
+int ath11k_dp_tx_htt_monitor_mode_ring_config(struct ath11k *ar, bool reset);
+
+int ath11k_dp_tx_htt_rx_filter_setup(struct ath11k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int rx_buf_size,
+				     struct htt_rx_ring_tlv_filter *tlv_filter);
+
+#endif

