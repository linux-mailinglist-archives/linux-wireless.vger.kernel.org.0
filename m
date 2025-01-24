Return-Path: <linux-wireless+bounces-17899-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38FA1B2BD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 10:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2F9D165E4C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 09:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832E219A67;
	Fri, 24 Jan 2025 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UL1V9eth"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA1219A75
	for <linux-wireless@vger.kernel.org>; Fri, 24 Jan 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737711280; cv=none; b=Tdz5VLPYEfIGckduGmgiotuJlRyeK68KCKCcFqd6njVFdjzO8mLvDURWMf8ppS6VTdnQknCiAzLQI68IBCHRxEvvydR7if39zGcsLPYJzfWalyTX4y1hRYztuMvO5JkewzmGZqz570/Ga8Lq8QhTHC6gYEnlSbUuWIjMvrEIQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737711280; c=relaxed/simple;
	bh=i77I2NUqp78aLho2w526OfK5XYNo8hBMz4AKJAIbxRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hQJGSaB8St/sePDnK0fLNbsbXoXWTkrpdp3fzv5U8KGVJfPZ4p2mSAxyP02dGpuA7p/9rjb7oXYsOastIDb0exnCcebbq6rxXDJUNkvY/WLEYL6rhLEu+T33RR8aG0GS2qJbXqjjVQd8lHb/McrUQUGfC1suklCP7H8RTPxXdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UL1V9eth; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O6lRxW027809;
	Fri, 24 Jan 2025 09:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=gt2pOZ57xswNedZ7vIhU/k
	b8DQrJZE/z0BM6k0VstjQ=; b=UL1V9ethfjwFjruXZhMPSrNrh9dObjTDlPtg2n
	7bIUs9/WwSy2cYvOgORPYqRtiA7/vJjCDJXE+Low5hcLO9cigRBlY/+OKcfMapGS
	rSYiOXgcvbgfbBnPrsoYCgGFWjOVIx/+TVq2x8vtBDUF8yV52+ARIWBYCkxzLEoM
	F5+ZkY4XQCsGKC0A+WuUnzwfvAgFAOKnOljDhbLdZU9hYtbMydTrmZYSmrzk23Ol
	bzJ11nuqKv+4hTdeHwzeHXFmeskbH7q2Wbk4BeAx6lq3FOSls/U1mUa0Rv7dtGVn
	uty8u/PWK3anxx/gFVOT0Xw8YSk8GI2hJxFu+9EDDLdtbKww==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c5wfgeh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:34:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O9YX1l011863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 09:34:33 GMT
Received: from lingbok.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 Jan 2025 01:34:31 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH] wifi: ath12k: Abort scan before removing link interface to prevent duplicate deletion
Date: Fri, 24 Jan 2025 17:33:52 +0800
Message-ID: <20250124093352.481-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.45.2.windows.1
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
X-Proofpoint-GUID: UXbCyJNDXAurKMYb7ez3omNv1s268Ifm
X-Proofpoint-ORIG-GUID: UXbCyJNDXAurKMYb7ez3omNv1s268Ifm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_03,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=969 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240068

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
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 329c05003721..cdce88787182 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9333,6 +9333,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
 		ath12k_mac_monitor_stop(ar);
 
+	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
+		ath12k_scan_abort(ar);
+		ar->scan.arvif = NULL;
+	}
+
 	ath12k_mac_remove_link_interface(hw, arvif);
 	ath12k_mac_unassign_link_vif(arvif);
 }

base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
-- 
2.34.1


