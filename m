Return-Path: <linux-wireless+bounces-6059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771889E85C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 05:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9890B1F22E10
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 03:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F3C64A;
	Wed, 10 Apr 2024 03:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aA2I9Cnc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3F20EB
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 03:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712718682; cv=none; b=ng+dXhXhrPH98iSepGuGKvWiSQgIqiZSRMTciscf2Twb04+9XBJ7+3l8mGScFdv9ycpOX/DAfQuxsT3ZV8g6VxgP7uePzq1GKrAXI9/CxZz0yBFs223hkncfezxz+c/O6tczRZ6VKSZlTFCeiygP+2Btpy/j5APgmQCZWJOmYRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712718682; c=relaxed/simple;
	bh=WXVR5Slcp9sF1GWCUfEwZFfufSRs8OFc1+dqEaf0jRI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S3i0q2rFla7vFJ8+CUb4RRle6luic3wJWoiTq8JncspNZpDj0HVHBTaUKFCahMY74FMMhgB1DJSvdSfCFoRS9e/k8GmNzKonYYn491T65OxZJfabtdprfUNaUXtKnwsblqrUGISrqUXWzH7Mc/vInCOeVJ8ro1+vCNzEs20hnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aA2I9Cnc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43A1XLvI028103;
	Wed, 10 Apr 2024 03:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=guxfdpP/7sTWwuRs/bJeCcUC8QIT+TmO1i4ZfTAxiro=; b=aA
	2I9CncDxzDS/aVx1LiBRhAweQF+/mQaBfoJJLARCqt1NmMG6QWJe7Pv+quJ6s2Wh
	yl4S6eqjJSNYeTTvEPjj+rYK7kJvImJkYU+//tiOt0JmiprUAYjVnBkMgcs+Wc1i
	K+t99y+ZiwS8I7sLHz3SsSxlKBjzDvUazo77cSWC8GPAhKY5nc6tw001m8r3WhTV
	35rm1bYnLWvJhGo2lv2h+KiOqqSbKz33IpKxPTPLvgEoukHhB5kTRuGzC8meZMSE
	F+zwVSM/0pXnixIJBX+GUZwYIK5Tj5GGuIxzDR04L4CRBIAM1952NmmvId0j8nRB
	Pw2uvornmvEs2sLjO1aQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdh6qgcbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 03:11:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43A3BEXr006311
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 03:11:14 GMT
Received: from hu-deng-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 20:11:14 -0700
From: Xin Deng <quic_deng@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] wifi: cfg80211: Clear mlo_links info when STA disconnect
Date: Tue, 9 Apr 2024 20:10:48 -0700
Message-ID: <20240410031048.23372-1-quic_deng@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5UatMNzqWOAPkQO4zwSOvZ34q50q49jO
X-Proofpoint-ORIG-GUID: 5UatMNzqWOAPkQO4zwSOvZ34q50q49jO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_12,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=978 phishscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404100022

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
index 82e3ce42206c..6a08f9d35eb2 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -477,6 +477,7 @@ static void cfg80211_wdev_release_bsses(struct wireless_dev *wdev)
 				 &wdev->links[link].client.current_bss->pub);
 		wdev->links[link].client.current_bss = NULL;
 	}
+	wdev->valid_links = 0;
 }
 
 void cfg80211_wdev_release_link_bsses(struct wireless_dev *wdev, u16 link_mask)

base-commit: 8027a466a77a288eccd2d11868f504e24231f3b7
-- 
2.17.1


