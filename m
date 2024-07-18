Return-Path: <linux-wireless+bounces-10353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04559934CE9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 14:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA8C1F23DF5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8E13B7A3;
	Thu, 18 Jul 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QLbF0Jug"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AC912C473
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304465; cv=none; b=arwsTdHG3D0Yzp16iE2IjvN/UDW8NOLxykgiSmLZxd2cPlixUOE3Slqznc4YyXBjRKE06Lo/YjZG9poyVaAUdVU2oiG6XMISzBSz3K/j7ATpa7ZU5JYh6nq1nzggfh9AWNwkbTUwetIFyHPEiGy9brKxD84XYp6Eol4EzSP6zP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304465; c=relaxed/simple;
	bh=8yWJ7TnJGEx6Z4FinhbhMVxJpb96T8TkpynnlbZxg60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PALRJTZhUru8PSfKp6cBFPwAvBsFbxCHMaE4RDLBZQqH/C8x8Mpd3xqZvhgHG0zN1hRTTVGemsfXf14wGHQB4oBiinX32FCDQaFsO9iLieKziblQvVIHJXOjwYAr7INyzJTwnIe6gb2gn6z62Cj4bPednNY9O8OdzH64QzxS4Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QLbF0Jug; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I99X7D021476;
	Thu, 18 Jul 2024 12:07:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pndvzF7nO5Elqztx3Sqvyv
	7X2PpO1NWK3xJVjqiSHAo=; b=QLbF0Jug6iFYNL1uAjDUqyCRCq8L2PE2WrtYTc
	v+2bZFQj/3hSaJ8KIG5irnPK7CEwq5TG5YYDm7ZQSv/USsrMOgur+xxCf0e9V1y9
	7wyGeSW6rFKrlUXERQRwmQs66YHi5ig+WlkYbLNAPK14zO6uHQtlg6LmwFBnRz4/
	T9bqo7pkQP3sOFzOmLRP6/rUqOCnTVVgm08YlKxl7ytVfnLwjsotHcxgBZZTbVYN
	EvYmwi6gICWQo9EOFK4q02oSI3S1YEmER0Lb7Q9GsyhfGKBb8+HaG1r7QR9zm9hB
	n2/9e1kJBTDKlAvEdL1RqJ1/D+DNeWS3Z7JjtR1eWIu/WdWA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpnd40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 12:07:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46IC7avl011939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 12:07:36 GMT
Received: from lingbok-Birman-PHX.qca.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Jul 2024 05:07:35 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v5 0/3] wifi: ath12k: report station mode stats
Date: Thu, 18 Jul 2024 20:07:22 +0800
Message-ID: <20240718120725.130265-1-quic_lingbok@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Kz-Wyan6oh2xj7FuTl5vvC8sSa9rKWth
X-Proofpoint-GUID: Kz-Wyan6oh2xj7FuTl5vvC8sSa9rKWth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_07,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=929
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180081

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
 drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 ++-
 drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
 drivers/net/wireless/ath/ath12k/dp_tx.c   | 117 +++++++++++++++++-
 drivers/net/wireless/ath/ath12k/hal_rx.h  |   3 +
 drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 141 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  49 +++++++-
 11 files changed, 472 insertions(+), 10 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
-- 
2.34.1


