Return-Path: <linux-wireless+bounces-21618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36D0A9126B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 06:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745041900CEC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 04:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408F91DE2C7;
	Thu, 17 Apr 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bHhtBp2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FDF1D514C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 04:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744865857; cv=none; b=rtoaWNt2N3IX6h27pyeGImITpMx+SIZER45231BStGRD40GtwTeWjrFW7Yj4i4aqbQ31PK2tlA2SOImpkjEzvHVw8eWB0M2WuhqYOEIRdKJNzFswng8BRaMd1s5GbeHq6Ffu9ZpfO9qD0gM5llsrUg3FDfIYlxEIhp6nxWF390g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744865857; c=relaxed/simple;
	bh=RZL1DjA7/XkFYyA10f8t0Tpkxbp1SmePfSGNa63hMI8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/FFPNwE2df0KDN0TLEFeUaoQtMr+0plyJiD74FxXtVNkPceAJiLzx1soCPuFT0W7we8nYORA374TmQ9553NucHZSN1/VcL/tFFJ5oeyr2c/fjVWqLiYdFtvU15G3lqdk6cisXMIcDQJiCTYmLa+P2bVIQu/1//tHxZ+RBnJbs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bHhtBp2E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GMnoeC020542;
	Thu, 17 Apr 2025 04:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZKty+1TmGMUHk8zlC3xV8y
	bQycCQGSbmC50dSeZACmc=; b=bHhtBp2ERfXfC8qdGeP3BzoiVtMpPVrQTzE0gm
	1qAGTS84cOKV6ptzCTLA/JtrzvxRqjVkjiy9gdHlh9bkQ2TUxOlcqRGTra++SVbc
	vdk4e7/p1YKAgjF9nT6p0qHENM30GBjSm7Kd4LdrBqp8W+LMCEIb9MNifJYalo4+
	mIIg3OsERu0dyQcESMQw3GCFDL2F068Lxhh9rfMN3ZiO5GrMTvg74Kc8MKZBKt2T
	1TSsf0xqyb2RnLwKp77eNJDaSkWXvYu8/QVp+AGbDTHH+mnaWnAeeJHgpHfiMcmn
	oRlDFbAps30tLTLMqnwZgOLaCAeFWRisPVVIg0+Fvhc7QPqQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wnpqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:30 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 53H4vTs9015100
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 04:57:29 GMT
Received: from hu-sarishar-blr.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 16 Apr 2025 21:57:28 -0700
From: Sarika Sharma <quic_sarishar@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Sarika Sharma
	<quic_sarishar@quicinc.com>
Subject: [PATCH ath-next v5 0/6] ath12k: add support to fill link statistics of multi-link station
Date: Thu, 17 Apr 2025 10:27:03 +0530
Message-ID: <20250417045709.770219-1-quic_sarishar@quicinc.com>
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
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=68008a3a cx=c_pps a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17 a=GEpy-HfZoHoA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=kYzkSp3CTHGy5h0v6O0A:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: jQfTyoHgXPcG8EWraZx1apoUkW-zIY6y
X-Proofpoint-GUID: jQfTyoHgXPcG8EWraZx1apoUkW-zIY6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_01,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=684 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170036

Currently, station statistics are filled at deflink for both non-ML and
multi-link(ML) station.

Hence, add support to fill station statistics for the corresponding
link of station.

Depends-On: [wireless-next,v6,00/11] wifi: cfg80211/mac80211: add support
            to handle per link statistics of multi-link station
Link: https://patchwork.kernel.org/project/linux-wireless/cover/20250415042030.1246187-1-quic_sarishar@quicinc.com/

V5:
 - Removed mac80211 patch from this series and included in dependent series.

V4:
 - Removed driver patches.
 - Added branch tree tag.
 
V3:
 - Fix kernel test robot build error

v2:
 - Convert RFC patch to actual PATCH with each patch bisectable.
 - Add new patch to update bw for ofdma packets.
 - Add new patch to fetch tx_retry and tx_failed packets.

Sarika Sharma (6):
  wifi: ath12k: enable wiphy flag for MLO station statistics support
  wifi: ath12k: correctly fetch arsta for MLO
  wifi: ath12k: add link support for multi-link in arsta
  wifi: ath12k: add EHT support for TX rate
  wifi: ath12k: correctly update bw for ofdma packets
  wifi: ath12k: fetch tx_retry and tx_failed from
    htt_ppdu_stats_user_cmpltn_common_tlv

 drivers/net/wireless/ath/ath12k/core.h   |  2 +
 drivers/net/wireless/ath/ath12k/dp.h     |  2 +
 drivers/net/wireless/ath/ath12k/dp_mon.c | 23 ++++++++----
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 48 +++++++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.c    | 17 ++++++++-
 drivers/net/wireless/ath/ath12k/peer.h   | 28 +++++++++++++-
 6 files changed, 102 insertions(+), 18 deletions(-)


base-commit: b80c52642c1159c2596776b39b06eb1c2e36baff
-- 
2.34.1


