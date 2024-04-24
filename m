Return-Path: <linux-wireless+bounces-6778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E9F8B1348
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 21:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81E11F2285F
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B521DA22;
	Wed, 24 Apr 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kYE/81IY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917301CD3F
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985921; cv=none; b=OpA91VPgWHjlNIvYrw8BNp2EWT2bCKaoA8yeWMH7idB/WpZ3Pb6IVzn/Ws3mxFVPc3riMVT8lvFNcZJrvv+jzf3KowYakPlKyZ1wb1O1UTH8CQ/yaMyXpHnTiAJTRACrOAJMsyReNGZVJ65R8VIKPcjN3QYLDAACLShNyzHfBYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985921; c=relaxed/simple;
	bh=WtzNVb7gI+Vm/MDgkx4i9hxe7IvomHovSbAJGAy9lG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLVDycuz4GSSEtZ1rKg4TZulW01Lhke8ap1Vi054sfCUz/mqxwHIjAbC3uWQVFZYUY+pvSgGczJS6wQbxOz36ypGI995wD6tqZN752bIccCy0z8bo1xgt4cQdlzpaMX3L94+GRNXYEccbhhSxroI+01f6jtTgGqSBa+WkddErpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kYE/81IY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OImSqh014733;
	Wed, 24 Apr 2024 19:11:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=qn8V2AmrnQqTjyejlKos
	/e7IR6vfIWUoCiojZ7vCgIY=; b=kYE/81IYrqYYwh50H4IkikGuQqNkvdsYU3qs
	vvbCGXHTaj6zQOUuyj12CXo9n9G4XDuC34gxH8i7kdsBOLcPCDT7yVAlrb/bs7Q2
	qMid7ldgbfZ58eljwP/koaaeYr+JDc/1rqiPyTly3X859x40VdJki0f+cXFObdip
	ffLaWcchomVoCN1nYwlZIRBpjAg7nU1MrBThlkUdakWfgKxrllT/jJomWwgDmQaf
	aNeys1VC+I1ycvPn4eFjR+unN4dmW56Dsq4XkOlWy2Cl6DdiV5eTbV8qOEqtEycb
	OHhi9RHAaNg3XwyvBGP5XiKUt+j08a95iEpW0lLLw8cC3I00NA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fhwq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OJBqQ8017561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 19:11:52 GMT
Received: from pradeepc2-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 12:11:52 -0700
From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>
Subject: [PATCH V3 3/6] wifi: ath12k: fix survey dump collection in 6 GHz
Date: Wed, 24 Apr 2024 12:11:38 -0700
Message-ID: <20240424191141.32549-4-quic_pradeepc@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
References: <20240424191141.32549-1-quic_pradeepc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: V3DRZ8kV6S4ULRPJXn9fi165nV0VGbND
X-Proofpoint-GUID: V3DRZ8kV6S4ULRPJXn9fi165nV0VGbND
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_16,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxlogscore=848
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240091

When ath12k receives survey request, choose the 6 GHz band
when enabled. Without this, survey requests do not include
any 6 GHz band results, leading to failures in auto channel
selection.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b471b27d6594..830f35fb89fe 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -8020,6 +8020,17 @@ static int ath12k_mac_op_get_survey(struct ieee80211_hw *hw, int idx,
 
 	if (!sband)
 		sband = hw->wiphy->bands[NL80211_BAND_5GHZ];
+	if (sband && idx >= sband->n_channels) {
+		idx -= sband->n_channels;
+		sband = NULL;
+	}
+
+	if (!sband)
+		sband = hw->wiphy->bands[NL80211_BAND_6GHZ];
+	if (!sband || idx >= sband->n_channels) {
+		idx -= sband->n_channels;
+		sband = NULL;
+	}
 
 	if (!sband || idx >= sband->n_channels)
 		return -ENOENT;
-- 
2.17.1


