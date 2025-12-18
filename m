Return-Path: <linux-wireless+bounces-29866-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE31CCA03F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B3083041E07
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDFF26E6F0;
	Thu, 18 Dec 2025 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbejb0kY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJSzYjHn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D391270EAB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022917; cv=none; b=Eu+cEA1+sZZrk5XQ8RcFf24LlODv/JtUpl116hyYt8Uhkrfxpf5ZfTzz9MO8FcF5j7gfYuQ/GcW6wQiosoCCU6be8n2y51eLSs80d3Xqxu/TxByhHhk27kGjZD0lamgDwV5Kxk5jWLLHXvviltybKr9hy/HifLwSqsjnkiCua6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022917; c=relaxed/simple;
	bh=/cfmX3yBGBhNH6po6wbYXDuZ+m+b67OTSG/ahrvbPUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kkmMqEjn20JB89tOXa0LhnY8A5FZa8y5+KjfDmH8JBOniena7kJFNdE3wo5I2GeQVkpv/1rS2YLGIhftGoQCkOjIo0wlYHIL4/4wdHYJg38JCLmgv9XpcBAKV1BB/bj3hjhrtECsTk2PDy5Tw/klS4Dw26tvp4adQNh1efkhjb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbejb0kY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJSzYjHn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1YjsI3717126
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zd+NHgHkqU0xZFONcwzOTfX+5HAIkhCqXr0ctxebxrQ=; b=nbejb0kYg0Pdxjwi
	sVApRzAKFIje2UiJsuW3+f9MBCLgNXaUXJRPn5mqQDuwgo/7aA3XC2BF2WAbaKYL
	QjwXeYibG15JTh0zQdCh7aeI5I8pWPFIfWC1OrQIZmxDHM7H03fG7JKKDBvCRZKX
	ujtep9c6X/tWXwySM9O0D5aED4i+6MwJ34XCcdQ5Rjq0mCnKuJ+skAz530ZQ69t7
	mu3/IvYMJmiqj0Ca/OBGmpIK1x/toB/yAT8WxcAJO3CFMlLeQ0We8kgdq29wmnsp
	+hfcvzRsf91vzTJC3ap4vQvMnxEbh/Jf3NTtfELxVL37wR2reMLpe6qy6QDXkg2/
	2tuETg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b40n79asc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0bb1192cbso3322305ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022915; x=1766627715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zd+NHgHkqU0xZFONcwzOTfX+5HAIkhCqXr0ctxebxrQ=;
        b=MJSzYjHnpteUqczQl3q1OTB2AflxAervt4R2jlJrWQS38hGmn23HGIwhOG93NjXVGK
         /T+HbTAB/hlTNFT3EiWKyGwQScBlk+jlL6Px64/nL9nEwV2bRwUQxoFWVRr5QS/8OiUZ
         yNLX6qgt0fK8+l3NLnO4gQt/N6NMABC3zOaKHp3+i2uU9siBVfREnkbeynGPpk0jHijL
         ZUxX7/HMRisWv+Ka5YR4OHUycva+x+N33tt2ZSMFMVUFbCJutrkA3vrCCdD6/52KMNQw
         1eZ5ziwzxAuSrNgYnSRJd5WMI2k7EQvmUcSddlf7VXifsreSdl2XE3KVLXEgoylT0+/i
         g8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022915; x=1766627715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zd+NHgHkqU0xZFONcwzOTfX+5HAIkhCqXr0ctxebxrQ=;
        b=UN41129tSa60WAVHSXVTWguOgX6HEjzS9wE6jmjFViDUeSoODzo+0p1sQ2PyBLFQtt
         je0z1E8/Ox7PzmShhB6LgVJGhETUViP+4URqAuPT7R5AxLZYxBv6LMynJVOjJlnu4Lvo
         bFK+91PQkU9QcVaI4ywVYpr9JaiSuUpQaD0mDVBeA/XsJOndq/pqRk49fjZc1bAyc1jR
         7jPEtCdVNQ1wvakpZD7bm6OORp8pyIH/yD8Xx4lt3kSSlc26q5McZyJbscX1njU+Ef2S
         fMH9RBrUkgLWDgdjz+psDLbXA9UROA8ga18NYVgoQ4fhitwqcJ/FLZA+HlE3zpKSiu9n
         QpPQ==
X-Gm-Message-State: AOJu0YzEzWZgacHzabWgm8CAUxtxZav+ysAb13SxSXo/rnYcvjc/DaZC
	JVCquGG1dE4IQa1u4ske/mEhEyLsg36LMKt2VrGcfd9PzAmJNH8a1BhFDTo2sn7u5zF8D8MFdQ0
	Vh1sxh90lNKrhPrYz+/fwzOPRnIMDNKF4Z+QKo79Lg1tGK7qbrDo8zLVvt1jZmPV+elmsIA==
X-Gm-Gg: AY/fxX5zpJ5IzZqI2Qr+LfISIDTP/5AeJFBfX9ynVvwzYLMt6V8XADmnu2fjR2NlziB
	wxgKIYwVDGblhJ2qWUWSQbvTBWyVaqTuHdlv1e1DHjK5YDS0gnk0qXSxJqFFy/Nge1nzd88MpEw
	rHpqPbvb/0ASXdu2M8fjbNEwXLdNVtmbYbbzL4Q6oFUXiFlSBXBd21tR4aOojx5yC8OFfBwlyDE
	TthS2kLg0HSnszM0kLsg7iwtcMf6X3oBQ+96awdaI4JlNWoMR96HeLmQRc2vTOiHqXAZ6bGF68Y
	PKEtsJuZt1e4JUON3yh05zWoBzBzSLWXD4zcgE2Lglnr9sBxyYjad71aakoqt2nkNQsdog27N9w
	Fjazv3Qkgk4JLBSM1wHbCQAAl8VSJspPjJpbdHZ5/AA0VSv6b53JFCbapQ+D0QGc=
X-Received: by 2002:a17:902:f543:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a110f60540mr103365965ad.26.1766022914827;
        Wed, 17 Dec 2025 17:55:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH177bhFNjFnWpSYngylfEmZufcf0R7/t06C3AIQcL+52h/fq5RiUjFCICcoChSsdjzSVkkjA==
X-Received: by 2002:a17:902:f543:b0:2a1:10f6:3c1 with SMTP id d9443c01a7336-2a110f60540mr103365785ad.26.1766022914343;
        Wed, 17 Dec 2025 17:55:14 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:14 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:19 +0800
Subject: [PATCH ath-next 05/19] wifi: ath12k: refactor 320 MHz bandwidth
 support parsing
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-5-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: m9pTrG56CQacJT4sARH3kIeSUt6Hv2hq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX3Dp8/eyr+S0o
 oTezp8J2RYw13ut5qIoiLG38yNbxk5Q/zTQKjs/SBmjBwApFnKGfuMDRadLrh3HN+2GAgDSEjkc
 wG2HoxQBolNXF9uOaFBNhwzOzc89k3ArSZXR8itW32WWJ1xJ5+t/XFNay+AgX2+0+uoLN/xWFLM
 Tb8QnJe7Nu5c3u5+ydNbA6kEJM9Chf9JxMk0DfFl7boAE98jfLHg9giP3QTTfYB9EZGIkdoyN/l
 LXsiE0NIZKMDPMUhIVVuO0i5sndEg6iry4ciwl+c4D/6NmFbpAUBaYqMuvTokufAlCyAXY0zzpA
 5eRV2iUsnuArvt9Axq0khecMj32Tt4thGkFwA2G2+8UsluQ9cb0lf/YQvnyCBIBueRNJlWnSlya
 vRw3XI3lhUMF9y61CYtsZvdTOKHJzg==
X-Authority-Analysis: v=2.4 cv=TZebdBQh c=1 sm=1 tr=0 ts=69435f03 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iGNyLxvpPC8n4FyEg3QA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: m9pTrG56CQacJT4sARH3kIeSUt6Hv2hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

For single pdev device, 320 MHz bandwidth support is reported only in
capability of WMI_HOST_HW_MODE_SINGLE mode, hence commit d4e244c85e45
("wifi: ath12k: enable 320 MHz bandwidth for 6 GHz band in EHT PHY
capability for WCN7850") relaxed the condition check in
ath12k_wmi_tlv_mac_phy_caps_ext() to allow SINGLE mode getting parsed in
ath12k_wmi_tlv_mac_phy_caps_ext_parse(). Since SINGLE mode is not assumed
to be preferred, the function returns unconditionally after parsing 320
MHz support.

This works for WCN7850 because it prefers another mode indeed, while it
breaks QCC2072 since it prefers SINGLE mode. Due to the unconditional
return, the subsequent EHT parsing is skipped. Consequently EHT related
features are disabled.

Refactor it by moving 320 MHz parsing to ath12k_wmi_tlv_mac_phy_caps_ext(),
before the mode checking. This makes the code more straightforward, and
work for both WCN7850 and QCC2072.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index ce2bbf6acb4a..dd643af892c2 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -4918,19 +4918,10 @@ ath12k_wmi_tlv_mac_phy_caps_ext_parse(struct ath12k_base *ab,
 				      const struct ath12k_wmi_caps_ext_params *caps,
 				      struct ath12k_pdev *pdev)
 {
-	struct ath12k_band_cap *cap_band;
-	u32 bands, support_320mhz;
+	u32 bands;
 	int i;
 
 	if (ab->hw_params->single_pdev_only) {
-		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
-			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
-				IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
-			cap_band = &pdev->cap.band[NL80211_BAND_6GHZ];
-			cap_band->eht_cap_phy_info[0] |= support_320mhz;
-			return 0;
-		}
-
 		for (i = 0; i < ab->fw_pdev_count; i++) {
 			struct ath12k_fw_pdev *fw_pdev = &ab->fw_pdev[i];
 
@@ -4983,14 +4974,22 @@ static int ath12k_wmi_tlv_mac_phy_caps_ext(struct ath12k_base *ab, u16 tag,
 					   void *data)
 {
 	const struct ath12k_wmi_caps_ext_params *caps = ptr;
+	struct ath12k_band_cap *cap_band;
+	u32 support_320mhz;
 	int i = 0, ret;
 
 	if (tag != WMI_TAG_MAC_PHY_CAPABILITIES_EXT)
 		return -EPROTO;
 
 	if (ab->hw_params->single_pdev_only) {
-		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id) &&
-		    caps->hw_mode_id != WMI_HOST_HW_MODE_SINGLE)
+		if (caps->hw_mode_id == WMI_HOST_HW_MODE_SINGLE) {
+			support_320mhz = le32_to_cpu(caps->eht_cap_phy_info_5ghz[0]) &
+					 IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
+			cap_band = &ab->pdevs[0].cap.band[NL80211_BAND_6GHZ];
+			cap_band->eht_cap_phy_info[0] |= support_320mhz;
+		}
+
+		if (ab->wmi_ab.preferred_hw_mode != le32_to_cpu(caps->hw_mode_id))
 			return 0;
 	} else {
 		for (i = 0; i < ab->num_radios; i++) {

-- 
2.25.1


