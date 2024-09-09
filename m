Return-Path: <linux-wireless+bounces-12640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2E970FDE
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 09:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1178A1F22BB4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF6B1AED5E;
	Mon,  9 Sep 2024 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i0FzUQbV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4961AF4F7
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867086; cv=none; b=sFoQD/atJlESp/yKrqijIyxRA1JQje0nLOVNpNi9p+AmAgjK13vot+ranjiunAmBIXpZ1rajkbXNtOYhQSjzOoh1rSxAEqGOC4bwA0Fzk9MCFKI9T+xvskruUKyb4x4qY80040nwliLnBDRTHV3wBHV0HsnX5H38APV60UTpcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867086; c=relaxed/simple;
	bh=GVbQdO3s9x3rflVV7KPsfX6idw3rNrnk0MvszSdTreQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mTLgOPIbT7rmtKNoeDPoBcBT7lpth3edMKqE4xW9/WgwMVu2RGMU+NDSl1fHTtkOaf3tAQz8GDt9Re/EQ+c/iwsiDMBkkt+UL260Nnljj/obLP1W6yDR1eiXeihooCHS21+URv74mKABb0Tf3fHGbtYvq1t37fW5RXxiBlnbIN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i0FzUQbV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 488NBm4J021696;
	Mon, 9 Sep 2024 07:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Z63XzYst1xSC3ukSs3PBTa9crJST8EJ2iKc
	YHaHR71M=; b=i0FzUQbVutduzeK5fV7bq3Ru80LRgnMfd+vjmanShAEjfTbtgtp
	3RBt5am+GSCtXGMIP+Out5iA1bWrTq/2peOBlB0FqpiR+bFjyWOAfOe48w549AY/
	cYB/Xb2TVBu21sGEOmDC+vPer/wzfqtn0iWoslAJrozoSO+8ZoE/3O4yFMTwmVTc
	a3xjEVB3WPn2Illv6p06M37yVKUyzOtC2LtrtB56N3uETDCsZRqwTs29NGooPZwk
	FZ/3BJWOXfWHeCktAJyNJUo5H8AkgMjQYQPcBhQiwvzQ4/Ro6UNtfggT6gKjN9qn
	ixIGtlJA1hccEY91HZPoN4XhBGHJK9mIM+w==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gybpj224-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 07:31:20 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4897VGx2027478;
	Mon, 9 Sep 2024 07:31:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 41h0eqtrnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 07:31:16 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4897VGJZ027458;
	Mon, 9 Sep 2024 07:31:16 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-santrame-blr.qualcomm.com [10.190.109.189])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4897VGbN027457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 07:31:16 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4399736)
	id 9D835414D1; Mon,  9 Sep 2024 13:01:15 +0530 (+0530)
From: Santhosh Ramesh <quic_santrame@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <quic_murugana@quicinc.com>,
        Santhosh Ramesh <quic_santrame@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix tx power, max reg power update to firmware
Date: Mon,  9 Sep 2024 13:00:49 +0530
Message-Id: <20240909073049.3423035-1-quic_santrame@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pl4zqrVhgdmBKtRlsu88Wu5Q8C5uQzPr
X-Proofpoint-GUID: pl4zqrVhgdmBKtRlsu88Wu5Q8C5uQzPr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090058

From: Sathishkumar Muruganandam <quic_murugana@quicinc.com>

Currently, when the vdev start WMI cmd is sent from host, vdev related
parameters such as max_reg_power, max_power, and max_antenna_gain are
multiplied by 2 before being sent to the firmware. This is incorrect
because the firmware uses 1 dBm steps for power calculations.

This leads to incorrect power values being used in the firmware and
radio, potentially causing incorrect behavior.

Fix the update of max_reg_power, max_power, and max_antenna_gain values
in the ath12k_mac_vdev_start_restart function, ensuring accurate
power settings in the firmware by sending these values as-is,
without multiplication.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sathishkumar Muruganandam <quic_murugana@quicinc.com>
Signed-off-by: Santhosh Ramesh <quic_santrame@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 137394c36460..6d7a005d83b4 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7217,9 +7217,9 @@ ath12k_mac_vdev_start_restart(struct ath12k_vif *arvif,
 							chandef->chan->band,
 							arvif->vif->type);
 	arg.min_power = 0;
-	arg.max_power = chandef->chan->max_power * 2;
-	arg.max_reg_power = chandef->chan->max_reg_power * 2;
-	arg.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
+	arg.max_power = chandef->chan->max_power;
+	arg.max_reg_power = chandef->chan->max_reg_power;
+	arg.max_antenna_gain = chandef->chan->max_antenna_gain;
 
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;

base-commit: 903aaf66edc97dd5b9e3118d19677291051a9c40
-- 
2.34.1


