Return-Path: <linux-wireless+bounces-7830-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796D78C97FF
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 04:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 178481F20C85
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2024 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9534BA40;
	Mon, 20 May 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WfQBr1t/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2D0BE71
	for <linux-wireless@vger.kernel.org>; Mon, 20 May 2024 02:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716172942; cv=none; b=Yt6lavHL/f4H+cySn5EP4Q8od6ZxDj/FBVnnV9b4PE7QrcSwOnghfh/J0eSwB9LmSlNr0KBNqov9kjYVsSDaDjTABnWCvmfRe7D7674bxHs06uiDVHMsc/34lt7LoYvzfZdfH/rK9e7lSO9dsL9f9c8YkfO+A0upf53hqCFZ5yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716172942; c=relaxed/simple;
	bh=u0mqGVT6XuDndkJOdFoGkykxK0tZTfZ/s4aLZ0/q8Ac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qrd+iF+6k/h/0bL3uoHbje9IOW/leXVliXlLluflwQk/yO9o2yoZsD/bUoMR+bXcTKH3JE/c0tcc4tGkJtyhRvPzSV5fR1QyFbt46UHiUWGqt1gwPJF/l9d/fV/Aw5wxCnEfUq9GwGYMlEv/a/c6KMoO3ljKpyv10eNh+2TEkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WfQBr1t/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K09tOo030101;
	Mon, 20 May 2024 02:42:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=CE1K8UcLSq3GWP9jj2cZdtOP0dr8WlbdGb+dwpNHe00=; b=Wf
	QBr1t/8zcuXDUVFi31L/9Be1U5LqmfjM7bT9DS2iyn2jmBeSAgYAgSBt+xzmUius
	ig5QnzDvdZm7q02Qw7vlg1Li1GcCMvDO76Q4V9xQUbLDT3MmSlzsozUPWC6zZ2NA
	/a2ZMsZRAHkKoow5oIfmNWZn0PczB5d7gLfNWiVbKn3aFwZr7sPO4T5+BVrYTWSJ
	TfAr8w5/E3Qk8Omdl+2ZsJaYe6XmXcacPU7QlNiEJC85hxaIYB1HqNM13g9ovsl0
	9qIj/iN9BayOBurYSmpvlbtfoXaZlr0KLg/EImLOz6SJizkIKPhyXsBhQbRwQabX
	mlTy25/xPphNXIAYXwBA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n4p2h29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 02:42:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K2g2TD006335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 02:42:02 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 19:42:00 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 2/2] wifi: ath11k: restore country code during resume
Date: Mon, 20 May 2024 10:41:48 +0800
Message-ID: <20240520024148.5472-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520024148.5472-1-quic_bqiang@quicinc.com>
References: <20240520024148.5472-1-quic_bqiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ng7QPluz6qzQhjIs7qTwnXsYwkkZdaOo
X-Proofpoint-GUID: Ng7QPluz6qzQhjIs7qTwnXsYwkkZdaOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-19_12,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0
 impostorscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200019

We got report that regdomain is not correct after
return from hibernation:

Before hibernation:
% iw reg get
[...]
phy#0 (self-managed)
country CH: DFS-ETSI
        (2402 - 2482 @ 40), (N/A, 20), (N/A)
        (5170 - 5250 @ 80), (N/A, 23), (N/A), NO-OUTDOOR, AUTO-BW
        (5250 - 5330 @ 80), (N/A, 23), (0 ms), NO-OUTDOOR, DFS, AUTO-BW
        (5490 - 5590 @ 80), (N/A, 30), (0 ms), DFS, AUTO-BW
        (5590 - 5650 @ 40), (N/A, 30), (600000 ms), DFS, AUTO-BW
        (5650 - 5730 @ 80), (N/A, 30), (0 ms), DFS, AUTO-BW
        (5735 - 5875 @ 80), (N/A, 14), (N/A), AUTO-BW

After hibernation:
% iw reg get
[...]
phy#0 (self-managed)
country na: DFS-UNSET
        (2402 - 2472 @ 40), (N/A, 20), (N/A)
        (2457 - 2482 @ 20), (N/A, 20), (N/A), PASSIVE-SCAN
        (5170 - 5330 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5490 - 5730 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5735 - 5895 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5945 - 7125 @ 160), (N/A, 30), (N/A), AUTO-BW, PASSIVE-SCAN

The reason is, during resume, firmware is reinitialized but host does
not send current country code to firmware. So default reg rules with
country code set to 'na' is uploaded to host, as shown above.

Fix it by restoring country code to firmware during resume.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: 166a490f59ac ("wifi: ath11k: support hibernation")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 748e3ad2bec3..3772e64d4976 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1009,6 +1009,16 @@ int ath11k_core_resume(struct ath11k_base *ab)
 		return -ETIMEDOUT;
 	}
 
+	if (ab->hw_params.current_cc_support &&
+	    ar->alpha2[0] != 0 && ar->alpha2[1] != 0) {
+		ret = ath11k_reg_set_cc(ar);
+		if (ret) {
+			ath11k_warn(ab, "failed to set country code during resume: %d\n",
+				    ret);
+			return ret;
+		}
+	}
+
 	ret = ath11k_dp_rx_pktlog_start(ab);
 	if (ret)
 		ath11k_warn(ab, "failed to start rx pktlog during resume: %d\n",
-- 
2.25.1


