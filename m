Return-Path: <linux-wireless+bounces-17497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F069A1083D
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 14:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1AA167302
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1816C3F9D5;
	Tue, 14 Jan 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="XykbVmAw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C335972
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863059; cv=none; b=DwfeBts5L8nKGcwLPQzVhoSssNRTP5NoytKoJu+eps3s4ar73gbyR+eI6ZlDXk9/+Tpp7pOJVTiH3zgKUhQ1hGIcnZmDDkUwMEp2ekL0HIGl7JB7TGYMknTlcnYLBjLMrk9DnGpeTmrH/C8Y01NzLk0VdsKUO50G32KEOGTfDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863059; c=relaxed/simple;
	bh=pyyh1I3a9TqkHT3zVl11ATmy63lgOBkZwfv49ATQN60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y4vDvmjRZpN3oYvQ2JCKHfNUWWOCOWrVtRS0S5m5fhJaiwNOt2z2lINa0rlUeAmPeanulUvIx+f5r0tmUV5yO4lZ4EOw9WF9tZn4kbeEKuwLTt+fZMRBUWj94ETNE2HPU/Bf/sxLZnGRRBEVKeEO6GBZfIB2FG5V4by3H/EsWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=XykbVmAw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E6ckOM003620;
	Tue, 14 Jan 2025 13:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/Da0P3T8OcYngtrwuPK2DU
	Hqia+CmiTgyeS/jU3pteY=; b=XykbVmAwh24xggGhX8LR1vfKJQRvvBLEZCbi//
	E4kbyqrnLXWN48IMrMIW8vDYz+Mc6z3oVL8ZQhi7wGnvqHrgZbiFNYFTcV5cvx+V
	kbuSJte9lBoTIojW1fgZ0lcXVUo5KKjBOr0tKFi3WLKOb9XvmNBoDBElxWoQWE7s
	I78wuKT+tSusHmCThGs5tnOdc5xpv9zjICfkAzvLBbJfnVRjKZ5wdCJaqYpdkSce
	Jmc4TjdiW5+2Nv5a+tWyTpD7oFAjKM9ki7mN4uDUJ/KhyWcdjlVhlPiek3JOOhBG
	2dbHiBULKT2aZ8XVnV6Utas47SfxShm8++whN3QjM7kB+ELg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 445jubgw78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:57:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50EDvWW3028471
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 13:57:32 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 05:57:30 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v3 0/2] wifi: ath12k: Support Transmit Power Control Stats
Date: Tue, 14 Jan 2025 19:27:06 +0530
Message-ID: <20250114135708.966170-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y9CSwbzMo3NrJgoN9Y5hM5xPumqEVZHc
X-Proofpoint-GUID: y9CSwbzMo3NrJgoN9Y5hM5xPumqEVZHc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140112

Add support to print Transmit Power Control Stats. Add support for basic
infrastructure necessary for enabling TPC stats via debugfs. This patch
series brings support to request stats type from firmware and dump the
corresponding stats.

Schema for an ath12k device:
ath12k
-- pci-0000:06:00.0
    -- mac0
        -- tpc_stats
        -- tpc_stats_type

Sample TPC logs:
*************** TPC config **************
* powers are in 0.25 dBm steps
reg domain-22           chan freq-5955
power limit-126         max reg-domain Power-252
No.of tx chain-4        No.of rates-1164
**************** SU WITH TXBF ****************
                                TPC values for Active chains
Rate idx Preamble Rate code     1-Chain 2-Chain 3-Chain 4-Chain
4        OFDM    0x000          39      15      1       -9
5        OFDM    0x001          39      15      1       -9
.....
12       HT20    0x200          40      16      2       -8
13       HT20    0x201          40      16      2       -8
.....
44       HT40    0x200          88      88      88      88
45       HT40    0x201          88      88      88      88
.....
76       VHT20   0x300          40      16      2       -8
77       VHT20   0x301          40      16      2       -8
.....
172      VHT40   0x300          88      88      88      88
173      VHT40   0x301          88      88      88      88
.....

Note:
MCC firmware version -
WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3 does not print stats
because MCC firmware will not respond to the event passed from host,
resulting in timeout.

v3:
 - Fixed datatype conversion warnings in v2.
v2:
 - Fixed compilation issues in v1.

Sowmiya Sree Elavalagan (2):
  wifi: ath12k: Add Support to Parse TPC Event from Firmware
  wifi: ath12k: Add Support to Calculate and Display TPC Values

 drivers/net/wireless/ath/ath12k/core.h    |   5 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 716 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h |  85 +++
 drivers/net/wireless/ath/ath12k/wmi.c     | 458 ++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     | 139 +++++
 5 files changed, 1403 insertions(+)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.25.1


