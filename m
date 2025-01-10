Return-Path: <linux-wireless+bounces-17294-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB4FA0888A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 07:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5DF0168841
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 06:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F3C1CEAB2;
	Fri, 10 Jan 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kwvyh407"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F91E507
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736491751; cv=none; b=eMI1sSMu22X59UfR/TclPHqcEG990ueMhC+bGxQ/9vRYqPhP4wWDwVrkDIHWWor6cZ4SbgEhC0xslJAPfWdSCfQPM13kO5nfVY1fgiMXZnFjmawU6/V7M9FYi7hC3Q3UbrrzGyx545EpIUSyeIaNbm4HWNdeBjUuTFRbt+yUkCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736491751; c=relaxed/simple;
	bh=MPW9tK04gHhTyG0+OHbTNbLYXb6tf8dq7bp/+gL66zk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t9ZmZRT62PxrC4qdYbDi7pYaOkIYdr6BppuKRSUjHqd/DFn+13fcaxqNnsYUpYn5Hjynhlwmgp9pUdeT8Un65sr2kVjZOK4HTAjhXwtujZVLS+tMBqIw/FHVfCVcpATJFRiQeKs/HvPBfpHhYRDHfWqf2LwTUD1B72swXuDpSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kwvyh407; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A0sHTZ007717;
	Fri, 10 Jan 2025 06:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Tje3BAdhEsPwkepiybejK/
	YGyqmRX1iJsxTyCyvlWZM=; b=kwvyh407GY20QEjOo5WKl0sVS28f8cnnkkQgbK
	EV5Zh0RwKEqAzDwII3vE2+d7tDGrl06hgcXwRlC2FQm1Q6UizgWq+RwuGaKx0568
	LkZED4WK4z1oMMvSvPCxZxho/TJl0kb+5XMmts083njD4H+bIEPvlua/RInMckgD
	SRFMBJ0+3BKXIe10ag8eOyIEBI+G0HTww0c3H8k5pkQ7LyniRuGlKX9kWr5TDI+o
	+whytzTyuyL8bAsAcrjWnFIhweaiIa7YaEM9gZoPSs7xJcL8elip/bQyN/kIgkOu
	rkJvax4HgMMW1Z1nXaqLlveodoccNsmVfE1SEzOfNa5Sv7GQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442sd90pbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:49:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A6n5cU017168
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jan 2025 06:49:05 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 22:49:03 -0800
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v9 0/3] wifi: ath12k: report station mode stats
Date: Fri, 10 Jan 2025 14:48:45 +0800
Message-ID: <20250110064848.790733-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: caMGsrBW9PwpSjAD1zy2dZg_afwf2sgY
X-Proofpoint-ORIG-GUID: caMGsrBW9PwpSjAD1zy2dZg_afwf2sgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=953 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100055

Currently, the transmit rate, the receive rate and signal strength of "iw
dev xxx station dump" always show an invalid value.

This is because ath12k has no logic to handle this relevant information.

To solve this issue, ath12k parses the information passed by the firmware
and passes it to mac80211.

After that, "iw dev xxx station dump" show the correct value.
Such as:

Station 00:03:7f:12:03:03 (on wlo1)
        inactive time:  600 ms
        rx bytes:       4642228
        rx packets:     23796
        tx bytes:       933967
        tx packets:     8761
        tx retries:     66
        tx failed:      0
        beacon loss:    0
        beacon rx:      8925
        rx drop misc:   191
        signal:         -20 dBm
        beacon signal avg:      -18 dBm
        tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
        tx duration:    0 us
        rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
        rx duration:    0 us

v9:
1.rebase to dbe50a7420e2

v8:
1.rebase to 09fa3b6974a1

v7:
1.use switch statement
2.use guard(mutex)(&ah->hw_mutex)
3.use info0 = le32_to_cpu(desc->rate_stats.info0) and then use u32_get_bits() everywhere
4.replace time with time_left

v6:
1.rebase against wifi: ath12k: prepare sta data structure for MLO handling

v5:
1.use ieee80211_find_sta_by_ifaddr() to avoid using base_lock

v4:
1.rebase ath-pending-202404181533
2.change ATH12K_EHT_MCS_MAX from 13 to 15

v3:
1.change wmi_vdev_stats_event to wmi_vdev_stats_params

v2:
1.change copyright
2.change name according Naming conventions for structures

Lingbo Kong (3):
  wifi: ath12k: report station mode transmit rate
  wifi: ath12k: report station mode receive rate for IEEE 802.11be
  wifi: ath12k: report station mode signal strength

 drivers/net/wireless/ath/ath12k/core.h    |   5 +
 drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 +++-
 drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 139 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h  |   3 +
 drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 138 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h     |   3 +
 drivers/net/wireless/ath/ath12k/rx_desc.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c     | 132 ++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++++
 11 files changed, 493 insertions(+), 8 deletions(-)


base-commit: dbe50a7420e22954c747e79e72df2750d795ea77
-- 
2.34.1


