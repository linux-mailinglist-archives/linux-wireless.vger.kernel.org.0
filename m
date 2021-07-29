Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B559A3DAECB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jul 2021 00:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhG2W01 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 18:26:27 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19931 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhG2W00 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 18:26:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627597582; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=HkCvaMrGnSzCF4urr4g5xdMktrSk3shrrWsCei9ytdA=; b=URm8DOd+u+rklWeNHA9qCfonk3U42xz5VqVzOQ133TUq43akwnQe9XGT5ctG5LAXOLpBsxOB
 52VGeNcbJGhTIClU0/VmlW505UE3Au9RJyn8aYZsBRhC/Wh6fYRYaosjvfa+02JNVM+qTHZP
 lVHidYIvtFC3r3Vpbv9tRdguK9M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61032afee31d882d18794a94 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 22:26:06
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10046C43217; Thu, 29 Jul 2021 22:26:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AEBA1C433F1;
        Thu, 29 Jul 2021 22:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEBA1C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH] ath11k: Add HE UL MU fixed rate setting
Date:   Thu, 29 Jul 2021 15:25:58 -0700
Message-Id: <1627597558-25144-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds ath11k support for setting HE UL MU fixed rate.
HE UL MU fixed rate is informed to HE STA by HE Basic Trigger frame.
The added code is reusing parts of the existing code path used for
HE fixed rate.

Utilizing iw command, HE UL MU fixed rate can be set:
	iw dev wlanX set bitrates he-ul-mcs-<5/2.4> <NSS:MCS>

	Example: iw dev wlan0 set bitrates he-ul-mcs-5 2:5

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-00356-QCAHKSWPL_SILICONZ-1

Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 74 ++++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/wmi.h |  1 +
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 0a65ff4e9091..8651dcff0a25 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3021,6 +3021,20 @@ ath11k_mac_bitrate_mask_num_he_rates(struct ath11k *ar,
 }
 
 static int
+ath11k_mac_bitrate_mask_num_he_ul_rates(struct ath11k *ar,
+					enum nl80211_band band,
+				       const struct cfg80211_bitrate_mask *mask)
+{
+	int num_rates = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_ul_mcs); i++)
+		num_rates += hweight16(mask->control[band].he_ul_mcs[i]);
+
+	return num_rates;
+}
+
+static int
 ath11k_mac_set_peer_vht_fixed_rate(struct ath11k_vif *arvif,
 				   struct ieee80211_sta *sta,
 				   const struct cfg80211_bitrate_mask *mask,
@@ -6029,10 +6043,11 @@ ath11k_mac_get_single_legacy_rate(struct ath11k *ar,
 
 static int ath11k_mac_set_fixed_rate_params(struct ath11k_vif *arvif,
 					    u32 rate, u8 nss, u8 sgi, u8 ldpc,
-					    u8 he_gi, u8 he_ltf)
+					    u8 he_gi, u8 he_ltf, u32 he_ul_rate,
+					    u8 he_ul_nss)
 {
 	struct ath11k *ar = arvif->ar;
-	u32 vdev_param;
+	u32 vdev_param, rate_code;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -6105,6 +6120,17 @@ static int ath11k_mac_set_fixed_rate_params(struct ath11k_vif *arvif,
 		}
 	}
 
+	rate_code = ATH11K_HW_RATE_CODE(he_ul_rate, he_ul_nss - 1,
+					WMI_RATE_PREAMBLE_HE);
+	vdev_param = WMI_VDEV_PARAM_UL_FIXED_RATE;
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id, vdev_param,
+					    rate_code);
+
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set HE UL fixed rate %d: %d\n",
+			    rate_code, ret);
+	}
+
 	return 0;
 }
 
@@ -6158,6 +6184,22 @@ ath11k_mac_he_mcs_range_present(struct ath11k *ar,
 	return true;
 }
 
+static bool
+ath11k_mac_he_ul_mcs_present(struct ath11k *ar,
+			     enum nl80211_band band,
+			     const struct cfg80211_bitrate_mask *mask)
+{
+	int i;
+
+	for (i = 0; i < NL80211_HE_NSS_MAX; i++) {
+		if (mask->control[band].he_ul_mcs[i])
+			return true;
+	}
+
+	return false;
+}
+
+
 static void ath11k_mac_set_bitrate_mask_iter(void *data,
 					     struct ieee80211_sta *sta)
 {
@@ -6203,12 +6245,12 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	const u16 *he_mcs_mask;
 	u8 he_ltf = 0;
 	u8 he_gi = 0;
-	u32 rate;
-	u8 nss;
+	u32 rate, he_ul_rate;
+	u8 nss, he_ul_nss;
 	u8 sgi;
 	u8 ldpc;
 	int single_nss;
-	int ret;
+	int ret, i;
 	int num_rates;
 
 	if (ath11k_mac_vif_chan(vif, &def))
@@ -6227,6 +6269,15 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	he_gi = mask->control[band].he_gi;
 	he_ltf = mask->control[band].he_ltf;
 
+	for (i = 0; i < ARRAY_SIZE(mask->control[band].he_ul_mcs); i++) {
+		if (hweight16(mask->control[band].he_ul_mcs[i]) == 1) {
+			he_ul_nss = i + 1;
+			he_ul_rate = ffs((int)
+					 mask->control[band].he_ul_mcs[i]) - 1;
+			break;
+		}
+	}
+
 	/* mac80211 doesn't support sending a fixed HT/VHT MCS alone, rather it
 	 * requires passing atleast one of used basic rates along with them.
 	 * Fixed rate setting across different preambles(legacy, HT, VHT) is
@@ -6300,6 +6351,16 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 			return -EINVAL;
 		}
 
+		num_rates = ath11k_mac_bitrate_mask_num_he_ul_rates(ar, band,
+								    mask);
+
+		if (ath11k_mac_he_ul_mcs_present(ar, band, mask) &&
+		    num_rates != 1) {
+			ath11k_warn(ar->ab,
+				    "Setting HE UL MCS Fixed Rate range is not supported in fw.\n");
+			return -EINVAL;
+		}
+
 		ieee80211_iterate_stations_atomic(ar->hw,
 						  ath11k_mac_disable_peer_fixed_rate,
 						  arvif);
@@ -6317,7 +6378,8 @@ ath11k_mac_op_set_bitrate_mask(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 
 	ret = ath11k_mac_set_fixed_rate_params(arvif, rate, nss, sgi, ldpc,
-					       he_gi, he_ltf);
+					       he_gi, he_ltf, he_ul_rate,
+					       he_ul_nss);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set fixed rate params on vdev %i: %d\n",
 			    arvif->vdev_id, ret);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 5ff52f5649da..98e7ef7e6459 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1047,6 +1047,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_HE_LTF = 0x74,
 	WMI_VDEV_PARAM_BA_MODE = 0x7e,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
+	WMI_VDEV_PARAM_UL_FIXED_RATE,
 	WMI_VDEV_PARAM_6GHZ_PARAMS = 0x99,
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
 	WMI_VDEV_PARAM_BSS_COLOR,
-- 
2.7.4

