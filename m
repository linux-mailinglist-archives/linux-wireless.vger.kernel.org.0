Return-Path: <linux-wireless+bounces-11157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6306C94C855
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 03:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8699C1C21B3F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 01:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B896F101E6;
	Fri,  9 Aug 2024 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XVLnUUO3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57AAD515
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 01:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168751; cv=none; b=lGrvxWAyqUIwh3yD7NgqGhZF9FRaHgVRFHjDs6ElNsZtE8QE0wwVp7XhESXH3bdASs33O3Eq3uj31ymTujIDOVUDZLrYZ/52CNDUSjzzDJ77xVn0QKi74l9bI5KZOUFRpcz5CYp2Jhdx0po4381kQQwbOlzz0LEuQOTv8H9TrVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168751; c=relaxed/simple;
	bh=ys7cVDJ8PjPKxw3GfB0JTV24RncKBZZcwZppkfadRCg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oaa+yDfDITpA8duSrNChX4C1CQvajtH7WsoPcTP8poKeKBrRhjB5XH+tkGs6oEJ6kMiUzBJZou+mLpDiPjQyhXDe46W94g5euxsm328ahxNPDI8/UAtCqJ4nbvnL8NB1dbt6+lR9y2EB8lToviiYlz2VNLBRsHfVa9QGiRmnsi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XVLnUUO3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4790fsXV021835;
	Fri, 9 Aug 2024 01:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JsK2lFmtgL+7AkK63XN9Co
	HNikFvEzeT+OelMzry9Tg=; b=XVLnUUO37cQKipcedjpR1Rqzi1lRhVKRzAeTQv
	Ss1J9iUfKf3a3x448Uh74ZHz+YSfu6ykIXC6NrXi0O+rny1e/kvEVxdVPEoJkBHz
	vq//Pp/Q1Xa2J08HCyEsWWrAB1OsuT8iPWHscwSP2cZw4eaQkBukkt9soMcxR8pO
	m7zt28IpDB5g+399iUbaNJpxdzpKueTpjGM6WWI3kuvmafChxrTEje05ykq4z4n7
	v48FTIQzTBCH2Z6JCwnlMv0keV0d8szLfT+o0OJHQrRIaskYhJnmO4e/pz+HAVJ6
	IyB88SxDLfTaxsbM0ME1Szg2S+dy+PFBZuRTeNI76xiKHStg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40vuwat5df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Aug 2024 01:59:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4791x1vg030227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Aug 2024 01:59:01 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 8 Aug 2024 18:58:59 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix the stack frame size warning in ath12k_mac_op_hw_scan
Date: Fri, 9 Aug 2024 09:58:41 +0800
Message-ID: <20240809015841.2671448-1-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nqD8XbVpepE96o3-4bk_np5UcXGbXVAT
X-Proofpoint-GUID: nqD8XbVpepE96o3-4bk_np5UcXGbXVAT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_25,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408090013

Fix the following W=1 kernel build warning:

drivers/net/wireless/ath/ath12k/mac.c: In function ‘ath12k_mac_op_hw_scan’:
drivers/net/wireless/ath/ath12k/mac.c:3806:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 54 +++++++++++++++------------
 1 file changed, 30 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 8106297f0bc1..37edf9f7c78c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -3664,7 +3664,7 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	struct ath12k *ar, *prev_ar;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	struct cfg80211_scan_request *req = &hw_req->req;
-	struct ath12k_wmi_scan_req_arg arg = {};
+	struct ath12k_wmi_scan_req_arg *arg = NULL;
 	int ret;
 	int i;
 	bool create = true;
@@ -3746,42 +3746,47 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;
 
-	ath12k_wmi_start_scan_init(ar, &arg);
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH12K_SCAN_ID;
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ath12k_wmi_start_scan_init(ar, arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH12K_SCAN_ID;
 
 	if (req->ie_len) {
-		arg.extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
-		if (!arg.extraie.ptr) {
+		arg->extraie.ptr = kmemdup(req->ie, req->ie_len, GFP_KERNEL);
+		if (!arg->extraie.ptr) {
 			ret = -ENOMEM;
 			goto exit;
 		}
-		arg.extraie.len = req->ie_len;
+		arg->extraie.len = req->ie_len;
 	}
 
 	if (req->n_ssids) {
-		arg.num_ssids = req->n_ssids;
-		for (i = 0; i < arg.num_ssids; i++)
-			arg.ssid[i] = req->ssids[i];
+		arg->num_ssids = req->n_ssids;
+		for (i = 0; i < arg->num_ssids; i++)
+			arg->ssid[i] = req->ssids[i];
 	} else {
-		arg.scan_f_passive = 1;
+		arg->scan_f_passive = 1;
 	}
 
 	if (req->n_channels) {
-		arg.num_chan = req->n_channels;
-		arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
-					GFP_KERNEL);
-
-		if (!arg.chan_list) {
+		arg->num_chan = req->n_channels;
+		arg->chan_list = kcalloc(arg->num_chan, sizeof(*arg->chan_list),
+					 GFP_KERNEL);
+		if (!arg->chan_list) {
 			ret = -ENOMEM;
 			goto exit;
 		}
 
-		for (i = 0; i < arg.num_chan; i++)
-			arg.chan_list[i] = req->channels[i]->center_freq;
+		for (i = 0; i < arg->num_chan; i++)
+			arg->chan_list[i] = req->channels[i]->center_freq;
 	}
 
-	ret = ath12k_start_scan(ar, &arg);
+	ret = ath12k_start_scan(ar, arg);
 	if (ret) {
 		ath12k_warn(ar->ab, "failed to start hw scan: %d\n", ret);
 		spin_lock_bh(&ar->data_lock);
@@ -3791,14 +3796,15 @@ static int ath12k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	/* Add a margin to account for event/command processing */
 	ieee80211_queue_delayed_work(ath12k_ar_to_hw(ar), &ar->scan.timeout,
-				     msecs_to_jiffies(arg.max_scan_time +
+				     msecs_to_jiffies(arg->max_scan_time +
 						      ATH12K_MAC_SCAN_TIMEOUT_MSECS));
 
 exit:
-	kfree(arg.chan_list);
-
-	if (req->ie_len)
-		kfree(arg.extraie.ptr);
+	if (arg) {
+		kfree(arg->chan_list);
+		kfree(arg->extraie.ptr);
+		kfree(arg);
+	}
 
 	mutex_unlock(&ar->conf_mutex);
 
-- 
2.25.1


