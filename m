Return-Path: <linux-wireless+bounces-16745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D7F9FBA25
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 08:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3AB1880800
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40D414EC4E;
	Tue, 24 Dec 2024 07:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="icbDz7kb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5266DEEBB
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 07:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735024986; cv=none; b=LYOw7wcgdUlj00pJ4dlOyD1nPW41+/URGTbCXjaRePrpUyexViwxBEz6IzKlSj4UhUKp8IgMzaIeQ2qkE/6H59DHd/XgUakaUstrEqNhRvIFDCRa0UHcPIpmRuhAxPrHlQqrzEd+v3DMXIiZOb0A6Z9x+SfAuGiZYWWNCEMn4P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735024986; c=relaxed/simple;
	bh=WjklbOhy3VMMLhJLLpYwUhA5FxFCOsyAbLSuwOq85sg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F0LLCLKmKYY2vW/ITaMZ0JlD38h+a7q3vnEU9sItkDbkD77pIi6dP3E5qrxKaFIUTzMXdRoL2l4LzM9P7SNvTxyQRk32VLF9F0uOmDltxEbiFHgGLvBClQ4yg9uxBKZg5vZZJzWDb29mfzjzEfgBOp5Jk7+7IZi3EMB6Kw6x9NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=icbDz7kb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNJsVDf029652;
	Tue, 24 Dec 2024 07:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SkmHEeiMJj7JtK9EFhybFy
	XlyY1M2UbsDkaBAJOmWPM=; b=icbDz7kbWIFMmR8NXilBwnC5dJ8cwAravtKeUe
	r14ytLVkF8/HePhykwvQCgAAjFBazv+gWQorQDpKHKC+BV8ZnOu5r0C4AGHBHaBf
	S20sx01GmslMlgFzwba5t2Nhf4wmW4HTs8ibZuyGRMUkrbtRHKF1twXIZXH7zXRQ
	KQzZ4lJItZqnMAOUp9LO1ma2fEVSTB6PGkp7trWZ+b69NUsZ+dT/oPpmm7YKIgH7
	mq2r+cBQuVrvS1YnhGrlE42FZgj6z/7R1zhS29V/eZYwPI9/cWwJcgqWUx1PZMvk
	vGCDj+Xg3egpdP+yl8KX9Xi0MbQfjitJGhRgScU7Xr4UL0/g==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43qee0hnq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 07:23:01 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BO7N01d010850
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Dec 2024 07:23:00 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 23 Dec 2024 23:22:58 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Support Transmit Power Control Stats
Date: Tue, 24 Dec 2024 12:52:34 +0530
Message-ID: <20241224072236.1357432-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6qBQZyf7tplC51q9ULo93VdcwR-5ThRz
X-Proofpoint-GUID: 6qBQZyf7tplC51q9ULo93VdcwR-5ThRz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412240060

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


base-commit: 09fa3b6974a1245ddd0751747609431494ba5b4f
-- 
2.25.1


