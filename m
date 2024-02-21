Return-Path: <linux-wireless+bounces-3834-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFEA85CE7D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 04:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C55B1C2305D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 03:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29B38DE0;
	Wed, 21 Feb 2024 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dosOMGOg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C92B9CE;
	Wed, 21 Feb 2024 03:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484452; cv=none; b=tI7oUUyCT/s5E02pVVfjDgHtAN1rD/4mc0BsI/9q4ckccztIoe7NwHc481DmA54ykptd+8tUV1OADJ1vhuqfdQhlggY/JA/kOVTZy4O83sg/p5m43RotGjg9ma2lUBPy91qFrox674PcA5FWCDl2XXHC1C2Kqd3Tu1yQxPUBvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484452; c=relaxed/simple;
	bh=blJQ/GKePx+uk14gC4hirA2g8TcAe2wqrTDC9aAhOpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5PhsKDG1vGwVRou1UAJkd5/Gg7a6zN19kmv2Op/D7uE//zjPRPKeqsmoVLNOGDtYylcPdB80/YymBAYno4N1SGpunVS9UxpXUzwpUUQJt+ZVh9qb/K1ejMS5in+NtTSRlJqhZ/wb2dsBozIf6nsauBY9lrmf0HN1NdxCW0uTL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dosOMGOg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41L2Msrn019903;
	Wed, 21 Feb 2024 03:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=5YihgDE2Mb3w93ocdB00u8Cf3jEOU9nmNoCyUw6QMTU=; b=do
	sOMGOg6swc0Ka/BrNE4UD2bElOMvSheWmVxtplBkzclnfM1K2vb8m+B7vqe+TAXY
	SPEn1ibpPEiGYoAIULti4OWP/E4mk4YqTbb7KhD1wybatkJgvYwMLwyPGw9GaIIi
	YhPGbhGfHFtLJy2yWZN/Ome1tDZNrUjOEOviNPyxPagQJD9reaRfkFt7nMY9HUIY
	JQPntLtsALnUjggUE6BmP/ItENKp74dVf3wiO2lmEqA6+KF1RecTgF3TMbFYIxpQ
	0hBn74q5kpsNuuj+vWQtSKCXyBT2VOSyVEHbswJtCkiKFoR6/xaMttME8pUCb9y+
	fzdyhN29JSBgiJLNUM+w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wd21ursuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:00:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41L30lXX017467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 03:00:47 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 19:00:44 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <mhi@lists.linux.dev>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH 2/3] net: qrtr: support suspend/hibernation
Date: Wed, 21 Feb 2024 11:00:25 +0800
Message-ID: <20240221030026.10553-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221030026.10553-1-quic_bqiang@quicinc.com>
References: <20240221030026.10553-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: sEWiADHkXhUkU7R6hfSbgZK1TtyKKGui
X-Proofpoint-ORIG-GUID: sEWiADHkXhUkU7R6hfSbgZK1TtyKKGui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402210020

MHI devices may not be destroyed during suspend/hibernation, so need
to unprepare/prepare MHI channels throughout the transition.

The RFC version adds new API to MHI stack with which an MHI controller
driver can do unprepare/prepare directly by itself, see

https://patchwork.kernel.org/project/linux-wireless/patch/20231127162022.518834-3-kvalo@kernel.org/

Although it works well Mani pointed out that the design is not good
because MHI channels are managed by MHI client driver thus should not
be touched by others. See the discussion

https://lore.kernel.org/mhi/20231127162022.518834-1-kvalo@kernel.org/

This version changes to add suspend/resume callbacks to achieve the
same purpose. The suspend callback is called in the late suspend stage,
this means MHI channels are still alive at suspend stage, and that makes
it possible for an MHI controller driver to communicate with others over
those channels at suspend stage. While the resume callback is called in
the early resume stage, for a similar reason.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 net/qrtr/mhi.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 9ced13c0627a..b54a6c2113e9 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -118,6 +118,32 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
 };
 MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
 
+static int qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
+{
+	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
+
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	return 0;
+}
+
+static int qcom_mhi_qrtr_pm_resume_early(struct device *dev)
+{
+	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
+	int rc;
+
+	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
+	if (rc)
+		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
+
+	return rc;
+}
+
+static const struct dev_pm_ops __maybe_unused qcom_mhi_qrtr_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
+				     qcom_mhi_qrtr_pm_resume_early)
+};
+
 static struct mhi_driver qcom_mhi_qrtr_driver = {
 	.probe = qcom_mhi_qrtr_probe,
 	.remove = qcom_mhi_qrtr_remove,
@@ -126,6 +152,9 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
 	.id_table = qcom_mhi_qrtr_id_table,
 	.driver = {
 		.name = "qcom_mhi_qrtr",
+#ifdef CONFIG_PM
+		.pm = &qcom_mhi_qrtr_pm_ops,
+#endif
 	},
 };
 
-- 
2.25.1


