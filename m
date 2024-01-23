Return-Path: <linux-wireless+bounces-2361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0823D8385DB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 03:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7341C2A241
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 02:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE287F4;
	Tue, 23 Jan 2024 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gG+52+zQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9395520E4
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705978653; cv=none; b=IieGGtGa6wyf3/JnjBcJoKHJwj0hyBGhZIrCvMxLsrx0wpqOJXbubipBPAJhUF2suYwRfn96scj5xQtMqMlPXG/r4UxrEEahXpIOgt7riUNKVguLql7WeBypKYNA/fJMiho83h+eAQOuc9Ul5M0kgl6w5QQ57ZO3m5RvRJ2bSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705978653; c=relaxed/simple;
	bh=CPKDnkmA5w00xHV+2lDz9zpMoTMtK0bGidQdYuzcL2E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+rPA8i3ej6xDnClDrOmOf0i0MEXyS1dHd+DdW8cMJMAAag/9uQ7yYORLW2Jpdw0LPhgRDE3uS4Ir0eol9Mp2amMpoyHC6JSq6F1EYHC9pPWCVesszeFFbapQxvvpAcL0GG74UNEX+v7jr4u1DXOW8C5Sud4rpwLrodzlkK1+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gG+52+zQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N2BoOt008729;
	Tue, 23 Jan 2024 02:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=kHTH0zo1pimKi3yYupZBGYmGR27jhbfDUfA1t0FpYgk=; b=gG
	+52+zQXU4GJ8KIcxj0i0cuJJZh9t07Oj63EsZEpu8gYmeLCcYBJqOu+EhUXLw8KV
	KViqnXumz4jbMyjPuT2gf/nXB0OEcix1bhq+jlF+qDCxm9Tn6xKPPNmf69uJFwJB
	PbqS2wipa7IO/01IqtXNQH4ItRqqaqlsfzrTFImC1kAotFeTXujmPgzdU3ixprIR
	0va0UDToUpcI+zvkNnbdQnUz/cHsXY33Lal4Amq9an/ZIal3k8BskXJfuJKiEQSm
	uHoxBxSxhnMkC87a8wfosWWt4s86uLOFnjzhHJFrUMlxhZ1Llqr8/TA1xC9dDLvb
	kiOYp9GyfrEGWAm49cgA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vt4err2q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N2vCCs016233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 02:57:12 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 22 Jan 2024 18:57:10 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 1/4] wifi: ath11k: remove invalid peer create logic
Date: Tue, 23 Jan 2024 10:56:57 +0800
Message-ID: <20240123025700.2929-2-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123025700.2929-1-quic_bqiang@quicinc.com>
References: <20240123025700.2929-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Oizq9SGKcK2kDmy7IHBE6aPHjM4P1ZTv
X-Proofpoint-ORIG-GUID: Oizq9SGKcK2kDmy7IHBE6aPHjM4P1ZTv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_12,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 clxscore=1015 mlxlogscore=921 suspectscore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230019

In ath11k_mac_op_assign_vif_chanctx(), there is a logic to
create peer using ar->mac_addr for a STA vdev. This is invalid
because a STA vdev should have a peer created using AP's
MAC address. Besides, if we run into that logic, it means a peer
has already been created earlier, we should not create it again.
So remove it.

This is found during code review.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 8dda3337ee2d..5c7a33d4ca8b 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8097,7 +8097,6 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	int ret;
-	struct peer_create_params param;
 	struct cur_regulatory_info *reg_info;
 	enum ieee80211_ap_reg_power power_type;
 
@@ -8140,21 +8139,6 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	if (ab->hw_params.vdev_start_delay &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
-		param.vdev_id = arvif->vdev_id;
-		param.peer_type = WMI_PEER_TYPE_DEFAULT;
-		param.peer_addr = ar->mac_addr;
-
-		ret = ath11k_peer_create(ar, arvif, NULL, &param);
-		if (ret) {
-			ath11k_warn(ab, "failed to create peer after vdev start delay: %d",
-				    ret);
-			goto out;
-		}
-	}
-
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath11k_mac_monitor_start(ar);
 		if (ret) {
-- 
2.25.1


