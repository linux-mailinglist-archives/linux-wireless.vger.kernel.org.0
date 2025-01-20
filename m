Return-Path: <linux-wireless+bounces-17745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FAFA169EE
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDEC3A2ABC
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0FD1BC07B;
	Mon, 20 Jan 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZvtkxV9H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9431B0435;
	Mon, 20 Jan 2025 09:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366540; cv=none; b=NhyU6fHrZ4ob+IusjenZbZ34LREQSTS/M9oazRlJL6cZcRYAI3Vh1+nk9lRskC07+j1hVUq9CWjw/vmYeigpNRekl1Ga7tOwjHAwHtAkCTaCWGyWygi1vhlfprLNVV7IYCPCqYvL99Vqt/wE8fPA41nKEll3Oi6DeBwQBAJ7Zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366540; c=relaxed/simple;
	bh=eI6bUO76ZCGRVuvZnIDubXWP8BQ3261ExG8vxGz8X8M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hJrSHioQuluspsKu7F5oBqwVyzoreGbjsx/5PGPFawQAdzOTb4+xf6sse9oGXWwESclhX9ClX8O6Yrz1CTBEagpPWPBzLGV91Kmcx/dglw+mjhwNIZCNvPlz2+SjxhO/GPWXL1a5f85PyqgNoWCaeBcJJI/jMkck+/sC1FOLmwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZvtkxV9H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9RaeH014433;
	Mon, 20 Jan 2025 09:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BDQHH4jMREkbEeCTVmx2EsVjl8gHmKo7qd3cXINLy/U=; b=ZvtkxV9H9/IZjifj
	v6gS/z+CXzPY+hHk3122DGfGmVHV2hYQ8lRNFuT2/9QyJrpIjxg7MDwL6FQG6Wmv
	I7heWQdAciVpwrHSwsOuJR5HGntyvjh3ed1ma/qwU8a3GBQvO8mJq6GdBzAFe6Sw
	7zcpgU89gzL3sxKIODFw86uJOe75gwhs2+0vjvSv11ZHD+WPXwyZ/1NwaWUSHCjq
	VfuIZjkbaDRiJoys+a5FVKZxvUtIweS6W6ws4YasDv9q5FGOj56F4erfC0eBn9wc
	IkvjCK+3e7UHBQFEdYc+u9kgIzSHg9ebY43Zk/6J76E/xiAbCoBfxLADM1Dgvj5d
	1ZPgDQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 449kvh81md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50K9ms3X023468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 09:48:54 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 20 Jan 2025 01:48:51 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Date: Mon, 20 Jan 2025 15:18:26 +0530
Subject: [PATCH v2 06/10] wifi: ath12k: fix
 ath12k_core_pre_reconfigure_recovery() with grouping
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250120-fix_reboot_issues_with_hw_grouping-v2-6-b7d073bb2a22@quicinc.com>
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
X-Proofpoint-GUID: OeXKrCk-DbuiDswL1v-Ye3xkMrmual5O
X-Proofpoint-ORIG-GUID: OeXKrCk-DbuiDswL1v-Ye3xkMrmual5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200081

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

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 988fb25778b9d3b62544719200ca505eb6bcfd80..548af77ba892928c3e73fd7c917ad344b35e6883 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1281,6 +1281,18 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
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
@@ -1303,6 +1315,8 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			idr_destroy(&ar->txmgmt_idr);
 			wake_up(&ar->txmgmt_empty_waitq);
 		}
+
+		wiphy_unlock(ah->hw->wiphy);
 	}
 
 	wake_up(&ab->wmi_ab.tx_credits_wq);

-- 
2.34.1


