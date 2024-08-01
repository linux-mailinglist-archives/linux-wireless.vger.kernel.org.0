Return-Path: <linux-wireless+bounces-10815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BA944A66
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 13:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20841F213E2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC0B189BA8;
	Thu,  1 Aug 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kHHGsKqi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D81C189B9C
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722511803; cv=none; b=KDb9oJfVvpb7gfBnY6MfySVzIih3HgqPzSLg4CiLPjpw8wy3O7sa7zSr6mhrWFca4gIefZNki+RLRYfVoLWuFJAszg7FrSmLNarb4xAPsW62II1FkOptP6ywvT6c1IEsSVxx5FK+ADoiWEViUGhahN3PoL3j0uYiaPFo61U8JkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722511803; c=relaxed/simple;
	bh=wG6RApbXPKyCVuPXRwh9GsawubykbdnrrWYFCYH8B+o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=byWPHxkERnLlpjJSQIXqtiJuHu1T7w2nA9zgJxENKdTUV485lvK4XJ/NQgxOBoDTgOegK0EOXUrz+oyjYpFJwlKIBlRxf1dUy1OmuY883bSi2g6TXfy4Hy9CEtuh4xC2f5qBuWstcyqdTFoDKKHIUKcUQFjNIC5s0BVmgI2jI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kHHGsKqi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47178ISV030656;
	Thu, 1 Aug 2024 11:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=L9KqPaLeZ/wyDaEx9hBzYw
	eYRZOmfngUM+JDRh+SkTc=; b=kHHGsKqi8AY0PuCn/iAH7LZINSjTzxDiz15X9F
	dXi7fdChffLx46dCquqrSJdOdpx4S1gCVU/DIaMO7U+fmfNBg7sYE05mzWGaj7Yu
	pfVONgHdZ5nXDlvVJ+ykOuFVBQIjo2jVuYJXTAyt+ZE79TDjj8uqkdJdfI0Jfps0
	hYvq/XWyf0FyYNcXqTHz0hA61QIoC4rvjIQ5CjCLrJCztEKujKt8NqiQVYlmCSRB
	efQCWQ6DTD49Za+fScIE2RxlpJyeESLqzCYpw0dzHqz8pjQfxRC/jptvp2nhKEU9
	FNf0hNba8j17Nf7+st8QFUSfCGC0dfgyYQyaFCMa5IYsXg3w==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms43eq91-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Aug 2024 11:29:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 471BTPTs029289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Aug 2024 11:29:25 GMT
Received: from lingbok-Birman-PHX.lan (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 1 Aug 2024 04:29:24 -0700
From: Lingbo Kong <quic_lingbok@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_lingbok@quicinc.com>
Subject: [PATCH v7 0/3] wifi: ath12k: report station mode stats
Date: Thu, 1 Aug 2024 19:28:50 +0800
Message-ID: <20240801112853.85508-1-quic_lingbok@quicinc.com>
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
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JYf3n1KbitBBTQSfiiCN8-XgvUl-LG5i
X-Proofpoint-ORIG-GUID: JYf3n1KbitBBTQSfiiCN8-XgvUl-LG5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_08,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=879 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408010073

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

Depends-on:[v6,0/3] wifi: ath12k: prepare vif and sta datastructure
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20240711165511.3100433-1-quic_ramess@quicinc.com/

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
 drivers/net/wireless/ath/ath12k/hal_rx.h  |   5 +-
 drivers/net/wireless/ath/ath12k/hal_tx.h  |   7 +-
 drivers/net/wireless/ath/ath12k/mac.c     | 136 ++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/mac.h     |   4 +-
 drivers/net/wireless/ath/ath12k/rx_desc.h |   3 +
 drivers/net/wireless/ath/ath12k/wmi.c     | 132 ++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++++
 11 files changed, 492 insertions(+), 10 deletions(-)


base-commit: db1ce56e6e1d395dd42a3cd6332a871d9be59c45
prerequisite-patch-id: f87638504028796f96a183930bf1799f55b9d268
prerequisite-patch-id: dc15d6df954760395ff72d9bcf14aace5adefbe7
prerequisite-patch-id: b43d0571ad6b42c80a16e65dc2c54657f3cd3dc5
-- 
2.34.1


