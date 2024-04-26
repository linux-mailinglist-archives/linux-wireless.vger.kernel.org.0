Return-Path: <linux-wireless+bounces-6909-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE008B2E7A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 03:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF1BB229CD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 01:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9BEEBE;
	Fri, 26 Apr 2024 01:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hZgdUDbw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF73812
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714096497; cv=none; b=HcJhI3gnC10lTVq5HOMHYaw7sIXD9SqiXriC6594NJPooAGVbUUrXgcvyNYjTyweRPXuPKVDIhE05Q+V0fMiQUWqeE75+NNADLcRFoK7LlsxJ+4NxiqECye0ir0HU0jt5CMrHVJZajglnJo3gpLRF2tWwmb8OJ7Zb3KMarRtwRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714096497; c=relaxed/simple;
	bh=VORW9jCJlP0wOfhdB7nTah1l3TwXdMxiVjSbe3X57fY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jpn1JP6yKe/ZxiS2gdt/chDmQGVEwttyTT8JP3xDxrNEewkc9Ch7vdN1OQqruMqArl6aXGARVx/DFSG2xdq3wHuC2dhc3rGGankeZW/hgkgkAxOBPLeD/d4BKb8WM25ybkwN4/tynDygFH37voYodYAH/UD2vDNc5j6krqB4fHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hZgdUDbw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q0k25d011116;
	Fri, 26 Apr 2024 01:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=dsjdCHV
	qQIcdlUkuZKOpdgqwATTtl9UjvPBH/m6i0GI=; b=hZgdUDbw+M3NuCbGglRlUaO
	LWl+lOdb85CyAFj0aMojtCparX6KIaq5hI5oH1ttgs2IvGIBxvCnFh90yuvX5jXJ
	VFzWA6prNzWtfbDD0nizxmhiJHYumdt2Y+4kNX37+X1Yel3RyT80oXWs13NXQs/i
	NLeo3aiSkGE3aTaUw2rwbn1C6eG2YZUVyML9fRX+KOgchtrOD4ykrGe56Ii3pnGi
	UjKiBpT8X8c+FUQlgc4E3uKDvd/n0O4nojEsn3ziZNDHP0EWS0I1UPuv+YXN3GiC
	9uIDNX8dkYEIBo6gVBwLOaDH4znWsX0avHik75gRxL0gpsrZbDn22q5kVCGLKVg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqx038fy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 01:54:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q1smP8001401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 01:54:48 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 18:54:47 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: fix flush failure in recovery scenarios
Date: Fri, 26 Apr 2024 09:54:34 +0800
Message-ID: <20240426015434.94840-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: v0lr0kkODGFazu0rgdHuiEy7uoKe7zZi
X-Proofpoint-ORIG-GUID: v0lr0kkODGFazu0rgdHuiEy7uoKe7zZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_23,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260010

Commit eaf9f17b861b ("wifi: ath12k: relocate ath12k_dp_pdev_pre_alloc()
call") moves ath12k_dp_pdev_pre_alloc() from ath12k_core_start() to
ath12k_mac_allocate(), resulting in ath12k_mac_flush() failure in
recovery scenarios:

[ 6849.684104] ath12k_pci 0000:04:00.0: pdev 0 successfully recovered
[ 6854.907320] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
[ 6860.027353] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0
[ 6865.143385] ath12k_pci 0000:04:00.0: failed to flush transmit queue 0

This is because, with ath12k_dp_pdev_pre_alloc() moved to ath12k_mac_allocate(),
dp->num_tx_pending is not reset due to ATH12K_FLAG_REGISTERED set in
recovery scenarios.

So a possible fix would be to reset that counter at some proper point,
just like the old design. But considering that the counter tracks number
of packets pending to be freed or returned to mac80211, forcefully reset
it might make it hard to expose some real issues. For example if somehow
ath12k fails to free/return some TX packets, we don't know that because
no warnings any more.

That is to say we should not reset that counter during recovery (which is
already done due to above commit), instead should decrease it each time
a packet is freed/returned. Currently almost each related function has
this logic implemented, except ath12k_dp_cc_cleanup(). So add the same
there to fix this issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 - add 'Tested-on' for QCN9274

 drivers/net/wireless/ath/ath12k/dp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 963b9ad4dc82..7843c76a82c1 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1155,7 +1155,9 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_tx_desc_info *tx_desc_info, *tmp1;
 	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_skb_cb *skb_cb;
 	struct sk_buff *skb;
+	struct ath12k *ar;
 	int i, j;
 	u32 pool_id, tx_spt_page;
 
@@ -1206,6 +1208,11 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 			if (!skb)
 				continue;
 
+			skb_cb = ATH12K_SKB_CB(skb);
+			ar = skb_cb->ar;
+			if (atomic_dec_and_test(&ar->dp.num_tx_pending))
+				wake_up(&ar->dp.tx_empty_waitq);
+
 			dma_unmap_single(ab->dev, ATH12K_SKB_CB(skb)->paddr,
 					 skb->len, DMA_TO_DEVICE);
 			dev_kfree_skb_any(skb);

base-commit: bf99bc7423e18aa3475ef00a7a6fb773c31ce6df
-- 
2.25.1


