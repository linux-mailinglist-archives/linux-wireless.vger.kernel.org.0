Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4A44999F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Nov 2021 17:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239735AbhKHQ1U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Nov 2021 11:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbhKHQ1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Nov 2021 11:27:20 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55ACC061570
        for <linux-wireless@vger.kernel.org>; Mon,  8 Nov 2021 08:24:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id j28so17534831ila.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Nov 2021 08:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QjeBABJCcSzvzO+a126dwhy5LGsNedsv6kISne52R2I=;
        b=IeItX+Xl89Zm6MZ1RY3nJObjfURE3EuB0e+oDuIXso0Yw1d8rUaMkeOrdn3Q8M7Q4h
         mwCEMHYJjcACR46xOsCKUmLHDiYcvYT+cFwKcLOSVtuyVv+388qrQCoTabwJIOniwnIY
         0lC7SvHcW1Qr4M2+KOhDLHUFykaOtmNEUix41OQLc78XHJHU0kSMfeb9tucrW92DLJ2p
         /Z8Gj9yRg4xim6hI8sFaFZ5x9OMnR61YZ3GzWy6FJ2vcc0VDV35EF9ZbuaFA1k0/JynP
         8qWV45Y1ib6y1cKFxVlJsK7sdIBX0asP9zXYgYk1ux53JqIV1v/XIcuD/qSXslBMY7BO
         yzjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QjeBABJCcSzvzO+a126dwhy5LGsNedsv6kISne52R2I=;
        b=6qfoHj05aaFU3dkQVbfaxazSkgk7+0Buoo30UKZcE4pl0L2NRM9GQ/BdEl2AHrFnXE
         e+cPWO6lczylUI49PQA6Fp7tbO0xCnBRKzUaA1eTK3e5uQ90DS6topDk29E44yYu2cPm
         PlkHL7yOfAix/6/bRf4OnnsUhHGpMejPjjW+U8AZcV3C3fotXPDkQMiwnbzYX/MAINmk
         P5XEY9rikiky097DI1HUdBTMx9dlKCaQNFQR39XKoBG0CSBLIktT16ep/aJMoBEhBlJl
         A3qRd8LrTMr0tIni30YTDifdH9NGUMm7Ei2D2Y+6xrdCfDh+naRrXLF0G87lQs63ubHN
         cawA==
X-Gm-Message-State: AOAM531bNypPzLbOdbVxbPx6nr88DczbO312KPiZ9UMDKcX4ambV7XzB
        EvJiAGyP1AqMO3BgylN5fFEgXTVLXvVywhf/tI/lkOrQlNs=
X-Google-Smtp-Source: ABdhPJzoM9Mml0U3Ft107K9RS3cqmlmtTnCx9hi2RlfD6r/569G8wH+tc3uGdKeHEqZdnAqgmNfYTYP0nGemDdCRW8Q=
X-Received: by 2002:a05:6e02:164d:: with SMTP id v13mr184034ilu.167.1636388674689;
 Mon, 08 Nov 2021 08:24:34 -0800 (PST)
MIME-Version: 1.0
From:   Francesco Magliocca <franciman12@gmail.com>
Date:   Mon, 8 Nov 2021 17:25:08 +0100
Message-ID: <CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com>
Subject: [PATCH] ath10k: abstract htt_rx_desc structure
To:     ath10k@lists.infradead.org
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-wireless@vger.kernel.org, enrico@fracta.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCA6174 card often hangs with the current htt_rx_desc
memory layout in some circumstances, because its firmware
fails to handle length differences.
Therefore we must abstract the htt_rx_desc structure
and operations on it, to allow different wireless cards
to use different, unrelated rx descriptor structures.

Define a base htt_rx_desc structure and htt_rx_desc_qca_old
for use with the QCA family of ath10k supported cards
and htt_rx_desc_new for use with the WCN3990 card.

Define htt_rx_desc_ops which contains the abstract operations
to access the generic htt_rx_desc, give implementations
for each card and update htt_rx.c to use the defined
abstract interface to rx descriptors.

Fixes: e3def6f7 ("ath10k: Update rx descriptor for WCN3990 target")

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1

Co-developed-by: Enrico Lumetti <enrico@fracta.dev>
Signed-off-by: Enrico Lumetti <enrico@fracta.dev>
Signed-off-by: Francesco Magliocca <franciman12@gmail.com>
---
 drivers/net/wireless/ath/ath10k/core.c    |  16 ++
 drivers/net/wireless/ath/ath10k/htt.c     | 151 +++++++++++
 drivers/net/wireless/ath/ath10k/htt.h     | 296 +++++++++++++++++++--
 drivers/net/wireless/ath/ath10k/htt_rx.c  | 303 ++++++++++++++--------
 drivers/net/wireless/ath/ath10k/htt_tx.c  |  36 +--
 drivers/net/wireless/ath/ath10k/hw.c      |  15 +-
 drivers/net/wireless/ath/ath10k/hw.h      |  27 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h |  40 ++-
 8 files changed, 692 insertions(+), 192 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c
b/drivers/net/wireless/ath/ath10k/core.c
index 72a366aa9f60..abbd67d8dfac 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -75,6 +75,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA988X_BOARD_DATA_SZ,
             .board_ext_size = QCA988X_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -110,6 +111,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA988X_BOARD_DATA_SZ,
             .board_ext_size = QCA988X_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -146,6 +148,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA9887_BOARD_DATA_SZ,
             .board_ext_size = QCA9887_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -181,6 +184,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA6174_BOARD_DATA_SZ,
             .board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca6174_sdio_ops,
         .hw_clk = qca6174_clk,
         .target_cpu_freq = 176000000,
@@ -212,6 +216,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA6174_BOARD_DATA_SZ,
             .board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -247,6 +252,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA6174_BOARD_DATA_SZ,
             .board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -282,6 +288,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA6174_BOARD_DATA_SZ,
             .board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -318,6 +325,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA6174_BOARD_DATA_SZ,
             .board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca6174_ops,
         .hw_clk = qca6174_clk,
         .target_cpu_freq = 176000000,
@@ -362,6 +370,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_ext_size = QCA99X0_BOARD_EXT_DATA_SZ,
         },
         .sw_decrypt_mcast_mgmt = true,
+        .rx_desc_ops = &qca99x0_rx_desc_ops,
         .hw_ops = &qca99x0_ops,
         .decap_align_bytes = 1,
         .spectral_bin_discard = 4,
@@ -406,6 +415,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .ext_board_size = QCA99X0_EXT_BOARD_DATA_SZ,
         },
         .sw_decrypt_mcast_mgmt = true,
+        .rx_desc_ops = &qca99x0_rx_desc_ops,
         .hw_ops = &qca99x0_ops,
         .decap_align_bytes = 1,
         .spectral_bin_discard = 12,
@@ -451,6 +461,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_ext_size = QCA99X0_BOARD_EXT_DATA_SZ,
         },
         .sw_decrypt_mcast_mgmt = true,
+        .rx_desc_ops = &qca99x0_rx_desc_ops,
         .hw_ops = &qca99x0_ops,
         .decap_align_bytes = 1,
         .spectral_bin_discard = 12,
@@ -490,6 +501,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA9377_BOARD_DATA_SZ,
             .board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca988x_ops,
         .decap_align_bytes = 4,
         .spectral_bin_discard = 0,
@@ -525,6 +537,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA9377_BOARD_DATA_SZ,
             .board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca6174_ops,
         .hw_clk = qca6174_clk,
         .target_cpu_freq = 176000000,
@@ -562,6 +575,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_size = QCA9377_BOARD_DATA_SZ,
             .board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
         },
+        .rx_desc_ops = &qca988x_rx_desc_ops,
         .hw_ops = &qca6174_ops,
         .hw_clk = qca6174_clk,
         .target_cpu_freq = 176000000,
@@ -597,6 +611,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .board_ext_size = QCA4019_BOARD_EXT_DATA_SZ,
         },
         .sw_decrypt_mcast_mgmt = true,
+        .rx_desc_ops = &qca99x0_rx_desc_ops,
         .hw_ops = &qca99x0_ops,
         .decap_align_bytes = 1,
         .spectral_bin_discard = 4,
@@ -628,6 +643,7 @@ static const struct ath10k_hw_params
ath10k_hw_params_list[] = {
             .dir = WCN3990_HW_1_0_FW_DIR,
         },
         .sw_decrypt_mcast_mgmt = true,
+        .rx_desc_ops = &wcn3990_rx_desc_ops,
         .hw_ops = &wcn3990_ops,
         .decap_align_bytes = 1,
         .num_peers = TARGET_HL_TLV_NUM_PEERS,
diff --git a/drivers/net/wireless/ath/ath10k/htt.c
b/drivers/net/wireless/ath/ath10k/htt.c
index 127b4e4980ef..bf8e1b5bf65c 100644
--- a/drivers/net/wireless/ath/ath10k/htt.c
+++ b/drivers/net/wireless/ath/ath10k/htt.c
@@ -131,6 +131,157 @@ static const enum htt_t2h_msg_type
htt_10_4_t2h_msg_types[] = {
                 HTT_T2H_MSG_TYPE_PEER_STATS,
 };

+const struct ath10k_htt_rx_desc_ops qca988x_rx_desc_ops = {
+    .rx_desc_size = sizeof(struct htt_rx_desc_old_qca),
+    .rx_desc_msdu_payload_offset = offsetof(struct
htt_rx_desc_old_qca, msdu_payload)
+};
+
+static int ath10k_qca99x0_rx_desc_get_l3_pad_bytes(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc = container_of(rxd, struct
htt_rx_desc_old_qca, base);
+
+    return MS(__le32_to_cpu(rx_desc->msdu_end.qca99x0.info1),
+          RX_MSDU_END_INFO1_L3_HDR_PAD);
+}
+
+static bool ath10k_qca99x0_rx_desc_msdu_limit_error(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc = container_of(rxd, struct
htt_rx_desc_old_qca, base);
+
+    return !!(rx_desc->msdu_end.common.info0 &
+          __cpu_to_le32(RX_MSDU_END_INFO0_MSDU_LIMIT_ERR));
+}
+
+const struct ath10k_htt_rx_desc_ops qca99x0_rx_desc_ops = {
+    .rx_desc_size = sizeof(struct htt_rx_desc_old_qca),
+    .rx_desc_msdu_payload_offset = offsetof(struct
htt_rx_desc_old_qca, msdu_payload),
+
+    .rx_desc_get_l3_pad_bytes = ath10k_qca99x0_rx_desc_get_l3_pad_bytes,
+    .rx_desc_get_msdu_limit_error = ath10k_qca99x0_rx_desc_msdu_limit_error,
+};
+
+static void ath10k_rx_desc_wcn3990_get_offsets(struct
htt_rx_ring_rx_desc_offsets *off)
+{
+#define desc_offset(x) (offsetof(struct htt_rx_desc_new, x) / 4)
+    off->mac80211_hdr_offset = __cpu_to_le16(desc_offset(rx_hdr_status));
+    off->msdu_payload_offset = __cpu_to_le16(desc_offset(msdu_payload));
+    off->ppdu_start_offset = __cpu_to_le16(desc_offset(ppdu_start));
+    off->ppdu_end_offset = __cpu_to_le16(desc_offset(ppdu_end));
+    off->mpdu_start_offset = __cpu_to_le16(desc_offset(mpdu_start));
+    off->mpdu_end_offset = __cpu_to_le16(desc_offset(mpdu_end));
+    off->msdu_start_offset = __cpu_to_le16(desc_offset(msdu_start));
+    off->msdu_end_offset = __cpu_to_le16(desc_offset(msdu_end));
+    off->rx_attention_offset = __cpu_to_le16(desc_offset(attention));
+    off->frag_info_offset = __cpu_to_le16(desc_offset(frag_info));
+#undef desc_metadata_offset
+#undef metadata_offset
+#undef desc_offset
+}
+
+static struct htt_rx_desc *
+ath10k_rx_desc_wcn3990_from_raw_buffer(void *buff)
+{
+    return &((struct htt_rx_desc_new *)buff)->base;
+}
+
+static struct rx_attention *
+ath10k_rx_desc_wcn3990_get_attention(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->attention;
+}
+
+static struct rx_frag_info_common *
+ath10k_rx_desc_wcn3990_get_frag_info(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->frag_info.common;
+}
+
+static struct rx_mpdu_start *
+ath10k_rx_desc_wcn3990_get_mpdu_start(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->mpdu_start;
+}
+
+static struct rx_mpdu_end *
+ath10k_rx_desc_wcn3990_get_mpdu_end(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->mpdu_end;
+}
+
+static struct rx_msdu_start_common *
+ath10k_rx_desc_wcn3990_get_msdu_start(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->msdu_start.common;
+}
+
+static struct rx_msdu_end_common *
+ath10k_rx_desc_wcn3990_get_msdu_end(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->msdu_end.common;
+}
+
+static struct rx_ppdu_start *
+ath10k_rx_desc_wcn3990_get_ppdu_start(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->ppdu_start;
+}
+
+static struct rx_ppdu_end_common *
+ath10k_rx_desc_wcn3990_get_ppdu_end(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return &rx_desc->ppdu_end.common;
+}
+
+static u8 *
+ath10k_rx_desc_wcn3990_get_rx_hdr_status(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return rx_desc->rx_hdr_status;
+}
+
+static u8 *
+ath10k_rx_desc_wcn3990_get_msdu_payload(struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_new *rx_desc = container_of(rxd, struct
htt_rx_desc_new, base);
+
+    return rx_desc->msdu_payload;
+}
+
+const struct ath10k_htt_rx_desc_ops wcn3990_rx_desc_ops = {
+    .rx_desc_size = sizeof(struct htt_rx_desc_new),
+    .rx_desc_msdu_payload_offset = offsetof(struct htt_rx_desc_new,
msdu_payload),
+
+    .rx_desc_from_raw_buffer = ath10k_rx_desc_wcn3990_from_raw_buffer,
+    .rx_desc_get_offsets = ath10k_rx_desc_wcn3990_get_offsets,
+    .rx_desc_get_attention = ath10k_rx_desc_wcn3990_get_attention,
+    .rx_desc_get_frag_info = ath10k_rx_desc_wcn3990_get_frag_info,
+    .rx_desc_get_mpdu_start = ath10k_rx_desc_wcn3990_get_mpdu_start,
+    .rx_desc_get_mpdu_end = ath10k_rx_desc_wcn3990_get_mpdu_end,
+    .rx_desc_get_msdu_start = ath10k_rx_desc_wcn3990_get_msdu_start,
+    .rx_desc_get_msdu_end = ath10k_rx_desc_wcn3990_get_msdu_end,
+    .rx_desc_get_ppdu_start = ath10k_rx_desc_wcn3990_get_ppdu_start,
+    .rx_desc_get_ppdu_end = ath10k_rx_desc_wcn3990_get_ppdu_end,
+    .rx_desc_get_rx_hdr_status = ath10k_rx_desc_wcn3990_get_rx_hdr_status,
+    .rx_desc_get_msdu_payload = ath10k_rx_desc_wcn3990_get_msdu_payload,
+};
+
 int ath10k_htt_connect(struct ath10k_htt *htt)
 {
     struct ath10k_htc_svc_conn_req conn_req;
diff --git a/drivers/net/wireless/ath/ath10k/htt.h
b/drivers/net/wireless/ath/ath10k/htt.h
index ec689e3ce48a..7c869fe523b4 100644
--- a/drivers/net/wireless/ath/ath10k/htt.h
+++ b/drivers/net/wireless/ath/ath10k/htt.h
@@ -240,14 +240,7 @@ enum htt_rx_ring_flags {
 #define HTT_RX_RING_FILL_LEVEL (((HTT_RX_RING_SIZE) / 2) - 1)
 #define HTT_RX_RING_FILL_LEVEL_DUAL_MAC (HTT_RX_RING_SIZE - 1)

-struct htt_rx_ring_setup_ring32 {
-    __le32 fw_idx_shadow_reg_paddr;
-    __le32 rx_ring_base_paddr;
-    __le16 rx_ring_len; /* in 4-byte words */
-    __le16 rx_ring_bufsize; /* rx skb size - in bytes */
-    __le16 flags; /* %HTT_RX_RING_FLAGS_ */
-    __le16 fw_idx_init_val;
-
+struct htt_rx_ring_rx_desc_offsets {
     /* the following offsets are in 4-byte units */
     __le16 mac80211_hdr_offset;
     __le16 msdu_payload_offset;
@@ -261,6 +254,17 @@ struct htt_rx_ring_setup_ring32 {
     __le16 frag_info_offset;
 } __packed;

+struct htt_rx_ring_setup_ring32 {
+    __le32 fw_idx_shadow_reg_paddr;
+    __le32 rx_ring_base_paddr;
+    __le16 rx_ring_len; /* in 4-byte words */
+    __le16 rx_ring_bufsize; /* rx skb size - in bytes */
+    __le16 flags; /* %HTT_RX_RING_FLAGS_ */
+    __le16 fw_idx_init_val;
+
+    struct htt_rx_ring_rx_desc_offsets offsets;
+} __packed;
+
 struct htt_rx_ring_setup_ring64 {
     __le64 fw_idx_shadow_reg_paddr;
     __le64 rx_ring_base_paddr;
@@ -269,17 +273,7 @@ struct htt_rx_ring_setup_ring64 {
     __le16 flags; /* %HTT_RX_RING_FLAGS_ */
     __le16 fw_idx_init_val;

-    /* the following offsets are in 4-byte units */
-    __le16 mac80211_hdr_offset;
-    __le16 msdu_payload_offset;
-    __le16 ppdu_start_offset;
-    __le16 ppdu_end_offset;
-    __le16 mpdu_start_offset;
-    __le16 mpdu_end_offset;
-    __le16 msdu_start_offset;
-    __le16 msdu_end_offset;
-    __le16 rx_attention_offset;
-    __le16 frag_info_offset;
+    struct htt_rx_ring_rx_desc_offsets offsets;
 } __packed;

 struct htt_rx_ring_setup_hdr {
@@ -2182,12 +2176,22 @@ static inline bool
ath10k_htt_rx_proc_rx_frag_ind(struct ath10k_htt *htt,
     return htt->rx_ops->htt_rx_proc_rx_frag_ind(htt, rx, skb);
 }

+/* the driver strongly assumes that the rx header status be 64 bytes long,
+ * so all possible rx_desc structures must respect this assumption.
+ */
 #define RX_HTT_HDR_STATUS_LEN 64

-/* This structure layout is programmed via rx ring setup
+/* The rx descriptor structure layout is programmed via rx ring setup
  * so that FW knows how to transfer the rx descriptor to the host.
- * Buffers like this are placed on the rx ring.
+ * Unfortunately, though, QCA6174's firmware doesn't currently behave correctly
+ * when modifying the structure layout of the rx descriptor beyond
what it expects
+ * (even if it correctly programmed during the rx ring setup).
+ * Therefore we must keep two different memory layouts, abstract the
rx descriptor
+ * representation and use ath10k_rx_desc_ops
+ * for correctly accessing rx descriptor data.
  */
+
+/* base struct used for abstracting the rx descritor representation */
 struct htt_rx_desc {
     union {
         /* This field is filled on the host using the msdu buffer
@@ -2196,6 +2200,13 @@ struct htt_rx_desc {
         struct fw_rx_desc_base fw_desc;
         u32 pad;
     } __packed;
+} __packed;
+
+/* rx descriptor for wcn3990 and possibly extensible for newer cards
+ * Buffers like this are placed on the rx ring.
+ */
+struct htt_rx_desc_new {
+    struct htt_rx_desc base;
     struct {
         struct rx_attention attention;
         struct rx_frag_info frag_info;
@@ -2210,6 +2221,240 @@ struct htt_rx_desc {
     u8 msdu_payload[];
 };

+/* QCA6174, QCA988x, QCA99x0 dedicated rx descriptor to make sure
their firmware
+ * works correctly. We keep a single rx descriptor for all these three
+ * families of cards because from tests it seems to be the most
stable solution,
+ * e.g. having a rx descriptor only for QCA6174 seldom caused firmware crashes
+ * during some tests.
+ * Buffers like this are placed on the rx ring.
+ */
+struct htt_rx_desc_old_qca {
+    struct htt_rx_desc base;
+    struct {
+        struct rx_attention attention;
+        struct rx_frag_info_old_qca frag_info;
+        struct rx_mpdu_start mpdu_start;
+        struct rx_msdu_start_old_qca msdu_start;
+        struct rx_msdu_end_old_qca msdu_end;
+        struct rx_mpdu_end mpdu_end;
+        struct rx_ppdu_start ppdu_start;
+        struct rx_ppdu_end_old_qca ppdu_end;
+    } __packed;
+    u8 rx_hdr_status[RX_HTT_HDR_STATUS_LEN];
+    u8 msdu_payload[];
+};
+
+/* rx_desc abstraction */
+struct ath10k_htt_rx_desc_ops {
+    /* These fields are mandatory, they must be specified in any instance */
+
+    /* sizeof() of the rx_desc structure used by this hw */
+    size_t rx_desc_size;
+
+    /* offset of msdu_payload inside the rx_desc structure used by this hw */
+    size_t rx_desc_msdu_payload_offset;
+
+    /* These fields are options.
+     * When a field is not provided the default implementation gets used
+     * (see the ath10k_rx_desc_* operations below for more info about
the defaults)
+     */
+    bool (*rx_desc_get_msdu_limit_error)(struct htt_rx_desc *rxd);
+    int (*rx_desc_get_l3_pad_bytes)(struct htt_rx_desc *rxd);
+
+    /* Safely cast from a void* buffer containing an rx descriptor
+     * to the proper rx_desc structure
+     */
+    struct htt_rx_desc *(*rx_desc_from_raw_buffer)(void *buff);
+
+    void (*rx_desc_get_offsets)(struct htt_rx_ring_rx_desc_offsets *offs);
+    struct rx_attention *(*rx_desc_get_attention)(struct htt_rx_desc *rxd);
+    struct rx_frag_info_common *(*rx_desc_get_frag_info)(struct
htt_rx_desc *rxd);
+    struct rx_mpdu_start *(*rx_desc_get_mpdu_start)(struct htt_rx_desc *rxd);
+    struct rx_mpdu_end *(*rx_desc_get_mpdu_end)(struct htt_rx_desc *rxd);
+    struct rx_msdu_start_common *(*rx_desc_get_msdu_start)(struct
htt_rx_desc *rxd);
+    struct rx_msdu_end_common *(*rx_desc_get_msdu_end)(struct
htt_rx_desc *rxd);
+    struct rx_ppdu_start *(*rx_desc_get_ppdu_start)(struct htt_rx_desc *rxd);
+    struct rx_ppdu_end_common *(*rx_desc_get_ppdu_end)(struct
htt_rx_desc *rxd);
+    u8 *(*rx_desc_get_rx_hdr_status)(struct htt_rx_desc *rxd);
+    u8 *(*rx_desc_get_msdu_payload)(struct htt_rx_desc *rxd);
+};
+
+extern const struct ath10k_htt_rx_desc_ops qca988x_rx_desc_ops;
+extern const struct ath10k_htt_rx_desc_ops qca99x0_rx_desc_ops;
+extern const struct ath10k_htt_rx_desc_ops wcn3990_rx_desc_ops;
+
+static inline int
+ath10k_htt_rx_desc_get_l3_pad_bytes(struct ath10k_hw_params *hw,
struct htt_rx_desc *rxd)
+{
+    if (hw->rx_desc_ops->rx_desc_get_l3_pad_bytes)
+        return hw->rx_desc_ops->rx_desc_get_l3_pad_bytes(rxd);
+    return 0;
+}
+
+static inline bool
+ath10k_htt_rx_desc_msdu_limit_error(struct ath10k_hw_params *hw,
struct htt_rx_desc *rxd)
+{
+    if (hw->rx_desc_ops->rx_desc_get_msdu_limit_error)
+        return hw->rx_desc_ops->rx_desc_get_msdu_limit_error(rxd);
+    return false;
+}
+
+/* The default implementation of all these getters is using the old rx_desc,
+ * so that it is easier to define the ath10k_htt_rx_desc_ops instances.
+ * But probably, if new wireless cards must be supported, it would be better
+ * to switch the default implementation to the new rx_desc, since this would
+ * make the extension easier .
+ */
+static inline struct htt_rx_desc *
+ath10k_htt_rx_desc_from_raw_buffer(struct ath10k_hw_params *hw,    void *buff)
+{
+    if (hw->rx_desc_ops->rx_desc_from_raw_buffer)
+        return hw->rx_desc_ops->rx_desc_from_raw_buffer(buff);
+    return &((struct htt_rx_desc_old_qca *)buff)->base;
+}
+
+static inline void
+ath10k_htt_rx_desc_get_offsets(struct ath10k_hw_params *hw,
+                   struct htt_rx_ring_rx_desc_offsets *off)
+{
+    if (hw->rx_desc_ops->rx_desc_get_offsets) {
+        hw->rx_desc_ops->rx_desc_get_offsets(off);
+    } else {
+#define    desc_offset(x) (offsetof(struct    htt_rx_desc_old_qca, x)    / 4)
+        off->mac80211_hdr_offset = __cpu_to_le16(desc_offset(rx_hdr_status));
+        off->msdu_payload_offset = __cpu_to_le16(desc_offset(msdu_payload));
+        off->ppdu_start_offset = __cpu_to_le16(desc_offset(ppdu_start));
+        off->ppdu_end_offset = __cpu_to_le16(desc_offset(ppdu_end));
+        off->mpdu_start_offset = __cpu_to_le16(desc_offset(mpdu_start));
+        off->mpdu_end_offset = __cpu_to_le16(desc_offset(mpdu_end));
+        off->msdu_start_offset = __cpu_to_le16(desc_offset(msdu_start));
+        off->msdu_end_offset = __cpu_to_le16(desc_offset(msdu_end));
+        off->rx_attention_offset = __cpu_to_le16(desc_offset(attention));
+        off->frag_info_offset =    __cpu_to_le16(desc_offset(frag_info));
+#undef desc_offset
+    }
+}
+
+static inline struct rx_attention *
+ath10k_htt_rx_desc_get_attention(struct    ath10k_hw_params *hw,
struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_attention)
+        return hw->rx_desc_ops->rx_desc_get_attention(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->attention;
+}
+
+static inline struct rx_frag_info_common *
+ath10k_htt_rx_desc_get_frag_info(struct    ath10k_hw_params *hw,
struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_frag_info)
+        return hw->rx_desc_ops->rx_desc_get_frag_info(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->frag_info.common;
+}
+
+static inline struct rx_mpdu_start *
+ath10k_htt_rx_desc_get_mpdu_start(struct ath10k_hw_params *hw, struct
htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_mpdu_start)
+        return hw->rx_desc_ops->rx_desc_get_mpdu_start(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->mpdu_start;
+}
+
+static inline struct rx_mpdu_end *
+ath10k_htt_rx_desc_get_mpdu_end(struct ath10k_hw_params    *hw,
struct htt_rx_desc    *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_mpdu_end)
+        return hw->rx_desc_ops->rx_desc_get_mpdu_end(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->mpdu_end;
+}
+
+static inline struct rx_msdu_start_common *
+ath10k_htt_rx_desc_get_msdu_start(struct ath10k_hw_params *hw, struct
htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_msdu_start)
+        return hw->rx_desc_ops->rx_desc_get_msdu_start(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->msdu_start.common;
+}
+
+static inline struct rx_msdu_end_common    *
+ath10k_htt_rx_desc_get_msdu_end(struct ath10k_hw_params    *hw,
struct htt_rx_desc    *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_msdu_end)
+        return hw->rx_desc_ops->rx_desc_get_msdu_end(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->msdu_end.common;
+}
+
+static inline struct rx_ppdu_start *
+ath10k_htt_rx_desc_get_ppdu_start(struct ath10k_hw_params *hw, struct
htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_ppdu_start)
+        return hw->rx_desc_ops->rx_desc_get_ppdu_start(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->ppdu_start;
+}
+
+static inline struct rx_ppdu_end_common    *
+ath10k_htt_rx_desc_get_ppdu_end(struct ath10k_hw_params    *hw,
struct htt_rx_desc    *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_ppdu_end)
+        return hw->rx_desc_ops->rx_desc_get_ppdu_end(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return &rx_desc->ppdu_end.common;
+}
+
+static inline u8 *
+ath10k_htt_rx_desc_get_rx_hdr_status(struct ath10k_hw_params *hw,
struct htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_rx_hdr_status)
+        return hw->rx_desc_ops->rx_desc_get_rx_hdr_status(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return rx_desc->rx_hdr_status;
+}
+
+static inline u8 *
+ath10k_htt_rx_desc_get_msdu_payload(struct ath10k_hw_params *hw,
struct    htt_rx_desc *rxd)
+{
+    struct htt_rx_desc_old_qca *rx_desc;
+
+    if (hw->rx_desc_ops->rx_desc_get_msdu_payload)
+        return hw->rx_desc_ops->rx_desc_get_msdu_payload(rxd);
+
+    rx_desc = container_of(rxd, struct htt_rx_desc_old_qca, base);
+    return rx_desc->msdu_payload;
+}
+
 #define HTT_RX_DESC_HL_INFO_SEQ_NUM_MASK           0x00000fff
 #define HTT_RX_DESC_HL_INFO_SEQ_NUM_LSB            0
 #define HTT_RX_DESC_HL_INFO_ENCRYPTED_MASK         0x00001000
@@ -2243,7 +2488,14 @@ struct htt_rx_chan_info {
  * rounded up to a cache line size.
  */
 #define HTT_RX_BUF_SIZE 2048
-#define HTT_RX_MSDU_SIZE (HTT_RX_BUF_SIZE - (int)sizeof(struct htt_rx_desc))
+
+/* The HTT_RX_MSDU_SIZE can't be statically computed anymore,
+ * because it depends on the underlying device rx_desc representation
+ */
+static inline int ath10k_htt_rx_msdu_size(struct ath10k_hw_params *hw)
+{
+    return HTT_RX_BUF_SIZE - (int)hw->rx_desc_ops->rx_desc_size;
+}

 /* Refill a bunch of RX buffers for each refill round so that FW/HW can handle
  * aggregated traffic more nicely.
diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c
b/drivers/net/wireless/ath/ath10k/htt_rx.c
index adbaeb67eedf..531d8231c427 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -21,7 +21,10 @@

 #define HTT_RX_RING_REFILL_RESCHED_MS 5

-static int ath10k_htt_rx_get_csum_state(struct sk_buff *skb);
+/* shortcut to interpret a raw memory buffer as a rx descriptor */
+#define HTT_RX_BUF_TO_RX_DESC(hw, buf)
ath10k_htt_rx_desc_from_raw_buffer(hw, buf)
+
+static int ath10k_htt_rx_get_csum_state(struct ath10k_hw_params *hw,
struct sk_buff *skb);

 static struct sk_buff *
 ath10k_htt_rx_find_skb_paddr(struct ath10k *ar, u64 paddr)
@@ -128,6 +131,7 @@ static void *ath10k_htt_get_vaddr_ring_64(struct
ath10k_htt *htt)

 static int __ath10k_htt_rx_ring_fill_n(struct ath10k_htt *htt, int num)
 {
+    struct ath10k_hw_params *hw = &htt->ar->hw_params;
     struct htt_rx_desc *rx_desc;
     struct ath10k_skb_rxcb *rxcb;
     struct sk_buff *skb;
@@ -163,8 +167,8 @@ static int __ath10k_htt_rx_ring_fill_n(struct
ath10k_htt *htt, int num)
                  skb->data);

         /* Clear rx_desc attention word before posting to Rx ring */
-        rx_desc = (struct htt_rx_desc *)skb->data;
-        rx_desc->attention.flags = __cpu_to_le32(0);
+        rx_desc = HTT_RX_BUF_TO_RX_DESC(hw, skb->data);
+        ath10k_htt_rx_desc_get_attention(hw, rx_desc)->flags =
__cpu_to_le32(0);

         paddr = dma_map_single(htt->ar->dev, skb->data,
                        skb->len + skb_tailroom(skb),
@@ -343,9 +347,14 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,
                    struct sk_buff_head *amsdu)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     int msdu_len, msdu_chaining = 0;
     struct sk_buff *msdu;
     struct htt_rx_desc *rx_desc;
+    struct rx_attention *rx_desc_attention;
+    struct rx_frag_info_common *rx_desc_frag_info_common;
+    struct rx_msdu_start_common *rx_desc_msdu_start_common;
+    struct rx_msdu_end_common *rx_desc_msdu_end_common;

     lockdep_assert_held(&htt->rx_ring.lock);

@@ -360,13 +369,17 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,

         __skb_queue_tail(amsdu, msdu);

-        rx_desc = (struct htt_rx_desc *)msdu->data;
+        rx_desc = HTT_RX_BUF_TO_RX_DESC(hw, msdu->data);
+        rx_desc_attention = ath10k_htt_rx_desc_get_attention(hw, rx_desc);
+        rx_desc_msdu_start_common =
ath10k_htt_rx_desc_get_msdu_start(hw, rx_desc);
+        rx_desc_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rx_desc);
+        rx_desc_frag_info_common =
ath10k_htt_rx_desc_get_frag_info(hw, rx_desc);

         /* FIXME: we must report msdu payload since this is what caller
          * expects now
          */
-        skb_put(msdu, offsetof(struct htt_rx_desc, msdu_payload));
-        skb_pull(msdu, offsetof(struct htt_rx_desc, msdu_payload));
+        skb_put(msdu, hw->rx_desc_ops->rx_desc_msdu_payload_offset);
+        skb_pull(msdu, hw->rx_desc_ops->rx_desc_msdu_payload_offset);

         /*
          * Sanity check - confirm the HW is finished filling in the
@@ -376,24 +389,24 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,
          * To prevent the case that we handle a stale Rx descriptor,
          * just assert for now until we have a way to recover.
          */
-        if (!(__le32_to_cpu(rx_desc->attention.flags)
+        if (!(__le32_to_cpu(rx_desc_attention->flags)
                 & RX_ATTENTION_FLAGS_MSDU_DONE)) {
             __skb_queue_purge(amsdu);
             return -EIO;
         }

-        msdu_len_invalid = !!(__le32_to_cpu(rx_desc->attention.flags)
+        msdu_len_invalid = !!(__le32_to_cpu(rx_desc_attention->flags)
                     & (RX_ATTENTION_FLAGS_MPDU_LENGTH_ERR |
                        RX_ATTENTION_FLAGS_MSDU_LENGTH_ERR));
-        msdu_len = MS(__le32_to_cpu(rx_desc->msdu_start.common.info0),
+        msdu_len = MS(__le32_to_cpu(rx_desc_msdu_start_common->info0),
                   RX_MSDU_START_INFO0_MSDU_LENGTH);
-        msdu_chained = rx_desc->frag_info.ring2_more_count;
+        msdu_chained = rx_desc_frag_info_common->ring2_more_count;

         if (msdu_len_invalid)
             msdu_len = 0;

         skb_trim(msdu, 0);
-        skb_put(msdu, min(msdu_len, HTT_RX_MSDU_SIZE));
+        skb_put(msdu, min(msdu_len, ath10k_htt_rx_msdu_size(hw)));
         msdu_len -= msdu->len;

         /* Note: Chained buffers do not contain rx descriptor */
@@ -411,11 +424,12 @@ static int ath10k_htt_rx_amsdu_pop(struct ath10k_htt *htt,
             msdu_chaining = 1;
         }

-        last_msdu = __le32_to_cpu(rx_desc->msdu_end.common.info0) &
+        last_msdu = __le32_to_cpu(rx_desc_msdu_end_common->info0) &
                 RX_MSDU_END_INFO0_LAST_MSDU;

-        trace_ath10k_htt_rx_desc(ar, &rx_desc->attention,
-                     sizeof(*rx_desc) - sizeof(u32));
+        /* FIXME: why are we skipping the first part of the rx_desc? */
+        trace_ath10k_htt_rx_desc(ar, rx_desc + sizeof(u32),
+                     hw->rx_desc_ops->rx_desc_size - sizeof(u32));

         if (last_msdu)
             break;
@@ -480,6 +494,7 @@ static int
ath10k_htt_rx_handle_amsdu_mon_32(struct ath10k_htt *htt,
                          struct htt_rx_in_ord_msdu_desc **msdu_desc)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     u32 paddr;
     struct sk_buff *frag_buf;
     struct sk_buff *prev_frag_buf;
@@ -488,12 +503,12 @@ static int
ath10k_htt_rx_handle_amsdu_mon_32(struct ath10k_htt *htt,
     struct htt_rx_desc *rxd;
     int amsdu_len = __le16_to_cpu(ind_desc->msdu_len);

-    rxd = (void *)msdu->data;
-    trace_ath10k_htt_rx_desc(ar, rxd, sizeof(*rxd));
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, msdu->data);
+    trace_ath10k_htt_rx_desc(ar, rxd, hw->rx_desc_ops->rx_desc_size);

-    skb_put(msdu, sizeof(struct htt_rx_desc));
-    skb_pull(msdu, sizeof(struct htt_rx_desc));
-    skb_put(msdu, min(amsdu_len, HTT_RX_MSDU_SIZE));
+    skb_put(msdu, hw->rx_desc_ops->rx_desc_size);
+    skb_pull(msdu, hw->rx_desc_ops->rx_desc_size);
+    skb_put(msdu, min(amsdu_len, ath10k_htt_rx_msdu_size(hw)));
     amsdu_len -= msdu->len;

     last_frag = ind_desc->reserved;
@@ -556,6 +571,7 @@ ath10k_htt_rx_handle_amsdu_mon_64(struct ath10k_htt *htt,
                   struct htt_rx_in_ord_msdu_desc_ext **msdu_desc)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     u64 paddr;
     struct sk_buff *frag_buf;
     struct sk_buff *prev_frag_buf;
@@ -564,12 +580,12 @@ ath10k_htt_rx_handle_amsdu_mon_64(struct ath10k_htt *htt,
     struct htt_rx_desc *rxd;
     int amsdu_len = __le16_to_cpu(ind_desc->msdu_len);

-    rxd = (void *)msdu->data;
-    trace_ath10k_htt_rx_desc(ar, rxd, sizeof(*rxd));
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, msdu->data);
+    trace_ath10k_htt_rx_desc(ar, rxd, hw->rx_desc_ops->rx_desc_size);

-    skb_put(msdu, sizeof(struct htt_rx_desc));
-    skb_pull(msdu, sizeof(struct htt_rx_desc));
-    skb_put(msdu, min(amsdu_len, HTT_RX_MSDU_SIZE));
+    skb_put(msdu, hw->rx_desc_ops->rx_desc_size);
+    skb_pull(msdu, hw->rx_desc_ops->rx_desc_size);
+    skb_put(msdu, min(amsdu_len, ath10k_htt_rx_msdu_size(hw)));
     amsdu_len -= msdu->len;

     last_frag = ind_desc->reserved;
@@ -631,8 +647,10 @@ static int ath10k_htt_rx_pop_paddr32_list(struct
ath10k_htt *htt,
                       struct sk_buff_head *list)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_in_ord_msdu_desc *msdu_desc = ev->msdu_descs32;
     struct htt_rx_desc *rxd;
+    struct rx_attention *rxd_attention;
     struct sk_buff *msdu;
     int msdu_count, ret;
     bool is_offload;
@@ -667,15 +685,16 @@ static int ath10k_htt_rx_pop_paddr32_list(struct
ath10k_htt *htt,
         __skb_queue_tail(list, msdu);

         if (!is_offload) {
-            rxd = (void *)msdu->data;
+            rxd = HTT_RX_BUF_TO_RX_DESC(hw, msdu->data);
+            rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);

-            trace_ath10k_htt_rx_desc(ar, rxd, sizeof(*rxd));
+            trace_ath10k_htt_rx_desc(ar, rxd, hw->rx_desc_ops->rx_desc_size);

-            skb_put(msdu, sizeof(*rxd));
-            skb_pull(msdu, sizeof(*rxd));
+            skb_put(msdu, hw->rx_desc_ops->rx_desc_size);
+            skb_pull(msdu, hw->rx_desc_ops->rx_desc_size);
             skb_put(msdu, __le16_to_cpu(msdu_desc->msdu_len));

-            if (!(__le32_to_cpu(rxd->attention.flags) &
+            if (!(__le32_to_cpu(rxd_attention->flags) &
                   RX_ATTENTION_FLAGS_MSDU_DONE)) {
                 ath10k_warn(htt->ar, "tried to pop an incomplete
frame, oops!\n");
                 return -EIO;
@@ -693,8 +712,10 @@ static int ath10k_htt_rx_pop_paddr64_list(struct
ath10k_htt *htt,
                       struct sk_buff_head *list)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_in_ord_msdu_desc_ext *msdu_desc = ev->msdu_descs64;
     struct htt_rx_desc *rxd;
+    struct rx_attention *rxd_attention;
     struct sk_buff *msdu;
     int msdu_count, ret;
     bool is_offload;
@@ -728,15 +749,16 @@ static int ath10k_htt_rx_pop_paddr64_list(struct
ath10k_htt *htt,
         __skb_queue_tail(list, msdu);

         if (!is_offload) {
-            rxd = (void *)msdu->data;
+            rxd = HTT_RX_BUF_TO_RX_DESC(hw, msdu->data);
+            rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);

-            trace_ath10k_htt_rx_desc(ar, rxd, sizeof(*rxd));
+            trace_ath10k_htt_rx_desc(ar, rxd, hw->rx_desc_ops->rx_desc_size);

-            skb_put(msdu, sizeof(*rxd));
-            skb_pull(msdu, sizeof(*rxd));
+            skb_put(msdu, hw->rx_desc_ops->rx_desc_size);
+            skb_pull(msdu, hw->rx_desc_ops->rx_desc_size);
             skb_put(msdu, __le16_to_cpu(msdu_desc->msdu_len));

-            if (!(__le32_to_cpu(rxd->attention.flags) &
+            if (!(__le32_to_cpu(rxd_attention->flags) &
                   RX_ATTENTION_FLAGS_MSDU_DONE)) {
                 ath10k_warn(htt->ar, "tried to pop an incomplete
frame, oops!\n");
                 return -EIO;
@@ -944,6 +966,18 @@ static void ath10k_htt_rx_h_rates(struct ath10k *ar,
                   struct ieee80211_rx_status *status,
                   struct htt_rx_desc *rxd)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
+    struct rx_attention *rxd_attention =
ath10k_htt_rx_desc_get_attention(hw, rxd);
+    struct rx_mpdu_start *rxd_mpdu_start =
ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);
+    struct rx_mpdu_end *rxd_mpdu_end =
ath10k_htt_rx_desc_get_mpdu_end(hw, rxd);
+    struct rx_msdu_start_common *rxd_msdu_start_common =
+        ath10k_htt_rx_desc_get_msdu_start(hw, rxd);
+
+    struct rx_msdu_end_common *rxd_msdu_end_common =
+        ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+
+    struct rx_ppdu_start *rxd_ppdu_start =
ath10k_htt_rx_desc_get_ppdu_start(hw, rxd);
+    u8 *rxd_msdu_payload = ath10k_htt_rx_desc_get_msdu_payload(hw, rxd);
     struct ieee80211_supported_band *sband;
     u8 cck, rate, bw, sgi, mcs, nss;
     u8 preamble = 0;
@@ -951,9 +985,9 @@ static void ath10k_htt_rx_h_rates(struct ath10k *ar,
     u32 info1, info2, info3;
     u32 stbc, nsts_su;

-    info1 = __le32_to_cpu(rxd->ppdu_start.info1);
-    info2 = __le32_to_cpu(rxd->ppdu_start.info2);
-    info3 = __le32_to_cpu(rxd->ppdu_start.info3);
+    info1 = __le32_to_cpu(rxd_ppdu_start->info1);
+    info2 = __le32_to_cpu(rxd_ppdu_start->info2);
+    info3 = __le32_to_cpu(rxd_ppdu_start->info3);

     preamble = MS(info1, RX_PPDU_START_INFO1_PREAMBLE_TYPE);

@@ -1022,24 +1056,24 @@ static void ath10k_htt_rx_h_rates(struct ath10k *ar,
         if (mcs > 0x09) {
             ath10k_warn(ar, "invalid MCS received %u\n", mcs);
             ath10k_warn(ar, "rxd %08x mpdu start %08x %08x msdu start
%08x %08x ppdu start %08x %08x %08x %08x %08x\n",
-                    __le32_to_cpu(rxd->attention.flags),
-                    __le32_to_cpu(rxd->mpdu_start.info0),
-                    __le32_to_cpu(rxd->mpdu_start.info1),
-                    __le32_to_cpu(rxd->msdu_start.common.info0),
-                    __le32_to_cpu(rxd->msdu_start.common.info1),
-                    rxd->ppdu_start.info0,
-                    __le32_to_cpu(rxd->ppdu_start.info1),
-                    __le32_to_cpu(rxd->ppdu_start.info2),
-                    __le32_to_cpu(rxd->ppdu_start.info3),
-                    __le32_to_cpu(rxd->ppdu_start.info4));
+                    __le32_to_cpu(rxd_attention->flags),
+                    __le32_to_cpu(rxd_mpdu_start->info0),
+                    __le32_to_cpu(rxd_mpdu_start->info1),
+                    __le32_to_cpu(rxd_msdu_start_common->info0),
+                    __le32_to_cpu(rxd_msdu_start_common->info1),
+                    rxd_ppdu_start->info0,
+                    __le32_to_cpu(rxd_ppdu_start->info1),
+                    __le32_to_cpu(rxd_ppdu_start->info2),
+                    __le32_to_cpu(rxd_ppdu_start->info3),
+                    __le32_to_cpu(rxd_ppdu_start->info4));

             ath10k_warn(ar, "msdu end %08x mpdu end %08x\n",
-                    __le32_to_cpu(rxd->msdu_end.common.info0),
-                    __le32_to_cpu(rxd->mpdu_end.info0));
+                    __le32_to_cpu(rxd_msdu_end_common->info0),
+                    __le32_to_cpu(rxd_mpdu_end->info0));

             ath10k_dbg_dump(ar, ATH10K_DBG_HTT_DUMP, NULL,
                     "rx desc msdu payload: ",
-                    rxd->msdu_payload, 50);
+                    rxd_msdu_payload, 50);
         }

         status->rate_idx = mcs;
@@ -1059,6 +1093,10 @@ static void ath10k_htt_rx_h_rates(struct ath10k *ar,
 static struct ieee80211_channel *
 ath10k_htt_rx_h_peer_channel(struct ath10k *ar, struct htt_rx_desc *rxd)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
+    struct rx_attention *rxd_attention =
ath10k_htt_rx_desc_get_attention(hw, rxd);
+    struct rx_msdu_end_common *rxd_msdu_end_common =
ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+    struct rx_mpdu_start *rxd_mpdu_start =
ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);
     struct ath10k_peer *peer;
     struct ath10k_vif *arvif;
     struct cfg80211_chan_def def;
@@ -1069,15 +1107,15 @@ ath10k_htt_rx_h_peer_channel(struct ath10k
*ar, struct htt_rx_desc *rxd)
     if (!rxd)
         return NULL;

-    if (rxd->attention.flags &
+    if (rxd_attention->flags &
         __cpu_to_le32(RX_ATTENTION_FLAGS_PEER_IDX_INVALID))
         return NULL;

-    if (!(rxd->msdu_end.common.info0 &
+    if (!(rxd_msdu_end_common->info0 &
           __cpu_to_le32(RX_MSDU_END_INFO0_FIRST_MSDU)))
         return NULL;

-    peer_id = MS(__le32_to_cpu(rxd->mpdu_start.info0),
+    peer_id = MS(__le32_to_cpu(rxd_mpdu_start->info0),
              RX_MPDU_START_INFO0_PEER_IDX);

     peer = ath10k_peer_find_by_id(ar, peer_id);
@@ -1167,14 +1205,16 @@ static void ath10k_htt_rx_h_signal(struct ath10k *ar,
                    struct ieee80211_rx_status *status,
                    struct htt_rx_desc *rxd)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
+    struct rx_ppdu_start *rxd_ppdu_start =
ath10k_htt_rx_desc_get_ppdu_start(hw, rxd);
     int i;

     for (i = 0; i < IEEE80211_MAX_CHAINS ; i++) {
         status->chains &= ~BIT(i);

-        if (rxd->ppdu_start.rssi_chains[i].pri20_mhz != 0x80) {
+        if (rxd_ppdu_start->rssi_chains[i].pri20_mhz != 0x80) {
             status->chain_signal[i] = ATH10K_DEFAULT_NOISE_FLOOR +
-                rxd->ppdu_start.rssi_chains[i].pri20_mhz;
+                rxd_ppdu_start->rssi_chains[i].pri20_mhz;

             status->chains |= BIT(i);
         }
@@ -1182,7 +1222,7 @@ static void ath10k_htt_rx_h_signal(struct ath10k *ar,

     /* FIXME: Get real NF */
     status->signal = ATH10K_DEFAULT_NOISE_FLOOR +
-             rxd->ppdu_start.rssi_comb;
+             rxd_ppdu_start->rssi_comb;
     status->flag &= ~RX_FLAG_NO_SIGNAL_VAL;
 }

@@ -1190,13 +1230,15 @@ static void ath10k_htt_rx_h_mactime(struct ath10k *ar,
                     struct ieee80211_rx_status *status,
                     struct htt_rx_desc *rxd)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
+    struct rx_ppdu_end_common *rxd_ppdu_end_common =
ath10k_htt_rx_desc_get_ppdu_end(hw, rxd);
     /* FIXME: TSF is known only at the end of PPDU, in the last MPDU. This
      * means all prior MSDUs in a PPDU are reported to mac80211 without the
      * TSF. Is it worth holding frames until end of PPDU is known?
      *
      * FIXME: Can we get/compute 64bit TSF?
      */
-    status->mactime = __le32_to_cpu(rxd->ppdu_end.common.tsf_timestamp);
+    status->mactime = __le32_to_cpu(rxd_ppdu_end_common->tsf_timestamp);
     status->flag |= RX_FLAG_MACTIME_END;
 }

@@ -1206,7 +1248,9 @@ static void ath10k_htt_rx_h_ppdu(struct ath10k *ar,
                  u32 vdev_id)
 {
     struct sk_buff *first;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_attention *rxd_attention;
     bool is_first_ppdu;
     bool is_last_ppdu;

@@ -1214,11 +1258,13 @@ static void ath10k_htt_rx_h_ppdu(struct ath10k *ar,
         return;

     first = skb_peek(amsdu);
-    rxd = (void *)first->data - sizeof(*rxd);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)first->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);

-    is_first_ppdu = !!(rxd->attention.flags &
+    is_first_ppdu = !!(rxd_attention->flags &
                __cpu_to_le32(RX_ATTENTION_FLAGS_FIRST_MPDU));
-    is_last_ppdu = !!(rxd->attention.flags &
+    is_last_ppdu = !!(rxd_attention->flags &
               __cpu_to_le32(RX_ATTENTION_FLAGS_LAST_MPDU));

     if (is_first_ppdu) {
@@ -1357,7 +1403,9 @@ static void ath10k_htt_rx_h_undecap_raw(struct ath10k *ar,
                     const u8 first_hdr[64])
 {
     struct ieee80211_hdr *hdr;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_msdu_end_common *rxd_msdu_end_common;
     size_t hdr_len;
     size_t crypto_len;
     bool is_first;
@@ -1366,10 +1414,12 @@ static void ath10k_htt_rx_h_undecap_raw(struct
ath10k *ar,
     int bytes_aligned = ar->hw_params.decap_align_bytes;
     u8 *qos;

-    rxd = (void *)msdu->data - sizeof(*rxd);
-    is_first = !!(rxd->msdu_end.common.info0 &
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+    is_first = !!(rxd_msdu_end_common->info0 &
               __cpu_to_le32(RX_MSDU_END_INFO0_FIRST_MSDU));
-    is_last = !!(rxd->msdu_end.common.info0 &
+    is_last = !!(rxd_msdu_end_common->info0 &
              __cpu_to_le32(RX_MSDU_END_INFO0_LAST_MSDU));

     /* Delivered decapped frame:
@@ -1387,7 +1437,7 @@ static void ath10k_htt_rx_h_undecap_raw(struct ath10k *ar,
      * error packets. If limit exceeds, hw sends all remaining MSDUs as
      * a single last MSDU with this msdu limit error set.
      */
-    msdu_limit_err = ath10k_rx_desc_msdu_limit_error(&ar->hw_params, rxd);
+    msdu_limit_err = ath10k_htt_rx_desc_msdu_limit_error(hw, rxd);

     /* If MSDU limit error happens, then don't warn on, the partial raw MSDU
      * without first MSDU is expected in that case, and handled later here.
@@ -1479,6 +1529,7 @@ static void ath10k_htt_rx_h_undecap_nwifi(struct
ath10k *ar,
                       const u8 first_hdr[64],
                       enum htt_rx_mpdu_encrypt_type enctype)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct ieee80211_hdr *hdr;
     struct htt_rx_desc *rxd;
     size_t hdr_len;
@@ -1499,9 +1550,9 @@ static void ath10k_htt_rx_h_undecap_nwifi(struct
ath10k *ar,
      */

     /* pull decapped header and copy SA & DA */
-    rxd = (void *)msdu->data - sizeof(*rxd);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);

-    l3_pad_bytes = ath10k_rx_desc_get_l3_pad_bytes(&ar->hw_params, rxd);
+    l3_pad_bytes = ath10k_htt_rx_desc_get_l3_pad_bytes(&ar->hw_params, rxd);
     skb_put(msdu, l3_pad_bytes);

     hdr = (struct ieee80211_hdr *)(msdu->data + l3_pad_bytes);
@@ -1537,18 +1588,24 @@ static void
*ath10k_htt_rx_h_find_rfc1042(struct ath10k *ar,
                       enum htt_rx_mpdu_encrypt_type enctype)
 {
     struct ieee80211_hdr *hdr;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_msdu_end_common *rxd_msdu_end_common;
+    u8 *rxd_rx_hdr_status;
     size_t hdr_len, crypto_len;
     void *rfc1042;
     bool is_first, is_last, is_amsdu;
     int bytes_aligned = ar->hw_params.decap_align_bytes;

-    rxd = (void *)msdu->data - sizeof(*rxd);
-    hdr = (void *)rxd->rx_hdr_status;
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+    rxd_rx_hdr_status = ath10k_htt_rx_desc_get_rx_hdr_status(hw, rxd);
+    hdr = (void *)rxd_rx_hdr_status;

-    is_first = !!(rxd->msdu_end.common.info0 &
+    is_first = !!(rxd_msdu_end_common->info0 &
               __cpu_to_le32(RX_MSDU_END_INFO0_FIRST_MSDU));
-    is_last = !!(rxd->msdu_end.common.info0 &
+    is_last = !!(rxd_msdu_end_common->info0 &
              __cpu_to_le32(RX_MSDU_END_INFO0_LAST_MSDU));
     is_amsdu = !(is_first && is_last);

@@ -1574,6 +1631,7 @@ static void ath10k_htt_rx_h_undecap_eth(struct ath10k *ar,
                     const u8 first_hdr[64],
                     enum htt_rx_mpdu_encrypt_type enctype)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct ieee80211_hdr *hdr;
     struct ethhdr *eth;
     size_t hdr_len;
@@ -1593,8 +1651,9 @@ static void ath10k_htt_rx_h_undecap_eth(struct ath10k *ar,
     if (WARN_ON_ONCE(!rfc1042))
         return;

-    rxd = (void *)msdu->data - sizeof(*rxd);
-    l3_pad_bytes = ath10k_rx_desc_get_l3_pad_bytes(&ar->hw_params, rxd);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+    l3_pad_bytes = ath10k_htt_rx_desc_get_l3_pad_bytes(&ar->hw_params, rxd);
     skb_put(msdu, l3_pad_bytes);
     skb_pull(msdu, l3_pad_bytes);

@@ -1635,6 +1694,7 @@ static void ath10k_htt_rx_h_undecap_snap(struct
ath10k *ar,
                      const u8 first_hdr[64],
                      enum htt_rx_mpdu_encrypt_type enctype)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct ieee80211_hdr *hdr;
     size_t hdr_len;
     int l3_pad_bytes;
@@ -1647,8 +1707,9 @@ static void ath10k_htt_rx_h_undecap_snap(struct
ath10k *ar,
      * [payload]
      */

-    rxd = (void *)msdu->data - sizeof(*rxd);
-    l3_pad_bytes = ath10k_rx_desc_get_l3_pad_bytes(&ar->hw_params, rxd);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+    l3_pad_bytes = ath10k_htt_rx_desc_get_l3_pad_bytes(&ar->hw_params, rxd);

     skb_put(msdu, l3_pad_bytes);
     skb_pull(msdu, sizeof(struct amsdu_subframe_hdr) + l3_pad_bytes);
@@ -1673,7 +1734,9 @@ static void ath10k_htt_rx_h_undecap(struct ath10k *ar,
                     enum htt_rx_mpdu_encrypt_type enctype,
                     bool is_decrypted)
 {
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_msdu_start_common *rxd_msdu_start_common;
     enum rx_msdu_decap_format decap;

     /* First msdu's decapped header:
@@ -1687,8 +1750,10 @@ static void ath10k_htt_rx_h_undecap(struct ath10k *ar,
      * [rfc1042/llc]
      */

-    rxd = (void *)msdu->data - sizeof(*rxd);
-    decap = MS(__le32_to_cpu(rxd->msdu_start.common.info1),
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_msdu_start_common = ath10k_htt_rx_desc_get_msdu_start(hw, rxd);
+    decap = MS(__le32_to_cpu(rxd_msdu_start_common->info1),
            RX_MSDU_START_INFO1_DECAP_FORMAT);

     switch (decap) {
@@ -1710,17 +1775,22 @@ static void ath10k_htt_rx_h_undecap(struct ath10k *ar,
     }
 }

-static int ath10k_htt_rx_get_csum_state(struct sk_buff *skb)
+static int ath10k_htt_rx_get_csum_state(struct ath10k_hw_params *hw,
struct sk_buff *skb)
 {
     struct htt_rx_desc *rxd;
+    struct rx_attention *rxd_attention;
+    struct rx_msdu_start_common *rxd_msdu_start_common;
     u32 flags, info;
     bool is_ip4, is_ip6;
     bool is_tcp, is_udp;
     bool ip_csum_ok, tcpudp_csum_ok;

-    rxd = (void *)skb->data - sizeof(*rxd);
-    flags = __le32_to_cpu(rxd->attention.flags);
-    info = __le32_to_cpu(rxd->msdu_start.common.info1);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)skb->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);
+    rxd_msdu_start_common = ath10k_htt_rx_desc_get_msdu_start(hw, rxd);
+    flags = __le32_to_cpu(rxd_attention->flags);
+    info = __le32_to_cpu(rxd_msdu_start_common->info1);

     is_ip4 = !!(info & RX_MSDU_START_INFO1_IPV4_PROTO);
     is_ip6 = !!(info & RX_MSDU_START_INFO1_IPV6_PROTO);
@@ -1741,9 +1811,9 @@ static int ath10k_htt_rx_get_csum_state(struct
sk_buff *skb)
     return CHECKSUM_UNNECESSARY;
 }

-static void ath10k_htt_rx_h_csum_offload(struct sk_buff *msdu)
+static void ath10k_htt_rx_h_csum_offload(struct ath10k_hw_params *hw,
struct sk_buff *msdu)
 {
-    msdu->ip_summed = ath10k_htt_rx_get_csum_state(msdu);
+    msdu->ip_summed = ath10k_htt_rx_get_csum_state(hw, msdu);
 }

 static u64 ath10k_htt_rx_h_get_pn(struct ath10k *ar, struct sk_buff *skb,
@@ -1835,7 +1905,11 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
     struct sk_buff *first;
     struct sk_buff *last;
     struct sk_buff *msdu, *temp;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_attention *rxd_attention;
+    struct rx_mpdu_start *rxd_mpdu_start;
+
     struct ieee80211_hdr *hdr;
     enum htt_rx_mpdu_encrypt_type enctype;
     u8 first_hdr[64];
@@ -1853,18 +1927,21 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
         return;

     first = skb_peek(amsdu);
-    rxd = (void *)first->data - sizeof(*rxd);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)first->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);
+    rxd_mpdu_start = ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);

-    is_mgmt = !!(rxd->attention.flags &
+    is_mgmt = !!(rxd_attention->flags &
              __cpu_to_le32(RX_ATTENTION_FLAGS_MGMT_TYPE));

-    enctype = MS(__le32_to_cpu(rxd->mpdu_start.info0),
+    enctype = MS(__le32_to_cpu(rxd_mpdu_start->info0),
              RX_MPDU_START_INFO0_ENCRYPT_TYPE);

     /* First MSDU's Rx descriptor in an A-MSDU contains full 802.11
      * decapped header. It'll be used for undecapping of each MSDU.
      */
-    hdr = (void *)rxd->rx_hdr_status;
+    hdr = (void *)ath10k_htt_rx_desc_get_rx_hdr_status(hw, rxd);
     memcpy(first_hdr, hdr, RX_HTT_HDR_STATUS_LEN);

     if (rx_hdr)
@@ -1882,8 +1959,10 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,

     /* Some attention flags are valid only in the last MSDU. */
     last = skb_peek_tail(amsdu);
-    rxd = (void *)last->data - sizeof(*rxd);
-    attention = __le32_to_cpu(rxd->attention.flags);
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)last->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_attention = ath10k_htt_rx_desc_get_attention(hw, rxd);
+    attention = __le32_to_cpu(rxd_attention->flags);

     has_fcs_err = !!(attention & RX_ATTENTION_FLAGS_FCS_ERR);
     has_crypto_err = !!(attention & RX_ATTENTION_FLAGS_DECRYPT_ERR);
@@ -1971,7 +2050,7 @@ static void ath10k_htt_rx_h_mpdu(struct ath10k *ar,
             continue;
         }

-        ath10k_htt_rx_h_csum_offload(msdu);
+        ath10k_htt_rx_h_csum_offload(&ar->hw_params, msdu);

         if (frag && !fill_crypt_header &&
             enctype == HTT_RX_MPDU_ENCRYPT_TKIP_WPA)
@@ -2083,12 +2162,18 @@ static void ath10k_htt_rx_h_unchain(struct ath10k *ar,
                     unsigned long *unchain_cnt)
 {
     struct sk_buff *first;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_msdu_start_common *rxd_msdu_start_common;
+    struct rx_frag_info_common *rxd_frag_info;
     enum rx_msdu_decap_format decap;

     first = skb_peek(amsdu);
-    rxd = (void *)first->data - sizeof(*rxd);
-    decap = MS(__le32_to_cpu(rxd->msdu_start.common.info1),
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)first->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_msdu_start_common = ath10k_htt_rx_desc_get_msdu_start(hw, rxd);
+    rxd_frag_info = ath10k_htt_rx_desc_get_frag_info(hw, rxd);
+    decap = MS(__le32_to_cpu(rxd_msdu_start_common->info1),
            RX_MSDU_START_INFO1_DECAP_FORMAT);

     /* FIXME: Current unchaining logic can only handle simple case of raw
@@ -2097,7 +2182,7 @@ static void ath10k_htt_rx_h_unchain(struct ath10k *ar,
      * try re-constructing such frames - it'll be pretty much garbage.
      */
     if (decap != RX_MSDU_DECAP_RAW ||
-        skb_queue_len(amsdu) != 1 + rxd->frag_info.ring2_more_count) {
+        skb_queue_len(amsdu) != 1 + rxd_frag_info->ring2_more_count) {
         *drop_cnt += skb_queue_len(amsdu);
         __skb_queue_purge(amsdu);
         return;
@@ -2112,7 +2197,10 @@ static bool ath10k_htt_rx_validate_amsdu(struct
ath10k *ar,
     u8 *subframe_hdr;
     struct sk_buff *first;
     bool is_first, is_last;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct htt_rx_desc *rxd;
+    struct rx_msdu_end_common *rxd_msdu_end_common;
+    struct rx_mpdu_start *rxd_mpdu_start;
     struct ieee80211_hdr *hdr;
     size_t hdr_len, crypto_len;
     enum htt_rx_mpdu_encrypt_type enctype;
@@ -2120,12 +2208,15 @@ static bool
ath10k_htt_rx_validate_amsdu(struct ath10k *ar,

     first = skb_peek(amsdu);

-    rxd = (void *)first->data - sizeof(*rxd);
-    hdr = (void *)rxd->rx_hdr_status;
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)first->data -
hw->rx_desc_ops->rx_desc_size);

-    is_first = !!(rxd->msdu_end.common.info0 &
+    rxd_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+    rxd_mpdu_start = ath10k_htt_rx_desc_get_mpdu_start(hw, rxd);
+    hdr = (void *)ath10k_htt_rx_desc_get_rx_hdr_status(hw, rxd);
+
+    is_first = !!(rxd_msdu_end_common->info0 &
               __cpu_to_le32(RX_MSDU_END_INFO0_FIRST_MSDU));
-    is_last = !!(rxd->msdu_end.common.info0 &
+    is_last = !!(rxd_msdu_end_common->info0 &
              __cpu_to_le32(RX_MSDU_END_INFO0_LAST_MSDU));

     /* Return in case of non-aggregated msdu */
@@ -2136,7 +2227,7 @@ static bool ath10k_htt_rx_validate_amsdu(struct
ath10k *ar,
     if (!is_first)
         return false;

-    enctype = MS(__le32_to_cpu(rxd->mpdu_start.info0),
+    enctype = MS(__le32_to_cpu(rxd_mpdu_start->info0),
              RX_MPDU_START_INFO0_ENCRYPT_TYPE);

     hdr_len = ieee80211_hdrlen(hdr->frame_control);
@@ -3028,11 +3119,13 @@ static void ath10k_htt_rx_delba(struct ath10k
*ar, struct htt_resp *resp)
     spin_unlock_bh(&ar->data_lock);
 }

-static int ath10k_htt_rx_extract_amsdu(struct sk_buff_head *list,
+static int ath10k_htt_rx_extract_amsdu(struct ath10k_hw_params *hw,
+                       struct sk_buff_head *list,
                        struct sk_buff_head *amsdu)
 {
     struct sk_buff *msdu;
     struct htt_rx_desc *rxd;
+    struct rx_msdu_end_common *rxd_msdu_end_common;

     if (skb_queue_empty(list))
         return -ENOBUFS;
@@ -3043,15 +3136,19 @@ static int ath10k_htt_rx_extract_amsdu(struct
sk_buff_head *list,
     while ((msdu = __skb_dequeue(list))) {
         __skb_queue_tail(amsdu, msdu);

-        rxd = (void *)msdu->data - sizeof(*rxd);
-        if (rxd->msdu_end.common.info0 &
+        rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+        rxd_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+        if (rxd_msdu_end_common->info0 &
             __cpu_to_le32(RX_MSDU_END_INFO0_LAST_MSDU))
             break;
     }

     msdu = skb_peek_tail(amsdu);
-    rxd = (void *)msdu->data - sizeof(*rxd);
-    if (!(rxd->msdu_end.common.info0 &
+    rxd = HTT_RX_BUF_TO_RX_DESC(hw, (void *)msdu->data -
hw->rx_desc_ops->rx_desc_size);
+
+    rxd_msdu_end_common = ath10k_htt_rx_desc_get_msdu_end(hw, rxd);
+    if (!(rxd_msdu_end_common->info0 &
           __cpu_to_le32(RX_MSDU_END_INFO0_LAST_MSDU))) {
         skb_queue_splice_init(amsdu, list);
         return -EAGAIN;
@@ -3194,7 +3291,7 @@ static int ath10k_htt_rx_in_ord_ind(struct
ath10k *ar, struct sk_buff *skb)

     while (!skb_queue_empty(&list)) {
         __skb_queue_head_init(&amsdu);
-        ret = ath10k_htt_rx_extract_amsdu(&list, &amsdu);
+        ret = ath10k_htt_rx_extract_amsdu(&ar->hw_params, &list, &amsdu);
         switch (ret) {
         case 0:
             /* Note: The in-order indication may report interleaved
diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c
b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d6b8bdcef416..4047400ee4da 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -793,47 +793,26 @@ static int
ath10k_htt_send_frag_desc_bank_cfg_64(struct ath10k_htt *htt)
     return 0;
 }

-static void ath10k_htt_fill_rx_desc_offset_32(void *rx_ring)
+static void ath10k_htt_fill_rx_desc_offset_32(struct ath10k_hw_params
*hw, void *rx_ring)
 {
     struct htt_rx_ring_setup_ring32 *ring =
             (struct htt_rx_ring_setup_ring32 *)rx_ring;

-#define desc_offset(x) (offsetof(struct htt_rx_desc, x) / 4)
-    ring->mac80211_hdr_offset = __cpu_to_le16(desc_offset(rx_hdr_status));
-    ring->msdu_payload_offset = __cpu_to_le16(desc_offset(msdu_payload));
-    ring->ppdu_start_offset = __cpu_to_le16(desc_offset(ppdu_start));
-    ring->ppdu_end_offset = __cpu_to_le16(desc_offset(ppdu_end));
-    ring->mpdu_start_offset = __cpu_to_le16(desc_offset(mpdu_start));
-    ring->mpdu_end_offset = __cpu_to_le16(desc_offset(mpdu_end));
-    ring->msdu_start_offset = __cpu_to_le16(desc_offset(msdu_start));
-    ring->msdu_end_offset = __cpu_to_le16(desc_offset(msdu_end));
-    ring->rx_attention_offset = __cpu_to_le16(desc_offset(attention));
-    ring->frag_info_offset = __cpu_to_le16(desc_offset(frag_info));
-#undef desc_offset
+    ath10k_htt_rx_desc_get_offsets(hw, &ring->offsets);
 }

-static void ath10k_htt_fill_rx_desc_offset_64(void *rx_ring)
+static void ath10k_htt_fill_rx_desc_offset_64(struct ath10k_hw_params
*hw, void *rx_ring)
 {
     struct htt_rx_ring_setup_ring64 *ring =
             (struct htt_rx_ring_setup_ring64 *)rx_ring;

-#define desc_offset(x) (offsetof(struct htt_rx_desc, x) / 4)
-    ring->mac80211_hdr_offset = __cpu_to_le16(desc_offset(rx_hdr_status));
-    ring->msdu_payload_offset = __cpu_to_le16(desc_offset(msdu_payload));
-    ring->ppdu_start_offset = __cpu_to_le16(desc_offset(ppdu_start));
-    ring->ppdu_end_offset = __cpu_to_le16(desc_offset(ppdu_end));
-    ring->mpdu_start_offset = __cpu_to_le16(desc_offset(mpdu_start));
-    ring->mpdu_end_offset = __cpu_to_le16(desc_offset(mpdu_end));
-    ring->msdu_start_offset = __cpu_to_le16(desc_offset(msdu_start));
-    ring->msdu_end_offset = __cpu_to_le16(desc_offset(msdu_end));
-    ring->rx_attention_offset = __cpu_to_le16(desc_offset(attention));
-    ring->frag_info_offset = __cpu_to_le16(desc_offset(frag_info));
-#undef desc_offset
+    ath10k_htt_rx_desc_get_offsets(hw, &ring->offsets);
 }

 static int ath10k_htt_send_rx_ring_cfg_32(struct ath10k_htt *htt)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct sk_buff *skb;
     struct htt_cmd *cmd;
     struct htt_rx_ring_setup_ring32 *ring;
@@ -893,7 +872,7 @@ static int ath10k_htt_send_rx_ring_cfg_32(struct
ath10k_htt *htt)
     ring->flags = __cpu_to_le16(flags);
     ring->fw_idx_init_val = __cpu_to_le16(fw_idx);

-    ath10k_htt_fill_rx_desc_offset_32(ring);
+    ath10k_htt_fill_rx_desc_offset_32(hw, ring);
     ret = ath10k_htc_send(&htt->ar->htc, htt->eid, skb);
     if (ret) {
         dev_kfree_skb_any(skb);
@@ -906,6 +885,7 @@ static int ath10k_htt_send_rx_ring_cfg_32(struct
ath10k_htt *htt)
 static int ath10k_htt_send_rx_ring_cfg_64(struct ath10k_htt *htt)
 {
     struct ath10k *ar = htt->ar;
+    struct ath10k_hw_params *hw = &ar->hw_params;
     struct sk_buff *skb;
     struct htt_cmd *cmd;
     struct htt_rx_ring_setup_ring64 *ring;
@@ -962,7 +942,7 @@ static int ath10k_htt_send_rx_ring_cfg_64(struct
ath10k_htt *htt)
     ring->flags = __cpu_to_le16(flags);
     ring->fw_idx_init_val = __cpu_to_le16(fw_idx);

-    ath10k_htt_fill_rx_desc_offset_64(ring);
+    ath10k_htt_fill_rx_desc_offset_64(hw, ring);
     ret = ath10k_htc_send(&htt->ar->htc, htt->eid, skb);
     if (ret) {
         dev_kfree_skb_any(skb);
diff --git a/drivers/net/wireless/ath/ath10k/hw.c
b/drivers/net/wireless/ath/ath10k/hw.c
index 57c58af64a57..e52e41a70321 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -11,6 +11,7 @@
 #include "hif.h"
 #include "wmi-ops.h"
 #include "bmi.h"
+#include "rx_desc.h"

 const struct ath10k_hw_regs qca988x_regs = {
     .rtc_soc_base_address        = 0x00004000,
@@ -1134,21 +1135,7 @@ const struct ath10k_hw_ops qca988x_ops = {
     .is_rssi_enable = ath10k_htt_tx_rssi_enable,
 };

-static int ath10k_qca99x0_rx_desc_get_l3_pad_bytes(struct htt_rx_desc *rxd)
-{
-    return MS(__le32_to_cpu(rxd->msdu_end.qca99x0.info1),
-          RX_MSDU_END_INFO1_L3_HDR_PAD);
-}
-
-static bool ath10k_qca99x0_rx_desc_msdu_limit_error(struct htt_rx_desc *rxd)
-{
-    return !!(rxd->msdu_end.common.info0 &
-          __cpu_to_le32(RX_MSDU_END_INFO0_MSDU_LIMIT_ERR));
-}
-
 const struct ath10k_hw_ops qca99x0_ops = {
-    .rx_desc_get_l3_pad_bytes = ath10k_qca99x0_rx_desc_get_l3_pad_bytes,
-    .rx_desc_get_msdu_limit_error = ath10k_qca99x0_rx_desc_msdu_limit_error,
     .is_rssi_enable = ath10k_htt_tx_rssi_enable,
 };

diff --git a/drivers/net/wireless/ath/ath10k/hw.h
b/drivers/net/wireless/ath/ath10k/hw.h
index 6b03c7787e36..10487f17d9c0 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -510,6 +510,8 @@ struct ath10k_hw_clk_params {
     u32 outdiv;
 };

+struct htt_rx_desc_ops;
+
 struct ath10k_hw_params {
     u32 id;
     u16 dev_id;
@@ -562,6 +564,9 @@ struct ath10k_hw_params {
      */
     bool sw_decrypt_mcast_mgmt;

+    /* Rx descriptor abstraction */
+    const struct ath10k_htt_rx_desc_ops *rx_desc_ops;
+
     const struct ath10k_hw_ops *hw_ops;

     /* Number of bytes used for alignment in rx_hdr_status of rx desc. */
@@ -627,16 +632,14 @@ struct ath10k_hw_params {
     bool dynamic_sar_support;
 };

-struct htt_rx_desc;
 struct htt_resp;
 struct htt_data_tx_completion_ext;
+struct htt_rx_ring_rx_desc_offsets;

 /* Defines needed for Rx descriptor abstraction */
 struct ath10k_hw_ops {
-    int (*rx_desc_get_l3_pad_bytes)(struct htt_rx_desc *rxd);
     void (*set_coverage_class)(struct ath10k *ar, s16 value);
     int (*enable_pll_clk)(struct ath10k *ar);
-    bool (*rx_desc_get_msdu_limit_error)(struct htt_rx_desc *rxd);
     int (*tx_data_rssi_pad_bytes)(struct htt_resp *htt);
     int (*is_rssi_enable)(struct htt_resp *resp);
 };
@@ -649,24 +652,6 @@ extern const struct ath10k_hw_ops wcn3990_ops;

 extern const struct ath10k_hw_clk_params qca6174_clk[];

-static inline int
-ath10k_rx_desc_get_l3_pad_bytes(struct ath10k_hw_params *hw,
-                struct htt_rx_desc *rxd)
-{
-    if (hw->hw_ops->rx_desc_get_l3_pad_bytes)
-        return hw->hw_ops->rx_desc_get_l3_pad_bytes(rxd);
-    return 0;
-}
-
-static inline bool
-ath10k_rx_desc_msdu_limit_error(struct ath10k_hw_params *hw,
-                struct htt_rx_desc *rxd)
-{
-    if (hw->hw_ops->rx_desc_get_msdu_limit_error)
-        return hw->hw_ops->rx_desc_get_msdu_limit_error(rxd);
-    return false;
-}
-
 static inline int
 ath10k_tx_data_rssi_get_pad_bytes(struct ath10k_hw_params *hw,
                   struct htt_resp *htt)
diff --git a/drivers/net/wireless/ath/ath10k/rx_desc.h
b/drivers/net/wireless/ath/ath10k/rx_desc.h
index 705b6295e466..dfa9e0bfe38c 100644
--- a/drivers/net/wireless/ath/ath10k/rx_desc.h
+++ b/drivers/net/wireless/ath/ath10k/rx_desc.h
@@ -196,17 +196,31 @@ struct rx_attention {
  *        descriptor.
  */

-struct rx_frag_info {
+struct rx_frag_info_common {
     u8 ring0_more_count;
     u8 ring1_more_count;
     u8 ring2_more_count;
     u8 ring3_more_count;
+} __packed;
+
+struct rx_frag_info_wcn3990 {
     u8 ring4_more_count;
     u8 ring5_more_count;
     u8 ring6_more_count;
     u8 ring7_more_count;
 } __packed;

+struct rx_frag_info {
+    struct rx_frag_info_common common;
+    union {
+        struct rx_frag_info_wcn3990 wcn3990;
+    } __packed;
+} __packed;
+
+struct rx_frag_info_old_qca {
+    struct rx_frag_info_common common;
+} __packed;
+
 /*
  * ring0_more_count
  *        Indicates the number of more buffers associated with RX DMA
@@ -474,11 +488,17 @@ struct rx_msdu_start_wcn3990 {
 struct rx_msdu_start {
     struct rx_msdu_start_common common;
     union {
-        struct rx_msdu_start_qca99x0 qca99x0;
         struct rx_msdu_start_wcn3990 wcn3990;
     } __packed;
 } __packed;

+struct rx_msdu_start_old_qca {
+    struct rx_msdu_start_common common;
+    union {
+        struct rx_msdu_start_qca99x0 qca99x0;
+    } __packed;
+} __packed;
+
 /*
  * msdu_length
  *        MSDU length in bytes after decapsulation.  This field is
@@ -612,11 +632,17 @@ struct rx_msdu_end_wcn3990 {
 struct rx_msdu_end {
     struct rx_msdu_end_common common;
     union {
-        struct rx_msdu_end_qca99x0 qca99x0;
         struct rx_msdu_end_wcn3990 wcn3990;
     } __packed;
 } __packed;

+struct rx_msdu_end_old_qca {
+    struct rx_msdu_end_common common;
+    union {
+        struct rx_msdu_end_qca99x0 qca99x0;
+    } __packed;
+} __packed;
+
 /*
  *ip_hdr_chksum
  *        This can include the IP header checksum or the pseudo header
@@ -1134,13 +1160,19 @@ struct rx_ppdu_end_wcn3990 {
 } __packed;

 struct rx_ppdu_end {
+    struct rx_ppdu_end_common common;
+    union {
+        struct rx_ppdu_end_wcn3990 wcn3990;
+    } __packed;
+} __packed;
+
+struct rx_ppdu_end_old_qca {
     struct rx_ppdu_end_common common;
     union {
         struct rx_ppdu_end_qca988x qca988x;
         struct rx_ppdu_end_qca6174 qca6174;
         struct rx_ppdu_end_qca99x0 qca99x0;
         struct rx_ppdu_end_qca9984 qca9984;
-        struct rx_ppdu_end_wcn3990 wcn3990;
     } __packed;
 } __packed;

-- 
2.33.1
