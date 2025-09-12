Return-Path: <linux-wireless+bounces-27252-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E12B540D0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 05:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8E9716AB57
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 03:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB63146D45;
	Fri, 12 Sep 2025 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EXMmui+k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A47136351
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 03:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647289; cv=none; b=GjiWJV8vqPLtNyJ0leU7oLme7hxBTties2d8P5L6FnFFeR37ij9XGexbwKjq+6E+utGp02lhI/qdSst0Cy7cWB3X90QOAa34brk3m9Ze2KhNa8+FLC4CNSoPT5lsFcN/aeRsrwMSNZddxW2oc9ATAlpw09gQzsPhaStUW3GDLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647289; c=relaxed/simple;
	bh=PANa0T76VyDmX0Aq8nMnvIzZ3Ocv1+X710McgLZyAmg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tlxhi8ycH3x48mlF2UckR7MGXpAOI62auBmu0SicWrS+K2idC7rCNSnprw97YwhvZGQk5lUOw8KfS+3WtTWP2rwoe24cMAOz02Y9Wx5GX028vVE7q3eKvx+hsVPy4NLgfQtZ053km7qVVW4Xef02qov2T0F6EEMFx/HEIgwlyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EXMmui+k; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BLQVrD032242;
	Fri, 12 Sep 2025 03:21:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=voJ17d3zhICfCX5Hw/8hEu
	sNdsNtgPW2xLFpC3hdrC0=; b=EXMmui+kVeAwe9TDCS2CemDp4+fAcKZvNst1o4
	EKiw/rLuVdWGuR3a4cInvgIda5Hp7wOUt+OGY0CVMcvSUDfbfgq6tyBoTsYLIZ2N
	9VIA+f/A6NlLbRNiWgqCb2rI6Kl/C4QEeOr48gDsE25O86WQUbeJ4ixDad3zALPE
	ewA0fF7ORRT67ZgyDis608T7aCEP0/maWQfZG7VSlS+re1nIcB/BZ/wrb7c3RoO/
	0R7wuO1YddFn/t5Z9ViUMdaz1tjaccjHaVVAKpkDi5F1Rp77hHliuq9EEdhufWbc
	vZWVdHnKvDXKqU8XWaLzCFnNb75evm4jlpqg8J3B/8aEuavA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqg9tpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58C3LMmI005308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Sep 2025 03:21:22 GMT
Received: from hu-amitajit-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 11 Sep 2025 20:21:20 -0700
From: Amith A <quic_amitajit@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <quic_amitajit@quicinc.com>
Subject: [PATCH wireless-next v2 0/3] wifi: cfg80211/mac80211: add support to handle incumbent signal detected event
Date: Fri, 12 Sep 2025 08:51:02 +0530
Message-ID: <20250912032105.714949-1-quic_amitajit@quicinc.com>
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
X-Proofpoint-ORIG-GUID: GfXrEb25b2gxj9cEKRjxysp5WSmilP_9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX7Vq1P6YlBqHl
 2j/PG6rQzsecwXGcNdxLk76g78nLlMl7/qpOuEfH97pt6qlfnkxV1dJvAEprQDzTup6C8EtQa7p
 O5vDPLKquoeumu01L2BWZ7PGGT6sFIZNSAx0Xg5s2sB0ESS0B8EZ97kB4nuMOQatJkF2ypDovSI
 JZnrX3pOP+ACVgG1LG4+/UCDeOy5KF6w4FpQfD2B0vY7w9kVOKb+aS/LlbDZm/0zcdpW/9WWsQu
 8vWUnGqcx0DlccEwmllI7MMmz8AGj95h8RU8MVIaKcNz16QjIe02xUWJe4UXumae6M2u7PZllDv
 tIaDOkaY6foemSI0A5eyvooc6h3kOPoSEX6rXjcWsvCfZbsoRP+yupTR2j63Nj3XHuZhts/EaUJ
 YbbLpYjA
X-Proofpoint-GUID: GfXrEb25b2gxj9cEKRjxysp5WSmilP_9
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68c391b3 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=bg1tv6u6hkGMVcEzmNAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

This patch series adds support to handle incumbent signal interference
detected event in 6 GHz band. When an incumbent signal is detected by an
AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
vacate the channels affected by it.

Driver is expected to call the newly introduced API with required
information to notify the interference detection. This information will be
ultimately sent to user space via NL command. User space is expected to
process it and take further action - vacate the channel, or reduce the
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


