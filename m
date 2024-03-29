Return-Path: <linux-wireless+bounces-5518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F522891142
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4CD21F2426C
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF05380;
	Fri, 29 Mar 2024 01:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kBFcZ5F4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9FB1642F
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677417; cv=none; b=baOkOZiekTJz5CCwBkH6+05pacTdH4AqKcC0CiVfqaPx5j/eFeSZu2u+noituF3GfwJiklWtFCBJeB4vFnjeZWfRJC2uxBu6XSCKloyp9BSGKogif9/R/DptP+MsrdwfoxGIE7fuiQaAmXInkM4pOMCrHRh/HgBX6+tT97UuyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677417; c=relaxed/simple;
	bh=j+Dw8l+IFgBPvsR5JZNcHAQgvUiOJTewwbfLiiw+03s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rbro6dr6Qi6LbfbKBv8UTomM9KDxZ/Vipk+wq4r0LLa7cKtTafnb+5XaDTehy5TbZS9qDxW4V5lWLVe9F4wQoEL+vfZ/jrTzLzmUXAXqkAnSihhtHOb7D2pz6X+34g8U7GilJJhShLa8xK3c3D5e1vhP0XJzbTNcbE1y7/tjDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kBFcZ5F4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T1f3wM022779;
	Fri, 29 Mar 2024 01:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=F9BZd3t
	29r0aH146EHm7ypIrvmdNcdcAo23/taNDQNk=; b=kBFcZ5F4FEq8DArIRnFnRRK
	9S70Gj+vW2HRrZYzRW0BRy4P5jChEVANOys1Vg1SW20Im4rNP5XheMF91alFNOHD
	7HOmI7it2b4xam0tKz7i657CVO0oBBaEm2TS7L8D4KeFZaB3jj1F5I54gxq/X3h/
	ti17qdbB2EryIyNS0uJpld+ELEA3KZDg3/a4Q+kjXtYo+W2bXmD6tUKucLwlCl5+
	4JaORG/gOfkaOKPwSb4o/Uq1904OGpoldi7J7OJoIqjEed4RU4lBsFXR18d7bFkK
	I7lFEpVOKsMhn/aRMLzOz8f5KJsNL1TUcOAU3uNoE6ph5ihTM5huRqI1eP9dTDQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5fr7ggth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:56:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42T1un2e012861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 01:56:49 GMT
Received: from bqiang-SFF.lan (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 18:56:47 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix flush failure in recovery scenarios
Date: Fri, 29 Mar 2024 09:56:30 +0800
Message-ID: <20240329015630.3019-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: bzvV04oXi8eKaWWQTntBhMOfwcZNhGpP
X-Proofpoint-ORIG-GUID: bzvV04oXi8eKaWWQTntBhMOfwcZNhGpP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_01,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290014

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

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp.c b/drivers/net/wireless/ath/ath12k/dp.c
index 1006eef8ff0c..ddfe1eb82d6b 100644
--- a/drivers/net/wireless/ath/ath12k/dp.c
+++ b/drivers/net/wireless/ath/ath12k/dp.c
@@ -1150,7 +1150,9 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
 	struct ath12k_rx_desc_info *desc_info;
 	struct ath12k_tx_desc_info *tx_desc_info, *tmp1;
 	struct ath12k_dp *dp = &ab->dp;
+	struct ath12k_skb_cb *skb_cb;
 	struct sk_buff *skb;
+	struct ath12k *ar;
 	int i, j;
 	u32 pool_id, tx_spt_page;
 
@@ -1201,6 +1203,11 @@ static void ath12k_dp_cc_cleanup(struct ath12k_base *ab)
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

base-commit: fe7e1b830cf3c0272aa4eaf367c4c7b29c169c3d
-- 
2.25.1


