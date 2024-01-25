Return-Path: <linux-wireless+bounces-2493-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C9F83C723
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 16:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB831B230CC
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 15:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64309745E3;
	Thu, 25 Jan 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O1k3K4k0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B173172
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197577; cv=none; b=DZFEA2lryb9xYve3arq0mhNGTbk+xXTQ3ztjQWa1s20wRjAz+jrX0Pw0I8Q+mGJCjcEKNd/OjPmJIT8WFTE4Th5KSs95RmBRLjVk7tZyFOIKfB8axIgiDMQkTn0rI75iTLzz6Pyr3qPp+nPkppH2H+xo4hvtuzqEvI2di5O+4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197577; c=relaxed/simple;
	bh=tzr1XAVkWoFo3oMkLGDpPFVojpVl4rRw4OIzMbOKWco=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1akZ3D37XsmyLC0p+FVKtqsfdxhIYFmPb3k0xroNv3S+WU7oY/u+dg/nX9joVqA5zk9NZzCZcZaop1gvYFPLzYQdgvCjTNxDhtrZyInS9tOQanyPBFkzqeD7yWzWRjmN/Sf9f3kSqT3ORsFH8HBY35Bb+P16YIQ98JlVH3M6HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O1k3K4k0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40PFMQ1c012220;
	Thu, 25 Jan 2024 15:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Ks6Iax1
	tA8eDScykeIVZcNkgq/56DU0tTG3QuDRsi3I=; b=O1k3K4k0i7Sa91909fRuJwn
	pVBJ/nhSRzbmz4YdegDE8bnD978U/i0WMPmZVeu7+xZP0pcm/rWWKoyKScXY9vmI
	rDEKtHVJZ8dLcicKy1kNwbWrTlKJogCWE8NqNKCPYWJb7HD+pR5xmJ8H27g4kiox
	DbE7kpW0UIraHWgHUhgkZbdpIupRPXu3XO1U9emZIUGiGqDqjPIncfmUXInPVBT7
	kS/maMccBRjmoD+7GDFjRSCvUhJcfpeFdYt1RR8FnW1ks1kYp8JcJaJOGowX7+Gu
	xIIAYDQbrwrrSXZliu/8MN/9E9FFRveW8GfpMfXBw7P//iOubsDvpaBg5jaUBww=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vufwx9qse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:46:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40PFkAFN027323
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jan 2024 15:46:10 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 25 Jan 2024 07:46:08 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH] wifi: ath12k: refactor the rfkill worker
Date: Thu, 25 Jan 2024 21:15:55 +0530
Message-ID: <20240125154555.3169706-1-quic_periyasa@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mR6nFt28bMaJvQANtX2zVh10--HCA8py
X-Proofpoint-ORIG-GUID: mR6nFt28bMaJvQANtX2zVh10--HCA8py
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_09,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=782 impostorscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401250111

Currently, the rfkill worker handler access mac80211 HW from the radio/link
structure. This is will be incorrect for single wiphy model, as they will
hold multiple link/radio structures. To fix this, access mac80211 HW based
on the number of hardware in the SoC/chip. This approach makes the rfkill
worker handler compatible with both multi wiphy and single wiphy models.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 1baad3302157..f27a6ec3a394 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -879,21 +879,29 @@ static void ath12k_rfkill_work(struct work_struct *work)
 {
 	struct ath12k_base *ab = container_of(work, struct ath12k_base, rfkill_work);
 	struct ath12k *ar;
+	struct ath12k_hw *ah;
 	struct ieee80211_hw *hw;
 	bool rfkill_radio_on;
-	int i;
+	int i, j;
 
 	spin_lock_bh(&ab->base_lock);
 	rfkill_radio_on = ab->rfkill_radio_on;
 	spin_unlock_bh(&ab->base_lock);
 
-	for (i = 0; i < ab->num_radios; i++) {
-		ar = ab->pdevs[i].ar;
-		if (!ar)
+	for (i = 0; i < ab->num_hw; i++) {
+		ah = ab->ah[i];
+		if (!ah)
 			continue;
 
-		hw = ath12k_ar_to_hw(ar);
-		ath12k_mac_rfkill_enable_radio(ar, rfkill_radio_on);
+		for (j = 0; j < ah->num_radio; j++) {
+			ar = &ah->radio[j];
+			if (!ar)
+				continue;
+
+			ath12k_mac_rfkill_enable_radio(ar, rfkill_radio_on);
+		}
+
+		hw = ah->hw;
 		wiphy_rfkill_set_hw_state(hw->wiphy, !rfkill_radio_on);
 	}
 }

base-commit: 64d1dfa649b8d8f2980f95dbded4bcb6210ad073
-- 
2.34.1


