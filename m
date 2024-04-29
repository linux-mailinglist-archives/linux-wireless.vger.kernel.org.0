Return-Path: <linux-wireless+bounces-6974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48168B52EA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 10:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4319A1F21043
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2024 08:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD2D175BF;
	Mon, 29 Apr 2024 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RLDo8UJj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5037117592
	for <linux-wireless@vger.kernel.org>; Mon, 29 Apr 2024 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378555; cv=none; b=iFY7YNclWcAjLj90WICPBcuzzzRoOw/ruv7ZSKBg430j3/cNdRbCa/A4hCeltY4QAc9PZOvL/JSs8ShpxOqICuUDNW9waIVEneuSKpu/kA0V6e9H1L6IT2+v5t335ZYbam8f8wMs35mkfnthBJk0VHEte5mP7LnA38h48LxNBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378555; c=relaxed/simple;
	bh=GNAkfHWp7HCGgkRZQMpXZqgLlfutUsV7OZq8jmH5y2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPr6Ove046nIcw/EcZpt3WO0YayLeAObF+MHJDT28aL4oi3GqdqaQk9kT7HAGbdCtu+LrVcPVw/61Kl8RAP2W/51fqC5PPUnVm751Dkwcdru5B+u0LQyRnRm26u4OojEyC8uJSKwi8VKCUn7n5K+8o8tMwEOGh6NM+asmTn3Djo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RLDo8UJj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5H35j032085;
	Mon, 29 Apr 2024 08:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=U2Md2tSftTGHp4nYoJdxRz6i1DgHZzpoHZpoM2WBy28=; b=RL
	Do8UJjnTikcK7ynAcuyJUz9RuuY0QkFk+cLqqqKMluwWIqZ8rMJzGJaKZ3oWZzgu
	Dlf1DJcFv+QQiKMosQrDG+3YEmP5ga/cDkjJ4FSeGztRNNdak9vr0DCw4wOs/wSS
	bjK04qlVlptVpE7rZhG6wU4hvMfRs31n/cx3xICYdI6qVk5eiSI1wRjgCVJ/TGUC
	+JW7HJnR8wr4Ya51HGTtFY175IZNsQmoTpWJelLYCAWbyiDwcYuNBHu72rPxn52B
	ws807SCQC0aopFI4OMMs9GrikAR5sUeXC3Ekcn0sJfOhh6mOqU++GdFwC/tvKe+E
	lwJjynE55VWNly3TEm1Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrtnek28s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:52 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43T8FpeU006947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 08:15:51 GMT
Received: from kangyang.ap.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 29 Apr 2024 01:15:50 -0700
From: kangyang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 4/5] wifi: ath12k: remove redundant peer delete
Date: Mon, 29 Apr 2024 16:15:24 +0800
Message-ID: <20240429081525.983-5-quic_kangyang@quicinc.com>
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
X-Proofpoint-GUID: i43JtGQqi2FZdx04eVKpEQSgtbhk6SVP
X-Proofpoint-ORIG-GUID: i43JtGQqi2FZdx04eVKpEQSgtbhk6SVP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_06,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 mlxlogscore=727 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404290051

From: Kang Yang <quic_kangyang@quicinc.com>

Firmware will create internal peer for monitor mode. For host no need to
do peer create and peer delete.

So remove related code.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 9a2823bcf8fc..f994a78e7dc5 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7354,11 +7354,6 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
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


