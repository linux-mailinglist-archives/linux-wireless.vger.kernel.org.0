Return-Path: <linux-wireless+bounces-17293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9818A0881C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 07:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCBE77A4C25
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BC92080E7;
	Fri, 10 Jan 2025 06:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SEYb/ojv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4B52066F6
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736489577; cv=none; b=g1uwMCBXMvGywdQEHURfE30PthN5WUhaFOfG1H1PRRGoloSsNM34AMV1Ss6YfYugoWTpt6yn3GdcVXr3XCPSUx+DjhmgRAJbAJShQQHvxqML+9X2fNBawzfXUdHYifmm+EiD2YEY5p0LpG1F5DG6Ec17WC6sLj2aUGpbPPkooWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736489577; c=relaxed/simple;
	bh=73sY2gZPCDFCfQbKf/GDFuvhuJXMq4GNRFeZHIJElDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlSROM/7DnITainj7V6AElErROZq9Nfo3wVP5l7LJwm1PWOi2m9QQ98lMZy8pRXoEFM3ZKHCA61bX8xb9dA7xysAV5T+qt3cgkv5RKZ0irVCk8I2Xctx3NmrV7ZDWmfb8m3NsU24kl1BEgouSCNgW1RzSof8ecAxWPECdnMcIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SEYb/ojv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A2ZakW027939;
	Fri, 10 Jan 2025 06:12:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4lE5oaWll4pj2HAGi3zO2G5bEfiFcMQKvWXbTx1w67I=; b=SEYb/ojvbXm+SKJy
	m9ObxXma6i1ct6N2vw6B4Ha4aahRWJlso6wpSZb+eirAP25bgO/QOJdF+DyuW7nd
	jAlAlhG4Lc+JQfeflOHx8LK/JBdYBxLtvoGFBH42uhSyMt2+s78p732oOl185U1F
	9xwrlWniFubd+gnqqBBvzVRXoplSBBjzOTFgVBjpXuGd1W4zVf+hpvZhxwTH4gR4
	SLuYZB9xnWFiBLyAZA6yqfdv3VMnc4BIW0TaiZ886akql9uYxCSHOoRDgq6WHZUe
	/mvNGek3Db2U3xVnZ7UjECjMKWMsDDcXCzaWmeYNm/HOnvIvYiuvHJe0aGKmIHyi
	jLti5w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442twbgdfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:53 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A6Cqvv007569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:12:52 GMT
Received: from hu-aarasahu-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 22:12:51 -0800
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Aaradhana Sahu
	<quic_aarasahu@quicinc.com>
Subject: [PATCH v7 5/5] wifi: ath12k: Disable MLO in Factory Test Mode
Date: Fri, 10 Jan 2025 11:42:24 +0530
Message-ID: <20250110061224.1839547-6-quic_aarasahu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
References: <20250110061224.1839547-1-quic_aarasahu@quicinc.com>
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
X-Proofpoint-GUID: aH1UgzrN4cbTUKGL0jI3GxB9YK9WoeJg
X-Proofpoint-ORIG-GUID: aH1UgzrN4cbTUKGL0jI3GxB9YK9WoeJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=659
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100049

Factory test mode(FTM) is supported only in non-MLO(multi-link operation)
mode. Therefore, disable MLO when driver boots in FTM mode.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1

Signed-off-by: Aaradhana Sahu <quic_aarasahu@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index d0cf82ca6dae..d80a73bc2f49 100644
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
@@ -1799,6 +1802,9 @@ void ath12k_core_hw_group_set_mlo_capable(struct ath12k_hw_group *ag)
 
 	lockdep_assert_held(&ag->mutex);
 
+	if (ath12k_ftm_mode)
+		return;
+
 	/* If more than one devices are grouped, then inter MLO
 	 * functionality can work still independent of whether internally
 	 * each device supports single_chip_mlo or not.
-- 
2.34.1


