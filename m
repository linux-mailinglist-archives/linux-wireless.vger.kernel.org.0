Return-Path: <linux-wireless+bounces-2078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E1F8300FA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 09:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771411F2552C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 08:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F6C13D;
	Wed, 17 Jan 2024 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kxheh5Oj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0FC13C
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 08:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478694; cv=none; b=h0qPwqCyket30Q1PNyeXXZIz4xyO3y+SCpHHghYOLP8EuQxuEaZ9LNjOcnWInlyPEjj3HF7IOYqzBw04TcjMnafjql0bFXnMvdIhh03kdDfOA/Zli7/UHjm6zTmrieqfDXj9SM61x1JtRl3AZ6+znjN/RbXWZ4+Vf8B0QB8nqUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478694; c=relaxed/simple;
	bh=vOnuxfH4UbwZRXF6O9ByJES4xLvFq8SpmtwyQGcRTRE=;
	h=Received:DKIM-Signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-QCInternal:X-Proofpoint-Virus-Version:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details; b=sryBYuzb3aLpTj5e6a7TjePh4nDQzQyflEpdFg5WJ2UHp0VTrw1nva7UAb9wgNnOJg1Ui7n3Xz5/WFEd2o2a7eqTxhPPmrjljER5jh4CvyQmRXfZXwRKQry6S7LdrWqefGiNBwr/UP3lnquJFR/EslK5QaEo7A/yphWAbTksmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kxheh5Oj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40H7uCRZ005033;
	Wed, 17 Jan 2024 08:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=R3esMWD
	bSI53OHA0M56lUt2rtfcjay02Rx7xHJtJeGY=; b=kxheh5Oj8oI9z1/cnTewvho
	pq3K9YbcB2PazaEwP0sebuM0RfuF2brAe9rmM6N5TB+CTuODLzZ1oGw0KjCoWWvn
	c2eKquvbLlpu3E/48uch4AGCjORLy+E4vVg0FV6k2Lgwvc0i9NwP1AIG0rJ0Ybwh
	0q3Kg54iqWRA1U/rarOO8A3tu6KRvoEuyA3u/1m0Mq36CjPfioSsbrS9E9A8D4jQ
	4YO1XnpKvexfXIuTzmY1DvNobnIZWrpfMgICIGaQBVhBUFHe03R5t/D9ZtxN+dAK
	ptCz9EGqeAVBT6NeNjKtmWZ6e2mNla15HIfAG+NrN806WRqob5rtURL6G4RwdyQ=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vp6p3rgv4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:04:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40H84mfm032422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jan 2024 08:04:48 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 00:04:46 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath10k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/3] wifi: ath: replace ENOTSUPP with EOPNOTSUPP
Date: Wed, 17 Jan 2024 13:34:28 +0530
Message-ID: <20240117080431.2907471-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: SQqjSL6DQe1yZt7t_JFpJwA-evxUBihY
X-Proofpoint-ORIG-GUID: SQqjSL6DQe1yZt7t_JFpJwA-evxUBihY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_04,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=426 lowpriorityscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401170054

ENOTSUPP is not a standard error code, don't use it. Replace with
EOPNOTSUPP instead.

No functional changes, compile tested only.

v3:
 - Added "Acked-by" tag
v2:
 - Modified the copy rights

Karthikeyan Periyasamy (3):
  wifi: ath12k: replace ENOTSUPP with EOPNOTSUPP
  wifi: ath11k: replace ENOTSUPP with EOPNOTSUPP
  wifi: ath10k: replace ENOTSUPP with EOPNOTSUPP

 drivers/net/wireless/ath/ath10k/core.c    |  4 ++--
 drivers/net/wireless/ath/ath10k/htt.c     |  3 ++-
 drivers/net/wireless/ath/ath10k/mac.c     |  6 +++---
 drivers/net/wireless/ath/ath10k/pci.c     | 10 +++++-----
 drivers/net/wireless/ath/ath10k/wmi-tlv.c |  7 ++++---
 drivers/net/wireless/ath/ath10k/wmi.c     | 12 ++++++------
 drivers/net/wireless/ath/ath11k/dp_tx.c   |  6 +++---
 drivers/net/wireless/ath/ath11k/hal_rx.c  |  4 ++--
 drivers/net/wireless/ath/ath12k/dp_tx.c   |  6 +++---
 drivers/net/wireless/ath/ath12k/hal_rx.c  |  4 ++--
 drivers/net/wireless/ath/ath12k/mac.c     |  8 ++++----
 11 files changed, 36 insertions(+), 34 deletions(-)


base-commit: c1938548bbeed6fcce8fa6e4de9f694994efcc42
-- 
2.34.1


