Return-Path: <linux-wireless+bounces-12223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AF89654E1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE06D1C22461
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAE344C77;
	Fri, 30 Aug 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vfnbx4HX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FE627473
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724982864; cv=none; b=j5UVQaiAes3aF4rl+sS9jxYvF9YzwtFRgRE5touYr++ibLzaCGeE5bLsU//pfqwMg+kuP6kSvrHNB6Q2C2IY3sKBGaFjCLBgyvZNnZAwfdR9eaJzdA1rv/MSlbvA+FlbtZWqHhYrhgQP2slFba13VwqMqk4eY++YCJZ2Yeno0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724982864; c=relaxed/simple;
	bh=5XLqbgGCLZfCfYvrUzds5KrqCTlmkAPbD8+4fybO4nw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RpJxR+c6c42/nT8cOEQVgiFNQJl4CcNzQKLhmPGOlyojEo/fRQ1iO3kCDs9K/+cLmSyNuzyp+hgASIEmcIh1U7F3Cr8BZPqw6djcCaPPRYP8HVPzduwnk7UsHIPh5Ssqlz3ZGPCQol6M+/jFHr61cRKGzYsKr5NF+dcsyLeVk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vfnbx4HX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TIGtr7028780;
	Fri, 30 Aug 2024 01:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WnLv4pdq+EyUjJ75h9GulT
	ycBwILJtRBraCLytMa3p4=; b=Vfnbx4HX+NdYvjVWUVB7icBC3dQd95ZT4GB/3j
	/PMYXo3bBRoubi7mw3RKH/qvnmi554kvo0DEByOg2ufwudDmxD8+IZWv9lWTpx9G
	FPTHL9jWh8DmCKdBaCO55m8nLxmLCcomqjLzSYYPq7lp5n4UzfONzPuHDoj+WLC0
	+wUXlu7WEmvNwW/PMsRJVrOrXAWtvHk0BCY8cNB/o/od5PwKTaDzIYyiFudu/47F
	PjPInNjdOZemOWZ54kJ1BzMGZSLDyh+jT4+YHk8yb2yhb31tgXPAiBjMCTmsEC4N
	V8Kx9iLljUv7O5N+J5OTze5o6SHOBVWqDKZcHUowCjxqdWdw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41ax4mgtpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 01:54:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U1s9Me002460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 01:54:09 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 18:54:08 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath10k: fix the stack frame size warning in ath10k_remain_on_channel
Date: Fri, 30 Aug 2024 09:53:49 +0800
Message-ID: <20240830015349.1083226-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: U5elr_1K-dDnI5PrBxac_BZuhzjeViFZ
X-Proofpoint-ORIG-GUID: U5elr_1K-dDnI5PrBxac_BZuhzjeViFZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300012

Fix the following W=1 kernel build warning:

drivers/net/wireless/ath/ath10k/mac.c: In function ‘ath10k_remain_on_channel’:
drivers/net/wireless/ath/ath10k/mac.c:7980:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Compile tested only.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 35 ++++++++++++++++-----------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a5da32e87106..9bfa55dede31 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7899,7 +7899,7 @@ static int ath10k_remain_on_channel(struct ieee80211_hw *hw,
 {
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
-	struct wmi_start_scan_arg arg;
+	struct wmi_start_scan_arg *arg = NULL;
 	int ret = 0;
 	u32 scan_time_msec;
 
@@ -7936,20 +7936,25 @@ static int ath10k_remain_on_channel(struct ieee80211_hw *hw,
 
 	scan_time_msec = ar->hw->wiphy->max_remain_on_channel_duration * 2;
 
-	memset(&arg, 0, sizeof(arg));
-	ath10k_wmi_start_scan_init(ar, &arg);
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH10K_SCAN_ID;
-	arg.n_channels = 1;
-	arg.channels[0] = chan->center_freq;
-	arg.dwell_time_active = scan_time_msec;
-	arg.dwell_time_passive = scan_time_msec;
-	arg.max_scan_time = scan_time_msec;
-	arg.scan_ctrl_flags |= WMI_SCAN_FLAG_PASSIVE;
-	arg.scan_ctrl_flags |= WMI_SCAN_FILTER_PROBE_REQ;
-	arg.burst_duration_ms = duration;
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
 
-	ret = ath10k_start_scan(ar, &arg);
+	ath10k_wmi_start_scan_init(ar, arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH10K_SCAN_ID;
+	arg->n_channels = 1;
+	arg->channels[0] = chan->center_freq;
+	arg->dwell_time_active = scan_time_msec;
+	arg->dwell_time_passive = scan_time_msec;
+	arg->max_scan_time = scan_time_msec;
+	arg->scan_ctrl_flags |= WMI_SCAN_FLAG_PASSIVE;
+	arg->scan_ctrl_flags |= WMI_SCAN_FILTER_PROBE_REQ;
+	arg->burst_duration_ms = duration;
+
+	ret = ath10k_start_scan(ar, arg);
 	if (ret) {
 		ath10k_warn(ar, "failed to start roc scan: %d\n", ret);
 		spin_lock_bh(&ar->data_lock);
@@ -7975,6 +7980,8 @@ static int ath10k_remain_on_channel(struct ieee80211_hw *hw,
 
 	ret = 0;
 exit:
+	kfree(arg);
+
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
-- 
2.25.1


