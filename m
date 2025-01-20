Return-Path: <linux-wireless+bounces-17746-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E05F0A169F0
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D993169DAA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53B81DED60;
	Mon, 20 Jan 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pNKbb7bb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F51B0F0B;
	Mon, 20 Jan 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366542; cv=none; b=ukjqN/KkEoWmyvekWfjVcUeikiiMH606qMdjAF97OqdsQACYr7GJCoA5tFmD8OZpnCH/PXy9Dx39AifoAsqB6728SnCB+U3tkKUCaOGXu0jy0bYEfXbPeRtPgqF2AXxLV+/HkWv+RDQ6PMx1PWAuSNOHaVfP16+acvoqcRVi4uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366542; c=relaxed/simple;
	bh=x91T47JCD9kUEfsZtBD0gMONiIaK3ZFLzxYUoRAmzhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=m5Zf3Ri9M9ElMS/67aBx+TUhTMwKa2PPXezbTEs2zfshEbPJdVdel04mnLJy6/Z2ILzomKIMGTJRKMgJiW5nuPYTdtBVOHpabtEHqivx3SO6IBhzcxP2/QDO9RX2RhPKjMl3ycBpArPO0lgzPvfM/H6F83uZj2cPInRUkP+CKOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pNKbb7bb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K7HoiM011766;
	Mon, 20 Jan 2025 09:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PiVP4ZNR1jPHjTXytk+PgMSUIfF/Zxg2VHl5D4U+cgU=; b=pNKbb7bb9WjpcKWC
	iybCbt7H98rWSnBOOQr/mZ1B+Z4CgOl8gQDhr8tD5t9oGmfb+oQ3QerHUtGzSH/b
	1UyZuwvra10fA39K3zMaiogj261AZg7n6N07gFtUMPo+bamSMJfZBvj7lbz5p0LC
	6DolWtpLTlBo1kqL9GgVdBUMpBIay251WX7tuDrPCi8omA8/t0Cj8+nBQ5BtDm4J
	tA6KecdqsKCNI4qD3B4xvM43RBNXOvre+0mDniI4CjqyrUeGncUVVfJCY3dq3vHj
	qpF7ZCABNFBsEERnDGAdXTXQRx2Y9n5VYwi4Uc2Ip0BUKbRBjqS0pUUIAocAdvDe
	m8hHqg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449hykrbwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K9mfHk005391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:41 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 Jan 2025 01:48:38 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Mon, 20 Jan 2025 15:18:22 +0530
Subject: [PATCH v2 02/10] wifi: ath12k: add reference counting for core
 attachment to hardware group
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250120-fix_reboot_issues_with_hw_grouping-v2-2-b7d073bb2a22@quicinc.com>
References: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
In-Reply-To: <20250120-fix_reboot_issues_with_hw_grouping-v2-0-b7d073bb2a22@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem
	<quic_hprem@quicinc.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Kalle Valo
	<quic_kvalo@quicinc.com>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Aditya Kumar
 Singh" <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: X_u0jeJwTWvOmfgh24gogG9RQKa-zY0o
X-Proofpoint-ORIG-GUID: X_u0jeJwTWvOmfgh24gogG9RQKa-zY0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501200081

Currently, driver does not manage reference counting for attaching and
detaching cores to/from hardware groups. This can lead to issues when
multiple cores are involved. Or with same core, attach/detach is called
multiple times back to back.

Fix this issue by using reference counting.

With that, it is now ensured that the core is properly attached or detached
from the hardware group and even back to back calls will not alter the
count.

Additionally, add some debug logs during the attachment and detachment
events for better debugging and tracking.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 47 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath12k/core.h | 15 +----------
 2 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1959c59cb2bb18aeec215b9d309468b7c6716752..05a914a3f8555236deeab89729d02527e7b4d786 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -603,9 +603,49 @@ u32 ath12k_core_get_max_num_tids(struct ath12k_base *ab)
 	return TARGET_NUM_TIDS(SINGLE);
 }
 
+static inline
+void ath12k_core_to_group_ref_get(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (ab->hw_group_ref) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "core already attached to group %d\n",
+			   ag->id);
+		return;
+	}
+
+	ab->hw_group_ref = true;
+	ag->num_started++;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "core attached to group %d, num_started %d\n",
+		   ag->id, ag->num_started);
+}
+
+static inline
+void ath12k_core_to_group_ref_put(struct ath12k_base *ab)
+{
+	struct ath12k_hw_group *ag = ab->ag;
+
+	lockdep_assert_held(&ag->mutex);
+
+	if (!ab->hw_group_ref) {
+		ath12k_dbg(ab, ATH12K_DBG_BOOT, "core already de-attached from group %d\n",
+			   ag->id);
+		return;
+	}
+
+	ab->hw_group_ref = false;
+	ag->num_started--;
+
+	ath12k_dbg(ab, ATH12K_DBG_BOOT, "core de-attached from group %d, num_started %d\n",
+		   ag->id, ag->num_started);
+}
+
 static void ath12k_core_stop(struct ath12k_base *ab)
 {
-	ath12k_core_stopped(ab);
+	ath12k_core_to_group_ref_put(ab);
 
 	if (!test_bit(ATH12K_FLAG_CRASH_FLUSH, &ab->dev_flags))
 		ath12k_qmi_firmware_stop(ab);
@@ -841,9 +881,8 @@ static int ath12k_core_start(struct ath12k_base *ab,
 		/* ACPI is optional so continue in case of an error */
 		ath12k_dbg(ab, ATH12K_DBG_BOOT, "acpi failed: %d\n", ret);
 
-	if (!test_bit(ATH12K_FLAG_RECOVERY, &ab->dev_flags))
-		/* Indicate the core start in the appropriate group */
-		ath12k_core_started(ab);
+	/* Indicate the core start in the appropriate group */
+	ath12k_core_to_group_ref_get(ab);
 
 	return 0;
 
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index ee595794a7aee83a7695fb57d6b8e2e74eabf3aa..e20551a8838622dfaaff8943915b0a251d5b4e86 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -1052,6 +1052,7 @@ struct ath12k_base {
 
 	struct ath12k_hw_group *ag;
 	struct ath12k_wsi_info wsi_info;
+	bool hw_group_ref;
 
 	/* must be last */
 	u8 drv_priv[] __aligned(sizeof(void *));
@@ -1210,20 +1211,6 @@ static inline struct ath12k_hw_group *ath12k_ab_to_ag(struct ath12k_base *ab)
 	return ab->ag;
 }
 
-static inline void ath12k_core_started(struct ath12k_base *ab)
-{
-	lockdep_assert_held(&ab->ag->mutex);
-
-	ab->ag->num_started++;
-}
-
-static inline void ath12k_core_stopped(struct ath12k_base *ab)
-{
-	lockdep_assert_held(&ab->ag->mutex);
-
-	ab->ag->num_started--;
-}
-
 static inline struct ath12k_base *ath12k_ag_to_ab(struct ath12k_hw_group *ag,
 						  u8 device_id)
 {

-- 
2.34.1


