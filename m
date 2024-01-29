Return-Path: <linux-wireless+bounces-2656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE22784029B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED5051C225C6
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 10:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4330557864;
	Mon, 29 Jan 2024 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g3evgKJK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A55730C
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 10:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523326; cv=none; b=Zo9QPk3dsvULj0Ziprimr+djp89qEpFpeC8hd914n78A313fPr3sbbrbtF477JMmLHcpjPMr/D4tKxkte9kjm52XfDfjpMIAdBL57RSWwq5PwsBv/rHFF5zKuXCH6bTQzNHDODK+1kAi9ggBgEqHMDGm0i6bHVTIh0TY2NW8oIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523326; c=relaxed/simple;
	bh=x1ZUV/LKz/s0sOFU7ZB2X0k3Vh9Vdj5Eq0jyFL25Eog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8hsXlM80bJ8Jwlmj/CiZYxqz0k+3G+f5jYaCJc4Bh1nMwlAT1rrwKW5Lb6LBoNds1mZkFOnxpGYCVwDTf7w9HOWGph9VUmPunApfT5CHboP+FvgxsIFhI7mXVAnDi2sNTm02yO02eXKwCUAwYV4E8KlpO4EpbQsvLTbUWQy0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g3evgKJK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T3Evtk007009;
	Mon, 29 Jan 2024 10:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=Y1iYrvTZgrpq41Km6KJeuWoFowrFAThWwDY8Wboqqc4=; b=g3
	evgKJKwWTCHf0YyEKq0Ni5OqLnwRpsxJQf7xgBQOKJ3GA14XskO+BI3IuwSjy/CU
	P2AGZw/u76dzSC8wBLNyjswKwcd4t06VucNclXz9/g2sWKnApflFIZiFTBRvVqPE
	PNXmG870GM0iWqKuCKb57SzoKge5WTMDzY7h3eJ9T2K7SiAfYah902hIxYApBHnq
	oicf2TbEnhk+NRivtzQ1MNq4YR5R2IN3K1yqeF731O3I81T/BLrzI6BI8RUlD+fd
	tOdsvajLfYqG7lz32AmAPxnz3pKNx9sOVBbA0l3TsfMXZN17x/8XA6gI/WYxVeT3
	Zat8gOEjyP7vvOJtKBHQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3dtrr3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TAFLg9019138
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:15:21 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 02:15:20 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v5 06/11] wifi: ath12k: allow specific mgmt frame tx while vdev is not up
Date: Mon, 29 Jan 2024 18:14:48 +0800
Message-ID: <20240129101453.368494-7-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129101453.368494-1-quic_kangyang@quicinc.com>
References: <20240129101453.368494-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: pXCVtVLp39EEwbqcIgHCbkWussEl0a83
X-Proofpoint-ORIG-GUID: pXCVtVLp39EEwbqcIgHCbkWussEl0a83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_06,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401290073

In current code, the management frames must be sent after vdev is started.
But for P2P device, vdev won't start until P2P negotiation is done. So
this logic doesn't make sense for P2P device.

Also use ar->conf_mutex to synchronize ar to avoid potential conflicts.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v5: change commit log.
v4: no change.
v3: no change.
v2: add Tested-on tag of QCN9274.

---
 drivers/net/wireless/ath/ath12k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 366bb5e5934b..4ad23bc9381c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -5069,8 +5069,8 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		}
 
 		arvif = ath12k_vif_to_arvif(skb_cb->vif);
-		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
-		    arvif->is_started) {
+		mutex_lock(&ar->conf_mutex);
+		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
 			ret = ath12k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
 				ath12k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",
@@ -5084,6 +5084,7 @@ static void ath12k_mgmt_over_wmi_tx_work(struct work_struct *work)
 				    arvif->is_started);
 			ath12k_mgmt_over_wmi_tx_drop(ar, skb);
 		}
+		mutex_unlock(&ar->conf_mutex);
 	}
 }
 
-- 
2.34.1


