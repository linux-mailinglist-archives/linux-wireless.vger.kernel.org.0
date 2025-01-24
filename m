Return-Path: <linux-wireless+bounces-17890-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421AA1B04B
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 07:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9DA7A448C
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jan 2025 06:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7191D6DB8;
	Fri, 24 Jan 2025 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CHi2K63b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0791282F5;
	Fri, 24 Jan 2025 06:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737699418; cv=none; b=fc8FxaWv/3pHYsym/tclu+EKgxZ2pezPsorRuBH2HI48CxZG1e8YUR4RYga6d7QRGALz3ZkIYaJjdlEZZmz3KDmNxk73uE2N2n+PFnceBdYyUy8OgHvrnQzFjhm7ctJNHD/sx3uj87AJdnwhCWG/9CECxPo8h98PkWp314lnOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737699418; c=relaxed/simple;
	bh=tYgZnVNKi3NZvFTHDaqVzggQ5lcICzJPgXzEn331rZc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=rrG6H2i7OYCPY8cadsM37Ge1oI7od7omCHJxh8EIoIS+s/0HQ2lO+uDud7YC+R23M2qy1ELmM76FUAdn6qsmUfnmz0SpHp+lm7ZDLBgC7vIM0QcnZtKu8NuuVLnfFzzPGq6Fe/IKJEnRGe2mLcan5ivInqbXP2yE+mKudPE2ek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CHi2K63b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O3GTpe006824;
	Fri, 24 Jan 2025 06:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TjLpMS6x+RwtvlryzfD4wA
	6UUGx2cYpikbG/Si4Xym4=; b=CHi2K63bJm1S449o3pCdJMwv7V/1EQ/V38ay33
	EsqSemPCumeE1fxK+d/BC2A6iMtRyy05K5ew2z/B87CTrvud2eeQanbYqFjr2BZM
	sROwRr/GIJKYpBflFI/XnvsFEHST3fr1ERFN5xekPbgLg6IZTdKJSG48vnr5HsDI
	cspg6N/DShqXZdezTEG3joBjDbKkCA1HqwD2WN2eQS6R68NmGtp/cPP35s9NmQbc
	8l2EjiGR3T3XLcggUa2/YHM8sTO6H3pmH2+0hjV4ZfJKt+MYn4nXAHxnirv2lD8f
	skBhQ/UDa5oyZwLMN+Uc/edQhqbBCm9t+di7eaVS5mdUzPqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44c2t48ah8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:16:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50O6GpcW031630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 06:16:51 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 23 Jan 2025 22:16:49 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v2 0/4] wifi: ath12k: add MLO CSA support
Date: Fri, 24 Jan 2025 11:46:34 +0530
Message-ID: <20250124-ath12k_mlo_csa-v2-0-420c42fcfecf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEIwk2cC/13MQQ6CMBCF4auQWVvDDJYSV9zDEFLaKhOFaotEQ
 7i7lbhy+b/kfQtEF9hFOGYLBDdzZD+moF0GptfjxQm2qYFyOiChEnrqka7tcPOtiVoUsrMSSed
 SO0ine3Bnfm3gqUndc5x8eG/+jN/1R1HxT80ocqGqrrRKopRlVT+ebHg0e+MHaNZ1/QA0yCvFr
 gAAAA==
X-Change-ID: 20241217-ath12k_mlo_csa-35bd512a05ae
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yvb8rKINXhbvn_vZz2QtCn9Gn7baKTqf
X-Proofpoint-GUID: yvb8rKINXhbvn_vZz2QtCn9Gn7baKTqf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_02,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=768
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240043

Patch 1 and 2 are pre-req fixes (applies to non-MLO as well)

Patch 3 basically uses arvif->link_id to enable MLO for CSA while adding
support to update counters throughout the CSA time.

Patch 4 fixes a potential problem seen when medium is busy. Again this
applies to both MLO and non-MLO. But this is exposed only when Patch 3 is
there.

---
Changes in v2:
- Rebased on ToT.
- Link to v1: https://lore.kernel.org/r/20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com

---
Aditya Kumar Singh (4):
      wifi: ath12k: update beacon template function to use arvif structure
      wifi: ath12k: fix handling of CSA offsets in beacon template command
      wifi: ath12k: update the latest CSA counter
      wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE

 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  7 ++--
 drivers/net/wireless/ath/ath12k/mac.h  |  3 +-
 drivers/net/wireless/ath/ath12k/wmi.c  | 61 +++++++++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.h  |  2 +-
 5 files changed, 57 insertions(+), 18 deletions(-)
---
base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
change-id: 20241217-ath12k_mlo_csa-35bd512a05ae


