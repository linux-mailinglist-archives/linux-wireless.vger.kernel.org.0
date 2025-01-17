Return-Path: <linux-wireless+bounces-17653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EB6A15541
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 18:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAA73A34D6
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 17:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B3519F41C;
	Fri, 17 Jan 2025 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A/aSICbQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D3919E7D1
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 17:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133489; cv=none; b=t3meryXXOdQH+2YK2l8JfaJmZCpqlONY/XwOSSiuvcwp46ODyvbCU357eRY06rMXGZ1l3olaCdjvhBlrFk5roI+ifnhS9EW2VbTT5qFggydC1r4QCEgwfCf+yjXxISiHmqYcRdSPpe5Yx3ZKxJgvufRo345L3GgW3Mx26msUP68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133489; c=relaxed/simple;
	bh=1qpWwAzEnnAUOvHZ4V3xsJrd8ixmbPGuvLMx7qqHdPg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dOHS0JtrwHi332FTas/pmN9TKPYl/ETeJdMj3F/56nYR6rXCCkhD5rwb5vELfcQqa28oEgNo/oi52Z4zTwwPesTSo8TYShRntlUefvF2LcEa6RmRF1xKuCJ8OBrYKlXWDn+pfBJMBDcQ9e4hdBe0XXIL82CCMOPVRnlZXt27LKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A/aSICbQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H9IhUL030288;
	Fri, 17 Jan 2025 17:04:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nj+yQgkiZnWtliqVNMliEa
	zQLLZhjhl1BjV+zAHp1HA=; b=A/aSICbQ+fkPmE4xreoAD7O9lcHfastSNnzHxD
	OE0V3634I/E4dNMXkgALgBN6L4FL83kAk7KowrzYyb1EHuZcRNoVqH0OLB0PljBQ
	fCyLOfeqo1TtS3SgPGAicQlv6JPxUClg2mOIfnCfmtNJf7tpxtnO3xe8aAuTE1Jf
	119vVCqww9WBPGtFDc66xoEIYr40T8tt1alYWum8DKWoEhbTWhu0NK0qV2ILvyvx
	806bSYg4065Opr4axDA/9FE3lt6xPN6j+rtVPpGhUup9l5mNcTiowxACp10yWWy9
	nYRVfu7T59JrPTbtVOenVA3Zl3WlRVf7r56nifgZEF3EpYKg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 447mfcs619-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 17:04:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50HH4cav020805
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 17:04:38 GMT
Received: from hu-ramess-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 17 Jan 2025 09:04:36 -0800
From: Rameshkumar Sundaram <quic_ramess@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>
Subject: [PATCH v2 0/3] wifi: cfg80211: update EML capabilities of an ML Station
Date: Fri, 17 Jan 2025 22:34:13 +0530
Message-ID: <20250117170416.2907530-1-quic_ramess@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c-PV91Ne7LBiTuDWbquasHP01OHwdjmD
X-Proofpoint-ORIG-GUID: c-PV91Ne7LBiTuDWbquasHP01OHwdjmD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=773 spamscore=0 mlxscore=0 impostorscore=0
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170134

When EMLSR is enabled for an ML association, the EML capabilities
advertised by the ML Station needs to be updated to drivers in order to
trigger EMLSR operation.
Add support to fetch EML capabilities advertised by ML station and
cache it in ieee80211_sta data structure so that drivers can use them
whenever required.

*v2:
   - Added new flag eml_cap_present to indicate if EML attribute is
     present as part of new/set station command.

Ramasamy Kaliappan (3):
  wifi: cfg80211: Add support to get EMLSR capabilities of non-AP MLD
  wifi: mac80211: update ML STA with EML capabilities
  wifi: ath12k: update EMLSR capabilities of ML Station

 drivers/net/wireless/ath/ath12k/mac.c |  1 +
 drivers/net/wireless/ath/ath12k/wmi.c | 81 ++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath12k/wmi.h |  3 +-
 include/net/cfg80211.h                |  5 ++
 include/net/mac80211.h                |  2 +
 net/mac80211/cfg.c                    |  3 +
 net/wireless/nl80211.c                | 12 ++++
 7 files changed, 104 insertions(+), 3 deletions(-)


base-commit: d7bef42fc98f2d8f67546d1ea1a3f2c2932fd72b
-- 
2.34.1


