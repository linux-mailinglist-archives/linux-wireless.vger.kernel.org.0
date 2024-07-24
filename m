Return-Path: <linux-wireless+bounces-10481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FC893B112
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 14:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7789D1C21108
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Jul 2024 12:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8242158869;
	Wed, 24 Jul 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FWGD62wu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BAF158213
	for <linux-wireless@vger.kernel.org>; Wed, 24 Jul 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825632; cv=none; b=R98iuvUioA2zWneK+fWe+335sq2GrLCHiKwQkAtvPXTset2whToPHIx4C1Hs0yxjEr2GBOoEk6oGGfFqOZZbgC8/BIjXw1rQNyGmnWra45mC0t0S0LnvobEuBrpbw4DllRhYpeHTII745FvYQ2e4HfBkKU9mcHw9xHe9k8h1b5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825632; c=relaxed/simple;
	bh=E9LNwM8Q+npgOZtS8hzOsRLKitiNzHNet5yOqnpYG+Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E74sc0cm5paWu1Tcfra6zhaQE2OzNdFv08pJJKtbihBNmzezi6xBoVvulCoC3QICEHf3igA2UI+R3GqQ9YXR/QC9eo1dySz16MVtTyUQxNOkGECLmFFf3G14zuCRWKUumz3F15mDMxC3yqNdLU7fn3Iw1S+Ylucxg2UqLpddhoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FWGD62wu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OAIhIe010800;
	Wed, 24 Jul 2024 12:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+/GXAQp2ZCY4uS4Z64UnUT
	L4ZCMqqf9gqOduweg4SYg=; b=FWGD62wuIctF3eQSqZR9RnF2gTub0q65wMEztj
	063AQypg1scB3giVfpkNDnOaTpEkTqa4BBAFCCKrMxiTpFjsfLtXJ4T/S7kAYaTG
	PiFmdY86j3lF628kdnJM831+6Vlf3AbpOK3WsaliOvXlDFI08jmbJ7VHvDUTB1RR
	e5+RGtgj6tupM9WxQuWWjeEKvETqUa9yfwcbOx+mq6TuuNClnBz3Kg4lGEs+XOmN
	p01D0WeJ3Cv/Yy8JTSb91EgXE2oCt046EJdo+9hIhkcKSS4XLS8YUYewvdOvKxRm
	dKbJ/ybzVK3NFGTG8j2+oMJU1Ya1W1wSxktpIBCR9kohkpiA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40jyrfgbh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:53:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46OCrkd9005604
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 12:53:46 GMT
Received: from hu-vjakkam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Jul 2024 05:53:44 -0700
From: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_vjakkam@quicinc.com>
Subject: [PATCH v2] wifi: cfg80211: fix reporting failed MLO links status with cfg80211_connect_done
Date: Wed, 24 Jul 2024 18:23:27 +0530
Message-ID: <20240724125327.3495874-1-quic_vjakkam@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: PuAwfr90pgmtbUvhMOs82CY0ZvTVRsn9
X-Proofpoint-ORIG-GUID: PuAwfr90pgmtbUvhMOs82CY0ZvTVRsn9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_10,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240095

Individual MLO links connection status not copied to
EVENT_CONNECT_RESULT data while processing the connect response
information in cfg80211_connect_done(). Due to this failed links also
indicated with success status in EVENT_CONNECT_RESULT.

To fix this, copy the individual MLO links status to
EVENT_CONNECT_RESULT data.

Fixes: 53ad07e9823b ("wifi: cfg80211: support reporting failed links")
Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
---
v2:
 - Add "Fixes:" tag in commit text.
---
 net/wireless/sme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index e419aa8c4a5a..d9d7bf8bb5c1 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -1045,6 +1045,7 @@ void cfg80211_connect_done(struct net_device *dev,
 			cfg80211_hold_bss(
 				bss_from_pub(params->links[link].bss));
 		ev->cr.links[link].bss = params->links[link].bss;
+		ev->cr.links[link].status = params->links[link].status;
 
 		if (params->links[link].addr) {
 			ev->cr.links[link].addr = next;
-- 
2.34.1


