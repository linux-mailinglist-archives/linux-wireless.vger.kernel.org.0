Return-Path: <linux-wireless+bounces-12241-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BDA9658AA
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAE01F23B1D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2613632B;
	Fri, 30 Aug 2024 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xsqol21O"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5F7602D
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725003276; cv=none; b=PND6Dl3gAJ4pFAi2WdHFp25Uz3RsGqxEWytJ11Mfkyw2uRflLYmHb05RmLeDBxHOTDtdiqEtAWo4vD6DLvrfHciyYee2ERlgP6uFnxxe7hZhx6m6JkMcnixHvKPLvghFuTpgdhYQBWU2MBOvTAEByS1EhYQpFVyIh+ysxcRvmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725003276; c=relaxed/simple;
	bh=NJVwufjbTx01OsEjj99xWbgoXwqyPPQn3h/1qhdD30A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aihB7bmwk7OvIkv8XdxJnUC621XzKyMroaLw/lczuA9lkXhmJ1hc8SuIT78/aoUk6w1vK7cwNGwcIjf1WFLt50vDJAYz3iKJzauA17SY8Q6mGpL/Sv/QxrDTsLLN1TCSWNr0bmSxcZlIwWOmyxsZUi864N8Jq4luUw5y8SW6OSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xsqol21O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TGZXn8026587;
	Fri, 30 Aug 2024 07:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nnxVEnhocjHvzatUPU0zkK
	03weelDH6wgz+zQlZtLNY=; b=Xsqol21O8HaTFvA2kDwlR60NsWnPUtx6EA6lDy
	r1VLkXjw3vKcbLjEQIWb21rYo/9Z9obE7felOKSblO5rYtpvVJeZwxyoyq8th+iJ
	tDOoQVe+bgHc9fRkrZGoSsRvCZ9Ya34QIO/TYwwKJzXUCOBrZukgEsZRhaaHncOZ
	7d2bFlq/mXzH0sXlnTcUo+t8RkMUKBTiHSmVOp8MPaiKT9ZVFowb2uNkuJ1AODrh
	afsk0qICIIZPVzAz1RY8NCUw5dpX8nmzxBNJ5dYlWdCm/MCKCMAQpzgyVN6p5olW
	ZHXv1OXS0C2jzubzvTPqrM6+uJe/AKdt3Vqf3FJETiK2rVnw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 419puufqbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:34:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47U7YVRr016348
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:34:31 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 30 Aug 2024 00:34:29 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH ath-current 0/2] wifi: ath11k: revert hibernation support
Date: Fri, 30 Aug 2024 15:34:18 +0800
Message-ID: <20240830073420.5790-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: ySyWZ6_FOaTOT9wfEhbOI369QmGy4g-e
X-Proofpoint-ORIG-GUID: ySyWZ6_FOaTOT9wfEhbOI369QmGy4g-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_03,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=589 mlxscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300055

It is reported that commit 166a490f59ac ("wifi: ath11k: support hibernation") breaks
system suspend on some Lenovo platforms. As there is no fix available, revert it for
now. And because commit 7f0343b7b871 ("wifi: ath11k: restore country code during resume")
depends on it, need to revert it as well.

Baochen Qiang (2):
  Revert "wifi: ath11k: restore country code during resume"
  Revert "wifi: ath11k: support hibernation"

 drivers/net/wireless/ath/ath11k/ahb.c  |   4 +-
 drivers/net/wireless/ath/ath11k/core.c | 115 +++++++------------------
 drivers/net/wireless/ath/ath11k/core.h |   4 -
 drivers/net/wireless/ath/ath11k/hif.h  |  12 +--
 drivers/net/wireless/ath/ath11k/mhi.c  |  12 +--
 drivers/net/wireless/ath/ath11k/mhi.h  |   3 +-
 drivers/net/wireless/ath/ath11k/pci.c  |  44 ++--------
 drivers/net/wireless/ath/ath11k/qmi.c  |   2 +-
 8 files changed, 48 insertions(+), 148 deletions(-)


base-commit: 8fb3b2b8d6d489416a7ff8a28cd4083340ad9e55
-- 
2.25.1


