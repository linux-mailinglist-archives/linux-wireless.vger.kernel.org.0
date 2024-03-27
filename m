Return-Path: <linux-wireless+bounces-5314-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DBB88D507
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 04:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271E0B23337
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448E422EEF;
	Wed, 27 Mar 2024 03:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N+sh4ew1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374E22EF8
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 03:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509918; cv=none; b=HuOf3+SaRE9vGYoTkPNGL2lromqY6R9U3mbrSN7qPImmCUuwa6sAkD8MTBI/WnGDUiWxZltfNHssbWTnDIjaw106fqSUkc+jYt5LR59cNsJLT0i59wxzzDZDQx3IylFIqg7KE802VhSphwM12WqR4GOYao05hrU8w5/t2qoklvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509918; c=relaxed/simple;
	bh=nN5lnnS++O0nwW9nC9EAqTmhH0cMJZFMA7e39U0VxIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VieCIfygoATBQykzxep0JJ3bgUEYDwILVDOMGTSfZOpyBZ9DS3S4UB1Wp2WMf4Sasy6G2l/SufpJeQ5kOBITDK5Mj6oh/jNsOfF/yXztxg96B7XaHb0k6/9OK102T4OtIm5VyAhmNm39wNCL/NdHlJsS0sVNt6t71Kv80NwOowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N+sh4ew1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R29t7C014719;
	Wed, 27 Mar 2024 03:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=D00Xce7ztpbry1CSLudg7yMIL+Ch8sPkhjouPgKZw7s=; b=N+
	sh4ew1b+lHy2Jo5iXPv8lcjucMLu+MRIB2FNcAJYLtVG7MFEjx+JK9qGMKEozQd4
	9adUytptpjK+L2wHvFAdcle9Li/6BJtAOfZfWaHjMvRhnTCJF8EC6M+9+XiVwDAh
	ILy/BJN+3UIu1IajM5lSMPgPWIK1he9xIGI1rfjAboYC7UBZnkX+pitBS3rd6uKM
	y9uvBxk+GEaCj8JJljCy8ul8snDwIFOHUspFECg3rUFy/+f+eT9WoeTxL/zwb4MX
	BOhggDgz7zemnkT8tlTHPvAzVO8hRMPlFK+r1adVWegoTcVJrIfusHeHcSmOWM8T
	lXWcD6OXzs3v+gUdWbXw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4780ggac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 03:25:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R3P8wY028752
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 03:25:08 GMT
Received: from hu-deng-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 20:25:07 -0700
From: Xin Deng <quic_deng@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: cfg80211: Clear mlo_links info when STA disconnect
Date: Tue, 26 Mar 2024 20:24:48 -0700
Message-ID: <20240327032448.15098-1-quic_deng@quicinc.com>
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
X-Proofpoint-GUID: BLF2axo_HII6VTzA9irJbit2P8PuPQOW
X-Proofpoint-ORIG-GUID: BLF2axo_HII6VTzA9irJbit2P8PuPQOW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=962 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403270019

wdev->valid_links is not cleared when upper layer disconnect from a
wdev->AP MLD. It has been observed that this would prevent offchannel
operations like remain-on-channel which would be needed for user space
operations with Public Action frame.
Clear the wdev->valid_links when STA disconnect.

Signed-off-by: Xin Deng <quic_deng@quicinc.com>
---
 net/wireless/sme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index 82e3ce42206c..86e837f37f8c 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -492,6 +492,7 @@ void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask)
 				 &wdev->links[link].client.current_bss->pub);
 		wdev->links[link].client.current_bss = NULL;
 	}
+	wdev->valid_links = 0;
 }
 
 static int cfg80211_sme_get_conn_ies(struct wireless_dev *wdev,

base-commit: 8027a466a77a288eccd2d11868f504e24231f3b7
-- 
2.17.1


