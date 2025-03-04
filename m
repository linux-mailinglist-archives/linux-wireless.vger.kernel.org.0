Return-Path: <linux-wireless+bounces-19749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0935A4D956
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 10:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD30B1647E2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 09:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854C11FCFC9;
	Tue,  4 Mar 2025 09:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N78GgTNq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB99C1F37CE
	for <linux-wireless@vger.kernel.org>; Tue,  4 Mar 2025 09:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082054; cv=none; b=mj9AIxPsSUvaDT8Iv3mbns1btluyklUH9FazZSER3UqvFRwZLAO7+em/uYfer7i8xg2yYLYtKkTOqGXtB2jmokOelnHJaylExMASRcytcEEi36TTAwMcU4Lkn1IHJGJLY1wATLVCuHDhYzfZVlMPxIeToxhgpts2duY1UQsnOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082054; c=relaxed/simple;
	bh=dRcy0C+zz+tn/uCEvbz2D6/MY3gy7IdzClBd52RJ508=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nW7cwR90PYfE7RiD/1REULSgSKuHngwvb+AZqaVMMnPHg4h/kxmV7a7EXL3sP7T6J8BuVJw6R2dIm/43C8XcZZzmhj7W8Hm8n9mRFnQYAfxXm1bF6GD/6eSLJRjJQ4UHEFRImjeNssbeA8Q3Sd+vJuYy+ETfl1//B8HyLgKInI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N78GgTNq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523NXJw3010211;
	Tue, 4 Mar 2025 09:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=cFXuxOoeD/aNY+NV1GNLr+
	Ind1xjrs0J38k4BHbjCTY=; b=N78GgTNqtbc80yu6MjZqOoW6w0oSSi8lvrprsj
	kBtWiVmgq3WJAfTs57oBQI/D3vy57VIZPtyFBEm/0z4IfbwlwE+qIxhHgh1ReuNZ
	zy8phXYhd25FGBAjNVTG4GNA1zs9gnBSJMCvph2cJXNCIG4nZGKvL3s9Yi2nA3Eq
	kISUxt9VoVQxBTwip6uyjpVq4n/fQl5f3B+5W3clTdPfrN7CJrTqi67RnS44W1Yz
	IQft72zyQI7xxbtytRTKOqh2i9W2UWWEVoF2xC1T4nTJl87LuBrkeWAile/AnZXW
	cBsPvK7pHTyYzF+oZ4nYDrRbvuVuWyGVg50kKTRSXSLWqH9A==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6whdwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 09:54:08 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5249s7b3027846
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Mar 2025 09:54:07 GMT
Received: from hu-surapk-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 01:54:05 -0800
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>,
        Suraj P Kizhakkethil
	<quic_surapk@quicinc.com>
Subject: [PATCH v2 0/2] wifi: ath12k: Pass correct channel frequency parameters
Date: Tue, 4 Mar 2025 15:23:13 +0530
Message-ID: <20250304095315.3050325-1-quic_surapk@quicinc.com>
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
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c6cdc0 cx=c_pps a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=wycfSnS5-3SXLsRzsT4A:9
X-Proofpoint-GUID: UOP9fjr9XBxO4pH1RGTbMpNAMO76PXr9
X-Proofpoint-ORIG-GUID: UOP9fjr9XBxO4pH1RGTbMpNAMO76PXr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_04,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=849 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040083

For higher bandwidths, the channel frequency parameters passed to
the firmware are incorrect. Pass correct values of channel
frequency parameters.

v2:
 - Replaced arg->band_center_freq1 to local variable center_freq1,
   which is initialized to arg->band_center_freq1
 - Rebased on ToT

Sriram R (1):
  wifi: ath12k: Pass correct values of center freq1 and center freq2 for
    320 MHz

Suraj P Kizhakkethil (1):
  wifi: ath12k: Pass correct values of center freq1 and center freq2 for
    160 MHz

 drivers/net/wireless/ath/ath12k/wmi.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)


base-commit: 3148fc3cf193dbbd2e14eee59468a510a38bf604
-- 
2.34.1


