Return-Path: <linux-wireless+bounces-18381-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71207A26C3E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 07:44:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023BA3A57BD
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 06:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CB1F8AD3;
	Tue,  4 Feb 2025 06:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nALUhlOe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3AB13212A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 06:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738651485; cv=none; b=WJw8nmVRpdc4St14uQqpV4K+LUUdoIMZk9UgUJKKbN1vVFY9tb891TThm1rDelBkCaqqlX15MpbtRUVryFmIX5Q7yyUt4pO2WDlIfVRLZ3l1ty8qZhZxugGw7qR6ENT0b2J5OQVXmJIyVzEWlG25Yb1RGZrj7a42S5AbFH87ekU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738651485; c=relaxed/simple;
	bh=g1TvqCEeD35LIxFcoXx7gsfQYE6/SiYvP8nqKRt6E+Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/RC86V3MKTcLZZiO3U9hKoQ8rZhFhGzqoBgMaMsfVadcoYEh05YeFVT6X8DGZNgotrDgy+Boo60LLlj1PIaO7i4jMorhCOA49ssCMTku0mbbtUY57Dt3ncYvODFPrQZWhN9OeSBzzZZRx9W0rq9irFjCV6FA4V0XNIzInkLgRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nALUhlOe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514583NP008380;
	Tue, 4 Feb 2025 06:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wvgUwBg2FrMRJ6J1XiTX5w
	DvBcwqTYr3F3sSGPYGWvc=; b=nALUhlOeWp4wIvprWNURhSV/udL7qq6Il8FPlR
	MnC05kEmyJVVXJDHKGlgmQo11/Gmw46VU5m+qX+o1KQLAckK9wOY9Xp1je9RY8fD
	NS3i3TaUkzIqj34cO/VXjV5OEvsVpRWCW5DQUPfmjQhNRJgdGrBzf5dUfODEThBm
	vRrFnVhl4G4zgJKdpyfWZJ26CJl4HuwkRwZLGDx+KMWeUE2AcUx01UyFiP3WzjgO
	H/+BHj8E1jFQEA+bXXL6ZCMbVqVNw9dfLsakVUD27CPegs55CGAFYVuDAKfMEP7Q
	iPHwH+BVR9rZ1XGGgpOpD81xhT2WyEeW990ZSQiJGm/boisQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcfp0647-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 06:44:39 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5146icsG030717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 06:44:38 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 3 Feb 2025 22:44:36 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH v5 0/5] wifi: ath12k: Support Sounding, Latency, Trigger, FSE stats
Date: Tue, 4 Feb 2025 12:14:12 +0530
Message-ID: <20250204064417.3671928-1-quic_rdevanat@quicinc.com>
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
X-Proofpoint-GUID: 8jIBKWKfdA4HFs8YBObFZghq1hSeujks
X-Proofpoint-ORIG-GUID: 8jIBKWKfdA4HFs8YBObFZghq1hSeujks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_03,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 mlxlogscore=858 malwarescore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040052

Add support to request HTT stats type 22, 25, 26, 27 and 28 from
firmware. These stats give sounding stats, latency stats, trigger stats
for uplink OFDMA and MUMIMO and FSE stats, respectively.

v5:
 - Rebased on ToT. No code changes.
v4:
 - Squashed patches to avoid build warning.
v3:
 - Rebased on ToT.
 - Removed patch dependencies.
v2:
 - Added line breaks where necessary, as pointed out by Kalle.
 - Modified the use of pointer arithmetic print_array_to_buf_s8().
 - Modified commit logs, as suggested by Kalle.

Dinesh Karthikeyan (4):
  wifi: ath12k: Support Sounding Stats
  wifi: ath12k: Support Latency Stats
  wifi: ath12k: Support Uplink OFDMA Trigger Stats
  wifi: ath12k: Support Received FSE Stats

Roopni Devanathan (1):
  wifi: ath12k: Support Uplink MUMIMO Trigger Stats

 .../wireless/ath/ath12k/debugfs_htt_stats.c   | 736 ++++++++++++++++++
 .../wireless/ath/ath12k/debugfs_htt_stats.h   | 275 ++++++-
 2 files changed, 973 insertions(+), 38 deletions(-)


base-commit: 48a62436540224f57013c27519dd2aa3ddd714c9
-- 
2.25.1


