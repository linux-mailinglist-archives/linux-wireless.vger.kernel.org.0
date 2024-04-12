Return-Path: <linux-wireless+bounces-6213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAF38A2624
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17AD283403
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2D1DDDB;
	Fri, 12 Apr 2024 06:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I7MpYg+9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419381B977
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902003; cv=none; b=BDouuMk8hqqUkDtY12O+x79CQkNcUbgRYSTdS5eg6cGONNF+FFubMyQl/LFZcx9jRQuUOUI57AYg8hkTd0TDbGr4xiXKKWh3GeDhSdI9bKA5978sjH0f+5RBnjJ5d4Q8CoiwVQKbk9Ih2TJof3xdlXe0VSuLj3TkziCja0QItVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902003; c=relaxed/simple;
	bh=u2FfeEStNCdDqhijmLkVmrXfHAp6BALfOLlDdqSk3sc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SejRTu6AWYfJ2aLxomKC5zs1itieNBBNpJunFG7DlA4ab9PxQySKGTDW+7FWztRwzsex4THp/2J8BT67cdGiXZEFs8zGnx1CZZkz+myZgU15Q3OSEIuidwNz6fHScyFRyOKSaSTa1UjIeAQUYQP25b6HxlFKtzg7A1NSd1+zjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I7MpYg+9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C2pC91019922;
	Fri, 12 Apr 2024 06:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=pRFcpXVNOD995PB4K/wG8/Iyn227BDybTQ8ptYNTGYM=; b=I7
	MpYg+9EoyXxeVoI7kYa/Fi/H4XRBNWbz1qT2EX6eIG1hKO0zyFO3z3BmGDx1VMxD
	kJBaXBK54rXLFw0/XigsqgmpdC23Zr9mMlhEiAA6QuJhEqoSBH+RDlo1FdpLbRXK
	dyZ5/90u68zph15KTvRCz40aZVuZTC7SYLSFhCT+N3BqwiizSC/EdxFJf8gYEo7B
	5Cc1q6fr2Ak4Mm1sbVeokRDKagZ3OcEXsIl3uAlC8rZIcfcwg6ry3SZTXHCc7lKN
	wlMIJPtAWJM6PK5J/OGTO8P4WIwwxoP6QyHiiAShoUvq/Byh1eCPxAnNQ2XOB/U1
	pYzviD3E2YQQ6zba7Sdw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xeskt0n7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66bB6031852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:37 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:36 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 01/10] wifi: ath12k: rearrange IRQ enable/disable in reset path
Date: Fri, 12 Apr 2024 14:06:11 +0800
Message-ID: <20240412060620.27519-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: okI0-Nlwn17i-5Pbj4lldUj1M3sEjUzZ
X-Proofpoint-ORIG-GUID: okI0-Nlwn17i-5Pbj4lldUj1M3sEjUzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=842 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404120042

For non-WoW suspend/resume, ath12k host powers down whole hardware
when suspend and powers up it when resume, the code path it goes
through is very like the ath12k reset logic.

In order to reuse that logic, rearrange IRQ handling in the reset
path.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 3c522a4b3e9b..28663cf4db30 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -879,9 +879,8 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 	int ret;
 
 	mutex_lock(&ab->core_lock);
-	ath12k_hif_irq_disable(ab);
 	ath12k_dp_pdev_free(ab);
-	ath12k_hif_stop(ab);
+	ath12k_ce_cleanup_pipes(ab);
 	ath12k_wmi_detach(ab);
 	ath12k_dp_rx_pdev_reo_cleanup(ab);
 	mutex_unlock(&ab->core_lock);
@@ -1136,6 +1135,9 @@ static void ath12k_core_reset(struct work_struct *work)
 	time_left = wait_for_completion_timeout(&ab->recovery_start,
 						ATH12K_RECOVER_START_TIMEOUT_HZ);
 
+	ath12k_hif_irq_disable(ab);
+	ath12k_hif_ce_irq_disable(ab);
+
 	ath12k_hif_power_down(ab);
 	ath12k_qmi_free_resource(ab);
 	ath12k_hif_power_up(ab);
-- 
2.25.1


