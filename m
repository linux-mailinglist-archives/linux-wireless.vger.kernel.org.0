Return-Path: <linux-wireless+bounces-18611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A2A2BA78
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 06:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F6F1889557
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 05:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163B23236A;
	Fri,  7 Feb 2025 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VFPtiMWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB6346BF
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738904641; cv=none; b=kGx5chxLgNhJrJYlH8GK508Oi0zzXensHg8T7YPXvs7QFK6+ekFfWpLRUeYuiMj9nScDaHtBichMkwm0sBrRHCh1t35QHJFtpz8JnsQmxOvpxmUbWNbaSW0gsNDRrPuWTQMXoKJ2qzY3dI6CRYpz4Quvm8yvfu4dcPeGRkdx51U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738904641; c=relaxed/simple;
	bh=XWk3qVXJXdLkEDIdRMgcocnvaM4JtOz709IcSQG7IoE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iRqPynFLjLk+mTP6A/8KqipfcA9TmgyAg89tAG03koCq+jpePDU1mnSats0kh00ihwMuy0wlpvIqxueY38vVcbpe/amT4DFX3oGBZ7spx9udSBWCrnTVv1dVJytZ7YfVdrLzYP1ExvxR0WQ26l9ZtWLNqi7deaKM+QR/IwSb1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VFPtiMWL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5174Kr2s008031;
	Fri, 7 Feb 2025 05:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDN4nme6ngpxWE157lMhY+GOCpOxVx5S9CBzghi/Fnk=; b=VFPtiMWLMkzNLZjB
	DArHmijyP1picSeOibTBlKG3WlnSX7J6OlePaOhYB+moCAV9cdg5MMl0ZuIB/bkA
	LV1Of0ObD9deLWp2VgcMrKOlWkVn7dKR4jxeD96aUO+HRsiFI+9sa2w5xN2hh7dd
	Umjp3cfUc/dSHxVfTtTk0iJdjSOPy3c30yvu9Z4aikB9G3JbX9N8nYrOtO3bvOGl
	Ctq0G2K0p4Gu/c28wxm0a5zvefywrUJLK8SXZTn6JRFJhnRrQSGQfv4m6Mdh1mAX
	Vj/69kcA+Ik9Shkgewsa7p9OLomeb2N0kitOjyMfgR+5p+tmYgUcfLef/RK3OxST
	S6MRPw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44nb2m82vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 05:03:50 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51753nel009539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 05:03:49 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Feb 2025 21:03:47 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH 1/3] wifi: ath12k: Enable MLO setup ready and teardown commands for single split-phy device
Date: Fri, 7 Feb 2025 10:33:25 +0530
Message-ID: <20250207050327.360987-2-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
References: <20250207050327.360987-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nSHU_xfla4whhBed15vJPe9IvQO7YYuJ
X-Proofpoint-ORIG-GUID: nSHU_xfla4whhBed15vJPe9IvQO7YYuJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_02,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=947
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502070038

When multi-link operation(MLO) is enabled through follow-up patches in
the single split-phy device, the firmware expects hardware links
(hw_links) information from the driver.

If driver does not send WMI multi-link setup and ready command to the
firmware during MLO setup for single split-phy device, the firmware will
be unaware of the hw_links component of the multi-link operation. This may
lead to firmware assert during multi-link association.

Therefore, enable WMI setup, ready and teardown commands for single
split-phy PCI device.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 33 +++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/core.h |  1 +
 drivers/net/wireless/ath/ath12k/mac.c  |  9 +++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 323bd5082a7d..e46444c64096 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -897,10 +897,41 @@ static void ath12k_core_hw_group_stop(struct ath12k_hw_group *ag)
 	ath12k_mac_destroy(ag);
 }
 
+u8 ath12k_get_num_partner_link(struct ath12k *ar)
+{
+	struct ath12k_base *partner_ab, *ab = ar->ab;
+	struct ath12k_hw_group *ag = ab->ag;
+	struct ath12k_pdev *pdev;
+	u8 num_link = 0;
+	int i, j;
+
+	lockdep_assert_held(&ag->mutex);
+
+	for (i = 0; i < ag->num_devices; i++) {
+		partner_ab = ag->ab[i];
+
+		for (j = 0; j < partner_ab->num_radios; j++) {
+			pdev = &partner_ab->pdevs[j];
+
+			/* Avoid the self link */
+			if (ar == pdev->ar)
+				continue;
+
+			num_link++;
+		}
+	}
+
+	return num_link;
+}
+
 static int __ath12k_mac_mlo_ready(struct ath12k *ar)
 {
+	u8 num_link = ath12k_get_num_partner_link(ar);
 	int ret;
 
+	if (num_link == 0)
+		return 0;
+
 	ret = ath12k_wmi_mlo_ready(ar);
 	if (ret) {
 		ath12k_err(ar->ab, "MLO ready failed for pdev %d: %d\n",
@@ -942,7 +973,7 @@ static int ath12k_core_mlo_setup(struct ath12k_hw_group *ag)
 {
 	int ret, i;
 
-	if (!ag->mlo_capable || ag->num_devices == 1)
+	if (!ag->mlo_capable)
 		return 0;
 
 	ret = ath12k_mac_mlo_setup(ag);
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 57e71ccbbb67..a247ba525038 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1204,6 +1204,7 @@ int ath12k_core_resume(struct ath12k_base *ab);
 int ath12k_core_suspend(struct ath12k_base *ab);
 int ath12k_core_suspend_late(struct ath12k_base *ab);
 void ath12k_core_hw_group_unassign(struct ath12k_base *ab);
+u8 ath12k_get_num_partner_link(struct ath12k *ar);
 
 const struct firmware *ath12k_core_firmware_request(struct ath12k_base *ab,
 						    const char *filename);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 16e6f2fae943..eb59895d5c22 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -11279,6 +11279,9 @@ static int __ath12k_mac_mlo_setup(struct ath12k *ar)
 		}
 	}
 
+	if (num_link == 0)
+		return 0;
+
 	mlo.group_id = cpu_to_le32(ag->id);
 	mlo.partner_link_id = partner_link_id;
 	mlo.num_partner_links = num_link;
@@ -11308,10 +11311,16 @@ static int __ath12k_mac_mlo_teardown(struct ath12k *ar)
 {
 	struct ath12k_base *ab = ar->ab;
 	int ret;
+	u8 num_link;
 
 	if (test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
 		return 0;
 
+	num_link = ath12k_get_num_partner_link(ar);
+
+	if (num_link == 0)
+		return 0;
+
 	ret = ath12k_wmi_mlo_teardown(ar);
 	if (ret) {
 		ath12k_warn(ab, "failed to send MLO teardown WMI command for pdev %d: %d\n",
-- 
2.34.1


