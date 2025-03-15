Return-Path: <linux-wireless+bounces-20405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA34EA62FA4
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020B93A930A
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Mar 2025 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55323175D39;
	Sat, 15 Mar 2025 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UM02w05R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9528F18C93C
	for <linux-wireless@vger.kernel.org>; Sat, 15 Mar 2025 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053945; cv=none; b=QO/zmtniHDejB/s/D8LIcqBARAZ5JMm4LP81JRLpxxQhulefgnZFm902i2aeybWzxENJz+PyzJpgRA5FK9fselGcxrsJ9m3OlbV35cSYsy3PJzpA4vZyl04Lf3jrxXf8Jc2ah7CXX6uN2cHSs14fkDcpvz6t1PQK1MfMm5WVSoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053945; c=relaxed/simple;
	bh=h6wJZHoRA1IShID/KhcQ2spl82FWpYcWrIE5Yb0XtBs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtDaYzjUUMCm3f27ynDHrYaMK57vErCo08RxXTdeQCZQgLYVoNVfN0+mpG/knE3/zUTu+iHCEvXkrQRXln4AaY5Yy27vVoLIhg6eY8li/IqiMm0elONV9vCtNP8OQNl+nRG/RPK7MMITHmF/+zhufuegJopFdQw35JDWhPiJ3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UM02w05R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52FDo2Rv014225;
	Sat, 15 Mar 2025 15:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=/D7Ywb35E297OmtqBzCrmu5RX7Xuv1Atj3Q0hOpfTj8=; b=UM
	02w05RAimKI2D7RannSulk2s6+VUSPXqesiZBW9+sY9tZNkyR9V1QcEyqTsBf5ol
	n7mPRR8uP8kZYGk6bHe6D1Xsmiei/yry9zPlOgxroG6z/O1l+IpmV0k2G/Tq3EGX
	+IuX9ibPFS55BZpVFNZaZHBVvHvH6JIv/e5K0BOIeonJ7C+eBCIfd/6k3wl5dvWJ
	Zt6Gpc+uhSWkmecR1VQpI1LWz1U+8ChoBVPqAdPtNA5zyV6F8HB98VwzWPmhpMYO
	ixR30Z+1grrMhOkSXubXxJWZZRMk+bc15sfmkCqIcJT/9ldNcR/CvF1IC2I7m2Zj
	OMZ3Cu+8/BKenXxjbCsw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d1r10wf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Mar 2025 15:52:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 52FFqHqX016227
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Mar 2025 15:52:17 GMT
Received: from hu-nithp-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 15 Mar 2025 08:52:15 -0700
From: Nithyanantham Paramasivam <quic_nithp@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Nithyanantham Paramasivam
	<quic_nithp@quicinc.com>
Subject: [PATCH ath-next v3 0/3] wifi: ath12k: Enable REO queue lookup table on QCN9274
Date: Sat, 15 Mar 2025 21:21:56 +0530
Message-ID: <20250315155159.2475885-1-quic_nithp@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=LuaSymdc c=1 sm=1 tr=0 ts=67d5a232 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=tnCF6RmjttW7q9gwjsMA:9
X-Proofpoint-GUID: RQ6MMTIKFbRMcgjXzX0DXUe7V0G_m7Cc
X-Proofpoint-ORIG-GUID: RQ6MMTIKFbRMcgjXzX0DXUe7V0G_m7Cc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-15_06,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=464
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503150113

Instead of storing the REO queue address inside peer entries, REO
hardware module prefers them to be stored in SRAM which could be
directly accessed by REO using peer_ID/TID based Lookup table(LUT)
mechanism. This feature is expected to improve stability by reduced
interaction between host and firmware during both MLO and non-MLO
operations.This feature is enabled only for the QCN9274, so it does
not impact the WCN7850.

v3:
- Rebased on TOT
- Fixed 32bit compilation warning

v2:
- Removed junk version histories in cover letter

Balamurugan S (1):
  wifi: ath12k: Add support to clear qdesc array in REO cache

Nithyanantham Paramasivam (1):
  wifi: ath12k: Enable REO queue lookup table feature on QCN9274

Sriram R (1):
  wifi: ath12k: Fix the enabling of REO queue lookup table feature

 drivers/net/wireless/ath/ath12k/dp.c     | 77 ++++++++++++++++--------
 drivers/net/wireless/ath/ath12k/dp.h     |  5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c  | 11 +++-
 drivers/net/wireless/ath/ath12k/hal.h    |  9 ++-
 drivers/net/wireless/ath/ath12k/hal_rx.c | 19 +++++-
 drivers/net/wireless/ath/ath12k/hw.c     |  6 +-
 drivers/net/wireless/ath/ath12k/hw.h     |  5 +-
 drivers/net/wireless/ath/ath12k/wmi.c    |  8 ++-
 drivers/net/wireless/ath/ath12k/wmi.h    |  1 +
 9 files changed, 107 insertions(+), 34 deletions(-)


base-commit: a2ef9d802c470bc1cc8cb78391ac2e290422cee1
-- 
2.17.1


