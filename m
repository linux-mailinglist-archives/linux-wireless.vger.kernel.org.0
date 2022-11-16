Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F99062C523
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiKPQoo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiKPQnj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA1856572
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EE89B81DDC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD12C43470;
        Wed, 16 Nov 2022 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616787;
        bh=502oWqQ+GTWg26Vp+E3/WRe7autuvpcJgkDWVjbg4Nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyK7uIYMQYG9P9NuBOHnhjql85i8N+NNs8gW1S/0U5Bh12Mgt3Cv9Y1sa+0zgcy4O
         kM5mCOxo+cuIMxHP59w4Imcf5dJHXOPJWpJFKt9KzMDiGx2i4wl3Dae7zr4gHWwXpv
         FC5clIckd9NEoXpukC1tM+7K7Zm1R5g/D4LcD2btDghoQbYn9DDCQVICoG0sEtDvqY
         31Muo8Za34MktXWmuSm48N6tRqdFODgqYn47it/aW2nxUmZzJQKwQj6CLwFsF02y0E
         Vkate9Onc8K2phERn3RM0aQ7Edbfe+kzK+AlBXFnq5ObMlsw1F5l/qNPfpL5Rip45K
         Kp0rYYUqZ3kPA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 38/50] wifi: ath12k: add peer.h
Date:   Wed, 16 Nov 2022 18:38:50 +0200
Message-Id: <20221116163902.24996-39-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/peer.h | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
new file mode 100644
index 000000000000..b296dc0e2f67
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_PEER_H
+#define ATH12K_PEER_H
+
+#include "dp_rx.h"
+
+struct ppdu_user_delayba {
+	u16 sw_peer_id;
+	u32 info0;
+	u16 ru_end;
+	u16 ru_start;
+	u32 info1;
+	u32 rate_flags;
+	u32 resp_rate_flags;
+};
+
+struct ath12k_peer {
+	struct list_head list;
+	struct ieee80211_sta *sta;
+	int vdev_id;
+	u8 addr[ETH_ALEN];
+	int peer_id;
+	u16 ast_hash;
+	u8 pdev_idx;
+	u16 hw_peer_id;
+
+	/* protected by ab->data_lock */
+	struct ieee80211_key_conf *keys[WMI_MAX_KEY_INDEX + 1];
+	struct ath12k_dp_rx_tid rx_tid[IEEE80211_NUM_TIDS + 1];
+
+	/* Info used in MMIC verification of
+	 * RX fragments
+	 */
+	struct crypto_shash *tfm_mmic;
+	u8 mcast_keyidx;
+	u8 ucast_keyidx;
+	u16 sec_type;
+	u16 sec_type_grp;
+	struct ppdu_user_delayba ppdu_stats_delayba;
+	bool delayba_flag;
+	bool is_authorized;
+};
+
+void ath12k_peer_unmap_event(struct ath12k_base *ab, u16 peer_id);
+void ath12k_peer_map_event(struct ath12k_base *ab, u8 vdev_id, u16 peer_id,
+			   u8 *mac_addr, u16 ast_hash, u16 hw_peer_id);
+struct ath12k_peer *ath12k_peer_find(struct ath12k_base *ab, int vdev_id,
+				     const u8 *addr);
+struct ath12k_peer *ath12k_peer_find_by_addr(struct ath12k_base *ab,
+					     const u8 *addr);
+struct ath12k_peer *ath12k_peer_find_by_id(struct ath12k_base *ab, int peer_id);
+void ath12k_peer_cleanup(struct ath12k *ar, u32 vdev_id);
+int ath12k_peer_delete(struct ath12k *ar, u32 vdev_id, u8 *addr);
+int ath12k_peer_create(struct ath12k *ar, struct ath12k_vif *arvif,
+		       struct ieee80211_sta *sta,
+		       struct ath12k_wmi_peer_create_arg *arg);
+int ath12k_wait_for_peer_delete_done(struct ath12k *ar, u32 vdev_id,
+				     const u8 *addr);
+bool ath12k_peer_exist_by_vdev_id(struct ath12k_base *ab, int vdev_id);
+struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
+
+#endif /* _PEER_H_ */

