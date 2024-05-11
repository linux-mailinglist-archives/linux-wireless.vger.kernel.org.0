Return-Path: <linux-wireless+bounces-7501-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB0B8C3068
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 11:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6440281DF2
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2024 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC75380F;
	Sat, 11 May 2024 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eGZvbPU7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AB2C14F
	for <linux-wireless@vger.kernel.org>; Sat, 11 May 2024 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715421076; cv=none; b=tBS92V2dXIqi0cX0iAK80f98scS0a1C7Z9Ru0rAS7dLc9TlYP6AV80nDwNUi+OmB6Q5b/AHBOSqU4MkSJScnqaowpl9PwZoDt5fCZS/ukpT2rp/PYB+9H38GfeAOVXhyrnUbc8fg89t55F2JsspsZSKXmsVrSBCaokqxaWJC4yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715421076; c=relaxed/simple;
	bh=avcQovijRayBbSK3jfdsAAhEmoe1+9TndLmLkdiyUb8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cYZL1aF06c2Y0DY9gWW1UdTVb9SQhDbE1dtvwwvpgLPc8LhJ7EOA1YRye5HnhluaxAaebbS26ChaRIPfGC71MXp4UqW9wsaO+HpqtxWqHDrdnXZKSuBBPOa7ndyqre2vuiwaK9Owcd67QEycgtU9hVw0mxz3PpVCoBjhQvs0o1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eGZvbPU7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44B9XGhh009139;
	Sat, 11 May 2024 09:51:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=3w0xYAD
	pxO0pAxrl0r2NQfZ2oscqn+f4hbm7xi0MJzw=; b=eGZvbPU7PKNwr6HbBewwBMx
	SJFPqGeuFjTeIQBffKkPaRRzQVUtprW4gT4WZYNDLMD1e4J9g6wz/5pMQIiUMss4
	yX4FF9KJgkeejwgAQe5CF4ADmeuHHxMe7kQdB1zLUUE3Rku916kLUVf+ZN28juyZ
	Dm4cR+5SsbrWiV6sFibq53EorV7z92o9UblvKV5nUrS6dGpsGPssUH9bKZnL6GHS
	jEnj/jsRIFrkJl0p+6UhceRcSmBEH4433fD5c/6edY8aIA9Yew5kTXqk7OKL33pH
	W/6oP828e0E2VUthE3z0c38OxJBactNNZhhmG7kwRi7XdrdXVuxjroqp1ChdWwA=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1yp58feu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 09:51:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44B9p6bb002266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 11 May 2024 09:51:06 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 11 May 2024 02:51:05 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix Smatch warnings on ath12k_core_suspend()
Date: Sat, 11 May 2024 17:50:45 +0800
Message-ID: <20240511095045.9623-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: Uhzpv4uZ31nH2gkbkSFZyxaiX19UhPIA
X-Proofpoint-ORIG-GUID: Uhzpv4uZ31nH2gkbkSFZyxaiX19UhPIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-11_04,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405110072

Smatch is throwing below warning:

Commit 692921ead832 ("wifi: ath12k: flush all packets before
suspend") leads to the following Smatch static checker warning:

	drivers/net/wireless/ath/ath12k/core.c:58 ath12k_core_suspend()
	warn: sleeping in atomic context

and also gives the reason:

drivers/net/wireless/ath/ath12k/core.c
    48         int ret, i;
    49
    50         if (!ab->hw_params->supports_suspend)
    51                 return -EOPNOTSUPP;
    52
    53         rcu_read_lock();
               ^^^^^^^^^^^^^^^
Disables preemption.

    54         for (i = 0; i < ab->num_radios; i++) {
    55                 ar = ath12k_mac_get_ar_by_pdev_id(ab, i);
    56                 if (!ar)
    57                         continue;
--> 58                 ret = ath12k_mac_wait_tx_complete(ar);
                                        ^^^^^^^
Sleeping in atomic context.

    59                 if (ret) {
    60                         ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
    61                         rcu_read_unlock();
    62                         return ret;
    63                 }
    64         }
    65         rcu_read_unlock();

But it is weird that no warning on this in run time even with
CONFIG_DEBUG_ATOMIC_SLEEP=y. With some debug it is found that this is
because: when system goes to suspend, ath12k_mac_op_stop() gets called
where then in ath12k_mac_stop() ab->pdevs_active[ar->pdev_idx] is cleared.
This results in ath12k_mac_get_ar_by_pdev_id() always returning a NULL ar,
and thereby ath12k_mac_wait_tx_complete() never gets a chance to run.

Fix it by retrieving ar directly from ab->pdevs[].ar instead of using
ath12k_mac_get_ar_by_pdev_id(). Since ab->pdevs[].ar is set at boot time
and won't get cleared when suspend, ath12k_mac_wait_tx_complete() won't
be skipped. In addition, with ath12k_mac_get_ar_by_pdev_id() removed,
rcu_read_lock()/unlock() are not needed any more, so remove them. This
also fixes the warning above.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Fixes: 692921ead832 ("wifi: ath12k: flush all packets before suspend")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/ath12k/7a96ca11-80b5-4751-8cfc-fa637f3aa63a@moroto.mountain/
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9482d5db71e7..e7f628e935e4 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -50,19 +50,16 @@ int ath12k_core_suspend(struct ath12k_base *ab)
 	if (!ab->hw_params->supports_suspend)
 		return -EOPNOTSUPP;
 
-	rcu_read_lock();
 	for (i = 0; i < ab->num_radios; i++) {
-		ar = ath12k_mac_get_ar_by_pdev_id(ab, i);
+		ar = ab->pdevs[i].ar;
 		if (!ar)
 			continue;
 		ret = ath12k_mac_wait_tx_complete(ar);
 		if (ret) {
 			ath12k_warn(ab, "failed to wait tx complete: %d\n", ret);
-			rcu_read_unlock();
 			return ret;
 		}
 	}
-	rcu_read_unlock();
 
 	/* PM framework skips suspend_late/resume_early callbacks
 	 * if other devices report errors in their suspend callbacks.

base-commit: 1025c616ee13372f3803b158abb1d87ef368ae3d
-- 
2.25.1


