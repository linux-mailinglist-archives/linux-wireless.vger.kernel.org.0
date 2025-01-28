Return-Path: <linux-wireless+bounces-18066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF67EA20947
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 12:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597F1169063
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jan 2025 11:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFC19B3EE;
	Tue, 28 Jan 2025 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D5kjoFnt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30373192B96
	for <linux-wireless@vger.kernel.org>; Tue, 28 Jan 2025 11:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062689; cv=none; b=r+LZAsvxNysEdj5iCCIcttv9nxavzOZNL4Hw3Eij0ii+/kUq2v1sN+GE29fwRT3PJKwGyiJgUHaVanyQpvK9o6WU/auvbJ2MJ8hbHmqFeAWEleyOb8MmqOt5Av1p+YFqiWCoG4ox2q9lNHdk8mYMSZbY26TmV77USkw4aiikUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062689; c=relaxed/simple;
	bh=cvFrKpLTtJfXvn9Jag8ad2QYjBfzNCW/xfjMTIe7Jd8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VPLv6YIojCbCJC1Ya6alpkIcmrqdYatC8f7Y8uCkQNoaBNlqP3z7IgC0gTBRepDkUyY5RaNag5IsLQpRUwGnqjBg6D0ljSHsuHjSyvIcEX5Hg3bTnQfM737aSkZhJk5I6sefZ/iXtNvu/39hlPxd7/sfmiYpQu7ee77dga9M5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D5kjoFnt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SAScVq032383;
	Tue, 28 Jan 2025 11:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SLltrCTlBpVzJyZJBkGjGb
	CN91/sNiJQ/8Fa6WnqWUs=; b=D5kjoFntCPL7WodIEM9QECMFiYRnRNkwFvllC5
	HA5/KNaMjCCRW2WkfiOdhcKT392m/psYRPljyRwtLu41csc4QdiU22V/yepzYdE4
	J7SfcasyxcYxfCFyTgwX4U3sYxUJUSKHDFLhQs9vu8w+9MICcaqQcvHafZWt8m0/
	z8gXT5qD7yNO80OgLQ4QLqAgItH3hLpgy1ZtIacWieGjdnEyQjG/+a2vuvqAzitq
	YmHmp1yrc7A0kP67+sctIVGVVODjqpKogC5kXYk3/gCZxQpEn0UVBpkCC+5qPBC4
	r611jIMZ80WKBRa36lpAHwXZJfpf3y/6ronImSGLGkJWIvTA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ewh483dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 11:11:24 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50SBBOY1019363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 11:11:24 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 28 Jan 2025 03:11:22 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v5 0/2] wifi: ath12k: Support Transmit Power Control Stats
Date: Tue, 28 Jan 2025 16:40:57 +0530
Message-ID: <20250128111059.1690113-1-quic_rdevanat@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: plJKpJCND8Kh5FIlNF-Y1jMZECcwwGwa
X-Proofpoint-ORIG-GUID: plJKpJCND8Kh5FIlNF-Y1jMZECcwwGwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501280086

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

v5:
 - Fixed cosmetic comments about line breaks, function naming and
   paranthesis alignment.
v4:
 - Rebased on ToT. No change in code.
v3:
 - Fixed datatype conversion warnings in v2.
v2:
 - Fixed compilation issues in v1.


Sowmiya Sree Elavalagan (2):
  wifi: ath12k: Add Support to Parse TPC Event from Firmware
  wifi: ath12k: Add Support to Calculate and Display TPC  Values

 drivers/net/wireless/ath/ath12k/core.h    |   4 +
 drivers/net/wireless/ath/ath12k/debugfs.c | 714 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/debugfs.h |  83 +++
 drivers/net/wireless/ath/ath12k/reg.h     |   5 +-
 drivers/net/wireless/ath/ath12k/wmi.c     | 451 ++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     | 140 +++++
 6 files changed, 1396 insertions(+), 1 deletion(-)


base-commit: 5e40b6ac64339a78a5fbf1009581aa43eb46c352
-- 
2.25.1


