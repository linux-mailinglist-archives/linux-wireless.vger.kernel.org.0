Return-Path: <linux-wireless+bounces-6139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16038A0639
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 04:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF96287FCB
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 02:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6020913B2AC;
	Thu, 11 Apr 2024 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o7da8xhs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197E5F870
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 02:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712804035; cv=none; b=nB9ql0LKLRQZADxw056s48iv6k0u8lKe4h3hv9ICAhSWxeuJLmnOrtYDui3F0V4J20xeva1/ExkX6szbU9To+skLtTWg35XWXuKMBaZjCe+mcgDJq0KSuW7t9Yrz1RGJn7LgnOVlgmINrSxG8CodBni6TdpzmvpAdkMoMtX6lRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712804035; c=relaxed/simple;
	bh=/wMbHZxJTwMm3wC+aBRdolW17/mH0B7fv/5ZjGgeaFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YFq2/JIpS1tHl5bt3Z5DbljZ88g68wQ+uQIkrv+EuiJVgxzUVPrcKjuzyyNPyonw2O1Nwy2Opvif4N1Z0l/HB79DvySY2WNB5AKR8iliOk9VSsESevtrJgetrTs2cp/0YL0zLR7ChOJncOOD0xIkqntt2M+0oJMEte1oQ8KTQ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o7da8xhs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B2JXLJ020499;
	Thu, 11 Apr 2024 02:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=QZB8l1GVaA+ypojqlJVN
	vNR8qffQAmPNN+Fy48rPUeE=; b=o7da8xhsNFewdD67U9KIh153/fin381yiJ4t
	HN2OHwBEhiXVpqs87Py4cWT6sHl14WjbbfkS4FLCvntrwqlc3KhBXZDOuh3g+Z+s
	dr7PvB6Cc0AGssSbHnYBBbXqHpLTtVleA3wtOMkSJNhUaPPXNFzQKxT0eswcD2sE
	8mMIoaO1i73We/FnQdOpovZe0T5QMqdTJWnQ3ttzXiRHx2HX07jrrVvpqWy3l+/i
	JiytJX7gCLFYEkBOxtYy9nLta9zw+uZoHZ6B48ZJ6VoAXnwREL+pz387koFblXnk
	WuAtUiMPRjfhEM+IpcgPndmTqJ/v2IBLQSPNFjPQfqXRvocgbQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xdnqtmjjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 02:53:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43B2rlLa021401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 02:53:47 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 10 Apr 2024 19:53:46 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH 0/3] wifi: ath12k: report station mode stats
Date: Thu, 11 Apr 2024 10:53:19 +0800
Message-ID: <20240411025322.33888-1-quic_lingbok@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M8khZOVWhZoG_aJg0uViFjnJAXSxHQMc
X-Proofpoint-GUID: M8khZOVWhZoG_aJg0uViFjnJAXSxHQMc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=869
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110019

Currently, the transmit rate, the receive rate and signal strength of
“iw dev xxx station dump” always show an invalid value.

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

Lingbo Kong (3):
  wifi: ath12k: report station mode transmit rate
  wifi: ath12k: report station mode receive rate for IEEE 802.11be
  wifi: ath12k: report station mode signal strength

 drivers/net/wireless/ath/ath12k/core.h    |   4 +
 drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 147 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_tx.h  |   9 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 180 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h     |   3 +
 drivers/net/wireless/ath/ath12k/rx_desc.h |   2 +
 drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++
 10 files changed, 537 insertions(+), 9 deletions(-)


base-commit: dc410c4accd2fe64479a1f4ebc47ec9cd3928f4a
-- 
2.34.1


