Return-Path: <linux-wireless+bounces-17748-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C51A169F4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2DF1881B24
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C191DED4B;
	Mon, 20 Jan 2025 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pJVjrfVJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA541B3956;
	Mon, 20 Jan 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366547; cv=none; b=aajl9HJo1L/Ek87MJ5AbNCT4XBberYVeslit4Oc0glI82azIfZl9dgYnOYfog//2dxy49uOXHheYm68s0OK1cqh3ZW0khggzlRJvWOugbBXU8PaCOOxEch3VjQthGtVtlPV8X7sJw+Ar7c6vnhVxyz2xjgDRNwpDS9OiICbNvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366547; c=relaxed/simple;
	bh=b1ktlJdvZMn+0iAproiWNfS4X/QaQxzHbttR+HOht4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bGCIPiMeflUM0YsZm8i5Fw6lpwoMsaYR4QcdmiZdZwJuhkEEHgbB9EjIdEbJAjD+NELfK1aFN5obYie0kQtaVsn2BGtFuOQV9tWRdx1a3+F7f6GbJO9KCFCfV/Eo/UagQPIcH4woavT91jVmTrjWtFwhE8htagDw5a6sWiyqPIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pJVjrfVJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9S689014772;
	Mon, 20 Jan 2025 09:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XTR2fVXhW9PYJNzKpulitLbceGSHbNTT+f0aFa0qX+4=; b=pJVjrfVJ3efTT5Lo
	JSvryBLhB15+/0Al2DOhXfa8zzIsHi4J0qO5W3fZBj5G142aYDSlMHTbAaUleyR2
	xi+r3D7lj60oP0KVQxekikzAILCqQuT8+2G+0rr2Se7K7FEHUcX6F+MjQYm35I5a
	El6SqHENA7IK/rSvZOrYkejQV00ZXi5fB3ugTEQt1sJI6TNG3rRpfwRumfpNUHYW
	1gaHZQDuYEOtVgLeNPbap6s2PqIiwZbcF9FjCn9dEWL3ewOLZkvPjAlQwA3rkPZp
	oUeyEMtWXDdPA4JoSIzlGok+Pcr7hIKM3sReMGd/JQMUcSRrOJEEwU8Zr8IgKXwm
	HPOriw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449kvh81mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:49:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K9n1vZ007871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:49:01 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 Jan 2025 01:48:58 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Mon, 20 Jan 2025 15:18:28 +0530
Subject: [PATCH v2 08/10] wifi: ath12k: handle ath12k_core_restart() with
 hardware grouping
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250120-fix_reboot_issues_with_hw_grouping-v2-8-b7d073bb2a22@quicinc.com>
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
X-Proofpoint-GUID: AJzOWqrrs4GvM0m9XdCcJjTWnm4yWO43
X-Proofpoint-ORIG-GUID: AJzOWqrrs4GvM0m9XdCcJjTWnm4yWO43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200081

Currently, when ath12k_core_restart() is called and the ab->is_reset flag
is set, it invokes ieee80211_restart_hw() for all hardware in the same
group. However, other hardware might still be in the recovery process,
making this call inappropriate with grouping into picture.

To address this, add a condition to check if the group is ready. If the
group is not ready, do not call ieee80211_restart_hw().

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index f645f1fb24dcb3f0aabc537cd9ac08e6d4bef95b..aedb42a0ea85da705d213ae33871af1b5afbe21a 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1398,12 +1398,22 @@ static void ath12k_core_restart(struct work_struct *work)
 			ath12k_dbg(ab, ATH12K_DBG_BOOT, "reset success\n");
 		}
 
+		mutex_lock(&ag->mutex);
+
+		if (!ath12k_core_hw_group_start_ready(ag)) {
+			mutex_unlock(&ag->mutex);
+			goto exit_restart;
+		}
+
 		for (i = 0; i < ag->num_hw; i++) {
-			ah = ath12k_ag_to_ah(ab->ag, i);
+			ah = ath12k_ag_to_ah(ag, i);
 			ieee80211_restart_hw(ah->hw);
 		}
+
+		mutex_unlock(&ag->mutex);
 	}
 
+exit_restart:
 	complete(&ab->restart_completed);
 }
 

-- 
2.34.1


