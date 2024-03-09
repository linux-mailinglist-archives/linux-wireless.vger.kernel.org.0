Return-Path: <linux-wireless+bounces-4506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED708770AA
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4A0281B0A
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4AB364A8;
	Sat,  9 Mar 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MT101XZK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B65C8B
	for <linux-wireless@vger.kernel.org>; Sat,  9 Mar 2024 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709983899; cv=none; b=BViC6w0vIvefDdLKc8gjw/oCoYl1chM9N2pgEove5ra7vJ5Ohn2FS77CpiLiOUUWZzRLLuNA/0TAcZRCkE4zHqMqc3hOY5n2zbjVC3KAJFccLstVByhU/7UYX4Eg17FCl9JkKgiJoX1x1U70LGodIHUL2im0qz5DzD0ELyX3S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709983899; c=relaxed/simple;
	bh=+4hzvJN8DYLSpCPeXE68462T5eW8VNCw3ueaJlUjxQs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jaPcCYPovA9M4ELTekl7wzWwF2afqNUxzZkKwx3CJt7lRdiMpnAh0JEcdKryzmLO5/Tv5XFSMqDlPmr/6SimYxR9WLbyGtdJiqB832N9g1npSZ71pKTl4RGO9JUzlAE4sVgsn1TbqrQkxxcpTaE78OINPSpcqpUOuhUiyAfBmtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MT101XZK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 429BJ1nc013375;
	Sat, 9 Mar 2024 11:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=+wyx/Vh
	Gct4tBH0Mou0Kr9MyBVWlStejrsiczgJZsiA=; b=MT101XZK6YLmPkfBiMU2d9t
	Jm4pH5rdFiQ/bCDTPei6vBmBfHzVfRSCiqmUHj6gFtEZhk80nBpEbY1WilCw3rgW
	c9NtL/ymzB2PGnlLJRSuhN39nv+nerBYy1wW38lMu2fDbMpjzbt625HV6jQbE8bL
	4qWmzLj/ttTySF9sKXxiKxjPeof8gezXURaqFvlDuL8M8ddzDxOBtM3kt28xVkrR
	XyVlZyjNRw9Mgeid4yg5v+RFMiEOJSxMq+LnKFYRdWBB2Lej0Q5T4r1DwOJZQ/xo
	ROiN6oo64TXbo346xJ7kVkWorpUL/DP0TBr4dsVBXb33uFgx3G1Nf7qe0V5RN1Q=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wrg5b0dwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 Mar 2024 11:31:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 429BVSCs003955
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 Mar 2024 11:31:28 GMT
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Mar 2024 03:31:27 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath11k: don't force enable power save on non-running vdevs
Date: Sat, 9 Mar 2024 19:31:15 +0800
Message-ID: <20240309113115.11498-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-GUID: QMr27MUFxRgrmnh_kk8i3YnMjow-HylW
X-Proofpoint-ORIG-GUID: QMr27MUFxRgrmnh_kk8i3YnMjow-HylW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403090092

Currently we force enable power save on non-running vdevs, this results
in unexpected ping latency in below scenarios:
	1. disable power save from userspace.
	2. trigger suspend/resume.

With step 1 power save is disabled successfully and we get a good latency:

PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=5.13 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=5.45 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=5.99 ms
64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=6.34 ms
64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=4.47 ms
64 bytes from 192.168.1.1: icmp_seq=6 ttl=64 time=6.45 ms

While after step 2, the latency becomes much larger:

PING 192.168.1.1 (192.168.1.1) 56(84) bytes of data.
64 bytes from 192.168.1.1: icmp_seq=1 ttl=64 time=17.7 ms
64 bytes from 192.168.1.1: icmp_seq=2 ttl=64 time=15.0 ms
64 bytes from 192.168.1.1: icmp_seq=3 ttl=64 time=14.3 ms
64 bytes from 192.168.1.1: icmp_seq=4 ttl=64 time=16.5 ms
64 bytes from 192.168.1.1: icmp_seq=5 ttl=64 time=20.1 ms

The reason is, with step 2, power save is force enabled due to vdev not
running, although mac80211 was trying to disable it to honor userspace
configuration:

ath11k_pci 0000:03:00.0: wmi cmd sta powersave mode psmode 1 vdev id 0
Call Trace:
 ath11k_wmi_pdev_set_ps_mode
 ath11k_mac_op_bss_info_changed
 ieee80211_bss_info_change_notify
 ieee80211_reconfig
 ieee80211_resume
 wiphy_resume

This logic is taken from ath10k where it was added due to below comment:

	Firmware doesn't behave nicely and consumes more power than
	necessary if PS is disabled on a non-started vdev.

However we don't know whether such an issue also occurs to ath11k firmware
or not. But even if it does, it's not appropriate because it goes against
userspace, even cfg/mac80211 don't know we have enabled it in fact.

Remove it to fix this issue. In this way we not only get a better latency,
but also, and the most important, keeps the consistency between userspace
and kernel/driver. The biggest price for that would be the power consumption,
which is not that important, compared with the consistency.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30

Fixes: b2beffa7d9a6 ("ath11k: enable 802.11 power save mode in station mode")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a6a37d67a50a..42a6a51a6a9d 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1231,14 +1231,7 @@ static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
 
 	enable_ps = arvif->ps;
 
-	if (!arvif->is_started) {
-		/* mac80211 can update vif powersave state while disconnected.
-		 * Firmware doesn't behave nicely and consumes more power than
-		 * necessary if PS is disabled on a non-started vdev. Hence
-		 * force-enable PS for non-running vdevs.
-		 */
-		psmode = WMI_STA_PS_MODE_ENABLED;
-	} else if (enable_ps) {
+	if (enable_ps) {
 		psmode = WMI_STA_PS_MODE_ENABLED;
 		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
 

base-commit: 7a5ed5a3801e9b6cf7bafbb0a05c70cef620b22a
-- 
2.25.1


