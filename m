Return-Path: <linux-wireless+bounces-19481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA98A45D32
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 12:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 288B57A6026
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 11:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A402118D622;
	Wed, 26 Feb 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="osZXZ8oa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1BB215171
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569496; cv=none; b=WABD9DRnvZUkK5IRnp/yy+FAVxlz7wpRime/ad1d4ZchkZRK9cjZ5zWjw7hN3Unh+11CBiDJk+1mjbrtKldedFtImgDjleQxsejOfokW6M2UwcQtODg/vqUvnsgtMohGdEmy2lM/EZeB4nvHQc2n3Z/ihEjTj59adii1QycIH94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569496; c=relaxed/simple;
	bh=XK0+NXIiIEaYH4u6xTQtHo/fyOEVN+eHsZcL1mCDSrs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c2i3z5KRWYnhXvoUBlw9eVMYT2SHGYDBuvZOBdbByqaY5Qc1Q0cTqX5RAOZ6ax4tFZW9JldybfrMNSEWL4LzJ9dPwHJJtBrbs6llNWg9I0kWFee6Imd0yNFNlGYNgC1XHph1NhlEXRb2uJDuSMhQpQ6CkzevXlBtssxm+/UIreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=osZXZ8oa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QAxSpu002104;
	Wed, 26 Feb 2025 11:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4jayubKMT7OfdwXuym9RzI
	ryglZnRB1ZIpcAbGkWZ0w=; b=osZXZ8oao0MKAAiRGuwn6mcNP1HXyoh636+bZZ
	Zm/xzOM9XfHZQ7qwvDouUhiZsAP5frhE9E4JbghXtI2wKOVEXCsahBR6xfCEmgLG
	72J0XP4eZAbowo2kgj+gySSMmafAm8X5CDud01i98745nT8Csqvl6AN/YzC0LCbn
	rXCc/+iQygEq8TStVKjQkgEyxI9ttwhUbMwkFMRZQ5rFcr+FunDRYVv8b0MxBgSF
	JSiubQBGLebSpi6y/KPVfSGltRK5roYqh7cnIwXPkFVw1cX0R2SXcOx9KfKJB90f
	SSiZVLCznYVbL4HBV5fWXjO6nscWsj/Xgv8xPvDvAtNkPFXg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4521ph82nj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:31:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51QBVUhL023541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 11:31:30 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Feb 2025 03:31:28 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH ath-next v2] wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion
Date: Wed, 26 Feb 2025 19:31:18 +0800
Message-ID: <20250226113118.7626-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: 9wgbGwOPqpEIWiIolDB14SvQS0dds2_w
X-Proofpoint-ORIG-GUID: 9wgbGwOPqpEIWiIolDB14SvQS0dds2_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260092

Currently, when ath12k performs the remove link interface operation, if
there is an ongoing scan operation on the arvif, ath12k may execute the
remove link interface operation multiple times on the same arvif. This
occurs because, during the remove link operation, if a scan operation is
present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
from the firmware. Upon receiving this event, ath12k will continue to
execute the ath12k_scan_vdev_clean_work() function, performing the remove
link interface operation on the same arvif again.

To address this issue, before executing the remove link interface
operation, ath12k needs to check if there is an ongoing scan operation on
the current arvif. If such an operation exists, it should be aborted.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
---
1.rebase to ath-next

 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3e3afdc56fc9..551133483f44 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9578,6 +9578,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	if (ahvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
+
+	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
+		ath12k_scan_abort(ar);
+		ar->scan.arvif = NULL;
+	}
 }
 
 static int

base-commit: e180a01bf2c4a67db13d70d2d91410a8c6f74be3
-- 
2.34.1


