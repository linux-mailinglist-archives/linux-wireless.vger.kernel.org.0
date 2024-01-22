Return-Path: <linux-wireless+bounces-2319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C481836244
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 12:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285E21F2831D
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jan 2024 11:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220B93D96F;
	Mon, 22 Jan 2024 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vvd2pg2Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7593D964
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jan 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923579; cv=none; b=lqUIhwhiPTEudVvO0youeUvZmL0AeiBRmkV0dcyE4slQJkhzA8NpUfTUR8lIkf1Kh5ZzoXeUeD/KgLyhNLH9pCfOJCipVOmVHeM5t/xc2PFQGMlIyY698z67Pk5XZttcn9vbIxmBqDOV0Agnzy/mQqmXLT48lj6GdWGLuLe1qls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923579; c=relaxed/simple;
	bh=G+37iptBW2XsNCPEZ3Vr78m9rznfobjbqht8I6C3qgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyucPND6IVgefTqspcVveRyEDfBg5QJAekz9rNXn78pJkKqjqLvNTB4BQfEd9y5y9vNJYF3xJ9TGWl416knjsLZKI6VoHEHvoQXGfaL/vAQ2BXvZXrr/FnTRwRM2zFW5lvwpv6LkZ5kkGvrT+pfP8ftYnywvummusDruPav9G5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vvd2pg2Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40MAkABt032343;
	Mon, 22 Jan 2024 11:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=irSnxmr4WkJzAJDcQdBIvSGSCBvNuapuPXfTi9at0ko=; b=Vv
	d2pg2Zic2nDXjDLpi0d7AJtH8yMGvkp97XMX6DeA08MsMhkhD3O8q9lI7x6RVhbG
	B0LFbfDUxXv4b40j6opLEVmuK8rRNG4l4Qug6KextxlSXqzWxY4GwHeEhpavNuml
	jGaoUTHcm4yaFlnh19l3J9Q2zUrvpIKan/NmFW4UNqi3yUuBqf2KPg76yThQgxc/
	vbfBk42KyPrG3m0sEx8v3lw726MLoHfzw/ZxKMT9/mRnnuIecw9xOewaYRf7Lm6x
	ZDT3Zn9NAA26a1R1QUWHzDTfkO/Jv3oNeh1KpnlVTWVT37K6IkZ4rYDFyaIPMfGK
	tGCbQiKVfdOigkKLapWA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8r3xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:34 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MBdXHW027201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 11:39:33 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 03:39:31 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v3 06/10] wifi: ath12k: allow specific mgmt frame tx while vdev is not up
Date: Mon, 22 Jan 2024 19:39:00 +0800
Message-ID: <20240122113904.8938-7-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122113904.8938-1-quic_kangyang@quicinc.com>
References: <20240122113904.8938-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: rfOTlS8r5pyzCYI5uZOnQMoziwLSeYBk
X-Proofpoint-ORIG-GUID: rfOTlS8r5pyzCYI5uZOnQMoziwLSeYBk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220083

In current code, the management frames must be sent after vdev is started.
But for P2P device, vdev won't start until P2P negotiation is done. So
this logic doesn't make sense for P2P device.

Also use ar->conf_mutex to synchronize vdev delete and mgmt, TX.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8b106aae3260..65ac1d0b52a4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5069,8 +5069,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		}
 
 		arvif = ath12k_vif_to_arvif(skb_cb->vif);
-		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
-		    arvif->is_started) {
+		mutex_lock(&ar->conf_mutex);
+		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
 			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
 				ath12k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",
@@ -5084,6 +5084,7 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 				    arvif->is_started);
 			ath12k_mgmt_over_wmi_tx_drop(ar, skb);
 		}
+		mutex_unlock(&ar->conf_mutex);
 	}
 }
 
-- 
2.34.1


