Return-Path: <linux-wireless+bounces-19977-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E9A55F35
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 05:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DB81894D84
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Mar 2025 04:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC89718DB1F;
	Fri,  7 Mar 2025 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZHAlsoVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2385DF49;
	Fri,  7 Mar 2025 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741320561; cv=none; b=KCV6npI/rp1MTJiBz3ISv2relXyfc2VWv7Hd7R8CAA1W3pZW4yU0XJHCCtjsG7BQJq7cdh7Y2fm1qKO5er58OmKXRa5kV6Y+YIK1Lq1g6IypVgR5HiNagwmPs9K8WFAKjuY4PAopu0sffOQP6CmgLPN7JMfHZmcNY/VEFhOoK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741320561; c=relaxed/simple;
	bh=vYNXxjTEA5P8TI6zuQI7bgTFrFFYpBZ5P49z2LAHFLI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGx6UbjmUnISJhGQJOu10dAPlZSGi2OxtFu0P4kLTxRmhLFxOj8G6FFWr3pEIYZ5b2JHiyXoQFpWfWFWy1+uxbAyEK3Cw4HwCtnRijwE4vMI7oRUYqOptJi+HzCe8lYLWaMyZlv6MmEf61inmF6CiRg070zm/1i5xm5AsIBEqAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZHAlsoVg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526LFcm5019600;
	Fri, 7 Mar 2025 04:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3myaz05gJUsn4Trep8ooUM
	0g2cG7uUv7yvGPvMB7amE=; b=ZHAlsoVggCn7tpJS85kKQm4U8GwJhD4V17zsK6
	ArgUy/cKolbYv1DpgTKXpFCI/VJTW/X60VcjpcYnHsKz4lnTZ6BAKnWqv+qSFZR5
	edngswx1nDHRxzURyBly5ZIUg0MGgw1Uu8C5QBl7eG4qb+62LQ4AEpMibN1dVteO
	27AjCet4lqiPrFFRkcg3DxaahklTaPHiQ3RLUJ7tgIYrQzvYfBkgKwI9H40ZQ7pu
	K/8xpPwSiapYCqk1hkEqb0nVmvT+OkxdGVM3pFDwyqbKslkAntVvpO1EC3csk3/c
	9uK0K8A3+mNxDsZl4Gp01nR7+o6OG+QFhvDraLdlTJyJv3sQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 457kfbgtrr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 04:09:15 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52749E7l008764
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Mar 2025 04:09:14 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 6 Mar 2025 20:09:12 -0800
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Miaoqing Pan <quic_miaoqing@quicinc.com>
Subject: [PATCH ath-next 0/2] wifi: ath11k: fix HTC rx insufficient length
Date: Fri, 7 Mar 2025 12:08:46 +0800
Message-ID: <20250307040848.3822788-1-quic_miaoqing@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mVe9xauhExAEdFDTJ0TbcDPp49n6uBCj
X-Authority-Analysis: v=2.4 cv=D/e9KuRj c=1 sm=1 tr=0 ts=67ca716b cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=G9Sqsl_jvRD_TnvheR8A:9
X-Proofpoint-GUID: mVe9xauhExAEdFDTJ0TbcDPp49n6uBCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=649 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503070025

This series of patches is to address the issue reported in
https://bugzilla.kernel.org/show_bug.cgi?id=218623.

ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484

Miaoqing Pan (2):
  wifi: ath11k: add function to get next srng desc
  wifi: ath11k: fix HTC rx insufficient length

 drivers/net/wireless/ath/ath11k/ce.c   | 32 ++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hal.c  | 24 +++++++++++--------
 drivers/net/wireless/ath/ath11k/hal.h  |  3 ++-
 4 files changed, 42 insertions(+), 18 deletions(-)


base-commit: 3148fc3cf193dbbd2e14eee59468a510a38bf604
-- 
2.25.1


