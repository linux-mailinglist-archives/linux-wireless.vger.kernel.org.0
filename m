Return-Path: <linux-wireless+bounces-16561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA219F713D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 01:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CF3616A2EF
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79D023A6;
	Thu, 19 Dec 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P7eFr3mb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA5B380
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734567034; cv=none; b=q3FKKzNOzFwVnjF05LoFvGRjY/kxPZBUblrFQsAEHctb4c69jAFudV1gUD09Fqk6hvXEpfb3wCW96aNyLJMKToKv3p4Qnmn4W3kWnx33QZPJ2F1OtXiOo6PN0nJmORef3OMwOFNYfDAJTQjtkHcO5hOQeyXoaIT58g68PMzqhqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734567034; c=relaxed/simple;
	bh=/84B4ORWYOX9kDnWMqKZDJUF4dF0IDJxVlQX/jzXtIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXxb++YAXD/r3+htWiEF6giTsveOibJPO0iKuLy/7SRYOiiwo0hyD2ckvpKT6JOpl3T7mIHkoFa4dP3LIShMQpWIyzuIOvuhmu1neWKbkEhZf5/nLH8kHBrsCUxkfwUxeiyCWk9foRCVfobRu8KBPTzoiz9m01ZrKMlY4wjyDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P7eFr3mb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIMrkVu012017;
	Thu, 19 Dec 2024 00:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=94C1y99zJDWALNTsLJ8XK8
	/y9AIsrj3wUbnPi4Rb/iE=; b=P7eFr3mbZk+BHc/ht6K6HCEyqpG41B+5jkxfay
	27p9Sive2mFGUVXJyDzmjgeUQvgtaPexn1vja9XnZ7cnmj+CKwZCJM2LCQ+rDFDt
	lAE3fcB5rcyXMrHugIdFxyhHk6H4wABuWdwqGioiEEq1Au31SgrK2/4wYOCgNMt5
	4YpbG9pBCIgj5tAaY78ck2mDgNp/pBKlm5mKxGzMM823T4u6q5blZyx0P3pnCgqe
	3FQY22vUvhQDwxzB5rzluaVt3jxhc47nx0bLzbBxwMMswu+ri87JigEWqV5MXUyL
	9X3zrj3w+KkPnfFp8T+knRY/ZXhNyZxMrRUszhJyCw1Vf5Bw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43m7ka046w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJ0AQGq029526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 00:10:26 GMT
Received: from hu-periyasa-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 18 Dec 2024 16:10:25 -0800
From: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: Refactor monitor Rx handler
Date: Thu, 19 Dec 2024 05:40:03 +0530
Message-ID: <20241219001006.1036495-1-quic_periyasa@quicinc.com>
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
X-Proofpoint-GUID: 1m3KV6wO-DHEOVPSOH-DdbkQUFQ3wUHq
X-Proofpoint-ORIG-GUID: 1m3KV6wO-DHEOVPSOH-DdbkQUFQ3wUHq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=468 bulkscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412180187

Currently, monitor support is not added. However, in the future, the
monitor will be enabled. Therefore, refactor the monitor handler, which
help to add monitor support in the future.

Depends-on:
  [PATCH] wifi: ath12k: Add support for parsing 64-bit TLVs
  https://lore.kernel.org/all/20241204071238.948885-1-quic_ppranees@quicinc.com/

  [PATCH 0/8] wifi: ath12k: Refactor the monitor status Rx path
  https://lore.kernel.org/all/20241217084511.2981515-1-quic_periyasa@quicinc.com/ 

Karthikeyan Periyasamy (3):
  wifi: ath12k: Refactor the monitor Rx parser handler argument
  wifi: ath12k: Refactor the monitor Tx/RX handler procedure arguments
  wifi: ath12k: Refactor Rx status TLV parsing procedure argument

 drivers/net/wireless/ath/ath12k/dp_mon.c | 60 ++++++++++++------------
 drivers/net/wireless/ath/ath12k/dp_mon.h |  7 ++-
 2 files changed, 33 insertions(+), 34 deletions(-)


base-commit: 9a448415ed0c46edeb9170091a03b620986ca0b2
prerequisite-patch-id: 17dd9d2f723e951761f037999a1a7baed16e0d04
prerequisite-patch-id: b2e45c89692e23290870fcdec73106c9a910c054
prerequisite-patch-id: 7f6954e09b67481e7b5ea44ec495d7bf95696502
prerequisite-patch-id: 42680e4dd84e5bf3cef644d08f1a17326915e238
prerequisite-patch-id: 6c936b626c89ef9aefc898004826ca755367c93d
prerequisite-patch-id: 02f5565f0ed6cec4b43e5248395845f415729321
prerequisite-patch-id: 14dcc6fdc6722661a74bd1c9c7e459b4937c83e8
prerequisite-patch-id: 4cce8563f290b716a4d3b18ff15b0fbf7c11a64a
prerequisite-patch-id: 6755d0467c39a99b37e3a1f574f0ef57d6cf6399
-- 
2.34.1


