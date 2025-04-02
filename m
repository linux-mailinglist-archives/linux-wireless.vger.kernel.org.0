Return-Path: <linux-wireless+bounces-21102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFB1A794CC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214D13AF8B8
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB39619993B;
	Wed,  2 Apr 2025 18:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4NTr6hy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183119006B
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743617166; cv=none; b=rJ8nv7c/BEiMAuAE7bB+D86Mk4ftAvCnwt2F7VkK2dHxdRJp6pjywJfUpNEnEgbGw+iy1D9QsVWvGwS8aDyBLjg7eMOiNLhbsFm9jOVZsLJi2XAz1egPeZbzY9Zuv4dsGaWNp4c7cxgtNFGawmsM+cN11raABH3hKPO4fFsIjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743617166; c=relaxed/simple;
	bh=JXmw87/TmaQHnAJifz27de2f9jCwfggmxrjEqL0N+AU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lgP8xF4mutWoY11vRP+P2+O8nvlvXGI2rfKMg7KvlDjf68lN2GvH1qM3lKg6vm3WFk7QA6hjbrOj3Btwexb17OzH66fgdkmnZ6+x6NlHzqKEtN8aIEY7Qr6T2pkswVlVb/OaqSEHJ5p6+SkwXPAKng7Glns/UYQg+T1PyZa4HX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4NTr6hy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532AuAYZ014503
	for <linux-wireless@vger.kernel.org>; Wed, 2 Apr 2025 18:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fdShziIALLnGA3EOn3bsai4736gfzWW/VFr
	WzHvrNCc=; b=j4NTr6hyQBaz726K5beN2vpCTMD0p7mvwPP70zR6rkx62ThgMnV
	WTeXQj8I7QK3mLsA5rjwyYu7ZAyBjUibAnTpcAwzioMXbPJtoUijeTCrd+8tnnHa
	ypwCeW7FSw83U1lu8Ww9bwIgUAQvL9j46sB2mzwlLNbuhCY65O5oeuE3U4Yq+Ndj
	rLCaOr6zch8N9Kvu0UnqigpPGXTWf3bGgEntwTIMPwivtsM9+EQc36dL4MG72RYd
	TkqHgVjQ5VQSYMI4Xtk5YuHJZVd80p2qRRAe8aK8VH9V4apZPAgnArBOkZtdAmnL
	4k8MFuGbiCHYHOzDkjNsOG+YlVGkzwNWdtA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45p7tvmbx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 18:06:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736b431ee0dso60951b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 11:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743617161; x=1744221961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdShziIALLnGA3EOn3bsai4736gfzWW/VFrWzHvrNCc=;
        b=QtMYS0HH5cADgRpDCH+hK+XlT2xJ7USVqZE7URlXrI9Z8T070m6V8zry67QRi6W0mO
         uMtQes2xWvYM0WI4F1yJCE0DI9+e/guvMpSeWttVdQ0Ma0WcH+pdgoHE9JsJK2PlUt8J
         t0qGQ4+3njqcOEQQL7ZyKlYbZcBKPpkHfXlo0VtXzDBGIrEg6MpU/2NZHda5BaG97CNd
         J6iVZL2W2gUr2RWj2gA85vb6cGiBjjiZCtZd9F6/5LXw72miIV1k4wVoKd37vfsHwdBA
         tIIoJzyNa/KOArFbYSm/5yQoQPDOt75F5zbCHGwKgq0W35pQW9V+L2pvRIo6qlO3kKPi
         /bhQ==
X-Gm-Message-State: AOJu0YzudR8PNC78n6br5U7OvXCvSoqpkfHcYZdbpVrUav3SdI16O35Q
	N9+0wBATYD/9GBJgRApVjECOd9LlqOnvTkXxD2v+UUuy12ddwVOQ07hPsvq7qB15h54LyPshkTv
	73Y1nsxIbgTpN2EQXdjUtBq8TWZPGBD2M5EHA2Plbll4jDcX+i35th3ItvTJU+D6MsyqXJaIwZA
	==
X-Gm-Gg: ASbGncsdbNtoRwgHorEmf+o28PIxufckbN2y1D39Tg5lIxlZ9uP2UQTi+4/kt6xN4PW
	1iljip3arx8mTxhEG5VAUJQQhfwU+Y1pINbM6OEEx4EhqJDDd5tr/gQ4AqkGMCg6KU3G/FZpBLb
	OGsSrzff9o0NAJyDdcpxPqLGxP76HQoskSSxVn878Ux7drgvIortHEZtl53Y2A6DSe6wt2Gd4VS
	z1li1uQZm/noDb8nKH8STditef1b/jqbe5WB91GBeptwZlbRJwlEFXOExzWnjikfxXEidmRB7bk
	rTtZSf34MhwPdWJcxMyeBFMpQkLmKSRK94dk+bDPgksIZQmpyr/Vty77IkKlViTUbFM5Hyj1TH7
	06zkit1l/bjWHp5U2eDJtdDpHevSuVhV16w==
X-Received: by 2002:a05:6a00:3c8f:b0:737:9b:582a with SMTP id d2e1a72fcca58-739b611a1c2mr10850262b3a.24.1743617161061;
        Wed, 02 Apr 2025 11:06:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa5k9e0Yz9dh4yttEZuPbgBkDcLC6RWpmj+jDGu11Xc5bwMo2ILgv0fZQBlNylIIIYhqmGqA==
X-Received: by 2002:a05:6a00:3c8f:b0:737:9b:582a with SMTP id d2e1a72fcca58-739b611a1c2mr10850206b3a.24.1743617160525;
        Wed, 02 Apr 2025 11:06:00 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710636aesm11677804b3a.91.2025.04.02.11.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 11:06:00 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath12k: Fix invalid memory access while forming 802.11 header
Date: Wed,  2 Apr 2025 23:35:43 +0530
Message-Id: <20250402180543.2670947-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OIon3TaB c=1 sm=1 tr=0 ts=67ed7c8a cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=JjvW5l02fN9JWm9YJMsA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: I1uW6OOklV8cJGQUwNkhbbenkM60sL7_
X-Proofpoint-GUID: I1uW6OOklV8cJGQUwNkhbbenkM60sL7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_08,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020115

While forming the 802.11 header from the rx descriptor, skb_push() is
performed for the 802.11 header length and then calls
ath12k_dp_rx_desc_get_dot11_hdr(). Since skb_push() moves the skb->data
pointer backwards by the 802.11 header length, the rx descriptor points to
a different memory area than intended, causing invalid information to be
fetched from the rx descriptor.

Also, when IV and ICV are not stripped from the given MSDU, mac80211
performs PN validation for these MSDUs, which requires the crypto header.
Before forming the crypto header from the given rx descriptor, skb_push()
is performed for the crypto header length, which overwrites the memory
pointed to by the rx descriptor, causing invalid information to form the
802.11 header.

Fix these issues by moving all rx descriptor accesses before the skb_push()
operation which ensures the proper 802.11 headers are generated from the
given rx descriptor and removing ath12k_dp_rxdesc_get_mpdu_frame_ctrl()
for filling frame control, as this information is already fetched by
ath12k_dp_rx_desc_get_dot11_hdr().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00199-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Co-developed-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: Karthikeyan Periyasamy <karthikeyan.periyasamy@oss.qualcomm.com>
Signed-off-by: P Praneesh <praneesh.p@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 27 +++++++++----------------
 drivers/net/wireless/ath/ath12k/hal.c   | 19 -----------------
 drivers/net/wireless/ath/ath12k/hal.h   |  1 -
 3 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 66603e9c154b..d54c59812270 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -228,12 +228,6 @@ static void ath12k_dp_rx_desc_get_crypto_header(struct ath12k_base *ab,
 	ab->hal_rx_ops->rx_desc_get_crypto_header(desc, crypto_hdr, enctype);
 }
 
-static u16 ath12k_dp_rxdesc_get_mpdu_frame_ctrl(struct ath12k_base *ab,
-						struct hal_rx_desc *desc)
-{
-	return ab->hal_rx_ops->rx_desc_get_mpdu_frame_ctl(desc);
-}
-
 static inline u8 ath12k_dp_rx_get_msdu_src_link(struct ath12k_base *ab,
 						struct hal_rx_desc *desc)
 {
@@ -2122,10 +2116,13 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 	struct hal_rx_desc *rx_desc = rxcb->rx_desc;
 	struct ath12k_base *ab = ar->ab;
 	size_t hdr_len, crypto_len;
-	struct ieee80211_hdr *hdr;
+	struct ieee80211_hdr hdr;
 	u16 qos_ctl;
-	__le16 fc;
-	u8 *crypto_hdr;
+	u8 *crypto_hdr, mesh_ctrl;
+
+	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, &hdr);
+	hdr_len = ieee80211_hdrlen(hdr.frame_control);
+	mesh_ctrl = ath12k_dp_rx_h_mesh_ctl_present(ab, rx_desc);
 
 	if (!(status->flag & RX_FLAG_IV_STRIPPED)) {
 		crypto_len = ath12k_dp_rx_crypto_param_len(ar, enctype);
@@ -2133,22 +2130,16 @@ static void ath12k_get_dot11_hdr_from_rx_desc(struct ath12k *ar,
 		ath12k_dp_rx_desc_get_crypto_header(ab, rx_desc, crypto_hdr, enctype);
 	}
 
-	fc = cpu_to_le16(ath12k_dp_rxdesc_get_mpdu_frame_ctrl(ab, rx_desc));
-	hdr_len = ieee80211_hdrlen(fc);
 	skb_push(msdu, hdr_len);
-	hdr = (struct ieee80211_hdr *)msdu->data;
-	hdr->frame_control = fc;
-
-	/* Get wifi header from rx_desc */
-	ath12k_dp_rx_desc_get_dot11_hdr(ab, rx_desc, hdr);
+	memcpy(msdu->data, &hdr, min(hdr_len, sizeof(hdr)));
 
 	if (rxcb->is_mcbc)
 		status->flag &= ~RX_FLAG_PN_VALIDATED;
 
 	/* Add QOS header */
-	if (ieee80211_is_data_qos(hdr->frame_control)) {
+	if (ieee80211_is_data_qos(hdr.frame_control)) {
 		qos_ctl = rxcb->tid;
-		if (ath12k_dp_rx_h_mesh_ctl_present(ab, rx_desc))
+		if (mesh_ctrl)
 			qos_ctl |= IEEE80211_QOS_CTL_MESH_CONTROL_PRESENT;
 
 		/* TODO: Add other QoS ctl fields when required */
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 031f76d88bef..d00869a33fea 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -511,11 +511,6 @@ static void ath12k_hw_qcn9274_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274.mpdu_start.pn[1]);
 }
 
-static u16 ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274.mpdu_start.frame_ctrl);
-}
-
 static int ath12k_hal_srng_create_config_qcn9274(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
@@ -736,7 +731,6 @@ const struct hal_rx_ops hal_rx_qcn9274_ops = {
 	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_rx_desc_get_crypto_hdr,
-	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_qcn9274_rx_desc_get_mpdu_frame_ctl,
 	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_dp_rx_h_ip_cksum_fail,
@@ -975,11 +969,6 @@ ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 		HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcn9274_compact.mpdu_start.pn[1]);
 }
 
-static u16 ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.qcn9274_compact.mpdu_start.frame_ctrl);
-}
-
 static bool ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done(struct hal_rx_desc *desc)
 {
 	return !!le32_get_bits(desc->u.qcn9274_compact.msdu_end.info14,
@@ -1080,8 +1069,6 @@ const struct hal_rx_ops hal_rx_qcn9274_compact_ops = {
 	.rx_desc_is_da_mcbc = ath12k_hw_qcn9274_compact_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_qcn9274_compact_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_qcn9274_compact_rx_desc_get_crypto_hdr,
-	.rx_desc_get_mpdu_frame_ctl =
-		ath12k_hw_qcn9274_compact_rx_desc_get_mpdu_frame_ctl,
 	.dp_rx_h_msdu_done = ath12k_hw_qcn9274_compact_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_qcn9274_compact_dp_rx_h_ip_cksum_fail,
@@ -1330,11 +1317,6 @@ static void ath12k_hw_wcn7850_rx_desc_get_crypto_hdr(struct hal_rx_desc *desc,
 	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.wcn7850.mpdu_start.pn[1]);
 }
 
-static u16 ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl(struct hal_rx_desc *desc)
-{
-	return __le16_to_cpu(desc->u.wcn7850.mpdu_start.frame_ctrl);
-}
-
 static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_base *ab)
 {
 	struct ath12k_hal *hal = &ab->hal;
@@ -1555,7 +1537,6 @@ const struct hal_rx_ops hal_rx_wcn7850_ops = {
 	.rx_desc_is_da_mcbc = ath12k_hw_wcn7850_rx_desc_is_da_mcbc,
 	.rx_desc_get_dot11_hdr = ath12k_hw_wcn7850_rx_desc_get_dot11_hdr,
 	.rx_desc_get_crypto_header = ath12k_hw_wcn7850_rx_desc_get_crypto_hdr,
-	.rx_desc_get_mpdu_frame_ctl = ath12k_hw_wcn7850_rx_desc_get_mpdu_frame_ctl,
 	.dp_rx_h_msdu_done = ath12k_hw_wcn7850_dp_rx_h_msdu_done,
 	.dp_rx_h_l4_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_l4_cksum_fail,
 	.dp_rx_h_ip_cksum_fail = ath12k_hw_wcn7850_dp_rx_h_ip_cksum_fail,
diff --git a/drivers/net/wireless/ath/ath12k/hal.h b/drivers/net/wireless/ath/ath12k/hal.h
index 9f12ed84a653..a365703f84c0 100644
--- a/drivers/net/wireless/ath/ath12k/hal.h
+++ b/drivers/net/wireless/ath/ath12k/hal.h
@@ -1080,7 +1080,6 @@ struct hal_rx_ops {
 	bool (*rx_desc_is_da_mcbc)(struct hal_rx_desc *desc);
 	void (*rx_desc_get_dot11_hdr)(struct hal_rx_desc *desc,
 				      struct ieee80211_hdr *hdr);
-	u16 (*rx_desc_get_mpdu_frame_ctl)(struct hal_rx_desc *desc);
 	void (*rx_desc_get_crypto_header)(struct hal_rx_desc *desc,
 					  u8 *crypto_hdr,
 					  enum hal_encrypt_type enctype);

base-commit: ba613742db305037ca2193b2b552b769c4f2a5f7
-- 
2.34.1


