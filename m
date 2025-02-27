Return-Path: <linux-wireless+bounces-19515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B0A474EE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 05:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B85A1887FFC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 04:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A391E5210;
	Thu, 27 Feb 2025 04:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JDmxW4GY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771E3FB0E
	for <linux-wireless@vger.kernel.org>; Thu, 27 Feb 2025 04:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740632339; cv=none; b=KFE6mMD8FPn/QROiOcU+6axWKgYUnJe5YAZmH77MvL39uTxnDpDeWwQ1zyZtwj1IcGRkBHJC1sqoZMg6hfYKB6vpMEx4zfLP2h526xFF0KUP2l2HF/3FvGhnhIDy4yiK/baVNiOgJBvw4jAYs3eHv6GGw25QIFbz/2NX3QNoxgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740632339; c=relaxed/simple;
	bh=Oclf2id8kmorvSI3nkkQcEAAalnUm0oRSbqQRnabhOI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NnkHTmEmJ9KG5k/H43AqcY1BEQJEMAkkASGaKQRmesP/LIIJ3BpnmePHGmZXKllncFItLNXEVFxGksgJwBGfD7siMz2E6TMCb0pGkafckqqd2kDSu6MLS3vPEv+EYRiM+DOLuxH4sklnFHrGgcND1Q8FHF/7yuLADlSuHcXCmV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JDmxW4GY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGHUrN022657;
	Thu, 27 Feb 2025 04:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=2fBkDN6g3V/Vwbh9XAPI1K
	5QU/WxRT6Ay3lfITV7lxY=; b=JDmxW4GYYV9Dtwc19968T2oD4jHn/9b7yC66lg
	Ga4nxPFZL6SDrbbQiSW6Te12in4e/uOM8vn4VmEZkdLCAdklwrY5jGmeEMlpDyhp
	cFn2WeCNfc0Vb7yJvBN19+0uCwDlNBjqVjBFleJF9ZPaRsGPoc1uC/y/MwHedwnq
	wib5527pNN4MZ39QofFlcXOEuoE4zDQGOlQI78WI3GDixTtAyolgJCQa26+PNe2h
	849crfpC9lX2GIK4cbByTiLJd2Wz3C1+sVUUFBYFzIKZeKqjyAeNQgdz/Jo1wtaW
	f5aH5fuz3Bohs8p2b9zQBW40pqkqoZVuJ7bbyE22OBu6dwUg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4526bj1qhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 04:58:42 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51R4wgQC021818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 04:58:42 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Feb 2025 20:58:40 -0800
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, <johannes@sipsolutions.net>,
        "Sarika
 Sharma" <quic_sarishar@quicinc.com>
Subject: [PATCH v3 0/5] wifi: mac80211/ath12k: add support to fill link statistics of multi-link station
Date: Thu, 27 Feb 2025 10:28:19 +0530
Message-ID: <20250227045824.91480-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xkXMff5SdIs20yunphj68anehcJR4GY6
X-Proofpoint-GUID: xkXMff5SdIs20yunphj68anehcJR4GY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_02,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 mlxlogscore=678 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270035

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

Depends-On: [RFC,v3,00/12] wifi: cfg80211/mac80211: add support to
            handle per link statistics of multi-link station
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20250213171632.1646538-1-quic_sarishar@quicinc.com/

V3:
 - Fix kernel test robot build error

v2:
 - Convert RFC patch to actual PATCH with each patch bisectable.
 - Add new patch to update bw for ofdma packets.
 - Add new patch to fetch tx_retry and tx_failed packets.

Sarika Sharma (5):
  wifi: mac80211: correct RX stats packet increment for multi-link
  wifi: ath12k: add link support for multi-link in arsta
  wifi: ath12k: add EHT support for TX rate
  wifi: ath12k: correctly update bw for ofdma packets
  wifi: ath12k: fetch tx_retry and tx_failed from
    htt_ppdu_stats_user_cmpltn_common_tlv

 drivers/net/wireless/ath/ath12k/core.h   |  2 ++
 drivers/net/wireless/ath/ath12k/dp.h     |  2 ++
 drivers/net/wireless/ath/ath12k/dp_mon.c | 23 ++++++++----
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 45 ++++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/mac.c    |  5 +++
 drivers/net/wireless/ath/ath12k/peer.h   | 27 +++++++++++++-
 net/mac80211/rx.c                        | 15 ++++++--
 7 files changed, 102 insertions(+), 17 deletions(-)


base-commit: 704a2d7237043317ed1b0f8a08203e9ddde70097
-- 
2.34.1


