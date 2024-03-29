Return-Path: <linux-wireless+bounces-5512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AD891052
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFA328A5FC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 01:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD2117BA1;
	Fri, 29 Mar 2024 01:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K4s8Ov/H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B774017999
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711675464; cv=none; b=NF98kmDJNmQfgVw1Brr+bDXkqHp8ctL7dYntUk4GL0lFsrQ/2zh62jbZeXohXsu0DlWhXae03K9/fK6MLDokoudLUd4+ypT7kqEf0Ubwwx6O1OJgHzuYOv872+XE7D4y5gzSyk5cA2k2u3gIDlaTR3XwNCtjI5QKSiAaKRJV8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711675464; c=relaxed/simple;
	bh=soMerkKGzomlkOW46wUCL2NANOGTARQHCRceLKUtCVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YnjG7PLIN+bTfbK6CAgGHcUewaLCW5ESYLw03ZjBkH1pV2MSPpTruUw5yCXHxuOsPjwf6EWiqEDdptyb5LhOFFPrVZdZkezSi92ZZ2LeTFFZdBGevwS2TPdo4VK024cTiUF7/PWB1UKRDQaVViFuuM6WjKvGoORMQnSILn3PvUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K4s8Ov/H; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T0rBOJ030878;
	Fri, 29 Mar 2024 01:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Pi5ww7+WD4OmNvmkI5frgTdZ6myXRGM0QbzptSuUL0U=; b=K4
	s8Ov/HXuXXdTCAnVLaB47FGniyKypcD06DWwrQNbNmk3tagOJIsvgMdiLey7fgdY
	6OxnTSmRYd4D9Yl9PFqBhTDAznqw5zufoP+vN6h9dPXFOUcQmVXb+s5/KJjoLPJ4
	R94U7h3tJkLkshheHW697Iy9OpAIy7crwcBoFJ6I+u4+771/zFv363XehroWBoHl
	0jFKPOFGCnxTbqFg9cQxNTG5aUDmbVKx8pWWP6WYerJkkdHkbcdajEh4UDRJ6vhp
	JorKRXpHPrCDapDsNVLFodEVgCBOscjkwOlaV6pzhdelXVwfFqZzamet3iyjethl
	lnHh47JeO0IisMCoIX0Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x54r62kfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:24:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T1OFkM011784
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:24:15 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 18:24:13 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: extend the link capable flag
Date: Fri, 29 Mar 2024 06:53:57 +0530
Message-ID: <20240329012358.2242354-2-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
References: <20240329012358.2242354-1-quic_periyasa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fUHohISSCmnWWHzeAgoluv35R1haa9ed
X-Proofpoint-ORIG-GUID: fUHohISSCmnWWHzeAgoluv35R1haa9ed
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_19,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 mlxlogscore=909
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290010

Link capability categorized as Single Link Operation (SLO) and Multi Link
Operation (MLO).

	* Intra-chip SLO/MLO refers to links present within a chip
	* Inter-chip SLO/MLO refers to links present across multiple chips

Currently, driver uses a boolean variable to represent intra-chip SLO/MLO
capability. To accommodate inter-chip SLO/MLO capabilities within the same
variable, modify the existing variable name and type. Define a new
enumeration for the link capabilities to accommodate both intra-chip and
inter-chip scenarios. Populate the enum based on the supported
capabilities.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c |  2 +-
 drivers/net/wireless/ath/ath12k/core.h | 23 ++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/mhi.c  |  2 +-
 drivers/net/wireless/ath/ath12k/qmi.c  |  2 +-
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 391b6fb2bd42..231bdcd4b415 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1227,7 +1227,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->dev = dev;
 	ab->hif.bus = bus;
 	ab->qmi.num_radios = U8_MAX;
-	ab->slo_capable = true;
+	ab->mlo_capable_flags = ATH12k_INTRA_CHIP_MLO_SUPPORT;
 
 	return ab;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 97e5a0ccd233..ef58f6b07b79 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -688,6 +688,21 @@ struct ath12k_soc_dp_stats {
 	struct ath12k_soc_dp_tx_err_stats tx_err;
 };
 
+/**
+ * enum ath12k_link_capable_flags - link capable flags
+ *
+ * Single/Multi link capability information
+ *
+ * @ATH12k_INTRA_CHIP_MLO_SUPPORT: SLO/MLO form between the radio, where all
+ *	the radio present within a chip.
+ * @ATH12k_INTER_CHIP_MLO_SUPPORT: SLO_MLO form between the radio, where all
+ *	the radio present across the chips
+ */
+enum ath12k_link_capable_flags {
+	ATH12k_INTRA_CHIP_MLO_SUPPORT	= BIT(0),
+	ATH12k_INTER_CHIP_MLO_SUPPORT	= BIT(1),
+};
+
 /* Master structure to hold the hw data which may be used in core module */
 struct ath12k_base {
 	enum ath12k_hw_rev hw_rev;
@@ -843,10 +858,12 @@ struct ath12k_base {
 
 	const struct hal_rx_ops *hal_rx_ops;
 
-	/* slo_capable denotes if the single/multi link operation
-	 * is supported within the same chip (SoC).
+	/* mlo_capable_flags denotes the single/multi link operation
+	 * capabilities of the chip (SoC).
+	 *
+	 * See enum ath12k_link_capable_flags
 	 */
-	bool slo_capable;
+	u8 mlo_capable_flags;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index adb8c3ec1950..fd519c87ae24 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -385,7 +385,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 				   "failed to read board id\n");
 		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
 			dualmac = true;
-			ab->slo_capable = false;
+			ab->mlo_capable_flags = 0;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "dualmac fw selected for board id: %x\n", board_id);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 92845ffff44a..3f0d2b99127a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2124,7 +2124,7 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	struct qmi_txn txn;
 	int ret;
 
-	if (!ab->slo_capable)
+	if (!ab->mlo_capable_flags)
 		goto out;
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
-- 
2.34.1


