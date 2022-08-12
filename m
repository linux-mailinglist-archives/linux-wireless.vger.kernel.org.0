Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9459459138B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239166AbiHLQKb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbiHLQK0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F59590
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DADA2B82482
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00612C433B5;
        Fri, 12 Aug 2022 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320621;
        bh=6/d5E0LAZZu3J4TICj+U30DsscyJ/QClMl79o7LsRw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwVOQMWUMwVa2C5q4iUZaPzy7+MybqHXt6RPXqq0H1s5l2luk0PamZGvDoxZ43YW0
         UzDmabSyCfZrOybbUthUU34aPWU3WTz+/21O0+6lZLedjTVsyZkBFC96akbKyxtsrw
         gdff6soxW05cTn2QK2gCqlL4kuYTd7eVzb97q+jXjB3tLCLyV4FVJkAyn1nF3tMIjO
         E9pP0bOIQHIkHgy7mCP/gu8mT3R6KrGDdvIYNsJFMY2XTLbO+9wMxX7WId0KMLk7lq
         6jdfmtaLxqzw2t7PlieulIaIIS+gfDwNQl+8NjffblGhFCTSo4E6+a0dL2vO3nsJH0
         TJdNtuIeG++Mw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 14/50] wifi: ath12k: add dp_mon.h
Date:   Fri, 12 Aug 2022 19:09:27 +0300
Message-Id: <20220812161003.27279-15-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/dp_mon.h | 103 +++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.h b/drivers/net/wireless/ath/ath12k/dp_mon.h
new file mode 100644
index 000000000000..fd938bda89f6
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_mon.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_DP_MON_H
+#define ATH12K_DP_MON_H
+
+#include "core.h"
+
+#define ATH12K_DP_TX_MONITOR_MODE 0
+#define ATH12K_DP_RX_MONITOR_MODE 1
+
+enum dp_mon_tx_ppdu_info_type {
+	DP_MON_TX_PROT_PPDU_INFO,
+	DP_MON_TX_DATA_PPDU_INFO
+};
+
+enum dp_mon_tx_tlv_status {
+	DP_MON_TX_FES_SETUP,
+	DP_MON_TX_FES_STATUS_END,
+	DP_MON_RX_RESPONSE_REQUIRED_INFO,
+	DP_MON_RESPONSE_END_STATUS_INFO,
+	DP_MON_TX_MPDU_START,
+	DP_MON_TX_MSDU_START,
+	DP_MON_TX_BUFFER_ADDR,
+	DP_MON_TX_DATA,
+	DP_MON_TX_STATUS_PPDU_NOT_DONE,
+};
+
+enum dp_mon_tx_medium_protection_type {
+	DP_MON_TX_MEDIUM_NO_PROTECTION,
+	DP_MON_TX_MEDIUM_RTS_LEGACY,
+	DP_MON_TX_MEDIUM_RTS_11AC_STATIC_BW,
+	DP_MON_TX_MEDIUM_RTS_11AC_DYNAMIC_BW,
+	DP_MON_TX_MEDIUM_CTS2SELF,
+	DP_MON_TX_MEDIUM_QOS_NULL_NO_ACK_3ADDR,
+	DP_MON_TX_MEDIUM_QOS_NULL_NO_ACK_4ADDR
+};
+
+struct dp_mon_qosframe_addr4 {
+	__le16 frame_control;
+	__le16 duration;
+	u8 addr1[ETH_ALEN];
+	u8 addr2[ETH_ALEN];
+	u8 addr3[ETH_ALEN];
+	__le16 seq_ctrl;
+	u8 addr4[ETH_ALEN];
+	__le16 qos_ctrl;
+} __packed;
+
+struct dp_mon_frame_min_one {
+	__le16 frame_control;
+	__le16 duration;
+	u8 addr1[ETH_ALEN];
+} __packed;
+
+struct dp_mon_packet_info {
+	u64 cookie;
+	u16 dma_length;
+	bool msdu_continuation;
+	bool truncated;
+};
+
+struct dp_mon_tx_ppdu_info {
+	u32 ppdu_id;
+	u8  num_users;
+	bool is_used;
+	struct hal_rx_mon_ppdu_info rx_status;
+	struct list_head dp_tx_mon_mpdu_list;
+	struct dp_mon_mpdu *tx_mon_mpdu;
+};
+
+enum hal_rx_mon_status
+ath12k_dp_mon_rx_parse_mon_status(struct ath12k *ar,
+				  struct ath12k_mon_data *pmon,
+				  int mac_id, struct sk_buff *skb,
+				  struct napi_struct *napi);
+int ath12k_dp_mon_buf_replenish(struct ath12k_base *ab,
+				struct dp_rxdma_ring *buf_ring,
+				int req_entries);
+int ath12k_dp_mon_srng_process(struct ath12k *ar, int mac_id,
+			       int *budget, bool flag,
+			       struct napi_struct *napi);
+int ath12k_dp_mon_process_ring(struct ath12k_base *ab, int mac_id,
+			       struct napi_struct *napi, int budget, bool flag);
+struct sk_buff *ath12k_dp_mon_tx_alloc_skb(void);
+enum dp_mon_tx_tlv_status
+ath12k_dp_mon_tx_status_get_num_user(u16 tlv_tag,
+				     struct hal_tlv_hdr *tx_tlv,
+				     u8 *num_users);
+enum hal_rx_mon_status
+ath12k_dp_mon_tx_parse_mon_status(struct ath12k *ar,
+				  struct ath12k_mon_data *pmon,
+				  int mac_id,
+				  struct sk_buff *skb,
+				  struct napi_struct *napi,
+				  u32 ppdu_id);
+void ath12k_dp_mon_rx_process_ulofdma(struct hal_rx_mon_ppdu_info *ppdu_info);
+int ath12k_dp_mon_rx_process_stats(struct ath12k *ar, int mac_id,
+				   struct napi_struct *napi, int *budget);
+#endif

