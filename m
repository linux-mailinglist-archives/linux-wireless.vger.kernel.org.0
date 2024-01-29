Return-Path: <linux-wireless+bounces-2647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A9283FEC4
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 07:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8441C1F232E2
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8324D11F;
	Mon, 29 Jan 2024 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IULoioPD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4214D11A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706511499; cv=none; b=NbL0o4dspDoa1P9kQcf2iXcmg+eKft7VFpRaqe8AlnqwnXJIgX13w/YRnQWr4MgUyi9RGhjbjB5JXy1o9e+5DBZMPCQBFWIFrpd/y+60nE2Q9Zkp9y9o/2rYebiY0ommiodTwiGBNVtL+F7auzb8i3SNAw8VYXqZEKKDuprC0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706511499; c=relaxed/simple;
	bh=u0OkD12eXTzENfgHWMAMtQochv1JZlANKUo2VZrcS9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=br7WK5dwy3twUvTdoYRMX62MRBLO4zKNX/nPomsH5pIIBv89dgG0tseiJS9PBlDZCzkM902YJFTRb23bTzxrh295QSCE3xsNGSQVW6nq4f+glr7JOG8Fkl05YNjcCuDigEw49Rozp7xgfKy4C0+FbGVg1pjTSDsvazX9IODMnr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IULoioPD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T577IH014247;
	Mon, 29 Jan 2024 06:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=qTMEaWmX/U3rUd8hdIRVgh2/6qnl5C9mDVtiumC2UmA=; b=IU
	LoioPDyxgRfSALndYFEWJgFfiFgNoSQnzcaR+1NLdKI8tb8Hs+tPths2VhWM/2SX
	yQ2Bsbiq9CXGe02T96+nfS7HayYrTua4LaC8FSGSrnsJ+SJ/RwtfKGEnF3mgBZlL
	AqcOUoKjsWC//KFcxcl8gmFs/cOYkbppA2EHWdSrk1zPhW01CaVSeY9Kd8iGpdXh
	ZKopiYbXR2Ku5O4rF9P7Er4/y7xc5JP0OgvGQnQVLqqrffCX14B53XYAbvVaW+in
	TBJNZd78xGQ9f2t/rLgDPYDZmqEwDU7YrQAVC0kRUzXYCQgjS9AWwty2IRImNCrb
	+5vpRB1e4YsHPJ9Rde0Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx275gf8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:14 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40T6wDvY025404
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 06:58:13 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 28 Jan 2024 22:58:11 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH v3 13/13] wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274
Date: Mon, 29 Jan 2024 12:27:24 +0530
Message-ID: <20240129065724.2310207-14-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
References: <20240129065724.2310207-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ToDCnDQFrYozc0SA3UX38Tm3NJW4urcU
X-Proofpoint-GUID: ToDCnDQFrYozc0SA3UX38Tm3NJW4urcU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_03,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290049

QMI PHY capability learn is used to get PHY count information to
support single/multi link operation (SLO/MLO) configuration. The
QCN9274 dualmac firmware currently do not support SLO/MLO, if two
PHYs are within the same chip. Due to this firmware crashes in
split-phy QCN9274, while bringing up AP with MLO parameter enabled
in QMI host capability request message.

The QMI PHY capability learn is not required for split-phy QCN9274,
if SLO/MLO is not supported within the same chip. Hence, disable QMI
PHY capability learn support in split-phy QCN9274.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 1 +
 drivers/net/wireless/ath/ath12k/core.h | 5 +++++
 drivers/net/wireless/ath/ath12k/mhi.c  | 1 +
 drivers/net/wireless/ath/ath12k/qmi.c  | 3 +++
 4 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index ca3777c684b3..0d4640ff8d6f 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1218,6 +1218,7 @@ struct ath12k_base *ath12k_core_alloc(struct device *dev, size_t priv_size,
 	ab->dev = dev;
 	ab->hif.bus = bus;
 	ab->qmi.num_radios = U8_MAX;
+	ab->slo_capable = true;
 
 	return ab;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index f0a319ea57c1..a984171e4a08 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -842,6 +842,11 @@ struct ath12k_base {
 
 	const struct hal_rx_ops *hal_rx_ops;
 
+	/* slo_capable denotes if the single/multi link operation
+	 * is supported within the same chip (SoC).
+	 */
+	bool slo_capable;
+
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index 50b9e44504f7..adb8c3ec1950 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -385,6 +385,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 				   "failed to read board id\n");
 		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
 			dualmac = true;
+			ab->slo_capable = false;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "dualmac fw selected for board id: %x\n", board_id);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 0f0eaadc8418..92845ffff44a 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2124,6 +2124,9 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	struct qmi_txn txn;
 	int ret;
 
+	if (!ab->slo_capable)
+		goto out;
+
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_phy_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
-- 
2.34.1


