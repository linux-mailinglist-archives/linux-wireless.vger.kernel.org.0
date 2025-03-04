Return-Path: <linux-wireless+bounces-19750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9B9A4D957
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51833164397
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBFC1FCFDF;
	Tue,  4 Mar 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fwUDuUAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249451EE7AD
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082054; cv=none; b=XhyriuVfwji4JTC3bp1qaISyAEZ1OIoU4s5NCriAPAiZg0b3smCTXtmY7C75DgjwViaLxoka76ZfuS2FRgQcyED17Q2owZkyupe9b2+OLIY89w/lMCcxi94yukMdVTmvYLk9L0Ex/rSOASNU6qoZTOJDeLOmv5da32dubr3+K6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082054; c=relaxed/simple;
	bh=bQScljsUmdirIZMPyooExCI9NHSTYuNlEd6cUPUkTjg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpYmu/+qytT7Q74Is/L7oETT2y+oMDIvArmWJFpaxDxKLUHcsy2us2lYPhgpQiqw+uug6W3YEfOmNRZEBLsrCWWoLfivBNTxHgv58RLCh60AKH4sFOrX9Q68SfSNFru4OOLB4eTRJEKADPho1NVZLo10/hTUUWDe8cRM9HfOcpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fwUDuUAW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NX2iJ006094;
	Tue, 4 Mar 2025 09:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+vF1vOrDQrPRErNKglAAPZzOL/2e3RmComRmytqagoc=; b=fwUDuUAWu1o3/I/l
	t/tz995cooS4yuO/8cu4R26++F+RJTr428IfwlQ2vNdDm/il9Qu9gwsT4NXg/8cP
	iqwlDD2IcvNjK11qwhvpm0YMeNjnhqz7/pn3u3NHD10Is4vhXqha2vJJR6LCprmr
	N/bfShKpJvWUuuNdA0kSxi8VnpPw5H6du62kD7xb9lKHYDx6KLmni3A6zwfcVu/R
	Hwl4QuCGATzt+Dp6o9oqVMomozKv+uyiCNB+9/XfLyLgcHPgjVWEb1zOoC7SLC+V
	dXqkMrPXkKDGU5yeIzC37t8EYc8KFdut+sEfXgLgDQzK4Ms+AUGRnJ4GKBWU+B0p
	1dUrDQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6the83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:54:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5249s9oq029438
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 09:54:09 GMT
Received: from hu-surapk-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 01:54:07 -0800
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Suraj P Kizhakkethil
	<quic_surapk@quicinc.com>
Subject: [PATCH v2 1/2] wifi: ath12k: Pass correct values of center freq1 and center freq2 for 160 MHz
Date: Tue, 4 Mar 2025 15:23:14 +0530
Message-ID: <20250304095315.3050325-2-quic_surapk@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304095315.3050325-1-quic_surapk@quicinc.com>
References: <20250304095315.3050325-1-quic_surapk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c6cdc2 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=JoUBYU7c8MG1E7uCwVEA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZS1ta2cA_HhlM__yBx8TBo3id6v-_vmP
X-Proofpoint-ORIG-GUID: ZS1ta2cA_HhlM__yBx8TBo3id6v-_vmP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040083

Currently, for 160 MHz bandwidth, center frequency1 and
center frequency2 are not passed correctly to the firmware.
Set center frequency1 as the center frequency
of the primary 80 MHz channel segment and center frequency2 as
the center frequency of the 160 MHz channel and pass the values
to the firmware.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 6d1ea5f3a791..bed8c24aef20 100644
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
-	chan->band_center_freq1 = cpu_to_le32(arg->band_center_freq1);
-	if (arg->mode == MODE_11AC_VHT80_80)
+	chan->band_center_freq1 = cpu_to_le32(center_freq1);
+	if (arg->mode == MODE_11BE_EHT160) {
+		if (arg->freq > center_freq1)
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 + 40);
+		else
+			chan->band_center_freq1 = cpu_to_le32(center_freq1 - 40);
+
+		chan->band_center_freq2 = cpu_to_le32(center_freq1);
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


