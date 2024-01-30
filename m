Return-Path: <linux-wireless+bounces-2763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 387F0841AD1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 05:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4591C24DD6
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 04:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E89738390;
	Tue, 30 Jan 2024 04:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pi0T16XE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C457381CD
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706587421; cv=none; b=nFHjfSooPIGg6FEdQAu03f8Dn8AAgbbMNJBzFHO3EgSYV/ZJ+jFfhB8NoXi4irZ8L+rXWzyhyyCj0GL5DUJtf9DpgPlJaw4tqGShepx4t1mfqQy8Kht9BvJxYi0SwYY7+uOJJIPrp5IZFtc+9F/xPy3YHsaML/qMKxe5azhQVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706587421; c=relaxed/simple;
	bh=bjDlWechFYllIhTBjsLNeBbsiE/+X9e+Od4uUVMHHZE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L811ADpRZrjEeMQUkRg5+TeKclzy4I1l5z5ZaHGipnvpyPZorM1Et2tKcBgV3Psmkiy5laFiCeqXORi7nTShscUGQ08kmfmIZXsKi4/JrMqLR+OXoRRtz154Y87YdllV63baZSQowhp009WLMApEPQervuzpadVeBmH/v+txNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pi0T16XE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U3EAj2021371;
	Tue, 30 Jan 2024 04:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=iRd/HDFKl8graBd8jQC29LWu8QlljAV5YkT74BTgB5s=; b=pi
	0T16XEb/qNYdEFeobZPU9bA4CeVO7cIZCP31RdWpCn/Y9N4DfZoLaUV7Q3AKAQL3
	fMYAW1NfhLrBJtW/rrD+tH9gIUSz525Aurc8vqmQxw9ywNJ0rGFAUK7TRmv9Z7xP
	7yM/1MDZ1M7iysQELZ9428CHiSFviopm1ks6tFj9Rh9PzZnUYMgJkXu1m+PCWX5t
	mqg8ZZxfe0fgYWDuEOUNLFEZmbMJywE73IR5WVyGGHlsr+IKeUu33Dqi4umMhHVL
	36fc/evrwPX6SrTbGpYaRIG50rhcYcwvIorrMXWzQHhfbnhPLA1ZD3SeWgayMieP
	3FTtKCj7eITd40xw84uw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxr2v060c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:38 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U43bAg013261
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 04:03:37 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 20:03:36 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v6 08/11] wifi: ath12k: allow specific mgmt frame tx while vdev is not up
Date: Tue, 30 Jan 2024 12:03:00 +0800
Message-ID: <20240130040303.370590-9-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130040303.370590-1-quic_kangyang@quicinc.com>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FOWbHiaSqOVg787mNip3RHPXWdUKajOP
X-Proofpoint-ORIG-GUID: FOWbHiaSqOVg787mNip3RHPXWdUKajOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_15,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300026

In current code, the management frames must be sent after vdev is started.
But for P2P device, vdev won't start until P2P negotiation is done. So
this logic doesn't make sense for P2P device.

Also use ar->conf_mutex to synchronize ar to avoid potential conflicts.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v6: no change.
v5: change commit log.
v4: no change.
v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index ec90a21fcd7f..1377b710bdcb 100644
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


