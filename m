Return-Path: <linux-wireless+bounces-8254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784F8D2CB8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 07:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE861F2613C
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 05:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C0415B98B;
	Wed, 29 May 2024 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jRIZMR4R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAFF15B96E
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 05:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961810; cv=none; b=TS451NpcvnsMNZ3EG7ywwwlmGtEqlt4yiWQ8tnDGjLDdz45irFeQWwB93gtA3LiFa1738sWVme13iZ67VplWQ9A23PRLY/c1pWswjaYxCygAblFrbU9kVq8S15URnEz+ESmXt+LL1VI+zZQ5PBHKmI4rMeKij7sq3njtNNxNv3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961810; c=relaxed/simple;
	bh=4bSZ8mxnI9Q8/g+9Ct7gxkh+ZlSS+whyT5Z7rOcD7Es=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YNgeB6C9COJjOSX6RSdFYwoOJm5sXXnBbQYTf1if7pxt/aHmpm9Ywo67gPFIpW/5x57eSm5Bku9D5YqEJQhFjaSu7cROnlGhOYiMyJV91SF+ui3D/Lw6+WG683govTyhaP5LawYslX1Wtw1anc3Was4J7bH68zfgukwDY9euma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jRIZMR4R; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44T2LMjx030243;
	Wed, 29 May 2024 05:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=O5afrz4lk/lB0PegKA2WVSRiNojCFM1uOG0
	Ra6d0FKQ=; b=jRIZMR4Ry4GWPuko1fCmvrqvQARCt3rM76noj6/jUGZpw7kg/7P
	fXpRGkhzYer7CHm2RbQq7FsdvLUXnaobxvY5AT2nI2L1env/JpY+l3hAdI6qfvrn
	lwpYvG5LQrjtBKFiTzlZA/u+cjgPALl1iDoh2036vVk1egfwcyn7/IyrDnfhftp+
	A31exXBqtYFPtSovzyT9YWf1COBH66B798oa7lrK+devvlnJhpmTbSUT5gxb3prO
	Abctjef5nu9ycyW9of4XfhyTQ4Ad2SstVgglyPT3qWWk0S9161kz9pCIl9BGjQdM
	nh4QUtXv/ja1d7euv6RnvJMJLOWIFDzJXTg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2ng5gw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 05:50:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44T5mJAD013695;
	Wed, 29 May 2024 05:49:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3yb92kh9hq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 05:49:58 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44T5nw6W014981;
	Wed, 29 May 2024 05:49:58 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-hprem-blr.qualcomm.com [10.190.108.75])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 44T5nwV3014979
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 05:49:58 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 4146166)
	id C37FE410F6; Wed, 29 May 2024 11:19:57 +0530 (+0530)
From: Harshitha Prem <quic_hprem@quicinc.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Subject: [PATCH] wifi: ath12k: add hw_link_id in ath12k_pdev
Date: Wed, 29 May 2024 11:19:55 +0530
Message-Id: <20240529054955.4105240-1-quic_hprem@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iRkclUJ23TEkn-g2K5qXzpYS2Tg8ZIdH
X-Proofpoint-GUID: iRkclUJ23TEkn-g2K5qXzpYS2Tg8ZIdH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290036

From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

Currently, hw_link_id is sent in WMI service ready event but it
is not parsed anywhere.

But, in future, for multi-link operation, this parameter would be
needed by many WMI commands such as WMI beacon template
(WMI_BCN_TMPL_CMDID), WMI vdev start for Multi-link virtual AP
interfaces (WMI_VDEV_START_REQUEST_CMDID), WMI peer assoc command
(WMI_PEER_ASSOC_CMDID) for Multi-link peer and so on.

Hence, add changes to parse and store the hw_link_id received in
WMI service ready event in ath12k_pdev structure.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Signed-off-by: Harshitha Prem <quic_hprem@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/core.h | 1 +
 drivers/net/wireless/ath/ath12k/mac.c  | 2 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 7d20b09c52e6..45ca4d5e2b5f 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -689,6 +689,7 @@ struct mlo_timestamp {
 struct ath12k_pdev {
 	struct ath12k *ar;
 	u32 pdev_id;
+	u32 hw_link_id;
 	struct ath12k_pdev_cap cap;
 	u8 mac_addr[ETH_ALEN];
 	struct mlo_timestamp timestamp;
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 784964ae03ec..509c02bffdae 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -9229,7 +9229,7 @@ static struct ath12k_hw *ath12k_mac_hw_allocate(struct ath12k_base *ab,
 		ar = ath12k_ah_to_ar(ah, i);
 		ar->ah = ah;
 		ar->ab = ab;
-		ar->hw_link_id = i;
+		ar->hw_link_id = pdev->hw_link_id;
 		ar->pdev = pdev;
 		ar->pdev_idx = pdev_idx;
 		pdev->ar = ar;
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 99106b088311..d6e1d1398cdb 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -500,6 +500,7 @@ ath12k_pull_mac_phy_cap_svc_ready_ext(struct ath12k_wmi_pdev *wmi_handle,
 	mac_caps = wmi_mac_phy_caps + phy_idx;
 
 	pdev->pdev_id = ath12k_wmi_mac_phy_get_pdev_id(mac_caps);
+	pdev->hw_link_id = ath12k_wmi_mac_phy_get_hw_link_id(mac_caps);
 	pdev_cap->supported_bands |= le32_to_cpu(mac_caps->supported_bands);
 	pdev_cap->ampdu_density = le32_to_cpu(mac_caps->ampdu_density);
 

base-commit: 2580be9ee6f5d97d6763b5d4ae4f9c0383fdf130
-- 
2.34.1


