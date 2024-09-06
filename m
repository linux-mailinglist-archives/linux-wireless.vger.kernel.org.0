Return-Path: <linux-wireless+bounces-12576-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4142A96E849
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 05:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42CA286473
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 03:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC85D1EB35;
	Fri,  6 Sep 2024 03:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BqzoZIzV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A21E28370
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725593552; cv=none; b=C04C5s6h6dEoAJ82D61Q++Sv/QdraSfQZePTKS5uh1iM42AUanKfqE/5lJ/EPWEEf2e7cqdYckl216bf0hZhGBlbnAClQeG87Epqb4X8OQ/PzALiAR5tY9k8v0lmslghneeXQn9Etg9E33ncYoGaztGq8hRQIi1KwF4ZNpsCCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725593552; c=relaxed/simple;
	bh=KJ/5RYJfU6eYKjvh+oE7Wl1YrOMJX7O63HCunM9ChBs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWfWONy7eTndo1PCeZstUgNPQnYiHO/J/RSlTAp+OphVm69PDVFKLgoVub8byKm2hgAr1PfczMPYyXF/akHM3L0oXB60zUYPQ0SYatHcu3glU7604pNv+/MFBDJbnedg8aRjXei1HCNbC5wrJ42QJ8QhWZuce+6ilc4x6M9nYCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BqzoZIzV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485IPxpd032629;
	Fri, 6 Sep 2024 03:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IhJ+eqJMwoZRzmfds+qANVZ5VsqhN8EeaH6l4z2rl3E=; b=BqzoZIzVl3J18rNt
	4WeKB1gz3xmnG+cgu2CcMNy9jMQEATPATny54nTQ/g1Zr20gEt0rEY4MSmnbqGf8
	voASQSJjKnKCt/SksHxkuwdMSi2jqUuzc8mR5GQgm3y55qKMblgt6klrscR/F1ya
	4kTF3L91SgTejZNkmxhLdIfy/1KVunxwUK/UseUKVRH3WzNFChpEBZ+bkFA5WInP
	RBye/iQG7VSsgswurrj7v2O9SqY/rPttxgpSq/t1+ke4DcKpAWRvOEBPBTiAf2+Y
	xLor/4EEm7ngkMqjxyD48Rfsrk+6tohyN1VS4uW+JQ1yoTj5QfIaVeeHdaq4jFJp
	dda48A==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41fhwt8xq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 03:32:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4863WONC027891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Sep 2024 03:32:24 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Sep 2024 20:32:23 -0700
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath11k: move update channel list from update reg worker to reg notifier
Date: Fri, 6 Sep 2024 11:31:59 +0800
Message-ID: <20240906033200.472-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240906033200.472-1-quic_kangyang@quicinc.com>
References: <20240906033200.472-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: SyFB5n6E13QQq4yzjGHJckSV3h4qpyFh
X-Proofpoint-ORIG-GUID: SyFB5n6E13QQq4yzjGHJckSV3h4qpyFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_17,2024-09-05_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060024

From: Wen Gong <quic_wgong@quicinc.com>

Currently ath11k call regulatory_set_wiphy_regd() in ath11k_regd_update()
to notify the reg domain change to cfg80211 and update channel list by
reg_work, then ath11k immediately update channel list to firmware by
ath11k_reg_update_chan_list(). 

callstack:
ath11k_regd_update
->regulatory_set_wiphy_regd
           -> schedule_work(&reg_work)
-> ath11k_reg_update_chan_list

They are running in two threads, it leads the channel list data out of
sync caused by muti-threads without synchronization. At this time,
ath11k may update wrong channel list to firmware because the reg_work
still running or even hasn't started yet.

The correct flow is after reg_work update the channel list according to
new reg domain, ath11k call ath11k_reg_update_chan_list() and update the
new channel list to firmware.

reg_call_notifier()(finally it will call ath11k_reg_notifier()) will be
called to by reg_work to notify ath11k when it finishes the channel
list update. So at this time, call ath11k_reg_update_chan_list() in
reg_call_notifier() with initiator type NL80211_REGDOM_SET_BY_DRIVER.
Then ath11k_reg_update_chan_list() will use the correct channel list.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Fixes: f45cb6b29cd3 ("wifi: ath11k: avoid deadlock during regulatory update in ath11k_regd_update()")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/reg.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b0f289784dd3..cb2cf9b63d18 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -55,6 +55,19 @@ ath11k_reg_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	ath11k_dbg(ar->ab, ATH11K_DBG_REG,
 		   "Regulatory Notification received for %s\n", wiphy_name(wiphy));
 
+	if (request->initiator == NL80211_REGDOM_SET_BY_DRIVER) {
+		ath11k_dbg(ar->ab, ATH11K_DBG_REG,
+			   "driver initiated regd update\n");
+		if (ar->state != ATH11K_STATE_ON)
+			return;
+
+		ret = ath11k_reg_update_chan_list(ar, true);
+		if (ret)
+			ath11k_warn(ar->ab, "failed to update channel list: %d\n", ret);
+
+		return;
+	}
+
 	/* Currently supporting only General User Hints. Cell base user
 	 * hints to be handled later.
 	 * Hints from other sources like Core, Beacons are not expected for
@@ -293,12 +306,6 @@ int ath11k_regd_update(struct ath11k *ar)
 	if (ret)
 		goto err;
 
-	if (ar->state == ATH11K_STATE_ON) {
-		ret = ath11k_reg_update_chan_list(ar, true);
-		if (ret)
-			goto err;
-	}
-
 	return 0;
 err:
 	ath11k_warn(ab, "failed to perform regd update : %d\n", ret);
@@ -977,6 +984,7 @@ void ath11k_regd_update_work(struct work_struct *work)
 void ath11k_reg_init(struct ath11k *ar)
 {
 	ar->hw->wiphy->regulatory_flags = REGULATORY_WIPHY_SELF_MANAGED;
+	ar->hw->wiphy->flags |= WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER;
 	ar->hw->wiphy->reg_notifier = ath11k_reg_notifier;
 }
 
-- 
2.34.1


