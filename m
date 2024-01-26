Return-Path: <linux-wireless+bounces-2554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93583D9A8
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272E41C23A77
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 11:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD846199B4;
	Fri, 26 Jan 2024 11:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q5aUj80j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9E199A0
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 11:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706269982; cv=none; b=j3LtRwoOly3pW4sS+cGuhUHpT7wJziy+xk+SZ+h9OrU2wGD4yrD37Q+Aig4P7pP1b5lFZKQf114sToaGNfq7aEGg9fKbOTr12VE3mm1MPyViNbDIP7mmscbL4jvkK8wVBweaWcQ1uLsEm+LFvbJWMPgWuTx8q2bLW05UBR8vMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706269982; c=relaxed/simple;
	bh=cjzrOKhcOi39tZSvQ3LY7KOIzsBu1sSEfVu+T3WDVfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I43UiRMvJN/d9xg789bLXATEC/Ul6xiIDpqgsHpGixSK3JcPSPn69B6ph+q0iQZZLBVZpMMNiNrPHCeDzCPCQQygzOOVIpAK4t79OfuUOy0ubobZM0rkVFgxPlGQsvQmyRSi/viDoorCYTKPPk2Ova9K/Edgj9jbLLIaugYBwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q5aUj80j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QBDDjw004163;
	Fri, 26 Jan 2024 11:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=XP5ZWHP
	Hg9Xh+ftA9D3NIYvUkYeFrVyKUMLvSKQ8auM=; b=Q5aUj80jlXLHY5qw4ngaij5
	yTY1oYvZbJaWZ/MUK52ClHivEvIJ4yZPYQTqULckDURUQrlnpvD6dXOccd8wLvkh
	Pz2qKvOnIP5GcYL/Z3BlYGybR7jp1569NPrYOSx7uzYaKArsTDbuzox6WV43sAHV
	1Tg9unS7I57Cx3DwIJVfB6q62Q2EoAPkELRwapjt0ufbuxx+GCvQvYuwC76kM6PO
	oY2PDKEKloczySM6n35i7OSXga5J9cVWXnqlrf6dhd++P/8vcpUgkVWobrprjoJI
	Rb9W6XuO4NdPqU41Iwn7R255NJN7huvps0tmFMtzG4ntXk0w5aXeHMQy4s1i3hQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv1yps8tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:52:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QBqngU008162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 11:52:50 GMT
Received: from yk-E5440.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 03:52:48 -0800
From: Kang Yang <quic_kangyang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_kangyang@quicinc.com>
Subject: [PATCH v4 00/11] wifi: ath12k: P2P support for WCN7850
Date: Fri, 26 Jan 2024 19:52:20 +0800
Message-ID: <20240126115231.356658-1-quic_kangyang@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Oqxx8_608M8EWCMNKRTqx_yx4n6GtKu8
X-Proofpoint-GUID: Oqxx8_608M8EWCMNKRTqx_yx4n6GtKu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=949 mlxscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260087

Add P2P support for WCN7850.

Kang Yang (11):
  wifi: ath12k: change interface combination for P2P mode
  wifi: ath12k: add P2P IE in beacon template
  wifi: ath12k: implement handling of P2P NoA event
  wifi: ath12k: implement remain on channel for P2P mode
  wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
  wifi: ath12k: allow specific mgmt frame tx while vdev is not up
  wifi: ath12k: fix broken structure wmi_vdev_create_cmd
  wifi: ath12k: move peer delete after vdev stop of station for WCN7850
  wifi: ath12k: designating channel frequency for ROC scan
  wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
  wifi: ath12k: advertise P2P dev support for WCN7850

v4: add a new patch #10 to fix warning(Kalle).
v3: rebase on new ath-tag, use ath12k_ah_to_ar() get ar(Karthikeyan).
v2:
    1. add Tested-on tag of QCN9274.
    2. update copyright in patch #1, #2, #4 and #10.


 drivers/net/wireless/ath/ath12k/Makefile |   3 +-
 drivers/net/wireless/ath/ath12k/core.c   |   1 +
 drivers/net/wireless/ath/ath12k/hw.c     |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c    | 368 +++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/p2p.c    | 142 +++++++++
 drivers/net/wireless/ath/ath12k/p2p.h    |  23 ++
 drivers/net/wireless/ath/ath12k/wmi.c    | 116 ++++++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  50 ++-
 8 files changed, 644 insertions(+), 66 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h


base-commit: 17f4b952f067b1f87d14e6df4c8c216fe7a245d1
-- 
2.34.1


