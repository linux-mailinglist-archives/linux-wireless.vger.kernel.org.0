Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7955913AA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbiHLQLH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiHLQKy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A6C9F779
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43A2761583
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E828C433B5;
        Fri, 12 Aug 2022 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320646;
        bh=L1TNHCI903TjgSsBnpw7Wf+Crix8ntg1y+fgPxR26cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHXutyM3eKxq7v5bon7Y6jHaT0id8M5jL+hZ7+Tu3ptd2zTPg8BTqMngYlmc/ZRB9
         JH/lqtLYDZZkxcXwHSUyi3sV2eBQGeBTuBnLBu72kOI0KgVHR+PMdDU2MeTDHrfW5X
         A8+Iu6idGDYiveqaKYeWeQLv+OQIKDXExqfCOryQwgBqhzb96jemxnt9qIDL+Ck8V7
         nYXocfKlOWwOEEXpCpx+e9aLg+yy12kfVEd5S5vm6lOYcajRHR2Q0OXpo/C2GJIYE4
         8YhrJpW2GqCXvGKKrAc079pFADYMni/EMkYnpBJK2KGX/jsyQS9+B3p4gqVsp69D8Z
         6LPaIIF0/Rolw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 38/50] wifi: ath12k: add peer.h
Date:   Fri, 12 Aug 2022 19:09:51 +0300
Message-Id: <20220812161003.27279-39-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/peer.h | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/peer.h b/drivers/net/wireless/ath/ath12k/peer.h
new file mode 100644
index 000000000000..d0346e8b1b60
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/peer.h
@@ -0,0 +1,69 @@
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
+	u8 reserved0;
+	u16 sw_peer_id;
+	u32 info0;
+	u16 ru_end;
+	u16 ru_start;
+	u32 info1;
+	u32 rate_flags;
+	u32 resp_rate_flags;
+} __packed;
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
+struct ath12k_peer *ath12k_peer_find_by_vdev_id(struct ath12k_base *ab,
+						int vdev_id);
+struct ath12k_peer *ath12k_peer_find_by_ast(struct ath12k_base *ab, int ast_hash);
+
+#endif /* _PEER_H_ */

