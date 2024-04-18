Return-Path: <linux-wireless+bounces-6526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F48A9A76
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 14:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01382282D55
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19680143C4A;
	Thu, 18 Apr 2024 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HnVaEOiC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E748594D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Apr 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713444999; cv=none; b=u/z1U5aR/1qTlly1lqA80e7suyFNKFBJFTkNLnjHfVExJSDAZojpSfdrrVBzbquFWxYXhYcAecVWQ5ID9LkbSA1DFgd62FNqsWSRerlUPcOY/47mSTuFA5N8D4wohwixga/Un7vbxtd+W8vdsDqagpYkof3JU8Uh9aawIFvX+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713444999; c=relaxed/simple;
	bh=1JdF2zuDU7fZavf2kxMNJza+/n0JdzOVvPGqTZDwcGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSCsEekm3Uv22PPHMbiypKf3K5Pv6NnLUKlsNQEWl0TRht9CDZpzU6At6v34ZJS8L7zVyC0DB+KQuUoaWK5ZQUkYwLXqNCfxhFjHK/mvlCqVRz75a5EnngIbtHMMRlvDaIg4SZ7/KAolrG3yqxhGk/Kx8n7/8ZE5pta8ap65Yc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HnVaEOiC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43ICGNeJ017589;
	Thu, 18 Apr 2024 12:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=+JXAacMTMQaCuQzTPyfwtP75RKbMKWC6TA3Y06Alg20=; b=Hn
	VaEOiCQXj2GKUu/nleFB9Ib8v2+CCfJdDAiJi6xMBkHN0x/+r/98QrjnXMcKyQHC
	gu1xTflmI+2fKfTH4Um7+h/cE70Jmdl/EYsKkTmIc5OFdm4NILvVjkr3i/2fdL1n
	3AcdE82G9P+hBBuHOMiSSxmMTaKMeHrRXjEhIo6GVHe5mj4//hvbkp26BHEjarLK
	BA6bPT+6UqF53OMTPts3FVxZLvXRpIDbGYyMPLvaF2z9GZU299xUIA3RhVABARDp
	6+Aih+wUtgesDZsTQRfqNSgCYjKloGRxpslip/NaBISeXCxIEkr69KSmtxebG29+
	PKkPHqBDpbyCJkldt11w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xk3chg2k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 12:56:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43ICuW8s019442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Apr 2024 12:56:32 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 05:56:30 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Raj Kumar Bhagat
	<quic_rajkbhag@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: set mlo_capable_flags based on QMI PHY capability
Date: Thu, 18 Apr 2024 18:26:09 +0530
Message-ID: <20240418125609.3867730-3-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
References: <20240418125609.3867730-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4coWxWJUt3_4Fzyx4KVrP5_lCJYtWPvQ
X-Proofpoint-GUID: 4coWxWJUt3_4Fzyx4KVrP5_lCJYtWPvQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_11,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404180091

Currently, mlo_capable_flags is set to zero if dualmac device is
detected based on One Time Programmable (OTP) register value.
This is not generic and in future dualmac devices may support
Single Link Operation (SLO) and Multi Link Operation (MLO).

Thus, set mlo_capable_flags based on 'single_chip_mlo_support'
parameter from QMI PHY capability response message from the firmware.
Also, add check on mlo_capable_flags to disable MLO parameter in the
host capability QMI request message.

If the firmware does not respond with this optional parameter
'single_chip_mlo_support' in QMI PHY capability response, default
ab->mlo_capable_flags is used.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00209-QCAHKSWPL_SILICONZ-1

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mhi.c |  1 -
 drivers/net/wireless/ath/ath12k/qmi.c | 16 +++++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index fd519c87ae24..50b9e44504f7 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -385,7 +385,6 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 				   "failed to read board id\n");
 		} else if (board_id & OTP_VALID_DUALMAC_BOARD_ID_MASK) {
 			dualmac = true;
-			ab->mlo_capable_flags = 0;
 			ath12k_dbg(ab, ATH12K_DBG_BOOT,
 				   "dualmac fw selected for board id: %x\n", board_id);
 		}
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index a555839dae8e..a286715f98fb 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -2023,6 +2023,12 @@ static void ath12k_host_cap_parse_mlo(struct ath12k_base *ab,
 	u8 hw_link_id = 0;
 	int i;
 
+	if (!(ab->mlo_capable_flags & ATH12K_INTRA_DEVICE_MLO_SUPPORT)) {
+		ath12k_dbg(ab, ATH12K_DBG_QMI,
+			   "intra device MLO is disabled hence skip QMI MLO cap");
+		return;
+	}
+
 	if (!ab->qmi.num_radios || ab->qmi.num_radios == U8_MAX) {
 		ab->mlo_capable_flags = 0;
 
@@ -2144,9 +2150,6 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 	struct qmi_txn txn;
 	int ret;
 
-	if (!ab->mlo_capable_flags)
-		goto out;
-
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_phy_cap_resp_msg_v01_ei, &resp);
 	if (ret < 0)
@@ -2171,6 +2174,13 @@ static void ath12k_qmi_phy_cap_send(struct ath12k_base *ab)
 		goto out;
 	}
 
+	if (resp.single_chip_mlo_support_valid) {
+		if (resp.single_chip_mlo_support)
+			ab->mlo_capable_flags |= ATH12K_INTRA_DEVICE_MLO_SUPPORT;
+		else
+			ab->mlo_capable_flags &= ~ATH12K_INTRA_DEVICE_MLO_SUPPORT;
+	}
+
 	if (!resp.num_phy_valid) {
 		ret = -ENODATA;
 		goto out;
-- 
2.34.1


