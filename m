Return-Path: <linux-wireless+bounces-17218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6E4A06CF7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 05:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 217C93A4B79
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2025 04:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B8C18FDC9;
	Thu,  9 Jan 2025 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="opF205J3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B656D1946BC;
	Thu,  9 Jan 2025 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736396768; cv=none; b=Tp1yAHF6A2DJkBLnnULLnvHxSCEnEdvtRBjQsf9hd7fkiuqtBFA8y5WCSL3WESXLZVGe/yysxehkdhkoWEHCRknTnldLn3kGQmuTiT8ZdL3j9Jrr3iYFy7psfETi1mpOfktVIAEFHQGKJh9fHWEX8tc8SfRA8SecS+Y3Zh2VPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736396768; c=relaxed/simple;
	bh=bLAdmkwEDX6MWDZQTRBuSaG1if2oX0n/XEPsphW3b+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=R92kywR0TrZbF2dxWgupNmIhlrndo3tIlk6AnT3KOkq1tNQhb3n4nzq0m6NLAihe75I/mCRC6SJ4Vckwa2/SclvyQTzmPHR1mTVkkGRhwYzCdFoDAJry+yucasONF3ZwIKOtbKjuiAvVrivdcPrLvCQKzE5TSenOS7eg2fN7HQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=opF205J3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508HMXHH014713;
	Thu, 9 Jan 2025 04:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UY6X7nkp8jWjFm8K8tGQImgrpWXRnTm+7Dq63GDIDeI=; b=opF205J3LGSNqE/8
	dQ5YwCDK/eNDPUowQvxlgNON6nPSjkvpMr4mUPEHA0lDthOaxl9MWDUdxsKEl2x5
	nE3d8okWgdbpXKvUDsoAdsPi6dCOk7sYY6qTykcVVHCn1CIoOaeS4+eiI41zHnbJ
	wEzLsPZhKfRazIdWk2t8dd/5ZJOWEu/AnBU6mdSzDiyRs04fj3MG7KOkOW145HVD
	Id9IUsveh1A+keGGwtt8e2SJPGtuCvg+to/v00S4d2iJal5dI/dFA8PCllYS5RzU
	3t3GBMQX4KrcMEpAIjaWqAGcczUd6WdneadEd3xzocKmnLSFtCAcIUG71Jnf8Ky0
	PdhuJA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441wq51bex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 04:26:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5094Q0Mf028629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 Jan 2025 04:26:00 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 20:25:57 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Thu, 9 Jan 2025 09:55:34 +0530
Subject: [PATCH 06/10] wifi: ath12k: fix
 ath12k_core_pre_reconfigure_recovery() with grouping
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250109-fix_reboot_issues_with_hw_grouping-v1-6-fb39ec03451e@quicinc.com>
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
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
X-Proofpoint-GUID: oA7SBU3TTHazBUZYRWlrm0-t5qIq9gN0
X-Proofpoint-ORIG-GUID: oA7SBU3TTHazBUZYRWlrm0-t5qIq9gN0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090033

Currently, ath12k_core_pre_reconfigure_recovery() reconfigures all radios
within the same group. During grouping and driver going for a recovery,
this function is called as many times as there are devices in the group.
Consequently, it performs the same reconfiguration multiple times, which
is unnecessary.

To prevent this, add a check to continue if the action has already been
taken.

To simplify the management of various flags, the reason for hardware queues
being stopped is used as a check instead of introducing a new flag.

While at it, also add missing wiphy locks. Wiphy lock is required since
ath12k_mac_drain_tx() which is called by
ath12k_core_pre_reconfigure_recovery() needs this lock to be held by the
caller.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 72e6e3a0cf7be03b20b7421866c479dfcb8038ff..5700fc661ac380b6c01d0571595d27fb1ab7c8c5 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1279,6 +1279,18 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 		if (!ah || ah->state == ATH12K_HW_STATE_OFF)
 			continue;
 
+		wiphy_lock(ah->hw->wiphy);
+
+		/* If queue 0 is stopped, it is safe to assume that all
+		 * other queues are stopped by driver via
+		 * ieee80211_stop_queues() below. This means, there is
+		 * no need to stop it again and hence continue
+		 */
+		if (ieee80211_queue_stopped(ah->hw, 0)) {
+			wiphy_unlock(ah->hw->wiphy);
+			continue;
+		}
+
 		ieee80211_stop_queues(ah->hw);
 
 		for (j = 0; j < ah->num_radio; j++) {
@@ -1301,6 +1313,8 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			idr_destroy(&ar->txmgmt_idr);
 			wake_up(&ar->txmgmt_empty_waitq);
 		}
+
+		wiphy_unlock(ah->hw->wiphy);
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);

-- 
2.34.1


