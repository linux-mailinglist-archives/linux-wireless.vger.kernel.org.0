Return-Path: <linux-wireless+bounces-16735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30469FB2BE
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 17:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A04166CE2
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EFB1B395E;
	Mon, 23 Dec 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qjlv+YvY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0441B392B;
	Mon, 23 Dec 2024 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970918; cv=none; b=TkBv5NgEEvuVxNZNuqZ/imtYLWjGI8j9gyCEojtMFY8nZnTJesMllzfBf/1dddhGsQ+debi6yu9OYCFCrxcJy9VJjjry9gpsbpMVbaYi/OG7lnkbaLuXwo5tDPc/zthQppq/GendEUM7yoxOdVBhdPS/MqYuAPhNBeovZ7mZ+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970918; c=relaxed/simple;
	bh=L5r6e1t7r4UgrDgrkfIpWhONtNo1zKUlzjf+9Rso+7A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gN89Eh8f1Mw5w1lSFOWKdTifaxyB2vaP+fNT10Fqknxkvn4Octq5ZQqxnR2AJ5jNXMd+eKiF24FoKx6GfaWtntdV6t512pbHplMYByiZpsNelO3nEwIaH61RCHcoHA5zgLagdoeEkg3sVT0oIZmOHhPFZ3viKbOA05X1LM4+Gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qjlv+YvY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNCudEw002191;
	Mon, 23 Dec 2024 16:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/XSNYODY+Vqtrgdh3Hv94w
	hQ4qyzy25uWL/29oGKgoU=; b=Qjlv+YvYoP+EWeivMXVSSNTjPjEFzpXViS586o
	rv/krUF5xUoelBjqYPeM+Num7TbNFQmnFsO0cs98hz3dNHXvOC/gwVMTnGfDTsf4
	jfM9g3pXZE6YVykK7IWlN2bVHYuqBR7x+lsAzLzhgizNSAAhay1tcLuoEHiRqZa9
	vhRm2j7V5ipYNxN/QIRfQk1G/3yHKYqF02rF2FV04AYB71xnc6KB6YmAaqffcXb2
	DzhRfwd8WT8BkasOlmomlEbAVcXH303oN2rjav76d0+1zjjbsqAgQ8KPR9ST5h00
	nAfIuV1ZkfnHpiw2EPLoZ2Kvk8Kuzm6/kOeltxGINHLQ3T6w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43q8ah8tqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:21:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BNGLmVN011372
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Dec 2024 16:21:48 GMT
Received: from hu-adisi-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 08:21:46 -0800
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH 0/4] wifi: ath12k: add MLO CSA support
Date: Mon, 23 Dec 2024 21:51:35 +0530
Message-ID: <20241223-ath12k_mlo_csa-v1-0-78b6d7515568@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABCOaWcC/x3M0QqDMAxA0V+RPFswcWWwXxGRqHEN26w0Mjak/
 77Ox/Nw7wEmScXgVh2Q5K2mcS3AuoIp8HoXp3MxUEMXJLw63gPSY3g94zAZu9aPs0fixrNAibY
 ki37OYdcXB7U9pu//n3P+Ac4aeSRvAAAA
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
X-Proofpoint-GUID: 2U75hCg3LIE3fkwJHpJL4ulhp0djN0eh
X-Proofpoint-ORIG-GUID: 2U75hCg3LIE3fkwJHpJL4ulhp0djN0eh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 mlxlogscore=738
 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412230146

Patch 1 and 2 are pre-req fixes (applies to non-MLO as well)

Patch 3 basically uses arvif->link_id to enable MLO for CSA while adding
support to update counters throughout the CSA time.

Patch 4 fixes a potential problem seen when medium is busy. Again this
applies to both MLO and non-MLO. But this is exposed only when Patch 3 is
there.

---
Aditya Kumar Singh (4):
      wifi: ath12k: update beacon template function to use arvif structure
      wifi: ath12k: fix handling of CSA offsets in beacon template command
      wifi: ath12k: update the latest CSA counter
      wifi: ath12k: prevent CSA counter to reach 0 and hit WARN_ON_ONCE

 drivers/net/wireless/ath/ath12k/core.h |  2 ++
 drivers/net/wireless/ath/ath12k/mac.c  |  7 ++--
 drivers/net/wireless/ath/ath12k/mac.h  |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c  | 61 +++++++++++++++++++++++++++-------
 drivers/net/wireless/ath/ath12k/wmi.h  |  2 +-
 5 files changed, 56 insertions(+), 17 deletions(-)
---
base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
change-id: 20241217-ath12k_mlo_csa-35bd512a05ae


