Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB85559139F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239209AbiHLQKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbiHLQK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D4B31DF7
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 092E6B82478
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3E1C433D6;
        Fri, 12 Aug 2022 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320623;
        bh=GhrbCjA8qAMw06+pY8HCPTBOJtkv3xyVyDkR1J6VF4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StPyltCz2e9k/K7pTSUkbPIPLa79/mS04L41Ylln76UZRX4UASI4f2c5YzSEwz1oe
         kXSpRHZxb/HZw+LuXANR3ZMSgGCT2spiwr0heTI0HRgh4V1n5hYA3EYgCDlZjuRI32
         fwbn62Q1rdeUliVZnAhZfo6PYPCru5qCMA3MsI2VPdfyhpyFLYxbyLDxQsDaRWTRzq
         evvh5t68WiC9geYZrtO+9CWRF23JfJ4BfY6nyrKZc2XMLZQSeiZpmpCbSd0kYIs1YS
         hl+UpEeN9QB2niXfP96e9F7jfgAeruw60WWRyA3YNh7DMKf81SKZBeHzDFwHOIzews
         4H1XJVjrveopQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 16/50] wifi: ath12k: add dp_rx.h
Date:   Fri, 12 Aug 2022 19:09:29 +0300
Message-Id: <20220812161003.27279-17-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.h | 160 ++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.h b/drivers/net/wireless/ath/ath12k/dp_rx.h
new file mode 100644
index 000000000000..60a52f83bdcd
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef ATH12K_DP_RX_H
+#define ATH12K_DP_RX_H
+
+#include "core.h"
+#include "rx_desc.h"
+#include "debug.h"
+
+#define DP_MAX_NWIFI_HDR_LEN	30
+
+struct ath12k_dp_rx_tid {
+	u8 tid;
+	u32 *vaddr;
+	dma_addr_t paddr;
+	u32 size;
+	u32 ba_win_sz;
+	bool active;
+
+	/* Info related to rx fragments */
+	u32 cur_sn;
+	u16 last_frag_no;
+	u16 rx_frag_bitmap;
+
+	struct sk_buff_head rx_frags;
+	struct hal_reo_dest_ring *dst_ring_desc;
+
+	/* Timer info related to fragments */
+	struct timer_list frag_timer;
+	struct ath12k_base *ab;
+};
+
+struct ath12k_dp_rx_reo_cache_flush_elem {
+	struct list_head list;
+	struct ath12k_dp_rx_tid data;
+	unsigned long ts;
+};
+
+struct ath12k_dp_rx_reo_cmd {
+	struct list_head list;
+	struct ath12k_dp_rx_tid data;
+	int cmd_num;
+	void (*handler)(struct ath12k_dp *dp, void *ctx,
+			enum hal_reo_cmd_status status);
+};
+
+#define ATH12K_DP_RX_REO_DESC_FREE_THRES  64
+#define ATH12K_DP_RX_REO_DESC_FREE_TIMEOUT_MS 1000
+
+enum ath12k_dp_rx_decap_type {
+	DP_RX_DECAP_TYPE_RAW,
+	DP_RX_DECAP_TYPE_NATIVE_WIFI,
+	DP_RX_DECAP_TYPE_ETHERNET2_DIX,
+	DP_RX_DECAP_TYPE_8023,
+};
+
+struct ath12k_dp_rx_rfc1042_hdr {
+	u8 llc_dsap;
+	u8 llc_ssap;
+	u8 llc_ctrl;
+	u8 snap_oui[3];
+	__be16 snap_type;
+} __packed;
+
+struct ath_pktlog_hdr {
+	u16 flags;
+	u16 missed_cnt;
+	u16 log_type;
+	u16 size;
+	u32 timestamp;
+	u32 type_specific_data;
+	struct mlo_timestamp m_timestamp;
+	u8 payload[];
+};
+
+static inline u32 ath12k_he_gi_to_nl80211_he_gi(u8 sgi)
+{
+	u32 ret = 0;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_HE_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_HE_GI_3_2;
+		break;
+	}
+
+	return ret;
+}
+
+int ath12k_dp_rx_ampdu_start(struct ath12k *ar,
+			     struct ieee80211_ampdu_params *params);
+int ath12k_dp_rx_ampdu_stop(struct ath12k *ar,
+			    struct ieee80211_ampdu_params *params);
+int ath12k_dp_rx_peer_pn_replay_config(struct ath12k_vif *arvif,
+				       const u8 *peer_addr,
+				       enum set_key_cmd key_cmd,
+				       struct ieee80211_key_conf *key);
+void ath12k_dp_rx_peer_tid_cleanup(struct ath12k *ar, struct ath12k_peer *peer);
+void ath12k_dp_rx_peer_tid_delete(struct ath12k *ar,
+				  struct ath12k_peer *peer, u8 tid);
+int ath12k_dp_rx_peer_tid_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id,
+				u8 tid, u32 ba_win_sz, u16 ssn,
+				enum hal_pn_type pn_type);
+void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
+				       struct sk_buff *skb);
+int ath12k_dp_rx_pdev_reo_setup(struct ath12k_base *ab);
+void ath12k_dp_rx_pdev_reo_cleanup(struct ath12k_base *ab);
+int ath12k_dp_rx_htt_setup(struct ath12k_base *ab);
+int ath12k_dp_rx_alloc(struct ath12k_base *ab);
+void ath12k_dp_rx_free(struct ath12k_base *ab);
+int ath12k_dp_rx_pdev_alloc(struct ath12k_base *ab, int pdev_idx);
+void ath12k_dp_rx_pdev_free(struct ath12k_base *ab, int pdev_idx);
+void ath12k_dp_rx_reo_cmd_list_cleanup(struct ath12k_base *ab);
+void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab);
+int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
+				 struct napi_struct *napi, int budget);
+int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
+			     int budget);
+int ath12k_dp_rx_process(struct ath12k_base *ab, int mac_id,
+			 struct napi_struct *napi,
+			 int budget);
+int ath12k_dp_rx_bufs_replenish(struct ath12k_base *ab, int mac_id,
+				struct dp_rxdma_ring *rx_ring,
+				int req_entries,
+				enum hal_rx_buf_return_buf_manager mgr,
+				bool hw_cc);
+int ath12k_dp_htt_tlv_iter(struct ath12k_base *ab, const void *ptr, size_t len,
+			   int (*iter)(struct ath12k_base *ar, u16 tag, u16 len,
+				       const void *ptr, void *data),
+			   void *data);
+int ath12k_dp_rx_pdev_mon_attach(struct ath12k *ar);
+int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev_id);
+
+int ath12k_dp_rx_pktlog_start(struct ath12k_base *ab);
+int ath12k_dp_rx_pktlog_stop(struct ath12k_base *ab, bool stop_timer);
+u8 ath12k_dp_rx_h_l3pad(struct ath12k_base *ab,
+			struct hal_rx_desc *desc);
+struct ath12k_peer *
+ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu);
+u8 ath12k_dp_rx_h_decap_type(struct ath12k_base *ab,
+			     struct hal_rx_desc *desc);
+u32 ath12k_dp_rx_h_mpdu_err(struct ath12k_base *ab,
+			    struct hal_rx_desc *desc);
+void ath12k_dp_rx_h_ppdu(struct ath12k *ar, struct hal_rx_desc *rx_desc,
+			 struct ieee80211_rx_status *rx_status);
+struct ath12k_peer *
+ath12k_dp_rx_h_find_peer(struct ath12k_base *ab, struct sk_buff *msdu);
+
+int ath12k_dp_rxdma_ring_sel_config_qcn9274(struct ath12k_base *ab);
+int ath12k_dp_rxdma_ring_sel_config_wcn7850(struct ath12k_base *ab);
+
+#endif /* ATH12K_DP_RX_H */

