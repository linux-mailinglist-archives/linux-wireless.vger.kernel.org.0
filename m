Return-Path: <linux-wireless+bounces-23305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E93AC0A70
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 13:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FEA5189CA31
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 11:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5885A28A1C0;
	Thu, 22 May 2025 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VW3VviFj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B1221FD0
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747912538; cv=none; b=Wjgdg57an7IzEyN1Lu5ry6kmnZ92ByoUnEdkjKK+NABHp5Wvibdx1D1njz1DPJRHoSW9N5showXJsDyMTMKQ3FO2DjHIJEUH0oMz6zop8REGKvvwc3Y4thq26rkxK26H29jdzz+qG9tryeRpIiGIcJ7gstSZs31jzMWcls4d8DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747912538; c=relaxed/simple;
	bh=InQYtKIN6R+A3rJhHvjZ7o+5l/UzFCp3xOCDKx7EwSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkirWkZGOLVrXKwTqzGOCTtx2Gm/+0vE1s5Zu77uPM3aNxueh4vFwoDokzJ42VlzXmxOYN3QvEYOU1+7IJv+U5EURm2eiE/0FRKDYDb9Nkt2QGOYnXToZEWUfWwJ4EDnVAzkERI8/5RDN6O4LHt8hk+CoS71BlwwqPp14Lqa6q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VW3VviFj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7fPw1020937
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 11:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NJCFlSiH8F8LqMmytsnGm/5ALtT/yHy3+u+
	M4Cupnx0=; b=VW3VviFj5LT2tRDiA3DOulgDljopoqkdQvv/pq2V1X9bL/4LHpb
	tD2saHjmk7KxP5pytHmKkdLTCkFWXzWDiuhFB/XeXTlYTumf9Awe5Ds71Z9dJgsf
	w/kMKURs+i5u0h/yiU0kXNUv2fyasuxaHU1vNcL9I5OKuvoFPUByuaBJkF4p5zf5
	JTTCYuSqii8TQQ7fRF3KuLx6Fq8/VSyCR/drccZUoM88BKd9umUqXF5TGzk4S7KR
	bwoTv3DQXxzqaPCjHnClkBJSI33IsEzmiRsp90zuCJY+mR/5oqX8oS2vwBs/3mWR
	iIP8cI2TV+XnIaIcFREdZ8b7WxygL4LtN0w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf068vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 11:15:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742c620e236so4407462b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 04:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747912534; x=1748517334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJCFlSiH8F8LqMmytsnGm/5ALtT/yHy3+u+M4Cupnx0=;
        b=tGEUOvoOBdawoFWVSQlFy9XQ4h7/Mhypvw8w3jVDRzzhPg2wZG4r7Yp4FKjAF7/5Di
         aWmRgJilji8ZGaH5qOrOo3KkaUxTDhjWaeYKvXTjMKcif59jMcDD5PGB+ss6y6iMzjmf
         YkB/kQFwr6gMHmtMFz3eHNNW+qsGlZ1CGi4n/Iuu1E+pPDMVvi4Hik6jTp3psmASbNnv
         etxrafC3Z0sgRJ5IqjqtNFJ0EuygKI1qC8mvkCkW4Phg4g3CMCgM8ft1zNzQ+M5JBCVN
         xal8nE3Jn3oSV7m6asAjGhQYkof5f8y2CBlMK5coujYY1viJy9DpTmnSnaWZGgeYBMtR
         bMvg==
X-Gm-Message-State: AOJu0YztLzzGcZx2qyhorrij4BjOWJdgkWtPsLRCAM1Jw1+oX+FM5aEz
	3ChO9vCIRuPnGFtncRiajPFueqNMbpgS8cTzNgx4gSCuuRJXKMJTxLWn8khOUnjzGwSGnUEy8Mn
	RGN5Afo6A6GC3ykh22Wi5zQbEkNgJTaLdky5Vg09iqo1+MzoHrdzSOcf61r1Qa2TsNRtS4A==
X-Gm-Gg: ASbGncsm1GkVRhn0+fRYLLWnayj3cXqOUKGDY2CyPIUFW2GAzKiRqd/hhl87d7EPiPd
	TgVJyPWegUslQz2idAw8xl2wvDaEk3xXvoPSqEPo6f+iN6hfm7PmsgbCSadZVyR7dvaHukLzOsL
	jY8snT4AEhqhxCm3YsK2ASmpxMsAmjX56GqSOqKEFcsDm2u9iYy5gJqGl3Ep1+bwJtd2b0A9bBG
	qMtCzGyEQd340kQqVhh645ZwjNemk/NG+ifobE02+axxqKYnCadbLzYU9bEDW5wRRqLzIcVhONT
	Saxe14DvPVENsOjdkxtwHfB4BYfdyCoywFitck2a+PoLsn33QEWiPEw3y7cysGhB5DLoLlfvulw
	K2qQgWnftqlgjJrEU8ipZK9aaT1JS8NU6MViFJQ+z
X-Received: by 2002:a05:6a00:c8d:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-742a97768f0mr35397613b3a.4.1747912534394;
        Thu, 22 May 2025 04:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVJNJ6rlBMI5U7xExXSQ3PMuR6QUheJrn3jKGXadAATGkYVQv4wC5vcPWub2ECGXreQumayg==
X-Received: by 2002:a05:6a00:c8d:b0:740:aa31:fe66 with SMTP id d2e1a72fcca58-742a97768f0mr35397573b3a.4.1747912533903;
        Thu, 22 May 2025 04:15:33 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829a4dsm11470289b3a.107.2025.05.22.04.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 04:15:33 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Subject: [PATCH ath-next v3] wifi: ath12k: combine channel list for split-phy devices in single-wiphy
Date: Thu, 22 May 2025 16:45:14 +0530
Message-Id: <20250522111514.3735107-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Pws6c24zjpxrugGgJOQ9SRqHOrcHw8VH
X-Proofpoint-ORIG-GUID: Pws6c24zjpxrugGgJOQ9SRqHOrcHw8VH
X-Authority-Analysis: v=2.4 cv=ZP3XmW7b c=1 sm=1 tr=0 ts=682f0757 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=M2JtdFxej-CA3OLZbwkA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDExMyBTYWx0ZWRfX9fwzgE9GYxBh
 eCj48aipf337dbE/JbtyV2EoL1X7gWiD3O8IvH9Q6+oFJQ/TNDLyu3IWXomp5d7irAGzZ4vkgNk
 HbnP2YvhdICUYxHcnNL54OYYHI955wG0O4MMaxNpzvax5NywifxKTgfyJMVvFuVtDK4vq3pcpKR
 fGfwOTB4Awq/NNrUiRRChbTocLM+wuPocq3J6c69q5WWWwhPzQdWsn+zZ/KfPRivBHhj2uc+bkM
 MWh5y6Av0woDxmQEUcwv4pgGaMYOA6my8TKGTxWM5wmEq+HDDeRtgyL2qAt4imvm0by1Uh4hcIJ
 zjxrYVtgzGcbd6m2o8za/4m4WX7O5bTO9SrQ9F1D0v/5PzpeU7H0lF/XSto0P3XFhVNN60l94Zb
 LZmxZJjNKNLWf5YVrAzzFK7OnIjoT+zcVT2ykBBX0lLN8PdMtQlznfq5PEtHmPXIF6r1J1Yx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_06,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220113

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
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1

Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
---
v3:
 - Rebased on ToT as the patch that fixed the frequencey
   range - https://lore.kernel.org/linux-wireless/20250520-fix_freq_range_update-v1-1-e061fd147b87@oss.qualcomm.com/
   is merged.
v2:
 - Fixed frequency conversion from KHZ to MHZ in freq_to_idx()
---
 drivers/net/wireless/ath/ath12k/mac.c | 93 +++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath12k/reg.c | 13 ++++
 drivers/net/wireless/ath/ath12k/wmi.c |  9 ++-
 3 files changed, 109 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87a..ca08cb81e6c3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4149,8 +4149,9 @@ ath12k_mac_select_scan_device(struct ieee80211_hw *hw,
 		band = NL80211_BAND_6GHZ;
 
 	for_each_ar(ah, ar, i) {
-		/* TODO 5 GHz low high split changes */
-		if (ar->mac.sbands[band].channels)
+		if (ar->mac.sbands[band].channels &&
+		    center_freq >= KHZ_TO_MHZ(ar->freq_range.start_freq) &&
+		    center_freq <= KHZ_TO_MHZ(ar->freq_range.end_freq))
 			return ar;
 	}
 
@@ -11411,6 +11412,32 @@ static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
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
@@ -11421,6 +11448,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	u32 phy_id, freq_low, freq_high;
 	struct ath12k_hw *ah = ar->ah;
 	void *channels;
+	int ret;
 
 	BUILD_BUG_ON((ARRAY_SIZE(ath12k_2ghz_channels) +
 		      ARRAY_SIZE(ath12k_5ghz_channels) +
@@ -11442,7 +11470,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		band->channels = channels;
 		band->n_bitrates = ath12k_g_rates_size;
 		band->bitrates = ath12k_g_rates;
-		bands[NL80211_BAND_2GHZ] = band;
 
 		if (ab->hw_params->single_pdev_only) {
 			phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_2GHZ_CAP);
@@ -11459,6 +11486,22 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
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
@@ -11477,7 +11520,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			bands[NL80211_BAND_6GHZ] = band;
 
 			freq_low = max(reg_cap->low_5ghz_chan,
 				       ab->reg_freq_6ghz.start_freq);
@@ -11490,6 +11532,26 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 
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
@@ -11508,7 +11570,6 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			band->channels = channels;
 			band->n_bitrates = ath12k_a_rates_size;
 			band->bitrates = ath12k_a_rates;
-			bands[NL80211_BAND_5GHZ] = band;
 
 			if (ab->hw_params->single_pdev_only) {
 				phy_id = ath12k_get_phy_id(ar, WMI_HOST_WLAN_5GHZ_CAP);
@@ -11525,6 +11586,28 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
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
index 2598b39d5d7e..67a235318596 100644
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
index 60e2444fe08c..4b214b2710c1 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -5911,9 +5911,16 @@ static int freq_to_idx(struct ath12k *ar, int freq)
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

base-commit: db5a2f8ef8d4be926d29ed62182d003110c1a6ca
-- 
2.34.1


