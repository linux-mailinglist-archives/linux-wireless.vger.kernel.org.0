Return-Path: <linux-wireless+bounces-22661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BD0AAC1CD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 12:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390694C763F
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 10:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4092279790;
	Tue,  6 May 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GzMG4gBu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3627877A
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529011; cv=none; b=KPr/GpkNJpEwehAEOFaG81B4RfZRAVe23YNxhk+mhWBA172YZ1VTuCIw8stMCr0e+qlv8jt7Uxi1VrcvmDCgmMw8UJNjoadIg1pDvb2QuzOO0FXqa/v6A8V0k/1D6G4BGTdx0gdF6KXlZg+nZEkN95OJJVFbO2YnMgSHpKEZIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529011; c=relaxed/simple;
	bh=x/vSdlf9AL6LuKJbKMZ81RuPM07JDkwkAv9HzlqIbsI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i19AMv/9DC4RVJAj2Yn10mBD/o2K+vwbYYEvgK7pVghTMh33BgKSkUQBxOAi9maIVaM7vdDgyCk/V1EJWzHbqwwvHm1hGfQ5xAKaLURYnrXStMi5G4EJ8l+eoCPqurMSm8iydwELUIuo32XKTnYTl/2SxAqStm7OB+W1IOkf640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GzMG4gBu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5467cJ1v007897
	for <linux-wireless@vger.kernel.org>; Tue, 6 May 2025 10:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=tb0uI8Vc+4eJj1Krp/L02KCDgshNgaLZ6KR
	sPsvSHmk=; b=GzMG4gBuLt1tto5Ity7pe6wy0wBDd5IdtbbiFoUfuCtNpZfMWWL
	Gun34B+MEAswT99V9kGVEvcZZnz+H9ZcFDq8leHnrqc2WWsI3Lw0G3TQG/YfVZDJ
	xCoQm9NjCXgZEqBSCIz8wZpPRqTSRm3zWA7zOIRZV4Rt1NIT0z3ROlV+B2m4ZTHU
	BlFs3fq90X2nsJI+qCeJbwt2XNPq5tStCRt+MCGeFY/pjgea7tPl6AZG5a+dD8Jp
	TZISUgw+rGglvlIXlbk2oLwF8j6JY+Tvj3kAqucSZc3f2qkDT5Fi1m9GE2lw2aaL
	LIYg+7Jey5i9fBfKUJ7VqYOSR7uVJ65PpFQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46d9ep7fqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 10:56:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso6435105b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 03:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746529007; x=1747133807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tb0uI8Vc+4eJj1Krp/L02KCDgshNgaLZ6KRsPsvSHmk=;
        b=kbhCJipmD6ZR0mvj5/DDMnUeaLyki/L3CxLgrolU+l7P2x6+tyj/YaczNKZqMoKzE+
         zL+XnybUUfkNr3TwNuE3ubf1KrvJEep78rwI4v8EM2QNTcjj9WfuUsikeuku1Tb6/Quk
         g06INN9KNabP8tgZIqHk6KtvcvxzqjFiyBZjOBTQy5jt/RtLEVRgNv6b5Ik6wHV82YZL
         mJl/4jmiMIiG9v42+1lpI5k7wLhJDQZX0obLxg7xw1oHjbnWt+qkyQGGXLxRk0n6e1aD
         4Pg79bTqtqpuDhlxc1YcdIdkesAiA9CcGYseFW0s6g2TfKlQCqWuUdb2swmfS7WuEeTc
         8I/A==
X-Gm-Message-State: AOJu0YzK84VU+zpXASAhfzbbkL8vI8fym+I/KErEr3GePdSe7OsT363+
	ZNQ6pUL4h3DmD3XDefyT7RgciA3sNK23/lJKWYV5u3DA7U9uwr7d2Wey9YvfGXw2qynjuEG0VyI
	+mexGJUZWUQ9BHyWodOtKKQQVlXnZwWkxS3vzNwK5VotkcbpwID8Ko5FyBRmbCW75qg==
X-Gm-Gg: ASbGncufo7h8DOzcZl0C0VMWsn2UearexgzXNmbXzLQT5sDdlny/CaWnITUurBDZav1
	dzp6Rk+qv09MjVIoshANsupUAJ94dMxoi49bnKesh/c889cSO8iETSJnfgXDAkFU7D+A/TiAmbj
	M/JQpupnDkOZuOXyhiUMo8gIlHCwddXj5Xs+7fkbbCFt/0lt5B+DT6X0iDq4Ptsx4FtRGE2bw1/
	26eNm4+FklP09a8c3KOmk2TrTHZeYs5N30AZ2GjJj5U++e2jjQJyQG8V1GwvSnpXCPM9iq78kwn
	gDs8d2X1+QWD/E9U8ykvyXzjDyfJZsBKUqNrJYWnEPRuvjyvEbyoiSGSKf1ptmk/G+FjIzJqy9I
	bTlyvlfJJq0+IaT+eb9yl1ru3pKpWTChukVEEEtgR
X-Received: by 2002:a05:6a00:ac0b:b0:740:67ce:1d8b with SMTP id d2e1a72fcca58-74091a16c05mr3248697b3a.7.1746529006871;
        Tue, 06 May 2025 03:56:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8OOSUClMJ12fdQiSy9tFQzrC7l4sCBoinRErzr6JQSPK8wSG94dFSc2usAmKR3WTko0YO7A==
X-Received: by 2002:a05:6a00:ac0b:b0:740:67ce:1d8b with SMTP id d2e1a72fcca58-74091a16c05mr3248674b3a.7.1746529006471;
        Tue, 06 May 2025 03:56:46 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059064cf2sm8805124b3a.142.2025.05.06.03.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 03:56:45 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: combine channel list for split-phy devices in single-wiphy
Date: Tue,  6 May 2025 16:26:24 +0530
Message-Id: <20250506105624.466019-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EOUG00ZC c=1 sm=1 tr=0 ts=6819eaf0 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=KBSZuLJJbAmD61iNme8A:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: nxswWQ2asSTvucREFIMPIC3qa5NSBnrW
X-Proofpoint-GUID: nxswWQ2asSTvucREFIMPIC3qa5NSBnrW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEwNCBTYWx0ZWRfX+ZHLSZRFNEIN
 /BF0ZEOgW8A9bWFfh+rOjBg67b1vV54xV7DW/bfBhDQFRPMbzxw9haFz1XNkyQPZZl0+LY5WkQq
 Xcwd5lI8FBWHx5//y8jjdVblQ1/OgXrotLWlGQHpVm63S8vQTunaAPZ7xZxm5fy4IwjBEc6KzcP
 cMDjp54nGApAvHlexJ+vgOGxorkF2iHxSMVFV599v8vRYtyXY7hNTx9AofeeTcX9uaQ7AjDxeVe
 OcoX0QthRts0dT18uTMw6yyL+qbzn+JWaheblrf8zAJHSYlbhA1cr7eSrbQ/jbxlBCFesVEcGMD
 DYOT8EjVEEtoWAcdum2hvQ+APi4FGbsXqJlvSn2Zz1PKaZmIR4LHM+Bleqyjy0jTHg41qa0ZeI7
 Q1K9sTml7ZtrkrgQPtZ5DpcNFtGaowA2ALwrMnraxu8BCB3UTcPgqCWvYi5imCa0K5B0wkrC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060104

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

*v2:
  - Fixed frequency conversion from KHZ to MHZ in freq_to_idx()

---
 drivers/net/wireless/ath/ath12k/mac.c | 93 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/reg.c | 13 ++++
 drivers/net/wireless/ath/ath12k/wmi.c |  9 ++-
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 4dae941c9615..23cbf348e836 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4131,8 +4131,9 @@ ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 		band = NL80211_BAND_6GHZ;
 
 	for_each_ar(ah, ar, i) {
-		/* TODO 5 GHz low high split changes */
-		if (ar->mac.sbands[band].channels)
+		if (ar->mac.sbands[band].channels &&
+		    center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
+		    center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))
 			return ar;
 	}
 
@@ -10925,6 +10926,32 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
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
@@ -10935,6 +10962,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	u32 phy_id, freq_low, freq_high;
 	struct ath12k_hw *ah = ar->ah;
 	void *channels;
+	int ret;
 
 	BUILD_BUG_ON((ARRAY_SIZE(ath12k_2ghz_channels) +
 		      ARRAY_SIZE(ath12k_5ghz_channels) +
@@ -10956,7 +10984,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		band->channels = channels;
 		band->n_bitrates = ath12k_g_rates_size;
 		band->bitrates = ath12k_g_rates;
-		bands[NL80211_BAND_2GHZ] = band;
 
 		if (ab->hw_params->single_pdev_only) {
 			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2GHZ_CAP);
@@ -10973,6 +11000,22 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
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
@@ -10991,7 +11034,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			bands[NL80211_BAND_6GHZ] = band;
 
 			freq_low = max(reg_cap->low_5ghz_chan,
 				       ab->reg_freq_6ghz.start_freq);
@@ -11004,6 +11046,26 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 
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
@@ -11022,7 +11084,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			bands[NL80211_BAND_5GHZ] = band;
 
 			if (ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
@@ -11039,6 +11100,28 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
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
index 7048834e0d14..5c577188fa74 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -176,6 +176,12 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
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
@@ -204,6 +210,13 @@ int ath12k_reg_update_chan_list(struct ath12k *ar, bool wait)
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
index ea303dca38b5..dfd36491c024 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5887,9 +5887,16 @@ static int freq_to_idx(struct ath12k *ar, int freq)
 		if (!sband)
 			continue;
 
-		for (ch = 0; ch < sband->n_channels; ch++, idx++)
+		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
+			if (sband->channels[ch].center_freq <
+			    KHZ_TO_MHZ(ar->freq_range.start_freq) ||
+			    sband->channels[ch].center_freq >
+			    KHZ_TO_MHZ(ar->freq_range.end_freq))
+				continue;
+
 			if (sband->channels[ch].center_freq == freq)
 				goto exit;
+		}
 	}
 
 exit:

base-commit: 21346cd925c2567d5f56cdb1421c94815ac10221
-- 
2.34.1


