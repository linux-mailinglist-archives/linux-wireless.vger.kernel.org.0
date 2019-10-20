Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687DBDDDB1
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Oct 2019 12:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfJTKE5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Oct 2019 06:04:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45072 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726259AbfJTKE4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Oct 2019 06:04:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3F4186119A; Sun, 20 Oct 2019 10:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565895;
        bh=+pOubxnGZnJFd5LgyLKZ/lfsyUtwrMlIk5WgRFFNGbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZJOYWa8R7efDpSJzMuJBl9O1q1NMfowihZ1L6TS7JNwae3IJF5smkARoZWf5/DYjs
         4pf25Ky1Kq0YE79k9yAY+cLuegOjdTHJXmrCrgj4TI4YgJSpIOETv+d7/aOiF39xEL
         SYExBbsrdUagYhUtLh+gCflPZsb3rcdkH1MXSOPw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4C93611AA;
        Sun, 20 Oct 2019 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571565893;
        bh=+pOubxnGZnJFd5LgyLKZ/lfsyUtwrMlIk5WgRFFNGbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cUTQxBEpBkStk7caZEhvmcTlW1h3JqctHF2e9c2JHZ11e3VUKHKdgscwoa+cpgVa7
         +ltuejluPKI+yACUHNQAuwoEQNrDnNVbvx6X+IhIDipeW6WpJaQdv5pEmf0N57dknn
         885t+rZcoNLrVpYDh5YB4vyBjqeu479GNxADwsSc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4C93611AA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH v2 18/49] ath11k: add dp_rx.h
Date:   Sun, 20 Oct 2019 13:03:36 +0300
Message-Id: <1571565847-10338-19-git-send-email-kvalo@codeaurora.org>
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
 drivers/net/wireless/ath/ath11k/dp_rx.h | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
new file mode 100644
index 000000000000..026820fda568
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+#ifndef ATH11K_DP_RX_H
+#define ATH11K_DP_RX_H
+
+#include "core.h"
+#include "rx_desc.h"
+#include "debug.h"
+
+#define DP_RX_MPDU_ERR_FCS			BIT(0)
+#define DP_RX_MPDU_ERR_DECRYPT			BIT(1)
+#define DP_RX_MPDU_ERR_TKIP_MIC			BIT(2)
+#define DP_RX_MPDU_ERR_AMSDU_ERR		BIT(3)
+#define DP_RX_MPDU_ERR_OVERFLOW			BIT(4)
+#define DP_RX_MPDU_ERR_MSDU_LEN			BIT(5)
+#define DP_RX_MPDU_ERR_MPDU_LEN			BIT(6)
+#define DP_RX_MPDU_ERR_UNENCRYPTED_FRAME	BIT(7)
+
+enum dp_rx_decap_type {
+	DP_RX_DECAP_TYPE_RAW,
+	DP_RX_DECAP_TYPE_NATIVE_WIFI,
+	DP_RX_DECAP_TYPE_ETHERNET2_DIX,
+	DP_RX_DECAP_TYPE_8023,
+};
+
+struct ath11k_dp_amsdu_subframe_hdr {
+	u8 dst[ETH_ALEN];
+	u8 src[ETH_ALEN];
+	__be16 len;
+} __packed;
+
+struct ath11k_dp_rfc1042_hdr {
+	u8 llc_dsap;
+	u8 llc_ssap;
+	u8 llc_ctrl;
+	u8 snap_oui[3];
+	__be16 snap_type;
+} __packed;
+
+int ath11k_dp_rx_ampdu_start(struct ath11k *ar,
+			     struct ieee80211_ampdu_params *params);
+int ath11k_dp_rx_ampdu_stop(struct ath11k *ar,
+			    struct ieee80211_ampdu_params *params);
+void ath11k_peer_rx_tid_cleanup(struct ath11k *ar, struct ath11k_peer *peer);
+int ath11k_peer_rx_tid_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id,
+			     u8 tid, u32 ba_win_sz, u16 ssn);
+void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
+				       struct sk_buff *skb);
+int ath11k_dp_rx_pdev_alloc(struct ath11k_base *ab, int pdev_idx);
+void ath11k_dp_rx_pdev_free(struct ath11k_base *ab, int pdev_idx);
+void ath11k_dp_reo_cmd_list_cleanup(struct ath11k_base *ab);
+void ath11k_dp_process_reo_status(struct ath11k_base *ab);
+int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget);
+int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
+				 struct napi_struct *napi, int budget);
+int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
+			     int budget);
+int ath11k_dp_process_rx(struct ath11k_base *ab, int mac_id,
+			 struct napi_struct *napi, struct sk_buff_head *pending_q,
+			 int budget);
+int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
+			       struct dp_rxdma_ring *rx_ring,
+			       int req_entries,
+			       enum hal_rx_buf_return_buf_manager mgr,
+			       gfp_t gfp);
+int ath11k_dp_htt_tlv_iter(struct ath11k_base *ab, const void *ptr, size_t len,
+			   int (*iter)(struct ath11k_base *ar, u16 tag, u16 len,
+				       const void *ptr, void *data),
+			   void *data);
+int ath11k_dp_rx_process_mon_rings(struct ath11k_base *ab, int mac_id,
+				   struct napi_struct *napi, int budget);
+int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
+				    struct napi_struct *napi, int budget);
+int ath11k_dp_rx_mon_status_bufs_replenish(struct ath11k_base *ab, int mac_id,
+					   struct dp_rxdma_ring *rx_ring,
+					   int req_entries,
+					   enum hal_rx_buf_return_buf_manager mgr,
+					   gfp_t gfp);
+int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar);
+int ath11k_dp_rx_pdev_mon_attach(struct ath11k *ar);
+
+#endif /* ATH11K_DP_RX_H */

