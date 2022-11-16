Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E3962C518
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiKPQoW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiKPQnb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383C20181
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E14961EF7
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C892C433D7;
        Wed, 16 Nov 2022 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616781;
        bh=2mNkmO2Ydttl38g21L/S9zsWVh8YYOnQh25A44zHhTQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0+cJpdLWKdb3/G7MRC0KdLZOMJ+x7t/zukPYp7CEyH3ooLjRu12IMRKKt03Cp0y8
         wi3fNu1H3vPzuXAi/p3MqX0EXQkbuGDgJ01dSRpbB7zhLntOwOkq+0uKsw1Aw8W7d4
         v3M5d7mg2J7cEy7Flc+y9oE77PARh+XbFhjOmBDwM/0xMDIG/kFT+SkAM31m6egYVO
         FEro7OelMwie+2W0rpFI2ZZMtwdVkabjKY8tsePYvNDeIe77hKu0c0AP4oI0+esF+9
         i1PUsRLWpPzu8H8woUfcVpb3YFkQeaf+lcdgXDyTyENIu0hbQ3IvTJt6qLrroYbAyi
         zS0adULrlzz8Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 32/50] wifi: ath12k: add mac.h
Date:   Wed, 16 Nov 2022 18:38:44 +0200
Message-Id: <20221116163902.24996-33-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/mac.h | 76 +++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
new file mode 100644
index 000000000000..57f4295420bb
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_MAC_H
+#define ATH12K_MAC_H
+
+#include <net/mac80211.h>
+#include <net/cfg80211.h>
+
+struct ath12k;
+struct ath12k_base;
+
+struct ath12k_generic_iter {
+	struct ath12k *ar;
+	int ret;
+};
+
+/* number of failed packets (20 packets with 16 sw reties each) */
+#define ATH12K_KICKOUT_THRESHOLD		(20 * 16)
+
+/* Use insanely high numbers to make sure that the firmware implementation
+ * won't start, we have the same functionality already in hostapd. Unit
+ * is seconds.
+ */
+#define ATH12K_KEEPALIVE_MIN_IDLE		3747
+#define ATH12K_KEEPALIVE_MAX_IDLE		3895
+#define ATH12K_KEEPALIVE_MAX_UNRESPONSIVE	3900
+
+/* FIXME: should these be in ieee80211.h? */
+#define IEEE80211_VHT_MCS_SUPPORT_0_11_MASK	GENMASK(23, 16)
+#define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
+
+#define ATH12K_CHAN_WIDTH_NUM			8
+
+#define ATH12K_TX_POWER_MAX_VAL	70
+#define ATH12K_TX_POWER_MIN_VAL	0
+
+enum ath12k_supported_bw {
+	ATH12K_BW_20    = 0,
+	ATH12K_BW_40    = 1,
+	ATH12K_BW_80    = 2,
+	ATH12K_BW_160   = 3,
+};
+
+extern const struct htt_rx_ring_tlv_filter ath12k_mac_mon_status_filter_default;
+
+void ath12k_mac_destroy(struct ath12k_base *ab);
+void ath12k_mac_unregister(struct ath12k_base *ab);
+int ath12k_mac_register(struct ath12k_base *ab);
+int ath12k_mac_allocate(struct ath12k_base *ab);
+int ath12k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
+					  u16 *rate);
+u8 ath12k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
+			     u32 bitrate);
+u8 ath12k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
+			     u8 hw_rate, bool cck);
+
+void __ath12k_mac_scan_finish(struct ath12k *ar);
+void ath12k_mac_scan_finish(struct ath12k *ar);
+
+struct ath12k_vif *ath12k_mac_get_arvif(struct ath12k *ar, u32 vdev_id);
+struct ath12k_vif *ath12k_mac_get_arvif_by_vdev_id(struct ath12k_base *ab,
+						   u32 vdev_id);
+struct ath12k *ath12k_mac_get_ar_by_vdev_id(struct ath12k_base *ab, u32 vdev_id);
+struct ath12k *ath12k_mac_get_ar_by_pdev_id(struct ath12k_base *ab, u32 pdev_id);
+
+void ath12k_mac_drain_tx(struct ath12k *ar);
+void ath12k_mac_peer_cleanup_all(struct ath12k *ar);
+int ath12k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
+enum rate_info_bw ath12k_mac_bw_to_mac80211_bw(enum ath12k_supported_bw bw);
+enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw);
+enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
+#endif

