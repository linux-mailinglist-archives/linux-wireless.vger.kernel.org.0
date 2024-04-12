Return-Path: <linux-wireless+bounces-6222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EE98A262D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 08:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BD7287B2A
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 06:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C162D630;
	Fri, 12 Apr 2024 06:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KhHpxbdd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D335200D4
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 06:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902014; cv=none; b=SrZWKeY0tM0ogDH/P/mqr+PYEm16BnkWyS+Bm1x/+VAsY37Pzn16jKE2qkyT/2ka60SSgLQiwhQmWKAR43d1gjyzRwDk3raMZRsI60VekahDZsqYK2/qWPFhpppipc5XsQNQmBe6S5zuxVUilzUyVNsz3duMn6iJqkuSIdUmo0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902014; c=relaxed/simple;
	bh=Ydn/K+WVpkZbjY7m0ncfgX+Mhhws46RLz8ZV71GcgJ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=py498duydPKMfpQcRHdjoYpz1pw/RLDPDFmnwXnqz6PwfgowHGP23PCVUIVZQX7xtYUJ8DN+AZhoBKIub/iCKpOZtZRc24bdM3rXZ0kc0usd2gRKJ6TWiTxGtpSPmmPGnNN61JZmjHTuyPhC99QNZ21XHTCAKh28sjfGcqEiR3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KhHpxbdd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43C4E209021323;
	Fri, 12 Apr 2024 06:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Q7+lJDeTDhzV1P3jkpR9O9a061M/d5sCBruKa5KRzX8=; b=Kh
	HpxbddNy35iGmLFJWl/4rcyuYSnoVTxyknsQRUXM9JzeevVUkrs3/QzgUo20i5CP
	dCU9qrVRYlk0nXXbs5eci6j4L04VNkFOciFSYU3uA+awMnu3je6114HwDE/rOdc5
	gsh0MlM7zjyC/ixULDjn8K9OlO6euJUx+FDxTBNXOCtwxNtOonBB8H6wET75G//z
	eiv95E+goEKBZfxzTiyf3s8FM502KCkW6kiPNAFbeVzIUinOGkSiiecMq5WDJ2E/
	j+D/o2kORwsdxmwijTRUeAc5FjZIQmgdcKqiZr6P5pqRwtKDEIDWEutjyZltvjOa
	P/dBylVtHar3Jng1tUww==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xewr38788-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43C66ohf007216
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 06:06:50 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 11 Apr 2024 23:06:49 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH 10/10] wifi: ath12k: change supports_suspend to true for WCN7850
Date: Fri, 12 Apr 2024 14:06:20 +0800
Message-ID: <20240412060620.27519-11-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412060620.27519-1-quic_bqiang@quicinc.com>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: WLFMKQ5afMciG6IdHHX7CFCsPj6tNCk4
X-Proofpoint-GUID: WLFMKQ5afMciG6IdHHX7CFCsPj6tNCk4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_02,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 adultscore=0 mlxlogscore=931 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404120042

Now that all things are ready, enable supports_suspend to
make suspend/resume work for WCN7850. Don't touch other
chips because they don't support suspend.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 0b17dfd47856..613c2a9c0056 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -964,7 +964,7 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 
 		.idle_ps = true,
 		.download_calib = false,
-		.supports_suspend = false,
+		.supports_suspend = true,
 		.tcl_ring_retry = false,
 		.reoq_lut_support = false,
 		.supports_shadow_regs = true,
-- 
2.25.1


