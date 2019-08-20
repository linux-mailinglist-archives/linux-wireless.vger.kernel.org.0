Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C67C296561
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2019 17:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbfHTPuW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Aug 2019 11:50:22 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46190 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbfHTPuW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Aug 2019 11:50:22 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6381661C1C; Tue, 20 Aug 2019 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316221;
        bh=ANipCbH8iQoNnfoKxAnbK0TsDc0DPmikl0+2zkKr9wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9NFWPyXvw4tKQUxwMde5Ev7FXzGt1ncdA2v9BwVnhEuVtSoKQ3IFXq+ngbSUzm/w
         PpPOQy3+MVN7Mk3sm+ZXa1wkS8MGK/lhN57BZ6+tDQ+x7r7QrHoA5kgth7V9DDRgpQ
         bZpPDmzT1U7aTMCo1tNBRMAdeBSJ9uul51opDyeI=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32A6E61BCC;
        Tue, 20 Aug 2019 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566316190;
        bh=ANipCbH8iQoNnfoKxAnbK0TsDc0DPmikl0+2zkKr9wQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3ymWuT+8oQS/JVRKcHHByZEfdYR2e6+jSR/WZsM+D1z6BWA8+S/vtwd27wGQUb+r
         GyAJh3YExcmPT187XRs/7cGhtWxiy+tpVWK4LNlCbf3dekPZC/eBUxcLYZ+wS/euSK
         ZzY5QvrKtNBs9s+HRjdjCr15Lv3+aQcwzd1Eh8E8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32A6E61BCC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 32/49] ath11k: add mac.h
Date:   Tue, 20 Aug 2019 18:47:58 +0300
Message-Id: <1566316095-27507-33-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
References: <1566316095-27507-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

---
 drivers/net/wireless/ath/ath11k/mac.h | 145 ++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
new file mode 100644
index 000000000000..29b42b145fc3
--- /dev/null
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef ATH11K_MAC_H
+#define ATH11K_MAC_H
+
+#include <net/mac80211.h>
+#include <net/cfg80211.h>
+
+struct ath11k;
+struct ath11k_base;
+
+struct ath11k_generic_iter {
+	struct ath11k *ar;
+	int ret;
+};
+
+/* number of failed packets (20 packets with 16 sw reties each) */
+#define ATH11K_KICKOUT_THRESHOLD		(20 * 16)
+
+/* Use insanely high numbers to make sure that the firmware implementation
+ * won't start, we have the same functionality already in hostapd. Unit
+ * is seconds.
+ */
+#define ATH11K_KEEPALIVE_MIN_IDLE		3747
+#define ATH11K_KEEPALIVE_MAX_IDLE		3895
+#define ATH11K_KEEPALIVE_MAX_UNRESPONSIVE	3900
+
+#define WMI_HOST_RC_DS_FLAG			0x01
+#define WMI_HOST_RC_CW40_FLAG			0x02
+#define WMI_HOST_RC_SGI_FLAG			0x04
+#define WMI_HOST_RC_HT_FLAG			0x08
+#define WMI_HOST_RC_RTSCTS_FLAG			0x10
+#define WMI_HOST_RC_TX_STBC_FLAG		0x20
+#define WMI_HOST_RC_RX_STBC_FLAG		0xC0
+#define WMI_HOST_RC_RX_STBC_FLAG_S		6
+#define WMI_HOST_RC_WEP_TKIP_FLAG		0x100
+#define WMI_HOST_RC_TS_FLAG			0x200
+#define WMI_HOST_RC_UAPSD_FLAG			0x400
+
+#define WMI_HT_CAP_ENABLED			0x0001
+#define WMI_HT_CAP_HT20_SGI			0x0002
+#define WMI_HT_CAP_DYNAMIC_SMPS			0x0004
+#define WMI_HT_CAP_TX_STBC			0x0008
+#define WMI_HT_CAP_TX_STBC_MASK_SHIFT		3
+#define WMI_HT_CAP_RX_STBC			0x0030
+#define WMI_HT_CAP_RX_STBC_MASK_SHIFT		4
+#define WMI_HT_CAP_LDPC				0x0040
+#define WMI_HT_CAP_L_SIG_TXOP_PROT		0x0080
+#define WMI_HT_CAP_MPDU_DENSITY			0x0700
+#define WMI_HT_CAP_MPDU_DENSITY_MASK_SHIFT	8
+#define WMI_HT_CAP_HT40_SGI			0x0800
+#define WMI_HT_CAP_RX_LDPC			0x1000
+#define WMI_HT_CAP_TX_LDPC			0x2000
+#define WMI_HT_CAP_IBF_BFER			0x4000
+
+/* These macros should be used when we wish to advertise STBC support for
+ * only 1SS or 2SS or 3SS.
+ */
+#define WMI_HT_CAP_RX_STBC_1SS			0x0010
+#define WMI_HT_CAP_RX_STBC_2SS			0x0020
+#define WMI_HT_CAP_RX_STBC_3SS			0x0030
+
+#define WMI_HT_CAP_DEFAULT_ALL (WMI_HT_CAP_ENABLED    | \
+				WMI_HT_CAP_HT20_SGI   | \
+				WMI_HT_CAP_HT40_SGI   | \
+				WMI_HT_CAP_TX_STBC    | \
+				WMI_HT_CAP_RX_STBC    | \
+				WMI_HT_CAP_LDPC)
+
+#define WMI_VHT_CAP_MAX_MPDU_LEN_MASK		0x00000003
+#define WMI_VHT_CAP_RX_LDPC			0x00000010
+#define WMI_VHT_CAP_SGI_80MHZ			0x00000020
+#define WMI_VHT_CAP_SGI_160MHZ			0x00000040
+#define WMI_VHT_CAP_TX_STBC			0x00000080
+#define WMI_VHT_CAP_RX_STBC_MASK		0x00000300
+#define WMI_VHT_CAP_RX_STBC_MASK_SHIFT		8
+#define WMI_VHT_CAP_SU_BFER			0x00000800
+#define WMI_VHT_CAP_SU_BFEE			0x00001000
+#define WMI_VHT_CAP_MAX_CS_ANT_MASK		0x0000E000
+#define WMI_VHT_CAP_MAX_CS_ANT_MASK_SHIFT	13
+#define WMI_VHT_CAP_MAX_SND_DIM_MASK		0x00070000
+#define WMI_VHT_CAP_MAX_SND_DIM_MASK_SHIFT	16
+#define WMI_VHT_CAP_MU_BFER			0x00080000
+#define WMI_VHT_CAP_MU_BFEE			0x00100000
+#define WMI_VHT_CAP_MAX_AMPDU_LEN_EXP		0x03800000
+#define WMI_VHT_CAP_MAX_AMPDU_LEN_EXP_SHIT	23
+#define WMI_VHT_CAP_RX_FIXED_ANT		0x10000000
+#define WMI_VHT_CAP_TX_FIXED_ANT		0x20000000
+
+#define WMI_VHT_CAP_MAX_MPDU_LEN_11454		0x00000002
+
+/* These macros should be used when we wish to advertise STBC support for
+ * only 1SS or 2SS or 3SS.
+ */
+#define WMI_VHT_CAP_RX_STBC_1SS			0x00000100
+#define WMI_VHT_CAP_RX_STBC_2SS			0x00000200
+#define WMI_VHT_CAP_RX_STBC_3SS			0x00000300
+
+#define WMI_VHT_CAP_DEFAULT_ALL (WMI_VHT_CAP_MAX_MPDU_LEN_11454  | \
+				 WMI_VHT_CAP_SGI_80MHZ      |       \
+				 WMI_VHT_CAP_TX_STBC        |       \
+				 WMI_VHT_CAP_RX_STBC_MASK   |       \
+				 WMI_VHT_CAP_RX_LDPC        |       \
+				 WMI_VHT_CAP_MAX_AMPDU_LEN_EXP   |  \
+				 WMI_VHT_CAP_RX_FIXED_ANT   |       \
+				 WMI_VHT_CAP_TX_FIXED_ANT)
+
+/* FIXME: should these be in ieee80211.h? */
+#define IEEE80211_VHT_MCS_SUPPORT_0_11_MASK	GENMASK(23, 16)
+#define IEEE80211_DISABLE_VHT_MCS_SUPPORT_0_11	BIT(24)
+
+#define WMI_MAX_SPATIAL_STREAM			3
+
+#define ATH11K_CHAN_WIDTH_NUM			8
+
+extern const struct htt_rx_ring_tlv_filter ath11k_mac_mon_status_filter_default;
+
+int ath11k_mac_create(struct ath11k_base *ab);
+void ath11k_mac_destroy(struct ath11k_base *ab);
+void ath11k_mac_unregister(struct ath11k_base *ab);
+int ath11k_mac_hw_ratecode_to_legacy_rate(u8 hw_rc, u8 preamble, u8 *rateidx,
+					  u16 *rate);
+u8 ath11k_mac_bitrate_to_idx(const struct ieee80211_supported_band *sband,
+			     u32 bitrate);
+u8 ath11k_mac_hw_rate_to_idx(const struct ieee80211_supported_band *sband,
+			     u8 hw_rate, bool cck);
+
+void __ath11k_mac_scan_finish(struct ath11k *ar);
+void ath11k_mac_scan_finish(struct ath11k *ar);
+
+struct ath11k_vif *ath11k_mac_get_arvif(struct ath11k *ar, u32 vdev_id);
+struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
+						   u32 vdev_id);
+struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
+struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
+struct ath11k *ath11k_mac_get_ar_vdev_stop_status(struct ath11k_base *ab,
+						  u32 vdev_id);
+
+void ath11k_mac_drain_tx(struct ath11k *ar);
+void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
+int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
+#endif

