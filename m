Return-Path: <linux-wireless+bounces-16769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588859FBF3D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07951884DF7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C51D1B87FF;
	Tue, 24 Dec 2024 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Zjt9AckV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D41A1991DD
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050994; cv=none; b=T3FjhJowCZPiArgfQgttWIRmLOpNpl8PxkwOBj0TShYAvzVg6i7rA9aPRCemoTBz6BO5awfhB7YjZ129u8wYQ+BVC4PH4Pu5/8Lloudy2oYa0DKk/koRyf10oYS10zN31PvHzwa8pkwWI8xSZjOSU5Ji78xvcYu7WDga/XcZ2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050994; c=relaxed/simple;
	bh=Bb+FiQUqEqn0JbB0Bqrfc70K9NUlAsh6055ee040bm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fkqYJrPO1xWmWljFHf+KF4RExA947uIDyZqmIEcRgApdDcqOuPUZT0IBhqVwFLZpU3/9Bywmjk4HYI/2BfhQBK7WAlLeJ9dGUngalzsGA+O2HcZN0MpV8+/vMy04WupX6mwq6GmPP9eIlSmDBOyIwF8KdfqTV/83c3eax+PCZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Zjt9AckV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BOAIJ0C028368;
	Tue, 24 Dec 2024 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pZt4+FN6WJwRQLIdr0HirI
	DOXlHPflQ3XebmXHdBgUM=; b=Zjt9AckVArz84CEvakV8QNLq5gKtLwQRBdAU8v
	GwoZOOgpFaqdKmHmPijJbcsFCir1OWqVM+DCjwl7s0x7oso9oC57WtWDTqB1QTWy
	KCCRKbpOt1yo4LAuSIkJi0BMJ9DjEibk/Swi7FyGB0VCLZdr/bGs+rdILLzZsGJZ
	pU/xyGAtJhXTFiYzAHeLIuCX7QnZzal+jL9f9e6kDHKe4jlBVSp6Fibp0PiAzCjo
	dLLQFltXOWeBGs6XWuAJA4M3luK4jhe+fBj1hQshiPvsizk8X0Zo+WR7++yUn1cI
	O+sNTRxVOVGTAhY4z+rfvasUJJpqGIZ5VwZQmZmr427/59sA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qjqvkjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:36:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BOEaSKY015182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 14:36:28 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 24 Dec 2024 06:36:26 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH v3 0/3] wifi: ath12k: Refactor monitor Rx handler
Date: Tue, 24 Dec 2024 20:06:10 +0530
Message-ID: <20241224143613.164921-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-ORIG-GUID: cWyxDFCURiO_QaKdAPer3Mh1JmWKWmoq
X-Proofpoint-GUID: cWyxDFCURiO_QaKdAPer3Mh1JmWKWmoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=548 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412240126

Currently, monitor support is not added. However, in the future, the
monitor will be enabled. Therefore, refactor the monitor handler, which
help to add monitor support in the future.

v3:
 - Remove the Acked-by tag
v2:
 wifi: ath12k: Refactor Rx status TLV parsing procedure argument
  - Updated more details in the commit message

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor the monitor Rx parser handler argument
  wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
  wifi: ath12k: Refactor Rx status TLV parsing procedure argument

 drivers/net/wireless/ath/ath12k/dp_mon.c | 60 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |  7 ++-
 2 files changed, 33 insertions(+), 34 deletions(-)


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.34.1


