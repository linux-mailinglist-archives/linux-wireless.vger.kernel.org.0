Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1151BF8EDA
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 12:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKLLqA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 06:46:00 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:41002 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfKLLp7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 06:45:59 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E839A60CED; Tue, 12 Nov 2019 11:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573559157;
        bh=xHKWBUeD11s5CGSdw3r3CUfyAYtULf4mhp2zjjJMzRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b53GzNfqfq8sG4Dfen+ZWRExkg6lHtnX6c9otYIG7YWwYdVv/2AIx/dCgECoNWW7d
         HPxFtfYEPao826etrQ68m83xshCm1yeyn1AhA3qH0A8pBMppZzmn+/cXRDeXdagfB6
         4wd44y2h4xgNTF9oFKho/cfwZTFwgvRmsXD0q2is=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from rex-laptop.wy-b52.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yyuwang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D04160D46;
        Tue, 12 Nov 2019 11:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573559157;
        bh=xHKWBUeD11s5CGSdw3r3CUfyAYtULf4mhp2zjjJMzRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b53GzNfqfq8sG4Dfen+ZWRExkg6lHtnX6c9otYIG7YWwYdVv/2AIx/dCgECoNWW7d
         HPxFtfYEPao826etrQ68m83xshCm1yeyn1AhA3qH0A8pBMppZzmn+/cXRDeXdagfB6
         4wd44y2h4xgNTF9oFKho/cfwZTFwgvRmsXD0q2is=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D04160D46
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=yyuwang@codeaurora.org
From:   Yu Wang <yyuwang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] ath10k: correct legacy rate in tx stats
Date:   Tue, 12 Nov 2019 19:45:48 +0800
Message-Id: <1573559148-4844-3-git-send-email-yyuwang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573559148-4844-1-git-send-email-yyuwang@codeaurora.org>
References: <1573559148-4844-1-git-send-email-yyuwang@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When working in station mode, after connected to a legacy
AP, 11g only, for example, the tx bitrate is incorrect in
output of command 'iw wlan0 link'.

That's because the legacy tx bitrate value reported by
firmware is not well handled:
For QCA6174, the value represents rate index, but treated
as a real rate;
For QCA9888, the value is real rate, with unit 'Mbps', but
treated as '100kbps'.

To fix this issue:
1. Translate the rate index to real rate for QCA6174;
2. Translate the rate from 'Mbps' to 'kbps' for QCA9888.

Tested with:
QCA6174 PCIe with firmware WLAN.RM.4.4.1.c3-00031.
QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
QCA9888 PCIe with firmware 10.4-3.9.0.2-00040.

Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c  | 48 ++++++++++++-------------------
 drivers/net/wireless/ath/ath10k/mac.c     | 13 ---------
 drivers/net/wireless/ath/ath10k/mac.h     | 11 +++++++
 drivers/net/wireless/ath/ath10k/wmi-ops.h | 15 +++++++++-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 38 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi.c     | 46 +++++++++++++++++++++++++++++
 6 files changed, 128 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index cde2d9b..e0b6aff 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -12,6 +12,7 @@
 #include "debug.h"
 #include "trace.h"
 #include "mac.h"
+#include "wmi-ops.h"
 
 #include <linux/log2.h>
 #include <linux/bitfield.h>
@@ -3310,21 +3311,6 @@ void ath10k_htt_htc_t2h_msg_handler(struct ath10k *ar, struct sk_buff *skb)
 		dev_kfree_skb_any(skb);
 }
 
-static inline s8 ath10k_get_legacy_rate_idx(struct ath10k *ar, u8 rate)
-{
-	static const u8 legacy_rates[] = {1, 2, 5, 11, 6, 9, 12,
-					  18, 24, 36, 48, 54};
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(legacy_rates); i++) {
-		if (rate == legacy_rates[i])
-			return i;
-	}
-
-	ath10k_warn(ar, "Invalid legacy rate %hhd peer stats", rate);
-	return -EINVAL;
-}
-
 static void
 ath10k_accumulate_per_peer_tx_stats(struct ath10k *ar,
 				    struct ath10k_sta *arsta,
@@ -3454,10 +3440,12 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 {
 	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
 	struct ieee80211_chanctx_conf *conf = NULL;
-	u8 rate = 0, sgi;
-	s8 rate_idx = 0;
+	u8 sgi;
+	s8 rate_idx = -1;
 	bool skip_auto_rate;
 	struct rate_info txrate;
+	enum nl80211_band band;
+	struct ieee80211_supported_band *sband;
 
 	lockdep_assert_held(&ar->data_lock);
 
@@ -3475,7 +3463,7 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 		return;
 
 	if (txrate.flags == WMI_RATE_PREAMBLE_VHT && txrate.mcs > 9) {
-		ath10k_warn(ar, "Invalid VHT mcs %hhd peer stats",  txrate.mcs);
+		ath10k_warn(ar, "Invalid VHT mcs %hhd peer stats", txrate.mcs);
 		return;
 	}
 
@@ -3490,14 +3478,19 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 	memset(&arsta->tx_info.status, 0, sizeof(arsta->tx_info.status));
 	if (txrate.flags == WMI_RATE_PREAMBLE_CCK ||
 	    txrate.flags == WMI_RATE_PREAMBLE_OFDM) {
-		rate = ATH10K_HW_LEGACY_RATE(peer_stats->ratecode);
-		/* This is hacky, FW sends CCK rate 5.5Mbps as 6 */
-		if (rate == 6 && txrate.flags == WMI_RATE_PREAMBLE_CCK)
-			rate = 5;
-		rate_idx = ath10k_get_legacy_rate_idx(ar, rate);
-		if (rate_idx < 0)
+		if (!arsta->arvif || !arsta->arvif->vif)
+			return;
+
+		conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
+		if (!conf)
+			return;
+
+		band = conf->def.chan->band;
+		sband = &ar->mac.sbands[band];
+		if (ath10k_wmi_get_legacy_rate(ar, sband, peer_stats->ratecode,
+					       &arsta->txrate.legacy,
+					       &rate_idx))
 			return;
-		arsta->txrate.legacy = rate;
 	} else if (txrate.flags == WMI_RATE_PREAMBLE_HT) {
 		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
 		arsta->txrate.mcs = txrate.mcs + 8 * (txrate.nss - 1);
@@ -3508,10 +3501,7 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
 
 	switch (txrate.flags) {
 	case WMI_RATE_PREAMBLE_OFDM:
-		if (arsta->arvif && arsta->arvif->vif)
-			conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
-		if (conf && conf->def.chan->band == NL80211_BAND_5GHZ)
-			arsta->tx_info.status.rates[0].idx = rate_idx - 4;
+		arsta->tx_info.status.rates[0].idx = rate_idx;
 		break;
 	case WMI_RATE_PREAMBLE_CCK:
 		arsta->tx_info.status.rates[0].idx = rate_idx;
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 5e3450c..555f850 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -94,19 +94,6 @@ static struct ieee80211_rate ath10k_rates_rev2[] = {
 
 #define ath10k_wmi_legacy_rates ath10k_rates
 
-static bool ath10k_mac_bitrate_is_cck(int bitrate)
-{
-	switch (bitrate) {
-	case 10:
-	case 20:
-	case 55:
-	case 110:
-		return true;
-	}
-
-	return false;
-}
-
 static u8 ath10k_mac_bitrate_to_rate(int bitrate)
 {
 	return DIV_ROUND_UP(bitrate, 5) |
diff --git a/drivers/net/wireless/ath/ath10k/mac.h b/drivers/net/wireless/ath/ath10k/mac.h
index 98d83a2..ce700ed 100644
--- a/drivers/net/wireless/ath/ath10k/mac.h
+++ b/drivers/net/wireless/ath/ath10k/mac.h
@@ -92,4 +92,15 @@ static inline void ath10k_tx_h_seq_no(struct ieee80211_vif *vif,
 	}
 }
 
+static inline bool ath10k_mac_bitrate_is_cck(int bitrate)
+{
+	switch (bitrate) {
+	case 10:
+	case 20:
+	case 55:
+	case 110:
+		return true;
+	}
+	return false;
+}
 #endif /* _MAC_H_ */
diff --git a/drivers/net/wireless/ath/ath10k/wmi-ops.h b/drivers/net/wireless/ath/ath10k/wmi-ops.h
index 1491c25..aa20e1c 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-ops.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-ops.h
@@ -216,7 +216,9 @@ struct wmi_ops {
 	struct sk_buff *(*gen_bb_timing)
 			(struct ath10k *ar,
 			 const struct wmi_bb_timing_cfg_arg *arg);
-
+	int (*get_legacy_rate)(struct ath10k *ar,
+			       struct ieee80211_supported_band *sband,
+			       u8 ratecode, u16 *rate, s8 *idx);
 };
 
 int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id);
@@ -1616,4 +1618,15 @@ ath10k_wmi_pdev_bb_timing(struct ath10k *ar,
 	return ath10k_wmi_cmd_send(ar, skb,
 				   ar->wmi.cmd->set_bb_timing_cmdid);
 }
+
+static inline int
+ath10k_wmi_get_legacy_rate(struct ath10k *ar,
+			   struct ieee80211_supported_band *sband,
+			   u8 ratecode, u16 *rate, s8 *idx)
+{
+	if (!ar->wmi.ops->get_legacy_rate)
+		return -EOPNOTSUPP;
+
+	return ar->wmi.ops->get_legacy_rate(ar, sband, ratecode, rate, idx);
+}
 #endif
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index ae12a58..8964fa8 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -4009,6 +4009,43 @@ ath10k_wmi_tlv_op_gen_vdev_spectral_enable(struct ath10k *ar, u32 vdev_id,
 	return skb;
 }
 
+static int
+ath10k_wmi_tlv_op_get_legacy_rate(struct ath10k *ar,
+				  struct ieee80211_supported_band *sband,
+				  u8 ratecode, u16 *rate, s8 *idx)
+{
+	u8 hw_rate = ATH10K_HW_LEGACY_RATE(ratecode);
+	u8 preamble = ATH10K_HW_PREAMBLE(ratecode);
+	int i;
+	const struct ieee80211_rate *bitrates;
+	bool cck;
+
+	if (!sband || !sband->bitrates || !rate || !idx)
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(sband->n_bitrates > S8_MAX))
+		return -EINVAL;
+
+	cck = (preamble == WMI_RATE_PREAMBLE_CCK);
+	for (i = 0; i < sband->n_bitrates; i++) {
+		bitrates = &sband->bitrates[i];
+
+		if (ath10k_mac_bitrate_is_cck(bitrates->bitrate) != cck)
+			continue;
+
+		if (bitrates->hw_value == hw_rate ||
+		    (bitrates->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
+		     bitrates->hw_value_short == hw_rate)) {
+			*rate = bitrates->bitrate;
+			*idx = i;
+			return 0;
+		}
+	}
+
+	ath10k_warn(ar, "Invalid legacy ratecode %hhd peer stats", ratecode);
+	return -EINVAL;
+}
+
 /****************/
 /* TLV mappings */
 /****************/
@@ -4445,6 +4482,7 @@ static const struct wmi_ops wmi_tlv_ops = {
 	.gen_echo = ath10k_wmi_tlv_op_gen_echo,
 	.gen_vdev_spectral_conf = ath10k_wmi_tlv_op_gen_vdev_spectral_conf,
 	.gen_vdev_spectral_enable = ath10k_wmi_tlv_op_gen_vdev_spectral_enable,
+	.get_legacy_rate = ath10k_wmi_tlv_op_get_legacy_rate,
 };
 
 static const struct wmi_peer_flags_map wmi_tlv_peer_flags_map = {
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 9f564e2..304e09f 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -9016,6 +9016,47 @@ ath10k_wmi_10_2_4_op_gen_bb_timing(struct ath10k *ar,
 	return skb;
 }
 
+static int
+ath10k_wmi_op_get_legacy_rate(struct ath10k *ar,
+			      struct ieee80211_supported_band *sband,
+			      u8 ratecode, u16 *rate, s8 *idx)
+{
+	u16 hw_rate = ATH10K_HW_LEGACY_RATE(ratecode);
+	u8 preamble = ATH10K_HW_PREAMBLE(ratecode);
+	int i;
+	const struct ieee80211_rate *bitrates;
+	bool cck;
+
+	if (!sband || !sband->bitrates || !rate || !idx)
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(sband->n_bitrates > S8_MAX))
+		return -EINVAL;
+
+	cck = (preamble == WMI_RATE_PREAMBLE_CCK);
+
+	/* From Mbps to 100kbps */
+	hw_rate *= 10;
+
+	/* This is hacky, FW sends CCK rate 5.5Mbps as 6 */
+	if (cck && hw_rate == 60)
+		hw_rate = 55;
+
+	for (i = 0; i < sband->n_bitrates; i++) {
+		bitrates = &sband->bitrates[i];
+		if (ath10k_mac_bitrate_is_cck(bitrates->bitrate) != cck)
+			continue;
+
+		if (bitrates->bitrate == hw_rate) {
+			*rate = bitrates->bitrate;
+			*idx = i;
+			return 0;
+		}
+	}
+	ath10k_warn(ar, "Invalid legacy ratecode %hhd peer stats", ratecode);
+	return -EINVAL;
+}
+
 static const struct wmi_ops wmi_ops = {
 	.rx = ath10k_wmi_op_rx,
 	.map_svc = wmi_main_svc_map,
@@ -9083,6 +9124,7 @@ static const struct wmi_ops wmi_ops = {
 	/* .gen_p2p_go_bcn_ie not implemented */
 	/* .gen_adaptive_qcs not implemented */
 	/* .gen_pdev_enable_adaptive_cca not implemented */
+	.get_legacy_rate = ath10k_wmi_op_get_legacy_rate,
 };
 
 static const struct wmi_ops wmi_10_1_ops = {
@@ -9153,6 +9195,7 @@ static const struct wmi_ops wmi_10_1_ops = {
 	/* .gen_p2p_go_bcn_ie not implemented */
 	/* .gen_adaptive_qcs not implemented */
 	/* .gen_pdev_enable_adaptive_cca not implemented */
+	.get_legacy_rate = ath10k_wmi_op_get_legacy_rate,
 };
 
 static const struct wmi_ops wmi_10_2_ops = {
@@ -9221,6 +9264,7 @@ static const struct wmi_ops wmi_10_2_ops = {
 	.fw_stats_fill = ath10k_wmi_10x_op_fw_stats_fill,
 	.get_vdev_subtype = ath10k_wmi_op_get_vdev_subtype,
 	/* .gen_pdev_enable_adaptive_cca not implemented */
+	.get_legacy_rate = ath10k_wmi_op_get_legacy_rate,
 };
 
 static const struct wmi_ops wmi_10_2_4_ops = {
@@ -9295,6 +9339,7 @@ static const struct wmi_ops wmi_10_2_4_ops = {
 	/* .gen_prb_tmpl not implemented */
 	/* .gen_p2p_go_bcn_ie not implemented */
 	/* .gen_adaptive_qcs not implemented */
+	.get_legacy_rate = ath10k_wmi_op_get_legacy_rate,
 };
 
 static const struct wmi_ops wmi_10_4_ops = {
@@ -9371,6 +9416,7 @@ static const struct wmi_ops wmi_10_4_ops = {
 	.gen_pdev_bss_chan_info_req = ath10k_wmi_10_2_op_gen_pdev_bss_chan_info,
 	.gen_echo = ath10k_wmi_op_gen_echo,
 	.gen_pdev_get_tpc_config = ath10k_wmi_10_2_4_op_gen_pdev_get_tpc_config,
+	.get_legacy_rate = ath10k_wmi_op_get_legacy_rate,
 };
 
 int ath10k_wmi_attach(struct ath10k *ar)
-- 
2.7.4

