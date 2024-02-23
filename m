Return-Path: <linux-wireless+bounces-3947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7E860A63
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 06:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A90285D4F
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 05:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8986711CAD;
	Fri, 23 Feb 2024 05:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ndZsELO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20F11171E
	for <linux-wireless@vger.kernel.org>; Fri, 23 Feb 2024 05:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667130; cv=none; b=T+DHV1bgy5K5MJMlqdo5ebUnv3wjKxuhIq1g2vNMoGRxHrs6e8NpdvsQwnoZ8y0CA8G5mfQ3lHCz0EPmX4l6za6iS8rwQIxhT7KtCl4u6IB0CAdPTjJvwneAzzvEI4mTOXSySf3Hbi4kpRxuNiaFeIxNUbB3thhleN8wbjtGk4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667130; c=relaxed/simple;
	bh=W+f2St+xqAGzRkDgFAe83L3KorkvAFQw+GehKYaZuAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TzsJKDBxj2NdLsx/UCQv6UUCz8UiGd4b3KjH5FdonUG6qtPUMnzVR6uOyP3HBpWojM2y1xP3Oj5lrrt/+aasXHo+GWFQdC/rAPLVL8W66wsyB3QAujk70r5Hdoy63W9T4l7NQ4U4g8Gr4tXe3rFJShQa9TbH4FL5xbeoXNNWBoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ndZsELO9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41N4I1ui008028;
	Fri, 23 Feb 2024 05:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=mV/2Tiu
	FRKoqYy+l9ovdEcmeodlyGe2KgMowwS7SSDw=; b=ndZsELO9d7l/a3vn/PMNUJ4
	QTVN/XSuXfRRlcDegBGdMOkXBi7kwn4t1YsnosjWakNKERJqWRtGfZYoucWIKXTr
	SBItE96QKkdRWramhPXzGugbwmwR2iEifsZBYP8jT3eXxWTYmlhSSgGXIVatw8jT
	zbmxPD2+OMMNc7we3atU7/lzjLt3ShluXo6cs2jeO+QhZ+jhjWmXDBztuMgmYSat
	IQUI80fulerhCrpEGbGjpZ3LL2tcdx1n4Ah1jXZvHWTJn/Vuzt66WBqzE1sl2W1K
	AjO07wZ7x6BLdtK8a0J5XwVtAmgZhZg6eETLd4Byao+/cNnbCmYO0orG8xulJSQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weedkrv04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:45:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41N5jKQJ000565
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 05:45:20 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 21:45:19 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH] wifi: ath12k: add rcu lock for ath12k_wmi_p2p_noa_event()
Date: Fri, 23 Feb 2024 13:45:05 +0800
Message-ID: <20240223054505.438839-1-quic_kangyang@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: VaYCnJsUS-jNWWvqIvmBiXxbxkn8LyLt
X-Proofpoint-GUID: VaYCnJsUS-jNWWvqIvmBiXxbxkn8LyLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=788
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402230037

Warning will appear when running P2P GO:

WARNING: suspicious RCU usage
drivers/net/wireless/ath/ath12k/mac.c:583 suspicious rcu_dereference_check() usage!
other info that might help us debug this:
rcu_scheduler_active = 2, debug_locks = 1
no locks held by swapper/0/0.
stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc4-wt-ath+ #4
Call Trace:
 <IRQ>
 dump_stack_lvl+0x82/0xa0
 dump_stack+0x14/0x20
 lockdep_rcu_suspicious+0x214/0x3b0
 ath12k_mac_get_ar_by_vdev_id+0x192/0x220 [ath12k]
 ath12k_wmi_op_rx+0x2d7/0x1b40 [ath12k]

ath12k_mac_get_ar_by_vdev_id() requires its callers to have called
rcu_read_lock(), but in ath12k_wmi_p2p_noa_event() it is called without
doing so, and hence the warning was triggered.

Add rcu_read_lock() and rcu_read_unlock() to avoid warning.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: 9411eecb60cb ("wifi: ath12k: implement handling of P2P NoA event")
Reported-by: Kalle Valo <quic_kvalo@quicinc.com>
Closes: https://lore.kernel.org/linux-wireless/87o7cusyvw.fsf@kernel.org/
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 838161dd9098..9d69a1769926 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6736,18 +6736,21 @@ static int ath12k_wmi_p2p_noa_event(struct ath12k_base *ab,
 		   "wmi tlv p2p noa vdev_id %i descriptors %u\n",
 		   vdev_id, le32_get_bits(noa->noa_attr, WMI_P2P_NOA_INFO_DESC_NUM));
 
+	rcu_read_lock();
 	ar = ath12k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
 		ath12k_warn(ab, "invalid vdev id %d in P2P NoA event\n",
 			    vdev_id);
 		ret = -EINVAL;
-		goto out;
+		goto unlock;
 	}
 
 	ath12k_p2p_noa_update_by_vdev_id(ar, vdev_id, noa);
 
 	ret = 0;
 
+unlock:
+	rcu_read_unlock();
 out:
 	kfree(tb);
 	return ret;

base-commit: 707e306f3573fa321ae197d77366578e4566cff5
-- 
2.34.1


