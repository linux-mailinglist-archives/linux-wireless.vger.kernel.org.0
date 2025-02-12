Return-Path: <linux-wireless+bounces-18800-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5603BA31C2A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 03:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A7E1653CF
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439906088F;
	Wed, 12 Feb 2025 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nYHcYVN4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1300617996
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327934; cv=none; b=doTcEy+0ia/tpMjbBFozf/uKI6gY1jbm1hFs+3xavm1yfuWLH89eobHgOZgXFQHWIJToYqSVVSBUAadRWd0ef7F/OVI7yKyiFbiKTwaCDD1sg88RlyBGr6HbyzwuXM8FfrW2Cu5ZTaAtTbDnqHO8lTdFD5qiJBYfBKUBzr+I+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327934; c=relaxed/simple;
	bh=Om/Hr5rG0eC5zQBPQ3M8SmNSZu4DZd12Gvs61QZJ6D4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=np7JoSu9l0PThur6Hxx/J0PJCUka4ASoOTsLdikRPdZu8/kTGjClaHk4YAYsa+tiYu02A1WZ+qhUiGcnj/MGHtfUuKdw9sWfWrXgRqjdp4USEPNOEbgLvxAWccG/qq4CkNx+66z8jzrxjMN/upOi4vMWFg924He++5oUZnmaBdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nYHcYVN4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51C0Udxo030555;
	Wed, 12 Feb 2025 02:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dZAw5hbdY76KOMmAK5YeVe
	lDyMrFKIyauU3evVYq/Dk=; b=nYHcYVN4CoUKigr1TKL+rD5rz4YmAG4WwzX3nJ
	rpcigqivsOLHd52LhSU8V2ztZeN4lCIapJHQGo1Y/tK0ry4yWB2HKXDHTuDd8B1N
	Pd5LHKzJLba7SMePFG8D2oKIpsHCAFmwMKQ1idyArol37Y/UtGuyAK5+WtAixfoZ
	QYQgc/5y0tVHrg3FKJTbWH1QkIHrFW2Iocx0YPRnMZZ6v8mrgcrVjtSEHBt9YWRL
	Sq6txiFsxG4piqLuIOg+TigyiQhyTG/Qv46c0Nf7YKeZYWt6FfOLzNvpErP0F2bh
	Ob7gi5KywavYVGCxNjBNXkrki9EdoYksmPAcmIfv1PACsObw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qxg9kcyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 02:38:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51C2cdtC003969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 02:38:39 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 11 Feb 2025 18:38:38 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()
Date: Wed, 12 Feb 2025 10:38:29 +0800
Message-ID: <20250212023829.3300-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: QbJsiYS3iK02njbb2o1DTuefgcR7Bpw5
X-Proofpoint-GUID: QbJsiYS3iK02njbb2o1DTuefgcR7Bpw5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_10,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120019

From: Wen Gong <quic_wgong@quicinc.com>

Running this test in a loop it is easy to reproduce an rtnl deadlock:

iw reg set FI
ifconfig wlan0 down

What happens is that thread A (workqueue) tries to update the regulatory:

    try to acquire the rtnl_lock of ar->regd_update_work

    rtnl_lock
    ath12k_regd_update [ath12k]
    ath12k_regd_update_work [ath12k]
    process_one_work
    worker_thread
    kthread
    ret_from_fork

And thread B (ifconfig) tries to stop the interface:

    try to cancel_work_sync(&ar->regd_update_work) in ath12k_mac_op_stop().
    ifconfig  3109 [003]  2414.232506: probe:

    ath12k_mac_op_stop [ath12k]
    drv_stop [mac80211]
    ieee80211_do_stop [mac80211]
    ieee80211_stop [mac80211]

The sequence of deadlock is:

1. Thread B calls rtnl_lock().

2. Thread A starts to run and calls rtnl_lock() from within
   ath12k_regd_update_work(), then enters wait state because the lock is
   owned by thread B.

3. Thread B tries to call cancel_work_sync(&ar->regd_update_work), but
   thread A is in ath12k_regd_update_work() waiting for rtnl_lock(). So
   cancel_work_sync() forever waits for ath12k_regd_update_work() to
   finish and we have a deadlock.

Change to use regulatory_set_wiphy_regd(), which is the asynchronous
version of regulatory_set_wiphy_regd_sync(). This way rtnl & wiphy locks
are not required so can be removed, and in the end the deadlock issue can
be avoided.

But a side effect introduced by the asynchronous regd update is that,
some essential information used in ath12k_reg_update_chan_list(), which
would be called later in ath12k_regd_update(), might has not been updated
by cfg80211, as a result wrong channel parameters sent to firmware.

To handle this side effect, move ath12k_reg_update_chan_list() to
ath12k_reg_notifier(), and advertise WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER
to cfg80211. This works because, in the process of the asynchronous regd
update, after the new regd is processed, cfg80211 will notify ath12k by
calling ath12k_reg_notifier(). Since all essential information is updated
at that time, we are good to do channel list update.

Please note ath12k_reg_notifier() could also be called due to other
reasons, like core/beacon/user hints etc. For them we are not allowed to
call ath12k_reg_update_chan_list() because regd has not been updated.
This is done by verifying  the initiator.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Co-developed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
v2:
 - rebased on ToT
 - reformat commit text to make checkpatch happy
 - update copyright

 drivers/net/wireless/ath/ath12k/reg.c | 37 +++++++++++++++------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d8..987fcca71504 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: BSD-3-Clause-Clear
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #include <linux/rtnetlink.h>
 #include "core.h"
@@ -55,6 +55,24 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "driver initiated regd update\n");
+		if (ah->state != ATH12K_HW_STATE_ON)
+			return;
+
+		for_each_ar(ah, ar, i) {
+			ret = ath12k_reg_update_chan_list(ar);
+			if (ret) {
+				ath12k_warn(ar->ab,
+					    "failed to update chan list for pdev %u, ret %d\n",
+					    i, ret);
+				break;
+			}
+		}
+		return;
+	}
+
 	/* Currently supporting only General User Hints. Cell base user
 	 * hints to be handled later.
 	 * Hints from other sources like Core, Beacons are not expected for
@@ -211,7 +229,6 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
-	int i;
 
 	ab = ar->ab;
 
@@ -275,11 +292,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 		goto err;
 	}
 
-	rtnl_lock();
-	wiphy_lock(hw->wiphy);
-	ret = regulatory_set_wiphy_regd_sync(hw->wiphy, regd_copy);
-	wiphy_unlock(hw->wiphy);
-	rtnl_unlock();
+	ret = regulatory_set_wiphy_regd(hw->wiphy, regd_copy);
 
 	kfree(regd_copy);
 
@@ -290,15 +303,6 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 		goto skip;
 
 	ah->regd_updated = true;
-	/* Apply the new regd to all the radios, this is expected to be received only once
-	 * since we check for ah->regd_updated and allow here only once.
-	 */
-	for_each_ar(ah, ar, i) {
-		ab = ar->ab;
-		ret = ath12k_reg_update_chan_list(ar);
-		if (ret)
-			goto err;
-	}
 skip:
 	return 0;
 err:
@@ -770,6 +774,7 @@ void ath12k_regd_update_work(struct work_struct *work)
 void ath12k_reg_init(struct ieee80211_hw *hw)
 {
 	hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	hw->wiphy->reg_notifier = ath12k_reg_notifier;
 }
 

base-commit: 704a2d7237043317ed1b0f8a08203e9ddde70097
-- 
2.25.1


