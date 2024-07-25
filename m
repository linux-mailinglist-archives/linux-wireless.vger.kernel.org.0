Return-Path: <linux-wireless+bounces-10512-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1456F93C15D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 14:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B961D281F9B
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6625199E88;
	Thu, 25 Jul 2024 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nKxdx2RV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE0F199EB7
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908876; cv=none; b=Hh5FNEokGnLJyp6FbZY0Wez53LqenBbwuqFATJ1ikQbGND9uH/KoukFkhwL/Q0zRSvcDhRxjlp+2QIumPn0ipQaswV6R1HvKsTH7c/zeTz++QE4POe+VyDKnJBbf7EErX/xV8bviZsJXtTZE+59rfoIvT+CJVhygpjIDeRUIhSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908876; c=relaxed/simple;
	bh=47FoP6OaroUUZB8fvfRtj4IGEpETpmX42zYUXhmJ9/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehL7nAEy28QJYxoT4OXKmhlbteRGNGrEpJQ2ezzD6GHDGVKWXXfZfzxo/6Ifan3YQSvEEn3m7U6JYh3YZGSFRLBGFcDJ9lVCzPsXK6V4VPWht+CMb4wsCutRkc4ZeOd97ay+M+WPuZJC5koM34X2mUbCr1QsAK3Ywu3cwPAK+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nKxdx2RV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46PAHshS016854;
	Thu, 25 Jul 2024 12:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BFrTwZ0q6oFifu/385ozK3X4UqTdH4j7xrwpbXfkrb8=; b=nKxdx2RVusmytMS7
	SvhHBYEWGRAX8oB6Wa65c5SWItV7Tc3/1KBhprkHWQRQbWxaiN2uLztOjUnM8uP8
	KCRblH4BVV9O7JJRAzVJOpIPjGDF0MvAleHlEZmjvW8M/0Bo3U6Jdr3qXflRmxlm
	Blq7jJDiT0xUsn6qSj32A1B4LlBZEkN3kpVb/GllHOzEIDDY3Bm00H7Ku1/3dUR1
	OMtO3eDDdB0oVpHzakYduNk5sMAU3fEavs1yAsV59CArsN7ARfMW5AnPH+jCfNKK
	00yaIVOCdJf+4Wjx3JdDsXB4K68glCJ7VrDKtKP1GBpHyM6WTkNx/6gcT+38fKpg
	O4C4cg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40gurtur05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:12 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46PC1BeP006189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 12:01:11 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Jul 2024 05:01:09 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 08/11] wifi: ath12k: delete NSS and TX power setting for monitor vdev
Date: Thu, 25 Jul 2024 20:00:32 +0800
Message-ID: <20240725120035.493-9-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240725120035.493-1-quic_kangyang@quicinc.com>
References: <20240725120035.493-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TmTJZeTs9XvJ1L2EiD-pq6eXJTjlCBWu
X-Proofpoint-ORIG-GUID: TmTJZeTs9XvJ1L2EiD-pq6eXJTjlCBWu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_11,2024-07-25_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxlogscore=743
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250082

From: Kang Yang <quic_kangyang@quicinc.com>

ath12k_mac_monitor_vdev_create() will set NSS and TX power for monitor
vdev. But this is not needed for monitor vdev.

So delete them.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 642d756db663..bbf55cd06e4d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -1064,7 +1064,6 @@ static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
 	struct ath12k_wmi_vdev_create_arg arg = {};
 	int bit, ret;
 	u8 tmp_addr[6];
-	u16 nss;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -1104,19 +1103,6 @@ static int ath12k_mac_monitor_vdev_create(struct ath12k *ar)
 		return ret;
 	}
 
-	nss = hweight32(ar->cfg_tx_chainmask) ? : 1;
-	ret = ath12k_wmi_vdev_set_param_cmd(ar, ar->monitor_vdev_id,
-					    WMI_VDEV_PARAM_NSS, nss);
-	if (ret) {
-		ath12k_warn(ar->ab, "failed to set vdev %d chainmask 0x%x, nss %d :%d\n",
-			    ar->monitor_vdev_id, ar->cfg_tx_chainmask, nss, ret);
-		return ret;
-	}
-
-	ret = ath12k_mac_txpower_recalc(ar);
-	if (ret)
-		return ret;
-
 	ar->allocated_vdev_map |= 1LL << ar->monitor_vdev_id;
 	ar->ab->free_vdev_map &= ~(1LL << ar->monitor_vdev_id);
 	ar->num_created_vdevs++;
-- 
2.34.1


