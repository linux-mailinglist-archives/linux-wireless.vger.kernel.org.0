Return-Path: <linux-wireless+bounces-4331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8D86F9E1
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 07:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02781C20C7E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Mar 2024 06:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EAEDDD2;
	Mon,  4 Mar 2024 06:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pnSxbS+d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F40BE7F;
	Mon,  4 Mar 2024 06:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709532604; cv=none; b=AJZVepBozsQHN8PYPjgaR2K+Id/a0r+WAYqp0m01ojHpAO44R1yMV9r3RhrF4dab907aRFbZyPBfpSLWdt78GN8K+NPekUv9/vp9M4HnxbQXJRx/TFPwbzp6S76x165FBTm44qD4oTLRvZTGTg2k1ubaWODzaFheZffqh5OILNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709532604; c=relaxed/simple;
	bh=t80sR6N/xwfdjsOwMpA6O2kcCMln/a0guetcPaclZRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcWLZG+bl6Agv6ZKDchi0HQn8/hW1Z53SLTZnRBjbgZN5EFBhpUPYd6VNuUE8ugjrU8i/tKcznpDJmSF10s5oKqOTR4ijdGS1jDltPDhYUF8SFcScyHzn/To9xgBFPvMuKVll1SBplBflR3Rwdy6svKj8yVez9ELLX6JnZ6MfUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pnSxbS+d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4245mxba025353;
	Mon, 4 Mar 2024 06:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=QOYGXwqQOfhJ8AIwuFXsBqbfOCUwZ3NNLP39K/+EpSI=; b=pn
	SxbS+dqmc6rY3m5d+H2i/6IWZmQd+yf3+y9wATPz9Yz39Zg26xVYbbwvoInuHuQO
	hJwR+RFmiRq+WnQFJP0l70A3dobgCBTUxHvyE/eutkjQoRpypnVrt5LWc0NIiYpC
	HBqGLiOtKVgKBUCoa0eqjT/TpJ97EeqYgeogRo7fA1jf4gTIOf7jDoPEiLJQKvUb
	wwZ6PCGfLDQ3fBPDqIEa+amnRXJt/3Og/hGr56btNchb4I1Y5uhiCRQaY5LKNLU8
	j3lgpJmCFyLEl9RjtOjpuTxjaWxcJd7alZJPZba89gl1Asio/rcphsR7Mkl//2Tu
	c3J4uSkReu5JpRM1Ztvg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn8fxr118-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 06:09:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42469pTX018758
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 06:09:51 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Mar 2024 22:09:48 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_bqiang@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: [PATCH v6 2/3] net: qrtr: support suspend/hibernation
Date: Mon, 4 Mar 2024 14:09:31 +0800
Message-ID: <20240304060932.80839-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240304060932.80839-1-quic_bqiang@quicinc.com>
References: <20240304060932.80839-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: KdVzC4gYKg9zBt4d5nPwSKNDMWUhYoS1
X-Proofpoint-ORIG-GUID: KdVzC4gYKg9zBt4d5nPwSKNDMWUhYoS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040044

MHI devices may not be destroyed during suspend/hibernation, so need
to unprepare/prepare MHI channels throughout the transition, this is
done by adding suspend/resume callbacks.

The suspend callback is called in the late suspend stage, this means
MHI channels are still alive at suspend stage, and that makes it
possible for an MHI controller driver to communicate with others over
those channels at suspend stage. While the resume callback is called
in the early resume stage, for a similar reason.

Also note that we won't do unprepare/prepare when MHI device is in
suspend state because it's pointless if MHI is only meant to go through
a suspend/resume transition, instead of a complete power cycle.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 net/qrtr/mhi.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/net/qrtr/mhi.c b/net/qrtr/mhi.c
index 9ced13c0627a..69f53625a049 100644
--- a/net/qrtr/mhi.c
+++ b/net/qrtr/mhi.c
@@ -118,6 +118,51 @@ static const struct mhi_device_id qcom_mhi_qrtr_id_table[] = {
 };
 MODULE_DEVICE_TABLE(mhi, qcom_mhi_qrtr_id_table);
 
+static int __maybe_unused qcom_mhi_qrtr_pm_suspend_late(struct device *dev)
+{
+	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
+	enum mhi_state state;
+
+	state = mhi_get_mhi_state(mhi_dev->mhi_cntrl);
+	/*
+	 * If the device is in suspend state, then no need for the
+	 * client driver to unprepare the channels.
+	 */
+	if (state == MHI_STATE_M3)
+		return 0;
+
+	mhi_unprepare_from_transfer(mhi_dev);
+
+	return 0;
+}
+
+static int __maybe_unused qcom_mhi_qrtr_pm_resume_early(struct device *dev)
+{
+	struct mhi_device *mhi_dev = container_of(dev, struct mhi_device, dev);
+	enum mhi_state state;
+	int rc;
+
+	state = mhi_get_mhi_state(mhi_dev->mhi_cntrl);
+	/*
+	 * If the device is in suspend state, we won't unprepare channels
+	 * in suspend callback, therefore no need to prepare channels when
+	 * resume.
+	 */
+	if (state == MHI_STATE_M3)
+		return 0;
+
+	rc = mhi_prepare_for_transfer_autoqueue(mhi_dev);
+	if (rc)
+		dev_err(dev, "failed to prepare for autoqueue transfer %d\n", rc);
+
+	return rc;
+}
+
+static const struct dev_pm_ops qcom_mhi_qrtr_pm_ops = {
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(qcom_mhi_qrtr_pm_suspend_late,
+				     qcom_mhi_qrtr_pm_resume_early)
+};
+
 static struct mhi_driver qcom_mhi_qrtr_driver = {
 	.probe = qcom_mhi_qrtr_probe,
 	.remove = qcom_mhi_qrtr_remove,
@@ -126,6 +171,7 @@ static struct mhi_driver qcom_mhi_qrtr_driver = {
 	.id_table = qcom_mhi_qrtr_id_table,
 	.driver = {
 		.name = "qcom_mhi_qrtr",
+		.pm = &qcom_mhi_qrtr_pm_ops,
 	},
 };
 
-- 
2.25.1


