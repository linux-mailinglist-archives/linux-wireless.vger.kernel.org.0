Return-Path: <linux-wireless+bounces-8332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CCD8D589A
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 04:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA481F22547
	for <lists+linux-wireless@lfdr.de>; Fri, 31 May 2024 02:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35674E3D;
	Fri, 31 May 2024 02:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G5rcRNPL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F1520DC4
	for <linux-wireless@vger.kernel.org>; Fri, 31 May 2024 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717122273; cv=none; b=rPn9DSPMGCQCNw2viJxjJ/eo+V1+Mqw5ejGD4kU9SQEvw2Xg+V8q6J1bMeZ1L2wl0Aer17Icx7Aq4xVzx0+TxdhvpglNnYoaAEjh9m42GN8Qxzd4O7OWxy7SDRiDqq0SvLrp2UwCpF0a2xtR3/SYTKsb5FzEljyFWbTfcV7++nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717122273; c=relaxed/simple;
	bh=JGj8JbHnzWnu/JXp5qFtwwNMgFP6Nbkm4qGhgygRSYc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bPMmaL/iIIWGTUWoQkHojkg4kF4VfAMahRxOfpoIrru7+lbjg/czQAoBn+x8XstUUg0psYnI4BbxPTBU2JKBfZH40hgwFvF7CgV7NmkDOHurZiPpLJqK+i30nZwEotogX5X+fUbckSRpa33xn4wjxbF62f3hHN+3iZA1ijEf0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G5rcRNPL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V0upPM003494;
	Fri, 31 May 2024 02:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=W5AIp9m3z5uFhtI37N3yJ0
	ql7Q8fhCN4mU3YtCAsnVo=; b=G5rcRNPLFDSBZNM6V8vL9Vj45i8h20Kd6O5o/l
	YOeMSw7jxwToK4LMvo416gypEUDnGI+CzX2Wm94xLAKufTxsWVhAsN6SzbmJumWa
	G+mZeyhNyoWwqav+QfzpoQVRbpGhXv1osEmMtp5l4V6hBVr1Hy125wb2HHMiBuBo
	qISDwmps5joPdWGqridvUyg2r3lQa4hJxyIRO/ZC+P6olBatjj3aECtXufU46LKN
	PnpuY9vxEYdZhtwvCyZmMBzzR1dSruALCMzp/cVlp9Rs6PQoQ19fJytbUQFERx4d
	wDwW6iyPVpCw3JlpKRF+DYw9Ms6D/oupioyhR4rky8YE5isw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yesw5hkrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 02:24:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44V2OP0n016430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 02:24:25 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 30 May 2024 19:24:24 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: fix RCU documentation in ath11k_mac_op_ipv6_changed()
Date: Fri, 31 May 2024 10:24:11 +0800
Message-ID: <20240531022411.6543-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: CsK6Qo0wi9UdiDhOlgquEZWgW-VYmlmv
X-Proofpoint-GUID: CsK6Qo0wi9UdiDhOlgquEZWgW-VYmlmv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_21,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=737 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310017

Current documentation on RCU in ath11k_mac_op_ipv6_changed() says:

	/* Note: read_lock_bh() calls rcu_read_lock() */
	read_lock_bh(&idev->lock);

This is wrong because without enabling CONFIG_PREEMPT_RT
rcu_read_lock() is not called by read_lock_bh(). The reason
why current code works even in a CONFIG_PREEMPT_RT=n kernel
is because atomic_notifier_call_chain() already does that for
us, see:

	int atomic_notifier_call_chain()
	{
		...
		rcu_read_lock();
		ret = notifier_call_chain(&nh->head, val, v, -1, NULL);
		rcu_read_unlock();
		...
	}

and backtrace:

	ath11k_mac_op_ipv6_changed
	ieee80211_ifa6_changed
	notifier_call_chain
	atomic_notifier_call_chain

So update the comment to make it correct.

This is found during code review, compile tested only.

Fixes: feafe59c8975 ("wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a1800c75d32b..29af015a16f9 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -9020,7 +9020,12 @@ static void ath11k_mac_op_ipv6_changed(struct ieee80211_hw *hw,
 	offload = &arvif->arp_ns_offload;
 	count = 0;
 
-	/* Note: read_lock_bh() calls rcu_read_lock() */
+	/* The _ipv6_changed() is called with RCU lock already held in
+	 * atomic_notifier_call_chain(), so we don't need to call
+	 * rcu_read_lock() again here. But note that with CONFIG_PREEMPT_RT
+	 * enabled, read_lock_bh() also calls rcu_read_lock(). This is OK
+	 * because RCU read critical section is allowed to get nested.
+	 */
 	read_lock_bh(&idev->lock);
 
 	memset(offload->ipv6_addr, 0, sizeof(offload->ipv6_addr));

base-commit: 6e7a5c6d5e38b93f9cc3289d66a597b9a4ca0403
-- 
2.25.1


