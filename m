Return-Path: <linux-wireless+bounces-2773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7BB841BBC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 07:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2FC284F18
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B3E381B9;
	Tue, 30 Jan 2024 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ITKx/Y3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC3381BB
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594942; cv=none; b=s+FqEtdAbogoPjMP5fydF8omO3hSI4LU1pnBDDqvjOZ1ixumPNscPHOSRWDx/imYbCpDDuI5JgxhaGWbnJ29l49txPiAGguQw2timCPISXyIqMgqKkiF2B0Ojpfesm8E5iwoUON0eEjEigc4hfgtNLi+lNo/7CqZigtun+xf0A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594942; c=relaxed/simple;
	bh=/jtBI46qUdzP1WllG3SjIv9iGSqEeh2GuuqxeYD/OzE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HCe31UxqEA31qoS/09LjbyEbv2sjKn4N/bXpRFuwhB8xRtyoGgY1p30Vm0PKX7ajACxaiPRms+m3TcRMycbZLOoqniIaLyrQlcTdeJbs4tsC45mwLjdK5QKtBIIozOnKK1n5j5pL306b+8ve9xRseSQTnkS/CF3ij+HThM3n/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ITKx/Y3s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U4tcVE011575;
	Tue, 30 Jan 2024 06:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=eBPOUTS
	tUtXOdZiLPwsIUbuE9YttOk/G4h+qPGGbswc=; b=ITKx/Y3sZi8GDPnW7XvpZlA
	LDv19JnEA+NkfICgG1xkoy2MopKQE9X+sUGKNg9SGB9r02eV3znEzsyHyGfGVEPG
	5Zhkk4RjLQjhGMSheWysCCQgVISeFzt2UTKxCG0mus8MkJV/gwqreyVyRwwaq0WO
	8bk4TfUftlKIaDdu35hLBqTAFJzMqaYGFesvRx4dF6idCr5PuzDxbyjq/ArXKI2q
	6/VpHtCle3lyntHaO8XPFTAL/ce4g/GU52ZSc9Abv4pharyoBEcTRqDJ088dgFKH
	4lNtBi7oCh7hyUAJedZ1NQDMmilmRd5OJ8Xd3+6QhBMusFInwtBqUtHlG0FdyvQ=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxsc207t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:08:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40U68sY4008729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 06:08:54 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 22:08:52 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Refactor the hardware recovery procedures
Date: Tue, 30 Jan 2024 11:38:35 +0530
Message-ID: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: xT4d9Li075nwkBR-iar0PB-avYrq_hXA
X-Proofpoint-ORIG-GUID: xT4d9Li075nwkBR-iar0PB-avYrq_hXA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_02,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 mlxlogscore=333 phishscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300042

Currently, hardware recovery procedure supports multi wiphy model. However,
to support single wiphy model, we need to refactor the hardware recovery
procedure. This patchset allows the logic to work both multi wiphy models
and future single wiphy models.

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor the hardware recovery procedure
  wifi: ath12k: Refactor hardware recovery synchronous
  wifi: ath12k: Refactor the hardware state

 drivers/net/wireless/ath/ath12k/core.c | 97 ++++++++++++++------------
 drivers/net/wireless/ath/ath12k/core.h | 25 +++++--
 drivers/net/wireless/ath/ath12k/mac.c  | 95 +++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/reg.c  |  5 +-
 4 files changed, 137 insertions(+), 85 deletions(-)


base-commit: 17f4b952f067b1f87d14e6df4c8c216fe7a245d1
-- 
2.34.1


