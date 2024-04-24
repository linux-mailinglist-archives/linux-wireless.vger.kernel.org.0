Return-Path: <linux-wireless+bounces-6755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190EB8B02B9
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 08:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A4031C227C5
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03B13B5A6;
	Wed, 24 Apr 2024 06:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W9dtbpgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C0156C53
	for <linux-wireless@vger.kernel.org>; Wed, 24 Apr 2024 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941830; cv=none; b=fopQ7ddHYu48j4ZAdIeVKRnbl7jxnGO6d3Crc/84S6ujHe/Tvn3PY0bZt0wjdhIKA34N9cMigoQnQGurnVyFLQS4DAUB1yKcDj/kUoKwMocOth+jq9twApgYxqMVb4Os8NevkmN+ZywcTEh3C2eyZIrg3DxCIowN5QGe843076s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941830; c=relaxed/simple;
	bh=tobKFsSVwGGX6McTLYQt9fW8PZiTAPwlPtFYE8+GykA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NiiCnI3+VfczJ0jbDLvtDwdfKqzYBKnioXM77w6LIBFkpKT5ogL6UeH9Ot0ILijXWuLeSrAwg64fDyj46F48TAkLhqLpcv2M3B/56Gm/a+JUJEgBBgxbH5dEg/a8cLEFiRBzriVB0kr+YBbnc4+ObrJA4IjGcmViS1dbKbVjUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=W9dtbpgS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43O6WwX7022778;
	Wed, 24 Apr 2024 06:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=PvJkgx9
	KwB7uBqVMPgUMHgAkN2uJht5c1B6uLIUS5as=; b=W9dtbpgSQHq9MdnSe1XIvNs
	LV9R1sokdSx4EJvnE9JO1ZNEFJIxI+aAsyt8NipaDTB0kIiNnDNmzE21rsIrtQ2z
	IisjEDEhWnz3vWGUoQY0+O7eBwBLBzJJxVd80oJrvLyPr95x6GcrK7S6p12/y0SN
	pEPjkZNEbDdztwuTJEAZ9E84GrDom98Yj4om6gd9Ln2A9QRFuRkoMal2AWqUGeSj
	kbrrslFTIFK1vfGbbeKFm31baxCc+2bDIDvGrg/Qzlz2jpplf5g6+jtAiKwNzWui
	BTN5JHaLmkjGQ541zBZbYYrKjmk7+0LUrGyid0RFo+BnmSct2v6R+BaaUVV0Izg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9fg40w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:57:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43O6v19Q002219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 06:57:01 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 23:57:00 -0700
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v2 0/3] wifi: ath12k: Refactor the hardware recovery procedures
Date: Wed, 24 Apr 2024 12:26:43 +0530
Message-ID: <20240424065646.1666166-1-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: eJwZQIXmIEDhqFrodvfXz6gWD0dRZ3dK
X-Proofpoint-ORIG-GUID: eJwZQIXmIEDhqFrodvfXz6gWD0dRZ3dK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_04,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=646 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240030

Currently, hardware recovery procedure supports multi wiphy model. However,
to support single wiphy model, we need to refactor the hardware recovery
procedure. This patchset allows the logic to work both multi wiphy models
and future single wiphy models.

v2:
 - Rebased to ToT
 - Renamed the lock name as per the kalle comments

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor the hardware recovery procedure
  wifi: ath12k: Refactor the hardware state
  wifi: ath12k: Add lock to protect the hardware state

 drivers/net/wireless/ath/ath12k/core.c | 98 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/core.h | 28 +++++---
 drivers/net/wireless/ath/ath12k/mac.c  | 95 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.c  | 19 ++---
 4 files changed, 149 insertions(+), 91 deletions(-)


base-commit: 1b61047b44218a00c7a7836eff4f8e037d5634d8
-- 
2.34.1


