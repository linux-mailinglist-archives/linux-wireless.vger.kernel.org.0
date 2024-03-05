Return-Path: <linux-wireless+bounces-4363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DF087136A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 03:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4C61C22688
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Mar 2024 02:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B80182C3;
	Tue,  5 Mar 2024 02:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hox+wroz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5551865C;
	Tue,  5 Mar 2024 02:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709604836; cv=none; b=u/qgoG40HsjvpNzkjlTUevivbx+IJwnvTe/rdWl6aoR4j+xOkb7q3HjSul1DYdS1+doQR62ILtF/1oF+cek5Pj71uSzas0nTAnMoelm1ixf6mZFbP4sZ6tvdqLXGDcOjDVzLWFQcjenTskq+x/csaS0MfunE9Zqryper0EFLXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709604836; c=relaxed/simple;
	bh=t80sR6N/xwfdjsOwMpA6O2kcCMln/a0guetcPaclZRs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l433OKhKTRhMWbyqGsG7E2ZmWzeDa11NmY6hE981Q7C2IgdRXZl291RecAF3Pfrxk6VHs+kjTasZEP4GJik8xPv3zfJJgebT+Gpiia23OclHvd6bkAXFxBwNLfy2HGURXsl6R1WkbNH4m9fU0a8j0JXXZ7Zypt+prtkFHgodqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hox+wroz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4251QBPe014428;
	Tue, 5 Mar 2024 02:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=QOYGXwqQOfhJ8AIwuFXsBqbfOCUwZ3NNLP39K/+EpSI=; b=ho
	x+wrozFTYQnOtAmUnMy9t+fzGuIC/IkTZhYFz+tYEf2Cf0t9MclX5sH05EZwQxIl
	HStiCkWftucwry+HZyopg0kpHWxev7QCZVlmbvBuAAUHpShwBBxMEkaoyAP01JcV
	zdkOMJV1f9PWo28vSgsdCAwFQW8fclL0n7yVdjzCnlIar1kgndHfDr5a2k7yKNAk
	ALXJ+SkzFIMxXputuSzofS2B45U2vhhjicv81mWs90gLP8+DjPU9y4dp+j1TA94f
	cbUmCsftGAdK4CB3karJwjMay5Ig8Jg6YunuU0uFF+dxWqd9jEIuwqw7hBpiqoyB
	vzn2vuRuQ2XZAAwf0KuQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnjtbgy7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 02:13:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4252DcUp013234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 02:13:38 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 18:13:35 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>
CC: <linux-wireless@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_bqiang@quicinc.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: [PATCH v7 2/3] net: qrtr: support suspend/hibernation
Date: Tue, 5 Mar 2024 10:13:19 +0800
Message-ID: <20240305021320.3367-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240305021320.3367-1-quic_bqiang@quicinc.com>
References: <20240305021320.3367-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: umV8tnm7Td2rIVyCR6P_yQRs-RAj-yKc
X-Proofpoint-ORIG-GUID: umV8tnm7Td2rIVyCR6P_yQRs-RAj-yKc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_20,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050015

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


