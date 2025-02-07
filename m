Return-Path: <linux-wireless+bounces-18639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEEAA2C93B
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 17:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B9C164267
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C4E23C8AF;
	Fri,  7 Feb 2025 16:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YOX+FldO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DB18C92F
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946878; cv=none; b=AIhV3NXXkCzumah2949BlY52KOGYzT9JlTJk5uaG+q2erMiz254v5SegioKLy8X+yWTius4Xk/QoipDxyt4YUeGhQiPNqkdW8HhIqEkbh3CM8PZt/LvMO1DsRPUPpyE3z1JS3beVmwHG9pNo2myE19odP6qON1OZVyKuPo0bv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946878; c=relaxed/simple;
	bh=ULQbQK3uafNZzIxbraWJoGoM4AAd+qDxpEvNoixXti8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcWmm4gLsWGBPeaVYOTDjurbA5iBKGIkHjKQsTEnLSgR400xW+8VZH5k9n7EBImQNgs4H8oYnh0BO8fzkGgMDssI4B9shHcsqkxoaF7wB0tWfKGicjfxLfW1A15qQZ++SU1kqQGPg4I8L5s25lVkBkXZLM5eXlc+5pPsVCDLCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YOX+FldO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517B2kxX003240;
	Fri, 7 Feb 2025 16:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Mq+2VhVyKi66Q+OnyxY5pLU2
	2J5Xa5Ohmhz5gu/r5Ds=; b=YOX+FldOaO8rPieZkHzcdwrldmJ2mI2TbEYwUrtR
	p21/eDz7GicNnvgZQfcLcq6rvGlVYen0ThTdYtE4DStWfTe5J3Tr0btQxRq4jz4X
	Yj48K3/DgnTv5SN6/6knaq73+ppN3TVzEBn2UyGB2hKBqNYH3KCGEM+R92Ohkrrt
	YNN3g6TIqKsUIKAFjRB/xYYnAnA8kRU3feQfIgqYWjJuily/3esMlwsb/SRgn21W
	5qkXLX+TcQPwiU6vCmMjey9aM7rLING4CEV4Y9T0v8saNI5ou35HBAwdTQLqWNiX
	CKwQfbshHYDDgW278O6pZcj3UyKbZQRTf6YVQPlKbdsA0g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ngy10u3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 16:47:54 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 517GlsMm031878
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Feb 2025 16:47:54 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Feb 2025 08:47:52 -0800
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH 3/3] wifi: ath12k: Enable REO queue lookup table feature on QCN9274
Date: Fri, 7 Feb 2025 22:17:03 +0530
Message-ID: <20250207164703.3818135-4-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250207164703.3818135-1-quic_nithp@quicinc.com>
References: <20250207164703.3818135-1-quic_nithp@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 49AuI7SFq5i0a2q1jf-Pp7pdJKoUmGHC
X-Proofpoint-GUID: 49AuI7SFq5i0a2q1jf-Pp7pdJKoUmGHC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=942
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070125

Enable the REO queue lookup table feature for QCN9274 by setting the
reoq_lut_support flag.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 51c2033cec46..2433ade22e2f 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -1057,7 +1057,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.download_calib = true,
 		.supports_suspend = false,
 		.tcl_ring_retry = true,
-		.reoq_lut_support = false,
+		.reoq_lut_support = true,
 		.supports_shadow_regs = false,
 
 		.num_tcl_banks = 48,
-- 
2.17.1


