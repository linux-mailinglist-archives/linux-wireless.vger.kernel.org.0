Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0F20C91A
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2020 19:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgF1RCM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 13:02:12 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:39531 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbgF1RCM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 13:02:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593363732; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2gzIWbRLApRc+c8wxA6rb5y1hvN+Rud3CsFjdwJRvmo=; b=k40w+OR8QyIxzu/m7CbjYNhOZDfkFIAgSa0C0AUte3ym4K2PffZDLf79VeUwkf2bdP6RCyYe
 afZ2a2C1vz8KqpwS4DCTK1GKL68ezcSRNvg/A6ERlyxplKs+fo2sbDc65dMh07TWjDMbRifX
 ffeGuhLmhoNkx11xAtaoNRTIcx8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ef8cd13a6e154319f780e57 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 28 Jun 2020 17:02:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0E7B1C433CA; Sun, 28 Jun 2020 17:02:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from tamizhr-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B61EC433C8;
        Sun, 28 Jun 2020 17:02:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B61EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH 2/4] ath10k: Move rate mask validation function up in the file
Date:   Sun, 28 Jun 2020 22:31:56 +0530
Message-Id: <1593363718-5148-3-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593363718-5148-1-git-send-email-tamizhr@codeaurora.org>
References: <1593363718-5148-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch does not have any functional changes.

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 174 +++++++++++++++++-----------------
 1 file changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3e38962..7023ccf 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6602,6 +6602,93 @@ static int ath10k_sta_set_txpwr(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static bool
+ath10k_mac_bitrate_mask_has_single_rate(struct ath10k *ar,
+					enum nl80211_band band,
+					const struct cfg80211_bitrate_mask *mask,
+					int *vht_num_rates)
+{
+	int num_rates = 0;
+	int i, tmp;
+
+	num_rates += hweight32(mask->control[band].legacy);
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
+		num_rates += hweight8(mask->control[band].ht_mcs[i]);
+
+	*vht_num_rates = 0;
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
+		tmp = hweight16(mask->control[band].vht_mcs[i]);
+		num_rates += tmp;
+		*vht_num_rates += tmp;
+	}
+
+	return num_rates == 1;
+}
+
+static int
+ath10k_mac_bitrate_mask_get_single_rate(struct ath10k *ar,
+					enum nl80211_band band,
+					const struct cfg80211_bitrate_mask *mask,
+					u8 *rate, u8 *nss, bool vht_only)
+{
+	int rate_idx;
+	int i;
+	u16 bitrate;
+	u8 preamble;
+	u8 hw_rate;
+
+	if (vht_only)
+		goto next;
+
+	if (hweight32(mask->control[band].legacy) == 1) {
+		rate_idx = ffs(mask->control[band].legacy) - 1;
+
+		if (ar->phy_capability & WHAL_WLAN_11A_CAPABILITY)
+			rate_idx += ATH10K_MAC_FIRST_OFDM_RATE_IDX;
+
+		hw_rate = ath10k_wmi_legacy_rates[rate_idx].hw_value;
+		bitrate = ath10k_wmi_legacy_rates[rate_idx].bitrate;
+
+		if (ath10k_mac_bitrate_is_cck(bitrate))
+			preamble = WMI_RATE_PREAMBLE_CCK;
+		else
+			preamble = WMI_RATE_PREAMBLE_OFDM;
+
+		*nss = 1;
+		*rate = preamble << 6 |
+			(*nss - 1) << 4 |
+			hw_rate << 0;
+
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++) {
+		if (hweight8(mask->control[band].ht_mcs[i]) == 1) {
+			*nss = i + 1;
+			*rate = WMI_RATE_PREAMBLE_HT << 6 |
+				(*nss - 1) << 4 |
+				(ffs(mask->control[band].ht_mcs[i]) - 1);
+
+			return 0;
+		}
+	}
+
+next:
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
+		if (hweight16(mask->control[band].vht_mcs[i]) == 1) {
+			*nss = i + 1;
+			*rate = WMI_RATE_PREAMBLE_VHT << 6 |
+				(*nss - 1) << 4 |
+				(ffs(mask->control[band].vht_mcs[i]) - 1);
+
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int ath10k_sta_state(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
@@ -7352,30 +7439,6 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 }
 
 static bool
-ath10k_mac_bitrate_mask_has_single_rate(struct ath10k *ar,
-					enum nl80211_band band,
-					const struct cfg80211_bitrate_mask *mask,
-					int *vht_num_rates)
-{
-	int num_rates = 0;
-	int i, tmp;
-
-	num_rates += hweight32(mask->control[band].legacy);
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++)
-		num_rates += hweight8(mask->control[band].ht_mcs[i]);
-
-	*vht_num_rates = 0;
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
-		tmp = hweight16(mask->control[band].vht_mcs[i]);
-		num_rates += tmp;
-		*vht_num_rates += tmp;
-	}
-
-	return num_rates == 1;
-}
-
-static bool
 ath10k_mac_bitrate_mask_get_single_nss(struct ath10k *ar,
 				       enum nl80211_band band,
 				       const struct cfg80211_bitrate_mask *mask,
@@ -7424,69 +7487,6 @@ static int ath10k_get_survey(struct ieee80211_hw *hw, int idx,
 	return true;
 }
 
-static int
-ath10k_mac_bitrate_mask_get_single_rate(struct ath10k *ar,
-					enum nl80211_band band,
-					const struct cfg80211_bitrate_mask *mask,
-					u8 *rate, u8 *nss, bool vht_only)
-{
-	int rate_idx;
-	int i;
-	u16 bitrate;
-	u8 preamble;
-	u8 hw_rate;
-
-	if (vht_only)
-		goto next;
-
-	if (hweight32(mask->control[band].legacy) == 1) {
-		rate_idx = ffs(mask->control[band].legacy) - 1;
-
-		if (ar->phy_capability & WHAL_WLAN_11A_CAPABILITY)
-			rate_idx += ATH10K_MAC_FIRST_OFDM_RATE_IDX;
-
-		hw_rate = ath10k_wmi_legacy_rates[rate_idx].hw_value;
-		bitrate = ath10k_wmi_legacy_rates[rate_idx].bitrate;
-
-		if (ath10k_mac_bitrate_is_cck(bitrate))
-			preamble = WMI_RATE_PREAMBLE_CCK;
-		else
-			preamble = WMI_RATE_PREAMBLE_OFDM;
-
-		*nss = 1;
-		*rate = preamble << 6 |
-			(*nss - 1) << 4 |
-			hw_rate << 0;
-
-		return 0;
-	}
-
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].ht_mcs); i++) {
-		if (hweight8(mask->control[band].ht_mcs[i]) == 1) {
-			*nss = i + 1;
-			*rate = WMI_RATE_PREAMBLE_HT << 6 |
-				(*nss - 1) << 4 |
-				(ffs(mask->control[band].ht_mcs[i]) - 1);
-
-			return 0;
-		}
-	}
-
-next:
-	for (i = 0; i < ARRAY_SIZE(mask->control[band].vht_mcs); i++) {
-		if (hweight16(mask->control[band].vht_mcs[i]) == 1) {
-			*nss = i + 1;
-			*rate = WMI_RATE_PREAMBLE_VHT << 6 |
-				(*nss - 1) << 4 |
-				(ffs(mask->control[band].vht_mcs[i]) - 1);
-
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 static int ath10k_mac_set_fixed_rate_params(struct ath10k_vif *arvif,
 					    u8 rate, u8 nss, u8 sgi, u8 ldpc)
 {
-- 
1.9.1

