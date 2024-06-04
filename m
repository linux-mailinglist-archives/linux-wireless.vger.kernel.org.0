Return-Path: <linux-wireless+bounces-8457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4828FAA47
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 07:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B95AB24DAE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 05:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C413D889;
	Tue,  4 Jun 2024 05:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NcnT5GCJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50C7199BC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 05:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717480468; cv=none; b=E+/hohMLfDfRyIeHJg/S1odM4HlNBI7UfizO7M0gY8ByLBi9oLCJ1rlHgSQbQjDGhioQDO4wpXQFTEDXr9xyqFSheeUKGKrrGbuN1Q3SUD4umkYiZjrCkrqTLO7DjhfLpGSs/8B9zopQ/Ixpgyrl2REsjV3Z71pbBdAcNcvTDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717480468; c=relaxed/simple;
	bh=RMu4KQsppQgeRSyGydwzo/uHrhQ+82i+S182I+d2Nxw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=agg8nicoUZMYqM/ccvBmMRVDg9JTNEgizMWy3amLY0uxRl2XsELbv0j9j9aQLBHoLPMiRYSKJteSYrExoSBox9PPxkZ2HJCnQeh9uZ70bkHe/mTsVyCQCMZWKZWDRhwdgLSsEE0+aABUMiTX502YCnGFMlgOhO6RdsGFhMgeGRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NcnT5GCJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4544iqrQ000456;
	Tue, 4 Jun 2024 05:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AuN+RVJTm/9dbwUj7OPqpY
	oN3bK4eDiZUC8DKGAZEpw=; b=NcnT5GCJGCZ8YVrZFd9dFx5BlIZmcoleV9eWdf
	e7jzBSA8Nrg5kwfVdtBQoX4ujzC7OYeqk1GQUp6WhgeDaVK26N17gFtLri525FI5
	4o6WoqDfTiDi3Sei3V15ixAhzybHc4cVoWIL/3RdwG96AdZX3aRH5Pc5lS0qtts8
	4g1BmAKTUYko8it5XTtRPrXughWwayN9bwGI/L/L4oXJD1WY6LrhApHLlhddCf4j
	4pSKpeP2yQfUwUvahLqJ2PruESkFobW67u2wl5Kq2maxNU4siDSzuZdi0odcXBMl
	9TgETKwZYNF99IoloSgUxCKFC6mIp461PVVAjbhgiOtoKnZg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yfw59nmvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 05:54:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4545sJCm025980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Jun 2024 05:54:19 GMT
Received: from bqiang-SFF.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Jun 2024 22:54:17 -0700
From: Baochen Qiang <quic_bqiang@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <quic_bqiang@quicinc.com>
Subject: [PATCH v4 0/8] wifi: ath12k: add support for WoW
Date: Tue, 4 Jun 2024 13:53:59 +0800
Message-ID: <20240604055407.12506-1-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: 2Nv6pq6scQvE71ltxpySWvdv2hz005X5
X-Proofpoint-ORIG-GUID: 2Nv6pq6scQvE71ltxpySWvdv2hz005X5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_02,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=731 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406040046

Add support for WoW (Wakeup on Wireless) funtionalities, this including
magic-pattern, net-detect, disconnect and patterns, HW data filter, ARP
and NS offload, GTK rekey offload.

Also enable keepalive before suspend to avoid unexpected kick out by AP.

v4:
 - wifi: ath12k: add ATH12K_DBG_WOW log level
	1. update copyright
 - wifi: ath12k: support ARP and NS offload
	1. don't cache idev in _ipv6_changed() callback, but instead back
	   reference it in ath12k_wow_prepare_ns_offload. Also remove
	   _ipv6_changed() since not needed any more.

v3:
 - wifi: ath12k: add ATH12K_DBG_WOW log level
        1. new addition.
 - wifi: ath12k: support ARP and NS offload
        1. move ipv6 infomation parse to ath12k_wow_arp_ns_offload() to
           avoid memory leak issue.
        2. move ARP/NS related definition from core.h to wmi.h
        3. rename ath12k_arp_ns_offlaod to wmi_arp_ns_offload_arg
        4. rename some macros
 - wifi: ath12k: support GTK rekey offload
        1. add rcu_read_lock/unlock in ath12k_wmi_gtk_offload_status_event()


v2:
 - [2/7] wifi: ath12k: add basic WoW functionalities
        1. In ath12k_wow_convert_8023_to_80211(), change to use 'size_t'
           instead of 'int' to make GCC happy
 - [5/7] wifi: ath12k: support ARP and NS offload
        1. In ath12k_mac_arvif_get_arp_ns_offload(), change to use
           GFP_ATOMIC to fix kernel crash due to sleep in invalid context
 - rebased on ToT

Baochen Qiang (8):
  wifi: ath12k: add ATH12K_DBG_WOW log level
  wifi: ath12k: implement WoW enable and wakeup commands
  wifi: ath12k: add basic WoW functionalities
  wifi: ath12k: add WoW net-detect functionality
  wifi: ath12k: implement hardware data filter
  wifi: ath12k: support ARP and NS offload
  wifi: ath12k: support GTK rekey offload
  wifi: ath12k: handle keepalive during WoWLAN suspend and resume

 drivers/net/wireless/ath/ath12k/Makefile |    1 +
 drivers/net/wireless/ath/ath12k/core.c   |   48 +-
 drivers/net/wireless/ath/ath12k/core.h   |   19 +
 drivers/net/wireless/ath/ath12k/debug.h  |    3 +-
 drivers/net/wireless/ath/ath12k/htc.c    |    6 +
 drivers/net/wireless/ath/ath12k/mac.c    |   96 ++
 drivers/net/wireless/ath/ath12k/mac.h    |    4 +
 drivers/net/wireless/ath/ath12k/wmi.c    |  720 +++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h    |  578 ++++++++++++
 drivers/net/wireless/ath/ath12k/wow.c    | 1018 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wow.h    |   62 ++
 11 files changed, 2546 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wow.h


base-commit: a116bf2be795eb1db75fa6a48aa85c397be001a6
-- 
2.25.1


