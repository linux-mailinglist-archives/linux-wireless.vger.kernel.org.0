Return-Path: <linux-wireless+bounces-6973-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7ED8B52E9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 10:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C7E1C20C8F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7093171C1;
	Mon, 29 Apr 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="StojCLmA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9051758C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 08:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378554; cv=none; b=tUnfTZLoakaoAS29lUw2lBIlTMBqn7HgxpYGRZ2YRPJ5iiobSLrMVpG6r7O9NCY5CC+YGxXrNiBsAHYloEzIT9NTfpUgRcrHYgittM8lCHH1iwmAbukm/BFh2lHBdiXguvuJQjGDxZCCObL4j6o8GFYgZuw8YgMl4CC68hS7y9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378554; c=relaxed/simple;
	bh=rJVR5VYfsUi0e5Br/AfBDRCIVNtJd2MID6V7ZglOZBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzzAiL4l2N9lm5NyhQTJ83p15wurABY/H4YVerYMJWuQd3So4JQ1YWYwASf9KokzV90yLgC8i4gGR7f/1rKrhjAiOyuev0FGcMDTIK3PhLRlMd7XFLmuEupuGamSq8eisSITdNJMM66JcVZaB+bxAa/bARwsfZbnCaUA3bBnTbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=StojCLmA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T6b8sQ026312;
	Mon, 29 Apr 2024 08:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=9G3zrctaFCDSY3o51Uq6vw7ZK/2OcFFnfziKUSc1zao=; b=St
	ojCLmAgekiDo5dRDVfxyaXuHP4YxeiiX5vLLwUHywmiNtLpYSf09SGJr95Ki2eZP
	pW2HvagHc2YOzCiEcvVRz5VH38xeWs7lAEYUTHr0HlFZMCWb21/gEsN5KHUj+dTa
	s2vngxOA/XOFO0X+yM9T6fgb9OYOiODQ99TG5tGFCwhAQtdNoMO/VHkFLYe2zGyq
	MS770ZNpmZT1ZUPc5RF55k4Mm+0PaYjwvpEq1+rDBtA4i6DPx5IroYtIUvJxIGIz
	rcSr+uRMcsshYFcwqkfFYm7F/ClKr1knpCBWWNP6jSv/e36vzIFVlwovC7RS/R6+
	4VK/dolfPWpSUhWGv+rQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xt2sernu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:49 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T8FmVq006919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:48 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 01:15:47 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 2/5] wifi: ath12k: avoid duplicated vdev stop
Date: Mon, 29 Apr 2024 16:15:22 +0800
Message-ID: <20240429081525.983-3-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
In-Reply-To: <20240429081525.983-1-quic_kangyang@quicinc.com>
References: <20240429081525.983-1-quic_kangyang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6OWU0iPGA0qFE8WM5XB1RCzQrA702RIB
X-Proofpoint-ORIG-GUID: 6OWU0iPGA0qFE8WM5XB1RCzQrA702RIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_05,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=847
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290050

From: Kang Yang <quic_kangyang@quicinc.com>

ath12k_mac_op_unassign_vif_chanctx() will do vdev stop in
ath12k_mac_monitor_stop(). This ath12k_mac_vdev_stop() will do vdev stop
again, then might trigger firmware crash.

So add judgement to avoid duplicated vdev stop.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Fixes: c9e4e41e71ff ("wifi: ath12k: move peer delete after vdev stop of station for WCN7850")
Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 3e9a7dec7eba..4f553f2a7165 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7369,7 +7369,8 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 		arvif->is_started = false;
 	}
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_STA) {
+	if (arvif->vdev_type != WMI_VDEV_TYPE_STA &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
 		ath12k_bss_disassoc(ar, arvif);
 		ret = ath12k_mac_vdev_stop(arvif);
 		if (ret)
-- 
2.34.1


