Return-Path: <linux-wireless+bounces-6922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5070C8B33E0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 11:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 830CE1C21C82
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0F913C838;
	Fri, 26 Apr 2024 09:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lhs7L8qr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FC13D53D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 09:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123540; cv=none; b=X3z3S+MY3dU0OZ14gb/hIAcAv9hZkSEDP1lN0J4cEYWw0RcWj3j41r0/OFmX5ZoBGMSYkANs4dh4e47tR/7VYELeIJKH3cMiaY6cEFE+id0biBY+tvZGlervrSwfb0rz0W0deMLK7SfFptb4tr43WSnlsxNTXTk9YIS1tJ2HUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123540; c=relaxed/simple;
	bh=g3Mk5QLvG1pPzlQSMEsaMIna+muaiiRpig72hJH+AL8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lpxE12EFFtr7tU4jU5tGHVUjvgmCPdnE4+R/v418xdk4BqkqoMx7FjmZAoQ9pXIY3leXLRDD5Kx3m1EbFt5u5Id6pznPHa2o5chzXy3QnmcC29SlmaEiekTGpPl+wRYDGlDCcGG0fC14FlI3ozJdy6T09VkgEZ0BLemXUf9NwNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lhs7L8qr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q8jJRT010019;
	Fri, 26 Apr 2024 09:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=czEYNIOf1KwJm+opD9kgX945vx9cWNbmsN5hmQ+rB48=; b=Lh
	s7L8qrS4Z7zHZZC/rKUBrJpXF2zv9pQNvpAL0U3V8mSUnXjMeD7ox2OHinCkZstA
	nqz5VG1xS4QAhMehdvdmAfrtUxlVA4LE4E0yZSqekbsle2Ft/f82DGOcQTJcwDV3
	89T/mHlNh5GG3MOXDGlcBRCYYJl0SXyDZuNJI/Map8PRL9jQoOLLr6r9yYTyATMf
	X6CA4doSY5aWVOoIUTvI4zHreYfZQP+QSIhetmSTWUbszQpI0WrmkFAObsOOlrpv
	Zuo3F8NyBB/PtT+/z9RR9FQRmvDZQ/v6QXLDbD9gZmidVvU0pzY/vLoyMGmfFQuQ
	Nnr2Kz7/6idqelAp3eBg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr3591d3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:25:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q9PSaW008776
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 09:25:28 GMT
Received: from hu-deng-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 02:25:27 -0700
From: Xin Deng <quic_deng@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_deng@quicinc.com>
Subject: [PATCH v3] wifi: cfg80211: Clear mlo_links info when STA disconnect
Date: Fri, 26 Apr 2024 02:25:01 -0700
Message-ID: <20240426092501.8592-1-quic_deng@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fdxBifZ78GzdNDDPC9asGb4ap06TOhch
X-Proofpoint-ORIG-GUID: fdxBifZ78GzdNDDPC9asGb4ap06TOhch
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260060

wdev->valid_links is not cleared when upper layer disconnect from a
wdev->AP MLD. It has been observed that this would prevent offchannel
operations like remain-on-channel which would be needed for user space
operations with Public Action frame.
Clear the wdev->valid_links when STA disconnect.

Signed-off-by: Xin Deng <quic_deng@quicinc.com>
---
v2:
        - Change wdev->valid_links = 0 to cfg80211_wdev_release_bsses();
v3:
        - Change wdev->valid_links = 0 to __cfg80211_diesconnected();
---
 net/wireless/sme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 82e3ce42206c..a8ad55f11133 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1353,6 +1353,7 @@ void __cfg80211_disconnected(struct net_device *dev, const u8 *ie,
 		return;
 
 	cfg80211_wdev_release_bsses(wdev);
+	wdev->valid_links = 0;
 	wdev->connected = false;
 	wdev->u.client.ssid_len = 0;
 	wdev->conn_owner_nlportid = 0;

base-commit: 8027a466a77a288eccd2d11868f504e24231f3b7
-- 
2.17.1


