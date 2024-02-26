Return-Path: <linux-wireless+bounces-3988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78E88669D4
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 07:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33F14B214EF
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 06:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9028C1BC37;
	Mon, 26 Feb 2024 06:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QtW6FbKl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC781BC30
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 06:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708927368; cv=none; b=hEnYHnlFQJqkCtEjFTaJ35OS4CyWSjMhqHgPjnmUz0f6eS4gYnK9LDn87ybRH0NPcrK0CjJe89IkVULvaC26A88NC5eWsF/3VdGoscquC9ziKcBkTnmEYNwbQJduvutYbgAqRoRphdsvaiha4rutbU45KPKjynZleIS0Cvpf3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708927368; c=relaxed/simple;
	bh=0nSAZCTseBn1OUZiEgmDpiDV0frQtpKcsJLHOIe4WRY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kdTs4uCupG8xhW9BH1J2y50lpJOQa9TZQt/qfEH+OJhRgmORglsV5ASC0elW9dP5eFPS2KW89bHDGWSgGPmddQjVjlqFFPyGua9SiR8dKq0nYrzeH8glWZcQ6dIoDYvyZq1ojm+T5NPz1kvEiOIiO7RSverEujACjreMiaEbHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QtW6FbKl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q5dMo1012073;
	Mon, 26 Feb 2024 06:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=++fvpXl
	d3il1aE7M8WTkbHNqQiqvzMqRUmu847H9SQg=; b=QtW6FbKlfNQQzfQjVmFQuo2
	neOiFXjiTdQ9h6r1LlmKOkgzEg+FFXV9Ud2flKlQX52JuaNS+Wo+/dtmkuf4AoDX
	AttQMbqDjiflHtYblQrZFUs6gBK110H8JgBtrEMvUqrfecHAKZO3k+afdHTxjtU2
	S4Mk4G0acOTR0CWj/8UOUWVZ5zuXqyh7ukIyJWowIcdtyO7JSftgdw5Lvw2056b0
	S7eyeFCMWzZv+BXszo8asCsQ65HIvHe1esl/xMpKOCrOLCUvtGgIJhQbVBSj0PL+
	35mNAMnWaMaWBgkCywhTzq3SrUqps5cftlSIKl/sfVtXPgFiWscR5J0lxAm0Alg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxng3gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:44 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q62KuP016889
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 06:02:20 GMT
Received: from Mayan.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 25 Feb 2024 22:02:18 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH 0/6] wifi: ath11k: P2P support for QCA6390/WCN6855/QCA2066
Date: Mon, 26 Feb 2024 14:01:57 +0800
Message-ID: <20240226060203.2040444-1-quic_kangyang@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JzkYb_3trRe9AKt_d808MeqlRrGjdtBU
X-Proofpoint-GUID: JzkYb_3trRe9AKt_d808MeqlRrGjdtBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=771 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260044

Add P2P support for QCA6390/WCN6855/QCA2066.

Kang Yang (6):
  wifi: ath11k: change interface combination for P2P mode
  wifi: ath11k: add P2P IE in beacon template
  wifi: ath11k: implement handling of P2P NoA event
  wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
  wifi: ath11k: invert scan flag WMI_SCAN_FILTER_PROBE_REQ for
    QCA6390/WCN6855/QCA2066
  wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066

 drivers/net/wireless/ath/ath11k/Makefile |   3 +-
 drivers/net/wireless/ath/ath11k/core.c   |  20 ++-
 drivers/net/wireless/ath/ath11k/mac.c    | 159 ++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/p2p.c    | 145 +++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/p2p.h    |  23 ++++
 drivers/net/wireless/ath/ath11k/wmi.c    |  99 +++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h    |  42 +++++-
 7 files changed, 454 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h


base-commit: c39a5cfa0448f3afbee78373f16d87815a674f11
-- 
2.34.1


