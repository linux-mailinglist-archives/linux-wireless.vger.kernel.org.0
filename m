Return-Path: <linux-wireless+bounces-23169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CBCABCE44
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 06:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB30B8A39BE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 04:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D31D90C8;
	Tue, 20 May 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UAyPToM7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0778F3E
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747715829; cv=none; b=GddWkTHUUGEGBpaQ2fF6XUPyKijTEFPvD3V0Ofh7pW1HwATZm20pmK99G8TXuRyR8f6k5P4q5eRhEeby99vDXA2+V+0X84HnSLIsxyvwXt2WTNizgbIL85QCeekKUDcIAiQZAFbTdi8CSQXFQP75eFFUjkcHt3p5S/2PbTiu2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747715829; c=relaxed/simple;
	bh=7AwdS0LxoFNqbbTHWAEHlvt5hE0tUbeKAsUmeP+m7AM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lkMdekiy9DLvcE8HnT2hi1R3k9SsiAifVf0RmPlpjjOBHvWainoXxsskPb4aQTUySYgoUl07HMz3dMIl1NikPfZPH3zisniCDvD8OCks9ZqRw+vQ4F4dNvKqV6Vw10+SQHjF/uK+3Y6pwthqEDPalns9//yI7a/U8NtysMGw7Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UAyPToM7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JKaRtU027386
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:37:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=awwojNaNrXyiw5s74gkw/0
	TBIsrjT+fryKobFxMVZAU=; b=UAyPToM7bIn7t18+Iz095PGhXjCA7lT4yVZZzW
	mIzSvqJDSW/GVDg/r9EZLzZQrG1wfTuFXH3b+8oQu1MjsfEbtKjQXgNCpUTLf7eb
	YaUK9E3vMY9oGYKbEmF+Z40XqltkeML+OXNhQ5JUxP4CTxBWAFY7vGRGfFPoJgu8
	1c94a69Dn4RvMkenhYskSB5kDRwmvxBXlhNsb1L66zsYklsLqM5GBDZx1W26QJKC
	/ywxycnh0t9nhIrwEp5zF23Xx7CE0ruqU2XpYQ9BFIB4ubq846OZtGhPQiFFfnan
	l8ZXu7QiCG6dMDjYchnZyentvglgeIVDw+JAeY7nby4+lKTw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjjsxd7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 May 2025 04:37:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2323bd7f873so17136425ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 21:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747715825; x=1748320625;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awwojNaNrXyiw5s74gkw/0TBIsrjT+fryKobFxMVZAU=;
        b=oVqTFONRfR27f/uqbS+MEdwsVzKctdTOiuURPwe4RhSojR0jTThy9dkGeCDzcSie97
         Yk3rqxodWC+/O4mS3seIby6lJQLW9+4x/d8wjV3V8eNmhAyr+HhgZvYHPnW+2cxxM6GO
         aWm0xXi+gENHuJ1TsMwjH91++8pgqFy80DaFVj/WVjnhl5K5qgM5WD+pofYGmitc2rYn
         cOBhdvBe86fd1daxvdZDdp2p85NuLWptLwIG8PiPn8UcsVRAOMCdp+Cf0d5ESFrRirDg
         TGZLosQtLL2ZwE8tgq0Mfq2AZPcepAIOpzdJjZB6meyqywBdV2zjFDiGjWdTllU5nN5S
         ScZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXq0rc908X+fl/HF5jMDg4HQx8j5gP16OAk7ZkEssBpjj70cabfZV5CpZFVDd5a+BasSP/QWElZ5Dr6nM89ow==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7f/G1hoV2MyNjxEx1lu8g61HDwsGNM5TQWS3gA8u5a6b5C3/
	GcsHpTyYcqiKVO2/8bbAA99h//K3hxafDPJ0XY3rgmQ3c/akSaj6zEcpDvu+yr6FwAM/VriBK/m
	MGQuwtn985EwPLwS30iJ/5me6kWG2qJqEABWdLqrGWXlp2lPf9ebzsWKPl4gE4cBI0OvUkg==
X-Gm-Gg: ASbGnct5pnNKjm2uCBmgGiIPxFsIVpJa5qEi4H0ofNlcuTjoK4IA9xp8v+yUAhPCcf7
	BwPPl6vi4V6fRX+dsMX4ltRqxaJm5Ou6JKPZcesUVkbNydnDgwA4Z0WRJ44834qujQTDYDYTzPi
	tG8rfpNTDf+AgkJ6j0p2UUsUZs502uTi+0s576QIti7o881HwAhMKpbdFukVXNwmuKZreNxz2dI
	tJFIOTSt+HXtZ/InShM0zBqOIVHgqZLg/M4dI24sa5NGLHeRHRma2NDJw/SA661VmpNbdKeEk27
	DzXAfwSZfo8QPlxsV2Px1bNyzx6HM0ulpeRr1YwOAROGoDY1P4fY20LxrfNqqrVm7a4IIlR4mMx
	Z53MPymkF5/bDsAnYAQugIRY1KD3TFNjb8331
X-Received: by 2002:a17:903:41d0:b0:231:c86b:ff77 with SMTP id d9443c01a7336-231d43cd9b2mr208070475ad.26.1747715824844;
        Mon, 19 May 2025 21:37:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt7ORIP0yCt6qLypNPPfXeVFvBW/v9IliwSoKvZIBmJS5PZ+67wJGNjBRQ+fK3mLegQIqhhA==
X-Received: by 2002:a17:903:41d0:b0:231:c86b:ff77 with SMTP id d9443c01a7336-231d43cd9b2mr208070235ad.26.1747715824423;
        Mon, 19 May 2025 21:37:04 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4adba91sm68395295ad.54.2025.05.19.21.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 21:37:03 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 20 May 2025 10:06:52 +0530
Subject: [PATCH ath-next] wifi: ath12k: fix mac pdev frequency range update
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250520-fix_freq_range_update-v1-1-e061fd147b87@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOMGLGgC/x2MUQ5AMBAFryL7rUnbILiKSNOy2J9iWyIRd1c+J
 2/e3BCQCQO02Q2MJwVafQKVZzAs1s8oaEwMWupSllqKiS4zMe6Gv9Uc22gjCj24unKFcqqpIH0
 3xiT+3Q5sXITHK0L/PC9CUJv1cQAAAA==
X-Change-ID: 20250520-fix_freq_range_update-2cb86b41b196
To: Jeff Johnson <jjohnson@kernel.org>, Rajat Soni <quic_rajson@quicinc.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: ipUezaq_0OOLxv41pwip9Ii_G4FO1r0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDAzNSBTYWx0ZWRfX4rfmKV+LkSp4
 uTqzeFMHqEkqIMqcH6fxclTXyWIOo4CdnkhGmKxpHwlCQeW0A2nUKMt8L0bObROX6URnHTnTSNy
 YqpEhTTMoWxfSMPqDc0xkvIGRUkDsN+/jw9nPwrmYehMptCATCx+MZURA3Igon9O0vuHYetfcLb
 vjNmDw8CTKIMpqAxXWNtXv2RVxXobbCReITZwb6cgKcGmEhe8LQwMG7k35PrLZdgpI0oo8QQ9JK
 FcaDqWXKrjJfXvBaLYHGriNUAR0Kyna1w+JJyjngI+nxtfgm8BJ2Zq7erXc42afvjrxzG4IrlXT
 s/Pm2G3fGpuJDzP7xAQYulVofSl5NQzXxbeT0QY6ASSlkrGXsu3GCBxtw1+U+cB6qYWj13SjZDj
 u5O8ZQP2gQYOjXPij8EdaKisuk73Iq01HhAsxm5Ujgkb/XZf6jdBMslq7weh0ae833gQT44d
X-Authority-Analysis: v=2.4 cv=K4giHzWI c=1 sm=1 tr=0 ts=682c06f2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=QKJL3u4FREtiCmV0lJIA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: ipUezaq_0OOLxv41pwip9Ii_G4FO1r0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_02,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505200035

The current implementation of per-pdev frequency range updates assumes that
each pdev supports only a single band. As a result in ath12k_regd_update(),
bands are handled using an if-else structure, which limits updates to only
one of the band per pdev. This assumption does not hold for all chipsets.
For example, the WCN7850 supports multiple bands within a single pdev.

Hence to accommodate such cases, update the logic to account for all band
cases by handling each band in a separate if conditions instead of the
previous if-else structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1

Fixes: 13324cecbb2c ("wifi: ath12k: Update frequency range if reg rules changes")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++--
 drivers/net/wireless/ath/ath12k/reg.c | 56 +++++++++++++++++------------------
 2 files changed, 42 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fa39537fa4ce8a4a2aad5aff87868aeaecd73565..64500b04675dbeb1cdf52b3fa77f4d831f43103e 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11353,8 +11353,20 @@ void ath12k_mac_update_freq_range(struct ath12k *ar,
 	if (!(freq_low && freq_high))
 		return;
 
-	ar->freq_range.start_freq = MHZ_TO_KHZ(freq_low);
-	ar->freq_range.end_freq = MHZ_TO_KHZ(freq_high);
+	if (ar->freq_range.start_freq || ar->freq_range.end_freq) {
+		ar->freq_range.start_freq = min(ar->freq_range.start_freq,
+						MHZ_TO_KHZ(freq_low));
+		ar->freq_range.end_freq = max(ar->freq_range.end_freq,
+					      MHZ_TO_KHZ(freq_high));
+	} else {
+		ar->freq_range.start_freq = MHZ_TO_KHZ(freq_low);
+		ar->freq_range.end_freq = MHZ_TO_KHZ(freq_high);
+	}
+
+	ath12k_dbg(ar->ab, ATH12K_DBG_MAC,
+		   "mac pdev %u freq limit updated. New range %u->%u MHz\n",
+		   ar->pdev->pdev_id, KHZ_TO_MHZ(ar->freq_range.start_freq),
+		   KHZ_TO_MHZ(ar->freq_range.end_freq));
 }
 
 static void ath12k_mac_update_ch_list(struct ath12k *ar,
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 62936d518b1d767a198958150a13bb9ac8b73009..fb8b07c95355c4683c514c2d62624feafedcf1f3 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -265,8 +265,8 @@ static void ath12k_copy_regd(struct ieee80211_regdomain *regd_orig,
 
 int ath12k_regd_update(struct ath12k *ar, bool init)
 {
-	u32 phy_id, freq_low = 0, freq_high = 0, supported_bands, band;
 	struct ath12k_wmi_hal_reg_capabilities_ext_arg *reg_cap;
+	u32 phy_id, freq_low, freq_high, supported_bands;
 	struct ath12k_hw *ah = ath12k_ar_to_ah(ar);
 	struct ieee80211_hw *hw = ah->hw;
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
@@ -276,45 +276,45 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	ab = ar->ab;
 
 	supported_bands = ar->pdev->cap.supported_bands;
-	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
-		band = NL80211_BAND_2GHZ;
-	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && !ar->supports_6ghz) {
-		band = NL80211_BAND_5GHZ;
-	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && ar->supports_6ghz) {
-		band = NL80211_BAND_6GHZ;
-	} else {
-		/* This condition is not expected.
-		 */
-		WARN_ON(1);
-		ret = -EINVAL;
-		goto err;
-	}
-
 	reg_cap = &ab->hal_reg_cap[ar->pdev_idx];
 
-	if (ab->hw_params->single_pdev_only && !ar->supports_6ghz) {
-		phy_id = ar->pdev->cap.band[band].phy_id;
-		reg_cap = &ab->hal_reg_cap[phy_id];
-	}
-
 	/* Possible that due to reg change, current limits for supported
-	 * frequency changed. Update that
+	 * frequency changed. Update it. As a first step, reset the
+	 * previous values and then compute and set the new values.
 	 */
+	ar->freq_range.start_freq = 0;
+	ar->freq_range.end_freq = 0;
+
 	if (supported_bands & WMI_HOST_WLAN_2GHZ_CAP) {
+		if (ab->hw_params->single_pdev_only) {
+			phy_id = ar->pdev->cap.band[WMI_HOST_WLAN_2GHZ_CAP].phy_id;
+			reg_cap = &ab->hal_reg_cap[phy_id];
+		}
+
 		freq_low = max(reg_cap->low_2ghz_chan, ab->reg_freq_2ghz.start_freq);
 		freq_high = min(reg_cap->high_2ghz_chan, ab->reg_freq_2ghz.end_freq);
-	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && !ar->supports_6ghz) {
+
+		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
+	}
+
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && !ar->supports_6ghz) {
+		if (ab->hw_params->single_pdev_only) {
+			phy_id = ar->pdev->cap.band[WMI_HOST_WLAN_5GHZ_CAP].phy_id;
+			reg_cap = &ab->hal_reg_cap[phy_id];
+		}
+
 		freq_low = max(reg_cap->low_5ghz_chan, ab->reg_freq_5ghz.start_freq);
 		freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_5ghz.end_freq);
-	} else if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && ar->supports_6ghz) {
-		freq_low = max(reg_cap->low_5ghz_chan, ab->reg_freq_6ghz.start_freq);
-		freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_6ghz.end_freq);
+
+		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
 	}
 
-	ath12k_mac_update_freq_range(ar, freq_low, freq_high);
+	if (supported_bands & WMI_HOST_WLAN_5GHZ_CAP && ar->supports_6ghz) {
+		freq_low = max(reg_cap->low_5ghz_chan, ab->reg_freq_6ghz.start_freq);
+		freq_high = min(reg_cap->high_5ghz_chan, ab->reg_freq_6ghz.end_freq);
 
-	ath12k_dbg(ab, ATH12K_DBG_REG, "pdev %u reg updated freq limits %u->%u MHz\n",
-		   ar->pdev->pdev_id, freq_low, freq_high);
+		ath12k_mac_update_freq_range(ar, freq_low, freq_high);
+	}
 
 	/* If one of the radios within ah has already updated the regd for
 	 * the wiphy, then avoid setting regd again

---
base-commit: 0b7122d5c6a84dd18d2ebffbcc46db835f24628f
change-id: 20250520-fix_freq_range_update-2cb86b41b196


