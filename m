Return-Path: <linux-wireless+bounces-8359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 531268D68A9
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 20:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FDC528A29A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 18:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BFF17C7D4;
	Fri, 31 May 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cakhUnmS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4497817CA1A
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 18:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717178674; cv=none; b=cZCk4MttO8lf1EgSS/aKSD11AK9O4SI/mIG3DH1d8iOOVfuhR2YQY8E9QzZVXDrwPtiNEOr/jzaYyUWpwfHClE9gp/R/2K4zcViOmRBrL8SG7kY0ZUHItPIX39t+RlmVANEEC2Iis+M5l8V8/sNCMJoCtFyYBuqlW1DCXhneCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717178674; c=relaxed/simple;
	bh=S5MgTxyTRa2iDO3ZAxSpCrgMn1GmhYLNNlhaB774oj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uESdgyhM3zCWyO3UDaDm3cc9GY9wrMwikDxOpUkYcE2EXyBFzjjKZj5SL86Au/K8+zpuffjPFzpUpeyYcuxETlnrZaDr/IJ7PyHDM9mnuGoez3ebr22n3XbZqHYa8ItAOlyLgxpOhmW4Brq4F2Ac9/nY6g5C9rxLAlwQzKBuPiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cakhUnmS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V9HSfc022220;
	Fri, 31 May 2024 18:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GRsw07B02sP
	83VG6NMbhByVIv0ijDEmm8NqLsJehJEQ=; b=cakhUnmSD5VOAETYKrlTGfx80Wx
	SikB9g70gzDwdcwdipoUVp/K+dbdmJunLkhAyBwqxz8AOtVvhkWppupHmsEm4gij
	WuuhYNIL3qiBZDqjUGFWJqv4SqFkw+/CjM6hE+R5Re9h2ARHrwSzrT2J5x2AFcO3
	JuW0NsWhDm/QQgFeoA/WMSm64qpKCZITzJn9dbIsPVHp8Cs1ABDtU6GzHcFODOTj
	CDIULDCO6NE1LnwhUGzEK+zDV70Hx1qijY+FwC8tSwxrsc15EKKGuVnIzpvmXArM
	IZhUeK5Co87skMibYiboIX0lttEy92DzXM4e9nF/eEvrML6YP/rIhVTxR5Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjg0x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44VI4FgV012029;
	Fri, 31 May 2024 18:04:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3yf34nn90m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:17 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44VI4Hut012078;
	Fri, 31 May 2024 18:04:17 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44VI4HsA012077
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 18:04:17 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id 0F6D041174; Fri, 31 May 2024 23:34:17 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v8 5/8] wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
Date: Fri, 31 May 2024 23:34:08 +0530
Message-Id: <20240531180411.1149605-6-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531180411.1149605-1-quic_hprem@quicinc.com>
References: <20240531180411.1149605-1-quic_hprem@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: h_2d6ZBtooIRR6z8TJPJuqYoRKf2nx9Z
X-Proofpoint-ORIG-GUID: h_2d6ZBtooIRR6z8TJPJuqYoRKf2nx9Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310137

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

When hardware device group abstraction is introduced, in future, a group
abstraction is registered to mac80211 rather than a particular device.
Hence, setting ATH12K_FLAG_REGISTERED in QMI firmware ready event might not
be ideal.

Add changes to move set/unset of ATH12K_FLAG_REGISTERED flag inside
ath12k_mac_register() and ath12k_mac_unregister() respectively.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 2 ++
 drivers/net/wireless/ath/ath12k/qmi.c | 4 +---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 66587c5ea8fd..4ab9846f154c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9165,6 +9165,7 @@ int ath12k_mac_register(struct ath12k_base *ab)
 			goto err;
 	}
 
+	set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 	return 0;
 
 err:
@@ -9184,6 +9185,7 @@ void ath12k_mac_unregister(struct ath12k_base *ab)
 	struct ath12k_hw *ah;
 	int i;
 
+	clear_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
 	for (i = ath12k_get_num_hw(ab) - 1; i >= 0; i--) {
 		ah = ath12k_ab_to_ah(ab, i);
 		if (!ah)
diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 23cd21a3fa97..c570b17fe150 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -3333,11 +3333,9 @@ static void ath12k_qmi_driver_event_work(struct work_struct *work)
 				  &ab->dev_flags);
 			clear_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags);
 			ret = ath12k_core_qmi_firmware_ready(ab);
-			if (!ret) {
+			if (!ret)
 				set_bit(ATH12K_FLAG_QMI_FW_READY_COMPLETE,
 					&ab->dev_flags);
-				set_bit(ATH12K_FLAG_REGISTERED, &ab->dev_flags);
-			}
 
 			break;
 		default:
-- 
2.34.1


