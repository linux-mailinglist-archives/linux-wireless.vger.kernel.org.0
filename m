Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D7C59139E
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiHLQKh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiHLQKa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6789082FB4
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BF78B8247C
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323EDC433D7;
        Fri, 12 Aug 2022 16:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320625;
        bh=/hX3OzB39UruIkacA08xZgaTBDYUxigx0gBqm8j9Lvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aq10gSTBsPNEe/0tGvifGSq0W1VGCEOu0WTMtCUkCd5S2GaGpMU7VxdHf+/o2kZfq
         JSSiiKzFgYtU3NQ/1krNwzvOo3g090BNQT8IpjZ3mDfhA8xx/ISh8CIG62I0h21Zhq
         UVAPL8ZnOI5omdZBcwvA3Rq45fJ5PBqwjYxEfP7gQRVTwRhX1DNfKbjtTmJ9c7MZwT
         Iu8/IfsRBHByhYWbCn1RqRDlN9hwaP9y8XcDx8rM+fFMhZioUeq3fs9KXr2F2E10AN
         9cHH8EWpUqIAo9VY+ncEi2zBXbUFjSMO6kxRaERTRSbB6IYeIku2Dr/w7umYC9fwvA
         1mtEPnQxirxvg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 18/50] wifi: ath12k: add dp_tx.h
Date:   Fri, 12 Aug 2022 19:09:31 +0300
Message-Id: <20220812161003.27279-19-kvalo@kernel.org>
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

