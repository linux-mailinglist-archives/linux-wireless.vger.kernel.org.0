Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92BC62D775
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 10:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfE2IN6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 04:13:58 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45044 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2IN6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 04:13:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CFE606030E; Wed, 29 May 2019 08:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559117636;
        bh=QoI/EH1Ufz4EVydGEkruQZ9oa4zP1BkjXVvzzsPlRpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nOUqKxkNTakA86fL3r2ZwDZRRxJRCm7w63gV4yyZXwTE13EzBzaklo+fpq3XPyNlV
         Xsq5IGb+Taise13F7+F/m1G/0AsgnQocNZ7glT7FHTPS5BVQY7NpcnxgPUCrlCErZS
         noJCC4DVV1FmSc6wvFD3Q2opBTo680ZBYHufLw0M=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F52860592;
        Wed, 29 May 2019 08:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559117636;
        bh=QoI/EH1Ufz4EVydGEkruQZ9oa4zP1BkjXVvzzsPlRpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=nOUqKxkNTakA86fL3r2ZwDZRRxJRCm7w63gV4yyZXwTE13EzBzaklo+fpq3XPyNlV
         Xsq5IGb+Taise13F7+F/m1G/0AsgnQocNZ7glT7FHTPS5BVQY7NpcnxgPUCrlCErZS
         noJCC4DVV1FmSc6wvFD3Q2opBTo680ZBYHufLw0M=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F52860592
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Wed, 29 May 2019 16:13:45 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH v2] ath10k: fix failure to set multiple fixed rate
Date:   Wed, 29 May 2019 16:13:28 +0800
Message-Id: <1559117608-11117-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, below fixed rate commands are broken,
iw wlanx set bitrates legacy-<2.4|5> ht-mcs-<2.4|5> vht-mcs-<2.4|5> \
<NSS:MCSx>
iw wlanx set bitrates legacy-<2.4|5> <legacy rate> ht-mcs-<2.4|5> \
vht-mcs-<2.4|5> <NSS:MCSx>

There are two methods to set fixed rate, both failed,
- Use vdev fixed rate command
  This command only support one single rate, but it's broken due to
  mac80211 change commit e8e4f5280ddd ("mac80211: reject/clear user
  rate mask if not usable"), which requires user to specify at least
  one legacy rate. So we can't use this command to set ht/vht single
  rate any more.
- Use peer_assoc command
  This command can update rx capability for multiple rates, it will
  work fine for ht mcs rates, as each supported mcs can be advertised
  in ht_mcs index mask. But this will not work with vht rates because,
  as per the vht mcs capability advertisement, there are only two bits
  to indicate the supported mcs. E.g. only support 0-7, 0-8, 0-9.

So introduced new WMI command: WMI_PEER_PARAM_FIXED_RATE. After peer
assoc, the peer fixed rate cmd will work for that specific peer.
Remaining peers will use auto rate. If both vdev fixed rate and peer
fixed rates are given, peer fixed rate will take effect to peers for
which this cmd is given. Remaining peers in that vdev, will use vdev
fixed rate.

Tested HW: QCA9984
Tested FW: 10.4-3.9.0.2-00035

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
Changes since v1
- update commit message, remove 2nd broken command
---
 drivers/net/wireless/ath/ath10k/core.c |   1 +
 drivers/net/wireless/ath/ath10k/core.h |   7 +++
 drivers/net/wireless/ath/ath10k/mac.c  | 111 +++++++++++++++++++++++++++++----
 drivers/net/wireless/ath/ath10k/wmi.h  |   1 +
 4 files changed, 108 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 61ef903..811cf38 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -612,6 +612,7 @@
 	[ATH10K_FW_FEATURE_MGMT_TX_BY_REF] = "mgmt-tx-by-reference",
 	[ATH10K_FW_FEATURE_NON_BMI] = "non-bmi",
 	[ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL] = "single-chan-info-per-channel",
+	[ATH10K_FW_FEATURE_PEER_FIXED_RATE] = "peer-fixed-rate",
 };
 
 static unsigned int ath10k_core_get_fw_feature_str(char *buf,
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 2d109c0..fe6e88d 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -579,6 +579,10 @@ struct ath10k_vif {
 	struct work_struct ap_csa_work;
 	struct delayed_work connection_loss_work;
 	struct cfg80211_bitrate_mask bitrate_mask;
+
+	/* For setting VHT peer fixed rate, protected by conf_mutex */
+	int vht_num_rates;
+	u8 vht_pfr;
 };
 
 struct ath10k_vif_iter {
@@ -770,6 +774,9 @@ enum ath10k_fw_features {
 	/* Firmware sends only one chan_info event per channel */
 	ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL = 20,
 
+	/* Firmware allows setting peer fixed rate */
+	ATH10K_FW_FEATURE_PEER_FIXED_RATE = 21,
+
 	/* keep last */
 	ATH10K_FW_FEATURE_COUNT,
 };
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b500fd4..e555a22 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7107,18 +7107,23 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 static bool
 ath10k_mac_bitrate_mask_has_single_rate(struct ath10k *ar,
 					enum nl80211_band band,
-					const struct cfg80211_bitrate_mask *mask)
+					const struct cfg80211_bitrate_mask *mask,
+					int *vht_num_rates)
 {
 	int num_rates = 0;
-	int i;
+	int i, tmp;
 
 	num_rates += hweight32(mask->control[band].legacy);
 
 	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
 		num_rates += hweight8(mask->control[band].ht_mcs[i]);
 
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++)
-		num_rates += hweight16(mask->control[band].vht_mcs[i]);
+	*vht_num_rates = 0;
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
+		tmp = hweight16(mask->control[band].vht_mcs[i]);
+		num_rates += tmp;
+		*vht_num_rates += tmp;
+	}
 
 	return num_rates == 1;
 }
@@ -7176,7 +7181,7 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 ath10k_mac_bitrate_mask_get_single_rate(struct ath10k *ar,
 					enum nl80211_band band,
 					const struct cfg80211_bitrate_mask *mask,
-					u8 *rate, u8 *nss)
+					u8 *rate, u8 *nss, bool vht_only)
 {
 	int rate_idx;
 	int i;
@@ -7184,6 +7189,9 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 	u8 preamble;
 	u8 hw_rate;
 
+	if (vht_only)
+		goto next;
+
 	if (hweight32(mask->control[band].legacy) == 1) {
 		rate_idx = ffs(mask->control[band].legacy) - 1;
 
@@ -7217,6 +7225,7 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 		}
 	}
 
+next:
 	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
 		if (hweight16(mask->control[band].vht_mcs[i]) == 1) {
 			*nss = i + 1;
@@ -7278,7 +7287,8 @@ static int ath10k_mac_set_fixed_rate_params(struct ath10k_vif *arvif,
 static bool
 ath10k_mac_can_set_bitrate_mask(struct ath10k *ar,
 				enum nl80211_band band,
-				const struct cfg80211_bitrate_mask *mask)
+				const struct cfg80211_bitrate_mask *mask,
+				bool allow_pfr)
 {
 	int i;
 	u16 vht_mcs;
@@ -7297,7 +7307,8 @@ static int ath10k_mac_set_fixed_rate_params(struct ath10k_vif *arvif,
 		case BIT(10) - 1:
 			break;
 		default:
-			ath10k_warn(ar, "refusing bitrate mask with missing 0-7 VHT MCS rates\n");
+			if (!allow_pfr)
+				ath10k_warn(ar, "refusing bitrate mask with missing 0-7 VHT MCS rates\n");
 			return false;
 		}
 	}
@@ -7305,6 +7316,26 @@ static int ath10k_mac_set_fixed_rate_params(struct ath10k_vif *arvif,
 	return true;
 }
 
+static bool ath10k_mac_set_vht_bitrate_mask_fixup(struct ath10k *ar,
+						  struct ath10k_vif *arvif,
+						  struct ieee80211_sta *sta)
+{
+	int err;
+	u8 rate = arvif->vht_pfr;
+
+	/* skip non vht and multiple rate peers */
+	if (!sta->vht_cap.vht_supported || arvif->vht_num_rates != 1)
+		return false;
+
+	err = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
+					WMI_PEER_PARAM_FIXED_RATE, rate);
+	if (err)
+		ath10k_warn(ar, "failed to eanble STA %pM peer fixed rate: %d\n",
+			    sta->addr, err);
+
+	return true;
+}
+
 static void ath10k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
@@ -7315,6 +7346,9 @@ static void ath10k_mac_set_bitrate_mask_iter(void *data,
 	if (arsta->arvif != arvif)
 		return;
 
+	if (ath10k_mac_set_vht_bitrate_mask_fixup(ar, arvif, sta))
+		return;
+
 	spin_lock_bh(&ar->data_lock);
 	arsta->changed |= IEEE80211_RC_SUPP_RATES_CHANGED;
 	spin_unlock_bh(&ar->data_lock);
@@ -7322,6 +7356,26 @@ static void ath10k_mac_set_bitrate_mask_iter(void *data,
 	ieee80211_queue_work(ar->hw, &arsta->update_wk);
 }
 
+static void ath10k_mac_clr_bitrate_mask_iter(void *data,
+					     struct ieee80211_sta *sta)
+{
+	struct ath10k_vif *arvif = data;
+	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
+	struct ath10k *ar = arvif->ar;
+	int err;
+
+	/* clear vht peers only */
+	if (arsta->arvif != arvif || !sta->vht_cap.vht_supported)
+		return;
+
+	err = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
+					WMI_PEER_PARAM_FIXED_RATE,
+					WMI_FIXED_RATE_NONE);
+	if (err)
+		ath10k_warn(ar, "failed to clear STA %pM peer fixed rate: %d\n",
+			    sta->addr, err);
+}
+
 static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 					  struct ieee80211_vif *vif,
 					  const struct cfg80211_bitrate_mask *mask)
@@ -7338,6 +7392,9 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	u8 ldpc;
 	int single_nss;
 	int ret;
+	int vht_num_rates, allow_pfr;
+	u8 vht_pfr;
+	bool update_bitrate_mask = true;
 
 	if (ath10k_mac_vif_chan(vif, &def))
 		return -EPERM;
@@ -7351,9 +7408,21 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	if (sgi == NL80211_TXRATE_FORCE_LGI)
 		return -EINVAL;
 
-	if (ath10k_mac_bitrate_mask_has_single_rate(ar, band, mask)) {
+	allow_pfr = test_bit(ATH10K_FW_FEATURE_PEER_FIXED_RATE,
+			     ar->normal_mode_fw.fw_file.fw_features);
+	if (allow_pfr) {
+		mutex_lock(&ar->conf_mutex);
+		ieee80211_iterate_stations_atomic(ar->hw,
+						  ath10k_mac_clr_bitrate_mask_iter,
+						  arvif);
+		mutex_unlock(&ar->conf_mutex);
+	}
+
+	if (ath10k_mac_bitrate_mask_has_single_rate(ar, band, mask,
+						    &vht_num_rates)) {
 		ret = ath10k_mac_bitrate_mask_get_single_rate(ar, band, mask,
-							      &rate, &nss);
+							      &rate, &nss,
+							      false);
 		if (ret) {
 			ath10k_warn(ar, "failed to get single rate for vdev %i: %d\n",
 				    arvif->vdev_id, ret);
@@ -7369,12 +7438,30 @@ static int ath10k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			  max(ath10k_mac_max_ht_nss(ht_mcs_mask),
 			      ath10k_mac_max_vht_nss(vht_mcs_mask)));
 
-		if (!ath10k_mac_can_set_bitrate_mask(ar, band, mask))
-			return -EINVAL;
+		if (!ath10k_mac_can_set_bitrate_mask(ar, band, mask,
+						     allow_pfr)) {
+			u8 vht_nss;
+
+			if (!allow_pfr || vht_num_rates != 1)
+				return -EINVAL;
+
+			/* Reach here, firmware supports peer fixed rate and has
+			 * single vht rate, and don't update vif birate_mask, as
+			 * the rate only for specific peer.
+			 */
+			ath10k_mac_bitrate_mask_get_single_rate(ar, band, mask,
+								&vht_pfr,
+								&vht_nss,
+								true);
+			update_bitrate_mask = false;
+		}
 
 		mutex_lock(&ar->conf_mutex);
 
-		arvif->bitrate_mask = *mask;
+		if (update_bitrate_mask)
+			arvif->bitrate_mask = *mask;
+		arvif->vht_num_rates = vht_num_rates;
+		arvif->vht_pfr = vht_pfr;
 		ieee80211_iterate_stations_atomic(ar->hw,
 						  ath10k_mac_set_bitrate_mask_iter,
 						  arvif);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 12f57f9..bd54da6 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6260,6 +6260,7 @@ enum wmi_peer_param {
 	WMI_PEER_CHAN_WIDTH = 0x4,
 	WMI_PEER_NSS        = 0x5,
 	WMI_PEER_USE_4ADDR  = 0x6,
+	WMI_PEER_PARAM_FIXED_RATE = 0x9,
 	WMI_PEER_DEBUG      = 0xa,
 	WMI_PEER_PHYMODE    = 0xd,
 	WMI_PEER_DUMMY_VAR  = 0xff, /* dummy parameter for STA PS workaround */
-- 
1.9.1

