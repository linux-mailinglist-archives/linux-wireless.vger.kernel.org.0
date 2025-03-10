Return-Path: <linux-wireless+bounces-20097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82650A589D8
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 02:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C093A9332
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Mar 2025 01:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DB86352;
	Mon, 10 Mar 2025 01:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GiMbkh/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DF4224F6;
	Mon, 10 Mar 2025 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741568565; cv=none; b=dXhl606qce+ht6Q7pifpYYXiUdzRMilh8rVyX7OnkOyR2SbE65fC34sukkbij150BPZ4Ki26wtCT3ZdShmCvAVJW7O2dXQRYFRyZdYDx28TACnBgAngEDgoDlpDml+29bJrVbXU9e/w90S3gQs9xaIl8XLgqRG1hxFWbcYwhm0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741568565; c=relaxed/simple;
	bh=Mmfk+M99cY4x4D/+gbAQustRoe30UZxTFwpI7PVNVDA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M/P7clasXvXN6ECOTuIAL+jkRlKlX9R07RNFnJV1DoiKmpmIJPcm1F7k5Gq7w5deBrYvd3oGoeH2NMqMA0Gjbb0uJe6pFnngFBMezx0weNRsIc6Mg40Wgrv0OdP80CPiVWau5ZqxiUbbRnqwmo1oOr1s90F/Wzmp0Yl+prwx4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GiMbkh/h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529NxEvB021827;
	Mon, 10 Mar 2025 01:02:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DbbE3UhXSNFYrqtlH9Z7kM
	lB5JCQ83Sk0hWGHzSj3P8=; b=GiMbkh/hK6lZRmHqNJjob/QQWFK7BZxNNNSdRh
	ekf7l4TKWOSNwmc888UGpaHGEtD1LJ1o2wh4iiIo70RMdYtICU79z10P1wVuaQFv
	40zeOfYD9jid1+CaaXpZH4kyUryP+6PKuh8OFM4wR8+tH0Z2SY5Dau9+8P+SjLHA
	hziXeioGZWniEQoiZt2OiKSVcN7eZ77o6UFGkv0FBoG24RcIoMrw4BKhgZme58By
	E/3aLozpnmggKV56HKZtTmGwNonXXnQgTmbidzLWJ/pTEfBGJsleY31Pz6CHkyGj
	XE8X98wuHOg4NmKTGcHMp0Hb8RkTJPCtTZjYhx0EKX1HuRbA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458eypb1te-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:02:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52A12TPs010292
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 01:02:29 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 9 Mar 2025 18:02:27 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <quic_jjohnson@quicinc.com>
CC: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <johan+linaro@kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v2 ath-next 0/2] wifi: ath11k: fix HTC rx insufficient length
Date: Mon, 10 Mar 2025 09:02:15 +0800
Message-ID: <20250310010217.3845141-1-quic_miaoqing@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=A9yWP7WG c=1 sm=1 tr=0 ts=67ce3a2e cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=G9Sqsl_jvRD_TnvheR8A:9
X-Proofpoint-ORIG-GUID: Ni9iBJdgKDcDsS-qdvZGfu40MOpvFEW3
X-Proofpoint-GUID: Ni9iBJdgKDcDsS-qdvZGfu40MOpvFEW3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_09,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=674
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100006

This series of patches is to address the issue reported in
https://bugzilla.kernel.org/show_bug.cgi?id=218623.

ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1488, expected 1492
ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484

---
v2: add Reported-by tag.
---
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


