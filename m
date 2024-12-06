Return-Path: <linux-wireless+bounces-15947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A79E66FB
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4AB284C56
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F55193417;
	Fri,  6 Dec 2024 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZJR2rcG8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375318B09
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463981; cv=none; b=He8pxxYJ3lKhqJcP3kyvwMK9HlI0to31HmKGe17LE021w7LAqBrQLOrgZDL4zGR9uD4o+639SP2ORrEPBy0anLNgFnwhceQRI51+XSLn9TWFEzp4OrnB+kjKGlYFWY6KQQkhJQNmhxvZ8OG6bq9fcU4m3t5lKtX3k0Xknajmabc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463981; c=relaxed/simple;
	bh=HmAlmZYx3JDsy2gH63EsPCWigGnveQTDNVkFUTww9Lw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gs/lycqCqzBMdMKkGx2HPxvtuUvaulrlZkxpKaPpM6xEMLPkldijetuHbHakv58QbXlsv8RwTHG7YHI44rM94pGfjGzKCE0lEGFIvR718ktTJic3Q/kdHmuOk6HTkEGWa7oM9jxmfuADb9mBdiddqtPLm611YL16p0PeM+YkUy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZJR2rcG8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JhfAL018610;
	Fri, 6 Dec 2024 05:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xmKv+KVjtN41how3o9Z4O2
	jLLcC8DsYGeQotW8UsKlA=; b=ZJR2rcG8zpSzdyV1hjskkMnxZpUE7Iaw6j4Gr4
	aww7SOFvhR3FLCbRV3c4MKq8ZlL5s2m20QuSnGEgfK40F5IPoF7qQIlYP6qfVC1x
	kNXJBLCGTcNkV7LCeMaaeagtChVmMWS5yt7+wN480i4mhfxbS8pPl8i7abAMDAf1
	gfsCiutmtEPVX5OLmmQOiHgIqZd4AM5wJZsLcqqJGx6s6yX0lDo6IexX7g8MCHHY
	tp40++ENzLXjJD1Sd9kAWwV/y8DLGQLjiyJUOA5WUvBvg5k6MSBoL+uGwZY8de1K
	iD5IdeufXbTNdXySk9tvk6AjOsbq2WWmqll3+siEqv23XltA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bjk8s6ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 05:46:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B65kDon011319
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 05:46:13 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 5 Dec 2024 21:46:11 -0800
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH] wifi: ath12k: fix leaking michael_mic for non-primary links
Date: Fri, 6 Dec 2024 13:45:52 +0800
Message-ID: <20241206054552.177424-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n1tdAVRIYq37U9RahsF6ANv8oHynxMv2
X-Proofpoint-GUID: n1tdAVRIYq37U9RahsF6ANv8oHynxMv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412060040

In ath12k_dp_rx_peer_frag_setup(), commit ea4192553850 ("wifi: ath12k: add primary
link for data path operations") checks whether a link is the primary link, and
returns directly if it isn't. In ML scenario where we have non-primary links created,
this results in leaking the michael_mic info since it is allocated by default but
could never be freed for a non-primary link.

Note that we can not move the might-sleep allocation after primary link check since
there we are in atomic context (due to spin lock). So keep the default allocation,
and then free it before return to fix this issue.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Fixes: ea4192553850 ("wifi: ath12k: add primary link for data path operations")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index b24d1de4aabb..f8e79eff2089 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -2830,6 +2830,7 @@ int ath12k_dp_rx_peer_frag_setup(struct ath12k *ar, const u8 *peer_mac, int vdev
 
 	if (!peer->primary_link) {
 		spin_unlock_bh(&ab->base_lock);
+		crypto_free_shash(tfm);
 		return 0;
 	}
 

base-commit: 3b2ab397d31f926523f2781d7f0a14a387415bf4
-- 
2.25.1


