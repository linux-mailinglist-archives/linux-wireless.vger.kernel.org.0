Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD752FD8FF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 10:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKOJaS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 04:30:18 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKOJaS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 04:30:18 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0969061139; Fri, 15 Nov 2019 09:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810217;
        bh=0EMYFctPcFVwlejoMa6dEfJWqn5trTXRa5AkVNLhZL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Frz8O3thlKCDGiUhBd3ha1pRJJkM1Xo9dVmGTj7cgoAVqRe9PP4gNslAlVIbKhoia
         677L0tNoOrnBHLDxJsLaZE32unYOdLYc+nMrb18u0aU+H6tw9gC/Ml4L85+q7ON32Q
         DceJ1ecMoAJsehS++MPLmB0+zo9KO067VhooX9rk=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D537C61495;
        Fri, 15 Nov 2019 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573810209;
        bh=0EMYFctPcFVwlejoMa6dEfJWqn5trTXRa5AkVNLhZL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IkrgtEzUrv9XGKyzXsfkJBRlNYET+GWU2vdOw2laeIHt7YNkPmQFwDiCmX4lyvZ+6
         cg+tJNhscKRyhT/dkg/4kQAu0p6HS5zaPGIBwdomz+b8lrTOmhnAhFK3clIXGS3nkD
         9YVPf/2jHQ8BVBzjZRrH8fiSrYckFG5+iqPIPEq8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D537C61495
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v3 20/49] ath11k: add dp_tx.h
Date:   Fri, 15 Nov 2019 11:28:44 +0200
Message-Id: <1573810153-29623-21-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
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

