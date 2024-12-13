Return-Path: <linux-wireless+bounces-16368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06929F0819
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EB781889868
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893B1B395F;
	Fri, 13 Dec 2024 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VXs6D32k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5331B0103
	for <linux-wireless@vger.kernel.org>; Fri, 13 Dec 2024 09:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082784; cv=none; b=jlYTPrlEZC3AIjKnaNfusf8/JI//o4fU7hfM5GSE3ffDiQ1fTIvqOuKHEncsY0osNzfkERcdEjfRFg4HE+DcWDKfsQwBCq360sp4c+Gd6TfVzPU7aYhCVCaIkryvHIMq9KIv8zuSLbqVMnxTT0skrfYIBt1nTnvPnlDrHo+/+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082784; c=relaxed/simple;
	bh=M/qeWUTVmQSa7ViBg2gh5Zj632OPJ3FC/TT8CyCtwOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYKEVopw0C7PUZ3aVZC+SE4ylAp5PW04QyVcZNmqYySRQSLPK5OMEK4OaRc1B43JRQR1N3xkOZLpPBSUHXZzKWJfBRUMqOcGrlzavI9UORvjBdMZfvdGH0DnRmDL2c03FSlRjltw2cjlKA+qFXV7R2JwkRIzq4pKQ3tmptD2PCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VXs6D32k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1Vq65001463;
	Fri, 13 Dec 2024 09:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ynfzvs2D3kFtoelKFSYDq6ItdwYW1pKcnFwao1P4rQY=; b=VXs6D32kpNURJlNx
	cmqh3ovajhTuIYnyR8zyUI7vCS2VoevLuCt5BwaHPQ9Bbp7fY4E++N3OVd9W8sDR
	4kATkV/wiYgu+Mp8+AOa9AcGQZqKsDogCFTWlgFPMgilSaQGemOGMYcZLN0YmL0e
	cnHO3TWwSUz0b4EIvr6cbNxLTo4sUdxqMQvzbYXtirv1WfJZySDR1I7elb6EjS4C
	N/+npqYbLyIn2DYjfudW2bduPYeWJrsv3W6r/XySIF5WQvtoZO541pFoDTNBFoep
	gOUGNqV1cDQPtrl9Q8D3HZH25bJBtqwgXfggutgX2xtCgZw2mrnFaTooWfi60s77
	mfig8Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43fqes4aq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:39:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BD9dcHf006385
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 09:39:39 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 13 Dec 2024 01:39:37 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 1/2] wifi: ath11k: move update channel list from update reg worker to reg notifier
Date: Fri, 13 Dec 2024 17:39:08 +0800
Message-ID: <20241213093909.629-2-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20241213093909.629-1-quic_kangyang@quicinc.com>
References: <20241213093909.629-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: kjJiGrGKKzk1wEWz0n8S4d7Q3HQrSwcH
X-Proofpoint-ORIG-GUID: kjJiGrGKKzk1wEWz0n8S4d7Q3HQrSwcH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130065

From: Wen Gong <quic_wgong@quicinc.com>

Currently when ath11k gets new channel list, it will mainly do two things
in ath11k_regd_update():
1. update channel list to cfg80211 by reg_work.
2. update cfg80211's channel list to firmware by
ath11k_reg_update_chan_list().

Flow:
ath11k_regd_update
->regulatory_set_wiphy_regd
        -> schedule_work(&reg_work)
                ->reg_work->reg_process_self_managed_hint
                        ->handle_band_custom(update to cfg80211)
-> ath11k_reg_update_chan_list(update to firmware)

But ath11k_reg_update_chan_list() is immediately called after reg_work
is queued. They are running in different threads. At this time,
ath11k_reg_update_chan_list() may use a wrong channel list because
handle_band_custom() may not be finished.
This may result in out-of-bounds write errors:
BUG: KASAN: slab-out-of-bounds in ath11k_reg_update_chan_list
Call Trace:
    ath11k_reg_update_chan_list+0xbfe/0xfe0 [ath11k]
    kfree+0x109/0x3a0
    ath11k_regd_update+0x1cf/0x350 [ath11k]
    ath11k_regd_update_work+0x14/0x20 [ath11k]
    process_one_work+0xe35/0x14c0

So should make sure ath11k_reg_update_chan_list() is called after
handle_band_custom() is finished.

reg_process_self_managed_hint() will call reg_call_notifier() after
handle_band_custom(). This function will call ath11k_reg_notifier(), so
move ath11k_reg_update_chan_list() to ath11k_reg_notifier(). Then
ath11k can update correct channel list to firmware.

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


