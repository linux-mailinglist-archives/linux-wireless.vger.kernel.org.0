Return-Path: <linux-wireless+bounces-21833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9377A964C2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA24189AE96
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2997A18E3F;
	Tue, 22 Apr 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="coXIRiOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362D8BEA
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315019; cv=none; b=d3N2/qRqHuLeUy9aYGs5ReA+h8zhuwY/ILsj0lsjR9Hf4QwS5frqNQxymWWj0KaC0aCgdGEL3VjtNvfprvrXnuIYLwBUN7h4SjmaLaVzQmQevKYwdzQvnQgBLShxio2j5x+xgalQBphpoeLoZWrIEq3AOTyK18BzBypPqUz8mso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315019; c=relaxed/simple;
	bh=c9QnEAZeP83K+es4UR3MeXYS4WLNtubuEY5Um5LHywM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a8DTdlFcWKd9FAaMe34SwyOusp6A7uwHfMQjCuIH5n3L4Yj9u0+qZZWz5/JrlLzNpG7T13M/Jj66f8unT4td2sGdN02/o/J+/N93hTsLjUwMJUFPt2L98rTQeb8DQcbFCsnuRfSP3+HTbPefwI3ae25jdELEY9MXM5RUgjZ4ylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=coXIRiOI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M4P2jx006342
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=a0aCPzESRmOL
	FCZSZqW4C1Bz5aMHm1PCkm2+Jj0kpro=; b=coXIRiOIuG2XzFtF5m8Sc2iUQ0zn
	NGppuBJ/gwEq+p/us/hOG5Ywzo48UysAxOXIb2S5B81sToNd14QvMkJPmEHQaia0
	LFFEeAD8TQLGa9ErQeFmavFv79oOj5vGtNb6APowxM//yqU2i7POSvqfDBmHAgaZ
	VD2KNWdO0HTsM0wXNlSvWSlu1CbydVK8q5zWH3XUFuuMM9oAnasOCpiY39NlSTJZ
	wZgtLW2PfcvYaVeT5MYCHI0kOtQeVM0ok8lZIsAK5k46KR2RWHpsbg/A9edejZkh
	cfH8es6LihWtEYJlzKgck01mmlRF3QFgKIJmrHxmXlI1XXxMHWgafXsNPg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46435jeyux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:43:35 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-73917303082so3476872b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 02:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315014; x=1745919814;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0aCPzESRmOLFCZSZqW4C1Bz5aMHm1PCkm2+Jj0kpro=;
        b=Yo1gfIrgMfgKAyI38VW/lxSyegvSB2jw9OoupSTuMEZvFieWWe4CiyBDqsGb7898/V
         9WT4anVfHqTcSL1nCMJNUiuCbO0ft00hNwYdSRu/yTQPcrihaIM/75fMMJIoL71ifPGL
         CH+BEg5wSxilvAA5Ul+cCgL/62ALbvF1Rl4RfD7QHGhd4srdsR7pN5fnM8t/DnaEVH34
         zRYX+H9B69Ko8DuUM21uqso1mapWht2YR9l7ddhtyIFVHfV6MjSErmsBJOhrYu9jRyG1
         qv8nWFwiIczDRobO5HOgjxvpPeC4EhKxSjvUfcmeeIMZrzdqLSuhFfTZ8n9AHpunrvuc
         crFg==
X-Gm-Message-State: AOJu0YyJdScejJRH0E6of4y7a47l9JsAgT7K27ZJmjiAkK8rZ+F/Q9qX
	Y0Zj22nUmj1MVOKBkGwZucDhlHIV2ybzWZ9rT8Sjdvf9rpEDqj6K43m6cUuNbiLo2rzN3SRtUgf
	TO1bHcuUE8+thrXdzk3JcV3ZZv8Y8QU3tnuH+EEDMLVvqHcERsu6azZk7mIoyIXGlJg==
X-Gm-Gg: ASbGncvHibuitHynjE3q/nP2f9GIoVgjj1ho06/P/Zr7Hv45UqL4belAY2ztLA40VFL
	9TEpSVXmOjBCunqv93R4MrPbzXT22ehEUA9exCBMZxryGGSg36Du69/XebQoCqv1gnds1is+Tu5
	IaJs1AJCzIdQ6KA3XcN6M4PgdIXUhSCdOuw7F1ny8JbA31RC0JhQd+h9UJZo28lbBx8EEXFvkLC
	9VnK75MZ8sb73PuaH5YT729aKRPxUyZS7EYtr6tZrZSdJFvACi5zK19dX+IOUOV+QGAFPPAnK8q
	uKsU3rFOy88tpoEjH+hAOYQJOVY1qBUsyncYddvicqm2DOTT9DqHXiWifpY6v1XpsE7yHx2qpD8
	JOAwSCpALb0aGKgmY/+BF4K3D2zqSzvHFYfJfEMicLmCcWA==
X-Received: by 2002:a05:6a00:98e:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73dc144c7aamr23123356b3a.3.1745315014342;
        Tue, 22 Apr 2025 02:43:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEan9zA+8EjugL8KIBuwmnjvji6NNTShHfGQ9LH/OIZR2Y1iL5cxa0Jyk6oLHrP2hF/h1A6hQ==
X-Received: by 2002:a05:6a00:98e:b0:736:5c8e:bab8 with SMTP id d2e1a72fcca58-73dc144c7aamr23123330b3a.3.1745315013837;
        Tue, 22 Apr 2025 02:43:33 -0700 (PDT)
Received: from hu-nithp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58376sm8432243b3a.100.2025.04.22.02.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:43:33 -0700 (PDT)
From: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>,
        Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: Enable AST index based address search in Station Mode
Date: Tue, 22 Apr 2025 15:12:55 +0530
Message-Id: <20250422094255.131226-1-nithyanantham.paramasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=EOYG00ZC c=1 sm=1 tr=0 ts=680764c7 cx=c_pps a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=g-AHoWTylar1N0jkHzsA:9 a=zc0IvFSfCIW2DFIPzwfm:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OGIvztSJdiaK7DWwFX_aTpNZfNHzSC7H
X-Proofpoint-ORIG-GUID: OGIvztSJdiaK7DWwFX_aTpNZfNHzSC7H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220073
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

From: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>

Currently, TCL performs the TX address search for each entry during
transmission, which may lead to packet delays.

To mitigate this issue, enable AST index-based address search during
transmission in station mode. This AST index-based search is not
enabled in AP mode due to the complexity involved in fetching peer
information.

Implement changes to retrieve the offset of ast_idx/ast_hash values
from the PEER_MAP3 event, update the vdev search type to ADDRX, and
enable AST lookup in the bank configuration.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Signed-off-by: Nithyanantham Paramasivam <nithyanantham.paramasivam@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp.c    | 10 +++++-----
 drivers/net/wireless/ath/ath12k/dp.h    |  2 ++
 drivers/net/wireless/ath/ath12k/dp_rx.c |  6 +++++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index ad873013e46c..0291fbea6312 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -354,7 +354,10 @@ u32 ath12k_dp_tx_get_vdev_bank_config(struct ath12k_base *ab,
 			u32_encode_bits(0, HAL_TX_BANK_CONFIG_EPD);
 
 	/* only valid if idx_lookup_override is not set in tcl_data_cmd */
-	bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
+	if (ahvif->vdev_type == WMI_VDEV_TYPE_STA)
+		bank_config |= u32_encode_bits(1, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
+	else
+		bank_config |= u32_encode_bits(0, HAL_TX_BANK_CONFIG_INDEX_LOOKUP_EN);
 
 	bank_config |= u32_encode_bits(arvif->hal_addr_search_flags & HAL_TX_ADDRX_EN,
 					HAL_TX_BANK_CONFIG_ADDRX_EN) |
@@ -1107,11 +1110,8 @@ static void ath12k_dp_update_vdev_search(struct ath12k_link_vif *arvif)
 {
 	switch (arvif->ahvif->vdev_type) {
 	case WMI_VDEV_TYPE_STA:
-		/* TODO: Verify the search type and flags since ast hash
-		 * is not part of peer mapv3
-		 */
 		arvif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
-		arvif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
+		arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
 		break;
 	case WMI_VDEV_TYPE_AP:
 	case WMI_VDEV_TYPE_IBSS:
diff --git a/drivers/net/wireless/ath/ath12k/dp.h b/drivers/net/wireless/ath/ath12k/dp.h
index 706d766d8c81..e3923ff02dbd 100644
--- a/drivers/net/wireless/ath/ath12k/dp.h
+++ b/drivers/net/wireless/ath/ath12k/dp.h
@@ -1330,6 +1330,8 @@ struct htt_t2h_version_conf_msg {
 #define HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16	GENMASK(15, 0)
 #define HTT_T2H_PEER_MAP_INFO1_HW_PEER_ID	GENMASK(31, 16)
 #define HTT_T2H_PEER_MAP_INFO2_AST_HASH_VAL	GENMASK(15, 0)
+#define HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID	GENMASK(15, 0)
+#define HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL	GENMASK(31, 16)
 #define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_M	BIT(16)
 #define HTT_T2H_PEER_MAP_INFO2_NEXT_HOP_S	16
 
diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index 1abfbd15f13c..f83e34db83c0 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -1802,8 +1802,12 @@ void ath12k_dp_htt_htc_t2h_msg_handler(struct ath12k_base *ab,
 					     HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16);
 		ath12k_dp_get_mac_addr(le32_to_cpu(resp->peer_map_ev.mac_addr_l32),
 				       peer_mac_h16, mac_addr);
+		ast_hash = le32_get_bits(resp->peer_map_ev.info2,
+					 HTT_T2H_PEER_MAP3_INFO2_AST_HASH_VAL);
+		hw_peer_id = le32_get_bits(resp->peer_map_ev.info2,
+					   HTT_T2H_PEER_MAP3_INFO2_HW_PEER_ID);
 		ath12k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash,
-				      peer_id);
+				      hw_peer_id);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:

base-commit: d33705bb41ff786b537f8ed50a187a474db111c1
-- 
2.17.1


