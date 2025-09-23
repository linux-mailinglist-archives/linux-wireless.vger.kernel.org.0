Return-Path: <linux-wireless+bounces-27597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C3B94CB6
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 09:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4817F7AEBCB
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 07:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98B330FC09;
	Tue, 23 Sep 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jg+wSc4G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC62E92BC
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 07:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758612980; cv=none; b=A9uhqxnLhx7xx54Q82cG8yQSEQq+V2vC6ywchUCbxFc5kloUHCkw0gO294SmIRR+DjJGTYi3dgUAzaU6a4/UShnFHS7R5oKxQECLfwCTaoCFZ4qW7hU+wtHK/OngDmeR5JTMETXjrOZ49+kqCrPFq1wlaz03wCjLAskPucRQH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758612980; c=relaxed/simple;
	bh=XCmDI28SLRFj+kBgXlCcJOdM8qH2auO0d7bfoEg+SLU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akJacOY+bozXY//3DvFGoczsZNDe7YREy0V8GbmVRSBTy/LbDms01C1B/XV+KfU14oGlik9jDhZ3JCE3o2/TbqBgLM8JEHgjdX7fs0PYQWtmUJn+FeLFg1DpBP5Bigdpf72r0ZVvyUupCUXxWWKuAmFb8jkluD1KdDmRfbhyp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jg+wSc4G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6Zisf011535;
	Tue, 23 Sep 2025 07:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Gmp8z06bZy++Q7pDAxbIDD
	75Et/C3fdTGddDHkyNIUs=; b=Jg+wSc4GqnyZUM+/zPtGqz/pUk4AnUo3EMaulp
	KN2J3+5aKBrQrTjiBxV2c1d0qcQUWAUVaUWhDpqzsmzvizNu8Zr9BlfXhDyOpBdn
	5nDR0H7aW0+0QBGqJSmwNtUBZY/fLhyFihNJRvAQmQDhZeyu0YJOhrsTrBNFpnW8
	xJXA1srYwzf99r70cR7IuBPk+yOdW176+UhNcaQj9JO9CTi30CyM2eGzIlJXRZSN
	kFcRbwiCs1fOPrHMgZIWPGmra52rkZCJkehjtSfDzjcBqBVoJETWcZHQ/ZpAUouJ
	m/bi1FtSWEYHlZ6gkiHIC0rDsaFQdZd5IpDfDxoGq4McDKVw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjrx35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58N7aCZJ002107
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 07:36:12 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 23 Sep 2025 00:36:11 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>
Subject: [PATCH wireless-next v3 0/3] wifi: cfg80211/mac80211: add support to handle incumbent signal detected event
Date: Tue, 23 Sep 2025 13:05:51 +0530
Message-ID: <20250923073554.3438429-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 8K2447iYoVrpTXLW7iJf_A7qMRU5L-QZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX3AB4mdXP9gGQ
 5IcKPMiOHaCeI2ICuyaLZOCYdStl+eAcxFuH2uf3ZHJpreR7DsgN+TOnLZbRQPVG1u6wuy7s60f
 vpLim+fg0WAdGS7qg/REY5Duwkmm9Hhbk0JRCtHOtk188kKWd6lSZff4XDvIYQepbsmOMrk6dbA
 odFpe72WiQ7mgVtCZlN0K41VN581Q398a6xar/QDbXG/4SKAozZdrf/9fBorzrbXqS/M0TxA1Gv
 OxgemEn3/Ccv8jRHK4loCPDIpJ8dJfkRLNgQUinsBrU0racAu2vDkTfLHbgBU335zKgFOU8CgLX
 mnysOPdq6HRYkZ/DyIvjTxRO3SepjfZvBg/WTApbCr+OHfZDyWXp/gMXG8/jRDQQHvs1BsapoUk
 cRGfltds
X-Proofpoint-GUID: 8K2447iYoVrpTXLW7iJf_A7qMRU5L-QZ
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d24ded cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=1P1qi0jZ29cQl9APfZwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

This patch series adds support to handle incumbent signal interference
detected event in 6 GHz band. When an incumbent signal is detected by an
AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
vacate the channels affected by it.

Driver is expected to call the newly introduced API with required
information to notify the interference detection. This information will be
ultimately sent to user space via NL802111 command. User space is expected
to process it and take further action - vacate the channel, or reduce the
bandwidth.

Aditya Kumar Singh (1):
  wifi: mac80211_hwsim: add incumbent signal interference detection
    support

Hari Chandrakanthan (2):
  wifi: cfg80211: add support to handle incumbent signal detected event
    from mac80211/driver
  wifi: mac80211: add support to handle incumbent signal detected event
    from driver
---
Changes in v3:
 - Removed the workqueue mechanism in ieee80211_incumbent_signal_detected(),
   exported the cfg80211_ function that sends the NL80211 command and called
   it from ieee80211_incumbent_signal_detected() directly.
 - Renamed nl80211_incumbent_signal_notify() to
   cfg80211_incumbent_signal_notify() and removed the gfp argument from it.

Changes in v2:
 - Updated the kernel doc of NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP
   to include details of how it interacts with puncturing.
 - Rebased on ToT
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 33 ++++++++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.h |  4 ++
 include/net/cfg80211.h                        | 17 ++++++++
 include/net/mac80211.h                        | 18 +++++++++
 include/uapi/linux/nl80211.h                  | 19 +++++++++
 net/mac80211/ieee80211_i.h                    |  5 +++
 net/mac80211/main.c                           |  3 ++
 net/mac80211/trace.h                          | 26 +++++++++++++
 net/mac80211/util.c                           | 39 +++++++++++++++++++
 net/wireless/mlme.c                           | 12 ++++++
 net/wireless/nl80211.c                        | 35 +++++++++++++++++
 net/wireless/nl80211.h                        |  4 ++
 12 files changed, 215 insertions(+)


base-commit: e3ac93e9d916ebae0711a42f524429dad89c4887
-- 
2.34.1


