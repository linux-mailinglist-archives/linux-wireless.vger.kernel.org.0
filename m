Return-Path: <linux-wireless+bounces-8240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 730CD8D2A21
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 03:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C671F260FA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 01:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAA113E40C;
	Wed, 29 May 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QoajoswW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336CD28F3
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947663; cv=none; b=hSDuJOATsWT1T5us55/AZ986lyIyW2yL+1h712136XnO4NO4ezAH3nGJJnZXq4UnCrxr6QNlmVSZvO74Y2sdo9+PZKcvROuwX0EsMb3YoUDmiVqB4zXv/3TRmKqOGUVBLRmubNjWqy+afwb/BmypeG7OQgymirVVSSrbPEa9MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947663; c=relaxed/simple;
	bh=mUOckbvQIkW966ZVHWvINQBJc1uN7YoDYq5KdGRYwoM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AgzeKOE/6y8dZFC6E1Mir9AtoLfmWfs1TAOwBFwd6TTtbKUAyvVKxfzNuWKtIeBStkbEitdeVlX4V7reJ3W8DQl/otOQvhhTCDL5Tp0ULTz9KYXF16e4dDmaWlb+s5M75gpaCMeFo7TnGPC9wh5Ekfs2qRwFPp/ryCf0QKnPmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QoajoswW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44SLZoiI017358;
	Wed, 29 May 2024 01:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=w43RXtj0fskVD1BKrCnAzh
	v3jEu4k3N/sLt4ARq8x0E=; b=QoajoswWOF/oEX5XWjARNuuywDT3V9v3/IcUVc
	sCJ++tV5KlRY+sZriDGLBGNPc/VgWDpx2pVwWhmWzBNZnMjQ6A6iIjDbtTueAKgL
	RzLhybuQm6CmDFyNbAylfEWMAEV6wAMoyh93KhaD110+8dmvjGs7TWpMpSgxP0ct
	X1HAhEFk1sgKCb6MSjiiHEIO0UfGjMhzzuo/MjxANneoUH5PA4Zl+C3nFnhQA+Rr
	aQwExEcfbnjzfDxxHz+PHJ7b7aqqX6/XMyrBlO8f36g5OLXQIOqmK0naPmfrYKUf
	x1QoIpdoYh3IZtQN5cftfltHIaTJ5AMKCO9dSBo64l91Kt6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0pqnba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 01:54:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44T1sENs024047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 01:54:14 GMT
Received: from bqiang-Celadon-RN.lan (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 May 2024 18:54:13 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: do not process consecutive RDDM event
Date: Wed, 29 May 2024 09:53:57 +0800
Message-ID: <20240529015357.9846-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-ORIG-GUID: 7-vOt_44nEetHkYe-HBpyOj-re-xZthC
X-Proofpoint-GUID: 7-vOt_44nEetHkYe-HBpyOj-re-xZthC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405290010

Currently we do reset for each RDDM event from MHI, however there are
cases, see below log, that we get two or more consecutive events, and
it is pointless to do reset for the subsequent ones. What's more, it
makes reset process more likely to fail.

[  103.289864] mhi mhi0: System error detected
[  103.289871] ath12k_pci 0000:03:00.0: mhi notify status reason MHI_CB_EE_RDDM
[  103.293144] mhi mhi0: System error detected
[  103.293150] ath12k_pci 0000:03:00.0: mhi notify status reason MHI_CB_EE_RDDM

Add a check to avoid reset again and again. This is done by tracking previous
MHI status: if we receive a new RDDM event while the previous event is
also the same, we treat it as duplicate and ignore it, because normally
we should at least receive a MHI_CB_EE_MISSION_MODE event between them.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mhi.c | 11 +++++++++++
 drivers/net/wireless/ath/ath12k/pci.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.c b/drivers/net/wireless/ath/ath12k/mhi.c
index fef2f7622033..df96b0f91f54 100644
--- a/drivers/net/wireless/ath/ath12k/mhi.c
+++ b/drivers/net/wireless/ath/ath12k/mhi.c
@@ -16,6 +16,7 @@
 #define MHI_TIMEOUT_DEFAULT_MS	90000
 #define OTP_INVALID_BOARD_ID	0xFFFF
 #define OTP_VALID_DUALMAC_BOARD_ID_MASK		0x1000
+#define MHI_CB_INVALID	0xff
 
 static const struct mhi_channel_config ath12k_mhi_channels_qcn9274[] = {
 	{
@@ -268,6 +269,7 @@ static void ath12k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 				    enum mhi_callback cb)
 {
 	struct ath12k_base *ab = dev_get_drvdata(mhi_cntrl->cntrl_dev);
+	struct ath12k_pci *ab_pci = ath12k_pci_priv(ab);
 
 	ath12k_dbg(ab, ATH12K_DBG_BOOT, "mhi notify status reason %s\n",
 		   ath12k_mhi_op_callback_to_str(cb));
@@ -277,12 +279,20 @@ static void ath12k_mhi_op_status_cb(struct mhi_controller *mhi_cntrl,
 		ath12k_warn(ab, "firmware crashed: MHI_CB_SYS_ERROR\n");
 		break;
 	case MHI_CB_EE_RDDM:
+		if (ab_pci->mhi_pre_cb == MHI_CB_EE_RDDM) {
+			ath12k_dbg(ab, ATH12K_DBG_BOOT,
+				   "do not queue again for consecutive RDDM event\n");
+			break;
+		}
+
 		if (!(test_bit(ATH12K_FLAG_UNREGISTERING, &ab->dev_flags)))
 			queue_work(ab->workqueue_aux, &ab->reset_work);
 		break;
 	default:
 		break;
 	}
+
+	ab_pci->mhi_pre_cb = cb;
 }
 
 static int ath12k_mhi_op_read_reg(struct mhi_controller *mhi_cntrl,
@@ -313,6 +323,7 @@ int ath12k_mhi_register(struct ath12k_pci *ab_pci)
 	if (!mhi_ctrl)
 		return -ENOMEM;
 
+	ab_pci->mhi_pre_cb = MHI_CB_INVALID;
 	ab_pci->mhi_ctrl = mhi_ctrl;
 	mhi_ctrl->cntrl_dev = ab->dev;
 	mhi_ctrl->regs = ab->mem;
diff --git a/drivers/net/wireless/ath/ath12k/pci.h b/drivers/net/wireless/ath/ath12k/pci.h
index 6186a78038cf..31584a7ad80e 100644
--- a/drivers/net/wireless/ath/ath12k/pci.h
+++ b/drivers/net/wireless/ath/ath12k/pci.h
@@ -104,6 +104,7 @@ struct ath12k_pci {
 	struct mhi_controller *mhi_ctrl;
 	const struct ath12k_msi_config *msi_config;
 	unsigned long mhi_state;
+	enum mhi_callback mhi_pre_cb;
 	u32 register_window;
 
 	/* protects register_window above */

base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
-- 
2.25.1


