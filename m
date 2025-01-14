Return-Path: <linux-wireless+bounces-17515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4FA11432
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 23:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEE0188ABDB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 22:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0852135C6;
	Tue, 14 Jan 2025 22:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jpOjd2gh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7117C1D5142
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jan 2025 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894195; cv=none; b=S1NKsO9lsP0JNJ8iVrSgI1FgU5BwhFKiXF/LGW0A2tmdvZrhXcdV1f7OQba8z3kPk/+Koxim9d2YUayzXFBs9oUczGWq9dWY+arouOTefNeyR3Off7tI7ddx9yRdzeAKlSGYH4qsfjAeckHffgIBmfrElCaHCNOLO9zup8tkpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894195; c=relaxed/simple;
	bh=zYPDO2uC47+vv9bdnbKTN+7NlFGbS/fVBqyGXW9Yd9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lkk0ixW25SCk9CkIz2kCa5gRAJoC1PlLP11G2NcqqkL6H2nal+3KLKLYHfuz0I9z3wZ1C9tt1EOjMfGlXlr5ESDmmqyDMaZrs8FyN09QN02HHcniO8g/MMRMk0MeQAgkM8/1Br1ugFaqDmn+zrNdw+tPXDphHyQlgoIHVKngW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jpOjd2gh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ELbXuI011377;
	Tue, 14 Jan 2025 22:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=g3UgNV52S52vbSRZiDp+nZ
	gzeRylzxxC8uHe3DRtK60=; b=jpOjd2ghixYGsrMaLbXvEDgtKGREQCjyxoYhJn
	7TZoezBGhPZlB93dyYr6JcYRFNYhhPeT2hnETSbgFpKW9QiRt8GedWjCNjkFEPYs
	hi3LwKR5nE591tOF+3J34EyIRosPv9v2pLnfTraE9UvvUQqDp/xyME/0CGL3wPD4
	ZlWd3W7SKzjii9HxW41qfZ6URfvfxza9/mMFfUAHdqpXRxYLkH2+ROzqZGBbsWGC
	V4VVHOruVWkRaYU4EgFZFnn8kUY617LyLcJSnzpE7IAeVXDe2tWfRmKkaFtSj1eU
	ugBH06ksEu41JoRLUVKVaW2s2ZBFBkMMwvf/VeQb1UBwDYLQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44600p03n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:36:31 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50EMaUHu000707
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 22:36:30 GMT
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 14 Jan 2025 14:36:30 -0800
From: Aloka Dixit <quic_alokad@quicinc.com>
To: <ath11k@lists.infradead.org>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC: Aloka Dixit <quic_alokad@quicinc.com>
Subject: [PATCH 0/5] wifi:ath11k/ath12k: refactor tx_arvif retrieval
Date: Tue, 14 Jan 2025 14:36:07 -0800
Message-ID: <20250114223612.2979310-1-quic_alokad@quicinc.com>
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
X-Proofpoint-ORIG-GUID: LXgm-dqTsRi2UFZK1by-DkcSShk6HV8I
X-Proofpoint-GUID: LXgm-dqTsRi2UFZK1by-DkcSShk6HV8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-14_07,2025-01-13_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=966 phishscore=0 spamscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140170

MLO MBSSID series for cfg80211/mac80211, which is in review here 
https://patchwork.kernel.org/project/linux-wireless/list/?series=902914&state=%2A&archive=both,
changes the way transmitted profile data is stored for each link.
As drivers currently retrieve 'arvif' for transmitted profile at
multiple places, MLO MBSSID changes will becomes unnecessarily
bloated with RCU operations for every retrieval. Refactor 'tx_arvif'
to avoid this.

Additionally, fix an issue in ath11k_mac_update_vif_chan() where
tx_arvif is not reset to NULL inside 'for' loop during each
iteration.

Aloka Dixit (5):
  wifi: ath11k: refactor transmitted arvif retrieval
  wifi: ath11k: pass tx arvif for MBSSID and EMA beacon generation
  wifi: ath12k: refactor transmitted arvif retrieval
  wifi: ath12k: pass tx arvif for MBSSID and EMA beacon generation
  wifi: ath12k: pass BSSID index as input for EMA

 drivers/net/wireless/ath/ath11k/mac.c | 70 +++++++++++-----------
 drivers/net/wireless/ath/ath12k/mac.c | 83 +++++++++++++--------------
 2 files changed, 75 insertions(+), 78 deletions(-)


base-commit: 0c5fcd9069dd5f984e39820629acbfbe0f1b4256
-- 
2.34.1


