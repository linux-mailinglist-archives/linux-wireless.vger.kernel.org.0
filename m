Return-Path: <linux-wireless+bounces-12225-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7D0965550
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 04:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B65191F24102
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 02:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560514D8A1;
	Fri, 30 Aug 2024 02:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ht1wXSBs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7885E2C18C
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 02:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724985563; cv=none; b=qnqJvlzcukUr/siA9AgllRSbrk25GMgKHswnm5DPA6rqU8FQYOIyxJErqO84I8HeaLzfICaV3YJJpzUKQsCKx3dWS7CrWH185rAt4J24L0sIGcS0tTYGBCG0UzhByMpCGl6P3q7W8FG5N1ty5AUZzR/jXWsoml4Q3Bt9v1xKAZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724985563; c=relaxed/simple;
	bh=sO28K1G5URjA0KPKTLaQsAiVymgk+P/3nrjHY5q2P+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=goUCUt0EUJKlldxaFxAvomme4OJeF34aYWhv5VNDFyVun0ef1Y52/PPdFRfrs+AR7JcTu7r52YLRn4cWC/JLWm4qP0KYKwlflPfxZ4P+NPRB8MU7cLqnYf0uBHp9CRiTlV5/stD++eA7Utdk7NqHgUu2/XOUuoqk/jJEsrJmsiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ht1wXSBs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TI3gQ6009653;
	Fri, 30 Aug 2024 02:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4ry96/rvnbCRnQuoRQuiIC
	2RmpYFaVXg5FQdsyPce3E=; b=ht1wXSBsmP31cko+TFZIBlo9+Fna6DfvcIkypO
	PRaQTVL3LFJUs2FdByF2a1euieBEp8Lp3R/9M3s3iKBIaTMVkODqxjPGAOmq0qK2
	o66Z0y4SpUjJois9JhtGBk3HZJp49GiPlmz9D3wKv6v9j8z9aJ7F1KfDCLc9EzjF
	NhakBPg3R3+FTKc2N0D7pTXiMj3xMund/clQX8myHRil58KKwqgw77IueN+RA/AG
	Yzrr56nmViC0tFCgsUO8rGp/loW+PHWYQjC76JU0qj01YlryCWRrlZbMECm8dbHM
	cdfUoP2F/mEsleedlSNf4lW6ANP4Tyyojh3q2ZeBvuBDNnPA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419pv0f7jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 02:39:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U2dFii017200
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 02:39:15 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 19:39:13 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: avoid deadlock during regulatory update in ath12k_regd_update()
Date: Fri, 30 Aug 2024 10:39:01 +0800
Message-ID: <20240830023901.204746-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: YhfKptEDqQEDr26b0iQrx08Kipm9iax2
X-Proofpoint-ORIG-GUID: YhfKptEDqQEDr26b0iQrx08Kipm9iax2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300018

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
   ath12k_regd_update_work(), then enters wait state because the lock is owned by
   thread B.

3. Thread B tries to call cancel_work_sync(&ar->regd_update_work), but thread A is in
   ath12k_regd_update_work() waiting for rtnl_lock(). So cancel_work_sync()
   forever waits for ath12k_regd_update_work() to finish and we have a deadlock.

Change to use regulatory_set_wiphy_regd(), which is the asynchronous version of
regulatory_set_wiphy_regd_sync(). This way rtnl & wiphy locks are not required so can
be removed, and in the end the deadlock issue can be avoided.

But a side effect introduced by the asynchronous regd update is that, some essential
information used in ath12k_reg_update_chan_list(), which would be called later in
ath12k_regd_update(), might has not been updated by cfg80211, as a result wrong
channel parameters sent to firmware.

To handle this side effect, move ath12k_reg_update_chan_list() to ath12k_reg_notifier(),
and advertise WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER to cfg80211. This works because,
in the process of the asynchronous regd update, after the new regd is processed,
cfg80211 will notify ath12k by calling ath12k_reg_notifier(). Since all essential
information is updated at that time, we are good to do channel list update.

Please note ath12k_reg_notifier() could also be called due to other reasons, like
core/beacon/user hints etc. For them we are not allowed to call
ath12k_reg_update_chan_list() because regd has not been updated. This is done by
verifying  the initiator.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Co-developed-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/reg.c | 35 +++++++++++++++------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 439d61f284d8..ea03f3f50e50 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
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
 

base-commit: 8fb3b2b8d6d489416a7ff8a28cd4083340ad9e55
-- 
2.25.1


