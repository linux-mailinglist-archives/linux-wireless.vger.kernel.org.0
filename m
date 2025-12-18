Return-Path: <linux-wireless+bounces-29873-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F56CCA04E
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 02:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA89306222F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 01:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED2226E6F4;
	Thu, 18 Dec 2025 01:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pDHpU3Sh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I+DXmf3y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D761271450
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766022933; cv=none; b=mwKTGGMHKyljs3Lhh4fEmtTwl7lIv5SSwB1IMzCW7rfmLDh/PYOA5HLoT27aHLrVPXpriFtxExQhR45UQUexJkGNbhpgHDmlV77KYp4Gpz75z9Rx4iDCdwabu6fOXe8OAp4OgVX0wbZ4d+gjArq7KOKSk/N5G1ijoZqj/7mQQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766022933; c=relaxed/simple;
	bh=3IO36Nbbv3zdrr1Hri/61Kgwz1jyF7gy+0dXpRcuwAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sz5v7XQ75rZqzmUDflMyXZCeBp8ZvHIdfXJm8xG8yIO2bkjXDRLG07U8TV5r9E4p8Kg+libXsw/x1N4FBDhqYsB5ku7GFASyBYkILwE5Hltl6NFARasG+8UFIR/wYUWcc07wbQDZCG71UCeFbEQrXt/rxuXfDIHJ5whFaysclJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pDHpU3Sh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I+DXmf3y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI1Ylhv527962
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HCui9xX0LB5baEIWckuw98a0r2Jgz6TDCXW7KmDdZZk=; b=pDHpU3Shd3DhjZeS
	6i66w71U3YwHPmZupCYtKnEsWXgo8mWlw7FNzJjOF1mm1Jd7mt2FXqXDZBSHcWLD
	54T21f9sxjl3fcqERSTCIlu73Hyj3dV6n4cFbnfsFtBHlxM/sFCW8E31R2N5ZO32
	SPy0CUZfT/kdu3ycm6VCnuwuDYgh2IbHvUu9bT2fRfaWb4fT/46UTowMq9u1RNZT
	KpeVtLZhAMsAiHIoCR/WkG4yR3ODoFrxGWlIJg4C59rXJBNgNZ7QxQlMPkVEQe6j
	7mOeFSyOQjgeqHSYrULs45cWDiTVDpfizap0lmvLo8KXol0SsjKnTZM53UVX0CD7
	iFJhvA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b43mb0qkb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 01:55:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bf222e5b54dso72119a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 17:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766022929; x=1766627729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCui9xX0LB5baEIWckuw98a0r2Jgz6TDCXW7KmDdZZk=;
        b=I+DXmf3y9WpTwRUeqsgAe0YAZQW2F/5aAd7VWL7/t+CKEL4EkkPuPxiRRYFdL23qZr
         eZpYpvdU9jPW+3aW8yczeAvJ9xp6flUVGKC3zODq+9ik/tBnTG5UgSLnT8Z2qdPTIwaY
         Lzs6UiRea0S/8EVCO+tW5yplSdp7sRCPCgfw/4zilegEaEMWvHUMU4wy21DBmdS35eNH
         l7mzh2hRNtHfk6BD0BKP6GcVwiObqNbZVIz7knPYAAYxt1TLr7g26pZW0Qls76gNQfZG
         MZY6tEQuAaH1K3QA1wO0y4mzJq7xvNGtrdtDCt5ZKH1xpTRRFIc/wpdDeWVqqmTw6nQy
         ovZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766022929; x=1766627729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCui9xX0LB5baEIWckuw98a0r2Jgz6TDCXW7KmDdZZk=;
        b=L8MltfEVVRDNM05gVAr7BJ8SdtCqKdbKryhlP/VMfsZUJ+b9/S7Om61Bi8R+32nm/t
         UHUCbKKO+x260R8mNkeQLwXcZbySGAO6BGSMBILnpN8l/TaHK+SIQBHlIdtEV4L0J+bw
         AEo1kGgeSD7FGCmBSja/r3lfEJFCe3qHaMkoS21Any9Mebnwb9NDIB84thdfUz0AkWBi
         suy6UE4poC45MK4PyOErs7zbnVZ8G7oAoUvw5zgxtVDJgAmSm38TpS/JpLNFtk3NJBgn
         UJUj5xTMA/7D2XadMB1ls1ZNgrtxFQq8oJtM+EdSudi5KpoUkwIN0eICeCRp2M4AP0sR
         xwAw==
X-Gm-Message-State: AOJu0YzbmUhwxuwdJFY0XxZqaa9Rp0VF/SeFTVnDGokxTvRKAtB4RKfZ
	LUsz6s9DR+scEyKeEOEQVW2j9YyaGL6/4+IpD5pAJvYUMl0WJ+4HRlMDgjv9dGHgvCgFOST4l1f
	XJ4oEFEan7GU9NCKD6dRJvuOLPb2V4Ojy1r0eNsjHXsIBiV1jalY7NHyyOWTLj1NHo76cVA==
X-Gm-Gg: AY/fxX4azzQr0Pd6P7qCNEFTE5nlDBobPlza5cie1qCasBK960v7By3TdtpgMr7m9VC
	a4PeusvQeOlEKtuybK/ZX9isIsHmPwzA9wvP3N8BQojBSWYLsMQihpYKXI0scAcarpY95ExJnK/
	yrpLPS0Hb4vPikWXcVHnWhGQ2qEEcWpIe2kiPnVd94JruvDTlO1/0Lno8spcMjDm2804nekwZB5
	0Y8fsFlmQ1t0K4L+NMmk9xxLVDtz4WSCrUTHuI/yUHXOO6GJ0TF1roA8rMF6egedcSg6lyK0+AT
	ymD3RWD/C12bfzO1gwuxa5ehNKa2JasQ0BYatwxEqIFnXSL92VOHYDKAnXNufO2G3IF/5OOaUY+
	fnEXWSLiAsoY7vh2iGNqlALR8qswhoYzJgbIqdHkV9N6Vc6urhBaBeN+++//Fp7Y=
X-Received: by 2002:a05:6a20:3d1a:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3755408c4eemr1307188637.30.1766022928658;
        Wed, 17 Dec 2025 17:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZu04LGmpBYf86FhMGiGRuykNuqNbseNkbZ282UmXc0rO5IGdmSS6KiglLXmiR9JR18tD3Lw==
X-Received: by 2002:a05:6a20:3d1a:b0:342:fa5:8b20 with SMTP id adf61e73a8af0-3755408c4eemr1307166637.30.1766022928142;
        Wed, 17 Dec 2025 17:55:28 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c812sm6548175ad.15.2025.12.17.17.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 17:55:27 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Thu, 18 Dec 2025 09:54:26 +0800
Subject: [PATCH ath-next 12/19] wifi: ath12k: add HAL descriptor and ops
 for QCC2072
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-ath12k-support-qcc2072-v1-12-87928cf8e547@oss.qualcomm.com>
References: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
In-Reply-To: <20251218-ath12k-support-qcc2072-v1-0-87928cf8e547@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        20251201-wlan_image_load_skip_512k-v3-1-bedb5498a58a@oss.qualcomm.com,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: soGk2cOW4mAnHbIysQewfQhZZIUxI2oa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDAxMyBTYWx0ZWRfX0AhD/+lUiVC/
 vjVuNsNdKiNtrY17my+0RVion8sORFFyEEhlytuJ7xxQhvMlaaPCSjYAhWWEkXMVlHs13jI+Qm1
 PhEXnvp3UW27cpvKH9G0GRTxmC9iuxlm5Y3Jt1Fmfi4hTm//dnBwjaMlmS9aKF/VXmvMcOUjMhD
 hh2DYYusHTwor70ww1jM6lgvX+gaKFj2h466/eSIKCMytYQdDgkjKKfKTy8At7Cd9ygALFaOFHn
 SC8ZFDrpFVqDiQOPH/ttUpIybblpH0pQOz4Rr/R/hyIO09Sam8CsSE6fL8Y46fuG4iNLYArarnm
 usRgIuB6GIad+6l2ooPbczfFG57MasrB8guK2q4dXbsCVWCQ/AH8YyHkvpxLyf2hXmPd3x8VRqR
 otHtVRQURKy9tbmdMWFIwmezyxL3xA==
X-Authority-Analysis: v=2.4 cv=NPHYOk6g c=1 sm=1 tr=0 ts=69435f11 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=nIUU2HICKwZ5NK4rRtwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: soGk2cOW4mAnHbIysQewfQhZZIUxI2oa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_01,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512180013

QCC2072 has different HAL descriptors hence require different HAL
handling, compared to other chips. Add support for this.

REO CMD/status ring handling is currently using the 64 bit ops

	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring_tlv64,
	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,

these will be updated to use 32 bit variants in upcoming patches.

Tested-on: QCC2072 hw1.0 PCI WLAN.COL.1.0-01560-QCACOLSWPL_V1_TO_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |   4 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    | 362 +++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |   2 +
 .../net/wireless/ath/ath12k/wifi7/hal_rx_desc.h    |  17 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |   2 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |   1 +
 6 files changed, 385 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal.c b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
index b957ebc9b7c5..bd1753ca0db6 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal.c
@@ -44,8 +44,8 @@ static const struct ath12k_hw_version_map ath12k_wifi7_hw_ver_map[] = {
 		.hw_regs = &ipq5332_regs,
 	},
 	[ATH12K_HW_QCC2072_HW10] = {
-		.hal_ops = &hal_wcn7850_ops,
-		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn7850),
+		.hal_ops = &hal_qcc2072_ops,
+		.hal_desc_sz = sizeof(struct hal_rx_desc_qcc2072),
 		.tcl_to_wbm_rbm_map = ath12k_hal_tcl_to_wbm_rbm_map_wcn7850,
 		.hal_params = &ath12k_hw_hal_params_wcn7850,
 		.hw_regs = &qcc2072_regs,
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
index 6c4986050bc6..847484ece204 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
@@ -4,6 +4,7 @@
  */
 
 #include "hal_qcc2072.h"
+#include "hal_wcn7850.h"
 
 const struct ath12k_hw_regs qcc2072_regs = {
 	/* SW2TCL(x) R0 ring configuration address */
@@ -92,3 +93,364 @@ const struct ath12k_hw_regs qcc2072_regs = {
 
 	.gcc_gcc_pcie_hot_rst = 0x1e65304,
 };
+
+static void ath12k_hal_rx_desc_set_msdu_len_qcc2072(struct hal_rx_desc *desc, u16 len)
+{
+	u32 info = __le32_to_cpu(desc->u.qcc2072.msdu_end.info10);
+
+	info &= ~RX_MSDU_END_INFO10_MSDU_LENGTH;
+	info |= u32_encode_bits(len, RX_MSDU_END_INFO10_MSDU_LENGTH);
+
+	desc->u.qcc2072.msdu_end.info10 = __cpu_to_le32(info);
+}
+
+static void ath12k_hal_rx_desc_get_dot11_hdr_qcc2072(struct hal_rx_desc *desc,
+						     struct ieee80211_hdr *hdr)
+{
+	hdr->frame_control = desc->u.qcc2072.mpdu_start.frame_ctrl;
+	hdr->duration_id = desc->u.qcc2072.mpdu_start.duration;
+	ether_addr_copy(hdr->addr1, desc->u.qcc2072.mpdu_start.addr1);
+	ether_addr_copy(hdr->addr2, desc->u.qcc2072.mpdu_start.addr2);
+	ether_addr_copy(hdr->addr3, desc->u.qcc2072.mpdu_start.addr3);
+
+	if (__le32_to_cpu(desc->u.qcc2072.mpdu_start.info4) &
+	    RX_MPDU_START_INFO4_MAC_ADDR4_VALID)
+		ether_addr_copy(hdr->addr4, desc->u.qcc2072.mpdu_start.addr4);
+
+	hdr->seq_ctrl = desc->u.qcc2072.mpdu_start.seq_ctrl;
+}
+
+static void ath12k_hal_rx_desc_get_crypto_hdr_qcc2072(struct hal_rx_desc *desc,
+						      u8 *crypto_hdr,
+						      enum hal_encrypt_type enctype)
+{
+	unsigned int key_id;
+
+	switch (enctype) {
+	case HAL_ENCRYPT_TYPE_OPEN:
+		return;
+	case HAL_ENCRYPT_TYPE_TKIP_NO_MIC:
+	case HAL_ENCRYPT_TYPE_TKIP_MIC:
+		crypto_hdr[0] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcc2072.mpdu_start.pn[0]);
+		crypto_hdr[1] = 0;
+		crypto_hdr[2] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcc2072.mpdu_start.pn[0]);
+		break;
+	case HAL_ENCRYPT_TYPE_CCMP_128:
+	case HAL_ENCRYPT_TYPE_CCMP_256:
+	case HAL_ENCRYPT_TYPE_GCMP_128:
+	case HAL_ENCRYPT_TYPE_AES_GCMP_256:
+		crypto_hdr[0] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcc2072.mpdu_start.pn[0]);
+		crypto_hdr[1] =
+			HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcc2072.mpdu_start.pn[0]);
+		crypto_hdr[2] = 0;
+		break;
+	case HAL_ENCRYPT_TYPE_WEP_40:
+	case HAL_ENCRYPT_TYPE_WEP_104:
+	case HAL_ENCRYPT_TYPE_WEP_128:
+	case HAL_ENCRYPT_TYPE_WAPI_GCM_SM4:
+	case HAL_ENCRYPT_TYPE_WAPI:
+		return;
+	}
+
+	key_id = u32_get_bits(__le32_to_cpu(desc->u.qcc2072.mpdu_start.info5),
+			      RX_MPDU_START_INFO5_KEY_ID);
+	crypto_hdr[3] = 0x20 | (key_id << 6);
+	crypto_hdr[4] = HAL_RX_MPDU_INFO_PN_GET_BYTE3(desc->u.qcc2072.mpdu_start.pn[0]);
+	crypto_hdr[5] = HAL_RX_MPDU_INFO_PN_GET_BYTE4(desc->u.qcc2072.mpdu_start.pn[0]);
+	crypto_hdr[6] = HAL_RX_MPDU_INFO_PN_GET_BYTE1(desc->u.qcc2072.mpdu_start.pn[1]);
+	crypto_hdr[7] = HAL_RX_MPDU_INFO_PN_GET_BYTE2(desc->u.qcc2072.mpdu_start.pn[1]);
+}
+
+static void ath12k_hal_rx_desc_copy_end_tlv_qcc2072(struct hal_rx_desc *fdesc,
+						    struct hal_rx_desc *ldesc)
+{
+	memcpy(&fdesc->u.qcc2072.msdu_end, &ldesc->u.qcc2072.msdu_end,
+	       sizeof(struct rx_msdu_end_qcn9274));
+}
+
+static u8 ath12k_hal_rx_desc_get_msdu_src_link_qcc2072(struct hal_rx_desc *desc)
+{
+	return 0;
+}
+
+static u8 ath12k_hal_rx_desc_get_l3_pad_bytes_qcc2072(struct hal_rx_desc *desc)
+{
+	return le16_get_bits(desc->u.qcc2072.msdu_end.info5,
+			     RX_MSDU_END_INFO5_L3_HDR_PADDING);
+}
+
+static u32 ath12k_hal_rx_desc_get_mpdu_start_tag_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.mpdu_start_tag,
+			     HAL_TLV_HDR_TAG);
+}
+
+static u32 ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcc2072(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcc2072.mpdu_start.phy_ppdu_id);
+}
+
+static u8 *ath12k_hal_rx_desc_get_msdu_payload_qcc2072(struct hal_rx_desc *desc)
+{
+	return &desc->u.qcc2072.msdu_payload[0];
+}
+
+static bool ath12k_hal_rx_desc_get_first_msdu_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.qcc2072.msdu_end.info5,
+			       RX_MSDU_END_INFO5_FIRST_MSDU);
+}
+
+static bool ath12k_hal_rx_desc_get_last_msdu_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le16_get_bits(desc->u.qcc2072.msdu_end.info5,
+			       RX_MSDU_END_INFO5_LAST_MSDU);
+}
+
+static bool ath12k_hal_rx_desc_encrypt_valid_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcc2072.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_ENCRYPT_INFO_VALID);
+}
+
+static u32 ath12k_hal_rx_desc_get_encrypt_type_qcc2072(struct hal_rx_desc *desc)
+{
+	if (!ath12k_hal_rx_desc_encrypt_valid_qcc2072(desc))
+		return HAL_ENCRYPT_TYPE_OPEN;
+
+	return le32_get_bits(desc->u.qcc2072.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_ENC_TYPE);
+}
+
+static u8 ath12k_hal_rx_desc_get_decap_type_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info11,
+			     RX_MSDU_END_INFO11_DECAP_FORMAT);
+}
+
+static u8 ath12k_hal_rx_desc_get_mesh_ctl_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info11,
+			     RX_MSDU_END_INFO11_MESH_CTRL_PRESENT);
+}
+
+static bool ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcc2072.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_SEQ_CTRL_VALID);
+}
+
+static bool ath12k_hal_rx_desc_get_mpdu_fc_valid_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcc2072.mpdu_start.info4,
+			       RX_MPDU_START_INFO4_MPDU_FCTRL_VALID);
+}
+
+static u16 ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.mpdu_start.info4,
+			     RX_MPDU_START_INFO4_MPDU_SEQ_NUM);
+}
+
+static u16 ath12k_hal_rx_desc_get_msdu_len_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info10,
+			     RX_MSDU_END_INFO10_MSDU_LENGTH);
+}
+
+static u8 ath12k_hal_rx_desc_get_msdu_sgi_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info12,
+			     RX_MSDU_END_INFO12_SGI);
+}
+
+static u8 ath12k_hal_rx_desc_get_msdu_rate_mcs_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RATE_MCS);
+}
+
+static u8 ath12k_hal_rx_desc_get_msdu_rx_bw_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info12,
+			     RX_MSDU_END_INFO12_RECV_BW);
+}
+
+static u32 ath12k_hal_rx_desc_get_msdu_freq_qcc2072(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcc2072.msdu_end.phy_meta_data);
+}
+
+static u8 ath12k_hal_rx_desc_get_msdu_pkt_type_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info12,
+			     RX_MSDU_END_INFO12_PKT_TYPE);
+}
+
+static u8 ath12k_hal_rx_desc_get_msdu_nss_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.msdu_end.info12,
+			     RX_MSDU_END_INFO12_MIMO_SS_BITMAP);
+}
+
+static u8 ath12k_hal_rx_desc_get_mpdu_tid_qcc2072(struct hal_rx_desc *desc)
+{
+	return le32_get_bits(desc->u.qcc2072.mpdu_start.info2,
+			     RX_MPDU_START_INFO2_TID);
+}
+
+static u16 ath12k_hal_rx_desc_get_mpdu_peer_id_qcc2072(struct hal_rx_desc *desc)
+{
+	return __le16_to_cpu(desc->u.qcc2072.mpdu_start.sw_peer_id);
+}
+
+static bool ath12k_hal_rx_desc_mac_addr2_valid_qcc2072(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcc2072.mpdu_start.info4) &
+			     RX_MPDU_START_INFO4_MAC_ADDR2_VALID;
+}
+
+static u8 *ath12k_hal_rx_desc_mpdu_start_addr2_qcc2072(struct hal_rx_desc *desc)
+{
+	return desc->u.qcc2072.mpdu_start.addr2;
+}
+
+static bool ath12k_hal_rx_desc_is_da_mcbc_qcc2072(struct hal_rx_desc *desc)
+{
+	return __le32_to_cpu(desc->u.qcc2072.msdu_end.info13) &
+			     RX_MSDU_END_INFO13_MCAST_BCAST;
+}
+
+static bool ath12k_hal_rx_h_msdu_done_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcc2072.msdu_end.info14,
+			       RX_MSDU_END_INFO14_MSDU_DONE);
+}
+
+static bool ath12k_hal_rx_h_l4_cksum_fail_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcc2072.msdu_end.info13,
+			       RX_MSDU_END_INFO13_TCP_UDP_CKSUM_FAIL);
+}
+
+static bool ath12k_hal_rx_h_ip_cksum_fail_qcc2072(struct hal_rx_desc *desc)
+{
+	return !!le32_get_bits(desc->u.qcc2072.msdu_end.info13,
+			       RX_MSDU_END_INFO13_IP_CKSUM_FAIL);
+}
+
+static bool ath12k_hal_rx_h_is_decrypted_qcc2072(struct hal_rx_desc *desc)
+{
+	return (le32_get_bits(desc->u.qcc2072.msdu_end.info14,
+			      RX_MSDU_END_INFO14_DECRYPT_STATUS_CODE) ==
+		RX_DESC_DECRYPT_STATUS_CODE_OK);
+}
+
+static u32 ath12k_hal_rx_h_mpdu_err_qcc2072(struct hal_rx_desc *desc)
+{
+	u32 info = __le32_to_cpu(desc->u.qcc2072.msdu_end.info13);
+	u32 errmap = 0;
+
+	if (info & RX_MSDU_END_INFO13_FCS_ERR)
+		errmap |= HAL_RX_MPDU_ERR_FCS;
+
+	if (info & RX_MSDU_END_INFO13_DECRYPT_ERR)
+		errmap |= HAL_RX_MPDU_ERR_DECRYPT;
+
+	if (info & RX_MSDU_END_INFO13_TKIP_MIC_ERR)
+		errmap |= HAL_RX_MPDU_ERR_TKIP_MIC;
+
+	if (info & RX_MSDU_END_INFO13_A_MSDU_ERROR)
+		errmap |= HAL_RX_MPDU_ERR_AMSDU_ERR;
+
+	if (info & RX_MSDU_END_INFO13_OVERFLOW_ERR)
+		errmap |= HAL_RX_MPDU_ERR_OVERFLOW;
+
+	if (info & RX_MSDU_END_INFO13_MSDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MSDU_LEN;
+
+	if (info & RX_MSDU_END_INFO13_MPDU_LEN_ERR)
+		errmap |= HAL_RX_MPDU_ERR_MPDU_LEN;
+
+	return errmap;
+}
+
+static void ath12k_hal_extract_rx_desc_data_qcc2072(struct hal_rx_desc_data *rx_desc_data,
+						    struct hal_rx_desc *rx_desc,
+						    struct hal_rx_desc *ldesc)
+{
+	rx_desc_data->is_first_msdu = ath12k_hal_rx_desc_get_first_msdu_qcc2072(ldesc);
+	rx_desc_data->is_last_msdu = ath12k_hal_rx_desc_get_last_msdu_qcc2072(ldesc);
+	rx_desc_data->l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcc2072(ldesc);
+	rx_desc_data->enctype = ath12k_hal_rx_desc_get_encrypt_type_qcc2072(rx_desc);
+	rx_desc_data->decap_type = ath12k_hal_rx_desc_get_decap_type_qcc2072(rx_desc);
+	rx_desc_data->mesh_ctrl_present =
+				ath12k_hal_rx_desc_get_mesh_ctl_qcc2072(rx_desc);
+	rx_desc_data->seq_ctl_valid =
+				ath12k_hal_rx_desc_get_mpdu_seq_ctl_vld_qcc2072(rx_desc);
+	rx_desc_data->fc_valid = ath12k_hal_rx_desc_get_mpdu_fc_valid_qcc2072(rx_desc);
+	rx_desc_data->seq_no = ath12k_hal_rx_desc_get_mpdu_start_seq_no_qcc2072(rx_desc);
+	rx_desc_data->msdu_len = ath12k_hal_rx_desc_get_msdu_len_qcc2072(ldesc);
+	rx_desc_data->sgi = ath12k_hal_rx_desc_get_msdu_sgi_qcc2072(rx_desc);
+	rx_desc_data->rate_mcs = ath12k_hal_rx_desc_get_msdu_rate_mcs_qcc2072(rx_desc);
+	rx_desc_data->bw = ath12k_hal_rx_desc_get_msdu_rx_bw_qcc2072(rx_desc);
+	rx_desc_data->phy_meta_data = ath12k_hal_rx_desc_get_msdu_freq_qcc2072(rx_desc);
+	rx_desc_data->pkt_type = ath12k_hal_rx_desc_get_msdu_pkt_type_qcc2072(rx_desc);
+	rx_desc_data->nss = hweight8(ath12k_hal_rx_desc_get_msdu_nss_qcc2072(rx_desc));
+	rx_desc_data->tid = ath12k_hal_rx_desc_get_mpdu_tid_qcc2072(rx_desc);
+	rx_desc_data->peer_id = ath12k_hal_rx_desc_get_mpdu_peer_id_qcc2072(rx_desc);
+	rx_desc_data->addr2_present = ath12k_hal_rx_desc_mac_addr2_valid_qcc2072(rx_desc);
+	rx_desc_data->addr2 = ath12k_hal_rx_desc_mpdu_start_addr2_qcc2072(rx_desc);
+	rx_desc_data->is_mcbc = ath12k_hal_rx_desc_is_da_mcbc_qcc2072(rx_desc);
+	rx_desc_data->msdu_done = ath12k_hal_rx_h_msdu_done_qcc2072(ldesc);
+	rx_desc_data->l4_csum_fail = ath12k_hal_rx_h_l4_cksum_fail_qcc2072(rx_desc);
+	rx_desc_data->ip_csum_fail = ath12k_hal_rx_h_ip_cksum_fail_qcc2072(rx_desc);
+	rx_desc_data->is_decrypted = ath12k_hal_rx_h_is_decrypted_qcc2072(rx_desc);
+	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_qcc2072(rx_desc);
+}
+
+const struct hal_ops hal_qcc2072_ops = {
+	.create_srng_config = ath12k_hal_srng_create_config_wcn7850,
+	.rx_desc_set_msdu_len = ath12k_hal_rx_desc_set_msdu_len_qcc2072,
+	.rx_desc_get_dot11_hdr = ath12k_hal_rx_desc_get_dot11_hdr_qcc2072,
+	.rx_desc_get_crypto_header = ath12k_hal_rx_desc_get_crypto_hdr_qcc2072,
+	.rx_desc_copy_end_tlv = ath12k_hal_rx_desc_copy_end_tlv_qcc2072,
+	.rx_desc_get_msdu_src_link_id = ath12k_hal_rx_desc_get_msdu_src_link_qcc2072,
+	.extract_rx_desc_data = ath12k_hal_extract_rx_desc_data_qcc2072,
+	.rx_desc_get_l3_pad_bytes = ath12k_hal_rx_desc_get_l3_pad_bytes_qcc2072,
+	.rx_desc_get_mpdu_start_tag = ath12k_hal_rx_desc_get_mpdu_start_tag_qcc2072,
+	.rx_desc_get_mpdu_ppdu_id = ath12k_hal_rx_desc_get_mpdu_ppdu_id_qcc2072,
+	.rx_desc_get_msdu_payload = ath12k_hal_rx_desc_get_msdu_payload_qcc2072,
+	.ce_dst_setup = ath12k_wifi7_hal_ce_dst_setup,
+	.srng_src_hw_init = ath12k_wifi7_hal_srng_src_hw_init,
+	.srng_dst_hw_init = ath12k_wifi7_hal_srng_dst_hw_init,
+	.set_umac_srng_ptr_addr = ath12k_wifi7_hal_set_umac_srng_ptr_addr,
+	.srng_update_shadow_config = ath12k_wifi7_hal_srng_update_shadow_config,
+	.srng_get_ring_id = ath12k_wifi7_hal_srng_get_ring_id,
+	.ce_get_desc_size = ath12k_wifi7_hal_ce_get_desc_size,
+	.ce_src_set_desc = ath12k_wifi7_hal_ce_src_set_desc,
+	.ce_dst_set_desc = ath12k_wifi7_hal_ce_dst_set_desc,
+	.ce_dst_status_get_length = ath12k_wifi7_hal_ce_dst_status_get_length,
+	.set_link_desc_addr = ath12k_wifi7_hal_set_link_desc_addr,
+	.tx_set_dscp_tid_map = ath12k_wifi7_hal_tx_set_dscp_tid_map,
+	.tx_configure_bank_register =
+				ath12k_wifi7_hal_tx_configure_bank_register,
+	.reoq_lut_addr_read_enable = ath12k_wifi7_hal_reoq_lut_addr_read_enable,
+	.reoq_lut_set_max_peerid = ath12k_wifi7_hal_reoq_lut_set_max_peerid,
+	.write_reoq_lut_addr = ath12k_wifi7_hal_write_reoq_lut_addr,
+	.write_ml_reoq_lut_addr = ath12k_wifi7_hal_write_ml_reoq_lut_addr,
+	.setup_link_idle_list = ath12k_wifi7_hal_setup_link_idle_list,
+	.reo_init_cmd_ring = ath12k_wifi7_hal_reo_init_cmd_ring_tlv64,
+	.reo_hw_setup = ath12k_wifi7_hal_reo_hw_setup,
+	.rx_buf_addr_info_set = ath12k_wifi7_hal_rx_buf_addr_info_set,
+	.rx_buf_addr_info_get = ath12k_wifi7_hal_rx_buf_addr_info_get,
+	.cc_config = ath12k_wifi7_hal_cc_config,
+	.get_idle_link_rbm = ath12k_wifi7_hal_get_idle_link_rbm,
+	.rx_msdu_list_get = ath12k_wifi7_hal_rx_msdu_list_get,
+	.rx_reo_ent_buf_paddr_get = ath12k_wifi7_hal_rx_reo_ent_buf_paddr_get,
+	.reo_cmd_enc_tlv_hdr = ath12k_hal_encode_tlv64_hdr,
+	.reo_status_dec_tlv_hdr = ath12k_hal_decode_tlv64_hdr,
+};
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
index 744d7e02b46e..392bfbb6a412 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h
@@ -4,5 +4,7 @@
  */
 
 #include "../hal.h"
+#include "hal.h"
 
 extern const struct ath12k_hw_regs qcc2072_regs;
+extern const struct hal_ops hal_qcc2072_ops;
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
index cc5e1d336376..0d19a9cbb68c 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_rx_desc.h
@@ -1481,10 +1481,27 @@ struct hal_rx_desc_wcn7850 {
 	u8 msdu_payload[];
 };
 
+struct rx_pkt_hdr_tlv_qcc2072 {
+	__le32 tag;
+	__le64 phy_ppdu_id;
+	u8 rx_pkt_hdr[HAL_RX_BE_PKT_HDR_TLV_LEN];
+};
+
+struct hal_rx_desc_qcc2072 {
+	__le32 msdu_end_tag;
+	struct rx_msdu_end_qcn9274 msdu_end;
+	u8 rx_padding0[RX_BE_PADDING0_BYTES];
+	__le32 mpdu_start_tag;
+	struct rx_mpdu_start_qcn9274 mpdu_start;
+	struct rx_pkt_hdr_tlv_qcc2072 pkt_hdr_tlv;
+	u8 msdu_payload[];
+};
+
 struct hal_rx_desc {
 	union {
 		struct hal_rx_desc_qcn9274_compact qcn9274_compact;
 		struct hal_rx_desc_wcn7850 wcn7850;
+		struct hal_rx_desc_qcc2072 qcc2072;
 	} u;
 } __packed;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
index c3093c01af87..88f51a3828aa 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.c
@@ -614,7 +614,7 @@ void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_da
 	rx_desc_data->err_bitmap = ath12k_hal_rx_h_mpdu_err_wcn7850(rx_desc);
 }
 
-static int ath12k_hal_srng_create_config_wcn7850(struct ath12k_hal *hal)
+int ath12k_hal_srng_create_config_wcn7850(struct ath12k_hal *hal)
 {
 	struct hal_srng_config *s;
 
diff --git a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
index 46047fd6a312..a56ca9fd3de4 100644
--- a/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
+++ b/drivers/net/wireless/ath/ath12k/wifi7/hal_wcn7850.h
@@ -36,4 +36,5 @@ void ath12k_hal_rx_desc_get_dot11_hdr_wcn7850(struct hal_rx_desc *desc,
 void ath12k_hal_extract_rx_desc_data_wcn7850(struct hal_rx_desc_data *rx_desc_data,
 					     struct hal_rx_desc *rx_desc,
 					     struct hal_rx_desc *ldesc);
+int ath12k_hal_srng_create_config_wcn7850(struct ath12k_hal *hal);
 #endif

-- 
2.25.1


