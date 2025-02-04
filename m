Return-Path: <linux-wireless+bounces-18377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA608A26B6F
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D7D3A6EEB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 05:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9147F19ADA4;
	Tue,  4 Feb 2025 05:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UllazbF8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950919B5A9
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 05:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738647331; cv=none; b=INvQnlE3tGQYKyrlP+OA0+byWD/rICrWAk6W7EfGKALfBjnicXHlzgVSI6d5ZRsd+YXcik0PguV4ZmlF+sIqgm8HW/RdMkRoeHTigKECcOxlbtQcRoHw/pxJBfv/3y5aCKTIQ8/mEb2GbdeMlXuvOZoMuteXkBCEDrPETr4rE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738647331; c=relaxed/simple;
	bh=2s/ZfhhjSmmFmrpADLTYjAn87/294AcDvZCZLIRdCD8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpvb5FAT9tJY15HKQhIDNBibbUKyh22ECrp+IYvTeci4DIu+/VKrU/MzVCcN/3S+doaxr61yIGQi5nMh4EcuBEUzSaQzxtNmlKdKKmbO8s2BKYM+0k6aYn6Y0b279wA7hE9j5B/RracfyogFCLk1aZjVtZ8CmUrAxhk1lIdSlW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UllazbF8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51457l4N007884;
	Tue, 4 Feb 2025 05:35:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mnuMkCTVXu5UeKaSUwz9cY8BRcQVw1EbU5gqxKwtCA8=; b=UllazbF8T361eyL4
	fslOreHN69FWILx7E38FKqf/uCDCY74APjeemQrPvQcnlqUafE6vSx5XbxdoIh3o
	9v2u39QTztuNL0hDmyatFB+esyV5UIwbLchQrjDPRNkYpv2xk/Etctl9sdyuML4p
	5rNB16kcZ8Twxs64rieaa6u1y4TgvE18CbefTDqKqw7D5tlJB0p3Fp5yX3Urb5Lo
	NJlJblfohnym/e+f7TqwGUiMYaBoVR4nc6D5KG+p8dDxmmcOtF/myj6gDMdjkIl4
	eDtO1tjzVT3OqMUoZR+YcEnPWSGjimXX9RQO4DOftxDn33uove5HxazT+Eqtkk2Y
	Dkngtg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcfp01rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 05:35:26 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5145ZP9m026842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 05:35:25 GMT
Received: from hu-surapk-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 21:35:24 -0800
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Sriram R <quic_srirrama@quicinc.com>,
        Suraj P Kizhakkethil <quic_surapk@quicinc.com>
Subject: [PATCH 2/2] wifi: ath12k: Pass correct values of center freq1 and center freq2 for 320 MHz
Date: Tue, 4 Feb 2025 11:04:51 +0530
Message-ID: <20250204053451.2703834-3-quic_surapk@quicinc.com>
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
X-Proofpoint-GUID: WGP6YD1UwJajc3SA8ueXWXjXZb0Zu1nE
X-Proofpoint-ORIG-GUID: WGP6YD1UwJajc3SA8ueXWXjXZb0Zu1nE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040043

From: Sriram R <quic_srirrama@quicinc.com>

Currently, for 320 MHz bandwidth, center frequency1 and
center frequency2 are not passed correctly to the firmware.
Set center frequency1 as the center frequency of the
primary 160 MHz channel segment and center frequency2 as the center
frequency of the 320 MHz channel and pass the values
to the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 848a65268194..982bdfc4902f 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -1043,7 +1043,15 @@ static void ath12k_wmi_put_wmi_channel(struct ath12k_wmi_channel_params *chan,
 
 	chan->mhz = cpu_to_le32(arg->freq);
 	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	if (arg->mode == MODE_11BE_EHT160) {
+	if (arg->mode == MODE_11BE_EHT320) {
+		if (arg->freq > arg->band_center_freq1)
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 80);
+		else
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 80);
+
+		chan->band_center_freq2 = cpu_to_le32(arg->band_center_freq1);
+
+	} else if (arg->mode == MODE_11BE_EHT160) {
 		if (arg->freq > arg->band_center_freq1)
 			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
 		else
-- 
2.34.1


