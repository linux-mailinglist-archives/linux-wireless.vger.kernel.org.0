Return-Path: <linux-wireless+bounces-11315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7294F146
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 17:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE5AAB21FD6
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 15:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1DE1E504;
	Mon, 12 Aug 2024 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EE4PL0Py"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC4F14C5A4
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475263; cv=none; b=aTWyVX8MtosbfNXeNLfhHcssAf89IfUxv1nm7RwwZ8WyHzRVVkqt/O9Q9AgqgM3Dpk6fwkozjdvk3r/xDtQcoCYXQFkgcezdcy8HeOziqhhqjRKgwm04cegiLCkEZFzFYNLo2m2irbNAHpCfVoVWiryUeaAsvWjcSp2Hgxg2zI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475263; c=relaxed/simple;
	bh=94g+ZQYkMtaFqgP9WGbnMfmxKbyOD2406zxPv3sEBqk=;
	h=Message-ID:Date:MIME-Version:From:To:CC:Subject:Content-Type; b=oI8EUTYoQ4rTboouE27j22qfncdxJ7zOJF626nfpJFykpkpvszP3om2UTnumq+V6XoovtGKYdDmd/eMH+rbFhMDpTdx0oXT4j5X3b05iSDsUFd+QepVDW4if/ZOSBHWtiS+VL9AMI0J2HWQMaiBUwDBGNVARZBzTM1IFDYlSDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EE4PL0Py; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CDSTT2001043;
	Mon, 12 Aug 2024 15:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=GvMLIUxd1sWR5SI1wQrmBc
	ATK5sUWrvbdeu4Db5BmhQ=; b=EE4PL0PyKCR+C1zTJ7wC6vvZDVNW+PzrOgagKW
	Ld+CsWHRqkRFyCmnG/Rc4TfgGaN5Pw7mRdNArtNEl4Dht4sEVJkxQv9di/45v8QX
	g/dSkuBkJDikF5dDgKxW8awWEcFGWCkN1BulSwWMYwl3lA9CCIj6Kx9pd0nKopyE
	5r4Tpk5rQVd8DJ+pyJyrh0QEU073dmNmf1SVUchVdRvVIJCO0WC00d9f5cM2qbF8
	MbQ+nxtkG7kJ6B4MHThRkTb2dLaOaX9vUaz2Drjg8WqzuO9yhBnxno6hql6y+zRB
	9CwVcN/fmFhT9o03tXrYI5oepPsLFPmQKRSYd+dinxMqurOg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x3et4g57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 15:07:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47CF7ZIC022449
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 15:07:35 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 12 Aug
 2024 08:07:34 -0700
Message-ID: <7c3b295d-3d5e-40ee-ac33-c92669f29d51@quicinc.com>
Date: Mon, 12 Aug 2024 08:07:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <linux-wireless@vger.kernel.org>
CC: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
        <ath12k@lists.infradead.org>, <quic_jjohnson@quicinc.com>,
        <quic_kvalo@quicinc.com>
Subject: pull-request: ath-current-20240812
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9weQVwKyogkPxWi5uiLK3LvEWgaKtSJ7
X-Proofpoint-ORIG-GUID: 9weQVwKyogkPxWi5uiLK3LvEWgaKtSJ7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_04,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1011 mlxlogscore=580
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408120112

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git
tags/ath-current-20240812

for you to fetch changes up to 38055789d15155109b41602ad719d770af507030:

  wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850
(2024-08-05 12:28:07 +0300)

----------------------------------------------------------------
ath.git patch for v6.11

We have a single patch for the next 6.11-rc which introduces a
workaround to ath12k which addresses a WCN7850 hardware issue that
prevents proper operation with unaligned transmit buffers.

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: use 128 bytes aligned iova in transmit path for WCN7850

 drivers/net/wireless/ath/ath12k/dp_tx.c | 72 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/hw.c    |  6 +++
 drivers/net/wireless/ath/ath12k/hw.h    |  4 ++
 drivers/net/wireless/ath/ath12k/mac.c   |  1 +
 4 files changed, 83 insertions(+)

