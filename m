Return-Path: <linux-wireless+bounces-21235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4466DA7F383
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 06:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1283AF97B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 04:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898F31B0F19;
	Tue,  8 Apr 2025 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXuZaiCA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31625F7B8
	for <linux-wireless@vger.kernel.org>; Tue,  8 Apr 2025 04:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744086116; cv=none; b=ly9G0mMxAxqOQRKOVa2bGxLdVswfpv2mQxVKuoTMm2cquXgfpXviK0mRHfi1p8bhI4l3ZvxdePrwQ6mrAD+6N9uPX9DzAQY54j13OprvOZiNWPC1/89f/2n/YiA8fh7Hkxa9WO6PCeZM5ttmv+UDv2aGFK3jTQc69aZREYUAC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744086116; c=relaxed/simple;
	bh=LBJbrFaZypEoWDtimmS8Gcjrgn7zcX6FvMtc6Ee30i0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdenXTJJk2iLJNOaW6x2n+WnZhsS+sWRnDN5xc/yawDZlbhWEgxtYKOjnVHh0gcGinYWlXMN6TolCI5s197uZ2x7jso9zgbUKqh99HBMktO0mnRc4FGVs9eZLUZZYVmeagQ04qHztzBTwdmZXsWdW1bKO482ZqKbPdmP+0Q5VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DXuZaiCA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GSqC008168;
	Tue, 8 Apr 2025 04:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tjH6i69nbjpMNZDiXdgJw7srN0uxGAjI4AZQw1iRHaI=; b=DXuZaiCALkldBAKU
	Kitwe8bi3RaknaeSMZU0Kdm6h7Wyp8bx2AuRAr6ccYKWWgoxktp525G33bloMCnG
	RiAxdgptnos4r3hCx+4YbJ7m4xfV6TUCMGDpzOgkR4OcEWZ2f2YeP3sD3TYravsF
	L3LAifGaxeY3A8Q4lHk82zZkDLkIBXECDafYjp1eU+yBZ7S+rY0rsnPrOZq/rSDF
	rCZWvk/kzyBgrdwYMCa6Wb1+/BNwD6utYzP8l7KNXKrTj1zaw8KiXHySf6G8lOu+
	rjty8dGd0XqO+39owpVvENIjM2A/DrZdyFWnEmoM125ScvW1mBdMzefvANFrzM39
	VqvnpQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtaxg1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:21:51 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5384LpsG015810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 04:21:51 GMT
Received: from hu-rajson-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 7 Apr 2025 21:21:49 -0700
From: Rajat Soni <quic_rajson@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>,
        Rajat Soni <quic_rajson@quicinc.com>
Subject: [PATCH ath-next 3/3] wifi: ath12k: Update frequency range if reg rules changes
Date: Tue, 8 Apr 2025 09:51:28 +0530
Message-ID: <20250408042128.720263-4-quic_rajson@quicinc.com>
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
X-Proofpoint-GUID: p9Ft41yVaWQyww_mPrUfT4jJsbOIfKlY
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f4a45f cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=w9nBwx8m75PmKFNLLyMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: p9Ft41yVaWQyww_mPrUfT4jJsbOIfKlY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080029

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

During the hardware register, driver updates the frequency range
during boot-up. However, if new regulatory rules are applied after
boot-up, the frequency range remains based on the older rules.
Since different countries have varying regulatory rules, the
frequency range can differ. Retaining the frequency range based on
outdated rules can be misleading.

Update the frequency range according to the new regulatory rules in
the function ath12k_regd_update().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Co-developed-by: Rajat Soni <quic_rajson@quicinc.com>
Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 54 +++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index e1007b878f91..0fed4e0096cb 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -6,6 +6,7 @@
 #include <linux/rtnetlink.h>
 #include "core.h"
 #include "debug.h"
+#include "mac.h"
 
 /* World regdom to be used in case default regd from fw is unavailable */
 #define ATH12K_2GHZ_CH01_11      REG_RULE(2412 - 10, 2462 + 10, 40, 0, 20, 0)
@@ -246,6 +247,8 @@ static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
 
 int ath12k_regd_update(struct ath12k *ar, bool init)
 {
+	u32 phy_id, freq_low = 0, freq_high = 0, supported_bands, band;
+	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
 	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	struct ieee80211_hw *hw = ah->hw;
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
@@ -255,6 +258,47 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 
 	ab = ar->ab;
 
+	supported_bands = ar->pdev->cap.supported_bands;
+	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
+		band = NL80211_BAND_2GHZ;
+	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && !ar->supports_6ghz) {
+		band = NL80211_BAND_5GHZ;
+	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && ar->supports_6ghz) {
+		band = NL80211_BAND_6GHZ;
+	} else {
+		/* This condition is not expected.
+		 */
+		WARN_ON(1);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	reg_cap = &ab->hal_reg_cap[ar->pdev_idx];
+
+	if (ab->hw_params->single_pdev_only && !ar->supports_6ghz) {
+		phy_id = ar->pdev->cap.band[band].phy_id;
+		reg_cap = &ab->hal_reg_cap[phy_id];
+	}
+
+	/* Possible that due to reg change, current limits for supported
+	 * frequency changed. Update that
+	 */
+	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
+		freq_low = max(reg_cap->low_2ghz_chan, ab->reg_freq_2ghz.start_freq);
+		freq_high = min(reg_cap->high_2ghz_chan, ab->reg_freq_2ghz.end_freq);
+	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && !ar->supports_6ghz) {
+		freq_low = max(reg_cap->low_5ghz_chan, ab->reg_freq_5ghz.start_freq);
+		freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_5ghz.end_freq);
+	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && ar->supports_6ghz) {
+		freq_low = max(reg_cap->low_5ghz_chan, ab->reg_freq_6ghz.start_freq);
+		freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_6ghz.end_freq);
+	}
+
+	ath12k_mac_update_freq_range(ar, freq_low, freq_high);
+
+	ath12k_dbg(ab, ATH12K_DBG_REG, "pdev %u reg updated freq limits %u->%u MHz\n",
+		   ar->pdev->pdev_id, freq_low, freq_high);
+
 	/* If one of the radios within ah has already updated the regd for
 	 * the wiphy, then avoid setting regd again
 	 */
@@ -704,6 +748,16 @@ ath12k_reg_build_regd(struct ath12k_base *ab,
 		   "\r\nCountry %s, CFG Regdomain %s FW Regdomain %d, num_reg_rules %d\n",
 		   alpha2, ath12k_reg_get_regdom_str(tmp_regd->dfs_region),
 		   reg_info->dfs_region, num_rules);
+
+	/* Reset start and end frequency for each band
+	 */
+	ab->reg_freq_5ghz.start_freq = INT_MAX;
+	ab->reg_freq_5ghz.end_freq = 0;
+	ab->reg_freq_2ghz.start_freq = INT_MAX;
+	ab->reg_freq_2ghz.end_freq = 0;
+	ab->reg_freq_6ghz.start_freq = INT_MAX;
+	ab->reg_freq_6ghz.end_freq = 0;
+
 	/* Update reg_rules[] below. Firmware is expected to
 	 * send these rules in order(2G rules first and then 5G)
 	 */
-- 
2.34.1


