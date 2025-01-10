Return-Path: <linux-wireless+bounces-17315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 933AEA08F01
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DEE5166B18
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 11:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBE209678;
	Fri, 10 Jan 2025 11:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VYA08N6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FF2080D2
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507958; cv=none; b=Gp9nRLEDs4VWQDZV00wQcZlq2L1sS7Oulk2LDPMW4MMef9kAd70o5zCs1I0tPaCcFh7SkRF2yDSRvmzSQhRAyHjXg+C1tNc9oGKVYwiuq2sdD8k503CrA/62rSltoPoHHRrNFH8t61KXfxoaO00z7ElCjFg89rh+SEsYgRl5mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507958; c=relaxed/simple;
	bh=LnmtOJffWM6l02RDpSNp26uJm5cXYsbw8v4MeAW9Cq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8LzVe+GBWYtYVJPCvGsBTLJo+Hm+K8G8+fJbQXsAOlMCpc5Xub7ViQk1ALULHBPlaUav6JXGAXk87X1DU4JxbkYzzrgJHg1KLtlvRPTpEwuklr/YisrKr5Fde3Wv6QZM7CWa8sglGV8diRrwKidH8kYa9aSR8ytPyQHo8Dy02k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VYA08N6M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ABEn1x029616;
	Fri, 10 Jan 2025 11:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AZ7jsM5Kny757mI8InCm6ngjtSDDFlNTWEDCvZ4FGNM=; b=VYA08N6MC2a0ykf4
	+OlCVJATOhEczeiRtokn6Hhw21/tkPRicSjzi/6qtyMQY9H9Dtup810GPGlLUmfZ
	fBbUOIfEmiZYIp12QftnYf1wKvitmK4fUSF236zjQj26a7JOkK3NsTFd9ue/+nAI
	HVUZxDPEyQvy6qM84kFlODhvRDKJF+GAk9oumSAyIdg7V/5k/UOIxv3/OZ6xTGfb
	qCqKiVWKNg3HIftXKvEHQ0B8IbJ+RBB4M88/O1DdcyQH2+j6cTKXgxXq/S+SxiWV
	ewL5g3NSLKCeMIh2SY8wvkEfCLTXgdrMYBibjvOC2zY4o8/OJUBrTwG4k/WQXZ7M
	Kdsfdw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4432gq009b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:19:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50ABJCPv019680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 11:19:12 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 Jan 2025 03:19:10 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v8 5/5] wifi: ath12k: Disable MLO in Factory Test Mode
Date: Fri, 10 Jan 2025 16:48:45 +0530
Message-ID: <20250110111845.2920741-6-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
References: <20250110111845.2920741-1-quic_aarasahu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JYMaa-xkmtQLws725UxPomO5NA1ZtWMn
X-Proofpoint-ORIG-GUID: JYMaa-xkmtQLws725UxPomO5NA1ZtWMn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=702 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100088

Factory test mode(FTM) is supported only in non-MLO(multi-link operation)
mode. Therefore, disable MLO when driver boots in FTM mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d0cf82ca6dae..d23e7299962b 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -1610,6 +1610,9 @@ static struct ath12k_hw_group *ath12k_core_hw_group_assign(struct ath12k_base *a
 
 	lockdep_assert_held(&ath12k_hw_group_mutex);
 
+	if (ath12k_ftm_mode)
+		goto invalid_group;
+
 	/* The grouping of multiple devices will be done based on device tree file.
 	 * The platforms that do not have any valid group information would have
 	 * each device to be part of its own invalid group.
@@ -1797,6 +1800,9 @@ void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
 	struct ath12k_base *ab;
 	int i;
 
+	if (ath12k_ftm_mode)
+		return;
+
 	lockdep_assert_held(&ag->mutex);
 
 	/* If more than one devices are grouped, then inter MLO
-- 
2.34.1


