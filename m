Return-Path: <linux-wireless+bounces-24020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B52AD6520
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 03:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039B63ABE2A
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 01:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209854758;
	Thu, 12 Jun 2025 01:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W9OX/VWs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E26847B;
	Thu, 12 Jun 2025 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749691931; cv=none; b=DnxsoOKRA1rpnsXVjPTcVrjSaDj9icgIvyyFnHkteSRSxAjFcaAdNiEzBnPcdB0YSo04SAnMlSSxGgdDPhmFlPdjhOGq9aofyxA+Ev+1Lq/ZL/VEYwMsgwjJ13eha7fil6M9mU3CCgAJujgOCJ+fPeOhVufsF8cX2t0zifpVMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749691931; c=relaxed/simple;
	bh=HWCkbxMgjAoLsZ1Gl3Xp7a1xv8OeGMZlBxx47ZdiqrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RK+SDliI6PmgLnJMcdMjHZnOkySdiODnrk49cbVwlIB3nCzZ+9+VIhAfPS+ZdNbkswbrO37qnw+0xofrLATEq93KS1ypdwKb4+Kl0D9b8/bPBB9QYRSzf6UCnPtOhBxMwNWnL69dz6BRkpqF9n64xWfUh1h1tRdngL3I5R5d1xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W9OX/VWs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BM9rEb002604;
	Thu, 12 Jun 2025 01:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wq5v0ddsvOvcqNyeuQqlmLxX8cKI76Ec7FRGgFxQFyw=; b=W9OX/VWsRuS+v2Ci
	CJkGpJdvqeIz0X1XTaFukDbqeMh2aSTpcEB3INQDjTJHCiKyQL8gk6vAdxlNuZx5
	+oNf25gr32zSFqq+aKY2NWP2+wzyk45EyBfSTx38Quz2IUsqBy1U4soLLOJ8kWlX
	1Fsn29adXSy9tcyUf4vgGKLNs34M2ksTGXQ0tdqEuNIZTY77jSx7KQR/FS5EsFYq
	khURkni/ujemlmFsuL3vp6bmqm3ybLMNNqdTMr5Ji+xPf6cQ/I66YRyzYBiLuycL
	vj7WC09s5mbPGf10pIESnxI/at+N97rI9r1sEe3Y6zFybYOIsk15VAAlFPajnmEb
	YwPOIw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbpgbte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55C1W31I012568
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 01:32:03 GMT
Received: from [127.0.1.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 11 Jun
 2025 18:32:01 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
Date: Thu, 12 Jun 2025 09:31:49 +0800
Subject: [PATCH ath-current 1/4] wifi: ath12k: fix documentation on
 firmware stats
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250612-ath12k-fw-fixes-v1-1-12f594f3b857@quicinc.com>
References: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
In-Reply-To: <20250612-ath12k-fw-fixes-v1-0-12f594f3b857@quicinc.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Ramya Gnanasekar
	<ramya.gnanasekar@oss.qualcomm.com>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
CC: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Baochen Qiang <quic_bqiang@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aOfRtIkimQI4GD_GUCZgGTCEZgaz4yxi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDAxMCBTYWx0ZWRfX3ALXOqJG2jGt
 85KqDRCws9kw+N47kErQrskeSFMQG4ZbPMXHsByrYTbayWbniTjP0FQT8ajua5on1evYhVKdcTK
 w9vFQCyPS6O3H9CorRaozxLhplUZGMLESh3wsS5c93ZJ5U4C3yYjyYDpgL159dFsx9E6wn65uO+
 S/RwMoJLo45dsu8TOUo0eFc0Q6vqRahzuRfxLrPIE7E1Z8MwoEZKBai6slQXzKK+1qN0atdQkK1
 2NwJCUrAwkMN/8/VQhhxSkYv2z/lTxCWUwgZkOgtKDKpaLCnWAUOGP2jjd5Bx+oT4r8biomWJvv
 4KwVNbp3h9dqGbuNsx3PZVhnEtHkKm386dpaNGIlDvmaPgT9lEmHKb0+zfpO1uuT0aIw8Bx8KPF
 xmaieFkJhtye55nD+LMH8iId8uShkajb6TU6syyYlQ1Dbn2qwAe8gXdKawDD58wLMVHhDsDT
X-Proofpoint-ORIG-GUID: aOfRtIkimQI4GD_GUCZgGTCEZgaz4yxi
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684a2e14 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8
 a=8tjGaqDP5q2GUWaB4ncA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120010

Regarding the firmware stats events handling, the comment in
ath12k_mac_get_fw_stats() says host determines whether all events have been
received based on 'end' tag in TLV. This is wrong as there is no such tag
at all, actually host makes the decision totally by itself based on the
stats type and active pdev/vdev counts etc.

Fix it to correctly reflect the logic.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00284.1-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88b59f3ff87af8b48cb3fafcd364fd9ced4ff197..15dc99992f271f3ec81ecedaf1f6a81fbeb03f79 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4400,9 +4400,8 @@ int ath12k_mac_get_fw_stats(struct ath12k *ar,
 	/* Firmware sends WMI_UPDATE_STATS_EVENTID back-to-back
 	 * when stats data buffer limit is reached. fw_stats_complete
 	 * is completed once host receives first event from firmware, but
-	 * still end might not be marked in the TLV.
-	 * Below loop is to confirm that firmware completed sending all the event
-	 * and fw_stats_done is marked true when end is marked in the TLV.
+	 * still there could be more events following. Below loop is to wait
+	 * until firmware completes sending all the events.
 	 */
 	for (;;) {
 		if (time_after(jiffies, timeout))

-- 
2.34.1


