Return-Path: <linux-wireless+bounces-18375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFDCA26B6E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 996817A3E51
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA828632C;
	Tue,  4 Feb 2025 05:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kaVknL0V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8D19B5A9
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647328; cv=none; b=nNW5Rk69Bc4K9C9MKMdw3jrWSuonN9ZwA3DvIrSTKV9zlO8V/6k1NMoTadZX+sm/oBu5so4/+iULirxkBSVelPQXIgyxD5TViAcrnpLf8wkD1iATQwBGam5AgHketydvhrixWikbePSkjVchJcLiwLvzVYWhih4xNA0aGIeqI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647328; c=relaxed/simple;
	bh=zh8KDBc51EQwNqPECiycWxvH1+sbjdsVOvOuoQy14V4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jEayWkeydn8sk0jULOHS/S4fwob9NUFH9WDzibHuhwG0Ol4b8pIJYV9/J3M2ArmoDxuvrVBql/71MGUvIo2eKhgkeTGWvQ8Ta/Ag2joVgrDn2cw4lnsnXL08dWyxQWlrp0+VpBdHuC9Oc93RLn/j67lcH9RwXWlIP/wE3FK0sPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kaVknL0V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513KQmY6027045;
	Tue, 4 Feb 2025 05:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZmO7ibLXAi5oB2uIK3WSFCe/c0foBv16j8IkzgabKO0=; b=kaVknL0VhaOESTNZ
	FCWU7JumRnFPEeNFbxm6h9tgr/OurIQ5MQjDk6M+0e4VI8k0t35NWnqn9hNN+BQS
	p/hY1pGjFrY8SikSoW+30HUURxvSw+suVVh3FBpDr7NVSFOjiE4g8dBux45qZj30
	BtGjU7TmM1T2O6//hVyP92oaDmwDltSFbQKSaYaZgibGeqx3ORbzi+0QZpIZjjCc
	1YRFzWKfiIhvqH7InkaCli8K3b7Mvy2cxmcro29feobP7E7pDBBHTWIo0uq147Qf
	8Gefjyl0OVYD14m8QZM/y69ArfAMAvVLNzgJFl9ydy5GUlwUeKzqmIkfErrCoYVG
	4lrbHA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44k4ufrxr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 05:35:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5145ZNpU003638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 05:35:23 GMT
Received: from hu-surapk-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 21:35:22 -0800
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Suraj P Kizhakkethil
	<quic_surapk@quicinc.com>
Subject: [PATCH 1/2] wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz
Date: Tue, 4 Feb 2025 11:04:50 +0530
Message-ID: <20250204053451.2703834-2-quic_surapk@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204053451.2703834-1-quic_surapk@quicinc.com>
References: <20250204053451.2703834-1-quic_surapk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hQ8dS3u3fagN1mYdrrZo5wXKzR7ObDsC
X-Proofpoint-ORIG-GUID: hQ8dS3u3fagN1mYdrrZo5wXKzR7ObDsC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 adultscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502040043

Currently, for 160 MHz bandwidth, center frequency1 and
center frequency2 are not passed correctly to the firmware.
Set center frequency1 as the center frequency
of the primary 80 MHz channel segment and center frequency2 as
the center frequency of the 160 MHz channel and pass the values
to the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index f934d49acee6..848a65268194 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1037,14 +1037,24 @@ int ath12k_wmi_vdev_down(struct ath12k *ar, u8 vdev_id)
 static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 				       struct wmi_vdev_start_req_arg *arg)
 {
+	u32 center_freq1 = arg->band_center_freq1;
+
 	memset(chan, 0, sizeof(*chan));
 
 	chan->mhz = cpu_to_le32(arg->freq);
 	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	if (arg->mode == MODE_11AC_VHT80_80)
+	if (arg->mode == MODE_11BE_EHT160) {
+		if (arg->freq > arg->band_center_freq1)
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
+		else
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 40);
+
+		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq1);
+	} else if (arg->mode == MODE_11BE_EHT80_80) {
 		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq2);
-	else
+	} else {
 		chan->band_center_freq2 = 0;
+	}
 
 	chan->info |= le32_encode_bits(arg->mode, WMI_CHAN_INFO_MODE);
 	if (arg->passive)
-- 
2.34.1


