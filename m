Return-Path: <linux-wireless+bounces-21631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29063A91571
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37DBE16B31F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8F62192E9;
	Thu, 17 Apr 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ptvq3IpK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD55195FE8
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875613; cv=none; b=MUFGNIZ/N4ldbmFBAupPaOK7ssavvvHZJJ4GfMh3zieClA4CTuuSkCk545l0NzRihpPxT3aExD7lYypt86VA6t4O+F3AHCaNL8po/euafqN6krOfbFsJVoqfq1jdkKop5njqmY96DZcJBTweZtREJZRJRF/zbg0Hw7OKBc8zFcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875613; c=relaxed/simple;
	bh=z28EO+YacEii0HZIKYfOz4G8fTucs7jeNowlTd3r1ws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Va2mhvcXRCG0qOgZUbgcOZ3PZuVRu97N7WM0aw5lwkW38nU16breoYqEMQnQeha8DTh59FqI0NwhsyC89cBn8v/M7GgJ+uYcCVYZUH4jopm2/r/7T46f8Oo96Ksshc6RhLnloz6SB0Sy2Cc7FV65HqjPCCY2PE6s3zA7N09vQf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ptvq3IpK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53H5l5Pi009452
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 07:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=65XFmNl0+5TE6vrkiKattQnKjAy2pyJzTPU
	JO9VT1g0=; b=Ptvq3IpKN+ybx5Y0Qx4w+3ITEbYM0mNzRkv+Cg5I7r2wBKe1JQe
	GprrKN3HdrEBAjCLiNCrnlsnn7a8NkQ/C4dPOiZnDMyjxtxmy1tnb6M29HW7V4yI
	VqTl9L6lNx3FIDyZx2+laKIzaguxpmK5JB/cavWGCWyES2GuVVfSHVQ9vJL+rhCb
	fQwkKj0eyqAnG0lMCRRL/3ihjdjJyg97Yft2ni5gcf7VkHh7lRnP2m3huCTMB0RF
	2jG7L4kL3jLIawoxHbTRQb8bmFs8XtulqqRQwlCSj6PqAMoeDgsU52WFo+raQZ7c
	YQnOoqe0t7AWQE9EW5ZzK+uUxKMwYXCbiwQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45ygd6p596-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 07:40:10 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ff8119b436so471883a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 00:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744875609; x=1745480409;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65XFmNl0+5TE6vrkiKattQnKjAy2pyJzTPUJO9VT1g0=;
        b=ZKyRguC2DWmovWbK/gwqxBueid4+lcdGuibYsIm/ilt8HI7WG5cZsNe4MKB8Bjz0Zp
         vLT2xlrUHq7pw5b2NTAEYG652VDkCLR2ZS8L0FAmKErHEQ9+OIHRKHSTum4hgNFzOZwL
         EqeH+zG6MltKUMrS1JV1mPnt+L2xC2Y8ynutI7qzZyjKeTT5epvfvIaM5oUAlh8oxC1M
         EddNQzXOU+L42lbhnzJo8zTyxxEO64hU+uxS4yYG9CYz3PCaSrooc7ZY1v2fhA39ol8/
         lEChJB8UQtk7gW78AizPIIJB4trW3GRKwFDra7RESeXDbtfPoVfOWT3mzS9hp7GObU6a
         CLlQ==
X-Gm-Message-State: AOJu0YwD6vUy7FHi4wgu4Wab+Jv4nM15Pt9wPMhlcxv8LuEjOmu7Wivt
	JfXf5AX9qCnzS8wqjeZpkYZKkWi/udSNPGh7rUZcyHyvykvm2iL64n67C8cUyrYWbm1fmsoTCOI
	dablNoftlKgMiCx9sr09BJbC5YB4W7HwcYoTvTjjmzERya1ldvPfbtNabjmLtyHtX8A==
X-Gm-Gg: ASbGnct7S1hvliq+5pcSM65KfWHqs8MXXmgpLOIXJ7LN5t07/xAlp7AvB66NaK9sGFK
	LTTO3+HzLAm5c0MGzop9Okk09Jyu5y2T+plRgxAHmfP9fh0Sm+PzTr0RVLwFmXgJIJiSUKWbMid
	1w98I3le+/buL9aqMUufJZEJfkRJ2aqEdun0P928aHq4xFBpzlLHtp3g1BbM7chCgFxVduT7uhE
	o/2VPbWP24CkaWfTBAhncUdpD1UaUsuI1zEIOq0WZVqf7JQEQYfk5HUUme7YUWyAEhlNw635fP5
	sxuuNqMUeYjL6KeAn/V83Ew8KQj4o+5U3DR/025O74d1DyypIhuxqBohkAzzS636pu/Lvs5qw2p
	AbmAknkBj2B4csAuGeezuq4iC+LJmljtMsNmFuY5D
X-Received: by 2002:a17:90b:4c8e:b0:2ff:618c:a1e0 with SMTP id 98e67ed59e1d1-3086417278amr7578673a91.29.1744875609031;
        Thu, 17 Apr 2025 00:40:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOdf1wbfYO/yn2EL9KtN/ubvo7/KWlE9OB3TZuTll7IOrq8oNRt1/0Ac+u73HWKCZw7DxHeQ==
X-Received: by 2002:a17:90b:4c8e:b0:2ff:618c:a1e0 with SMTP id 98e67ed59e1d1-3086417278amr7578639a91.29.1744875608587;
        Thu, 17 Apr 2025 00:40:08 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613b3719sm3290142a91.33.2025.04.17.00.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 00:40:08 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: combine channel list for split-phy devices in single-wiphy
Date: Thu, 17 Apr 2025 13:09:54 +0530
Message-Id: <20250417073954.632994-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rSCTQFxhEOYshPfASITnUgIW3yUGMlFb
X-Proofpoint-GUID: rSCTQFxhEOYshPfASITnUgIW3yUGMlFb
X-Authority-Analysis: v=2.4 cv=ANaQCy7k c=1 sm=1 tr=0 ts=6800b05a cx=c_pps a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=GRGOd-fCwLhAcA7P59AA:9 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=908 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170057

When two split-phy devices that support overlapping frequency ranges within
the same band are grouped into an ath12k hardware (HW) setup, they share a
common wiphy instance. Consequently, the channel list (wiphy->bands[])
becomes unified across all associated radios (ar).

For reference, the devices are:
2.4 GHz + 5 GHz Low Band
5 GHz High Band + 6 GHz

The first radio probed within the 5 GHz range (say 5 GHz Low Band) updates
its sband reference (&ar->mac.sbands[NL80211_BAND_5GHZ]) within
wiphy->bands[]. However, when the second 5 GHz radio (5 GHz High Band) is
probed, it replaces the existing wiphy->bands[] entry with its own sub-band
reference. As a result, wiphy->bands[] always reflects the channel list
from the most recently probed radio in that band, restricting supported
channels to those within its specific range for upper-layer.

Fix this by updating the wiphy->bands[] to just enable the channels of
current radio when there exist a radio which already has set it.
This will make sure wiphy->bands[] holds reference of first radio which
got probed in 5 GHz band and subsequent radio just updates the channel list
in the same address space.

Since same sband memory space is shared between radios of a band, while
determining the allowed frequency range of radio, its frequency limits
(ar->freq_range.start_freq, end_freq) should be used.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
Depends-on: https://lore.kernel.org/linux-wireless/20250408042128.720263-1-quic_rajson@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/mac.c | 93 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/reg.c | 13 ++++
 drivers/net/wireless/ath/ath12k/wmi.c |  9 ++-
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 6e4619e5cdf1..4ded4d850025 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4117,8 +4117,9 @@ ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 		band = NL80211_BAND_6GHZ;
 
 	for_each_ar(ah, ar, i) {
-		/* TODO 5 GHz low high split changes */
-		if (ar->mac.sbands[band].channels)
+		if (ar->mac.sbands[band].channels &&
+		    center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
+		    center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))
 			return ar;
 	}
 
@@ -10907,6 +10908,32 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
 	return 0;
 }
 
+static int ath12k_mac_update_band(struct ath12k *ar,
+				  struct ieee80211_supported_band *orig_band,
+				  struct ieee80211_supported_band *new_band)
+{
+	int i;
+
+	if (!orig_band || !new_band)
+		return -EINVAL;
+
+	if (orig_band->band != new_band->band)
+		return -EINVAL;
+
+	for (i = 0; i < new_band->n_channels; i++) {
+		if (new_band->channels[i].flags & IEEE80211_CHAN_DISABLED)
+			continue;
+		/* An enabled channel in new_band should not be already enabled
+		 * in the orig_band
+		 */
+		if (WARN_ON(!(orig_band->channels[i].flags &
+			      IEEE80211_CHAN_DISABLED)))
+			return -EINVAL;
+		orig_band->channels[i].flags &= ~IEEE80211_CHAN_DISABLED;
+	}
+	return 0;
+}
+
 static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 					   u32 supported_bands,
 					   struct ieee80211_supported_band *bands[])
@@ -10917,6 +10944,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	u32 phy_id, freq_low, freq_high;
 	struct ath12k_hw *ah = ar->ah;
 	void *channels;
+	int ret;
 
 	BUILD_BUG_ON((ARRAY_SIZE(ath12k_2ghz_channels) +
 		      ARRAY_SIZE(ath12k_5ghz_channels) +
@@ -10938,7 +10966,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		band->channels = channels;
 		band->n_bitrates = ath12k_g_rates_size;
 		band->bitrates = ath12k_g_rates;
-		bands[NL80211_BAND_2GHZ] = band;
 
 		if (ab->hw_params->single_pdev_only) {
 			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2GHZ_CAP);
@@ -10955,6 +10982,22 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 					  reg_cap->high_2ghz_chan);
 
 		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
+
+		if (!bands[NL80211_BAND_2GHZ]) {
+			bands[NL80211_BAND_2GHZ] = band;
+		} else {
+			/* Split mac in same band under same wiphy */
+			ret = ath12k_mac_update_band(ar, bands[NL80211_BAND_2GHZ], band);
+			if (ret) {
+				kfree(channels);
+				band->channels = NULL;
+				return ret;
+			}
+			ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac pdev %u identified as 2 GHz split mac with start freq %d end freq %d",
+				   ar->pdev->pdev_id,
+				   KHZ_TO_MHZ(ar->freq_range.start_freq),
+				   KHZ_TO_MHZ(ar->freq_range.end_freq));
+		}
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
@@ -10973,7 +11016,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			bands[NL80211_BAND_6GHZ] = band;
 
 			freq_low = max(reg_cap->low_5ghz_chan,
 				       ab->reg_freq_6ghz.start_freq);
@@ -10986,6 +11028,26 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 
 			ath12k_mac_update_freq_range(ar, freq_low, freq_high);
 			ah->use_6ghz_regd = true;
+
+			if (!bands[NL80211_BAND_6GHZ]) {
+				bands[NL80211_BAND_6GHZ] = band;
+			} else {
+				/* Split mac in same band under same wiphy */
+				ret = ath12k_mac_update_band(ar,
+							     bands[NL80211_BAND_6GHZ],
+							     band);
+				if (ret) {
+					kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
+					ar->mac.sbands[NL80211_BAND_2GHZ].channels = NULL;
+					kfree(channels);
+					band->channels = NULL;
+					return ret;
+				}
+				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac pdev %u identified as 6 GHz split mac with start freq %d end freq %d",
+					   ar->pdev->pdev_id,
+					   KHZ_TO_MHZ(ar->freq_range.start_freq),
+					   KHZ_TO_MHZ(ar->freq_range.end_freq));
+			}
 		}
 
 		if (reg_cap->low_5ghz_chan < ATH12K_MIN_6GHZ_FREQ) {
@@ -11004,7 +11066,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			bands[NL80211_BAND_5GHZ] = band;
 
 			if (ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
@@ -11021,6 +11082,28 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 						  reg_cap->high_5ghz_chan);
 
 			ath12k_mac_update_freq_range(ar, freq_low, freq_high);
+
+			if (!bands[NL80211_BAND_5GHZ]) {
+				bands[NL80211_BAND_5GHZ] = band;
+			} else {
+				/* Split mac in same band under same wiphy */
+				ret = ath12k_mac_update_band(ar,
+							     bands[NL80211_BAND_5GHZ],
+							     band);
+				if (ret) {
+					kfree(ar->mac.sbands[NL80211_BAND_2GHZ].channels);
+					ar->mac.sbands[NL80211_BAND_2GHZ].channels = NULL;
+					kfree(ar->mac.sbands[NL80211_BAND_6GHZ].channels);
+					ar->mac.sbands[NL80211_BAND_2GHZ].channels = NULL;
+					kfree(channels);
+					band->channels = NULL;
+					return ret;
+				}
+				ath12k_dbg(ar->ab, ATH12K_DBG_MAC, "mac pdev %u identified as 5 GHz split mac with start freq %d end freq %d",
+					   ar->pdev->pdev_id,
+					   KHZ_TO_MHZ(ar->freq_range.start_freq),
+					   KHZ_TO_MHZ(ar->freq_range.end_freq));
+			}
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 9d188e1037a6..63bb47f36554 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -158,6 +158,12 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 			if (bands[band]->channels[i].flags &
 			    IEEE80211_CHAN_DISABLED)
 				continue;
+			/* Skip Channels that are not in current radio's range */
+			if (bands[band]->channels[i].center_freq <
+			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
+			    bands[band]->channels[i].center_freq >
+			    KHZ_TO_MHZ(ar->freq_range.end_freq))
+				continue;
 
 			num_channels++;
 		}
@@ -186,6 +192,13 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
 			if (channel->flags & IEEE80211_CHAN_DISABLED)
 				continue;
 
+			/* Skip Channels that are not in current radio's range */
+			if (bands[band]->channels[i].center_freq <
+			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
+			    bands[band]->channels[i].center_freq >
+			    KHZ_TO_MHZ(ar->freq_range.end_freq))
+				continue;
+
 			/* TODO: Set to true/false based on some condition? */
 			ch->allow_ht = true;
 			ch->allow_vht = true;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ea303dca38b5..5d6417ffa33f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5887,9 +5887,16 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 		if (!sband)
 			continue;
 
-		for (ch = 0; ch < sband->n_channels; ch++, idx++)
+		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
+			if (sband->channels[ch].center_freq <
+			    MHZ_TO_KHZ(ar->freq_range.start_freq) ||
+			    sband->channels[ch].center_freq >
+			    MHZ_TO_KHZ(ar->freq_range.end_freq))
+				continue;
+
 			if (sband->channels[ch].center_freq == freq)
 				goto exit;
+		}
 	}
 
 exit:

base-commit: d0bcc5eaaa611aacbffe6b2cc2fb64bfc3bdfcbc
prerequisite-patch-id: f369472e458667be205aede5c0c935958ef1ba82
prerequisite-patch-id: 917c05e38624bc1d080e1d16b662abfd907b1e3e
prerequisite-patch-id: c7f80d90d8a8f97c39b26240ca593e968cdcad76
-- 
2.34.1


