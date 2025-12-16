Return-Path: <linux-wireless+bounces-29776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE85CC1269
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F70F309192F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 06:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D603431EE;
	Tue, 16 Dec 2025 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="al3xM/J8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aAehEoFP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75A342C9D
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765866453; cv=none; b=t2IsfwKlwBN5lCI+nNkeIFvjfUPnNhaZReSrE47Zi0knp+moybVH5a20fm9n/ZmPnZFsN20grcxHrbdUlQilzdccuZ1UfcIJfPt4Z41PWvCR8WXAcQvtsCbGxpIgniSfOOdquNMLnY+OJ3EEfL9klnBs30lXbavEHztSh/4YbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765866453; c=relaxed/simple;
	bh=sqYr6dr6OKTe3c0pbr/ZHBCI+vMCPn2lzGPvDJpTixk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aFxG1XjrXIXJ33rkShuJrnlYnW8kOah/cOHDKNXrWsuD9xSiFV6ADxX6OlLEzX+dyU9b6D2vq2yZB1ohhaWo9qF2ZgriwMUdChGxGcBcMFri0l4SwuBOngiG00jRuWWiCbS5f626nDsB1s51hUYKEAjTUjxernjHVyRnGfTqIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=al3xM/J8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aAehEoFP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG2GwaB1823829
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hdeu8Xq6OWxePzrbguwJsE8IJdQeLdy0QkUtpNicV/s=; b=al3xM/J8zyd6BV4I
	kz7zIPCw7Kd6613dPm7zWQfAT+KodilMzK9MoFiDZxoP8nc+9WxMDg31C3Y13UFA
	p+7Xt2qD17+gitiuyDkm6p5gYvcIeDQMoNeI25j2+e/D8PZMsRAb3nPx0hF6KgKB
	nnSvVaAFqlQ4RJqt6SyVD7IcBv5Owt0p8kz6/CU7eEpQzVLmxEcRvJW9sdd7dMDm
	bPQlXXQhkRK+qy1tuHI/r3prZOKJ/bHr+5myK3Hi6Sf5vKg2hDtxhm3URg0Q0Pen
	Vr1NE8S6DCl6H7oSlmDAS0T35Ox+9fSzrVUbgEMQnC/+9xwnH1vjeYth2Xgcm+5z
	w4sRGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2p4f2dyg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 06:27:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0f4822f77so51016745ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 22:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765866439; x=1766471239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdeu8Xq6OWxePzrbguwJsE8IJdQeLdy0QkUtpNicV/s=;
        b=aAehEoFP/0h90sbDZBA/HTD0MHDOKiIcyJVwOtpoadU/XiOUhPF9YlVCyVUl6Jh4l/
         dTG9knfx09Lyubn2CVFHYsKmCZ6XPqHViODa8GbuzAlmI4I7mUUYSqjuN65TAHY93ooz
         TgC2SR6ELNSxH8LCwUobY/EYc/Iu+mKhKnZEHD2lgaABxBIW0n/60JvEqVBh2Yct2DGn
         e1My7DcnrFjZ7gBfTdQlc8EhOE1qS3yMq8qCz86Uv/TJQXVqnVQ+B6J+G4LMxLJtcJNx
         GJ+mLRyHS2BYfqGH/RHaGQ/N/rwfm6YbOy9m1l/SmZuqjeRnTkrsDgqHcUC/kLRzijtl
         ualA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765866439; x=1766471239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdeu8Xq6OWxePzrbguwJsE8IJdQeLdy0QkUtpNicV/s=;
        b=tkajYVEbm6bxo4fi0f0mMvv47/07Ssor2dWXeB3MxMTR/zuQLbOkiZ2o6TVkFHcHGm
         toqgZ1uF8fL6A+OWrfy1Z6a1hj94/3qKWRM2ubYSJKjJNzkqxcJowTR38+ixRyVWqk4k
         ElG69chps4X+EqI7u7hHh50LypwMOdfl6bP24vQHkcQ/2G3Q9Q+2qVBUQqi/JBrMRcY/
         H37//cxyo0YuDtdGMy91SQ70pe/wZ8Do4kipfHpcNHysKfwAoxKOKAlY6RYQyitW1Fic
         /xHmOVXlRdTA13Gq0ge1apfsycL3EAmhSaCJC5+uuJWUnpV4Pa4eE4LdSARvwc835UAX
         uO6A==
X-Gm-Message-State: AOJu0YyBQEncFyS+STNxqwV2SxJP4ZeSgvtdyFG+RXECf5s81m3yn5Ip
	GxqnSZ4Npue6oM6hvEGAGkylgaz0iPtkiOrDKffbu+SLW2zlwA33cDi2nKovlSFvBNFbmFIrXzg
	t0tDvktBgY/ae5CwjZES+jMUZNyyr9DH3dPwc+qB9J+IxLxSVKpUNIR5cfPg/utE3wNOiSg==
X-Gm-Gg: AY/fxX4nZ/+NKithlsXZi3A5IT4f3ji/OOVSy6JmIArhM0DukYPG5b7LbWpbcU4hLhq
	ttz8+B23TCpI8hL2A7S57Lzb6Jvr211ytnMF3HoaoGzbsh88hehUObEb47g3qWP0p3phv3DTDqs
	raMf0stdKKdjlGLY1kBYgMCrD3g6xNy/s9tjVU1FnTN9stPDivKz4kgyBaYQcaz9T0mWlrkX/KL
	cVwR/VoixDSUUmr8qHyy77dPlqzVz/I2OdvwZu7WmD2n0bwCKJQ35eDOJSLFWG9hiJNMbl5nlmm
	Hvp2emXqDgA942gFZ8V1X5ekcm/tUOzYnf9II2NuyMrH68PQdLnM+qFie5FGov9lWqn3/cOKO4W
	QKmIKIJyr3xHaiNU6INQ+yMv944JoV9vn1MREsaXd9JpUuAx1khvw1A==
X-Received: by 2002:a17:903:240f:b0:2a0:a8c2:be5d with SMTP id d9443c01a7336-2a0a8c2c178mr95056805ad.5.1765866439309;
        Mon, 15 Dec 2025 22:27:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeRFGc79xZtUMHQiA4rH558sffcSIEHPj5BdfL1cmbVou3obRsqzIRe0QYnBL83Nr3/5gE6w==
X-Received: by 2002:a17:903:240f:b0:2a0:a8c2:be5d with SMTP id d9443c01a7336-2a0a8c2c178mr95056305ad.5.1765866438247;
        Mon, 15 Dec 2025 22:27:18 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29f4d27f833sm106478015ad.45.2025.12.15.22.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 22:27:17 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH RFC wireless-next 02/13] wifi: ieee80211: Add UHR (802.11bn) definitions
Date: Tue, 16 Dec 2025 11:56:45 +0530
Message-Id: <20251216062656.1738022-3-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
References: <20251216062656.1738022-1-karthikeyan.kathirvel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XFTCTLZvQ8nQKSvk3zoXq4pY91tZ1Ig7
X-Authority-Analysis: v=2.4 cv=OK8qHCaB c=1 sm=1 tr=0 ts=6940fbc8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UjtVTOmJoyioJT8tg2QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: XFTCTLZvQ8nQKSvk3zoXq4pY91tZ1Ig7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1MSBTYWx0ZWRfXw26+2RZtb/h4
 DZ/uSdxhAYAEPgwvPRcJXvMUrbWXjc70+YAk9NSYXiqlDtWdCNv7ReejT7z38Uq1lCPje74p5pi
 Zpi+9KfwSAdVTNgR3IfaC0IgiFx7dt4ShFwetAjxHPHwmaOCRGeWLGgX8SxyKdlk3oZJbFHUB9Y
 o4NV0eCbHYSSuSJaKAPyx4H+vQb8grNFpoBZHPNgOShRklHmJcKeGqDxeB1csh8JydwUxMiZkOu
 vidNcfqkJaOaI0KKDXdPTeZbz8Ds5dkMipOMfJWRN1Ik1VlGjO/CHRWFUlxQ1ykrLOoWyooGasg
 eKiMbHi5r8aWk2I6l/YrzHRhM3zaaCVZYI7fpSIpS2mZYJC0oL5345UP1HC/XGTCOpSIekUZmb2
 B9ZDJ4cWZ3iFfRKiQ8qX/uHpRcPMVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160051

Add ieee80211bn MAC and PHY Capabilities based on Draft P802.11bn_D1.0.
Introduce helper functions to calculate UHR capabilities and operation.

Some of fields in UHR capability and operation elements are
still in TBD state in the standard, the bit position and size
adjustments will be done later.

Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
---
 include/linux/ieee80211-uhr.h | 416 ++++++++++++++++++++++++++++++++++
 include/linux/ieee80211.h     |   3 +
 2 files changed, 419 insertions(+)
 create mode 100644 include/linux/ieee80211-uhr.h

diff --git a/include/linux/ieee80211-uhr.h b/include/linux/ieee80211-uhr.h
new file mode 100644
index 000000000000..53259fd7f633
--- /dev/null
+++ b/include/linux/ieee80211-uhr.h
@@ -0,0 +1,416 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * IEEE 802.11 UHR definitions
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+#ifndef LINUX_IEEE80211_UHR_H
+#define LINUX_IEEE80211_UHR_H
+
+/* UHR MAC capabilities as defined in P802.11bn_D1.0 section 9.4.2.aa2.2 */
+#define IEEE80211_UHR_MAC_CAP0_DPS_SUPPORT				0x01
+#define IEEE80211_UHR_MAC_CAP0_DPS_ASSISTING_SUPPORT			0x02
+#define IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPPORT		0x04
+#define IEEE80211_UHR_MAC_CAP0_ML_POWER_MANAGEMENT			0x08
+#define IEEE80211_UHR_MAC_CAP0_NPCA_SUPPORTED				0x10
+#define IEEE80211_UHR_MAC_CAP0_ENHANCED_BSR_SUPPORT			0x20
+#define IEEE80211_UHR_MAC_CAP0_ADDITIONAL_MAPPED_TID_SUPPORT		0x40
+#define IEEE80211_UHR_MAC_CAP0_EOTSP_SUPPORT				0x80
+#define IEEE80211_UHR_MAC_CAP1_DSO_SUPPORT				0x01
+#define IEEE80211_UHR_MAC_CAP1_P_EDCA_SUPPORT				0x02
+#define IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT				0x04
+#define IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPPORT				0x08
+#define IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPPORT				0x10
+#define IEEE80211_UHR_MAC_CAP1_PUO_SUPPORT				0x20
+#define IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPPORT				0x40
+#define IEEE80211_UHR_MAC_CAP1_DUO_SUPPORT				0x80
+#define IEEE80211_UHR_MAC_CAP2_OM_UL_MU_DATA_DIS_RX_SUPPORT		0x01
+#define IEEE80211_UHR_MAC_CAP2_AOM_SUPPORT				0x02
+#define IEEE80211_UHR_MAC_CAP2_IFCS_SUPPORT				0x04
+#define IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPPORT				0x08
+#define IEEE80211_UHR_MAC_CAP2_TXSPG_SUPPORT				0x10
+#define IEEE80211_UHR_MAC_CAP2_TXOP_RETURN_SUPPORT_INTXSPG		0x20
+#define IEEE80211_UHR_MAC_CAP2_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK	0xc0
+#define IEEE80211_UHR_MAC_CAP3_UHR_OPER_MODE_PARAM_UPDATE_TIMEOUT_MASK	0x03
+#define IEEE80211_UHR_MAC_CAP3_PARAM_UPDATE_ADV_NOTIFY_INT_MASK		0x1c
+#define IEEE80211_UHR_MAC_CAP3_UPDATE_IND_IN_TIM_INT_MASK		0xe0
+#define IEEE80211_UHR_MAC_CAP4_UPDATE_IND_IN_TIM_INT_MASK		0x03
+#define IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS				0x04
+#define IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE				0x08
+
+/* UHR PHY capabilities as defined in P802.11bn_D1.0 section 9.4.2.aa2.3 */
+#define IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_80MHZ		0x01
+#define IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_80MHZ		0x02
+#define IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_160MHZ		0x04
+#define IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_160MHZ	0x08
+#define IEEE80211_UHR_PHY_CAP0_MAX_NSS_RX_NDP_SOUNDING_320MHZ		0x10
+#define IEEE80211_UHR_PHY_CAP0_MAX_NSS_TOTAL_RX_DL_MUMIMO_320MHZ	0x20
+#define IEEE80211_UHR_PHY_CAP0_ELR_RX_SUPPORT				0x40
+#define IEEE80211_UHR_PHY_CAP0_ELR_TX_SUPPORT				0x80
+
+/**
+ * struct ieee80211_uhr_mcs_nss_supp_20mhz_only - UHR 20 MHz only station max
+ * supported NSS for per MCS.
+ *
+ * As per spec P802.11bn_D1.0 38.3.11 - "UHR-MCS 0-15 are the same as
+ * EHT-MCS 0-15"
+ *
+ * For each field below, bits 0 - 3 indicate the maximal number of spatial
+ * streams for Rx, and bits 4 - 7 indicate the maximal number of spatial streams
+ * for Tx.
+ *
+ * @rx_tx_mcs7_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 0 - 7.
+ * @rx_tx_mcs9_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 8 - 9.
+ * @rx_tx_mcs11_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 10 - 11.
+ * @rx_tx_mcs13_max_nss: indicates the maximum number of spatial streams
+ *     supported for reception and the maximum number of spatial streams
+ *     supported for transmission for MCS 12 - 13.
+ * @rx_tx_max_nss: array of the previous fields for easier loop access
+ */
+struct ieee80211_uhr_mcs_nss_supp_20mhz_only {
+	union {
+		struct {
+			u8 rx_tx_mcs7_max_nss;
+			u8 rx_tx_mcs9_max_nss;
+			u8 rx_tx_mcs11_max_nss;
+			u8 rx_tx_mcs13_max_nss;
+		};
+		u8 rx_tx_max_nss[4];
+	};
+} __packed;
+
+#define IEEE80211_UHR_DBE_CAP_MAX_BW			GENMASK(2, 0)
+#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ_PRES	BIT(3)
+#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ_PRES	BIT(4)
+#define IEEE80211_UHR_DBE_CAP_RESERVED			GENMASK(7, 5)
+#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ		GENMASK(31, 8)
+#define IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ		GENMASK(55, 32)
+
+/**
+ * struct ieee80211_dbe_cap - UHR DBE Capability parameter
+ *
+ * As per spec P802.11bn_D1.0 Figure 9-aa8 "DBE Capability Parameters
+ * field format"
+ *
+ * Please refer IEEE80211_UHR_DBE_CAP*
+ * @dbe_cap_param:
+ *      DBE Maximum Supported Bandwidth -  indicates the maximum bandwidth
+ *                                         that the AP supports for
+ *                                         DBE operation.
+ *      EHT-MCS Map (BW=160 MHz) Present - indicates whether the EHT-MCS Map
+ *                                         (BW=160 MHz) field is present in
+ *                                         the DBE Capability Parameters field
+ *      EHT-MCS Map (BW=320 MHz) Present - indicates whether the EHT-MCS Map
+ *                                         (BW=320 MHz) field is present in
+ *                                         the DBE Capability Parameters field
+ *      EHT-MCS Map (BW=160 MHz) - indicates the combinations of EHT-MCS 0-13,
+ *                                 and number of spatial streams NSS, that the
+ *                                 AP supports for reception and the
+ *                                 combinations that it supports for
+ *                                 transmission for 160 MHz DBE bandwidth
+ *      EHT-MCS Map (BW=320 MHz) - indicates the combinations of EHT-MCS 0-13,
+ *                                 and number of spatial streams NSS, that the
+ *                                 AP supports for reception and the
+ *                                 combinations that it supports for
+ *                                 transmission for 320 MHz DBE bandwidth
+ */
+struct ieee80211_dbe_cap {
+	__le64 dbe_cap_param;
+} __packed;
+
+/**
+ * struct ieee80211_uhr_cap_elem_fixed - UHR capabilities fixed data
+ *
+ * This structure is the "UHR Capabilities element" fixed fields as
+ * described in P802.11bn_D1.0 section 9.4.2.aa2.
+ *
+ * @mac_cap_info: MAC capabilities, see IEEE80211_UHR_MAC_CAP*
+ * @dbe_cap: DBE Capabilities, see IEEE80211_UHR_DBE_CAP*
+ * @phy_cap_info: PHY capabilities, see IEEE80211_UHR_PHY_CAP*
+ */
+struct ieee80211_uhr_cap_elem_fixed {
+	u8 mac_cap_info[5];
+	struct ieee80211_dbe_cap dbe_cap;
+	u8 phy_cap_info[2];
+} __packed;
+
+/**
+ * struct ieee80211_uhr_cap_elem - UHR capabilities element
+ * @fixed: fixed parts, see &ieee80211_uhr_cap_elem_fixed
+ */
+struct ieee80211_uhr_cap_elem {
+	struct ieee80211_uhr_cap_elem_fixed fixed;
+} __packed;
+
+#define IEEE80211_UHR_OPER_DPS_ENABLED		BIT(0)
+#define IEEE80211_UHR_OPER_NPCA_ENABLED		BIT(1)
+#define IEEE80211_UHR_OPER_DBE_ENABLED		BIT(2)
+#define IEEE80211_UHR_OPER_P_EDCA_ENABLED	BIT(3)
+
+#define IEEE80211_UHR_DBE_BANDWIDTH			GENMASK(2, 0)
+#define IEEE80211_UHR_DBE_RESERVED			GENMASK(7, 3)
+#define IEEE80211_UHR_DBE_DIS_SUBCHANNEL_BITMAP		GENMASK(15, 0)
+/**
+ * struct ieee80211_dbe_info - dbe operation information
+ *
+ * This structure is the "UHR Operation Element" fields as described
+ * in P802.11bn_D1.0 section 9.4.2.aa1. Refer Figure 9-aa5.
+ *
+ * Please refer IEEE80211_UHR_DBE*
+ * @dbe_bandwidth: DBE Bandwidth field is set to indicate
+ *     expanded bandwidth for DBE mode
+ *     Value 0 is reserved.
+ *     Set to 1 to indicate 40 MHz DBE bandwidth.
+ *     Set to 2 to indicate 80 MHz DBE bandwidth.
+ *     Set to 3 to indicate 160 MHz DBE bandwidth.
+ *     Set to 4 to indicate 320-1 MHz DBE bandwidth.
+ *     Set to 5 to indicate 320-2 MHz DBE bandwidth.
+ *     Values 6 to 7 are reserved.
+ * @dbe_disabled_subchannel_bitmap: DBE Disabled Subchannel
+ *     Bitmap field is set to indicate disabled 20 MHz subchannels
+ *     within the DBE Bandwidth.
+ */
+struct ieee80211_dbe_info {
+	u8 dbe_bandwidth;
+	__le16 dbe_disabled_subchannel_bitmap;
+} __packed;
+
+#define IEEE80211_UHR_P_EDCA_ECWMIN		GENMASK(3, 0)
+#define IEEE80211_UHR_P_EDCA_ECWMAX		GENMASK(7, 4)
+#define IEEE80211_UHR_P_EDCA_AIFSN		GENMASK(3, 0)
+#define IEEE80211_UHR_P_EDCA_CW_DS		GENMASK(5, 4)
+#define IEEE80211_UHR_P_EDCA_PSRC_THRESHOLD	GENMASK(8, 6)
+#define IEEE80211_UHR_P_EDCA_QSRC_THRESHOLD	GENMASK(10, 9)
+#define IEEE80211_UHR_P_EDCA_RESERVED		GENMASK(14, 11)
+/**
+ * struct ieee80211_p_edca_info - p_edca operation information
+ *
+ * This structure is the "UHR Operation Element" fields as described
+ * in P802.11bn_D1.0 section 9.4.2.aa1. Refer Figure 9-aa4.
+ *
+ * Please refer IEEE80211_UHR_P_EDCA*
+ * @p_edca_ec: The P-EDCA ECWmin, P-EDCA and ECWmax
+ *     fields indicate the CWmin and CWmax
+ *     value that are used by a P-EDCA STA during P-EDCA contention.
+ * @p_edca_params: The AIFSN field indicate the AIFSN value that are
+ *     used by a P-EDCA STA during P-EDCA contention.
+ *     The CW DS field indicate the value used
+ *     for the randomization of the transmission slot of the DS-CTS
+ *     frame. The value 3 is reserved. The value 0 indicate that
+ *     randomization not enabled.
+ *     The P-EDCA PSRC threshold field indicates the maximum number
+ *     of allowed consecutive DS-CTS transmissions. The value 0 and
+ *     values greater than 4 are reserved
+ *      The P-EDCA QSRC threshold field indicates the value of the
+ *      QSRC[AC_VO] counter to be allowed to start P-EDCA contention.
+ *      The value 0 is reserved
+ */
+struct ieee80211_p_edca_info {
+	u8 p_edca_ec;
+	__le16 p_edca_params;
+} __packed;
+
+#define IEEE80211_UHR_NPCA_PRIMARY_CHAN			GENMASK(3, 0)
+#define IEEE80211_UHR_NPCA_MIN_DUR_THRESHOLD		GENMASK(7, 4)
+#define IEEE80211_UHR_NPCA_SWITCHING_DELAY		GENMASK(13, 8)
+#define IEEE80211_UHR_NPCA_SWITCH_BACK_DELAY		GENMASK(19, 14)
+#define IEEE80211_UHR_NPCA_INITIAL_QSRC			GENMASK(21, 20)
+#define IEEE80211_UHR_NPCA_MOPLEN			BIT(22)
+#define IEEE80211_UHR_NPCA_DIS_SUBCHAN_BITMAP_PRESENT	BIT(23)
+#define IEEE80211_UHR_NPCA_RESERVED			GENMASK(31, 24)
+
+/**
+ * struct ieee80211_npca_info - npca operation information
+ *
+ * This structure is the "UHR Operation Element" fields as described
+ * in P802.11bn_D1.0 section 9.4.2.aa1. Refer Figure 9-aa3.
+ *
+ * Please refer IEEE80211_UHR_NPCA*
+ * @npca_params:
+ *     npca_primary_chan - NPCA primary channel
+ *     npca_min_dur_threshold - Minimum duration of inter-BSS activity
+ *     npca_switching_delay -  Time needed by an NPCA AP to switch from the
+ *                             BSS primary channel to the NPCA primary channel
+ *                             in the unit of 4 µs.
+ *     npca_switch_back_delay - Time to switch from the NPCA primary channel
+ *                              to the BSS primary channel in the unit of 4 µs.
+ *     npca_initial_qsrc -  initialize the EDCAF QSRC[AC] variables
+ *                          when an NPCA STA in the BSS
+ *                          switches to NPCA operation.
+ *     npca_moplen - indicates which conditions can be used to
+ *                   initiate an NPCA operation,
+ *                   1 -> both PHYLEN NPCA operation and MOPLEN
+ *                        NPCA operation are
+ *                        permitted in the BSS
+ *                   0 -> only PHYLEN NPCA operation is allowed in the BSS.
+ * @npca_disabled_subchan_bitmap: indicates whether the NPCA
+ *                                Disabled Subchannel
+ *                                Bitmap field is present.
+ */
+struct ieee80211_npca_info {
+	__le32 npca_params;
+	__le16 npca_disabled_subchan_bitmap;
+} __packed;
+
+#define IEEE80211_UHR_DPS_PADDING_DELAY			GENMASK(5, 0)
+#define IEEE80211_UHR_DPS_RESERVED1			GENMASK(7, 6)
+#define IEEE80211_UHR_DPS_TRANSITION_DELAY		GENMASK(13, 8)
+#define IEEE80211_UHR_DPS_RESERVED2			GENMASK(15, 14)
+#define IEEE80211_UHR_DPS_ICF_REQUIRED			BIT(16)
+#define IEEE80211_UHR_DPS_PARAMETERIZED_FLAG		BIT(17)
+#define IEEE80211_UHR_DPS_LC_MODE_BW			GENMASK(20, 18)
+#define IEEE80211_UHR_DPS_LC_MODE_NSS			GENMASK(24, 21)
+#define IEEE80211_UHR_DPS_LC_MODE_MCS			GENMASK(28, 25)
+#define IEEE80211_UHR_DPS_MOBILE_AP_DPS_STATIC_HCM	BIT(29)
+#define IEEE80211_UHR_DPS_RESERVED3			GENMASK(31, 30)
+
+/**
+ * struct ieee80211_dps_info - dps operation information
+ *
+ * This structure is the "UHR Operation Element" fields as described
+ * in P802.11bn_D1.0 section 9.4.1.87. Refer Figure 9-207u.
+ *
+ * Please refer IEEE80211_UHR_DPS*
+ * @dps_delay_params:
+ *     DPS Padding Delay - indicates the minimum MAC padding
+ *                         duration that is required by a DPS STA
+ *                         in an ICF to cause the STA to transition
+ *                         from the lower capability mode to the
+ *                         higher capability mode. The DPS Padding
+ *                         Delay field is in units of 4 µs.
+ *     DPS Transition - indicates the amount of time required by a
+ *                      DPS STA to transition from the higher
+ *                      capability mode to the lower capability
+ *                      mode. The DPS Transition Delay field is in
+ *                      units of 4 µs.
+ * @dps_params:
+ *      ICF Required - indicates when the DPS assisting STA needs
+ *                     to transmit an ICF frame to the peer DPS STA
+ *                     before performing the frame exchanges with
+ *                     the peer DPS STA in a TXOP.
+ *                     1 -> indicates that the transmission of the
+ *                          ICF frame to the peer DPS STA prior to
+ *                          any frame exchange is needed.
+ *                     0 -> ICF transmission before the frame
+ *                          exchanges with the peer DPS STA is only
+ *                          needed if the frame exchange is performed
+ *                          in the HC mode.
+ *      Parameterized Flag - 0 -> indicate that only 20 MHz, 1 SS,
+ *                                non-HT PPDU format with the data
+ *                                rate of 6, 12, and 24 Mb/s as the
+ *                                default mode are supported by the
+ *                                DPS STA in the LC mode
+ *                           1 -> indicate that a bandwidth up to the
+ *                                bandwidth indicated in the LC Mode
+ *                                Bandwidth field, a number of spatial
+ *                                streams up to the NSS indicated in
+ *                                the LC Mode Nss field, and an MCS up
+ *                                to the MCS indicated in the LC Mode
+ *                                MCS fields are supported by the DPS
+ *                                STA in the LC mode as the
+ *                                parameterized mode.
+ *      LC Mode Bandwidth - indicates the maximum bandwidth supported
+ *                          by the STA in the LC mode.
+ *      LC Mode Nss - indicates the maximum number of the spatial
+ *                    streams supported by the STA in the LC mode.
+ *      LC Mode MCS - indicates the highest MCS supported by the STA
+ *                    in the LC mode.
+ *      Mobile AP DPS Static HCM -
+ *                    1 -> indicate that it will remain in the DPS high
+ *                         capability mode until the next TBTT on that
+ *                         link.
+ *                    0 -> otherwise.
+ */
+struct ieee80211_dps_info {
+	__le16 dps_delay_params;
+	__le16 dps_params;
+} __packed;
+
+/**
+ * struct ieee80211_uhr_operation_info - uhr operation information
+ *
+ * @dps_info: DPS operation information
+ * @npca_info: NPCA operation information
+ * @p_edca_info: P-EDCA operation information
+ * @dbe_info: DBE operation information
+ */
+struct ieee80211_uhr_operation_info {
+	struct ieee80211_dps_info dps_info;
+	struct ieee80211_npca_info npca_info;
+	struct ieee80211_p_edca_info p_edca_info;
+	struct ieee80211_dbe_info dbe_info;
+} __packed;
+
+/**
+ * struct ieee80211_uhr_operation - uhr operation element
+ *
+ * This structure is the "UHR Operation Element" fields as
+ * described in P802.11bn_D1.0 section 9.4.2.aa1
+ *
+ * @params: UHR operation element parameters. See &IEEE80211_UHR_OPER_*
+ * @basic_mcs_nss: indicates the UHR-MCSs for each number of spatial streams in
+ *     UHR PPDUs that are supported by all UHR STAs in the BSS in transmit and
+ *     receive.
+ * @optional: optional parts
+ */
+
+struct ieee80211_uhr_operation {
+	__le16 params;
+	struct ieee80211_uhr_mcs_nss_supp_20mhz_only basic_mcs_nss;
+	u8 optional[];
+} __packed;
+
+static inline bool
+ieee80211_uhr_capa_size_ok(const u8 *data, u8 len)
+{
+	const struct ieee80211_uhr_cap_elem_fixed *elem = (const void *)data;
+	u8 needed = sizeof(struct ieee80211_uhr_cap_elem_fixed) -
+		sizeof(struct ieee80211_dbe_cap);
+
+	if (elem->mac_cap_info[1] &
+	    IEEE80211_UHR_MAC_CAP1_DBE_SUPPORT) {
+		needed += 1;
+
+		if (le64_to_cpu(elem->dbe_cap.dbe_cap_param) &
+		    IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_160MHZ_PRES)
+			needed += 3;
+
+		if (le64_to_cpu(elem->dbe_cap.dbe_cap_param) &
+		    IEEE80211_UHR_DBE_CAP_EHT_MCS_BW_320MHZ_PRES)
+			needed += 3;
+	}
+
+	return len >= needed;
+}
+
+static inline bool
+ieee80211_uhr_oper_size_ok(const u8 *data, u8 len, bool is_bcn)
+{
+	const struct ieee80211_uhr_operation *elem = (const void *)data;
+	u8 needed = sizeof(*elem);
+
+	if (len < needed)
+		return false;
+
+	if (is_bcn)
+		return len >= needed;
+
+	if (le16_to_cpu(elem->params) & IEEE80211_UHR_OPER_DPS_ENABLED)
+		needed += sizeof(struct ieee80211_dps_info);
+	if (le16_to_cpu(elem->params) & IEEE80211_UHR_OPER_NPCA_ENABLED)
+		needed += sizeof(struct ieee80211_npca_info);
+	if (le16_to_cpu(elem->params) & IEEE80211_UHR_OPER_DBE_ENABLED)
+		needed += sizeof(struct ieee80211_dbe_info);
+	if (le16_to_cpu(elem->params) & IEEE80211_UHR_OPER_P_EDCA_ENABLED)
+		needed += sizeof(struct ieee80211_p_edca_info);
+
+	return len >= needed;
+}
+
+#endif /* LINUX_IEEE80211_UHR_H */
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 96439de55f07..8497c45bd96a 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -1801,6 +1801,8 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
 	WLAN_EID_EXT_KNOWN_STA_IDENTIFCATION = 136,
 	WLAN_EID_EXT_NON_AP_STA_REG_CON = 137,
+	WLAN_EID_EXT_UHR_OPERATION = 151,
+	WLAN_EID_EXT_UHR_CAPABILITY = 152,
 };
 
 /* Action category code */
@@ -2820,6 +2822,7 @@ struct ieee80211_tbtt_info_ge_11 {
 #include "ieee80211-vht.h"
 #include "ieee80211-he.h"
 #include "ieee80211-eht.h"
+#include "ieee80211-uhr.h"
 #include "ieee80211-mesh.h"
 #include "ieee80211-s1g.h"
 #include "ieee80211-p2p.h"
-- 
2.34.1


