Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46CB62C507
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiKPQny (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbiKPQnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBAC5F86A
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8AE7FCE1BDC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3744AC43470;
        Wed, 16 Nov 2022 16:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616766;
        bh=/hX3OzB39UruIkacA08xZgaTBDYUxigx0gBqm8j9Lvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kW6EFw599tbOlTMCa9/QVDX8nNSSNJ/Y3i32dCGyBJe8lVvQyhmqh1I0KVeJMsAuX
         TtCSmWDrhqMYHSCi/TMDQQeKrh77FXS1mpEgCDAJT1kSQOnr8jw9b5l4laYUr45fKJ
         IJTblv7rAG4nxeSnqkC7lPKSo958I2000zhD5BMnQnE+GigXoLTD9283YLGqJOKoJL
         yI28OEelfzF30BCAFWRyEvMt+AeoNh+qRQe/H4S6HwFDoapzZ4fxKfX0nwnOhDX+n/
         9O8+WqUApLhoRYy38mKWkdtTI9kUHG3Rz8JnkGkVUOTI+io3pgWP+RFFVOLPjskUfx
         OtPhJtk6D9odg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 18/50] wifi: ath12k: add dp_tx.h
Date:   Wed, 16 Nov 2022 18:38:30 +0200
Message-Id: <20221116163902.24996-19-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/wireless/ath/ath12k/dp_tx.h | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.h b/drivers/net/wireless/ath/ath12k/dp_tx.h
new file mode 100644
index 000000000000..436d77e5e9ee
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_DP_TX_H
+#define ATH12K_DP_TX_H
+
+#include "core.h"
+#include "hal_tx.h"
+
+struct ath12k_dp_htt_wbm_tx_status {
+	bool acked;
+	int ack_rssi;
+};
+
+int ath12k_dp_tx_htt_h2t_ver_req_msg(struct ath12k_base *ab);
+int ath12k_dp_tx(struct ath12k *ar, struct ath12k_vif *arvif,
+		 struct sk_buff *skb);
+void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id);
+
+int ath12k_dp_tx_htt_h2t_ppdu_stats_req(struct ath12k *ar, u32 mask);
+int
+ath12k_dp_tx_htt_h2t_ext_stats_req(struct ath12k *ar, u8 type,
+				   struct htt_ext_stats_cfg_params *cfg_params,
+				   u64 cookie);
+int ath12k_dp_tx_htt_rx_monitor_mode_ring_config(struct ath12k *ar, bool reset);
+
+int ath12k_dp_tx_htt_rx_filter_setup(struct ath12k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int rx_buf_size,
+				     struct htt_rx_ring_tlv_filter *tlv_filter);
+void ath12k_dp_tx_put_bank_profile(struct ath12k_dp *dp, u8 bank_id);
+int ath12k_dp_tx_htt_tx_filter_setup(struct ath12k_base *ab, u32 ring_id,
+				     int mac_id, enum hal_ring_type ring_type,
+				     int tx_buf_size,
+				     struct htt_tx_ring_tlv_filter *htt_tlv_filter);
+int ath12k_dp_tx_htt_tx_monitor_mode_ring_config(struct ath12k *ar, bool reset);
+int ath12k_dp_tx_htt_monitor_mode_ring_config(struct ath12k *ar, bool reset);
+#endif

