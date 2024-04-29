Return-Path: <linux-wireless+bounces-6975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D9D8B52EB
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 10:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23A301F2116C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 08:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16B134BF;
	Mon, 29 Apr 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B7vPVgmy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1C179AF
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378557; cv=none; b=Qx7DIjC2hR+6/yYicwLFrHfiASZb461sxs05IGuRmlnLYDBIbP/tFCXW6kRXyCGHStKcp91IBeEZpaLCqCSunL2+rkztGvTNg2Mvr4aq4FxfPtdEfrjEU34HGOiVT7OtOQ2M/onXOhnDVT2BMlwo/cbak+qse80+zeQPS0owMb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378557; c=relaxed/simple;
	bh=zc7J4iHEcYONY+tb8pmvrGrT/0/c+57oAUjHotpYmJ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tH8r+SjnGHG1DI3JlLSUsCzWqq3UEPH66D14clp5YkHITQiDsUuUXyr4GcaaaBFvrKkTLO+j1mKd/Vp/nt7zOmLdrikikWQE2l56ec3GVKHf5m1iO0x687WH+9njOvR+ZJcrsbvR0QWGljTPs3VB9t+PH3eDzsXily7AOamU3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B7vPVgmy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T8Frnj019934;
	Mon, 29 Apr 2024 08:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=wBlsOlD/Sz44Qkk5Uwr20/rdUzbHgB3zSXY5H+ToLhs=; b=B7
	vPVgmyHjY3dZWKtyN0KGASo+NHeLt27kFgE9+qI+g5xD6cFioO4PeI5Nk2N0iHhg
	ckxQIwjdwFbbwlxXpWDfDT74uHnKQNdiH6oIgi92t70jZHO+e8yyawjq0p4WIWE/
	lweOIFXaDFRGe2tDUfaYVSFGNexlo6cs1BCv5oZOMTF0oKuojrsz+M0zha2hse7I
	QrNTgg56d96SnMCpl07N0TlBg5a7Kel78TnqE/wjj0z7X9bY9tMbNji1EAYvbe4v
	PBmj9gUpxWaTty8RFROyWZLr6Kxmam1Vbyn+k2RViFClaqf4kGbCeQCEazbpENRP
	GE93i5Ve1c9riSv9GSYw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrthtb1gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:53 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T8Fq4S028025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:52 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 01:15:51 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 5/5] wifi: ath12k: remove invalid peer create logic
Date: Mon, 29 Apr 2024 16:15:25 +0800
Message-ID: <20240429081525.983-6-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ZEPhIi81zZpS--HVhsIg0E1nWgY5lck6
X-Proofpoint-GUID: ZEPhIi81zZpS--HVhsIg0E1nWgY5lck6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=993 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290051

From: Kang Yang <quic_kangyang@quicinc.com>

In ath12k_mac_op_assign_vif_chanctx(), there is a logic to
create peer using ar->mac_addr for a STA vdev. This is invalid
because a STA vdev should have a peer created using AP's
MAC address. Besides, if we run into that logic, it means a peer
has already been created earlier, we should not create it again.
So remove it.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index f994a78e7dc5..be961de26c6d 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7242,7 +7242,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct ath12k_base *ab;
 	struct ath12k_vif *arvif = ath12k_vif_to_arvif(vif);
 	int ret;
-	struct ath12k_wmi_peer_create_arg param;
 
 	/* For multi radio wiphy, the vdev was not created during add_interface
 	 * create now since we have a channel ctx now to assign to a specific ar/fw
@@ -7278,21 +7277,6 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		goto out;
 	}
 
-	if (ab->hw_params->vdev_start_delay &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
-		param.vdev_id = arvif->vdev_id;
-		param.peer_type = WMI_PEER_TYPE_DEFAULT;
-		param.peer_addr = ar->mac_addr;
-
-		ret = ath12k_peer_create(ar, arvif, NULL, &param);
-		if (ret) {
-			ath12k_warn(ab, "failed to create peer after vdev start delay: %d",
-				    ret);
-			goto out;
-		}
-	}
-
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_start(ar);
 		if (ret)
-- 
2.34.1


