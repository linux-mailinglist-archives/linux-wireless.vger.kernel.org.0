Return-Path: <linux-wireless+bounces-21237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0215A7F43E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 07:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1A023B312B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Apr 2025 05:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB0520A5CB;
	Tue,  8 Apr 2025 05:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OdIJApeI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AC22AE74;
	Tue,  8 Apr 2025 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090827; cv=none; b=M/yNrxjgR2Pt/42B6uEt5vvfuoCiA+jnzJn4aFOLHWW/Oc1Wsipc/xFtW5Fb0bAf6yMOr+J9THZbeIAiDQBdmP0n3c8pSQey/eIoLXs4t65DPDiSQTMiCZxT90qNmO/oi3gt0GTkd/nDZkgo2R9KPFGlpqn5+7VC0+ssNa6aThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090827; c=relaxed/simple;
	bh=F9Wmr5HV3gk1WSJlqvVh8gpos4IlKbfBj0jsM7zv0KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=thxjYmKqeoC7Z5jm7SWf+OsjTgyqA83MHIBnJLSS6C4YuFzx2mvC+7Aji0wakfh6NtV4OzMVfVEyMdMAH7qZjRecRZPMkX0sWqhy1ji6kmG1VxBzDthggG9yfugz9/NOjD7J7HnSoOI9ZMtkVKfHed4yrieTE0dzEo3q1G20YNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OdIJApeI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5382GMQo000856;
	Tue, 8 Apr 2025 05:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sXMbEQlVvWXiILhhIH3FVT
	iE2JqySujeGJdB3cTH/8s=; b=OdIJApeI7BKklpwBmW3/qobliReAFGjvDfLEK9
	fdI9g99bTKgFcOecQFWXZsZmfI2/Flhll+mhxHhW9oJYlUeexmrIwMun7ujTS12A
	5tHrpW0e3vrNwm7VByu4k47myun/WDgARazpst9OM1O3lF0ibJ6z+MEMfXP1tr4u
	TVQx3KbuL2q78eDnsKee29eIxp78cyDP7bQi+x1A9Eoj03OsBWgus9aGFBIFeM2j
	+meijEzJzIyLQy9wbd8P8WHJtGKCSfRQR8wgOpFx7PjMPR+n18ScPT6pOjbygiZg
	EUikPkg0BP8b1l0mVnJfpkIwuk9zMOhyj7LuTo+wAp5mq5Zw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twbe6mxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 05:40:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5385eCEi013115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 05:40:12 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 7 Apr 2025
 22:40:10 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Tue, 8 Apr 2025 13:39:48 +0800
Subject: [PATCH ath-next v3] wifi: ath12k: avoid deadlock during regulatory
 update in ath12k_regd_update()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250408-rtnl-deadlock-v3-1-fdc12bc511ea@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKO29GcC/3WNQQ7CIBBFr9LM2jEUJBpX3sN0QWFqJ1aogKSm6
 d0l3bt8efnvr5AoMiW4NitEKpw4+Arq0IAdjX8QsqsMUkgtTuKCMfsJHRk3BftEbYezbqVRQ2+
 gbuZIAy977w4mj+hpydBVM3LKIX73o6J2/6dZFLaoBGkt+lYLJ2/vD1v29mjDC7pt235jAriqt
 gAAAA==
X-Change-ID: 20250408-rtnl-deadlock-5cf7512a3fba
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
	<jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Wen Gong <quic_wgong@quicinc.com>,
        "Baochen
 Qiang" <quic_bqiang@quicinc.com>,
        Jeff Johnson
	<jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dkDR2_x_jhdlvWavHrRv8Zkw6NOmDpjH
X-Authority-Analysis: v=2.4 cv=T7OMT+KQ c=1 sm=1 tr=0 ts=67f4b6bd cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=10iZpnK5eFnVvZAGgq0A:9
 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: dkDR2_x_jhdlvWavHrRv8Zkw6NOmDpjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_01,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080039

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
Changes in v3:
- rebase on ToT
- Link to v2: https://lore.kernel.org/linux-wireless/20250212023829.3300-1-quic_bqiang@quicinc.com/

Changes in v2:
- rebase on ToT
- reformat commit text to make checkpatch happy
- update copyright
- Link to v1: https://lore.kernel.org/linux-wireless/20240830023901.204746-1-quic_bqiang@quicinc.com/
---
 drivers/net/wireless/ath/ath12k/reg.c | 36 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 893650f76fb2d9f24177d524c5a979693b543657..a84c021e119ab8def002d997556b5d92c0fc806b 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -56,6 +56,24 @@ ath12k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath12k_dbg(ar->ab, ATH12K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
+		ath12k_dbg(ar->ab, ATH12K_DBG_REG,
+			   "driver initiated regd update\n");
+		if (ah->state != ATH12K_HW_STATE_ON)
+			return;
+
+		for_each_ar(ah, ar, i) {
+			ret = ath12k_reg_update_chan_list(ar, true);
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
@@ -251,7 +269,6 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 	struct ieee80211_regdomain *regd, *regd_copy = NULL;
 	int ret, regd_len, pdev_id;
 	struct ath12k_base *ab;
-	int i;
 
 	ab = ar->ab;
 
@@ -315,11 +332,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 		goto err;
 	}
 
-	rtnl_lock();
-	wiphy_lock(hw->wiphy);
-	ret = regulatory_set_wiphy_regd_sync(hw->wiphy, regd_copy);
-	wiphy_unlock(hw->wiphy);
-	rtnl_unlock();
+	ret = regulatory_set_wiphy_regd(hw->wiphy, regd_copy);
 
 	kfree(regd_copy);
 
@@ -330,15 +343,7 @@ int ath12k_regd_update(struct ath12k *ar, bool init)
 		goto skip;
 
 	ah->regd_updated = true;
-	/* Apply the new regd to all the radios, this is expected to be received only once
-	 * since we check for ah->regd_updated and allow here only once.
-	 */
-	for_each_ar(ah, ar, i) {
-		ab = ar->ab;
-		ret = ath12k_reg_update_chan_list(ar, true);
-		if (ret)
-			goto err;
-	}
+
 skip:
 	return 0;
 err:
@@ -810,6 +815,7 @@ void ath12k_regd_update_work(struct work_struct *work)
 void ath12k_reg_init(struct ieee80211_hw *hw)
 {
 	hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	hw->wiphy->reg_notifier = ath12k_reg_notifier;
 }
 

---
base-commit: ac17b1211841c98a9b4c2900ba2a7f457c80cf90
change-id: 20250408-rtnl-deadlock-5cf7512a3fba

Best regards,
-- 
Baochen Qiang <quic_bqiang@quicinc.com>


