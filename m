Return-Path: <linux-wireless+bounces-21233-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39E3A7F381
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536233ACA61
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 04:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453BF204583;
	Tue,  8 Apr 2025 04:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JHQkBKyW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A652182D0
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086112; cv=none; b=Vllo2/oyclKLwcJVHOW9JigOgyaMhWDPiLWpYsfzBwiA22r1l4NcocMfG5eai1GZbGO2LNrKa/N23v1sdLPgrWVLBuLoKzJ8JQueMe92ARRb6zb9Xr7YhtQ4jUMiMLiFuxwDTtaiN33HvpCfFBbLkeveNAICk6ptr0UBv4v9+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086112; c=relaxed/simple;
	bh=5Swih1l+l4f1qCJU+1qyQPn/vUvLFs4T06x/M8T0jwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2DffMd4KcyOwuSkiRMW3u7sdlwhdO8WoBuEW/LHG+hjHbEHBLbHRK0fwau1Q5hMcrEJQEtD8ZAV6Gn9FGiLRsLwKDuMS4gWN8BR73860Z430jxjHf0CUNf+RHy0EtPEbDu/9hDS5wabBeJjTfk0rBu5KSFZqGAXWoEKBFfjqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JHQkBKyW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GL4O008070;
	Tue, 8 Apr 2025 04:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x3htg6sc6yWZqF0xgEqHwaH74+4CkR+f6D01ur5Wd9c=; b=JHQkBKyWJQVR7B18
	jd9zCA7fQkjNKePcHtRvJaDZGJS9SAZr6eMmkC3jJh8iPfYgc8HxcSd55cH+SS/r
	SWgo870nMsIyE7uvHtV/0N6xcHo+Ci54YEDl8bsufMiuehrt+WGwEDzVqmxs9PGd
	ZYuvlh2QnGx86pUfWuxbRtRbKKLzTa9Wu5nr2WGxlFb4oMn3YSKkUAxHhChsKEdY
	3YQhxFt2C4rrjH9rikmrhySfvZ0IQHvMvr68WQdNXr5hJ1nEzbyuPYsV0+UxaZ1S
	22bIVH4tZvKSHS4Ai+BQ9YJBIgOxP75dIDH8/kCKhrSrGXiMxO1xweeUrUiI2+wk
	fH514g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtaxg1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:21:47 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5384LlPh011779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 04:21:47 GMT
Received: from hu-rajson-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Apr 2025 21:21:45 -0700
From: Rajat Soni <quic_rajson@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH ath-next 1/3] wifi: ath12k: Add helper function ath12k_mac_update_freq_range()
Date: Tue, 8 Apr 2025 09:51:26 +0530
Message-ID: <20250408042128.720263-2-quic_rajson@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408042128.720263-1-quic_rajson@quicinc.com>
References: <20250408042128.720263-1-quic_rajson@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s9uKFjnk-7DBCz4o_URiQ2DPxI7oDfGE
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f4a45b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=ZBC4GIfCeQsqTZ2mr1YA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: s9uKFjnk-7DBCz4o_URiQ2DPxI7oDfGE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080029

In a subsequent change, the frequency range needs to be updated with
each regulatory update. Since the current function also modifies the
DISABLED flag in the actual channel list, which should always align
with hardware-supported start and end frequencies rather than the
current operating ones, the existing function cannot be called again.
Therefore, the logic for setting the frequency range needs to be
refactored.

To address this, refactor the frequency setting part into a new
helper function, ath12k_mac_update_freq_range(). Since this needs
to be done independently of updating the DISABLED flag, call the new
helper function ath12k_mac_update_freq_range() after updating the
channel list for each band.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 22 +++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mac.h |  2 ++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 2b6bdc3d2b11..449aca719ad3 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -10811,6 +10811,16 @@ static const struct ieee80211_ops ath12k_ops = {
 #endif
 };
 
+void ath12k_mac_update_freq_range(struct ath12k *ar,
+				  u32 freq_low, u32 freq_high)
+{
+	if (!(freq_low && freq_high))
+		return;
+
+	ar->freq_range.start_freq = MHZ_TO_KHZ(freq_low);
+	ar->freq_range.end_freq = MHZ_TO_KHZ(freq_high);
+}
+
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
 				      struct ieee80211_supported_band *band,
 				      u32 freq_low, u32 freq_high)
@@ -10825,9 +10835,6 @@ static void ath12k_mac_update_ch_list(struct ath12k *ar,
 		    band->channels[i].center_freq > freq_high)
 			band->channels[i].flags |= IEEE80211_CHAN_DISABLED;
 	}
-
-	ar->freq_range.start_freq = MHZ_TO_KHZ(freq_low);
-	ar->freq_range.end_freq = MHZ_TO_KHZ(freq_high);
 }
 
 static u32 ath12k_get_phy_id(struct ath12k *ar, u32 band)
@@ -10885,6 +10892,9 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 		ath12k_mac_update_ch_list(ar, band,
 					  reg_cap->low_2ghz_chan,
 					  reg_cap->high_2ghz_chan);
+
+		ath12k_mac_update_freq_range(ar, reg_cap->low_2ghz_chan,
+					     reg_cap->high_2ghz_chan);
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP) {
@@ -10907,6 +10917,9 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
+
+			ath12k_mac_update_freq_range(ar, reg_cap->low_5ghz_chan,
+						     reg_cap->high_5ghz_chan);
 			ah->use_6ghz_regd = true;
 		}
 
@@ -10936,6 +10949,9 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 			ath12k_mac_update_ch_list(ar, band,
 						  reg_cap->low_5ghz_chan,
 						  reg_cap->high_5ghz_chan);
+
+			ath12k_mac_update_freq_range(ar, reg_cap->low_5ghz_chan,
+						     reg_cap->high_5ghz_chan);
 		}
 	}
 
diff --git a/drivers/net/wireless/ath/ath12k/mac.h b/drivers/net/wireless/ath/ath12k/mac.h
index 6c5f9d587a60..da37332352fe 100644
--- a/drivers/net/wireless/ath/ath12k/mac.h
+++ b/drivers/net/wireless/ath/ath12k/mac.h
@@ -126,4 +126,6 @@ struct ath12k *ath12k_get_ar_by_vif(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif,
 				    u8 link_id);
 int ath12k_mac_get_fw_stats(struct ath12k *ar, struct ath12k_fw_stats_req_params *param);
+void ath12k_mac_update_freq_range(struct ath12k *ar,
+				  u32 freq_low, u32 freq_high);
 #endif
-- 
2.34.1


