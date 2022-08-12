Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F359138C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239242AbiHLQLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbiHLQKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BCBA50CA
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B160FB8247F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7AEC433D6;
        Fri, 12 Aug 2022 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320640;
        bh=atHzZF+xvyS84ZYuWSObY+lbwZ195L3KzD8sW5VLEqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=spZWkYhGgzo0W/2zfNKbfvwXj1EGD6euK2rXEOhcWLC5pMZgJUnC4kZJwnI/R/472
         elj9YMeTOai+s/4zyRoKUEROZRNrZr5hfmxAieI88Lv90n4IJ78KZwP4Uo7/ItZKm2
         RjqlAeBoBWCpYH4rqnNbWymOma2MASTCvYZadcZADh763xYQsJihgfpOlpdtt1vv1h
         ydmgMhDJ3WZPQcoo2z0yTYZ+3wAo5Mkk9ZqoFD4HPg96Pjyq5YxQBPCtjFT2MotG5+
         z/ialC1CjyRIHNjzUXq4oKo7NrU/+u/yIj/+8tsiNWbspG7Z8+zfLZDerQ2NliFNWh
         TSiddSzH96hAw==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 32/50] wifi: ath12k: add mac.h
Date:   Fri, 12 Aug 2022 19:09:45 +0300
Message-Id: <20220812161003.27279-33-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/mac.h | 69 +++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
new file mode 100644
index 000000000000..7c32f18201fe
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -0,0 +1,69 @@
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
+u8 ath12k_mac_bw_to_mac80211_bw(u8 bw);
+enum ath12k_supported_bw ath12k_mac_mac80211_bw_to_ath12k_bw(enum rate_info_bw bw);
+enum hal_encrypt_type ath12k_dp_tx_get_encrypt_type(u32 cipher);
+#endif

