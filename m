Return-Path: <linux-wireless+bounces-12224-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC09654E7
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 03:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00111F2422F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 01:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C373D2C18C;
	Fri, 30 Aug 2024 01:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kB5wzqLl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CCE6CDBA
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 01:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983029; cv=none; b=YeP444SzimAY1h3jxkDmd5/v0IBBwapNaqBaGSzybe8xqxpC4qsMOxgLiViQnIVzZMLXaTwxkWf31rSxf3UZ+ezRg8dUOMIh2vpjB02QMcOuZ1XojdSPQ4QXU3Uykd9QI9H+3fOHxqLNKhDVeeYwoi9cOY7Tt+pR/BnHoP9AW2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983029; c=relaxed/simple;
	bh=JXxp0aJSxBgQ+tbEjrST/fYrzbwlsYQYUgyncTjMSg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bnGvaCNao+FQr8tJkeA9RUeIdc8bzhbZeIhTklfZuJq0RzhOupBbj3I9QhQ8FSSiM6M7uUT3uHa49eqUVKdaFDoyq7KJiq8j3jVOabJwLg0GvTgXhcvKxELygLlFWp/2I4xxGA8m32OVsYFI8x7ib5TD+hqKYqpZ34XuIfWb9oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kB5wzqLl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TNNR56025857;
	Fri, 30 Aug 2024 01:57:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9FNUXs55L6FPOGeQppdseA
	QdixfkkyD+EfcdGOUY7S4=; b=kB5wzqLlrMqOxaqixtmsTTHVvGC4yazc+8NJPX
	5ZfMfNVFsGBOQGeT4aRcP0Qd8TapN6rGoj0ezqU2PiZat67ch6XZyrWP+s9nS92L
	IB2Tf0iHHxZ6EYl8iPamNh13yTtveR8qSvhHr/tM6Vrh5y/utmes1cZUkfIgNTVj
	xYdFytjWEDuW9C5t3rxG705AwcK/XFTDrazqrIYyYrjXjzqD82HsIEdMtk+F7UoI
	rnoq1rCOTU/TfeZD9RmFC/RHaqi+OnHacvlRVcIL4q+sGgxEMgHkpxTAgSiXiFVW
	syPxtxVVGrR/imilLhk11RVDPrKOqmycgnZhnIJCDMK2quJA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41arax2174-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 01:57:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U1v0dX001064
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 01:57:00 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 29 Aug 2024 18:56:58 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath10k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH] wifi: ath10k: fix the stack frame size warning in ath10k_hw_scan
Date: Fri, 30 Aug 2024 09:56:49 +0800
Message-ID: <20240830015649.1083758-1-quic_miaoqing@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SeZC64OIH2DFmfHblPH4PwKTYK_WeV8J
X-Proofpoint-GUID: SeZC64OIH2DFmfHblPH4PwKTYK_WeV8J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 priorityscore=1501 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300013

Fix the following W=1 kernel build warning:

drivers/net/wireless/ath/ath10k/mac.c: In function ‘ath10k_hw_scan’:
drivers/net/wireless/ath/ath10k/mac.c:6468:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Compile tested only.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 59 +++++++++++++++------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index a5da32e87106..9772f2c18ba1 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6369,7 +6369,7 @@ static int ath10k_hw_scan(struct ieee80211_hw *hw,
 	struct ath10k *ar = hw->priv;
 	struct ath10k_vif *arvif = (void *)vif->drv_priv;
 	struct cfg80211_scan_request *req = &hw_req->req;
-	struct wmi_start_scan_arg arg;
+	struct wmi_start_scan_arg *arg = NULL;
 	int ret = 0;
 	int i;
 	u32 scan_timeout;
@@ -6402,56 +6402,61 @@ static int ath10k_hw_scan(struct ieee80211_hw *hw,
 	if (ret)
 		goto exit;
 
-	memset(&arg, 0, sizeof(arg));
-	ath10k_wmi_start_scan_init(ar, &arg);
-	arg.vdev_id = arvif->vdev_id;
-	arg.scan_id = ATH10K_SCAN_ID;
+	arg = kzalloc(sizeof(*arg), GFP_KERNEL);
+	if (!arg) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ath10k_wmi_start_scan_init(ar, arg);
+	arg->vdev_id = arvif->vdev_id;
+	arg->scan_id = ATH10K_SCAN_ID;
 
 	if (req->ie_len) {
-		arg.ie_len = req->ie_len;
-		memcpy(arg.ie, req->ie, arg.ie_len);
+		arg->ie_len = req->ie_len;
+		memcpy(arg->ie, req->ie, arg->ie_len);
 	}
 
 	if (req->n_ssids) {
-		arg.n_ssids = req->n_ssids;
-		for (i = 0; i < arg.n_ssids; i++) {
-			arg.ssids[i].len  = req->ssids[i].ssid_len;
-			arg.ssids[i].ssid = req->ssids[i].ssid;
+		arg->n_ssids = req->n_ssids;
+		for (i = 0; i < arg->n_ssids; i++) {
+			arg->ssids[i].len  = req->ssids[i].ssid_len;
+			arg->ssids[i].ssid = req->ssids[i].ssid;
 		}
 	} else {
-		arg.scan_ctrl_flags |= WMI_SCAN_FLAG_PASSIVE;
+		arg->scan_ctrl_flags |= WMI_SCAN_FLAG_PASSIVE;
 	}
 
 	if (req->flags & NL80211_SCAN_FLAG_RANDOM_ADDR) {
-		arg.scan_ctrl_flags |=  WMI_SCAN_ADD_SPOOFED_MAC_IN_PROBE_REQ;
-		ether_addr_copy(arg.mac_addr.addr, req->mac_addr);
-		ether_addr_copy(arg.mac_mask.addr, req->mac_addr_mask);
+		arg->scan_ctrl_flags |=  WMI_SCAN_ADD_SPOOFED_MAC_IN_PROBE_REQ;
+		ether_addr_copy(arg->mac_addr.addr, req->mac_addr);
+		ether_addr_copy(arg->mac_mask.addr, req->mac_addr_mask);
 	}
 
 	if (req->n_channels) {
-		arg.n_channels = req->n_channels;
-		for (i = 0; i < arg.n_channels; i++)
-			arg.channels[i] = req->channels[i]->center_freq;
+		arg->n_channels = req->n_channels;
+		for (i = 0; i < arg->n_channels; i++)
+			arg->channels[i] = req->channels[i]->center_freq;
 	}
 
 	/* if duration is set, default dwell times will be overwritten */
 	if (req->duration) {
-		arg.dwell_time_active = req->duration;
-		arg.dwell_time_passive = req->duration;
-		arg.burst_duration_ms = req->duration;
+		arg->dwell_time_active = req->duration;
+		arg->dwell_time_passive = req->duration;
+		arg->burst_duration_ms = req->duration;
 
-		scan_timeout = min_t(u32, arg.max_rest_time *
-				(arg.n_channels - 1) + (req->duration +
+		scan_timeout = min_t(u32, arg->max_rest_time *
+				(arg->n_channels - 1) + (req->duration +
 				ATH10K_SCAN_CHANNEL_SWITCH_WMI_EVT_OVERHEAD) *
-				arg.n_channels, arg.max_scan_time);
+				arg->n_channels, arg->max_scan_time);
 	} else {
-		scan_timeout = arg.max_scan_time;
+		scan_timeout = arg->max_scan_time;
 	}
 
 	/* Add a 200ms margin to account for event/command processing */
 	scan_timeout += 200;
 
-	ret = ath10k_start_scan(ar, &arg);
+	ret = ath10k_start_scan(ar, arg);
 	if (ret) {
 		ath10k_warn(ar, "failed to start hw scan: %d\n", ret);
 		spin_lock_bh(&ar->data_lock);
@@ -6463,6 +6468,8 @@ static int ath10k_hw_scan(struct ieee80211_hw *hw,
 				     msecs_to_jiffies(scan_timeout));
 
 exit:
+	kfree(arg);
+
 	mutex_unlock(&ar->conf_mutex);
 	return ret;
 }
-- 
2.25.1


