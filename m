Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73489653B
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfHTPte (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:49:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43082 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfHTPte (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:49:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1550A61B01; Tue, 20 Aug 2019 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316173;
        bh=JbAuOXZn1mcNxVNXETkdnHhOc1A8Z1MrHCCkBL23bEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tx1ISefDFyCh9AsWWPq/cDIvLw4+K1XtF62OX1vzQiOAk/+G0VcXB2U180FatZTuu
         jg/NIoGDuwJmYXc5toPU+3Z3Qkn7pSW3zAJbRotYdf4QHY0GK8Tn4u4SN5OR3GU+9H
         ScYRvufbQwkZZmKsk+Cgb1TeZ7qDl669vGyl94Ns=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6103361B07;
        Tue, 20 Aug 2019 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316153;
        bh=JbAuOXZn1mcNxVNXETkdnHhOc1A8Z1MrHCCkBL23bEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QyisRk3Aap/9Jwp+MIC3t/b5yMOX13rCq1IiqTF1Guh+ZSZLPF5h2YCOvqBg9NDfD
         djccgJ+kY/kb+7RcS8qLFH1f4jEj3XBrHk5NRYEshGvHlEYJczp2XM5LPmw/tvJlfh
         tXlU1CkjyXJaZ/bTTY3uzbX4IrUwudCX+M0MlvZA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6103361B07
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 18/49] ath11k: add dp_rx.h
Date:   Tue, 20 Aug 2019 18:47:44 +0300
Message-Id: <1566316095-27507-19-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/dp_rx.h | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
new file mode 100644
index 000000000000..0a243ec5eb16
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: ISC */
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

