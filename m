Return-Path: <linux-wireless+bounces-7448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF1C8C22EC
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 13:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA392828C0
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 11:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47A216D4F5;
	Fri, 10 May 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eG5Ol7pV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E9D168AFC
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339593; cv=none; b=lt8mXFg1uvSEUx8rtD4cwhdyWof5mB3HxVdlOXfvAAtEBCb/R4my5UrPMCKYHf6EL7d9zYoy0ecinto9RKgF25yDogeuyDPR4yX/BKOfAg00hQDV29IBmTZeWe5DIoUuZSk/d+anjG1q3J5RU6gK6pn2mvI/WUo+6fVrWEKaeow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339593; c=relaxed/simple;
	bh=t3jsJgE8MTm90ASH65AK5KEnoqmgKzicWiVd9wmS6aI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XyiMm/fiuPGFdONq+ss8ZXjbTdmorvLIHcXEYkGoa+Syy6XZkl1KHksKSRt+IMBhi3m/PeLXNyuOnN3YLazWIIwno4h6jXXtrVCNwC90K3dE7GTxy0KzVdF1e4Ab/e4ttXsLQERZjIZeqQ/8l8AMSxpV5BzO75x/f+/5n851j+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eG5Ol7pV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44A2tiiA024568;
	Fri, 10 May 2024 11:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=V0nUXqC
	iCPsgEx2v3qvcExro7RouPBplX54Kn2gg8+o=; b=eG5Ol7pVxljDUoLaL5ar9gs
	pORWY21TklkwuY3c/tQ9wtAC1GZLoLV+TIDJjV199jCC/g9uC8+nEWmjUKaWR5WY
	t9fJKGL9/yyswkSPZlnSn5vh/y7uBIywNZaCneOGe4w0aYrxQhO5G/cAgrA8D353
	1uectJOXDJPWQE0DMrXDrcFfnFQZbsMlvIx82NTpf+7Xenqd0kP2NqM6A+PE1NVI
	z+txqV6ZqprK/tXGiYAkHNIJ2NKouuGSX+8u4LTj7Ti9eXUNNcinGMEzX45MHulR
	Vgrlu6GuWpltGAHNe537FIiA/HNfeQ+VJQG9HTCaAPYvB4IavtcAHDl5TiNTgyw=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y16w218wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 11:13:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44ABD4lL013013
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 May 2024 11:13:04 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 10 May 2024 04:13:03 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v2] wifi: ath12k: remove redundant peer delete for WCN7850
Date: Fri, 10 May 2024 19:12:38 +0800
Message-ID: <20240510111238.1113-1-quic_kangyang@quicinc.com>
X-Mailer: git-send-email 2.34.1.windows.1
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
X-Proofpoint-GUID: GTJfJX4pfvQ4aYK_ZCdjXnIHWf2BZJss
X-Proofpoint-ORIG-GUID: GTJfJX4pfvQ4aYK_ZCdjXnIHWf2BZJss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_07,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=933
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405010000 definitions=main-2405100079

From: Kang Yang <quic_kangyang@quicinc.com>

ath12k_mac_op_unassign_vif_chanctx() will do peer delete for WCN7850's
monitor interface.

But for host no need to do peer create/delete for monitor interface
because firmware doesn't require it, QCN9274 is the same.

Also, the first judgement is true only for WCN7850, so this logic won't
affect QCN9274 at any time.

So remove this peer delete.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---

v2: rewrite commit message.

---
 drivers/net/wireless/ath/ath12k/mac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 96dc5c2e096f..1b8a74159ca5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7366,11 +7366,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	WARN_ON(!arvif->is_started);
 
-	if (ab->hw_params->vdev_start_delay &&
-	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR &&
-	    ath12k_peer_find_by_addr(ab, ar->mac_addr))
-		ath12k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
-
 	if (arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
 		ret = ath12k_mac_monitor_stop(ar);
 		if (ret) {
-- 
2.34.1


